component=catalogue
source common.sh

nodejs_setup

dnf install mongodb-mongosh -y

mongosh --host mongo-dev.krishnadevops.shop </app/db/master-data.js

systemd_setup