source ./common.sh
app_name=catalogue

# Install NodeJS
NODEJS

cp $app_name.service /etc/systemd/system/$app_name.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Add application User
useradd roboshop


#Lets setup an app directory.
NODEJS

NODEJS
#Download the application code to created app directory.
NODEJS

#Lets download the dependencies.
cd /app
npm install

#Load the service.
systemctl daemon-reload

#Start the service.
systemctl enable $app_name
systemctl start $app_name

dnf install mongodb-mongosh -y

#Load Master Data of the List of products

mongosh --host MongoDB-Dev.azdevops.online </app/db/master-data.js