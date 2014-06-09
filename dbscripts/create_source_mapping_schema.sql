CREATE TABLE `ui_source_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



CREATE TABLE `source_dimension_mapping` (
  `ui_source_id` smallint NOT NULL,
  `source_id` smallint NOT NULL,
  UNIQUE KEY `unique_key` (`ui_source_id`, `source_id`),
  KEY `ui_source_id` (`ui_source_id`),
  KEY `source_id` (`source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

