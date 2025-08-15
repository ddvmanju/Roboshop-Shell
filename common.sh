dir_path=$(pwd)

SYSTEMD_SETUP() {
  cp $dir_path/$app_name.service /etc/systemd/system/$app_name.service

  systemctl daemon-reload
  systemctl enable $app_name
  systemctl start $app_name
}

APP_PREREQ(){
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

APP_PREREQ
SYSTEMD_SETUP
}

JAVA() (
dnf install maven -y
#cp $app_name.service /etc/systemd/system/$app_name.service
useradd roboshop
APP_PREREQ
cd /app
mvn clean package
mv target/$app_name-1.0.jar $app_name.jar
SYSTEMD_SETUP
)