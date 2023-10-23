#!/bin/sh

echo "having a nap\n"
sleep 5

echo "Starting WordPress Configuration Script"
echo "Current Directory: $(pwd)"
if mysqladmin ping -h mariadb -u $DB_USER -p$DB_PASSWORD &> /dev/null; then
    echo "MySQL/MariaDB is running"
else
    echo "MySQL/MariaDB is not running"
    exit 1
fi

if [ ! -f wp-config.php ]
then
	echo "Wordpress configuration\n"
	wp core config \
		--dbhost=mariadb \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASSWORD \
		--allow-root
	wp core install \
		--title=$WP_TITLE \
		--admin_user=$WP_ADMIN_USERNAME \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_MAIL \
		--url=$DOMAIN_NAME \
		--allow-root
	
fi
echo "starting php-fpm\n"
exec /usr/sbin/php-fpm7.4 -F