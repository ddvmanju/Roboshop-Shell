#Install MySQL Server
dnf install mysql-server -y

#Start MySQL Service
systemctl enable mysqld
systemctl start mysqld

mysql_secure_installation --set-root-pass RoboShop@1