DROP procedure IF EXISTS  generic_etl;
DROP procedure IF EXISTS  generic_etl_bulk;

DELIMITER //
CREATE PROCEDURE generic_etl()
BEGIN
   call populate_generic_master_fact_from_liverail();
   call populate_generic_master_fact_from_youtube();			
   call populate_generic_master_fact_from_summary_plays();		
   call populate_generic_master_fact_from_summary_views();
   call update_generic_master_fact_for_duplicate_videos();
   call populate_generic_account_daily_fact();
   call populate_generic_project_daily_fact();
   call populate_generic_video_daily_fact();
   call populate_generic_country_daily_fact();
   call populate_generic_device_daily_fact();
   call proc_aggregate_device_all_time_from_generic_device_daily_fact();
   call proc_aggregate_country_all_time_from_generic_country_daily_fact();
   call proc_aggregate_video_all_time_from_generic_video_daily_fact();
   call populate_publisher_content_ad_impressions();
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE generic_etl_bulk()
BEGIN
   call populate_generic_master_fact_from_liverail();
   call populate_generic_master_fact_from_youtube(); 
   call populate_generic_master_fact_from_summary_plays_bulk();              
   call populate_generic_master_fact_from_summary_views_bulk();
   call update_generic_master_fact_for_duplicate_videos();
   call populate_generic_account_daily_fact();
   call populate_generic_project_daily_fact();
   call populate_generic_video_daily_fact();
   call populate_generic_country_daily_fact();
   call populate_generic_device_daily_fact();
   call proc_aggregate_device_all_time_from_generic_device_daily_fact();
   call proc_aggregate_country_all_time_from_generic_country_daily_fact();
   call proc_aggregate_video_all_time_from_generic_video_daily_fact();
   call populate_publisher_content_ad_impressions();
END //
DELIMITER ;

