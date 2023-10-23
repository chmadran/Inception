#!/bin/sh
if [ -d "/var/lib/mysql/${DB_NAME}" ]
then
	echo "${DB_NAME} already exists\n"
	sleep 10
else
    # mysqld --daemonize
	service mariadb start
	sleep 10
	echo "creating ${DB_NAME}\n"
	# mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	# mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASSWORD}';"
	# mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	# mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	# mysql -e "FLUSH PRIVILEGES;"

	mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${DB_ADMIN_PASSWORD}';"
	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
	sleep 5

	mysqladmin -u root -p${DB_ADMIN_PASSWORD} shutdown
	sleep 5
fi
exec mysqld