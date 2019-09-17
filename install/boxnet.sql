/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES UTF8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

UPDATE mysql.user SET Password=PASSWORD('{QH_MYSQL_ROOT_PASS}') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
CREATE DATABASE IF NOT EXISTS {QH_MYSQL_DBNAME} /*!40100 DEFAULT CHARACTER SET latin1 */;
CREATE USER `{QH_MYSQL_USER_NAME}`@`localhost`;
SET PASSWORD FOR `{QH_MYSQL_USER_NAME}`@`localhost` = PASSWORD('{QH_MYSQL_USER_PASS}');
GRANT ALL ON {QH_MYSQL_DBNAME}.* TO `{QH_MYSQL_USER_NAME}`@`localhost` IDENTIFIED BY '{QH_MYSQL_USER_PASS}';
GRANT ALL ON {QH_MYSQL_DBNAME}.* TO `{QH_MYSQL_USER_NAME}`@`%` IDENTIFIED BY '{QH_MYSQL_USER_PASS}';

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
SET FOREIGN_KEY_CHECKS=0;

USE {QH_MYSQL_DBNAME};

-- tablo yapısı dökülüyor boxnet.cui
CREATE TABLE IF NOT EXISTS `cui` (
  `clientipaddress` varchar(15) NOT NULL DEFAULT '',
  `callingstationid` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(64) NOT NULL DEFAULT '',
  `cui` varchar(32) NOT NULL DEFAULT '',
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastaccounting` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`username`,`clientipaddress`,`callingstationid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Dumping data for table boxnet.cui: 0 rows
/*!40000 ALTER TABLE `cui` DISABLE KEYS */;
/*!40000 ALTER TABLE `cui` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.nas
CREATE TABLE IF NOT EXISTS `nas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nasname` varchar(128) NOT NULL,
  `shortname` varchar(32) DEFAULT NULL,
  `type` varchar(30) DEFAULT 'other',
  `ports` int(5) DEFAULT NULL,
  `secret` varchar(60) NOT NULL DEFAULT 'secret',
  `server` varchar(64) DEFAULT NULL,
  `community` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT 'RADIUS Client',
  PRIMARY KEY (`id`),
  KEY `nasname` (`nasname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.nas: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `nas` DISABLE KEYS */;
/*!40000 ALTER TABLE `nas` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radacct
CREATE TABLE IF NOT EXISTS `radacct` (
  `radacctid` bigint(21) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `username` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `groupname` varchar(64) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `realm` varchar(64) CHARACTER SET latin1 DEFAULT '',
  `nasipaddress` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `nasportid` varchar(15) CHARACTER SET latin1 DEFAULT NULL,
  `nasporttype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `acctstarttime`  datetime DEFAULT NULL,
  `acctupdatetime` datetime NULL DEFAULT NULL,
  `acctstoptime` datetime DEFAULT NULL,
  `acctinterval` int(12) DEFAULT NULL,
  `acctsessiontime` int(12) DEFAULT NULL,
  `acctauthentic` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_start` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `connectinfo_stop` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `acctinputoctets` bigint(20) DEFAULT NULL,
  `acctoutputoctets` bigint(20) DEFAULT NULL,
  `calledstationid` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `callingstationid` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `servicetype` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedprotocol` varchar(32) CHARACTER SET latin1 DEFAULT NULL,
  `framedipaddress` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `acctstartdelay` int(12) DEFAULT NULL,
  `acctstopdelay` int(12) DEFAULT NULL,
  `xascendsessionsvrkey` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`radacctid`),
  UNIQUE KEY `acctuniqueid` (`acctuniqueid`),
  KEY `username` (`username`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `acctsessionid` (`acctsessionid`),
  KEY `acctsessiontime` (`acctsessiontime`),
  KEY `acctstarttime` (`acctstarttime`),
  KEY `acctinterval` (`acctinterval`),
  KEY `acctstoptime` (`acctstoptime`),
  KEY `nasipaddress` (`nasipaddress`),
  KEY `callingstationid` (`callingstationid`),
  KEY `calledstationid` (`calledstationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table net_yonetim.radacct: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radacct` DISABLE KEYS */;
INSERT INTO `radacct` (`radacctid`, `acctsessionid`, `acctuniqueid`, `username`, `groupname`, `realm`, `nasipaddress`, `nasportid`, `nasporttype`, `acctstarttime`, `acctstoptime`, `acctsessiontime`, `acctauthentic`, `connectinfo_start`, `connectinfo_stop`, `acctinputoctets`, `acctoutputoctets`, `calledstationid`, `callingstationid`, `acctterminatecause`, `servicetype`, `framedprotocol`, `framedipaddress`, `acctstartdelay`, `acctstopdelay`, `xascendsessionsvrkey`) VALUES
	(4, 'e2f9d84bd2e66ee6', 'cc0f437f9c60da42', 'demo', '', '', '172.16.10.1', '2140', 'Ethernet', '2015-07-04 19:04:45', '2015-07-04 19:05:19', 34, 'RADIUS', '', '', 0, 0, '172.16.10.1', '00:30:67:37:45:10', 'User-Request', '', '', '172.16.10.10', 0, 0, '');
/*!40000 ALTER TABLE `radacct` ENABLE KEYS */;

-- tablo yapısı dökülüyor boxnet.radcheck
CREATE TABLE IF NOT EXISTS `radcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  `UyeID` int(11) DEFAULT NULL,
  `GrupID` int(11) DEFAULT NULL,
  `ProfilID` int(11) DEFAULT NULL,
  `AdSoyad` varchar(50) DEFAULT NULL,
  `KimlikNo` varchar(25) DEFAULT NULL,
  `Telefon` varchar(16) DEFAULT NULL,
  `DogumTarih` varchar(25) DEFAULT NULL,
  `EPosta` varchar(50) DEFAULT NULL,
  `KotaKB` varchar(50) DEFAULT NULL,
  `EPostaOnay` int(11) DEFAULT '0',
  `SMSOnay` int(11) DEFAULT '0',
  `KotaTur` varchar(10) DEFAULT NULL,
  `OdaNo` varchar(50) DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `BitisTarih` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.radcheck: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radcheck` DISABLE KEYS */;
INSERT INTO `radcheck` (`id`, `username`, `attribute`, `op`, `value`, `UyeID`, `GrupID`, `ProfilID`, `AdSoyad`, `KimlikNo`, `Telefon`, `DogumTarih`, `EPosta`, `KotaKB`, `EPostaOnay`, `SMSOnay`, `KotaTur`, `OdaNo`, `Tarih`, `BitisTarih`) VALUES
	(55, 'demo', 'Cleartext-Password', ':=', 'demo', 1, NULL, 15, 'demo', NULL, NULL, NULL, NULL, '0', 0, 0, NULL, NULL, '2015-07-04 19:03:50', NULL),
	(56, 'demo', 'Expiration', '=', '11 Mar 2029', NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, '2015-07-04 19:03:50', NULL);
/*!40000 ALTER TABLE `radcheck` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radgroupcheck
CREATE TABLE IF NOT EXISTS `radgroupcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '==',
  `value` varchar(253) NOT NULL DEFAULT '',
  `Aciklama` varchar(50) NOT NULL DEFAULT '',
  `ProfilID` int(11) DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table boxnet.radgroupcheck: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radgroupcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupcheck` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radgroupreply
CREATE TABLE IF NOT EXISTS `radgroupreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  `ProfilID` int(11) DEFAULT NULL,
  `GrupID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groupname` (`groupname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.radgroupreply: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radgroupreply` DISABLE KEYS */;
/*!40000 ALTER TABLE `radgroupreply` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radippool
CREATE TABLE IF NOT EXISTS `radippool` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pool_name` varchar(30) NOT NULL,
  `framedipaddress` varchar(15) NOT NULL DEFAULT '',
  `nasipaddress` varchar(15) NOT NULL DEFAULT '',
  `calledstationid` varchar(30) NOT NULL,
  `callingstationid` varchar(30) NOT NULL,
  `expiry_time` datetime DEFAULT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pool_key` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `radippool_poolname_expire` (`pool_name`,`expiry_time`),
  KEY `framedipaddress` (`framedipaddress`),
  KEY `radippool_nasip_poolkey_ipaddress` (`nasipaddress`,`pool_key`,`framedipaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table boxnet.radippool: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radippool` DISABLE KEYS */;
/*!40000 ALTER TABLE `radippool` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radpostauth
CREATE TABLE IF NOT EXISTS `radpostauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `pass` varchar(64) NOT NULL DEFAULT '',
  `reply` varchar(32) NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table boxnet.radpostauth: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radpostauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `radpostauth` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radreply
CREATE TABLE IF NOT EXISTS `radreply` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL DEFAULT '',
  `attribute` varchar(64) NOT NULL DEFAULT '',
  `op` char(2) NOT NULL DEFAULT '=',
  `value` varchar(253) NOT NULL DEFAULT '',
  `ProfilID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin5;

-- Dumping data for table boxnet.radreply: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radreply` DISABLE KEYS */;
INSERT INTO `radreply` (`id`, `username`, `attribute`, `op`, `value`, `ProfilID`) VALUES
	(82, 'demo', 'WISPr-Bandwidth-Max-Down', '==', '2097152', 15),
	(83, 'demo', 'WISPr-Bandwidth-Max-Up', '==', '524288', 15),
	(84, 'demo', 'WISPr-Redirection-URL', ':=', 'http://www.google.com.tr', 15);
/*!40000 ALTER TABLE `radreply` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.radusergroup
CREATE TABLE IF NOT EXISTS `radusergroup` (
  `username` varchar(64) NOT NULL DEFAULT '',
  `groupname` varchar(64) NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT '1',
  KEY `username` (`username`(32))
) ENGINE=InnoDB DEFAULT CHARSET=latin5;

-- Dumping data for table boxnet.radusergroup: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `radusergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `radusergroup` ENABLE KEYS */;


-- yöntem yapısı dökülüyor boxnet.sp_kullanicihareketler
DELIMITER //
CREATE DEFINER=`boxnet`@`%` PROCEDURE `sp_kullanicihareketler`()
BEGIN
	CREATE TABLE hareketler
  (
       username varchar(11),
       tarih datetime,
       tip varchar(11)
       
  );
  insert hareketler
  select r.username,r.acctstarttime,'giris' from radacct r order by r.acctstarttime desc limit 0,100;
  insert hareketler
	select r.username,r.acctstoptime,'cikis' from radacct r order by r.acctstoptime desc limit 0,100;

	SELECT
		*
	FROM hareketler order by tarih desc limit 0,6;
	   
	Drop Table hareketler;
END//
DELIMITER ;


-- yöntem yapısı dökülüyor boxnet.sp_kullanicitumhareketler
DELIMITER //
CREATE DEFINER=`boxnet`@`%` PROCEDURE `sp_kullanicitumhareketler`(IN `$$toplam` INT, IN `$$baslangic` INT, IN `$$filter` varCHAR(50))
BEGIN
		declare lmt int(11);
		set lmt=$$baslangic+10;
		
	if $$toplam>0 then
		CREATE TABLE hareketler
		(
		    username varchar(30),
		    tarih datetime,
		    acctterminatecause varchar(30),
		    framedipaddress varchar(15),
		    callingstationid varchar(20),
		    tip varchar(11)
		    
		);
		insert hareketler
		select username, acctstarttime,acctterminatecause,framedipaddress ,callingstationid ,'giris' 
		from radacct where username like $$filter or framedipaddress like $$filter or callingstationid like $$filter limit 0,lmt;
		insert hareketler
		select username, acctstoptime,acctterminatecause,framedipaddress ,callingstationid ,'cikis' 
		from radacct where username like $$filter or framedipaddress like $$filter or callingstationid like $$filter limit 0,lmt;

		SELECT
			*
		FROM hareketler
		where username like $$filter or framedipaddress like $$filter or callingstationid like $$filter order by tarih desc limit $$baslangic,10;
		
		Drop Table hareketler;
	else
		SELECT
			count(acctstarttime)+count(acctstoptime)
		FROM radacct where username like $$filter or framedipaddress like $$filter or callingstationid like $$filter;
	end if;
END//
DELIMITER ;


-- tablo yapısı dökülüyor boxnet.tbl_ayar
CREATE TABLE IF NOT EXISTS `tbl_ayar` (
  `AyarID` int(11) NOT NULL AUTO_INCREMENT,
  `MailGonderenAd` varchar(50) DEFAULT NULL,
  `MailHostIp` varchar(100) DEFAULT NULL,
  `MailKullaniciAdi` varchar(50) DEFAULT NULL,
  `facebookHesapProfilID` bit(1) DEFAULT b'0',
  `MailSifre` varchar(50) DEFAULT NULL,
  `SmsFirma` varchar(50) DEFAULT NULL,
  `SmsBaslik` varchar(50) DEFAULT NULL,
  `SmsApi` varchar(100) DEFAULT NULL,
  `SmsKullaniciAdi` varchar(50) DEFAULT NULL,
  `SmsSifre` varchar(50) DEFAULT NULL,
  `SmsSablon` longtext,
  `SmsGonderimLimiti` int(11) DEFAULT NULL,
  `LoginKullaniciAdiText` varchar(50) DEFAULT NULL,
  `LoginSifreText` varchar(50) DEFAULT NULL,
  `EntegreProgram` varchar(50) DEFAULT NULL,
  `sqlhost` varchar(100) DEFAULT NULL,
  `sqlport` varchar(50) DEFAULT NULL,
  `sqldbname` varchar(200) DEFAULT NULL,
  `sqluser` varchar(100) DEFAULT NULL,
  `sqlpass` varchar(100) DEFAULT NULL,
  `sqlprofilid` int(11) DEFAULT NULL,
  `grsNetyum` bit(1) DEFAULT b'0',
  `grsOzel` bit(1) DEFAULT b'0',
  `grsKurumsal` bit(1) DEFAULT b'0',
  `grsTc` bit(1) DEFAULT b'0',
  `grsSms` bit(1) DEFAULT b'0',
  `grsGuvenlik` bit(1) DEFAULT b'0',
  `grsPosta` bit(1) DEFAULT b'0',
  `grsBilet` bit(1) DEFAULT b'0',
  `grsFacebook` bit(1) DEFAULT b'0',
  `grsVoucher` bit(1) DEFAULT b'0',
  `grsBizeYazin` bit(1) DEFAULT b'0',
  `SliderAktif` bit(1) DEFAULT b'0',
  `SliderSure` varchar(50) DEFAULT NULL,
  `AktifDil` varchar(10) DEFAULT NULL,
  `MacAktif` bit(1) DEFAULT b'0',
  `BiletBaslik` varchar(50) DEFAULT NULL,
  `BiletSablon` text,
  `TcHesapProfilID` int(11) DEFAULT NULL,
  `SmsHesapProfilID` int(11) DEFAULT NULL,
  `GuvenlikHesapProfilID` int(11) DEFAULT NULL,
  `PostaHesapProfilID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AyarID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_ayar: ~1 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_ayar` DISABLE KEYS */;
INSERT INTO `tbl_ayar` (`AyarID`, `MailGonderenAd`, `MailHostIp`, `MailKullaniciAdi`, `MailSifre`, `SmsFirma`, `SmsBaslik`, `SmsApi`, `SmsKullaniciAdi`, `SmsSifre`, `SmsSablon`, `SmsGonderimLimiti`, `LoginKullaniciAdiText`, `LoginSifreText`, `EntegreProgram`, `sqlhost`, `sqlport`, `sqldbname`, `sqluser`, `sqlpass`, `sqlprofilid`, `grsNetyum`, `grsOzel`, `grsKurumsal`, `grsTc`, `grsSms`, `grsGuvenlik`, `grsPosta`, `grsBilet`, `grsVoucher`, `grsBizeYazin`, `SliderAktif`, `SliderSure`, `AktifDil`, `MacAktif`, `BiletBaslik`, `BiletSablon`, `TcHesapProfilID`, `SmsHesapProfilID`, `GuvenlikHesapProfilID`, `PostaHesapProfilID`) VALUES
	(1, 'Boxnet Hotspot Yonetimi', 'mail.simyacibilisim.com', 'info@simyacibilisim.com', '123123', 'mobilpark', 'BASLIK', 'APIURL', 'KullaniciAdi', 'Sifre', 'Internet erisimi icin Kullanıcı Adınız:{telefon} Şifreniz:{sifre}', 30, NULL, NULL, 'Amonra_XML', '192.168.1.87', '50456', 'C:/AKINSOFT/Wolvox7/Database_FB/DEMO_WOLVOX/2014/WOLVOX.FDB', 'SYSDBA', 'masterkey', 4, b'1', b'0', b'0', b'0', b'0', b'0', b'0', b'0', b'1', b'0', b'1', '500000', 'TR', b'0', 'Boxnet', '<div style="text-align: center;"><br></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;">Sayın {adsoyad} Boxnet´e hoşgeldiniz.</span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;"><br></span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;">Bilet Numaranız : {biletno}</span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;">Bilet Süreniz : {biletsuresi}</span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;"><br></span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;">İnternet erişimleriniz 5651 sayısı gereğince kayıt altına alınmaktadır.</span></div><div style="text-align: center;"><span class="Apple-style-span" style="color: rgb(34, 34, 34); font-family: ´´PT Sans´´, sans-serif; line-height: 15px;"><br></span></div>', 15, 15, 15, 15);
/*!40000 ALTER TABLE `tbl_ayar` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_bilet
CREATE TABLE IF NOT EXISTS `tbl_bilet` (
  `BiletID` int(11) NOT NULL AUTO_INCREMENT,
  `BiletNo` varchar(50) COLLATE utf8_bin NOT NULL,
  `AdSoyad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `KimlikNo` varchar(11) COLLATE utf8_bin DEFAULT NULL,
  `Telefon` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `BiletSuresi` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BiletID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_bilet: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_bilet` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_bilet` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_dil
CREATE TABLE IF NOT EXISTS `tbl_dil` (
  `DilID` int(11) NOT NULL AUTO_INCREMENT,
  `Dil` varchar(3) DEFAULT NULL,
  `Aciklama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DilID`),
  UNIQUE KEY `Dil` (`Dil`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_dil: ~5 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_dil` DISABLE KEYS */;
INSERT INTO `tbl_dil` (`DilID`, `Dil`, `Aciklama`) VALUES
	(1, 'TR', ''),
	(4, 'EN', NULL),
	(5, 'GR', NULL),
	(6, 'IT', NULL),
	(7, 'RU', NULL);
/*!40000 ALTER TABLE `tbl_dil` ENABLE KEYS */;

-- tablo yapısı dökülüyor boxnet.tbl_kullanici
CREATE TABLE IF NOT EXISTS `tbl_kullanici` (
  `KullaniciID` int(10) NOT NULL AUTO_INCREMENT,
  `AdSoyad` varchar(50) DEFAULT NULL,
  `Telefon` varchar(15) DEFAULT NULL,
  `Mail` varchar(50) DEFAULT NULL,
  `KullaniciAdi` varchar(50) NOT NULL,
  `Sifre` varchar(200) NOT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`KullaniciID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_kullanici: ~2 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_kullanici` DISABLE KEYS */;
INSERT INTO `tbl_kullanici` (`KullaniciID`, `AdSoyad`, `Telefon`, `Mail`, `KullaniciAdi`, `Sifre`, `Tarih`) VALUES
	(6, 'Boxnet Administrator', '0 216 970 06 44', 'info@simyacibilisim.com', 'admin', 'BOXnet2014smyc', '2014-10-17 01:07:44'),
	(7, 'Boxnet Standart', '0 216 970 06 44', 'info@simyacibilisim.com', 'boxnet', 'B0xn3t', '2014-10-17 01:09:05');
/*!40000 ALTER TABLE `tbl_kullanici` ENABLE KEYS */;

-- tablo yapısı dökülüyor boxnet.tbl_macban
CREATE TABLE IF NOT EXISTS `tbl_macban` (
  `BanID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Mac` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`BanID`),
  KEY `Mac` (`Mac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_macban: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_macban` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_macban` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_mesaj
CREATE TABLE IF NOT EXISTS `tbl_mesaj` (
  `MesajID` int(11) NOT NULL AUTO_INCREMENT,
  `AdSoyad` varchar(50) DEFAULT NULL,
  `Telefon` varchar(50) DEFAULT NULL,
  `Konu` varchar(100) DEFAULT NULL,
  `Mesaj` text,
  `Durum` bit(1) DEFAULT b'0',
  `Aciklama` text,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MesajID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_mesaj: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_mesaj` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_mesaj` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_profil
CREATE TABLE IF NOT EXISTS `tbl_profil` (
  `ProfilID` int(11) NOT NULL AUTO_INCREMENT,
  `ProfilAdi` varchar(50) COLLATE utf8_bin NOT NULL,
  `Aciklama` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `ProfilTuru` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `HesapTuru` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `Sure` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `Url` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `MaxDownload` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `MaxUpload` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Kota` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `KotaTuru` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `AkkOnay` bit(1) DEFAULT NULL,
  `AkkD` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `AkkU` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Tariih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ProfilID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_profil: ~4 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_profil` DISABLE KEYS */;
INSERT INTO `tbl_profil` (`ProfilID`, `ProfilAdi`, `Aciklama`, `ProfilTuru`, `HesapTuru`, `Sure`, `Url`, `MaxDownload`, `MaxUpload`, `Kota`, `KotaTuru`, `AkkOnay`, `AkkD`, `AkkU`, `Tariih`) VALUES
	(15, 'Limitsiz', 'Limitsiz', 'Gunluk', 'Gunluk', '4999', 'http://www.google.com.tr', '2097152', '524288', '0', NULL, b'0', '0', '0', '2014-10-17 01:28:12'),
	(17, 'Gunde 1 Saat 4 MB', 'Gunde 1 Saat 4 MB', 'Saatlik', 'Gunluk', '3600', 'http://www.google.com.tr', '4194304', '524288', '0', NULL, b'0', '0', '0', '2014-10-17 01:29:16'),
	(19, 'Limitsiz Sure - 1GB Kota - Gunluk Reset', 'Limitsiz Sure - 1GB Kota - Gunluk Reset', 'Gunluk', 'Gunluk', '4999', 'http://www.google.com.tr', '8358912', '1048576', '1024000', 'Gunluk', b'0', '0', '0', '2014-10-17 01:32:29'),
	(20, 'Limitsiz Sure - 4GB Kota - Adil Kullanım ', 'Limitsiz Sure - 4GB Kota - Adil Kullanım ', 'Gunluk', 'Gunluk', '4999', 'http://www.google.com.tr', '8358912', '1048576', '4096000', 'Aylik', b'1', '2097152', '524288', '2014-10-17 01:35:02');
/*!40000 ALTER TABLE `tbl_profil` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_resim
CREATE TABLE IF NOT EXISTS `tbl_resim` (
  `ResimID` int(11) NOT NULL AUTO_INCREMENT,
  `Resim` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Logo` bit(1) DEFAULT b'0',
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ResimID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_resim: ~3 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_resim` DISABLE KEYS */;
INSERT INTO `tbl_resim` (`ResimID`, `Resim`, `Logo`, `Tarih`) VALUES
	(30, 'captiveportal-captiveportal-2.jpg', b'0', '2014-09-30 00:30:07'),
	(31, 'captiveportal-captiveportal-3.jpg', b'0', '2014-09-30 00:30:16'),
	(32, 'captiveportal-captiveportal-4.jpg', b'0', '2014-09-30 00:58:49');
/*!40000 ALTER TABLE `tbl_resim` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_smslog
CREATE TABLE IF NOT EXISTS `tbl_smslog` (
  `LogID` int(11) NOT NULL AUTO_INCREMENT,
  `AdSoyad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Telefon` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `HataKodu` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `UserName` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Password` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_smslog: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_smslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_smslog` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_text
CREATE TABLE IF NOT EXISTS `tbl_text` (
  `TextID` int(11) NOT NULL AUTO_INCREMENT,
  `DilID` int(11) NOT NULL DEFAULT '0',
  `trTextID` int(11) DEFAULT NULL,
  `Txt` varchar(50) DEFAULT NULL,
  `Deger` longtext,
  PRIMARY KEY (`TextID`),
  KEY `FK_tbl_text_tbl_dil` (`DilID`),
  CONSTRAINT `FK_tbl_text_tbl_dil` FOREIGN KEY (`DilID`) REFERENCES `tbl_dil` (`DilID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = INNODB DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_text: ~133 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_text` DISABLE KEYS */;
INSERT INTO `tbl_text` (`TextID`, `DilID`, `trTextID`, `Txt`, `Deger`) VALUES
	(1, 1, 1, 'grsNetyum', 'Kullanıcı Girişi'),
	(2, 1, 2, 'grsNetyumKullaniciAdi', 'Kullanıcı Adınız'),
	(3, 1, 3, 'grsNetyumSifre', 'Şifreniz'),
	(4, 1, 4, 'grsNetyumButon', 'Giriş Yap'),
	(5, 1, 5, 'grsOzelGiris', 'Misafir Girişi'),
	(6, 1, 6, 'grsOzelGirisKullaniciAdi', 'Kullanıcı Adınız'),
	(7, 1, 7, 'grsOzelGirisSifre', 'Şifreniz'),
	(8, 1, 8, 'grsOzelGirisButon', 'Giriş Yap'),
	(9, 1, 9, 'grsTc', 'Kayıt Ol'),
	(10, 1, 10, 'grsTcMesaj', 'Lütfen aşağıdaki formu nüfus cüzdanınızdaki gibi doldurunuz. Eğer kimlik bilgileriniz onaylanırsa üyeliğiniz oluşturulacaktır.'),
	(11, 1, 11, 'grsTcKimlik', 'T.C Kimlik Numaranız'),
	(12, 1, 12, 'grsTcAdiniz', 'Adınız'),
	(13, 1, 13, 'grsTcSoyadiniz', 'Soyadiniz'),
	(14, 1, 14, 'grsTcDogumYili', 'Doğum Yılınız'),
	(15, 1, 15, 'grsTcButon', 'Kayıt Ol'),
	(16, 1, 16, 'msjHataTc', 'Hesap oluşturulamadı! Lütfen yöneticinize başvurun.'),
	(17, 1, 17, 'msjHataTcFormKontrol', 'Lütfen formu doldurunuz.'),
	(18, 1, 18, 'msjHataTcProfilKontrol', 'Profil bilgileri alınamadı.'),
	(19, 1, 19, 'msjHataTcKontrol', 'TC Kimlik numaranız doğrulanamadı.Lütfen bilgilerinizi doğru yazdığınızdan emin olunuz.'),
	(20, 1, 20, 'msjSonucTc', 'Hesabınız başarılı şekilde oluşturulmuş olup, TC kimlik numaranız ve şifrenizle giriş yapabilirsiniz.'),
	(21, 1, 21, 'msjSonucTcSifreGuncelleme', 'Hesabınız güncellendi.Belirtmiş olduğunuz şifre ve tc kimlik numarasıyla internet erişiminizi sağlayabilirsiniz.'),
	(22, 1, 22, 'grsKayitSms', 'Kayıt Ol'),
	(23, 1, 23, 'grsKayitSmsMesaj', 'Aşağıdaki forma telefon numaranızı 0 koymadan yazınız. Ornek : 5322225434'),
	(24, 1, 24, 'grsKayitSmsAdSoyad', 'Adınız Soyadınız'),
	(25, 1, 25, 'grsKayitSmsTelefon', 'Telefon Numaranız'),
	(26, 1, 26, 'grsKayitSmsHaberdarOl', 'Yeniliklerden haberdar olmak istiyorum.'),
	(27, 1, 27, 'grsKayitSmsGiris', 'Kayıt Ol'),
	(28, 1, 28, 'msjHataSms', 'Hesap oluşturulamadı! Lütfen yöneticinize başvurun.'),
	(29, 1, 29, 'msjHataSmsFormKontrol', 'Lütfen formu doldurunuz.'),
	(30, 1, 30, 'msjHataSmsLimitKontrol', 'Günlük SMS Alma limitiniz dolmuştur.Şifrenizle ilgili problem yaşıyorsanız bilgi işlem yöneticinizle iletişime geçiniz.'),
	(31, 1, 31, 'msjHataSmsBilgilerKontrol', 'Bilgilerinizde bir yanlışlık soz konusu.Lutfen tekrar deneyiniz.'),
	(32, 1, 32, 'msjHataSmsProfilKontrol', 'Profil bilgileri alınamadı.'),
	(33, 1, 33, 'msjSonucSms', 'Kullanıcı adı ve Şifreniz belirtmiş olduğunuz telefon numarasına gönderilmiştir.'),
	(34, 1, 34, 'grsGuvenlik', 'Kullanıcı Girişi'),
	(35, 1, 35, 'grsGuvenlikMesaj', 'Guvenlik Kodunuz'),
	(36, 1, 36, 'grsGuvenlikKodu', 'Yeniliklerden haberdar olmak istiyorum.'),
	(37, 1, 37, 'grsGuvenlikGiris', 'Giriş Yap'),
	(38, 1, 38, 'grsEposta', 'Kullanıcı Girişi'),
	(39, 1, 39, 'grsEpostaMesaj', 'Sizi daha yakından tanıyabilmemiz için lütfen aşağıdaki  bilgileri doğru yazınız.'),
	(40, 1, 40, 'grsEpostaAdSoyad', 'Adınız Soyadınız'),
	(41, 1, 41, 'grsEpostaMail', 'E-Posta Adresiniz.'),
	(42, 1, 42, 'grsEpostaTelefon', 'Telefon Numaranız'),
	(43, 1, 43, 'grsEpostaGiris', 'Giriş Yap'),
	(44, 1, 44, 'grsBilet', 'İnternet Erisimi'),
	(45, 1, 45, 'grsBiletMesaj', 'Satın almış olduğunuz Bilet´in üzerinde bulunan Bilet numarasını aşağıya yazınız.'),
	(46, 1, 46, 'grsBiletKodu', 'Bilet No'),
	(47, 1, 47, 'grsBiletGiris', 'Giriş Yap'),
	(48, 1, 48, 'grsKurumsal', 'Kullanıcı Girişi'),
	(49, 1, 49, 'grsKurumsalKullaniciAdi', 'Kullanıcı Adınız'),
	(50, 1, 50, 'grsKurumsalSifre', 'Şifreniz'),
	(51, 1, 51, 'grsKurumsalGiris', 'Giriş Yap'),
	(52, 1, 52, 'grsBizeYazin', 'Bize Yazın'),
	(53, 1, 53, 'grsBizeYazinMesaj', 'Öner,Şikayet ve destektek bildirimlerinizi bu bölümden Sistem Yöneticimize iletebilirsiniz.'),
	(104, 1, 104, 'grsTcSifre', 'Şifreniz'),
	(105, 1, 105, 'grsBizeYazinAdSoyad', 'Adınız Soyadınız'),
	(106, 1, 106, 'grsBizeYazinTelefon', 'Telefon Numaranız'),
	(108, 1, 108, 'grsBizeYazinSikayet', 'Şikayet'),
	(110, 1, 110, 'grsBizeYazinDestek', 'Destek'),
	(111, 1, 111, 'grsBizeYazinOneri', 'Öneri'),
	(112, 1, 112, 'grsBizeYazinIcerik', 'Mesajınız'),
	(113, 1, 113, 'grsBizeYazinGiris', 'Gönder'),
	(115, 1, 115, 'msjHataBizeYazin', 'Mesajınız gönderilemedi! Lütfen tekrar deneyiniz.'),
	(116, 1, 116, 'msjHataBizeYazinFormKontrol', 'Mesajınız gönderilemedi! Lütfen formu eksiksiz giriniz.'),
	(118, 1, 118, 'msjSonucBizeYazin', 'Mesajınız başarılı olarak gönderilmiştir.En kısa sürede size geri dönüş yapacağız.'),
	(119, 1, 119, 'grsBan', 'Boxnet Ban......'),
	(121, 1, 121, 'grsBanAciklama', 'Bu bilgisayar´dan internet erişiminiz engellenmiştir.Lütfen Sistem Yöneticinizle iletişime geçiniz.!'),
	(122, 4, 1, 'grsNetyum', 'User Access'),
	(123, 4, 2, 'grsNetyumKullaniciAdi', 'Username'),
	(124, 4, 3, 'grsNetyumSifre', 'Password'),
	(125, 4, 4, 'grsNetyumButon', 'Login'),
	(126, 4, 5, 'grsOzelGiris', 'Guest Access'),
	(127, 4, 6, 'grsOzelGirisKullaniciAdi', 'Username'),
	(128, 4, 7, 'grsOzelGirisSifre', 'Password'),
	(129, 4, 8, 'grsOzelGirisButon', 'Login'),
	(130, 4, 9, 'grsTc', 'Register'),
	(131, 4, 10, 'grsTcMesaj', 'Hata'),
	(132, 4, 11, 'grsTcKimlik', 'Tc Number'),
	(133, 4, 12, 'grsTcAdiniz', 'Name'),
	(134, 4, 13, 'grsTcSoyadiniz', 'Surname'),
	(135, 4, 14, 'grsTcDogumYili', 'Year of Birth'),
	(136, 4, 15, 'grsTcButon', 'Register'),
	(137, 4, 16, 'msjHataTc', 'Hata'),
	(138, 4, 17, 'msjHataTcFormKontrol', 'Hata'),
	(139, 4, 18, 'msjHataTcProfilKontrol', 'Hata'),
	(140, 4, 19, 'msjHataTcKontrol', 'Hata'),
	(141, 4, 20, 'msjSonucTc', 'Hata'),
	(142, 4, 21, 'msjSonucTcSifreGuncelleme', 'Hata'),
	(143, 4, 22, 'grsKayitSms', 'Register'),
	(144, 4, 23, 'grsKayitSmsMesaj', 'Hata'),
	(145, 4, 24, 'grsKayitSmsAdSoyad', 'Fullname'),
	(146, 4, 25, 'grsKayitSmsTelefon', 'Phone Number'),
	(147, 4, 26, 'grsKayitSmsHaberdarOl', 'Hata'),
	(148, 4, 27, 'grsKayitSmsGiris', 'Register'),
	(149, 4, 28, 'msjHataSms', 'Hata'),
	(150, 4, 29, 'msjHataSmsFormKontrol', 'Hata'),
	(151, 4, 30, 'msjHataSmsLimitKontrol', 'Hata'),
	(152, 4, 31, 'msjHataSmsBilgilerKontrol', 'Hata'),
	(153, 4, 32, 'msjHataSmsProfilKontrol', 'Hata'),
	(154, 4, 33, 'msjSonucSms', 'Hata'),
	(155, 4, 34, 'grsGuvenlik', 'User Access'),
	(156, 4, 35, 'grsGuvenlikMesaj', 'Security Code'),
	(157, 4, 36, 'grsGuvenlikKodu', 'Yeniliklerden haberdar olmak istiyorum.'),
	(158, 4, 37, 'grsGuvenlikGiris', 'Login'),
	(159, 4, 38, 'grsEposta', 'User Access'),
	(160, 4, 39, 'grsEpostaMesaj', 'Doğru yaziniz.'),
	(161, 4, 40, 'grsEpostaAdSoyad', 'Fullname'),
	(162, 4, 41, 'grsEpostaMail', 'E-Mail'),
	(163, 4, 42, 'grsEpostaTelefon', 'Phone Number'),
	(164, 4, 43, 'grsEpostaGiris', 'Login'),
	(165, 4, 44, 'grsBilet', 'Internet Access'),
	(166, 4, 45, 'grsBiletMesaj', 'Biletinizde bulunan şifreyi aşağıya giriniz.'),
	(167, 4, 46, 'grsBiletKodu', 'Ticket No'),
	(168, 4, 47, 'grsBiletGiris', 'Login'),
	(169, 4, 48, 'grsKurumsal', 'User Access'),
	(170, 4, 49, 'grsKurumsalKullaniciAdi', 'Username'),
	(171, 4, 50, 'grsKurumsalSifre', 'Password'),
	(172, 4, 51, 'grsKurumsalGiris', 'Login'),
	(173, 4, 52, 'grsBizeYazin', 'Contact'),
	(174, 4, 53, 'grsBizeYazinMesaj', 'Aciklama yaz'),
	(175, 4, 105, 'grsBizeYazinAdSoyad', 'Fullname'),
	(176, 4, 106, 'grsBizeYazinTelefon', 'Phone Number'),
	(177, 4, 108, 'grsBizeYazinSikayet', 'Information'),
	(178, 4, 110, 'grsBizeYazinDestek', 'Support'),
	(179, 4, 111, 'grsBizeYazinOneri', 'Cause'),
	(180, 4, 112, 'grsBizeYazinIcerik', 'Message'),
	(181, 4, 113, 'grsBizeYazinGiris', 'Send'),
	(182, 4, 115, 'msjHataBizeYazin', 'Hata'),
	(183, 4, 116, 'msjHataBizeYazinFormKontrol', 'Formu Doldurunuz'),
	(184, 4, 118, 'msjSonucBizeYazin', 'Tamamlandı.'),
	(185, 4, 119, 'sozlesmemetni', '<div><span class="Apple-style-span" style="font-weight: bold;">"Visitor Wireless Internet Access" is only provided for Boxnet Ltd. Belekövisitor´s personal usage.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Visitors are not allowed to share wireless network access with any person.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">Boxnet Ltd. is not responsible for the legal obligations stemming from sharing access and forbidden internet usage.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">According to the law enacted on 23.05.2007, All movements on the network are recorded.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">Visitors are responsible for their unlegal internet usage.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">It is prohibited to send mass mailing, mail bombing, spam, Dos attack, Port network scanning ..etc.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">Visitors accept abovementioned rules when they start using internet service.</span></div><div><span class="Apple-style-span" style="font-weight: bold;">&nbsp;</span></div><div><span class="Apple-style-span" style="font-weight: bold;">Boxnet Ltd. Dose Not accept any responsibilty or obligations caused by unlegal internet usage. Only users take responsibilty for the inconvenient usage.</span></div>'),
	(186, 4, 121, 'footerMesaj', 'İnternet erişimleriniz 5651 sayılı kanun gereğince kayıt altına alınmaktadır.'),
	(187, 1, 187, 'sozlesmemetni', '<div><span class="Apple-style-span" style="font-weight: bold;">Boxnet Ltd. Şti. "misafir kablosuz ağ erişimi", otelimize gelen misafirlerin bireysel kullanımına sunulmuş internet hizmetidir.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Misafir kablosuz ağ erişimi kişiye özel olup başkaları ile paylaştırılamaz.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Hizmetin paylaştırılması, yeniden dağıtılması, hizmetin amacına uygun kullanılmaması gibi nedenlerle oluşabilecek yasal yükümlülüklerden Boxnet Ltd. Şti. sorumlu tutulamaz.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">23.05.2007 tarihinde yürürlüğe giren 5651 sayılı Internet Ortamında Yapılan Yayınların Düzenlenmesi ve Bu Yayınlar Yoluyla İşlenen Suçlarla Mücadele Edilmesi Hakkında Kanun,  gereğince tüm internet trafiği kayıt altına alınmaktadır.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Misafir kablosuz ağ erişimi hizmetinden faydalanan  Misafirler, gerçekleştirdikleri aktivitelerin yasal sonuçlarından kendileri sorumludurlar.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Kablosuz ağ kaynakları kullanılarak, kütlesel e-posta gönderilmesi (mass mailing, mail bombing, spam) ve üçüncü şahısların göndermesine olanak sağlanması yasaktır.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Ağ güvenliğini tehdit edici faaliyetlerde bulunmak (DoS saldırısı, port network taraması vb.) yasaktır.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Bu hizmeti kullanmaya başladığınızda burada belirtilen şartları kubul etmiş sayılırsınız.</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">YASAL SORUMLULUK REDDİ:</span></div><div><span class="Apple-style-span" style="font-weight: bold;"><br></span></div><div><span class="Apple-style-span" style="font-weight: bold;">Boxnet Ltd. Şti. kablosuz ağ kullanimindan doğacak riskler konusunda sorumluluk kabul etmez. Bütün sorumluluk kullaniciya aittir.</span></div>'),
	(188, 1, 188, 'footerMesaj', 'İnternet erişimleriniz 5651 sayılı kanun gereğince kayıt altına alınmaktadır.'),
	(189, 1, 189, 'grsFacebookTitle', 'Facebook ile Bağlan'),
	(190, 1, 190, 'grsFacebookMesaj', 'Merhaba'),
	(191, 1, 191, 'grsFacebookGiris', 'İnternet Giriş Yap');
/*!40000 ALTER TABLE `tbl_text` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_voucher
CREATE TABLE IF NOT EXISTS `tbl_voucher` (
  `VoucherID` int(11) NOT NULL AUTO_INCREMENT,
  `ProfilID` int(11) DEFAULT NULL,
  `Adet` int(11) DEFAULT NULL,
  `Hesaplar` longtext COLLATE utf8_bin,
  `HesapID` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`VoucherID`),
  KEY `FK_tbl_voucher_tbl_profil` (`ProfilID`),
  CONSTRAINT `FK_tbl_voucher_tbl_profil` FOREIGN KEY (`ProfilID`) REFERENCES `tbl_profil` (`ProfilID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_voucher: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_voucher` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_yetki
CREATE TABLE IF NOT EXISTS `tbl_yetki` (
  `Yetki` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Aciklama` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  UNIQUE KEY `Yetki` (`Yetki`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table boxnet.tbl_yetki: ~23 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_yetki` DISABLE KEYS */;
INSERT INTO `tbl_yetki` (`Yetki`, `Aciklama`) VALUES
	('profil_yonetimi_profiller', 'profil yönetimi > profil hesaplarını, düzenleme ve silme'),
	('profil_yonetimi_yeni_profil', 'profil yönetimi > yeni profil hesabı ekleme'),
	('gunlukler_5651_gunlukleri', 'günlükler > 5651 günlük raporları'),
	('gunlukler_hesap_gunlukleri', 'günlükler > hesap kullanım günlukleri'),
	('gunlukler_hesap_hareketleri', 'günlükler > hesap hareketleri(giriş/çıkış)'),
	('hesap_yonetimi_biletler', 'hesap yönetimi > bilet oluşturma'),
	('hesap_yonetimi_gruplar', 'hesap yönetimi > grup oluşurma'),
	('hesap_yonetimi_hesaplar', 'hesap yönetimi > hesap yönetimi'),
	('hesap_yonetimi_yeni_hesap', 'hesap yönetimi > yeni hesap oluşturma'),
	('hizmet_portali_gelen_mesajlar', 'hizmet portalı > gelen mesajlar'),
	('hizmet_portali_yukleme_merkezi', 'hizmet portalı > yükleme merkezi(logo/slider)'),
	('sistem_yonetimi_entegrasyon_ayari', 'sistem yonetimi > entegrasyon ayarları'),
	('sistem_yonetimi_hotspot_yonetimi', 'sistem yonetimi > hotspot genel ayarlar'),
	('sistem_yonetimi_kullanici_yonetimi', 'sistem yonetimi > yonetici hesapları'),
	('sistem_yonetimi_mail_sms_ayarlari', 'sistem yonetimi > mail sms ayarları'),
	('sistem_yonetimi_toplu_mail', 'sistem yonetimi > toplu mail gönderme'),
	('sistem_yonetimi_toplu_sms', 'sistem yonetimi > toplu sms gönderme'),
	('raporlar', 'raporlar > genel raporlar'),
	('gunlukler_sms_gunlukleri', 'günlükler > sms  günlükleri'),
	('hizmet_portali_dil_ayari', 'hizmet portalı > dil ayarı'),
	('sistem_yonetimi_nas_yonetimi', 'sistem yonetimi > nas yonetimi'),
	('sistem_yonetimi_yedekleme', 'sistem yonetimi > yedekleme'),
	('sistem_yonetimi_sms_api', 'sistem yonetimi > sms api');
/*!40000 ALTER TABLE `tbl_yetki` ENABLE KEYS */;

-- tablo yapısı dökülüyor boxnet.tbl_kullanici_yetki
CREATE TABLE IF NOT EXISTS `tbl_kullanici_yetki` (
  `KullaniciID` int(11) DEFAULT NULL,
  `Yetki` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Yeni` bit(1) DEFAULT NULL,
  `Duzenle` bit(1) DEFAULT NULL,
  `Sil` bit(1) DEFAULT NULL,
  UNIQUE KEY `KullaniciID_Yetki` (`KullaniciID`,`Yetki`),
  KEY `KullaniciID` (`KullaniciID`),
  KEY `Yetki` (`Yetki`),
  CONSTRAINT `FK__tbl_kullanici` FOREIGN KEY (`KullaniciID`) REFERENCES `tbl_kullanici` (`KullaniciID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__tbl_yetki` FOREIGN KEY (`Yetki`) REFERENCES `tbl_yetki` (`Yetki`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=UTF8_BIN;

-- Dumping data for table boxnet.tbl_kullanici_yetki: ~34 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_kullanici_yetki` DISABLE KEYS */;
INSERT INTO `tbl_kullanici_yetki` (`KullaniciID`, `Yetki`, `Yeni`, `Duzenle`, `Sil`) VALUES
	(7, 'gunlukler_hesap_hareketleri', NULL, NULL, NULL),
	(7, 'gunlukler_hesap_gunlukleri', NULL, NULL, NULL),
	(7, 'gunlukler_sms_gunlukleri', NULL, NULL, NULL),
	(7, 'hesap_yonetimi_biletler', NULL, NULL, NULL),
	(7, 'hesap_yonetimi_gruplar', NULL, NULL, NULL),
	(7, 'hesap_yonetimi_hesaplar', NULL, NULL, NULL),
	(7, 'hesap_yonetimi_yeni_hesap', NULL, NULL, NULL),
	(7, 'hizmet_portali_gelen_mesajlar', NULL, NULL, NULL),
	(7, 'raporlar', NULL, NULL, NULL),
	(7, 'sistem_yonetimi_toplu_mail', NULL, NULL, NULL),
	(7, 'sistem_yonetimi_toplu_sms', NULL, NULL, NULL),
	(6, 'gunlukler_5651_gunlukleri', NULL, NULL, NULL),
	(6, 'gunlukler_hesap_hareketleri', NULL, NULL, NULL),
	(6, 'gunlukler_hesap_gunlukleri', NULL, NULL, NULL),
	(6, 'gunlukler_sms_gunlukleri', NULL, NULL, NULL),
	(6, 'hesap_yonetimi_biletler', NULL, NULL, NULL),
	(6, 'hesap_yonetimi_gruplar', NULL, NULL, NULL),
	(6, 'hesap_yonetimi_hesaplar', NULL, NULL, NULL),
	(6, 'hesap_yonetimi_yeni_hesap', NULL, NULL, NULL),
	(6, 'hizmet_portali_dil_ayari', NULL, NULL, NULL),
	(6, 'hizmet_portali_gelen_mesajlar', NULL, NULL, NULL),
	(6, 'hizmet_portali_yukleme_merkezi', NULL, NULL, NULL),
	(6, 'profil_yonetimi_profiller', NULL, NULL, NULL),
	(6, 'profil_yonetimi_yeni_profil', NULL, NULL, NULL),
	(6, 'raporlar', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_entegrasyon_ayari', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_hotspot_yonetimi', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_mail_sms_ayarlari', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_nas_yonetimi', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_sms_api', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_toplu_mail', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_toplu_sms', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_yedekleme', NULL, NULL, NULL),
	(6, 'sistem_yonetimi_kullanici_yonetimi', NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_kullanici_yetki` ENABLE KEYS */;


-- tablo yapısı dökülüyor boxnet.tbl_kurumsal
CREATE TABLE IF NOT EXISTS `tbl_kurumsal` (
  `UyeID` int(11) NOT NULL AUTO_INCREMENT,
  `ProfilID` int(11) DEFAULT NULL,
  `KullaniciAdi` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Sifre` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `AdSoyad` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `Tarih` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UyeID`),
  UNIQUE KEY `KullaniciAdi` (`KullaniciAdi`),
  KEY `FK_tbl_kurumsal_tbl_profil` (`ProfilID`),
  CONSTRAINT `FK_tbl_kurumsal_tbl_profil` FOREIGN KEY (`ProfilID`) REFERENCES `tbl_profil` (`ProfilID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dumping data for table boxnet.tbl_kurumsal: ~0 rows (yaklaşık)
/*!40000 ALTER TABLE `tbl_kurumsal` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_kurumsal` ENABLE KEYS */;

-- görünüm yapısı dökülüyor boxnet.vw_groupkullanicidownload
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_groupkullanicidownload` (
	`groupname` VARCHAR(64) NULL COLLATE 'latin1_swedish_ci',
	`username` VARCHAR(64) NOT NULL COLLATE 'latin1_swedish_ci',
	`acctinputoctets` BIGINT(20) NULL,
	`Tarih` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- görünüm yapısı dökülüyor boxnet.vw_grupkota
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_grupkota` (
	`groupname` VARCHAR(64) NOT NULL COLLATE 'latin1_swedish_ci',
	`KotaTur` VARCHAR(10) NULL COLLATE 'utf8_bin',
	`KotaKb` VARCHAR(50) NULL COLLATE 'utf8_bin',
	`Tarih` TIMESTAMP NULL,
	`Bugun` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- görünüm yapısı dökülüyor boxnet.vw_internetkullanimi
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_internetkullanimi` (
	`Tarih` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`ToplamKayit` BIGINT(21) NOT NULL,
	`Trafik` DECIMAL(45,2) NULL
) ENGINE=MyISAM;


-- görünüm yapısı dökülüyor boxnet.vw_kullanicidownload
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_kullanicidownload` (
	`username` VARCHAR(64) NOT NULL COLLATE 'latin1_swedish_ci',
	`acctinputoctets` BIGINT(20) NULL,
	`Tarih` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- görünüm yapısı dökülüyor boxnet.vw_kullanicikota
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_kullanicikota` (
	`id` INT(11) UNSIGNED NOT NULL,
	`username` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci',
	`attribute` VARCHAR(64) NOT NULL COLLATE 'utf8_general_ci',
	`KotaKb` VARCHAR(50) NULL COLLATE 'utf8_general_ci',
	`KotaTur` VARCHAR(10) NULL COLLATE 'utf8_general_ci',
	`Tarih` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci',
	`Bugun` VARCHAR(10) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;


-- görünüm yapısı dökülüyor boxnet.vw_kullanicimac
-- VIEW bağımlılık sorunlarını çözmek için geçici tablolar oluşturuluyor
CREATE TABLE `vw_kullanicimac` (
	`radacctid` BIGINT(21) NOT NULL,
	`username` VARCHAR(64) NOT NULL COLLATE 'latin1_swedish_ci',
	`callingstationid` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`acctstarttime` DATETIME NULL
) ENGINE=MyISAM;



DROP TABLE IF EXISTS `vw_groupkullanicidownload`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_groupkullanicidownload` AS select (select `radgroupcheck`.`groupname` from (`radcheck` join `radgroupcheck` on((`radgroupcheck`.`id` = `radcheck`.`GrupID`))) where (`radcheck`.`username` = convert(`radacct`.`username` using utf8))) AS `groupname`,`radacct`.`username` AS `username`,`radacct`.`acctinputoctets` AS `acctinputoctets`,date_format(`radacct`.`acctstarttime`,'%Y-%m-%d') AS `Tarih` from `radacct` where `radacct`.`username` in (select `radcheck`.`username` from `radcheck` where (`radcheck`.`GrupID` is not null) group by `radcheck`.`username`);



DROP TABLE IF EXISTS `vw_grupkota`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_grupkota` AS select `r`.`groupname` AS `groupname`,`p`.`KotaTuru` AS `KotaTur`,`p`.`MaxDownload` AS `KotaKb`,`r`.`Tarih` AS `Tarih`,date_format(now(),'%Y-%m-%d') AS `Bugun` from (`radgroupcheck` `r` join `tbl_profil` `p` on((`p`.`ProfilID` = `r`.`ProfilID`))) group by `r`.`groupname`;



DROP TABLE IF EXISTS `vw_internetkullanimi`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_internetkullanimi` AS select date_format(`radacct`.`acctstarttime`,'%d.%m.%Y') AS `Tarih`,count(0) AS `ToplamKayit`,round(((((sum(`radacct`.`acctinputoctets`) + sum(`radacct`.`acctoutputoctets`)) / 1024) / 1024) / 1024),2) AS `Trafik` from `radacct` group by date_format(`radacct`.`acctstarttime`,'%d.%m.%Y') order by `radacct`.`acctstarttime` desc limit 0,9;



DROP TABLE IF EXISTS `vw_kullanicidownload`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_kullanicidownload` AS select `radacct`.`username` AS `username`,`radacct`.`acctinputoctets` AS `acctinputoctets`,date_format(`radacct`.`acctstarttime`,'%Y-%m-%d') AS `Tarih` from `radacct` where `radacct`.`username` in (select `radcheck`.`username` from `radcheck` where (`radcheck`.`UyeID` <> 12) group by `radcheck`.`username`);



DROP TABLE IF EXISTS `vw_kullanicikota`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_kullanicikota` AS select `radcheck`.`id` AS `id`,`radcheck`.`username` AS `username`,`radcheck`.`attribute` AS `attribute`,`radcheck`.`KotaKB` AS `KotaKb`,`radcheck`.`KotaTur` AS `KotaTur`,date_format(`radcheck`.`Tarih`,'%Y-%m-%d') AS `Tarih`,date_format(now(),'%Y-%m-%d') AS `Bugun` from `radcheck` where (`radcheck`.`KotaKB` is not null) group by `radcheck`.`username`;



DROP TABLE IF EXISTS `vw_kullanicimac`;
CREATE ALGORITHM=UNDEFINED DEFINER=`boxnet`@`%` SQL SECURITY DEFINER VIEW `vw_kullanicimac` AS select `radacct`.`radacctid` AS `radacctid`,`radacct`.`username` AS `username`,`radacct`.`callingstationid` AS `callingstationid`,`radacct`.`acctstarttime` AS `acctstarttime` from `radacct` group by `radacct`.`callingstationid`;

UPDATE tbl_text SET Deger = REPLACE (Deger, 'ÅŸ', 'ş' ) WHERE Deger LIKE '%ÅŸ%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Åž', 'Ş' ) WHERE Deger LIKE '%Åž%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã‡', 'Ç' ) WHERE Deger LIKE '%Ã‡%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã§', 'ç' ) WHERE Deger LIKE '%Ã§%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã?', 'Ö' ) WHERE Deger LIKE '%Ã?%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã–', 'Ö' ) WHERE Deger LIKE '%Ã–%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã¶', 'ö' ) WHERE Deger LIKE '%Ã¶%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ã¼', 'ü' ) WHERE Deger LIKE '%Ã¼%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'ÄŸ', 'ğ' ) WHERE Deger LIKE '%ÄŸ%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ä±', 'ı' ) WHERE Deger LIKE '%Ä±%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ä°', 'İ' ) WHERE Deger LIKE '%Ä°%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ãœ', 'Ü' ) WHERE Deger LIKE '%Ãœ%';
UPDATE tbl_text SET Deger = REPLACE (Deger, 'Ä�', 'Ğ' ) WHERE Deger LIKE '%Ä�%';

UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'ÅŸ', 'ş' ) WHERE Aciklama LIKE '%ÅŸ%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Åž', 'Ş' ) WHERE Aciklama LIKE '%Åž%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã‡', 'Ç' ) WHERE Aciklama LIKE '%Ã‡%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã§', 'ç' ) WHERE Aciklama LIKE '%Ã§%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã?', 'Ö' ) WHERE Aciklama LIKE '%Ã?%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã–', 'Ö' ) WHERE Aciklama LIKE '%Ã–%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã¶', 'ö' ) WHERE Aciklama LIKE '%Ã¶%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ã¼', 'ü' ) WHERE Aciklama LIKE '%Ã¼%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'ÄŸ', 'ğ' ) WHERE Aciklama LIKE '%ÄŸ%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ä±', 'ı' ) WHERE Aciklama LIKE '%Ä±%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ä°', 'İ' ) WHERE Aciklama LIKE '%Ä°%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ãœ', 'Ü' ) WHERE Aciklama LIKE '%Ãœ%';
UPDATE tbl_yetki SET Aciklama = REPLACE (Aciklama, 'Ä�', 'Ğ' ) WHERE Aciklama LIKE '%Ä�%';

UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'ÅŸ', 'ş' ) WHERE SmsSablon LIKE '%ÅŸ%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Åž', 'Ş' ) WHERE SmsSablon LIKE '%Åž%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã‡', 'Ç' ) WHERE SmsSablon LIKE '%Ã‡%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã§', 'ç' ) WHERE SmsSablon LIKE '%Ã§%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã?', 'Ö' ) WHERE SmsSablon LIKE '%Ã?%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã–', 'Ö' ) WHERE SmsSablon LIKE '%Ã–%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã¶', 'ö' ) WHERE SmsSablon LIKE '%Ã¶%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ã¼', 'ü' ) WHERE SmsSablon LIKE '%Ã¼%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'ÄŸ', 'ğ' ) WHERE SmsSablon LIKE '%ÄŸ%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ä±', 'ı' ) WHERE SmsSablon LIKE '%Ä±%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ä°', 'İ' ) WHERE SmsSablon LIKE '%Ä°%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ãœ', 'Ü' ) WHERE SmsSablon LIKE '%Ãœ%';
UPDATE tbl_ayar SET SmsSablon = REPLACE (SmsSablon, 'Ä�', 'Ğ' ) WHERE SmsSablon LIKE '%Ä�%';

UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'ÅŸ', 'ş' ) WHERE BiletSablon LIKE '%ÅŸ%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Åž', 'Ş' ) WHERE BiletSablon LIKE '%Åž%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã‡', 'Ç' ) WHERE BiletSablon LIKE '%Ã‡%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã§', 'ç' ) WHERE BiletSablon LIKE '%Ã§%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã?', 'Ö' ) WHERE BiletSablon LIKE '%Ã?%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã–', 'Ö' ) WHERE BiletSablon LIKE '%Ã–%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã¶', 'ö' ) WHERE BiletSablon LIKE '%Ã¶%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ã¼', 'ü' ) WHERE BiletSablon LIKE '%Ã¼%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'ÄŸ', 'ğ' ) WHERE BiletSablon LIKE '%ÄŸ%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ä±', 'ı' ) WHERE BiletSablon LIKE '%Ä±%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ä°', 'İ' ) WHERE BiletSablon LIKE '%Ä°%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ãœ', 'Ü' ) WHERE BiletSablon LIKE '%Ãœ%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Ä�', 'Ğ' ) WHERE BiletSablon LIKE '%Ä�%';
UPDATE tbl_ayar SET BiletSablon = REPLACE (BiletSablon, 'Â', '' ) WHERE BiletSablon LIKE '%Â%';

UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'ÅŸ', 'ş' ) WHERE Aciklama LIKE '%ÅŸ%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Åž', 'Ş' ) WHERE Aciklama LIKE '%Åž%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã‡', 'Ç' ) WHERE Aciklama LIKE '%Ã‡%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã§', 'ç' ) WHERE Aciklama LIKE '%Ã§%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã?', 'Ö' ) WHERE Aciklama LIKE '%Ã?%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã–', 'Ö' ) WHERE Aciklama LIKE '%Ã–%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã¶', 'ö' ) WHERE Aciklama LIKE '%Ã¶%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ã¼', 'ü' ) WHERE Aciklama LIKE '%Ã¼%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'ÄŸ', 'ğ' ) WHERE Aciklama LIKE '%ÄŸ%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ä±', 'ı' ) WHERE Aciklama LIKE '%Ä±%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ä°', 'İ' ) WHERE Aciklama LIKE '%Ä°%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ãœ', 'Ü' ) WHERE Aciklama LIKE '%Ãœ%';
UPDATE tbl_profil SET Aciklama = REPLACE (Aciklama, 'Ä�', 'Ğ' ) WHERE Aciklama LIKE '%Ä�%';

UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'ÅŸ', 'ş' ) WHERE ProfilAdi LIKE '%ÅŸ%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Åž', 'Ş' ) WHERE ProfilAdi LIKE '%Åž%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã‡', 'Ç' ) WHERE ProfilAdi LIKE '%Ã‡%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã§', 'ç' ) WHERE ProfilAdi LIKE '%Ã§%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã?', 'Ö' ) WHERE ProfilAdi LIKE '%Ã?%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã–', 'Ö' ) WHERE ProfilAdi LIKE '%Ã–%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã¶', 'ö' ) WHERE ProfilAdi LIKE '%Ã¶%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ã¼', 'ü' ) WHERE ProfilAdi LIKE '%Ã¼%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'ÄŸ', 'ğ' ) WHERE ProfilAdi LIKE '%ÄŸ%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ä±', 'ı' ) WHERE ProfilAdi LIKE '%Ä±%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ä°', 'İ' ) WHERE ProfilAdi LIKE '%Ä°%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ãœ', 'Ü' ) WHERE ProfilAdi LIKE '%Ãœ%';
UPDATE tbl_profil SET ProfilAdi = REPLACE (ProfilAdi, 'Ä�', 'Ğ' ) WHERE ProfilAdi LIKE '%Ä�%';
