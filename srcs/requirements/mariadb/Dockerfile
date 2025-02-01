# Needs to be the first parameter in the dockerfile
# It says that the image we will create will 
# use the docker image specified as a base image
FROM debian:bullseye

# Especifies wich port the container will 
# accept data from other containers inside the newtwork
EXPOSE 3306

# Will execute any command in a shell inside the container enviroment
RUN apt update && \
	apt install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf/setup.sh /bin/
RUN	chmod 777 /bin/setup.sh

ENTRYPOINT ["/bin/setup.sh"]

CMD ["mysqld_safe", "--bind-address=0.0.0.0"]

# CMD ["tail", "-f", "/dev/null"]

