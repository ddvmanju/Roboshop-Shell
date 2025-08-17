source ./common.sh
app_name=shipping

JAVA

#load the schema
dnf install mysql -y
mysql -h MySQL-Dev.azdevops.online -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h MySQL-Dev.azdevops.online -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h MySQL-Dev.azdevops.online -uroot -pRoboShop@1 < /app/db/master-data.sql

systemctl restart $app_name