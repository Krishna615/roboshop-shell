systemd_setup(){
  systemctl daemon-reload
  systemctl enable $component
  systemctl restart $component
}
artifacts_setup(){
  useradd roboshop

  rm -rf /app
  mkdir /app

  curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  cd /app
  unzip /tmp/cart.zip

  cd /app
  npm install
}