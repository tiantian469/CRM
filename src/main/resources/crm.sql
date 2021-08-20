CREATE DATABASE  IF NOT EXISTS `crm` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `crm`;
-- MySQL dump 10.13  Distrib 8.0.24, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: crm
-- ------------------------------------------------------
-- Server version	8.0.24

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
-- Table structure for table `tbl_activity`
--

DROP TABLE IF EXISTS `tbl_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_activity`
--

LOCK TABLES `tbl_activity` WRITE;
/*!40000 ALTER TABLE `tbl_activity` DISABLE KEYS */;
INSERT INTO `tbl_activity` VALUES ('05753c5b7aee4583893ab343dae02214','06f5fc056eac41558a964f96daa7f27c','测试1','2021-05-29','2021-04-25','666666','7777777777777777777','2021-05-20 05:21:10','幽灵猫123','2021-07-01 23:28:41','幽灵猫'),('05753c5b7aee4583893ab343dae02216','06f5fc056eac41558a964f96daa7f27c','测试2','2021-04-25','2021-04-26','66666','777777777777777777777777','2021-05-20 05:21:10','幽灵猫456','2021-06-15 18:43:30','幽灵猫'),('05753c5b7aee4583893ab343dae02217','06f5fc056eac41558a964f96daa7f27c','测试3','2021-05-23','2021-04-25','22222222','3333333333333','2021-05-20 05:21:10','幽灵猫','2021-06-15 18:48:30','幽灵猫'),('05753c5b7aee4583893ab343dae02218','06f5fc056eac41558a964f96daa7f27c','测试4','2021-11-25','2022-04-09','77777777777','777777777777777777777777777777777','2021-05-20 05:21:10','幽灵猫','2021-05-26 17:52:16','幽灵猫'),('05753c5b7aee4583893ab343dae02219','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02220','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02221','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02222','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02223','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02224','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02225','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02226','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02227','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02236','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('05753c5b7aee4583893ab343dae02237','06f5fc056eac41558a964f96daa7f27c','123','2021-05-20','2021-05-29','-4750$','123456','2021-05-20 05:21:10','幽灵猫','2021-04-20','幽灵猫'),('36901a6373dd4a049f90d35331658df4','06f5fc056eac41558a964f96daa7f27c','wdnmd1','2021-05-19','2021-05-31','-4750$','wdnmd起把狙给我','2021-04-20','wdnmd',NULL,NULL),('80d4ea6a6db84434aa9b0c5ccb55dc9c','06f5fc056eac41558a964f96daa7f27c','123456','2021-05-20','2021-05-29','-4750$','123456789','2021-05-20 05:21:10','幽灵猫',NULL,NULL),('84daf22983b14e29b33b943471836c46','06f5fc056eac41558a964f96daa7f27c','123456','2021-05-20','2021-05-29','-4750$','123456789','2021-05-20 05:21:10','幽灵猫',NULL,NULL),('9244d4dab23c47599c56b28b88a92c71','06f5fc056eac41558a964f96daa7f27c','wdnmd2','2021-05-19','2021-05-29','-4750$','我起了，一枪秒了，有什么好说的','2021-04-19',NULL,NULL,NULL),('9d341ddc8d5649c3b2f36b07a6f42766','06f5fc056eac41558a964f96daa7f27c','wdnmd3','2021-05-19','2021-06-02','-4750$','wdnmd','2021-05-19 01:59:00','茄子',NULL,NULL),('b6fb98dba044441d93fb310def9fefa2','06f5fc056eac41558a964f96daa7f27c','wdnmd','2021-07-14','2021-07-13','-4750$','123','2021-07-19 00:10:45','幽灵猫',NULL,NULL);
/*!40000 ALTER TABLE `tbl_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_activity_remark`
--

DROP TABLE IF EXISTS `tbl_activity_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0±íÊ¾Î´ÐÞ¸Ä£¬1±íÊ¾ÒÑÐÞ¸Ä',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_activity_remark`
--

LOCK TABLES `tbl_activity_remark` WRITE;
/*!40000 ALTER TABLE `tbl_activity_remark` DISABLE KEYS */;
INSERT INTO `tbl_activity_remark` VALUES ('05753c5b7aee4583893ab343dae02215','这是一条备注！2333','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('05753c5b7aee4583893ab343dae02218','这是一条备注！5555555555','2020-1-1','123','2021-06-28 18:57:32','幽灵猫','1','05753c5b7aee4583893ab343dae02214'),('123453666','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('1234753','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('17b1d35f9097499f986152dc52e8a797','111','2021-06-15 12:47:44','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('1e6f45eaa221436ca7f9117c8358d6e8','23333333333333333333333','2021-06-15 12:51:07','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('2312345','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('2513d3d7414044cb887b77d8d81fc83a','123','2021-06-15 12:49:56','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('4516378','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('45632455','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('4563453','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('4563453123','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('45687945324','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('674845','这是一条备注！','2020-1-1','123','2020-1-2','456','1','05753c5b7aee4583893ab343dae02214'),('97248294e2644ab4b4667322e1b174f4','2333333','2021-06-15 12:52:15','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('98fbf1df941144c9bf5d8dc4fd85e967','13','2021-07-19 00:15:23','幽灵猫',NULL,NULL,'0','b6fb98dba044441d93fb310def9fefa2'),('9c0bfcc12e384e6e991551af71bf659b','13','2021-07-19 00:15:25','幽灵猫',NULL,NULL,'0','b6fb98dba044441d93fb310def9fefa2'),('bcc9644aed0547df8082f29ef5892074','666','2021-06-15 13:00:03','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('c715eee01456440a999e3b0700af41ff','88888888888','2021-06-15 13:02:49','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('c9e513b65c044829b7938bed7fcaa8e7','99999999999999999999999999','2021-06-15 13:08:18','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('d5838c21e3444462b6b10d5899d448db','233333333333','2021-06-15 12:53:10','幽灵猫',NULL,NULL,'0','05753c5b7aee4583893ab343dae02216'),('e597841a22cd470fa59402f477682036','13','2021-07-19 00:15:27','幽灵猫',NULL,NULL,'0','b6fb98dba044441d93fb310def9fefa2');
/*!40000 ALTER TABLE `tbl_activity_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_clue`
--

DROP TABLE IF EXISTS `tbl_clue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_clue`
--

LOCK TABLES `tbl_clue` WRITE;
/*!40000 ALTER TABLE `tbl_clue` DISABLE KEYS */;
INSERT INTO `tbl_clue` VALUES ('a247e01ee372453a916556cc9ee8e20e','幽灵猫','女士','06f5fc056eac41558a964f96daa7f27c','幽灵猫企业！','CEO','1272970733@qq.com','02909145035','www.ghostcat.vip','13209191902','将来联系','web调研','幽灵猫','2021-07-02 16:44:53','幽灵猫','2021-07-05 23:32:52','这是一条测试用描述！',NULL,NULL,'翻斗大街2号楼4001'),('c5f1539a907b4c158b73602ac9469c90','4455555555','夫人','06f5fc056eac41558a964f96daa7f27c','666','666','555555','333','22','5555','需要条件','web调研','幽灵猫','2021-06-26 16:51:01',NULL,NULL,'11111111111','222222222222','2021-06-13','3333333333333');
/*!40000 ALTER TABLE `tbl_clue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_clue_activity_relation`
--

DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_clue_activity_relation`
--

LOCK TABLES `tbl_clue_activity_relation` WRITE;
/*!40000 ALTER TABLE `tbl_clue_activity_relation` DISABLE KEYS */;
INSERT INTO `tbl_clue_activity_relation` VALUES ('004','c5f1539a907b4c158b73602ac9469c90','05753c5b7aee4583893ab343dae02218'),('19fbfc5ecca7442299852688efcbf454','c5f1539a907b4c158b73602ac9469c90','05753c5b7aee4583893ab343dae02219'),('3a44c0ad00284be0a5680e008cbf48ab','a247e01ee372453a916556cc9ee8e20e','05753c5b7aee4583893ab343dae02217'),('ce6be674b31f44c4805666d912d93818','a247e01ee372453a916556cc9ee8e20e','05753c5b7aee4583893ab343dae02216');
/*!40000 ALTER TABLE `tbl_clue_activity_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_clue_remark`
--

DROP TABLE IF EXISTS `tbl_clue_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_clue_remark`
--

LOCK TABLES `tbl_clue_remark` WRITE;
/*!40000 ALTER TABLE `tbl_clue_remark` DISABLE KEYS */;
INSERT INTO `tbl_clue_remark` VALUES ('45a62292978a42d99ef0de9604f52766','666666666666666','幽灵猫','2021-07-05 23:27:08',NULL,NULL,'0','c5f1539a907b4c158b73602ac9469c90'),('79e93f2e7afa40beb88e5ae261bc1199','这是一条测试用备注！','幽灵猫','2021-07-05 23:29:17',NULL,NULL,'0','a247e01ee372453a916556cc9ee8e20e'),('e760df94ccdd404888f66e66cbf056ea','233333333','幽灵猫','2021-07-05 23:25:18',NULL,NULL,'0','c5f1539a907b4c158b73602ac9469c90');
/*!40000 ALTER TABLE `tbl_clue_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_contacts`
--

DROP TABLE IF EXISTS `tbl_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_contacts`
--

LOCK TABLES `tbl_contacts` WRITE;
/*!40000 ALTER TABLE `tbl_contacts` DISABLE KEYS */;
INSERT INTO `tbl_contacts` VALUES ('123','06f5fc056eac41558a964f96daa7f27c','123',NULL,'123','123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('9f21c222f7cd4486a7802c93c50692d1','06f5fc056eac41558a964f96daa7f27c','交易会','26e70b3b025240bba2c1bd30b92c7e55','幽灵猫猫','先生','1272970733@qq.com','123456','学生','0609','幽灵猫','2021-07-17 20:25:26',NULL,NULL,'123','456','2021-07-22','魂器学院');
/*!40000 ALTER TABLE `tbl_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_contacts_activity_relation`
--

DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_contacts_activity_relation_tbl_contacts_id_fk` (`contactsId`),
  CONSTRAINT `tbl_contacts_activity_relation_tbl_contacts_id_fk` FOREIGN KEY (`contactsId`) REFERENCES `tbl_contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_contacts_activity_relation`
--

LOCK TABLES `tbl_contacts_activity_relation` WRITE;
/*!40000 ALTER TABLE `tbl_contacts_activity_relation` DISABLE KEYS */;
INSERT INTO `tbl_contacts_activity_relation` VALUES ('bc1da6479fc44e1e8f320f1fe52af836','9f21c222f7cd4486a7802c93c50692d1','05753c5b7aee4583893ab343dae02217');
/*!40000 ALTER TABLE `tbl_contacts_activity_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_contacts_remark`
--

DROP TABLE IF EXISTS `tbl_contacts_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_contacts_remark_tbl_contacts_id_fk` (`contactsId`),
  CONSTRAINT `tbl_contacts_remark_tbl_contacts_id_fk` FOREIGN KEY (`contactsId`) REFERENCES `tbl_contacts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_contacts_remark`
--

LOCK TABLES `tbl_contacts_remark` WRITE;
/*!40000 ALTER TABLE `tbl_contacts_remark` DISABLE KEYS */;
INSERT INTO `tbl_contacts_remark` VALUES ('3b3a559ab7674d1fafca8cb573b4b304','456','幽灵猫','2021-07-22 00:20:20',NULL,NULL,'0','9f21c222f7cd4486a7802c93c50692d1'),('62e6433d4ac74e7fbac98422299810ae','123456','幽灵猫','2021-07-22 00:21:40',NULL,NULL,'0','9f21c222f7cd4486a7802c93c50692d1'),('9c1a1b8ba17c45988a3cc6e82ccbd7fa','789','幽灵猫','2021-07-22 00:27:28',NULL,NULL,'0','9f21c222f7cd4486a7802c93c50692d1');
/*!40000 ALTER TABLE `tbl_contacts_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_customer`
--

DROP TABLE IF EXISTS `tbl_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_customer`
--

LOCK TABLES `tbl_customer` WRITE;
/*!40000 ALTER TABLE `tbl_customer` DISABLE KEYS */;
INSERT INTO `tbl_customer` VALUES ('0b1aab203160442b8dfd2857fc23b92e','06f5fc056eac41558a964f96daa7f27c','幽灵好公司233','www.ghostcat.vip','02909145035','幽灵猫','2021-07-02 00:30:31','幽灵猫','2021-07-07 19:59:30','654321','2021-07-22','123456','3333333333333'),('0b40be2eaa7e43509479a8c736b3586e','06f5fc056eac41558a964f96daa7f27c','幽灵企业！！！','www.ghostcat.vip','02909145035','幽灵猫','2021-07-03 19:18:19',NULL,NULL,'654321','2021-07-06','123456','3333333333333333333'),('128025a076bd40f995f885bbd5e4932c','06f5fc056eac41558a964f96daa7f27c','幽灵猫有限公司','www.ghostcat.vip','02909145035','幽灵猫','2021-07-02 00:58:56',NULL,NULL,'没有联系概要！','2021-07-28','没有线索描述！','没有详细地址！'),('1c4cc82368af45d78be61cf61868f937','06f5fc056eac41558a964f96daa7f27c','幽灵猫猫猫',NULL,NULL,'幽灵猫','2021-07-19 00:06:50',NULL,NULL,NULL,NULL,NULL,NULL),('26e70b3b025240bba2c1bd30b92c7e55','06f5fc056eac41558a964f96daa7f27c','这个用户不存在！',NULL,NULL,'幽灵猫','2021-07-17 20:25:26',NULL,NULL,NULL,NULL,NULL,NULL),('27464bcce16148e693fea9b94b7d3d96','06f5fc056eac41558a964f96daa7f27c','幽灵猫有限公司2333',NULL,NULL,'幽灵猫','2021-07-18 01:09:56',NULL,NULL,NULL,NULL,NULL,NULL),('431f8e155a9e48f28d30e6fee3fd3fab','06f5fc056eac41558a964f96daa7f27c','幽灵猫猫',NULL,NULL,'幽灵猫','2021-07-18 20:08:23',NULL,NULL,NULL,NULL,NULL,NULL),('4d0e4f890c854e3cb534c4aa5bdf74e6','06f5fc056eac41558a964f96daa7f27c','没有公司','www.ghostcat.vip','02909145035','幽灵猫','2021-07-02 00:18:10',NULL,NULL,'3333333333333333','2021-07-31','222222222','33333333333333'),('50e1ab30934c402cabc5036d2ecffd28','06f5fc056eac41558a964f96daa7f27c','幽灵企业','无','02909145035','幽灵猫','2021-07-02 00:04:02',NULL,NULL,'','','123456','艾欧泽亚大陆西萨纳兰黄昏港沙之家'),('6362ec758f234aca9a434a04f2ab1654','06f5fc056eac41558a964f96daa7f27c','33333333333','33333333333333','7777777777777777777','幽灵猫','2021-07-02 00:36:19',NULL,NULL,'9999999999999999999','1899-12-13','99999999999','9999999999999999999'),('6df546be51ae4adeb8633f58079de3fe','06f5fc056eac41558a964f96daa7f27c','无','www.ghostcat.vip','02909145035','幽灵猫','2021-07-02 00:24:42',NULL,NULL,'555555','1899-12-31','3333333','666666666666666'),('7075c527432a47238bdf3870c8d1184b','06f5fc056eac41558a964f96daa7f27c','幽灵企业！',NULL,NULL,'幽灵猫','2021-07-19 00:08:59',NULL,NULL,NULL,NULL,NULL,NULL),('a4d9456f55b544458d018df4a5b92a33','06f5fc056eac41558a964f96daa7f27c','132',NULL,NULL,'幽灵猫','2021-07-19 00:20:27',NULL,NULL,NULL,NULL,NULL,NULL),('b7d502daf4f64f53899333a91d738e51','06f5fc056eac41558a964f96daa7f27c','111111111','1111111111111111111111','1111111111111111','幽灵猫','2021-07-02 16:44:02',NULL,NULL,'11111111111','2021-07-22','11111111111111111','111111111111111111111111'),('bf49ebb101a547f6ab05044bbc0c27bd','06f5fc056eac41558a964f96daa7f27c','幽灵猫',NULL,NULL,'幽灵猫','2021-07-17 20:24:29',NULL,NULL,NULL,NULL,NULL,NULL),('cb3820f00a0641d6853b824cbedd461d','06f5fc056eac41558a964f96daa7f27c','88888888888','44444444','6666666','幽灵猫','2021-07-02 00:26:02',NULL,NULL,'322222222222','2021-07-23','33333333333','66666666666666666'),('d738a819fda14367be25e5bd8aec440f','06f5fc056eac41558a964f96daa7f27c','88888888','8888888888888','88888888888','幽灵猫','2021-07-02 00:48:35',NULL,NULL,'88888888888888','2021-07-15','88888888888888','8888888888888888888888'),('e43caeac630d4253a539e92573773c09','06f5fc056eac41558a964f96daa7f27c','没有这个客户哦！',NULL,NULL,'幽灵猫','2021-07-30 21:15:33',NULL,NULL,NULL,NULL,NULL,NULL),('edf9e21a1acb4fe8b8319fa656c6c99c','06f5fc056eac41558a964f96daa7f27c','11111',NULL,NULL,'幽灵猫','2021-07-18 20:07:19',NULL,NULL,NULL,NULL,NULL,NULL),('eeacbcf11e334bd9bb945602362f566e','06f5fc056eac41558a964f96daa7f27c','333333','22','12345312','幽灵猫','2021-07-02 00:20:48',NULL,NULL,'333333333333','2021-07-06','3333333333','333333333333333333');
/*!40000 ALTER TABLE `tbl_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_customer_remark`
--

DROP TABLE IF EXISTS `tbl_customer_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_customer_remark`
--

LOCK TABLES `tbl_customer_remark` WRITE;
/*!40000 ALTER TABLE `tbl_customer_remark` DISABLE KEYS */;
INSERT INTO `tbl_customer_remark` VALUES ('02cf17ebf0544f349613e0ea93a35fe5','这是一条测试备注！','幽灵猫','2021-07-02 00:58:56',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('0400a88f8c4d49faafcce055c991afed','6666666666666666666','幽灵猫','2021-07-10 21:07:29',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('10154a6b4fd34dec8922e3e38c977b99','1111111','幽灵猫','2021-07-10 21:09:43',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('10a4437ae05543b5a9ce0520310f9e31','233','幽灵猫','2021-07-10 21:14:25',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('119fd1074c144dc58d3196fe96268c86','233333333333333333333','幽灵猫','2021-07-02 00:04:02',NULL,NULL,'0','50e1ab30934c402cabc5036d2ecffd28'),('1bd93735723f4d12b15f6a38b3dd9436','6666666666666666','幽灵猫','2021-07-02 00:13:41',NULL,NULL,'0','50e1ab30934c402cabc5036d2ecffd28'),('3f2339e8e49840209350bde4487514e0','233333333333333','幽灵猫','2021-07-10 21:06:52',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('4fb84ebf9b714baf88a7c7681110e68f','2333333333333333333333','幽灵猫','2021-07-02 00:13:41',NULL,NULL,'0','50e1ab30934c402cabc5036d2ecffd28'),('77dd6537fe954d7196a569b1bbe8c40d','这是一条测试备注！','幽灵猫','2021-07-02 00:58:56',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('8cbbe45524e44c33906acaad8a04f3d8','123','幽灵猫','2021-07-10 21:11:51',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c'),('92e39611e7a9467d8026181b15d595c9','233333333333333','幽灵猫','2021-07-02 00:30:31',NULL,NULL,'0','0b1aab203160442b8dfd2857fc23b92e'),('e6d0c2966b714f17b154b0506515984a','5555555','幽灵猫','2021-07-02 00:09:36',NULL,NULL,'0','15ccf9a8d7604c4797ee7ea44facbfef'),('efadf98dfaee4a51b417b4ef96d0ac32','66666666666666666666666666333','幽灵猫','2021-07-02 00:04:02',NULL,NULL,'0','50e1ab30934c402cabc5036d2ecffd28'),('fc1335f5f5cf4b19a849c022cd2907dd','这是一条测试备注！','幽灵猫','2021-07-02 00:58:56',NULL,NULL,'0','128025a076bd40f995f885bbd5e4932c');
/*!40000 ALTER TABLE `tbl_customer_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_dic_type`
--

DROP TABLE IF EXISTS `tbl_dic_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '±àÂëÊÇÖ÷¼ü£¬²»ÄÜÎª¿Õ£¬²»ÄÜº¬ÓÐÖÐÎÄ¡£',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_dic_type`
--

LOCK TABLES `tbl_dic_type` WRITE;
/*!40000 ALTER TABLE `tbl_dic_type` DISABLE KEYS */;
INSERT INTO `tbl_dic_type` VALUES ('appellation','称呼',''),('clueState','线索状态',''),('returnPriority','回访优先级',''),('returnState','回访状态',''),('source','来源',''),('stage','阶段',''),('transactionType','交易类型','');
/*!40000 ALTER TABLE `tbl_dic_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_dic_value`
--

DROP TABLE IF EXISTS `tbl_dic_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT 'Ö÷¼ü£¬²ÉÓÃUUID',
  `value` varchar(255) DEFAULT NULL COMMENT '²»ÄÜÎª¿Õ£¬²¢ÇÒÒªÇóÍ¬Ò»¸ö×ÖµäÀàÐÍÏÂ×ÖµäÖµ²»ÄÜÖØ¸´£¬¾ßÓÐÎ¨Ò»ÐÔ¡£',
  `text` varchar(255) DEFAULT NULL COMMENT '¿ÉÒÔÎª¿Õ',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '¿ÉÒÔÎª¿Õ£¬µ«²»Îª¿ÕµÄÊ±ºò£¬ÒªÇó±ØÐëÊÇÕýÕûÊý',
  `typeCode` varchar(255) DEFAULT NULL COMMENT 'Íâ¼ü',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_dic_value`
--

LOCK TABLES `tbl_dic_value` WRITE;
/*!40000 ALTER TABLE `tbl_dic_value` DISABLE KEYS */;
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55','虚假线索','虚假线索','4','clueState'),('0fe33840c6d84bf78df55d49b169a894','销售邮件','销售邮件','8','source'),('12302fd42bd349c1bb768b19600e6b20','交易会','交易会','11','source'),('1615f0bb3e604552a86cde9a2ad45bea','最高','最高','2','returnPriority'),('176039d2a90e4b1a81c5ab8707268636','教授','教授','5','appellation'),('1e0bd307e6ee425599327447f8387285','将来联系','将来联系','2','clueState'),('2173663b40b949ce928db92607b5fe57','丢失线索','丢失线索','5','clueState'),('2876690b7e744333b7f1867102f91153','未启动','未启动','1','returnState'),('29805c804dd94974b568cfc9017b2e4c','07成交','07成交','7','stage'),('310e6a49bd8a4962b3f95a1d92eb76f4','试图联系','试图联系','1','clueState'),('31539e7ed8c848fc913e1c2c93d76fd1','博士','博士','4','appellation'),('37ef211719134b009e10b7108194cf46','01资质审查','01资质审查','1','stage'),('391807b5324d4f16bd58c882750ee632','08丢失的线索','08丢失的线索','8','stage'),('3a39605d67da48f2a3ef52e19d243953','聊天','聊天','14','source'),('474ab93e2e114816abf3ffc596b19131','低','低','3','returnPriority'),('48512bfed26145d4a38d3616e2d2cf79','广告','广告','1','source'),('4d03a42898684135809d380597ed3268','合作伙伴研讨会','合作伙伴研讨会','9','source'),('59795c49896947e1ab61b7312bd0597c','先生','先生','1','appellation'),('5c6e9e10ca414bd499c07b886f86202a','高','高','1','returnPriority'),('67165c27076e4c8599f42de57850e39c','夫人','夫人','2','appellation'),('68a1b1e814d5497a999b8f1298ace62b','09因竞争丢失关闭','09因竞争丢失关闭','9','stage'),('6b86f215e69f4dbd8a2daa22efccf0cf','web调研','web调研','13','source'),('72f13af8f5d34134b5b3f42c5d477510','合作伙伴','合作伙伴','6','source'),('7c07db3146794c60bf975749952176df','未联系','未联系','6','clueState'),('86c56aca9eef49058145ec20d5466c17','内部研讨会','内部研讨会','10','source'),('9095bda1f9c34f098d5b92fb870eba17','进行中','进行中','3','returnState'),('954b410341e7433faa468d3c4f7cf0d2','已有业务','已有业务','1','transactionType'),('966170ead6fa481284b7d21f90364984','已联系','已联系','3','clueState'),('96b03f65dec748caa3f0b6284b19ef2f','推迟','推迟','2','returnState'),('97d1128f70294f0aac49e996ced28c8a','新业务','新业务','2','transactionType'),('9ca96290352c40688de6596596565c12','完成','完成','4','returnState'),('9e6d6e15232549af853e22e703f3e015','需要条件','需要条件','7','clueState'),('9ff57750fac04f15b10ce1bbb5bb8bab','02需求分析','02需求分析','2','stage'),('a70dc4b4523040c696f4421462be8b2f','等待某人','等待某人','5','returnState'),('a83e75ced129421dbf11fab1f05cf8b4','推销电话','推销电话','2','source'),('ab8472aab5de4ae9b388b2f1409441c1','常规','常规','5','returnPriority'),('ab8c2a3dc05f4e3dbc7a0405f721b040','05提案/报价','05提案/报价','5','stage'),('b924d911426f4bc5ae3876038bc7e0ad','web下载','web下载','12','source'),('c13ad8f9e2f74d5aa84697bb243be3bb','03价值建议','03价值建议','3','stage'),('c83c0be184bc40708fd7b361b6f36345','最低','最低','4','returnPriority'),('db867ea866bc44678ac20c8a4a8bfefb','员工介绍','员工介绍','3','source'),('e44be1d99158476e8e44778ed36f4355','04确定决策者','04确定决策者','4','stage'),('e5f383d2622b4fc0959f4fe131dafc80','女士','女士','3','appellation'),('e81577d9458f4e4192a44650a3a3692b','06谈判/复审','06谈判/复审','6','stage'),('fb65d7fdb9c6483db02713e6bc05dd19','在线商场','在线商场','5','source'),('fd677cc3b5d047d994e16f6ece4d3d45','公开媒介','公开媒介','7','source'),('ff802a03ccea4ded8731427055681d48','外部介绍','外部介绍','4','source');
/*!40000 ALTER TABLE `tbl_dic_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tran`
--

DROP TABLE IF EXISTS `tbl_tran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tran`
--

LOCK TABLES `tbl_tran` WRITE;
/*!40000 ALTER TABLE `tbl_tran` DISABLE KEYS */;
INSERT INTO `tbl_tran` VALUES ('12','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','03价值建议','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('12345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','03价值建议','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('1234536','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','03价值建议','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('123453743123','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','03价值建议','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('12345414351345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','03价值建议','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('123564','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','04确定决策者','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('134513451351','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','04确定决策者','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('1451351351351','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','04确定决策者','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('151451515351345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','05提案/报价','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('155431531345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','05提案/报价','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('2dd7af09788744d3ad18d3cba5913451','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','05提案/报价','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('45235743','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','05提案/报价','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('453','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('45343453','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('45345312','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('456343753','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('45678976','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('5145135351345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','06谈判/复审','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('61eaec24df0b4abfbc4932325ecd3601','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','07成交',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3602','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','07成交',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3603','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','08丢失的线索',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3604','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','09因竞争丢失关闭',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3605','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','01资质审查',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3606','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','01资质审查',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3607','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','01资质审查',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3608','06f5fc056eac41558a964f96daa7f27c',NULL,NULL,NULL,'128025a076bd40f995f885bbd5e4932c','01资质审查',NULL,NULL,'05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('61eaec24df0b4abfbc4932325ecd3689','06f5fc056eac41558a964f96daa7f27c','5000','111111111-','2021-07-04','b7d502daf4f64f53899333a91d738e51','08丢失的线索',NULL,'web下载','05753c5b7aee4583893ab343dae02217','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-07-02 16:44:02',NULL,NULL,'11111111111111111','11111111111','2021-07-22'),('644ca573a26d4f21b43e7aa80b4225c1','06f5fc056eac41558a964f96daa7f27c','13453','43512','1899-12-13','27464bcce16148e693fea9b94b7d3d96','03价值建议','新业务','交易会','05753c5b7aee4583893ab343dae02218','123','幽灵猫','2021-08-18 01:38:43',NULL,NULL,'123456','645312','2021-09-01'),('7534','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','08丢失的线索','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('7635','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','02需求分析','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('78345','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','02需求分析','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('78435453','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','02需求分析','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('78634152','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','02需求分析','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('7864523','06f5fc056eac41558a964f96daa7f27c','123','123','2021-08-03','27464bcce16148e693fea9b94b7d3d96','09因竞争丢失关闭','已有业务','web调研','05753c5b7aee4583893ab343dae02218','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-08-18 01:35:32',NULL,NULL,'123456','321654','2021-08-27'),('a0a34c4ce04e4ca8a29ce118ecc4177d','06f5fc056eac41558a964f96daa7f27c','123456','2333','2021-07-28','e43caeac630d4253a539e92573773c09','03价值建议','新业务','交易会','05753c5b7aee4583893ab343dae02216','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-07-30 21:15:33',NULL,NULL,'33333333333333','555555555','2021-07-22'),('c265c14664e3415caeb106a1b92e1113','06f5fc056eac41558a964f96daa7f27c','5120','幽灵猫有限公司-测试交易','2021-07-31','128025a076bd40f995f885bbd5e4932c','09因竞争丢失关闭','','内部研讨会','05753c5b7aee4583893ab343dae02214','9f21c222f7cd4486a7802c93c50692d1','幽灵猫','2021-07-02 00:58:56','幽灵猫','2021-08-15 22:09:06','没有线索描述！','没有联系概要！','2021-07-28');
/*!40000 ALTER TABLE `tbl_tran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tran_history`
--

DROP TABLE IF EXISTS `tbl_tran_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tran_history`
--

LOCK TABLES `tbl_tran_history` WRITE;
/*!40000 ALTER TABLE `tbl_tran_history` DISABLE KEYS */;
INSERT INTO `tbl_tran_history` VALUES ('139639c92eb948bca40d85d170a3dbcf','02需求分析','5120','2021-07-31','2021-08-15 22:09:03','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('1ebe516feaeb44ca914b9d50f9c3371b','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:08:59','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('2539d23766584353a82150fccde19964','04确定决策者','5120','2021-07-31','2021-08-15 22:09:03','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('3c2dec9f1e6f462b8071f51af35a7464','08丢失的线索','5120','2021-07-31','2021-08-15 22:04:19','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('411f3628e98a4a52b43d8ca3fe729fe7','01资质审查','5120','2021-07-31','2021-08-15 22:09:04','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('47adfc6ad3dd4d9c97b8bcbbb6e5df2e','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:08:50','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('59e5f9f325c84bce96cd2ed5b423538a','03价值建议','123456','2021-07-28','2021-07-30 21:15:33','幽灵猫','a0a34c4ce04e4ca8a29ce118ecc4177d'),('6372dee4d53445ed904e60051340ec8c','02需求分析','5120','2021-07-31','2021-08-15 21:54:13','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('71e8e7e3da9b41c49cafde1b08c38f2f','03价值建议','5120','2021-07-31','2021-08-15 21:58:20','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('7559a5ddf1d4493aa5e4b2a256815293','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:07:46','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('75bace7228fd4f4f8f17b5c8923bb0b9','08丢失的线索','5120','2021-07-31','2021-08-15 22:07:47','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('79c9b92d8d3249b69e2a3085156a8d58','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:09:06','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('80cad6a896444f7b93dc1f8577d2bd88','02需求分析','5120','2021-07-31','2021-08-15 21:57:20','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('835007f24d2a49f48ed8156d6882e1bd','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:07:44','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('8516f806de81435f8ec5aa3738b0be09','06谈判/复审','5120','2021-07-31','2021-08-15 22:09:01','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('8a2d0a13d6414d778bfb5771a61265ff','01资质审查','5120','2021-07-31','2021-08-15 22:04:12','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('8b0fe20a0eb442d389e7c8978d3af631','01资质审查','5120','2021-07-31','2021-08-14 17:05:40','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('8dbefcce2ffe4b9c96a63ebed12b92dc','05提案/报价','5120','2021-07-31','2021-08-15 21:59:23','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('9519285795de42bab85528637cffe522','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:07:48','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('9b838aa46de5433ab552c45d33584c40','02需求分析','123','2021-08-03','2021-08-18 01:35:32','幽灵猫','2dd7af09788744d3ad18d3cba5913451'),('9d70f9ffa43249a98db8c8ade695ad70','07成交','5120','2021-07-31','2021-08-15 22:09:00','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('a91d16e8c02347d4a94192cfbe9ba486','08丢失的线索','5120','2021-07-31','2021-08-15 22:08:58','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('ac367fae41da4df9aeea8ab1f6917a54','03价值建议','13453','1899-12-13','2021-08-18 01:38:43','幽灵猫','644ca573a26d4f21b43e7aa80b4225c1'),('b17edb7d113a48bdad86c1b7020e20b5','03价值建议','5120','2021-07-31','2021-08-15 22:09:03','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('b52d5e3fc26441bd9998bdb64488f642','09因竞争丢失关闭','5120','2021-07-31','2021-08-15 22:08:57','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('b8f7f5b1dd3d443a8a5715d539bb6cab','08丢失的线索','5120','2021-07-31','2021-08-15 22:09:05','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('badd03296c55498c938b9b17f9e07b23','01资质审查','5000','2021-07-04','2021-07-02 16:44:02','幽灵猫','61eaec24df0b4abfbc4932325ecd3689'),('bfb798b81d904aedbc462b6d885ffc08','08丢失的线索','5120','2021-07-31','2021-08-15 22:08:47','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('c8de73490aac428696db57a1121c0042','05提案/报价','5120','2021-07-31','2021-08-15 22:09:02','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('cd7fd3649758481e8bd96e685c6d8a81','06谈判/复审','4750','2021-07-31','2021-07-02 00:58:56','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('cf78ab1fccd444f08bb24a4558bada1f','04确定决策者','5120','2021-07-31','2021-08-15 22:07:42','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('d03efec4d41e4609acd0c89f5c0b64e3','06谈判/复审','5120','2021-07-31','2021-08-15 22:07:43','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('d078114874f444f5a9b27474bcea880f','06谈判/复审','5120','2021-07-31','2021-08-15 22:04:18','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('d8ecbcb3b7fb4ee28cac3150fe06e1d0','08丢失的线索','5120','2021-07-31','2021-08-15 22:08:55','幽灵猫','c265c14664e3415caeb106a1b92e1113'),('ef3f6ad6f1f047e49881809bd3307db9','05提案/报价','5120','2021-07-31','2021-08-15 21:55:45','幽灵猫','c265c14664e3415caeb106a1b92e1113');
/*!40000 ALTER TABLE `tbl_tran_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tran_remark`
--

DROP TABLE IF EXISTS `tbl_tran_remark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tran_remark`
--

LOCK TABLES `tbl_tran_remark` WRITE;
/*!40000 ALTER TABLE `tbl_tran_remark` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tran_remark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT 'ÃÜÂë²»ÄÜ²ÉÓÃÃ÷ÎÄ´æ´¢£¬²ÉÓÃÃÜÎÄ£¬MD5¼ÓÃÜÖ®ºóµÄÊý¾Ý',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT 'Ê§Ð§Ê±¼äÎª¿ÕµÄÊ±ºò±íÊ¾ÓÀ²»Ê§Ð§£¬Ê§Ð§Ê±¼äÎª2018-10-10 10:10:10£¬Ôò±íÊ¾ÔÚ¸ÃÊ±¼äÖ®Ç°¸ÃÕË»§¿ÉÓÃ¡£',
  `lockState` char(1) DEFAULT NULL COMMENT 'Ëø¶¨×´Ì¬Îª¿ÕÊ±±íÊ¾ÆôÓÃ£¬Îª0Ê±±íÊ¾Ëø¶¨£¬Îª1Ê±±íÊ¾ÆôÓÃ¡£',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT 'ÔÊÐí·ÃÎÊµÄIPÎª¿ÕÊ±±íÊ¾IPµØÖ·ÓÀ²»ÊÜÏÞ£¬ÔÊÐí·ÃÎÊµÄIP¿ÉÒÔÊÇÒ»¸ö£¬Ò²¿ÉÒÔÊÇ¶à¸ö£¬µ±¶à¸öIPµØÖ·µÄÊ±ºò£¬²ÉÓÃ°ë½Ç¶ººÅ·Ö¸ô¡£ÔÊÐíIPÊÇ192.168.100.2£¬±íÊ¾¸ÃÓÃ»§Ö»ÄÜÔÚIPµØÖ·Îª192.168.100.2µÄ»úÆ÷ÉÏÊ¹ÓÃ¡£',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c','ls','幽灵猫','202cb962ac59075b964b07152d234b70','ls@163.com','2022-11-27 21:50:05','1','A001','192.168.1.1,127.0.0.1','2018-11-22 12:11:40','李四',NULL,NULL),('40f6cdea0bd34aceb77492a1656d9fb3','zs','张三','202cb962ac59075b964b07152d234b70','zs@qq.com','2018-11-30 23:50:55','1','A001','192.168.1.1,192.168.1.2,127.0.0.1','2018-11-22 11:37:34','张三',NULL,NULL);
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-20 20:45:54
