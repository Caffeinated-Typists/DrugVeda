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
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `SubcategoryID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`SubcategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES ('01c883ff5307429aab834a53190a4fb0','Multivitamins'),('06d70d3e7c55460dbf379bacc3ff1a60','Vitamin'),('0784b9ef9c4649289a4101496baf6b33','Covid Test Kits'),('11ad5f240aee4572894769706c218a25','Facial Masks'),('1acb594426c64db980f3ca295192f47c','Personal Body Massager'),('1e9ee6aeb9394a939106bf8bcecbb938','Disinfectants'),('2169fc55cf7c4ee18108a0f4bedbc6d4','Baby Accessories'),('239d21fe586a42fa95cab5e646d54984','Hand Wash'),('326cb34828344d5bb1c1e3c0ab825f6d','Women Care'),('32728a8fe6f046159bd82c757b996331','Toilet Essentials'),('351853a9a6fa4e0d97b05b29492517b8','Supplements'),('3f4ac2f86c364a91be7c4b37d6226ee0','Liver Care'),('429e85720fa74c35b28f379ab4dcb416','Eye Accessories'),('499023c2abf04fde8277c2f09eb21e8b','Anti Infective'),('4b16051c23c94d628e789e6a5fdc3b36','Performance Booster'),('5452577ff1744f388e6edfb99398e92d','Home Hygiene Essentials'),('5a749bb8e41342158faffd8f0200896b','Diabetic Care'),('5b6312995f894a0192e61483213f69e5','Nutritional Drinks'),('5ca8e306978f4bf8b5e2ed0af3b7745a','Pain Relief'),('5fa245fc52d34b60a80dc6391b5f19da','Hand Sanitizers'),('6a41c814f17f4d0aa570f7113ee17525','Baby Food'),('6c25c18d24a642c68f84573acc690992','Pain Relief Accessories'),('749e645cecf74d6ba0a277467e6ace73','Immunity Boosters'),('753e300115c7486b9acdfdae39d92873','Cold & Cough'),('7c2adddaa6404c25b8909401297c8152','Appliances'),('7f1badf0e43a44cd89a43650550b1acb','Home Hygiene Essentials'),('815f94ae678747e7834dc9c3752e0512','Masks'),('84bda679b32d401a9d4bf52de1843c12','Beverages'),('8e2fedf5f5204015a8b60ec156eec963','Protein Supplements'),('900fc9d7a4af4a4c887ce3389d04bc34','Stomach Care'),('9ec5493553af4f1f8613d3e714c23b35','Health Food'),('9ef8ef8046d34af0aa1f63a7bf8cb77b','Skin Creams & Hair Removal'),('a9d4a45d4e554e66883a302b3923ac0b','Feet Problem'),('ae6d47eb29254338bde79025ad054936','Face Wipes'),('b074ab741ebf4f4e99ff87d474b414f3','Mobility And Support Accessories'),('be6ec22afa5a4da9aa3703d8c42a1e35','Pain Relief'),('bfd205ff8e8247e98529baa56d1b2a92','Urinary Support And Care'),('ceefbba71e804920987f28de2b91e9a1','Skin Care'),('d047ed77f42c429faf80df45c55753cd','Men Care'),('d19a4f01fdac4632bca956e8258fec2d','Mother Wellness'),('d4d64b300aab46fc85f5e56f78e41035','Nutrition Food'),('d4f1cd494d994014817327d481d8a397','Condoms'),('d71243aaf561470bb5bd98e70274322b','Diabetic Care'),('e2818599dc7a4fcbb0edc47a629de114','Kidney Care'),('e3de108f3f22419da8b65148232f99b0','Disinfectants'),('ee8ecd93b49f4024b32ba9797471a67d','Personal Safety Wearables'),('f25136699e1e4d14aad01d1021e58662','Oral Care'),('f401962d0d45479d8caf03ffef409d79','Diabetic & Ortho Footwear'),('f7c7288c35844b5a962014c033ea5f04','Talcum Powder'),('fd0836fca6f54993bd126b3c847285c9','Baby Hygiene');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
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

-- Dump completed on 2023-02-17 16:35:46
