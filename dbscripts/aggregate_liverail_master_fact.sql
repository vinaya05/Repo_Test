
source procedures/populate_liverail_project_device_daily_fact.sql
source procedures/populate_liverail_device_daily_fact.sql
source procedures/populate_liverail_project_country_daily_fact.sql
source procedures/populate_liverail_country_daily_fact.sql
source procedures/populate_liverail_account_daily_fact.sql
source procedures/populate_liverail_project_daily_fact.sql
source procedures/populate_liverail_video_daily_fact.sql

DELIMITER //
CREATE PROCEDURE aggregate_liverail_facts()
BEGIN
  call populate_liverail_project_device_daily_fact();
  call populate_liverail_device_daily_fact();
  call populate_liverail_project_country_daily_fact();
  call populate_liverail_country_daily_fact();
  call populate_liverail_account_daily_fact();
  call populate_liverail_project_daily_fact();
  call populate_liverail_video_daily_fact();
END //
DELIMITER ;
