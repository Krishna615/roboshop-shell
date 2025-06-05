component=dispatch
source common.sh
dnf install golang -y

cp dispatch.service /etc/systemd/system/dispatch.service
useradd roboshop

artifacts_setup

cd /app
go mod init dispatch
go get
go build

systemd_setup