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
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `BatchID` varchar(36) NOT NULL,
  `RetailerID` varchar(36) NOT NULL,
  `QuantityRemaining` int NOT NULL,
  KEY `ix_inventory_BatchID` (`BatchID`),
  KEY `ix_inventory_RetailerID` (`RetailerID`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`BatchID`) REFERENCES `batches` (`BatchID`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`RetailerID`) REFERENCES `retailers` (`RetailerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('ee495a42a94b11edac77f889d2839e9e','dd5b1ce4-a3bd-40b3-816a-a36582e88275',87),('ee493352a94b11ed9204f889d2839e9e','37e7d46c-81f2-4e0a-89eb-b018f62c0ff6',46),('ee48e525a94b11ed9901f889d2839e9e','4a273ef8-372a-4f5d-afa9-dd7402088a71',28),('ee48e518a94b11ed8083f889d2839e9e','dfb0b290-e06c-4e10-b09e-4db8d4424c11',71),('ee490c1ea94b11ed9934f889d2839e9e','610ef9bd-646d-4e20-919f-edd30ebe89b7',11),('ee49332ba94b11ed8752f889d2839e9e','e159cba4-95d7-4ea1-bfd8-754d649ccd3d',23),('ee49330fa94b11ed971df889d2839e9e','637ba0de-b24c-4ea9-a6c5-6d144b218b2c',25),('ee48e4cba94b11ed9626f889d2839e9e','4db96527-d748-43fe-b746-bee35d7914b8',16),('ee490c05a94b11ed83bef889d2839e9e','7e3578ad-1a99-461b-9503-7e3eb249b9a2',15),('ee48e500a94b11ed87e0f889d2839e9e','8b199b75-add9-4429-b201-d86f8b8b8422',18),('ee490be7a94b11edb7a4f889d2839e9e','453391a5-4c6c-4382-b826-a48e8dbbc145',6),('ee495a1da94b11edb5aef889d2839e9e','a2f8600f-9054-4d7b-84f6-3c2dbb711130',20),('ee48e511a94b11ed85b0f889d2839e9e','258b7817-cacd-47e1-aa49-c5528d6fbb47',2),('ee495a14a94b11edadc9f889d2839e9e','22dafbe5-0e3f-4963-8b1d-d82a32f53f2c',2),('ee490c25a94b11ed8b75f889d2839e9e','6489d7c1-3d94-4142-8f19-13b0f62be217',12),('ee493318a94b11ed8c96f889d2839e9e','d6c91d2f-e545-4a52-bc56-9e86a3d85383',70),('ee493318a94b11ed8c96f889d2839e9e','976ca389-a417-447d-90fd-2e73b1086ba2',38),('ee490c20a94b11edbdf5f889d2839e9e','c06ecbb2-6953-4daf-9e3c-43bd83fb0cac',28),('ee4932f3a94b11ed87d2f889d2839e9e','9012bbc0-4f5c-4985-8eda-356bce21d15e',2),('ee4932f3a94b11ed87d2f889d2839e9e','f73712c0-b269-4eae-b37c-e1b63a58eddc',5),('ee490be6a94b11ed8b51f889d2839e9e','179f4320-64c4-44e3-825a-c9ea21bf05f5',1),('ee490c4ba94b11ed9dc7f889d2839e9e','8d156d93-3b3f-4338-a5ef-3e109bb4f236',1),('ee4932fda94b11ed865ff889d2839e9e','008dec6d-635d-4326-8cad-ab02d63aa5b4',8),('ee490c4ea94b11ed9701f889d2839e9e','4a05fc72-48da-4714-89ce-1123feba62c1',49),('ee49334da94b11edbf8cf889d2839e9e','59ef19aa-fac7-49f1-adf9-0841fad31054',2),('ee493313a94b11ed826ff889d2839e9e','5aa5f5e0-e63f-4597-8120-38b23e9168ed',46),('ee49332fa94b11ed9c26f889d2839e9e','dc1b68d5-49ba-4be5-9ac3-7026a3156e5b',19),('ee48e4cba94b11ed9626f889d2839e9e','ef928edd-256f-4b03-9ea4-405f9743fcef',31),('ee48e50da94b11ed8e2ef889d2839e9e','aca2dca3-cd2a-4201-a8f5-d9ede5270891',42),('ee490be2a94b11edba62f889d2839e9e','a7f3b05a-56eb-4d00-baa9-d42b25a6a11c',5),('ee490c35a94b11edb4fbf889d2839e9e','dcec857c-089f-48a5-ba49-a4da4eda0932',73),('ee49333da94b11edb879f889d2839e9e','43d40c58-5e09-40c8-bba5-2ec0627e7e8b',27),('ee493318a94b11ed8c96f889d2839e9e','2b31142f-f21d-47be-b140-9002e52000e5',69),('ee493318a94b11ed8c96f889d2839e9e','7f6fc7b3-fcea-4c29-93da-5d33cb606454',22),('ee48e4f6a94b11edbf43f889d2839e9e','524b20da-2d3e-4792-8480-77230ba6e01f',44),('ee49334fa94b11ed9297f889d2839e9e','de598623-80e4-4e92-bd52-faa2e511f3d7',52),('ee48e50da94b11ed8e2ef889d2839e9e','9074dfb3-da9f-4f38-8e0f-f88940989195',69),('ee490c1ea94b11ed9934f889d2839e9e','b322bbe8-c514-4fed-9a40-0f037ba2d217',24),('ee4932fea94b11eda44bf889d2839e9e','867d7b1f-d789-4993-87c8-71aa4226255b',4),('ee495a40a94b11ed8bc1f889d2839e9e','2fcbad7b-e670-4477-bf6b-70d0a21d7bb6',39),('ee493315a94b11eda025f889d2839e9e','670239e1-b919-41de-af45-7a6c43774ee7',6),('ee48e523a94b11ed84aef889d2839e9e','2ced0233-ffd9-4892-a852-9787197f0e22',51),('ee493352a94b11ed9204f889d2839e9e','ace7eaf1-d7b1-468c-9f73-7197d23234a0',21),('ee490bf5a94b11edb882f889d2839e9e','d06296e6-da50-46c5-a4b3-62d26ca57aec',29),('ee48e511a94b11ed85b0f889d2839e9e','fdcc2ca0-8193-435b-8deb-b702e1adadb3',5),('ee48e518a94b11ed8083f889d2839e9e','bf18d1e0-979e-444e-9190-e16fa43cfaa4',8),('ee48e4f6a94b11edbf43f889d2839e9e','b3c09eab-a3c3-45c7-b703-d7c3259ec630',12),('ee490c40a94b11edbc58f889d2839e9e','1ecf0055-99a0-4d46-9d96-f8f030a55002',25),('ee48e518a94b11ed8083f889d2839e9e','38100eaf-aff2-4585-96ad-543c7f1b2d64',30),('ee49330da94b11ed9453f889d2839e9e','fbf1191c-15b9-4bd9-98dc-d9ffe392c568',36),('ee490bf5a94b11edb882f889d2839e9e','88e054ea-ba0a-4744-a79a-8a29b2830696',43),('ee490c25a94b11ed8b75f889d2839e9e','1221cadf-66a5-49af-a2e0-df346ef5b9be',7),('ee493317a94b11eda04df889d2839e9e','dd30dc10-67da-40f4-80b7-3c777f84d993',64),('ee49334fa94b11ed9297f889d2839e9e','d1cf8c2d-8dac-48c3-85e7-45e53d7ed8f4',18),('ee48e4e8a94b11ed87f1f889d2839e9e','ed802459-959a-4a41-b853-c271482168c9',1),('ee48e51da94b11edad8cf889d2839e9e','6d9b3974-dee7-4379-8abf-d08a4262f2ee',20),('ee48e501a94b11edad0bf889d2839e9e','8c41952f-8f72-43dc-ae71-7de160b5ce21',16),('ee490c4ba94b11ed9dc7f889d2839e9e','14476338-65ca-4f11-a1d7-bb59f215a03f',1),('ee495a23a94b11eda17ef889d2839e9e','18f62f19-e11f-42d7-8ad6-65f1cbb6a2e4',47),('ee49331ba94b11ed8400f889d2839e9e','fa5d9a52-fa2c-4893-9c08-42256aa38f7e',54),('ee49330da94b11ed9453f889d2839e9e','d5bd7fc5-5622-49f6-8dc9-0ab4af1b0544',3),('ee490c40a94b11edbc58f889d2839e9e','2b16c3ee-68cd-4a8b-84bc-e014df8e457d',15),('ee495a0aa94b11eda75ff889d2839e9e','d2c1d26f-6637-4acb-a4bc-9d386cfa8933',19),('ee48e51da94b11edad8cf889d2839e9e','3f86bb87-b973-465b-a7bb-78e7759b143d',4),('ee48e4d9a94b11ed9f81f889d2839e9e','75583402-fe4c-4b8e-af76-8d454092fd45',41),('ee4932eda94b11ed953af889d2839e9e','0e317ace-2779-493e-b6a5-d79dac62ca57',22),('ee495a3ea94b11edbaf3f889d2839e9e','d491f642-500f-4950-92b8-2489099c2907',85),('ee490c0ba94b11edb4e4f889d2839e9e','5546fb2c-b73c-40c2-9ad2-ef059159ba64',48),('ee49331ba94b11ed8400f889d2839e9e','f7ee6a9c-fcc8-47cb-a60a-11594fc52a6e',58),('ee48e518a94b11ed8083f889d2839e9e','ff36e41e-6c35-4987-8525-b41e0119230b',67),('ee48e523a94b11ed84aef889d2839e9e','dc5def82-d4f1-4ca5-a9ea-df9cbcdf9d5e',54),('ee490c0aa94b11ed8a9df889d2839e9e','e21f8241-5848-41d2-afa6-8007c32d048a',69),('ee48e530a94b11edb386f889d2839e9e','5073d41b-e4eb-4da4-983f-86ad05ffca14',7),('ee490c43a94b11edab15f889d2839e9e','2313d112-432d-4900-947d-bfbc2ec25a62',52),('ee48e52fa94b11edae91f889d2839e9e','14ba921c-83ff-4080-ac2e-49f073ef0244',11),('ee49330fa94b11ed971df889d2839e9e','54ce8c6c-e3fe-488b-8912-0341f540b43d',38),('ee493322a94b11ed9c8ef889d2839e9e','e42b4375-0e87-49a7-9375-092e41ff2ced',80),('ee495a14a94b11edadc9f889d2839e9e','f44656a8-55c1-4715-a52a-f82cc9112902',54),('ee48e525a94b11ed9901f889d2839e9e','ae03d9b1-9786-4bb8-a43d-b02cef54c80f',73),('ee490c4ba94b11ed9dc7f889d2839e9e','85a8deed-3f14-4230-ab7a-4f27e34ba07d',1),('ee493355a94b11ed8167f889d2839e9e','3bc58a49-5515-4227-b495-628fcdeadbb3',14),('ee48e4d9a94b11ed9f81f889d2839e9e','887c5870-3004-40d5-bef0-f4df60521869',65),('ee493355a94b11ed8167f889d2839e9e','c485f924-28d7-4dd7-8a80-e2f8fbf7d1c2',6),('ee4932fea94b11eda44bf889d2839e9e','b612e291-5658-4f80-8767-5e1288334b83',20),('ee493355a94b11ed8167f889d2839e9e','6e365903-4189-42e0-b5bd-c4e571845d86',37),('ee48e530a94b11edb386f889d2839e9e','9f09d58b-b66b-4cf7-b3c5-5e8bcd020b5b',6),('ee495a23a94b11eda17ef889d2839e9e','988a278c-ca14-41cc-a9a3-6537f0a0581b',55),('ee490c38a94b11ed82aff889d2839e9e','aba04d24-6f63-4070-a4b0-ea6cca6737e1',45),('ee4932e7a94b11ed87cbf889d2839e9e','cfe19032-77ef-4583-a92d-516f71981763',46),('ee490bf2a94b11edaa82f889d2839e9e','8fa0b99e-235e-4b65-b440-356e87f4c200',15),('ee49332fa94b11ed9c26f889d2839e9e','f42b883e-e6ba-4c40-943d-e54075c23271',6),('ee490c23a94b11ed990bf889d2839e9e','0ba9a99a-9de9-4649-a47b-693a7983ebcf',17),('ee490bfaa94b11ed88fbf889d2839e9e','449990c2-8fa4-428c-89ca-52762ea2090f',33),('ee49330ca94b11edb9d9f889d2839e9e','e7780305-53dc-4440-94fc-43fb8c07783e',27),('ee48e525a94b11ed9901f889d2839e9e','1e928d69-e8d3-4bdf-908c-e0186962983f',55),('ee490bf2a94b11edaa82f889d2839e9e','4968b65c-adb0-4aae-b24f-180c38b537be',1),('ee493332a94b11ed81fdf889d2839e9e','48e37976-33c3-47bb-a638-296b6193b905',7),('ee490c40a94b11edbc58f889d2839e9e','57f17790-0f63-456d-a7ab-b19a5dbe5a42',4),('ee48e500a94b11ed87e0f889d2839e9e','46229b5f-a221-4e20-816b-c490c802dfe2',17),('ee48e4cba94b11ed9626f889d2839e9e','657f9a58-8291-45ea-8f29-973589982063',28);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
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
