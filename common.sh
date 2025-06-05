systemd_setup(){
  print_head copying the service file
  cp $component.service /etc/systemd/system/$component.service
  systemctl daemon-reload
  systemctl enable $component
  print_head restarting the service
  systemctl restart $component

}
artifacts_setup(){
  rm -rf /app
  mkdir /app

  print_head downloading the content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip

  cd /app
  unzip /tmp/$component.zip
}
nodejs_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y

  print_head installing the nodejs
  dnf install nodejs -y




  useradd roboshop

  artifacts_setup
  cd /app
  npm install
}
python_setup(){
  print_head installing the python

  dnf install python3 gcc python3-devel -y

  useradd roboshop

  artifacts_setup

  cd /app
  pip3 install -r requirements.txt


}
golan_setup(){
  print_head installing the go lang

  dnf install golang -y


  useradd roboshop

  artifacts_setup

  cd /app
  go mod init $component
  go get
  go build

}
maven_setup(){
  print_head installing the maven
  dnf install maven -y


  useradd roboshop

  artifacts_setup

  cd /app
  mvn clean package
  exit_status $1
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