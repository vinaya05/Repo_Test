--
-- Table structure for table `yt_social_info_raw`
--

DROP TABLE IF EXISTS `yt_social_info_raw`;

CREATE TABLE `yt_social_info_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cms_account` varchar(255) NOT NULL,
  `channel_id` varchar(255) NOT NULL,
  `channel_name` varchar(255) NOT NULL,
  `yt_video_id` varchar(255) NOT NULL,
  `day` date NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'Unknown',
  `country_raw` varchar(255) DEFAULT NULL,
  `os` varchar(100) NOT NULL DEFAULT 'Unknown',
  `os_raw` varchar(255) DEFAULT NULL,
  `views_count` int(11) NOT NULL DEFAULT '0',
  `likes_count` int(11) NOT NULL DEFAULT '0',
  `dislikes_count` int(11) NOT NULL DEFAULT '0',  
  `subscribers_count` int(11) NOT NULL DEFAULT '0',
  `comments_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_account` (`cms_account`),
  KEY `channel_id` (`channel_id`),
  KEY `channel_name` (`channel_name`),
  KEY `yt_video_id` (`yt_video_id`),
  KEY `day` (`day`),
  KEY `country` (`country`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `yt_social_info_raw_processed` LIKE `yt_social_info_raw`;
ALTER TABLE `yt_social_info_raw_processed` ADD COLUMN `processed_on` timestamp DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `yt_social_info_raw_processed` ADD COLUMN `run_name` varchar(255) DEFAULT 'Unnamed' AFTER id;

--
-- Table structure for table `yt_revenue_info_raw`
--

DROP TABLE IF EXISTS `yt_revenue_info_raw`;

CREATE TABLE `yt_revenue_info_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `yt_video_id` varchar(255) NOT NULL,
  `yt_video_id_raw` varchar(255) NOT NULL,
  `custom_id` varchar(255) NOT NULL,
  `day` date NOT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'Unknown',
  `country_raw` varchar(255) DEFAULT NULL,
  `os` varchar(100) NOT NULL DEFAULT 'Unknown',
  `os_raw` varchar(255) DEFAULT NULL,
  `content_type` varchar(255) NOT NULL DEFAULT 'Unknown',
  `policy` varchar(255) NOT NULL DEFAULT 'Unknown',
  `total_views` int(11) NOT NULL DEFAULT '0',
  `watch_page_views` int(11) NOT NULL DEFAULT '0',
  `embedded_player_views` int(11) NOT NULL DEFAULT '0',
  `channel_page_video_views` int(11) NOT NULL DEFAULT '0',
  `live_views` int(11) NOT NULL DEFAULT '0',
  `recorded_views` int(11) NOT NULL DEFAULT '0',
  `ad_enabled_views` int(11) NOT NULL DEFAULT '0',
  `ad_requested_views` int(11) NOT NULL DEFAULT '0',
  `total_earnings` float(11,7) NOT NULL DEFAULT '0.0000000',
  `gross_youtube_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `gross_partner_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `gross_ad_sense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  `net_youtube_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',  
  `net_ad_sense_sold_revenue` float(11,7) NOT NULL DEFAULT '0.0000000',
  PRIMARY KEY (`id`),
  KEY `yt_video_id` (`yt_video_id`),
  KEY `day` (`day`),
  KEY `country` (`country`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `yt_revenue_info_raw_processed` LIKE `yt_revenue_info_raw`;
ALTER TABLE `yt_revenue_info_raw_processed` ADD COLUMN `processed_on` timestamp DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `yt_revenue_info_raw_processed` ADD COLUMN `run_name` varchar(255) DEFAULT 'Unnamed' AFTER id;

--
-- Table structure for table `yt_reports_master_fact`
--

DROP TABLE IF EXISTS `yt_reports_master_fact`;

CREATE TABLE `yt_reports_master_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `video_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `device_id` int(2) NOT NULL,
  `country_id` int(3) NOT NULL,
  `content_type` int(2) NOT NULL DEFAULT '-1',
  `source_id` smallint NOT NULL,
  `views_count` int(11) NOT NULL DEFAULT '0',
  `cms_views_count` int(11) NOT NULL DEFAULT '0',
  `likes_count` int(11) NOT NULL DEFAULT '0',
  `dislikes_count` int(11) NOT NULL DEFAULT '0',  
  `subscribers_count` int(11) NOT NULL DEFAULT '0',
  `comments_count` int(11) NOT NULL DEFAULT '0',
  `ad_enabled_views` int(11) DEFAULT NULL,
  `ad_requested_views` int(11) DEFAULT NULL,
  `gross_youtube_sold_revenue` float(11,7) DEFAULT NULL,
  `gross_partner_sold_revenue` float(11,7) DEFAULT NULL,
  `gross_ad_sense_sold_revenue` float(11,7) DEFAULT NULL,
  `net_youtube_sold_revenue` float(11,7) DEFAULT NULL,
  `net_ad_sense_sold_revenue` float(11,7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`account_id`,`pub_account_id`,`project_id`,`video_id`,`device_id`,`content_type`,`source_id`,`country_id`,`day`),
  KEY `account_id` (`account_id`),
  KEY `project_id` (`project_id`),
  KEY `video_id` (`video_id`),
  KEY `day` (`day`),
  KEY `device_id` (`device_id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `yt_content_mapping` (
  `id` bigint(20) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `content_type` (`content_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
