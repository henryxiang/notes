CREATE DATABASE  IF NOT EXISTS `pat` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pat`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (x86_64)
--
-- Host: pat-cluster-aurora-mysql-latest.cluster-cyg8wlehnkx9.us-west-2.rds.amazonaws.com    Database: pat
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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `affiliation`
--

DROP TABLE IF EXISTS `affiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `affiliation` (
  `affiliation_code` varchar(50) NOT NULL,
  `affiliation_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`affiliation_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `age`
--

DROP TABLE IF EXISTS `age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age` (
  `age_code` varchar(50) NOT NULL,
  `age_type` varchar(10) NOT NULL,
  `age_name` varchar(45) DEFAULT NULL,
  `min_age` int NOT NULL,
  `max_age` int NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`age_code`),
  KEY `fk_age_age_type_idx` (`age_type`),
  CONSTRAINT `fk_age_age_type` FOREIGN KEY (`age_type`) REFERENCES `age_type` (`age_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `age_type`
--

DROP TABLE IF EXISTS `age_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_type` (
  `age_type` varchar(10) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`age_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute` (
  `attribute_code` varchar(50) NOT NULL,
  `attribute_name` varchar(100) DEFAULT NULL,
  `attribute_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `multi_select` tinyint DEFAULT NULL,
  PRIMARY KEY (`attribute_code`),
  KEY `fk_attribute_attribute_type_idx` (`attribute_type_code`),
  CONSTRAINT `fk_attribute_attribute_type` FOREIGN KEY (`attribute_type_code`) REFERENCES `attribute_type` (`attribute_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attribute_applicable_value`
--

DROP TABLE IF EXISTS `attribute_applicable_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_applicable_value` (
  `attribute_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `attribute_value_code` varchar(50) NOT NULL,
  `attribute_value_name` varchar(50) NOT NULL,
  PRIMARY KEY (`attribute_code`,`attribute_value_code`),
  KEY `fk_attribute_code_idx` (`attribute_code`),
  CONSTRAINT `fk_attribute_applicable_value_attribute` FOREIGN KEY (`attribute_code`) REFERENCES `attribute` (`attribute_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attribute_type`
--

DROP TABLE IF EXISTS `attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_type` (
  `attribute_type_code` varchar(50) NOT NULL,
  `attribute_type_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`attribute_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(16) DEFAULT NULL,
  `action_source` varchar(40) DEFAULT NULL,
  `action_on` timestamp NOT NULL,
  `action_user` varchar(20) NOT NULL,
  `entity` varchar(50) NOT NULL,
  `entity_code` varchar(150) DEFAULT NULL,
  `data` json NOT NULL,
  PRIMARY KEY (`audit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61774 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit_entity`
--

DROP TABLE IF EXISTS `audit_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_entity` (
  `entity` varchar(50) NOT NULL,
  PRIMARY KEY (`entity`),
  UNIQUE KEY `entity_UNIQUE` (`entity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `brand_code` varchar(50) NOT NULL,
  `brand_name` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`brand_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_category`
--

DROP TABLE IF EXISTS `bundle_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundle_category` (
  `bundle_category_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `classification_code` varchar(50) NOT NULL,
  `optional` tinyint NOT NULL,
  `selectable` tinyint NOT NULL,
  `min_selection` int DEFAULT NULL,
  `max_selection` int DEFAULT NULL,
  `duration_modifier` int DEFAULT '0',
  `duration_min` int DEFAULT NULL,
  `duration_max` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `frequency_code` enum('ONE_TIME','PER_DAY','PER_NIGHT','INHERIT_PARENT_DURATION') DEFAULT NULL,
  `method_code` enum('PER_GUEST','PER_ITEM') DEFAULT NULL,
  PRIMARY KEY (`bundle_category_id`),
  UNIQUE KEY `idx_bundle_category_UNIQUE` (`product_template_code`,`classification_code`,`optional`,`selectable`),
  KEY `fk_bundle_category_product_template_idx` (`product_template_code`),
  KEY `fk_bundle_category_product_classification_idx` (`classification_code`),
  CONSTRAINT `fk_bundle_category_product_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_bundle_category_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bundle_category_bkp`
--

DROP TABLE IF EXISTS `bundle_category_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bundle_category_bkp` (
  `bundle_category_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `classification_code` varchar(50) NOT NULL,
  `optional` tinyint NOT NULL,
  `selectable` tinyint NOT NULL,
  `max_selection` int DEFAULT NULL,
  `duration_modifier` int DEFAULT '0',
  `duration_min` int DEFAULT NULL,
  `duration_max` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `frequency_code` enum('ONE_TIME','PER_DAY','PER_NIGHT','INHERIT_PARENT_DURATION') DEFAULT NULL,
  `method_code` enum('PER_GUEST','PER_ITEM') DEFAULT NULL,
  PRIMARY KEY (`bundle_category_id`),
  UNIQUE KEY `product_template_clasification_code_optional_selectable` (`product_template_code`,`classification_code`,`optional`,`selectable`,`frequency_code`,`method_code`),
  KEY `fk_bundle_category_product_template_idx` (`product_template_code`),
  KEY `fk_bundle_category_product_classification_idx` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute`
--

DROP TABLE IF EXISTS `cc_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute` (
  `attribute_id` bigint NOT NULL AUTO_INCREMENT,
  `attribute_code` varchar(50) NOT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `attribute_type_code` varchar(50) NOT NULL,
  `multi_select` tinyint NOT NULL,
  `reference_url` varchar(500) DEFAULT NULL,
  `entity_level` varchar(50) NOT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `group_code` varchar(50) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `attribute_code_UNIQUE` (`attribute_code`),
  KEY `fk_cc_attribute_cc_attribute_type_idx` (`attribute_type_code`),
  KEY `fk_cc_attribute_cc_entity_idx` (`entity_level`),
  KEY `fk_cc_attribute_cc_attribute_group_idx` (`group_code`),
  CONSTRAINT `fk_cc_attribute_cc_attribute_group` FOREIGN KEY (`group_code`) REFERENCES `cc_attribute_group` (`group_code`),
  CONSTRAINT `fk_cc_attribute_cc_attribute_type` FOREIGN KEY (`attribute_type_code`) REFERENCES `cc_attribute_type` (`attribute_type_code`),
  CONSTRAINT `fk_cc_attribute_cc_entity` FOREIGN KEY (`entity_level`) REFERENCES `cc_entity` (`entity_level`)
) ENGINE=InnoDB AUTO_INCREMENT=1229 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute_group`
--

DROP TABLE IF EXISTS `cc_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute_group` (
  `group_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute_saved`
--

DROP TABLE IF EXISTS `cc_attribute_saved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute_saved` (
  `attribute_id` bigint NOT NULL AUTO_INCREMENT,
  `attribute_code` varchar(50) NOT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `attribute_type_code` varchar(50) NOT NULL,
  `multi_select` tinyint NOT NULL,
  `reference_url` varchar(500) DEFAULT NULL,
  `entity_level` varchar(50) NOT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `group_code` varchar(50) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `attribute_code_UNIQUE` (`attribute_code`),
  KEY `fk_cc_attribute_cc_attribute_type_idx` (`attribute_type_code`),
  KEY `fk_cc_attribute_cc_entity_idx` (`entity_level`),
  KEY `fk_cc_attribute_cc_attribute_group_idx` (`group_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1040 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute_type`
--

DROP TABLE IF EXISTS `cc_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute_type` (
  `attribute_type_code` varchar(50) NOT NULL,
  `attribute_type_description` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`attribute_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute_value`
--

DROP TABLE IF EXISTS `cc_attribute_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute_value` (
  `attribute_id` bigint NOT NULL,
  `entity_value` varchar(150) NOT NULL,
  `entity_level` varchar(50) NOT NULL,
  `attribute_value_id` int NOT NULL,
  `attribute_value` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `entity_level_2` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`,`entity_value`,`entity_level`,`attribute_value_id`),
  KEY `fk_cc_attribute_value_cc_attribute_idx` (`attribute_id`),
  KEY `fk_cc_attribute_value_cc_entity_idx` (`entity_value`,`entity_level`),
  KEY `fk_cc_attribute_value_cc_entity_level` (`entity_level`),
  CONSTRAINT `fk_cc_attribute_value_cc_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_cc_attribute_value_cc_entity_level` FOREIGN KEY (`entity_level`) REFERENCES `cc_entity` (`entity_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_attribute_value_saved`
--

DROP TABLE IF EXISTS `cc_attribute_value_saved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_attribute_value_saved` (
  `attribute_id` bigint NOT NULL,
  `entity_value` varchar(100) NOT NULL,
  `entity_level` varchar(50) NOT NULL,
  `attribute_value_id` int NOT NULL,
  `attribute_value` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`,`entity_value`,`entity_level`,`attribute_value_id`),
  KEY `fk_cc_attribute_value_cc_attribute_idx` (`attribute_id`),
  KEY `fk_cc_attribute_value_cc_entity_idx` (`entity_value`,`entity_level`),
  KEY `fk_cc_attribute_value_cc_entity_level` (`entity_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_classification_client_attribute`
--

DROP TABLE IF EXISTS `cc_classification_client_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_classification_client_attribute` (
  `classification_code` varchar(50) NOT NULL,
  `attribute_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`,`attribute_id`),
  KEY `fk_cc_classification_client_attribute_cc_attribute_idx` (`attribute_id`),
  CONSTRAINT `fk_cc_classification_client_attribute_cc_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_cc_classification_client_attribute_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_client`
--

DROP TABLE IF EXISTS `cc_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_client` (
  `client_code` varchar(50) NOT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`client_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_client_attribute`
--

DROP TABLE IF EXISTS `cc_client_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_client_attribute` (
  `client_code` varchar(50) NOT NULL,
  `attribute_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`client_code`,`attribute_id`),
  KEY `fk_cc_client_attribute_cc_attribute_idx` (`attribute_id`),
  CONSTRAINT `fk_cc_client_attributes_cc_attributes` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_cc_client_attributes_cc_client` FOREIGN KEY (`client_code`) REFERENCES `cc_client` (`client_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_entity`
--

DROP TABLE IF EXISTS `cc_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_entity` (
  `entity_level` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`entity_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cc_entity_saved`
--

DROP TABLE IF EXISTS `cc_entity_saved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cc_entity_saved` (
  `entity_level` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`entity_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `channel_map`
--

DROP TABLE IF EXISTS `channel_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_map` (
  `channel_map_code` varchar(50) NOT NULL,
  `channel_map_name` varchar(100) DEFAULT NULL,
  `market_code` varchar(50) NOT NULL,
  `distribution_channel_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`channel_map_code`),
  UNIQUE KEY `channel_map_market_distribution_channel_UNIQUE` (`channel_map_code`,`market_code`,`distribution_channel_code`),
  UNIQUE KEY `channel_map_code_UNIQUE` (`channel_map_code`),
  KEY `fk_channel_map_market_idx` (`market_code`),
  KEY `fk_channel_map_distribution_channel_idx` (`distribution_channel_code`),
  CONSTRAINT `fk_channel_map_distribution_channel` FOREIGN KEY (`distribution_channel_code`) REFERENCES `distribution_channel` (`distribution_channel_code`),
  CONSTRAINT `fk_channel_map_market` FOREIGN KEY (`market_code`) REFERENCES `market` (`market_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification` (
  `classification_code` varchar(50) NOT NULL,
  `classification_name` varchar(100) DEFAULT NULL,
  `parent_classification_code` varchar(50) DEFAULT NULL,
  `level` int NOT NULL,
  `validate_dimensions` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` enum('ONE_TIME','PER_DAY','PER_NIGHT','INHERIT_PARENT_DURATION') DEFAULT NULL,
  `method` enum('PER_GUEST','PER_ITEM') DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`),
  KEY `fk_product_classification_product_classification_idx` (`parent_classification_code`),
  CONSTRAINT `fk_product_classification_product_classification` FOREIGN KEY (`parent_classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification_attribute`
--

DROP TABLE IF EXISTS `classification_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification_attribute` (
  `classification_code` varchar(50) NOT NULL,
  `attribute_code` varchar(50) NOT NULL,
  `reference_value` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`,`attribute_code`),
  KEY `fk_classification_attribute_attribute_idx` (`attribute_code`),
  CONSTRAINT `fk_classification_attribute_value_attribute1` FOREIGN KEY (`attribute_code`) REFERENCES `attribute` (`attribute_code`),
  CONSTRAINT `fk_classification_attribute_value_product_classification1` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification_control`
--

DROP TABLE IF EXISTS `classification_control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification_control` (
  `classification_code` varchar(50) NOT NULL,
  `affiliation_flag` tinyint DEFAULT '1',
  `age_group_flag` tinyint DEFAULT '1',
  `brand_flag` tinyint DEFAULT '1',
  `bundle_category_flag` tinyint DEFAULT '1',
  `channel_map_flag` tinyint DEFAULT '1',
  `client_flag` tinyint DEFAULT '1',
  `client_config_flag` tinyint DEFAULT '1',
  `client_group_flag` tinyint DEFAULT '1',
  `code_template_flag` tinyint DEFAULT '1',
  `company_flag` tinyint DEFAULT '1',
  `core_attribute_flag` tinyint DEFAULT '1',
  `discount_flag` tinyint DEFAULT '1',
  `distribution_channel_flag` tinyint DEFAULT '1',
  `division_flag` tinyint DEFAULT '1',
  `frequency_method_flag` tinyint DEFAULT '0',
  `location_flag` tinyint DEFAULT '1',
  `market_flag` tinyint DEFAULT '1',
  `market_group_flag` tinyint DEFAULT '1',
  `offer_flag` tinyint DEFAULT '1',
  `plan_type_flag` tinyint DEFAULT '1',
  `policy_flag` tinyint DEFAULT '1',
  `product_date_flag` tinyint DEFAULT '1',
  `product_duration_flag` tinyint DEFAULT '1',
  `product_set_flag` tinyint DEFAULT '1',
  `rate_grid_flag` tinyint DEFAULT '1',
  `sales_channels_section_flag` tinyint DEFAULT '1',
  `sku_flag` tinyint DEFAULT '1',
  `source_product_code_flag` tinyint DEFAULT '1',
  `source_product_template_flag` tinyint DEFAULT '1',
  `party_mix_control_flag` tinyint DEFAULT '1',
  `party_mix_grid_flag` tinyint DEFAULT '1',
  `days_to_arrival_flag` tinyint DEFAULT '1',
  `enable_locking_flag` tinyint DEFAULT '1',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`),
  CONSTRAINT `fk_classification_control_code` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification_frequency`
--

DROP TABLE IF EXISTS `classification_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification_frequency` (
  `classification_frequency_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `classification_code` varchar(50) DEFAULT NULL,
  `frequency_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_frequency_id`),
  KEY `fk_classification_frequency_code` (`classification_code`),
  KEY `fk_classification_frequency_type_code` (`frequency_code`),
  CONSTRAINT `fk_classification_frequency_code` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_classification_frequency_type_code` FOREIGN KEY (`frequency_code`) REFERENCES `frequency` (`frequency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification_method`
--

DROP TABLE IF EXISTS `classification_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification_method` (
  `classification_method_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `classification_code` varchar(50) DEFAULT NULL,
  `method_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_method_id`),
  KEY `fk_classification_method_code` (`classification_code`),
  KEY `fk_classification_method_type_code` (`method_code`),
  CONSTRAINT `fk_classification_method_code` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_classification_method_type_code` FOREIGN KEY (`method_code`) REFERENCES `method` (`method_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification_policy`
--

DROP TABLE IF EXISTS `classification_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification_policy` (
  `classification_code` varchar(50) NOT NULL,
  `policy_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`,`policy_id`),
  KEY `fk_classification_policy_policy_id` (`policy_id`),
  CONSTRAINT `fk_classification_policy_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_classification_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_group`
--

DROP TABLE IF EXISTS `client_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_group` (
  `client_group_code` varchar(50) NOT NULL,
  `client_group_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`client_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_format`
--

DROP TABLE IF EXISTS `code_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `code_format` (
  `code_format_code` varchar(50) NOT NULL,
  `classification_code` varchar(50) DEFAULT NULL,
  `code_field` varchar(50) DEFAULT NULL,
  `format` json NOT NULL,
  `active` tinyint NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`code_format_code`),
  UNIQUE KEY `UC_code_format` (`classification_code`,`code_field`),
  CONSTRAINT `fk_classification_code_format` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `code_format_option`
--

DROP TABLE IF EXISTS `code_format_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `code_format_option` (
  `classification_code` varchar(50) NOT NULL,
  `code_field` varchar(50) NOT NULL,
  `option` varchar(50) NOT NULL,
  `subset_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`classification_code`,`code_field`,`option`),
  CONSTRAINT `fk_classification_code_format_option` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_code` varchar(50) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`company_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_type`
--

DROP TABLE IF EXISTS `date_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `date_type` (
  `date_type_code` varchar(50) NOT NULL,
  `date_type_name` varchar(100) DEFAULT NULL,
  `date_type_type` enum('USAGE','SALES') NOT NULL DEFAULT 'USAGE',
  `date_type_impact` enum('EXCLUDE','INCLUDE','IGNORE') NOT NULL DEFAULT 'INCLUDE',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`date_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discount_group`
--

DROP TABLE IF EXISTS `discount_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_group` (
  `discount_group_code` varchar(60) NOT NULL,
  `discount_group_name` varchar(60) DEFAULT NULL,
  `discount_group_description` varchar(255) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`discount_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `distribution_channel`
--

DROP TABLE IF EXISTS `distribution_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `distribution_channel` (
  `distribution_channel_code` varchar(50) NOT NULL,
  `distribution_channel_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`distribution_channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `division` (
  `division_code` varchar(50) NOT NULL,
  `division_name` varchar(100) NOT NULL,
  `company_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`division_code`),
  KEY `fk_company_company_idx` (`company_code`),
  CONSTRAINT `fk_company_company` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duration`
--

DROP TABLE IF EXISTS `duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duration` (
  `duration` int NOT NULL,
  PRIMARY KEY (`duration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_history`
--

DROP TABLE IF EXISTS `export_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_history` (
  `filename` varchar(50) NOT NULL,
  `author` varchar(45) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `uploaded` tinyint DEFAULT NULL,
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `export_template`
--

DROP TABLE IF EXISTS `export_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `export_template` (
  `template_code` varchar(50) NOT NULL,
  `template_name` varchar(100) DEFAULT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `definition` json DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frequency`
--

DROP TABLE IF EXISTS `frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frequency` (
  `frequency_code` varchar(50) NOT NULL,
  `frequency_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`frequency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_code` varchar(50) NOT NULL,
  `location_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `location_type` varchar(50) NOT NULL,
  PRIMARY KEY (`location_code`),
  KEY `fk_location_location_type` (`location_type`),
  CONSTRAINT `fk_location_location_type` FOREIGN KEY (`location_type`) REFERENCES `location_type` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location_type`
--

DROP TABLE IF EXISTS `location_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_type` (
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market`
--

DROP TABLE IF EXISTS `market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market` (
  `market_code` varchar(50) NOT NULL,
  `market_name` varchar(100) DEFAULT NULL,
  `market_group_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`market_code`),
  KEY `fk_market_market_group1_idx` (`market_group_code`),
  CONSTRAINT `fk_market_market_group1` FOREIGN KEY (`market_group_code`) REFERENCES `market_group` (`market_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market_group`
--

DROP TABLE IF EXISTS `market_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_group` (
  `market_group_code` varchar(50) NOT NULL,
  `market_group_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`market_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market_segment`
--

DROP TABLE IF EXISTS `market_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_segment` (
  `market_segment_code` varchar(50) NOT NULL,
  `offer_code` varchar(50) DEFAULT NULL,
  `product_code` varchar(150) DEFAULT NULL,
  `plan_type_code` varchar(50) DEFAULT NULL,
  `market_code` varchar(50) DEFAULT NULL,
  `distribution_channel_code` varchar(50) DEFAULT NULL,
  `affiliation_code` varchar(50) DEFAULT NULL,
  `brand_code` varchar(50) DEFAULT NULL,
  `client_group_code` varchar(50) DEFAULT NULL,
  `commission_group_code` varchar(50) DEFAULT NULL,
  `yieldability` enum('NON-YIELDABLE','SEMI-YIELDABLE','FULLY-YIELDABLE') DEFAULT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`market_segment_code`),
  UNIQUE KEY `market_segment_code_UNIQUE` (`market_segment_code`),
  UNIQUE KEY `market_segment_dimensions_UNIQUE` (`offer_code`,`product_code`,`plan_type_code`,`market_code`,`distribution_channel_code`,`affiliation_code`,`brand_code`,`client_group_code`,`commission_group_code`,`yieldability`),
  KEY `idx_market_segment_product_code` (`product_code`),
  KEY `idx_market_segment_plan_type_code` (`plan_type_code`),
  KEY `idx_market_segment_market_code` (`market_code`),
  KEY `idx_market_segment_distribution_channel_code` (`distribution_channel_code`),
  KEY `idx_market_segment_affiliation_code` (`affiliation_code`),
  KEY `idx_market_segment_brand_code` (`brand_code`),
  KEY `idx_market_segment_client_group_code` (`client_group_code`),
  KEY `idx_market_segment_commission_group_code` (`commission_group_code`),
  KEY `idx_market_segment_yieldability` (`yieldability`),
  CONSTRAINT `fk_market_segment_affiliation_code` FOREIGN KEY (`affiliation_code`) REFERENCES `affiliation` (`affiliation_code`),
  CONSTRAINT `fk_market_segment_brand_code` FOREIGN KEY (`brand_code`) REFERENCES `brand` (`brand_code`),
  CONSTRAINT `fk_market_segment_client_group_code` FOREIGN KEY (`client_group_code`) REFERENCES `client_group` (`client_group_code`),
  CONSTRAINT `fk_market_segment_distribution_channel_code` FOREIGN KEY (`distribution_channel_code`) REFERENCES `distribution_channel` (`distribution_channel_code`),
  CONSTRAINT `fk_market_segment_market_code` FOREIGN KEY (`market_code`) REFERENCES `market` (`market_code`),
  CONSTRAINT `fk_market_segment_offer_code` FOREIGN KEY (`offer_code`) REFERENCES `offer` (`offer_code`),
  CONSTRAINT `fk_market_segment_plan_type_code` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`),
  CONSTRAINT `fk_market_segment_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `market_segment_condition`
--

DROP TABLE IF EXISTS `market_segment_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `market_segment_condition` (
  `market_segment_condition_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `market_segment_code` varchar(50) NOT NULL,
  `market_segment_condition` enum('DepositRequirements','Non-Refundable/Advanced Purchase','LimitedCancellationWindow','LimitedBookingWindow','MinLOSRequired','LimitedModificationsAllowed','LimitedChannel/Source','LimitedDOWRequirements') DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`market_segment_condition_id`),
  UNIQUE KEY `market_segment_condition_UNIQUE` (`market_segment_code`,`market_segment_condition`),
  KEY `idx_condition` (`market_segment_condition`,`market_segment_code`),
  CONSTRAINT `fk_market_segment_code` FOREIGN KEY (`market_segment_code`) REFERENCES `market_segment` (`market_segment_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `method`
--

DROP TABLE IF EXISTS `method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `method` (
  `method_code` varchar(50) NOT NULL,
  `method_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`method_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offer`
--

DROP TABLE IF EXISTS `offer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer` (
  `offer_code` varchar(50) NOT NULL,
  `offer_name` varchar(200) DEFAULT NULL,
  `classification_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`offer_code`),
  KEY `fk_offer_classification` (`classification_code`),
  CONSTRAINT `fk_offer_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offer_product`
--

DROP TABLE IF EXISTS `offer_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer_product` (
  `offer_product_id` varchar(50) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `offer_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`offer_product_id`),
  UNIQUE KEY `offer_product_UNIQUE` (`product_code`,`offer_code`),
  KEY `fk_offer_product_offer_code_idx` (`offer_code`),
  KEY `fk_offer_product_product_code_idx` (`product_code`),
  CONSTRAINT `fk_offer_product_offer_code` FOREIGN KEY (`offer_code`) REFERENCES `offer` (`offer_code`),
  CONSTRAINT `fk_offer_product_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plan_type`
--

DROP TABLE IF EXISTS `plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_type` (
  `plan_type_code` varchar(50) NOT NULL,
  `plan_type_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`plan_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plan_type_classification`
--

DROP TABLE IF EXISTS `plan_type_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_type_classification` (
  `plan_type_classification_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `classification_code` varchar(50) DEFAULT NULL,
  `plan_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`plan_type_classification_id`),
  KEY `fk_classification_code` (`classification_code`),
  KEY `fk_classification_plan_type_code` (`plan_type_code`),
  CONSTRAINT `fk_classification_code` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_classification_plan_type_code` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy`
--

DROP TABLE IF EXISTS `policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy` (
  `policy_id` bigint NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(50) DEFAULT NULL,
  `policy_name` varchar(100) DEFAULT NULL,
  `policy_description` varchar(100) DEFAULT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2033 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_rule_financial`
--

DROP TABLE IF EXISTS `policy_rule_financial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_rule_financial` (
  `rule_id` bigint NOT NULL AUTO_INCREMENT,
  `policy_id` bigint NOT NULL,
  `policy_type` varchar(20) NOT NULL,
  `effective_date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `attribute_id` bigint NOT NULL,
  `attribute_value_sequence` int NOT NULL,
  `attribute_value` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_id`),
  KEY `fk_policy_rule_financial_policy_id` (`policy_id`),
  KEY `fk_policy_rule_financial_policy_type` (`policy_type`),
  KEY `fk_policy_rule_financial_cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_policy_rule_financial_cc_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_policy_rule_financial_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`),
  CONSTRAINT `fk_policy_rule_financial_policy_type` FOREIGN KEY (`policy_type`) REFERENCES `policy_type` (`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_rule_information`
--

DROP TABLE IF EXISTS `policy_rule_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_rule_information` (
  `rule_id` bigint NOT NULL AUTO_INCREMENT,
  `policy_id` bigint NOT NULL,
  `policy_type` varchar(20) NOT NULL,
  `effective_date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `attribute_id` bigint NOT NULL,
  `attribute_value_sequence` int NOT NULL,
  `attribute_value` varchar(100) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_id`),
  KEY `fk_policy_rule_information_policy_id` (`policy_id`),
  KEY `fk_policy_rule_information_policy_type` (`policy_type`),
  KEY `fk_policy_rule_information_cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_policy_rule_information_cc_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_policy_rule_information_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`),
  CONSTRAINT `fk_policy_rule_information_policy_type` FOREIGN KEY (`policy_type`) REFERENCES `policy_type` (`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_set`
--

DROP TABLE IF EXISTS `policy_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_set` (
  `policy_id` bigint NOT NULL,
  `policy_type` varchar(20) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`policy_id`,`policy_type`),
  KEY `fk_policy_set_policy_type` (`policy_type`),
  CONSTRAINT `fk_policy_set_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`),
  CONSTRAINT `fk_policy_set_policy_type` FOREIGN KEY (`policy_type`) REFERENCES `policy_type` (`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `policy_type`
--

DROP TABLE IF EXISTS `policy_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `policy_type` (
  `policy_type` varchar(20) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_code` varchar(150) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `source_product_template_code` varchar(50) DEFAULT NULL,
  `status_code` varchar(50) NOT NULL,
  `min_total` int DEFAULT NULL,
  `max_total` int DEFAULT NULL,
  `min_any` int DEFAULT NULL,
  `max_any` int DEFAULT NULL,
  `min_adult` int DEFAULT NULL,
  `max_adult` int DEFAULT NULL,
  `min_child` int DEFAULT NULL,
  `max_child` int DEFAULT NULL,
  `min_infant` int DEFAULT NULL,
  `max_infant` int DEFAULT NULL,
  `std_any` int DEFAULT NULL,
  `std_adult` int DEFAULT NULL,
  `std_child` int DEFAULT NULL,
  `std_infant` int DEFAULT NULL,
  `days_to_arrival_from` int DEFAULT NULL,
  `days_to_arrival_to` int DEFAULT NULL,
  `sales_start_dts` datetime NOT NULL,
  `sales_end_dts` datetime DEFAULT NULL,
  `usage_start_dts` datetime NOT NULL,
  `usage_end_dts` datetime DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `source_product_code` varchar(150) DEFAULT NULL,
  `classification_code` varchar(50) NOT NULL,
  PRIMARY KEY (`product_code`),
  KEY `fk_product_product_template_idx` (`source_product_template_code`),
  KEY `fk_product_status_idx` (`status_code`),
  KEY `idx_product_source_template` (`source_product_template_code`),
  KEY `idx_product_source_product` (`source_product_code`),
  KEY `idx_product_classification` (`classification_code`),
  KEY `idx_min_max_adult` (`min_adult`,`max_adult`),
  KEY `idx_max_adult` (`max_adult`),
  KEY `idx_min_max_child` (`min_child`,`max_child`),
  KEY `idx_max_child` (`max_child`),
  KEY `idx_min_max_infant` (`min_infant`,`max_infant`),
  KEY `idx_max_infant` (`max_infant`),
  KEY `idx_min_max_any` (`min_any`,`max_any`),
  KEY `idx_max_any` (`max_any`),
  CONSTRAINT `fk_product_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`),
  CONSTRAINT `fk_product_source_product` FOREIGN KEY (`source_product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_source_template` FOREIGN KEY (`source_product_template_code`) REFERENCES `product_template` (`product_template_code`),
  CONSTRAINT `fk_product_status` FOREIGN KEY (`status_code`) REFERENCES `status` (`status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_affiliation`
--

DROP TABLE IF EXISTS `product_affiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_affiliation` (
  `product_affiliation_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `affiliation_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_affiliation_id`),
  UNIQUE KEY `product_affiliation_UNIQUE` (`product_code`,`affiliation_code`),
  KEY `fk_product_affiliation_affiliation_code_idx` (`affiliation_code`),
  KEY `fk_product_affiliation_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_affiliation_affiliation_code` FOREIGN KEY (`affiliation_code`) REFERENCES `affiliation` (`affiliation_code`),
  CONSTRAINT `fk_product_affiliation_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_age`
--

DROP TABLE IF EXISTS `product_age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_age` (
  `product_age_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `age_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_age_id`),
  UNIQUE KEY `product_age_UNIQUE` (`product_code`,`age_code`),
  KEY `fk_product_age_product_idx` (`product_code`),
  KEY `fk_product_age_age_idx` (`age_code`),
  CONSTRAINT `fk_product_age_on_age` FOREIGN KEY (`age_code`) REFERENCES `age` (`age_code`),
  CONSTRAINT `fk_product_age_on_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_attribute`
--

DROP TABLE IF EXISTS `product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attribute` (
  `product_attribute_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `attribute_code` varchar(50) NOT NULL,
  `product_attribute_value` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `attribute_value_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_attribute_id`),
  UNIQUE KEY `idx_product_attribute_UNIQUE` (`product_code`,`attribute_code`,`attribute_value_id`),
  KEY `idx_product_attribute_attribute` (`attribute_code`),
  KEY `idx_product_attribute_product` (`product_code`),
  CONSTRAINT `fk_product_attribute_attribute` FOREIGN KEY (`attribute_code`) REFERENCES `attribute` (`attribute_code`),
  CONSTRAINT `fk_product_attribute_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_brand`
--

DROP TABLE IF EXISTS `product_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_brand` (
  `product_brand_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `brand_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_brand_id`),
  UNIQUE KEY `product_brand_UNIQUE` (`product_code`,`brand_code`),
  KEY `fk_product_brand_brand_code_idx` (`brand_code`),
  KEY `fk_product_brand_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_brand_brand_code` FOREIGN KEY (`brand_code`) REFERENCES `brand` (`brand_code`),
  CONSTRAINT `fk_product_brand_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_bundle_category`
--

DROP TABLE IF EXISTS `product_bundle_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_category` (
  `product_bundle_category_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `classification_code` varchar(50) NOT NULL,
  `discount_group_code` varchar(60) DEFAULT NULL,
  `optional` tinyint NOT NULL,
  `selectable` tinyint NOT NULL,
  `min_selection` int DEFAULT NULL,
  `max_selection` int DEFAULT NULL,
  `duration_modifier` int DEFAULT '0',
  `duration_min` int DEFAULT NULL,
  `duration_max` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `frequency_code` enum('ONE_TIME','PER_DAY','PER_NIGHT','INHERIT_PARENT_DURATION') DEFAULT NULL,
  `method_code` enum('PER_GUEST','PER_ITEM') DEFAULT NULL,
  PRIMARY KEY (`product_bundle_category_id`),
  UNIQUE KEY `idx_product_bundle_category_UNIQUE` (`product_code`,`classification_code`,`optional`,`selectable`),
  KEY `idx_product_bundle_category_product` (`product_code`),
  KEY `idx_product_bundle_category_product_classification` (`classification_code`),
  KEY `idx_product_bundle_category_discount_group` (`discount_group_code`),
  CONSTRAINT `fk_product_bundle_category_discount_group` FOREIGN KEY (`discount_group_code`) REFERENCES `discount_group` (`discount_group_code`),
  CONSTRAINT `fk_product_bundle_category_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_bundle_category_product_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_bundle_category_bkp`
--

DROP TABLE IF EXISTS `product_bundle_category_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_category_bkp` (
  `product_bundle_category_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `classification_code` varchar(50) NOT NULL,
  `discount_group_code` varchar(60) DEFAULT NULL,
  `optional` tinyint NOT NULL,
  `selectable` tinyint NOT NULL,
  `max_selection` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `frequency_code` varchar(50) DEFAULT NULL,
  `method_code` varchar(50) DEFAULT NULL,
  `min_los` int DEFAULT NULL,
  `max_los` int DEFAULT NULL,
  PRIMARY KEY (`product_bundle_category_id`,`product_code`,`classification_code`),
  UNIQUE KEY `idx_product_bundle_category_UNIQUE` (`product_code`,`classification_code`,`optional`,`selectable`,`frequency_code`,`method_code`,`min_los`,`max_los`),
  KEY `idx_product_bundle_category_product` (`product_code`),
  KEY `idx_product_bundle_category_product_classification` (`classification_code`),
  KEY `idx_product_bundle_category_discount_group` (`discount_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_bundle_component`
--

DROP TABLE IF EXISTS `product_bundle_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_component` (
  `product_bundle_component_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_bundle_category_id` varchar(36) NOT NULL,
  `product_code` varchar(150) DEFAULT NULL,
  `component_product_code` varchar(150) DEFAULT NULL,
  `portfolio_product_code` varchar(150) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_bundle_component_id`),
  UNIQUE KEY `uk_product_bundle_component` (`product_bundle_category_id`,`product_code`,`component_product_code`),
  KEY `fk_product_bundle_component_product_idx` (`component_product_code`),
  KEY `fk_product_bundle_product_idx` (`product_code`),
  KEY `fk_product_component_product_idx` (`product_code`,`component_product_code`),
  KEY `idx_product_bundle_component_bundle_category` (`product_bundle_category_id`),
  KEY `fk_product_bundle_component_portfolio` (`portfolio_product_code`),
  CONSTRAINT `fk_bundle_components_component_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_bundle_components_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_bundle_component_bundle_category` FOREIGN KEY (`product_bundle_category_id`) REFERENCES `product_bundle_category` (`product_bundle_category_id`),
  CONSTRAINT `fk_product_bundle_component_portfolio` FOREIGN KEY (`portfolio_product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_channel`
--

DROP TABLE IF EXISTS `product_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_channel` (
  `product_channel_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `channel_map_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_channel_id`),
  UNIQUE KEY `product_code_channel_map_code_UNIQUE` (`product_code`,`channel_map_code`),
  KEY `fk_product_channel_product_idx` (`product_code`),
  KEY `fk_product_channel_channel_map_idx` (`channel_map_code`),
  CONSTRAINT `fk_product_channel_channel_map` FOREIGN KEY (`channel_map_code`) REFERENCES `channel_map` (`channel_map_code`),
  CONSTRAINT `fk_product_channel_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_client_group`
--

DROP TABLE IF EXISTS `product_client_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_client_group` (
  `product_client_group_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `client_group_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_client_group_id`),
  UNIQUE KEY `product_client_group_UNIQUE` (`product_code`,`client_group_code`),
  KEY `fk_product_client_group_group_code_idx` (`client_group_code`),
  KEY `fk_product_client_group_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_client_group_group_code` FOREIGN KEY (`client_group_code`) REFERENCES `client_group` (`client_group_code`),
  CONSTRAINT `fk_product_client_group_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_company`
--

DROP TABLE IF EXISTS `product_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_company` (
  `product_company_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `company_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_company_id`),
  UNIQUE KEY `product_company_UNIQUE` (`product_code`,`company_code`),
  KEY `fk_product_company_company_code_idx` (`company_code`),
  KEY `fk_product_company_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_company_company_code` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_code`),
  CONSTRAINT `fk_product_company_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_date_type`
--

DROP TABLE IF EXISTS `product_date_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_date_type` (
  `product_date_type_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `date_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_date_type_id`),
  KEY `fk_product_date_type_product_code` (`product_code`),
  KEY `fk_product_date_code` (`date_type_code`),
  CONSTRAINT `fk_product_date_code` FOREIGN KEY (`date_type_code`) REFERENCES `date_type` (`date_type_code`),
  CONSTRAINT `fk_product_date_type_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_date_type_date`
--

DROP TABLE IF EXISTS `product_date_type_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_date_type_date` (
  `product_date_type_date_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_date_type_id` varchar(36) NOT NULL,
  `date_type_date` timestamp NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_date_type_date_id`),
  KEY `fk_product_date_type_id` (`product_date_type_id`),
  CONSTRAINT `fk_pdtd_product_date_type_id` FOREIGN KEY (`product_date_type_id`) REFERENCES `product_date_type` (`product_date_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_date_type_date_backup`
--

DROP TABLE IF EXISTS `product_date_type_date_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_date_type_date_backup` (
  `product_date_type_date_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_date_type_id` varchar(36) NOT NULL,
  `date_type_date` timestamp NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_date_type_date_id`),
  KEY `fk_product_date_type_id` (`product_date_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_date_type_date_old`
--

DROP TABLE IF EXISTS `product_date_type_date_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_date_type_date_old` (
  `product_date_type_date_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_date_type_id` varchar(36) NOT NULL,
  `date_type_date` timestamp NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_date_type_date_id`),
  KEY `fk_product_date_type_id` (`product_date_type_id`),
  CONSTRAINT `fk_product_date_type_id` FOREIGN KEY (`product_date_type_id`) REFERENCES `product_date_type` (`product_date_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_discount_group`
--

DROP TABLE IF EXISTS `product_discount_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_discount_group` (
  `product_discount_group_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `discount_group_code` varchar(60) NOT NULL,
  `default_discount_group` tinyint(1) DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_discount_group_id`),
  UNIQUE KEY `product_discount_group_UNIQUE` (`product_code`,`discount_group_code`),
  KEY `fk_product_discount_group_discount_group_idx` (`discount_group_code`),
  KEY `fk_product_discount_group_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_discount_group_discount_group` FOREIGN KEY (`discount_group_code`) REFERENCES `discount_group` (`discount_group_code`),
  CONSTRAINT `fk_product_discount_group_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_distribution_channel`
--

DROP TABLE IF EXISTS `product_distribution_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_distribution_channel` (
  `product_distribution_channel_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `distribution_channel_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_distribution_channel_id`),
  UNIQUE KEY `product_distribution_channel_UNIQUE` (`product_code`,`distribution_channel_code`),
  KEY `fk_product_distribution_code_idx` (`distribution_channel_code`),
  KEY `fk_product_distribution_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_distribution_code` FOREIGN KEY (`distribution_channel_code`) REFERENCES `distribution_channel` (`distribution_channel_code`),
  CONSTRAINT `fk_product_distribution_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_division`
--

DROP TABLE IF EXISTS `product_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_division` (
  `product_division_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `division_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_division_id`),
  UNIQUE KEY `product_division_UNIQUE` (`product_code`,`division_code`),
  KEY `fk_product_division_division_code_idx` (`division_code`),
  KEY `fk_product_division_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_division_division_code` FOREIGN KEY (`division_code`) REFERENCES `division` (`division_code`),
  CONSTRAINT `fk_product_division_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_duration`
--

DROP TABLE IF EXISTS `product_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_duration` (
  `product_code` varchar(150) NOT NULL,
  `duration` int NOT NULL,
  `duration_uom` enum('days','time') NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_code`,`duration`),
  KEY `fk_product_duration_product_idx` (`product_code`),
  CONSTRAINT `fk_product_duration_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_location`
--

DROP TABLE IF EXISTS `product_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_location` (
  `product_location_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `location_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_location_id`),
  UNIQUE KEY `product_location_product_UNIQUE` (`product_code`,`location_code`),
  KEY `fk_product_location_location_idx` (`location_code`),
  KEY `fk_product_location_product_idx` (`product_code`),
  CONSTRAINT `fk_product_location_on_location` FOREIGN KEY (`location_code`) REFERENCES `location` (`location_code`),
  CONSTRAINT `fk_product_location_on_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_lock`
--

DROP TABLE IF EXISTS `product_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_lock` (
  `lock_id` varchar(36) NOT NULL COMMENT 'Unique lock identifier (UUID)',
  `product_code` varchar(150) NOT NULL COMMENT 'Product code being locked',
  `created_by` varchar(20) NOT NULL COMMENT 'User who created the lock record',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'UTC timestamp when the lock record was created (lock acquired)',
  `updated_by` varchar(20) DEFAULT NULL COMMENT 'User who last updated the lock record',
  `updated_on` timestamp NULL DEFAULT NULL COMMENT 'UTC timestamp when the lock record was last updated',
  PRIMARY KEY (`lock_id`),
  UNIQUE KEY `product_code` (`product_code`),
  KEY `idx_product_lock_locked_by_user_id` (`created_by`),
  KEY `idx_product_lock_user_product` (`created_by`,`product_code`),
  CONSTRAINT `fk_product_lock_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Tracks product locks for exclusive editing';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_market`
--

DROP TABLE IF EXISTS `product_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_market` (
  `product_market_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `market_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_market_id`),
  UNIQUE KEY `product_market_UNIQUE` (`product_code`,`market_code`),
  KEY `fk_product_market_market_code_idx` (`market_code`),
  KEY `fk_product_market_product_code_idx` (`product_code`),
  CONSTRAINT `fk_product_market_market_code` FOREIGN KEY (`market_code`) REFERENCES `market` (`market_code`),
  CONSTRAINT `fk_product_market_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_party_mix_grid`
--

DROP TABLE IF EXISTS `product_party_mix_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_party_mix_grid` (
  `product_code` varchar(150) NOT NULL,
  `sequence` int NOT NULL,
  `total_count` int NOT NULL,
  `adult_count` int NOT NULL,
  `child_count` int NOT NULL,
  `infant_count` int NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_code`,`sequence`),
  KEY `idx_total_count` (`total_count`),
  KEY `idx_adult_count` (`adult_count`),
  KEY `idx_child_count` (`child_count`),
  KEY `idx_infant_count` (`infant_count`),
  KEY `idx_adult_child_count` (`adult_count`,`child_count`),
  KEY `idx_adult_child_infant_count` (`adult_count`,`child_count`,`infant_count`),
  KEY `idx_adult_infant_count` (`adult_count`,`infant_count`),
  KEY `idx_total_adult_child_infant_count` (`total_count`,`adult_count`,`child_count`,`infant_count`),
  KEY `idx_total_adult_infant_count` (`total_count`,`adult_count`,`infant_count`),
  CONSTRAINT `fk_product_party_mix_grid` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_plan_type`
--

DROP TABLE IF EXISTS `product_plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_plan_type` (
  `product_plan_type_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) DEFAULT NULL,
  `plan_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_plan_type_id`),
  KEY `fk_product_code` (`product_code`),
  KEY `fk_product_plan_type_code` (`plan_type_code`),
  CONSTRAINT `fk_product_code` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_plan_type_code` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_policy`
--

DROP TABLE IF EXISTS `product_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_policy` (
  `product_code` varchar(150) NOT NULL,
  `policy_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_code`,`policy_id`),
  KEY `fk_product_policy_policy_id` (`policy_id`),
  CONSTRAINT `fk_product_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`),
  CONSTRAINT `fk_product_policy_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_rate_grid`
--

DROP TABLE IF EXISTS `product_rate_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_rate_grid` (
  `product_rate_grid_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_code` varchar(150) NOT NULL,
  `rate_grid_code` varchar(150) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_rate_grid_id`),
  UNIQUE KEY `product_rate_grid_unique` (`product_code`,`rate_grid_code`),
  KEY `fk_product_rate_grid_rate_grid` (`rate_grid_code`),
  CONSTRAINT `fk_product_rate_grid_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_rate_grid_rate_grid` FOREIGN KEY (`rate_grid_code`) REFERENCES `rate_grid` (`rate_grid_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_set`
--

DROP TABLE IF EXISTS `product_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_set` (
  `product_set_code` varchar(150) NOT NULL,
  `product_set_name` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_set_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_set_product`
--

DROP TABLE IF EXISTS `product_set_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_set_product` (
  `product_set_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_set_code` varchar(150) NOT NULL,
  `product_code` varchar(150) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_set_id`),
  UNIQUE KEY `product_set_code_product_code_UNIQUE` (`product_set_code`,`product_code`),
  KEY `fk_product_set_product_product_idx` (`product_code`),
  KEY `fk_product_set_product_product_set_idx` (`product_set_code`),
  CONSTRAINT `fk_product_set_product_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_product_set_product_product_set` FOREIGN KEY (`product_set_code`) REFERENCES `product_set` (`product_set_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template`
--

DROP TABLE IF EXISTS `product_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template` (
  `product_template_code` varchar(50) NOT NULL,
  `product_template_name` varchar(100) DEFAULT NULL,
  `inactive` tinyint NOT NULL DEFAULT '0',
  `classification_code` varchar(50) NOT NULL,
  `min_total` int DEFAULT NULL,
  `max_total` int DEFAULT NULL,
  `min_any` int DEFAULT NULL,
  `max_any` int DEFAULT NULL,
  `min_adult` int DEFAULT NULL,
  `max_adult` int DEFAULT NULL,
  `min_child` int DEFAULT NULL,
  `max_child` int DEFAULT NULL,
  `min_infant` int DEFAULT NULL,
  `max_infant` int DEFAULT NULL,
  `std_any` int DEFAULT NULL,
  `std_adult` int DEFAULT NULL,
  `std_child` int DEFAULT NULL,
  `std_infant` int DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_code`),
  KEY `fk_product_template_product_classification_idx` (`classification_code`),
  CONSTRAINT `fk_product_template_product_classification` FOREIGN KEY (`classification_code`) REFERENCES `classification` (`classification_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_affiliation`
--

DROP TABLE IF EXISTS `product_template_affiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_affiliation` (
  `product_affiliation_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) DEFAULT NULL,
  `affiliation_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_affiliation_id`),
  UNIQUE KEY `product_template_affiliation_UNIQUE` (`product_template_code`,`affiliation_code`),
  KEY `fk_product_template_affiliation_affiliation_code_idx` (`affiliation_code`),
  KEY `fk_product_template_affiliation_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_affiliation_affiliation_code` FOREIGN KEY (`affiliation_code`) REFERENCES `affiliation` (`affiliation_code`),
  CONSTRAINT `fk_product_template_affiliation_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_age`
--

DROP TABLE IF EXISTS `product_template_age`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_age` (
  `product_template_age_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `age_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_age_id`),
  UNIQUE KEY `product_template_age_UNIQUE` (`product_template_code`,`age_code`),
  KEY `fk_product_template_age_product_template_idx` (`product_template_code`),
  KEY `fk_product_template_age_age_idx` (`age_code`),
  CONSTRAINT `fk_product_age_age` FOREIGN KEY (`age_code`) REFERENCES `age` (`age_code`),
  CONSTRAINT `fk_product_age_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_attribute`
--

DROP TABLE IF EXISTS `product_template_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_attribute` (
  `product_template_attribute_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `attribute_code` varchar(50) NOT NULL,
  `product_attribute_value` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `attribute_value_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_template_attribute_id`),
  UNIQUE KEY `product_attribute_UNIQUE` (`product_template_code`,`attribute_code`,`attribute_value_id`),
  KEY `fk_product_template_attribute_attribute_idx` (`attribute_code`),
  KEY `fk_product_template_attribute_product_template_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_attribute_value_attribute` FOREIGN KEY (`attribute_code`) REFERENCES `attribute` (`attribute_code`),
  CONSTRAINT `fk_product_template_attribute_value_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_brand`
--

DROP TABLE IF EXISTS `product_template_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_brand` (
  `product_template_brand_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `brand_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_brand_id`),
  UNIQUE KEY `product_template_brand_UNIQUE` (`product_template_code`,`brand_code`),
  KEY `fk_product_template_brand_brand_code_idx` (`brand_code`),
  KEY `fk_product_template_brand_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_brand_brand_code` FOREIGN KEY (`brand_code`) REFERENCES `brand` (`brand_code`),
  CONSTRAINT `fk_product_template_brand_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_channel`
--

DROP TABLE IF EXISTS `product_template_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_channel` (
  `product_template_channel_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `channel_map_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_channel_id`),
  UNIQUE KEY `product_template_code_channel_map_code_UNIQUE` (`product_template_code`,`channel_map_code`),
  KEY `idx_product_template_channel_product` (`product_template_code`),
  KEY `idx_product_template_channel_channel_map` (`channel_map_code`),
  CONSTRAINT `fk_product_template_channel_channel_map` FOREIGN KEY (`channel_map_code`) REFERENCES `channel_map` (`channel_map_code`),
  CONSTRAINT `fk_product_template_channel_product` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_client_group`
--

DROP TABLE IF EXISTS `product_template_client_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_client_group` (
  `product_client_group_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) DEFAULT NULL,
  `client_group_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_client_group_id`),
  UNIQUE KEY `product_template_client_group_UNIQUE` (`product_template_code`,`client_group_code`),
  KEY `fk_product_template_client_group_group_code_idx` (`client_group_code`),
  KEY `fk_product_template_client_group_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_client_group_group_code` FOREIGN KEY (`client_group_code`) REFERENCES `client_group` (`client_group_code`),
  CONSTRAINT `fk_product_template_client_group_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_company`
--

DROP TABLE IF EXISTS `product_template_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_company` (
  `product_template_company_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `company_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_company_id`),
  UNIQUE KEY `product_template_company_UNIQUE` (`product_template_code`,`company_code`),
  KEY `fk_product_template_company_company_code_idx` (`company_code`),
  KEY `fk_product_template_company_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_company_company_code` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_code`),
  CONSTRAINT `fk_product_template_company_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_distribution_channel`
--

DROP TABLE IF EXISTS `product_template_distribution_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_distribution_channel` (
  `product_distribution_channel_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) DEFAULT NULL,
  `distribution_channel_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_distribution_channel_id`),
  UNIQUE KEY `product_template_distribution_channel_UNIQUE` (`product_template_code`,`distribution_channel_code`),
  KEY `fk_product_template_distribution_code_idx` (`distribution_channel_code`),
  KEY `fk_product_template_distribution_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_distribution_code` FOREIGN KEY (`distribution_channel_code`) REFERENCES `distribution_channel` (`distribution_channel_code`),
  CONSTRAINT `fk_product_template_distribution_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_division`
--

DROP TABLE IF EXISTS `product_template_division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_division` (
  `product_template_division_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `division_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_division_id`),
  UNIQUE KEY `product_template_division_UNIQUE` (`product_template_code`,`division_code`),
  KEY `fk_product_template_division_division_code_idx` (`division_code`),
  KEY `fk_product_template_division_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_division_division_code` FOREIGN KEY (`division_code`) REFERENCES `division` (`division_code`),
  CONSTRAINT `fk_product_template_division_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_duration`
--

DROP TABLE IF EXISTS `product_template_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_duration` (
  `product_template_code` varchar(50) NOT NULL,
  `duration` int NOT NULL,
  `duration_uom` enum('days','time') NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_code`,`duration`),
  KEY `fk_product_template_duration_product_template_idx` (`product_template_code`),
  CONSTRAINT `fk_product_duration_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_location`
--

DROP TABLE IF EXISTS `product_template_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_location` (
  `product_template_location_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) NOT NULL,
  `location_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_location_id`),
  UNIQUE KEY `product_template_location_product_template_UNIQUE` (`product_template_code`,`location_code`),
  KEY `fk_product_template_location_location_idx` (`location_code`),
  KEY `fk_product_template_location_product_template_idx` (`product_template_code`),
  CONSTRAINT `fk_product_class_location_location` FOREIGN KEY (`location_code`) REFERENCES `location` (`location_code`),
  CONSTRAINT `fk_product_class_location_product_class` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_market`
--

DROP TABLE IF EXISTS `product_template_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_market` (
  `product_template_market_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) DEFAULT NULL,
  `market_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_market_id`),
  UNIQUE KEY `product_template_market_UNIQUE` (`product_template_code`,`market_code`),
  KEY `fk_product_template_market_market_code_idx` (`market_code`),
  KEY `fk_product_template_market_product_code_idx` (`product_template_code`),
  CONSTRAINT `fk_product_template_market_market_code` FOREIGN KEY (`market_code`) REFERENCES `market` (`market_code`),
  CONSTRAINT `fk_product_template_market_product_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_party_mix_grid`
--

DROP TABLE IF EXISTS `product_template_party_mix_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_party_mix_grid` (
  `product_template_code` varchar(50) NOT NULL,
  `sequence` int NOT NULL,
  `total_count` int NOT NULL,
  `adult_count` int NOT NULL,
  `child_count` int NOT NULL,
  `infant_count` int NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_code`,`sequence`),
  CONSTRAINT `fk_product_template_party_mix_grid` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_plan_type`
--

DROP TABLE IF EXISTS `product_template_plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_plan_type` (
  `product_template_plan_type_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `product_template_code` varchar(50) DEFAULT NULL,
  `plan_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_plan_type_id`),
  KEY `fk_product_template_code` (`product_template_code`),
  KEY `fk_plan_type_code` (`plan_type_code`),
  CONSTRAINT `fk_plan_type_code` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`),
  CONSTRAINT `fk_product_template_code` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_template_policy`
--

DROP TABLE IF EXISTS `product_template_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_template_policy` (
  `product_template_code` varchar(50) NOT NULL,
  `policy_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_template_code`,`policy_id`),
  KEY `fk_product_template_policy_policy_id` (`policy_id`),
  CONSTRAINT `fk_product_template_policy_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `policy` (`policy_id`),
  CONSTRAINT `fk_product_template_policy_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_grid`
--

DROP TABLE IF EXISTS `rate_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_grid` (
  `rate_grid_code` varchar(150) NOT NULL,
  `rate_grid_name` varchar(150) DEFAULT NULL,
  `location_code` varchar(50) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rate_grid_code`),
  KEY `fk_rate_grid_location` (`location_code`),
  CONSTRAINT `fk_rate_grid_location` FOREIGN KEY (`location_code`) REFERENCES `location` (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_grid_plan_type`
--

DROP TABLE IF EXISTS `rate_grid_plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_grid_plan_type` (
  `rate_grid_plan_type_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `rate_grid_code` varchar(150) NOT NULL,
  `plan_type_code` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rate_grid_plan_type_id`),
  UNIQUE KEY `rate_grid_plan_type_unique` (`rate_grid_code`,`plan_type_code`),
  KEY `fk_rate_grid_plan_type_plan_type` (`plan_type_code`),
  CONSTRAINT `fk_rate_grid_plan_type_plan_type` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`),
  CONSTRAINT `fk_rate_grid_plan_type_rate_grid` FOREIGN KEY (`rate_grid_code`) REFERENCES `rate_grid` (`rate_grid_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_grid_product`
--

DROP TABLE IF EXISTS `rate_grid_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_grid_product` (
  `rate_grid_product_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `rate_grid_code` varchar(150) NOT NULL,
  `product_code` varchar(150) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rate_grid_product_id`),
  UNIQUE KEY `rate_grid_product_unique` (`rate_grid_code`,`product_code`),
  KEY `fk_rate_grid_product_product` (`product_code`),
  CONSTRAINT `fk_rate_grid_product_product` FOREIGN KEY (`product_code`) REFERENCES `product` (`product_code`),
  CONSTRAINT `fk_rate_grid_product_rate_grid` FOREIGN KEY (`rate_grid_code`) REFERENCES `rate_grid` (`rate_grid_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship` (
  `relationship_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `primary_entity_code` varchar(150) NOT NULL,
  `primary_entity_type` enum('product','classification','client_group','company','brand','market','division','distribution_channel') NOT NULL,
  `related_entity_code` varchar(150) NOT NULL,
  `related_entity_type` enum('product','classification','client_group','company','brand','market','division','distribution_channel') NOT NULL,
  `relationship_type_code` varchar(50) NOT NULL,
  `validity_start` timestamp NULL DEFAULT NULL,
  `validity_end` timestamp NULL DEFAULT NULL,
  `optional` tinyint(1) NOT NULL DEFAULT '0',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `uq_relationship_combination` (`primary_entity_code`,`primary_entity_type`,`related_entity_code`,`related_entity_type`,`relationship_type_code`),
  KEY `idx_relationship_primary_entity` (`primary_entity_code`,`primary_entity_type`),
  KEY `idx_relationship_related_entity` (`related_entity_code`,`related_entity_type`),
  KEY `idx_relationship_type_active` (`relationship_type_code`),
  KEY `idx_relationship_entity_pair` (`primary_entity_code`,`related_entity_code`),
  KEY `idx_relationship_active_type_primary` (`relationship_type_code`,`primary_entity_code`),
  CONSTRAINT `fk_relationship_type_code` FOREIGN KEY (`relationship_type_code`) REFERENCES `relationship_type` (`relationship_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_attribute`
--

DROP TABLE IF EXISTS `relationship_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_attribute` (
  `relationship_attribute_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `relationship_id` varchar(36) NOT NULL,
  `attribute_code` varchar(50) NOT NULL,
  `relationship_attribute_value` varchar(100) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`relationship_attribute_id`),
  UNIQUE KEY `uq_relationship_attribute_combination` (`relationship_id`,`attribute_code`,`relationship_attribute_value`),
  KEY `fk_relationship_attribute_attribute_code` (`attribute_code`),
  KEY `idx_relationship_attribute_relationship` (`relationship_id`),
  KEY `idx_relationship_attribute_compound` (`relationship_id`,`attribute_code`),
  CONSTRAINT `fk_relationship_attribute_attribute_code` FOREIGN KEY (`attribute_code`) REFERENCES `attribute` (`attribute_code`),
  CONSTRAINT `fk_relationship_attribute_relationship_code` FOREIGN KEY (`relationship_id`) REFERENCES `relationship` (`relationship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_rule`
--

DROP TABLE IF EXISTS `relationship_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_rule` (
  `rule_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `relationship_id` varchar(36) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_id`),
  UNIQUE KEY `uq_relationship_rule_relationship` (`relationship_id`),
  CONSTRAINT `fk_relationship_rule_relationship` FOREIGN KEY (`relationship_id`) REFERENCES `relationship` (`relationship_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_rule_group`
--

DROP TABLE IF EXISTS `relationship_rule_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_rule_group` (
  `rule_id` varchar(36) NOT NULL,
  `rule_group_code` int NOT NULL,
  `rule_group_logic` enum('include','exclude') NOT NULL,
  `quantity` int NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_id`,`rule_group_code`),
  CONSTRAINT `fk_rule_group_rule` FOREIGN KEY (`rule_id`) REFERENCES `relationship_rule` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_rule_group_component`
--

DROP TABLE IF EXISTS `relationship_rule_group_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_rule_group_component` (
  `rule_group_component_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `rule_id` varchar(36) NOT NULL,
  `rule_group_code` int NOT NULL,
  `rule_entity_code` varchar(150) NOT NULL,
  `rule_entity_type` enum('product','classification','client_group','company','brand','market','division','distribution_channel') NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_group_component_id`),
  KEY `fk_rule_group_component_group` (`rule_id`,`rule_group_code`),
  CONSTRAINT `fk_rule_group_component_group` FOREIGN KEY (`rule_id`, `rule_group_code`) REFERENCES `relationship_rule_group` (`rule_id`, `rule_group_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relationship_type` (
  `relationship_type_code` varchar(50) NOT NULL,
  `relationship_type_name` varchar(50) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_type`
--

DROP TABLE IF EXISTS `rule_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_type` (
  `rule_type` varchar(20) NOT NULL,
  `policy_type` varchar(20) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_type`),
  KEY `fk_rule_type_policy_type` (`policy_type`),
  CONSTRAINT `fk_rule_type_policy_type` FOREIGN KEY (`policy_type`) REFERENCES `policy_type` (`policy_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rule_type_client_attribute`
--

DROP TABLE IF EXISTS `rule_type_client_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule_type_client_attribute` (
  `rule_type` varchar(20) NOT NULL,
  `attribute_id` bigint NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`rule_type`,`attribute_id`),
  KEY `fk_rule_type_client_attribute_cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_rule_type_client_attribute_cc_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `cc_attribute` (`attribute_id`),
  CONSTRAINT `fk_rule_type_client_attribute_rule_type` FOREIGN KEY (`rule_type`) REFERENCES `rule_type` (`rule_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_version` (
  `version` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sku_exclusion_rule`
--

DROP TABLE IF EXISTS `sku_exclusion_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sku_exclusion_rule` (
  `sku_exclusion_rule_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `inactive` tinyint(1) NOT NULL DEFAULT '0',
  `plan_type_code` varchar(50) DEFAULT NULL,
  `company_code` varchar(50) DEFAULT NULL,
  `division_code` varchar(50) DEFAULT NULL,
  `brand_code` varchar(50) DEFAULT NULL,
  `market_code` varchar(50) DEFAULT NULL,
  `distribution_channel_code` varchar(50) DEFAULT NULL,
  `affiliation_code` varchar(50) DEFAULT NULL,
  `client_group_code` varchar(50) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(50) DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`sku_exclusion_rule_id`),
  UNIQUE KEY `uq_sku_exclusion_combination` (`plan_type_code`,`company_code`,`division_code`,`brand_code`,`market_code`,`distribution_channel_code`,`affiliation_code`,`client_group_code`),
  KEY `fk_sku_exclusion_rule_company_code` (`company_code`),
  KEY `fk_sku_exclusion_rule_division_code` (`division_code`),
  KEY `fk_sku_exclusion_rule_brand_code` (`brand_code`),
  KEY `fk_sku_exclusion_rule_market_code` (`market_code`),
  KEY `fk_sku_exclusion_rule_distribution_channel_code` (`distribution_channel_code`),
  KEY `fk_sku_exclusion_rule_affiliation_code` (`affiliation_code`),
  KEY `fk_sku_exclusion_rule_client_group_code` (`client_group_code`),
  CONSTRAINT `fk_sku_exclusion_rule_affiliation_code` FOREIGN KEY (`affiliation_code`) REFERENCES `affiliation` (`affiliation_code`),
  CONSTRAINT `fk_sku_exclusion_rule_brand_code` FOREIGN KEY (`brand_code`) REFERENCES `brand` (`brand_code`),
  CONSTRAINT `fk_sku_exclusion_rule_client_group_code` FOREIGN KEY (`client_group_code`) REFERENCES `client_group` (`client_group_code`),
  CONSTRAINT `fk_sku_exclusion_rule_company_code` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_code`),
  CONSTRAINT `fk_sku_exclusion_rule_distribution_channel_code` FOREIGN KEY (`distribution_channel_code`) REFERENCES `distribution_channel` (`distribution_channel_code`),
  CONSTRAINT `fk_sku_exclusion_rule_division_code` FOREIGN KEY (`division_code`) REFERENCES `division` (`division_code`),
  CONSTRAINT `fk_sku_exclusion_rule_market_code` FOREIGN KEY (`market_code`) REFERENCES `market` (`market_code`),
  CONSTRAINT `fk_sku_exclusion_rule_plan_type_code` FOREIGN KEY (`plan_type_code`) REFERENCES `plan_type` (`plan_type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `status_code` varchar(50) NOT NULL,
  `status_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `template_bundle_component`
--

DROP TABLE IF EXISTS `template_bundle_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template_bundle_component` (
  `template_bundle_component_id` varchar(36) NOT NULL DEFAULT (uuid()),
  `bundle_category_id` varchar(36) NOT NULL,
  `product_template_code` varchar(50) NOT NULL,
  `component_product_template_code` varchar(50) NOT NULL,
  `portfolio_product_template_code` varchar(50) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(20) NOT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`template_bundle_component_id`),
  UNIQUE KEY `uk_template_bundle_component` (`bundle_category_id`,`product_template_code`,`component_product_template_code`),
  KEY `fk_template_bundle_bundle_category_idx` (`bundle_category_id`),
  KEY `fk_template_bundle_component_product_template_idx` (`component_product_template_code`),
  KEY `fk_template_bundle_product_template_idx` (`product_template_code`),
  KEY `fk_product_template_component_product_template` (`product_template_code`,`component_product_template_code`),
  KEY `fk_template_bundle_component_portfolio` (`portfolio_product_template_code`),
  CONSTRAINT `fk_template_bundle_component_bundle_category` FOREIGN KEY (`bundle_category_id`) REFERENCES `bundle_category` (`bundle_category_id`),
  CONSTRAINT `fk_template_bundle_component_portfolio` FOREIGN KEY (`portfolio_product_template_code`) REFERENCES `product_template` (`product_template_code`),
  CONSTRAINT `fk_template_bundle_component_product_template` FOREIGN KEY (`component_product_template_code`) REFERENCES `product_template` (`product_template_code`),
  CONSTRAINT `fk_template_bundle_product_template` FOREIGN KEY (`product_template_code`) REFERENCES `product_template` (`product_template_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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

-- Dump completed on 2026-04-24 13:03:11
