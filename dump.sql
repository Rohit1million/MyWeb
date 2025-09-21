/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: rohit_portfolio_db
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `rohit_portfolio_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `rohit_portfolio_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `rohit_portfolio_db`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add blog posts',7,'add_blogposts'),
(26,'Can change blog posts',7,'change_blogposts'),
(27,'Can delete blog posts',7,'delete_blogposts'),
(28,'Can view blog posts',7,'view_blogposts'),
(29,'Can add certifications',8,'add_certifications'),
(30,'Can change certifications',8,'change_certifications'),
(31,'Can delete certifications',8,'delete_certifications'),
(32,'Can view certifications',8,'view_certifications'),
(33,'Can add contacts',9,'add_contacts'),
(34,'Can change contacts',9,'change_contacts'),
(35,'Can delete contacts',9,'delete_contacts'),
(36,'Can view contacts',9,'view_contacts'),
(37,'Can add education',10,'add_education'),
(38,'Can change education',10,'change_education'),
(39,'Can delete education',10,'delete_education'),
(40,'Can view education',10,'view_education'),
(41,'Can add experience',11,'add_experience'),
(42,'Can change experience',11,'change_experience'),
(43,'Can delete experience',11,'delete_experience'),
(44,'Can view experience',11,'view_experience'),
(45,'Can add personal info',12,'add_personalinfo'),
(46,'Can change personal info',12,'change_personalinfo'),
(47,'Can delete personal info',12,'delete_personalinfo'),
(48,'Can view personal info',12,'view_personalinfo'),
(49,'Can add project categories',13,'add_projectcategories'),
(50,'Can change project categories',13,'change_projectcategories'),
(51,'Can delete project categories',13,'delete_projectcategories'),
(52,'Can view project categories',13,'view_projectcategories'),
(53,'Can add project images',14,'add_projectimages'),
(54,'Can change project images',14,'change_projectimages'),
(55,'Can delete project images',14,'delete_projectimages'),
(56,'Can view project images',14,'view_projectimages'),
(57,'Can add projects',15,'add_projects'),
(58,'Can change projects',15,'change_projects'),
(59,'Can delete projects',15,'delete_projects'),
(60,'Can view projects',15,'view_projects'),
(61,'Can add quick info',16,'add_quickinfo'),
(62,'Can change quick info',16,'change_quickinfo'),
(63,'Can delete quick info',16,'delete_quickinfo'),
(64,'Can view quick info',16,'view_quickinfo'),
(65,'Can add site settings',17,'add_sitesettings'),
(66,'Can change site settings',17,'change_sitesettings'),
(67,'Can delete site settings',17,'delete_sitesettings'),
(68,'Can view site settings',17,'view_sitesettings'),
(69,'Can add skill categories',18,'add_skillcategories'),
(70,'Can change skill categories',18,'change_skillcategories'),
(71,'Can delete skill categories',18,'delete_skillcategories'),
(72,'Can view skill categories',18,'view_skillcategories'),
(73,'Can add skills',19,'add_skills'),
(74,'Can change skills',19,'change_skills'),
(75,'Can delete skills',19,'delete_skills'),
(76,'Can view skills',19,'view_skills');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$1000000$Snc14FfIniBTlzHmi5seAP$AlUhNSx++Pl0n9bC2vPp1WwOOnjnmRGyNdl+6rRQzEo=','2025-09-14 03:53:59.539748',1,'Rohit1million','','','rohit.shrestha314@gmail.com',1,1,'2025-09-07 00:53:44.609210');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_posts`
--

DROP TABLE IF EXISTS `blog_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `featured_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci DEFAULT 'draft',
  `tags` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `views` int DEFAULT '0',
  `featured` tinyint(1) DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_blog_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_posts`
--

LOCK TABLES `blog_posts` WRITE;
/*!40000 ALTER TABLE `blog_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certifications`
--

DROP TABLE IF EXISTS `certifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `certifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('certification','course','award','achievement','license') COLLATE utf8mb4_unicode_ci DEFAULT 'certification',
  `issuing_organization` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue_date` date NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `credential_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credential_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `skills_gained` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certificate_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certifications`
--

LOCK TABLES `certifications` WRITE;
/*!40000 ALTER TABLE `certifications` DISABLE KEYS */;
INSERT INTO `certifications` VALUES
(1,'Microsoft Excel Advanced','microsoft-excel-advanced','course','Coursera','2024-01-15',NULL,NULL,NULL,'Advanced Excel skills including Power Query, complex formulas, and data analysis techniques.',NULL,NULL,1,'2025-09-05 03:49:19'),
(2,'Data Modelling with Power BI','power-bi-data-modelling','course','Coursera','2024-03-20',NULL,NULL,NULL,'Comprehensive training in Power BI for business intelligence and data visualization.',NULL,NULL,1,'2025-09-05 03:49:19'),
(3,'Creating Django Views and Models','django-views-models','course','Skillsoft','2024-06-10',NULL,NULL,NULL,'Specialized training in Django framework development focusing on views and models.',NULL,NULL,1,'2025-09-05 03:49:19'),
(4,'Learning Django using Generative AI Help','django-generative-ai','course','Skillsoft','2024-06-15',NULL,NULL,NULL,'Modern approach to learning Django with AI assistance and best practices.',NULL,NULL,1,'2025-09-05 03:49:19');
/*!40000 ALTER TABLE `certifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `is_replied` tinyint(1) DEFAULT '0',
  `reply_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `replied_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contacts_read` (`is_read`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES
(17,'Ashish Shrestha','shresthaashish9811@gmail.com','Contact from Ashish Shrestha','Hello how are you.',NULL,NULL,0,0,NULL,'2025-09-17 18:02:15',NULL),
(18,'Ashish Shrestha','rohit.shrestha314@gmail.com','Contact from Ashish Shrestha','Hello',NULL,NULL,0,0,NULL,'2025-09-18 22:20:45',NULL);
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(7,'portfolio','blogposts'),
(8,'portfolio','certifications'),
(9,'portfolio','contacts'),
(10,'portfolio','education'),
(11,'portfolio','experience'),
(12,'portfolio','personalinfo'),
(13,'portfolio','projectcategories'),
(14,'portfolio','projectimages'),
(15,'portfolio','projects'),
(16,'portfolio','quickinfo'),
(17,'portfolio','sitesettings'),
(18,'portfolio','skillcategories'),
(19,'portfolio','skills'),
(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-09-05 07:46:26.292344'),
(2,'auth','0001_initial','2025-09-05 07:46:27.418835'),
(3,'admin','0001_initial','2025-09-05 07:46:27.557946'),
(4,'admin','0002_logentry_remove_auto_add','2025-09-05 07:46:27.563151'),
(5,'admin','0003_logentry_add_action_flag_choices','2025-09-05 07:46:27.569139'),
(6,'contenttypes','0002_remove_content_type_name','2025-09-05 07:46:27.652610'),
(7,'auth','0002_alter_permission_name_max_length','2025-09-05 07:46:27.698156'),
(8,'auth','0003_alter_user_email_max_length','2025-09-05 07:46:27.713263'),
(9,'auth','0004_alter_user_username_opts','2025-09-05 07:46:27.718559'),
(10,'auth','0005_alter_user_last_login_null','2025-09-05 07:46:27.760124'),
(11,'auth','0006_require_contenttypes_0002','2025-09-05 07:46:27.762749'),
(12,'auth','0007_alter_validators_add_error_messages','2025-09-05 07:46:27.767584'),
(13,'auth','0008_alter_user_username_max_length','2025-09-05 07:46:27.812350'),
(14,'auth','0009_alter_user_last_name_max_length','2025-09-05 07:46:27.862321'),
(15,'auth','0010_alter_group_name_max_length','2025-09-05 07:46:27.876326'),
(16,'auth','0011_update_proxy_permissions','2025-09-05 07:46:27.882330'),
(17,'auth','0012_alter_user_first_name_max_length','2025-09-05 07:46:27.930009'),
(18,'sessions','0001_initial','2025-09-05 07:46:27.955842'),
(19,'portfolio','0001_initial','2025-09-05 07:46:28.925841');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES
('88v0njkiex07lybnr2092uai2rpwt4hv','e30:1uv4gE:S6l7_eCF9t1sg2m15BEOzRFGoB2G3Pllsm_w8BH-O6I','2025-09-21 01:58:58.815660'),
('bp4vfu6rufq6qfw4dnu3n7g8zq8sgp9c','e30:1uv4c5:eQ-WXqweYJS6F73CNL8HrSOQdH6qOMCJr32ZNnN6xWM','2025-09-21 01:54:41.844992'),
('k8r7sel7aga6jppxqa0jyzchl77lfhzb','.eJxVjDsOwjAQBe_iGln-xJ9Q0ucMlr27xgFkS3FSIe5OIqWA9s28ebMQt7WErdMSZmRXJtnld0sRnlQPgI9Y741Dq-syJ34o_KSdTw3pdTvdv0CJvexvAjsagWocFDo0OVutvFMpk7HkBm1NSuitUTITeQINZo9TFCqRFBrY5wvsRjiV:1uvnzi:s_uh1fcq9N80lpu4MEmw2wr1qy_RjjzjhmkJ5h-Fiwg','2025-09-23 02:22:06.973082'),
('kvr8ptfmb1ayqxn3te3abipcjtscvf8a','e30:1uv4VG:UnHKv8Vy1tqnhK6ZgHxk4qh2IHkeeSGxfd8JTwWogKY','2025-09-21 01:47:38.576570'),
('tl6xpm0j16k48bkqcbecm1htg8h8ci7b','e30:1uv4m3:D6iR6Z2Zn1J1fBw6qEasyxmdJnLq8n8uJJkBCrHP4KE','2025-09-21 02:04:59.543883'),
('y59azek54v0xl2hbwh8ztlukew9nq2oa','e30:1uv52e:cOUUzyuBwF3DdQFibwrPXr14i3zGY1N28bBwcfVhhuM','2025-09-21 02:22:08.008377');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `degree_type` enum('bachelor','master','diploma','certificate','professional','bootcamp') COLLATE utf8mb4_unicode_ci NOT NULL,
  `degree_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `currently_studying` tinyint(1) DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `relevant_coursework` text COLLATE utf8mb4_unicode_ci,
  `grade` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `achievements` text COLLATE utf8mb4_unicode_ci,
  `institution_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `featured` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_education_featured` (`featured`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES
(1,'bachelor','Bachelor of Business Information Systems','Canterbury Institute of Management','Darwin, NT','2021-01-01','2024-05-01',0,'Comprehensive study of business information systems with focus on technology solutions for business problems.','Data Analytics, Database Architecture, Programming (MySQL, Java)',NULL,NULL,NULL,0,1,'2025-09-05 03:49:19'),
(2,'professional','Professional Year in Business Communications','National Institute of Technology','Australia','2024-09-01','2025-09-01',0,'Professional development program focusing on business communication skills and Australian workplace practices.','Business Communication, Professional Development, Workplace Skills',NULL,NULL,NULL,0,1,'2025-09-05 03:49:19');
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experience`
--

DROP TABLE IF EXISTS `experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_type` enum('full_time','part_time','internship','contract','volunteer','freelance') COLLATE utf8mb4_unicode_ci DEFAULT 'full_time',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `currently_working` tinyint(1) DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `key_achievements` text COLLATE utf8mb4_unicode_ci,
  `responsibilities` text COLLATE utf8mb4_unicode_ci,
  `technologies_used` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `featured` tinyint(1) DEFAULT '0',
  `show_on_resume` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_experience_featured` (`featured`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

LOCK TABLES `experience` WRITE;
/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience` VALUES
(1,'Research Assistant','Charles Darwin University',NULL,'Darwin, NT','internship','2025-07-01','2025-09-01',0,'Developed and maintained web applications using Django, Python, and MySQL with focus on Indigenous language preservation.',NULL,'Developed and maintained web applications using Django, Python, and MySQL with database integration and user authentication systems\nConverted legacy codebase to modern framework architecture, improving system performance, maintainability, and code optimization\nBuilt educational platforms supporting Indigenous language preservation with multimedia content delivery and interactive features\nUtilized DBMS tools and version control (Git) for efficient project management while debugging and optimizing web application modules\nCollaborated with faculty on research-driven, data-centric solutions for Indigenous knowledge system projects and IT integration','Django, Python, MySQL, Git, HTML5, CSS, JavaScript',NULL,0,1,1,'2025-09-05 03:49:19','2025-09-21 03:32:26'),
(2,'Table Games Dealer','Mindil Beach Casino Resort',NULL,'Darwin, NT','part_time','2025-03-01',NULL,1,'Performing real-time calculations and providing exceptional customer service in a fast-paced casino environment.',NULL,'Performing real-time mental arithmetic to calculate bets, payouts, and odds quickly and accurately\nProviding exceptional customer service, engaging with players, explaining game rules, and maintaining a welcoming and professional environment\nDeveloping faster and more efficient mental techniques to calculate payouts, improving game flow, and reducing dealer processing time\nEnsure compliance with all legal, regulatory, and industry standards to maintain operational integrity','Mental Mathematics, Customer Service, Compliance',NULL,0,1,1,'2025-09-05 03:49:19','2025-09-06 03:52:57');
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_info`
--

DROP TABLE IF EXISTS `personal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Rohit Raj Shrestha',
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'IT Professional & Django Developer',
  `tagline` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hero_background` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `introduction` text COLLATE utf8mb4_unicode_ci,
  `about_me` text COLLATE utf8mb4_unicode_ci,
  `mission_statement` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'rohit.shrestha314@gmail.com',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '0452354362',
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'Bayview, NT 0820',
  `linkedin` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'https://www.linkedin.com/in/rohit-shrestha-603a862b3',
  `github` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resume_file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_maintenance` tinyint(1) DEFAULT '0',
  `allow_contact_form` tinyint(1) DEFAULT '1',
  `show_resume_download` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_info`
--

LOCK TABLES `personal_info` WRITE;
/*!40000 ALTER TABLE `personal_info` DISABLE KEYS */;
INSERT INTO `personal_info` VALUES
(1,'Rohit Raj Shrestha','Designer X Developer','Designer and developer blending creativity with technology. Skilled in building modern web experiences with Python, Django, and MySQL, and driven by a passion for clean design and user-focused solutions.',NULL,NULL,'Designer and developer blending creativity with technology. Skilled in building modern web experiences with Python, Django, and MySQL, and driven by a passion for clean design and user-focused solutions.','I have a proven ability to resolve hardware and software issues, configure IT systems, and deliver exceptional customer service. Known for my strong communication skills, ability to work independently, and eagerness to learn new technologies.',NULL,'rohit.shrestha314@gmail.com','0452354362',' Bayview, Darwin NT 0820','https://www.linkedin.com/in/rohit-shrestha-603a862b3','https://github.com/',NULL,'https://www.instagram.com/','',NULL,NULL,NULL,0,1,1,'2025-09-05 03:49:19','2025-09-18 02:51:03');
/*!40000 ALTER TABLE `personal_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_categories`
--

DROP TABLE IF EXISTS `project_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT '#007bff',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_categories`
--

LOCK TABLES `project_categories` WRITE;
/*!40000 ALTER TABLE `project_categories` DISABLE KEYS */;
INSERT INTO `project_categories` VALUES
(1,'Web Applications','web-applications','Full-stack web development projects','#007bff','fas fa-globe',1,'2025-09-05 03:49:19'),
(2,'Project MyWeb','Web-applications2',NULL,'#007bff',NULL,1,'2025-09-04 14:30:00');
/*!40000 ALTER TABLE `project_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_images`
--

DROP TABLE IF EXISTS `project_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_images_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_images`
--

LOCK TABLES `project_images` WRITE;
/*!40000 ALTER TABLE `project_images` DISABLE KEYS */;
INSERT INTO `project_images` VALUES
(1,1,'portfolio\\static\\images\\icons\\image.png',NULL,0,'2025-09-18 06:09:30');
/*!40000 ALTER TABLE `project_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int NOT NULL,
  `project_type` enum('web_app','mobile_app','data_analysis','ai_ml','academic','hackathon','open_source','client_work') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('completed','in_progress','planning','on_hold') COLLATE utf8mb4_unicode_ci DEFAULT 'completed',
  `short_description` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detailed_description` text COLLATE utf8mb4_unicode_ci,
  `problem_statement` text COLLATE utf8mb4_unicode_ci,
  `solution_approach` text COLLATE utf8mb4_unicode_ci,
  `challenges_faced` text COLLATE utf8mb4_unicode_ci,
  `outcome_results` text COLLATE utf8mb4_unicode_ci,
  `lessons_learned` text COLLATE utf8mb4_unicode_ci,
  `featured_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tools_used` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_demo_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `case_study_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documentation_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `duration_weeks` int DEFAULT NULL,
  `team_size` int DEFAULT '1',
  `role_in_project` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collaborators` text COLLATE utf8mb4_unicode_ci,
  `featured` tinyint(1) DEFAULT '0',
  `published` tinyint(1) DEFAULT '1',
  `display_order` int DEFAULT '0',
  `views` int DEFAULT '0',
  `github_stars` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `technologies` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_projects_category` (`category_id`),
  KEY `idx_projects_featured` (`featured`),
  KEY `idx_projects_published` (`published`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `project_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES
(1,'Bundjalung Web Application','bundjalung-web-application',1,'web_app','completed','Django-based web application for Indigenous language preservation with multimedia content and user authentication.','A comprehensive web application built with Django to preserve and share Indigenous language content. Features include audio archives, transcript editing, and role-based authentication.','The existing Web2py application needed modernization to Django framework while preserving valuable language data and audio archives.','Migrated legacy Web2py application to Django, implemented modern authentication systems, built transcript editors with HTML5 audio integration, and created responsive templates.',NULL,'Successfully migrated all language data, implemented role-based authentication, created intuitive transcript editor, and developed wiki-style CMS with version control.',NULL,NULL,NULL,'https://github.com/ckutay/BundjalungDrupal',NULL,NULL,NULL,'2025-07-01','2025-09-01',NULL,1,'Django Developer',NULL,1,1,0,2,0,'2025-09-05 03:49:19','2025-09-17 14:05:17',NULL),
(3,'Project MyWeb','MyWeb-application',2,'web_app','in_progress','Developing my own Django-based website allows me to create a fully customizable, dynamic web application with a powerful backend, database integration, and user-friendly frontend.','Web_app','Web_app','Web_app',NULL,'Web_app',NULL,NULL,NULL,'https://github.com/Rohit1million/MyWeb',NULL,NULL,NULL,'2025-09-18',NULL,NULL,1,NULL,NULL,1,1,1,0,0,'2025-09-18 03:59:56','2025-09-18 04:01:07',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings`
--

DROP TABLE IF EXISTS `site_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `site_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'Rohit''s Portfolio',
  `site_tagline` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT 'IT Professional & Django Developer',
  `primary_color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT '#007bff',
  `secondary_color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT '#6c757d',
  `accent_color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT '#28a745',
  `google_analytics_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_social_links` tinyint(1) DEFAULT '1',
  `enable_blog` tinyint(1) DEFAULT '0',
  `enable_testimonials` tinyint(1) DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings`
--

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;
INSERT INTO `site_settings` VALUES
(1,'Rohit Raj Shrestha - Portfolio','IT Professional & Django Developer from Darwin, NT','#007bff','#6c757d','#28a745',NULL,'rohit.shrestha314@gmail.com','rohit.shrestha314@gmail.com',1,0,0,'2025-09-05 03:49:19');
/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill_categories`
--

DROP TABLE IF EXISTS `skill_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT '#007bff',
  `display_order` int DEFAULT '0',
  `show_on_home` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill_categories`
--

LOCK TABLES `skill_categories` WRITE;
/*!40000 ALTER TABLE `skill_categories` DISABLE KEYS */;
INSERT INTO `skill_categories` VALUES
(1,'Programming & Frameworks','programming-frameworks','Programming languages and web frameworks','fas fa-code','#007bff',1,1,'2025-09-05 03:49:19'),
(2,'Data Analysis & Visualization','data-analysis','Data analysis and business intelligence tools','fas fa-chart-bar','#28a745',2,1,'2025-09-05 03:49:19'),
(3,'Database & Tools','database-tools','Database management and development tools','fas fa-database','#ffc107',3,1,'2025-09-05 03:49:19'),
(4,'Soft Skills','soft-skills','Communication and leadership abilities','fas fa-users','#6f42c1',4,1,'2025-09-05 03:49:19');
/*!40000 ALTER TABLE `skill_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int NOT NULL,
  `proficiency` int DEFAULT '70',
  `description` text COLLATE utf8mb4_unicode_ci,
  `years_of_experience` decimal(3,1) DEFAULT NULL,
  `certification_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `certification_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `featured` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_skill_category` (`name`,`category_id`),
  KEY `idx_skills_category` (`category_id`),
  KEY `idx_skills_featured` (`featured`),
  CONSTRAINT `skills_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `skill_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `skills_chk_1` CHECK (((`proficiency` >= 0) and (`proficiency` <= 100)))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES
(1,'Python',1,50,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(2,'Django',1,80,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(3,'JavaScript',1,40,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(4,'MySQL',1,80,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(5,'HTML/CSS',1,85,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(6,'Git/GitHub',3,85,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(7,'Excel',1,90,NULL,0.0,NULL,NULL,0,1,1,'2025-09-14 03:10:53'),
(13,'VSCode',1,90,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(15,'ETL Processes',3,75,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(16,'Problem Solving',4,90,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(17,'Customer Service',4,95,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(18,'Team Collaboration',4,85,NULL,0.0,NULL,NULL,0,1,1,'2025-09-05 03:49:19'),
(19,'GenAI',1,85,NULL,NULL,NULL,NULL,0,1,1,'2025-09-14 02:56:07'),
(20,'Documentation',1,85,NULL,NULL,NULL,NULL,0,1,1,'2025-09-17 14:08:44');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'rohit_portfolio_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-21 21:36:54
