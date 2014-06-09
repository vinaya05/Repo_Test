DELIMITER //

CREATE PROCEDURE populate_generic_master_fact_from_summary_views()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'summary_views_daily_device';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

-- DEFAULT VALUES

DECLARE xsource smallint DEFAULT 3;
DECLARE xunknown_country_id smallint DEFAULT 338;
DECLARE xdevice_id_default bigint(2) DEFAULT 1;
DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE xco_account_id bigint(20);
DECLARE xco_project_id bigint(20);
DECLARE xco_video_id bigint(20);
DECLARE xcountry_id bigint(3);
DECLARE xday date;
DECLARE xsource_id smallint;
DECLARE xpub_account_id bigint(20);
DECLARE xdevice_id bigint(2);
DECLARE xloads bigint(20);
DECLARE xplays bigint(20);
DECLARE xad_clicks bigint(20);
DECLARE xad_impressions bigint(20);
DECLARE xad_revenue float(11,4);
DECLARE xecpm float(14,7);
DECLARE xinventory_pre int(11);
DECLARE xparent_video_id bigint(20);
DECLARE xparent_project_id bigint(20);
DECLARE xparent_account_id bigint(20);

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;

DECLARE cur CURSOR FOR 
SELECT
    wp_blogs.account_id as `co_account_id`,
    svdd.cid as `co_project_id`,
    playlists_0.post_id as `co_video_id`,
    xsource as `source_id`,
    publisher_tracking_codes.account_id as `pub_account_id`,
    IF(yt_countries.country_id IS NULL, xunknown_country_id, yt_countries.country_id) as `country_id`,
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
;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM t5m_stats.summary_views_daily_device;
select id into xsource from t5m_stats.source_dimension where `source` = 'rightster_player_views';
select country_id into xunknown_country_id from v3.yt_countries where `iso_code` = 'ZZ';

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
    xco_account_id,
    xco_project_id,
    xco_video_id,
    xsource_id,
    xpub_account_id,
    xcountry_id,
    xdevice_id,
    xday,
    xloads,
    xplays,
    xad_clicks,
    xad_impressions,
    xad_revenue,    
    xecpm,
    xinventory_pre,
    xparent_video_id,
    xparent_project_id,
    xparent_account_id
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM generic_master_fact
    WHERE 
      co_account_id = xco_account_id and
      co_project_id = xco_project_id and
      co_video_id = xco_video_id and
      source_id = xsource_id and
      pub_account_id = xpub_account_id and
      country_id = xcountry_id and
      device_id = xdevice_id and
      day = xday
    ;

    IF NOT xcount THEN
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
	`inventory_pre`,
	`parent_video_id`,
	`parent_project_id`,
	`parent_account_id`
      )
      VALUES (
	xco_account_id,
	xco_project_id,
        xco_video_id,
        xsource_id,
        xpub_account_id,
        xcountry_id,
        xdevice_id,
        xday,
        xloads,
        xplays,
        xad_clicks,
        xad_impressions,
        xad_revenue,    
        xecpm,
	xinventory_pre,
	xparent_video_id,
	xparent_project_id,
	xparent_account_id
      );

    ELSE

      DELETE FROM generic_master_fact
      WHERE
        co_account_id = xco_account_id and
        co_project_id = xco_project_id and
        co_video_id = xco_video_id and
        source_id = xsource_id and
        pub_account_id = xpub_account_id and
        country_id = xcountry_id and
        device_id = xdevice_id and
        day = xday
       ;

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
	`inventory_pre`,
	`parent_video_id`,
	`parent_project_id`,
	`parent_account_id`
      )
      SELECT
        wp_blogs.account_id as `co_account_id`,
        svdd.cid as `co_project_id`,
        playlists_0.post_id as `co_video_id`,
        xsource as `source_id`,
        publisher_tracking_codes.account_id as `pub_account_id`,
        yt_countries.country_id as `country_id`,
        liverail_device_mapping.device_id as `device_id`,
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
          t5m_stats.summary_views_daily_device svdd
INNER JOIN
    v3.playlists_0
ON
    svdd.vid = playlists_0.id
INNER JOIN
    v3.wp_blogs
ON
    playlists_0.channel_id = wp_blogs.blog_id
INNER JOIN
    v3.yt_countries
ON
    svdd.country = yt_countries.iso_code
INNER JOIN
    t5m_stats.liverail_device_mapping
ON 
    svdd.device like concat('%',liverail_device_mapping.os,'%')
INNER JOIN
    v3.publisher_tracking_codes
ON
    svdd.tid = publisher_tracking_codes.tid
      WHERE
        wp_blogs.account_id = xco_account_id and
        svdd.cid = xco_project_id and
	playlists_0.post_id = xco_video_id and
	publisher_tracking_codes.account_id = xpub_account_id and
        yt_countries.country_id = xcountry_id and
        liverail_device_mapping.device_id = xdevice_id and
        date(svdd.served_on) = xday
      GROUP BY
        `co_account_id`,
        `co_project_id`,
        `co_video_id`,
        `source_id`,
        `pub_account_id`,
        `country_id`,
        `device_id`,
        `day`
      ;

    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO high_water_mark (from_table_name, to_table_name, mark) VALUES (xfrom_table_name, xto_table_name, xnew_hwm)
ON DUPLICATE KEY UPDATE mark = xnew_hwm;

CLOSE cur;

END //
DELIMITER ;


