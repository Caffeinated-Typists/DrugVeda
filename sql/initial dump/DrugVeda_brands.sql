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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `BrandID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Lat` float DEFAULT NULL,
  `Lon` float DEFAULT NULL,
  `ProductCnt` int DEFAULT NULL,
  PRIMARY KEY (`BrandID`),
  UNIQUE KEY `uq_brands_email` (`Email`),
  KEY `ix_brands_Email` (`Email`),
  KEY `idx_brands_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES ('01207581faf9434892423d6a88b55c22','Smw','support@Smw.com',NULL,NULL,NULL),('0174f5ae2ae24060aa09d449a8c922a3','Zandu','help@Zandu.com',NULL,NULL,NULL),('0370a72b346346fca097203855de4e21','JohnsonS','help@JohnsonS.com',NULL,NULL,NULL),('03e7ddfb126d417cb0a65569d5a20624','Sebamed','help@Sebamed.com',NULL,NULL,NULL),('04101e13cdb34f3396633bfbc61d8a9a','Baidyanath','contact@Baidyanath.com',NULL,NULL,NULL),('06e92b20753d4a04a3669cadab33ada5','Wellbeing Nutrition','contact@Wellbeing Nutrition.com',NULL,NULL,NULL),('09d0f95129ae4eef89da76aa32ea7519','Skore','contact@Skore.com',NULL,NULL,NULL),('0a05f0d9040f4310bd07b8e3b442febe','Harpic','contact@Harpic.com',NULL,NULL,NULL),('0de572069fa44985a109e25e1f91f198','Depura','help@Depura.com',NULL,NULL,NULL),('12a9b46a6ada4838b12ad12ca04ca7ad','I Can','support@I Can.com',NULL,NULL,NULL),('131a8e107a3b4d1fabc6f96b763d0c12','D Protin','help@D Protin.com',NULL,NULL,NULL),('1b5578fcbe914bda8aac20ed74c74ad9','Cofsils','help@Cofsils.com',NULL,NULL,NULL),('1f39f59e360d46da87cb816e2058d904','Abzorb','contact@Abzorb.com',NULL,NULL,NULL),('22529aa7e99a4a568098ef1fbd20944b','Revital','help@Revital.com',NULL,NULL,NULL),('2818de4d2130417ca5544f9e385df735','Veet','support@Veet.com',NULL,NULL,NULL),('3041dcf10d844ad1942b58d1c1bfb733','3 Ply','help@3 Ply.com',NULL,NULL,NULL),('33a122931b284a7194dfb6e6844b62c1','Savlon','contact@Savlon.com',NULL,NULL,NULL),('34badc255d0345a998e2af0a44115e31','Gloveon','support@Gloveon.com',NULL,NULL,NULL),('390facaa12ee4b128a509f8b73eac4e8','Volini','support@Volini.com',NULL,NULL,NULL),('3e4d9257e3094af18391b2d5d8b779bb','Evion','help@Evion.com',NULL,NULL,NULL),('4803252ff27a446badec74ef91d8f8ac','Luciara','help@Luciara.com',NULL,NULL,NULL),('4ba0b0dacdeb4f41be52d4cdd28214f4','Becozym C Forte','contact@Becozym C Forte.com',NULL,NULL,NULL),('516ace95bd2c41f5b0c4c0e65c777845','Calcimax','support@Calcimax.com',NULL,NULL,NULL),('517ae79f68f34436932e6c5d01867256','Dettol','help@Dettol.com',NULL,NULL,NULL),('51896c60090a4ca2b587a1d06a0ad11d','Dulcoflex','contact@Dulcoflex.com',NULL,NULL,NULL),('575023e5af0240dd9e9ef4ee5ee1b7cf','Pro Pl','help@Pro Pl.com',NULL,NULL,NULL),('5b5125470d5a4b5986f65ac1854e9258','Lacto Calamine','contact@Lacto Calamine.com',NULL,NULL,NULL),('5bf3d97c036346b48c8a5c1003ed41bc','Protinex','contact@Protinex.com',NULL,NULL,NULL),('5eb15e84fe7c4bba9e79b1f026a3d4e0','Listerine','help@Listerine.com',NULL,NULL,NULL),('5f749395022644e2abd7cdd6d8e9d00d','Dr Ortho','help@Dr Ortho.com',NULL,NULL,NULL),('6536bd3eb9e84e19a459b99bca39ad05','Amrutanjan','support@Amrutanjan.com',NULL,NULL,NULL),('65ff583e34aa41fd94ec0b31f1fb411d','Everherb','contact@Everherb.com',NULL,NULL,NULL),('69c403da10a8403a972bdd9814d517ed','Sensodyne','support@Sensodyne.com',NULL,NULL,NULL),('6afb6c91e8254c8ea5c301c52f59d577','Candid','help@Candid.com',NULL,NULL,NULL),('6e55dd84d21645f1b837dc244d44bc6a','Lizol','contact@Lizol.com',NULL,NULL,NULL),('6f87971d609d4e4e987f7d958673ff30','Elovera','contact@Elovera.com',NULL,NULL,NULL),('70381db74f3649dea2366579b94cdf38','Abide','contact@Abide.com',NULL,NULL,NULL),('73a0f53d1116463ebe7c937d0c2a2ae6','Durex','support@Durex.com',NULL,NULL,NULL),('76e7e206ebaa45eeb26f966559418700','Maxirich','support@Maxirich.com',NULL,NULL,NULL),('796b164e5ebc422eac3ac99ff5750875','B-Protin','contact@B-Protin.com',NULL,NULL,NULL),('7a2019fbccf04f13abb15dc999511345','Dr. VaidyaS','support@Dr. VaidyaS.com',NULL,NULL,NULL),('7f3163ed5cdb4924a35ea412f6936c4d','Digene','support@Digene.com',NULL,NULL,NULL),('808194ca5d494a6d8770b75a111b3e2a','Tetmosol','contact@Tetmosol.com',NULL,NULL,NULL),('849fb602f241497eb8a4155dc1448834','Prega News','help@Prega News.com',NULL,NULL,NULL),('8917e76d50f54ceaaa85d786bfd73328','Coq','help@Coq.com',NULL,NULL,NULL),('90df37fc74e9420e85b4d7c00ec9e6f5','Groviva','support@Groviva.com',NULL,NULL,NULL),('994491bc76604e9b8c1f1cf69c2da231','Friends','help@Friends.com',NULL,NULL,NULL),('a1732b5c53b2435fb64f1e44336c8613','Liveasy','help@Liveasy.com',NULL,NULL,NULL),('a2265fc57b3e4ab6bd4cd636458ba241','Kapiva','support@Kapiva.com',NULL,NULL,NULL),('a2bd1a74f7fb41bfbe665b910a7ba927','Revilus Kz','contact@Revilus Kz.com',NULL,NULL,NULL),('a8ae32524c7d4535a8859973bc0e76ac','Tri-Activ','help@Tri-Activ.com',NULL,NULL,NULL),('a9e1fb83d964474eb22cc2461db87720','Fiama','contact@Fiama.com',NULL,NULL,NULL),('aeaa73e9c55248acadcf5c883bf3d81f','MotherS Horlicks','support@MotherS Horlicks.com',NULL,NULL,NULL),('b14b7fea65ff4f6f87ba02f27b821a47','Pentasure','contact@Pentasure.com',NULL,NULL,NULL),('b6e290aabe5d4b95b5cc27f50374a555','Dermec Ea','help@Dermec Ea.com',NULL,NULL,NULL),('b807c27f728d498b921c04170cd872fc','Whisper','support@Whisper.com',NULL,NULL,NULL),('bb95820d51e2418db20c7549f37f082a','Threptin','support@Threptin.com',NULL,NULL,NULL),('c341debef9c74d3392b9d21bcf99b20a','B4 Nappi','contact@B4 Nappi.com',NULL,NULL,NULL),('c7866d70b76d465783b6d41b4a616a1c','Sugar Free','contact@Sugar Free.com',NULL,NULL,NULL),('c94893c306e447be9d1e84d8abf3975a','Meril','support@Meril.com',NULL,NULL,NULL),('c9934c6eec824ede90619aec3ee792c7','Duckbill','contact@Duckbill.com',NULL,NULL,NULL),('d03a2e46c8ee46c087c40e4f316fde35','Pampers','contact@Pampers.com',NULL,NULL,NULL),('d0d6b93e1eb641a6bcaa8a6f18466562','Woodwards','support@Woodwards.com',NULL,NULL,NULL),('d78d90d1cd1846788d4ecdb8acb2f47a','Himalaya','contact@Himalaya.com',NULL,NULL,NULL),('d9f631b09a1e4de78d1b3a590139813f','Vantej','help@Vantej.com',NULL,NULL,NULL),('d9f81158fc284176ba190987c5c0e102','Kamasutra','help@Kamasutra.com',NULL,NULL,NULL),('dd291d79d1204586bb2249f45babbbcb','Himalaya Baby','support@Himalaya Baby.com',NULL,NULL,NULL),('dfebf6adba884cf8b7380393348ce33f','Pharmeasy','help@Pharmeasy.com',NULL,NULL,NULL),('e1f98e66ce7a4a21800e2b9e843b322f','Huggies','support@Huggies.com',NULL,NULL,NULL),('e6c9f5eca5d64b5795ee3ce169aa933d','Clocip','contact@Clocip.com',NULL,NULL,NULL),('e995a4ddee7e4833b43f5c807be53b17','Ensure','support@Ensure.com',NULL,NULL,NULL),('f031a38259f644048e57fd8889939f9d','Grd','contact@Grd.com',NULL,NULL,NULL),('f10261e553c144d2a9b284dc8f338b87','Episoft','support@Episoft.com',NULL,NULL,NULL),('f4040a1f2ec4458e8448644a54cf6186','LittleS','support@LittleS.com',NULL,NULL,NULL),('f52c1a48473545fab5f89584d7ce760f','Supradyn','support@Supradyn.com',NULL,NULL,NULL),('f7426abd82264853869265669260a921','Dhootapapeshwar','contact@Dhootapapeshwar.com',NULL,NULL,NULL),('fae46c8c1535408393a304f6ba23702f','Depiwhite','contact@Depiwhite.com',NULL,NULL,NULL),('fe02e4ffe3714039ae77e6329a82aa80','Prohance','support@Prohance.com',NULL,NULL,NULL);
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
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

-- Dump completed on 2023-02-17 16:35:21
