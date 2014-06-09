DELIMITER //

CREATE PROCEDURE populate_yt_reports_master_fact_from_yt_social_info_raw()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'yt_social_info_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'yt_reports_master_fact';
DECLARE done INT DEFAULT 0;
DECLARE xyoutube_publisher_id INT DEFAULT 974;
DECLARE xsource smallint DEFAULT 5;

-- DIMENSION and METRIC definitions

DECLARE xaccountid bigint(20);
DECLARE xpubaccountid int(11);
DECLARE xprojectid bigint(20);
DECLARE xvideoid bigint(20);
DECLARE xcountry_id int(3);
DECLARE xdevice_id int(2);
DECLARE xday date;
DECLARE xviews_count int(11);
DECLARE xsubscribers_count int(11);
DECLARE xlikes_count int(11);
DECLARE xdislikes_count int(11);
DECLARE xcomments_count int(11);

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
  day,
  sum(views_count),
  sum(subscribers_count),
  sum(likes_count),
  sum(dislikes_count),
  sum(comments_count)
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
    day,
    views_count,
    subscribers_count,
    likes_count,
    dislikes_count,
    comments_count
  FROM
    ( SELECT * FROM yt_social_info_raw FOR UPDATE) as uyt_social_info_raw
  LEFT OUTER JOIN
    v3.external_video_mapping evm
  ON 
    uyt_social_info_raw.yt_video_id = evm.xid
  LEFT OUTER JOIN
    v3.wp_blogs
  ON
    evm.cid = wp_blogs.blog_id
  LEFT OUTER JOIN
    liverail_countries 
  ON 
    uyt_social_info_raw.country = liverail_countries.name
  LEFT OUTER JOIN
    liverail_device_mapping 
  ON 
    uyt_social_info_raw.os = liverail_device_mapping.os
) as RAW
GROUP BY
  account_id,
  pub_account_id,
  project_id,
  video_id,
  country_id,
  device_id,
  source_id,
  day
;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
select id into xsource from t5m_stats.source_dimension where `source` = 'youtube_api';

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
	xday,
	xviews_count,
	xsubscribers_count,
	xlikes_count,
	xdislikes_count,
	xcomments_count
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
	day,
	views_count,
	subscribers_count,
	likes_count,
	dislikes_count,
	comments_count
      )
      VALUES (
	xaccountid,
	xpubaccountid,
	xprojectid,
	xvideoid,
	xcountry_id,
	xdevice_id,
	xsource,
	xday,
	xviews_count,
	xsubscribers_count,
	xlikes_count,
	xdislikes_count,
	xcomments_count
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
        day = xday;

      INSERT INTO yt_reports_master_fact (
	account_id,
	pub_account_id,
	project_id,
	video_id,
	country_id,
	device_id,
	source_id,
	day,
	views_count,
	subscribers_count,
	likes_count,
	dislikes_count,
	comments_count
      )
      VALUES (
	xaccountid,
	xpubaccountid,
	xprojectid,
	xvideoid,
	xcountry_id,
	xdevice_id,
	xsource,
	xday,
	xviews_count,
	xsubscribers_count,
	xlikes_count,
	xdislikes_count,
	xcomments_count
      );

    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO yt_social_info_raw_processed (
cms_account,
channel_id,
channel_name,
yt_video_id,
day,
country,
country_raw,
os,
os_raw,
views_count,
likes_count,
dislikes_count,
subscribers_count,
comments_count
)
SELECT
cms_account,
channel_id,
channel_name,
yt_video_id,
day,
country,
country_raw,
os,
os_raw,
views_count,
likes_count,
dislikes_count,
subscribers_count,
comments_count
FROM
yt_social_info_raw;
    
DELETE FROM yt_social_info_raw;

CLOSE cur;

END //
DELIMITER ;

