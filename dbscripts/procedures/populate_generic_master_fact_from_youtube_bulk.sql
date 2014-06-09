DELIMITER //

CREATE PROCEDURE populate_generic_master_fact_from_youtube_bulk()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'yt_master_fact';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

-- DEFAULT VALUES

DECLARE xsource smallint DEFAULT 2;
DECLARE xyt_pub_id bigint(20) DEFAULT 974;
DECLARE xdevice_id_default bigint(2) DEFAULT 1;
DECLARE done INT DEFAULT 0;

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;

SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM v3.yt_master_fact;
select id into xsource from t5m_stats.source_dimension where `source` = 'youtube';

INSERT INTO generic_master_fact (
        `co_account_id`,
        `co_project_id`,
        `co_video_id`,
        `source_id`,
        `pub_account_id`,
        `country_id`,
        `device_id`,
        `day`,
        `loads`,
        `plays`,
        `ad_clicks`,
        `ad_impressions`,
        `ad_revenue`,
        `ecpm`,
	`inventory_pre`
)
(
SELECT
    `account_id` as `co_account_id`,
    `project_id` as `co_project_id`,
    `video_id` as `co_video_id`,
    xsource as `source_id`,
    xyt_pub_id as `pub_account_id`,
    `country` as `country_id`,
    xdevice_id_default as `device_id`,
    `date` as `day`,
    null as `loads`,
    sum(`total_views`) as `plays`,
    null as `ad_clicks`,
    null as `ad_impressions`,
    sum(`net_revenue`) as `ad_revenue`,    
    null as `ecpm`,
    null as `inventory_pre`
FROM
    v3.yt_master_fact
WHERE
  v3.yt_master_fact.id > xhigh_water_mark
AND
  v3.yt_master_fact.id <= xnew_hwm
GROUP BY
    `co_account_id`,
    `co_project_id`,
    `co_video_id`,
    `source_id`,
    `pub_account_id`,
    `country_id`,
    `device_id`,
    `day`
);

INSERT INTO high_water_mark (from_table_name, to_table_name, mark) VALUES (xfrom_table_name, xto_table_name, xnew_hwm)
ON DUPLICATE KEY UPDATE mark = xnew_hwm;

END //
DELIMITER ;


