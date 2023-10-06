#!/bin/sh

echo 'Wordpress Check MariaDB connection : '
echo "MYSQL_HOST : $MYSQL_HOST"
echo "MYSQL_USER : $MYSQL_USER"
echo "MYSQL_PASSWORD : $MYSQL_PASSWORD"
echo "MYSQL_DATABASE : $MYSQL_DATABASE"
while ! mariadb -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE --port=3306 &>/dev/null; do
    echo "Waiting for the MariaDB container..."
    sleep 3
done
echo 'Wordpress MariaDB connection SUCCESS !'

adduser www-data -G www-data
mkdir -p /run/php
echo "Passed mkdir -p /run/php"
touch /run/php/php-fpm.pid
echo "Passed touch /run/php/php-fpm.pid"

echo "Checking if /var/www/html/wp-config.php is there ..."
if [ ! -f /var/www/html/wp-config.php ]; then

	echo "Attempt chown -R www-data:www-data /var/www/"
	chown -R www-data:www-data /var/www/
	echo "Passed chown -R www-data:www-data /var/www/"
	chown -R 755 /var/www
	echo "Passed chown -R 755 /var/www"

	echo 'Wordpress START INSTALL !'
	mkdir -p /var/www/html
	echo "wget wordpress package ..."
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html;

	if [ ! -f "./wp-activate.php" ]; then
		echo "wp core download ..."
		wp core download --allow-root;
	fi
	
	echo "wp create config with dbname $MYSQL_DATABASE ..."
	wp config create	\
		--allow-root				\
		--dbname=$MYSQL_DATABASE	\
		--dbuser=$MYSQL_USER		\
		--dbpass=$MYSQL_PASSWORD	\
		--dbhost=$MYSQL_HOST		\
		--dbcharset="utf8"			\
		--dbcollate="utf8_general_ci"

	echo "wp core install for wordpress title $WP_TITLE ..."
	echo "WP_URL : $WP_URL"
	echo "WP_TITLE : $WP_TITLE"
	echo "WP_ADMIN_DB_USER : $WP_ADMIN_DB_USER"
	echo "WP_ADMIN_DB_PASS : $WP_ADMIN_DB_PASS"
	echo "WP_ADMIN_DB_EMAIL : $WP_ADMIN_DB_EMAIL"
	if wp core install	\
		--allow-root	\
		--url=${WP_URL}	\
		--title=${WP_TITLE}	\
		--admin_user=${WP_ADMIN_DB_USER}	\
		--admin_password=${WP_ADMIN_DB_PASS}	\
		--admin_email=${WP_ADMIN_DB_EMAIL};
	then
		echo "Wordpress core install SUCCESS !"
		echo "wp user create $WP_USER_LOGIN ..."
	else
		echo "Wordpress core install FAILED !"
		exit 1
	fi

	echo "WP_USER_DB_LOGIN: $WP_USER_DB_LOGIN"
	echo "WP_USER_DB_EMAIL: $WP_USER_DB_EMAIL"
	echo "WP_USER_DB_PASS: $WP_USER_DB_PASS"
	if wp user create		\
		${WP_USER_DB_LOGIN}	\
		${WP_USER_DB_EMAIL}	\
		--role=author		\
		--allow-root		\
		--user_pass=${WP_USER_DB_PASS}	\
		--porcelain;
	then 
		echo "WordPress user create SUCCESS !"
		echo "wp-config.php :"
		cat "/var/www/html/wp-config.php"
	else
		echo "WordPress user create FAILURE !"
		exit 1
	fi 
	echo "Wordpress is ready!"
else
	echo "wp-config.php :"
	cat "/var/www/html/wp-config.php"
	echo "Wordpress already exist"
fi

exec "$@"