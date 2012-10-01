-- MySQL dump 10.13  Distrib 6.0.6-alpha, for Win32 (ia32)
--
-- Host: localhost    Database: anychart_tree_db
-- ------------------------------------------------------
-- Server version	6.0.6-alpha-community

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_currenttask` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_currenttask_44224078` (`status_id`),
  CONSTRAINT `status_id_refs_id_c03f34c` FOREIGN KEY (`status_id`) REFERENCES `app_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_currenttask`
--

LOCK TABLES `app_currenttask` WRITE;
/*!40000 ALTER TABLE `app_currenttask` DISABLE KEYS */;
INSERT INTO `app_currenttask` VALUES (2,'Проверить корректность',6),(3,'Отредактировать',7),(4,'Реализовать',8),(5,'Протестировать',9),(6,'null',10);
/*!40000 ALTER TABLE `app_currenttask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_fileinnodes`
--

DROP TABLE IF EXISTS `app_fileinnodes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_fileinnodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_fileinnodes`
--

LOCK TABLES `app_fileinnodes` WRITE;
/*!40000 ALTER TABLE `app_fileinnodes` DISABLE KEYS */;
INSERT INTO `app_fileinnodes` VALUES (1,'gauge.xml','files/gauge_5.xml'),(2,'main.xml','files/main_6.xml'),(3,'gauge.xml','files/gauge_6.xml'),(4,'hEdHw22EGQA.jpg','files/hEdHw22EGQA_1.jpg'),(5,'важнейшая картинка, символизирующая мир.jpg','files/hEdHw22EGQA_2.jpg');
/*!40000 ALTER TABLE `app_fileinnodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_node`
--

DROP TABLE IF EXISTS `app_node`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (3,'основы',NULL,1,12,7,0),(8,'labels',3,10,11,7,1),(11,'новый узел',NULL,1,2,6,0),(12,'jhkjhk',NULL,1,2,5,0);
/*!40000 ALTER TABLE `app_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodeeditionhistory`
--

DROP TABLE IF EXISTS `app_nodeeditionhistory`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_nodeeditionhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `purpose` varchar(300) NOT NULL,
  `reason` varchar(300) NOT NULL,
  `redaction_date` datetime NOT NULL,
  `node_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `edit_description` longtext NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_nodeeditionhistory`
--

LOCK TABLES `app_nodeeditionhistory` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory` DISABLE KEYS */;
INSERT INTO `app_nodeeditionhistory` VALUES (1,'Именно исход из классических основных позиций обеспечивает для артиста правильное исполнение па, помогая в создании грациозности и выразительности танца. Из основных позиций образуется множество других танцевальных положений[2]. Все основные балетные позиции выполняются в положении стоя, мышцы собраны, живот втянут, ягодицы подобраны, осанка прямая. Исполнение позиций — это начало начал обучения хореографии вот уже на протяжении двухсот лет во всех балетных школах. Речь идет не о том, чтобы повернуть только ступни носками в разные стороны, повернута должна быть вся нога, начиная с бедренного сустава[1]. По-этому, все позиции ног в классическом балете поставлены — выворотно, на этом и основаны основные позиции. Французское слово (фр. en dehors в терминологии используется для обозначения направления движения, например вращения.','нет цели','облачность','2012-09-06 02:49:09',3,1,'захотелось',2,2),(2,'<p>Именно исход из классических основных позиций обеспечивает для артиста правильное исполнение па, помогая в создании грациозности и выразительности танца. Из основных позиций образуется множество других танцевальных положений[2]. Все основные балетные позиции выполняются в положении стоя, мышцы собраны, живот втянут, ягодицы подобраны, осанка прямая. Исполнение позиций &mdash; это начало начал обучения хореографии вот уже на протяжении двухсот лет во всех балетных школах. Речь идет не о том, чтобы повернуть только ступни носками в разные стороны, повернута должна быть вся нога, начиная с бедренного сустава[1]. По-этому, все позиции ног в классическом балете поставлены &mdash; выворотно, на этом и основаны основные позиции. Французское слово (фр. en dehors в терминологии используется для обозначения направления движения, например вращения.</p>','нет цели','','2012-09-06 03:23:31',3,1,'<p>захотелось</p>',1,2),(3,'<p>&nbsp;Современная западная система ювенальной юстиции<sup>1</sup> в целом основана на абсолютизации приоритета прав ребенка по отношению к правам родителей, что подчас приводит к ущемлению прав и интересов родителей и семьи в целом.</p>','','повышенная облачность','2012-09-06 03:24:57',8,2,'только создано',1,2),(4,'<p>Светлана Кобзева представила структуру добровольческого движения православной службы помощи &laquo;Милосердия&raquo;, действующей в Москве, основные направления и принципы ее работы, привела примеры различных &laquo;внештатных&raquo; ситуаций, возникающих в работе добровольцев, и предложила способы их решения. Обсуждались вопросы взаимодействия и поддержки добровольцев и самые разные аспекты их деятельности, в том числе юридический и моральный. Светлана Кобзева подчеркнула, что добровольцем службы &laquo;Милосердие&raquo; может стать любой человек, независимо от своего мировоззрения и религиозной принадлежности, указав в то же время на духовные истоки добровольческого служения, коренящиеся в православной вере.</p>\r\n<p>&nbsp;</p>','','','2012-09-06 05:07:07',8,2,'<p>только создано</p>',1,2),(5,'<p>каумм &nbsp;ав аваа а&nbsp;</p>','','нет цели','2012-09-07 01:56:32',11,2,'только создано',1,2),(6,'<p>&nbsp;jhkjhkkjh</p>','','hjkjhk','2012-09-24 02:00:57',12,2,'только создано',2,2);
/*!40000 ALTER TABLE `app_nodeeditionhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_nodeeditionhistory_files`
--

DROP TABLE IF EXISTS `app_nodeeditionhistory_files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_nodeeditionhistory_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nodeeditionhistory_id` int(11) NOT NULL,
  `fileinnodes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nodeeditionhistory_id` (`nodeeditionhistory_id`,`fileinnodes_id`),
  KEY `app_nodeeditionhistory_files_67851358` (`nodeeditionhistory_id`),
  KEY `app_nodeeditionhistory_files_46ec4367` (`fileinnodes_id`),
  CONSTRAINT `fileinnodes_id_refs_id_2c13211e` FOREIGN KEY (`fileinnodes_id`) REFERENCES `app_fileinnodes` (`id`),
  CONSTRAINT `nodeeditionhistory_id_refs_id_6e09f21d` FOREIGN KEY (`nodeeditionhistory_id`) REFERENCES `app_nodeeditionhistory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_nodeeditionhistory_files`
--

LOCK TABLES `app_nodeeditionhistory_files` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory_files` DISABLE KEYS */;
INSERT INTO `app_nodeeditionhistory_files` VALUES (1,1,1),(2,2,1);
/*!40000 ALTER TABLE `app_nodeeditionhistory_files` ENABLE KEYS */;
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
  KEY `app_nodesrelationship_324412b3` (`first_node_id`),
  KEY `app_nodesrelationship_26a194d4` (`second_node_id`),
  KEY `app_nodesrelationship_659e52cd` (`type_of_relation_id`),
  CONSTRAINT `first_node_id_refs_id_147b46ed` FOREIGN KEY (`first_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `second_node_id_refs_id_147b46ed` FOREIGN KEY (`second_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `type_of_relation_id_refs_id_7a05ef82` FOREIGN KEY (`type_of_relation_id`) REFERENCES `app_typeofnodesrelationship` (`id`)
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
-- Table structure for table `app_personrole`
--

DROP TABLE IF EXISTS `app_personrole`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_personrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_personrole`
--

LOCK TABLES `app_personrole` WRITE;
/*!40000 ALTER TABLE `app_personrole` DISABLE KEYS */;
INSERT INTO `app_personrole` VALUES (1,'author'),(2,'corrector'),(3,'implementer'),(4,'tester');
/*!40000 ALTER TABLE `app_personrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personroledetection`
--

DROP TABLE IF EXISTS `app_personroledetection`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_personroledetection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_personroledetection_474baebc` (`node_id`),
  KEY `app_personroledetection_40f80fc0` (`role_id`),
  CONSTRAINT `node_id_refs_id_f8ba848` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `role_id_refs_id_344936e3` FOREIGN KEY (`role_id`) REFERENCES `app_personrole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_personroledetection`
--

LOCK TABLES `app_personroledetection` WRITE;
/*!40000 ALTER TABLE `app_personroledetection` DISABLE KEYS */;
INSERT INTO `app_personroledetection` VALUES (1,8,1),(2,8,2),(3,8,1),(4,8,2),(5,11,1),(6,11,2),(7,12,1),(8,12,2);
/*!40000 ALTER TABLE `app_personroledetection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personroledetection_persons`
--

DROP TABLE IF EXISTS `app_personroledetection_persons`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_personroledetection_persons`
--

LOCK TABLES `app_personroledetection_persons` WRITE;
/*!40000 ALTER TABLE `app_personroledetection_persons` DISABLE KEYS */;
INSERT INTO `app_personroledetection_persons` VALUES (1,1,1),(2,1,2),(3,2,2),(4,2,3),(5,3,1),(6,3,2),(7,4,2),(8,4,3),(9,5,4),(10,6,4),(11,7,3),(12,7,4),(13,8,4);
/*!40000 ALTER TABLE `app_personroledetection_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personrolerequirementdetection`
--

DROP TABLE IF EXISTS `app_personrolerequirementdetection`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_personrolerequirementdetection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `req_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_personrolerequirementdetection_441990db` (`req_id`),
  KEY `app_personrolerequirementdetection_40f80fc0` (`role_id`),
  CONSTRAINT `req_id_refs_id_4a066e22` FOREIGN KEY (`req_id`) REFERENCES `app_requirement` (`id`),
  CONSTRAINT `role_id_refs_id_12971a9d` FOREIGN KEY (`role_id`) REFERENCES `app_personrole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_personrolerequirementdetection`
--

LOCK TABLES `app_personrolerequirementdetection` WRITE;
/*!40000 ALTER TABLE `app_personrolerequirementdetection` DISABLE KEYS */;
INSERT INTO `app_personrolerequirementdetection` VALUES (21,8,1),(22,8,2),(23,8,3),(24,8,4),(25,9,1),(26,9,2),(27,9,3),(28,9,4);
/*!40000 ALTER TABLE `app_personrolerequirementdetection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_personrolerequirementdetection_persons`
--

DROP TABLE IF EXISTS `app_personrolerequirementdetection_persons`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_personrolerequirementdetection_persons`
--

LOCK TABLES `app_personrolerequirementdetection_persons` WRITE;
/*!40000 ALTER TABLE `app_personrolerequirementdetection_persons` DISABLE KEYS */;
INSERT INTO `app_personrolerequirementdetection_persons` VALUES (24,21,3),(25,22,2),(26,22,3),(27,23,3),(28,24,1),(29,25,2),(30,26,1),(31,27,2),(32,28,3);
/*!40000 ALTER TABLE `app_personrolerequirementdetection_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_release`
--

DROP TABLE IF EXISTS `app_release`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `deadline` datetime NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,'первый','2012-10-20 03:00:00','хорошее начало дело накачало'),(2,'второй','2012-12-15 02:35:22','хороший конец - всему делу венец');
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
  `name` varchar(200) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  `release_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirement_474baebc` (`node_id`),
  KEY `app_requirement_47d82a6c` (`release_id`),
  CONSTRAINT `node_id_refs_id_316ccd9f` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_6adac0ef` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirement`
--

LOCK TABLES `app_requirement` WRITE;
/*!40000 ALTER TABLE `app_requirement` DISABLE KEYS */;
INSERT INTO `app_requirement` VALUES (8,'главнейшее требование',3,2),(9,'паип',8,2);
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
  `requirement_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `purpose` varchar(300) NOT NULL,
  `reason` varchar(300) NOT NULL,
  `deadline` date NOT NULL,
  `redaction_date` datetime NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirementsedition`
--

LOCK TABLES `app_requirementsedition` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition` DISABLE KEYS */;
INSERT INTO `app_requirementsedition` VALUES (3,8,'<p><span style=\"color: rgb(255, 0, 0); \">Поздравляю всех подписчиков с Новым 2004 годом, желаю здоровью, счастья и успехов, как в жизни, так и на фоне Web-творчества</span>.</p>','','нет цели','2012-09-30','2012-09-06 04:50:49','только создано',1,2),(4,8,'<p><span style=\"color: rgb(255, 0, 0); \">Поздравляю всех подписчиков с Новым 2004 годом, желаю здоровью, счастья и успехов, как в жизни, так и на фоне Web-творчества</span>.</p>','','','2012-09-30','2012-09-06 04:54:48','<p>только создано</p>',1,2),(5,9,'<p>&nbsp;<strong>кеурер</strong></p>','','апиап','2012-09-29','2012-09-06 07:18:16','только создано',2,2);
/*!40000 ALTER TABLE `app_requirementsedition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_requirementsedition_files`
--

DROP TABLE IF EXISTS `app_requirementsedition_files`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_requirementsedition_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirementsedition_id` int(11) NOT NULL,
  `fileinnodes_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `requirementsedition_id` (`requirementsedition_id`,`fileinnodes_id`),
  KEY `app_requirementsedition_files_18cc8f4d` (`requirementsedition_id`),
  KEY `app_requirementsedition_files_46ec4367` (`fileinnodes_id`),
  CONSTRAINT `fileinnodes_id_refs_id_25f827f5` FOREIGN KEY (`fileinnodes_id`) REFERENCES `app_fileinnodes` (`id`),
  CONSTRAINT `requirementsedition_id_refs_id_6a71e487` FOREIGN KEY (`requirementsedition_id`) REFERENCES `app_requirementsedition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirementsedition_files`
--

LOCK TABLES `app_requirementsedition_files` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition_files` DISABLE KEYS */;
INSERT INTO `app_requirementsedition_files` VALUES (3,3,4),(4,4,5);
/*!40000 ALTER TABLE `app_requirementsedition_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_status`
--

DROP TABLE IF EXISTS `app_status`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
INSERT INTO `app_status` VALUES (6,'не проверено'),(7,'на доработке'),(8,'на исполнении'),(9,'тестируется'),(10,'выполнено');
/*!40000 ALTER TABLE `app_status` ENABLE KEYS */;
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
-- Table structure for table `app_userrole`
--

DROP TABLE IF EXISTS `app_userrole`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `app_userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_userrole`
--

LOCK TABLES `app_userrole` WRITE;
/*!40000 ALTER TABLE `app_userrole` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_userrole` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add registration profile',8,'add_registrationprofile'),(23,'Can change registration profile',8,'change_registrationprofile'),(24,'Can delete registration profile',8,'delete_registrationprofile'),(25,'Can add Роль пользователя',9,'add_userrole'),(26,'Can change Роль пользователя',9,'change_userrole'),(27,'Can delete Роль пользователя',9,'delete_userrole'),(28,'Can add Бизнес-требование',10,'add_node'),(29,'Can change Бизнес-требование',10,'change_node'),(30,'Can delete Бизнес-требование',10,'delete_node'),(31,'Can add Роль',11,'add_personrole'),(32,'Can change Роль',11,'change_personrole'),(33,'Can delete Роль',11,'delete_personrole'),(34,'Can add Люди по ролям в узлах',12,'add_personroledetection'),(35,'Can change Люди по ролям в узлах',12,'change_personroledetection'),(36,'Can delete Люди по ролям в узлах',12,'delete_personroledetection'),(37,'Can add Релиз',13,'add_release'),(38,'Can change Релиз',13,'change_release'),(39,'Can delete Релиз',13,'delete_release'),(40,'Can add Статус',14,'add_status'),(41,'Can change Статус',14,'change_status'),(42,'Can delete Статус',14,'delete_status'),(43,'Can add Задача',15,'add_currenttask'),(44,'Can change Задача',15,'change_currenttask'),(45,'Can delete Задача',15,'delete_currenttask'),(46,'Can add Файл',16,'add_fileinnodes'),(47,'Can change Файл',16,'change_fileinnodes'),(48,'Can delete Файл',16,'delete_fileinnodes'),(49,'Can add История редактирования БТ',17,'add_nodeeditionhistory'),(50,'Can change История редактирования БТ',17,'change_nodeeditionhistory'),(51,'Can delete История редактирования БТ',17,'delete_nodeeditionhistory'),(52,'Can add Тип отношений между узлами',18,'add_typeofnodesrelationship'),(53,'Can change Тип отношений между узлами',18,'change_typeofnodesrelationship'),(54,'Can delete Тип отношений между узлами',18,'delete_typeofnodesrelationship'),(55,'Can add Отношения между узлами',19,'add_nodesrelationship'),(56,'Can change Отношения между узлами',19,'change_nodesrelationship'),(57,'Can delete Отношения между узлами',19,'delete_nodesrelationship'),(58,'Can add Требование',20,'add_requirement'),(59,'Can change Требование',20,'change_requirement'),(60,'Can delete Требование',20,'delete_requirement'),(61,'Can add История редактирования требований',21,'add_requirementsedition'),(62,'Can change История редактирования требований',21,'change_requirementsedition'),(63,'Can delete История редактирования требований',21,'delete_requirementsedition'),(64,'Can add Люди по ролям в требованиях',22,'add_personrolerequirementdetection'),(65,'Can change Люди по ролям в требованиях',22,'change_personrolerequirementdetection'),(66,'Can delete Люди по ролям в требованиях',22,'delete_personrolerequirementdetection');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'admin','','','maresha@list.ru','pbkdf2_sha256$10000$PX6A75ZmPszL$WLyxCKWemcto5UO3GUifJF4BAThuVhbDLHBdK1CUZFk=',1,1,1,'2012-09-24 02:11:01','2012-09-06 02:31:28'),(2,'galina','','','','pbkdf2_sha256$10000$0Y1wjkmmD1Rd$iGEmi7o+cTSVwqI8PGgrL8EpGKDVwJ8mbEZkuvBEljM=',0,1,0,'2012-09-24 02:00:39','2012-09-06 02:32:01'),(3,'baraban','Валерий','','maresha@list.ru','pbkdf2_sha256$10000$Gal6Xfkc6D7M$hwltEE8PjXw4aNvWb5cAqm5/3DDCIfib9knD/iTamZs=',1,1,1,'2012-09-06 02:32:13','2012-09-06 02:32:13'),(4,'Vitaly','','','vitaly.radionov@anychart.com','pbkdf2_sha256$10000$HyhxUgLhbqtb$xCDW4pdE82epg2ntV/u1olO26hfjY62rmrRxZjli5S8=',0,0,0,'2012-09-06 07:29:19','2012-09-06 07:29:19');
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-09-06 02:32:01',1,4,'2','galina',1,''),(2,'2012-09-06 02:32:13',1,4,'3','baraban',1,''),(3,'2012-09-06 02:32:53',1,4,'3','baraban',2,'Изменен password,first_name,last_name,email,is_staff и is_superuser.'),(4,'2012-09-06 02:33:23',1,9,'1','labels',1,''),(5,'2012-09-06 02:35:16',1,13,'1','первый',1,''),(6,'2012-09-06 02:35:31',1,13,'2','второй',1,''),(7,'2012-09-06 02:36:33',1,9,'1','labels',3,''),(8,'2012-09-06 02:36:47',1,9,'3','labels',1,''),(9,'2012-09-06 02:37:29',1,8,'1','author',1,''),(10,'2012-09-06 02:37:36',1,8,'2','corrector',1,''),(11,'2012-09-06 02:37:43',1,8,'3','implementer',1,''),(12,'2012-09-06 02:37:45',1,8,'4','tester',1,''),(13,'2012-09-06 02:37:55',1,14,'1','null',1,''),(14,'2012-09-06 02:38:06',1,14,'2','не проверено',1,''),(15,'2012-09-06 02:38:12',1,14,'1','null',3,''),(16,'2012-09-06 02:38:18',1,14,'2','не проверено',3,''),(17,'2012-09-06 02:38:22',1,14,'3','не проверено',1,''),(18,'2012-09-06 02:38:35',1,14,'4','на доработке',1,''),(19,'2012-09-06 02:38:41',1,14,'5','утверждено',1,''),(20,'2012-09-06 02:44:43',1,15,'1','Проверить корректность',1,''),(21,'2012-09-06 02:45:22',1,14,'3','не проверено',3,''),(22,'2012-09-06 02:45:22',1,14,'4','на доработке',3,''),(23,'2012-09-06 02:45:22',1,14,'5','утверждено',3,''),(24,'2012-09-06 02:45:35',1,14,'6','не проверено',1,''),(25,'2012-09-06 02:45:41',1,14,'7','на доработке',1,''),(26,'2012-09-06 02:45:48',1,14,'8','на исполнении',1,''),(27,'2012-09-06 02:45:53',1,14,'9','тестируется',1,''),(28,'2012-09-06 02:45:58',1,14,'10','выполнено',1,''),(29,'2012-09-06 02:46:48',1,15,'2','Проверить корректность',1,''),(30,'2012-09-06 02:47:12',1,15,'3','Отредактировать',1,''),(31,'2012-09-06 02:47:23',1,15,'4','Реализовать',1,''),(32,'2012-09-06 02:47:32',1,15,'5','Протестировать',1,''),(33,'2012-09-06 02:47:39',1,15,'6','null',1,''),(34,'2012-09-06 02:48:11',1,9,'4','',3,''),(35,'2012-09-06 02:49:09',1,17,'1','захотелось: 2012-09-06 02:49:09.543000+00:00',1,''),(36,'2012-09-06 02:52:32',1,9,'5','новый узел',3,''),(37,'2012-09-06 02:54:34',1,8,'1','author',2,'Ни одно поле не изменено.'),(38,'2012-09-06 02:58:29',1,10,'7','апитап',3,''),(39,'2012-09-06 02:58:29',1,10,'6','новый',3,''),(40,'2012-09-06 03:03:10',1,9,'1','author',3,''),(41,'2012-09-06 03:03:10',1,9,'2','corrector',3,''),(42,'2012-09-06 03:03:10',1,9,'3','implementer',3,''),(43,'2012-09-06 03:03:10',1,9,'4','tester',3,''),(44,'2012-09-06 03:03:20',1,11,'1','author',1,''),(45,'2012-09-06 03:03:27',1,11,'2','corrector',1,''),(46,'2012-09-06 03:03:36',1,11,'3','implementer',1,''),(47,'2012-09-06 03:03:38',1,11,'4','tester',1,''),(48,'2012-09-06 04:57:22',1,4,'3','baraban',2,'Изменен password и last_name.'),(49,'2012-09-07 01:47:24',1,10,'9','',3,''),(50,'2012-09-07 01:52:50',1,10,'10','',3,''),(51,'2012-09-07 02:35:18',1,10,'12','',3,''),(52,'2012-09-07 02:35:18',1,10,'13','7о',3,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'registration profile','registration','registrationprofile'),(9,'Роль пользователя','app','userrole'),(10,'Бизнес-требование','app','node'),(11,'Роль','app','personrole'),(12,'Люди по ролям в узлах','app','personroledetection'),(13,'Релиз','app','release'),(14,'Статус','app','status'),(15,'Задача','app','currenttask'),(16,'Файл','app','fileinnodes'),(17,'История редактирования БТ','app','nodeeditionhistory'),(18,'Тип отношений между узлами','app','typeofnodesrelationship'),(19,'Отношения между узлами','app','nodesrelationship'),(20,'Требование','app','requirement'),(21,'История редактирования требований','app','requirementsedition'),(22,'Люди по ролям в требованиях','app','personrolerequirementdetection');
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
INSERT INTO `django_session` VALUES ('2257848157cb2224a88fa063132e83ba','NjU2YTA0ODk4ZTQzZmZhZjU0Njg0MzA1OTViYzk3ODBiNzI4MTU1ODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n','2012-10-08 02:00:39'),('340399d24b4b36f197aed7fc550342ff','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-10-08 02:11:02'),('a4835b50e2b83185a2116a721d0d3d33','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-09-21 01:24:43');
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

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_313280c4` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
INSERT INTO `registration_registrationprofile` VALUES (1,4,'228391c92dad96544c837e878862266dfe934530');
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

-- Dump completed on 2012-10-01  4:18:46
