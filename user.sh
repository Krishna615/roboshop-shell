component=user
source common.sh
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y
cp user.service /etc/systemd/system/user.service
useradd roboshop

artifacts_setup

cd /app
npm install

systemd_setup