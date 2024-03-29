CREATE DATABASE  IF NOT EXISTS `DrugVeda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `DrugVeda`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: lin-16287-9495-mysql-primary.servers.linodedb.net    Database: DrugVeda
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'dad3bf71-ab0e-11ed-8ee8-f23c932ad393:1-627';

--
-- Table structure for table `medical_labs`
--

DROP TABLE IF EXISTS `medical_labs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_labs` (
  `LabID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Lat` float NOT NULL,
  `Lon` float NOT NULL,
  PRIMARY KEY (`LabID`),
  UNIQUE KEY `uq_medical_labs_email` (`Email`),
  UNIQUE KEY `uq_medical_labs_phone` (`Phone`),
  KEY `ix_medical_labs_Email` (`Email`),
  KEY `idx_medical_labs_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_labs`
--

LOCK TABLES `medical_labs` WRITE;
/*!40000 ALTER TABLE `medical_labs` DISABLE KEYS */;
INSERT INTO `medical_labs` VALUES ('01747d92-167d-4afe-8d00-23e6b22afc63','Ajay Wakelam','awakelam1t@chicagotribune.com','2086003528',-8.1278,112.751),('01ba66ab-4439-47d5-8ba6-508f601fdc4c','Keefer Bilt','kbilt28@privacy.gov.au','9284993310',38.6817,112.338),('025101cf-77e3-49e0-97ca-df53daaa4cc0','Sayers Sieghard','ssieghard2@abc.net.au','5151052232',59.3321,18.0575),('04930994-392d-4556-a6b9-39430e57b4d5','Baxie Hamilton','bhamilton29@nps.gov','7068630469',-7.3056,108.094),('0533c16d-8274-4d56-841d-d4712cd4c6b9','Flossi Ateggart','fateggartn@devhub.com','2039171375',8.21585,-13.0962),('05f490c0-9962-45c9-be9f-5eaba0d8d3a4','Val Dobel','vdobel19@amazon.com','2269295606',40.8457,25.874),('0637697c-3946-4cd2-8d87-0284e1f79e79','Selena Sarra','ssarra2l@paginegialle.it','4976403151',-9.35509,-37.1902),('0ae804b7-272c-4e68-bfed-f9605b6af62e','Tripp Rego','trego2e@indiegogo.com','7892695496',14.6032,121.01),('0af6b043-194e-4b0d-866e-803a05ce396a','Blanch Ahmed','bahmedb@mlb.com','8439984135',33.7072,8.97146),('0b3f05e2-2713-4168-bad2-606396997bfb','Ash Gooke','agooke1f@surveymonkey.com','4333948393',22.8081,-81.194),('0caf91aa-8a87-4447-b4b5-1131ca86f0ad','Abbey Ondrasek','aondrasek24@drupal.org','1197836184',-12.0582,-77.1054),('0f6b8af9-9530-49fe-b85b-66b0a61da141','Kassi Govier','kgovier1r@bandcamp.com','2959346395',-27.8341,25.9063),('1143775a-3ec8-453e-8f49-f80d257b8268','Miles Middlemass','mmiddlemass1y@artisteer.com','1071021644',50.0625,-110.682),('14fb8af2-4591-4ae4-9f5a-e5ce5f85c972','Skylar Fludder','sfludder1@yelp.com','7756577646',40.0115,-119.696),('1a055b4a-ccc4-4afd-8117-73ca3eb584fb','Vivyanne Culham','vculhamg@cam.ac.uk','4022945614',-40.8114,-65.0905),('1a2ff29b-c35d-4988-ac2a-2aa3c04f8b9f','Hildy Runge','hrunge21@si.edu','1506845662',50.2415,15.4908),('212d8b92-cbfa-457c-b914-c1d30b7073a6','Mitchell Antonchik','mantonchik2m@1688.com','9743683652',14.7909,42.9709),('23d3ddb0-2124-467b-b362-7b4142352fc5','Robinson Dowtry','rdowtry1j@google.it','7528207469',14.429,121.036),('250c6b8f-fad7-4481-876c-fd7f6a8e3946','Kennith De Ruel','kdec@twitter.com','4557526804',43.3212,45.992),('2627f6d8-3346-4c45-a8a1-63af8b8e2e12','Skelly Leroux','slerouxq@ihg.com','2752227604',38.7107,-9.39754),('29a1f9ac-21bd-4321-8fa8-f87594f99853','Hally Gilmore','hgilmore1w@globo.com','8368141537',35.0435,25.0929),('29ae2b0a-8a15-43d0-b6df-78e565b23360','Sherill Dobbinson','sdobbinson4@home.pl','7484022990',34.9487,-5.24798),('2aedd369-936e-4312-af20-ae8e6620ef57','Madel Earry','mearryk@springer.com','2469026740',19.7236,99.7165),('305362c4-1ca5-4d8b-b0ad-1da1ce18ef9f','Lazarus Bramall','lbramall1v@mozilla.com','8766452109',15.2008,-12.945),('3df3f2fb-dee7-42bf-bcdd-ed7c327543fe','Sandra Medlin','smedlin1q@intel.com','2641264103',38.5023,125.752),('3ec9db98-8a12-44c6-9d51-88a76602e1ce','Travis Zmitrichenko','tzmitrichenko16@altervista.org','1939504801',30.5208,120.145),('4105c2a0-45f4-49d6-a76d-061946114b50','Archibald Kelleher','aot@reuters.com','1247987747',54.208,19.1175),('41cc1044-e57f-451a-b1be-84871bb3be60','Lola Mullally','lomullally2g@washington.edu','8442834740',40.5336,19.5955),('42ff03ee-1266-4cc9-9475-84286b2ddfd8','Kathrine Drinkeld','kdrinkeld2c@vkontakte.ru','4707700702',48.5347,7.63702),('455b766f-5c21-4f54-9e9c-4d1d11b479bf','Eal Melville','emelville1d@google.it','1864391882',32.2951,75.2071),('46cc6122-6480-4a4a-9ed6-5e253694928f','Joela Aronsohn','jaronsohn23@addtoany.com','1772684338',35.1775,109.591),('47f14174-905d-4d6c-9bbd-225587280267','Lennard Betteson','lbetteson7@marketwatch.com','7654882201',-9.26234,-77.693),('4ab01075-f76c-4b03-9198-fe5a16ebda39','Ingunna Jarmyn','ijarmyni@e-recht24.de','8353235634',-5.17349,105.199),('4db4c763-27e5-4683-bdd0-e9c3c18b7aa5','Bird Bielfeldt','bbielfeldt1e@free.fr','2437545664',-6.33686,107.377),('523efbc2-78fa-431a-a1d6-48b162737593','Blisse Robelin','brobelin1z@lulu.com','6103439386',22.2455,-80.3937),('5500130f-0f1e-4be3-89c2-d5cc7bc44154','Nadine Walby','nwalby2q@mediafire.com','5176437754',42.7283,-84.5511),('5568a841-5832-4db5-afdb-b3e33855b62e','Nike Clews','nclews1n@dailymail.co.uk','6593980011',50.3501,-113.769),('5643026e-2d3b-476f-812a-e960e18d4b70','Travers Beausang','tbeausang2k@list-manage.com','8441109064',-34.0897,23.3262),('58cc8574-8652-4c7f-867f-d82254648a86','Pearla Filer','pfiler1s@opensource.org','4774990523',38.0511,114.463),('59837615-eab0-4dd3-ac06-861aa1293b7c','Kailey Gravet','kgraveta@ovh.net','8327700454',47.255,-1.54015),('59cb4596-e112-4867-a7a0-3bdd90830fb6','Darrick Stratton','dstrattonh@eepurl.com','7723244249',26.6655,-80.0591),('5b724365-b93f-4025-9dcc-b2a8eb5197f0','Elwyn Arnoud','earnoud14@netscape.com','1071068193',32.6276,113.808),('60700770-bcb9-4343-a2c8-f402fee7c82b','Ulick Illes','uilles9@php.net','2802884331',35.0422,136.957),('64f7ded9-8340-49f0-9d05-dfb5a1fb2e5a','Gav Swinbourne','gswinbourne6@paginegialle.it','9998427727',38.235,115.726),('65d325c9-906c-4f44-8fdd-05fda7051a55','Sherman Cubbit','scubbits@arizona.edu','6948939274',40.0612,140.142),('65ee1968-6a97-4a59-8a96-d99a1bf8e1a6','Barbee Elderton','beldertonv@eepurl.com','7622363591',-11.8532,-75.508),('6b654915-e9a5-4e7f-8576-98c5abd5cc2b','Veriee Laydel','vlaydel27@baidu.com','2219674589',-26.1353,28.2949),('6b7d7623-3e3d-4096-b5bb-769cdc05bcec','Clarette Itschakov','citschakove@admin.ch','3336841610',10.5955,124.766),('6f24cee1-c843-4c1f-b193-902c06a5b891','Kandace Roskruge','kroskruge1b@e-recht24.de','7676831956',12.5633,124.927),('71ba845d-cb3c-4353-9685-e8713024703c','Ezri Appleyard','eappleyardr@state.tx.us','9499026831',55.1952,32.4001),('730f4262-da03-4b26-a689-0fedcc5acd06','Nicolis McKearnen','nmckearnen25@dell.com','9006406450',40.5852,46.843),('77cc839b-4c1d-43d5-92ca-92b20b5cd383','Colin Chinnick','cchinnick1o@webnode.com','9278265500',-6.80585,111.961),('79aa7f01-687c-4e32-9e2c-9fdfc62d659f','Silvana Paver','spavero@hugedomains.com','8934361014',-26.4594,27.8604),('7bc0428a-1b17-47a5-aca3-bf938f0484fa','Reinald Claussen','rclaussen1k@usa.gov','5218495738',44.8298,34.9151),('7e95901f-b7b5-43c4-8080-5b95f7c54576','Liliane Bohea','lbohea0@google.com.br','2399538549',-23.1078,26.8321),('811b2587-d362-406f-ac25-778969e27a93','Meggi de Aguirre','mde26@slideshare.net','4027311905',38.1353,114.397),('81c7420b-c82c-4c3a-9059-8e1d139c81d4','Kala Miliffe','kmiliffe1i@vimeo.com','7791390965',41.1962,-8.41568),('82a453fc-7761-4e46-9075-59f12bb60f55','Moyna Covolini','mcovolini11@ameblo.jp','6952342819',35.0965,32.8423),('860b3795-8cf5-4296-8535-7a988ba493d6','Jessi Holton','jholton2f@twitpic.com','6042643638',41.7464,-8.37212),('875fa3c2-78e3-45b7-9e2e-e6776d0f4a91','Elli Leathwood','eleathwood13@mediafire.com','6885370747',14.5725,121.038),('875fbc11-5a56-4d0a-9c3e-ad46b4aaae21','Stan Lynas','slynas10@slashdot.org','6981804879',59.3121,18.1969),('8de8b298-1ffb-421e-9507-5bc26479f5ff','Ilsa Jentle','ijentle1c@naver.com','4807845968',-0.245758,110.283),('8e9c97f2-2e90-4007-b238-178a1d69c8c3','Giovanna Reisk','greisk2a@seesaa.net','1418741718',-7.60443,109.577),('90fcd4fb-d749-4151-bd80-4ee1d24efc74','Randi Shurmore','rshurmorej@slate.com','3512770121',-10.5971,121.889),('9129ca5f-47bb-48fd-838d-cb2d33ed6024','Kerri Groger','kgrogerz@answers.com','2259399271',-25.0994,-50.1585),('94a2416b-8441-4809-817c-7382e94b5366','Domenic Deighton','ddeightond@ezinearticles.com','5203744533',5.9841,116.076),('9a1da8c4-02f9-4ad7-b41f-b3ff0a0f8804','Rudd Thomazet','rthomazetm@bigcartel.com','8189030849',28.4389,120.565),('9a5d2367-e62e-4615-b441-b5b7cffbd532','Donavon Stidston','dstidston1h@chron.com','7504813852',49.7234,18.0785),('9d28c547-3580-452b-b63d-ece8d3e19506','Abran Vanacci','avanacci15@adobe.com','2027586075',42.542,-91.1118),('9de3a502-cd80-4512-b791-239ac9d5d82e','Shayne Yakebovitch','syakebovitchp@springer.com','6628036969',34.2734,109.065),('9eddcb79-3501-4b97-bb19-ff6e262a9306','Mignonne Fitzroy','mfitzroy2n@dagondesign.com','8787820129',16.1391,120.524),('a0585b51-f3eb-4e4b-8be8-fb57ac533694','Abby Hackly','ahackly3@blinklist.com','2144052106',32.8869,-96.9679),('a3a90609-e18c-4715-8712-b9b9e37002dd','Kerwin Lidster','klidster1a@ifeng.com','2204796330',35.8462,14.4864),('a40dd999-de4f-4782-9521-b0939f7894cc','Bee Yukhnini','byukhninix@google.es','6296522305',59.2424,14.4353),('a5d31e3b-b7b8-4f96-9a8c-178c1cb2b123','Devan Glassopp','dglassopp1l@blinklist.com','8324911761',32.8905,115.815),('a7883668-71e7-4815-a9fa-de33859121a2','Sydelle Trousdale','strousdalew@eepurl.com','1063450143',43.6131,7.05623),('a98f78a5-3ded-4091-96c8-648fc839fbcc','Leda Wittman','lwittmanu@ucoz.com','8976596600',8.92047,125.009),('aaefc0d7-fe35-4739-8741-af080cbafef6','Odell Beumant','obeumant20@twitter.com','1638676557',-27.5949,-48.5482),('afecf528-a39e-46a2-90d3-a42adaee1964','Fedora Mayow','fmayow2i@usatoday.com','7935351320',26.5679,106.714),('b0cec522-cf46-42d7-a133-1588627d6b23','Jeanie Newis','jnewis1p@princeton.edu','1655343514',49.5891,6.25705),('b50362f4-3e99-46af-ae10-08e8f7532592','Natalie Keightley','nkeightley2b@umn.edu','8852675684',43.4829,44.5893),('b6a2e4fb-2132-405b-b9a3-f1f9d6f87a5c','Aridatha Greetland','agreetland2d@google.co.uk','2466091671',49.3933,16.6413),('c012d436-743e-4933-a513-bb04c8590d2b','Tabina Smellie','tsmellie1m@homestead.com','5882610679',-7.35,-79.0333),('c2765a30-df4b-4c94-998d-2d76bdf61acc','Tallie Mansell','tmansell2p@reuters.com','4484742159',-7.02958,108.592),('ca0ea731-7a6d-443d-9589-2da78f7627dd','Jena Willshear','jwillshear18@alexa.com','2987341032',45.6879,18.4042),('cc217736-95d0-4db8-8085-eaccb12bdba8','Phillipe Lummis','plummis1u@about.me','3117961797',23.9563,113.192),('ce11f3a7-84ce-4b1b-8130-c663a2124e5f','Elliott Bywater','ebywater12@cnn.com','8519508311',-7.54503,111.656),('d2394dcb-dd97-41c7-a58f-2412b3ba8d08','Eduino Monelli','emonelliy@soundcloud.com','2572840216',10.2744,125.257),('d783057c-76bb-4154-a4c7-eb21b5ad8f09','Adan Anton','aanton2j@discuz.net','7215393262',-30.8494,-51.8048),('d9b18c2e-1534-4b21-833d-9745b274e9a6','Lanna Hagergham','lhagergham1x@house.gov','9102241958',44.1088,-79.4985),('dcdb3573-2cde-4647-95a6-8c09147d66bb','Barnett Yo','byo1g@microsoft.com','8415594706',19.2199,-70.8191),('dfe9d917-3c43-42c6-a805-555d1473f747','Carol-jean Clowney','cclowneyf@omniture.com','7475647623',50.9409,20.9571),('e72fbbaa-6cdf-4c97-89c1-f0dbc42a182b','Nobe Sand','nsandl@taobao.com','7273581484',40.1573,-8.11063),('e7e4e549-ec6d-4f8e-8596-06794baa0692','Hamlen Esbrook','hesbrook5@hao123.com','2343953977',48.2506,-1.50299),('e8bc724e-bfab-41d0-b5ec-446197903b4f','Ellen Caulier','ecaulier22@dedecms.com','6812048058',-0.900292,119.878),('e97ad286-dd1c-4168-8758-b08173cda50e','Barde Sopper','bsopper17@dedecms.com','4024246639',-6.26832,106.108),('f9072b7d-9aa7-49f7-88f3-708c0a298cb5','Chrissie Sears','csears8@narod.ru','1386389167',11.2935,2.4357),('f9d15e72-153e-4904-91ea-c1f31ebf6c96','Zachary Seman','zseman2h@live.com','7451526536',31.3406,119.823),('fb75b9b7-9bf1-4569-afb6-fc8b4309585e','Ina Mastrantone','imastrantone2o@usnews.com','8193313455',4.68894,-75.7778),('fc07ed8d-b9fd-4352-8a9c-6a4650b5195d','Colene Handyside','chandyside2r@vk.com','6526687668',-10.1097,123.802);
/*!40000 ALTER TABLE `medical_labs` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-17 16:35:45
