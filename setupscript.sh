# Modified for use by Vaibhav Gupta

#!/usr/bin/env bash

set -x

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y -f install build-essential apache2 git tar curl python openssl git libffi-dev python-dev vim nano bash bash-doc bash-completion tree curl apache2 mariadb-server libapache2-mod-php libtiff-tools php php-mysql php-cli php-gd php-xsl php-curl php-mcrypt php-soap php-json php-gettext imagemagick php-mbstring php-zip php-ldap php-xml libssl-dev w3m 

#run mariadb commands for permissions

sudo touch ~/sqlrunner.sql

sudo echo "use mysql;" > ~/sqlrunner.sql
sudo echo "update user set plugin='' where User='root';" >> ~/sqlrunner.sql
sudo echo "flush privileges;" >> ~/sqlrunner.sql
sudo echo "\q" >> ~/sqlrunner.sql

sudo mysql -u root < ~/sqlrunner.sql

#use mysql;
#update user set plugin='' where User='root';
#flush privileges;
#\q

sudo service apache2 restart
sudo service mysql restart

sudo rm -r /var/www/html

echo "Which branch?: "
read BRANCH

sudo git clone https://github.com/vaibhavgupta3110/openemr -b $BRANCH /var/www/html

sudo service apache2 restart
sudo service mysql restart

sleep 400

echo "Browser opened?: " "(y or n)"

read ANSWER

if [ "$ANSWER" = "y" ]; then
	continue
else
	sleep 400
fi

# openemr's setup requireemnts


sudo chmod 666 \
/var/www/*/sites/*/sqlconf.php \
/var/www/*/interface/modules/zend_modules/config/application.config.php

sudo chown -R www-data:www-data \
/var/www/*/sites/*/documents \
/var/www/*/sites/*/edi \
/var/www/*/sites/*/era \
/var/www/*/sites/*/letter_templates \
/var/www/*/gacl/admin/templates_c \
/var/www/*/interface/main/calendar/modules/PostCalendar/pntemplates/compiled \
/var/www/*/interface/main/calendar/modules/PostCalendar/pntemplates/cache
