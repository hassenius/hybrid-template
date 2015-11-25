#!/bin/bash -v
apt-get update
apt-get install -y apache2 libapache2-mod-php5 php5-mysql
apt-get -y install unzip
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
service apache2 restart
