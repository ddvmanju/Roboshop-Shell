#Install Nginx

dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

# Start & Enable Nginx service

systemctl enable nginx
systemctl start nginx


# Remove the default content that web server is serving.