-- MySQL dump 10.13  Distrib 5.5.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: anychart_tree_db
-- ------------------------------------------------------
-- Server version	5.5.28-0ubuntu0.12.04.2

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
-- Table structure for table `app_file`
--

DROP TABLE IF EXISTS `app_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_file`
--

LOCK TABLES `app_file` WRITE;
/*!40000 ALTER TABLE `app_file` DISABLE KEYS */;
INSERT INTO `app_file` VALUES (2,'Circular axis angles sample','files/circular-axis-angles-sample-2.zip','2012-10-18 08:58:24'),(15,'Footer.jpg','files/preview.jpg','2012-10-24 07:52:59'),(17,'Sample-parts-gauge.pdf','files/111.pdf','2012-10-24 08:02:55'),(31,'Главная страница.jpg','files/282077-1920x1080_5.jpg','2012-10-24 08:34:27'),(34,'Главная страница.jpg','files/282077-1920x1080_7.jpg','2012-10-24 08:49:05'),(37,'tumblr_m75i1usLG41ra3jlho1_1280.jpg','files/tumblr_m75i1usLG41ra3jlho1_1280.jpg','2012-10-25 02:12:39'),(38,'tumblr_m7v6jeW0kr1rx93fyo1_400.jpg','files/tumblr_m7v6jeW0kr1rx93fyo1_400.jpg','2012-10-25 02:14:08'),(39,'шпатель.jpg','files/121019115024_russia_migrants_guide_photos_304x171_roovzglyadvbudushchee_nocredit.jpg','2012-10-25 02:21:19'),(45,'293406-1920x1080.jpg','files/293406-1920x1080.jpg','2012-10-30 04:37:04'),(46,'Baikal.jpg','files/298018-1920x1080_2.jpg','2012-10-25 07:38:30'),(47,'Cup coffee.png','files/Cup_coffee.png','2012-10-26 03:52:01'),(48,'Белый.jpg','files/239152-1920x1080_3.jpg','2012-10-30 03:53:09'),(49,'Травка.jpg','files/276817-1920x1080_2.jpg','2012-10-30 04:02:03'),(50,'Baikal.jpg','files/282077-1920x1080_9.jpg','2012-10-31 09:09:52'),(51,'Footer.jpg','files/282077-1920x1080_10.jpg','2012-10-31 09:13:11'),(52,'Первый.jpg','files/282077-1920x1080_11.jpg','2012-10-31 09:16:04'),(53,'Footer.jpg','files/293406-1920x1080_1.jpg','2012-11-01 03:50:22'),(54,'aerf.jpg','files/239152-1920x1080_4.jpg','2012-11-01 03:51:46'),(55,'flowers.jpg','files/flowers-wallpaper-1920x1200-084_3.jpg','2012-11-01 03:54:06');
/*!40000 ALTER TABLE `app_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_node`
--

DROP TABLE IF EXISTS `app_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `name_id` varchar(300) NOT NULL,
  `product_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `type` varchar(2) NOT NULL,
  `curator_id` int(11) DEFAULT NULL,
  `developer_id` int(11) DEFAULT NULL,
  `tester_id` int(11) DEFAULT NULL,
  `cur_status_id` int(11) DEFAULT NULL,
  `cur_release_id` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `source_description` varchar(300) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `last_modified_date` datetime NOT NULL,
  `content` longtext,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_node_bb420c12` (`product_id`),
  KEY `app_node_63f17a16` (`parent_id`),
  KEY `app_node_f0bd6439` (`type`),
  KEY `app_node_e3c053ed` (`curator_id`),
  KEY `app_node_4e11fbc7` (`developer_id`),
  KEY `app_node_aecd2d61` (`tester_id`),
  KEY `app_node_76d3f713` (`cur_status_id`),
  KEY `app_node_e69658ff` (`cur_release_id`),
  KEY `app_node_89f89e85` (`source_id`),
  KEY `app_node_42b06ff6` (`lft`),
  KEY `app_node_91543e5a` (`rght`),
  KEY `app_node_efd07f28` (`tree_id`),
  KEY `app_node_2a8f42e8` (`level`),
  CONSTRAINT `curator_id_refs_id_296f0a68` FOREIGN KEY (`curator_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `cur_release_id_refs_id_eade2d3` FOREIGN KEY (`cur_release_id`) REFERENCES `app_release` (`id`),
  CONSTRAINT `cur_status_id_refs_id_8dccdbd5` FOREIGN KEY (`cur_status_id`) REFERENCES `app_status` (`id`),
  CONSTRAINT `developer_id_refs_id_296f0a68` FOREIGN KEY (`developer_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `parent_id_refs_id_eff33d7d` FOREIGN KEY (`parent_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `product_id_refs_id_83d4b8bb` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`),
  CONSTRAINT `source_id_refs_id_c824e9b8` FOREIGN KEY (`source_id`) REFERENCES `app_source` (`id`),
  CONSTRAINT `tester_id_refs_id_296f0a68` FOREIGN KEY (`tester_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (2,'Тестовый узел','AC-1',1,NULL,'BR',1,10,13,3,50,1,'','2012-11-01 05:07:11','2012-11-01 05:07:11','<p>\n	&nbsp;</p>\n<p class=\"main\" style=\"color: rgb(51, 51, 51); line-height: 18px; text-align: left; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; \">\n	Thank you for choosing AnyChart Flash Chart Component! This page is a starting point for all documentation, samples and reference materials shipped with our charting component. If you can&#39;t find answer to any of your questions - do not hesitate to&nbsp;<a href=\"http://www.anychart.com/products/anychart/docs/users-guide/startup.html#support\" style=\"color: rgb(0, 102, 153); text-decoration: none; \">contact our technical support team</a>.</p>\n<p class=\"main\" style=\"color: rgb(51, 51, 51); line-height: 18px; text-align: left; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; \">\n	User&#39;s Guide, XML Reference and Chart Gallery can be found online at&nbsp;<a href=\"http://www.anychart.com/\" style=\"color: rgb(0, 102, 153); text-decoration: none; \">http://www.anychart.com/</a></p>\n<div>\n	&nbsp;</div>\n',1,14,2,0),(3,'Требование 2','AC-2',1,2,'OR',1,NULL,NULL,1,NULL,NULL,'','2012-11-01 05:06:00','2012-11-01 05:06:00','',8,9,2,1),(6,'Требование 3','AC-3',1,2,'OR',1,NULL,NULL,1,NULL,NULL,'','2012-11-15 07:41:40','2012-11-15 07:41:40','',6,7,2,1),(7,'Тестовый узел 45-78','AC-4',1,2,'BR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 04:33:25','2012-11-01 04:33:25',NULL,10,11,2,1),(8,'Требование 541','AC-5',1,2,'OR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 04:50:31','2012-11-01 04:50:31',NULL,4,5,2,1),(9,'Узел 231','AC-6',1,NULL,'BR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 04:50:49','2012-11-01 04:50:49',NULL,1,4,1,0),(10,'папка для сбора мусора','AC-7',1,NULL,'NE',1,NULL,NULL,6,NULL,NULL,NULL,'2012-11-01 08:10:47','2012-11-01 08:10:47',NULL,1,2,4,0),(11,'Папка','AC-8',1,2,'NE',1,NULL,NULL,6,NULL,NULL,NULL,'2012-11-01 08:14:50','2012-11-01 08:14:50',NULL,12,13,2,1),(12,'Узел узловатый','AC-9',1,9,'BR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 08:15:40','2012-11-01 08:15:40',NULL,2,3,1,1),(13,'Домашний','AC-10',1,NULL,'BR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 08:19:50','2012-11-01 08:19:50',NULL,1,2,5,0),(14,'Папка с чем-то','AC-11',1,NULL,'NE',1,NULL,NULL,1,NULL,NULL,NULL,'2012-11-01 08:20:01','2012-11-01 08:20:01',NULL,1,2,3,0);
/*!40000 ALTER TABLE `app_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_node_files`
--

DROP TABLE IF EXISTS `app_node_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_node_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`,`file_id`),
  KEY `app_node_files_474baebc` (`node_id`),
  KEY `app_node_files_2243e3be` (`file_id`),
  CONSTRAINT `file_id_refs_id_c93a90b1` FOREIGN KEY (`file_id`) REFERENCES `app_file` (`id`),
  CONSTRAINT `node_id_refs_id_ecd033eb` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_node_files`
--

LOCK TABLES `app_node_files` WRITE;
/*!40000 ALTER TABLE `app_node_files` DISABLE KEYS */;
INSERT INTO `app_node_files` VALUES (72,2,51),(73,2,52),(74,3,53),(75,3,54),(76,3,55),(70,68,48),(71,68,49);
/*!40000 ALTER TABLE `app_node_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_product`
--

DROP TABLE IF EXISTS `app_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `short_name` varchar(300) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_product`
--

LOCK TABLES `app_product` WRITE;
/*!40000 ALTER TABLE `app_product` DISABLE KEYS */;
INSERT INTO `app_product` VALUES (1,'AnyChart','AC','<p>AnyChart is a flexible Flash/JavaScript (HTML5) based charting solution.  \r\n<p>AnyChart enables any organization to add cross-browser and cross-platform interactive charts, dashboards, graphs and maps to their applications. Using AnyChart, our customers are able to maximize the value of their applications by easily adding data visualization tools that:\r\n<ul>\r\n<li>Enable better analysis and decision making by allowing comprehensive and free-flowing data exploration.  This provides the ability to spot patterns and trends.</li>\r\n<li>Increase customer satisfaction by enhancing the look of any application, report, or presentation.</li>\r\n<li>Lower developments cost and speed time-to market.</li>\r\n<p>We currently provide charting solutions to thousands of companies in over 100 countries across all industries. Leaders trust us.\r\n\r\nWith our extensive Partner Program our solution enhances the visualization for their clients with an out of the box solution to their specific needs.'),(2,'AnyGantt','AG','<p>AnyGantt is an advanced Flash based data-visualization solution, allowing everyone to utilize power of animation and ultimate interactivity. AnyGantt is an ideal tool for building complex and informative Gantt charts.\r\n<p>AnyGantt is fully cross-browser and cross-platform. It can be used with ASP.NET, ASP, PHP, JSP, ColdFusion, Ruby on Rails, simple HTML pages or PowerPoint Presentations. AnyGantt uses XML as universal data interface, so you can visualize data from any warehouse: from files in text, Excel, CSV formats to MySQL, MS SQL, and Oracle database servers.\r\n<p>There is no need to have any Flash skills or knowledge, use server or desktop platform of your choice to create your application - AnyGantt solution will take care of charting. Right visualization helps you to turn your data into Right Decisions! If you need advanced, award winning Gantt diagrams, then AnyGantt is the perfect solution for you.'),(3,'AnyStock','AS','<p>AnyChart Stock and Financial Charts (short name: AnyStock) is an XML/JSON Flash based financial charting solution. AnyStock technology turns your real time data into highly sophisticated charts with interactive capability, bringing visualization of your data to the Web. Designed to display data and time based information, AnyStock is the ideal tool for client reporting and performance based reporting applications. Reports and Dashboards are visualized with scrolling, drill downs, panning and zoom functionality.\r\n<p>AnyStock offers a wide variety of financial chart types and technical indicators including SMA, EMA, MACD, Bollinger Bands and PSAR, to name just a few. AnyStock brings analysis of your FOREX, commodity and investment market data to life. The ability to review long term and large data sets can easily be handled with scroll, pan, and zoom controls. Adding news events (analyst opinions, insider trading, dividends, and key developments) improves your ability to analyze information effectively.');
/*!40000 ALTER TABLE `app_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_release`
--

DROP TABLE IF EXISTS `app_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_release` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `number` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `description` longtext NOT NULL,
  `date` datetime DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_release_bb420c12` (`product_id`),
  CONSTRAINT `product_id_refs_id_436b7acb` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,'Первый','1.0',0,'','2012-10-31 03:00:00',1),(4,'Третий','3',0,'','2014-08-31 15:00:00',1),(23,'Новогодний','2.90',0,'Оставьте суету. ','2013-04-05 15:00:00',1),(26,'Стопятьсот','12',0,'Невзрачный комментарий.','2013-04-05 15:00:00',1),(29,'Релиз Важный','12',0,'ываыва','2013-04-05 15:00:00',1),(33,'Замечательный','1',0,'ну... ','2013-04-05 15:00:00',1),(37,'Второй','ыява',0,'','2013-04-05 15:00:00',1),(48,'Релизный релиз','12.345',0,'Нужно его выпустить своевременно!','2013-05-25 15:00:00',1),(49,'Новый преновый','2',0,'Описание релиза','2013-04-05 15:00:00',1),(50,'Завтра!','45',0,'Описание','2012-10-05 15:00:00',1);
/*!40000 ALTER TABLE `app_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_releasehistory`
--

DROP TABLE IF EXISTS `app_releasehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_releasehistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_node_id` int(11) NOT NULL,
  `id_release_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_release_id_refs_id_78111888` (`id_release_id`),
  KEY `app_releasehistory_243c846f` (`id_node_id`),
  CONSTRAINT `id_node_id_refs_id_830587c8` FOREIGN KEY (`id_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `id_release_id_refs_id_78111888` FOREIGN KEY (`id_release_id`) REFERENCES `app_release` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_releasehistory`
--

LOCK TABLES `app_releasehistory` WRITE;
/*!40000 ALTER TABLE `app_releasehistory` DISABLE KEYS */;
INSERT INTO `app_releasehistory` VALUES (1,2,29,'Релиз поменяла','2012-10-31 09:09:14'),(2,2,49,'','2012-10-31 09:09:39'),(3,2,50,'','2012-11-01 05:07:11');
/*!40000 ALTER TABLE `app_releasehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_source`
--

DROP TABLE IF EXISTS `app_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_source`
--

LOCK TABLES `app_source` WRITE;
/*!40000 ALTER TABLE `app_source` DISABLE KEYS */;
INSERT INTO `app_source` VALUES (1,'аналитика'),(2,'клиентский запрос'),(3,'отчет об ошибке');
/*!40000 ALTER TABLE `app_source` ENABLE KEYS */;
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
  `color` varchar(7) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
INSERT INTO `app_status` VALUES (1,'создано','#696969'),(2,'на согласовании','#778899'),(3,'в процессе реализации','#CD3700'),(4,'в процессе проверки','#EE7621'),(5,'реализовано','#698B22'),(6,'удалено','#cccccc');
/*!40000 ALTER TABLE `app_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_statushistory`
--

DROP TABLE IF EXISTS `app_statushistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_statushistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_node_id` int(11) NOT NULL,
  `id_status_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_status_id_refs_id_f8736998` (`id_status_id`),
  KEY `app_statushistory_243c846f` (`id_node_id`),
  CONSTRAINT `id_node_id_refs_id_d2e110f0` FOREIGN KEY (`id_node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `id_status_id_refs_id_f8736998` FOREIGN KEY (`id_status_id`) REFERENCES `app_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_statushistory`
--

LOCK TABLES `app_statushistory` WRITE;
/*!40000 ALTER TABLE `app_statushistory` DISABLE KEYS */;
INSERT INTO `app_statushistory` VALUES (100,67,1,'Just created','2012-10-29 03:43:37'),(101,68,1,'Just created','2012-10-30 02:06:29'),(102,68,6,'Тестовое удаление','2012-10-30 02:06:48'),(103,68,1,'Восстановлено из корзины','2012-10-30 02:27:30'),(104,68,6,'Еще раз удаляю','2012-10-30 02:29:50'),(108,67,6,'И этот узел надоел','2012-10-30 02:56:37'),(115,68,1,'Восстановлено из корзины','2012-10-30 03:36:10'),(116,68,6,'Удаляю последний раз','2012-10-30 03:36:43'),(117,68,1,'Восстановлено из корзины','2012-10-30 03:36:50'),(118,69,1,'Just created','2012-10-31 04:49:33'),(119,70,1,'Just created','2012-10-31 04:51:41'),(120,71,1,'Just created','2012-10-31 04:52:01'),(121,72,1,'Just created','2012-10-31 04:54:03'),(122,73,1,'Just created','2012-10-31 04:54:20'),(124,2,1,'Just created','2012-10-31 05:16:01'),(125,3,1,'Just created','2012-10-31 05:16:27'),(126,2,3,'Уже согласовываем','2012-10-31 09:08:50'),(127,3,6,'','2012-11-01 03:49:48'),(128,3,1,'Восстановлено из корзины','2012-11-01 03:49:56'),(131,6,1,'Just created','2012-11-01 04:32:58'),(132,7,1,'Just created','2012-11-01 04:33:25'),(133,8,1,'Just created','2012-11-01 04:50:31'),(134,9,1,'Just created','2012-11-01 04:50:49'),(135,10,1,'Just created','2012-11-01 04:51:02'),(136,10,6,'не нужна больше папка эта!','2012-11-01 08:10:47'),(137,11,1,'Just created','2012-11-01 08:14:39'),(138,11,6,'Удаляю','2012-11-01 08:14:50'),(139,12,1,'Just created','2012-11-01 08:15:40'),(140,13,1,'Just created','2012-11-01 08:19:50'),(141,14,1,'Just created','2012-11-01 08:20:01');
/*!40000 ALTER TABLE `app_statushistory` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (3,'curators'),(1,'developers'),(2,'testers');
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
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `group_id_refs_id_3cea63fe` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_a7792de1` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (49,3,25),(50,3,26),(51,3,27),(52,3,28),(53,3,29),(54,3,30),(55,3,31),(56,3,32),(57,3,33),(58,3,34),(59,3,35),(60,3,36),(61,3,37),(62,3,38),(63,3,39),(64,3,40),(65,3,41),(66,3,42),(67,3,43),(68,3,44),(69,3,45),(70,3,46),(71,3,47),(72,3,48);
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
  KEY `auth_permission_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_728de91f` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add registration profile',8,'add_registrationprofile'),(23,'Can change registration profile',8,'change_registrationprofile'),(24,'Can delete registration profile',8,'delete_registrationprofile'),(25,'Can add продукт',9,'add_product'),(26,'Can change продукт',9,'change_product'),(27,'Can delete продукт',9,'delete_product'),(28,'Can add релиз',10,'add_release'),(29,'Can change релиз',10,'change_release'),(30,'Can delete релиз',10,'delete_release'),(31,'Can add статус',11,'add_status'),(32,'Can change статус',11,'change_status'),(33,'Can delete статус',11,'delete_status'),(34,'Can add источник',12,'add_source'),(35,'Can change источник',12,'change_source'),(36,'Can delete источник',12,'delete_source'),(37,'Can add файл',13,'add_file'),(38,'Can change файл',13,'change_file'),(39,'Can delete файл',13,'delete_file'),(40,'Can add узел дерева',14,'add_node'),(41,'Can change узел дерева',14,'change_node'),(42,'Can delete узел дерева',14,'delete_node'),(43,'Can add историю смены статусов',15,'add_statushistory'),(44,'Can change историю смены статусов',15,'change_statushistory'),(45,'Can delete историю смены статусов',15,'delete_statushistory'),(46,'Can add историю смены релиза',16,'add_releasehistory'),(47,'Can change историю смены релиза',16,'change_releasehistory'),(48,'Can delete историю смены релиза',16,'delete_releasehistory');
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'olga','Administrotar','','olga@irnok.net','pbkdf2_sha256$10000$56vEfZGptbFi$OMLpUzmpiK1EM5U29iRgo1lu2JfTtr7XozO4E41X9Sc=',1,1,1,'2012-11-13 04:14:19','2012-10-10 08:11:41'),(2,'olga.vorobyeva','Olga','Vorobyeva','olga.vorobyeva@anychart.com','pbkdf2_sha256$10000$OH95eutxXqT0$xEkhK+nF9Wmc8ppxdMGStCeT3zvX15Qfab1Q4Oxc3Og=',0,1,0,'2012-10-25 03:54:53','2012-10-10 09:31:50'),(3,'alex.batsuev','Alexander','Batsuev','alex.batsuev@anychart.com','pbkdf2_sha256$10000$MrPmYRbzmdtD$LaxDmaZqkO/6y4GqXvDEVMnV+hqpBpCAYbFVUIcMbXI=',0,1,0,'2012-10-11 01:39:28','2012-10-11 01:39:28'),(4,'alexander.kudryavtsev','Alexander','Kudryavtsev','alexander.kudryavtsev@anychart.com','pbkdf2_sha256$10000$nWP8IzMCRbP1$5uZfgBbDqFqRbNE17tMPT2kSzkVI0x9aCgfCfGcTpsw=',0,1,0,'2012-10-11 01:55:48','2012-10-11 01:55:48'),(5,'alexandra.batireva','Alexandra','Batireva','alexandra.batireva@anychart.com','pbkdf2_sha256$10000$geICMoJPYsBm$E2TJ4AqXyM8jm279Umo/ehbRT2KPd2kbAcu8vjGieR0=',0,1,0,'2012-10-25 02:45:26','2012-10-11 01:58:01'),(6,'andrey.shakhmin','Andrey','Shakhmin','andrey.shakhmin@anychart.com','pbkdf2_sha256$10000$RtpgMzutZFHd$dBrqqrfvVcQJ8Br6QV6JyMUKMn5xaKc9HHw21hJnxUQ=',0,1,0,'2012-10-26 03:50:14','2012-10-11 01:58:50'),(7,'anton.baranchuk','Anton','Baranchuk','anton.baranchuk@anychart.com','pbkdf2_sha256$10000$EViHtV8bPXNL$EyJS7NYwO2ccL9pv1a2XunNIyRp3cMSJdOwdtDSZYY0=',0,1,0,'2012-10-11 01:59:36','2012-10-11 01:59:36'),(8,'anton.kagakin','Anton','Kagakin','anton.kagakin@anychart.com','pbkdf2_sha256$10000$r8tdl4i6vlt8$9WSBE+HY9u4yrdLGzQ7LBg744WNiK35SYMKEOW69yBg=',0,1,0,'2012-10-11 02:01:36','2012-10-11 02:01:36'),(9,'anton.saukh','Anton','Saukh','anton.saukh@anychart.com','pbkdf2_sha256$10000$OUFHgaeaMmSv$vOiBpDkhqSrPN6OK0F3Ydowq+oG3vw79UTnsGCLV3ts=',0,1,0,'2012-10-11 02:04:03','2012-10-11 02:04:03'),(10,'roman.lubushkin','Roman','Lubushkin','roman.lubushkin@anychart.com','pbkdf2_sha256$10000$iiZC6tFyvxQf$vo/qP2MArrlBXs7FwGB+9fvJcZRPDzvsS1HlgK/REeg=',0,1,0,'2012-10-11 02:05:05','2012-10-11 02:05:05'),(11,'sergey.medvedev','Sergey','Medvedev','sergey.medvedev@anychart.com','pbkdf2_sha256$10000$ndKr0Ry2rmzd$2muTNrXNenHWdtTaAtYvRyxPQudILtWXgjhCA+iT4rk=',0,1,0,'2012-10-11 02:05:39','2012-10-11 02:05:39'),(12,'timothy.loginov','Timothy','Loginov','timothy.loginov@anychart.com','pbkdf2_sha256$10000$ohBB0JX3HxDj$hlr9WF+T4HNCnk2pGoBtCN2B+TRkd9Y0oUE6gEuuMVM=',0,1,0,'2012-10-11 02:07:02','2012-10-11 02:07:02'),(13,'vitaly.radionov','Vitaly','Radionov','vitaly.radionov@anychart.com','pbkdf2_sha256$10000$CLxm3ml4rUa8$MzwQD4J7koysPYNA+T4+KPVqeDPH81C9SAty4hH0PO4=',0,1,0,'2012-11-15 07:30:10','2012-10-11 02:07:39');
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
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`),
  CONSTRAINT `group_id_refs_id_f0ee9890` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_831107f1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,2,2),(2,2,3),(3,3,1),(4,4,1),(5,5,2),(6,5,3),(7,6,3),(8,7,3),(9,8,1),(10,9,1),(11,10,1),(12,11,1),(13,12,3),(14,13,2),(15,13,3);
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
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_67e79cb` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_f2045483` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_288599e6` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c8665aa` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=362 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-10-10 08:18:35',1,11,'1','Создано',1,''),(2,'2012-10-10 08:19:12',1,10,'1','Первый',1,''),(3,'2012-10-10 08:19:28',1,12,'1','аналитика',1,''),(4,'2012-10-10 08:22:36',1,14,'1','Письмо участника',1,''),(5,'2012-10-10 08:23:13',1,14,'1','Требования к компоненту',2,'Изменен title и type.'),(6,'2012-10-10 08:23:30',1,14,'2','Требования к сопроводительным материалам',1,''),(7,'2012-10-10 08:24:04',1,14,'3','пользовательская документация',1,''),(8,'2012-10-10 08:24:11',1,14,'3','Пользовательская документация',2,'Изменен title.'),(9,'2012-10-10 08:24:26',1,14,'2','Сопроводительные материалы',2,'Изменен title.'),(10,'2012-10-10 08:24:35',1,14,'1','Компонент',2,'Изменен title.'),(11,'2012-10-10 08:25:02',1,14,'4','Демонстрационные примеры',1,''),(12,'2012-10-10 08:32:09',1,14,'5','Gauges',1,''),(13,'2012-10-10 08:36:36',1,14,'6','Polar Chart ',1,''),(14,'2012-10-10 08:37:19',1,14,'7','X-Axis settings',1,''),(15,'2012-10-10 08:37:49',1,14,'8','Y-Axis settings',1,''),(16,'2012-10-10 08:39:03',1,14,'9','Сircular gauge',1,''),(17,'2012-10-10 08:39:43',1,14,'10','Vertical Gauges ',1,''),(18,'2012-10-10 08:41:40',1,14,'11','Scale Settings and Title',1,''),(19,'2012-10-10 09:12:05',1,14,'12','Labels and Tickmarks',1,''),(20,'2012-10-10 09:12:28',1,14,'13','Color Ranges',1,''),(21,'2012-10-10 09:13:11',1,14,'14','Extra Labels',1,''),(22,'2012-10-10 09:14:32',1,14,'15','Axis Position and Axis Size',1,''),(23,'2012-10-10 09:16:49',1,14,'8','Y-Axis settings',2,'Изменен type.'),(24,'2012-10-10 09:16:54',1,14,'7','X-Axis settings',2,'Изменен type.'),(25,'2012-10-10 09:18:07',1,14,'16','Guages',1,''),(26,'2012-10-10 09:20:06',1,13,'1','Circular Gauge Sample',1,''),(27,'2012-10-10 09:20:16',1,14,'17','Circular Gauge Sample',1,''),(28,'2012-10-10 09:21:09',1,14,'2','Сопроводительные материалы',2,'Изменен cur_status.'),(29,'2012-10-10 09:21:21',1,14,'3','Пользовательская документация',2,'Изменен cur_status.'),(30,'2012-10-10 09:21:27',1,14,'4','Демонстрационные примеры',2,'Изменен cur_status.'),(31,'2012-10-10 09:21:42',1,14,'4','Демонстрационные примеры',2,'Изменен cur_release и source.'),(32,'2012-10-10 09:21:57',1,14,'16','Guages',2,'Изменен cur_status,cur_release и source.'),(33,'2012-10-10 09:22:05',1,14,'17','Circular Gauge Sample',2,'Изменен cur_status,cur_release и source.'),(34,'2012-10-10 09:22:12',1,14,'1','Компонент',2,'Изменен cur_status,cur_release и source.'),(35,'2012-10-10 09:22:20',1,14,'6','Polar Chart ',2,'Изменен cur_status,cur_release и source.'),(36,'2012-10-10 09:22:24',1,14,'6','Polar Chart ',2,'Ни одно поле не изменено.'),(37,'2012-10-10 09:22:34',1,14,'8','Y-Axis settings',2,'Изменен cur_status,cur_release и source.'),(38,'2012-10-10 09:22:36',1,14,'8','Y-Axis settings',2,'Ни одно поле не изменено.'),(39,'2012-10-10 09:22:43',1,14,'7','X-Axis settings',2,'Изменен cur_status,cur_release и source.'),(40,'2012-10-10 09:22:51',1,14,'5','Gauges',2,'Изменен cur_status и cur_release.'),(41,'2012-10-10 09:22:57',1,14,'5','Gauges',2,'Ни одно поле не изменено.'),(42,'2012-10-10 09:23:03',1,14,'9','Сircular gauge',2,'Изменен cur_status,cur_release и source.'),(43,'2012-10-10 09:23:09',1,14,'14','Extra Labels',2,'Изменен cur_status,cur_release и source.'),(44,'2012-10-10 09:23:15',1,14,'15','Axis Position and Axis Size',2,'Изменен cur_status,cur_release и source.'),(45,'2012-10-10 09:23:19',1,14,'15','Axis Position and Axis Size',2,'Ни одно поле не изменено.'),(46,'2012-10-10 09:23:25',1,14,'10','Vertical Gauges ',2,'Изменен cur_status,cur_release и source.'),(47,'2012-10-10 09:23:28',1,14,'10','Vertical Gauges ',2,'Ни одно поле не изменено.'),(48,'2012-10-10 09:23:36',1,14,'11','Scale Settings and Title',2,'Изменен cur_status,cur_release и source.'),(49,'2012-10-10 09:23:41',1,14,'15','Axis Position and Axis Size',2,'Ни одно поле не изменено.'),(50,'2012-10-10 09:23:45',1,14,'11','Scale Settings and Title',2,'Ни одно поле не изменено.'),(51,'2012-10-10 09:23:51',1,14,'12','Labels and Tickmarks',2,'Изменен cur_status,cur_release и source.'),(52,'2012-10-10 09:23:54',1,14,'12','Labels and Tickmarks',2,'Ни одно поле не изменено.'),(53,'2012-10-10 09:24:01',1,14,'13','Color Ranges',2,'Изменен cur_status,cur_release и source.'),(54,'2012-10-10 09:24:32',1,14,'3','Пользовательская документация',2,'Изменен cur_release и source.'),(55,'2012-10-10 09:24:38',1,14,'2','Сопроводительные материалы',2,'Изменен cur_release и source.'),(56,'2012-10-10 09:25:25',1,11,'2','На согласовании',1,''),(57,'2012-10-10 09:26:01',1,11,'3','в процессе реализации',1,''),(58,'2012-10-10 09:26:08',1,11,'2','на согласовании',2,'Изменен title.'),(59,'2012-10-10 09:26:14',1,11,'1','создано',2,'Изменен title.'),(60,'2012-10-10 09:26:43',1,11,'4','в процессе проверки',1,''),(61,'2012-10-10 09:27:03',1,11,'5','реализовано',1,''),(62,'2012-10-10 09:27:21',1,11,'6','удалено',1,''),(63,'2012-10-10 09:27:39',1,11,'1','создано',2,'Изменен color.'),(64,'2012-10-10 09:27:56',1,11,'2','на согласовании',2,'Изменен color.'),(65,'2012-10-10 09:28:14',1,11,'3','в процессе реализации',2,'Изменен color.'),(66,'2012-10-10 09:28:32',1,11,'4','в процессе проверки',2,'Изменен color.'),(67,'2012-10-10 09:29:07',1,12,'2','клиентский запрос',1,''),(68,'2012-10-10 09:29:17',1,12,'3','отчет об ошибке',1,''),(69,'2012-10-10 09:30:17',1,3,'1','olga.vorobyeva',1,''),(70,'2012-10-10 09:30:42',1,3,'1','developers',2,'Изменен name.'),(71,'2012-10-10 09:30:50',1,3,'2','testers',1,''),(72,'2012-10-10 09:31:17',1,3,'3','curators',1,''),(73,'2012-10-10 09:31:25',1,3,'1','developers',2,'Изменен permissions.'),(74,'2012-10-10 09:31:50',1,4,'2','olga.vorobyeva',1,''),(75,'2012-10-10 09:32:40',1,4,'2','olga.vorobyeva',2,'Изменен password,first_name,last_name,email и groups.'),(76,'2012-10-11 01:39:28',1,4,'3','alexander.batsuev',1,''),(77,'2012-10-11 01:40:29',1,4,'3','alex.batsuev',2,'Изменен username,password,first_name,last_name,email и groups.'),(78,'2012-10-11 01:55:48',1,4,'4','alexander.kudryavtsev',1,''),(79,'2012-10-11 01:56:16',1,4,'4','alexander.kudryavtsev',2,'Изменен password,first_name,last_name,email и groups.'),(80,'2012-10-11 01:58:01',1,4,'5','alexandra.batireva',1,''),(81,'2012-10-11 01:58:21',1,4,'5','alexandra.batireva',2,'Изменен password,first_name,last_name,email и groups.'),(82,'2012-10-11 01:58:50',1,4,'6','andrey.shakhmin',1,''),(83,'2012-10-11 01:59:13',1,4,'6','andrey.shakhmin',2,'Изменен password,first_name,last_name,email и groups.'),(84,'2012-10-11 01:59:36',1,4,'7','anton.baranchuk',1,''),(85,'2012-10-11 01:59:51',1,4,'7','anton.baranchuk',2,'Изменен password,first_name,last_name,email и groups.'),(86,'2012-10-11 02:01:36',1,4,'8','anton.kagakin',1,''),(87,'2012-10-11 02:01:56',1,4,'8','anton.kagakin',2,'Изменен password,first_name,last_name,email и groups.'),(88,'2012-10-11 02:04:03',1,4,'9','anton.saukh',1,''),(89,'2012-10-11 02:04:23',1,4,'9','anton.saukh',2,'Изменен password,first_name,last_name,email и groups.'),(90,'2012-10-11 02:05:05',1,4,'10','roman.lubushkin',1,''),(91,'2012-10-11 02:05:25',1,4,'10','roman.lubushkin',2,'Изменен password,first_name,last_name,email и groups.'),(92,'2012-10-11 02:05:39',1,4,'11','sergey.medvedev',1,''),(93,'2012-10-11 02:05:53',1,4,'11','sergey.medvedev',2,'Изменен password,first_name,last_name,email и groups.'),(94,'2012-10-11 02:07:02',1,4,'12','timothy.loginov',1,''),(95,'2012-10-11 02:07:22',1,4,'12','timothy.loginov',2,'Изменен password,first_name,last_name,email и groups.'),(96,'2012-10-11 02:07:40',1,4,'13','vitaly.radionov',1,''),(97,'2012-10-11 02:07:58',1,4,'13','vitaly.radionov',2,'Изменен password,first_name,last_name,email и groups.'),(98,'2012-10-11 02:10:27',1,9,'1','AnyChart',1,''),(99,'2012-10-11 02:25:54',1,15,'1','Polar Chart : на согласовании',1,''),(100,'2012-10-11 02:34:42',1,9,'1','AnyChart',1,''),(101,'2012-10-11 02:35:00',1,10,'1','Первый',1,''),(102,'2012-10-11 02:37:12',1,11,'1','cоздано',1,''),(103,'2012-10-11 02:37:31',1,11,'2','на согласовании',1,''),(104,'2012-10-11 02:37:51',1,11,'3','в процессе реализации',1,''),(105,'2012-10-11 02:38:17',1,11,'4','в процессе проверки',1,''),(106,'2012-10-11 02:38:41',1,11,'5','реализовано',1,''),(107,'2012-10-11 02:39:03',1,11,'6','удалено',1,''),(108,'2012-10-11 02:40:11',1,13,'1','Sample-parts-gauge',1,''),(109,'2012-10-11 02:40:30',1,12,'1','аналитика',1,''),(110,'2012-10-11 02:40:39',1,12,'2','клиентский запрос',1,''),(111,'2012-10-11 02:40:50',1,12,'3','отчет об ошибке',1,''),(112,'2012-10-11 02:41:48',1,14,'1','Требования к компоненту',1,''),(113,'2012-10-11 02:42:02',1,14,'1','Компонент',2,'Изменен title.'),(114,'2012-10-11 02:43:00',1,14,'2','Сопроводительные материалы',1,''),(115,'2012-10-11 02:43:17',1,14,'3','AnyChart',1,''),(116,'2012-10-11 02:43:22',1,14,'2','Сопроводительные материалы',2,'Изменен parent.'),(117,'2012-10-11 02:43:27',1,14,'1','Компонент',2,'Изменен parent.'),(118,'2012-10-11 02:43:46',1,14,'4','Пользовательская документация',1,''),(119,'2012-10-11 02:44:00',1,14,'5','Демонстрационные примеры',1,''),(120,'2012-10-11 02:45:24',1,14,'6','AnyStock',1,''),(121,'2012-10-11 02:45:36',1,14,'7','AnyGantt',1,''),(122,'2012-10-11 02:45:53',1,14,'8','Сопроводительные материалы',1,''),(123,'2012-10-11 02:46:02',1,14,'9','Компонент',1,''),(124,'2012-10-11 02:46:12',1,14,'10','Пользовательская документация',1,''),(125,'2012-10-11 02:46:22',1,14,'11','Демонстрационные примеры',1,''),(126,'2012-10-11 02:46:36',1,14,'12','Сопроводительные материалы',1,''),(127,'2012-10-11 02:46:44',1,14,'13','Компонент',1,''),(128,'2012-10-11 02:46:54',1,14,'14','Пользовательская документация',1,''),(129,'2012-10-11 02:47:04',1,14,'15','Демонстрационные примеры',1,''),(130,'2012-10-11 05:07:00',1,9,'1','AnyChart',1,''),(131,'2012-10-11 05:07:12',1,9,'2','AnyGantt',1,''),(132,'2012-10-11 05:07:32',1,9,'3','AnyStock',1,''),(133,'2012-10-11 05:07:48',1,12,'1','аналитика',1,''),(134,'2012-10-11 05:07:53',1,12,'2','клиентский запрос',1,''),(135,'2012-10-11 05:08:00',1,12,'3','отчет об ошибке',1,''),(136,'2012-10-11 05:08:35',1,10,'1','Первый',1,''),(137,'2012-10-11 05:08:57',1,11,'1','создано',1,''),(138,'2012-10-11 05:09:09',1,11,'2','на согласовании',1,''),(139,'2012-10-11 05:09:19',1,11,'3','в процессе реализации',1,''),(140,'2012-10-11 05:09:28',1,11,'4','в процессе проверки',1,''),(141,'2012-10-11 05:09:39',1,11,'5','реализовано',1,''),(142,'2012-10-11 05:09:54',1,11,'6','удалено',1,''),(143,'2012-10-11 05:10:12',1,13,'1','Sample-parts-gauge',1,''),(144,'2012-10-11 05:10:34',1,14,'1','Компонент',1,''),(145,'2012-10-11 05:10:46',1,14,'2','Сопроводительные материалы',1,''),(146,'2012-10-11 05:10:56',1,14,'3','Пользовательская документация',1,''),(147,'2012-10-11 05:11:08',1,14,'3','Пользовательская документация',2,'Изменен parent.'),(148,'2012-10-11 05:11:23',1,14,'4','Демонстрационные примеры',1,''),(149,'2012-10-11 05:12:17',1,14,'5','Gauges',1,''),(150,'2012-10-11 05:12:54',1,14,'6','Polar Chart ',1,''),(151,'2012-10-11 05:13:39',1,14,'7','X axis settings',1,''),(152,'2012-10-11 05:14:41',1,14,'8','X axis enable/disable',1,''),(153,'2012-10-11 05:15:07',1,14,'9','Tickmarks',1,''),(154,'2012-10-11 05:15:40',1,14,'10','Y axis settings',1,''),(155,'2012-10-11 05:16:33',1,14,'11','Y axis enable/disable',1,''),(156,'2012-10-11 05:17:25',1,14,'12','Linear and Logarithmic scale',1,''),(157,'2012-10-12 02:25:37',1,14,'6','Polar Chart ',2,'Изменен cur_status.'),(158,'2012-10-12 02:25:42',1,14,'10','Y axis settings',2,'Изменен cur_status.'),(159,'2012-10-12 02:25:47',1,14,'11','Y axis enable/disable',2,'Изменен cur_status.'),(160,'2012-10-12 02:25:53',1,14,'12','Linear and Logarithmic scale',2,'Изменен cur_status.'),(161,'2012-10-12 02:25:58',1,14,'7','X axis settings',2,'Изменен cur_status.'),(162,'2012-10-12 02:26:03',1,14,'8','X axis enable/disable',2,'Изменен cur_status.'),(163,'2012-10-12 02:26:13',1,14,'9','Tickmarks',2,'Изменен cur_status.'),(164,'2012-10-12 02:26:19',1,14,'5','Gauges',2,'Изменен cur_status.'),(165,'2012-10-12 02:27:26',1,4,'1','olga',2,'Изменен password и first_name.'),(166,'2012-10-12 02:43:43',1,11,'1','создано',2,'Изменен color.'),(167,'2012-10-12 02:43:57',1,11,'2','на согласовании',2,'Изменен color.'),(168,'2012-10-12 02:44:30',1,11,'4','в процессе проверки',2,'Изменен color.'),(169,'2012-10-12 02:44:39',1,11,'3','в процессе реализации',2,'Изменен color.'),(170,'2012-10-12 02:44:59',1,11,'5','реализовано',2,'Изменен color.'),(171,'2012-10-12 02:48:04',1,11,'2','на согласовании',2,'Изменен color.'),(172,'2012-10-12 02:48:20',1,11,'1','создано',2,'Изменен color.'),(173,'2012-10-12 02:49:03',1,14,'12','Linear and Logarithmic scale',2,'Изменен cur_status.'),(174,'2012-10-12 02:56:15',1,11,'1','создано',2,'Изменен color.'),(175,'2012-10-12 07:23:47',1,11,'3','в процессе реализации',2,'Изменен color.'),(176,'2012-10-12 07:24:48',1,11,'4','в процессе проверки',2,'Изменен color.'),(177,'2012-10-12 07:24:52',1,11,'4','в процессе проверки',2,'Ни одно поле не изменено.'),(178,'2012-10-12 07:25:14',1,11,'3','в процессе реализации',2,'Изменен color.'),(179,'2012-10-12 07:30:42',1,11,'3','в процессе реализации',2,'Изменен color.'),(180,'2012-10-12 07:32:55',1,11,'3','в процессе реализации',2,'Изменен color.'),(181,'2012-10-12 07:34:08',1,11,'3','в процессе реализации',2,'Изменен color.'),(182,'2012-10-12 07:34:40',1,11,'3','в процессе реализации',2,'Ни одно поле не изменено.'),(183,'2012-10-12 07:35:04',1,11,'4','в процессе проверки',2,'Изменен color.'),(184,'2012-10-12 07:35:11',1,11,'3','в процессе реализации',2,'Изменен color.'),(185,'2012-10-18 02:45:37',1,14,'5','Gauges',2,'Изменен curator,developer,tester,cur_release,source,source_description и files.'),(186,'2012-10-18 04:08:55',1,14,'10','Y axis settings',2,'Изменен cur_status.'),(187,'2012-10-18 04:10:03',1,11,'2','на согласовании',2,'Изменен color.'),(188,'2012-10-18 04:10:56',1,11,'2','на согласовании',2,'Изменен color.'),(189,'2012-10-18 08:44:23',1,14,'5','Gauges',2,'Изменен content.'),(190,'2012-10-18 08:47:28',1,14,'5','Gauges',2,'Изменен content.'),(191,'2012-10-18 08:47:59',1,14,'5','Gauges',2,'Изменен content.'),(192,'2012-10-18 08:58:24',1,13,'2','Circular axis angles sample',1,''),(193,'2012-10-18 08:58:28',1,14,'5','Gauges',2,'Изменен files.'),(194,'2012-10-18 09:39:03',1,14,'13','Tickmarks',1,''),(195,'2012-10-18 09:58:24',1,14,'14','Circular Gauge',1,''),(196,'2012-10-18 09:59:07',1,14,'15','Scale Settings and Title',1,''),(197,'2012-10-18 10:00:02',1,14,'16','Color Ranges',1,''),(198,'2012-10-18 10:01:21',1,14,'17','X axis settings',1,''),(199,'2012-10-18 10:02:02',1,14,'18','Y axis settings  ',1,''),(200,'2012-10-18 10:03:02',1,14,'19','Linear and Logarithmic scale',1,''),(201,'2012-10-19 03:51:01',1,15,'1','X axis settings: удалено',2,'Ни одно поле не изменено.'),(202,'2012-10-19 08:11:25',1,14,'6','Polar Chart ',2,'Изменен cur_status.'),(203,'2012-10-19 08:11:31',1,14,'18','Y axis settings  ',2,'Изменен cur_status.'),(204,'2012-10-19 08:11:37',1,14,'19','Linear and Logarithmic scale',2,'Изменен cur_status.'),(205,'2012-10-19 08:11:43',1,14,'5','Gauges',2,'Изменен cur_status.'),(206,'2012-10-19 08:11:48',1,14,'16','Color Ranges',2,'Изменен cur_status.'),(207,'2012-10-19 08:11:54',1,14,'14','Circular Gauge',2,'Изменен cur_status.'),(208,'2012-10-19 08:11:59',1,14,'15','Scale Settings and Title',2,'Изменен cur_status.'),(209,'2012-10-22 02:25:53',1,14,'23','Special Gauge and Pointer Types',3,''),(210,'2012-10-22 02:25:53',1,14,'24','Special Gauge and Pointer Types',3,''),(211,'2012-10-22 02:25:53',1,14,'25','Special Gauge and Pointer Types',3,''),(212,'2012-10-22 02:27:38',1,14,'20','Vertical gauges',3,''),(213,'2012-10-23 05:00:54',1,10,'2','Второй',3,''),(214,'2012-10-23 07:10:42',1,10,'5','Третий',3,''),(215,'2012-10-23 07:10:42',1,10,'15','у',3,''),(216,'2012-10-23 07:10:42',1,10,'14','Восьмисотый',3,''),(217,'2012-10-23 07:10:42',1,10,'8','Second',3,''),(218,'2012-10-23 07:10:42',1,10,'7','Третий',3,''),(219,'2012-10-23 07:10:42',1,10,'6','Третий',3,''),(220,'2012-10-23 07:10:42',1,10,'3','Второй',3,''),(221,'2012-10-23 07:10:42',1,10,'9','Третий',3,''),(222,'2012-10-23 07:10:42',1,10,'12','Пятый',3,''),(223,'2012-10-23 07:10:42',1,10,'11','Пятый',3,''),(224,'2012-10-23 07:10:42',1,10,'10','Пятый',3,''),(225,'2012-10-23 07:10:42',1,10,'18','fgjh',3,''),(226,'2012-10-23 07:10:42',1,10,'17','sdf',3,''),(227,'2012-10-23 07:10:42',1,10,'16','Cegth',3,''),(228,'2012-10-23 07:10:42',1,10,'13','Dddd',3,''),(229,'2012-10-23 07:18:38',1,10,'22','re',3,''),(230,'2012-10-23 07:18:38',1,10,'21','34',3,''),(231,'2012-10-23 07:18:38',1,10,'20','555',3,''),(232,'2012-10-23 07:18:38',1,10,'19','новый',3,''),(233,'2012-10-23 09:06:41',1,14,'37','sf sdg dfg dg w',3,''),(234,'2012-10-23 09:06:41',1,14,'35','ntct 2',3,''),(235,'2012-10-23 09:06:52',1,14,'34','тестовое требование',3,''),(236,'2012-10-23 09:06:52',1,14,'36','dfgh',3,''),(237,'2012-10-23 09:07:38',1,14,'28','Vertical guages',3,''),(238,'2012-10-23 09:07:38',1,14,'26','Vertical gauges',3,''),(239,'2012-10-23 09:07:38',1,14,'29','Vertical gauges',3,''),(240,'2012-10-23 09:07:38',1,14,'30','Vertical gauges',3,''),(241,'2012-10-23 09:07:38',1,14,'31','Vertical gauges',3,''),(242,'2012-10-23 09:07:38',1,14,'32','Vertical gauges',3,''),(243,'2012-10-23 09:07:38',1,14,'33','Vertical gauges',3,''),(244,'2012-10-24 05:01:02',1,14,'6','Polar Chart ',2,'Изменен files.'),(245,'2012-10-24 08:34:09',1,13,'30','гш.pdf',3,''),(246,'2012-10-24 08:34:09',1,13,'29','aerf.jpg',3,''),(247,'2012-10-24 08:34:09',1,13,'28','Sample-parts-gauge.png',3,''),(248,'2012-10-24 08:34:09',1,13,'27','aerf.png',3,''),(249,'2012-10-24 08:34:09',1,13,'26','Footer.png',3,''),(250,'2012-10-24 08:34:09',1,13,'25','Icons.jpg',3,''),(251,'2012-10-24 08:34:09',1,13,'24','Footer.png',3,''),(252,'2012-10-24 08:34:09',1,13,'23','Footer.png',3,''),(253,'2012-10-24 08:34:09',1,13,'22','Первый.png',3,''),(254,'2012-10-24 08:34:09',1,13,'21','Sample-parts-gauge.jpg',3,''),(255,'2012-10-24 08:34:09',1,13,'20','Sample-parts-gauge.jpg',3,''),(256,'2012-10-24 08:34:09',1,13,'19','Первый.png',3,''),(257,'2012-10-24 08:34:09',1,13,'18','Главная страница.jpg',3,''),(258,'2012-10-24 08:34:10',1,13,'16','Sample-parts-gauge.bmp',3,''),(259,'2012-10-24 08:34:10',1,13,'14','Footer.jpg',3,''),(260,'2012-10-24 08:34:10',1,13,'13','Первый.jpg',3,''),(261,'2012-10-24 08:34:10',1,13,'12','Главная страница.jpg',3,''),(262,'2012-10-24 08:34:10',1,13,'11','Baikal.jpg',3,''),(263,'2012-10-24 08:34:10',1,13,'10','Baikal.png',3,''),(264,'2012-10-24 08:34:10',1,13,'9','Footer.png',3,''),(265,'2012-10-24 08:34:10',1,13,'8','aerf.png',3,''),(266,'2012-10-24 08:34:10',1,13,'7','aerf.jpg',3,''),(267,'2012-10-24 08:34:10',1,13,'6','aerf.jpg',3,''),(268,'2012-10-24 08:34:10',1,13,'5','Главная страница.jpg',3,''),(269,'2012-10-24 08:34:10',1,13,'4','Первый.jpg',3,''),(270,'2012-10-24 08:34:10',1,13,'3','Baikal.jpg',3,''),(271,'2012-10-24 08:34:10',1,13,'1','Sample-parts-gauge',3,''),(272,'2012-10-25 09:20:08',1,16,'6','новое требование: екп',3,''),(273,'2012-10-25 09:20:08',1,16,'5','никак: екп',3,''),(274,'2012-10-25 09:20:08',1,16,'3','Новое прелестное требование: Первый',3,''),(275,'2012-10-25 09:20:08',1,16,'2','Новое прелестное требование: Третий',3,''),(276,'2012-10-25 09:20:08',1,16,'1','Новое прелестное требование: Новогодний',3,''),(277,'2012-10-25 09:25:09',1,16,'12','Новое прелестное требование: Релиз Важный',3,''),(278,'2012-10-25 09:25:09',1,16,'11','Новое прелестное требование: Самый хороший ',3,''),(279,'2012-10-25 09:25:09',1,16,'10','Новое прелестное требование: Замечательный',3,''),(280,'2012-10-25 09:25:09',1,16,'9','Новое прелестное требование: Самый хороший ',3,''),(281,'2012-10-25 09:26:05',1,16,'13','Новое прелестное требование: Релиз Важный',3,''),(282,'2012-10-25 09:30:39',1,16,'16','Новое прелестное требование: Релиз Важный',3,''),(283,'2012-10-25 09:30:39',1,16,'15','Новое прелестное требование: Самый хороший ',3,''),(284,'2012-10-25 09:30:39',1,16,'14','Новое прелестное требование: Стопятьсот',3,''),(285,'2012-10-25 10:00:35',1,14,'51','',3,''),(286,'2012-10-25 10:00:40',1,14,'50','',3,''),(287,'2012-10-25 10:00:48',1,14,'52','паиапи',3,''),(288,'2012-10-25 10:01:00',1,14,'6','Polar Chart ',2,'Изменен curator.'),(289,'2012-10-25 10:01:34',1,14,'47','никак',3,''),(290,'2012-10-25 10:01:34',1,14,'49','требование',3,''),(291,'2012-10-25 10:01:34',1,14,'48','новое требование',3,''),(292,'2012-10-26 01:20:22',1,10,'47','df',3,''),(293,'2012-10-26 01:20:23',1,10,'46','df',3,''),(294,'2012-10-26 01:20:23',1,10,'45','gj',3,''),(295,'2012-10-26 01:20:23',1,10,'44','gj',3,''),(296,'2012-10-26 01:20:23',1,10,'43','gj',3,''),(297,'2012-10-26 01:20:23',1,10,'42','Dfdv',3,''),(298,'2012-10-26 01:20:23',1,10,'41','Dfdv',3,''),(299,'2012-10-26 01:20:23',1,10,'40','Dfdv',3,''),(300,'2012-10-26 01:20:23',1,10,'39','Dfdv',3,''),(301,'2012-10-26 01:20:23',1,10,'38','asf',3,''),(302,'2012-10-26 01:20:23',1,10,'36','Второй',3,''),(303,'2012-10-26 01:20:23',1,10,'35','Второй',3,''),(304,'2012-10-26 01:20:23',1,10,'34','чвпр',3,''),(305,'2012-10-26 01:20:23',1,10,'32','Замечательный',3,''),(306,'2012-10-26 01:20:23',1,10,'31','Замечательный',3,''),(307,'2012-10-26 01:20:23',1,10,'30','fh',3,''),(308,'2012-10-26 01:20:23',1,10,'28','Релиз Важный',3,''),(309,'2012-10-26 01:20:23',1,10,'25','Привет ',3,''),(310,'2012-10-26 01:20:23',1,10,'24','Самый хороший ',3,''),(311,'2012-10-26 01:20:23',1,10,'27','екп',3,''),(312,'2012-10-26 01:21:49',1,15,'48','Gauges: в процессе проверки',2,'Изменен description.'),(313,'2012-10-26 01:22:17',1,15,'5','Polar Chart : создано',2,'Изменен id_status и description.'),(314,'2012-10-26 01:22:24',1,15,'5','Polar Chart : создано',2,'Изменен description.'),(315,'2012-10-26 01:28:55',1,15,'77','Y axis settings  : в процессе реализации',2,'Изменен description.'),(316,'2012-10-26 01:29:10',1,15,'78','Y axis settings  : в процессе проверки',2,'Изменен description.'),(317,'2012-10-26 01:37:50',1,13,'35','.jpg',3,''),(318,'2012-10-26 02:31:05',1,14,'53','Документ 1',3,''),(319,'2012-10-26 02:31:05',1,14,'17','X axis settings',3,''),(320,'2012-10-26 02:31:05',1,14,'27','Vertical guages',3,''),(321,'2012-10-26 02:44:10',1,15,'85','Download examples : удалено',3,''),(322,'2012-10-26 05:24:19',1,14,'58','General User\'s Guide',3,''),(323,'2012-10-26 05:24:19',1,14,'59','XML Reference',3,''),(324,'2012-10-26 05:24:19',1,14,'56','General User\'s Guide',3,''),(325,'2012-10-26 05:24:19',1,14,'57','Download examples ',3,''),(326,'2012-10-26 05:24:19',1,14,'6','Polar Chart ',3,''),(327,'2012-10-26 05:24:19',1,14,'60','Требование 1',3,''),(328,'2012-10-26 05:24:19',1,14,'18','Y axis settings  ',3,''),(329,'2012-10-26 05:24:19',1,14,'19','Linear and Logarithmic scale',3,''),(330,'2012-10-26 05:24:19',1,14,'5','Gauges',3,''),(331,'2012-10-26 05:24:19',1,14,'21','Horizontal gauges',3,''),(332,'2012-10-26 05:24:19',1,14,'55','Bar Pointer',3,''),(333,'2012-10-26 05:24:19',1,14,'16','Color Ranges',3,''),(334,'2012-10-26 05:24:20',1,14,'14','Circular Gauge',3,''),(335,'2012-10-26 05:24:20',1,14,'15','Scale Settings and Title',3,''),(336,'2012-10-26 05:24:20',1,14,'61','Chart Module',3,''),(337,'2012-10-26 05:24:20',1,14,'63','Что-то Еще',3,''),(338,'2012-10-26 05:24:20',1,14,'64','Что-то Еще',3,''),(339,'2012-10-26 05:24:20',1,14,'65','Что-то Еще',3,''),(340,'2012-10-26 05:24:20',1,14,'66','Новое требование ))',3,''),(341,'2012-10-26 05:24:20',1,14,'62','Отступы относительно границ контейнера',3,''),(342,'2012-10-30 03:35:31',1,15,'114','Тестовое: удалено',3,''),(343,'2012-10-30 03:35:31',1,15,'113','Тестовый: создано',3,''),(344,'2012-10-30 03:35:31',1,15,'112','Тестовое: удалено',3,''),(345,'2012-10-30 03:35:31',1,15,'111','Тестовое: удалено',3,''),(346,'2012-10-30 03:35:31',1,15,'110','Тестовое: удалено',3,''),(347,'2012-10-30 03:35:31',1,15,'109','Тестовое: удалено',3,''),(348,'2012-10-30 03:35:31',1,15,'107','Тестовое: удалено',3,''),(349,'2012-10-30 03:35:31',1,15,'106','Тестовое: удалено',3,''),(350,'2012-10-30 03:35:56',1,15,'105','Тестовое: создано',3,''),(351,'2012-10-30 04:37:04',1,13,'45','293406-1920x1080.jpg',2,'Ни одно поле не изменено.'),(352,'2012-10-30 07:36:10',1,14,'68','Тестовое',2,'Изменен content.'),(353,'2012-10-30 07:43:18',1,14,'68','Тестовое',2,'Изменен content.'),(354,'2012-10-31 05:05:00',1,9,'1','AnyChart',1,''),(355,'2012-10-31 05:05:35',1,9,'2','AnyGantt',1,''),(356,'2012-10-31 05:06:06',1,9,'3','AnyStock',1,''),(357,'2012-10-31 05:15:51',1,14,'1','Главный узел',3,''),(358,'2012-10-31 05:17:18',1,14,'3','Требование 2',2,'Изменен name_id.'),(359,'2012-10-31 05:17:24',1,14,'2','Eptk',2,'Изменен name_id.'),(360,'2012-11-01 04:18:00',1,14,'4','Папка',3,''),(361,'2012-11-01 04:31:47',1,14,'5','Требование 5',3,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'registration profile','registration','registrationprofile'),(9,'продукт','app','product'),(10,'релиз','app','release'),(11,'статус','app','status'),(12,'источник','app','source'),(13,'файл','app','file'),(14,'узел дерева','app','node'),(15,'историю смены статусов','app','statushistory'),(16,'историю смены релиза','app','releasehistory');
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
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0013614cf6af46af873e2fb94bf2c0d7','YzY3NTk1NGYxMTMyMjIxZWU2NGJiN2FlODEwYmYwZWMyMTUzZjEwYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQ11Lg==\n','2012-11-29 07:30:10'),('06537cff40ab2ddb78d14e0817b5093f','MjVjZjg1YmI0ZjZlMDdiYjZjZjEwZWM3OTQ3Y2UxNjM2NTk4MTUxODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQV1Lg==\n','2012-11-08 02:45:26'),('4c8fb42bb45f63d5ca585c87dd396080','YzY3NTk1NGYxMTMyMjIxZWU2NGJiN2FlODEwYmYwZWMyMTUzZjEwYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQ11Lg==\n','2012-11-09 03:44:07'),('5f7ba0914609975f23d0b728ebc47a22','NWM4YmRlZWEyMzY4ZWIyMzA3ZjAxNjAwZTk5NzRiYTA0ZTI5ZTBkYTqAAn1xAS4=\n','2012-11-26 05:08:41'),('65c494058c2829885fd26781a4625e09','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-11-13 03:42:08'),('6e53bcf18cec608a54d4156146d9eb29','MTc1NDBjNWM5NmZmNjM1YjJhOTc3N2I5YzVhODM0YzkwNDQ5YjllMzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQZ1Lg==\n','2012-11-09 03:50:14'),('a350f7c620c19c37d780362a06d025f1','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-10-26 02:25:22'),('a8a01ca9dba6a58d981379b9ec111ef7','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-11-27 04:14:19'),('d74e953284f3878be4895c349027ae7e','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-11-08 03:58:11'),('fb12c22e49ebb0f0877d2e3825962645','YzY3NTk1NGYxMTMyMjIxZWU2NGJiN2FlODEwYmYwZWMyMTUzZjEwYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQ11Lg==\n','2012-11-06 08:32:28');
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
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
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
  CONSTRAINT `user_id_refs_id_cecd7f3c` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
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

-- Dump completed on 2012-11-16 11:25:33
