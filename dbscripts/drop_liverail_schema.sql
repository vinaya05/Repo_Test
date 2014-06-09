-- Drop procedures
DROP PROCEDURE IF EXISTS liverail_etl;
DROP PROCEDURE IF EXISTS aggregate_liverail_facts;
DROP PROCEDURE IF EXISTS populate_liverail_project_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_video_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_account_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_country_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_project_country_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_device_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_project_device_daily_fact;
DROP PROCEDURE IF EXISTS populate_liverail_master_fact;
DROP PROCEDURE IF EXISTS populate_liverail_master_fact;
DROP PROCEDURE IF EXISTS populate_liverail_stage;

-- Drop tables

DROP TABLE IF EXISTS `liverail_project_daily_fact`;
DROP TABLE IF EXISTS `liverail_video_daily_fact`;
DROP TABLE IF EXISTS `liverail_account_daily_fact`;
DROP TABLE IF EXISTS `liverail_country_daily_fact`;
DROP TABLE IF EXISTS `liverail_project_country_daily_fact`;
DROP TABLE IF EXISTS `liverail_device_daily_fact`;
DROP TABLE IF EXISTS liverail_project_device_daily_fact;
DROP TABLE IF EXISTS liverail_master_fact;
DROP TABLE IF EXISTS liverail_stage;
DROP TABLE IF EXISTS liverail_raw;
DROP TABLE IF EXISTS liverail_raw_processed;
DROP TABLE IF EXISTS liverail_countries;
DROP TABLE IF EXISTS liverail_device_mapping;
DROP TABLE IF EXISTS device_dimension;
DROP TABLE IF EXISTS high_water_mark;
DROP TABLE IF EXISTS liverail_third_party_player_publisher;
