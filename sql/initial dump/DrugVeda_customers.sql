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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Lat` float NOT NULL,
  `Lon` float NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `uq_customers_email` (`Email`),
  UNIQUE KEY `uq_customers_phone` (`Phone`),
  KEY `ix_customers_Email` (`Email`),
  KEY `idx_customers_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('01677896-1dba-463b-864d-6b589313adef','Jeanna Stife','jstifea@slideshare.net','4353552018',30.8225,28.9543),('05e32ec7-799a-46f0-a446-87ae9446529b','Peri Lovart','plovart23@tinyurl.com','3076645888',43.5415,-5.88551),('09d09b6d-9a65-4b62-b256-639cb6288e07','Lebbie Jahnke','ljahnkeu@nhs.uk','8799421916',49.5962,19.1333),('09d7e5d1-b4ef-476e-8e87-decca5bc488d','Martita Buckoke','mbuckoke1a@blinklist.com','5753646611',-8.19514,123.799),('0a916ea7-c796-46ec-86fa-ba1daa489563','Patric Faulkes','pfaulkes1l@amazonaws.com','5853653548',43.1626,-77.6079),('0c88bc4f-004a-48de-95f5-0e1614915cb3','Chick Greatrex','cgreatrex1k@ox.ac.uk','9333746337',-7.42127,107.172),('0cd76e24-6225-4a29-bdd3-f34ecd54d961','Tory Dittson','tdittson0@spiegel.de','2463184672',-23.75,-46.3977),('0dca5913-9ee9-4d11-860b-9bddbea4b91c','Mitchell Alleyne','malleynee@dropbox.com','2355281431',42.0216,121.67),('16efcf89-cc4f-49b7-961b-36e565ae5300','Jennifer Joslyn','jjoslynh@go.com','9455452787',37.3219,126.831),('1d28c7d4-449f-4802-836f-02f36a7433bc','Johna Cottey','jcottey3@dedecms.com','4802581942',21.0878,105.66),('1e6d5214-1615-4363-8a7d-5e8e4a37c6cb','Leslie Ortzen','lortzenl@tmall.com','3085253645',51.4758,6.71124),('1f17ef0f-b7db-48b0-aab7-46df6ef4cdbc','Vi Hewertson','vhewertson22@opensource.org','7925127237',34.2423,70.8744),('1fdb3612-791d-4c10-803c-5d1b6a58080a','Germaine Diess','gdiess1c@sphinn.com','7677195524',31.9537,118.84),('2837fa17-8a8f-4d15-b179-cf8b282f490d','Sela Hovington','shovington2a@utexas.edu','2619894930',5.2053,97.0687),('2b61cfa4-4678-4969-9d30-7590f6eeaec2','Joe Redsell','jredsell1y@networkadvertising.org','3379070065',51.23,-101.356),('2bb71941-a208-479b-9d55-1e63946e8689','Ciel Brear','cbrearp@soup.io','2419677404',45.6429,29.3754),('2bee772d-2266-44b1-bee6-f62876daa80a','Gwenette Whitwam','gwhitwam1j@weibo.com','4659745769',-8.1953,113.618),('2d664245-521d-4b1b-967d-2066bdd430b9','Madelyn Neil','mneil1n@businesswire.com','7895981637',7.98197,-81.1665),('2f020aa9-e56b-4b3e-b6fc-1ad457f461fb','Kary Drews','kdrews1q@4shared.com','6614093221',-8.64902,115.214),('309354aa-4836-4397-bfd3-d052e1f98152','Zacharia Burgoin','zburgoin8@biblegateway.com','8233891863',-7.37904,107.32),('3252391e-9f74-40b1-bb91-2aab4f6ca300','Lilah Sussems','lsussems16@bbc.co.uk','2696369673',32.3183,109.715),('378ca713-2180-4fce-923d-c51e2ffbe4c5','Kent Barukh','kbarukhj@soundcloud.com','8585680137',32.4,64.4319),('37b01f3e-76c5-40b1-901f-f8a03c1b44c1','Amandi Latus','alatus1r@tmall.com','1725949404',31.0157,117.206),('399501aa-3179-468d-9887-a5354d873c0b','Gradey Rimmer','grimmer1@patch.com','1101571006',3.10282,101.678),('3e74e425-11c3-46a6-8dea-0d8ee3faab29','Tonye Pigrome','tpigrome2j@jimdo.com','2998758393',52.1501,20.8188),('3ff203c5-42f6-4787-9099-3f2acc3c0e8d','Mandel Bullers','mbullers1i@rambler.ru','5915585393',63.8294,15.3601),('4069cc95-422b-4d0d-99a5-8f4321846299','Tracey Grumley','tgrumley1e@auda.org.au','9865689010',54.9898,62.5471),('4171ad87-0690-45b1-855c-f1896c44bee8','Millicent Rivenzon','mrivenzon2q@loc.gov','2384223929',6.92802,79.8908),('41fcb96e-de03-4e22-b629-913ea14995da','Pat Kydd','pkydd2g@mayoclinic.com','1121947751',12.7867,39.5433),('424631e8-58b5-4149-86af-59e709158120','Kliment Gosforth','kgosforth2o@pinterest.com','6814483658',40.2766,-8.49033),('42b30b4f-5279-4001-8446-1cc7ed5ad2df','Tanner Dake','tdake1g@washingtonpost.com','6819138569',34.6465,133.75),('430a8766-75fb-414b-af17-3e14be9d303a','Harrie Hobden','hhobdenk@un.org','9863461225',-7.16797,108.508),('4452bdee-7ee4-4f87-a4df-a4ce9ed2475c','Genevieve Conybear','gconybear2p@merriam-webster.com','8989397867',59.3015,17.9981),('47c53148-240c-40a8-a3ec-da7ab81fa5f6','Clea Bronger','cbronger24@booking.com','7032740447',38.8823,-77.1428),('4a5d8eba-1a3a-4493-a959-327913d6f5f3','Nahum Candish','ncandish1m@indiegogo.com','7661533538',-6.83006,110.837),('4a76fad6-a132-4bc5-9b1e-fc58a395ebe6','Andre Cubbino','acubbino1t@surveymonkey.com','1932524965',-7.48423,112.733),('50651218-196c-4962-95e5-29048bb0ddb6','Velvet Howett','vhowett4@imgur.com','6849007387',57.667,11.8785),('50699b67-9026-4202-9ed4-a368f8a9240b','Cherye Ketts','ckettsr@youku.com','9536002593',53.425,58.9689),('554c562f-0c36-4b88-ab07-1cb81f4ff6c3','Glenden Podbury','gpodbury1f@telegraph.co.uk','9332893020',34.7487,134.079),('56df632e-1249-4d54-8704-6430cd31b87f','Suzann Doneld','sdoneld26@nifty.com','2433213689',53.2,-6.10111),('5777482e-6f81-4e81-8fdc-e16e542b2d47','Miguelita Huntar','mhuntarv@dmoz.org','7889133083',39.1899,-8.72678),('5bc1aab2-7348-4b4b-82fd-75a9a6109066','Liliane Fairbrother','lfairbrother2b@rambler.ru','2287435141',-6.21677,106.523),('61783acf-877c-4b38-a3da-27a9520d7a13','Oliy Ludman','oludmanz@auda.org.au','4067602936',-22.8998,-49.6258),('63fe0f2a-ec93-4d17-a4b4-2752bee9d8f2','Anna-diane Friberg','afriberg1z@geocities.com','6485811031',-26.0731,30.107),('6647a9af-3955-4411-9836-36166c259660','Rogerio Mose','rmoseq@plala.or.jp','5604952915',17.2827,121.872),('6730036f-c20d-4c57-a9b5-ab1a1a3f8b8a','Brendon Mussared','bmussared5@cargocollective.com','8766549175',34.2721,108.085),('690eed11-ec59-4a61-bb40-f6deac586e55','Alejoa Brookzie','abrookzie2d@craigslist.org','8954673118',57.8644,13.4263),('6c443ebf-f828-43ed-b221-51ccf040ac98','Denna Baldung','dbaldung11@cpanel.net','6519434824',44.4113,18.748),('6cf3df38-075a-49b4-b592-f7791bd8b82f','Neile Lockhart','nlockhart2r@usgs.gov','3329916166',-7.47209,108.632),('6fd3b729-76b8-46be-8c8a-84d2a92455d0','Nedi Januszkiewicz','njanuszkiewiczx@time.com','4077901152',55.0614,73.2499),('70f472d4-f0ba-468c-b19b-3fba1abd1dfe','Sarge Sizeland','ssizeland13@adobe.com','8745236839',54.985,83.0471),('73f96971-21cc-421b-a01d-66ce18432a2e','Alick Hear','aoheary@nytimes.com','3359083477',35.8617,104.195),('74854920-6fc6-4d68-bd92-e26bfc0a205f','Perice Brandreth','pbrandreth2@dell.com','8043762013',36.689,117.302),('755a46b2-6609-4e06-abb5-0f755d064985','Catherin Gregoriou','cgregoriou1h@businessweek.com','7783473777',42.9535,129.992),('75b17e2a-8de7-4372-8292-74771031d292','Emerson McTague','emctague1w@uiuc.edu','8581988473',45.4402,39.5187),('7638d58e-ae93-4778-a78b-b478162d956d','Sherm Charters','scharters14@edublogs.org','2687484700',41.253,-7.95364),('7638fcd6-8a38-40d1-98a3-ba6d4a831732','Norris Size','nsize1d@cmu.edu','6542465788',31.1678,112.588),('7c87b817-609f-405c-8783-0531a7c3f540','Ramon Coleby','rcoleby7@businesswire.com','8482985051',-7.65683,110.339),('7e3d8d47-adc5-4436-8e4e-8ea31e21d946','Karlis Littlefield','klittlefields@icq.com','9727516927',32.6901,-96.937),('80ccf974-456e-4ee6-ae7f-ac092e99a925','Ibrahim Harden','iharden18@ed.gov','1863665411',50.0349,15.4781),('876c3479-5ce2-4d1b-b460-be758b24a494','Jemmy Adao','jadao2f@globo.com','5613780983',36.5669,105.673),('8c45fd11-e3a0-47cd-944f-3bd10f589fab','Latrina Cominotti','lcominotti9@creativecommons.org','8712999934',37.0508,22.0084),('8cc6be61-987b-48da-82e0-49c93c640271','Kailey Mariet','kmarietw@ucsd.edu','1289175083',31.1123,-8.4966),('8da901d0-4622-4d40-942f-72fb70cd0506','Catha Maddin','cmaddin2c@marriott.com','3531932844',23.3643,116.7),('9272714d-5d2d-4d54-a120-67cad04b4317','Chad Blabie','cblabien@fc2.com','1441678500',51.2343,58.4814),('98648540-039d-4996-8b46-388942e41d12','Trixy Biddle','tbiddle19@slashdot.org','6433128871',64.679,21.2422),('986b57b0-469f-48df-9ddb-d7dab0cec36e','Bert Roots','broots2e@cdbaby.com','2984796339',-7.73515,110.709),('9a05ea34-8012-4292-ba6c-cc281b7156f4','Wildon Carayol','wcarayol2m@twitter.com','4609387800',9.29644,99.0571),('9fce7f49-7a5a-4087-bc4a-066876a02a45','Etta Rigmond','erigmond2h@opera.com','7779226547',46.7133,96.5259),('a27afdb5-0316-483e-9c19-f28ff1307483','Stafani Pond','spond29@disqus.com','8164129046',-20.8914,55.5178),('a5857966-3c13-4395-8c1f-4313b727eef1','Ashbey Keir','akeirc@weebly.com','1377599617',54.7601,17.5563),('ac380ac5-98c0-42fb-8d96-05bbdbd3a7b1','Ertha Seleway','eseleway17@gmpg.org','7022766154',14.9144,120.894),('aebee06c-796a-408c-84b1-10077de1dd7f','Wanids Ellesworth','wellesworth1x@nbcnews.com','5813165370',-19.6633,22.1937),('b0969af0-daf1-4b97-919a-4bba5f9c5ac0','Ignaz Siddaley','isiddaley1o@cpanel.net','2739285032',54.2388,17.2313),('b14e236c-71bf-4187-abb8-feab31edd98b','Rhiamon Hugueville','rhugueville28@china.com.cn','4032683607',50.1369,-96.8792),('b19c4c1e-0b5a-48e1-a4e3-b5e2614eac62','Angelica Tosney','atosney15@addthis.com','9182676961',49.6835,-83.6665),('b697b54d-51f6-4ed2-984b-82fc9e81e7ca','Demetris Purselow','dpurselow10@soup.io','6808298003',48.3697,42.1774),('b6d07418-4df2-42d9-80bb-a5d04b691df9','Sisile Serrier','sserrier25@odnoklassniki.ru','1005815402',28.1591,115.771),('ba694734-1a33-4eaf-94bb-1d64ac07bb1c','Ilka Bullers','ibullers2l@blogger.com','9568912370',-23.3518,-47.6932),('bfa929d5-a121-4897-ae57-060c33011020','Debbi Placidi','dplacidif@4shared.com','2807558859',-11.2957,-75.7728),('c00a74f5-48a7-49bb-8ff7-7797fd3fef2a','Hube Lowres','hlowresm@surveymonkey.com','4764603406',14.2,100.575),('c0fbc039-776f-4de6-9702-c8864a89c389','Raddy Fuentes','rfuentes2k@fda.gov','8909548240',13.6782,102.521),('c37b395a-31ec-4488-9700-4ae4984f90c2','Caro Langrish','clangrish27@timesonline.co.uk','6897241070',24.3478,116.695),('c4d56400-3a70-4f10-b6ab-754980ec90f5','Nolan Anetts','nanettsg@weather.com','1085275710',43.0429,1.90388),('c93efa10-a95e-498e-9ca4-97689c5838f1','Christean Tanfield','ctanfield21@prnewswire.com','2534690661',31.4169,119.484),('cd17541d-25d2-476b-ac1d-29fc40edf1ff','Rivy Everwin','reverwin6@columbia.edu','9288136863',47.4917,21.6685),('cec064de-55ab-4e9f-a5a3-eda93e23cca5','Courtenay Trenear','ctrenear12@163.com','5109674407',38.7593,-9.27607),('d1b20608-f8a2-4b56-aaf6-2426724dba78','Esme Joyner','ejoynero@pinterest.com','4877639420',59.9247,30.321),('dda17c02-0f79-4f22-984b-8ef77247e426','Garald Linnell','glinnelli@csmonitor.com','3555707341',54.0518,35.2299),('e00994fe-ab87-4cce-8334-f1266ef41574','Wilmar Swain','wswainb@wordpress.org','4167992928',25.6927,117.847),('e0f47414-5096-449b-86f9-f3b5fdc18efd','Ema Glenister','eglenister2n@google.com','5553770082',46.1696,14.6907),('e23227d2-5b3d-4fac-81e1-c1b133b3a6c2','Talbert Riall','triall2i@goodreads.com','8018246050',46.2531,14.4869),('ed9b3a9d-c429-44db-8d31-e77649aacbbb','Maitilde Lysons','mlysons20@dailymail.co.uk','3279688216',45.5516,-73.1933),('eef1cc86-6c00-41db-a8c0-24fa33de9198','Heda Stiles','hstiles1b@photobucket.com','8987370049',54.7209,37.5456),('efaa3594-34f1-4fbb-950e-16426c6023ed','Leela Diggle','ldiggle1u@domainmarket.com','5184004478',38.6503,-9.21577),('f13e119b-9a05-46bf-a07b-d3ffd37c0324','Sibbie Killcross','skillcrosst@cnn.com','2057790612',31.1357,30.1328),('f4572d15-9c34-4f34-ae9e-d87671c72463','Talyah Leveritt','tleveritt1v@opera.com','7901719988',31.9584,12.0204),('f5b5a72c-d591-4780-966d-69d2d81f4770','Harmony Chatelain','hchatelain1s@domainmarket.com','6593684207',-1.92962,18.2911),('f6d2bce0-8c8f-463e-a356-5001dc008942','Ludovico Brammar','lbrammar1p@independent.co.uk','4364515276',-8.69316,-67.9524),('f76f4387-e502-4e09-8769-65df141855d0','Lucy Sharnock','lsharnockd@creativecommons.org','1849614112',18.4529,105.764);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
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

-- Dump completed on 2023-02-17 16:35:34
