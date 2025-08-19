source ./common.sh
app_name=catalogue

# Install NodeJS
NODEJS

cp $(pwd)/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-mongosh -y
mongosh --host MongoDB-Dev.azdevops.online </app/db/master-data.js