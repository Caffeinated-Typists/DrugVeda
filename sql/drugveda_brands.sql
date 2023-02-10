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
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `BrandID` varchar(36) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Lat` float DEFAULT NULL,
  `Lon` float DEFAULT NULL,
  `ProductCnt` int DEFAULT NULL,
  PRIMARY KEY (`BrandID`),
  KEY `ix_brands_Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES ('024ffa7371eb45aabe55d9c50ec29f02','Clocip','contact@Clocip.com',NULL,NULL,NULL),('04cc7e81d22c4384b72c896ecc895cab','Listerine','support@Listerine.com',NULL,NULL,NULL),('0705812d2ec74033975c1caa3cf537b2','Dhootapapeshwar','contact@Dhootapapeshwar.com',NULL,NULL,NULL),('070d9b8a957b4fc7be8ade26a5010d1f','Evion','help@Evion.com',NULL,NULL,NULL),('07d2dce1511643cc8832c174d9d8a19c','LittleS','contact@LittleS.com',NULL,NULL,NULL),('092d1b6c099641af8468e6d151ff6b49','Revital','help@Revital.com',NULL,NULL,NULL),('0d094aad8e1842cba2493c3534dd150d','JohnsonS','support@JohnsonS.com',NULL,NULL,NULL),('1173879c430940f1a369cc7ea7250d0b','Elovera','help@Elovera.com',NULL,NULL,NULL),('1889f15d4d0d4edba89c1c84bd2bb52a','Pro Pl','help@Pro Pl.com',NULL,NULL,NULL),('1a38ba6577454602947e12c6ed193bf5','Tri-Activ','help@Tri-Activ.com',NULL,NULL,NULL),('1a56f1398dbb47ceb474504719b67143','Duckbill','contact@Duckbill.com',NULL,NULL,NULL),('1b096f8a00524666afe9db309b820982','Abzorb','support@Abzorb.com',NULL,NULL,NULL),('1b22c51527d645108a4e1e81edef7ae7','3 Ply','support@3 Ply.com',NULL,NULL,NULL),('1e91ac3593b54ad393801be11f62bc45','Zandu','support@Zandu.com',NULL,NULL,NULL),('20f0779490eb433096e23d063180b838','Baidyanath','contact@Baidyanath.com',NULL,NULL,NULL),('21d02d7e7052419bb2ad598f39284911','Calcimax','support@Calcimax.com',NULL,NULL,NULL),('251b57af061d4ff9a7bb97dcdfe6b3d6','Savlon','help@Savlon.com',NULL,NULL,NULL),('2541c539730d4c228944db238f5b6191','Dettol','contact@Dettol.com',NULL,NULL,NULL),('299046d32cf04bc3aee6fdd5287d595c','Dr. VaidyaS','contact@Dr. VaidyaS.com',NULL,NULL,NULL),('2aa99410274a4cfd867035bea0146e91','Himalaya','contact@Himalaya.com',NULL,NULL,NULL),('2c4d18d07b1e4a319820b62c8911c177','Everherb','contact@Everherb.com',NULL,NULL,NULL),('2ee0885b4c964b7facc07c577551fb12','Veet','support@Veet.com',NULL,NULL,NULL),('315901ef3d4a4f528a7168e3b8d134b1','Friends','support@Friends.com',NULL,NULL,NULL),('3259311c027e43ad9d5274adc446ba67','Grd','help@Grd.com',NULL,NULL,NULL),('33a713bd8dde4ad29e9fc482743f73dc','Candid','support@Candid.com',NULL,NULL,NULL),('340af2542a9d450a95fe6bc1b83b2aac','Supradyn','support@Supradyn.com',NULL,NULL,NULL),('3556eb127a0e4f699e5e24d83ff0301d','Becozym C Forte','help@Becozym C Forte.com',NULL,NULL,NULL),('3ada4539478141bebfc906a904f3e15b','Coq','support@Coq.com',NULL,NULL,NULL),('3b2c5b8615fb4aa0a05697cb983f6431','Digene','support@Digene.com',NULL,NULL,NULL),('3ba90160fc094026a68287d701fdfe1e','Himalaya Baby','contact@Himalaya Baby.com',NULL,NULL,NULL),('3ece969690fe40a4ae5120a4f8d71c98','Wellbeing Nutrition','help@Wellbeing Nutrition.com',NULL,NULL,NULL),('3ffec4aff8d548adad7204bf32e1b43a','Pampers','contact@Pampers.com',NULL,NULL,NULL),('449b508912ec4ac0b873632a8d1fbed3','Prega News','contact@Prega News.com',NULL,NULL,NULL),('461a1ac70f8e4cac85a8b5e232843d89','Protinex','help@Protinex.com',NULL,NULL,NULL),('47450c695b314b0b869efb2012af2361','Huggies','help@Huggies.com',NULL,NULL,NULL),('48cda97366174345ba0422f9a767697d','Vantej','contact@Vantej.com',NULL,NULL,NULL),('4a3ed5046dd24cd1a7bfb531b22deb26','D Protin','contact@D Protin.com',NULL,NULL,NULL),('506af5e08b8f41caad8013305cce9c22','Fiama','contact@Fiama.com',NULL,NULL,NULL),('529a18a0cefa4b7aa9016ede001e0e42','Kamasutra','help@Kamasutra.com',NULL,NULL,NULL),('5cbc2b46e1a547beba2acce529219311','B4 Nappi','help@B4 Nappi.com',NULL,NULL,NULL),('5f3050e5e9914bb8b438b5aeee4d3165','Cofsils','contact@Cofsils.com',NULL,NULL,NULL),('60323f3e45aa4f2cb7a9237df4cf103c','Prohance','contact@Prohance.com',NULL,NULL,NULL),('68157406f6324e01a4c73e3afcf42b5c','Ensure','help@Ensure.com',NULL,NULL,NULL),('687394b58aed467b890ac870408129f7','Lizol','help@Lizol.com',NULL,NULL,NULL),('6a03eb6ab0d54740b1814268a056c609','Dulcoflex','help@Dulcoflex.com',NULL,NULL,NULL),('6cdc132b3d8f41768969995aa5de0d85','Depiwhite','help@Depiwhite.com',NULL,NULL,NULL),('7064a6d6b35e47af895e9034b31b3a5f','Liveasy','help@Liveasy.com',NULL,NULL,NULL),('7fea6929f64b41f3a5da9f57da21182d','Woodwards','contact@Woodwards.com',NULL,NULL,NULL),('80443f5d14f840ba8db255db7b601411','Volini','contact@Volini.com',NULL,NULL,NULL),('82e788613f644b8a9de52b35300dbe05','Maxirich','help@Maxirich.com',NULL,NULL,NULL),('8a758d2b2a304ea4bdbe270bc18578ae','Lacto Calamine','contact@Lacto Calamine.com',NULL,NULL,NULL),('8d6ca5773f89496286546991ac89eac4','Meril','support@Meril.com',NULL,NULL,NULL),('919f19b4a10a45caa1868684c02e44d4','Sensodyne','support@Sensodyne.com',NULL,NULL,NULL),('93db01a0916e49b5bf83944bb7edec9b','MotherS Horlicks','help@MotherS Horlicks.com',NULL,NULL,NULL),('96fcb6cc77a740ce9e1cef6ddc9db3fb','Gloveon','support@Gloveon.com',NULL,NULL,NULL),('9ed9bebc0a594cf792c679efa3ea1f83','Whisper','support@Whisper.com',NULL,NULL,NULL),('a258e9928577404c9003c2e9d9799eb9','Threptin','contact@Threptin.com',NULL,NULL,NULL),('a2a4bf0df6de493fb994b663e6999d88','B-Protin','contact@B-Protin.com',NULL,NULL,NULL),('ab7b0a2b940e4855bd6b15c0f8a301a8','Pentasure','contact@Pentasure.com',NULL,NULL,NULL),('b93df8402f9f40e38220d71839c151a7','Pharmeasy','contact@Pharmeasy.com',NULL,NULL,NULL),('bb3a925a4e114ec7b68e630a040a5339','Revilus Kz','contact@Revilus Kz.com',NULL,NULL,NULL),('c2d1c543792846da952aca2f14a90463','Episoft','contact@Episoft.com',NULL,NULL,NULL),('c4288f22b9e84297b51f7565357a64b5','Harpic','contact@Harpic.com',NULL,NULL,NULL),('c510b55701924ebe8d25f71e5dd34631','Kapiva','help@Kapiva.com',NULL,NULL,NULL),('d5ca18c2c7314662bc67499628a60076','Depura','help@Depura.com',NULL,NULL,NULL),('d837639e700a4532acd5e1621f4cdcf6','Abide','support@Abide.com',NULL,NULL,NULL),('d8a45375d6ee46019b438319840fd34d','Sebamed','contact@Sebamed.com',NULL,NULL,NULL),('df21f22853264bb0b54992d4eddcf898','I Can','contact@I Can.com',NULL,NULL,NULL),('e045b296481b495489e0e014f5c7a7c2','Sugar Free','contact@Sugar Free.com',NULL,NULL,NULL),('e3c31cce344c4a93bb5c7b97f6b749d7','Dermec Ea','help@Dermec Ea.com',NULL,NULL,NULL),('e450bde252a646308dd273e353ee86e9','Dr Ortho','contact@Dr Ortho.com',NULL,NULL,NULL),('e790493c7b6f484f9118aa7a4aafa768','Durex','contact@Durex.com',NULL,NULL,NULL),('ea4c7d564755434f9edc60414623c022','Amrutanjan','help@Amrutanjan.com',NULL,NULL,NULL),('ed6550a2cf114a51ae3e3e40fd28bc3f','Groviva','help@Groviva.com',NULL,NULL,NULL),('ee912af62b7048b19218b53625dc2e2a','Tetmosol','support@Tetmosol.com',NULL,NULL,NULL),('f03862c777d945ea9341c62a2082f1e1','Luciara','help@Luciara.com',NULL,NULL,NULL),('f1382cffa4584e079cb4de81d568913c','Smw','support@Smw.com',NULL,NULL,NULL),('fcaca2925a394eab8245452e447f63a6','Skore','support@Skore.com',NULL,NULL,NULL);
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 20:08:35
