#!/bin/bash -v
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/db_name/" wp-config.php
sed -i "s/username_here/db_user/" wp-config.php
sed -i "s/password_here/db_password/" wp-config.php
sed -i "s/localhost/db_ipaddr/" wp-config.php
