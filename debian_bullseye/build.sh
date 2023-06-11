apt update -y
apt upgrade -y
apt -y install apache2 mariadb-server
apt -y install zoneminder

a2enmod cgi
sed -i "s/;date.timezone =/date.timezone = $(sed 's/\//\\\//' /etc/timezone)/g" /etc/php/7.?/apache2/php.ini
chgrp -c www-data /etc/zm/zm.conf

a2enmod ssl
a2enconf ssl-params
a2enmod headers
a2ensite default-ssl
a2enconf zoneminder
a2enmod rewrite

service mariadb start

cat /usr/share/zoneminder/db/zm_create.sql |  mysql --defaults-file=/etc/mysql/debian.cnf
echo 'grant lock tables,alter,create,select,insert,update,delete,index on zm.* to 'zmuser'@localhost identified by "zmpass";'    | mysql --defaults-file=/etc/mysql/debian.cnf mysql

