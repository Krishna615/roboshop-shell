component=payment
spurce common.sh
dnf install python3 gcc python3-devel -y
cp payment.service /etc/systemd/system/payment.service
useradd roboshop

artifacts_setup

cd /app
pip3 install -r requirements.txt

systemd_setup