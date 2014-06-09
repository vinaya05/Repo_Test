use t5m_stats;

CREATE TABLE `aggregate_video_all_time` (
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `co_video_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `content_type` int(2) NOT NULL DEFAULT 0,
  `source_id` smallint NOT NULL,
  `loads` bigint(20),
  `plays` bigint(20),
  `ad_clicks` bigint(20),
  `ad_impressions` bigint(20),
  `ad_revenue` float(11,4),
  `inventory_pre` int(11),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`co_video_id`, `content_type`, `pub_account_id`,`source_id`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `co_video_id` (`co_video_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `source_id` (`source_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `aggregate_country_all_time` (
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `content_type` int(2) NOT NULL DEFAULT 0,
  `source_id` smallint NOT NULL,
  `country_id` int(3) NOT NULL,
  `loads` bigint(20),
  `plays` bigint(20),
  `ad_clicks` int(11),
  `ad_impressions` int(11),
  `ad_revenue` float(11,4),
  `inventory_pre` int(11),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`pub_account_id`,`source_id`, `content_type`, `country_id`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `source_id` (`source_id`),
  KEY `country_id` (`country_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `aggregate_device_all_time` (
  `co_account_id` bigint(20) NOT NULL,
  `co_project_id` bigint(20) NOT NULL,
  `pub_account_id` bigint(20) NOT NULL,
  `content_type` int(2) NOT NULL DEFAULT 0,
  `source_id` smallint NOT NULL,
  `device_id` int(3) NOT NULL,
  `loads` bigint(20),
  `plays` bigint(20),
  `ad_clicks` int(11),
  `ad_impressions` int(11),
  `ad_revenue` float(11,4),
  `inventory_pre` int(11),
  UNIQUE KEY `unique_key` (`co_account_id`, `co_project_id`,`pub_account_id`,`source_id`, `content_type`, `device_id`),
  KEY `co_account_id` (`co_account_id`),
  KEY `co_project_id` (`co_project_id`),
  KEY `pub_account_id` (`pub_account_id`),
  KEY `source_id` (`source_id`),
  KEY `device_id` (`device_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
