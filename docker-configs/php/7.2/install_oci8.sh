#!/bin/bash -x

# arg OCI8_INSTALL is true
if  [ $1 == "1" ]; then
  apt-get update \
      && apt-get install -y php-pear build-essential libaio1 wget

  mkdir /opt/oracle && cd /opt/oracle

  wget https://github.com/rafaelyanagui/oracle-instantclient/raw/master/instantclient-basic-linux.x64-12.2.0.1.0.zip -O /opt/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip \
    && wget https://github.com/rafaelyanagui/oracle-instantclient/raw/master/instantclient-sdk-linux.x64-12.2.0.1.0.zip -O /opt/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip 

  unzip /opt/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /opt/oracle \
    && unzip /opt/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /opt/oracle 

  ln -s /opt/oracle/instantclient_12_2/libclntsh.so.12.1 /opt/oracle/instantclient_12_2/libclntsh.so \
  && ln -s /opt/oracle/instantclient_12_2/libclntshcore.so.12.1 /opt/oracle/instantclient_12_2/libclntshcore.so \
  && ln -s /opt/oracle/instantclient_12_2/libocci.so.12.1 /opt/oracle/instantclient_12_2/libocci.so \
  && rm -rf /opt/oracle/*.zip

  export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2:${LD_LIBRARY_PATH}

  echo 'instantclient,/opt/oracle/instantclient_12_2/' | pecl install oci8-2.2.0
   
fi