#!/bin/sh

# Sertifika Dizini
SertD=/ca

# HTTP Log dosyasi
HttpLog=/var/squid/logs/access.log

# Log dizini
LogD=/usr/local/boxnet/public/5651Logs
if [ ! -d $LogD ]
	then
		mkdir $LogD
		echo "$LogD olusturuldu!"
		sleep 1
	fi

# Hatali imzalanan loglar dizini
HataLogD=/usr/localboxnet/public/5651Logs/hatali
if [ ! -d $HataLogD ]
	then
		mkdir $HataLogD
		echo "$HataLogD olusturuldu!"
		sleep 1
	fi

# Log hazirlik dizini
HazLogD=/5651
if [ ! -d $HazLogD ]
	then
		mkdir $HazLogD
		echo "$HazLogD olusturuldu!"
		sleep 1
	fi
cd $HazLogD

#degiskenler
Tarih=`date "+%Y%m%d-%H%M%S"`

#OpenSSL Bin ve Conf
openssl=/usr/local/bin/openssl
openssl_conf=/usr/local/openssl/openssl.cnf

#Tarihi update edelim
/usr/sbin/ntpdate time.ume.tubitak.gov.tr

################################################
# ------------------ DHCP -------------------- #
################################################
if [ -f /sbin/5651DhcpDuzenle.sh ]
	then

		#Loglarini hazirlayalim
		awk -f /sbin/5651DhcpDuzenle.sh < /var/dhcpd/var/db/dhcpd.leases > ./dhcp-$Tarih.txt
		echo "dhcp-$Tarih.txt olusturuldu!"

		#Query
		$openssl ts -query -data $HazLogD/dhcp-$Tarih.txt -no_nonce -out $HazLogD/dhcp-$Tarih.tsq
		echo "DHCP icin Query olusturuldu!"

		#Reply
		$openssl ts -reply -queryfile $HazLogD/dhcp-$Tarih.tsq -out $HazLogD/dhcp-$Tarih.tsr -token_out -config $openssl_conf -passin pass:netyumc3rt
		echo "DHCP icin Reply olusturuldu!"

		#Verify
		COMMAND=`$openssl ts -verify -data $HazLogD/dhcp-$Tarih.txt -in $HazLogD/dhcp-$Tarih.tsr -token_in -CAfile  $SertD/cacert.pem -untrusted $SertD/tsacert.pem`

		if [ "${COMMAND}" = "Verification: OK" ]
			then
				echo "Dhcp Dogrulama basarili"
				rm $HazLogD/dhcp-$Tarih.tsq
				tar -zcvf dhcp-$Tarih.tar.gz dhcp-$Tarih*
				rm $HazLogD/dhcp-$Tarih.tsr $HazLogD/dhcp-$Tarih.txt
				mv $HazLogD/dhcp-$Tarih* $LogD/
				logger "$Tarih Tarihli DHCP loglari basariyla hazirlandi."
			else
				echo "Dhcp Dogrulama HATALI"
				rm $HazLogD/dhcp-$Tarih.tsq
				tar -zcvf dhcp-$Tarih.tar.gz dhcp-$Tarih*
				rm $HazLogD/dhcp-$Tarih.tsr $HazLogD/dhcp-$Tarih.txt
				mv $HazLogD/dhcp-$Tarih* $HataLogD/
				logger "$Tarih Tarihli DHCP loglari HATALI."
				/sbin/5651Kurulum.sh
		fi

		echo "----------------> DHCP islemleri bitti!"
	else
		logger "Dhcp Duzenleme SH dosyasi bulunamadi!"
	fi

sleep 2

################################################
# ------------------ HTTP -------------------- #
################################################
if [ -f $HttpLog ]
	then
		#Dosyayi tasiyalim
		cp $HttpLog $HazLogD/http-$Tarih.txt
		echo "http-$Tarih.txt olusturuldu!"

		#Query
		$openssl ts -query -data $HazLogD/http-$Tarih.txt -no_nonce -out $HazLogD/http-$Tarih.tsq
		echo "HTTP icin OpenSSL query olusturuldu!"

		#Reply
		$openssl ts -reply -queryfile $HazLogD/http-$Tarih.tsq -out $HazLogD/http-$Tarih.tsr -token_out -config $openssl_conf -passin pass:netyumc3rt
		echo "HTTP icin OpenSSL reply olusturuldu!"

		#Verify
		COMMAND2=`$openssl ts -verify -data $HazLogD/http-$Tarih.txt -in $HazLogD/http-$Tarih.tsr -token_in -CAfile  $SertD/cacert.pem -untrusted $SertD/tsacert.pem`

		if [ "${COMMAND2}" = "Verification: OK" ]
			then
				echo "Http Dogrulama basarili"
				rm $HazLogD/http-$Tarih.tsq
				tar -zcvf http-$Tarih.tar.gz http-$Tarih*
				rm $HazLogD/http-$Tarih.tsr $HazLogD/http-$Tarih.txt
				mv $HazLogD/http-$Tarih* $LogD/
				logger "$Tarih Tarihli HTTP loglari basariyla hazirlandi."
			else
				echo "Http Dogrulama HATALI"
				rm $HazLogD/http-$Tarih.tsq
				tar -zcvf http-$Tarih.tar.gz http-$Tarih*
				rm $HazLogD/http-$Tarih.tsr $HazLogD/http-$Tarih.txt
				mv $HazLogD/http-$Tarih* $HataLogD/
				logger "$Tarih Tarihli HTTP loglari HATALI."
		fi
	else
		echo "HTTP dosyasi bulunamadi!"
		logger "HTTP dosyasi bulunamadi!"
	fi
sleep 1

echo "----------------> HTTP islemleri bitti!"
cd ..
rm -rf $HazLogD
