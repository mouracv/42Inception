#!/bin/bash

DESTINO="mariadb 3306"
CONFIG_PATH="/var/www/html/aleperei.42.fr/wp-config.php"

# Verify if database container is available for connection
while ! nc -z $DESTINO; do
    echo "Esperando o serviço ficar disponivel!"
    echo "Waiting for dataBase service to be available for connection!"
    sleep 1
done

echo "Database is ready!"


if [ ! -f $CONFIG_PATH ]; then
    
    echo "Arquivo wp-config.php não encontrado. Criando o arquivo..."

    chmod 755 /var/www/html
    chown -R www-data:www-data /var/www/html
    cd "/var/www/html/aleperei.42.fr"
    
    # Baixar o WordPress
    wp core download --allow-root 
    echo "Core baixado com sucesso."
    
    mv /bin/wp-config.php ./
    echo "Configuração criada com sucesso."

    # Instalar o WordPress
    wp core install --allow-root \
        --url="$DOMAIN" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email

    echo "WordPress instalado com sucesso."

    wp user create --allow-root \
        "$WP_SIMPLE_USER" \
        "$WP_SIMPLE_EMAIL" \
        --role="author" \
        --user_pass="$WP_SIMPLE_PASS" 

    # Ativar tema
    wp theme activate twentytwentyfour --allow-root
    echo "Tema ativado com sucesso."
fi

# Executar comando final
exec "$@"
