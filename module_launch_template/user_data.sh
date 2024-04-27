#! /bin/bash

sudo apt update -y
sudo apt install apache2 -y
git clone https://github.com/VaikunthSuresh/card-website.git
sudo cp -rf card-website/* /var/www/html/