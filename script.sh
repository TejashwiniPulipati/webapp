#!/bin/bash
echo "updating the system"
sudo apt update -y

echo "installing utilities"
sudo apt install zip unzip Nginx -y

echo "cleanup document root"
sudo rm -rf /var/www/html

echo "clone login app"
sudo git clone https://github.com/TejashwiniPulipati/webapp.git /var/www/html

echo "finished deployment process"
