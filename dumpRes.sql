-- MySQL dump 10.13  Distrib 5.5.25, for Win64 (x86)
--
-- Host: localhost    Database: anychart_tree_db
-- ------------------------------------------------------
-- Server version	5.5.25

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
-- Table structure for table `app_currenttask`
--

DROP TABLE IF EXISTS `app_currenttask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_currenttask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_currenttask_44224078` (`status_id`),
  CONSTRAINT `status_id_refs_id_c03f34c` FOREIGN KEY (`status_id`) REFERENCES `app_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_currenttask`
--

LOCK TABLES `app_currenttask` WRITE;
/*!40000 ALTER TABLE `app_currenttask` DISABLE KEYS */;
INSERT INTO `app_currenttask` VALUES (1,'Проверить корректность',1),(2,'Отредактировать',2),(3,'Реализовать',3),(4,'Протестировать',4),(5,'Null',5);
/*!40000 ALTER TABLE `app_currenttask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_fileinnodes`
--

DROP TABLE IF EXISTS `app_fileinnodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_fileinnodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_fileinnodes`
--

LOCK TABLES `app_fileinnodes` WRITE;
/*!40000 ALTER TABLE `app_fileinnodes` DISABLE KEYS */;
INSERT INTO `app_fileinnodes` VALUES (1,'модуль, поясняющий модель','files/4LZCj_LdE7I.jpg'),(2,'Катя','files/z_02a8a46c.jpg'),(3,'важная схема, без которой никак','files/hEdHw22EGQA.jpg');
/*!40000 ALTER TABLE `app_fileinnodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_node`
--

DROP TABLE IF EXISTS `app_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_node_63f17a16` (`parent_id`),
  KEY `app_node_42b06ff6` (`lft`),
  KEY `app_node_6eabc1a6` (`rght`),
  KEY `app_node_102f80d8` (`tree_id`),
  KEY `app_node_2a8f42e8` (`level`),
  CONSTRAINT `parent_id_refs_id_100cc283` FOREIGN KEY (`parent_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (1,'лэйблы',NULL,1,8,1,0),(2,'формат',1,6,7,1,1),(3,'позиционирование',1,4,5,1,1),(4,'анимация',1,2,3,1,1);
/*!40000 ALTER TABLE `app_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodeeditionhistory`
--

DROP TABLE IF EXISTS `app_nodeeditionhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_nodeeditionhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `purpose` varchar(300) NOT NULL,
  `reason` varchar(300) DEFAULT NULL,
  `redaction_date` datetime NOT NULL,
  `node_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `edit_description` longtext,
  `user_id` int(11) NOT NULL,
  `cur_task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_nodeeditionhistory_474baebc` (`node_id`),
  KEY `app_nodeeditionhistory_47d82a6c` (`release_id`),
  KEY `app_nodeeditionhistory_403f60f` (`user_id`),
  KEY `app_nodeeditionhistory_3b98485a` (`cur_task_id`),
  CONSTRAINT `cur_task_id_refs_id_7868fac6` FOREIGN KEY (`cur_task_id`) REFERENCES `app_currenttask` (`id`),
  CONSTRAINT `node_id_refs_id_73ad6efb` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_789000b5` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`),
  CONSTRAINT `user_id_refs_id_34a472e0` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_nodeeditionhistory`
--

LOCK TABLES `app_nodeeditionhistory` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory` DISABLE KEYS */;
INSERT INTO `app_nodeeditionhistory` VALUES (4,'о том, какими красками и кистями надо рисовать лэйблы. с толком, с чувством, с расстановкой','','здравый смысл','2012-08-21 04:42:46',1,1,'только создано',3,1),(5,'о том, какими красками и кистями надо рисовать лэйблы. с толком, с чувством, с расстановкой','','здравый смысл','2012-08-21 04:43:46',1,1,'реализовано. необходимо тестировать',2,4),(6,' Для изготовления мультфильмов использовались киносъёмочные аппараты, пригодные для покадровой съёмки на один из стандартных форматов киноплёнки. Для создания рисованной мультипликации существовали мультстанки, представлявшие из себя сложную репродукционную установку со специальным киносъёмочным аппаратом, как правило, имеющим конструкцию, сходную с аппаратами для комбинированной съёмки и позволяющим регулировать угол раскрытия обтюратора и выполнять затемнения и наплывы.','','укус бешеной собаки','2012-08-21 04:46:06',4,1,'требование утверждено',1,3),(7,'Позиционированием называется процесс поиска такой рыночной позиции для компании, продукта или услуги, которая будет выгодно отличать ее (его) от положения конкурентов. Позиционирование осуществляется с учетом конкретной целевой группы потребителей, для которой создаются и предлагаются преимущества и уникальность. Без ясного представления о том, на что направлена позиция, очень сложно, даже почти невозможно, согласовать решения маркетинга-микс. Определение конкурентного позиционирования часто диктует наиболее эффективные комбинации инструментов маркетинга.','','хорошая погода','2012-08-21 04:47:39',3,1,'немного исправили содержание требования, уточнив тот-то и тот-то пункт',3,1),(8,'Формат вещания (также формат радио, радиоформат, формат программирования радиостанции) — описывает жанровое содержание, направление и стиль подачи материала в эфир теле- или радиостанций.\r\nФорматы часто определяют маркетинговую направленность. Такие форматы, как «музыкальное радио», «информационное радио», «радио общения», «радио погоды» подразумевают основной жанр такого радио, где каждый отдельный формат может подразделяться на другие.','догнать и обогнать','плохая погода','2012-08-21 04:49:35',2,1,'найдены недочеты. необходимо переделать',2,2);
/*!40000 ALTER TABLE `app_nodeeditionhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodeeditionhistory_files`
--

DROP TABLE IF EXISTS `app_nodeeditionhistory_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_nodeeditionhistory_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nodeeditionhistory_id` int(11) NOT NULL,
  `fileinnodes_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nodeeditionhistory_id` (`nodeeditionhistory_id`,`fileinnodes_id`),
  KEY `app_nodeeditionhistory_files_67851358` (`nodeeditionhistory_id`),
  KEY `app_nodeeditionhistory_files_46ec4367` (`fileinnodes_id`),
  CONSTRAINT `fileinnodes_id_refs_id_2c13211e` FOREIGN KEY (`fileinnodes_id`) REFERENCES `app_fileinnodes` (`id`),
  CONSTRAINT `nodeeditionhistory_id_refs_id_6e09f21d` FOREIGN KEY (`nodeeditionhistory_id`) REFERENCES `app_nodeeditionhistory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_nodeeditionhistory_files`
--

LOCK TABLES `app_nodeeditionhistory_files` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory_files` DISABLE KEYS */;
INSERT INTO `app_nodeeditionhistory_files` VALUES (4,4,3),(5,5,3),(6,6,3),(7,7,1),(8,7,3),(9,8,2),(10,8,3);
/*!40000 ALTER TABLE `app_nodeeditionhistory_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodesrelationship`
--

DROP TABLE IF EXISTS `app_nodesrelationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_nodesrelationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_node_id` int(11) NOT NULL,
  `second_node_id` int(11) NOT NULL,
  `type_of_relation_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_nodesrelationship_324412b3` (`first_node_id`),
  KEY `app_nodesrelationship_26a194d4` (`second_node_id`),
  KEY `app_nodesrelationship_659e52cd` (`type_of_relation_id`),
  CONSTRAINT `first_node_id_refs_id_147b46ed` FOREIGN KEY (`first_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `second_node_id_refs_id_147b46ed` FOREIGN KEY (`second_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `type_of_relation_id_refs_id_7a05ef82` FOREIGN KEY (`type_of_relation_id`) REFERENCES `app_typeofnodesrelationship` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_nodesrelationship`
--

LOCK TABLES `app_nodesrelationship` WRITE;
/*!40000 ALTER TABLE `app_nodesrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_nodesrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personrole`
--

DROP TABLE IF EXISTS `app_personrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_personrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_personrole`
--

LOCK TABLES `app_personrole` WRITE;
/*!40000 ALTER TABLE `app_personrole` DISABLE KEYS */;
INSERT INTO `app_personrole` VALUES (1,'корректировщик'),(2,'тестировщик'),(3,'автор'),(4,'исполнитель');
/*!40000 ALTER TABLE `app_personrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personroledetection`
--

DROP TABLE IF EXISTS `app_personroledetection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_personroledetection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_personroledetection_474baebc` (`node_id`),
  KEY `app_personroledetection_40f80fc0` (`role_id`),
  CONSTRAINT `node_id_refs_id_f8ba848` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `role_id_refs_id_344936e3` FOREIGN KEY (`role_id`) REFERENCES `app_personrole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_personroledetection`
--

LOCK TABLES `app_personroledetection` WRITE;
/*!40000 ALTER TABLE `app_personroledetection` DISABLE KEYS */;
INSERT INTO `app_personroledetection` VALUES (8,4,3),(9,2,3),(10,4,1),(11,4,2);
/*!40000 ALTER TABLE `app_personroledetection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personroledetection_persons`
--

DROP TABLE IF EXISTS `app_personroledetection_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_personroledetection_persons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personroledetection_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personroledetection_id` (`personroledetection_id`,`user_id`),
  KEY `app_personroledetection_persons_3e9a4e73` (`personroledetection_id`),
  KEY `app_personroledetection_persons_403f60f` (`user_id`),
  CONSTRAINT `personroledetection_id_refs_id_367a522a` FOREIGN KEY (`personroledetection_id`) REFERENCES `app_personroledetection` (`id`),
  CONSTRAINT `user_id_refs_id_614780e8` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_personroledetection_persons`
--

LOCK TABLES `app_personroledetection_persons` WRITE;
/*!40000 ALTER TABLE `app_personroledetection_persons` DISABLE KEYS */;
INSERT INTO `app_personroledetection_persons` VALUES (8,8,2),(9,9,1),(10,10,1),(11,11,2);
/*!40000 ALTER TABLE `app_personroledetection_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personrolerequirementdetection`
--

DROP TABLE IF EXISTS `app_personrolerequirementdetection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_personrolerequirementdetection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `req_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_personrolerequirementdetection_441990db` (`req_id`),
  KEY `app_personrolerequirementdetection_40f80fc0` (`role_id`),
  CONSTRAINT `req_id_refs_id_4a066e22` FOREIGN KEY (`req_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `role_id_refs_id_12971a9d` FOREIGN KEY (`role_id`) REFERENCES `app_personrole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_personrolerequirementdetection`
--

LOCK TABLES `app_personrolerequirementdetection` WRITE;
/*!40000 ALTER TABLE `app_personrolerequirementdetection` DISABLE KEYS */;
INSERT INTO `app_personrolerequirementdetection` VALUES (11,1,1),(12,2,3),(13,1,3),(14,1,2),(15,1,4);
/*!40000 ALTER TABLE `app_personrolerequirementdetection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personrolerequirementdetection_persons`
--

DROP TABLE IF EXISTS `app_personrolerequirementdetection_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_personrolerequirementdetection_persons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personrolerequirementdetection_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personrolerequirementdetection_id` (`personrolerequirementdetection_id`,`user_id`),
  KEY `app_personrolerequirementdetection_persons_451ad0fb` (`personrolerequirementdetection_id`),
  KEY `app_personrolerequirementdetection_persons_403f60f` (`user_id`),
  CONSTRAINT `personrolerequirementdetection_id_refs_id_518239b2` FOREIGN KEY (`personrolerequirementdetection_id`) REFERENCES `app_personrolerequirementdetection` (`id`),
  CONSTRAINT `user_id_refs_id_43f4b170` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_personrolerequirementdetection_persons`
--

LOCK TABLES `app_personrolerequirementdetection_persons` WRITE;
/*!40000 ALTER TABLE `app_personrolerequirementdetection_persons` DISABLE KEYS */;
INSERT INTO `app_personrolerequirementdetection_persons` VALUES (11,11,2),(12,12,2),(13,13,1),(14,14,2),(15,15,1);
/*!40000 ALTER TABLE `app_personrolerequirementdetection_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_release`
--

DROP TABLE IF EXISTS `app_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `deadline` datetime NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,'кокон','2012-08-20 02:39:25','самый базовый функционал должен работать!'),(2,'прекрасное далеко','2012-08-31 04:29:17','всё будет харашо');
/*!40000 ALTER TABLE `app_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirement`
--

DROP TABLE IF EXISTS `app_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_requirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  `release_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirement_474baebc` (`node_id`),
  KEY `app_requirement_47d82a6c` (`release_id`),
  CONSTRAINT `node_id_refs_id_316ccd9f` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_6adac0ef` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_requirement`
--

LOCK TABLES `app_requirement` WRITE;
/*!40000 ALTER TABLE `app_requirement` DISABLE KEYS */;
INSERT INTO `app_requirement` VALUES (1,'общие положения',1,1),(2,'немного о реализации',4,1),(3,'pie',3,1),(4,'other types',3,1),(5,'немного о реализации',2,1);
/*!40000 ALTER TABLE `app_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirementsedition`
--

DROP TABLE IF EXISTS `app_requirementsedition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_requirementsedition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirement_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `purpose` varchar(300) NOT NULL,
  `reason` varchar(300) DEFAULT NULL,
  `deadline` date NOT NULL,
  `redaction_date` datetime DEFAULT NULL,
  `edit_description` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `cur_task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirementsedition_6657a0ce` (`requirement_id`),
  KEY `app_requirementsedition_403f60f` (`user_id`),
  KEY `app_requirementsedition_3b98485a` (`cur_task_id`),
  CONSTRAINT `cur_task_id_refs_id_33ee1ab3` FOREIGN KEY (`cur_task_id`) REFERENCES `app_currenttask` (`id`),
  CONSTRAINT `requirement_id_refs_id_7e5ee194` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `user_id_refs_id_6e0a0867` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_requirementsedition`
--

LOCK TABLES `app_requirementsedition` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition` DISABLE KEYS */;
INSERT INTO `app_requirementsedition` VALUES (1,1,'','превзойти конкурентов','волшебный пендель Тимы','2012-08-16','2012-08-20 03:51:20','исправил буквы в заголовке, требует проверки.',1,1),(2,2,'необходимо помнить, что на ноль делить нельзя','закрыть существующие недочеты','нет своих людей в минобороны','2012-08-17','2012-08-21 04:51:20','создано. требуется проверка',1,2),(3,1,'','догнать и обогнать','Тима','2012-08-26','2012-08-21 02:45:27','сделали. требуется тестирование',1,3),(4,1,'общие данные касательно того, как осуществляется вывод графика','догнать и обогнать','Тима','2012-08-31','2012-08-21 02:45:51','создано, требуется проверка',2,1),(6,1,'<p><strong>некие общие сведения</strong>, детально описывающие все те данные, что относятся ко всему узлу</p>\r\n\r\n<table width=\"200\" border=\"1\" cellpadding=\"1\" cellspacing=\"1\"><tbody><tr><td>Время года</td><td>Температура</td></tr><tr><td>Зима</td><td>-40</td></tr><tr><td>Лето</td><td>0</td></tr></tbody></table>','','взрыв в алабаме','2012-08-26','2012-08-23 05:23:22','files',2,4),(7,3,'призвано дополнить существующие крайне необходимыми уточнениями','','баг у клиента','2012-08-31','2012-08-21 04:58:29','подозрительно чесалась левая пятка у любимой собаки, решил переписать требование на всякий случай',2,2),(8,4,'описано, где располагаются лэйблы в некоторых отдельных случаях','','здравый смысл','2012-08-31','2012-08-21 04:52:39','да просто так захотелось подпортить требование',1,1),(9,5,'Модули форматирования данных представляют собой компоненты, принимающие данные уведомлений в необработанном виде и возвращающие отформатированные сообщения уведомлений. Модули форматирования данных загружаются распространителем, который установлен в ядре служб Notification Services. Распространитель взаимодействует с модулями форматирования данных через интерфейс под названием IContentFormatter.\r\n\r\nЧтобы разработать собственный модуль форматирования данных, необходимо разработать класс, реализующий интерфейс IContentFormatter. Этот интерфейс доступен в пространстве имен Microsoft.SqlServer.NotificationServices.','чтобы всё работало','укус комара','2012-09-07','2012-08-21 05:02:24','только создали, надо проверить',3,1);
/*!40000 ALTER TABLE `app_requirementsedition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirementsedition_files`
--

DROP TABLE IF EXISTS `app_requirementsedition_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_requirementsedition_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirementsedition_id` int(11) NOT NULL,
  `fileinnodes_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirementsedition_id` (`requirementsedition_id`,`fileinnodes_id`),
  KEY `app_requirementsedition_files_18cc8f4d` (`requirementsedition_id`),
  KEY `app_requirementsedition_files_46ec4367` (`fileinnodes_id`),
  CONSTRAINT `fileinnodes_id_refs_id_25f827f5` FOREIGN KEY (`fileinnodes_id`) REFERENCES `app_fileinnodes` (`id`),
  CONSTRAINT `requirementsedition_id_refs_id_6a71e487` FOREIGN KEY (`requirementsedition_id`) REFERENCES `app_requirementsedition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_requirementsedition_files`
--

LOCK TABLES `app_requirementsedition_files` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition_files` DISABLE KEYS */;
INSERT INTO `app_requirementsedition_files` VALUES (1,1,1),(16,2,1),(6,3,1),(7,4,1),(21,6,1),(22,6,2),(18,7,1),(19,9,2),(20,9,3);
/*!40000 ALTER TABLE `app_requirementsedition_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_status`
--

DROP TABLE IF EXISTS `app_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
INSERT INTO `app_status` VALUES (1,'не проверено'),(2,'на доработке'),(3,'на исполнении'),(4,'тестируется'),(5,'выполнено');
/*!40000 ALTER TABLE `app_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_typeofnodesrelationship`
--

DROP TABLE IF EXISTS `app_typeofnodesrelationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_typeofnodesrelationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_typeofnodesrelationship`
--

LOCK TABLES `app_typeofnodesrelationship` WRITE;
/*!40000 ALTER TABLE `app_typeofnodesrelationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_typeofnodesrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_userrole`
--

DROP TABLE IF EXISTS `app_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_userrole`
--

LOCK TABLES `app_userrole` WRITE;
/*!40000 ALTER TABLE `app_userrole` DISABLE KEYS */;
INSERT INTO `app_userrole` VALUES (1,'корректировщик'),(2,'тестер'),(3,'автор'),(4,'исполнитель');
/*!40000 ALTER TABLE `app_userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add Роль пользователя',8,'add_userrole'),(23,'Can change Роль пользователя',8,'change_userrole'),(24,'Can delete Роль пользователя',8,'delete_userrole'),(25,'Can add Узел',9,'add_node'),(26,'Can change Узел',9,'change_node'),(27,'Can delete Узел',9,'delete_node'),(28,'Can add Роль',10,'add_personrole'),(29,'Can change Роль',10,'change_personrole'),(30,'Can delete Роль',10,'delete_personrole'),(31,'Can add Люди по ролям в узлах',11,'add_personroledetection'),(32,'Can change Люди по ролям в узлах',11,'change_personroledetection'),(33,'Can delete Люди по ролям в узлах',11,'delete_personroledetection'),(34,'Can add Номер редакции',12,'add_redactionnumber'),(35,'Can change Номер редакции',12,'change_redactionnumber'),(36,'Can delete Номер редакции',12,'delete_redactionnumber'),(37,'Can add Релиз',13,'add_release'),(38,'Can change Релиз',13,'change_release'),(39,'Can delete Релиз',13,'delete_release'),(40,'Can add Статус',14,'add_status'),(41,'Can change Статус',14,'change_status'),(42,'Can delete Статус',14,'delete_status'),(43,'Can add Задача',15,'add_currenttask'),(44,'Can change Задача',15,'change_currenttask'),(45,'Can delete Задача',15,'delete_currenttask'),(46,'Can add Файл',16,'add_fileinnodes'),(47,'Can change Файл',16,'change_fileinnodes'),(48,'Can delete Файл',16,'delete_fileinnodes'),(49,'Can add История редактирования узлов',17,'add_nodeeditionhistory'),(50,'Can change История редактирования узлов',17,'change_nodeeditionhistory'),(51,'Can delete История редактирования узлов',17,'delete_nodeeditionhistory'),(52,'Can add Тип отношений между узлами',18,'add_typeofnodesrelationship'),(53,'Can change Тип отношений между узлами',18,'change_typeofnodesrelationship'),(54,'Can delete Тип отношений между узлами',18,'delete_typeofnodesrelationship'),(55,'Can add Отношения между узлами',19,'add_nodesrelationship'),(56,'Can change Отношения между узлами',19,'change_nodesrelationship'),(57,'Can delete Отношения между узлами',19,'delete_nodesrelationship'),(58,'Can add Требование',20,'add_requirement'),(59,'Can change Требование',20,'change_requirement'),(60,'Can delete Требование',20,'delete_requirement'),(61,'Can add История редактирования требований',21,'add_requirementsedition'),(62,'Can change История редактирования требований',21,'change_requirementsedition'),(63,'Can delete История редактирования требований',21,'delete_requirementsedition'),(64,'Can add Люди по ролям в требованиях',22,'add_personrolerequirementdetection'),(65,'Can change Люди по ролям в требованиях',22,'change_personrolerequirementdetection'),(66,'Can delete Люди по ролям в требованиях',22,'delete_personrolerequirementdetection'),(67,'Can add registration profile',23,'add_registrationprofile'),(68,'Can change registration profile',23,'change_registrationprofile'),(69,'Can delete registration profile',23,'delete_registrationprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'admin','','','admin@adminskiy.ru','pbkdf2_sha256$10000$eUxusgub1Ulf$N4NhC3oamgMzFW2F9UvYkYIE2KdqUSnKqDMVNiXoUqw=',1,1,1,'2012-08-23 08:34:11','2012-08-20 02:19:15'),(2,'olga','','','','pbkdf2_sha256$10000$Sj8cmuI9Lels$IWI44vI0LewyuCCtKN6ysgwvg6JleckHZL/wSncSPOw=',0,1,0,'2012-08-20 02:54:26','2012-08-20 02:54:26'),(3,'galina','','','alexandra.batireva@anychart.com','pbkdf2_sha256$10000$ifWNC15Fxi3p$RhzScnlzAb19u+OWIMUvzMOfHJ9vU44dHstULQgy+6w=',0,1,0,'2012-08-22 02:34:47','2012-08-21 04:12:44'),(8,'olga.vorobyeva','','','ov.irkutsk@gmail.com','pbkdf2_sha256$10000$iE1HPfERIJq1$EhkqBVoTWbGUTLDgpMdT2pkEsEOjQFtA/xy1PkdEjzc=',0,1,0,'2012-08-23 08:19:05','2012-08-22 01:39:25'),(9,'baraban','','','alexandra.batireva@anychart.com','pbkdf2_sha256$10000$THi6WDa73KxD$SPhN3JFGj0Th75x8AUZ7P78VprgvWpbpAJ8PDtZERUk=',0,1,0,'2012-08-22 02:32:31','2012-08-22 02:32:31'),(10,'tester','','','ov.irkutsk@gmail.com','pbkdf2_sha256$10000$kW6dvsNTdVjo$Muf5Mt8JonqeXWmEy+oUebnqpd9Q5bf9nRIba971ygE=',0,1,0,'2012-08-22 02:46:19','2012-08-22 02:46:19');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-08-20 02:32:07',1,9,'1','представление в виде картинки',1,''),(2,'2012-08-20 02:32:13',1,9,'2','распечатка',1,''),(3,'2012-08-20 02:34:41',1,14,'1','не проверено',1,''),(4,'2012-08-20 02:34:47',1,9,'3','jpg',1,''),(5,'2012-08-20 02:34:49',1,14,'2','на доработке',1,''),(6,'2012-08-20 02:34:53',1,9,'4','pdf',1,''),(7,'2012-08-20 02:35:06',1,14,'3','на исполнении',1,''),(8,'2012-08-20 02:35:23',1,14,'4','тестируется',1,''),(9,'2012-08-20 02:35:33',1,14,'5','выполнено',1,''),(10,'2012-08-20 02:35:45',1,9,'1','представление в виде другом',2,'Изменен name.'),(11,'2012-08-20 02:35:56',1,9,'1','представление в видах',2,'Изменен name.'),(12,'2012-08-20 02:36:24',1,16,'1','модуль, поясняющий модель',1,''),(13,'2012-08-20 02:36:32',1,15,'1','Проверить корректность',1,''),(14,'2012-08-20 02:36:57',1,15,'2','Отредактировать',1,''),(15,'2012-08-20 02:37:24',1,15,'3','Реализовать',1,''),(16,'2012-08-20 02:37:51',1,15,'4','Протестировать',1,''),(17,'2012-08-20 02:38:03',1,15,'5','Null',1,''),(18,'2012-08-20 02:40:09',1,13,'1','кокон',1,''),(19,'2012-08-20 02:40:48',1,20,'1','общие положения',1,''),(20,'2012-08-20 02:41:21',1,20,'2','конкретика с учетом багов adobe',1,''),(21,'2012-08-20 02:48:28',1,10,'1','корректировщик',1,''),(22,'2012-08-20 02:54:26',1,4,'2','olga',1,''),(23,'2012-08-20 02:55:56',1,8,'1','корректировщик',1,''),(24,'2012-08-20 02:55:59',1,8,'2','тестер',1,''),(25,'2012-08-20 02:56:04',1,8,'3','автор',1,''),(26,'2012-08-20 02:57:29',1,22,'11','11',1,''),(27,'2012-08-20 03:36:44',1,10,'2','тестировщик',1,''),(28,'2012-08-20 03:36:51',1,10,'3','автор',1,''),(29,'2012-08-20 03:36:58',1,22,'12','12',1,''),(30,'2012-08-20 03:39:43',1,11,'8','8',1,''),(31,'2012-08-20 03:42:38',1,11,'9','9',1,''),(32,'2012-08-20 03:42:57',1,11,'10','10',1,''),(33,'2012-08-20 03:43:06',1,11,'11','11',1,''),(34,'2012-08-20 03:46:10',1,12,'1','1',1,''),(35,'2012-08-20 03:51:20',1,21,'1','1',1,''),(36,'2012-08-20 04:29:32',1,13,'2','прекрасное далеко',1,''),(37,'2012-08-20 04:30:25',1,17,'1','какой-то текст: 2012-08-20 04:30:25.622000+00:00',1,''),(38,'2012-08-20 04:38:29',1,17,'2','сделано. проверьте.: 2012-08-20 04:38:29.250000+00:00',1,''),(39,'2012-08-20 04:46:33',1,21,'2','1',1,''),(40,'2012-08-20 04:51:52',1,8,'4','исполнитель',1,''),(41,'2012-08-20 04:52:03',1,17,'2','сделано. проверьте.: 2012-08-20 04:52:03.661000+00:00',2,'Изменен files.'),(42,'2012-08-20 04:53:39',1,12,'2','2',1,''),(43,'2012-08-20 04:55:03',1,21,'3','2',1,''),(44,'2012-08-20 07:33:19',1,21,'4','2',1,''),(45,'2012-08-20 07:33:52',1,12,'3','2',1,''),(46,'2012-08-20 07:34:25',1,21,'5','2',1,''),(47,'2012-08-20 07:35:03',1,10,'4','исполнитель',1,''),(48,'2012-08-20 07:35:20',1,22,'13','13',1,''),(49,'2012-08-20 07:35:32',1,22,'14','14',1,''),(50,'2012-08-20 07:35:43',1,22,'15','15',1,''),(51,'2012-08-21 02:27:33',1,16,'2','Катя',1,''),(52,'2012-08-21 02:28:00',1,21,'6','1',1,''),(53,'2012-08-21 02:33:36',1,17,'3',',kl,pl: 2012-08-21 02:33:36.811000+00:00',1,''),(54,'2012-08-21 02:42:42',1,20,'3','ещё одно требование',1,''),(55,'2012-08-21 02:43:15',1,21,'7','2',1,''),(56,'2012-08-21 02:45:27',1,21,'3','2',2,'Изменен files.'),(57,'2012-08-21 02:45:51',1,21,'4','2',2,'Изменен files.'),(58,'2012-08-21 02:46:05',1,21,'5','2',2,'Изменен files.'),(59,'2012-08-21 02:46:30',1,21,'6','1',2,'Изменен files.'),(60,'2012-08-21 02:46:57',1,21,'6','1',2,'Изменен files.'),(61,'2012-08-21 02:47:36',1,12,'4','10',1,''),(62,'2012-08-21 02:47:40',1,21,'6','10',2,'Изменен version.'),(63,'2012-08-21 02:48:10',1,12,'3','2',3,''),(64,'2012-08-21 02:48:51',1,12,'5','пкиц',1,''),(65,'2012-08-21 02:48:59',1,12,'5','пкиц',3,''),(66,'2012-08-21 03:59:05',1,9,'1','позиционирование лэйблов',2,'Изменен name.'),(67,'2012-08-21 04:00:07',1,9,'1','лэйблы',2,'Изменен name.'),(68,'2012-08-21 04:00:15',1,9,'3','позиционирование',2,'Изменен name.'),(69,'2012-08-21 04:02:13',1,9,'4','анимация',2,'Изменен name.'),(70,'2012-08-21 04:02:25',1,9,'2','формат',2,'Изменен name.'),(71,'2012-08-21 04:10:17',1,21,'7','2',2,'Изменен description,reason,deadline и cur_task.'),(72,'2012-08-21 04:12:44',1,4,'3','galina',1,''),(73,'2012-08-21 04:14:06',1,4,'3','galina',2,'Изменен password и email.'),(74,'2012-08-21 04:28:28',1,21,'6','10',2,'Изменен description,reason и deadline.'),(75,'2012-08-21 04:36:46',1,20,'3','pie',2,'Изменен name.'),(76,'2012-08-21 04:37:06',1,20,'4','other types',1,''),(77,'2012-08-21 04:38:27',1,21,'8','1',1,''),(78,'2012-08-21 04:40:00',1,20,'2','немного о реализации',2,'Изменен name.'),(79,'2012-08-21 04:40:38',1,17,'1','какой-то текст: 2012-08-20 04:30:25+00:00',3,''),(80,'2012-08-21 04:40:38',1,17,'2','сделано. проверьте.: 2012-08-20 04:52:03+00:00',3,''),(81,'2012-08-21 04:40:38',1,17,'3',',kl,pl: 2012-08-21 02:33:36+00:00',3,''),(82,'2012-08-21 04:42:41',1,16,'3','важная схема, без которой никак',1,''),(83,'2012-08-21 04:42:46',1,17,'4','только создано: 2012-08-21 04:42:46.096000+00:00',1,''),(84,'2012-08-21 04:43:46',1,17,'5','реализовано. необходимо тестировать: 2012-08-21 04:43:46.282000+00:00',1,''),(85,'2012-08-21 04:46:06',1,17,'6','требование утверждено: 2012-08-21 04:46:06.487000+00:00',1,''),(86,'2012-08-21 04:47:39',1,17,'7','немного исправили содержание требования, уточнив тот-то и тот-то пункт: 2012-08-21 04:47:39.198000+00:00',1,''),(87,'2012-08-21 04:49:35',1,17,'8','найдены недочеты. необходимо переделать: 2012-08-21 04:49:35.121000+00:00',1,''),(88,'2012-08-21 04:51:20',1,21,'2','1',2,'Изменен reason.'),(89,'2012-08-21 04:52:39',1,21,'8','1',2,'Изменен edit_description.'),(90,'2012-08-21 04:54:23',1,21,'7','2',2,'Изменен edit_description.'),(91,'2012-08-21 04:58:29',1,21,'7','2',2,'Изменен files.'),(92,'2012-08-21 04:59:19',1,20,'5','немного о реализации',1,''),(93,'2012-08-21 05:02:24',1,21,'9','1',1,''),(94,'2012-08-22 02:29:38',1,4,'3','galina',2,'Изменен password и email.'),(95,'2012-08-22 02:31:22',1,7,'1','192.168.1.176:8000',2,'Изменен domain и name.'),(96,'2012-08-22 02:32:31',1,4,'9','baraban',1,''),(97,'2012-08-22 02:32:46',1,4,'9','baraban',2,'Изменен password и email.'),(98,'2012-08-23 05:23:22',1,21,'6','10',2,'Изменен description.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'Роль пользователя','app','userrole'),(9,'Узел','app','node'),(10,'Роль','app','personrole'),(11,'Люди по ролям в узлах','app','personroledetection'),(12,'Номер редакции','app','redactionnumber'),(13,'Релиз','app','release'),(14,'Статус','app','status'),(15,'Задача','app','currenttask'),(16,'Файл','app','fileinnodes'),(17,'История редактирования узлов','app','nodeeditionhistory'),(18,'Тип отношений между узлами','app','typeofnodesrelationship'),(19,'Отношения между узлами','app','nodesrelationship'),(20,'Требование','app','requirement'),(21,'История редактирования требований','app','requirementsedition'),(22,'Люди по ролям в требованиях','app','personrolerequirementdetection'),(23,'registration profile','registration','registrationprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_3da3d3d8` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('64fd8ad8b637a469be6d6936e4798857','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-09-06 08:34:11'),('b26a022e26bb09aaef18dcec81aae9d6','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-09-05 01:09:41'),('c4d5af8bf5e1a12944d56850384d6769','OTdhYzY1NWZmMTczNWE4YTZlZGIzOGM1ZDcwYzdiMzNiMjNmNWZkYTqAAn1xAVUKdGVzdGNvb2tp\nZXECVQZ3b3JrZWRxA3Mu\n','2012-09-05 09:34:02');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'192.168.1.176:8000','olgin comp');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_313280c4` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
INSERT INTO `registration_registrationprofile` VALUES (5,8,'ALREADY_ACTIVATED'),(6,10,'ALREADY_ACTIVATED');
/*!40000 ALTER TABLE `registration_registrationprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-08-24 17:10:14
