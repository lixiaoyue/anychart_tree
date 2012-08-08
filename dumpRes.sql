-- MySQL dump 10.13  Distrib 6.0.6-alpha, for Win32 (ia32)
--
-- Host: 127.0.0.1    Database: anychart_tree_db
-- ------------------------------------------------------
-- Server version	6.0.6-alpha-community
USE anychart_tree_db;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_history`
--

DROP TABLE IF EXISTS `app_history`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirement_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `man_id` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task_id` (`task_id`),
  UNIQUE KEY `status_id` (`status_id`),
  UNIQUE KEY `man_id` (`man_id`),
  KEY `app_history_6657a0ce` (`requirement_id`),
  KEY `app_history_10f4f63` (`version_id`),
  CONSTRAINT `man_id_refs_id_d75431d` FOREIGN KEY (`man_id`) REFERENCES `app_people` (`id`),
  CONSTRAINT `requirement_id_refs_id_60576146` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `status_id_refs_id_612acdd4` FOREIGN KEY (`status_id`) REFERENCES `app_status` (`id`),
  CONSTRAINT `task_id_refs_id_656e8f41` FOREIGN KEY (`task_id`) REFERENCES `app_task` (`id`),
  CONSTRAINT `version_id_refs_id_24ff9808` FOREIGN KEY (`version_id`) REFERENCES `app_versionofrequirement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_history`
--

LOCK TABLES `app_history` WRITE;
/*!40000 ALTER TABLE `app_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_node`
--

DROP TABLE IF EXISTS `app_node`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` longtext NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_node_63f17a16` (`parent_id`),
  CONSTRAINT `parent_id_refs_id_100cc283` FOREIGN KEY (`parent_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (2,'AnyChart','самый главный узел',NULL),(3,'Gauges','дочрний узел самого главного узла',2),(4,'vertical gauges','дочерний узел дочернего узла самого главного узла',3),(5,'circular gauges','брат дочернего узла дочернего узла самого главного узла',3),(6,'Pie','брат дочернего узла самого главного узла',2);
/*!40000 ALTER TABLE `app_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodesrelationship`
--

DROP TABLE IF EXISTS `app_nodesrelationship`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_nodesrelationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_node_id` int(11) NOT NULL,
  `second_node_id` int(11) NOT NULL,
  `type_of_relation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_node_id` (`first_node_id`),
  UNIQUE KEY `second_node_id` (`second_node_id`),
  UNIQUE KEY `type_of_relation_id` (`type_of_relation_id`),
  CONSTRAINT `type_of_relation_id_refs_id_7a05ef82` FOREIGN KEY (`type_of_relation_id`) REFERENCES `app_typeofnodesrelationship` (`id`),
  CONSTRAINT `first_node_id_refs_id_147b46ed` FOREIGN KEY (`first_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `second_node_id_refs_id_147b46ed` FOREIGN KEY (`second_node_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_nodesrelationship`
--

LOCK TABLES `app_nodesrelationship` WRITE;
/*!40000 ALTER TABLE `app_nodesrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_nodesrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_people`
--

DROP TABLE IF EXISTS `app_people`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_people`
--

LOCK TABLES `app_people` WRITE;
/*!40000 ALTER TABLE `app_people` DISABLE KEYS */;
INSERT INTO `app_people` VALUES (1,'Борис Палыч'),(2,'Василий Кукуев'),(3,'Абрыхджам Магум');
/*!40000 ALTER TABLE `app_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_people_role_in_anychart`
--

DROP TABLE IF EXISTS `app_people_role_in_anychart`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_people_role_in_anychart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `people_id` int(11) NOT NULL,
  `roleinanychart_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `people_id` (`people_id`,`roleinanychart_id`),
  KEY `app_people_role_in_anychart_3aa854a1` (`people_id`),
  KEY `app_people_role_in_anychart_5735280f` (`roleinanychart_id`),
  CONSTRAINT `people_id_refs_id_4c8bb6be` FOREIGN KEY (`people_id`) REFERENCES `app_people` (`id`),
  CONSTRAINT `roleinanychart_id_refs_id_81abb00` FOREIGN KEY (`roleinanychart_id`) REFERENCES `app_roleinanychart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_people_role_in_anychart`
--

LOCK TABLES `app_people_role_in_anychart` WRITE;
/*!40000 ALTER TABLE `app_people_role_in_anychart` DISABLE KEYS */;
INSERT INTO `app_people_role_in_anychart` VALUES (1,1,2),(2,2,3),(3,3,1);
/*!40000 ALTER TABLE `app_people_role_in_anychart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_release`
--

DROP TABLE IF EXISTS `app_release`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` double NOT NULL,
  `name` varchar(30) NOT NULL,
  `deadline` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,1,'самый первый релиз','2012-08-31');
/*!40000 ALTER TABLE `app_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirement`
--

DROP TABLE IF EXISTS `app_requirement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_requirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `type_id` int(11) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  `business_requirement_id` int(11) DEFAULT NULL,
  `release_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_requirement_id` (`business_requirement_id`),
  KEY `app_requirement_777d41c8` (`type_id`),
  KEY `app_requirement_474baebc` (`node_id`),
  KEY `app_requirement_47d82a6c` (`release_id`),
  CONSTRAINT `business_requirement_id_refs_id_444e8a77` FOREIGN KEY (`business_requirement_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `node_id_refs_id_316ccd9f` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_6adac0ef` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`),
  CONSTRAINT `type_id_refs_id_2fbc17b0` FOREIGN KEY (`type_id`) REFERENCES `app_typesofrequirement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirement`
--

LOCK TABLES `app_requirement` WRITE;
/*!40000 ALTER TABLE `app_requirement` DISABLE KEYS */;
INSERT INTO `app_requirement` VALUES (1,'бт №1',3,3,NULL,1),(2,'бт №2',3,3,NULL,1),(3,'бт №3',3,4,NULL,1),(4,'бт №4',3,5,NULL,1),(5,'бт №5',3,5,NULL,1),(6,'бт №6',3,6,NULL,1),(7,'бт №7',3,6,NULL,1),(8,'фт №1',2,NULL,1,1),(9,'фт №2',2,NULL,2,1),(10,'фт №3',2,NULL,3,1),(11,'фт №4',2,NULL,4,1),(12,'фт №5',2,NULL,5,1),(13,'фт №6',2,NULL,6,1),(14,'фт №7',2,NULL,7,1);
/*!40000 ALTER TABLE `app_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirementsedition`
--

DROP TABLE IF EXISTS `app_requirementsedition`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_requirementsedition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `requirement_id` int(11) NOT NULL,
  `name_of_requirement` varchar(30) NOT NULL,
  `description_of_requirement` longtext NOT NULL,
  `file` varchar(100) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `deadline` date NOT NULL,
  `edition_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirementsedition_10f4f63` (`version_id`),
  KEY `app_requirementsedition_6657a0ce` (`requirement_id`),
  CONSTRAINT `requirement_id_refs_id_7e5ee194` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `version_id_refs_id_7d508676` FOREIGN KEY (`version_id`) REFERENCES `app_versionofrequirement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirementsedition`
--

LOCK TABLES `app_requirementsedition` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition` DISABLE KEYS */;
INSERT INTO `app_requirementsedition` VALUES (1,1,1,'требование по тому-то и тому-т','делать так-то и так-то, а не так и так под угрозой отрыва рук','','','2012-08-31','1');
/*!40000 ALTER TABLE `app_requirementsedition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_roleinanychart`
--

DROP TABLE IF EXISTS `app_roleinanychart`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_roleinanychart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_roleinanychart`
--

LOCK TABLES `app_roleinanychart` WRITE;
/*!40000 ALTER TABLE `app_roleinanychart` DISABLE KEYS */;
INSERT INTO `app_roleinanychart` VALUES (1,'develop'),(2,'начальство'),(3,'qa');
/*!40000 ALTER TABLE `app_roleinanychart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_roleincircle`
--

DROP TABLE IF EXISTS `app_roleincircle`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_roleincircle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirement_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_roleincircle_6657a0ce` (`requirement_id`),
  CONSTRAINT `requirement_id_refs_id_1f325230` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_roleincircle`
--

LOCK TABLES `app_roleincircle` WRITE;
/*!40000 ALTER TABLE `app_roleincircle` DISABLE KEYS */;
INSERT INTO `app_roleincircle` VALUES (1,1),(2,1),(3,1),(4,2),(5,2),(6,2),(7,8),(8,8);
/*!40000 ALTER TABLE `app_roleincircle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_roleincircle_man`
--

DROP TABLE IF EXISTS `app_roleincircle_man`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_roleincircle_man` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleincircle_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roleincircle_id` (`roleincircle_id`,`people_id`),
  KEY `app_roleincircle_man_45542bcb` (`roleincircle_id`),
  KEY `app_roleincircle_man_3aa854a1` (`people_id`),
  CONSTRAINT `people_id_refs_id_5e9be456` FOREIGN KEY (`people_id`) REFERENCES `app_people` (`id`),
  CONSTRAINT `roleincircle_id_refs_id_3c7557b4` FOREIGN KEY (`roleincircle_id`) REFERENCES `app_roleincircle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_roleincircle_man`
--

LOCK TABLES `app_roleincircle_man` WRITE;
/*!40000 ALTER TABLE `app_roleincircle_man` DISABLE KEYS */;
INSERT INTO `app_roleincircle_man` VALUES (1,1,1),(2,2,2),(3,3,2),(4,4,2),(5,5,3),(6,6,3),(7,7,2),(8,8,3);
/*!40000 ALTER TABLE `app_roleincircle_man` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_roleincircle_role`
--

DROP TABLE IF EXISTS `app_roleincircle_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_roleincircle_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleincircle_id` int(11) NOT NULL,
  `roleinsystem_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roleincircle_id` (`roleincircle_id`,`roleinsystem_id`),
  KEY `app_roleincircle_role_45542bcb` (`roleincircle_id`),
  KEY `app_roleincircle_role_498a662e` (`roleinsystem_id`),
  CONSTRAINT `roleincircle_id_refs_id_3dd11e4d` FOREIGN KEY (`roleincircle_id`) REFERENCES `app_roleincircle` (`id`),
  CONSTRAINT `roleinsystem_id_refs_id_1c34ea24` FOREIGN KEY (`roleinsystem_id`) REFERENCES `app_roleinsystem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_roleincircle_role`
--

LOCK TABLES `app_roleincircle_role` WRITE;
/*!40000 ALTER TABLE `app_roleincircle_role` DISABLE KEYS */;
INSERT INTO `app_roleincircle_role` VALUES (1,1,3),(2,2,2),(3,3,1),(4,4,3),(5,5,1),(6,6,2),(7,7,2),(8,8,1);
/*!40000 ALTER TABLE `app_roleincircle_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_roleinsystem`
--

DROP TABLE IF EXISTS `app_roleinsystem`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_roleinsystem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_roleinsystem`
--

LOCK TABLES `app_roleinsystem` WRITE;
/*!40000 ALTER TABLE `app_roleinsystem` DISABLE KEYS */;
INSERT INTO `app_roleinsystem` VALUES (1,'исполнитель'),(2,'контролер'),(3,'автор');
/*!40000 ALTER TABLE `app_roleinsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_status`
--

DROP TABLE IF EXISTS `app_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
INSERT INTO `app_status` VALUES (1,'не проверено'),(2,'на доработке'),(3,'утверждён');
/*!40000 ALTER TABLE `app_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_task`
--

DROP TABLE IF EXISTS `app_task`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `requirement_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirement_id` (`requirement_id`),
  KEY `app_task_44224078` (`status_id`),
  CONSTRAINT `requirement_id_refs_id_10bdc1c6` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `status_id_refs_id_773a1708` FOREIGN KEY (`status_id`) REFERENCES `app_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_task`
--

LOCK TABLES `app_task` WRITE;
/*!40000 ALTER TABLE `app_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_todoimmediately`
--

DROP TABLE IF EXISTS `app_todoimmediately`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_todoimmediately` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `implementer_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `description` longtext NOT NULL,
  `time_data_set` datetime NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `time_data_done` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `node_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `author_id` (`author_id`),
  UNIQUE KEY `implementer_id` (`implementer_id`),
  KEY `app_todoimmediately_474baebc` (`node_id`),
  CONSTRAINT `author_id_refs_id_7070c435` FOREIGN KEY (`author_id`) REFERENCES `app_people` (`id`),
  CONSTRAINT `implementer_id_refs_id_7070c435` FOREIGN KEY (`implementer_id`) REFERENCES `app_people` (`id`),
  CONSTRAINT `node_id_refs_id_5eb4424e` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_todoimmediately`
--

LOCK TABLES `app_todoimmediately` WRITE;
/*!40000 ALTER TABLE `app_todoimmediately` DISABLE KEYS */;
INSERT INTO `app_todoimmediately` VALUES (16,1,3,'срочно сделать что-то','вот его и его','2012-08-01 07:22:14','','2012-08-01 07:22:15',0,3);
/*!40000 ALTER TABLE `app_todoimmediately` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_typeofnodesrelationship`
--

DROP TABLE IF EXISTS `app_typeofnodesrelationship`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_typeofnodesrelationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_typeofnodesrelationship`
--

LOCK TABLES `app_typeofnodesrelationship` WRITE;
/*!40000 ALTER TABLE `app_typeofnodesrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_typeofnodesrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_typesofrequirement`
--

DROP TABLE IF EXISTS `app_typesofrequirement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_typesofrequirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_typesofrequirement`
--

LOCK TABLES `app_typesofrequirement` WRITE;
/*!40000 ALTER TABLE `app_typesofrequirement` DISABLE KEYS */;
INSERT INTO `app_typesofrequirement` VALUES (2,'функциональное'),(3,'бизнес-требование');
/*!40000 ALTER TABLE `app_typesofrequirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_versionofrequirement`
--

DROP TABLE IF EXISTS `app_versionofrequirement`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_versionofrequirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_versionofrequirement`
--

LOCK TABLES `app_versionofrequirement` WRITE;
/*!40000 ALTER TABLE `app_versionofrequirement` DISABLE KEYS */;
INSERT INTO `app_versionofrequirement` VALUES (1,1),(2,2.3);
/*!40000 ALTER TABLE `app_versionofrequirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_425ae3c4` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_5886d21f` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add role in system',8,'add_roleinsystem'),(23,'Can change role in system',8,'change_roleinsystem'),(24,'Can delete role in system',8,'delete_roleinsystem'),(25,'Can add role in anychart',9,'add_roleinanychart'),(26,'Can change role in anychart',9,'change_roleinanychart'),(27,'Can delete role in anychart',9,'delete_roleinanychart'),(28,'Can add people',10,'add_people'),(29,'Can change people',10,'change_people'),(30,'Can delete people',10,'delete_people'),(31,'Can add status',11,'add_status'),(32,'Can change status',11,'change_status'),(33,'Can delete status',11,'delete_status'),(34,'Can add types of requirement',12,'add_typesofrequirement'),(35,'Can change types of requirement',12,'change_typesofrequirement'),(36,'Can delete types of requirement',12,'delete_typesofrequirement'),(37,'Can add node',13,'add_node'),(38,'Can change node',13,'change_node'),(39,'Can delete node',13,'delete_node'),(40,'Can add type of nodes relationship',14,'add_typeofnodesrelationship'),(41,'Can change type of nodes relationship',14,'change_typeofnodesrelationship'),(42,'Can delete type of nodes relationship',14,'delete_typeofnodesrelationship'),(43,'Can add nodes relationship',15,'add_nodesrelationship'),(44,'Can change nodes relationship',15,'change_nodesrelationship'),(45,'Can delete nodes relationship',15,'delete_nodesrelationship'),(46,'Can add version of requirement',16,'add_versionofrequirement'),(47,'Can change version of requirement',16,'change_versionofrequirement'),(48,'Can delete version of requirement',16,'delete_versionofrequirement'),(49,'Can add release',17,'add_release'),(50,'Can change release',17,'change_release'),(51,'Can delete release',17,'delete_release'),(52,'Can add requirement',18,'add_requirement'),(53,'Can change requirement',18,'change_requirement'),(54,'Can delete requirement',18,'delete_requirement'),(55,'Can add requirements edition',19,'add_requirementsedition'),(56,'Can change requirements edition',19,'change_requirementsedition'),(57,'Can delete requirements edition',19,'delete_requirementsedition'),(58,'Can add task',20,'add_task'),(59,'Can change task',20,'change_task'),(60,'Can delete task',20,'delete_task'),(61,'Can add history',21,'add_history'),(62,'Can change history',21,'change_history'),(63,'Can delete history',21,'delete_history'),(64,'Can add role in circle',22,'add_roleincircle'),(65,'Can change role in circle',22,'change_roleincircle'),(66,'Can delete role in circle',22,'delete_roleincircle'),(67,'Can add to do immediately',23,'add_todoimmediately'),(68,'Can change to do immediately',23,'change_todoimmediately'),(69,'Can delete to do immediately',23,'delete_todoimmediately');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'alice','','','maresha@list.ru','pbkdf2_sha256$10000$rB0n9qlSfx47$Wj/D92eNIaKm6EFYYOowCauzyzIY24wtszIa8UMhuRM=',1,1,1,'2012-07-30 09:22:03','2012-07-30 09:21:51');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_403f60f` (`user_id`),
  KEY `auth_user_groups_425ae3c4` (`group_id`),
  CONSTRAINT `group_id_refs_id_f116770` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_7ceef80f` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_403f60f` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_dfbab7d` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_403f60f` (`user_id`),
  KEY `django_admin_log_1bb8f392` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-07-30 09:27:31',1,16,'1','1.0',1,''),(2,'2012-07-30 09:27:40',1,16,'2','2.3',1,''),(3,'2012-07-30 09:27:59',1,12,'1','hgn',1,''),(4,'2012-07-30 09:28:04',1,13,'1','fgdb',1,''),(5,'2012-08-01 02:15:01',1,9,'1','develop',1,''),(6,'2012-08-01 02:15:06',1,9,'2','начальство',1,''),(7,'2012-08-01 02:15:12',1,9,'3','qa',1,''),(8,'2012-08-01 02:15:21',1,10,'1','Борис Палыч',1,''),(9,'2012-08-01 02:15:37',1,10,'2','Василий Кукуев',1,''),(10,'2012-08-01 02:15:55',1,10,'3','Абрыхджам Магум',1,''),(11,'2012-08-01 02:16:23',1,11,'1','не проверено',1,''),(12,'2012-08-01 02:16:32',1,11,'2','на доработке',1,''),(13,'2012-08-01 02:16:41',1,11,'3','утверждён',1,''),(14,'2012-08-01 02:17:28',1,13,'2','AnyChart',1,''),(15,'2012-08-01 02:17:50',1,13,'3','Gauges',1,''),(16,'2012-08-01 02:18:02',1,13,'1','fgdb',3,''),(17,'2012-08-01 02:19:27',1,13,'4','vertical gauges',1,''),(18,'2012-08-01 02:19:50',1,13,'5','circular gauges',1,''),(19,'2012-08-01 02:20:21',1,13,'6','Pie',1,''),(20,'2012-08-01 02:20:57',1,12,'2','функциональное',1,''),(21,'2012-08-01 02:21:03',1,12,'1','hgn',3,''),(22,'2012-08-01 02:21:11',1,12,'3','бизнес-требование',1,''),(23,'2012-08-01 02:23:27',1,17,'1','самый первый релиз',1,''),(24,'2012-08-01 02:23:44',1,18,'1','бт №1',1,''),(25,'2012-08-01 02:24:04',1,18,'2','бт №2',1,''),(26,'2012-08-01 02:24:24',1,18,'3','бт №3',1,''),(27,'2012-08-01 02:24:37',1,18,'4','бт №4',1,''),(28,'2012-08-01 02:24:48',1,18,'5','бт №5',1,''),(29,'2012-08-01 02:25:03',1,18,'6','бт №6',1,''),(30,'2012-08-01 02:25:20',1,18,'7','бт №7',1,''),(31,'2012-08-01 02:25:30',1,18,'5','бт №5',2,'Changed type.'),(32,'2012-08-01 02:25:48',1,18,'8','фт №1',1,''),(33,'2012-08-01 02:26:00',1,18,'9','фт №2',1,''),(34,'2012-08-01 02:26:13',1,18,'10','фт №3',1,''),(35,'2012-08-01 02:26:27',1,18,'11','фт №4',1,''),(36,'2012-08-01 02:26:53',1,18,'12','фт №5',1,''),(37,'2012-08-01 02:27:12',1,18,'13','фт №6',1,''),(38,'2012-08-01 02:27:26',1,18,'14','фт №7',1,''),(39,'2012-08-01 02:31:16',1,8,'1','исполнитель',1,''),(40,'2012-08-01 02:31:36',1,8,'2','контролер',1,''),(41,'2012-08-01 02:31:42',1,8,'3','автор',1,''),(42,'2012-08-01 02:31:52',1,22,'1','бт №1',1,''),(43,'2012-08-01 02:32:10',1,22,'2','бт №1',1,''),(44,'2012-08-01 02:32:19',1,22,'3','бт №1',1,''),(45,'2012-08-01 02:32:49',1,22,'4','бт №2',1,''),(46,'2012-08-01 02:33:00',1,22,'5','бт №2',1,''),(47,'2012-08-01 02:33:08',1,22,'6','бт №2',1,''),(48,'2012-08-01 02:33:45',1,22,'7','фт №1',1,''),(49,'2012-08-01 02:33:55',1,22,'8','фт №1',1,''),(50,'2012-08-01 02:36:58',1,19,'1','1.0',1,''),(51,'2012-08-01 07:20:34',1,23,'15','15',1,''),(52,'2012-08-01 07:21:51',1,23,'15','Борис Палыч рпт',3,''),(53,'2012-08-01 07:22:18',1,23,'16','Борис Палыч срочно сделать что-то',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'role in system','app','roleinsystem'),(9,'role in anychart','app','roleinanychart'),(10,'people','app','people'),(11,'status','app','status'),(12,'types of requirement','app','typesofrequirement'),(13,'node','app','node'),(14,'type of nodes relationship','app','typeofnodesrelationship'),(15,'nodes relationship','app','nodesrelationship'),(16,'version of requirement','app','versionofrequirement'),(17,'release','app','release'),(18,'requirement','app','requirement'),(19,'requirements edition','app','requirementsedition'),(20,'task','app','task'),(21,'history','app','history'),(22,'role in circle','app','roleincircle'),(23,'to do immediately','app','todoimmediately');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8cc5e5a8580abfff81f2c86bab96abc7','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-08-13 09:22:03');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-02  2:29:38
