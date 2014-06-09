-- MySQL dump 10.13  Distrib 5.5.28, for debian-linux-gnu (i686)
--
-- Host: 67.228.0.250    Database: v3
-- ------------------------------------------------------
-- Server version	5.5.23-log

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
-- Table structure for table `_publisher_content_adimpressions`
--

DROP TABLE IF EXISTS `_publisher_content_adimpressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_publisher_content_adimpressions` (
  `tid` bigint(20) DEFAULT NULL,
  `vid` bigint(20) unsigned NOT NULL,
  `impressions` int(10) unsigned NOT NULL,
  `served_on` datetime NOT NULL,
  KEY `tid` (`tid`,`vid`,`served_on`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_deals`
--

DROP TABLE IF EXISTS `account_deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_deals` (
  `deal_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_account_id` bigint(20) NOT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `to_account_id` bigint(20) NOT NULL,
  `deal_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `project_id` bigint(20) NOT NULL,
  `terms` longtext NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `active` tinyint(1) NOT NULL,
  `request_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = not request/approved request, 1 = pending request',
  `request_text` text NOT NULL,
  PRIMARY KEY (`deal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3269 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_deals_pending`
--

DROP TABLE IF EXISTS `account_deals_pending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_deals_pending` (
  `deal_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_account_id` bigint(20) NOT NULL,
  `from_user_id` bigint(20) NOT NULL,
  `content_email` varchar(255) NOT NULL,
  `deal_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `project_id` bigint(20) NOT NULL,
  `terms` longtext NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`deal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_sites`
--

DROP TABLE IF EXISTS `account_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_sites` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(75) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `url` varchar(250) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_distribute_ftp`
--

DROP TABLE IF EXISTS `accounts_distribute_ftp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_distribute_ftp` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `name` char(50) NOT NULL,
  `server_address` char(200) NOT NULL,
  `path` char(200) NOT NULL,
  `username` char(100) NOT NULL,
  `password` char(200) DEFAULT NULL,
  `external_acc_id` varchar(30) DEFAULT NULL,
  `notification_email` char(150) NOT NULL,
  `type` tinyint(2) DEFAULT '0',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0=Active, 1=Deactive, 2=Has Error',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_ftp_map`
--

DROP TABLE IF EXISTS `accounts_ftp_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_ftp_map` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `accounts_distribute_ftp_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_invite_keys`
--

DROP TABLE IF EXISTS `accounts_invite_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_invite_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL DEFAULT '0',
  `auth_key` varchar(32) NOT NULL,
  `account_level` int(11) NOT NULL DEFAULT '0' COMMENT '0 = member, 1 = employee, 2 = admin',
  `expired` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2529 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_relationships`
--

DROP TABLE IF EXISTS `accounts_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_account_id` int(11) DEFAULT NULL,
  `second_account_id` int(11) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `relationship_created_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auditude_queue`
--

DROP TABLE IF EXISTS `auditude_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditude_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batch_number` varchar(155) DEFAULT '0',
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `status` tinyint(4) DEFAULT '0',
  `response` varchar(155) DEFAULT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `batch_number` (`batch_number`,`project_id`,`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bp_group_members`
--

DROP TABLE IF EXISTS `bp_group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bp_group_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `status_id` tinyint(2) NOT NULL DEFAULT '1',
  `user_id` bigint(20) DEFAULT NULL,
  `group_admin` tinyint(1) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL,
  `inviter_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bp_groups`
--

DROP TABLE IF EXISTS `bp_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bp_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `status_id` tinyint(2) NOT NULL DEFAULT '1',
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '1',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bulk_subscription_projects`
--

DROP TABLE IF EXISTS `bulk_subscription_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_subscription_projects` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `date` datetime NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `subscription_id` (`subscription_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bulk_subscriptions`
--

DROP TABLE IF EXISTS `bulk_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bulk_subscriptions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '1',
  `user_id` bigint(20) NOT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cached_content`
--

DROP TABLE IF EXISTS `cached_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cached_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` char(30) NOT NULL,
  `content` text NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cached_search`
--

DROP TABLE IF EXISTS `cached_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cached_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `post_title` varchar(200) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `archived` tinyint(1) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `alternatives` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_created` (`date_created`,`id`),
  KEY `index_modified` (`date_modified`,`id`),
  KEY `index_title` (`post_title`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41139 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cached_search_content`
--

DROP TABLE IF EXISTS `cached_search_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cached_search_content` (
  `search_id` int(11) NOT NULL,
  `fields` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`search_id`),
  FULLTEXT KEY `content` (`content`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar_items`
--

DROP TABLE IF EXISTS `calendar_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `project` int(11) NOT NULL DEFAULT '0',
  `video` int(11) NOT NULL DEFAULT '0',
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1659 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connect_invitations`
--

DROP TABLE IF EXISTS `connect_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connect_invitations` (
  `inviter_id` int(11) NOT NULL,
  `inviter_snsuserid` varchar(52) NOT NULL,
  `sns_id` tinyint(4) NOT NULL,
  `sns_userid` varchar(52) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `gmt_datetime` datetime NOT NULL,
  `utc_datetime` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `iso` char(2) NOT NULL,
  `name` varchar(80) NOT NULL,
  `printable_name` varchar(80) NOT NULL,
  `iso3` char(3) DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`iso`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cp_user_topics`
--

DROP TABLE IF EXISTS `cp_user_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cp_user_topics` (
  `user_id` bigint(20) DEFAULT NULL,
  `topic_id` mediumint(9) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_controller`
--

DROP TABLE IF EXISTS `cron_controller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_controller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `script_name` varchar(100) NOT NULL,
  `last_exe_time` datetime NOT NULL,
  `total_cnt` int(11) NOT NULL,
  `max_exe_time` bigint(20) NOT NULL,
  `avg_run_time` float(5,5) NOT NULL,
  `current_status` tinyint(1) NOT NULL COMMENT '1 = running, 0 = not running',
  PRIMARY KEY (`id`),
  UNIQUE KEY `script_name` (`script_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `direct_egest`
--

DROP TABLE IF EXISTS `direct_egest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direct_egest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner` varchar(64) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `dropbox_id` int(11) NOT NULL,
  `guid` varchar(128) NOT NULL,
  `manifest_file` text NOT NULL,
  `is_egested` tinyint(1) NOT NULL DEFAULT '0',
  `egest_start` datetime NOT NULL,
  `egest_complete` datetime NOT NULL,
  `xid` varchar(128) NOT NULL,
  `external_entity` varchar(64) NOT NULL,
  `egested_dir` text NOT NULL,
  `vid_updated_time` datetime NOT NULL,
  `error_detail` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1429 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropbox_ftp_mapping`
--

DROP TABLE IF EXISTS `dropbox_ftp_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dropbox_ftp_mapping` (
  `dropbox_id` int(11) NOT NULL,
  `ftp_profile_id` int(11) NOT NULL,
  PRIMARY KEY (`dropbox_id`,`ftp_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropboxes`
--

DROP TABLE IF EXISTS `dropboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dropboxes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `host` varchar(100) NOT NULL,
  `port` int(8) NOT NULL,
  `method` varchar(100) NOT NULL,
  `user` varchar(100) NOT NULL,
  `public_key` varchar(250) NOT NULL,
  `private_key` varchar(250) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `duplicate_video_tracking`
--

DROP TABLE IF EXISTS `duplicate_video_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duplicate_video_tracking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `vid` bigint(20) DEFAULT NULL,
  `parent_video_id` int(11) NOT NULL,
  `parent_project_id` int(11) NOT NULL,
  `parent_vid` int(11) NOT NULL COMMENT 'Source Playlist ID',
  `flag` tinyint(4) unsigned NOT NULL COMMENT '0=move, 1=copy',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `egest_threads`
--

DROP TABLE IF EXISTS `egest_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `egest_threads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` char(100) NOT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `pid` int(11) unsigned NOT NULL,
  `accounts_distribute_ftp_id` int(11) unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=139 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_pact_registrations`
--

DROP TABLE IF EXISTS `event_pact_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_pact_registrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `company` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `time_registered` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_video_mapping`
--

DROP TABLE IF EXISTS `external_video_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_video_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `xid` varchar(255) NOT NULL,
  `vid` bigint(20) NOT NULL,
  `cid` int(11) NOT NULL,
  `external_entity` varchar(64) NOT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `asset_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xid` (`xid`),
  KEY `xid_2` (`xid`)
) ENGINE=MyISAM AUTO_INCREMENT=21755 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filesets`
--

DROP TABLE IF EXISTS `filesets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filesets` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(48) COLLATE latin1_general_ci NOT NULL,
  `desc` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `data` text COLLATE latin1_general_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp_egest_queue`
--

DROP TABLE IF EXISTS `ftp_egest_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp_egest_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `accounts_distribute_ftp_id` int(11) unsigned NOT NULL,
  `cdn_url` char(255) NOT NULL COMMENT 'video to be send',
  `src_url` char(255) NOT NULL,
  `newsml_filename` char(100) NOT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `guid` char(100) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `is_newsml` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(4) unsigned NOT NULL COMMENT '1-10, 1=Low, 10=High....',
  `add_on` datetime NOT NULL COMMENT 'When request is add in queue',
  `sent_start` datetime NOT NULL COMMENT 'Date when video uploading started',
  `sent_on` datetime NOT NULL COMMENT 'When request is completed',
  `retry_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'How many times re-try for uploading in case of getting error in uploading',
  `request_source` tinyint(4) NOT NULL COMMENT '1=By Click on Button, 2=Automatic, 0=not captured',
  `progress_upload` smallint(6) NOT NULL DEFAULT '0',
  `last_error` varchar(255) NOT NULL,
  `last_transfer_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'In seconds',
  `file_size` int(10) unsigned NOT NULL COMMENT 'In Bytes',
  `last_transfer_rate` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Add in Queue, 1 = Download, -1 = Error in download, 2 = Upload Start, -2 = Error in Upload, 3 = Upload Finish, 4=pending, -6=YouTube ID Not Found',
  `is_allotted` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0=not, 1=allottted, 2=processed',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp_egest_queue_flag`
--

DROP TABLE IF EXISTS `ftp_egest_queue_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp_egest_queue_flag` (
  `flag` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `cnt` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `mx` tinyint(4) unsigned NOT NULL DEFAULT '3'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp_egest_queue_old`
--

DROP TABLE IF EXISTS `ftp_egest_queue_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp_egest_queue_old` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `accounts_distribute_ftp_id` int(11) unsigned NOT NULL,
  `cdn_url` char(255) NOT NULL COMMENT 'video to be send',
  `src_url` char(255) NOT NULL,
  `newsml_filename` char(100) NOT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `guid` char(100) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `is_newsml` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `priority` tinyint(4) unsigned NOT NULL COMMENT '1-10, 1=Low, 10=High....',
  `add_on` datetime NOT NULL COMMENT 'When request is add in queue',
  `sent_start` datetime NOT NULL COMMENT 'Date when video uploading started',
  `sent_on` datetime NOT NULL COMMENT 'When request is completed',
  `retry_times` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'How many times re-try for uploading in case of getting error in uploading',
  `request_source` tinyint(4) NOT NULL COMMENT '1=By Click on Button, 2=Automatic, 0=not captured',
  `progress_upload` smallint(6) NOT NULL DEFAULT '0',
  `last_error` varchar(255) NOT NULL,
  `last_transfer_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'In seconds',
  `file_size` int(10) unsigned NOT NULL COMMENT 'In Bytes',
  `last_transfer_rate` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = Add in Queue, 1 = Download, -1 = Error in download, 2 = Upload Start, -2 = Error in Upload, 3 = Upload Finish,  4=pending',
  `is_allotted` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0=not, 1=allottted, 2=processed',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ga_reports`
--

DROP TABLE IF EXISTS `ga_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ga_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `metric` char(15) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `grouped_by` char(15) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingest_alert`
--

DROP TABLE IF EXISTS `ingest_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingest_alert` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `method` text,
  `inactive_time` int(11) DEFAULT NULL,
  `is_email_sent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingest_filter`
--

DROP TABLE IF EXISTS `ingest_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingest_filter` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `parent_id` int(20) NOT NULL DEFAULT '0',
  `account_id` bigint(20) DEFAULT NULL,
  `search_field` varchar(255) DEFAULT NULL,
  `operator` int(4) DEFAULT NULL,
  `search_text` varchar(255) DEFAULT NULL,
  `projects_name` text,
  `topics` varchar(155) DEFAULT NULL,
  `relation` enum('AND','OR') DEFAULT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingest_info`
--

DROP TABLE IF EXISTS `ingest_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingest_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` varchar(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `media_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40134 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingest_project_filters`
--

DROP TABLE IF EXISTS `ingest_project_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingest_project_filters` (
  `filter_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `filter_xml` varchar(20000) NOT NULL,
  `metadata` text,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '''1''=>Success,''0''=>''Failed''',
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`filter_id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iptocountry`
--

DROP TABLE IF EXISTS `iptocountry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iptocountry` (
  `lower_bound` int(11) unsigned NOT NULL DEFAULT '0',
  `upper_bound` int(11) unsigned NOT NULL DEFAULT '0',
  `two_char_code` char(2) NOT NULL DEFAULT '',
  `three_char_code` char(3) NOT NULL DEFAULT '',
  `country` varchar(100) NOT NULL DEFAULT '',
  UNIQUE KEY `lower_bound` (`lower_bound`),
  UNIQUE KEY `upper_bound` (`upper_bound`),
  UNIQUE KEY `range` (`lower_bound`,`upper_bound`),
  KEY `two_char_code` (`two_char_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lrtmp`
--

DROP TABLE IF EXISTS `lrtmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lrtmp` (
  `record_date` char(12) NOT NULL,
  `partner` varchar(255) NOT NULL,
  `tid` bigint(20) unsigned NOT NULL,
  `pid` bigint(20) NOT NULL,
  `vid` char(12) NOT NULL,
  `impressions` int(10) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_encodes`
--

DROP TABLE IF EXISTS `media_encodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_encodes` (
  `encode_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `media_id` bigint(20) NOT NULL,
  `cdn_url` char(255) COLLATE ascii_bin NOT NULL,
  `cdn_pubpoint` char(255) COLLATE ascii_bin NOT NULL,
  `container` char(5) CHARACTER SET ascii NOT NULL,
  `duration` int(11) NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `status` tinyint(11) NOT NULL,
  `bitrate` smallint(6) unsigned NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) CHARACTER SET ascii NOT NULL,
  `acodec` char(12) CHARACTER SET ascii NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `taskid` bigint(20) NOT NULL,
  `task_status` char(32) COLLATE ascii_bin NOT NULL,
  `job_progress` smallint(5) NOT NULL DEFAULT '0',
  `src_url` char(255) COLLATE ascii_bin DEFAULT NULL,
  `backup_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`encode_id`),
  KEY `media_id` (`media_id`),
  KEY `taskid` (`taskid`)
) ENGINE=MyISAM AUTO_INCREMENT=233520 DEFAULT CHARSET=ascii COLLATE=ascii_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_encodes_bak`
--

DROP TABLE IF EXISTS `media_encodes_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_encodes_bak` (
  `encode_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `media_id` bigint(20) NOT NULL,
  `cdn_url` char(255) COLLATE ascii_bin NOT NULL,
  `cdn_pubpoint` char(255) COLLATE ascii_bin NOT NULL,
  `container` char(5) CHARACTER SET ascii NOT NULL,
  `duration` int(11) NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `status` tinyint(11) NOT NULL,
  `bitrate` smallint(6) unsigned NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) CHARACTER SET ascii NOT NULL,
  `acodec` char(12) CHARACTER SET ascii NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `taskid` bigint(20) NOT NULL,
  `task_status` char(32) COLLATE ascii_bin NOT NULL,
  `src_url` char(255) COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`encode_id`),
  KEY `media_id` (`media_id`),
  KEY `taskid` (`taskid`)
) ENGINE=MyISAM AUTO_INCREMENT=62442 DEFAULT CHARSET=ascii COLLATE=ascii_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_encodes_new`
--

DROP TABLE IF EXISTS `media_encodes_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_encodes_new` (
  `encode_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `media_id` bigint(20) NOT NULL,
  `cdn_url` char(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `cdn_pubpoint` char(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `container` char(5) CHARACTER SET ascii NOT NULL,
  `duration` int(11) NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `status` tinyint(11) NOT NULL,
  `bitrate` smallint(6) unsigned NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) CHARACTER SET ascii NOT NULL,
  `acodec` char(12) CHARACTER SET ascii NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `taskid` bigint(20) NOT NULL,
  `task_status` char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `job_progress` smallint(5) NOT NULL DEFAULT '0',
  `src_url` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT 'Original Video URL',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`encode_id`),
  KEY `media_id` (`media_id`),
  KEY `taskid` (`taskid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_source`
--

DROP TABLE IF EXISTS `media_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_source` (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `src_url` char(255) NOT NULL,
  `cdn_url` char(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `container` char(5) NOT NULL,
  `bitrate` int(11) NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) NOT NULL,
  `acodec` char(12) NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `duration` int(11) NOT NULL,
  `transfer_time` smallint(5) unsigned NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `added_on` datetime NOT NULL,
  `encoded_on` datetime NOT NULL,
  `job_id` int(10) unsigned NOT NULL,
  `job_progress` smallint(5) unsigned NOT NULL,
  `backup_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`media_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=79184 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_source_bak`
--

DROP TABLE IF EXISTS `media_source_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_source_bak` (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `src_url` char(255) NOT NULL,
  `cdn_url` char(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `container` char(5) NOT NULL,
  `bitrate` int(11) NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) NOT NULL,
  `acodec` char(12) NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `duration` int(11) NOT NULL,
  `transfer_time` smallint(5) unsigned NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `added_on` datetime NOT NULL,
  `encoded_on` datetime NOT NULL,
  `job_id` int(10) unsigned NOT NULL,
  `job_progress` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`media_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=21297 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_source_new`
--

DROP TABLE IF EXISTS `media_source_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_source_new` (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `src_url` char(255) NOT NULL,
  `cdn_url` char(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `container` char(5) NOT NULL,
  `bitrate` int(11) NOT NULL,
  `vbitrate` smallint(6) unsigned NOT NULL,
  `width` smallint(6) unsigned NOT NULL,
  `height` smallint(6) unsigned NOT NULL,
  `fps` smallint(6) NOT NULL,
  `vcodec` char(12) NOT NULL,
  `acodec` char(12) NOT NULL,
  `abitrate` smallint(11) unsigned NOT NULL,
  `afreq` mediumint(11) unsigned NOT NULL,
  `channels` tinyint(6) unsigned NOT NULL,
  `duration` int(11) NOT NULL,
  `transfer_time` smallint(5) unsigned NOT NULL,
  `filesize` bigint(20) unsigned NOT NULL,
  `added_on` datetime NOT NULL,
  `encoded_on` datetime NOT NULL,
  `job_id` int(10) unsigned NOT NULL,
  `job_progress` smallint(5) unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`media_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_video`
--

DROP TABLE IF EXISTS `media_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_video` (
  `video_id` bigint(20) NOT NULL DEFAULT '0',
  `project_id` bigint(20) NOT NULL DEFAULT '0',
  `media_id` bigint(20) DEFAULT NULL,
  `container` char(5) NOT NULL,
  PRIMARY KEY (`project_id`,`video_id`,`container`),
  KEY `media_id` (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media_video_archive`
--

DROP TABLE IF EXISTS `media_video_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_video_archive` (
  `video_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  `container` char(5) NOT NULL,
  `archived_on` datetime NOT NULL,
  KEY `media_id` (`media_id`),
  KEY `video_id` (`video_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrss_access_log`
--

DROP TABLE IF EXISTS `mrss_access_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrss_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `time_accessed` datetime NOT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1817 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrss_guid_log`
--

DROP TABLE IF EXISTS `mrss_guid_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrss_guid_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mis_id` int(11) NOT NULL,
  `guid` varchar(100) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB AUTO_INCREMENT=661 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrss_ingest_source_info`
--

DROP TABLE IF EXISTS `mrss_ingest_source_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrss_ingest_source_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(18) unsigned NOT NULL,
  `user_id` bigint(18) unsigned NOT NULL,
  `mrss_namespace_id` int(11) unsigned NOT NULL,
  `source_link` varchar(500) DEFAULT NULL,
  `showshare` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `showiconarticle` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `video_click_url` char(100) NOT NULL,
  `fetchvast` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `backup_folder_path` char(50) NOT NULL,
  `web_quality_download` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `high_quality_download` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `media_position` int(3) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `last_accessed` datetime NOT NULL,
  `poll_frequency` int(5) unsigned NOT NULL COMMENT 'inseconds',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0=Deactive, 1=Active, 2=Delete',
  `name` varchar(100) NOT NULL DEFAULT 'Default',
  `expiry_date` date NOT NULL,
  `categories` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrss_namespaces`
--

DROP TABLE IF EXISTS `mrss_namespaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrss_namespaces` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` char(255) DEFAULT NULL,
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '0=Deactive, 1=Active, 2=Delete',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `recipient` varchar(255) NOT NULL,
  `cc` varchar(128) DEFAULT NULL,
  `bcc` varchar(128) DEFAULT NULL,
  `subject` text,
  `body` text,
  `attachment` text,
  `send_time` datetime DEFAULT NULL,
  `success` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=93251 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_api_log`
--

DROP TABLE IF EXISTS `oauth_api_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_api_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_consumer_key` char(64) NOT NULL,
  `status` varchar(16) NOT NULL,
  `request` text NOT NULL,
  `response` text NOT NULL,
  `timestamp` datetime NOT NULL,
  `ip` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_api_log_archive`
--

DROP TABLE IF EXISTS `oauth_api_log_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_api_log_archive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_consumer_key` char(64) NOT NULL,
  `status` varchar(16) NOT NULL,
  `request` text NOT NULL,
  `response` text NOT NULL,
  `timestamp` datetime NOT NULL,
  `ip` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_consumer`
--

DROP TABLE IF EXISTS `oauth_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_consumer` (
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `app_id` int(11) NOT NULL DEFAULT '0',
  `consumer_key` char(64) NOT NULL,
  `consumer_secret` char(64) NOT NULL,
  `ip_ranges` text NOT NULL,
  `security_level` int(1) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `app_id` (`app_id`),
  KEY `consumer_key` (`consumer_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_nonce`
--

DROP TABLE IF EXISTS `oauth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_nonce` (
  `nonce` char(64) NOT NULL,
  `nonce_timestamp` int(11) NOT NULL,
  PRIMARY KEY (`nonce`),
  KEY `nonce_timestamp` (`nonce_timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_token`
--

DROP TABLE IF EXISTS `oauth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_token` (
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `consumer_key` char(64) NOT NULL,
  `type` char(7) NOT NULL,
  `token_key` char(64) NOT NULL,
  `token_secret` char(64) NOT NULL,
  `authorized` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`token_key`),
  UNIQUE KEY `token_key` (`token_key`),
  KEY `token_key_2` (`token_key`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagecache_stack`
--

DROP TABLE IF EXISTS `pagecache_stack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagecache_stack` (
  `url` varchar(512) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform_events`
--

DROP TABLE IF EXISTS `platform_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event` varchar(75) NOT NULL,
  `tracking_enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `event` (`event`)
) ENGINE=MyISAM AUTO_INCREMENT=201 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform_stats`
--

DROP TABLE IF EXISTS `platform_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_stats` (
  `date_time` datetime NOT NULL,
  `viewedby_account_id` bigint(20) NOT NULL,
  `viewedby_user_id` bigint(20) NOT NULL,
  `event` int(11) unsigned NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `video_id` bigint(20) NOT NULL,
  `ip` int(11) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `player_versions`
--

DROP TABLE IF EXISTS `player_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_versions` (
  `tracking_id` bigint(20) NOT NULL DEFAULT '0',
  `project_id` bigint(20) DEFAULT NULL,
  `player` int(11) NOT NULL,
  PRIMARY KEY (`tracking_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlist_failobjects`
--

DROP TABLE IF EXISTS `playlist_failobjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist_failobjects` (
  `failobject_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `failobject_name` char(32) NOT NULL COMMENT 'used for display purposes in lists where you need to select FOs',
  `failure_content` varchar(2048) NOT NULL COMMENT 'can be message, html, code, or URL, depending on contenttype. currently autodetected.',
  `failure_contenttype` tinyint(4) NOT NULL COMMENT 'Indicates what to do with the content',
  PRIMARY KEY (`failobject_id`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlist_rights`
--

DROP TABLE IF EXISTS `playlist_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlist_rights` (
  `map_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playlist_id` int(10) unsigned NOT NULL,
  `tracking_id` bigint(20) DEFAULT NULL,
  `right_name` char(16) NOT NULL,
  `fail_object` int(10) unsigned NOT NULL,
  `granted` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `grantee_account` int(10) unsigned NOT NULL,
  `grantee_user` int(10) unsigned NOT NULL,
  `requested_on` datetime NOT NULL,
  `granted_on` datetime NOT NULL,
  `granted_from` datetime NOT NULL,
  `granted_till` datetime NOT NULL,
  PRIMARY KEY (`map_id`),
  KEY `playlist_id` (`playlist_id`,`tracking_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlists_0`
--

DROP TABLE IF EXISTS `playlists_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists_0` (
  `ID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(64) CHARACTER SET utf8 NOT NULL,
  `vlist` text COLLATE latin1_general_ci NOT NULL,
  `tlist` text COLLATE latin1_general_ci NOT NULL,
  `plist` text COLLATE latin1_general_ci NOT NULL,
  `player_ver` smallint(6) NOT NULL,
  `player` text COLLATE latin1_general_ci NOT NULL,
  `channel_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `isAd` tinyint(1) NOT NULL,
  `content_count` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  `start_image` char(255) COLLATE latin1_general_ci NOT NULL,
  `click_thru` char(255) COLLATE latin1_general_ci NOT NULL,
  `base_id` bigint(20) NOT NULL,
  `views` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `failobject_id` int(10) unsigned NOT NULL,
  `is_playlist` tinyint(1) NOT NULL DEFAULT '0',
  `backup_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `channel_id` (`channel_id`),
  KEY `title` (`title`),
  FULLTEXT KEY `plist` (`plist`)
) ENGINE=MyISAM AUTO_INCREMENT=170438 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlists_0_bak`
--

DROP TABLE IF EXISTS `playlists_0_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists_0_bak` (
  `ID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(64) CHARACTER SET utf8 NOT NULL,
  `vlist` text COLLATE latin1_general_ci NOT NULL,
  `tlist` text COLLATE latin1_general_ci NOT NULL,
  `plist` text COLLATE latin1_general_ci NOT NULL,
  `player_ver` smallint(6) NOT NULL,
  `player` text COLLATE latin1_general_ci NOT NULL,
  `channel_id` smallint(6) NOT NULL,
  `post_id` smallint(6) NOT NULL,
  `isAd` tinyint(1) NOT NULL,
  `content_count` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  `start_image` char(255) COLLATE latin1_general_ci NOT NULL,
  `click_thru` char(255) COLLATE latin1_general_ci NOT NULL,
  `base_id` bigint(20) NOT NULL,
  `views` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `failobject_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `channel_id` (`channel_id`),
  FULLTEXT KEY `plist` (`plist`)
) ENGINE=MyISAM AUTO_INCREMENT=6980 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `playlists_0_new`
--

DROP TABLE IF EXISTS `playlists_0_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playlists_0_new` (
  `ID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(64) CHARACTER SET utf8 NOT NULL,
  `vlist` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `tlist` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `plist` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `player_ver` smallint(6) NOT NULL,
  `player` text CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `channel_id` smallint(6) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `isAd` tinyint(1) NOT NULL,
  `content_count` int(11) NOT NULL,
  `item_count` int(11) NOT NULL,
  `start_image` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `click_thru` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `base_id` bigint(20) NOT NULL,
  `views` bigint(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `failobject_id` int(10) unsigned NOT NULL,
  `is_playlist` tinyint(1) NOT NULL DEFAULT '0',
  `backup_status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `channel_id` (`channel_id`),
  KEY `title` (`title`),
  FULLTEXT KEY `plist` (`plist`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_hubs`
--

DROP TABLE IF EXISTS `post_hubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_hubs` (
  `id` int(7) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `hub_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hub_id` (`hub_id`),
  KEY `channel_id` (`channel_id`,`post_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=149758 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_hubs_19nov`
--

DROP TABLE IF EXISTS `post_hubs_19nov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_hubs_19nov` (
  `id` int(7) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `hub_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hub_id` (`hub_id`),
  KEY `channel_id` (`channel_id`,`post_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7018 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_hubs_old`
--

DROP TABLE IF EXISTS `post_hubs_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_hubs_old` (
  `channel_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `hub_id` int(11) NOT NULL,
  KEY `hub_id` (`hub_id`),
  KEY `channel_id` (`channel_id`,`post_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `post_info`
--

DROP TABLE IF EXISTS `post_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_info` (
  `channel_id` bigint(20) NOT NULL DEFAULT '0',
  `post_id` bigint(20) NOT NULL DEFAULT '0',
  `guid` char(48) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `pub_date` datetime NOT NULL,
  `post_category` mediumint(9) NOT NULL DEFAULT '1',
  `video_group_id` char(50) DEFAULT NULL,
  `video_partlabel` char(20) DEFAULT NULL,
  `partner` char(40) DEFAULT NULL,
  PRIMARY KEY (`channel_id`,`post_id`),
  KEY `guid` (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_requests`
--

DROP TABLE IF EXISTS `project_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_requests` (
  `project_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `request_date` datetime NOT NULL,
  `account_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_account`
--

DROP TABLE IF EXISTS `projects_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects_account` (
  `project_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  KEY `account_id` (`account_id`),
  KEY `project_id` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_content_adimpressions_2`
--

DROP TABLE IF EXISTS `publisher_content_adimpressions_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_content_adimpressions_2` (
  `tid` bigint(20) NOT NULL DEFAULT '0',
  `vid` bigint(20) unsigned NOT NULL,
  `impressions` int(10) unsigned NOT NULL,
  `served_on` date NOT NULL,
  PRIMARY KEY (`tid`,`vid`,`served_on`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_content_adimpressions_utc`
--

DROP TABLE IF EXISTS `publisher_content_adimpressions_utc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_content_adimpressions_utc` (
  `tid` bigint(20) DEFAULT NULL,
  `vid` bigint(20) unsigned NOT NULL,
  `impressions` int(10) unsigned NOT NULL,
  `served_on` datetime NOT NULL,
  KEY `tid` (`tid`,`vid`,`served_on`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_demographic_ages`
--

DROP TABLE IF EXISTS `publisher_demographic_ages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_demographic_ages` (
  `age_id` smallint(11) NOT NULL AUTO_INCREMENT,
  `age_range` char(10) NOT NULL,
  PRIMARY KEY (`age_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_demographic_uniques`
--

DROP TABLE IF EXISTS `publisher_demographic_uniques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_demographic_uniques` (
  `uniques_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `uniques_range` char(30) NOT NULL,
  PRIMARY KEY (`uniques_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_firstviews`
--

DROP TABLE IF EXISTS `publisher_firstviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_firstviews` (
  `tid` bigint(20) NOT NULL DEFAULT '0',
  `vid` bigint(20) NOT NULL DEFAULT '0',
  `location` char(255) NOT NULL,
  `IP` bigint(20) unsigned NOT NULL,
  `record_date` datetime NOT NULL,
  `record_type` tinyint(3) unsigned NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `last_verified_on` datetime NOT NULL,
  PRIMARY KEY (`tid`,`vid`,`record_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_firstviews_queue`
--

DROP TABLE IF EXISTS `publisher_firstviews_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_firstviews_queue` (
  `tid` bigint(20) NOT NULL DEFAULT '0',
  `vid` bigint(20) NOT NULL DEFAULT '0',
  `added_on` datetime NOT NULL,
  `processed_on` datetime NOT NULL,
  PRIMARY KEY (`tid`,`vid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_requests`
--

DROP TABLE IF EXISTS `publisher_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_requests` (
  `user_id` bigint(20) DEFAULT NULL,
  `video_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `time_requested` datetime NOT NULL,
  `requesting_account_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_sites`
--

DROP TABLE IF EXISTS `publisher_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_sites` (
  `site_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pub_id` bigint(20) NOT NULL,
  `site_name` varchar(200) NOT NULL,
  `site_url` varchar(200) NOT NULL,
  `monthly_visits` smallint(6) NOT NULL,
  `fansite_of` varchar(100) NOT NULL,
  `demographic` smallint(6) NOT NULL,
  PRIMARY KEY (`site_id`),
  KEY `pub_id` (`pub_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_topics`
--

DROP TABLE IF EXISTS `publisher_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_topics` (
  `topic_id` mediumint(9) NOT NULL DEFAULT '0',
  `topic_name` varchar(80) NOT NULL,
  `order` smallint(6) NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`topic_id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_tracking_codes`
--

DROP TABLE IF EXISTS `publisher_tracking_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_tracking_codes` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `pub_id` bigint(20) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `lr_partnerId` int(11) NOT NULL,
  `created_on` datetime NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`tid`),
  KEY `pub_id` (`pub_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2309 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_user_topics`
--

DROP TABLE IF EXISTS `publisher_user_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_user_topics` (
  `user_id` bigint(20) DEFAULT NULL,
  `topic_id` mediumint(9) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_users`
--

DROP TABLE IF EXISTS `publisher_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publisher_users` (
  `ID` bigint(20) NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `country` char(2) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `address_1` varchar(100) NOT NULL,
  `address_2` varchar(100) NOT NULL,
  `address_3` varchar(100) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `contact_email` varchar(150) NOT NULL,
  `site_name` varchar(200) NOT NULL,
  `site_url` varchar(200) NOT NULL,
  `monthly_visits` smallint(6) NOT NULL,
  `fansite_of` varchar(100) NOT NULL,
  `demographic` smallint(6) NOT NULL,
  `audience_gender` decimal(2,2) NOT NULL,
  `topic_other` text NOT NULL,
  `terms_conditions` tinyint(4) NOT NULL,
  `ad_verified_user` tinyint(4) DEFAULT NULL,
  `lfw_interest` tinyint(4) NOT NULL,
  `is_private` tinyint(4) NOT NULL,
  `reference_to_signup` text NOT NULL,
  `account_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recent_ingests`
--

DROP TABLE IF EXISTS `recent_ingests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recent_ingests` (
  `id` bigint(20) DEFAULT NULL,
  `guid` varchar(48) DEFAULT NULL,
  `sess_id` varchar(48) DEFAULT NULL,
  `input_params` text,
  `logged_on` datetime DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `post_title` text,
  `post_status` varchar(20) DEFAULT NULL,
  `rightster_url` text,
  UNIQUE KEY `sess_id` (`sess_id`),
  KEY `guid` (`guid`),
  KEY `input_params` (`input_params`(155)),
  KEY `post_title` (`post_title`(300))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `id` text NOT NULL,
  `label` text NOT NULL,
  `filters` text NOT NULL,
  `collation` text NOT NULL,
  `params` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` smallint(6) NOT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3511 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sponsorship_opportunity_types`
--

DROP TABLE IF EXISTS `sponsorship_opportunity_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsorship_opportunity_types` (
  `opportunity_id` int(11) NOT NULL AUTO_INCREMENT,
  `opportunity_type` varchar(100) NOT NULL,
  `opportunity_position` int(11) NOT NULL,
  PRIMARY KEY (`opportunity_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_demographics_data`
--

DROP TABLE IF EXISTS `summary_demographics_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_demographics_data` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `video_id` varchar(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `gender` varchar(6) DEFAULT NULL,
  `age_group` varchar(8) DEFAULT NULL,
  `percentage` float(5,2) DEFAULT NULL,
  `yt_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year` (`year`,`month`,`video_id`,`gender`,`age_group`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_gdata`
--

DROP TABLE IF EXISTS `summary_gdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_gdata` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `vid` varchar(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `categories` varchar(255) DEFAULT NULL,
  `view_count` int(20) DEFAULT NULL,
  `like_count` int(20) DEFAULT NULL,
  `dislike_count` int(20) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `thumbnail_urls` varchar(255) DEFAULT NULL,
  `average_rating` float(9,6) DEFAULT NULL,
  `total_rating` int(20) DEFAULT NULL,
  `yt_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year` (`year`,`month`,`account_id`,`username`,`vid`,`categories`,`keywords`,`thumbnail_urls`)
) ENGINE=InnoDB AUTO_INCREMENT=966 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_location_data`
--

DROP TABLE IF EXISTS `summary_location_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_location_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `region` varchar(3) DEFAULT NULL,
  `video_id` varchar(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `player_location` varchar(64) DEFAULT NULL,
  `total_views` int(11) DEFAULT NULL,
  `yt_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year` (`year`,`month`,`region`,`video_id`,`player_location`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_referrers_data`
--

DROP TABLE IF EXISTS `summary_referrers_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_referrers_data` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `region` varchar(3) DEFAULT NULL,
  `video_id` varchar(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `source_type` varchar(64) DEFAULT NULL,
  `total_views` int(11) DEFAULT NULL,
  `yt_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year` (`year`,`month`,`region`,`video_id`,`source_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_views_data`
--

DROP TABLE IF EXISTS `summary_views_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `summary_views_data` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `region` varchar(3) DEFAULT NULL,
  `video_id` varchar(64) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `unique_users` int(11) DEFAULT NULL,
  `unique_users_7_days` int(11) DEFAULT NULL,
  `unique_users_30_days` int(11) DEFAULT NULL,
  `popularity` float(11,10) DEFAULT NULL,
  `comments` int(11) DEFAULT NULL,
  `favorites` int(11) DEFAULT NULL,
  `rating_1` int(5) DEFAULT NULL,
  `rating_2` int(5) DEFAULT NULL,
  `rating_3` int(5) DEFAULT NULL,
  `rating_4` int(5) DEFAULT NULL,
  `rating_5` int(5) DEFAULT NULL,
  `yt_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year` (`year`,`month`,`region`,`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_comment_summary`
--

DROP TABLE IF EXISTS `t5m_comment_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_comment_summary` (
  `bid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `commented_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `bid` (`bid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_pop_alltime`
--

DROP TABLE IF EXISTS `t5m_pop_alltime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_pop_alltime` (
  `post_id` bigint(20) NOT NULL DEFAULT '0',
  `blog_id` bigint(20) NOT NULL,
  `total` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `last_updated` date NOT NULL,
  PRIMARY KEY (`post_id`,`blog_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_pop_alltime_backup`
--

DROP TABLE IF EXISTS `t5m_pop_alltime_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_pop_alltime_backup` (
  `post_id` bigint(20) NOT NULL DEFAULT '0',
  `blog_id` bigint(20) NOT NULL,
  `total` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `last_updated` date NOT NULL,
  PRIMARY KEY (`post_id`,`blog_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_pop_summary`
--

DROP TABLE IF EXISTS `t5m_pop_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_pop_summary` (
  `range` char(5) NOT NULL,
  `count` int(11) NOT NULL,
  `type` enum('v','c','t','ra') NOT NULL COMMENT 'v = top10 views, c = top 10 comments, t = top 20 channels, ra = top10 rated',
  `topic_id` mediumint(9) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  KEY `topic_id` (`topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_popularity`
--

DROP TABLE IF EXISTS `t5m_popularity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_popularity` (
  `post_id` bigint(20) NOT NULL DEFAULT '0',
  `blog_id` bigint(20) NOT NULL,
  `total` int(11) NOT NULL,
  `feed_views` int(11) NOT NULL,
  `home_views` int(11) NOT NULL,
  `archive_views` int(11) NOT NULL,
  `category_views` int(11) NOT NULL,
  `single_views` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `pingbacks` int(11) NOT NULL,
  `trackbacks` int(11) NOT NULL,
  `last_modified` datetime NOT NULL,
  `log_date` date NOT NULL,
  PRIMARY KEY (`post_id`,`blog_id`,`log_date`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t5m_popularity_options`
--

DROP TABLE IF EXISTS `t5m_popularity_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t5m_popularity_options` (
  `option_name` varchar(50) NOT NULL,
  `option_value` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_caps`
--

DROP TABLE IF EXISTS `temp_caps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_caps` (
  `account_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `action_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  KEY `account_id` (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_tbl`
--

DROP TABLE IF EXISTS `test_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_tbl` (
  `tid` bigint(20) DEFAULT NULL,
  `vid` bigint(20) NOT NULL,
  `impressions` int(10) NOT NULL,
  `served_on` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tophub_mappings`
--

DROP TABLE IF EXISTS `tophub_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tophub_mappings` (
  `tophub_id` mediumint(9) NOT NULL,
  `hub_id` int(11) NOT NULL,
  `weight` tinyint(1) NOT NULL,
  PRIMARY KEY (`tophub_id`,`hub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tophubs`
--

DROP TABLE IF EXISTS `tophubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tophubs` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` char(255) NOT NULL,
  `description` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `keywords` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `weight` tinyint(4) NOT NULL,
  `has_hubs` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_maping_external_entity`
--

DROP TABLE IF EXISTS `topic_maping_external_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_maping_external_entity` (
  `topic_id` mediumint(9) DEFAULT NULL,
  `external_category` varchar(128) NOT NULL,
  `external_entity` varchar(128) NOT NULL,
  `weight` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_maping_external_entity_old`
--

DROP TABLE IF EXISTS `topic_maping_external_entity_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_maping_external_entity_old` (
  `topic_id` mediumint(9) DEFAULT NULL,
  `external_category` varchar(128) NOT NULL,
  `external_entity` varchar(128) NOT NULL,
  `weight` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_mappings`
--

DROP TABLE IF EXISTS `topic_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_mappings` (
  `id` int(7) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` mediumint(9) NOT NULL,
  `channel_id` bigint(20) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `topic_id` (`topic_id`,`channel_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3982 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_mappings_old`
--

DROP TABLE IF EXISTS `topic_mappings_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_mappings_old` (
  `topic_id` mediumint(9) NOT NULL,
  `channel_id` bigint(20) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL,
  UNIQUE KEY `topic_id` (`topic_id`,`channel_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topic_mappings_old_19nov`
--

DROP TABLE IF EXISTS `topic_mappings_old_19nov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic_mappings_old_19nov` (
  `id` int(7) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` mediumint(9) NOT NULL,
  `channel_id` bigint(20) DEFAULT NULL,
  `is_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `topic_id` (`topic_id`,`channel_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` char(255) NOT NULL,
  `description` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `keywords` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics_old`
--

DROP TABLE IF EXISTS `topics_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics_old` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` char(255) NOT NULL,
  `description` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `keywords` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topics_old_old`
--

DROP TABLE IF EXISTS `topics_old_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics_old_old` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `title` char(255) NOT NULL,
  `description` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `keywords` char(255) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transcode_callback_log`
--

DROP TABLE IF EXISTS `transcode_callback_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcode_callback_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` varchar(255) DEFAULT NULL,
  `response` varchar(155) DEFAULT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notification_to` varchar(255) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `type` varchar(155) NOT NULL,
  `format` varchar(155) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`,`response`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_interactions`
--

DROP TABLE IF EXISTS `user_interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_interactions` (
  `uid` int(11) NOT NULL,
  `action_type` enum('c','v') NOT NULL,
  `action_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_post_votes`
--

DROP TABLE IF EXISTS `user_post_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_post_votes` (
  `uid` int(11) NOT NULL,
  `channel_id` bigint(20) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `likes` tinyint(1) NOT NULL,
  KEY `uid` (`uid`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_project_capabilities`
--

DROP TABLE IF EXISTS `user_project_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_project_capabilities` (
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `deal_id` int(10) unsigned NOT NULL,
  `action` tinyint(3) unsigned NOT NULL,
  `object` tinyint(3) unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `project_id` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_project_capabilities_20111209`
--

DROP TABLE IF EXISTS `user_project_capabilities_20111209`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_project_capabilities_20111209` (
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `deal_id` int(10) unsigned NOT NULL,
  `action` tinyint(3) unsigned NOT NULL,
  `object` tinyint(3) unsigned NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `project_id` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_project_subscriptions`
--

DROP TABLE IF EXISTS `user_project_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_project_subscriptions` (
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `subscription_type` int(11) NOT NULL,
  `subscribed` tinyint(1) NOT NULL,
  `bulk_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Bulk Subscription''s Primary Key',
  KEY `user_id` (`user_id`,`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_project_subscriptions_20111209`
--

DROP TABLE IF EXISTS `user_project_subscriptions_20111209`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_project_subscriptions_20111209` (
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `subscription_type` int(11) NOT NULL,
  `subscribed` tinyint(1) NOT NULL,
  KEY `user_id` (`user_id`,`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_socialnetwork_links`
--

DROP TABLE IF EXISTS `user_socialnetwork_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_socialnetwork_links` (
  `uid` int(11) NOT NULL,
  `sns_id` tinyint(4) NOT NULL,
  `access_token` text NOT NULL,
  `sns_userid` char(32) NOT NULL,
  `enabled` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_video_downloads`
--

DROP TABLE IF EXISTS `user_video_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_video_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `video_id` bigint(20) DEFAULT NULL,
  `type` varchar(40) NOT NULL,
  `time_downloaded` datetime NOT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13614 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_geo_access`
--

DROP TABLE IF EXISTS `video_geo_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_geo_access` (
  `project_id` bigint(20) NOT NULL,
  `video_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `country` char(2) NOT NULL,
  `status` enum('allow','deny','trash') NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime NOT NULL,
  `added_date` datetime NOT NULL,
  `rule_id` bigint(20) DEFAULT '0',
  KEY `PIndex` (`project_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_geo_project_access`
--

DROP TABLE IF EXISTS `video_geo_project_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_geo_project_access` (
  `project_id` bigint(20) NOT NULL,
  `country` char(2) NOT NULL,
  `status` enum('allow','deny','trash') NOT NULL,
  `start_day` int(11) NOT NULL,
  `end_day` varchar(11) NOT NULL,
  `added_date` datetime NOT NULL,
  `rule_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_geo_rules`
--

DROP TABLE IF EXISTS `video_geo_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_geo_rules` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` enum('1','2') DEFAULT NULL COMMENT '1 - Project, 2 - Video',
  `content_id` bigint(20) DEFAULT NULL,
  `added_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=472 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_event_tracking`
--

DROP TABLE IF EXISTS `video_ingest_event_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_event_tracking` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sess_id` (`sess_id`),
  KEY `looged_on` (`looged_on`)
) ENGINE=MyISAM AUTO_INCREMENT=7200623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_event_tracking_archive`
--

DROP TABLE IF EXISTS `video_ingest_event_tracking_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_event_tracking_archive` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sess_id` (`sess_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7150623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_event_tracking_test`
--

DROP TABLE IF EXISTS `video_ingest_event_tracking_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_event_tracking_test` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2944 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_logging`
--

DROP TABLE IF EXISTS `video_ingest_logging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_logging` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `is_event` tinyint(1) NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `looged_on` (`looged_on`)
) ENGINE=MyISAM AUTO_INCREMENT=7200623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_logging_archive`
--

DROP TABLE IF EXISTS `video_ingest_logging_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_logging_archive` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `is_event` tinyint(1) NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7150623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingest_logging_test`
--

DROP TABLE IF EXISTS `video_ingest_logging_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingest_logging_test` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `guid` char(48) NOT NULL,
  `sess_id` varchar(48) NOT NULL,
  `event` int(11) NOT NULL,
  `input_params` text NOT NULL,
  `output_prams` text NOT NULL,
  `looged_on` datetime NOT NULL,
  `is_event` tinyint(1) NOT NULL,
  `status` int(3) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2944 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_ingests`
--

DROP TABLE IF EXISTS `video_ingests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_ingests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) DEFAULT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `time_ingested` datetime NOT NULL,
  `filesize` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30514 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `video_keywords_index`
--

DROP TABLE IF EXISTS `video_keywords_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_keywords_index` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(100) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=52550 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blog_options`
--

DROP TABLE IF EXISTS `wp_blog_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blog_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) unsigned NOT NULL,
  `option_name` varchar(64) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`,`blog_id`),
  KEY `blog_id` (`blog_id`),
  KEY `option_id` (`option_id`),
  KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=71635 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blog_postmeta`
--

DROP TABLE IF EXISTS `wp_blog_postmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blog_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`blog_id`,`meta_id`),
  KEY `meta_id` (`meta_id`),
  KEY `blog_id` (`blog_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=2107790 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blog_postmeta_removed`
--

DROP TABLE IF EXISTS `wp_blog_postmeta_removed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blog_postmeta_removed` (
  `meta_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `blog_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blog_posts`
--

DROP TABLE IF EXISTS `wp_blog_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blog_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) unsigned NOT NULL,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` text NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  `account_id` bigint(20) DEFAULT NULL,
  `post_category` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`,`blog_id`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `blog_id` (`blog_id`),
  KEY `post_category` (`post_category`)
) ENGINE=MyISAM AUTO_INCREMENT=56880 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blog_versions`
--

DROP TABLE IF EXISTS `wp_blog_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blog_versions` (
  `blog_id` bigint(20) NOT NULL DEFAULT '0',
  `db_version` varchar(20) NOT NULL DEFAULT '',
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`blog_id`),
  KEY `db_version` (`db_version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_blogs`
--

DROP TABLE IF EXISTS `wp_blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blogs` (
  `blog_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) NOT NULL DEFAULT '0',
  `domain` varchar(200) NOT NULL DEFAULT '',
  `path` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL,
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_count` int(11) NOT NULL DEFAULT '0',
  `public` tinyint(2) NOT NULL DEFAULT '1',
  `archived` enum('0','1') NOT NULL DEFAULT '0',
  `mature` tinyint(2) NOT NULL DEFAULT '0',
  `spam` tinyint(2) NOT NULL DEFAULT '0',
  `deleted` tinyint(2) NOT NULL DEFAULT '0',
  `lang_id` int(11) NOT NULL DEFAULT '0',
  `account_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`blog_id`),
  KEY `domain` (`domain`(50),`path`(5)),
  KEY `lang_id` (`lang_id`),
  KEY `deleted` (`deleted`)
) ENGINE=MyISAM AUTO_INCREMENT=1450 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_activity`
--

DROP TABLE IF EXISTS `wp_bp_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_activity` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `component` enum('blogs','friends','groups','profile') NOT NULL,
  `type` enum('activity_update','created_group','friendship_created','joined_group','left_group','new_blog','new_blog_post','new_member','updated_blog','updated_blog_post') NOT NULL,
  `action` text NOT NULL,
  `content` longtext NOT NULL,
  `primary_link` varchar(150) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT '0',
  `mptt_left` int(11) NOT NULL DEFAULT '0',
  `mptt_right` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `date_recorded` (`date_recorded`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `component` (`component`),
  KEY `type` (`type`),
  KEY `mptt_left` (`mptt_left`),
  KEY `mptt_right` (`mptt_right`),
  KEY `hide_sitewide` (`hide_sitewide`)
) ENGINE=MyISAM AUTO_INCREMENT=85433 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_activity_copy`
--

DROP TABLE IF EXISTS `wp_bp_activity_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_activity_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `component` varchar(75) NOT NULL,
  `type` varchar(75) NOT NULL,
  `action` text NOT NULL,
  `content` longtext NOT NULL,
  `primary_link` varchar(150) NOT NULL,
  `item_id` int(75) NOT NULL,
  `secondary_item_id` varchar(75) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT '0',
  `mptt_left` int(11) NOT NULL DEFAULT '0',
  `mptt_right` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `date_recorded` (`date_recorded`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `component` (`component`),
  KEY `type` (`type`),
  KEY `mptt_left` (`mptt_left`),
  KEY `mptt_right` (`mptt_right`),
  KEY `hide_sitewide` (`hide_sitewide`)
) ENGINE=MyISAM AUTO_INCREMENT=4652 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_activity_meta`
--

DROP TABLE IF EXISTS `wp_bp_activity_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_activity_meta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activity_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_friends`
--

DROP TABLE IF EXISTS `wp_bp_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initiator_user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `date_created` datetime NOT NULL,
  `is_limited` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `initiator_user_id` (`initiator_user_id`),
  KEY `friend_user_id` (`friend_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=516 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_groups`
--

DROP TABLE IF EXISTS `wp_bp_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'public',
  `enable_forum` tinyint(1) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  `account_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=2783 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_groups_copy`
--

DROP TABLE IF EXISTS `wp_bp_groups_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_groups_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'public',
  `enable_forum` tinyint(1) NOT NULL DEFAULT '1',
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_groups_groupmeta`
--

DROP TABLE IF EXISTS `wp_bp_groups_groupmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_groups_groupmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=7410 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_groups_members`
--

DROP TABLE IF EXISTS `wp_bp_groups_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_groups_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_mod` tinyint(1) NOT NULL DEFAULT '0',
  `user_title` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `invite_sent` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `is_admin` (`is_admin`),
  KEY `is_mod` (`is_mod`),
  KEY `user_id` (`user_id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `is_confirmed` (`is_confirmed`)
) ENGINE=MyISAM AUTO_INCREMENT=14409 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_groups_members_bak`
--

DROP TABLE IF EXISTS `wp_bp_groups_members_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_groups_members_bak` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `is_mod` tinyint(1) NOT NULL DEFAULT '0',
  `user_title` varchar(100) NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `is_banned` tinyint(1) NOT NULL DEFAULT '0',
  `invite_sent` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `is_admin` (`is_admin`),
  KEY `is_mod` (`is_mod`),
  KEY `user_id` (`user_id`),
  KEY `inviter_id` (`inviter_id`),
  KEY `is_confirmed` (`is_confirmed`)
) ENGINE=MyISAM AUTO_INCREMENT=1207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_invite_anyone`
--

DROP TABLE IF EXISTS `wp_bp_invite_anyone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_invite_anyone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inviter_id` bigint(20) NOT NULL,
  `email` varchar(75) NOT NULL,
  `message` longtext NOT NULL,
  `group_invitations` longtext,
  `date_invited` datetime NOT NULL,
  `is_joined` tinyint(1) NOT NULL,
  `date_joined` datetime DEFAULT NULL,
  `is_opt_out` tinyint(1) NOT NULL,
  `is_hidden` tinyint(1) NOT NULL,
  `subject` text NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=554 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_messages`
--

DROP TABLE IF EXISTS `wp_bp_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) DEFAULT NULL,
  `recipient_id` int(11) NOT NULL,
  `folder_id` tinyint(1) NOT NULL DEFAULT '1',
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `is_draft` tinyint(1) DEFAULT '0',
  `date_sent` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_messages_messages`
--

DROP TABLE IF EXISTS `wp_bp_messages_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_messages_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` bigint(20) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `date_sent` datetime NOT NULL,
  `message_order` int(10) NOT NULL,
  `sender_is_group` tinyint(1) NOT NULL DEFAULT '0',
  `thread_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `message_order` (`message_order`),
  KEY `sender_is_group` (`sender_is_group`),
  KEY `thread_id` (`thread_id`)
) ENGINE=MyISAM AUTO_INCREMENT=814 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_messages_notices`
--

DROP TABLE IF EXISTS `wp_bp_messages_notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_messages_notices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(200) NOT NULL,
  `message` longtext NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `is_active` (`is_active`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_messages_recipients`
--

DROP TABLE IF EXISTS `wp_bp_messages_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_messages_recipients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `sender_only` tinyint(1) NOT NULL DEFAULT '0',
  `unread_count` int(10) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `thread_id` (`thread_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `sender_only` (`sender_only`),
  KEY `unread_count` (`unread_count`)
) ENGINE=MyISAM AUTO_INCREMENT=3417 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_notifications`
--

DROP TABLE IF EXISTS `wp_bp_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `component_name` varchar(75) NOT NULL,
  `component_action` varchar(75) NOT NULL,
  `date_notified` datetime NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `secondary_item_id` (`secondary_item_id`),
  KEY `user_id` (`user_id`),
  KEY `is_new` (`is_new`),
  KEY `component_name` (`component_name`),
  KEY `component_action` (`component_action`),
  KEY `useritem` (`user_id`,`is_new`)
) ENGINE=MyISAM AUTO_INCREMENT=4527 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_user_blogs`
--

DROP TABLE IF EXISTS `wp_bp_user_blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_user_blogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `blog_id` (`blog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8785 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_user_blogs_blogmeta`
--

DROP TABLE IF EXISTS `wp_bp_user_blogs_blogmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_user_blogs_blogmeta` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=4059 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_user_blogs_blogmeta_copy`
--

DROP TABLE IF EXISTS `wp_bp_user_blogs_blogmeta_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_user_blogs_blogmeta_copy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`id`),
  KEY `blog_id` (`blog_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=1569 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_xprofile_data`
--

DROP TABLE IF EXISTS `wp_bp_xprofile_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_xprofile_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `value` longtext CHARACTER SET latin1 NOT NULL,
  `last_updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3734 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_xprofile_fields`
--

DROP TABLE IF EXISTS `wp_bp_xprofile_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_xprofile_fields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint(20) unsigned NOT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `type` varchar(150) CHARACTER SET latin1 NOT NULL,
  `name` varchar(150) CHARACTER SET latin1 NOT NULL,
  `description` longtext CHARACTER SET latin1 NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `can_delete` tinyint(1) NOT NULL DEFAULT '1',
  `is_default_option` tinyint(1) NOT NULL DEFAULT '0',
  `field_order` bigint(20) NOT NULL DEFAULT '0',
  `option_order` bigint(20) NOT NULL DEFAULT '0',
  `order_by` varchar(15) CHARACTER SET latin1 NOT NULL,
  `is_public` int(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `parent_id` (`parent_id`),
  KEY `is_public` (`is_public`),
  KEY `can_delete` (`can_delete`),
  KEY `is_required` (`is_required`),
  KEY `field_order` (`field_order`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_bp_xprofile_groups`
--

DROP TABLE IF EXISTS `wp_bp_xprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bp_xprofile_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET latin1 NOT NULL,
  `description` mediumtext CHARACTER SET latin1 NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `can_delete` (`can_delete`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_compAnswers`
--

DROP TABLE IF EXISTS `wp_compAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_compAnswers` (
  `ansID` int(11) NOT NULL AUTO_INCREMENT,
  `qID` int(11) NOT NULL,
  `ansText` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ansID`),
  KEY `qID` (`qID`)
) ENGINE=MyISAM AUTO_INCREMENT=1065 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_compEntries`
--

DROP TABLE IF EXISTS `wp_compEntries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_compEntries` (
  `compID` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `entry_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `entry_score` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`compID`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_compEntryAnswers`
--

DROP TABLE IF EXISTS `wp_compEntryAnswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_compEntryAnswers` (
  `qID` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `selected_ansID` int(11) NOT NULL,
  PRIMARY KEY (`qID`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_compQuestions`
--

DROP TABLE IF EXISTS `wp_compQuestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_compQuestions` (
  `qID` int(11) NOT NULL AUTO_INCREMENT,
  `compID` int(11) NOT NULL,
  `correctAnsID` int(11) DEFAULT NULL,
  `qText` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`qID`),
  KEY `compID` (`compID`)
) ENGINE=MyISAM AUTO_INCREMENT=358 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_competitions`
--

DROP TABLE IF EXISTS `wp_competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_competitions` (
  `compID` int(11) NOT NULL AUTO_INCREMENT,
  `catID` int(11) NOT NULL DEFAULT '0',
  `compTitle` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `compLead` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `compDesc` longtext CHARACTER SET latin1 NOT NULL,
  `compDetails` longtext CHARACTER SET latin1 NOT NULL,
  `image_small` char(128) NOT NULL,
  `image_mid` char(128) NOT NULL,
  `image_big` char(128) NOT NULL,
  `compStart` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `compEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `compWinningUser` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`compID`),
  KEY `compEnd` (`compEnd`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_competitions_bak`
--

DROP TABLE IF EXISTS `wp_competitions_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_competitions_bak` (
  `compID` int(11) NOT NULL AUTO_INCREMENT,
  `catID` int(11) NOT NULL DEFAULT '0',
  `compTitle` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `compLead` varchar(200) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `compDesc` longtext CHARACTER SET latin1 NOT NULL,
  `compDetails` longtext CHARACTER SET latin1 NOT NULL,
  `image_small` char(128) NOT NULL,
  `image_big` char(128) NOT NULL,
  `compStart` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `compEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `compWinningUser` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`compID`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_countries`
--

DROP TABLE IF EXISTS `wp_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_countries` (
  `country_key` varchar(3) NOT NULL,
  `country_name` varchar(100) NOT NULL DEFAULT '',
  `html_name` varchar(100) NOT NULL DEFAULT '',
  `sort_precedence` tinyint(3) unsigned DEFAULT '100',
  PRIMARY KEY (`country_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_emails`
--

DROP TABLE IF EXISTS `wp_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_emails` (
  `email` varchar(128) COLLATE latin1_general_ci NOT NULL,
  `send_nl` tinyint(1) NOT NULL,
  `action_date` datetime NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_events`
--

DROP TABLE IF EXISTS `wp_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_events` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `blog_id` bigint(20) DEFAULT NULL,
  `eventTitle` varchar(255) CHARACTER SET utf8 NOT NULL,
  `eventDescription` text CHARACTER SET utf8 NOT NULL,
  `eventLocation` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `eventImage` varchar(255) CHARACTER SET utf8 NOT NULL,
  `eventStartDate` date NOT NULL,
  `eventStartTime` time DEFAULT NULL,
  `eventEndDate` date NOT NULL,
  `eventEndTime` time DEFAULT NULL,
  `postID` mediumint(9) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_occupations`
--

DROP TABLE IF EXISTS `wp_occupations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_occupations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `oc_name` varchar(50) NOT NULL DEFAULT '',
  `sort_precedence` tinyint(3) unsigned DEFAULT '100',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_registration_log`
--

DROP TABLE IF EXISTS `wp_registration_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_registration_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `IP` varchar(30) NOT NULL DEFAULT '',
  `blog_id` bigint(20) NOT NULL DEFAULT '0',
  `date_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `IP` (`IP`)
) ENGINE=MyISAM AUTO_INCREMENT=1402 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_signups`
--

DROP TABLE IF EXISTS `wp_signups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_signups` (
  `domain` varchar(200) NOT NULL DEFAULT '',
  `path` varchar(100) NOT NULL DEFAULT '',
  `title` longtext NOT NULL,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `activation_key` varchar(50) NOT NULL DEFAULT '',
  `meta` longtext,
  KEY `activation_key` (`activation_key`),
  KEY `domain` (`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_similar_posts`
--

DROP TABLE IF EXISTS `wp_similar_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_similar_posts` (
  `pID` bigint(20) unsigned NOT NULL,
  `blog_id` bigint(20) unsigned NOT NULL,
  `content` longtext NOT NULL,
  `title` text NOT NULL,
  `post_title` varchar(128) NOT NULL,
  `post_status` varchar(20) NOT NULL,
  `tags` text NOT NULL,
  KEY `pID` (`pID`),
  KEY `blog_id` (`blog_id`),
  FULLTEXT KEY `title` (`title`),
  FULLTEXT KEY `content` (`content`),
  FULLTEXT KEY `tags` (`tags`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_site`
--

DROP TABLE IF EXISTS `wp_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_site` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `domain` varchar(200) NOT NULL DEFAULT '',
  `path` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`,`path`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_sitecategories`
--

DROP TABLE IF EXISTS `wp_sitecategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_sitecategories` (
  `cat_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(55) NOT NULL DEFAULT '',
  `category_nicename` varchar(200) NOT NULL DEFAULT '',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cat_ID`),
  KEY `category_nicename` (`category_nicename`),
  KEY `last_updated` (`last_updated`)
) ENGINE=MyISAM AUTO_INCREMENT=24366 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_sitemeta`
--

DROP TABLE IF EXISTS `wp_sitemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_sitemeta` (
  `meta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `site_id` bigint(20) NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `meta_key` (`meta_key`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23305 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_sponsors`
--

DROP TABLE IF EXISTS `wp_sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_sponsors` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `sponsor` varchar(128) NOT NULL,
  `url` varchar(256) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `sponsor` (`sponsor`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_sponsors_media`
--

DROP TABLE IF EXISTS `wp_sponsors_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_sponsors_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sponsor_id` int(11) NOT NULL,
  `url` varchar(256) NOT NULL,
  `type` char(1) NOT NULL,
  `quality` smallint(6) NOT NULL,
  `bitrate` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sponsor_id` (`sponsor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=283 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_usermeta`
--

DROP TABLE IF EXISTS `wp_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=246377 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_usermeta_bak`
--

DROP TABLE IF EXISTS `wp_usermeta_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usermeta_bak` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=MyISAM AUTO_INCREMENT=227844 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_users`
--

DROP TABLE IF EXISTS `wp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  `spam` tinyint(2) NOT NULL DEFAULT '0',
  `deleted` tinyint(2) NOT NULL DEFAULT '0',
  `fbID` bigint(20) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `lfw_interest` tinyint(4) NOT NULL,
  `terms_conditions` tinyint(4) NOT NULL,
  `reference_to_signup` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=20653 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_users_bak`
--

DROP TABLE IF EXISTS `wp_users_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_users_bak` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(64) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  `spam` tinyint(2) NOT NULL DEFAULT '0',
  `deleted` tinyint(2) NOT NULL DEFAULT '0',
  `fbID` bigint(20) NOT NULL DEFAULT '0',
  `user_type` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=17123 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wpb2`
--

DROP TABLE IF EXISTS `wpb2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wpb2` (
  `blog_id` bigint(20) NOT NULL DEFAULT '0',
  `post_count` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_demographics_data`
--

DROP TABLE IF EXISTS `youtube_demographics_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_demographics_data` (
  `yid` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `video_id` varchar(64) NOT NULL,
  `title` text NOT NULL,
  `gender` varchar(6) NOT NULL,
  `age_group` varchar(8) NOT NULL,
  `percentage` float(5,2) NOT NULL,
  PRIMARY KEY (`yid`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_gdata`
--

DROP TABLE IF EXISTS `youtube_gdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_gdata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `vid` varchar(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `categories` text,
  `view_count` bigint(20) NOT NULL,
  `like_count` bigint(20) NOT NULL,
  `dislike_count` bigint(20) NOT NULL,
  `keywords` text,
  `thumbnail_urls` text,
  `average_rating` float(9,6) NOT NULL,
  `total_rating` bigint(20) NOT NULL,
  `yt_updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=968 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_location_data`
--

DROP TABLE IF EXISTS `youtube_location_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_location_data` (
  `yid` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `region` char(2) NOT NULL,
  `video_id` varchar(64) NOT NULL,
  `title` text NOT NULL,
  `player_location` varchar(64) NOT NULL,
  `detail` text NOT NULL,
  `views` int(11) NOT NULL,
  PRIMARY KEY (`yid`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_policies`
--

DROP TABLE IF EXISTS `youtube_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) NOT NULL DEFAULT '0',
  `policy_type` varchar(255) DEFAULT NULL,
  `policy_value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_referrers_data`
--

DROP TABLE IF EXISTS `youtube_referrers_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_referrers_data` (
  `yid` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `region` char(2) NOT NULL,
  `video_id` varchar(64) NOT NULL,
  `title` text NOT NULL,
  `source_type` varchar(64) NOT NULL,
  `detail` text NOT NULL,
  `referred_views` int(11) NOT NULL,
  PRIMARY KEY (`yid`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_video_cron_detail`
--

DROP TABLE IF EXISTS `youtube_video_cron_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_video_cron_detail` (
  `ycid` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` varchar(64) NOT NULL,
  `last_cron_date` datetime NOT NULL,
  `next_cron_date` datetime NOT NULL,
  PRIMARY KEY (`ycid`),
  UNIQUE KEY `video_id` (`video_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `youtube_views_data`
--

DROP TABLE IF EXISTS `youtube_views_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `youtube_views_data` (
  `yid` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `region` char(2) NOT NULL,
  `video_id` varchar(64) NOT NULL,
  `title` text NOT NULL,
  `views` int(11) NOT NULL,
  `unique_users` int(11) NOT NULL,
  `unique_users_7_days` int(11) NOT NULL,
  `unique_users_30_days` int(11) NOT NULL,
  `popularity` float(11,10) NOT NULL,
  `comments` int(11) NOT NULL,
  `favorites` int(11) NOT NULL,
  `rating_1` int(5) NOT NULL,
  `rating_2` int(5) NOT NULL,
  `rating_3` int(5) NOT NULL,
  `rating_4` int(5) NOT NULL,
  `rating_5` int(5) NOT NULL,
  PRIMARY KEY (`yid`)
) ENGINE=MyISAM AUTO_INCREMENT=11258 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_account_daily_fact`
--

DROP TABLE IF EXISTS `yt_account_daily_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_account_daily_fact` (
  `account_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  UNIQUE KEY `account_id` (`account_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_countries`
--

DROP TABLE IF EXISTS `yt_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_countries` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `iso_code` varchar(3) NOT NULL,
  `country_name` varchar(100) NOT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `iso_code` (`iso_code`)
) ENGINE=MyISAM AUTO_INCREMENT=339 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_country_daily_fact`
--

DROP TABLE IF EXISTS `yt_country_daily_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_country_daily_fact` (
  `account_id` bigint(20) NOT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  UNIQUE KEY `account_id` (`account_id`,`country_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_master_fact`
--

DROP TABLE IF EXISTS `yt_master_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_master_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `video_id` bigint(20) NOT NULL,
  `yt_video_id` varchar(45) NOT NULL,
  `country` int(3) NOT NULL,
  `date` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_id` (`video_id`,`country`,`date`),
  KEY `date` (`date`),
  KEY `project_id` (`project_id`),
  KEY `account_id` (`account_id`),
  KEY `country` (`country`)
) ENGINE=MyISAM AUTO_INCREMENT=2314011 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_project_country_daily_fact`
--

DROP TABLE IF EXISTS `yt_project_country_daily_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_project_country_daily_fact` (
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  UNIQUE KEY `project_id` (`project_id`,`country_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_project_daily_fact`
--

DROP TABLE IF EXISTS `yt_project_daily_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_project_daily_fact` (
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  UNIQUE KEY `project_id` (`project_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_raw_fact`
--

DROP TABLE IF EXISTS `yt_raw_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_raw_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) NOT NULL,
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `country_id` int(3) NOT NULL,
  `yt_id` varchar(50) NOT NULL,
  `data_video_id` varchar(50) NOT NULL,
  `data_custom_id` varchar(50) NOT NULL,
  `data_day` date NOT NULL,
  `data_country` varchar(20) NOT NULL,
  `data_content_type` varchar(255) NOT NULL DEFAULT '',
  `data_policy` varchar(50) NOT NULL DEFAULT '',
  `data_total_views` int(11) NOT NULL DEFAULT '0',
  `data_watch_page_views` int(11) NOT NULL DEFAULT '0',
  `data_channel_page_video_views` int(11) NOT NULL DEFAULT '0',
  `data_embebbed_player_views` int(11) NOT NULL DEFAULT '0',
  `data_live_views` int(11) NOT NULL DEFAULT '0',
  `data_recorded_views` int(11) NOT NULL DEFAULT '0',
  `data_ad_enabled_views` int(11) NOT NULL DEFAULT '0',
  `data_ad_req_views` int(11) NOT NULL DEFAULT '0',
  `data_total_earnings` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_gross_yt_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_gross_partner_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `gross_adsense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_net_youtube_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_net_adsense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `video_id` (`video_id`),
  KEY `country_id` (`country_id`),
  KEY `data_day` (`data_day`)
) ENGINE=MyISAM AUTO_INCREMENT=10198327 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_reports_data`
--

DROP TABLE IF EXISTS `yt_reports_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_reports_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yt_id` varchar(50) NOT NULL,
  `account_id` bigint(20) NOT NULL DEFAULT '0',
  `project_name` varchar(255) DEFAULT NULL,
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `process_cnt` int(3) NOT NULL DEFAULT '0',
  `updated_time` datetime NOT NULL,
  `last_processed_time` datetime NOT NULL,
  `post_id` bigint(20) NOT NULL DEFAULT '0',
  `needs_update` tinyint(1) NOT NULL DEFAULT '0',
  `data_video_id` varchar(50) NOT NULL,
  `data_claim_id` varchar(50) NOT NULL,
  `data_asset_id` varchar(50) NOT NULL,
  `data_uploader` varchar(50) NOT NULL,
  `data_title` varchar(255) NOT NULL,
  `data_views` int(11) NOT NULL,
  `data_status` varchar(20) NOT NULL,
  `data_claim_origin` varchar(50) NOT NULL,
  `data_claim_type` varchar(50) NOT NULL,
  `data_is_partner_upload` tinyint(1) NOT NULL DEFAULT '0',
  `data_is_premium` tinyint(1) NOT NULL DEFAULT '0',
  `data_ref_video_id` varchar(50) NOT NULL,
  `data_applied_policy` varchar(500) NOT NULL,
  `data_claim_date` date NOT NULL,
  `data_upload_date` date NOT NULL,
  `data_show_title` varchar(255) NOT NULL,
  `data_director` varchar(100) NOT NULL,
  `data_tms` varchar(50) NOT NULL,
  `data_release_date` varchar(20) NOT NULL,
  `data_studio` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `yt_id` (`yt_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25849 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_reports_data_raw`
--

DROP TABLE IF EXISTS `yt_reports_data_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_reports_data_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `yt_id` varchar(50) NOT NULL,
  `data_video_id` varchar(50) NOT NULL,
  `data_custom_id` varchar(50) NOT NULL,
  `data_day` date NOT NULL,
  `data_country` varchar(20) NOT NULL,
  `data_content_type` varchar(255) NOT NULL DEFAULT '',
  `data_policy` varchar(50) NOT NULL DEFAULT '',
  `data_total_views` int(11) NOT NULL DEFAULT '0',
  `data_watch_page_views` int(11) NOT NULL DEFAULT '0',
  `data_channel_page_video_views` int(11) NOT NULL DEFAULT '0',
  `data_embebbed_player_views` int(11) NOT NULL DEFAULT '0',
  `data_live_views` int(11) NOT NULL DEFAULT '0',
  `data_recorded_views` int(11) NOT NULL DEFAULT '0',
  `data_ad_enabled_views` int(11) NOT NULL DEFAULT '0',
  `data_ad_req_views` int(11) NOT NULL DEFAULT '0',
  `data_total_earnings` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_gross_yt_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_gross_partner_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `gross_adsense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_net_youtube_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `data_net_adsense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `added_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `yt_id` (`yt_id`)
) ENGINE=MyISAM AUTO_INCREMENT=16358184 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_reports_mapping`
--

DROP TABLE IF EXISTS `yt_reports_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_reports_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uploader_name` varchar(255) DEFAULT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uploader_name` (`uploader_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yt_video_daily_fact`
--

DROP TABLE IF EXISTS `yt_video_daily_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yt_video_daily_fact` (
  `account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `video_id` bigint(20) NOT NULL,
  `yt_video_id` varchar(45) NOT NULL,
  `day` date NOT NULL,
  `total_views` int(11) NOT NULL,
  `watch_page_views` int(11) NOT NULL,
  `embedded_player_views` int(11) NOT NULL,
  `channel_page_video_views` int(11) NOT NULL,
  `net_revenue` float(11,7) NOT NULL,
  `net_youtube_sold_revenue` float(11,7) NOT NULL,
  `net_adsense_sold_revenue` float(11,7) NOT NULL,
  UNIQUE KEY `video_id` (`video_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-11-27 17:26:33
