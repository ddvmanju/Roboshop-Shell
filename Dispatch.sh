#Install GoLang
dnf install golang -y
cp dispatch.service /etc/systemd/system/dispatch.service
#Add application User
useradd roboshop

rm -rf /app
#Lets setup an app directory.
mkdir /app
rm -f /tmp/dispatch.zip

#Download the application code to created app directory.
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip

#Lets download the dependencies.
cd /app
go mod init dispatch
go get
go build

#Load the service.
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch