source ./common.sh
#Install NodeJS
NODEJS

cp user.service /etc/systemd/system/user.service

#Add application User
useradd roboshop

#Lets setup an app directory.
mkdir /app
rm -f /tmp/user.zip

#Download the application code to created app directory.

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip
cd /app
unzip /tmp/user.zip

#Lets download the dependencies.

cd /app
npm install

#Load the service.
systemctl daemon-reload
systemctl enable user
systemctl start user