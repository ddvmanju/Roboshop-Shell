dir_path=$(pwd)
log_file=/tmp/roboshop.log
rm -f  $log_file #Only latest log file available
echo $?

SYSTEMD_SETUP() {

  echo Copy Application Service
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
  if [ $? -eq 0 ]; then
      echo -e "\e[32msuccess\e[0m"
  else
      echo -e "\e[31mfail\e[0m"
  fi


  echo Start Application
  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file
  echo $?
}

APP_PREREQ(){

  echo Create Application User
  useradd roboshop &>>$log_file
  echo $?

  echo Remove Application Directory
  rm -rf /app &>>$log_file
  rm -f /tmp/$app_name.zip &>>$log_file
  echo $?

  echo Create Application Directory
  mkdir /app &>>$log_file
  echo $?

  echo Download Applicaiton Code
  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  cd /app &>>$log_file
  echo $?

  echo Extract Application Code
  unzip /tmp/$app_name.zip &>>$log_file
  echo $?

}

NODEJS() {
  echo Disable Default NodeJS Version
  dnf module disable nodejs -y &>>$log_file
  echo $?

  echo Enable NodeJS 20 Version
  dnf module enable nodejs:20 -y &>>$log_file
  echo $?

  echo install NodeJS
  dnf install nodejs -y &>>$log_file
  echo $?

  APP_PREREQ

  echo install NodeJS Dependencies
  npm install &>>$log_file
  echo $?

  SYSTEMD_SETUP
}

JAVA() {
  dnf install maven -y &>>$log_file
  echo $?
  APP_PREREQ
  mvn clean package &>>$log_file
  echo $?
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file
  echo $?
  SYSTEMD_SETUP
}

PYTHON() {
  dnf install python3 gcc python3-devel -y &>>$log_file
  echo $?
  APP_PREREQ
  pip3 install -r requirements.txt &>>$log_file
  echo $?
  SYSTEMD_SETUP
}