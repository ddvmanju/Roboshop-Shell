NODEJS() {
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#Lets setup an app directory.
rm -rf /app
mkdir /app

rm -f /tmp/$app_name.zip
#Download the application code to created app directory.
curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
cd /app
unzip /tmp/$app_name.zip

systemctl daemon-reload
systemctl enable $app_name
systemctl start $app_name
}