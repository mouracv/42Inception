#!/bin/bash

# this script run in the building container
# it creates start the mariadb service and create the database and users according to the .env file
# at the end, exec $@ run the next CMD in the Dockerfile.
# In this case: "mysqld_safe" that restart the mariadb service

confifDB()
{
	echo "Starting MariaDB configuration..."

	# Start mariadb afther the installation
	service mariadb start

	sleep 2

	mysql_secure_installation <<-END
	\n
	n
	y
	$DB_ROOT_PASS
	$DB_ROOT_PASS
	y
	y
	y
	y
	END

	echo "MariaDB configured"
	echo "Creating Database..."

	# mariadb -v -u -p$DB_ROOT_PASS root <<-EOF
	mariadb -v -u root <<-EOF
	CREATE DATABASE IF NOT EXISTS $DB_NAME;
	CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
	GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
	FLUSH PRIVILEGES;
	EOF

	sleep 5

	# service mariadb stop
	mysqladmin -u root -p"$DB_ROOT_PASS" shutdown
	echo "Database Created..."
}

# GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';


# Verificar se nossa database esta crianda antes de executar
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
	confifDB
else
	echo "Database Already Exist!"
fi

exec "$@" 