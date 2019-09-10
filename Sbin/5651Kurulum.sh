#!/bin/sh

#dizinlerin olusturalim
DIR=ca
if [ -d /$DIR ]; then
        rm -rf /$DIR
        fi
mkdir /$DIR /$DIR/private /$DIR/certs /$DIR/newcerts

#gerekli dosyalari olusturalim
cd /$DIR
echo 1000 > serial
touch index.txt
echo 01 > tsaserial

#Eklendi: -passout pass:netyumc3rt
	/usr/local/bin/openssl req -config /usr/local/openssl/openssl.cnf -days 3650 -x509 -newkey rsa:2048 -passout pass:netyumc3rt -out cacert.pem -outform PEM -batch
mv privkey.pem /$DIR/private/cakey.pem

#Eklendi: -passout pass:netyumc3rt
/usr/local/bin/openssl genrsa -aes256 -passout pass:netyumc3rt -out tsakey.pem 2048 -batch
mv tsakey.pem /$DIR/private

#Eklendi: -passin pass:netyumc3rt
/usr/local/bin/openssl req -new -key /$DIR/private/tsakey.pem -passin pass:netyumc3rt -out tsareq.csr -batch

#Eklendi: -batch
/usr/local/bin/openssl ca -config /usr/local/openssl/openssl.cnf -in tsareq.csr -passin pass:netyumc3rt -out tsacert.pem -batch
