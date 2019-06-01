FROM ubuntu:bionic
MAINTAINER cedric@zestprod.com
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y apache2

RUN apt-get install -y software-properties-common \
  && add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get install -y --force-yes \
  wget \
  php7.3 \
  php7.3-mysql \
  php7.3-ldap \
  php7.3-xmlrpc \
  curl \
  php7.3-curl \
  php7.3-gd \
  php7.3-mbstring \
  php7.3-simplexml \
  php7.3-xml \
  php7.3-apcu \
  php7.3-imap

RUN a2enmod rewrite && service apache2 stop
WORKDIR /var/www/html
COPY start.sh /opt/
RUN chmod +x /opt/start.sh
RUN usermod -u 1000 www-data
CMD /opt/start.sh
EXPOSE 80
