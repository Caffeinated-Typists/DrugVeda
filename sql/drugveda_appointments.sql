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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `AppointmentID` varchar(36) NOT NULL,
  `TestID` varchar(36) NOT NULL,
  `CustomerID` varchar(36) NOT NULL,
  `BookingDate` datetime NOT NULL,
  `AppointmentDate` datetime NOT NULL,
  `Result` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `ix_appointments_TestID` (`TestID`),
  KEY `ix_appointments_CustomerID` (`CustomerID`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`TestID`) REFERENCES `tests` (`TestID`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES ('97610035a93911ed972af889d2839e9e','d9fe734ea93511ed9c94f889d2839e9e','16efcf89-cc4f-49b7-961b-36e565ae5300','2023-02-10 16:53:54','2023-02-18 16:53:54','Completed'),('97610036a93911eda038f889d2839e9e','d9fe734fa93511eda5a3f889d2839e9e','c0fbc039-776f-4de6-9702-c8864a89c389','2023-02-09 11:52:12','2023-02-14 11:52:12','Completed'),('97610037a93911ed9119f889d2839e9e','d9fe7363a93511ed9febf889d2839e9e','e00994fe-ab87-4cce-8334-f1266ef41574','2023-02-11 00:53:53','2023-02-13 00:53:53','Completed'),('97610038a93911edb365f889d2839e9e','d9fe733fa93511ed97d8f889d2839e9e','0cd76e24-6225-4a29-bdd3-f34ecd54d961','2023-03-04 21:50:10','2023-03-09 21:50:10','Completed'),('97610039a93911ed8144f889d2839e9e','d9fe7335a93511eda037f889d2839e9e','80ccf974-456e-4ee6-ae7f-ac092e99a925','2023-02-05 12:55:12','2023-02-15 12:55:12','Scheduled'),('9761003aa93911eda6f3f889d2839e9e','d9fe7364a93511edb310f889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','2023-02-24 22:17:25','2023-03-06 22:17:25','Scheduled'),('9761003ba93911edbd94f889d2839e9e','d9fe7338a93511ed99d6f889d2839e9e','e23227d2-5b3d-4fac-81e1-c1b133b3a6c2','2023-02-14 04:11:43','2023-02-17 04:11:43','Scheduled'),('9761003ca93911edb317f889d2839e9e','d9fe7364a93511edb310f889d2839e9e','2f020aa9-e56b-4b3e-b6fc-1ad457f461fb','2023-02-11 04:41:31','2023-02-12 04:41:31','Scheduled'),('9761003da93911ed8cb9f889d2839e9e','d9fe7333a93511ed9cfaf889d2839e9e','16efcf89-cc4f-49b7-961b-36e565ae5300','2023-03-01 12:38:38','2023-03-03 12:38:38','Completed'),('9761003ea93911edadfef889d2839e9e','d9fe7366a93511eda99df889d2839e9e','6c443ebf-f828-43ed-b221-51ccf040ac98','2023-03-06 13:31:56','2023-03-09 13:31:56','Completed'),('9761003fa93911ed8fe8f889d2839e9e','d9fe7337a93511edaed2f889d2839e9e','dda17c02-0f79-4f22-984b-8ef77247e426','2023-02-04 11:21:59','2023-02-13 11:21:59','Completed'),('97610040a93911edb3c3f889d2839e9e','d9fe7357a93511ed9730f889d2839e9e','c4d56400-3a70-4f10-b6ab-754980ec90f5','2023-02-10 16:10:03','2023-02-12 16:10:03','Completed'),('97610041a93911edb1bbf889d2839e9e','d9fe736ca93511ed989ff889d2839e9e','2bee772d-2266-44b1-bee6-f62876daa80a','2023-02-15 18:32:28','2023-02-17 18:32:28','Completed'),('97610042a93911ed9d37f889d2839e9e','d9fe7372a93511edbf33f889d2839e9e','1e6d5214-1615-4363-8a7d-5e8e4a37c6cb','2023-02-04 20:55:06','2023-02-14 20:55:06','Completed'),('97610043a93911edab20f889d2839e9e','d9fe7339a93511ed8b3ef889d2839e9e','ed9b3a9d-c429-44db-8d31-e77649aacbbb','2023-03-02 16:49:00','2023-03-11 16:49:00','Completed'),('97610044a93911ed9e6cf889d2839e9e','d9fe7339a93511ed8b3ef889d2839e9e','0c88bc4f-004a-48de-95f5-0e1614915cb3','2023-02-24 00:45:28','2023-03-05 00:45:28','Completed'),('97610045a93911eda8a6f889d2839e9e','d9fe735ba93511edad5bf889d2839e9e','63fe0f2a-ec93-4d17-a4b4-2752bee9d8f2','2023-03-04 13:01:56','2023-03-12 13:01:56','Scheduled'),('97610046a93911ed99c1f889d2839e9e','d9fe732ca93511ed885bf889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','2023-02-14 11:41:56','2023-02-22 11:41:56','Completed'),('9761272da93911eda523f889d2839e9e','d9fe734ea93511ed9c94f889d2839e9e','cd17541d-25d2-476b-ac1d-29fc40edf1ff','2023-02-06 06:14:17','2023-02-15 06:14:17','Scheduled'),('9761272ea93911eda919f889d2839e9e','d9fe7376a93511eda58bf889d2839e9e','3e74e425-11c3-46a6-8dea-0d8ee3faab29','2023-02-19 11:07:45','2023-03-01 11:07:45','Completed'),('9761272fa93911ed865ff889d2839e9e','d9fe7348a93511eda9a5f889d2839e9e','ed9b3a9d-c429-44db-8d31-e77649aacbbb','2023-02-16 03:33:23','2023-02-22 03:33:23','Scheduled'),('97612730a93911ed966df889d2839e9e','d9fe7362a93511ed8f4ef889d2839e9e','1fdb3612-791d-4c10-803c-5d1b6a58080a','2023-02-28 06:15:32','2023-03-10 06:15:32','Completed'),('97612731a93911edb5d5f889d2839e9e','d9fe737ca93511eda1dbf889d2839e9e','876c3479-5ce2-4d1b-b460-be758b24a494','2023-02-09 00:21:34','2023-02-19 00:21:34','Scheduled'),('97612732a93911edad07f889d2839e9e','d9fe737ea93511edb8e2f889d2839e9e','8c45fd11-e3a0-47cd-944f-3bd10f589fab','2023-02-26 17:26:59','2023-03-08 17:26:59','Completed'),('97612733a93911edb413f889d2839e9e','d9fe734ca93511ed89f4f889d2839e9e','690eed11-ec59-4a61-bb40-f6deac586e55','2023-02-17 15:00:23','2023-02-24 15:00:23','Scheduled'),('97612734a93911edb128f889d2839e9e','d9fe7346a93511ed8f42f889d2839e9e','f4572d15-9c34-4f34-ae9e-d87671c72463','2023-03-01 00:14:48','2023-03-07 00:14:48','Scheduled'),('97612735a93911ed8fbef889d2839e9e','d9fe7370a93511ed9a2ff889d2839e9e','2bb71941-a208-479b-9d55-1e63946e8689','2023-02-14 14:44:18','2023-02-20 14:44:18','Scheduled'),('97612736a93911edae9ff889d2839e9e','d9fe735da93511ed90c1f889d2839e9e','aebee06c-796a-408c-84b1-10077de1dd7f','2023-02-07 11:18:32','2023-02-15 11:18:32','Completed'),('97612737a93911ed9613f889d2839e9e','d9fe7350a93511edb091f889d2839e9e','cd17541d-25d2-476b-ac1d-29fc40edf1ff','2023-03-10 10:08:33','2023-03-12 10:08:33','Completed'),('97612738a93911edaa72f889d2839e9e','d9fe737ea93511edb8e2f889d2839e9e','c37b395a-31ec-4488-9700-4ae4984f90c2','2023-02-28 03:21:13','2023-03-09 03:21:13','Scheduled'),('97612739a93911edba5ef889d2839e9e','d9fe7345a93511ed85d7f889d2839e9e','430a8766-75fb-414b-af17-3e14be9d303a','2023-02-04 09:16:49','2023-02-13 09:16:49','Scheduled'),('9761273aa93911eda07ef889d2839e9e','d9fe737aa93511ed820ef889d2839e9e','6fd3b729-76b8-46be-8c8a-84d2a92455d0','2023-02-27 01:23:38','2023-03-07 01:23:38','Scheduled'),('9761273ba93911eda3fff889d2839e9e','d9fe7345a93511ed85d7f889d2839e9e','cec064de-55ab-4e9f-a5a3-eda93e23cca5','2023-03-03 11:15:11','2023-03-12 11:15:11','Scheduled'),('9761273ca93911edb35df889d2839e9e','d9fe7338a93511ed99d6f889d2839e9e','6fd3b729-76b8-46be-8c8a-84d2a92455d0','2023-02-13 10:37:26','2023-02-23 10:37:26','Scheduled'),('9761273da93911ed80fcf889d2839e9e','d9fe7343a93511ed8a07f889d2839e9e','5bc1aab2-7348-4b4b-82fd-75a9a6109066','2023-02-16 23:00:44','2023-02-18 23:00:44','Scheduled'),('9761273ea93911ed8639f889d2839e9e','d9fe7379a93511ed87dbf889d2839e9e','6730036f-c20d-4c57-a9b5-ab1a1a3f8b8a','2023-03-04 19:55:23','2023-03-05 19:55:23','Completed'),('9761273fa93911ed9d6df889d2839e9e','d9fe7370a93511ed9a2ff889d2839e9e','6647a9af-3955-4411-9836-36166c259660','2023-03-06 15:06:56','2023-03-07 15:06:56','Scheduled'),('97612740a93911ed9a7cf889d2839e9e','d9fe7361a93511edbb2bf889d2839e9e','0dca5913-9ee9-4d11-860b-9bddbea4b91c','2023-02-10 19:43:50','2023-02-19 19:43:50','Completed'),('97612741a93911ed9cb8f889d2839e9e','d9fe7332a93511ed96dbf889d2839e9e','1fdb3612-791d-4c10-803c-5d1b6a58080a','2023-02-18 16:59:57','2023-02-19 16:59:57','Completed'),('97612742a93911ed8205f889d2839e9e','d9fe7377a93511edb4aff889d2839e9e','56df632e-1249-4d54-8704-6430cd31b87f','2023-02-27 09:55:12','2023-03-04 09:55:12','Completed'),('97612743a93911ed9f1ef889d2839e9e','d9fe7349a93511eda855f889d2839e9e','dda17c02-0f79-4f22-984b-8ef77247e426','2023-02-24 13:27:11','2023-02-25 13:27:11','Scheduled'),('97612744a93911edb140f889d2839e9e','d9fe737fa93511ed9ef0f889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','2023-02-16 10:52:11','2023-02-18 10:52:11','Completed'),('97612745a93911ed9e52f889d2839e9e','d9fe7380a93511ed9f15f889d2839e9e','09d09b6d-9a65-4b62-b256-639cb6288e07','2023-02-18 23:16:43','2023-02-22 23:16:43','Scheduled'),('97612746a93911edb921f889d2839e9e','d9fe734ba93511ed891cf889d2839e9e','4452bdee-7ee4-4f87-a4df-a4ce9ed2475c','2023-03-09 16:56:31','2023-03-10 16:56:31','Scheduled'),('97612747a93911edbc03f889d2839e9e','d9fe7336a93511eda21af889d2839e9e','56df632e-1249-4d54-8704-6430cd31b87f','2023-03-01 13:34:46','2023-03-02 13:34:46','Completed'),('97612748a93911ed9c56f889d2839e9e','d9fe735ba93511edad5bf889d2839e9e','5bc1aab2-7348-4b4b-82fd-75a9a6109066','2023-03-05 18:55:50','2023-03-11 18:55:50','Completed'),('97612749a93911eda7f7f889d2839e9e','d9fe7348a93511eda9a5f889d2839e9e','42b30b4f-5279-4001-8446-1cc7ed5ad2df','2023-02-08 13:40:11','2023-02-11 13:40:11','Completed'),('9761274aa93911edb7f2f889d2839e9e','d9fe7381a93511eda3b2f889d2839e9e','efaa3594-34f1-4fbb-950e-16426c6023ed','2023-03-04 06:07:24','2023-03-10 06:07:24','Completed'),('9761274ba93911ed9ce9f889d2839e9e','d9fe7352a93511edbf56f889d2839e9e','ed9b3a9d-c429-44db-8d31-e77649aacbbb','2023-02-17 19:17:41','2023-02-21 19:17:41','Completed'),('9761274ca93911edbe46f889d2839e9e','d9fe736aa93511edb303f889d2839e9e','70f472d4-f0ba-468c-b19b-3fba1abd1dfe','2023-02-06 02:57:15','2023-02-11 02:57:15','Scheduled'),('9761274da93911ed9202f889d2839e9e','d9fe7381a93511eda3b2f889d2839e9e','73f96971-21cc-421b-a01d-66ce18432a2e','2023-02-09 18:35:49','2023-02-11 18:35:49','Completed'),('9761274ea93911ed9cf3f889d2839e9e','d9fe7367a93511ed9eb3f889d2839e9e','755a46b2-6609-4e06-abb5-0f755d064985','2023-02-19 14:09:32','2023-02-28 14:09:32','Completed'),('9761274fa93911eda6eef889d2839e9e','d9fe7364a93511edb310f889d2839e9e','b0969af0-daf1-4b97-919a-4bba5f9c5ac0','2023-02-04 13:20:46','2023-02-14 13:20:46','Scheduled'),('97612750a93911ed9654f889d2839e9e','d9fe7333a93511ed9cfaf889d2839e9e','1fdb3612-791d-4c10-803c-5d1b6a58080a','2023-02-08 05:51:20','2023-02-18 05:51:20','Completed'),('97612751a93911edb8caf889d2839e9e','d9fe7342a93511edaebff889d2839e9e','424631e8-58b5-4149-86af-59e709158120','2023-02-14 01:45:24','2023-02-20 01:45:24','Completed'),('97612752a93911edb4caf889d2839e9e','d9fe733fa93511ed97d8f889d2839e9e','3ff203c5-42f6-4787-9099-3f2acc3c0e8d','2023-02-06 03:51:52','2023-02-11 03:51:52','Scheduled'),('97612753a93911ed903ff889d2839e9e','d9fe7368a93511edb2eef889d2839e9e','09d09b6d-9a65-4b62-b256-639cb6288e07','2023-02-21 01:45:25','2023-02-22 01:45:25','Completed'),('97612754a93911ed92e4f889d2839e9e','d9fe733ea93511ed8de9f889d2839e9e','876c3479-5ce2-4d1b-b460-be758b24a494','2023-03-08 17:23:58','2023-03-11 17:23:58','Scheduled'),('97612755a93911ed8bdaf889d2839e9e','d9fe7330a93511ed99b0f889d2839e9e','42b30b4f-5279-4001-8446-1cc7ed5ad2df','2023-02-23 12:46:45','2023-03-05 12:46:45','Scheduled'),('97612756a93911edbbc0f889d2839e9e','d9fe735da93511ed90c1f889d2839e9e','a5857966-3c13-4395-8c1f-4313b727eef1','2023-02-14 04:21:46','2023-02-21 04:21:46','Scheduled'),('97612757a93911eda6ccf889d2839e9e','d9fe734ea93511ed9c94f889d2839e9e','3e74e425-11c3-46a6-8dea-0d8ee3faab29','2023-02-13 02:49:19','2023-02-14 02:49:19','Completed'),('97612758a93911ed9c7ef889d2839e9e','d9fe732ca93511ed885bf889d2839e9e','f5b5a72c-d591-4780-966d-69d2d81f4770','2023-03-06 09:34:35','2023-03-07 09:34:35','Completed'),('97612759a93911edb0a3f889d2839e9e','d9fe737ba93511ed9855f889d2839e9e','16efcf89-cc4f-49b7-961b-36e565ae5300','2023-02-27 10:52:18','2023-02-28 10:52:18','Completed'),('9761275aa93911ed9829f889d2839e9e','d9fe7334a93511edbc1df889d2839e9e','3e74e425-11c3-46a6-8dea-0d8ee3faab29','2023-02-26 07:46:45','2023-03-06 07:46:45','Completed'),('9761275ba93911ed9b02f889d2839e9e','d9fe7362a93511ed8f4ef889d2839e9e','c00a74f5-48a7-49bb-8ff7-7797fd3fef2a','2023-02-21 15:23:32','2023-02-28 15:23:32','Completed'),('9761275ca93911ed9f0ef889d2839e9e','d9fe7356a93511eda0fdf889d2839e9e','2bee772d-2266-44b1-bee6-f62876daa80a','2023-02-23 10:38:57','2023-02-24 10:38:57','Scheduled'),('9761275da93911ed96bcf889d2839e9e','d9fe7382a93511ed8eb8f889d2839e9e','1f17ef0f-b7db-48b0-aab7-46df6ef4cdbc','2023-02-27 18:30:45','2023-03-08 18:30:45','Completed'),('9761275ea93911eda9ecf889d2839e9e','d9fe736da93511ed9277f889d2839e9e','01677896-1dba-463b-864d-6b589313adef','2023-02-21 04:11:10','2023-02-25 04:11:10','Scheduled'),('9761275fa93911ed8fdff889d2839e9e','d9fe7380a93511ed9f15f889d2839e9e','554c562f-0c36-4b88-ab07-1cb81f4ff6c3','2023-02-03 11:46:44','2023-02-11 11:46:44','Completed'),('97612760a93911eda1daf889d2839e9e','d9fe7336a93511eda21af889d2839e9e','73f96971-21cc-421b-a01d-66ce18432a2e','2023-02-07 07:41:51','2023-02-17 07:41:51','Completed'),('97612761a93911ed8724f889d2839e9e','d9fe7333a93511ed9cfaf889d2839e9e','cd17541d-25d2-476b-ac1d-29fc40edf1ff','2023-03-04 01:55:30','2023-03-12 01:55:30','Completed'),('97612762a93911ed8ef2f889d2839e9e','d9fe7344a93511ed9e0ef889d2839e9e','c93efa10-a95e-498e-9ca4-97689c5838f1','2023-02-16 02:34:20','2023-02-26 02:34:20','Completed'),('97612763a93911edbc45f889d2839e9e','d9fe7358a93511ed915cf889d2839e9e','378ca713-2180-4fce-923d-c51e2ffbe4c5','2023-02-28 02:18:11','2023-03-04 02:18:11','Scheduled'),('97612764a93911edb9ebf889d2839e9e','d9fe732fa93511ed828ef889d2839e9e','3252391e-9f74-40b1-bb91-2aab4f6ca300','2023-02-08 04:41:42','2023-02-16 04:41:42','Completed'),('97612765a93911ed9362f889d2839e9e','d9fe732da93511ed8444f889d2839e9e','eef1cc86-6c00-41db-a8c0-24fa33de9198','2023-02-10 19:16:26','2023-02-18 19:16:26','Scheduled'),('97612766a93911edb2f2f889d2839e9e','d9fe7363a93511ed9febf889d2839e9e','50651218-196c-4962-95e5-29048bb0ddb6','2023-02-13 23:17:00','2023-02-17 23:17:00','Scheduled'),('97612767a93911ed97e9f889d2839e9e','d9fe735ca93511ed80fcf889d2839e9e','755a46b2-6609-4e06-abb5-0f755d064985','2023-02-15 20:40:57','2023-02-23 20:40:57','Completed'),('97612768a93911edaef8f889d2839e9e','d9fe7351a93511edbe14f889d2839e9e','1e6d5214-1615-4363-8a7d-5e8e4a37c6cb','2023-03-06 23:08:37','2023-03-07 23:08:37','Scheduled'),('97612769a93911eda9faf889d2839e9e','d9fe736ca93511ed989ff889d2839e9e','63fe0f2a-ec93-4d17-a4b4-2752bee9d8f2','2023-02-06 22:42:01','2023-02-16 22:42:01','Scheduled'),('9761276aa93911ed904df889d2839e9e','d9fe736ea93511eda1f3f889d2839e9e','a5857966-3c13-4395-8c1f-4313b727eef1','2023-03-03 16:13:37','2023-03-08 16:13:37','Completed'),('9761276ba93911ed822ff889d2839e9e','d9fe733fa93511ed97d8f889d2839e9e','986b57b0-469f-48df-9ddb-d7dab0cec36e','2023-02-17 17:21:31','2023-02-18 17:21:31','Completed'),('9761276ca93911edb6cdf889d2839e9e','d9fe735aa93511ed9a2ff889d2839e9e','c93efa10-a95e-498e-9ca4-97689c5838f1','2023-02-17 10:58:38','2023-02-18 10:58:38','Completed'),('9761276da93911ed920ff889d2839e9e','d9fe735aa93511ed9a2ff889d2839e9e','5bc1aab2-7348-4b4b-82fd-75a9a6109066','2023-02-28 01:24:20','2023-03-01 01:24:20','Completed'),('9761276ea93911ed83c5f889d2839e9e','d9fe737ba93511ed9855f889d2839e9e','2bb71941-a208-479b-9d55-1e63946e8689','2023-02-24 02:48:58','2023-03-04 02:48:58','Completed'),('9761276fa93911edb677f889d2839e9e','d9fe7339a93511ed8b3ef889d2839e9e','e23227d2-5b3d-4fac-81e1-c1b133b3a6c2','2023-02-27 18:15:44','2023-03-08 18:15:44','Scheduled'),('97614e37a93911eda6bbf889d2839e9e','d9fe7372a93511edbf33f889d2839e9e','5777482e-6f81-4e81-8fdc-e16e542b2d47','2023-02-10 10:45:26','2023-02-18 10:45:26','Scheduled'),('97614e38a93911ed974ff889d2839e9e','d9fe735da93511ed90c1f889d2839e9e','1fdb3612-791d-4c10-803c-5d1b6a58080a','2023-02-19 19:34:19','2023-02-26 19:34:19','Completed'),('97614e39a93911ed93e8f889d2839e9e','d9fe7375a93511eda576f889d2839e9e','0cd76e24-6225-4a29-bdd3-f34ecd54d961','2023-02-28 02:57:08','2023-03-06 02:57:08','Scheduled'),('97614e3aa93911edb44af889d2839e9e','d9fe733ca93511ed8109f889d2839e9e','4452bdee-7ee4-4f87-a4df-a4ce9ed2475c','2023-02-14 23:13:24','2023-02-20 23:13:24','Completed'),('97614e3ba93911ed8e5af889d2839e9e','d9fe7376a93511eda58bf889d2839e9e','f6d2bce0-8c8f-463e-a356-5001dc008942','2023-02-13 08:54:24','2023-02-21 08:54:24','Completed'),('97614e3ca93911edaca8f889d2839e9e','d9fe737ea93511edb8e2f889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','2023-03-01 03:52:00','2023-03-02 03:52:00','Scheduled'),('97614e3da93911ed91ccf889d2839e9e','d9fe7356a93511eda0fdf889d2839e9e','7638fcd6-8a38-40d1-98a3-ba6d4a831732','2023-02-06 15:18:56','2023-02-16 15:18:56','Completed'),('97614e3ea93911ed84ccf889d2839e9e','d9fe737fa93511ed9ef0f889d2839e9e','41fcb96e-de03-4e22-b629-913ea14995da','2023-02-19 16:44:39','2023-02-27 16:44:39','Completed'),('97614e3fa93911edb4dbf889d2839e9e','d9fe733ba93511ed9006f889d2839e9e','09d09b6d-9a65-4b62-b256-639cb6288e07','2023-03-05 17:17:19','2023-03-08 17:17:19','Scheduled'),('97614e40a93911edad85f889d2839e9e','d9fe7339a93511ed8b3ef889d2839e9e','2bee772d-2266-44b1-bee6-f62876daa80a','2023-02-28 04:22:29','2023-03-02 04:22:29','Scheduled'),('97614e41a93911ed8f23f889d2839e9e','d9fe7370a93511ed9a2ff889d2839e9e','7638d58e-ae93-4778-a78b-b478162d956d','2023-02-18 00:07:38','2023-02-20 00:07:38','Scheduled'),('97614e42a93911edbaf8f889d2839e9e','d9fe7376a93511eda58bf889d2839e9e','e00994fe-ab87-4cce-8334-f1266ef41574','2023-03-06 06:44:43','2023-03-08 06:44:43','Scheduled'),('97614e43a93911edbe91f889d2839e9e','d9fe735fa93511ed83b5f889d2839e9e','4171ad87-0690-45b1-855c-f1896c44bee8','2023-03-06 07:37:11','2023-03-07 07:37:11','Completed'),('97614e44a93911eda82bf889d2839e9e','d9fe7355a93511eda97af889d2839e9e','0dca5913-9ee9-4d11-860b-9bddbea4b91c','2023-02-25 11:55:56','2023-02-28 11:55:56','Completed'),('97614e45a93911ed98dff889d2839e9e','d9fe737ea93511edb8e2f889d2839e9e','cd17541d-25d2-476b-ac1d-29fc40edf1ff','2023-02-19 02:58:53','2023-02-20 02:58:53','Completed');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 20:08:37