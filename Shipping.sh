dnf install maven -y
cp shipping.service /etc/systemd/system/shipping.service

#Add application User
useradd roboshop

#Lets setup an app directory.
rm -rf /app
mkdir /app
rm -f /tmp/shipping.zip

#Download the application code to created app directory.
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip


#dependencies & build the application
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

#Load the service.
systemctl daemon-reload

#Start the service.
systemctl enable shipping
systemctl start shipping

#load the schema
dnf install mysql -y
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql

systemctl restart shipping