component=catalogue
source common.sh
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodejs -y

cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
rm -rf /app

useradd roboshop

rm -rf /app
mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install



dnf install mongodb-mongosh -y

mongosh --host mongo-dev.krishnadevops.shop </app/db/master-data.js

systemd_setup