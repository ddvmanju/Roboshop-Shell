#Install Python 3
dnf install python3 gcc python3-devel -y
cp payment.service /etc/systemd/system/payment.service

#Add application User
useradd roboshop

#Lets setup an app directory.
rm -rf /app
mkdir /app
rm -f /tmp/payment.zip

#Download the application code to created app directory.
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app
unzip /tmp/payment.zip

#Lets download the dependencies.
cd /app
pip3 install -r requirements.txt

#Load the service.
systemctl daemon-reload
systemctl enable payment
systemctl start payment