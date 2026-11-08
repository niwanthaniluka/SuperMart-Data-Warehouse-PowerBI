-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: supermart_pos
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Current Database: `supermart_pos`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `supermart_pos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `supermart_pos`;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `record_id` int NOT NULL,
  `action_type` varchar(20) NOT NULL,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `action_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,'sale_items',1,'DELETE','{\"sale_id\": 1, \"quantity\": 2, \"line_total\": 1000.00, \"product_id\": 1}',NULL,'2026-10-28 06:28:32'),(2,'sale_items',2,'DELETE','{\"sale_id\": 1, \"quantity\": 2, \"line_total\": 1400.00, \"product_id\": 2}',NULL,'2026-10-28 06:28:32'),(3,'payments',1,'DELETE','{\"sale_id\": 1, \"amount_paid\": 2400.00, \"payment_method\": \"Cash\"}',NULL,'2026-10-28 06:28:32'),(4,'sales',1,'DELETE','{\"sale_id\": 1, \"branch_id\": 1, \"net_amount\": 2400.00, \"customer_id\": 1, \"sale_status\": \"Completed\"}',NULL,'2026-10-28 06:28:32'),(5,'sales',1,'UPDATE','{\"sale_id\": 1, \"branch_id\": 1, \"sale_date\": \"2026-01-05 10:30:00.000000\", \"net_amount\": 2400.00, \"customer_id\": 1, \"sale_status\": \"Completed\", \"total_amount\": 2500.00, \"discount_amount\": 100.00}','{\"sale_id\": 1, \"branch_id\": 1, \"sale_date\": \"2026-01-05 10:30:00.000000\", \"net_amount\": 2400.00, \"customer_id\": 1, \"sale_status\": \"Refunded\", \"total_amount\": 2500.00, \"discount_amount\": 100.00}','2026-10-28 06:33:41'),(6,'sales',1,'UPDATE','{\"sale_id\": 1, \"branch_id\": 1, \"sale_date\": \"2026-01-05 10:30:00.000000\", \"net_amount\": 2400.00, \"customer_id\": 1, \"sale_status\": \"Refunded\", \"total_amount\": 2500.00, \"discount_amount\": 100.00}','{\"sale_id\": 1, \"branch_id\": 1, \"sale_date\": \"2026-01-05 10:30:00.000000\", \"net_amount\": 2400.00, \"customer_id\": 1, \"sale_status\": \"Completed\", \"total_amount\": 2500.00, \"discount_amount\": 100.00}','2026-10-28 06:34:05');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'SuperMart Colombo','Colombo','Galle Road, Colombo 03','0112345678','2026-10-27 13:55:06'),(2,'SuperMart Kandy','Kandy','Peradeniya Road, Kandy','0812345678','2026-10-27 13:55:06'),(3,'SuperMart Galle','Galle','Main Street, Galle','0912345678','2026-10-27 13:55:06'),(4,'SuperMart Matara','Matara','Anagarika Dharmapala Mawatha, Matara','0412345678','2026-10-27 13:55:06'),(5,'SuperMart Badulla','Badulla','Lower Street, Badulla','0552345678','2026-10-27 13:55:06');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(150) NOT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `registered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Kasun Perera','Male','0771000001','kasun@example.com','Colombo','2026-10-27 13:55:44'),(2,'Nimali Silva','Female','0771000002','nimali@example.com','Kandy','2026-10-27 13:55:44'),(3,'Chamath Fernando','Male','0771000003','chamath@example.com','Galle','2026-10-27 13:55:44'),(4,'Dilani Jayasinghe','Female','0771000004','dilani@example.com','Matara','2026-10-27 13:55:44'),(5,'Ravindu Kumara','Male','0771000005','ravindu@example.com','Badulla','2026-10-27 13:55:44'),(6,'Tharushi Wijesinghe','Female','0771000006','tharushi@example.com','Colombo','2026-10-27 13:55:44'),(7,'Isuru Bandara','Male','0771000007','isuru@example.com','Kandy','2026-10-27 13:55:44'),(8,'Sachini Madushika','Female','0771000008','sachini@example.com','Galle','2026-10-27 13:55:44'),(9,'Dinesh Lakmal','Male','0771000009','dinesh@example.com','Matara','2026-10-27 13:55:44'),(10,'Sanduni Nethmini','Female','0771000010','sanduni@example.com','Badulla','2026-10-27 13:55:44'),(11,'Nuwan Pradeep','Male','0771000011','nuwan@example.com','Colombo','2026-10-27 13:55:44'),(12,'Hiruni Fernando','Female','0771000012','hiruni@example.com','Kandy','2026-10-27 13:55:44'),(13,'Malith Perera','Male','0771000013','malith@example.com','Galle','2026-10-27 13:55:44'),(14,'Kavindi Silva','Female','0771000014','kavindi@example.com','Matara','2026-10-27 13:55:44'),(15,'Pasindu Dilshan','Male','0771000015','pasindu@example.com','Badulla','2026-10-27 13:55:44'),(16,'Anjali Rathnayake','Female','0771000016','anjali@example.com','Colombo','2026-10-27 13:55:44'),(17,'Sahan Maduranga','Male','0771000017','sahan@example.com','Kandy','2026-10-27 13:55:44'),(18,'Piumi Hansika','Female','0771000018','piumi@example.com','Galle','2026-10-27 13:55:44'),(19,'Thilina Sampath','Male','0771000019','thilina@example.com','Matara','2026-10-27 13:55:44'),(20,'Ayesha Dilrukshi','Female','0771000020','ayesha@example.com','Badulla','2026-10-27 13:55:44');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_payments_backup`
--

DROP TABLE IF EXISTS `deleted_payments_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_payments_backup` (
  `payment_id` int NOT NULL,
  `sale_id` int NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_payments_backup`
--

LOCK TABLES `deleted_payments_backup` WRITE;
/*!40000 ALTER TABLE `deleted_payments_backup` DISABLE KEYS */;
INSERT INTO `deleted_payments_backup` VALUES (1,1,'Cash',2400.00,'2026-01-05 10:35:00','2026-10-28 06:28:32');
/*!40000 ALTER TABLE `deleted_payments_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_sale_items_backup`
--

DROP TABLE IF EXISTS `deleted_sale_items_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_sale_items_backup` (
  `sale_item_id` int NOT NULL,
  `sale_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `line_total` decimal(12,2) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_sale_items_backup`
--

LOCK TABLES `deleted_sale_items_backup` WRITE;
/*!40000 ALTER TABLE `deleted_sale_items_backup` DISABLE KEYS */;
INSERT INTO `deleted_sale_items_backup` VALUES (1,1,1,2,500.00,0.00,1000.00,'2026-10-28 06:28:32'),(2,1,2,2,750.00,100.00,1400.00,'2026-10-28 06:28:32');
/*!40000 ALTER TABLE `deleted_sale_items_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_sales_backup`
--

DROP TABLE IF EXISTS `deleted_sales_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deleted_sales_backup` (
  `sale_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `sale_date` datetime NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `net_amount` decimal(12,2) NOT NULL,
  `sale_status` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_sales_backup`
--

LOCK TABLES `deleted_sales_backup` WRITE;
/*!40000 ALTER TABLE `deleted_sales_backup` DISABLE KEYS */;
INSERT INTO `deleted_sales_backup` VALUES (1,1,1,'2026-01-05 10:30:00',2500.00,100.00,2400.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52','2026-10-28 06:28:32');
/*!40000 ALTER TABLE `deleted_sales_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `sale_id` int NOT NULL,
  `payment_method` enum('Cash','Card','Bank Transfer','Digital Wallet') NOT NULL,
  `amount_paid` decimal(12,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_payments_sale` (`sale_id`),
  CONSTRAINT `fk_payments_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'Cash',2400.00,'2026-01-05 10:35:00'),(2,2,'Card',4000.00,'2026-01-06 11:20:00'),(3,3,'Cash',1800.00,'2026-01-07 12:25:00'),(4,4,'Digital Wallet',3350.00,'2026-01-08 14:15:00'),(5,5,'Card',5000.00,'2026-01-09 15:50:00'),(6,6,'Cash',2600.00,'2026-01-12 09:35:00'),(7,7,'Bank Transfer',5800.00,'2026-01-14 13:25:00'),(8,8,'Card',3200.00,'2026-01-16 16:15:00'),(9,9,'Digital Wallet',4300.00,'2026-01-18 10:05:00'),(10,10,'Cash',2900.00,'2026-01-20 17:35:00'),(11,11,'Card',3700.00,'2026-02-02 10:35:00'),(12,12,'Bank Transfer',5200.00,'2026-02-04 11:50:00'),(13,13,'Cash',2100.00,'2026-02-06 14:25:00'),(14,14,'Digital Wallet',4500.00,'2026-02-08 15:15:00'),(15,15,'Card',6000.00,'2026-02-10 12:45:00'),(16,16,'Cash',3000.00,'2026-02-12 09:25:00'),(17,17,'Card',4700.00,'2026-02-14 16:20:00'),(18,18,'Digital Wallet',3500.00,'2026-02-16 13:55:00'),(19,19,'Bank Transfer',5500.00,'2026-02-18 11:35:00'),(20,20,'Cash',4000.00,'2026-02-20 18:05:00');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_backup_payment_delete` BEFORE DELETE ON `payments` FOR EACH ROW BEGIN
    INSERT INTO deleted_payments_backup (
        payment_id, sale_id, payment_method,
        amount_paid, payment_date
    )
    VALUES (
        OLD.payment_id, OLD.sale_id,
        OLD.payment_method, OLD.amount_paid,
        OLD.payment_date
    );

    INSERT INTO audit_logs (
        table_name, record_id, action_type, old_data
    )
    VALUES (
        'payments',
        OLD.payment_id,
        'DELETE',
        JSON_OBJECT(
            'sale_id', OLD.sale_id,
            'payment_method', OLD.payment_method,
            'amount_paid', OLD.amount_paid
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sale_items`
--

DROP TABLE IF EXISTS `sale_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_items` (
  `sale_item_id` int NOT NULL AUTO_INCREMENT,
  `sale_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) DEFAULT '0.00',
  `line_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`sale_item_id`),
  KEY `fk_sale_items_sale` (`sale_id`),
  CONSTRAINT `fk_sale_items_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_items`
--

LOCK TABLES `sale_items` WRITE;
/*!40000 ALTER TABLE `sale_items` DISABLE KEYS */;
INSERT INTO `sale_items` VALUES (1,1,1,2,500.00,0.00,1000.00),(2,1,2,2,750.00,100.00,1400.00),(3,2,3,2,1200.00,100.00,2300.00),(4,2,4,2,900.00,100.00,1700.00),(5,3,5,2,400.00,0.00,800.00),(6,3,6,2,500.00,0.00,1000.00),(7,4,7,2,1000.00,100.00,1900.00),(8,4,8,2,750.00,50.00,1450.00),(9,5,9,2,1500.00,100.00,2900.00),(10,5,10,2,1100.00,100.00,2100.00),(11,6,1,3,500.00,0.00,1500.00),(12,6,2,2,600.00,100.00,1100.00),(13,7,3,3,1200.00,200.00,3400.00),(14,7,4,3,900.00,300.00,2400.00),(15,8,5,3,400.00,0.00,1200.00),(16,8,6,4,500.00,0.00,2000.00),(17,9,7,3,1000.00,100.00,2900.00),(18,9,8,2,750.00,100.00,1400.00),(19,10,9,1,1500.00,0.00,1500.00),(20,10,10,2,700.00,0.00,1400.00),(21,11,1,3,500.00,100.00,1400.00),(22,11,2,3,800.00,100.00,2300.00),(23,12,3,3,1200.00,100.00,3500.00),(24,12,4,2,900.00,100.00,1700.00),(25,13,5,3,400.00,100.00,1100.00),(26,13,6,2,500.00,0.00,1000.00),(27,14,7,3,1000.00,100.00,2900.00),(28,14,8,2,850.00,100.00,1600.00),(29,15,9,3,1500.00,200.00,4300.00),(30,15,10,2,900.00,100.00,1700.00),(31,16,1,3,500.00,0.00,1500.00),(32,16,2,2,800.00,100.00,1500.00),(33,17,3,3,1200.00,100.00,3500.00),(34,17,4,2,650.00,100.00,1200.00),(35,18,5,5,400.00,100.00,1900.00),(36,18,6,4,400.00,0.00,1600.00),(37,19,7,4,1000.00,200.00,3800.00),(38,19,8,2,900.00,100.00,1700.00),(39,20,9,2,1500.00,100.00,2900.00),(40,20,10,2,600.00,100.00,1100.00);
/*!40000 ALTER TABLE `sale_items` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_backup_sale_item_delete` BEFORE DELETE ON `sale_items` FOR EACH ROW BEGIN
    INSERT INTO deleted_sale_items_backup (
        sale_item_id, sale_id, product_id,
        quantity, unit_price, discount_amount,
        line_total
    )
    VALUES (
        OLD.sale_item_id, OLD.sale_id, OLD.product_id,
        OLD.quantity, OLD.unit_price,
        OLD.discount_amount, OLD.line_total
    );

    INSERT INTO audit_logs (
        table_name, record_id, action_type, old_data
    )
    VALUES (
        'sale_items',
        OLD.sale_item_id,
        'DELETE',
        JSON_OBJECT(
            'sale_id', OLD.sale_id,
            'product_id', OLD.product_id,
            'quantity', OLD.quantity,
            'line_total', OLD.line_total
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `customer_id` int DEFAULT NULL,
  `sale_date` datetime NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) DEFAULT '0.00',
  `net_amount` decimal(12,2) NOT NULL,
  `sale_status` enum('Completed','Cancelled','Refunded') DEFAULT 'Completed',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sale_id`),
  KEY `fk_sales_branch` (`branch_id`),
  KEY `fk_sales_customer` (`customer_id`),
  CONSTRAINT `fk_sales_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`),
  CONSTRAINT `fk_sales_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,1,1,'2026-01-05 10:30:00',2500.00,100.00,2400.00,'Completed','2026-10-27 13:57:52','2026-10-28 06:34:05'),(2,2,2,'2026-01-06 11:15:00',4200.00,200.00,4000.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(3,3,3,'2026-01-07 12:20:00',1800.00,0.00,1800.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(4,4,4,'2026-01-08 14:10:00',3500.00,150.00,3350.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(5,5,5,'2026-01-09 15:45:00',5200.00,200.00,5000.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(6,1,6,'2026-01-12 09:30:00',2700.00,100.00,2600.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(7,2,7,'2026-01-14 13:20:00',6300.00,500.00,5800.00,'Completed','2026-10-27 13:57:52','2026-10-27 14:00:45'),(8,3,8,'2026-01-16 16:10:00',3200.00,0.00,3200.00,'Completed','2026-10-27 13:57:52','2026-10-27 14:00:45'),(9,4,9,'2026-01-18 10:00:00',4500.00,200.00,4300.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(10,5,10,'2026-01-20 17:30:00',2900.00,0.00,2900.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(11,1,11,'2026-02-02 10:30:00',3900.00,200.00,3700.00,'Completed','2026-10-27 13:57:52','2026-10-27 14:00:45'),(12,2,12,'2026-02-04 11:45:00',5400.00,200.00,5200.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(13,3,13,'2026-02-06 14:20:00',2200.00,100.00,2100.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(14,4,14,'2026-02-08 15:10:00',4700.00,200.00,4500.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(15,5,15,'2026-02-10 12:40:00',6300.00,300.00,6000.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(16,1,16,'2026-02-12 09:20:00',3100.00,100.00,3000.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(17,2,17,'2026-02-14 16:15:00',4900.00,200.00,4700.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(18,3,18,'2026-02-16 13:50:00',3600.00,100.00,3500.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(19,4,19,'2026-02-18 11:30:00',5800.00,300.00,5500.00,'Completed','2026-10-27 13:57:52','2026-10-27 13:57:52'),(20,5,20,'2026-02-20 18:00:00',4200.00,200.00,4000.00,'Completed','2026-10-27 13:57:52','2026-10-27 14:00:45');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_sales_update_audit` AFTER UPDATE ON `sales` FOR EACH ROW BEGIN
    INSERT INTO audit_logs (
        table_name,
        record_id,
        action_type,
        old_data,
        new_data
    )
    VALUES (
        'sales',
        NEW.sale_id,
        'UPDATE',

        JSON_OBJECT(
            'sale_id', OLD.sale_id,
            'branch_id', OLD.branch_id,
            'customer_id', OLD.customer_id,
            'sale_date', OLD.sale_date,
            'total_amount', OLD.total_amount,
            'discount_amount', OLD.discount_amount,
            'net_amount', OLD.net_amount,
            'sale_status', OLD.sale_status
        ),

        JSON_OBJECT(
            'sale_id', NEW.sale_id,
            'branch_id', NEW.branch_id,
            'customer_id', NEW.customer_id,
            'sale_date', NEW.sale_date,
            'total_amount', NEW.total_amount,
            'discount_amount', NEW.discount_amount,
            'net_amount', NEW.net_amount,
            'sale_status', NEW.sale_status
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_backup_sale_delete` BEFORE DELETE ON `sales` FOR EACH ROW BEGIN
    INSERT INTO deleted_sales_backup (
        sale_id, branch_id, customer_id,
        sale_date, total_amount, discount_amount,
        net_amount, sale_status, created_at, updated_at
    )
    VALUES (
        OLD.sale_id, OLD.branch_id, OLD.customer_id,
        OLD.sale_date, OLD.total_amount,
        OLD.discount_amount, OLD.net_amount,
        OLD.sale_status, OLD.created_at, OLD.updated_at
    );

    INSERT INTO audit_logs (
        table_name, record_id, action_type, old_data
    )
    VALUES (
        'sales',
        OLD.sale_id,
        'DELETE',
        JSON_OBJECT(
            'sale_id', OLD.sale_id,
            'branch_id', OLD.branch_id,
            'customer_id', OLD.customer_id,
            'net_amount', OLD.net_amount,
            'sale_status', OLD.sale_status
        )
    );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'supermart_pos'
--

--
-- Current Database: `supermart_products`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `supermart_products` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `supermart_products`;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Groceries','Rice, flour and essential food items'),(2,'Beverages','Tea, coffee and soft drinks'),(3,'Dairy Products','Milk, cheese and yoghurt'),(4,'Personal Care','Soap, shampoo and toiletries'),(5,'Household','Cleaning and household products');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) NOT NULL,
  `category_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `unit_cost` decimal(12,2) NOT NULL,
  `selling_price` decimal(12,2) NOT NULL,
  `reorder_level` int DEFAULT '10',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  KEY `fk_product_category` (`category_id`),
  KEY `fk_product_supplier` (`supplier_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_product_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Rice 1kg',1,1,'SuperMart',350.00,550.00,30,1,'2026-10-27 14:14:49','2026-10-28 06:13:44'),(2,'Sugar 1kg',1,1,'SuperMart',450.00,800.00,25,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(3,'Cooking Oil 1L',1,1,'Golden',850.00,1200.00,20,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(4,'Flour 1kg',1,1,'Prima',450.00,900.00,25,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(5,'Milk Packet',3,3,'FreshMilk',250.00,400.00,30,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(6,'Yoghurt Pack',3,3,'FreshDairy',300.00,500.00,30,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(7,'Tea Pack',2,2,'Ceylon Tea',650.00,1000.00,20,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(8,'Coffee Pack',2,2,'Ceylon Coffee',500.00,900.00,20,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(9,'Shampoo Bottle',4,4,'CarePlus',1000.00,1500.00,15,1,'2026-10-27 14:14:49','2026-10-27 14:14:49'),(10,'Detergent Pack',5,5,'CleanHome',600.00,1100.00,20,1,'2026-10-27 14:14:49','2026-10-27 14:14:49');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(150) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Lanka Food Distributors','0112001001','lankafood@example.com','Colombo'),(2,'Ceylon Beverage Suppliers','0112001002','ceylonbeverage@example.com','Colombo'),(3,'Fresh Dairy Lanka','0812001003','freshdairy@example.com','Kandy'),(4,'Care Products Distributors','0912001004','careproducts@example.com','Galle'),(5,'Home Essentials Lanka','0412001005','homeessentials@example.com','Matara');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'supermart_products'
--

--
-- Current Database: `supermart_dw`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `supermart_dw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `supermart_dw`;

--
-- Table structure for table `dim_branch`
--

DROP TABLE IF EXISTS `dim_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_branch` (
  `branch_key` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `city` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`branch_key`),
  UNIQUE KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_branch`
--

LOCK TABLES `dim_branch` WRITE;
/*!40000 ALTER TABLE `dim_branch` DISABLE KEYS */;
INSERT INTO `dim_branch` VALUES (1,1,'SuperMart Colombo','Colombo','Galle Road, Colombo 03'),(2,2,'SuperMart Kandy','Kandy','Peradeniya Road, Kandy'),(3,3,'SuperMart Galle','Galle','Main Street, Galle'),(4,4,'SuperMart Matara','Matara','Anagarika Dharmapala Mawatha, Matara'),(5,5,'SuperMart Badulla','Badulla','Lower Street, Badulla');
/*!40000 ALTER TABLE `dim_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_customer`
--

DROP TABLE IF EXISTS `dim_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_customer` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `customer_name` varchar(150) NOT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `registered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_customer`
--

LOCK TABLES `dim_customer` WRITE;
/*!40000 ALTER TABLE `dim_customer` DISABLE KEYS */;
INSERT INTO `dim_customer` VALUES (1,1,'Kasun Perera','Male','Colombo','2026-10-27 19:25:44'),(2,2,'Nimali Silva','Female','Kandy','2026-10-27 19:25:44'),(3,3,'Chamath Fernando','Male','Galle','2026-10-27 19:25:44'),(4,4,'Dilani Jayasinghe','Female','Matara','2026-10-27 19:25:44'),(5,5,'Ravindu Kumara','Male','Badulla','2026-10-27 19:25:44'),(6,6,'Tharushi Wijesinghe','Female','Colombo','2026-10-27 19:25:44'),(7,7,'Isuru Bandara','Male','Kandy','2026-10-27 19:25:44'),(8,8,'Sachini Madushika','Female','Galle','2026-10-27 19:25:44'),(9,9,'Dinesh Lakmal','Male','Matara','2026-10-27 19:25:44'),(10,10,'Sanduni Nethmini','Female','Badulla','2026-10-27 19:25:44'),(11,11,'Nuwan Pradeep','Male','Colombo','2026-10-27 19:25:44'),(12,12,'Hiruni Fernando','Female','Kandy','2026-10-27 19:25:44'),(13,13,'Malith Perera','Male','Galle','2026-10-27 19:25:44'),(14,14,'Kavindi Silva','Female','Matara','2026-10-27 19:25:44'),(15,15,'Pasindu Dilshan','Male','Badulla','2026-10-27 19:25:44'),(16,16,'Anjali Rathnayake','Female','Colombo','2026-10-27 19:25:44'),(17,17,'Sahan Maduranga','Male','Kandy','2026-10-27 19:25:44'),(18,18,'Piumi Hansika','Female','Galle','2026-10-27 19:25:44'),(19,19,'Thilina Sampath','Male','Matara','2026-10-27 19:25:44'),(20,20,'Ayesha Dilrukshi','Female','Badulla','2026-10-27 19:25:44');
/*!40000 ALTER TABLE `dim_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_date`
--

DROP TABLE IF EXISTS `dim_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_date` (
  `date_key` int NOT NULL,
  `full_date` date NOT NULL,
  `day_number` int NOT NULL,
  `month_number` int NOT NULL,
  `month_name` varchar(20) NOT NULL,
  `quarter_number` int NOT NULL,
  `year_number` int NOT NULL,
  `day_name` varchar(20) NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `full_date` (`full_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_date`
--

LOCK TABLES `dim_date` WRITE;
/*!40000 ALTER TABLE `dim_date` DISABLE KEYS */;
INSERT INTO `dim_date` VALUES (20260101,'2026-01-01',1,1,'January',1,2026,'Thursday'),(20260102,'2026-01-02',2,1,'January',1,2026,'Friday'),(20260103,'2026-01-03',3,1,'January',1,2026,'Saturday'),(20260104,'2026-01-04',4,1,'January',1,2026,'Sunday'),(20260105,'2026-01-05',5,1,'January',1,2026,'Monday'),(20260106,'2026-01-06',6,1,'January',1,2026,'Tuesday'),(20260107,'2026-01-07',7,1,'January',1,2026,'Wednesday'),(20260108,'2026-01-08',8,1,'January',1,2026,'Thursday'),(20260109,'2026-01-09',9,1,'January',1,2026,'Friday'),(20260110,'2026-01-10',10,1,'January',1,2026,'Saturday'),(20260111,'2026-01-11',11,1,'January',1,2026,'Sunday'),(20260112,'2026-01-12',12,1,'January',1,2026,'Monday'),(20260113,'2026-01-13',13,1,'January',1,2026,'Tuesday'),(20260114,'2026-01-14',14,1,'January',1,2026,'Wednesday'),(20260115,'2026-01-15',15,1,'January',1,2026,'Thursday'),(20260116,'2026-01-16',16,1,'January',1,2026,'Friday'),(20260117,'2026-01-17',17,1,'January',1,2026,'Saturday'),(20260118,'2026-01-18',18,1,'January',1,2026,'Sunday'),(20260119,'2026-01-19',19,1,'January',1,2026,'Monday'),(20260120,'2026-01-20',20,1,'January',1,2026,'Tuesday'),(20260121,'2026-01-21',21,1,'January',1,2026,'Wednesday'),(20260122,'2026-01-22',22,1,'January',1,2026,'Thursday'),(20260123,'2026-01-23',23,1,'January',1,2026,'Friday'),(20260124,'2026-01-24',24,1,'January',1,2026,'Saturday'),(20260125,'2026-01-25',25,1,'January',1,2026,'Sunday'),(20260126,'2026-01-26',26,1,'January',1,2026,'Monday'),(20260127,'2026-01-27',27,1,'January',1,2026,'Tuesday'),(20260128,'2026-01-28',28,1,'January',1,2026,'Wednesday'),(20260129,'2026-01-29',29,1,'January',1,2026,'Thursday'),(20260130,'2026-01-30',30,1,'January',1,2026,'Friday'),(20260131,'2026-01-31',31,1,'January',1,2026,'Saturday'),(20260201,'2026-02-01',1,2,'February',1,2026,'Sunday'),(20260202,'2026-02-02',2,2,'February',1,2026,'Monday'),(20260203,'2026-02-03',3,2,'February',1,2026,'Tuesday'),(20260204,'2026-02-04',4,2,'February',1,2026,'Wednesday'),(20260205,'2026-02-05',5,2,'February',1,2026,'Thursday'),(20260206,'2026-02-06',6,2,'February',1,2026,'Friday'),(20260207,'2026-02-07',7,2,'February',1,2026,'Saturday'),(20260208,'2026-02-08',8,2,'February',1,2026,'Sunday'),(20260209,'2026-02-09',9,2,'February',1,2026,'Monday'),(20260210,'2026-02-10',10,2,'February',1,2026,'Tuesday'),(20260211,'2026-02-11',11,2,'February',1,2026,'Wednesday'),(20260212,'2026-02-12',12,2,'February',1,2026,'Thursday'),(20260213,'2026-02-13',13,2,'February',1,2026,'Friday'),(20260214,'2026-02-14',14,2,'February',1,2026,'Saturday'),(20260215,'2026-02-15',15,2,'February',1,2026,'Sunday'),(20260216,'2026-02-16',16,2,'February',1,2026,'Monday'),(20260217,'2026-02-17',17,2,'February',1,2026,'Tuesday'),(20260218,'2026-02-18',18,2,'February',1,2026,'Wednesday'),(20260219,'2026-02-19',19,2,'February',1,2026,'Thursday'),(20260220,'2026-02-20',20,2,'February',1,2026,'Friday'),(20260221,'2026-02-21',21,2,'February',1,2026,'Saturday'),(20260222,'2026-02-22',22,2,'February',1,2026,'Sunday'),(20260223,'2026-02-23',23,2,'February',1,2026,'Monday'),(20260224,'2026-02-24',24,2,'February',1,2026,'Tuesday'),(20260225,'2026-02-25',25,2,'February',1,2026,'Wednesday'),(20260226,'2026-02-26',26,2,'February',1,2026,'Thursday'),(20260227,'2026-02-27',27,2,'February',1,2026,'Friday'),(20260228,'2026-02-28',28,2,'February',1,2026,'Saturday'),(20260301,'2026-03-01',1,3,'March',1,2026,'Sunday'),(20260302,'2026-03-02',2,3,'March',1,2026,'Monday'),(20260303,'2026-03-03',3,3,'March',1,2026,'Tuesday'),(20260304,'2026-03-04',4,3,'March',1,2026,'Wednesday'),(20260305,'2026-03-05',5,3,'March',1,2026,'Thursday'),(20260306,'2026-03-06',6,3,'March',1,2026,'Friday'),(20260307,'2026-03-07',7,3,'March',1,2026,'Saturday'),(20260308,'2026-03-08',8,3,'March',1,2026,'Sunday'),(20260309,'2026-03-09',9,3,'March',1,2026,'Monday'),(20260310,'2026-03-10',10,3,'March',1,2026,'Tuesday'),(20260311,'2026-03-11',11,3,'March',1,2026,'Wednesday'),(20260312,'2026-03-12',12,3,'March',1,2026,'Thursday'),(20260313,'2026-03-13',13,3,'March',1,2026,'Friday'),(20260314,'2026-03-14',14,3,'March',1,2026,'Saturday'),(20260315,'2026-03-15',15,3,'March',1,2026,'Sunday'),(20260316,'2026-03-16',16,3,'March',1,2026,'Monday'),(20260317,'2026-03-17',17,3,'March',1,2026,'Tuesday'),(20260318,'2026-03-18',18,3,'March',1,2026,'Wednesday'),(20260319,'2026-03-19',19,3,'March',1,2026,'Thursday'),(20260320,'2026-03-20',20,3,'March',1,2026,'Friday'),(20260321,'2026-03-21',21,3,'March',1,2026,'Saturday'),(20260322,'2026-03-22',22,3,'March',1,2026,'Sunday'),(20260323,'2026-03-23',23,3,'March',1,2026,'Monday'),(20260324,'2026-03-24',24,3,'March',1,2026,'Tuesday'),(20260325,'2026-03-25',25,3,'March',1,2026,'Wednesday'),(20260326,'2026-03-26',26,3,'March',1,2026,'Thursday'),(20260327,'2026-03-27',27,3,'March',1,2026,'Friday'),(20260328,'2026-03-28',28,3,'March',1,2026,'Saturday'),(20260329,'2026-03-29',29,3,'March',1,2026,'Sunday'),(20260330,'2026-03-30',30,3,'March',1,2026,'Monday'),(20260331,'2026-03-31',31,3,'March',1,2026,'Tuesday'),(20260401,'2026-04-01',1,4,'April',2,2026,'Wednesday'),(20260402,'2026-04-02',2,4,'April',2,2026,'Thursday'),(20260403,'2026-04-03',3,4,'April',2,2026,'Friday'),(20260404,'2026-04-04',4,4,'April',2,2026,'Saturday'),(20260405,'2026-04-05',5,4,'April',2,2026,'Sunday'),(20260406,'2026-04-06',6,4,'April',2,2026,'Monday'),(20260407,'2026-04-07',7,4,'April',2,2026,'Tuesday'),(20260408,'2026-04-08',8,4,'April',2,2026,'Wednesday'),(20260409,'2026-04-09',9,4,'April',2,2026,'Thursday'),(20260410,'2026-04-10',10,4,'April',2,2026,'Friday'),(20260411,'2026-04-11',11,4,'April',2,2026,'Saturday'),(20260412,'2026-04-12',12,4,'April',2,2026,'Sunday'),(20260413,'2026-04-13',13,4,'April',2,2026,'Monday'),(20260414,'2026-04-14',14,4,'April',2,2026,'Tuesday'),(20260415,'2026-04-15',15,4,'April',2,2026,'Wednesday'),(20260416,'2026-04-16',16,4,'April',2,2026,'Thursday'),(20260417,'2026-04-17',17,4,'April',2,2026,'Friday'),(20260418,'2026-04-18',18,4,'April',2,2026,'Saturday'),(20260419,'2026-04-19',19,4,'April',2,2026,'Sunday'),(20260420,'2026-04-20',20,4,'April',2,2026,'Monday'),(20260421,'2026-04-21',21,4,'April',2,2026,'Tuesday'),(20260422,'2026-04-22',22,4,'April',2,2026,'Wednesday'),(20260423,'2026-04-23',23,4,'April',2,2026,'Thursday'),(20260424,'2026-04-24',24,4,'April',2,2026,'Friday'),(20260425,'2026-04-25',25,4,'April',2,2026,'Saturday'),(20260426,'2026-04-26',26,4,'April',2,2026,'Sunday'),(20260427,'2026-04-27',27,4,'April',2,2026,'Monday'),(20260428,'2026-04-28',28,4,'April',2,2026,'Tuesday'),(20260429,'2026-04-29',29,4,'April',2,2026,'Wednesday'),(20260430,'2026-04-30',30,4,'April',2,2026,'Thursday'),(20260501,'2026-05-01',1,5,'May',2,2026,'Friday'),(20260502,'2026-05-02',2,5,'May',2,2026,'Saturday'),(20260503,'2026-05-03',3,5,'May',2,2026,'Sunday'),(20260504,'2026-05-04',4,5,'May',2,2026,'Monday'),(20260505,'2026-05-05',5,5,'May',2,2026,'Tuesday'),(20260506,'2026-05-06',6,5,'May',2,2026,'Wednesday'),(20260507,'2026-05-07',7,5,'May',2,2026,'Thursday'),(20260508,'2026-05-08',8,5,'May',2,2026,'Friday'),(20260509,'2026-05-09',9,5,'May',2,2026,'Saturday'),(20260510,'2026-05-10',10,5,'May',2,2026,'Sunday'),(20260511,'2026-05-11',11,5,'May',2,2026,'Monday'),(20260512,'2026-05-12',12,5,'May',2,2026,'Tuesday'),(20260513,'2026-05-13',13,5,'May',2,2026,'Wednesday'),(20260514,'2026-05-14',14,5,'May',2,2026,'Thursday'),(20260515,'2026-05-15',15,5,'May',2,2026,'Friday'),(20260516,'2026-05-16',16,5,'May',2,2026,'Saturday'),(20260517,'2026-05-17',17,5,'May',2,2026,'Sunday'),(20260518,'2026-05-18',18,5,'May',2,2026,'Monday'),(20260519,'2026-05-19',19,5,'May',2,2026,'Tuesday'),(20260520,'2026-05-20',20,5,'May',2,2026,'Wednesday'),(20260521,'2026-05-21',21,5,'May',2,2026,'Thursday'),(20260522,'2026-05-22',22,5,'May',2,2026,'Friday'),(20260523,'2026-05-23',23,5,'May',2,2026,'Saturday'),(20260524,'2026-05-24',24,5,'May',2,2026,'Sunday'),(20260525,'2026-05-25',25,5,'May',2,2026,'Monday'),(20260526,'2026-05-26',26,5,'May',2,2026,'Tuesday'),(20260527,'2026-05-27',27,5,'May',2,2026,'Wednesday'),(20260528,'2026-05-28',28,5,'May',2,2026,'Thursday'),(20260529,'2026-05-29',29,5,'May',2,2026,'Friday'),(20260530,'2026-05-30',30,5,'May',2,2026,'Saturday'),(20260531,'2026-05-31',31,5,'May',2,2026,'Sunday'),(20260601,'2026-06-01',1,6,'June',2,2026,'Monday'),(20260602,'2026-06-02',2,6,'June',2,2026,'Tuesday'),(20260603,'2026-06-03',3,6,'June',2,2026,'Wednesday'),(20260604,'2026-06-04',4,6,'June',2,2026,'Thursday'),(20260605,'2026-06-05',5,6,'June',2,2026,'Friday'),(20260606,'2026-06-06',6,6,'June',2,2026,'Saturday'),(20260607,'2026-06-07',7,6,'June',2,2026,'Sunday'),(20260608,'2026-06-08',8,6,'June',2,2026,'Monday'),(20260609,'2026-06-09',9,6,'June',2,2026,'Tuesday'),(20260610,'2026-06-10',10,6,'June',2,2026,'Wednesday'),(20260611,'2026-06-11',11,6,'June',2,2026,'Thursday'),(20260612,'2026-06-12',12,6,'June',2,2026,'Friday'),(20260613,'2026-06-13',13,6,'June',2,2026,'Saturday'),(20260614,'2026-06-14',14,6,'June',2,2026,'Sunday'),(20260615,'2026-06-15',15,6,'June',2,2026,'Monday'),(20260616,'2026-06-16',16,6,'June',2,2026,'Tuesday'),(20260617,'2026-06-17',17,6,'June',2,2026,'Wednesday'),(20260618,'2026-06-18',18,6,'June',2,2026,'Thursday'),(20260619,'2026-06-19',19,6,'June',2,2026,'Friday'),(20260620,'2026-06-20',20,6,'June',2,2026,'Saturday'),(20260621,'2026-06-21',21,6,'June',2,2026,'Sunday'),(20260622,'2026-06-22',22,6,'June',2,2026,'Monday'),(20260623,'2026-06-23',23,6,'June',2,2026,'Tuesday'),(20260624,'2026-06-24',24,6,'June',2,2026,'Wednesday'),(20260625,'2026-06-25',25,6,'June',2,2026,'Thursday'),(20260626,'2026-06-26',26,6,'June',2,2026,'Friday'),(20260627,'2026-06-27',27,6,'June',2,2026,'Saturday'),(20260628,'2026-06-28',28,6,'June',2,2026,'Sunday'),(20260629,'2026-06-29',29,6,'June',2,2026,'Monday'),(20260630,'2026-06-30',30,6,'June',2,2026,'Tuesday'),(20260701,'2026-07-01',1,7,'July',3,2026,'Wednesday'),(20260702,'2026-07-02',2,7,'July',3,2026,'Thursday'),(20260703,'2026-07-03',3,7,'July',3,2026,'Friday'),(20260704,'2026-07-04',4,7,'July',3,2026,'Saturday'),(20260705,'2026-07-05',5,7,'July',3,2026,'Sunday'),(20260706,'2026-07-06',6,7,'July',3,2026,'Monday'),(20260707,'2026-07-07',7,7,'July',3,2026,'Tuesday'),(20260708,'2026-07-08',8,7,'July',3,2026,'Wednesday'),(20260709,'2026-07-09',9,7,'July',3,2026,'Thursday'),(20260710,'2026-07-10',10,7,'July',3,2026,'Friday'),(20260711,'2026-07-11',11,7,'July',3,2026,'Saturday'),(20260712,'2026-07-12',12,7,'July',3,2026,'Sunday'),(20260713,'2026-07-13',13,7,'July',3,2026,'Monday'),(20260714,'2026-07-14',14,7,'July',3,2026,'Tuesday'),(20260715,'2026-07-15',15,7,'July',3,2026,'Wednesday'),(20260716,'2026-07-16',16,7,'July',3,2026,'Thursday'),(20260717,'2026-07-17',17,7,'July',3,2026,'Friday'),(20260718,'2026-07-18',18,7,'July',3,2026,'Saturday'),(20260719,'2026-07-19',19,7,'July',3,2026,'Sunday'),(20260720,'2026-07-20',20,7,'July',3,2026,'Monday'),(20260721,'2026-07-21',21,7,'July',3,2026,'Tuesday'),(20260722,'2026-07-22',22,7,'July',3,2026,'Wednesday'),(20260723,'2026-07-23',23,7,'July',3,2026,'Thursday'),(20260724,'2026-07-24',24,7,'July',3,2026,'Friday'),(20260725,'2026-07-25',25,7,'July',3,2026,'Saturday'),(20260726,'2026-07-26',26,7,'July',3,2026,'Sunday'),(20260727,'2026-07-27',27,7,'July',3,2026,'Monday'),(20260728,'2026-07-28',28,7,'July',3,2026,'Tuesday'),(20260729,'2026-07-29',29,7,'July',3,2026,'Wednesday'),(20260730,'2026-07-30',30,7,'July',3,2026,'Thursday'),(20260731,'2026-07-31',31,7,'July',3,2026,'Friday'),(20260801,'2026-08-01',1,8,'August',3,2026,'Saturday'),(20260802,'2026-08-02',2,8,'August',3,2026,'Sunday'),(20260803,'2026-08-03',3,8,'August',3,2026,'Monday'),(20260804,'2026-08-04',4,8,'August',3,2026,'Tuesday'),(20260805,'2026-08-05',5,8,'August',3,2026,'Wednesday'),(20260806,'2026-08-06',6,8,'August',3,2026,'Thursday'),(20260807,'2026-08-07',7,8,'August',3,2026,'Friday'),(20260808,'2026-08-08',8,8,'August',3,2026,'Saturday'),(20260809,'2026-08-09',9,8,'August',3,2026,'Sunday'),(20260810,'2026-08-10',10,8,'August',3,2026,'Monday'),(20260811,'2026-08-11',11,8,'August',3,2026,'Tuesday'),(20260812,'2026-08-12',12,8,'August',3,2026,'Wednesday'),(20260813,'2026-08-13',13,8,'August',3,2026,'Thursday'),(20260814,'2026-08-14',14,8,'August',3,2026,'Friday'),(20260815,'2026-08-15',15,8,'August',3,2026,'Saturday'),(20260816,'2026-08-16',16,8,'August',3,2026,'Sunday'),(20260817,'2026-08-17',17,8,'August',3,2026,'Monday'),(20260818,'2026-08-18',18,8,'August',3,2026,'Tuesday'),(20260819,'2026-08-19',19,8,'August',3,2026,'Wednesday'),(20260820,'2026-08-20',20,8,'August',3,2026,'Thursday'),(20260821,'2026-08-21',21,8,'August',3,2026,'Friday'),(20260822,'2026-08-22',22,8,'August',3,2026,'Saturday'),(20260823,'2026-08-23',23,8,'August',3,2026,'Sunday'),(20260824,'2026-08-24',24,8,'August',3,2026,'Monday'),(20260825,'2026-08-25',25,8,'August',3,2026,'Tuesday'),(20260826,'2026-08-26',26,8,'August',3,2026,'Wednesday'),(20260827,'2026-08-27',27,8,'August',3,2026,'Thursday'),(20260828,'2026-08-28',28,8,'August',3,2026,'Friday'),(20260829,'2026-08-29',29,8,'August',3,2026,'Saturday'),(20260830,'2026-08-30',30,8,'August',3,2026,'Sunday'),(20260831,'2026-08-31',31,8,'August',3,2026,'Monday'),(20260901,'2026-09-01',1,9,'September',3,2026,'Tuesday'),(20260902,'2026-09-02',2,9,'September',3,2026,'Wednesday'),(20260903,'2026-09-03',3,9,'September',3,2026,'Thursday'),(20260904,'2026-09-04',4,9,'September',3,2026,'Friday'),(20260905,'2026-09-05',5,9,'September',3,2026,'Saturday'),(20260906,'2026-09-06',6,9,'September',3,2026,'Sunday'),(20260907,'2026-09-07',7,9,'September',3,2026,'Monday'),(20260908,'2026-09-08',8,9,'September',3,2026,'Tuesday'),(20260909,'2026-09-09',9,9,'September',3,2026,'Wednesday'),(20260910,'2026-09-10',10,9,'September',3,2026,'Thursday'),(20260911,'2026-09-11',11,9,'September',3,2026,'Friday'),(20260912,'2026-09-12',12,9,'September',3,2026,'Saturday'),(20260913,'2026-09-13',13,9,'September',3,2026,'Sunday'),(20260914,'2026-09-14',14,9,'September',3,2026,'Monday'),(20260915,'2026-09-15',15,9,'September',3,2026,'Tuesday'),(20260916,'2026-09-16',16,9,'September',3,2026,'Wednesday'),(20260917,'2026-09-17',17,9,'September',3,2026,'Thursday'),(20260918,'2026-09-18',18,9,'September',3,2026,'Friday'),(20260919,'2026-09-19',19,9,'September',3,2026,'Saturday'),(20260920,'2026-09-20',20,9,'September',3,2026,'Sunday'),(20260921,'2026-09-21',21,9,'September',3,2026,'Monday'),(20260922,'2026-09-22',22,9,'September',3,2026,'Tuesday'),(20260923,'2026-09-23',23,9,'September',3,2026,'Wednesday'),(20260924,'2026-09-24',24,9,'September',3,2026,'Thursday'),(20260925,'2026-09-25',25,9,'September',3,2026,'Friday'),(20260926,'2026-09-26',26,9,'September',3,2026,'Saturday'),(20260927,'2026-09-27',27,9,'September',3,2026,'Sunday'),(20260928,'2026-09-28',28,9,'September',3,2026,'Monday'),(20260929,'2026-09-29',29,9,'September',3,2026,'Tuesday'),(20260930,'2026-09-30',30,9,'September',3,2026,'Wednesday'),(20261001,'2026-10-01',1,10,'October',4,2026,'Thursday'),(20261002,'2026-10-02',2,10,'October',4,2026,'Friday'),(20261003,'2026-10-03',3,10,'October',4,2026,'Saturday'),(20261004,'2026-10-04',4,10,'October',4,2026,'Sunday'),(20261005,'2026-10-05',5,10,'October',4,2026,'Monday'),(20261006,'2026-10-06',6,10,'October',4,2026,'Tuesday'),(20261007,'2026-10-07',7,10,'October',4,2026,'Wednesday'),(20261008,'2026-10-08',8,10,'October',4,2026,'Thursday'),(20261009,'2026-10-09',9,10,'October',4,2026,'Friday'),(20261010,'2026-10-10',10,10,'October',4,2026,'Saturday'),(20261011,'2026-10-11',11,10,'October',4,2026,'Sunday'),(20261012,'2026-10-12',12,10,'October',4,2026,'Monday'),(20261013,'2026-10-13',13,10,'October',4,2026,'Tuesday'),(20261014,'2026-10-14',14,10,'October',4,2026,'Wednesday'),(20261015,'2026-10-15',15,10,'October',4,2026,'Thursday'),(20261016,'2026-10-16',16,10,'October',4,2026,'Friday'),(20261017,'2026-10-17',17,10,'October',4,2026,'Saturday'),(20261018,'2026-10-18',18,10,'October',4,2026,'Sunday'),(20261019,'2026-10-19',19,10,'October',4,2026,'Monday'),(20261020,'2026-10-20',20,10,'October',4,2026,'Tuesday'),(20261021,'2026-10-21',21,10,'October',4,2026,'Wednesday'),(20261022,'2026-10-22',22,10,'October',4,2026,'Thursday'),(20261023,'2026-10-23',23,10,'October',4,2026,'Friday'),(20261024,'2026-10-24',24,10,'October',4,2026,'Saturday'),(20261025,'2026-10-25',25,10,'October',4,2026,'Sunday'),(20261026,'2026-10-26',26,10,'October',4,2026,'Monday'),(20261027,'2026-10-27',27,10,'October',4,2026,'Tuesday'),(20261028,'2026-10-28',28,10,'October',4,2026,'Wednesday'),(20261029,'2026-10-29',29,10,'October',4,2026,'Thursday'),(20261030,'2026-10-30',30,10,'October',4,2026,'Friday'),(20261031,'2026-10-31',31,10,'October',4,2026,'Saturday'),(20261101,'2026-11-01',1,11,'November',4,2026,'Sunday'),(20261102,'2026-11-02',2,11,'November',4,2026,'Monday'),(20261103,'2026-11-03',3,11,'November',4,2026,'Tuesday'),(20261104,'2026-11-04',4,11,'November',4,2026,'Wednesday'),(20261105,'2026-11-05',5,11,'November',4,2026,'Thursday'),(20261106,'2026-11-06',6,11,'November',4,2026,'Friday'),(20261107,'2026-11-07',7,11,'November',4,2026,'Saturday'),(20261108,'2026-11-08',8,11,'November',4,2026,'Sunday'),(20261109,'2026-11-09',9,11,'November',4,2026,'Monday'),(20261110,'2026-11-10',10,11,'November',4,2026,'Tuesday'),(20261111,'2026-11-11',11,11,'November',4,2026,'Wednesday'),(20261112,'2026-11-12',12,11,'November',4,2026,'Thursday'),(20261113,'2026-11-13',13,11,'November',4,2026,'Friday'),(20261114,'2026-11-14',14,11,'November',4,2026,'Saturday'),(20261115,'2026-11-15',15,11,'November',4,2026,'Sunday'),(20261116,'2026-11-16',16,11,'November',4,2026,'Monday'),(20261117,'2026-11-17',17,11,'November',4,2026,'Tuesday'),(20261118,'2026-11-18',18,11,'November',4,2026,'Wednesday'),(20261119,'2026-11-19',19,11,'November',4,2026,'Thursday'),(20261120,'2026-11-20',20,11,'November',4,2026,'Friday'),(20261121,'2026-11-21',21,11,'November',4,2026,'Saturday'),(20261122,'2026-11-22',22,11,'November',4,2026,'Sunday'),(20261123,'2026-11-23',23,11,'November',4,2026,'Monday'),(20261124,'2026-11-24',24,11,'November',4,2026,'Tuesday'),(20261125,'2026-11-25',25,11,'November',4,2026,'Wednesday'),(20261126,'2026-11-26',26,11,'November',4,2026,'Thursday'),(20261127,'2026-11-27',27,11,'November',4,2026,'Friday'),(20261128,'2026-11-28',28,11,'November',4,2026,'Saturday'),(20261129,'2026-11-29',29,11,'November',4,2026,'Sunday'),(20261130,'2026-11-30',30,11,'November',4,2026,'Monday'),(20261201,'2026-12-01',1,12,'December',4,2026,'Tuesday'),(20261202,'2026-12-02',2,12,'December',4,2026,'Wednesday'),(20261203,'2026-12-03',3,12,'December',4,2026,'Thursday'),(20261204,'2026-12-04',4,12,'December',4,2026,'Friday'),(20261205,'2026-12-05',5,12,'December',4,2026,'Saturday'),(20261206,'2026-12-06',6,12,'December',4,2026,'Sunday'),(20261207,'2026-12-07',7,12,'December',4,2026,'Monday'),(20261208,'2026-12-08',8,12,'December',4,2026,'Tuesday'),(20261209,'2026-12-09',9,12,'December',4,2026,'Wednesday'),(20261210,'2026-12-10',10,12,'December',4,2026,'Thursday'),(20261211,'2026-12-11',11,12,'December',4,2026,'Friday'),(20261212,'2026-12-12',12,12,'December',4,2026,'Saturday'),(20261213,'2026-12-13',13,12,'December',4,2026,'Sunday'),(20261214,'2026-12-14',14,12,'December',4,2026,'Monday'),(20261215,'2026-12-15',15,12,'December',4,2026,'Tuesday'),(20261216,'2026-12-16',16,12,'December',4,2026,'Wednesday'),(20261217,'2026-12-17',17,12,'December',4,2026,'Thursday'),(20261218,'2026-12-18',18,12,'December',4,2026,'Friday'),(20261219,'2026-12-19',19,12,'December',4,2026,'Saturday'),(20261220,'2026-12-20',20,12,'December',4,2026,'Sunday'),(20261221,'2026-12-21',21,12,'December',4,2026,'Monday'),(20261222,'2026-12-22',22,12,'December',4,2026,'Tuesday'),(20261223,'2026-12-23',23,12,'December',4,2026,'Wednesday'),(20261224,'2026-12-24',24,12,'December',4,2026,'Thursday'),(20261225,'2026-12-25',25,12,'December',4,2026,'Friday'),(20261226,'2026-12-26',26,12,'December',4,2026,'Saturday'),(20261227,'2026-12-27',27,12,'December',4,2026,'Sunday'),(20261228,'2026-12-28',28,12,'December',4,2026,'Monday'),(20261229,'2026-12-29',29,12,'December',4,2026,'Tuesday'),(20261230,'2026-12-30',30,12,'December',4,2026,'Wednesday'),(20261231,'2026-12-31',31,12,'December',4,2026,'Thursday');
/*!40000 ALTER TABLE `dim_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_payment`
--

DROP TABLE IF EXISTS `dim_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_payment` (
  `payment_key` int NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_key`),
  UNIQUE KEY `payment_method` (`payment_method`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_payment`
--

LOCK TABLES `dim_payment` WRITE;
/*!40000 ALTER TABLE `dim_payment` DISABLE KEYS */;
INSERT INTO `dim_payment` VALUES (3,'Bank Transfer'),(2,'Card'),(1,'Cash'),(4,'Digital Wallet');
/*!40000 ALTER TABLE `dim_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dim_product`
--

DROP TABLE IF EXISTS `dim_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_product` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `category_name` varchar(100) DEFAULT NULL,
  `supplier_name` varchar(150) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `unit_cost` decimal(12,2) DEFAULT NULL,
  `selling_price` decimal(12,2) DEFAULT NULL,
  `reorder_level` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dim_product`
--

LOCK TABLES `dim_product` WRITE;
/*!40000 ALTER TABLE `dim_product` DISABLE KEYS */;
INSERT INTO `dim_product` VALUES (1,4,'Flour 1kg','Groceries','Lanka Food Distributors','Prima',450.00,900.00,25,1),(2,3,'Cooking Oil 1L','Groceries','Lanka Food Distributors','Golden',850.00,1200.00,20,1),(3,2,'Sugar 1kg','Groceries','Lanka Food Distributors','SuperMart',450.00,800.00,25,1),(4,1,'Rice 1kg','Groceries','Lanka Food Distributors','SuperMart',350.00,550.00,30,1),(5,8,'Coffee Pack','Beverages','Ceylon Beverage Suppliers','Ceylon Coffee',500.00,900.00,20,1),(6,7,'Tea Pack','Beverages','Ceylon Beverage Suppliers','Ceylon Tea',650.00,1000.00,20,1),(7,6,'Yoghurt Pack','Dairy Products','Fresh Dairy Lanka','FreshDairy',300.00,500.00,30,1),(8,5,'Milk Packet','Dairy Products','Fresh Dairy Lanka','FreshMilk',250.00,400.00,30,1),(9,9,'Shampoo Bottle','Personal Care','Care Products Distributors','CarePlus',1000.00,1500.00,15,1),(10,10,'Detergent Pack','Household','Home Essentials Lanka','CleanHome',600.00,1100.00,20,1);
/*!40000 ALTER TABLE `dim_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fact_inventory`
--

DROP TABLE IF EXISTS `fact_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_inventory` (
  `inventory_key` bigint NOT NULL AUTO_INCREMENT,
  `date_key` int NOT NULL,
  `branch_key` int NOT NULL,
  `product_key` int NOT NULL,
  `opening_stock` int NOT NULL DEFAULT '0',
  `stock_in` int NOT NULL DEFAULT '0',
  `stock_out` int NOT NULL DEFAULT '0',
  `closing_stock` int NOT NULL DEFAULT '0',
  `stock_value` decimal(14,2) NOT NULL DEFAULT '0.00',
  `loaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_key`),
  UNIQUE KEY `uq_inventory_snapshot` (`date_key`,`branch_key`,`product_key`),
  KEY `fk_fact_inventory_branch` (`branch_key`),
  KEY `fk_fact_inventory_product` (`product_key`),
  CONSTRAINT `fk_fact_inventory_branch` FOREIGN KEY (`branch_key`) REFERENCES `dim_branch` (`branch_key`),
  CONSTRAINT `fk_fact_inventory_date` FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  CONSTRAINT `fk_fact_inventory_product` FOREIGN KEY (`product_key`) REFERENCES `dim_product` (`product_key`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_inventory`
--

LOCK TABLES `fact_inventory` WRITE;
/*!40000 ALTER TABLE `fact_inventory` DISABLE KEYS */;
INSERT INTO `fact_inventory` VALUES (152,20260101,1,4,0,99,0,99,34650.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(153,20260115,1,4,99,33,0,132,46200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(154,20260220,1,4,132,0,18,114,39900.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(155,20260101,1,3,0,104,0,104,46800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(156,20260115,1,3,104,68,0,172,77400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(157,20260220,1,3,172,0,22,150,67500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(158,20260101,1,2,0,132,0,132,112200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(159,20260115,1,2,132,36,0,168,142800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(160,20260220,1,2,168,0,24,144,122400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(161,20260101,1,1,0,83,0,83,37350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(162,20260115,1,1,83,31,0,114,51300.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(163,20260220,1,1,114,0,41,73,32850.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(164,20260101,1,8,0,133,0,133,33250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(165,20260115,1,8,133,56,0,189,47250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(166,20260220,1,8,189,0,45,144,36000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(167,20260101,1,7,0,85,0,85,25500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(168,20260115,1,7,85,90,0,175,52500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(169,20260220,1,7,175,0,15,160,48000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(170,20260101,1,6,0,173,0,173,112450.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(171,20260115,1,6,173,57,0,230,149500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(172,20260220,1,6,230,0,24,206,133900.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(173,20260101,1,5,0,179,0,179,89500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(174,20260115,1,5,179,61,0,240,120000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(175,20260220,1,5,240,0,23,217,108500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(176,20260101,1,9,0,112,0,112,112000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(177,20260115,1,9,112,54,0,166,166000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(178,20260220,1,9,166,0,21,145,145000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(179,20260101,1,10,0,105,0,105,63000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(180,20260115,1,10,105,61,0,166,99600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(181,20260220,1,10,166,0,30,136,81600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(182,20260101,2,4,0,132,0,132,46200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(183,20260115,2,4,132,38,0,170,59500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(184,20260220,2,4,170,0,26,144,50400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(185,20260101,2,3,0,127,0,127,57150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(186,20260115,2,3,127,86,0,213,95850.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(187,20260220,2,3,213,0,30,183,82350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(188,20260101,2,2,0,91,0,91,77350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(189,20260115,2,2,91,30,0,121,102850.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(190,20260220,2,2,121,0,17,104,88400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(191,20260101,2,1,0,164,0,164,73800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(192,20260115,2,1,164,43,0,207,93150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(193,20260220,2,1,207,0,27,180,81000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(194,20260101,2,8,0,119,0,119,29750.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(195,20260115,2,8,119,66,0,185,46250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(196,20260220,2,8,185,0,44,141,35250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(197,20260101,2,7,0,160,0,160,48000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(198,20260115,2,7,160,42,0,202,60600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(199,20260220,2,7,202,0,27,175,52500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(200,20260101,2,6,0,90,0,90,58500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(201,20260115,2,6,90,49,0,139,90350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(202,20260220,2,6,139,0,19,120,78000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(203,20260101,2,5,0,147,0,147,73500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(204,20260115,2,5,147,78,0,225,112500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(205,20260220,2,5,225,0,34,191,95500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(206,20260101,2,9,0,121,0,121,121000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(207,20260115,2,9,121,67,0,188,188000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(208,20260220,2,9,188,0,33,155,155000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(209,20260101,2,10,0,170,0,170,102000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(210,20260115,2,10,170,67,0,237,142200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(211,20260220,2,10,237,0,16,221,132600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(212,20260101,3,4,0,129,0,129,45150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(213,20260115,3,4,129,66,0,195,68250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(214,20260220,3,4,195,0,34,161,56350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(215,20260101,3,3,0,161,0,161,72450.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(216,20260115,3,3,161,78,0,239,107550.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(217,20260220,3,3,239,0,30,209,94050.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(218,20260101,3,2,0,180,0,180,153000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(219,20260115,3,2,180,88,0,268,227800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(220,20260220,3,2,268,0,32,236,200600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(221,20260101,3,1,0,135,0,135,60750.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(222,20260115,3,1,135,70,0,205,92250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(223,20260220,3,1,205,0,28,177,79650.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(224,20260101,3,8,0,157,0,157,39250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(225,20260115,3,8,157,88,0,245,61250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(226,20260220,3,8,245,0,19,226,56500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(227,20260101,3,7,0,84,0,84,25200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(228,20260115,3,7,84,45,0,129,38700.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(229,20260220,3,7,129,0,34,95,28500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(230,20260101,3,6,0,145,0,145,94250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(231,20260115,3,6,145,81,0,226,146900.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(232,20260220,3,6,226,0,31,195,126750.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(233,20260101,3,5,0,118,0,118,59000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(234,20260115,3,5,118,80,0,198,99000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(235,20260220,3,5,198,0,22,176,88000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(236,20260101,3,9,0,158,0,158,158000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(237,20260115,3,9,158,83,0,241,241000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(238,20260220,3,9,241,0,13,228,228000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(239,20260101,3,10,0,147,0,147,88200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(240,20260115,3,10,147,70,0,217,130200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(241,20260220,3,10,217,0,43,174,104400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(242,20260101,4,4,0,159,0,159,55650.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(243,20260115,4,4,159,33,0,192,67200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(244,20260220,4,4,192,0,24,168,58800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(245,20260101,4,3,0,83,0,83,37350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(246,20260115,4,3,83,60,0,143,64350.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(247,20260220,4,3,143,0,18,125,56250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(248,20260101,4,2,0,149,0,149,126650.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(249,20260115,4,2,149,75,0,224,190400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(250,20260220,4,2,224,0,18,206,175100.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(251,20260101,4,1,0,111,0,111,49950.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(252,20260115,4,1,111,49,0,160,72000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(253,20260220,4,1,160,0,22,138,62100.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(254,20260101,4,8,0,114,0,114,28500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(255,20260115,4,8,114,66,0,180,45000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(256,20260220,4,8,180,0,24,156,39000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(257,20260101,4,7,0,139,0,139,41700.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(258,20260115,4,7,139,73,0,212,63600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(259,20260220,4,7,212,0,15,197,59100.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(260,20260101,4,6,0,156,0,156,101400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(261,20260115,4,6,156,64,0,220,143000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(262,20260220,4,6,220,0,30,190,123500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(263,20260101,4,5,0,148,0,148,74000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(264,20260115,4,5,148,51,0,199,99500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(265,20260220,4,5,199,0,34,165,82500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(266,20260101,4,9,0,131,0,131,131000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(267,20260115,4,9,131,75,0,206,206000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(268,20260220,4,9,206,0,35,171,171000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(269,20260101,4,10,0,168,0,168,100800.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(270,20260115,4,10,168,51,0,219,131400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(271,20260220,4,10,219,0,17,202,121200.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(272,20260101,5,4,0,131,0,131,45850.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(273,20260115,5,4,131,52,0,183,64050.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(274,20260220,5,4,183,0,28,155,54250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(275,20260101,5,3,0,142,0,142,63900.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(276,20260115,5,3,142,85,0,227,102150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(277,20260220,5,3,227,0,42,185,83250.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(278,20260101,5,2,0,147,0,147,124950.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(279,20260115,5,2,147,86,0,233,198050.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(280,20260220,5,2,233,0,43,190,161500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(281,20260101,5,1,0,80,0,80,36000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(282,20260115,5,1,80,34,0,114,51300.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(283,20260220,5,1,114,0,17,97,43650.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(284,20260101,5,8,0,147,0,147,36750.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(285,20260115,5,8,147,44,0,191,47750.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(286,20260220,5,8,191,0,43,148,37000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(287,20260101,5,7,0,139,0,139,41700.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(288,20260115,5,7,139,52,0,191,57300.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(289,20260220,5,7,191,0,40,151,45300.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(290,20260101,5,6,0,84,0,84,54600.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(291,20260115,5,6,84,67,0,151,98150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(292,20260220,5,6,151,0,20,131,85150.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(293,20260101,5,5,0,117,0,117,58500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(294,20260115,5,5,117,33,0,150,75000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(295,20260220,5,5,150,0,31,119,59500.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(296,20260101,5,9,0,97,0,97,97000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(297,20260115,5,9,97,44,0,141,141000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(298,20260220,5,9,141,0,14,127,127000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(299,20260101,5,10,0,144,0,144,86400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(300,20260115,5,10,144,45,0,189,113400.00,'2026-10-29 22:17:50','2026-10-29 22:17:50'),(301,20260220,5,10,189,0,24,165,99000.00,'2026-10-29 22:17:50','2026-10-29 22:17:50');
/*!40000 ALTER TABLE `fact_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fact_inventory_refresh_backup`
--

DROP TABLE IF EXISTS `fact_inventory_refresh_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_inventory_refresh_backup` (
  `inventory_key` bigint NOT NULL AUTO_INCREMENT,
  `date_key` int NOT NULL,
  `branch_key` int NOT NULL,
  `product_key` int NOT NULL,
  `opening_stock` int NOT NULL DEFAULT '0',
  `stock_in` int NOT NULL DEFAULT '0',
  `stock_out` int NOT NULL DEFAULT '0',
  `closing_stock` int NOT NULL DEFAULT '0',
  `stock_value` decimal(14,2) NOT NULL DEFAULT '0.00',
  `loaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_key`),
  UNIQUE KEY `uq_inventory_snapshot` (`date_key`,`branch_key`,`product_key`),
  KEY `fk_fact_inventory_branch` (`branch_key`),
  KEY `fk_fact_inventory_product` (`product_key`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_inventory_refresh_backup`
--

LOCK TABLES `fact_inventory_refresh_backup` WRITE;
/*!40000 ALTER TABLE `fact_inventory_refresh_backup` DISABLE KEYS */;
INSERT INTO `fact_inventory_refresh_backup` VALUES (1,20260101,1,4,0,99,0,99,34650.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(2,20260115,1,4,99,33,0,132,46200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(3,20260220,1,4,132,0,18,114,39900.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(4,20260101,1,3,0,104,0,104,46800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(5,20260115,1,3,104,68,0,172,77400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(6,20260220,1,3,172,0,22,150,67500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(7,20260101,1,2,0,132,0,132,112200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(8,20260115,1,2,132,36,0,168,142800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(9,20260220,1,2,168,0,24,144,122400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(10,20260101,1,1,0,83,0,83,37350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(11,20260115,1,1,83,31,0,114,51300.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(12,20260220,1,1,114,0,41,73,32850.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(13,20260101,1,8,0,133,0,133,33250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(14,20260115,1,8,133,56,0,189,47250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(15,20260220,1,8,189,0,45,144,36000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(16,20260101,1,7,0,85,0,85,25500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(17,20260115,1,7,85,90,0,175,52500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(18,20260220,1,7,175,0,15,160,48000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(19,20260101,1,6,0,173,0,173,112450.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(20,20260115,1,6,173,57,0,230,149500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(21,20260220,1,6,230,0,24,206,133900.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(22,20260101,1,5,0,179,0,179,89500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(23,20260115,1,5,179,61,0,240,120000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(24,20260220,1,5,240,0,23,217,108500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(25,20260101,1,9,0,112,0,112,112000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(26,20260115,1,9,112,54,0,166,166000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(27,20260220,1,9,166,0,21,145,145000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(28,20260101,1,10,0,105,0,105,63000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(29,20260115,1,10,105,61,0,166,99600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(30,20260220,1,10,166,0,30,136,81600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(31,20260101,2,4,0,132,0,132,46200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(32,20260115,2,4,132,38,0,170,59500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(33,20260220,2,4,170,0,26,144,50400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(34,20260101,2,3,0,127,0,127,57150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(35,20260115,2,3,127,86,0,213,95850.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(36,20260220,2,3,213,0,30,183,82350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(37,20260101,2,2,0,91,0,91,77350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(38,20260115,2,2,91,30,0,121,102850.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(39,20260220,2,2,121,0,17,104,88400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(40,20260101,2,1,0,164,0,164,73800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(41,20260115,2,1,164,43,0,207,93150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(42,20260220,2,1,207,0,27,180,81000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(43,20260101,2,8,0,119,0,119,29750.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(44,20260115,2,8,119,66,0,185,46250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(45,20260220,2,8,185,0,44,141,35250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(46,20260101,2,7,0,160,0,160,48000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(47,20260115,2,7,160,42,0,202,60600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(48,20260220,2,7,202,0,27,175,52500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(49,20260101,2,6,0,90,0,90,58500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(50,20260115,2,6,90,49,0,139,90350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(51,20260220,2,6,139,0,19,120,78000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(52,20260101,2,5,0,147,0,147,73500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(53,20260115,2,5,147,78,0,225,112500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(54,20260220,2,5,225,0,34,191,95500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(55,20260101,2,9,0,121,0,121,121000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(56,20260115,2,9,121,67,0,188,188000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(57,20260220,2,9,188,0,33,155,155000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(58,20260101,2,10,0,170,0,170,102000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(59,20260115,2,10,170,67,0,237,142200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(60,20260220,2,10,237,0,16,221,132600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(61,20260101,3,4,0,129,0,129,45150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(62,20260115,3,4,129,66,0,195,68250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(63,20260220,3,4,195,0,34,161,56350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(64,20260101,3,3,0,161,0,161,72450.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(65,20260115,3,3,161,78,0,239,107550.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(66,20260220,3,3,239,0,30,209,94050.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(67,20260101,3,2,0,180,0,180,153000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(68,20260115,3,2,180,88,0,268,227800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(69,20260220,3,2,268,0,32,236,200600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(70,20260101,3,1,0,135,0,135,60750.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(71,20260115,3,1,135,70,0,205,92250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(72,20260220,3,1,205,0,28,177,79650.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(73,20260101,3,8,0,157,0,157,39250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(74,20260115,3,8,157,88,0,245,61250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(75,20260220,3,8,245,0,19,226,56500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(76,20260101,3,7,0,84,0,84,25200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(77,20260115,3,7,84,45,0,129,38700.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(78,20260220,3,7,129,0,34,95,28500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(79,20260101,3,6,0,145,0,145,94250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(80,20260115,3,6,145,81,0,226,146900.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(81,20260220,3,6,226,0,31,195,126750.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(82,20260101,3,5,0,118,0,118,59000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(83,20260115,3,5,118,80,0,198,99000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(84,20260220,3,5,198,0,22,176,88000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(85,20260101,3,9,0,158,0,158,158000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(86,20260115,3,9,158,83,0,241,241000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(87,20260220,3,9,241,0,13,228,228000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(88,20260101,3,10,0,147,0,147,88200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(89,20260115,3,10,147,70,0,217,130200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(90,20260220,3,10,217,0,43,174,104400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(91,20260101,4,4,0,159,0,159,55650.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(92,20260115,4,4,159,33,0,192,67200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(93,20260220,4,4,192,0,24,168,58800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(94,20260101,4,3,0,83,0,83,37350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(95,20260115,4,3,83,60,0,143,64350.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(96,20260220,4,3,143,0,18,125,56250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(97,20260101,4,2,0,149,0,149,126650.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(98,20260115,4,2,149,75,0,224,190400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(99,20260220,4,2,224,0,18,206,175100.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(100,20260101,4,1,0,111,0,111,49950.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(101,20260115,4,1,111,49,0,160,72000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(102,20260220,4,1,160,0,22,138,62100.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(103,20260101,4,8,0,114,0,114,28500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(104,20260115,4,8,114,66,0,180,45000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(105,20260220,4,8,180,0,24,156,39000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(106,20260101,4,7,0,139,0,139,41700.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(107,20260115,4,7,139,73,0,212,63600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(108,20260220,4,7,212,0,15,197,59100.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(109,20260101,4,6,0,156,0,156,101400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(110,20260115,4,6,156,64,0,220,143000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(111,20260220,4,6,220,0,30,190,123500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(112,20260101,4,5,0,148,0,148,74000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(113,20260115,4,5,148,51,0,199,99500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(114,20260220,4,5,199,0,34,165,82500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(115,20260101,4,9,0,131,0,131,131000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(116,20260115,4,9,131,75,0,206,206000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(117,20260220,4,9,206,0,35,171,171000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(118,20260101,4,10,0,168,0,168,100800.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(119,20260115,4,10,168,51,0,219,131400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(120,20260220,4,10,219,0,17,202,121200.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(121,20260101,5,4,0,131,0,131,45850.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(122,20260115,5,4,131,52,0,183,64050.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(123,20260220,5,4,183,0,28,155,54250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(124,20260101,5,3,0,142,0,142,63900.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(125,20260115,5,3,142,85,0,227,102150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(126,20260220,5,3,227,0,42,185,83250.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(127,20260101,5,2,0,147,0,147,124950.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(128,20260115,5,2,147,86,0,233,198050.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(129,20260220,5,2,233,0,43,190,161500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(130,20260101,5,1,0,80,0,80,36000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(131,20260115,5,1,80,34,0,114,51300.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(132,20260220,5,1,114,0,17,97,43650.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(133,20260101,5,8,0,147,0,147,36750.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(134,20260115,5,8,147,44,0,191,47750.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(135,20260220,5,8,191,0,43,148,37000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(136,20260101,5,7,0,139,0,139,41700.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(137,20260115,5,7,139,52,0,191,57300.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(138,20260220,5,7,191,0,40,151,45300.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(139,20260101,5,6,0,84,0,84,54600.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(140,20260115,5,6,84,67,0,151,98150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(141,20260220,5,6,151,0,20,131,85150.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(142,20260101,5,5,0,117,0,117,58500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(143,20260115,5,5,117,33,0,150,75000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(144,20260220,5,5,150,0,31,119,59500.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(145,20260101,5,9,0,97,0,97,97000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(146,20260115,5,9,97,44,0,141,141000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(147,20260220,5,9,141,0,14,127,127000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(148,20260101,5,10,0,144,0,144,86400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(149,20260115,5,10,144,45,0,189,113400.00,'2026-10-28 06:19:04','2026-10-28 06:19:04'),(150,20260220,5,10,189,0,24,165,99000.00,'2026-10-28 06:19:04','2026-10-28 06:19:04');
/*!40000 ALTER TABLE `fact_inventory_refresh_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fact_sales`
--

DROP TABLE IF EXISTS `fact_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_sales` (
  `sales_key` bigint NOT NULL AUTO_INCREMENT,
  `sale_id` int NOT NULL,
  `sale_item_id` int NOT NULL,
  `date_key` int NOT NULL,
  `branch_key` int NOT NULL,
  `customer_key` int DEFAULT NULL,
  `product_key` int NOT NULL,
  `payment_key` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `gross_amount` decimal(14,2) NOT NULL,
  `discount_amount` decimal(14,2) NOT NULL DEFAULT '0.00',
  `net_amount` decimal(14,2) NOT NULL,
  `cost_amount` decimal(14,2) NOT NULL,
  `profit_amount` decimal(14,2) NOT NULL,
  `loaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_key`),
  UNIQUE KEY `uq_source_sale_item` (`sale_item_id`),
  KEY `fk_fact_sales_date` (`date_key`),
  KEY `fk_fact_sales_branch` (`branch_key`),
  KEY `fk_fact_sales_customer` (`customer_key`),
  KEY `fk_fact_sales_product` (`product_key`),
  KEY `fk_fact_sales_payment` (`payment_key`),
  CONSTRAINT `fk_fact_sales_branch` FOREIGN KEY (`branch_key`) REFERENCES `dim_branch` (`branch_key`),
  CONSTRAINT `fk_fact_sales_customer` FOREIGN KEY (`customer_key`) REFERENCES `dim_customer` (`customer_key`),
  CONSTRAINT `fk_fact_sales_date` FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  CONSTRAINT `fk_fact_sales_payment` FOREIGN KEY (`payment_key`) REFERENCES `dim_payment` (`payment_key`),
  CONSTRAINT `fk_fact_sales_product` FOREIGN KEY (`product_key`) REFERENCES `dim_product` (`product_key`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fact_sales`
--

LOCK TABLES `fact_sales` WRITE;
/*!40000 ALTER TABLE `fact_sales` DISABLE KEYS */;
INSERT INTO `fact_sales` VALUES (1,1,1,20260105,1,1,4,1,2,500.00,1000.00,0.00,1000.00,700.00,300.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(2,1,2,20260105,1,1,3,1,2,750.00,1500.00,100.00,1400.00,900.00,500.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(3,2,3,20260106,2,2,2,2,2,1200.00,2400.00,100.00,2300.00,1700.00,600.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(4,2,4,20260106,2,2,1,2,2,900.00,1800.00,100.00,1700.00,900.00,800.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(5,3,5,20260107,3,3,8,1,2,400.00,800.00,0.00,800.00,500.00,300.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(6,3,6,20260107,3,3,7,1,2,500.00,1000.00,0.00,1000.00,600.00,400.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(7,4,7,20260108,4,4,6,4,2,1000.00,2000.00,100.00,1900.00,1300.00,600.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(8,4,8,20260108,4,4,5,4,2,750.00,1500.00,50.00,1450.00,1000.00,450.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(9,5,9,20260109,5,5,9,2,2,1500.00,3000.00,100.00,2900.00,2000.00,900.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(10,5,10,20260109,5,5,10,2,2,1100.00,2200.00,100.00,2100.00,1200.00,900.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(11,6,11,20260112,1,6,4,1,3,500.00,1500.00,0.00,1500.00,1050.00,450.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(12,6,12,20260112,1,6,3,1,2,600.00,1200.00,100.00,1100.00,900.00,200.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(13,7,13,20260114,2,7,2,3,3,1200.00,3600.00,200.00,3400.00,2550.00,850.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(14,7,14,20260114,2,7,1,3,3,900.00,2700.00,300.00,2400.00,1350.00,1050.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(15,8,15,20260116,3,8,8,2,3,400.00,1200.00,0.00,1200.00,750.00,450.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(16,8,16,20260116,3,8,7,2,4,500.00,2000.00,0.00,2000.00,1200.00,800.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(17,9,17,20260118,4,9,6,4,3,1000.00,3000.00,100.00,2900.00,1950.00,950.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(18,9,18,20260118,4,9,5,4,2,750.00,1500.00,100.00,1400.00,1000.00,400.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(19,10,19,20260120,5,10,9,1,1,1500.00,1500.00,0.00,1500.00,1000.00,500.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(20,10,20,20260120,5,10,10,1,2,700.00,1400.00,0.00,1400.00,1200.00,200.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(21,11,21,20260202,1,11,4,2,3,500.00,1500.00,100.00,1400.00,1050.00,350.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(22,11,22,20260202,1,11,3,2,3,800.00,2400.00,100.00,2300.00,1350.00,950.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(23,12,23,20260204,2,12,2,3,3,1200.00,3600.00,100.00,3500.00,2550.00,950.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(24,12,24,20260204,2,12,1,3,2,900.00,1800.00,100.00,1700.00,900.00,800.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(25,13,25,20260206,3,13,8,1,3,400.00,1200.00,100.00,1100.00,750.00,350.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(26,13,26,20260206,3,13,7,1,2,500.00,1000.00,0.00,1000.00,600.00,400.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(27,14,27,20260208,4,14,6,4,3,1000.00,3000.00,100.00,2900.00,1950.00,950.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(28,14,28,20260208,4,14,5,4,2,850.00,1700.00,100.00,1600.00,1000.00,600.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(29,15,29,20260210,5,15,9,2,3,1500.00,4500.00,200.00,4300.00,3000.00,1300.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(30,15,30,20260210,5,15,10,2,2,900.00,1800.00,100.00,1700.00,1200.00,500.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(31,16,31,20260212,1,16,4,1,3,500.00,1500.00,0.00,1500.00,1050.00,450.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(32,16,32,20260212,1,16,3,1,2,800.00,1600.00,100.00,1500.00,900.00,600.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(33,17,33,20260214,2,17,2,2,3,1200.00,3600.00,100.00,3500.00,2550.00,950.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(34,17,34,20260214,2,17,1,2,2,650.00,1300.00,100.00,1200.00,900.00,300.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(35,18,35,20260216,3,18,8,4,5,400.00,2000.00,100.00,1900.00,1250.00,650.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(36,18,36,20260216,3,18,7,4,4,400.00,1600.00,0.00,1600.00,1200.00,400.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(37,19,37,20260218,4,19,6,3,4,1000.00,4000.00,200.00,3800.00,2600.00,1200.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(38,19,38,20260218,4,19,5,3,2,900.00,1800.00,100.00,1700.00,1000.00,700.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(39,20,39,20260220,5,20,9,1,2,1500.00,3000.00,100.00,2900.00,2000.00,900.00,'2026-10-28 06:17:19','2026-10-28 06:17:19'),(40,20,40,20260220,5,20,10,1,2,600.00,1200.00,100.00,1100.00,1200.00,-100.00,'2026-10-28 06:17:19','2026-10-28 06:17:19');
/*!40000 ALTER TABLE `fact_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'supermart_dw'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-30  6:21:53
