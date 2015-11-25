#!/bin/bash
# Setup MySQL root password and create a user
mysqladmin -u root password db_rootpassword
cat << EOF | mysql -u root --password=db_rootpassword
CREATE DATABASE db_name;
GRANT ALL PRIVILEGES ON db_name.* TO "db_user"@"%"
IDENTIFIED BY "db_password";
FLUSH PRIVILEGES;
EXIT
EOF
sed -e '/bind-address/ s/^#*/#/' -i /etc/mysql/my.cnf
sed -e '/skip-networking/ s/^#*/#/' -i /etc/mysql/my.cnf
service mysql restart
