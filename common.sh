systemd_setup(){
  print_head copying the service file
  cp $pwd/$component.service /etc/systemd/system/$component.service
  systemctl daemon-reload
  systemctl enable $component
  print_head restartig=ng the service
  systemctl restart $component
  exit_status $1
}
artifacts_setup(){
  rm -rf /app
  mkdir /app
  echo $?
  print_head downloading the content
  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  exit_status $1
  cd /app
  unzip /tmp/$component.zip
}
nodejs_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  exit_status $1
  print_head installing the nodejs
  dnf install nodejs -y
  exit_status $1



  useradd roboshop

  artifacts_setup
  cd /app
  npm install
  exit_status $1
}
python_setup(){
  print_head installing the python

  dnf install python3 gcc python3-devel -y
  exit_status $1

  useradd roboshop

  artifacts_setup

  cd /app
  pip3 install -r requirements.txt
  exit_status $1

}
golan_setup(){
  print_head installing the go lang

  dnf install golang -y
  exit_status $1

  useradd roboshop

  artifacts_setup

  cd /app
  go mod init $component
  go get
  go build
  exit_status $1
}
maven_setup(){
  print_head installing the maven
  dnf install maven -y
  exit_status $1

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

exit_status(){
  if [ $1 -eq 0 ]; then
      echo -e "\e[32m <<SUCCESS\E[0M"
    else
      echo -e "\e[31m <<SUCCESS\E[0M"
    fi
}

pwd=$(pwd)