-- MySQL dump 10.13  Distrib 5.7.19, for osx10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: cryptomarker_dev
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Table structure for table `candles`
--

DROP TABLE IF EXISTS `candles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `time` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `currency_symbol` varchar(16) NOT NULL DEFAULT '',
  `currency_to` varchar(16) NOT NULL DEFAULT '',
  `open` double NOT NULL,
  `high` double NOT NULL,
  `close` double NOT NULL,
  `low` double NOT NULL,
  `volume_from` double NOT NULL,
  `volume_to` double NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `candles_currency_symbol_currency_to_time_index` (`currency_symbol`,`currency_to`,`time`),
  KEY `candles_currency_id_index` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=212801 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cryptocompare_currencies`
--

DROP TABLE IF EXISTS `cryptocompare_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cryptocompare_currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(255) NOT NULL,
  `full_snapshot` longtext,
  `social_stats` longtext,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `slug` varchar(64) NOT NULL DEFAULT '',
  `favorite` tinyint(1) NOT NULL DEFAULT '0',
  `price_usd` double NOT NULL DEFAULT '0',
  `price_btc` double NOT NULL DEFAULT '0',
  `volume_24h_usd` double NOT NULL DEFAULT '0',
  `market_cap_usd` double NOT NULL DEFAULT '0',
  `available_supply` double NOT NULL DEFAULT '0',
  `total_supply` double NOT NULL DEFAULT '0',
  `percent_change_1h` double DEFAULT '0',
  `percent_change_24h` double DEFAULT '0',
  `markets_count` int(11) NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `no_twitter` tinyint(1) NOT NULL DEFAULT '0',
  `short_summary` varchar(255) DEFAULT NULL,
  `description` text,
  `asset_parent_id` bigint(20) unsigned DEFAULT NULL,
  `completeness_score` double DEFAULT '0',
  `imported` tinyint(1) NOT NULL DEFAULT '0',
  `imported_reddit` tinyint(1) NOT NULL DEFAULT '0',
  `starts_on` date DEFAULT NULL,
  `imported_starts_on` tinyint(1) NOT NULL DEFAULT '0',
  `owner_user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currencies_slug_index` (`slug`),
  KEY `currencies_asset_parent_id_fkey` (`asset_parent_id`),
  KEY `currencies_owner_user_id_fkey` (`owner_user_id`),
  CONSTRAINT `currencies_asset_parent_id_fkey` FOREIGN KEY (`asset_parent_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `currencies_owner_user_id_fkey` FOREIGN KEY (`owner_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1148 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency_comments`
--

DROP TABLE IF EXISTS `currency_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `body` text NOT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `currency_comments_currency_id_index` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency_links`
--

DROP TABLE IF EXISTS `currency_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_links` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) NOT NULL,
  `type` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(64) DEFAULT NULL,
  `url` varchar(191) NOT NULL DEFAULT '',
  `user_id` bigint(20) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `not_found` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `currency_links_currency_id_index` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency_ratings`
--

DROP TABLE IF EXISTS `currency_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_ratings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `comment` text,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_currencies_currency_id_user_id_index` (`currency_id`,`user_id`),
  KEY `user_currencies_currency_id_index` (`currency_id`),
  KEY `user_currencies_user_id_index` (`user_id`),
  CONSTRAINT `user_currencies_currency_id_fkey` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `user_currencies_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_apis`
--

DROP TABLE IF EXISTS `exchange_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_apis` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `exchange_id` bigint(20) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `docs_url` varchar(255) DEFAULT NULL,
  `root` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `mappings` text,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `last_response` longtext,
  `currencies_url` varchar(255) DEFAULT NULL,
  `last_api_fetch_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exchange_apis_exchange_id_fkey` (`exchange_id`),
  CONSTRAINT `exchange_apis_exchange_id_fkey` FOREIGN KEY (`exchange_id`) REFERENCES `exchanges` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_currencies`
--

DROP TABLE IF EXISTS `exchange_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `exchange_id` bigint(20) unsigned NOT NULL,
  `currency_id` bigint(20) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exchange_currencies_exchange_id_currency_id_index` (`exchange_id`,`currency_id`),
  KEY `exchange_currencies_currency_id_fkey` (`currency_id`),
  CONSTRAINT `exchange_currencies_currency_id_fkey` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `exchange_currencies_exchange_id_fkey` FOREIGN KEY (`exchange_id`) REFERENCES `exchanges` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchanges`
--

DROP TABLE IF EXISTS `exchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchanges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `country` varchar(64) NOT NULL DEFAULT '',
  `website_url` varchar(255) NOT NULL,
  `api_docs_url` varchar(255) DEFAULT NULL,
  `volume_usd` double NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `api_currencies_url` varchar(255) DEFAULT NULL,
  `api_root` varchar(255) DEFAULT NULL,
  `api_type` varchar(255) DEFAULT NULL,
  `api_symbol` varchar(255) DEFAULT NULL,
  `api_active` varchar(255) DEFAULT NULL,
  `api_mappings` text,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `github_repos`
--

DROP TABLE IF EXISTS `github_repos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `github_repos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) unsigned NOT NULL,
  `full_name` varchar(96) NOT NULL DEFAULT '',
  `stars_count` int(11) NOT NULL DEFAULT '0',
  `forks_count` int(11) NOT NULL DEFAULT '0',
  `watchers_count` int(11) NOT NULL DEFAULT '0',
  `open_issues_count` int(11) NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `github_repos_full_name_index` (`full_name`),
  KEY `github_repos_currency_id_fkey` (`currency_id`),
  CONSTRAINT `github_repos_currency_id_fkey` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `content_markdown` text NOT NULL,
  `header_image` varchar(255) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_index` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating_factors`
--

DROP TABLE IF EXISTS `rating_factors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_factors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `field` varchar(64) NOT NULL DEFAULT '',
  `weight` int(11) NOT NULL DEFAULT '1',
  `weight_percent` double NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rating_factors_field_index` (`field`),
  UNIQUE KEY `rating_factors_user_id_field_index` (`user_id`,`field`),
  CONSTRAINT `rating_factors_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reddits`
--

DROP TABLE IF EXISTS `reddits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reddits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `subscribers_count` int(11) NOT NULL DEFAULT '0',
  `active_users_count` int(11) NOT NULL DEFAULT '0',
  `posts_per_hour` int(11) NOT NULL DEFAULT '0',
  `posts_per_day` int(11) NOT NULL DEFAULT '0',
  `comments_per_hour` int(11) NOT NULL DEFAULT '0',
  `comments_per_day` int(11) NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reddits_currency_id_fkey` (`currency_id`),
  CONSTRAINT `reddits_currency_id_fkey` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` bigint(20) NOT NULL,
  `inserted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_accounts`
--

DROP TABLE IF EXISTS `twitter_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `twitter_user_id` bigint(20) NOT NULL,
  `screen_name` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `following` tinyint(1) NOT NULL DEFAULT '0',
  `image_url` varchar(255) DEFAULT NULL,
  `followers_count` int(11) DEFAULT NULL,
  `tweets_count` int(11) DEFAULT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `twitter_accounts_currency_id_screen_name_index` (`currency_id`,`screen_name`),
  KEY `twitter_accounts_currency_id_index` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_statuses`
--

DROP TABLE IF EXISTS `twitter_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `screen_name` varchar(16) NOT NULL,
  `twitter_user_id` bigint(20) NOT NULL,
  `text` varchar(255) CHARACTER SET utf8 NOT NULL,
  `media_url_https` varchar(255) DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `retweets_count` int(11) NOT NULL DEFAULT '0',
  `favorites_count` int(11) NOT NULL DEFAULT '0',
  `replies_count` int(11) NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `rating` tinyint(1) NOT NULL DEFAULT '0',
  `unimportant` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `twitter_feeds_twitter_user_id_index` (`twitter_user_id`),
  KEY `twitter_statuses_inserted_at_index` (`inserted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=910654802484432898 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_trades`
--

DROP TABLE IF EXISTS `user_trades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_trades` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `type` varchar(255) NOT NULL,
  `reason` text,
  `currency_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_trades_currency_id_index` (`currency_id`),
  KEY `user_trades_user_id_index` (`user_id`),
  CONSTRAINT `user_trades_currency_id_fkey` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `user_trades_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `github_uid` varchar(255) DEFAULT NULL,
  `developer` tinyint(1) NOT NULL DEFAULT '0',
  `moderator` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `public_profile` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'cryptomarker_dev'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-21  2:06:17
INSERT INTO `schema_migrations` (version) VALUES (20170820142547), (20170820195527), (20170821170828), (20170821184833), (20170821185158), (20170822204905), (20170824073702), (20170824120009), (20170824143029), (20170824165407), (20170824213301), (20170824222637), (20170825082932), (20170825091155), (20170825114649), (20170825135539), (20170825140254), (20170825174753), (20170825190407), (20170826105752), (20170826220843), (20170827111018), (20170827123335), (20170827135216), (20170827191256), (20170827215506), (20170828102201), (20170828141223), (20170830190847), (20170830221158), (20170830232538), (20170831122451), (20170903091619), (20170903103038), (20170903133539), (20170903140531), (20170903205753), (20170905135109), (20170906204401), (20170909104747), (20170912135343), (20170912144507), (20170912153402), (20170912190516), (20170913230543), (20170914102325), (20170914123344), (20170914123804), (20170914152016), (20170914182738), (20170915175146), (20170915205225), (20170918142423), (20170918232217), (20170919002729), (20170920235250);

