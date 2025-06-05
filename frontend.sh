dnf module disable nginx -y
dnf module enable nginx:1.24 -y
print_head installling the nginx
dnf install nginx -y

cp nginx.conf /etc/nginx/nginx.conf

rm -rf /usr/share/nginx/html/*
print_head download the required files of nginx
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

systemctl enable nginx
print_head restarting the nginx
systemctl restart nginx