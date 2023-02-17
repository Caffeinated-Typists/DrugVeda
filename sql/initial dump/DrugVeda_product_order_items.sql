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
-- Table structure for table `product_order_items`
--

DROP TABLE IF EXISTS `product_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_order_items` (
  `OrderID` varchar(36) NOT NULL,
  `ProductID` varchar(36) NOT NULL,
  `CustomerID` varchar(36) NOT NULL,
  `RetailerID` varchar(36) NOT NULL,
  `Quantity` int NOT NULL,
  `Amount` float NOT NULL,
  PRIMARY KEY (`OrderID`,`ProductID`,`CustomerID`,`RetailerID`),
  KEY `idx_product_order_items_retailerid` (`RetailerID`),
  KEY `idx_product_order_items_orderid` (`OrderID`),
  KEY `idx_product_order_items_productid` (`ProductID`),
  KEY `idx_product_order_items_customerid` (`CustomerID`),
  CONSTRAINT `fk_product_order_items_customerid` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_order_items_orderid` FOREIGN KEY (`OrderID`) REFERENCES `product_orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_order_items_productid` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_order_items_retailerid` FOREIGN KEY (`RetailerID`) REFERENCES `retailers` (`RetailerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_order_items`
--

LOCK TABLES `product_order_items` WRITE;
/*!40000 ALTER TABLE `product_order_items` DISABLE KEYS */;
INSERT INTO `product_order_items` VALUES ('46cf95aaaea211ed97e2f889d2839e9e','9e082a1ba91711edbe71f889d2839e9e','ed9b3a9d-c429-44db-8d31-e77649aacbbb','dc5def82-d4f1-4ca5-a9ea-df9cbcdf9d5e',6,1618.2),('46cf95abaea211ed8929f889d2839e9e','9e082a15a91711ed82b2f889d2839e9e','c0fbc039-776f-4de6-9702-c8864a89c389','258b7817-cacd-47e1-aa49-c5528d6fbb47',9,209.61),('46cf95acaea211ed988bf889d2839e9e','9e0829c1a91711edac61f889d2839e9e','6cf3df38-075a-49b4-b592-f7791bd8b82f','887c5870-3004-40d5-bef0-f4df60521869',10,3245),('46cf95adaea211ed972bf889d2839e9e','9e082979a91711edbcebf889d2839e9e','876c3479-5ce2-4d1b-b460-be758b24a494','59ef19aa-fac7-49f1-adf9-0841fad31054',9,1103.94),('46cf95aeaea211edaa31f889d2839e9e','9e0850c0a91711ed85e3f889d2839e9e','b14e236c-71bf-4187-abb8-feab31edd98b','ace7eaf1-d7b1-468c-9f73-7197d23234a0',9,1300.5),('46cf95afaea211ed87dff889d2839e9e','9e0850b9a91711ed92b3f889d2839e9e','75b17e2a-8de7-4372-8292-74771031d292','008dec6d-635d-4326-8cad-ab02d63aa5b4',8,2252.8),('46cf95b0aea211ed8790f889d2839e9e','9e082982a91711ed80d2f889d2839e9e','c0fbc039-776f-4de6-9702-c8864a89c389','dd5b1ce4-a3bd-40b3-816a-a36582e88275',5,585.75),('46cf95b1aea211eda4f6f889d2839e9e','9e0850c3a91711ed8fe8f889d2839e9e','399501aa-3179-468d-9887-a5354d873c0b','d06296e6-da50-46c5-a4b3-62d26ca57aec',9,405),('46cf95b2aea211ed9e2ff889d2839e9e','9e0829bfa91711eda87cf889d2839e9e','c37b395a-31ec-4488-9700-4ae4984f90c2','4a273ef8-372a-4f5d-afa9-dd7402088a71',4,1615),('46cf95b3aea211ed87eef889d2839e9e','9e082989a91711eda7a5f889d2839e9e','9272714d-5d2d-4d54-a120-67cad04b4317','37e7d46c-81f2-4e0a-89eb-b018f62c0ff6',4,858.48),('46cf95b4aea211eda1ddf889d2839e9e','9e082a2ea91711ed8349f889d2839e9e','b6d07418-4df2-42d9-80bb-a5d04b691df9','dc5def82-d4f1-4ca5-a9ea-df9cbcdf9d5e',6,1122.36),('46cf95b5aea211ed9d49f889d2839e9e','9e0829a1a91711ed8ac1f889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','5546fb2c-b73c-40c2-9ad2-ef059159ba64',8,1881.6),('46cf95b6aea211ed9059f889d2839e9e','9e082a09a91711eda6e0f889d2839e9e','399501aa-3179-468d-9887-a5354d873c0b','008dec6d-635d-4326-8cad-ab02d63aa5b4',6,2156.4),('46cf95b7aea211edb043f889d2839e9e','9e085097a91711edbac5f889d2839e9e','63fe0f2a-ec93-4d17-a4b4-2752bee9d8f2','7e3578ad-1a99-461b-9503-7e3eb249b9a2',6,1795.8),('46cf95b8aea211edb47bf889d2839e9e','9e082a0fa91711edb617f889d2839e9e','8c45fd11-e3a0-47cd-944f-3bd10f589fab','4a05fc72-48da-4714-89ce-1123feba62c1',9,277.83),('46cf95b9aea211ed8caef889d2839e9e','9e0850d4a91711ed88b3f889d2839e9e','f6d2bce0-8c8f-463e-a356-5001dc008942','3f86bb87-b973-465b-a7bb-78e7759b143d',3,867.3),('46cf95baaea211ed830bf889d2839e9e','9e082990a91711ed85aff889d2839e9e','4a5d8eba-1a3a-4493-a959-327913d6f5f3','8b199b75-add9-4429-b201-d86f8b8b8422',3,1200),('46cf95bbaea211ed9a3ff889d2839e9e','9e082a02a91711edbc09f889d2839e9e','9fce7f49-7a5a-4087-bc4a-066876a02a45','14476338-65ca-4f11-a1d7-bb59f215a03f',6,296.46),('46cf95bcaea211edac28f889d2839e9e','9e08508ca91711ed94c4f889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','179f4320-64c4-44e3-825a-c9ea21bf05f5',1,232.75),('46cf95bdaea211edaf81f889d2839e9e','9e08297ba91711ed9ae8f889d2839e9e','0c88bc4f-004a-48de-95f5-0e1614915cb3','aca2dca3-cd2a-4201-a8f5-d9ede5270891',7,1322.65),('46cf95beaea211edb8adf889d2839e9e','9e0829d6a91711ed986ef889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','976ca389-a417-447d-90fd-2e73b1086ba2',4,679.36),('46cf95bfaea211ed8080f889d2839e9e','9e0829d0a91711ed93adf889d2839e9e','f76f4387-e502-4e09-8769-65df141855d0','988a278c-ca14-41cc-a9a3-6537f0a0581b',3,367.98),('46cf95c0aea211eda779f889d2839e9e','9e082a0ea91711edbffaf889d2839e9e','2bb71941-a208-479b-9d55-1e63946e8689','f44656a8-55c1-4715-a52a-f82cc9112902',6,1618.2),('46cf95c1aea211eda883f889d2839e9e','9e082a1fa91711eda7b4f889d2839e9e','16efcf89-cc4f-49b7-961b-36e565ae5300','aba04d24-6f63-4070-a4b0-ea6cca6737e1',6,1989),('46cf95c2aea211edad9df889d2839e9e','9e08298ba91711eda7ebf889d2839e9e','6c443ebf-f828-43ed-b221-51ccf040ac98','cfe19032-77ef-4583-a92d-516f71981763',7,560.28),('46cf95c3aea211eda1caf889d2839e9e','9e082a02a91711edbc09f889d2839e9e','e23227d2-5b3d-4fac-81e1-c1b133b3a6c2','657f9a58-8291-45ea-8f29-973589982063',2,98.82),('46cf95c4aea211eda607f889d2839e9e','9e082a2aa91711eda14ef889d2839e9e','7e3d8d47-adc5-4436-8e4e-8ea31e21d946','670239e1-b919-41de-af45-7a6c43774ee7',1,302.4),('46cf95c5aea211ed949ff889d2839e9e','9e082988a91711ed89a3f889d2839e9e','7e3d8d47-adc5-4436-8e4e-8ea31e21d946','14476338-65ca-4f11-a1d7-bb59f215a03f',7,746.9),('46cf95c6aea211eda084f889d2839e9e','9e0850bea91711eda9c4f889d2839e9e','0c88bc4f-004a-48de-95f5-0e1614915cb3','6489d7c1-3d94-4142-8f19-13b0f62be217',7,299.25),('46cf95c7aea211ed9749f889d2839e9e','9e0829e0a91711edb040f889d2839e9e','e00994fe-ab87-4cce-8334-f1266ef41574','ae03d9b1-9786-4bb8-a43d-b02cef54c80f',3,643.86),('46cf95c8aea211ed9194f889d2839e9e','9e0829b5a91711ed9aaef889d2839e9e','37b01f3e-76c5-40b1-901f-f8a03c1b44c1','43d40c58-5e09-40c8-bba5-2ec0627e7e8b',3,440.73),('46cf95c9aea211ed9037f889d2839e9e','9e0850cfa91711eda7c5f889d2839e9e','b14e236c-71bf-4187-abb8-feab31edd98b','f7ee6a9c-fcc8-47cb-a60a-11594fc52a6e',9,3217.5),('46cf95caaea211ed88edf889d2839e9e','9e0850dda91711edac63f889d2839e9e','01677896-1dba-463b-864d-6b589313adef','8fa0b99e-235e-4b65-b440-356e87f4c200',10,3594),('46cf95cbaea211eda40af889d2839e9e','9e0850afa91711ed9afbf889d2839e9e','a27afdb5-0316-483e-9c19-f28ff1307483','008dec6d-635d-4326-8cad-ab02d63aa5b4',10,3783.5),('46cf95ccaea211edb94af889d2839e9e','9e082a09a91711eda6e0f889d2839e9e','1fdb3612-791d-4c10-803c-5d1b6a58080a','2ced0233-ffd9-4892-a852-9787197f0e22',2,718.8),('46cf95cdaea211ed94d7f889d2839e9e','9e0850a3a91711eda4c0f889d2839e9e','6730036f-c20d-4c57-a9b5-ab1a1a3f8b8a','610ef9bd-646d-4e20-919f-edd30ebe89b7',1,11.18),('46cf95ceaea211ed8462f889d2839e9e','9e0829f7a91711edaa77f889d2839e9e','aebee06c-796a-408c-84b1-10077de1dd7f','cfe19032-77ef-4583-a92d-516f71981763',9,2245.32),('46cf95cfaea211edb31ff889d2839e9e','9e0850bca91711edaf5cf889d2839e9e','1d28c7d4-449f-4802-836f-02f36a7433bc','2b16c3ee-68cd-4a8b-84bc-e014df8e457d',5,420.75),('46cf95d0aea211ed830ef889d2839e9e','9e0829fda91711ed989af889d2839e9e','8c45fd11-e3a0-47cd-944f-3bd10f589fab','4968b65c-adb0-4aae-b24f-180c38b537be',1,523.6),('46cf95d1aea211eda20af889d2839e9e','9e085088a91711edb5b6f889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','4a05fc72-48da-4714-89ce-1123feba62c1',5,510),('46cf95d2aea211ed8038f889d2839e9e','9e082a26a91711ed9bc1f889d2839e9e','50651218-196c-4962-95e5-29048bb0ddb6','5546fb2c-b73c-40c2-9ad2-ef059159ba64',7,1783.6),('46cfbcbbaea211edb300f889d2839e9e','9e0829eda91711edba7cf889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','2b31142f-f21d-47be-b140-9002e52000e5',3,862.08),('46cfbcbcaea211ed8045f889d2839e9e','9e082991a91711ed8a45f889d2839e9e','2837fa17-8a8f-4d15-b179-cf8b282f490d','fdcc2ca0-8193-435b-8deb-b702e1adadb3',8,196),('46cfbcbdaea211ed9d75f889d2839e9e','9e0850b2a91711ed8d66f889d2839e9e','9fce7f49-7a5a-4087-bc4a-066876a02a45','7f6fc7b3-fcea-4c29-93da-5d33cb606454',3,498.75),('46cfbcbeaea211edb818f889d2839e9e','9e0829b5a91711ed9aaef889d2839e9e','3252391e-9f74-40b1-bb91-2aab4f6ca300','524b20da-2d3e-4792-8480-77230ba6e01f',10,1469.1),('46cfbcbfaea211ed87b6f889d2839e9e','9e085092a91711ed9439f889d2839e9e','0cd76e24-6225-4a29-bdd3-f34ecd54d961','6489d7c1-3d94-4142-8f19-13b0f62be217',10,1958),('46cfbcc0aea211ed8d19f889d2839e9e','9e0829fea91711ed946df889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','fa5d9a52-fa2c-4893-9c08-42256aa38f7e',4,2552),('46cfbcc1aea211eda011f889d2839e9e','9e0829bda91711edb741f889d2839e9e','2bee772d-2266-44b1-bee6-f62876daa80a','9f09d58b-b66b-4cf7-b3c5-5e8bcd020b5b',7,7695.8),('46cfbcc2aea211ed9419f889d2839e9e','9e082a0ba91711ed89adf889d2839e9e','ac380ac5-98c0-42fb-8d96-05bbdbd3a7b1','c485f924-28d7-4dd7-8a80-e2f8fbf7d1c2',7,3180.45),('46cfbcc3aea211ed9203f889d2839e9e','9e085097a91711edbac5f889d2839e9e','d1b20608-f8a2-4b56-aaf6-2426724dba78','fdcc2ca0-8193-435b-8deb-b702e1adadb3',8,2394.4),('46cfbcc4aea211edb110f889d2839e9e','9e08298da91711ed8d47f889d2839e9e','eef1cc86-6c00-41db-a8c0-24fa33de9198','d06296e6-da50-46c5-a4b3-62d26ca57aec',8,546.48),('46cfbcc5aea211edba1cf889d2839e9e','9e0829c4a91711ed9309f889d2839e9e','0a916ea7-c796-46ec-86fa-ba1daa489563','f73712c0-b269-4eae-b37c-e1b63a58eddc',10,3960),('46cfbcc6aea211eda43ef889d2839e9e','9e0850d8a91711edbe4af889d2839e9e','b14e236c-71bf-4187-abb8-feab31edd98b','c06ecbb2-6953-4daf-9e3c-43bd83fb0cac',6,1689.6),('46cfbcc7aea211ed9b10f889d2839e9e','9e0850baa91711ed9439f889d2839e9e','47c53148-240c-40a8-a3ec-da7ab81fa5f6','2ced0233-ffd9-4892-a852-9787197f0e22',4,676.6),('46cfbcc8aea211edadc7f889d2839e9e','9e08298ca91711ed83bdf889d2839e9e','399501aa-3179-468d-9887-a5354d873c0b','aca2dca3-cd2a-4201-a8f5-d9ede5270891',8,649.44),('46cfbcc9aea211edbc30f889d2839e9e','9e082a13a91711ed9f42f889d2839e9e','0a916ea7-c796-46ec-86fa-ba1daa489563','4a273ef8-372a-4f5d-afa9-dd7402088a71',7,607.39),('46cfbccaaea211edace9f889d2839e9e','9e0829e2a91711ed8078f889d2839e9e','399501aa-3179-468d-9887-a5354d873c0b','d5bd7fc5-5622-49f6-8dc9-0ab4af1b0544',9,720.36),('46cfbccbaea211eda143f889d2839e9e','9e082981a91711edbe5ff889d2839e9e','2d664245-521d-4b1b-967d-2066bdd430b9','f7ee6a9c-fcc8-47cb-a60a-11594fc52a6e',7,912.66),('46cfbcccaea211edb0b1f889d2839e9e','9e082a1da91711edb373f889d2839e9e','378ca713-2180-4fce-923d-c51e2ffbe4c5','ed802459-959a-4a41-b853-c271482168c9',4,1904),('46cfbccdaea211edb57ff889d2839e9e','9e08298fa91711ed9363f889d2839e9e','378ca713-2180-4fce-923d-c51e2ffbe4c5','7e3578ad-1a99-461b-9503-7e3eb249b9a2',5,3450),('46cfbcceaea211ed84e2f889d2839e9e','9e082986a91711eda1f4f889d2839e9e','d1b20608-f8a2-4b56-aaf6-2426724dba78','f44656a8-55c1-4715-a52a-f82cc9112902',4,679.36),('46cfbccfaea211edb2c0f889d2839e9e','9e0829eca91711ed852ef889d2839e9e','6fd3b729-76b8-46be-8c8a-84d2a92455d0','0ba9a99a-9de9-4649-a47b-693a7983ebcf',9,1725.57),('46cfbcd0aea211eda098f889d2839e9e','9e0829e4a91711ed8c23f889d2839e9e','05e32ec7-799a-46f0-a446-87ae9446529b','c485f924-28d7-4dd7-8a80-e2f8fbf7d1c2',10,683.1),('46cfbcd1aea211edad91f889d2839e9e','9e0850b4a91711edb201f889d2839e9e','56df632e-1249-4d54-8704-6430cd31b87f','d5bd7fc5-5622-49f6-8dc9-0ab4af1b0544',7,1526.35),('46cfbcd2aea211ed81b1f889d2839e9e','9e082a2da91711edb47ef889d2839e9e','7638d58e-ae93-4778-a78b-b478162d956d','54ce8c6c-e3fe-488b-8912-0341f540b43d',1,217.5),('46cfbcd3aea211eda1c0f889d2839e9e','9e085086a91711ed8217f889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','524b20da-2d3e-4792-8480-77230ba6e01f',8,3041.28),('46cfbcd4aea211ed83b9f889d2839e9e','9e0829b5a91711ed9aaef889d2839e9e','ba694734-1a33-4eaf-94bb-1d64ac07bb1c','a7f3b05a-56eb-4d00-baa9-d42b25a6a11c',5,734.55),('46cfbcd5aea211ed870bf889d2839e9e','9e0850b4a91711edb201f889d2839e9e','75b17e2a-8de7-4372-8292-74771031d292','de598623-80e4-4e92-bd52-faa2e511f3d7',5,1090.25),('46cfbcd6aea211ed9763f889d2839e9e','9e0829d6a91711ed986ef889d2839e9e','ba694734-1a33-4eaf-94bb-1d64ac07bb1c','0ba9a99a-9de9-4649-a47b-693a7983ebcf',4,679.36),('46cfbcd7aea211ed9915f889d2839e9e','9e0829bba91711edb012f889d2839e9e','2837fa17-8a8f-4d15-b179-cf8b282f490d','7e3578ad-1a99-461b-9503-7e3eb249b9a2',9,5382),('46cfbcd8aea211ed8abdf889d2839e9e','9e0850d3a91711ed9f78f889d2839e9e','2f020aa9-e56b-4b3e-b6fc-1ad457f461fb','59ef19aa-fac7-49f1-adf9-0841fad31054',10,1144),('46cfbcd9aea211ed8d05f889d2839e9e','9e0829d4a91711edb307f889d2839e9e','7638d58e-ae93-4778-a78b-b478162d956d','14ba921c-83ff-4080-ac2e-49f073ef0244',10,911.4),('46cfbcdaaea211ed96c4f889d2839e9e','9e0829f1a91711ed9884f889d2839e9e','cd17541d-25d2-476b-ac1d-29fc40edf1ff','867d7b1f-d789-4993-87c8-71aa4226255b',6,3787.26),('46cfbcdbaea211eda89af889d2839e9e','9e082a1ca91711edba6df889d2839e9e','7e3d8d47-adc5-4436-8e4e-8ea31e21d946','48e37976-33c3-47bb-a638-296b6193b905',7,2095.8),('46cfbcdcaea211eda25ff889d2839e9e','9e082a32a91711edbef2f889d2839e9e','50651218-196c-4962-95e5-29048bb0ddb6','1221cadf-66a5-49af-a2e0-df346ef5b9be',6,1411.2),('46cfbcddaea211edade2f889d2839e9e','9e0829d5a91711edbc53f889d2839e9e','c0fbc039-776f-4de6-9702-c8864a89c389','6d9b3974-dee7-4379-8abf-d08a4262f2ee',4,1282.52),('46cfbcdeaea211edb6dbf889d2839e9e','9e0850d8a91711edbe4af889d2839e9e','61783acf-877c-4b38-a3da-27a9520d7a13','637ba0de-b24c-4ea9-a6c5-6d144b218b2c',10,2816),('46cfbcdfaea211edb140f889d2839e9e','9e0829c2a91711edaa0ff889d2839e9e','f5b5a72c-d591-4780-966d-69d2d81f4770','6e365903-4189-42e0-b5bd-c4e571845d86',4,1615),('46cfbce0aea211edb49bf889d2839e9e','9e0829dda91711edba68f889d2839e9e','8da901d0-4622-4d40-942f-72fb70cd0506','fdcc2ca0-8193-435b-8deb-b702e1adadb3',7,1188.88),('46cfbce1aea211eda4d2f889d2839e9e','9e082988a91711ed89a3f889d2839e9e','6647a9af-3955-4411-9836-36166c259660','6e365903-4189-42e0-b5bd-c4e571845d86',5,533.5),('46cfbce2aea211ed8924f889d2839e9e','9e082994a91711edbca1f889d2839e9e','a5857966-3c13-4395-8c1f-4313b727eef1','258b7817-cacd-47e1-aa49-c5528d6fbb47',4,368.28),('46cfbce3aea211ed81c1f889d2839e9e','9e08299fa91711ed8480f889d2839e9e','755a46b2-6609-4e06-abb5-0f755d064985','1e928d69-e8d3-4bdf-908c-e0186962983f',10,3230),('46cfbce4aea211ed8899f889d2839e9e','9e085085a91711edab0af889d2839e9e','5777482e-6f81-4e81-8fdc-e16e542b2d47','f44656a8-55c1-4715-a52a-f82cc9112902',7,1646.4),('46cfbce5aea211edbd1ef889d2839e9e','9e0829a3a91711ed8ccdf889d2839e9e','7638d58e-ae93-4778-a78b-b478162d956d','c485f924-28d7-4dd7-8a80-e2f8fbf7d1c2',6,1797),('46cfbce6aea211ed9457f889d2839e9e','9e085091a91711edaf57f889d2839e9e','e00994fe-ab87-4cce-8334-f1266ef41574','8d156d93-3b3f-4338-a5ef-3e109bb4f236',8,1319.2),('46cfbce7aea211ed8e14f889d2839e9e','9e082a0aa91711ed8d72f889d2839e9e','430a8766-75fb-414b-af17-3e14be9d303a','46229b5f-a221-4e20-816b-c490c802dfe2',1,484),('46cfbce8aea211ed9c2cf889d2839e9e','9e08508da91711edae33f889d2839e9e','5bc1aab2-7348-4b4b-82fd-75a9a6109066','4a05fc72-48da-4714-89ce-1123feba62c1',3,306),('46cfbce9aea211ed80a6f889d2839e9e','9e0829d9a91711eda5f2f889d2839e9e','f6d2bce0-8c8f-463e-a356-5001dc008942','de598623-80e4-4e92-bd52-faa2e511f3d7',8,937.2),('46cfbceaaea211ed87acf889d2839e9e','9e0829cda91711edb8f9f889d2839e9e','4069cc95-422b-4d0d-99a5-8f4321846299','ae03d9b1-9786-4bb8-a43d-b02cef54c80f',10,2055),('46cfbcebaea211eda4dcf889d2839e9e','9e085088a91711edb5b6f889d2839e9e','2d664245-521d-4b1b-967d-2066bdd430b9','57f17790-0f63-456d-a7ab-b19a5dbe5a42',2,204),('46cfbcecaea211edb807f889d2839e9e','9e0850c2a91711ed8429f889d2839e9e','9272714d-5d2d-4d54-a120-67cad04b4317','2b16c3ee-68cd-4a8b-84bc-e014df8e457d',7,1075.2),('46cfbcedaea211ed9b2ff889d2839e9e','9e0850e0a91711ed8c90f889d2839e9e','efaa3594-34f1-4fbb-950e-16426c6023ed','f73712c0-b269-4eae-b37c-e1b63a58eddc',4,1677.6),('46cfbceeaea211eda9e6f889d2839e9e','9e082a0aa91711ed8d72f889d2839e9e','1f17ef0f-b7db-48b0-aab7-46df6ef4cdbc','ff36e41e-6c35-4987-8525-b41e0119230b',6,2904),('46cfbcefaea211edaeacf889d2839e9e','9e0829a9a91711edbb23f889d2839e9e','0dca5913-9ee9-4d11-860b-9bddbea4b91c','637ba0de-b24c-4ea9-a6c5-6d144b218b2c',6,752.4),('46cfbcf0aea211ed8f59f889d2839e9e','9e0850c5a91711ed8b0bf889d2839e9e','5777482e-6f81-4e81-8fdc-e16e542b2d47','ace7eaf1-d7b1-468c-9f73-7197d23234a0',3,547.2),('46cfbcf1aea211ed939ff889d2839e9e','9e082a27a91711ed9f6af889d2839e9e','424631e8-58b5-4149-86af-59e709158120','2b16c3ee-68cd-4a8b-84bc-e014df8e457d',3,1053.36),('46cfbcf2aea211ed902df889d2839e9e','9e082a05a91711edad43f889d2839e9e','56df632e-1249-4d54-8704-6430cd31b87f','2b16c3ee-68cd-4a8b-84bc-e014df8e457d',2,755.2),('46cfbcf3aea211edac5cf889d2839e9e','9e0829aea91711edb79bf889d2839e9e','6c443ebf-f828-43ed-b221-51ccf040ac98','ff36e41e-6c35-4987-8525-b41e0119230b',2,958.08),('46cfbcf4aea211edb402f889d2839e9e','9e0829dca91711ed850af889d2839e9e','e0f47414-5096-449b-86f9-f3b5fdc18efd','5073d41b-e4eb-4da4-983f-86ad05ffca14',6,1923.78),('46cfbcf5aea211ed86e0f889d2839e9e','9e0850dba91711ed952af889d2839e9e','ba694734-1a33-4eaf-94bb-1d64ac07bb1c','976ca389-a417-447d-90fd-2e73b1086ba2',10,1351.5);
/*!40000 ALTER TABLE `product_order_items` ENABLE KEYS */;
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

-- Dump completed on 2023-02-17 16:35:43
