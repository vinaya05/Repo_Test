
alter table generic_master_fact add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table generic_master_fact add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table generic_master_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table generic_account_daily_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table generic_project_daily_fact add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table generic_project_daily_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table generic_video_daily_fact add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table generic_video_daily_fact add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table generic_video_daily_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table aggregate_video_all_time add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table aggregate_video_all_time add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table aggregate_video_all_time add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table generic_country_daily_fact add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table generic_country_daily_fact add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table generic_country_daily_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table aggregate_country_all_time add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table aggregate_country_all_time add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table aggregate_country_all_time add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table generic_device_daily_fact add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table generic_device_daily_fact add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table generic_device_daily_fact add column parent_account_id BIGINT(20) DEFAULT NULL;

alter table aggregate_device_all_time add column parent_video_id BIGINT(20) DEFAULT NULL;
alter table aggregate_device_all_time add column parent_project_id BIGINT(20) DEFAULT NULL;
alter table aggregate_device_all_time add column parent_account_id BIGINT(20) DEFAULT NULL;

insert into  high_water_mark values('duplicate_video_tracking','generic_master_fact',0);
