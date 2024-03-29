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
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `SupplierID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Lat` float NOT NULL,
  `Lon` float NOT NULL,
  PRIMARY KEY (`SupplierID`),
  UNIQUE KEY `uq_suppliers_email` (`Email`),
  UNIQUE KEY `uq_suppliers_phone` (`Phone`),
  KEY `ix_suppliers_Email` (`Email`),
  KEY `idx_suppliers_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES ('03dd750c-a9cd-44dd-a872-780776961b6b','Erv Sketchley','esketchley2k@senate.gov','6458123597',-7.78885,114.191),('052ffd9d-7705-4d57-b547-733093703dd1','Lemmy Sancraft','lsancraftl@t-online.de','9922013928',32.297,35.11),('09d62860-bcd2-43f3-ab85-6cc238aaac6d','Shayla Firpi','sfirpi5@joomla.org','6374070651',49.7923,13.4915),('0e878c08-b720-4069-99e9-9980ebf344cb','Waly Glendining','wglendiningi@imgur.com','6789209247',-31.3965,-52.6788),('10c01259-ab97-450f-96ca-c85675377218','Mathias Pigott','mpigott25@cargocollective.com','2096333293',-20.2878,-45.5397),('130d148e-7d03-44bc-b21c-b8b8f8c5dbba','Curry Benn','cbenn1o@google.com','7311509319',14.4167,-91.1667),('17012a58-cfc8-4fff-abf0-dca4530d2cb2','Courtnay Jillis','cjillis18@cloudflare.com','8375258434',-6.49088,106.795),('1857007b-8f2d-4afb-adb7-631bf9e58a12','Rockwell Harrald','rharrald17@abc.net.au','1292864063',1.68306,-77.0729),('1a39c212-84b1-45a7-aa35-136211a7227b','Ibrahim Joliffe','ijoliffe2h@icq.com','8971959338',-17.7667,-149.417),('20aebbcc-ee34-408a-80a6-404672b27dbe','Austin Grimmolby','agrimmolby10@jalbum.net','3063213249',56.3153,48.2507),('2545e6a3-2462-42bf-b46d-428d1b29f80c','Sammy Suller','ssuller2e@omniture.com','5971344294',30.035,107.122),('28dc68ab-ec51-4f51-9d9b-6adfe7bc0a5d','Lucinda Kuhwald','lkuhwald2j@gmpg.org','1525552384',4.59437,-74.0741),('2bddb469-47e9-4f6e-a5de-9d52d6e083b8','Dotti Karpman','dkarpmano@chronoengine.com','8473487137',18.5615,-74.4196),('2c508da4-1765-42a2-bd27-1d4eb0f9ee4e','Frederick Murtagh','fomurtagh24@ning.com','5865637526',29.1697,48.1176),('2f5b89b1-9287-4d01-bdc3-0255e1ead146','Dorree Padmore','dpadmore1a@infoseek.co.jp','5109468037',44.8405,82.3537),('353a8d93-ba0d-46e1-b455-485b21672376','Cobby Downage','cdownage21@boston.com','3749172475',14.6213,-90.5501),('3560d295-7535-4cec-9e60-433167c2866d','Lexine Pawels','lpawels2l@eepurl.com','4928978933',46.8464,106.216),('35e5294c-bc21-4e9c-9974-04bc9579b0fd','Neely Showt','nshowt26@pagesperso-orange.fr','3754176331',43.7442,2.512),('36e055d5-1146-4a07-8128-76734437749c','Janot Sarsfield','jsarsfieldz@photobucket.com','6838754840',25.9568,88.3831),('371d001e-8ab1-4d43-acb3-53232864b1b6','Levin Kluger','lkluger2q@google.co.jp','1327975289',32.6837,112.197),('3c4eeb97-9822-4ba1-833f-0b79ff0b5b3f','Annadiana Douris','adouris14@techcrunch.com','7184475684',-8.43886,-77.3206),('3c76aa14-30ef-4f89-a77c-8a415c86a8d9','Norbie Bennitt','nbennitt1m@t-online.de','4658779964',56.4955,93.2783),('3e44c4e6-2690-4b7e-9eed-2d325943c151','Boone Chalker','bchalker1z@reddit.com','7012591234',48.0482,-1.63293),('43b15758-d5f5-45c1-8fb5-d21ee1bcca80','Chen Ingles','cingles23@ucoz.ru','7605706079',37.5237,-8.78603),('457c311a-8542-4a71-93c0-51414696b242','Hilary Beentjes','hbeentjesp@tmall.com','9776516495',45.9184,40.1588),('4a939fbf-708c-40e8-bd17-c0779274a84f','Marthena Greatorex','mgreatorex2a@wunderground.com','7781834108',35.6325,138.956),('4c37b5db-0f34-423b-80b1-d687b7a6c44d','Isidoro Douse','idouse1w@ebay.co.uk','6219358065',14.6485,121.078),('518b3845-2fdd-4f9f-bd9c-2960033c0572','Dominica Rafferty','dorafferty2g@ca.gov','2748421991',-23.397,-46.9996),('51e2fd73-0501-411b-b59e-1bf9c111af8f','June Godsafe','jgodsafe16@freewebs.com','2393012042',60.9358,25.935),('5c5d9ab6-c62f-4430-95c1-3245c33cab83','Merrel Cox','mcox1u@va.gov','9671735014',59.3779,10.7606),('5f98860d-8ae5-497d-b92f-582d9eefe8e0','Peggi Labern','plabern1v@mtv.com','9368612644',-9.54633,119),('606b9c67-ff97-4be4-b4d7-f22522e084fe','La verne Ratledge','lverne1s@thetimes.co.uk','5751910782',15.2674,-88.542),('609a0bef-bfa7-4a02-b3a3-456da1538e78','Lianne Newlove','lnewlove2p@360.cn','2455515951',-1.25458,31.4199),('6408c8fb-f7d1-4be7-b7fb-2e6818576f05','Karel Romi','kromig@ameblo.jp','5805629774',-10.5792,-37.745),('656e9389-e922-4c8b-9bcb-04344975fefc','Addison Heeks','aheeks8@php.net','1977662096',48.0398,30.9521),('67b6b0fc-7a75-49a5-91f3-9efe86a569dc','Lexi Toffel','ltoffel28@etsy.com','9066850303',61.9677,26.3974),('68092ab8-689b-4aee-99f5-039746e0a93a','Koren Minichillo','kminichilloa@amazon.co.uk','6524653116',24.5641,108.526),('68684bbf-fcd7-40ff-8c4c-9aaff97ee63c','Danya Marriner','dmarriner2b@altervista.org','2724250042',59.3126,18.0626),('6ccfb99f-f1e5-4efb-8e88-90b16296209c','Danell Jeffree','djeffree1l@phpbb.com','3676394432',34.1587,109.387),('6d80174c-06df-4b9b-a4a0-7777bd56984c','Mattie Rugg','mruggj@163.com','5186465346',15.6823,119.941),('70a928e1-974e-4028-a8b8-4410b49b4a14','Hanny Dabes','hdabes2o@zdnet.com','6274040472',26.6413,100.223),('7341cafd-aecb-402e-aeea-8d9909aec486','Roxane Prosser','rprosser1f@blog.com','7789983484',48.873,16.7665),('7420ac64-8e69-4c13-887f-990ef5ed3cb6','Deloria Stonard','dstonard13@dagondesign.com','2813422172',-33.0061,-60.6723),('749f3181-a5ea-419e-ac41-c27d000d9c31','Tally Jenkyn','tjenkyn2d@java.com','8116954122',22.5294,103.939),('75518bd6-3de4-438c-9f52-93f3642dc9d7','Janella Gerriets','jgerriets1e@myspace.com','1842467464',22.6695,113.248),('7fafe583-e599-4f4e-a4c8-ef04f5e6743e','Ingar Bigley','ibigley1h@sphinn.com','6102496941',39.976,-75.2537),('803e9515-08a7-4e50-827f-d7ca2995b8f7','Hedda Forty','hfortyf@slashdot.org','7986136523',40.9921,21.4233),('80b74e27-2faa-439a-988d-11d6a5700481','Orly Kilbourne','okilbourne12@npr.org','2264607592',59.3573,27.4137),('8406b60b-80d7-4cc1-9c1b-7b963cddde11','Kylila Casone','kcasone1b@archive.org','4296255542',33.645,133.479),('8ac5197e-a92b-4912-a7db-28fb585ef66d','Chris Nutting','cnuttingu@hc360.com','6406744267',53.1067,-0.687802),('90144fb1-e008-4ebc-a404-dae4ac6e5e8f','Fonzie Wilsee','fwilseeh@shinystat.com','1443151692',38.7098,-9.41646),('916a36ff-0e50-4d6a-bb68-7e593dd5ccc8','Pablo Rykert','prykert2n@skyrock.com','5535059879',64.0129,11.4964),('9209463c-c75e-41b4-ac0b-ad6998c65abd','Lotty Heinschke','lheinschke2r@constantcontact.com','6821487551',55.6629,37.5827),('9214d8cf-7cd8-4903-b57c-6fc5b33c9e52','Kit Killigrew','kkilligrew19@cbc.ca','9537152263',29.4977,106.573),('923b9d14-1f0e-453a-af07-fb97ef566fd6','Truda McCrudden','tmccrudden1@washingtonpost.com','7244913415',23.6347,112.441),('97c83d1b-99a2-483a-a465-abb5e055d954','Cordi Maskew','cmaskew22@free.fr','2387615525',53.8536,30.2671),('9bd523a5-703d-47ad-9437-682085afc287','Rhianna Bottell','rbottellx@aol.com','4987331685',-7.23762,35.7175),('9d837a42-d6bb-4b0a-b5c4-61377b63841a','Max Fayer','mfayer2m@tripod.com','5599206221',-8.2359,114.961),('a09785d8-7942-4b3c-9910-cb6ff0f1d48c','Cord Peploe','cpeploe1y@walmart.com','7611674412',53.2385,20.1681),('a1903234-16ab-41ba-9b31-808042b4df1b','Kendricks Burnep','kburnep1k@surveymonkey.com','6365235338',24.1543,115.744),('a2bd64ee-c326-4571-a94e-0b77d1f50591','Trevor Recher','trechere@cisco.com','1637294827',59.0923,57.6539),('a37a5e28-44ad-494d-8305-e8b2095d7d93','Ellerey Giovannacc@i','egiovannacci2c@purevolume.com','4828019990',-11.9007,-40.7564),('a631361a-7fff-4545-93fd-a0681a3baaf0','Gracie Seeman','gseeman2f@soup.io','8738577074',41.2267,-8.3781),('a77ae033-46d5-4fc8-a373-d0e543326b8e','Tilda Hassey','thassey2i@springer.com','1793393148',-37.0853,174.943),('a786c214-ab3f-42af-aeef-83cde527fb58','Hakim Derle','hderle1j@aboutads.info','2314569008',36.8831,22.549),('a89beb64-b445-4133-91cd-724ac87b8693','Erminia Gilman','egilman1p@netvibes.com','2924639693',-34.4786,-58.5718),('aa0fcf37-e438-471e-8b95-6f662294cd58','Jenn Stronghill','jstronghill1i@sfgate.com','3286898416',17.6992,121.504),('b26cf9ca-ec1e-401e-b25d-0ef063466be2','Butch Moles','bmoles27@yolasite.com','3557109324',56.8642,60.6397),('b460bc70-7583-441c-87cc-02341c497569','Theadora Spong','tspong2@wiley.com','6079239783',-7.42203,106.753),('b485852c-1c9f-4f50-8878-56fae3e91105','Hannis Currm','hcurrmw@ucoz.ru','9682610654',53.0804,85.6747),('b6f8dada-235b-4ea2-9f80-8cd426b38edb','Raimundo Weigh','rweigh11@house.gov','4608469499',35.7215,111.351),('b7a33c57-2cb3-4658-a98e-f54571e2f4f2','Catarina Van Saltsberg','cvann@feedburner.com','7005618983',62.0672,-7.30097),('b9fcf314-2e15-4719-a025-4bf299f15bf9','Noam Braithwaite','nbraithwaite1g@biblegateway.com','3473354514',59.3703,16.553),('bce72894-245a-42f1-9aef-5108d2398510','Sibilla Armsby','sarmsbys@pcworld.com','7198641304',22.941,-109.945),('c27277fa-6f79-42d2-9dd3-0c437e7265b0','Sarene Murricanes','smurricanesv@tmall.com','5378146768',56.4768,36.5752),('c4cb46b4-bb83-44bb-a782-bf9037d8c791','Thornton Castana','tcastana29@wired.com','4451310914',38.0162,-8.69568),('c573dc79-6e66-4c64-83fb-1c01b91fdf69','Allis Pickover','apickover1q@smugmug.com','2201588297',55.8432,13.2986),('ca6c2716-3353-40ee-913a-ebd0f95ee510','Forbes McClaughlin','fmcclaughlinc@tripadvisor.com','9841942408',29.9377,110.048),('ca85bfee-8334-4b3b-a85d-f4beb4448316','Davie Ivkovic','divkovicr@bbc.co.uk','3762740698',40.2673,19.6654),('cb2038e9-ad77-44d3-aa78-02d2550f48b1','Karlik Scothorn','kscothornd@dropbox.com','3624856817',30.4323,72.3382),('cf04bf19-7684-408f-8df7-b28b8e3e47f0','Staford Vasilkov','svasilkov1x@seattletimes.com','1423028618',-11.4034,-74.7527),('d38a06fa-c184-4b27-909d-dfa2a5b4789f','Carrie Gurnay','cgurnayq@i2i.jp','2435905889',45.4146,18.6959),('d6340f7b-5fe1-4363-94dc-e49c9a95689b','Cathy Gillyatt','cgillyatt1d@discuz.net','4934716164',49.1077,16.0607),('d76e05ad-f614-4e5b-a15c-7620ea20289c','Odele Lascelles','olascellesb@utexas.edu','1313629538',8.11764,-80.5938),('da1bdca0-9fcd-43ac-8d0a-be30882fa670','Marjory Klainman','mklainmank@google.ru','8221549224',-37.7867,175.282),('db9039a2-836b-40e8-9589-b65e04774950','Stacee Lob','slob3@indiatimes.com','1167791023',59.7585,17.7837),('dcc037f0-0c9e-4d6e-8f58-27bf6aaaff70','Carce Banaszczyk','cbanaszczykt@stanford.edu','8949949037',60.6191,26.1999),('df94f21c-3c8a-45d0-a1f2-59e7413cd290','Katha Lord','klord9@state.tx.us','7997984733',43.2581,42.6468),('e2884c7f-d141-48f4-961b-a889f227158f','Rycca Screen','rscreenm@tinypic.com','5198642171',19.0487,-72.4702),('e561da07-d8b3-4542-b129-b7a0bf87dc31','Jacki Bateup','jbateup1n@aol.com','7691309905',25.695,115.601),('e651e0a2-de70-4f7b-a27b-3468dd03aa8d','Benedetto Stoven','bstoven1t@ycombinator.com','8893313203',-6.75618,111.299),('e7a0899e-bd54-4302-aba0-a71041c13592','Lesli Allmond','lallmond1c@washingtonpost.com','4389177356',26.2012,105.48),('e82d560a-9c41-445e-ba0c-2844e2bb31ec','Dwain Roath','droathy@hao123.com','3366451850',3.79535,10.1367),('ea79bee5-625a-4c0f-9cd5-deea1aae9c1c','Helenka Gaythor','hgaythor4@alexa.com','8401525474',49.1382,0.231242),('eab52c9b-e886-4c7e-ab91-76c13811bef8','Sondra Donalson','sdonalson7@ycombinator.com','4826334663',31.0927,93.8129),('edcabbf6-0013-472c-ad81-ad7753210332','Sonnnie Kofax','skofax20@alibaba.com','8144061440',12.6115,8.88039),('ee2b5264-fcad-4f49-acf9-7a31f24aad7a','Debi Proud','dproud0@virginia.edu','4055874097',35.4318,-97.4922),('f1553308-eb23-43ec-9ed3-bf31b37aecb9','Ruth Burger','rburger15@com.com','1769913359',31.8917,72.4276),('f5bd6487-218a-458d-a4b0-3d69e09bfd54','Theo Hanhart','thanhart1r@addtoany.com','4892115737',56.1644,12.8833),('f5d99728-32be-432f-9ade-2569a15b3841','Miriam Ellacott','mellacott6@zdnet.com','2586901719',52.6657,36.3693);
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
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

-- Dump completed on 2023-02-17 16:35:27
