-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: bookclub
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

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
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `edition` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pub_year` year(4) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_article.png',
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `articles_user_id_foreign` (`user_id`),
  CONSTRAINT `articles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Voluptas laborum dolorem corrupti magni.','Necessitatibus cum nobis neque. Veniam minus facere nisi minus doloremque ut qui enim. Nihil quas facilis ea veniam rerum. Accusantium incidunt tenetur autem asperiores porro aut animi et.','Jacky Hegmann','policier','Eaque alias.',1990,'default_article.png',2,'2020-08-11 12:32:24','2020-08-11 12:32:24'),(2,'Non et optio numquam sequi.','Officiis atque eos enim quas dicta. Est quae ipsa nihil consequatur alias eius dolores aut. Iusto vero sequi sit deserunt magni. Nihil eligendi iusto est dolore sit nam.','Mrs. Naomie Ebert PhD','policier','Eaque rerum aut.',1990,'default_article.png',3,'2020-08-11 12:32:30','2020-08-11 12:32:30'),(3,'Ne le dit à personne','Pédiatre, David Beck exerce dans une clinique pour le compte de Medicaid, structure sociale qui prend en charge les pauvres sans couverture sociale. Il aime son métier et l\'exerce avec passion. Mais sa vie a été brisée lorsque son épouse, Elizabeth, qu\'il connaissait depuis l\'enfance, fut assassinée par un tueur sadique qui marquait ses victimes au fer rouge.\nHuit  ans après ce drame, il reçoit un étrange e-mail codé dont la clé n\'était connue que de lui-même et d\'Elizabeth. Abasourdi, David essaie de se souvenir des détails qui entourèrent l\'assassinat de sa femme, dont le propre père, officier de police, identifia formellement le corps. Impatient, il guette le prochain message qui lui donne rendez-vous le lendemain.\nEn cliquant sur un lien hypertexte, il découvre alors le site d\'une caméra de surveillance de rue et dans la foule, il voit, stupéfait, passer Elizabeth qui le regarde en articulant \"Pardon, je t\'aime...\"','Harlan Coben','thriller','Pocket',2012,'1xun3Hth.jpg',1,'2020-08-12 08:42:58','2020-08-12 08:42:58');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `article_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_book.png',
  `available` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `books_user_id_foreign` (`user_id`),
  KEY `books_article_id_foreign` (`article_id`),
  CONSTRAINT `books_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Quae qui eos nobis molestiae.','Ms. Amara Gerhold Sr.','Id accusantium deserunt officia. Velit et sit harum corrupti.','roman',3,1,'default_book.png',1,'2020-08-11 12:40:08','2020-08-11 12:40:08'),(2,'Et ducimus corrupti voluptas.','Baylee Prosacco','A ea esse qui nisi. Dolorem debitis minima autem qui aspernatur.','jeunesse',3,1,'default_book.png',1,'2020-08-11 12:40:18','2020-08-11 12:40:18'),(3,'mon livre à donner','mrX','description du livre à donner','education',1,0,'default_book.png',1,NULL,NULL),(4,'bla','bla','description 2 du livre à donner','education',2,0,'SWfz9eAm.png',1,'2020-08-12 11:01:28','2020-08-12 11:01:28'),(5,'test','test','description test','vie quotidienne',2,0,'WxnWaYHv.jpg',1,'2020-08-12 11:02:37','2020-08-12 11:02:37'),(6,'another test','plop','azertyuiop','roman',2,0,'fHfT93zM.png',1,'2020-08-12 11:04:54','2020-08-12 11:04:54');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_article_id_foreign` (`article_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_article_id_foreign` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Aliquid voluptas a iste qui in reprehenderit. Dolorum beatae minima non enim illo quisquam atque. Eaque animi aperiam sit et est tenetur autem. Est placeat quo qui autem hic voluptate molestiae earum.',1,2,'2020-08-11 12:32:51','2020-08-11 12:32:51'),(2,'Reiciendis perferendis repudiandae fugiat quis facere quia eos. Cum quo possimus veritatis sit ducimus. Id natus adipisci dignissimos consectetur voluptatibus. Consectetur laudantium labore quod.',1,1,'2020-08-11 12:33:02','2020-08-11 12:33:02');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2016_06_01_000001_create_oauth_auth_codes_table',1),(3,'2016_06_01_000002_create_oauth_access_tokens_table',1),(4,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(5,'2016_06_01_000004_create_oauth_clients_table',1),(6,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(7,'2019_08_19_000000_create_failed_jobs_table',1),(8,'2020_08_04_192827_create_articles_table',1),(9,'2020_08_04_193756_create_comment_table',1),(10,'2020_08_04_194403_create_books_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('683e33c46ce612b4e6ee701d813f3fe31bcd7f4cf43acbc9bfe8ca3d85d7d545121a2800ae2a33b0',2,2,NULL,'[]',0,'2020-08-12 09:14:15','2020-08-12 09:14:15','2021-08-12 11:14:15');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES (1,NULL,'Laravel Personal Access Client','3pvP882SD8NwXRMgzRiKTvZHhbJ1E15hfq2wD4AN',NULL,'http://localhost',1,0,0,'2020-08-11 12:14:00','2020-08-11 12:14:00'),(2,NULL,'Laravel Password Grant Client','orCjoEuPPtYje8BHndDaNxIJsfw5z0hL48BrqOHv','users','http://localhost',0,1,0,'2020-08-11 12:14:00','2020-08-11 12:14:00');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` VALUES (1,1,'2020-08-11 12:14:00','2020-08-11 12:14:00');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` VALUES ('442dd3569ca44eb62d7036ea9e861e8ccb64f871cd491dfaba0b55ec0973f46d7a7925b63bf9be9a','1a40ede0c5530b119ec67977662a0931995f9bb90d637fdc791566161b6b1af2a7357903f8f17723',0,'2021-08-12 10:27:44'),('4614c48608851ebf6eee41c2360bd576649c770ebe892742a73365340bd061101b800c79b23f9b6c','04b77625a1ff602e714f1bff13dcd62393ceb7de2250502386ba9f8bd26bd5c6cc469207e8c75afd',0,'2021-08-12 10:40:56'),('463a3e5bbd1b4c371a7836860bb8fc196ab8b9032de969d5fdfa49d2d761f8d560e73f1e7f485959','687cc7fb2e1740b500d183018dcf5fd2568c30ca2d068182fba501cdc3796ec1af82f069c50b58ab',0,'2021-08-12 10:34:56'),('522ad261e5a758a498c458bccb16824b05cb78232ebeb4b07f47e8ae09de646bd1b6100f16cf0a4a','4d4822a1de29e2a917314b11e95049da7dedb784aa6dbbb416c460c4d4af4bc0fd9d02f08b175ae5',0,'2021-08-12 10:21:30'),('5db50892547ceeefd476391d767f118d168b92deff4e79fab38627d9de2ec019e5eb6ed058aded01','d7129afff1c6362cff83f84bdca47c81dbdee1422616b82636addeda6fd37c57ed9a1fd559d4cf48',0,'2021-08-12 10:31:00'),('724d4695de6a590652b137f3550b433893fb8deb7f5447f416b6a790c0bc45e42867e78814a34032','7b4aaa8aae8b22be8c69a44c31bbdfbda63a2182a6298cd514d01773aae1190b442946fc2f55dc5d',0,'2021-08-12 09:19:05'),('7d350dc8c399c47dbe0742ba5d543f1a019a36a54c6d2239d556e9d12ed7fd5f18902045e641e3ae','4c091a40a697123f3a7a1eae7c3bed62dc8a7113b1eed4b036af0183ee7244e7c1bc8eb6296c9f69',0,'2021-08-11 14:25:21'),('81ae1a9f4a740b29d31d64eba2fc190961599cea634c380295a9d64249095a45c40938dc152b4f7e','a0ce95ad24164c6a4dcb22696c26d0202b31c749c8f8ce8f6e3e5508e3a1a2c92f24c70b17d542e8',0,'2021-08-12 10:14:06'),('9c9f2bb321ca5fc9dac81a8d4891f90ee7049e54a5c54bfd68e7ddfa7e34e7b389caa911c3a2e4ac','59fe0732d0dd329b7edd50bb63f901671bcec29292bcbb0b06171bf42384834867c7a7ce32ec898d',0,'2021-08-12 11:11:56'),('bac34cd5837bb6a0e150639e8d8ff6c320579aa0fb3a79b392b91446a32cf06a90f6a6027256bf83','8040e9453e5095796790021cae72508d9a06a8ced41a1076f605f8a676288ca2e90f9e098cd47d42',0,'2021-08-12 10:17:41'),('be982f21944fe363ce995036792e0026d2dc0a8d471f01ca97039255da14578cbd4f2639a5f674e8','683e33c46ce612b4e6ee701d813f3fe31bcd7f4cf43acbc9bfe8ca3d85d7d545121a2800ae2a33b0',0,'2021-08-12 11:14:15'),('e26988347ae7cd08dd38bf8d280824304d804de9189d32bb786ecf0e7c4654fdf6b7bece1fb55324','b4b64dd0a963a49750a17e86c14b3c63b55727abcd2e91f238c6af65992fb9149ae5cf62566ddb5e',0,'2021-08-12 10:33:05');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_avatar.png',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_name_unique` (`name`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Faty','faty@faty.com','$2y$10$S8XpXsaRgfHKKrA5x.L20u72MUzZ6BvCFMeck/AyDkeD7dVJLGK7m','default_avatar.png',0,NULL,'2020-08-11 12:15:18','2020-08-11 12:15:18'),(2,'Josiah Boyer','arne.langosh@example.net','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','default_avatar.png',0,'EJwrIxEviw','2020-08-11 12:32:09','2020-08-11 12:32:09'),(3,'Melba Breitenberg','cmuller@example.net','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','default_avatar.png',0,'Mfc0evOUqi','2020-08-11 12:32:15','2020-08-11 12:32:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-12 15:46:48
