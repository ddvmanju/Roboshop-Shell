source ./common.sh
app_name=dispatch
#Install GoLang
dnf install golang -y

NODEJS
#Lets download the dependencies.
cd /app
go mod init dispatch
go get
go build

