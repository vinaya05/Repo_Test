alter table liverail_raw add column inventory_pre INT(11) after revenue;
alter table liverail_raw_processed add column inventory_pre INT(11) after revenue;
alter table liverail_stage add column inventory_pre INT(11) after revenue;
alter table liverail_master_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_account_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_country_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_device_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_project_country_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_project_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_project_device_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;
alter table liverail_video_daily_fact add column inventory_pre INT(11) NOT NULL after ecpm;


alter table generic_account_daily_fact add column inventory_pre INT(11) after ecpm;
alter table generic_country_daily_fact add column inventory_pre INT(11) after ecpm;
alter table generic_device_daily_fact add column inventory_pre INT(11) after ecpm;
alter table generic_master_fact add column inventory_pre INT(11) after ecpm;
alter table generic_project_daily_fact add column inventory_pre INT(11) after ecpm;
alter table generic_video_daily_fact add column inventory_pre INT(11) after ecpm;


