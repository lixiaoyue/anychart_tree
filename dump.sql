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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_fileinnodes`
--

LOCK TABLES `app_fileinnodes` WRITE;
/*!40000 ALTER TABLE `app_fileinnodes` DISABLE KEYS */;
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
  `base` tinyint(1) NOT NULL,
  `curator_id` int(11) NOT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_node_63f17a16` (`parent_id`),
  KEY `app_node_1c3fac13` (`curator_id`),
  KEY `app_node_42b06ff6` (`lft`),
  KEY `app_node_6eabc1a6` (`rght`),
  KEY `app_node_102f80d8` (`tree_id`),
  KEY `app_node_2a8f42e8` (`level`),
  CONSTRAINT `curator_id_refs_id_296f0a68` FOREIGN KEY (`curator_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `parent_id_refs_id_100cc283` FOREIGN KEY (`parent_id`) REFERENCES `app_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_node`
--

LOCK TABLES `app_node` WRITE;
/*!40000 ALTER TABLE `app_node` DISABLE KEYS */;
INSERT INTO `app_node` VALUES (1,'Требования к компоненту',NULL,1,1,1,32,21,0),(2,'Требования к сопроводительным материалам',NULL,1,1,1,6,22,0),(3,'Требования к демонстрационным примерам',2,1,1,2,3,22,1),(4,'Требования к пользовательской документации',2,1,1,4,5,22,1),(5,'Требования к чему-либо еще',NULL,1,1,1,2,23,0);
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
  `redaction_date` datetime NOT NULL,
  `node_id` int(11) NOT NULL,
  `release_id` int(11) NOT NULL,
  `edit_description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_nodeeditionhistory_474baebc` (`node_id`),
  KEY `app_nodeeditionhistory_47d82a6c` (`release_id`),
  CONSTRAINT `node_id_refs_id_73ad6efb` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_789000b5` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_nodeeditionhistory`
--

LOCK TABLES `app_nodeeditionhistory` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory` DISABLE KEYS */;
INSERT INTO `app_nodeeditionhistory` VALUES (1,'Обязательный минимум представлен в форме набора предметных тем (дидактических единиц), включаемых в обязательном порядке в основные образовательные программы начального общего, основного общего, среднего (полного) общего образования.\r\nОбязательный минимум включает основные ценности и достижения национальной и мировой культуры, фундаментальные научные идеи и факты, определяющие общие мировоззренческие позиции человека и обеспечивающие условия для социализации, интеллектуального и общекультурного развития обучающихся, формирования их социальной и функциональной грамотности.\r\nОбязательный минимум обеспечивает преемственность ступеней общего образования и учебных предметов, представляет обучающимся возможность успешно продолжить образование на последующих ступенях (уровнях) образования.\r\nОбязательный минимум не устанавливает порядок (последовательность) изучения предметных тем (дидактических единиц) в рамках ступеней общего образования и не определяет нормативы учебного времени, отводимые на изучение данной дидактической единицы в рамках учебной программы.\r\nОбязательный минимум представлен в двух форматах. Прямым шрифтом выделено содержание, изучение которого является объектом контроля и оценки в рамках итоговой аттестации выпускников. Курсивом выделено содержание, которое подлежит изучению, но не является объектом контроля и не включается в требования к уровню подготовки выпускников.\r\nДанный способ представления обязательного минимума расширяет вариативность подхода к изучению учебного материала, представляет возможность разноуровневого обучения.','2012-10-08 03:50:52',1,1,'только создано'),(2,'Михаил Рамников получил диплом в области бизнеса в Московском университете, работая в то же время помощником менеджера в бакалейном магазине своего отца. Получив диплом, он создал (с нуля) собственный магазин по продаже и ремонту велосипедов. В течение 12 лет Михаил осуществлял руководство всем, что имело отношение к деятельности малого бизнеса - от рекламы до бухгалтерского учета, от приема и обработки заказов до контроля качества. Под его руководством находилась небольшая команда механиков по ремонту велосипедов, но основную часть дел, связанных с продажами, он вел сам. Его магазин стал одной из самых респектабельных компаний малого бизнеса в том районе, где он был расположен. Когда Михаил решил перебраться в Америку, он смог выгодно продать свое дело.\r\nПостоянно поглощенный заботами своего бизнеса, Михаил не забывал и про свое увлечение- придумывать и готовить различные блюда. Начиная еще со времени работы в бакалейном магазине он постоянно экспериментировал с различными рецептами, чтобы придать своим блюдам особый аромат. Наконец Михаил понял, что именно в этом его истинное призвание, и решил соединить свое стремление заниматься бизнесом с любовью к кулинарному делу.\r\nХотя у него и нет опыта ведения бизнеса в сфере общественного питания, но он может привнести в это дело тот опыт, который получил в другой отрасли. Михаил возьмет на себя обязанности президента компании \"Mikhai!\'s Tacos, Inc.\", а также станет членом совета директоров.','2012-10-08 08:20:40',2,1,'только создано'),(3,'Поведение родителей\r\nВ экзаменационную пору основная задача родителей - создать оптимальные комфортные условия для подготовки ребенка и... не мешать ему. Поощрение, поддержка, реальная помощь, а главное - спокойствие взрослых помогают ребенку успешно справиться с собственным волнением.\r\nНе запугивайте ребенка, не напоминайте ему о сложности и ответственности предстоящих экзаменов. Это не повышает мотивацию, а только создает эмоциональные барьеры, которые сам ребенок преодолеть не может.\r\nОчень важно скорректировать ожидания выпускника. Объясните: для хорошего результата совсем не обязательно отвечать на все вопросы ЕГЭ. Гораздо эффективнее спокойно дать ответы на те вопросы, которые он знает наверняка, чем переживать из-за нерешенных заданий.\r\nНезависимо от результата экзамена, часто, щедро и от всей души говорите ему о том, что он (она) - самый(ая) любимый(ая), и что все у него (неё) в жизни получится! Вера в успех, уверенность в своем ребенке, его возможностях, стимулирующая помощь в виде похвалы и одобрения очень важны, ведь \"от хорошего слова даже кактусы лучше растут\".','2012-10-08 08:23:58',3,1,'только создано'),(4,'В отличие от технической документации, сфокусированной на коде и том, как он работает, пользовательская документация описывает лишь то, как использовать программу.\r\nВ случае если продуктом является программная библиотека, пользовательская документация и документация на код становятся очень близкими, почти эквивалентными понятиями. Но в общем случае, это не так.\r\nОбычно, пользовательская документация представляет собой руководство пользователя, которое описывает каждую функцию программы, а также шаги, которые нужно выполнить для использования этой функции. Хорошая пользовательская документация идёт ещё дальше и предоставляет инструкции о том что делать в случае возникновения проблем. Очень важно, чтобы документация не вводила в заблуждение и была актуальной. Руководство должно иметь чёткую структуру; очень полезно, если имеется сквозной предметный указатель. Логическая связность и простота также имеют большое значение.\r\nСуществует три подхода к организации пользовательской документации. Вводное руководство (англ. tutorial), наиболее полезное для новых пользователей, последовательно проводит по ряду шагов, служащих для выполнения каких-либо типичных задач. Тематический подход, при котором каждая глава руководства посвящена какой-то отдельной теме, больше подходит для совершенствующихся пользователей. В последнем, третьем подходе, команды или задачи организованы в виде алфавитного справочника — часто это хорошо воспринимается продвинутыми пользователями, хорошо знающими, что они ищут. Жалобы пользователей обычно относятся к тому, что документация охватывает только один из этих подходов, и поэтому хорошо подходит лишь для одного класса пользователей.\r\nВо многих случаях разработчики программного продукта ограничивают набор пользовательской документации лишь встроенной системой помощи (англ. online help), содержащей справочную информацию о командах или пунктах меню. Работа по обучению новых пользователей и поддержке совершенствующихся пользователей перекладывается на частных издателей, часто оказывающих значительную помощь разработчикам.','2012-10-08 08:24:39',4,1,'только создано'),(5,'Для того, чтобы войти на форум, Вы должны пройти процедуру регистрации. Процесс регистрации отнимет всего несколько минут, но позволит Вам получить более широкие возможности. Администрация форума может также предоставить зарегистрированным пользователям большие привилегии. Перед началом регистрации, Вы должны ознакомиться с правилами и политикой форума. Помните, что Ваше присутствие на форумах означает согласие со всеми правилами.','2012-10-08 08:25:29',5,1,'только создано');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_nodeeditionhistory_files`
--

LOCK TABLES `app_nodeeditionhistory_files` WRITE;
/*!40000 ALTER TABLE `app_nodeeditionhistory_files` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_release`
--

LOCK TABLES `app_release` WRITE;
/*!40000 ALTER TABLE `app_release` DISABLE KEYS */;
INSERT INTO `app_release` VALUES (1,'первый','2013-01-24 03:50:48','');
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
  `curator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirement_474baebc` (`node_id`),
  KEY `app_requirement_47d82a6c` (`release_id`),
  KEY `app_requirement_1c3fac13` (`curator_id`),
  CONSTRAINT `curator_id_refs_id_108bb4a` FOREIGN KEY (`curator_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `node_id_refs_id_316ccd9f` FOREIGN KEY (`node_id`) REFERENCES `app_node` (`id`),
  CONSTRAINT `release_id_refs_id_6adac0ef` FOREIGN KEY (`release_id`) REFERENCES `app_release` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirement`
--

LOCK TABLES `app_requirement` WRITE;
/*!40000 ALTER TABLE `app_requirement` DISABLE KEYS */;
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
  `deadline` date NOT NULL,
  `redaction_date` datetime NOT NULL,
  `edit_description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_requirementsedition_6657a0ce` (`requirement_id`),
  CONSTRAINT `requirement_id_refs_id_7e5ee194` FOREIGN KEY (`requirement_id`) REFERENCES `app_requirement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirementsedition`
--

LOCK TABLES `app_requirementsedition` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_requirementsedition_files`
--

LOCK TABLES `app_requirementsedition_files` WRITE;
/*!40000 ALTER TABLE `app_requirementsedition_files` DISABLE KEYS */;
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
  `color` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `app_status`
--

LOCK TABLES `app_status` WRITE;
/*!40000 ALTER TABLE `app_status` DISABLE KEYS */;
INSERT INTO `app_status` VALUES (1,'сформировано','неопределённый'),(2,'реализовано','зелёный'),(3,'в процессе согласования','фиолетовый'),(4,'в процессе реализации','терракотовый'),(5,'в процессе проверки','багряный'),(6,'удалено','неопределённый');
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add registration profile',8,'add_registrationprofile'),(23,'Can change registration profile',8,'change_registrationprofile'),(24,'Can delete registration profile',8,'delete_registrationprofile'),(25,'Can add Бизнес-требование',9,'add_node'),(26,'Can change Бизнес-требование',9,'change_node'),(27,'Can delete Бизнес-требование',9,'delete_node'),(28,'Can add Релиз',10,'add_release'),(29,'Can change Релиз',10,'change_release'),(30,'Can delete Релиз',10,'delete_release'),(31,'Can add Статус',11,'add_status'),(32,'Can change Статус',11,'change_status'),(33,'Can delete Статус',11,'delete_status'),(34,'Can add Файл',12,'add_fileinnodes'),(35,'Can change Файл',12,'change_fileinnodes'),(36,'Can delete Файл',12,'delete_fileinnodes'),(37,'Can add История редактирования БТ',13,'add_nodeeditionhistory'),(38,'Can change История редактирования БТ',13,'change_nodeeditionhistory'),(39,'Can delete История редактирования БТ',13,'delete_nodeeditionhistory'),(40,'Can add Тип отношений между узлами',14,'add_typeofnodesrelationship'),(41,'Can change Тип отношений между узлами',14,'change_typeofnodesrelationship'),(42,'Can delete Тип отношений между узлами',14,'delete_typeofnodesrelationship'),(43,'Can add Отношения между узлами',15,'add_nodesrelationship'),(44,'Can change Отношения между узлами',15,'change_nodesrelationship'),(45,'Can delete Отношения между узлами',15,'delete_nodesrelationship'),(46,'Can add Требование',16,'add_requirement'),(47,'Can change Требование',16,'change_requirement'),(48,'Can delete Требование',16,'delete_requirement'),(49,'Can add История редактирования требований',17,'add_requirementsedition'),(50,'Can change История редактирования требований',17,'change_requirementsedition'),(51,'Can delete История редактирования требований',17,'delete_requirementsedition');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'admin','','','maresha@list.ru','pbkdf2_sha256$10000$iLo6KVGu0B4w$j8DZKPdqszKuFlDRLZC/2teWjeSii3rZakyHIj6GSYg=',1,1,1,'2012-10-08 03:03:46','2012-10-08 03:03:15'),(2,'galina','','','','pbkdf2_sha256$10000$dOsDCKQWmtSw$gi+kIM5prV+DWbOAsGHVi4FH7nBgslkvtqcK4DaRcf8=',0,1,0,'2012-10-08 03:04:20','2012-10-08 03:04:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2012-10-08 03:04:20',1,4,'2','galina',1,''),(2,'2012-10-08 03:05:54',1,9,'1','Требования к компоненту',1,''),(3,'2012-10-08 03:06:11',1,9,'2','Требования к сопроводительным материалам',1,''),(4,'2012-10-08 03:06:25',1,9,'3','Требования к демонстрационным примерам',1,''),(5,'2012-10-08 03:06:38',1,9,'4','Требования к пользовательской документации',1,''),(6,'2012-10-08 03:06:59',1,9,'5','Требования к чему-либо еще',1,''),(7,'2012-10-08 03:50:49',1,10,'1','первый',1,''),(8,'2012-10-08 03:50:52',1,13,'1','только создано: 2012-10-08 03:50:52.749000+00:00',1,''),(9,'2012-10-08 03:52:04',1,11,'1','сформировано',1,''),(10,'2012-10-08 03:52:13',1,11,'2','реализовано',1,''),(11,'2012-10-08 03:52:25',1,11,'3','в процессе согласования',1,''),(12,'2012-10-08 03:52:45',1,11,'4','в процессе реализации',1,''),(13,'2012-10-08 03:53:02',1,11,'5','в процессе проверки',1,''),(14,'2012-10-08 03:53:11',1,11,'6','удалено',1,''),(15,'2012-10-08 05:10:10',1,9,'7','',3,''),(16,'2012-10-08 05:10:10',1,9,'8','',3,''),(17,'2012-10-08 05:10:10',1,9,'9','',3,''),(18,'2012-10-08 05:10:10',1,9,'10','',3,''),(19,'2012-10-08 05:10:10',1,9,'11','',3,''),(20,'2012-10-08 05:10:10',1,9,'12','',3,''),(21,'2012-10-08 05:10:10',1,9,'13','',3,''),(22,'2012-10-08 05:10:10',1,9,'14','',3,''),(23,'2012-10-08 05:10:10',1,9,'15','',3,''),(24,'2012-10-08 05:10:10',1,9,'16','',3,''),(25,'2012-10-08 05:10:10',1,9,'17','',3,''),(26,'2012-10-08 05:10:10',1,9,'18','',3,''),(27,'2012-10-08 05:10:10',1,9,'19','',3,''),(28,'2012-10-08 05:10:10',1,9,'20','',3,''),(29,'2012-10-08 05:10:10',1,9,'21','',3,''),(30,'2012-10-08 08:20:40',1,13,'2','только создано: 2012-10-08 08:20:40.736000+00:00',1,''),(31,'2012-10-08 08:23:58',1,13,'3','только создано: 2012-10-08 08:23:58.411000+00:00',1,''),(32,'2012-10-08 08:24:39',1,13,'4','только создано: 2012-10-08 08:24:39.361000+00:00',1,''),(33,'2012-10-08 08:25:29',1,13,'5','только создано: 2012-10-08 08:25:29.456000+00:00',1,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'registration profile','registration','registrationprofile'),(9,'Бизнес-требование','app','node'),(10,'Релиз','app','release'),(11,'Статус','app','status'),(12,'Файл','app','fileinnodes'),(13,'История редактирования БТ','app','nodeeditionhistory'),(14,'Тип отношений между узлами','app','typeofnodesrelationship'),(15,'Отношения между узлами','app','nodesrelationship'),(16,'Требование','app','requirement'),(17,'История редактирования требований','app','requirementsedition');
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
INSERT INTO `django_session` VALUES ('0e8d40d5706b68de8821e7008220b603','Y2VlZGFiNDNiOGY0OWFmNDIwOGUyN2IzNzAyMTA0MDE4NjA2NDZjYzqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-10-22 03:03:46');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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

-- Dump completed on 2012-10-08  8:29:58
