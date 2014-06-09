CREATE TABLE `high_water_mark` (
  `from_table_name` varchar(64),
  `to_table_name` varchar(64),
  `mark` bigint(20),
  PRIMARY KEY (`from_table_name`, `to_table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `device_dimension` (
  `device_id` int(2) NOT NULL,
  `name` varchar(255),
  PRIMARY KEY (`device_id`),
  UNIQUE KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_device_mapping` (
  `os` varchar(255) NOT NULL,
  `device_id` int(2) NOT NULL,
  PRIMARY KEY (`os`),
  KEY `device_id` (`device_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_countries` (
  `name` varchar(100) NOT NULL,
  `country_id` int(3) NOT NULL,
  PRIMARY KEY(`name`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_third_party_player_publisher` (
  `partner_id` int(11) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `co_account_id` bigint(20) NOT NULL,
  PRIMARY KEY(`partner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Can not apply this constraint as yt_countries is a MyISAM table
--  FOREIGN KEY fk_country_id (country_id) REFERENCES yt_countries (country_id)

CREATE OR REPLACE VIEW `liverail_partner_mapping` (
  `partner_id`,
  `pub_account_id`
)
AS
SELECT
    DISTINCT
    lr_partnerid,
    account_id
FROM
    v3.publisher_tracking_codes;

CREATE TABLE `liverail_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `partnername` varchar(128),
  `partnerid` int(11) NOT NULL DEFAULT -1,
  `partnerid_raw` varchar(100),
  `country` varchar(100) NOT NULL DEFAULT 'Unknown',
  `country_raw` varchar(64),
  `mediaid` varchar(64) DEFAULT NULL,
  `os` varchar(100) NOT NULL DEFAULT 'Unknown',
  `os_raw` varchar(64),
  `date` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `ctr` DOUBLE(20,4),
  `ecpm` DOUBLE(20,4),
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`partnerid_raw`, `country_raw`,`mediaid`,`os_raw`,`date`),
  KEY (`partnerid`),
  KEY (`country`),
  KEY (`mediaid`),
  KEY (`os`),
  KEY (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_raw_processed` LIKE `liverail_raw`;
ALTER TABLE `liverail_raw_processed` ADD COLUMN `processed_on` timestamp DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `liverail_raw_processed` ADD COLUMN `run_name` varchar(255) DEFAULT 'Unnamed' AFTER id;
ALTER TABLE `liverail_raw_processed` DROP KEY `unique_key`;

CREATE TABLE `liverail_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) NOT NULL DEFAULT -1,
  `partner_id` int(11) NOT NULL DEFAULT -1,
  `device_id` int(2) NOT NULL DEFAULT 1,
  `country_id` int(3) NOT NULL DEFAULT 338,
  `day` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`playlist_id`, `partner_id`,`device_id`, `country_id`, `day`),
  KEY (`playlist_id`),
  KEY (`partner_id`),
  KEY (`device_id`),
  KEY (`country_id`),
  KEY (`day`)

) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_master_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `co_video_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `device_id` int(2) NOT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(14,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`co_video_id`,`pub_account_id`,`device_id`,`country_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `co_video_id` (`co_video_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `device_id` (`device_id`),
  KEY `country_id` (`country_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_project_device_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `device_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`pub_account_id`,`device_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `device_id` (`device_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_device_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `device_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`,`pub_account_id`,`device_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `device_id` (`device_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_project_country_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`pub_account_id`,`country_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `country_id` (`country_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_country_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`,`pub_account_id`,`country_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `country_id` (`country_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_account_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`,`pub_account_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



CREATE TABLE `liverail_video_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `co_video_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`co_video_id`,`pub_account_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `co_video_id` (`co_video_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_project_daily_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(11,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`pub_account_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_order_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `partnername` varchar(128),
  `partnerid` int(11) NOT NULL DEFAULT -1,
  `partnerid_raw` varchar(100),
  `country` varchar(100) NOT NULL DEFAULT 'Unknown',
  `country_raw` varchar(64),
  `mediaid` varchar(64) DEFAULT NULL,
  `order_raw` varchar(64),
  `date` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `inventory_fill` DOUBLE(20,4),
  `ecpm` DOUBLE(20,4),
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`partnerid_raw`, `country_raw`,`mediaid`,`order_raw`,`date`),
  KEY (`partnerid`),
  KEY (`country`),
  KEY (`mediaid`),
  KEY (`order_raw`),
  KEY (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_adsource_raw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `partnername` varchar(128),
  `partnerid` int(11) NOT NULL DEFAULT -1,
  `partnerid_raw` varchar(100),
  `country` varchar(100) NOT NULL DEFAULT 'Unknown',
  `country_raw` varchar(64),
  `mediaid` varchar(64) DEFAULT NULL,
  `adsource_raw` varchar(64),
  `date` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `inventory_fill` DOUBLE(20,4),
  `ecpm` DOUBLE(20,4),
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`partnerid_raw`, `country_raw`,`mediaid`,`adsource_raw`,`date`),
  KEY (`partnerid`),
  KEY (`country`),
  KEY (`mediaid`),
  KEY (`adsource_raw`),
  KEY (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_order_raw_processed` LIKE `liverail_order_raw`;
ALTER TABLE `liverail_order_raw_processed` ADD COLUMN `processed_on` timestamp DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `liverail_order_raw_processed` ADD COLUMN `run_name` varchar(255) DEFAULT 'Unnamed' AFTER id;
ALTER TABLE `liverail_order_raw_processed` DROP KEY `unique_key`;

CREATE TABLE `liverail_adsource_raw_processed` LIKE `liverail_adsource_raw`;
ALTER TABLE `liverail_adsource_raw_processed` ADD COLUMN `processed_on` timestamp DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `liverail_adsource_raw_processed` ADD COLUMN `run_name` varchar(255) DEFAULT 'Unnamed' AFTER id;
ALTER TABLE `liverail_adsource_raw_processed` DROP KEY `unique_key`;

CREATE TABLE `liverail_order_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) NOT NULL DEFAULT -1,
  `partner_id` int(11) NOT NULL DEFAULT -1,
  `order` varchar(64) NOT NULL,
  `country_id` int(3) NOT NULL DEFAULT 338,
  `day` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `inventory_fill` DOUBLE(20,4) NOT NULL DEFAULT 0,
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`playlist_id`, `partner_id`,`order`, `country_id`, `day`),
  KEY (`playlist_id`),
  KEY (`partner_id`),
  KEY (`order`),
  KEY (`country_id`),
  KEY (`day`)

) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `liverail_adsource_stage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) NOT NULL DEFAULT -1,
  `partner_id` int(11) NOT NULL DEFAULT -1,
  `adsource` varchar(64) NOT NULL,
  `country_id` int(3) NOT NULL DEFAULT 338,
  `day` date NOT NULL,
  `clickthroughs` int(11) NOT NULL DEFAULT 0,
  `impressions` int(11) NOT NULL DEFAULT 0,
  `inventory_fill` DOUBLE(20,4) NOT NULL DEFAULT 0,
  `revenue` float(11,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`playlist_id`, `partner_id`,`adsource`, `country_id`, `day`),
  KEY (`playlist_id`),
  KEY (`partner_id`),
  KEY (`adsource`),
  KEY (`country_id`),
  KEY (`day`)

) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `liverail_revenue_master_fact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `co_video_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `order` varchar(64) DEFAULT NULL,
  `adsource` varchar(64) DEFAULT NULL,
  `country_id` int(3) NOT NULL,
  `day` date NOT NULL,
  `ad_clicks` int(11) NOT NULL,
  `ad_impressions` int(11) NOT NULL,
  `inventory_fill` DOUBLE(20,4) NOT NULL,
  `ad_revenue` float(11,4) NOT NULL,
  `ecpm` float(14,7) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`co_video_id`,`pub_account_id`,`order`,`adsource`,`country_id`,`day`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `co_video_id` (`co_video_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `order` (`order`),
  KEY `adsource` (`adsource`),
  KEY `country_id` (`country_id`),
  KEY `day` (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



