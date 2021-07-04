#!/bin/bash

#Required
DOMAIN=srdelivery.app
COMMONNAME=srdelivery.app
CANAME=CA_srdelivery_app
PASSWORD=$(openssl rand -hex 16)
DAYS=730 # 2 anos

#Change to your company details
country=BR
state='Sao Paulo'
locality=Salto
organization='Sr Delivery'
organizationalunit=IT

SCRIPT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$SCRIPT_PATH";

printf "\n\n>>>>>> SSL Certificate Creation <<<<<< \n\n"

printf "\n\n>>> Creating Root Certificate Authority (CA)... \n\n"
printf "\n\n>>> Creating $CANAME.key... \n\n"

sudo openssl genrsa \
  -des3 \
  -passout pass:$PASSWORD \
  -out $SCRIPT_PATH/$CANAME.key 4096

printf "\n\n>>> Writing to $SCRIPT_PATH/$CANAME.key \n\n"

printf "\n\n>>> Creating $CANAME.pem... \n\n"

sudo openssl req \
  -passin pass:$PASSWORD \
  -x509 \
  -new \
  -nodes \
  -key $SCRIPT_PATH/$CANAME.key \
  -sha256 \
  -days $DAYS \
  -out $SCRIPT_PATH/$CANAME.pem \
  -config $SCRIPT_PATH/ssl-configs/ca-pem.conf

printf "\n\n>>> Writing to $SCRIPT_PATH/$CANAME.pem \n\n"

printf "\n\n>>> Creating Self Signed Certificate... \n\n"
printf "\n\n>>> Creating $DOMAIN.csr and $DOMAIN.key \n\n"

sudo openssl req \
  -new \
  -sha256 \
  -nodes \
  -out $SCRIPT_PATH/$DOMAIN.csr \
  -newkey rsa:2048 \
  -keyout $SCRIPT_PATH/$DOMAIN.key \
  -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$COMMONNAME"

printf "\n\n>>> Writing to $SCRIPT_PATH/$DOMAIN.csr \n\n"
printf "\n\n>>> Writing to $SCRIPT_PATH/$DOMAIN.key \n\n"

printf "\n\n>>> Creating $DOMAIN.crt \n\n"

sudo openssl x509 \
  -passin pass:$PASSWORD \
  -req \
  -in $SCRIPT_PATH/$DOMAIN.csr \
  -CA $SCRIPT_PATH/$CANAME.pem \
  -CAkey $SCRIPT_PATH/$CANAME.key \
  -CAcreateserial \
  -out $SCRIPT_PATH/$DOMAIN.crt \
  -days $DAYS \
  -sha256 \
  -extfile $SCRIPT_PATH/ssl-configs/x509-v3.conf

printf "\n\n>>> Writing x509 with SAN Certificate to $SCRIPT_PATH/$DOMAIN.crt \n\n"

printf "\n\n>>> Below is your $DOMAIN.crt \n\n"
sudo cat $SCRIPT_PATH/$DOMAIN.crt

printf "\n\n>>> Below is your $DOMAIN.key \n\n"
sudo cat $SCRIPT_PATH/$DOMAIN.key

printf "\n\n>>> Below is your $DOMAIN.crt details \n\n"
openssl x509 -text -in $SCRIPT_PATH/$DOMAIN.crt -noout

printf "\n\n>>> Moving server certificates and CA to server-certs folder. \n\n"
mkdir -p $SCRIPT_PATH/server-certs
mv $SCRIPT_PATH/$DOMAIN.crt $SCRIPT_PATH/server-certs/$DOMAIN.crt
mv $SCRIPT_PATH/$DOMAIN.key $SCRIPT_PATH/server-certs/$DOMAIN.key
mv $SCRIPT_PATH/$CANAME.pem $SCRIPT_PATH/server-certs/CLIENT_$CANAME.pem

# clone dhparam default
printf "\n\n>>> Cloning ssl defaults to server-certs folder. \n\n"
cp $SCRIPT_PATH/ssl-defaults/dhparam.pem.default $SCRIPT_PATH/server-certs/dhparam.pem

# remove generated files that are no longer required
printf "\n\n>>> Removing generated files that are no longer required. \n\n"
rm -f $SCRIPT_PATH/$CANAME.srl $SCRIPT_PATH/$CANAME.key $SCRIPT_PATH/$CANAME.pem $SCRIPT_PATH/$DOMAIN.csr


printf "\n\n>>> Moving server certificates to apache certs folder. \n\n"
mkdir -p $SCRIPT_PATH/../apache/certs

cp $SCRIPT_PATH/server-certs/$DOMAIN.crt $SCRIPT_PATH/../apache/certs/server.crt
cp $SCRIPT_PATH/server-certs/$DOMAIN.key $SCRIPT_PATH/../apache/certs/server.key

printf "\n\n>>> Moving local_docker_ssl.pem to root folder. \n\n"
cp $SCRIPT_PATH/server-certs/CLIENT_$CANAME.pem $SCRIPT_PATH/../../srdelivery_app_ssl.pem 

printf "\n\n>>>>>> End of SSL Certificate Creation. <<<<<< \n\n"
