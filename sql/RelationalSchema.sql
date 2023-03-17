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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'dad3bf71-ab0e-11ed-8ee8-f23c932ad393:1-628';

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
  `Result` varchar(8191) DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `idx_appointments_customerid` (`CustomerID`),
  KEY `idx_appointments_testid` (`TestID`),
  CONSTRAINT `fk_appointments_customerid` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_appointments_testid` FOREIGN KEY (`TestID`) REFERENCES `tests` (`TestID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batches`
--

DROP TABLE IF EXISTS `batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batches` (
  `BatchID` varchar(36) NOT NULL,
  `ProductID` varchar(36) NOT NULL,
  `Quantity` int NOT NULL,
  `ManufactureDate` datetime NOT NULL,
  `RetailerID` varchar(36) NOT NULL,
  `SupplierID` varchar(36) NOT NULL,
  PRIMARY KEY (`BatchID`),
  KEY `idx_batches_productid` (`ProductID`),
  KEY `idx_batches_retailerid` (`RetailerID`),
  KEY `idx_batches_supplierid` (`SupplierID`),
  CONSTRAINT `fk_batches_productid` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_batches_retailerid` FOREIGN KEY (`RetailerID`) REFERENCES `retailers` (`RetailerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_batches_supplierid` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Image` varchar(255) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `BatchID` varchar(36) NOT NULL,
  `RetailerID` varchar(36) NOT NULL,
  `QuantityRemaining` int NOT NULL,
  PRIMARY KEY (`BatchID`,`RetailerID`),
  KEY `idx_inventory_retailerid` (`RetailerID`),
  KEY `idx_inventory_batchid` (`BatchID`),
  CONSTRAINT `fk_inventory_batchid` FOREIGN KEY (`BatchID`) REFERENCES `batches` (`BatchID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_retailerid` FOREIGN KEY (`RetailerID`) REFERENCES `retailers` (`RetailerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `order_batches`
--

DROP TABLE IF EXISTS `order_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_batches` (
  `OrderID` varchar(36) NOT NULL,
  `BatchID` varchar(36) NOT NULL,
  PRIMARY KEY (`OrderID`,`BatchID`),
  KEY `fk_order_batches_batchid` (`BatchID`),
  KEY `idx_order_batches_orderid` (`OrderID`,`BatchID`),
  CONSTRAINT `fk_order_batches_batchid` FOREIGN KEY (`BatchID`) REFERENCES `batches` (`BatchID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_batches_orderid` FOREIGN KEY (`OrderID`) REFERENCES `supply_orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `ProductID` varchar(36) NOT NULL,
  `CategoryID` varchar(36) NOT NULL,
  `SubCategoryID` varchar(36) NOT NULL,
  PRIMARY KEY (`ProductID`,`CategoryID`,`SubCategoryID`),
  KEY `fk_product_categories_categoryid` (`CategoryID`),
  KEY `fk_product_categories_subcategoryid` (`SubCategoryID`),
  KEY `idx_product_categories_productid` (`ProductID`,`CategoryID`,`SubCategoryID`),
  CONSTRAINT `fk_product_categories_categoryid` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_categories_productid` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_categories_subcategoryid` FOREIGN KEY (`SubCategoryID`) REFERENCES `subcategories` (`SubcategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `product_orders`
--

DROP TABLE IF EXISTS `product_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_orders` (
  `OrderID` varchar(36) NOT NULL,
  `CustomerID` varchar(36) NOT NULL,
  `OrderDate` datetime NOT NULL,
  `Quantity` int NOT NULL,
  `Amount` float NOT NULL,
  `Status` enum('Placed','Shipped','Delivered','Cancelled') NOT NULL,
  `DeliveryMethod` enum('Delivery','Pickup') NOT NULL,
  `PaymentMethod` enum('Cash','Credit Card','Debit Card','Net Banking','Paytm','PhonePe','Google Pay','Amazon Pay','UPI') NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `idx_product_orders_status` (`Status`),
  KEY `idx_product_orders_customerid` (`CustomerID`),
  CONSTRAINT `fk_product_orders_customerid` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_suppliers`
--

DROP TABLE IF EXISTS `product_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_suppliers` (
  `ProductID` varchar(36) NOT NULL,
  `SupplierID` varchar(36) NOT NULL,
  PRIMARY KEY (`ProductID`,`SupplierID`),
  KEY `fk_product_suppliers_supplierid` (`SupplierID`),
  KEY `idx_product_suppliers_productid` (`ProductID`,`SupplierID`),
  CONSTRAINT `fk_product_suppliers_productid` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product_suppliers_supplierid` FOREIGN KEY (`SupplierID`) REFERENCES `suppliers` (`SupplierID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Image` varchar(255) NOT NULL,
  `Description` varchar(8191) NOT NULL,
  `Price` float NOT NULL,
  `BrandID` varchar(36) NOT NULL,
  `Rating` float NOT NULL,
  `RatingCnt` int NOT NULL,
  `TimeToExpire` datetime NOT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `idx_products_brandid` (`BrandID`),
  CONSTRAINT `fk_products_brandid` FOREIGN KEY (`BrandID`) REFERENCES `brands` (`BrandID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retailers`
--

DROP TABLE IF EXISTS `retailers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retailers` (
  `RetailerID` varchar(36) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(20) NOT NULL,
  `Lat` float NOT NULL,
  `Lon` float NOT NULL,
  `Manager` varchar(255) NOT NULL,
  PRIMARY KEY (`RetailerID`),
  UNIQUE KEY `uq_retailers_email` (`Email`),
  UNIQUE KEY `uq_retailers_phone` (`Phone`),
  KEY `ix_retailers_Email` (`Email`),
  KEY `idx_retailers_email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `supply_orders`
--

DROP TABLE IF EXISTS `supply_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply_orders` (
  `OrderID` varchar(36) NOT NULL,
  `OrderDate` datetime NOT NULL,
  `Amount` float NOT NULL,
  `Status` enum('Placed','Shipped','Delivered','Cancelled') NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `idx_supply_orders_status` (`Status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `TestID` varchar(36) NOT NULL,
  `Name` varchar(127) NOT NULL,
  `Description` varchar(8191) DEFAULT NULL,
  `Price` float NOT NULL,
  `LabID` varchar(36) NOT NULL,
  PRIMARY KEY (`TestID`),
  KEY `idx_tests_landid` (`LabID`),
  CONSTRAINT `fk_tests_landid` FOREIGN KEY (`LabID`) REFERENCES `medical_labs` (`LabID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-17 16:38:00
