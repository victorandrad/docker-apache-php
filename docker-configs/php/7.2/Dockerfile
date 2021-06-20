FROM phpdockerio/php72-fpm:latest
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install php-memcached php-redis php-xdebug

# Install git
RUN apt-get update \
    && apt-get -y install git

# Install mysql
RUN apt-get update \
    && apt-get -y install php7.2-mysql

# Install mcrypt
RUN apt-get update \
    && apt-get -y install gcc make autoconf libc-dev pkg-config \
    && apt-get -y install php7.2-dev \
    && apt-get -y install libmcrypt-dev \
    && pecl install mcrypt-1.0.1

# Add apt-add-repository command
RUN apt-get update && \
    apt-get -y install software-properties-common

# Install PHP INTL extension from ppa:ondrej/php
RUN add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get -y install php7.2-intl

# Install GD2
RUN apt-get update \
    && apt-get -y install php7.2-gd

# Install Prestissimo (composer plugin)
# RUN composer global require hirak/prestissimo

# ORACLE oci 
ARG OCI8_INSTALL=0
ENV LD_LIBRARY_PATH  /opt/oracle/instantclient_12_2:${LD_LIBRARY_PATH}
ADD install_oci8.sh /tmp/  
RUN chmod u+x /tmp/install_oci8.sh && /tmp/install_oci8.sh $OCI8_INSTALL

# Clean and remove unecessary files
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*