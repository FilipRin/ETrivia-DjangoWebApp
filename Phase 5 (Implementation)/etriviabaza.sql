-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: psi
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add game',6,'add_game'),(22,'Can change game',6,'change_game'),(23,'Can delete game',6,'delete_game'),(24,'Can view game',6,'view_game'),(25,'Can add multiplayerqueue',7,'add_multiplayerqueue'),(26,'Can change multiplayerqueue',7,'change_multiplayerqueue'),(27,'Can delete multiplayerqueue',7,'delete_multiplayerqueue'),(28,'Can view multiplayerqueue',7,'view_multiplayerqueue'),(29,'Can add questionsll',8,'add_questionsll'),(30,'Can change questionsll',8,'change_questionsll'),(31,'Can delete questionsll',8,'delete_questionsll'),(32,'Can view questionsll',8,'view_questionsll'),(33,'Can add questionsqow',9,'add_questionsqow'),(34,'Can change questionsqow',9,'change_questionsqow'),(35,'Can delete questionsqow',9,'delete_questionsqow'),(36,'Can view questionsqow',9,'view_questionsqow'),(37,'Can add user',10,'add_user'),(38,'Can change user',10,'change_user'),(39,'Can delete user',10,'delete_user'),(40,'Can view user',10,'view_user'),(41,'Can add result',11,'add_result'),(42,'Can change result',11,'change_result'),(43,'Can delete result',11,'delete_result'),(44,'Can view result',11,'view_result'),(45,'Can add llfield',12,'add_llfield'),(46,'Can change llfield',12,'change_llfield'),(47,'Can delete llfield',12,'delete_llfield'),(48,'Can view llfield',12,'view_llfield'),(49,'Can add secret sequence',13,'add_secretsequence'),(50,'Can change secret sequence',13,'change_secretsequence'),(51,'Can delete secret sequence',13,'delete_secretsequence'),(52,'Can view secret sequence',13,'view_secretsequence'),(53,'Can add number hunt',14,'add_numberhunt'),(54,'Can change number hunt',14,'change_numberhunt'),(55,'Can delete number hunt',14,'delete_numberhunt'),(56,'Can view number hunt',14,'view_numberhunt');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_Etrivia_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Etrivia_user_id` FOREIGN KEY (`user_id`) REFERENCES `etrivia_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'Etrivia','game'),(12,'Etrivia','llfield'),(7,'Etrivia','multiplayerqueue'),(14,'Etrivia','numberhunt'),(8,'Etrivia','questionsll'),(9,'Etrivia','questionsqow'),(11,'Etrivia','result'),(13,'Etrivia','secretsequence'),(10,'Etrivia','user'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-05-13 15:19:48.222717'),(2,'contenttypes','0002_remove_content_type_name','2024-05-13 15:19:48.301788'),(3,'auth','0001_initial','2024-05-13 15:19:48.560023'),(4,'auth','0002_alter_permission_name_max_length','2024-05-13 15:19:48.620078'),(5,'auth','0003_alter_user_email_max_length','2024-05-13 15:19:48.624082'),(6,'auth','0004_alter_user_username_opts','2024-05-13 15:19:48.629086'),(7,'auth','0005_alter_user_last_login_null','2024-05-13 15:19:48.633090'),(8,'auth','0006_require_contenttypes_0002','2024-05-13 15:19:48.635091'),(9,'auth','0007_alter_validators_add_error_messages','2024-05-13 15:19:48.639095'),(10,'auth','0008_alter_user_username_max_length','2024-05-13 15:19:48.643098'),(11,'auth','0009_alter_user_last_name_max_length','2024-05-13 15:19:48.647102'),(12,'auth','0010_alter_group_name_max_length','2024-05-13 15:19:48.656110'),(13,'auth','0011_update_proxy_permissions','2024-05-13 15:19:48.661115'),(14,'auth','0012_alter_user_first_name_max_length','2024-05-13 15:19:48.665119'),(15,'Etrivia','0001_initial','2024-05-13 15:19:49.622434'),(16,'admin','0001_initial','2024-05-13 15:19:49.758699'),(17,'admin','0002_logentry_remove_auto_add','2024-05-13 15:19:49.765584'),(18,'admin','0003_logentry_add_action_flag_choices','2024-05-13 15:19:49.771077'),(19,'sessions','0001_initial','2024-05-13 15:19:49.802961'),(20,'Etrivia','0002_alter_questionsll_prompt','2024-05-13 18:29:49.341675'),(21,'Etrivia','0003_numberhunt_secretsequence','2024-05-14 10:14:41.935009'),(22,'Etrivia','0004_game_idnh_game_idss','2024-05-14 10:14:42.126086'),(23,'Etrivia','0005_remove_llfield_text_llfield_left_llfield_right','2024-05-14 10:19:26.533242'),(24,'Etrivia','0006_alter_game_timestarted','2024-05-15 19:57:09.612020'),(25,'Etrivia','0007_game_joined','2024-05-17 19:50:10.575908'),(26,'Etrivia','0008_alter_result_idresult','2024-05-18 07:50:14.314306'),(27,'Etrivia','0009_alter_game_idqow1_alter_game_idqow2_and_more','2024-05-25 06:22:51.504028'),(28,'Etrivia','0010_remove_secretsequence_symbol1_and_more','2024-05-25 06:22:52.002953'),(29,'Etrivia','0011_game_finished','2024-05-25 06:22:52.064853'),(30,'Etrivia','0012_user_is_banned','2024-05-26 18:09:03.531078'),(31,'Etrivia','0013_result_timestamp','2024-05-29 06:13:24.455651'),(32,'Etrivia','0014_alter_llfield_left_alter_llfield_right_and_more','2024-05-31 06:58:52.992935'),(33,'Etrivia','0015_alter_questionsqow_question','2024-05-31 07:06:05.002128');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('aq23mymhz3icecfd3c6rnml1mkipx8wz','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6lu1:JNrj_Jlu6LB5SgBq4PsuhF1V7gjOCh0snrgjX47wpQw','2024-05-28 06:44:45.872103'),('dd3u5oktmmb78ky4jinl4yskfai04ocl','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6pSr:0lakb6qdsH7zwHEqt-kX2cOZS4FcZE9FXzHq0aa6Igs','2024-05-28 10:32:57.795479'),('jivkd9rnrmqfh3pgbfogq65mq3mxjhv3','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6tqi:BT5PzbjPanJweG7HTBsrBdIuNSxmwVqr_jY5VyrJIL0','2024-05-28 15:13:52.558954'),('q3sdh2ox8ypl04g8tsfrw1aqcm7j5wk1','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6lrF:s3f0nhJ4mLtne2Va21RusRICF1nVU5Sk2QXTZgDgJ_g','2024-05-28 06:41:53.296257'),('ror55a3i63b2snpdomu8z78ay0khq7ua','.eJxVjEEOwiAQRe_C2pAZWgq4dO8ZyMCAVA0kpV0Z765NutDtf-_9l_C0rcVvPS1-ZnEWKE6_W6D4SHUHfKd6azK2ui5zkLsiD9rltXF6Xg7376BQL996soPNkAYVrAUckVJAxgSsySlHDjgMqBm1MQwZHJs4Yc5W4eic1iDeH81RNw8:1sBI4d:fGZ-Xc-sUsc7TP1VdbSjNDuVYgl_etZhOs8RGm8Uaj0','2024-06-09 17:54:23.858148'),('smb0zzr32ke5ccs642p9mkg9aqtbwko7','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6a9y:AiCJorTi6ZijrkfNfYk0NDGrw_Rv1muULygf8fEkr9s','2024-05-27 18:12:26.403228'),('snw82o1jounyn6tbt2sscpqdoh92ix9i','.eJxVjDsOwyAQBe9CHSEW23xSpvcZ0AJLcBKBZOwqyt2DJRdJ-2bmvZnDfctub7S6JbIrk-zyu3kMTyoHiA8s98pDLdu6eH4o_KSNzzXS63a6fwcZW-41Eho5gfcSLJkopIpKBAOKBjvqwU7ekhwh2S5K3UGKCgCUpgQwCGSfL9nPN2o:1sCHzD:Gno4FN9XNSpUec-Zsxx2eHp6UnNNIO5HeRhv6KAtarU','2024-06-12 12:00:55.823644'),('twxcl7bpskk1ztxjazrrraryuxfop9n4','.eJxVjEEOwiAUBe_C2hD4lAIu3XuG5vEBqZo2Ke3KeHdt0oVu38y8lxiwrXXYWl6GMYmz0OL0u0XwI087SHdMt1nyPK3LGOWuyIM2eZ1Tfl4O9--gotVv7SwbEOmgoRCN4sg5FUB536NYJjJEBPLGdugUOwdngu2ddQWKgnh_AOHCN1I:1sCvxD:ELbuXloBtY5IkuPwZ5DKlI1jZZZfPHzn70gQ6-sphkc','2024-06-14 06:41:31.086070'),('ydridijcxinq965gegynzdstq8iikzva','.eJxVjEEOwiAQRe_C2hAYpoW6dO8ZCMMMtmpKUtqV8e7apAvd_vfef6mYtnWMW5MlTqzOCtTpd6OUHzLvgO9pvlWd67wuE-ld0Qdt-lpZnpfD_TsYUxu_dUHjqUuDDJlMQMeMllxAANNLNpQTMhUALN5mCNyLRRDvgAk6MFa9P-k7N7I:1s6tYq:dkCwfyVoGlD-P253PntDM26C1R01SxWOe3zDQgGS0fo','2024-05-28 14:55:24.248413');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etrivia_user`
--

DROP TABLE IF EXISTS `etrivia_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etrivia_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `idqueue` int NOT NULL,
  `is_banned` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etrivia_user`
--

LOCK TABLES `etrivia_user` WRITE;
/*!40000 ALTER TABLE `etrivia_user` DISABLE KEYS */;
INSERT INTO `etrivia_user` VALUES (1,'pbkdf2_sha256$720000$kTKpjp9lxbm9h1uNyFwPSl$QKKpC1LAcKtfprpS4WY81mMH9jlH9tR5jXH0p3g07kw=','2024-05-31 06:41:31.081377',1,'admin','','','',1,1,'2024-05-13 17:14:06.445859',0,0),(2,'pbkdf2_sha256$720000$PTaTXGXcamOjlBwd3bLgKp$w4uIuybLqufcbS8gmG/BKW+gZNBzSjuUu3tMkhUrrdc=','2024-05-29 12:00:55.822246',1,'admin2','','','',1,1,'2024-05-13 17:14:15.764421',0,0),(3,'pbkdf2_sha256$720000$1bKUp3GoKE4KkoiNWVKuKf$W1lEueSPqxs4Pfksdfe/pzPG89iDkvWtUGDpJWE1J/g=','2024-05-30 14:05:35.249334',0,'dorde','','','',0,1,'2024-05-30 13:27:19.857613',0,0);
/*!40000 ALTER TABLE `etrivia_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etrivia_user_groups`
--

DROP TABLE IF EXISTS `etrivia_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etrivia_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Etrivia_user_groups_user_id_group_id_9de860a3_uniq` (`user_id`,`group_id`),
  KEY `Etrivia_user_groups_group_id_96fb7bc4_fk_auth_group_id` (`group_id`),
  CONSTRAINT `Etrivia_user_groups_group_id_96fb7bc4_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Etrivia_user_groups_user_id_bb7cc0ec_fk_Etrivia_user_id` FOREIGN KEY (`user_id`) REFERENCES `etrivia_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etrivia_user_groups`
--

LOCK TABLES `etrivia_user_groups` WRITE;
/*!40000 ALTER TABLE `etrivia_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `etrivia_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etrivia_user_user_permissions`
--

DROP TABLE IF EXISTS `etrivia_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etrivia_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Etrivia_user_user_permis_user_id_permission_id_47632fdf_uniq` (`user_id`,`permission_id`),
  KEY `Etrivia_user_user_pe_permission_id_7726d13c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `Etrivia_user_user_pe_permission_id_7726d13c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `Etrivia_user_user_pe_user_id_07a87a06_fk_Etrivia_u` FOREIGN KEY (`user_id`) REFERENCES `etrivia_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etrivia_user_user_permissions`
--

LOCK TABLES `etrivia_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `etrivia_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `etrivia_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `IdGame` int NOT NULL AUTO_INCREMENT,
  `TimeStarted` datetime(6) DEFAULT NULL,
  `IdLL` int DEFAULT NULL,
  `IdQOW1` int DEFAULT NULL,
  `IdQOW2` int DEFAULT NULL,
  `IdQOW3` int DEFAULT NULL,
  `IdQOW4` int DEFAULT NULL,
  `IdQOW5` int DEFAULT NULL,
  `IdUser1` bigint NOT NULL,
  `IdUser2` bigint NOT NULL,
  `IdHunt` int DEFAULT NULL,
  `IdSecret` int DEFAULT NULL,
  `joined` int NOT NULL,
  `finished` int NOT NULL,
  PRIMARY KEY (`IdGame`),
  KEY `game_IdLL_d11a65c6_fk_questionsll_IdLL` (`IdLL`),
  KEY `game_IdQOW1_343851b1_fk_questionsqow_IdQOW` (`IdQOW1`),
  KEY `game_IdQOW2_1d17e38e_fk_questionsqow_IdQOW` (`IdQOW2`),
  KEY `game_IdQOW3_d6472d8a_fk_questionsqow_IdQOW` (`IdQOW3`),
  KEY `game_IdQOW4_fd6a1fcd_fk_questionsqow_IdQOW` (`IdQOW4`),
  KEY `game_IdQOW5_e0a6c699_fk_questionsqow_IdQOW` (`IdQOW5`),
  KEY `game_IdUser1_8d8d0494_fk_Etrivia_user_id` (`IdUser1`),
  KEY `game_IdUser2_17c88385_fk_Etrivia_user_id` (`IdUser2`),
  KEY `game_IdHunt_8b2f18ca_fk_numberhunt_IdHunt` (`IdHunt`),
  KEY `game_IdSecret_d41f57c9_fk_secretsequence_IdSecret` (`IdSecret`),
  CONSTRAINT `game_IdHunt_8b2f18ca_fk_numberhunt_IdHunt` FOREIGN KEY (`IdHunt`) REFERENCES `numberhunt` (`IdHunt`),
  CONSTRAINT `game_IdLL_d11a65c6_fk_questionsll_IdLL` FOREIGN KEY (`IdLL`) REFERENCES `questionsll` (`IdLL`),
  CONSTRAINT `game_IdQOW1_343851b1_fk_questionsqow_IdQOW` FOREIGN KEY (`IdQOW1`) REFERENCES `questionsqow` (`IdQOW`),
  CONSTRAINT `game_IdQOW2_1d17e38e_fk_questionsqow_IdQOW` FOREIGN KEY (`IdQOW2`) REFERENCES `questionsqow` (`IdQOW`),
  CONSTRAINT `game_IdQOW3_d6472d8a_fk_questionsqow_IdQOW` FOREIGN KEY (`IdQOW3`) REFERENCES `questionsqow` (`IdQOW`),
  CONSTRAINT `game_IdQOW4_fd6a1fcd_fk_questionsqow_IdQOW` FOREIGN KEY (`IdQOW4`) REFERENCES `questionsqow` (`IdQOW`),
  CONSTRAINT `game_IdQOW5_e0a6c699_fk_questionsqow_IdQOW` FOREIGN KEY (`IdQOW5`) REFERENCES `questionsqow` (`IdQOW`),
  CONSTRAINT `game_IdSecret_d41f57c9_fk_secretsequence_IdSecret` FOREIGN KEY (`IdSecret`) REFERENCES `secretsequence` (`IdSecret`),
  CONSTRAINT `game_IdUser1_8d8d0494_fk_Etrivia_user_id` FOREIGN KEY (`IdUser1`) REFERENCES `etrivia_user` (`id`),
  CONSTRAINT `game_IdUser2_17c88385_fk_Etrivia_user_id` FOREIGN KEY (`IdUser2`) REFERENCES `etrivia_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (186,'2024-05-25 16:17:05.369248',1,1,5,NULL,2,4,2,1,191,191,0,1),(187,'2024-05-25 16:19:02.842666',1,4,NULL,5,2,1,1,2,192,192,0,1),(188,'2024-05-25 16:19:15.769248',1,5,1,3,4,NULL,2,1,193,193,0,1),(189,'2024-05-25 16:23:27.081246',1,3,5,4,1,NULL,2,1,194,194,0,1),(190,'2024-05-25 16:27:31.198508',1,4,5,2,3,NULL,2,1,195,195,0,1),(191,'2024-05-25 16:29:25.265080',1,5,2,NULL,3,4,2,1,196,196,0,1),(192,'2024-05-25 16:30:37.555288',1,2,5,4,NULL,3,2,1,197,197,0,1),(193,'2024-05-25 16:33:11.057255',1,1,5,3,NULL,2,1,2,198,198,0,1),(194,'2024-05-25 19:16:56.825248',2,3,5,2,4,NULL,1,2,199,199,0,1),(195,'2024-05-26 20:05:30.922625',1,NULL,1,5,2,4,1,1,200,200,0,1),(196,'2024-05-26 20:06:12.397628',1,NULL,2,5,3,4,1,2,201,201,0,1),(197,'2024-05-26 20:07:07.497951',1,5,4,NULL,2,3,1,2,202,202,0,1),(198,'2024-05-26 20:07:45.803104',1,4,3,NULL,1,2,1,2,203,203,0,1),(199,'2024-05-26 20:09:21.230729',2,5,1,NULL,2,4,1,2,204,204,0,1),(200,'2024-05-29 14:01:02.000570',1,5,3,NULL,4,1,1,2,205,205,0,1),(201,'2024-05-29 14:04:47.245202',1,2,5,3,NULL,4,1,2,206,206,0,1),(202,'2024-05-30 15:27:41.865362',1,5,3,4,1,NULL,3,2,207,207,2,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llfield`
--

DROP TABLE IF EXISTS `llfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `llfield` (
  `IdLLField` int NOT NULL AUTO_INCREMENT,
  `IdLL` int NOT NULL,
  `Left` varchar(100) NOT NULL,
  `Right` varchar(100) NOT NULL,
  PRIMARY KEY (`IdLLField`),
  KEY `llfield_IdLL_4635de92_fk_questionsll_IdLL` (`IdLL`),
  CONSTRAINT `llfield_IdLL_4635de92_fk_questionsll_IdLL` FOREIGN KEY (`IdLL`) REFERENCES `questionsll` (`IdLL`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llfield`
--

LOCK TABLES `llfield` WRITE;
/*!40000 ALTER TABLE `llfield` DISABLE KEYS */;
INSERT INTO `llfield` VALUES (18,3,'Dusan','Vlahovic'),(19,3,'Olivier','Giroud'),(20,3,'David','De Gea'),(21,3,'Toni','Kroos'),(22,3,'Marco','Reus'),(23,3,'Robert','Lewandowski'),(24,3,'Bukayo','Saka'),(25,3,'Harry','Kane'),(26,3,'Lionel','Messi'),(27,3,'Cristiano','Ronaldo'),(28,3,'Kylian','Mbappe'),(29,3,'Aleksandar','Mitrovic'),(30,4,'Serbia','Belgrade'),(31,4,'United Kingdom','London'),(32,4,'Russia','Moscow'),(33,4,'Germany','Berlin'),(34,4,'France','Paris'),(35,4,'USA','Washington DC'),(36,4,'Japan','Tokyo'),(37,4,'South Korea','Seoul'),(38,4,'Greece','Athens'),(39,4,'Egypt','Cairo'),(40,4,'Philippines','Manila'),(41,4,'Poland','Warsaw'),(42,5,'Cillian Murphy','Oppenheimer'),(43,5,'Brendan Fraser','The Whale'),(44,5,'Will Smith','King Richard'),(45,5,'Anthony Hopkins','The Father'),(46,5,'Joaquin Phoenix','Joker'),(47,5,'Rami Malek','Bohemian Rhapsody'),(48,5,'Gary Oldman','Darkest Hour'),(49,5,'Casey Affleck','Manchester by the Sea'),(50,5,'Leonardo DiCaprio','The Revenant'),(51,6,'Lakers','Los Angeles'),(52,6,'Celtics','Boston'),(53,6,'Grizzlies','Memphis'),(54,6,'Pelicans','New Orleans'),(55,6,'Nuggets','Denver'),(56,6,'Jazz','Utah'),(57,6,'Mavericks','Dallas'),(58,6,'Cavaliers','Cleveland');
/*!40000 ALTER TABLE `llfield` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multiplayerqueue`
--

DROP TABLE IF EXISTS `multiplayerqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multiplayerqueue` (
  `IdQueue` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(18) DEFAULT NULL,
  `TimeJoined` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`IdQueue`)
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multiplayerqueue`
--

LOCK TABLES `multiplayerqueue` WRITE;
/*!40000 ALTER TABLE `multiplayerqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `multiplayerqueue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `numberhunt`
--

DROP TABLE IF EXISTS `numberhunt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `numberhunt` (
  `IdHunt` int NOT NULL AUTO_INCREMENT,
  `GoalNumber` int NOT NULL,
  `Number1` int NOT NULL,
  `Number2` int NOT NULL,
  `Number3` int NOT NULL,
  `Number4` int NOT NULL,
  `Number5` int NOT NULL,
  `Number6` int NOT NULL,
  PRIMARY KEY (`IdHunt`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `numberhunt`
--

LOCK TABLES `numberhunt` WRITE;
/*!40000 ALTER TABLE `numberhunt` DISABLE KEYS */;
INSERT INTO `numberhunt` VALUES (1,148,7,8,3,7,10,100),(2,53,9,7,3,7,15,25),(3,959,1,4,5,1,15,100),(4,228,8,2,1,9,10,25),(5,417,8,8,3,7,10,100),(6,488,1,2,1,8,15,25),(7,742,3,4,8,4,10,25),(8,580,4,2,9,2,15,25),(9,981,1,2,3,5,15,100),(10,70,9,9,1,4,20,50),(11,220,4,1,8,3,20,25),(12,942,5,6,2,8,20,50),(13,762,8,9,1,1,15,100),(14,929,8,3,3,1,20,25),(15,978,1,7,5,6,15,100),(16,463,1,2,3,3,15,50),(17,855,9,1,2,5,15,25),(18,465,5,2,7,7,20,100),(19,707,2,4,1,2,10,100),(20,433,5,7,8,7,10,25),(21,165,2,7,2,4,20,50),(22,758,1,5,6,2,10,25),(23,382,4,3,1,4,15,50),(24,470,2,7,4,3,15,100),(25,518,8,8,9,1,20,100),(26,415,1,3,4,3,20,50),(27,522,7,1,1,1,15,100),(28,597,1,6,8,8,20,100),(29,73,7,5,5,5,20,25),(30,71,2,2,2,2,10,25),(31,330,9,1,6,6,15,50),(32,498,8,1,9,8,10,50),(33,416,2,8,4,9,15,50),(34,924,6,1,2,7,15,100),(35,968,2,9,4,4,10,100),(36,113,3,5,7,8,15,100),(37,189,7,4,1,8,10,100),(38,738,7,3,2,6,10,100),(39,290,2,9,6,6,10,100),(40,685,3,1,4,7,15,100),(41,857,5,9,8,6,10,50),(42,847,9,5,9,8,10,100),(43,773,1,2,3,1,15,100),(44,710,9,4,2,5,15,100),(45,776,7,4,4,7,10,100),(46,497,1,1,5,2,10,25),(47,981,6,9,8,3,15,50),(48,16,8,5,6,9,15,100),(49,711,2,8,8,9,15,50),(50,267,2,6,5,6,20,50),(51,678,3,2,3,7,15,50),(52,550,8,5,9,4,10,25),(53,388,5,5,2,2,15,100),(54,926,8,9,2,8,10,25),(55,246,1,6,1,2,10,50),(56,475,8,5,2,2,15,25),(57,85,8,1,8,3,15,100),(58,785,3,5,6,5,20,25),(59,565,6,8,8,8,10,25),(60,717,8,9,8,2,15,25),(61,48,4,6,8,2,20,50),(62,76,1,2,7,6,20,50),(63,644,1,9,8,9,15,50),(64,484,5,9,6,5,10,25),(65,17,7,8,8,9,20,25),(66,343,5,3,1,5,10,25),(67,805,3,7,1,4,15,50),(68,172,4,4,7,9,15,50),(69,173,2,4,2,4,10,100),(70,675,2,2,2,8,10,25),(71,604,2,7,2,3,15,100),(72,83,7,5,8,1,10,50),(73,811,8,4,2,4,15,50),(74,579,4,4,7,6,10,50),(75,193,2,6,7,1,10,25),(76,77,7,4,6,9,10,25),(77,996,6,5,3,7,15,50),(78,520,5,4,9,6,10,50),(79,393,4,5,5,4,20,50),(80,907,4,4,5,1,15,100),(81,831,1,7,7,8,15,100),(82,876,5,5,7,9,15,100),(83,104,1,7,2,6,20,50),(84,801,1,9,3,1,20,25),(85,192,7,4,1,5,20,50),(86,394,2,3,2,1,15,50),(87,970,8,5,7,6,15,50),(88,770,8,1,7,5,10,100),(89,263,8,4,4,3,20,25),(90,403,4,4,2,8,15,25),(91,359,5,3,1,2,20,50),(92,479,9,6,8,8,10,50),(93,270,3,2,3,9,15,100),(94,836,1,3,1,5,10,100),(95,685,1,4,4,6,15,50),(96,10,9,3,3,5,20,50),(97,484,6,1,4,7,15,50),(98,773,2,3,1,6,20,50),(99,793,5,4,4,3,10,25),(100,554,5,2,4,3,10,100),(101,246,3,8,9,9,15,25),(102,799,8,8,9,7,20,100),(103,679,3,2,6,2,20,100),(104,859,9,5,3,3,20,50),(105,188,7,5,4,2,20,100),(106,391,6,3,9,2,15,50),(107,240,2,8,4,8,15,50),(108,761,3,6,1,3,10,25),(109,480,1,5,4,1,15,100),(110,424,7,1,6,8,15,100),(111,708,4,5,8,2,15,50),(112,402,8,3,6,2,10,100),(113,941,5,9,4,2,15,50),(114,143,1,3,6,6,20,25),(115,703,3,5,2,3,15,50),(116,368,3,8,3,1,15,50),(117,707,7,7,8,7,20,25),(118,731,5,2,2,2,20,25),(119,430,7,9,2,9,20,50),(120,239,3,8,2,4,10,100),(121,664,1,6,1,4,15,100),(122,559,8,6,1,6,20,100),(123,983,4,7,1,2,15,25),(124,936,7,2,1,6,15,25),(125,140,1,6,2,2,20,100),(126,86,7,9,3,9,15,25),(127,482,8,1,3,2,15,50),(128,362,3,3,5,5,20,100),(129,267,3,3,7,2,15,50),(130,175,9,2,2,7,10,100),(131,495,5,9,5,5,20,50),(132,563,5,7,2,4,15,25),(133,897,9,6,1,7,20,100),(134,112,8,1,5,5,10,25),(135,165,3,8,9,4,10,100),(136,867,4,7,9,8,15,100),(137,571,6,6,3,8,20,25),(138,205,2,4,7,2,10,25),(139,997,2,6,2,2,10,100),(140,699,8,8,2,3,15,25),(141,809,4,3,4,7,15,100),(142,14,8,9,6,9,20,100),(143,61,8,5,5,3,15,100),(144,753,1,1,9,6,15,25),(145,848,1,7,7,8,20,50),(146,230,5,4,9,1,10,50),(147,130,6,1,5,4,10,25),(148,45,5,8,7,5,10,100),(149,447,6,3,6,6,10,100),(150,925,1,7,8,5,10,100),(151,276,6,6,4,8,10,25),(152,745,3,7,5,4,20,50),(153,658,3,2,6,2,15,25),(154,216,9,3,2,3,15,100),(155,91,9,9,7,7,10,100),(156,540,8,3,7,9,10,100),(157,648,3,1,1,4,20,100),(158,8,5,1,1,5,20,25),(159,266,2,3,3,5,20,50),(160,208,5,7,1,3,20,50),(161,102,6,2,6,4,10,50),(162,903,4,4,1,8,20,50),(163,100,8,8,8,4,15,50),(164,737,8,1,9,3,10,25),(165,796,5,5,6,3,20,25),(166,931,6,9,2,7,15,25),(167,333,4,4,7,5,10,25),(168,61,8,6,5,7,15,100),(169,288,2,4,4,2,10,50),(170,550,7,7,2,5,20,25),(171,99,5,4,8,3,10,25),(172,949,5,4,4,8,15,50),(173,631,5,4,4,9,20,100),(174,656,4,2,8,9,10,50),(175,203,5,8,9,5,20,25),(176,738,7,1,5,6,20,50),(177,748,3,2,3,5,10,25),(178,989,7,1,8,3,10,25),(179,701,4,3,6,1,15,25),(180,156,5,3,8,9,10,100),(181,983,3,7,3,2,15,100),(182,721,2,3,3,6,20,50),(183,882,3,6,5,1,10,100),(184,483,1,8,7,4,15,100),(185,134,5,7,7,3,15,25),(186,354,3,3,9,9,10,25),(187,880,8,7,1,5,20,50),(188,669,7,9,3,5,10,25),(189,230,6,5,6,7,10,25),(190,901,2,1,4,8,20,100),(191,98,4,1,8,1,15,50),(192,364,6,9,9,1,15,50),(193,668,6,2,4,8,15,50),(194,623,3,2,4,1,20,100),(195,767,5,5,9,4,20,100),(196,81,2,1,7,2,10,50),(197,657,6,8,5,7,15,25),(198,534,1,2,9,3,10,50),(199,555,3,8,8,6,20,100),(200,683,4,1,9,3,10,50),(201,654,7,4,4,9,15,50),(202,600,6,3,8,8,20,100),(203,485,6,1,5,9,20,100),(204,550,4,3,4,1,15,50),(205,569,5,9,4,1,20,100),(206,783,4,6,1,1,10,100),(207,305,4,4,2,9,15,50);
/*!40000 ALTER TABLE `numberhunt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionsll`
--

DROP TABLE IF EXISTS `questionsll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionsll` (
  `IdLL` int NOT NULL AUTO_INCREMENT,
  `Prompt` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdLL`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionsll`
--

LOCK TABLES `questionsll` WRITE;
/*!40000 ALTER TABLE `questionsll` DISABLE KEYS */;
INSERT INTO `questionsll` VALUES (1,'Povezi imena i prezimena fudbalera'),(2,'b'),(3,'Connect the first and last names of footballers'),(4,'Connect the countries and their capital cities'),(5,'Connect the actors with the films for which they won the Academy Award for Best Actor'),(6,'Connect NBA teams with their home cities');
/*!40000 ALTER TABLE `questionsll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionsqow`
--

DROP TABLE IF EXISTS `questionsqow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionsqow` (
  `IdQOW` int NOT NULL AUTO_INCREMENT,
  `Question` varchar(150) NOT NULL,
  `Correct` varchar(100) NOT NULL,
  `Incorrect1` varchar(100) NOT NULL,
  `Incorrect2` varchar(100) NOT NULL,
  `Incorrect3` varchar(100) NOT NULL,
  PRIMARY KEY (`IdQOW`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionsqow`
--

LOCK TABLES `questionsqow` WRITE;
/*!40000 ALTER TABLE `questionsqow` DISABLE KEYS */;
INSERT INTO `questionsqow` VALUES (1,'When did WW2 start?','1939','1942','1878','1914'),(2,'What was the name of the first American president?','George Washington','Winston Churchill','Theodore Roosevelt','Thomas Jefferson'),(3,'Which NBA player has won the most championships?','Bill Russel','LeBron James','Sam Jones','Larry Bird'),(4,'What is the distance ran in a marathon?','42km','26km','60km','5km'),(5,'Where was the 2010 footbal World Cup held?','South Africa','Germany','Brazil','Russia'),(8,'\"High on the young Rhine\" is which countries national anthem?','Liechtenstein','Luxembourg','Germany','Belgium'),(9,'The currency \"Pataca\" is used in which territory?','Macao','China','Taiwan','Hong Kong'),(11,'Which sport made it\'s Olympic debut at the Tokyo Olympics, but will not be present at the Paris Olympics?','Karate','3x3 Basketball','Boxing','Wrestling'),(12,'What is the name of the simplest hydrocarbon?','Methane','Ethanol','Methanol','Ethane'),(13,'Which Russian novel starts with the sentence “Happy families are all alike; every unhappy family is unhappy in its own way.” ?','Anna Karenina','War and Peace','The Brothers Karamazov','Crime and Punishment');
/*!40000 ALTER TABLE `questionsqow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `IdResult` int NOT NULL AUTO_INCREMENT,
  `Points1` int NOT NULL,
  `Points2` int NOT NULL,
  `Points3` int NOT NULL,
  `Points4` int NOT NULL,
  `Won` longtext NOT NULL,
  `IdGame` int DEFAULT NULL,
  `IdUser` bigint NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`IdResult`),
  KEY `result_IdGame_dba0bdb9_fk_game_IdGame` (`IdGame`),
  KEY `result_IdUser_7813ca64_fk_Etrivia_user_id` (`IdUser`),
  CONSTRAINT `result_IdUser_7813ca64_fk_Etrivia_user_id` FOREIGN KEY (`IdUser`) REFERENCES `etrivia_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result`
--

LOCK TABLES `result` WRITE;
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
INSERT INTO `result` VALUES (1,3,19,3,0,'undefined',109,1,'2024-05-29 06:13:24.424401'),(2,2,11,1,11,'undefined',110,1,'2024-05-29 06:13:24.424401'),(3,7,14,4,14,'undefined',111,1,'2024-05-29 06:13:24.424401'),(4,4,0,12,4,'undefined',112,1,'2024-05-29 06:13:24.424401'),(5,4,14,11,6,'undefined',113,1,'2024-05-29 06:13:24.424401'),(6,9,17,16,13,'undefined',114,1,'2024-05-29 06:13:24.424401'),(7,9,10,15,5,'lost',116,2,'2024-05-29 06:13:24.424401'),(8,3,18,17,5,'won',116,1,'2024-05-29 06:13:24.424401'),(9,13,1,3,17,'lost',117,2,'2024-05-29 06:13:24.424401'),(10,9,19,5,6,'won',117,1,'2024-05-29 06:13:24.424401'),(11,18,0,6,3,'lost',118,2,'2024-05-29 06:13:24.424401'),(12,9,6,8,14,'won',118,1,'2024-05-29 06:13:24.424401'),(13,18,3,13,6,'won',121,2,'2024-05-29 06:13:24.424401'),(14,9,3,17,7,'lost',121,1,'2024-05-29 06:13:24.424401'),(15,9,10,9,6,'lost',123,1,'2024-05-29 06:13:24.424401'),(16,18,10,18,17,'won',123,2,'2024-05-29 06:13:24.424401'),(17,9,11,16,6,'undefined',131,1,'2024-05-29 06:13:24.424401'),(18,9,14,14,6,'lost',132,1,'2024-05-29 06:13:24.424401'),(19,18,4,8,17,'won',132,2,'2024-05-29 06:13:24.424401'),(20,9,11,2,6,'undefined',137,1,'2024-05-29 06:13:24.424401'),(21,18,6,1,17,'won',146,2,'2024-05-29 06:13:24.424401'),(22,9,7,10,6,'lost',146,1,'2024-05-29 06:13:24.424401'),(23,9,7,16,6,'lost',150,1,'2024-05-29 06:13:24.424401'),(24,18,4,12,17,'won',150,2,'2024-05-29 06:13:24.424401'),(25,9,8,7,6,'lost',151,1,'2024-05-29 06:13:24.424401'),(26,18,16,11,17,'won',151,2,'2024-05-29 06:13:24.424401'),(27,0,15,13,6,'undefined',153,1,'2024-05-29 06:13:24.424401'),(28,0,16,2,6,'undefined',154,1,'2024-05-29 06:13:24.424401'),(29,20,7,8,0,'lost',155,1,'2024-05-29 06:13:24.424401'),(30,18,5,13,0,'won',155,2,'2024-05-29 06:13:24.424401'),(31,0,8,9,25,'undefined',156,1,'2024-05-29 06:13:24.424401'),(32,20,7,18,15,'undefined',159,1,'2024-05-29 06:13:24.424401'),(33,0,16,1,-10,'won',168,1,'2024-05-29 06:13:24.424401'),(34,0,12,5,-25,'lost',168,2,'2024-05-29 06:13:24.424401'),(35,0,14,18,-25,'won',169,2,'2024-05-29 06:13:24.424401'),(36,0,19,6,-25,'lost',169,1,'2024-05-29 06:13:24.424401'),(37,20,11,11,0,'won',180,2,'2024-05-29 06:13:24.424401'),(38,0,12,19,-25,'lost',180,1,'2024-05-29 06:13:24.424401'),(39,0,6,7,-25,'lost',181,2,'2024-05-29 06:13:24.424401'),(40,0,16,10,-25,'won',181,1,'2024-05-29 06:13:24.424401'),(41,0,10,0,-5,'won',200,2,'2024-05-29 12:02:46.839307'),(42,0,30,0,0,'won',201,2,'2024-05-29 12:05:32.196199'),(43,20,20,24,5,'won',202,3,'2024-05-30 13:29:15.184247'),(44,0,30,0,0,'lost',202,2,'2024-05-30 13:29:58.238596');
/*!40000 ALTER TABLE `result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secretsequence`
--

DROP TABLE IF EXISTS `secretsequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `secretsequence` (
  `IdSecret` int NOT NULL AUTO_INCREMENT,
  `Symbol11` int NOT NULL,
  `Symbol12` int NOT NULL,
  `Symbol13` int NOT NULL,
  `Symbol21` int NOT NULL,
  `Symbol22` int NOT NULL,
  `Symbol23` int NOT NULL,
  `Symbol24` int NOT NULL,
  `Symbol31` int NOT NULL,
  `Symbol32` int NOT NULL,
  `Symbol33` int NOT NULL,
  `Symbol34` int NOT NULL,
  `Symbol35` int NOT NULL,
  PRIMARY KEY (`IdSecret`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secretsequence`
--

LOCK TABLES `secretsequence` WRITE;
/*!40000 ALTER TABLE `secretsequence` DISABLE KEYS */;
INSERT INTO `secretsequence` VALUES (1,0,0,0,0,0,0,0,0,0,0,0,0),(2,0,0,0,0,0,0,0,0,0,0,0,0),(3,0,0,0,0,0,0,0,0,0,0,0,0),(4,0,0,0,0,0,0,0,0,0,0,0,0),(5,0,0,0,0,0,0,0,0,0,0,0,0),(6,0,0,0,0,0,0,0,0,0,0,0,0),(7,0,0,0,0,0,0,0,0,0,0,0,0),(8,0,0,0,0,0,0,0,0,0,0,0,0),(9,0,0,0,0,0,0,0,0,0,0,0,0),(10,0,0,0,0,0,0,0,0,0,0,0,0),(11,0,0,0,0,0,0,0,0,0,0,0,0),(12,0,0,0,0,0,0,0,0,0,0,0,0),(13,0,0,0,0,0,0,0,0,0,0,0,0),(14,0,0,0,0,0,0,0,0,0,0,0,0),(15,0,0,0,0,0,0,0,0,0,0,0,0),(16,0,0,0,0,0,0,0,0,0,0,0,0),(17,0,0,0,0,0,0,0,0,0,0,0,0),(18,0,0,0,0,0,0,0,0,0,0,0,0),(19,0,0,0,0,0,0,0,0,0,0,0,0),(20,0,0,0,0,0,0,0,0,0,0,0,0),(21,0,0,0,0,0,0,0,0,0,0,0,0),(22,0,0,0,0,0,0,0,0,0,0,0,0),(23,0,0,0,0,0,0,0,0,0,0,0,0),(24,0,0,0,0,0,0,0,0,0,0,0,0),(25,0,0,0,0,0,0,0,0,0,0,0,0),(26,0,0,0,0,0,0,0,0,0,0,0,0),(27,0,0,0,0,0,0,0,0,0,0,0,0),(28,0,0,0,0,0,0,0,0,0,0,0,0),(29,0,0,0,0,0,0,0,0,0,0,0,0),(30,0,0,0,0,0,0,0,0,0,0,0,0),(31,0,0,0,0,0,0,0,0,0,0,0,0),(32,0,0,0,0,0,0,0,0,0,0,0,0),(33,0,0,0,0,0,0,0,0,0,0,0,0),(34,0,0,0,0,0,0,0,0,0,0,0,0),(35,0,0,0,0,0,0,0,0,0,0,0,0),(36,0,0,0,0,0,0,0,0,0,0,0,0),(37,0,0,0,0,0,0,0,0,0,0,0,0),(38,0,0,0,0,0,0,0,0,0,0,0,0),(39,0,0,0,0,0,0,0,0,0,0,0,0),(40,0,0,0,0,0,0,0,0,0,0,0,0),(41,0,0,0,0,0,0,0,0,0,0,0,0),(42,0,0,0,0,0,0,0,0,0,0,0,0),(43,0,0,0,0,0,0,0,0,0,0,0,0),(44,0,0,0,0,0,0,0,0,0,0,0,0),(45,0,0,0,0,0,0,0,0,0,0,0,0),(46,0,0,0,0,0,0,0,0,0,0,0,0),(47,0,0,0,0,0,0,0,0,0,0,0,0),(48,0,0,0,0,0,0,0,0,0,0,0,0),(49,0,0,0,0,0,0,0,0,0,0,0,0),(50,0,0,0,0,0,0,0,0,0,0,0,0),(51,0,0,0,0,0,0,0,0,0,0,0,0),(52,0,0,0,0,0,0,0,0,0,0,0,0),(53,0,0,0,0,0,0,0,0,0,0,0,0),(54,0,0,0,0,0,0,0,0,0,0,0,0),(55,0,0,0,0,0,0,0,0,0,0,0,0),(56,0,0,0,0,0,0,0,0,0,0,0,0),(57,0,0,0,0,0,0,0,0,0,0,0,0),(58,0,0,0,0,0,0,0,0,0,0,0,0),(59,0,0,0,0,0,0,0,0,0,0,0,0),(60,0,0,0,0,0,0,0,0,0,0,0,0),(61,0,0,0,0,0,0,0,0,0,0,0,0),(62,0,0,0,0,0,0,0,0,0,0,0,0),(63,0,0,0,0,0,0,0,0,0,0,0,0),(64,0,0,0,0,0,0,0,0,0,0,0,0),(65,0,0,0,0,0,0,0,0,0,0,0,0),(66,0,0,0,0,0,0,0,0,0,0,0,0),(67,0,0,0,0,0,0,0,0,0,0,0,0),(68,0,0,0,0,0,0,0,0,0,0,0,0),(69,0,0,0,0,0,0,0,0,0,0,0,0),(70,0,0,0,0,0,0,0,0,0,0,0,0),(71,0,0,0,0,0,0,0,0,0,0,0,0),(72,0,0,0,0,0,0,0,0,0,0,0,0),(73,0,0,0,0,0,0,0,0,0,0,0,0),(74,0,0,0,0,0,0,0,0,0,0,0,0),(75,0,0,0,0,0,0,0,0,0,0,0,0),(76,0,0,0,0,0,0,0,0,0,0,0,0),(77,0,0,0,0,0,0,0,0,0,0,0,0),(78,0,0,0,0,0,0,0,0,0,0,0,0),(79,0,0,0,0,0,0,0,0,0,0,0,0),(80,0,0,0,0,0,0,0,0,0,0,0,0),(81,0,0,0,0,0,0,0,0,0,0,0,0),(82,0,0,0,0,0,0,0,0,0,0,0,0),(83,0,0,0,0,0,0,0,0,0,0,0,0),(84,0,0,0,0,0,0,0,0,0,0,0,0),(85,0,0,0,0,0,0,0,0,0,0,0,0),(86,0,0,0,0,0,0,0,0,0,0,0,0),(87,0,0,0,0,0,0,0,0,0,0,0,0),(88,0,0,0,0,0,0,0,0,0,0,0,0),(89,0,0,0,0,0,0,0,0,0,0,0,0),(90,0,0,0,0,0,0,0,0,0,0,0,0),(91,0,0,0,0,0,0,0,0,0,0,0,0),(92,0,0,0,0,0,0,0,0,0,0,0,0),(93,0,0,0,0,0,0,0,0,0,0,0,0),(94,0,0,0,0,0,0,0,0,0,0,0,0),(95,0,0,0,0,0,0,0,0,0,0,0,0),(96,0,0,0,0,0,0,0,0,0,0,0,0),(97,0,0,0,0,0,0,0,0,0,0,0,0),(98,0,0,0,0,0,0,0,0,0,0,0,0),(99,0,0,0,0,0,0,0,0,0,0,0,0),(100,0,0,0,0,0,0,0,0,0,0,0,0),(101,0,0,0,0,0,0,0,0,0,0,0,0),(102,0,0,0,0,0,0,0,0,0,0,0,0),(103,0,0,0,0,0,0,0,0,0,0,0,0),(104,0,0,0,0,0,0,0,0,0,0,0,0),(105,0,0,0,0,0,0,0,0,0,0,0,0),(106,0,0,0,0,0,0,0,0,0,0,0,0),(107,0,0,0,0,0,0,0,0,0,0,0,0),(108,0,0,0,0,0,0,0,0,0,0,0,0),(109,0,0,0,0,0,0,0,0,0,0,0,0),(110,0,0,0,0,0,0,0,0,0,0,0,0),(111,0,0,0,0,0,0,0,0,0,0,0,0),(112,0,0,0,0,0,0,0,0,0,0,0,0),(113,0,0,0,0,0,0,0,0,0,0,0,0),(114,0,0,0,0,0,0,0,0,0,0,0,0),(115,0,0,0,0,0,0,0,0,0,0,0,0),(116,0,0,0,0,0,0,0,0,0,0,0,0),(117,0,0,0,0,0,0,0,0,0,0,0,0),(118,0,0,0,0,0,0,0,0,0,0,0,0),(119,0,0,0,0,0,0,0,0,0,0,0,0),(120,0,0,0,0,0,0,0,0,0,0,0,0),(121,0,0,0,0,0,0,0,0,0,0,0,0),(122,0,0,0,0,0,0,0,0,0,0,0,0),(123,0,0,0,0,0,0,0,0,0,0,0,0),(124,0,0,0,0,0,0,0,0,0,0,0,0),(125,0,0,0,0,0,0,0,0,0,0,0,0),(126,0,0,0,0,0,0,0,0,0,0,0,0),(127,0,0,0,0,0,0,0,0,0,0,0,0),(128,0,0,0,0,0,0,0,0,0,0,0,0),(129,0,0,0,0,0,0,0,0,0,0,0,0),(130,0,0,0,0,0,0,0,0,0,0,0,0),(131,0,0,0,0,0,0,0,0,0,0,0,0),(132,0,0,0,0,0,0,0,0,0,0,0,0),(133,0,0,0,0,0,0,0,0,0,0,0,0),(134,0,0,0,0,0,0,0,0,0,0,0,0),(135,0,0,0,0,0,0,0,0,0,0,0,0),(136,0,0,0,0,0,0,0,0,0,0,0,0),(137,0,0,0,0,0,0,0,0,0,0,0,0),(138,0,0,0,0,0,0,0,0,0,0,0,0),(139,0,0,0,0,0,0,0,0,0,0,0,0),(140,0,0,0,0,0,0,0,0,0,0,0,0),(141,0,0,0,0,0,0,0,0,0,0,0,0),(142,0,0,0,0,0,0,0,0,0,0,0,0),(143,0,0,0,0,0,0,0,0,0,0,0,0),(144,0,0,0,0,0,0,0,0,0,0,0,0),(145,0,0,0,0,0,0,0,0,0,0,0,0),(146,0,0,0,0,0,0,0,0,0,0,0,0),(147,0,0,0,0,0,0,0,0,0,0,0,0),(148,0,0,0,0,0,0,0,0,0,0,0,0),(149,0,0,0,0,0,0,0,0,0,0,0,0),(150,0,0,0,0,0,0,0,0,0,0,0,0),(151,0,0,0,0,0,0,0,0,0,0,0,0),(152,0,0,0,0,0,0,0,0,0,0,0,0),(153,0,0,0,0,0,0,0,0,0,0,0,0),(154,0,0,0,0,0,0,0,0,0,0,0,0),(155,0,0,0,0,0,0,0,0,0,0,0,0),(156,0,0,0,0,0,0,0,0,0,0,0,0),(157,0,0,0,0,0,0,0,0,0,0,0,0),(158,0,0,0,0,0,0,0,0,0,0,0,0),(159,0,0,0,0,0,0,0,0,0,0,0,0),(160,0,0,0,0,0,0,0,0,0,0,0,0),(161,0,0,0,0,0,0,0,0,0,0,0,0),(162,0,0,0,0,0,0,0,0,0,0,0,0),(163,0,0,0,0,0,0,0,0,0,0,0,0),(164,0,0,0,0,0,0,0,0,0,0,0,0),(165,0,0,0,0,0,0,0,0,0,0,0,0),(166,0,0,0,0,0,0,0,0,0,0,0,0),(167,0,0,0,0,0,0,0,0,0,0,0,0),(168,0,0,0,0,0,0,0,0,0,0,0,0),(169,0,0,0,0,0,0,0,0,0,0,0,0),(170,0,0,0,0,0,0,0,0,0,0,0,0),(171,0,0,0,0,0,0,0,0,0,0,0,0),(172,0,0,0,0,0,0,0,0,0,0,0,0),(173,0,0,0,0,0,0,0,0,0,0,0,0),(174,0,0,0,0,0,0,0,0,0,0,0,0),(175,0,0,0,0,0,0,0,0,0,0,0,0),(176,0,0,0,0,0,0,0,0,0,0,0,0),(177,0,0,0,0,0,0,0,0,0,0,0,0),(178,0,0,0,0,0,0,0,0,0,0,0,0),(179,0,0,0,0,0,0,0,0,0,0,0,0),(180,0,0,0,0,0,0,0,0,0,0,0,0),(181,5,4,6,6,6,3,5,6,2,3,1,4),(182,1,1,1,1,6,6,6,5,3,3,4,4),(183,2,1,4,3,5,3,5,5,5,2,1,4),(184,5,2,6,1,3,6,3,1,2,3,5,6),(185,2,6,4,1,5,3,5,1,1,2,6,4),(186,5,2,5,6,4,4,3,1,3,5,5,2),(187,4,2,5,2,4,6,5,5,1,1,2,2),(188,2,6,3,5,2,4,1,6,3,4,3,1),(189,4,2,6,6,4,4,5,2,2,3,3,1),(190,2,3,5,4,5,4,4,4,5,5,2,3),(191,6,6,6,6,5,5,4,5,2,1,4,5),(192,6,2,4,4,1,4,4,3,4,2,4,3),(193,5,2,2,4,2,3,6,2,5,2,5,1),(194,2,5,5,3,1,2,4,6,3,4,4,2),(195,3,2,2,5,4,6,5,2,4,3,1,1),(196,3,3,6,3,3,1,1,1,3,6,1,1),(197,5,4,2,4,3,3,5,3,1,1,5,5),(198,2,2,2,6,2,6,1,3,2,1,1,2),(199,4,1,5,3,5,6,5,6,5,4,5,5),(200,4,5,2,3,6,1,3,6,3,6,2,5),(201,6,6,2,3,5,2,2,5,6,2,5,4),(202,1,5,3,5,1,4,6,2,3,3,6,4),(203,3,4,5,6,3,3,2,1,2,4,2,4),(204,4,1,3,6,3,2,6,1,5,1,2,2),(205,4,3,6,4,2,5,6,3,3,1,2,6),(206,3,6,3,4,3,6,2,6,3,1,2,2),(207,6,5,6,3,1,2,3,3,1,3,3,5);
/*!40000 ALTER TABLE `secretsequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-31  9:45:34
