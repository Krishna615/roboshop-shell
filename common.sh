systemd_setup(){
  cp $pwd/$component.service /etc/systemd/system/$component.service
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}
artifacts_setup(){
  rm -rf /app
  mkdir /app
  echo $?

  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  echo $?
  cd /app
  unzip /tmp/$component.zip
}
nodejs_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y

  dnf install nodejs -y
  echo $?

  useradd roboshop

  artifacts_setup
  cd /app
  npm install
  echo $?
}
python_setup(){
  dnf install python3 gcc python3-devel -y
  echo $?

  useradd roboshop

  artifacts_setup

  cd /app
  pip3 install -r requirements.txt
  echo $?
}
golan_setup(){
  dnf install golang -y
  echo $?

  useradd roboshop

  artifacts_setup

  cd /app
  go mod init $component
  go get
  go build
}
maven_setup(){
  dnf install maven -y
  echo $?

  useradd roboshop

  artifacts_setup

  cd /app
  mvn clean package
  mv target/$component-1.0.jar $component.jar
}
print_head(){
  echo -e "\e[36m$*\e[0m"
  echo "###########################################"
  echo -e "\e[36m$*\e[0m"
  echo "########################################"
}
log_file=/tmp/roboshop.log
rm -f $log_file
pwd=$(pwd)