CREATE DATABASE  IF NOT EXISTS `drugveda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `drugveda`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: drugveda
-- ------------------------------------------------------
-- Server version	8.0.32

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

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `SubcategoryID` varchar(36) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Image` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SubcategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES ('06f46852eb0e4a9cb263e78081b3bd8c','Anti Infective',NULL),('0d068da96c1c4a0da1df9803ceadf027','Home Hygiene Essentials',NULL),('1909602a48d7405697515f11cee89486','Talcum Powder',NULL),('1b06594594ca4815b90469e84b0fd939','Skin Care',NULL),('1c65041d686f496884779bbaa94fdacf','Personal Safety Wearables',NULL),('1cf2ec29d31e425c8ff2fdb06c58e8be','Diabetic Care',NULL),('1fcf3243e01f49e3bdaed6aee178586c','Diabetic Care',NULL),('22cb9549e81044d699448fd0b32fd9f7','Men Care',NULL),('297aa3924282472682763d0851d336d3','Skin Creams & Hair Removal',NULL),('2d25086e2624491a955078bb3a34a225','Baby Hygiene',NULL),('2d79dd29b3114d018010594aaa67efb7','Appliances',NULL),('30415dfceeea4cd8bfe3572ada1761e4','Disinfectants',NULL),('368daa7bf0ce46e79595426c2fc30ee7','Pain Relief',NULL),('37b23d27c87f4d2ba735590bb575d1e5','Eye Accessories',NULL),('3b74a6a52a4647bfb0830b9e142159c5','Feet Problem',NULL),('44e43916069641b7bd15a638ccb20b5e','Performance Booster',NULL),('4bf5eb44ad7b46d0957ac686f09b967d','Beverages',NULL),('58e66024b60049728f610da3eaad5443','Mother Wellness',NULL),('59e42d88c3ca4bbc940e7add74f1c54d','Baby Accessories',NULL),('62bb5b27ad2f4cbcacb90f48569c847b','Multivitamins',NULL),('674f4ea2b2b44aef8b58a9f77f174496','Vitamin',NULL),('78c8b6677a0a43cba95923e62f70f6db','Supplements',NULL),('7ab18b062ac74a6d99fadcc424acebdf','Personal Body Massager',NULL),('7dc7dc630f0d452ca8ff0369c95a76c4','Health Food',NULL),('847c31b25f4245289b73db92a24567cc','Face Wipes',NULL),('85951a437c694f48bdecad790896c785','Urinary Support And Care',NULL),('86c23794a8f04fba8d8bd574250d4b45','Baby Food',NULL),('8fa34077cd8f48c9a194add0594cab10','Toilet Essentials',NULL),('96994d00807644a6a2d00ea886f46f82','Nutritional Drinks',NULL),('a0bad4a1aa5e4bafb1edfe93315c0fd4','Hand Sanitizers',NULL),('a5fb81317b584a5290ffb6e3d8abc5cb','Condoms',NULL),('aa8f88366beb4636bba8d0ac1dc66be0','Pain Relief',NULL),('aac2df9ddeb24762beae427610587968','Mobility And Support Accessories',NULL),('ad3cb6e7c720492e8575790cbdc5171f','Oral Care',NULL),('b7d223258b0244cd9214cf5ee18dd712','Stomach Care',NULL),('c7127a5973bc4ea795b153f7d2f7f4e6','Immunity Boosters',NULL),('d5ab3b27c8564654a1c4380ff9f58d80','Nutrition Food',NULL),('d7c3e862281e471d989275787f71cc7c','Home Hygiene Essentials',NULL),('d8a44752cec04e01a284f0f304d60bc7','Protein Supplements',NULL),('dbea4431e2a44a1fb64fd49453e67fcc','Diabetic & Ortho Footwear',NULL),('dd48104fb62c4e56be5b16551db8acb9','Facial Masks',NULL),('e1018d5d16774087bb274d1f0e246668','Masks',NULL),('e1105d2162db4807b3ee9b8bce9a1d8b','Kidney Care',NULL),('e1a7d1eb07d740ed8d3ef530cc801100','Liver Care',NULL),('ea4e6796ade3401d89f71a471eaee9ef','Women Care',NULL),('eb05bc5b94ce48f4bf443da9de5b49f7','Cold & Cough',NULL),('f1911523f42448f698f85ef5db37fea8','Pain Relief Accessories',NULL),('f22337fbf1854280925d11a1e35978c4','Covid Test Kits',NULL),('f4d1cbe74f7346d4a7923a33ee631407','Disinfectants',NULL),('fc72e97c2a474d3b859573c046412467','Hand Wash',NULL);
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 20:08:38
