DELIMITER //

CREATE PROCEDURE populate_generic_master_fact_bulk()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'generic_source_master_fact';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

-- DEFAULT VALUES

DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM t5m_stats.generic_source_master_fact;

INSERT INTO generic_master_fact (
        `co_account_id`,
        `co_project_id`,
        `co_video_id`,
        `is_claimed`,
        `pub_account_id`,
        `country_id`,
        `device_id`,
        `day`,
        `loads`,
        `plays`,
        `conversion`,
        `ad_clicks`,
        `ad_impressions`,
        `ad_revenue`,    
        `ecpm`,
	`inventory_pre`
      )
(
SELECT
    `co_account_id`,
    `co_project_id`,
    `co_video_id`,
    `is_claimed`,
    `pub_account_id`,
    `country_id`,
    `device_id`,
    `day`,
    sum(`loads`) as `loads`,
    sum(`plays`) as `plays`,
    IF ( ( sum(plays) / sum(loads) ) IS NOT NULL, ( sum(plays) / sum(loads) ), 0) as `conversion`,
    sum(`ad_clicks`) as `ad_clicks`,
    sum(`ad_impressions`) as `ad_impressions`,
    sum(`ad_revenue`) as `ad_revenue`,
    IF ( ( sum(`ad_revenue`) / sum(`ad_impressions`) ) * 1000 IS NOT NULL, ( sum(`ad_revenue`) / sum(`ad_impressions`) ) * 1000 , 0) as `ecpm`,
    sum(`inventory_pre`) as `inventory_pre`
FROM
    t5m_stats.generic_source_master_fact
WHERE
  t5m_stats.generic_source_master_fact.id > xhigh_water_mark
AND
  t5m_stats.generic_source_master_fact.id <= xnew_hwm
GROUP BY
    `co_account_id`,
    `co_project_id`,
    `co_video_id`,
    `is_claimed`,
    `pub_account_id`,
    `country_id`,
    `device_id`,
    `day`

      );


INSERT INTO high_water_mark (from_table_name, to_table_name, mark) VALUES (xfrom_table_name, xto_table_name, xnew_hwm)
ON DUPLICATE KEY UPDATE mark = xnew_hwm;

END //
DELIMITER ;


