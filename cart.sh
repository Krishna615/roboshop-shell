component=cart
source common.sh
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y
cp cart.service /etc/systemd/system/cart.service
useradd roboshop
artifacts_setup
cd /app
npm install

systemd_setup
