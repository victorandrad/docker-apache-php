#!/bin/bash -x
# arg OCI8_INSTALL is true
if  [ $1 == "1" ]; then

  apt-get update \
      && apt-get -y --no-install-recommends install  php-pear libaio1 make php5-dev wget

  mkdir /opt/oracle \
      && cd /opt/oracle

  wget https://github.com/rafaelyanagui/oracle-instantclient/raw/master/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb -O /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb \
  && wget https://github.com/rafaelyanagui/oracle-instantclient/raw/master/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb -O /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb \
  && wget https://github.com/rafaelyanagui/oracle-instantclient/raw/master/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb -O /tmp/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb

  dpkg -i /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb \
  && dpkg -i /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb \
  && dpkg -i /tmp/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb \
  && rm -rf /tmp/oracle-instantclient12.1-*.deb

  # Set up the Oracle environment variables
  export LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/" \
   && export ORACLE_HOME="/usr/lib/oracle/12.1/client64/lib/"

  # Install the OCI8 PHP extension
  echo 'instantclient,/usr/lib/oracle/12.1/client64/lib' | pecl install -f oci8-2.0.8

fi