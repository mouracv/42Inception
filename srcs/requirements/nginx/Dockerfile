
# Needs to be the first parameter in the dockerfile
# It says that the image we will create will 
# use the docker image specified as a base image
FROM debian:bullseye

RUN apt update && \
	apt install -y nginx  && \
	apt install -y openssl && \
	apt install -y nano

# req -x509: generate a request and self-sign the certificate
# -nodes: private key will not be encrypted
# -days 365: the certificate's validity period to 365 days
# -newkey rsa:2048: This generates a new key with a length of 2048 bits.
# -keyout/-out: where to save the key/certificate
# -subj "/C=...st/" details for the certificate:
# country (C), state (ST), locality (L), organization (O), organizational unit (OU), common name (CN)
RUN mkdir -p /etc/nginx/ssl && \
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-keyout /etc/nginx/ssl/server.key \
	-out /etc/nginx/ssl/server.crt \
	-subj "/C=PT/ST=Lisbon/L=Lisbon/O=42Lisboa/OU=aleperei/CN=localhost/"

RUN chmod 777  /etc/nginx/ssl/server.key /etc/nginx/ssl/server.crt && \
	mkdir -p alex

COPY ./conf/my.conf /etc/nginx/conf.d


# The instruction that is to be executed when a docker container starts
# There can only one 'CMD' in the dockerfile and it should be the last parameter 
CMD	["nginx", "-g", "daemon off;"]
