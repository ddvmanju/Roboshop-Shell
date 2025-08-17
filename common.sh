dir_path=$(pwd)

SYSTEMD_SETUP() {
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service

  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}

APP_PREREQ(){
  useradd roboshop
  rm -rf /app
  mkdir /app

  rm -f /tmp/$app_name.zip
  #Download the application code to created app directory.
  curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  cd /app
  unzip /tmp/$app_name.zip

}

NODEJS() {
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  dnf install nodejs -y

#Lets setup an app directory.
  npm install
  APP_PREREQ
  SYSTEMD_SETUP
}

JAVA() {
  dnf install maven -y
#cp $app_name.service /etc/systemd/system/$app_name.service

  APP_PREREQ
  mvn clean package
  mv target/$app_name-1.0.jar $app_name.jar
  SYSTEMD_SETUP
}

PYTHON() {

#Install Python 3
  dnf install python3 gcc python3-devel -y
  APP_PREREQ
  pip3 install -r requirements.txt
  SYSTEMD_SETUP
}