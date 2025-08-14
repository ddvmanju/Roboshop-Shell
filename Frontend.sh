#Install Nginx

dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

# Add the following content

cp nginx.conf /etc/nginx/nginx.conf

# Start & Enable Nginx service

systemctl enable nginx
systemctl start nginx


# Remove the default content that web server is serving.

rm -rf /usr/share/nginx/html/*

rm -f /tmp/frontend.zip

# Download the frontend content

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

# Extract the frontend content.
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# Restart Nginx Service to load the changes of the configuration

systemctl restart nginx



# Remove the default content that web server is serving.