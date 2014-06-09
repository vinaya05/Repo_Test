DELIMITER //

CREATE PROCEDURE populate_generic_master_fact_from_youtube()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'yt_reports_master_fact';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

-- DEFAULT VALUES

DECLARE xsource smallint DEFAULT 2;
DECLARE xyt_pub_id bigint(20) DEFAULT 974;
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
DECLARE xcontent_type bigint(2);
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
    `account_id` as `co_account_id`,
    `project_id` as `co_project_id`,
    `video_id` as `co_video_id`,
    `content_type`,
    xsource as `source_id`,
    xyt_pub_id as `pub_account_id`,
    `country_id`,
    xdevice_id_default as `device_id`,
    `day`,
    null as `loads`,
    sum(`cms_views_count`) as `plays`,
    null as `ad_clicks`,
    null as `ad_impressions`,
    sum(`net_youtube_sold_revenue` + `net_ad_sense_sold_revenue` + (0.55 * `gross_partner_sold_revenue`)) as `ad_revenue`,    
    null as `ecpm`,
    null as `inventory_pre`,
    null as `parent_video_id`,
    null as `parent_project_id`,
    null as `parent_account_id`
FROM
    t5m_stats.yt_reports_master_fact
WHERE
  t5m_stats.yt_reports_master_fact.id > xhigh_water_mark
AND
  t5m_stats.yt_reports_master_fact.id <= xnew_hwm
GROUP BY
    `co_account_id`,
    `co_project_id`,
    `co_video_id`,
    `content_type`,
    `source_id`,
    `pub_account_id`,
    `country_id`,
    `device_id`,
    `day`
;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM t5m_stats.yt_reports_master_fact;
select id into xsource from t5m_stats.source_dimension where `source` = 'youtube';

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
    xco_account_id,
    xco_project_id,
    xco_video_id,
    xcontent_type,
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
      content_type = xcontent_type and
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
	`content_type`,
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
	xcontent_type,
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
	content_type = xcontent_type and
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
	`content_type`,
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
 	account_id as `co_account_id`,
	project_id as `co_project_id`,
	video_id as `co_video_id`,
	content_type,
	xsource as `source_id`,
	xyt_pub_id as `pub_account_id`,
	`country_id` as `country_id`,
	xdevice_id_default as `device_id`,
	`day` as `day`,
	null as `loads`,
	sum(`cms_views_count`) as `plays`,
	null as `ad_clicks`,
	null as `ad_impressions`,
    	sum(`net_youtube_sold_revenue` + `net_ad_sense_sold_revenue` + (0.55 * `gross_partner_sold_revenue`)) as `ad_revenue`,    
	null as `ecpm`,
	null as `inventory_pre`,
	null as `parent_video_id`,
	null as `parent_project_id`,
	null as `parent_account_id`
      FROM
          t5m_stats.yt_reports_master_fact
      WHERE
        `account_id` = xco_account_id and
        `project_id` = xco_project_id and
	`video_id` = xco_video_id and
	`content_type` = xcontent_type and
        `country_id` = xcountry_id and
        `day` = xday
      GROUP BY
        `co_account_id`,
        `co_project_id`,
        `co_video_id`,
	`content_type`,
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


