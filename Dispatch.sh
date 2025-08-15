source ./common.sh
app_name=dispatch
#Install GoLang
dnf install golang -y
cp dispatch.service /etc/systemd/system/dispatch.service
#Add application User
NODEJS
#Lets setup an app directory.
NODEJS

#Download the application code to created app directory.
NODEJS

#Lets download the dependencies.
cd /app
go mod init dispatch
go get
go build

#Load the service.
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch