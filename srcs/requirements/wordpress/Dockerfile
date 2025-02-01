
# Needs to be the first parameter in the dockerfile
# It says that the image we will create will 
# use the docker image specified as a base image
FROM debian:bullseye

EXPOSE 9000

RUN apt update && \
    apt install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    wget \
    unzip \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /run/php/ && \
    chmod 755 /run/php/ && \
    mkdir -p /var/www/html/aleperei.42.fr

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp


COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /bin/
COPY ./conf/setup.sh /bin/

RUN chmod +x /bin/setup.sh

ENTRYPOINT ["/bin/setup.sh"]

CMD ["php-fpm7.4", "-F"]

# CMD ["tail", "-f", "/dev/null"]