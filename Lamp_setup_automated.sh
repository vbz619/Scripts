#!/bin/sh
 
#Installing Apache2 and Updating the Firewall
sudo apt update
sudo apt install apache2 -y
sudo ufw allow in "Apache"

#Installing MySQL
sudo apt install mysql-server -y

# Installing PHP
sudo apt install php libapache2-mod-php php-mysql -y

#Creating a Virtual Host for your Website
sudo mkdir /var/www/your_domain
sudo chown -R $USER:$USER /var/www/your_domain
sudo chown -R $USER:$USER /etc/apache2/sites-available/

sudo echo "<VirtualHost *:80>
    ServerName your_domain
    ServerAlias www.your_domain 
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/your_domain
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>">/etc/apache2/sites-available/your_domain.conf


sudo a2ensite your_domain
sudo a2dissite 000-default
sudo apache2ctl configtest

sudo echo "<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello World!</h1>

    <p>This is the landing page of <strong>your_domain</strong>.</p>
  </body>
</html>">/var/www/your_domain/index.html

#Testing PHP Processing on your Web Server
sudo echo "<?php
phpinfo();">/var/www/your_domain/info.php

sudo systemctl reload apache2


