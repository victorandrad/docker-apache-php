FROM bitnami/apache:2.4.41-debian-10-r11
WORKDIR "/app"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install  php5-mysql php5-xdebug 

# Install PHP INTL extension from ppa:ondrej/php
RUN  apt-get -y install php5-intl

# Install GD2
RUN apt-get -y install php5-gd

# Install Prestissimo (composer plugin)
RUN composer global require hirak/prestissimo

# Clean and remove unecessary files
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

