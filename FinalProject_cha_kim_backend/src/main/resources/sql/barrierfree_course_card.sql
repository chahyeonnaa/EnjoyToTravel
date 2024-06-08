-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: barrierfree
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `course_card`
--

DROP TABLE IF EXISTS `course_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_card` (
  `card_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `contentid` varchar(255) NOT NULL,
  `text` varchar(4000) DEFAULT NULL,
  `keyword01` tinyint DEFAULT NULL,
  `keyword02` tinyint DEFAULT NULL,
  `keyword03` tinyint DEFAULT NULL,
  `keyword04` tinyint DEFAULT NULL,
  `keyword05` tinyint DEFAULT NULL,
  `keyword06` tinyint DEFAULT NULL,
  `keyword07` tinyint DEFAULT NULL,
  `keyword08` tinyint DEFAULT NULL,
  `keyword09` tinyint DEFAULT NULL,
  `keyword10` tinyint DEFAULT NULL,
  `keyword11` tinyint DEFAULT NULL,
  `keyword12` tinyint DEFAULT NULL,
  `contenttypeid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `card_id_UNIQUE` (`card_id`),
  KEY `course_fk_idx` (`course_id`),
  KEY `content_fk_idx` (`contentid`),
  CONSTRAINT `content_fk` FOREIGN KEY (`contentid`) REFERENCES `places` (`contentid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_fk` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_card`
--

LOCK TABLES `course_card` WRITE;
/*!40000 ALTER TABLE `course_card` DISABLE KEYS */;
INSERT INTO `course_card` VALUES (1,1,'126486','도산공원에 대한 설명',1,0,1,0,1,0,1,0,1,0,1,0,'12'),(2,1,'126504','봉은사(서울)에 대한 설명',0,1,0,1,0,1,0,1,0,1,0,1,'12'),(3,1,'126525','서울 선릉과정릉 [유네스코 세계유산]에 대한 설명',1,1,1,1,0,0,0,0,1,1,1,1,'12'),(4,2,'1602451','대모산도시자연공원에 대한 설명',1,0,1,0,1,0,1,0,1,0,1,0,'12'),(5,2,'2456536','강남 마이스 관광특구에 대한 설명',0,1,0,1,0,1,0,1,0,1,0,1,'12'),(6,2,'2614315','AHC스파에 대한 설명',1,1,1,1,0,0,0,0,1,1,1,1,'12'),(7,3,'2752545','역삼개나리공원에 대한 설명',1,0,1,0,1,0,1,0,1,0,1,0,'12'),(8,3,'2754732','율현공원에 대한 설명',0,1,0,1,0,1,0,1,0,1,0,1,'12'),(9,3,'2754738','한솔공원에 대한 설명',1,1,1,1,0,0,0,0,1,1,1,1,'12');
/*!40000 ALTER TABLE `course_card` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-19 19:25:56
