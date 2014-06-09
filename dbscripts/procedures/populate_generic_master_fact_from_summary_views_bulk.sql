DELIMITER //

CREATE PROCEDURE populate_generic_master_fact_from_summary_views_bulk()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'summary_views_daily_device';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;

-- DEFAULT VALUES

DECLARE xcountry_id smallint DEFAULT 338;
DECLARE xsource smallint DEFAULT 3;
DECLARE xdevice_id_default bigint(2) DEFAULT 1;
DECLARE done INT DEFAULT 0;

select id into xsource from t5m_stats.source_dimension where `source` = 'rightster_player_views';

-- Following statements can trigger NOT FOUND handler, thus we'll reset.

SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM t5m_stats.summary_views_daily_device;
select country_id into xcountry_id from v3.yt_countries where `iso_code` = 'ZZ';

REPLACE INTO generic_master_fact (
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
	`inventory_pre`,
	`parent_video_id`,
	`parent_project_id`,
	`parent_account_id`
      )
(
      SELECT
        wp_blogs.account_id as `co_account_id`,
        svdd.cid as `co_project_id`,
        playlists_0.post_id as `co_video_id`,
        xsource as `source_id`,
        publisher_tracking_codes.account_id as `pub_account_id`,
    	IF(yt_countries.country_id IS NULL, xcountry_id, yt_countries.country_id) as `country_id`,
	IF(liverail_device_mapping.device_id IS NULL,xdevice_id_default, liverail_device_mapping.device_id) as `device_id`,
        date(svdd.served_on) as `day`,
	sum(svdd.total) as `loads`,
    	null as `plays`,
        null as `ad_clicks`,
        null as `ad_impressions`,
        null as `ad_revenue`,    
        null as `ecpm`,
	null as `inventory_pre`,
	null as `parent_video_id`,
	null as `parent_project_id`,
	null as `parent_account_id`
      FROM
(select vid, tid, cid, country, device, date(served_on) as served_on, sum(total) as total from t5m_stats.summary_views_daily_device where id > xhigh_water_mark and id <= xnew_hwm and date(served_on) > '2012-12-31' group by vid, tid, cid, country, device, date(served_on)) as svdd
INNER JOIN
    v3.playlists_0
ON
    svdd.vid = playlists_0.id
INNER JOIN
    v3.wp_blogs
ON
    playlists_0.channel_id = wp_blogs.blog_id
LEFT OUTER JOIN
    v3.yt_countries
ON
    svdd.country = yt_countries.iso_code
LEFT OUTER JOIN
    t5m_stats.liverail_device_mapping
ON
    svdd.device like concat('%',liverail_device_mapping.os,'%')
INNER JOIN
    v3.publisher_tracking_codes
ON
    svdd.tid = publisher_tracking_codes.tid
where 
    playlists_0.post_id is not null 
AND
    playlists_0.is_playlist != 1
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
