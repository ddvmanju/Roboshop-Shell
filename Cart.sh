source ./common.sh
#Install NodeJS
NODEJS



cp cart.service /etc/systemd/system/cart.service

#Add application User
useradd roboshop

rm -rf /app
#Lets setup an app directory.
mkdir /app
rm -f /tmp/cart.zip

#Download the application code to created app directory.

curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip

#Lets download the dependencies.
cd /app
npm install

#Load the service.
systemctl daemon-reload
systemctl enable user
systemctl start user