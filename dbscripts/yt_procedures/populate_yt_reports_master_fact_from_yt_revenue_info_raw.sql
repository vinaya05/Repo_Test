DELIMITER //

CREATE PROCEDURE populate_yt_reports_master_fact_from_yt_revenue_info_raw()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'yt_revenue_info_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'yt_reports_master_fact';
DECLARE done INT DEFAULT 0;
DECLARE xyoutube_publisher_id INT DEFAULT 974;

DECLARE xsource smallint DEFAULT 6;

DECLARE xaccountid bigint(20);
DECLARE xpubaccountid int(11);
DECLARE xprojectid bigint(20);
DECLARE xvideoid bigint(20);
DECLARE xcountry_id int(3);
DECLARE xdevice_id int(2);
DECLARE xcontent_type int(2);
DECLARE xday date;
DECLARE xcms_views_count int(11);
DECLARE xad_enabled_views int(11);
DECLARE xad_requested_views int(11);
DECLARE xgross_youtube_sold_revenue float(11,7);
DECLARE xgross_partner_sold_revenue float(11,7);
DECLARE xgross_ad_sense_sold_revenue float(11,7);
DECLARE xnet_youtube_sold_revenue float(11,7);
DECLARE xnet_ad_sense_sold_revenue float(11,7);

DECLARE xcount int(1) DEFAULT 0;

DECLARE cur CURSOR FOR 
SELECT
  account_id,
  pub_account_id,
  project_id,
  video_id,
  country_id,
  device_id,
  source_id,
  content_type,
  day,
  sum(cms_views_count),
  sum(ad_enabled_views),
  sum(ad_requested_views),
  sum(gross_youtube_sold_revenue),
  sum(gross_partner_sold_revenue),
  sum(gross_ad_sense_sold_revenue),
  sum(net_youtube_sold_revenue),
  sum(net_ad_sense_sold_revenue)
FROM
(
  SELECT
    IF (wp_blogs.account_id is not null, wp_blogs.account_id, -1) as account_id,
    xyoutube_publisher_id as pub_account_id,
    IF (wp_blogs.blog_id is not null, wp_blogs.blog_id, -1) as project_id,
    IF (evm.vid is not null, evm.vid, -1) as video_id,
    liverail_countries.country_id,
    liverail_device_mapping.device_id,
    xsource as source_id,
    yt_content_mapping.id as content_type,
    day,
    total_views as cms_views_count,
    ad_enabled_views,
    ad_requested_views,
    gross_youtube_sold_revenue,
    gross_partner_sold_revenue,
    gross_ad_sense_sold_revenue,
    net_youtube_sold_revenue,
    net_ad_sense_sold_revenue
  FROM
    ( SELECT * FROM yt_revenue_info_raw FOR UPDATE) as uyt_revenue_info_raw
  LEFT OUTER JOIN
    v3.external_video_mapping evm
  ON 
    uyt_revenue_info_raw.yt_video_id = evm.xid
  LEFT OUTER JOIN
    v3.wp_blogs
  ON
    evm.cid = wp_blogs.blog_id
  LEFT OUTER JOIN
    liverail_countries 
  ON 
    uyt_revenue_info_raw.country = liverail_countries.name
  LEFT OUTER JOIN
    liverail_device_mapping 
  ON 
    uyt_revenue_info_raw.os = liverail_device_mapping.os
  LEFT OUTER JOIN
    yt_content_mapping 
  ON 
    uyt_revenue_info_raw.content_type = yt_content_mapping.content_type
) as RAW
GROUP BY
  account_id,
  pub_account_id,
  project_id,
  video_id,
  country_id,
  device_id,
  source_id,
  content_type,
  day
;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
select id into xsource from t5m_stats.source_dimension where `source` = 'youtube_cms';

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
	xaccountid,
	xpubaccountid,
	xprojectid,
	xvideoid,
	xcountry_id,
	xdevice_id,
  	xsource,
	xcontent_type,
	xday,
	xcms_views_count,
	xad_enabled_views,
	xad_requested_views,
	xgross_youtube_sold_revenue,
	xgross_partner_sold_revenue,
	xgross_ad_sense_sold_revenue,
	xnet_youtube_sold_revenue,
	xnet_ad_sense_sold_revenue
  ;

  IF NOT done THEN

    SELECT count(1) INTO xcount FROM yt_reports_master_fact
    WHERE 
      account_id = xaccountid and
      pub_account_id = xpubaccountid and
      project_id = xprojectid and
      video_id = xvideoid and
      country_id = xcountry_id and
      device_id = xdevice_id and
      source_id = xsource and
      content_type = xcontent_type and
      day = xday;

    IF NOT xcount THEN
      INSERT INTO yt_reports_master_fact (
	account_id,
	pub_account_id,
	project_id,
	video_id,
	country_id,
	device_id,
	source_id,
	content_type,
	day,
	cms_views_count,
	ad_enabled_views,
	ad_requested_views,
	gross_youtube_sold_revenue,
	gross_partner_sold_revenue,
	gross_ad_sense_sold_revenue,
	net_youtube_sold_revenue,
	net_ad_sense_sold_revenue
      )
      VALUES (
	xaccountid,
	xpubaccountid,
	xprojectid,
	xvideoid,
	xcountry_id,
	xdevice_id,
        xsource,
	xcontent_type,
	xday,
	xcms_views_count,
	xad_enabled_views,
	xad_requested_views,
	xgross_youtube_sold_revenue,
	xgross_partner_sold_revenue,
	xgross_ad_sense_sold_revenue,
	xnet_youtube_sold_revenue,
	xnet_ad_sense_sold_revenue
      );

    ELSE

      DELETE FROM yt_reports_master_fact
      WHERE
        account_id = xaccountid and
        pub_account_id = xpubaccountid and
        project_id = xprojectid and
        video_id = xvideoid and
        country_id = xcountry_id and
        device_id = xdevice_id and
	source_id = xsource and
        content_type = xcontent_type and
        day = xday;

      INSERT INTO yt_reports_master_fact (
	account_id,
	pub_account_id,
	project_id,
	video_id,
	country_id,
	device_id,
	source_id,
	content_type,
	day,
	cms_views_count,
	ad_enabled_views,
	ad_requested_views,
	gross_youtube_sold_revenue,
	gross_partner_sold_revenue,
	gross_ad_sense_sold_revenue,
	net_youtube_sold_revenue,
	net_ad_sense_sold_revenue
      )
      VALUES (
	xaccountid,
	xpubaccountid,
	xprojectid,
	xvideoid,
	xcountry_id,
	xdevice_id,
        xsource,
	xcontent_type,
	xday,
    xcms_views_count,
	xad_enabled_views,
	xad_requested_views,
	xgross_youtube_sold_revenue,
	xgross_partner_sold_revenue,
	xgross_ad_sense_sold_revenue,
	xnet_youtube_sold_revenue,
	xnet_ad_sense_sold_revenue
      );


    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO yt_revenue_info_raw_processed (
yt_video_id,
custom_id,
day,
country,
country_raw,
os,
os_raw,
content_type,
policy,
total_views,
watch_page_views,
embedded_player_views,
channel_page_video_views,
live_views,
recorded_views,
ad_enabled_views,
ad_requested_views,
total_earnings,
gross_youtube_sold_revenue,
gross_partner_sold_revenue,
gross_ad_sense_sold_revenue,
net_youtube_sold_revenue,
net_ad_sense_sold_revenue
)
SELECT
yt_video_id,
custom_id,
day,
country,
country_raw,
os,
os_raw,
content_type,
policy,
total_views,
watch_page_views,
embedded_player_views,
channel_page_video_views,
live_views,
recorded_views,
ad_enabled_views,
ad_requested_views,
total_earnings,
gross_youtube_sold_revenue,
gross_partner_sold_revenue,
gross_ad_sense_sold_revenue,
net_youtube_sold_revenue,
net_ad_sense_sold_revenue
FROM
yt_revenue_info_raw;
    
DELETE FROM yt_revenue_info_raw;

CLOSE cur;

END //
DELIMITER ;

