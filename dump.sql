-- MySQL dump 10.13  Distrib 5.5.24, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: anychart_tree_db
-- ------------------------------------------------------
-- Server version	5.5.24-0ubuntu0.12.04.1

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_file`
--

LOCK TABLES `app_file` WRITE;
/*!40000 ALTER TABLE `app_file` DISABLE KEYS */;
INSERT INTO `app_file` VALUES (2,'Circular axis angles sample','files/circular-axis-angles-sample-2.zip','2012-10-18 08:58:24'),(15,'Footer.jpg','files/preview.jpg','2012-10-24 07:52:59'),(17,'Sample-parts-gauge.pdf','files/111.pdf','2012-10-24 08:02:55'),(31,'Главная страница.jpg','files/282077-1920x1080_5.jpg','2012-10-24 08:34:27'),(34,'Главная страница.jpg','files/282077-1920x1080_7.jpg','2012-10-24 08:49:05');
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (1,'Компонент',1,NULL,'NE',NULL,NULL,NULL,NULL,NULL,NULL,'','2012-10-11 05:10:34','2012-10-11 05:10:34','',1,70,3,0),(2,'Сопроводительные материалы',1,NULL,'NE',NULL,NULL,NULL,NULL,NULL,NULL,'','2012-10-11 05:10:46','2012-10-11 05:10:46','',1,6,1,0),(3,'Пользовательская документация',1,2,'NE',NULL,NULL,NULL,NULL,NULL,NULL,'','2012-10-11 05:11:08','2012-10-11 05:11:08','',2,3,1,1),(4,'Демонстрационные примеры',1,2,'NE',NULL,NULL,NULL,NULL,NULL,NULL,'','2012-10-11 05:11:23','2012-10-11 05:11:23','',4,5,1,1),(5,'Gauges',1,1,'BR',13,NULL,13,4,23,2,'<a href=\"ya.ru\" _fcksavedurl=\"ya.ru\">ссылка на источник</a><p></p>','2012-10-24 02:10:58','2012-10-24 02:10:58','In our everyday life \"Gauge\" is an instrument with a graduated scale or dial for measuring or indicating quantity. In AnyChart Gauges serve the same purpose and can be of two types: Circular Gauge and Linear Gauge.\n\n<p>Here is a list of main AnyChart Gauges Features we want to highlight - we did our best to create a flexible and powerful gauge creation engine:</p>\n\n<ul>\n	<li class=\"main\"><a href=\"gauge-circular-simple.html\" _fcksavedurl=\"gauge-circular-simple.html\">Circular Gauges with variable scale angles.</a></li>\n<li class=\"main\"><a href=\"gauge-linear-simple-v.html\" _fcksavedurl=\"gauge-linear-simple-v.html\">Vertical Linear Gauges.</a></li>\n    <li class=\"main\"><a href=\"gauge-linear-simple.html\" _fcksavedurl=\"gauge-linear-simple.html\">Horizontal Linear Gauges.</a></li>\n<li class=\"main\">Multiple Scales for any type of gauges. </li>\n<li class=\"main\">Multiple Pointers and Pointer types (<a href=\"gauges-styles-needle-pointer.html\" _fcksavedurl=\"gauges-styles-needle-pointer.html\">Needle</a>, <a href=\"gauges-styles-marker-pointer.html\" _fcksavedurl=\"gauges-styles-marker-pointer.html\">Marker</a>, <a href=\"gauges-styles-bar-pointer.html\" _fcksavedurl=\"gauges-styles-bar-pointer.html\">Bar</a>, etc).</li>\n<li class=\"main\"><a href=\"gauges-complex.html\" _fcksavedurl=\"gauges-complex.html\">Complex Composite Gauges.</a></li>\n<li class=\"main\"><a href=\"gauges-dynamic.html\" _fcksavedurl=\"gauges-dynamic.html\">Real-time update.</a></li>\n<li class=\"main\"><a href=\"gauges-dynamic.html\" _fcksavedurl=\"gauges-dynamic.html\">Interactive update.</a></li>\n<li class=\"main\"><a href=\"gauges-thermometer.html\" _fcksavedurl=\"gauges-thermometer.html\">Thermometer styled Gauge.</a></li>\n<li class=\"main\"><a href=\"gauges-tank.html\" _fcksavedurl=\"gauges-tank.html\">Tank styled Gauge.</a> </li>\n<li class=\"main\"><a href=\"gauges-bullet-graph.html\" _fcksavedurl=\"gauges-bullet-graph.html\">Bullet Graphs.</a></li>\n<li class=\"main\">... and many more features. </li>\n</ul>\n<ol>\n	<li class=\"main\">Create a sub folder named AnyChart in the root folder your application (it\'s not obligatory to give this certain name	or create it under root folder).</li>\n	<li class=\"main\">Copy all the files from Downloadable Package :\n	  <ul>\n	    <li>From <strong>swf </strong>and <strong>js</strong> folder to use AnyChart Flash Charts</li>\n        <li>From <strong>js </strong>folder to use AnyChart HTML5 Charts</li>\n      </ul>\n	and paste them into folder you\'ve created.    </li>\n  </ol>\n\n<table class=\"dtTABLE\" width=\"700\">\n	<tbody><tr>\n		<th width=\"149\">Type</th>\n		<th width=\"176\">Values required</th>		\n		<th width=\"359\">Description</th>				\n	</tr>\n	<tr>\n	  <td>between</td>\n	  <td>value_1, value_2, value_3 </td>\n	  <td>True when value_1 is greater than or equal to value_2 and less than or equal to value_3. </td>\n    </tr>\n	<tr>\n	  <td>notBetween</td>\n	  <td>value_1, value_2, value_3</td>\n	  <td>True when value_1 is less than value_2 or greater than value_3.</td>\n    </tr>\n	<tr>\n	  <td>equalTo</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is equal to value_2. </td>\n    </tr>\n	<tr>\n	  <td>notEqualTo</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is not equal to value_2.</td>\n    </tr>\n	<tr>\n	  <td>greaterThan</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is greater than value_2.</td>\n    </tr>\n	<tr>\n	  <td>greaterThanOrEqualTo</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is greater than or equal to value_2.</td>\n    </tr>\n	<tr>\n	  <td>lessThan</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is less than value_2.</td>\n    </tr>\n	<tr>\n	  <td>lessThanOrEqualTo</td>\n	  <td>value_1, value_2</td>\n	  <td>True when value_1 is less than or equal to value_2.</td>\n    </tr>\n</tbody></table><p></p>',34,69,3,1),(6,'Polar Chart ',1,1,'BR',NULL,NULL,NULL,3,NULL,NULL,'','2012-10-24 05:01:02','2012-10-24 05:01:02','Polar chart plot allows to draw scatter chart using polar coordinate system, which is is a two-dimensional coordinate system in which each point on a plane is determined by a distance from a fixed point and an angle from a fixed direction.',2,33,3,1),(14,'Circular Gauge',1,5,'BR',7,4,10,3,1,3,'','2012-10-19 08:11:54','2012-10-19 08:11:54','First of all we need to choose a gauge type, in this sample it should be circular gauge, so we put the following XML settings.',65,68,3,2),(15,'Scale Settings and Title',1,14,'OR',10,8,5,4,1,3,'','2012-10-19 08:11:59','2012-10-19 08:11:59','<p class=\"main\">Note: <strong>&lt;axis radius=\"50\"&gt;</strong> means that we want gauge axis to cover 50% percents of a gauge size - to understand this better you need to study <a href=\"gauge-circular-position.html\">Positioning</a>, <a href=\"gauge-linear-resizing.html\">Resizing</a> and <a href=\"gauge-circular-axis.html\">Axis Overview</a> Tutorials. <b>start_angle sets</b> the angle from which your scale should be drawn. The point from which the calculation starts is in the lowest points of your circular gauge and the direction is CW. <b>sweep_angle</b> is an actual angle of your circular gauge. In our example we will create a so-called \"semi-radial\" 180 degrees speedometer.</p>',66,67,3,3),(16,'Color Ranges',1,5,'OR',8,6,5,2,1,2,'<a href=\'ya.ru\'>ссылка на источник</a>','2012-10-19 08:11:48','2012-10-19 08:11:48','An essential part of linear gauges are color ranges that are used to distinct the quality of value shown, in our example we will create three color ranges \"Slow\", \"Average\" and \"Fast\" speed levels. The syntax should be as follow',63,64,3,2),(17,'X axis settings',1,6,'OR',8,NULL,NULL,6,1,2,'','2012-10-19 08:09:14','2012-10-19 08:09:14','<p>This section tells how to configure Х axis and its elements, such as tick marks, grid and labels.\r\n<p>X axis enable/disable\r\n<p>To turn X axis on or off use enabled attribute of <x_axis> node - setting it to false hides all visible components of X axis',9,10,3,2),(18,'Y axis settings  ',1,6,'OR',2,NULL,NULL,4,1,2,'<p></p>','2012-10-24 03:52:22','2012-10-24 03:52:22','This section tells how to configure Y axis mode, scale and its elements, such as tick marks, grid and labels.',7,8,3,2),(19,'Linear and Logarithmic scale',1,6,'OR',7,NULL,NULL,5,1,3,'&nbsp;','2012-10-24 03:39:29','2012-10-24 03:39:29','<table class=\"dtTABLE\">\n<tbody><tr>\n	<th width=\"120\">Attribute</th>\n	<th width=\"300\">Description</th>	\n</tr>\n<tr>\n	<td>color</td>\n	<td>Sets line color.</td>	\n</tr>\n<tr>\n  <td>opacity</td>\n  <td>Sets line opacity.</td>\n</tr>\n<tr>\n	<td>thickness</td>\n	<td>Sets line thickness.</td>	\n</tr>\n</tbody></table>\n<h3 class=\"main\"><a name=\"y-axis-grids\"></a>Grids</h3>\n<p class=\"main\">Each axis has its own grid. By default grid is enabled for all axes and looks like a set of black lines. You can turn it off or configure to fit your needs. \nHere is a sample XML with grid settings:</p>',15,16,3,2),(21,'Horizontal gauges',1,5,'BR',1,NULL,NULL,1,NULL,NULL,NULL,'2012-10-22 02:24:05','2012-10-22 02:24:05',NULL,61,62,3,2),(22,'Special Gauge and Pointer Types',1,5,'BR',1,4,5,1,4,2,'None','2012-10-23 09:12:55','2012-10-23 09:12:55','None',53,54,3,2),(27,'Vertical guages',1,5,'BR',1,NULL,NULL,6,NULL,NULL,NULL,'2012-10-22 02:31:10','2012-10-22 02:31:10',NULL,37,38,3,2),(38,'AxisLabel',1,6,'BR',13,3,2,1,24,1,'None','2012-10-23 08:44:18','2012-10-23 08:44:18','None',19,32,3,2),(39,'Req1',1,38,'OR',13,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 08:45:27','2012-10-23 08:45:27',NULL,30,31,3,3),(40,'Usel',1,38,'BR',13,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 08:46:02','2012-10-23 08:46:02',NULL,28,29,3,3),(41,'Usel 2',1,38,'BR',2,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 08:57:01','2012-10-23 08:57:01',NULL,20,27,3,3),(42,'Требование первое',1,41,'OR',2,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 08:59:59','2012-10-23 08:59:59',NULL,23,24,3,4),(43,'Требование второе',1,41,'OR',2,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 09:04:32','2012-10-23 09:04:32',NULL,25,26,3,4),(44,'Требование третье',1,41,'OR',2,NULL,NULL,1,NULL,NULL,NULL,'2012-10-23 09:05:38','2012-10-23 09:05:38',NULL,21,22,3,4),(45,'Новое прелестное требование',1,6,'OR',1,NULL,NULL,2,NULL,NULL,'None','2012-10-24 03:56:33','2012-10-24 03:56:33','None',5,6,3,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_node_files`
--

LOCK TABLES `app_node_files` WRITE;
/*!40000 ALTER TABLE `app_node_files` DISABLE KEYS */;
INSERT INTO `app_node_files` VALUES (16,5,2),(48,5,31),(19,6,2),(51,14,34),(8,17,2),(13,18,2),(32,38,15),(34,38,17);
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
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_product`
--

LOCK TABLES `app_product` WRITE;
/*!40000 ALTER TABLE `app_product` DISABLE KEYS */;
INSERT INTO `app_product` VALUES (1,'AnyChart','AnyChart is a flexible Flash/JavaScript (HTML5) based charting solution.  \r\nAnyChart enables any organization to add cross-browser and cross-platform interactive charts, dashboards, graphs and maps to their applications.\r\nUsing AnyChart, our customers are able to maximize the value of their applications by easily adding data visualization tools that:\r\n\r\nEnable better analysis and decision making by allowing comprehensive and free-flowing data exploration.  This provides the ability to spot patterns and trends.\r\nIncrease customer satisfaction by enhancing the look of any application, report, or presentation.\r\nLower developments cost and speed time-to market.\r\nWe currently provide charting solutions to thousands of companies in over 100 countries across all industries.'),(2,'AnyGantt','AnyGantt is an advanced Flash based data-visualization solution, allowing everyone to utilize power of animation and ultimate interactivity. AnyGantt is an ideal tool for building complex and informative Gantt charts.'),(3,'AnyStock','AnyChart Stock and Financial Charts (short name: AnyStock) is an XML/JSON Flash based financial charting solution. AnyStock technology turns your real time data into highly sophisticated charts with interactive capability, bringing visualization of your data to the Web. Designed to display data and time based information, AnyStock is the ideal tool for client reporting and performance based reporting applications. Reports and Dashboards are visualized with scrolling, drill downs, panning and zoom functionality.');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,'Первый','1.0',0,'','2012-10-31 03:00:00',1),(4,'Третий','3',0,'','2014-08-31 15:00:00',1),(23,'Новогодний','2.90',0,'Оставьте суету. ','2013-04-05 15:00:00',1),(24,'Самый хороший ','34',0,'Комметрарий %555','2013-04-05 15:00:00',1),(25,'Привет ','130',0,'Город не спит! ','2013-04-05 15:00:00',1),(26,'Стопятьсот','12',0,'Невзрачный комментарий.','2013-04-05 15:00:00',1);
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
INSERT INTO `app_releasehistory` VALUES (1,45,23,'Оставьте комментарий тут','2012-10-24 03:52:47'),(2,45,4,'Оставьте комментарий тут','2012-10-24 03:53:14'),(3,45,1,'Оставьте комментарий тут','2012-10-24 03:56:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_statushistory`
--

LOCK TABLES `app_statushistory` WRITE;
/*!40000 ALTER TABLE `app_statushistory` DISABLE KEYS */;
INSERT INTO `app_statushistory` VALUES (1,17,6,'Тестирование удаления','2012-10-19 03:51:01'),(2,18,6,'','2012-10-19 08:09:13'),(3,17,6,'','2012-10-19 08:09:14'),(4,19,6,'','2012-10-19 08:09:14'),(5,6,6,'','2012-10-19 08:09:14'),(6,16,6,'','2012-10-19 08:09:14'),(7,15,6,'','2012-10-19 08:09:14'),(8,14,6,'','2012-10-19 08:09:14'),(9,5,6,'','2012-10-19 08:09:14'),(11,21,1,'Just created','2012-10-22 02:24:05'),(12,22,1,'Just created','2012-10-22 02:25:30'),(18,27,1,'Just created','2012-10-22 02:30:48'),(21,27,6,'','2012-10-22 02:31:10'),(40,5,2,'','2012-10-23 08:03:56'),(41,38,1,'Just created','2012-10-23 08:37:57'),(42,39,1,'Just created','2012-10-23 08:45:27'),(43,40,1,'Just created','2012-10-23 08:46:02'),(44,41,1,'Just created','2012-10-23 08:57:01'),(45,42,1,'Just created','2012-10-23 08:59:59'),(46,43,1,'Just created','2012-10-23 09:04:32'),(47,44,1,'Just created','2012-10-23 09:05:38'),(48,5,4,'Cltkfyj! ','2012-10-24 02:10:58'),(49,45,1,'Just created','2012-10-24 03:39:55'),(50,45,2,'Необходимо согласовать с вышестоящими инстанциями','2012-10-24 03:40:46');
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
INSERT INTO `auth_user` VALUES (1,'olga','Administrotar','','olga@irnok.net','pbkdf2_sha256$10000$56vEfZGptbFi$OMLpUzmpiK1EM5U29iRgo1lu2JfTtr7XozO4E41X9Sc=',1,1,1,'2012-10-24 04:59:42','2012-10-10 08:11:41'),(2,'olga.vorobyeva','Olga','Vorobyeva','olga.vorobyeva@anychart.com','pbkdf2_sha256$10000$OH95eutxXqT0$xEkhK+nF9Wmc8ppxdMGStCeT3zvX15Qfab1Q4Oxc3Og=',0,1,0,'2012-10-24 03:51:48','2012-10-10 09:31:50'),(3,'alex.batsuev','Alexander','Batsuev','alex.batsuev@anychart.com','pbkdf2_sha256$10000$MrPmYRbzmdtD$LaxDmaZqkO/6y4GqXvDEVMnV+hqpBpCAYbFVUIcMbXI=',0,1,0,'2012-10-11 01:39:28','2012-10-11 01:39:28'),(4,'alexander.kudryavtsev','Alexander','Kudryavtsev','alexander.kudryavtsev@anychart.com','pbkdf2_sha256$10000$nWP8IzMCRbP1$5uZfgBbDqFqRbNE17tMPT2kSzkVI0x9aCgfCfGcTpsw=',0,1,0,'2012-10-11 01:55:48','2012-10-11 01:55:48'),(5,'alexandra.batireva','Alexandra','Batireva','alexandra.batireva@anychart.com','pbkdf2_sha256$10000$geICMoJPYsBm$E2TJ4AqXyM8jm279Umo/ehbRT2KPd2kbAcu8vjGieR0=',0,1,0,'2012-10-22 08:03:08','2012-10-11 01:58:01'),(6,'andrey.shakhmin','Andrey','Shakhmin','andrey.shakhmin@anychart.com','pbkdf2_sha256$10000$RtpgMzutZFHd$dBrqqrfvVcQJ8Br6QV6JyMUKMn5xaKc9HHw21hJnxUQ=',0,1,0,'2012-10-11 01:58:50','2012-10-11 01:58:50'),(7,'anton.baranchuk','Anton','Baranchuk','anton.baranchuk@anychart.com','pbkdf2_sha256$10000$EViHtV8bPXNL$EyJS7NYwO2ccL9pv1a2XunNIyRp3cMSJdOwdtDSZYY0=',0,1,0,'2012-10-11 01:59:36','2012-10-11 01:59:36'),(8,'anton.kagakin','Anton','Kagakin','anton.kagakin@anychart.com','pbkdf2_sha256$10000$r8tdl4i6vlt8$9WSBE+HY9u4yrdLGzQ7LBg744WNiK35SYMKEOW69yBg=',0,1,0,'2012-10-11 02:01:36','2012-10-11 02:01:36'),(9,'anton.saukh','Anton','Saukh','anton.saukh@anychart.com','pbkdf2_sha256$10000$OUFHgaeaMmSv$vOiBpDkhqSrPN6OK0F3Ydowq+oG3vw79UTnsGCLV3ts=',0,1,0,'2012-10-11 02:04:03','2012-10-11 02:04:03'),(10,'roman.lubushkin','Roman','Lubushkin','roman.lubushkin@anychart.com','pbkdf2_sha256$10000$iiZC6tFyvxQf$vo/qP2MArrlBXs7FwGB+9fvJcZRPDzvsS1HlgK/REeg=',0,1,0,'2012-10-11 02:05:05','2012-10-11 02:05:05'),(11,'sergey.medvedev','Sergey','Medvedev','sergey.medvedev@anychart.com','pbkdf2_sha256$10000$ndKr0Ry2rmzd$2muTNrXNenHWdtTaAtYvRyxPQudILtWXgjhCA+iT4rk=',0,1,0,'2012-10-11 02:05:39','2012-10-11 02:05:39'),(12,'timothy.loginov','Timothy','Loginov','timothy.loginov@anychart.com','pbkdf2_sha256$10000$ohBB0JX3HxDj$hlr9WF+T4HNCnk2pGoBtCN2B+TRkd9Y0oUE6gEuuMVM=',0,1,0,'2012-10-11 02:07:02','2012-10-11 02:07:02'),(13,'vitaly.radionov','Vitaly','Radionov','vitaly.radionov@anychart.com','pbkdf2_sha256$10000$CLxm3ml4rUa8$MzwQD4J7koysPYNA+T4+KPVqeDPH81C9SAty4hH0PO4=',0,1,0,'2012-10-23 08:32:28','2012-10-11 02:07:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-10-10 08:18:35',1,11,'1','Создано',1,''),(2,'2012-10-10 08:19:12',1,10,'1','Первый',1,''),(3,'2012-10-10 08:19:28',1,12,'1','аналитика',1,''),(4,'2012-10-10 08:22:36',1,14,'1','Письмо участника',1,''),(5,'2012-10-10 08:23:13',1,14,'1','Требования к компоненту',2,'Изменен title и type.'),(6,'2012-10-10 08:23:30',1,14,'2','Требования к сопроводительным материалам',1,''),(7,'2012-10-10 08:24:04',1,14,'3','пользовательская документация',1,''),(8,'2012-10-10 08:24:11',1,14,'3','Пользовательская документация',2,'Изменен title.'),(9,'2012-10-10 08:24:26',1,14,'2','Сопроводительные материалы',2,'Изменен title.'),(10,'2012-10-10 08:24:35',1,14,'1','Компонент',2,'Изменен title.'),(11,'2012-10-10 08:25:02',1,14,'4','Демонстрационные примеры',1,''),(12,'2012-10-10 08:32:09',1,14,'5','Gauges',1,''),(13,'2012-10-10 08:36:36',1,14,'6','Polar Chart ',1,''),(14,'2012-10-10 08:37:19',1,14,'7','X-Axis settings',1,''),(15,'2012-10-10 08:37:49',1,14,'8','Y-Axis settings',1,''),(16,'2012-10-10 08:39:03',1,14,'9','Сircular gauge',1,''),(17,'2012-10-10 08:39:43',1,14,'10','Vertical Gauges ',1,''),(18,'2012-10-10 08:41:40',1,14,'11','Scale Settings and Title',1,''),(19,'2012-10-10 09:12:05',1,14,'12','Labels and Tickmarks',1,''),(20,'2012-10-10 09:12:28',1,14,'13','Color Ranges',1,''),(21,'2012-10-10 09:13:11',1,14,'14','Extra Labels',1,''),(22,'2012-10-10 09:14:32',1,14,'15','Axis Position and Axis Size',1,''),(23,'2012-10-10 09:16:49',1,14,'8','Y-Axis settings',2,'Изменен type.'),(24,'2012-10-10 09:16:54',1,14,'7','X-Axis settings',2,'Изменен type.'),(25,'2012-10-10 09:18:07',1,14,'16','Guages',1,''),(26,'2012-10-10 09:20:06',1,13,'1','Circular Gauge Sample',1,''),(27,'2012-10-10 09:20:16',1,14,'17','Circular Gauge Sample',1,''),(28,'2012-10-10 09:21:09',1,14,'2','Сопроводительные материалы',2,'Изменен cur_status.'),(29,'2012-10-10 09:21:21',1,14,'3','Пользовательская документация',2,'Изменен cur_status.'),(30,'2012-10-10 09:21:27',1,14,'4','Демонстрационные примеры',2,'Изменен cur_status.'),(31,'2012-10-10 09:21:42',1,14,'4','Демонстрационные примеры',2,'Изменен cur_release и source.'),(32,'2012-10-10 09:21:57',1,14,'16','Guages',2,'Изменен cur_status,cur_release и source.'),(33,'2012-10-10 09:22:05',1,14,'17','Circular Gauge Sample',2,'Изменен cur_status,cur_release и source.'),(34,'2012-10-10 09:22:12',1,14,'1','Компонент',2,'Изменен cur_status,cur_release и source.'),(35,'2012-10-10 09:22:20',1,14,'6','Polar Chart ',2,'Изменен cur_status,cur_release и source.'),(36,'2012-10-10 09:22:24',1,14,'6','Polar Chart ',2,'Ни одно поле не изменено.'),(37,'2012-10-10 09:22:34',1,14,'8','Y-Axis settings',2,'Изменен cur_status,cur_release и source.'),(38,'2012-10-10 09:22:36',1,14,'8','Y-Axis settings',2,'Ни одно поле не изменено.'),(39,'2012-10-10 09:22:43',1,14,'7','X-Axis settings',2,'Изменен cur_status,cur_release и source.'),(40,'2012-10-10 09:22:51',1,14,'5','Gauges',2,'Изменен cur_status и cur_release.'),(41,'2012-10-10 09:22:57',1,14,'5','Gauges',2,'Ни одно поле не изменено.'),(42,'2012-10-10 09:23:03',1,14,'9','Сircular gauge',2,'Изменен cur_status,cur_release и source.'),(43,'2012-10-10 09:23:09',1,14,'14','Extra Labels',2,'Изменен cur_status,cur_release и source.'),(44,'2012-10-10 09:23:15',1,14,'15','Axis Position and Axis Size',2,'Изменен cur_status,cur_release и source.'),(45,'2012-10-10 09:23:19',1,14,'15','Axis Position and Axis Size',2,'Ни одно поле не изменено.'),(46,'2012-10-10 09:23:25',1,14,'10','Vertical Gauges ',2,'Изменен cur_status,cur_release и source.'),(47,'2012-10-10 09:23:28',1,14,'10','Vertical Gauges ',2,'Ни одно поле не изменено.'),(48,'2012-10-10 09:23:36',1,14,'11','Scale Settings and Title',2,'Изменен cur_status,cur_release и source.'),(49,'2012-10-10 09:23:41',1,14,'15','Axis Position and Axis Size',2,'Ни одно поле не изменено.'),(50,'2012-10-10 09:23:45',1,14,'11','Scale Settings and Title',2,'Ни одно поле не изменено.'),(51,'2012-10-10 09:23:51',1,14,'12','Labels and Tickmarks',2,'Изменен cur_status,cur_release и source.'),(52,'2012-10-10 09:23:54',1,14,'12','Labels and Tickmarks',2,'Ни одно поле не изменено.'),(53,'2012-10-10 09:24:01',1,14,'13','Color Ranges',2,'Изменен cur_status,cur_release и source.'),(54,'2012-10-10 09:24:32',1,14,'3','Пользовательская документация',2,'Изменен cur_release и source.'),(55,'2012-10-10 09:24:38',1,14,'2','Сопроводительные материалы',2,'Изменен cur_release и source.'),(56,'2012-10-10 09:25:25',1,11,'2','На согласовании',1,''),(57,'2012-10-10 09:26:01',1,11,'3','в процессе реализации',1,''),(58,'2012-10-10 09:26:08',1,11,'2','на согласовании',2,'Изменен title.'),(59,'2012-10-10 09:26:14',1,11,'1','создано',2,'Изменен title.'),(60,'2012-10-10 09:26:43',1,11,'4','в процессе проверки',1,''),(61,'2012-10-10 09:27:03',1,11,'5','реализовано',1,''),(62,'2012-10-10 09:27:21',1,11,'6','удалено',1,''),(63,'2012-10-10 09:27:39',1,11,'1','создано',2,'Изменен color.'),(64,'2012-10-10 09:27:56',1,11,'2','на согласовании',2,'Изменен color.'),(65,'2012-10-10 09:28:14',1,11,'3','в процессе реализации',2,'Изменен color.'),(66,'2012-10-10 09:28:32',1,11,'4','в процессе проверки',2,'Изменен color.'),(67,'2012-10-10 09:29:07',1,12,'2','клиентский запрос',1,''),(68,'2012-10-10 09:29:17',1,12,'3','отчет об ошибке',1,''),(69,'2012-10-10 09:30:17',1,3,'1','olga.vorobyeva',1,''),(70,'2012-10-10 09:30:42',1,3,'1','developers',2,'Изменен name.'),(71,'2012-10-10 09:30:50',1,3,'2','testers',1,''),(72,'2012-10-10 09:31:17',1,3,'3','curators',1,''),(73,'2012-10-10 09:31:25',1,3,'1','developers',2,'Изменен permissions.'),(74,'2012-10-10 09:31:50',1,4,'2','olga.vorobyeva',1,''),(75,'2012-10-10 09:32:40',1,4,'2','olga.vorobyeva',2,'Изменен password,first_name,last_name,email и groups.'),(76,'2012-10-11 01:39:28',1,4,'3','alexander.batsuev',1,''),(77,'2012-10-11 01:40:29',1,4,'3','alex.batsuev',2,'Изменен username,password,first_name,last_name,email и groups.'),(78,'2012-10-11 01:55:48',1,4,'4','alexander.kudryavtsev',1,''),(79,'2012-10-11 01:56:16',1,4,'4','alexander.kudryavtsev',2,'Изменен password,first_name,last_name,email и groups.'),(80,'2012-10-11 01:58:01',1,4,'5','alexandra.batireva',1,''),(81,'2012-10-11 01:58:21',1,4,'5','alexandra.batireva',2,'Изменен password,first_name,last_name,email и groups.'),(82,'2012-10-11 01:58:50',1,4,'6','andrey.shakhmin',1,''),(83,'2012-10-11 01:59:13',1,4,'6','andrey.shakhmin',2,'Изменен password,first_name,last_name,email и groups.'),(84,'2012-10-11 01:59:36',1,4,'7','anton.baranchuk',1,''),(85,'2012-10-11 01:59:51',1,4,'7','anton.baranchuk',2,'Изменен password,first_name,last_name,email и groups.'),(86,'2012-10-11 02:01:36',1,4,'8','anton.kagakin',1,''),(87,'2012-10-11 02:01:56',1,4,'8','anton.kagakin',2,'Изменен password,first_name,last_name,email и groups.'),(88,'2012-10-11 02:04:03',1,4,'9','anton.saukh',1,''),(89,'2012-10-11 02:04:23',1,4,'9','anton.saukh',2,'Изменен password,first_name,last_name,email и groups.'),(90,'2012-10-11 02:05:05',1,4,'10','roman.lubushkin',1,''),(91,'2012-10-11 02:05:25',1,4,'10','roman.lubushkin',2,'Изменен password,first_name,last_name,email и groups.'),(92,'2012-10-11 02:05:39',1,4,'11','sergey.medvedev',1,''),(93,'2012-10-11 02:05:53',1,4,'11','sergey.medvedev',2,'Изменен password,first_name,last_name,email и groups.'),(94,'2012-10-11 02:07:02',1,4,'12','timothy.loginov',1,''),(95,'2012-10-11 02:07:22',1,4,'12','timothy.loginov',2,'Изменен password,first_name,last_name,email и groups.'),(96,'2012-10-11 02:07:40',1,4,'13','vitaly.radionov',1,''),(97,'2012-10-11 02:07:58',1,4,'13','vitaly.radionov',2,'Изменен password,first_name,last_name,email и groups.'),(98,'2012-10-11 02:10:27',1,9,'1','AnyChart',1,''),(99,'2012-10-11 02:25:54',1,15,'1','Polar Chart : на согласовании',1,''),(100,'2012-10-11 02:34:42',1,9,'1','AnyChart',1,''),(101,'2012-10-11 02:35:00',1,10,'1','Первый',1,''),(102,'2012-10-11 02:37:12',1,11,'1','cоздано',1,''),(103,'2012-10-11 02:37:31',1,11,'2','на согласовании',1,''),(104,'2012-10-11 02:37:51',1,11,'3','в процессе реализации',1,''),(105,'2012-10-11 02:38:17',1,11,'4','в процессе проверки',1,''),(106,'2012-10-11 02:38:41',1,11,'5','реализовано',1,''),(107,'2012-10-11 02:39:03',1,11,'6','удалено',1,''),(108,'2012-10-11 02:40:11',1,13,'1','Sample-parts-gauge',1,''),(109,'2012-10-11 02:40:30',1,12,'1','аналитика',1,''),(110,'2012-10-11 02:40:39',1,12,'2','клиентский запрос',1,''),(111,'2012-10-11 02:40:50',1,12,'3','отчет об ошибке',1,''),(112,'2012-10-11 02:41:48',1,14,'1','Требования к компоненту',1,''),(113,'2012-10-11 02:42:02',1,14,'1','Компонент',2,'Изменен title.'),(114,'2012-10-11 02:43:00',1,14,'2','Сопроводительные материалы',1,''),(115,'2012-10-11 02:43:17',1,14,'3','AnyChart',1,''),(116,'2012-10-11 02:43:22',1,14,'2','Сопроводительные материалы',2,'Изменен parent.'),(117,'2012-10-11 02:43:27',1,14,'1','Компонент',2,'Изменен parent.'),(118,'2012-10-11 02:43:46',1,14,'4','Пользовательская документация',1,''),(119,'2012-10-11 02:44:00',1,14,'5','Демонстрационные примеры',1,''),(120,'2012-10-11 02:45:24',1,14,'6','AnyStock',1,''),(121,'2012-10-11 02:45:36',1,14,'7','AnyGantt',1,''),(122,'2012-10-11 02:45:53',1,14,'8','Сопроводительные материалы',1,''),(123,'2012-10-11 02:46:02',1,14,'9','Компонент',1,''),(124,'2012-10-11 02:46:12',1,14,'10','Пользовательская документация',1,''),(125,'2012-10-11 02:46:22',1,14,'11','Демонстрационные примеры',1,''),(126,'2012-10-11 02:46:36',1,14,'12','Сопроводительные материалы',1,''),(127,'2012-10-11 02:46:44',1,14,'13','Компонент',1,''),(128,'2012-10-11 02:46:54',1,14,'14','Пользовательская документация',1,''),(129,'2012-10-11 02:47:04',1,14,'15','Демонстрационные примеры',1,''),(130,'2012-10-11 05:07:00',1,9,'1','AnyChart',1,''),(131,'2012-10-11 05:07:12',1,9,'2','AnyGantt',1,''),(132,'2012-10-11 05:07:32',1,9,'3','AnyStock',1,''),(133,'2012-10-11 05:07:48',1,12,'1','аналитика',1,''),(134,'2012-10-11 05:07:53',1,12,'2','клиентский запрос',1,''),(135,'2012-10-11 05:08:00',1,12,'3','отчет об ошибке',1,''),(136,'2012-10-11 05:08:35',1,10,'1','Первый',1,''),(137,'2012-10-11 05:08:57',1,11,'1','создано',1,''),(138,'2012-10-11 05:09:09',1,11,'2','на согласовании',1,''),(139,'2012-10-11 05:09:19',1,11,'3','в процессе реализации',1,''),(140,'2012-10-11 05:09:28',1,11,'4','в процессе проверки',1,''),(141,'2012-10-11 05:09:39',1,11,'5','реализовано',1,''),(142,'2012-10-11 05:09:54',1,11,'6','удалено',1,''),(143,'2012-10-11 05:10:12',1,13,'1','Sample-parts-gauge',1,''),(144,'2012-10-11 05:10:34',1,14,'1','Компонент',1,''),(145,'2012-10-11 05:10:46',1,14,'2','Сопроводительные материалы',1,''),(146,'2012-10-11 05:10:56',1,14,'3','Пользовательская документация',1,''),(147,'2012-10-11 05:11:08',1,14,'3','Пользовательская документация',2,'Изменен parent.'),(148,'2012-10-11 05:11:23',1,14,'4','Демонстрационные примеры',1,''),(149,'2012-10-11 05:12:17',1,14,'5','Gauges',1,''),(150,'2012-10-11 05:12:54',1,14,'6','Polar Chart ',1,''),(151,'2012-10-11 05:13:39',1,14,'7','X axis settings',1,''),(152,'2012-10-11 05:14:41',1,14,'8','X axis enable/disable',1,''),(153,'2012-10-11 05:15:07',1,14,'9','Tickmarks',1,''),(154,'2012-10-11 05:15:40',1,14,'10','Y axis settings',1,''),(155,'2012-10-11 05:16:33',1,14,'11','Y axis enable/disable',1,''),(156,'2012-10-11 05:17:25',1,14,'12','Linear and Logarithmic scale',1,''),(157,'2012-10-12 02:25:37',1,14,'6','Polar Chart ',2,'Изменен cur_status.'),(158,'2012-10-12 02:25:42',1,14,'10','Y axis settings',2,'Изменен cur_status.'),(159,'2012-10-12 02:25:47',1,14,'11','Y axis enable/disable',2,'Изменен cur_status.'),(160,'2012-10-12 02:25:53',1,14,'12','Linear and Logarithmic scale',2,'Изменен cur_status.'),(161,'2012-10-12 02:25:58',1,14,'7','X axis settings',2,'Изменен cur_status.'),(162,'2012-10-12 02:26:03',1,14,'8','X axis enable/disable',2,'Изменен cur_status.'),(163,'2012-10-12 02:26:13',1,14,'9','Tickmarks',2,'Изменен cur_status.'),(164,'2012-10-12 02:26:19',1,14,'5','Gauges',2,'Изменен cur_status.'),(165,'2012-10-12 02:27:26',1,4,'1','olga',2,'Изменен password и first_name.'),(166,'2012-10-12 02:43:43',1,11,'1','создано',2,'Изменен color.'),(167,'2012-10-12 02:43:57',1,11,'2','на согласовании',2,'Изменен color.'),(168,'2012-10-12 02:44:30',1,11,'4','в процессе проверки',2,'Изменен color.'),(169,'2012-10-12 02:44:39',1,11,'3','в процессе реализации',2,'Изменен color.'),(170,'2012-10-12 02:44:59',1,11,'5','реализовано',2,'Изменен color.'),(171,'2012-10-12 02:48:04',1,11,'2','на согласовании',2,'Изменен color.'),(172,'2012-10-12 02:48:20',1,11,'1','создано',2,'Изменен color.'),(173,'2012-10-12 02:49:03',1,14,'12','Linear and Logarithmic scale',2,'Изменен cur_status.'),(174,'2012-10-12 02:56:15',1,11,'1','создано',2,'Изменен color.'),(175,'2012-10-12 07:23:47',1,11,'3','в процессе реализации',2,'Изменен color.'),(176,'2012-10-12 07:24:48',1,11,'4','в процессе проверки',2,'Изменен color.'),(177,'2012-10-12 07:24:52',1,11,'4','в процессе проверки',2,'Ни одно поле не изменено.'),(178,'2012-10-12 07:25:14',1,11,'3','в процессе реализации',2,'Изменен color.'),(179,'2012-10-12 07:30:42',1,11,'3','в процессе реализации',2,'Изменен color.'),(180,'2012-10-12 07:32:55',1,11,'3','в процессе реализации',2,'Изменен color.'),(181,'2012-10-12 07:34:08',1,11,'3','в процессе реализации',2,'Изменен color.'),(182,'2012-10-12 07:34:40',1,11,'3','в процессе реализации',2,'Ни одно поле не изменено.'),(183,'2012-10-12 07:35:04',1,11,'4','в процессе проверки',2,'Изменен color.'),(184,'2012-10-12 07:35:11',1,11,'3','в процессе реализации',2,'Изменен color.'),(185,'2012-10-18 02:45:37',1,14,'5','Gauges',2,'Изменен curator,developer,tester,cur_release,source,source_description и files.'),(186,'2012-10-18 04:08:55',1,14,'10','Y axis settings',2,'Изменен cur_status.'),(187,'2012-10-18 04:10:03',1,11,'2','на согласовании',2,'Изменен color.'),(188,'2012-10-18 04:10:56',1,11,'2','на согласовании',2,'Изменен color.'),(189,'2012-10-18 08:44:23',1,14,'5','Gauges',2,'Изменен content.'),(190,'2012-10-18 08:47:28',1,14,'5','Gauges',2,'Изменен content.'),(191,'2012-10-18 08:47:59',1,14,'5','Gauges',2,'Изменен content.'),(192,'2012-10-18 08:58:24',1,13,'2','Circular axis angles sample',1,''),(193,'2012-10-18 08:58:28',1,14,'5','Gauges',2,'Изменен files.'),(194,'2012-10-18 09:39:03',1,14,'13','Tickmarks',1,''),(195,'2012-10-18 09:58:24',1,14,'14','Circular Gauge',1,''),(196,'2012-10-18 09:59:07',1,14,'15','Scale Settings and Title',1,''),(197,'2012-10-18 10:00:02',1,14,'16','Color Ranges',1,''),(198,'2012-10-18 10:01:21',1,14,'17','X axis settings',1,''),(199,'2012-10-18 10:02:02',1,14,'18','Y axis settings  ',1,''),(200,'2012-10-18 10:03:02',1,14,'19','Linear and Logarithmic scale',1,''),(201,'2012-10-19 03:51:01',1,15,'1','X axis settings: удалено',2,'Ни одно поле не изменено.'),(202,'2012-10-19 08:11:25',1,14,'6','Polar Chart ',2,'Изменен cur_status.'),(203,'2012-10-19 08:11:31',1,14,'18','Y axis settings  ',2,'Изменен cur_status.'),(204,'2012-10-19 08:11:37',1,14,'19','Linear and Logarithmic scale',2,'Изменен cur_status.'),(205,'2012-10-19 08:11:43',1,14,'5','Gauges',2,'Изменен cur_status.'),(206,'2012-10-19 08:11:48',1,14,'16','Color Ranges',2,'Изменен cur_status.'),(207,'2012-10-19 08:11:54',1,14,'14','Circular Gauge',2,'Изменен cur_status.'),(208,'2012-10-19 08:11:59',1,14,'15','Scale Settings and Title',2,'Изменен cur_status.'),(209,'2012-10-22 02:25:53',1,14,'23','Special Gauge and Pointer Types',3,''),(210,'2012-10-22 02:25:53',1,14,'24','Special Gauge and Pointer Types',3,''),(211,'2012-10-22 02:25:53',1,14,'25','Special Gauge and Pointer Types',3,''),(212,'2012-10-22 02:27:38',1,14,'20','Vertical gauges',3,''),(213,'2012-10-23 05:00:54',1,10,'2','Второй',3,''),(214,'2012-10-23 07:10:42',1,10,'5','Третий',3,''),(215,'2012-10-23 07:10:42',1,10,'15','у',3,''),(216,'2012-10-23 07:10:42',1,10,'14','Восьмисотый',3,''),(217,'2012-10-23 07:10:42',1,10,'8','Second',3,''),(218,'2012-10-23 07:10:42',1,10,'7','Третий',3,''),(219,'2012-10-23 07:10:42',1,10,'6','Третий',3,''),(220,'2012-10-23 07:10:42',1,10,'3','Второй',3,''),(221,'2012-10-23 07:10:42',1,10,'9','Третий',3,''),(222,'2012-10-23 07:10:42',1,10,'12','Пятый',3,''),(223,'2012-10-23 07:10:42',1,10,'11','Пятый',3,''),(224,'2012-10-23 07:10:42',1,10,'10','Пятый',3,''),(225,'2012-10-23 07:10:42',1,10,'18','fgjh',3,''),(226,'2012-10-23 07:10:42',1,10,'17','sdf',3,''),(227,'2012-10-23 07:10:42',1,10,'16','Cegth',3,''),(228,'2012-10-23 07:10:42',1,10,'13','Dddd',3,''),(229,'2012-10-23 07:18:38',1,10,'22','re',3,''),(230,'2012-10-23 07:18:38',1,10,'21','34',3,''),(231,'2012-10-23 07:18:38',1,10,'20','555',3,''),(232,'2012-10-23 07:18:38',1,10,'19','новый',3,''),(233,'2012-10-23 09:06:41',1,14,'37','sf sdg dfg dg w',3,''),(234,'2012-10-23 09:06:41',1,14,'35','ntct 2',3,''),(235,'2012-10-23 09:06:52',1,14,'34','тестовое требование',3,''),(236,'2012-10-23 09:06:52',1,14,'36','dfgh',3,''),(237,'2012-10-23 09:07:38',1,14,'28','Vertical guages',3,''),(238,'2012-10-23 09:07:38',1,14,'26','Vertical gauges',3,''),(239,'2012-10-23 09:07:38',1,14,'29','Vertical gauges',3,''),(240,'2012-10-23 09:07:38',1,14,'30','Vertical gauges',3,''),(241,'2012-10-23 09:07:38',1,14,'31','Vertical gauges',3,''),(242,'2012-10-23 09:07:38',1,14,'32','Vertical gauges',3,''),(243,'2012-10-23 09:07:38',1,14,'33','Vertical gauges',3,''),(244,'2012-10-24 05:01:02',1,14,'6','Polar Chart ',2,'Изменен files.'),(245,'2012-10-24 08:34:09',1,13,'30','гш.pdf',3,''),(246,'2012-10-24 08:34:09',1,13,'29','aerf.jpg',3,''),(247,'2012-10-24 08:34:09',1,13,'28','Sample-parts-gauge.png',3,''),(248,'2012-10-24 08:34:09',1,13,'27','aerf.png',3,''),(249,'2012-10-24 08:34:09',1,13,'26','Footer.png',3,''),(250,'2012-10-24 08:34:09',1,13,'25','Icons.jpg',3,''),(251,'2012-10-24 08:34:09',1,13,'24','Footer.png',3,''),(252,'2012-10-24 08:34:09',1,13,'23','Footer.png',3,''),(253,'2012-10-24 08:34:09',1,13,'22','Первый.png',3,''),(254,'2012-10-24 08:34:09',1,13,'21','Sample-parts-gauge.jpg',3,''),(255,'2012-10-24 08:34:09',1,13,'20','Sample-parts-gauge.jpg',3,''),(256,'2012-10-24 08:34:09',1,13,'19','Первый.png',3,''),(257,'2012-10-24 08:34:09',1,13,'18','Главная страница.jpg',3,''),(258,'2012-10-24 08:34:10',1,13,'16','Sample-parts-gauge.bmp',3,''),(259,'2012-10-24 08:34:10',1,13,'14','Footer.jpg',3,''),(260,'2012-10-24 08:34:10',1,13,'13','Первый.jpg',3,''),(261,'2012-10-24 08:34:10',1,13,'12','Главная страница.jpg',3,''),(262,'2012-10-24 08:34:10',1,13,'11','Baikal.jpg',3,''),(263,'2012-10-24 08:34:10',1,13,'10','Baikal.png',3,''),(264,'2012-10-24 08:34:10',1,13,'9','Footer.png',3,''),(265,'2012-10-24 08:34:10',1,13,'8','aerf.png',3,''),(266,'2012-10-24 08:34:10',1,13,'7','aerf.jpg',3,''),(267,'2012-10-24 08:34:10',1,13,'6','aerf.jpg',3,''),(268,'2012-10-24 08:34:10',1,13,'5','Главная страница.jpg',3,''),(269,'2012-10-24 08:34:10',1,13,'4','Первый.jpg',3,''),(270,'2012-10-24 08:34:10',1,13,'3','Baikal.jpg',3,''),(271,'2012-10-24 08:34:10',1,13,'1','Sample-parts-gauge',3,'');
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
INSERT INTO `django_session` VALUES ('1fd18fc2928d3878043bfbce96e7de56','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-11-07 04:59:42'),('766946f51f20920464e31f75588e26a6','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-11-07 02:11:22'),('a350f7c620c19c37d780362a06d025f1','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-10-26 02:25:22'),('a6d31145cab21d0f5ccd88609675b5ed','MjVjZjg1YmI0ZjZlMDdiYjZjZjEwZWM3OTQ3Y2UxNjM2NTk4MTUxODqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQV1Lg==\n','2012-11-05 08:03:08'),('fb12c22e49ebb0f0877d2e3825962645','YzY3NTk1NGYxMTMyMjIxZWU2NGJiN2FlODEwYmYwZWMyMTUzZjEwYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQ11Lg==\n','2012-11-06 08:32:28');
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

-- Dump completed on 2012-10-24 17:52:40
