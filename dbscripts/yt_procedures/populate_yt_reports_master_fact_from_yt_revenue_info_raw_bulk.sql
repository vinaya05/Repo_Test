DELIMITER //

CREATE PROCEDURE populate_yt_reports_master_fact_from_yt_revenue_info_raw_bulk()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'yt_revenue_info_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'yt_reports_master_fact';
DECLARE done INT DEFAULT 0;
DECLARE xyoutube_publisher_id INT DEFAULT 974;

DECLARE xsource smallint DEFAULT 6;

DECLARE xcount int(1) DEFAULT 0;

select id into xsource from t5m_stats.source_dimension where `source` = 'youtube_cms';

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
	ad_enabled_views,
	ad_requested_views,
	gross_youtube_sold_revenue,
	gross_partner_sold_revenue,
	gross_ad_sense_sold_revenue,
	net_youtube_sold_revenue,
	net_ad_sense_sold_revenue
      )
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
	    IF (playlists_0.channel_id is not null, playlists_0.channel_id, -1) as project_id,
	    IF (playlists_0.post_id is not null, playlists_0.post_id, -1) as video_id,
	    liverail_countries.country_id,
	    liverail_device_mapping.device_id,
	    xsource as source_id,
	    yt_content_mapping.id as content_type,
	    day,
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
	    v3.playlists_0
	  ON
	    evm.vid = playlists_0.id
	  LEFT OUTER JOIN
	    v3.wp_blogs
	  ON
	    playlists_0.channel_id = wp_blogs.blog_id
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

END //
DELIMITER ;

