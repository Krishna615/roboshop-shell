systemd_setup(){
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}
artifacts_setup(){


  rm -rf /app
  mkdir /app

  curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  cd /app
  unzip /tmp/$component.zip


}
nodejs_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y

  dnf install nodejs -y
  cp $component.service /etc/systemd/system/$component.service
  useradd roboshop

  artifacts_setup

  cd /app
  npm install
}