dnf install mongodb-org -y

cp mongo.repo /etc/yum.repos.d/mongo.repo

systemctl enable mongod
systemctl start mongod