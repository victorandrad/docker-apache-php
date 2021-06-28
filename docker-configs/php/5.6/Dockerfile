FROM phpdockerio/php56-fpm:latest
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install  php5-mysql php5-xdebug 

# Install PHP INTL extension from ppa:ondrej/php
RUN  apt-get -y install php5-intl

# Install GD2
RUN apt-get -y install php5-gd

# Install the Oracle Instant Client
# Default false
ARG OCI8_INSTALL=0
ADD install_oci8.sh /tmp/  
RUN chmod u+x /tmp/install_oci8.sh && ls -al && /tmp/install_oci8.sh $OCI8_INSTALL

# Clean and remove unecessary files
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

