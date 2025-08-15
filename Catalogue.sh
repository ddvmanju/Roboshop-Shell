# Install NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Add application User
useradd roboshop

#Lets setup an app directory.
mkdir /app

rm -f /tmp/catalogue.zip
#Download the application code to created app directory.
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

#Lets download the dependencies.
cd /app
npm install

#Load the service.
systemctl daemon-reload

#Start the service.
systemctl enable catalogue
systemctl start catalogue

dnf install mongodb-mongosh -y

#Load Master Data of the List of products

mongosh --host MongoDB-Dev.azdevops.online </app/db/master-data.js