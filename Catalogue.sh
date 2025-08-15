app_name=catalogue

# Install NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

cp $app_name.service /etc/systemd/system/$app_name.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
#Add application User
useradd roboshop


#Lets setup an app directory.
rm -rf /app
mkdir /app

rm -f /tmp/$app_name.zip
#Download the application code to created app directory.
curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
cd /app
unzip /tmp/$app_name.zip

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