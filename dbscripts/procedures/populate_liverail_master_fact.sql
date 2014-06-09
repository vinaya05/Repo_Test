DELIMITER //

CREATE PROCEDURE populate_liverail_master_fact()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_stage';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_master_fact';
DECLARE done INT DEFAULT 0;

-- DEMINSION and METRIC definitions

DECLARE xco_account_id bigint(20);
DECLARE xco_project_id bigint(20);
DECLARE xco_video_id bigint(20);
DECLARE xpub_account_id bigint(20);
DECLARE xdevice_id int(2);
DECLARE xcountry_id int(3);
DECLARE xday date;
DECLARE xad_clicks int(11);
DECLARE xad_impressions int(11);
DECLARE xad_revenue float(11,4);
DECLARE xecpm float(14,7);
DECLARE xinventory_pre int(11);

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;

DECLARE cur CURSOR FOR 
SELECT * FROM
(
	SELECT * FROM (
			SELECT
			  wp_blogs.account_id as co_account_id,
			  playlists_0.channel_id as co_project_id,
			  playlists_0.post_id as co_video_id,
			  liverail_partner_mapping.pub_account_id as pub_account_id,
			  device_id,
			  country_id,
			  day,
			  sum(clickthroughs) as ad_clicks,
			  sum(impressions) as ad_impressions,
			  sum(revenue) as ad_revenue,
			  IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm,
			  sum(inventory_pre) as inventory_pre
			from
			  liverail_stage
			INNER JOIN
			  liverail_partner_mapping
			ON
			  liverail_stage.partner_id = liverail_partner_mapping.partner_id
			INNER JOIN
			  v3.playlists_0
			ON
			  liverail_stage.playlist_id = playlists_0.id
			INNER JOIN
			  v3.wp_blogs
			ON
			  playlists_0.channel_id = wp_blogs.blog_id
			WHERE
			  playlists_0.post_id IS NOT NULL
			AND
			  playlists_0.is_playlist = 0
			AND
			  liverail_stage.id > xhigh_water_mark
			AND
			  liverail_stage.id <= xnew_hwm
			GROUP BY
			  wp_blogs.account_id,
			  playlists_0.channel_id,
			  playlists_0.post_id,
			  liverail_partner_mapping.pub_account_id,
			  device_id,
			  country_id,
			  day
	) as one
	UNION
	SELECT * FROM (
		SELECT
			lr.co_account_id as co_account_id,
			cast(-(1) as SIGNED) as co_project_id,
			cast(-(1) as SIGNED) as co_video_id,
			lr.pub_account_id as pub_account_id,
			device_id,
			country_id,
			day,
			sum(clickthroughs) as ad_clicks,
			sum(impressions) as ad_impressions,
			sum(revenue) as ad_revenue,
			IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm,
			sum(inventory_pre) as inventory_pre
		FROM
			t5m_stats.liverail_stage
		INNER JOIN
			t5m_stats.liverail_third_party_player_publisher lr
		ON
			  liverail_stage.partner_id = lr.partner_id
			AND
			  liverail_stage.id > xhigh_water_mark
			AND
			  liverail_stage.id <= xnew_hwm
		GROUP BY
		co_account_id,
		co_project_id,
		co_video_id,
		pub_account_id,
		device_id,
		country_id,
		day
	) as two
) as the_master
;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM liverail_stage;

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
    xco_account_id,
    xco_project_id,
    xco_video_id,
    xpub_account_id,
    xdevice_id,
    xcountry_id,
    xday,
    xad_clicks,
    xad_impressions,
    xad_revenue,
    xecpm,
    xinventory_pre
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_master_fact
    WHERE 
      co_account_id = xco_account_id and
      co_project_id = xco_project_id and
      co_video_id = xco_video_id and
      pub_account_id = xpub_account_id and
      device_id = xdevice_id and
      country_id = xcountry_id and
      day = xday
    ;

    IF NOT xcount THEN
      INSERT INTO liverail_master_fact (
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        device_id,
        country_id,
        day,
        ad_clicks,
        ad_impressions,
        ad_revenue,
        ecpm,
	inventory_pre
      )
      VALUES (
        xco_account_id,
        xco_project_id,
        xco_video_id,
        xpub_account_id,
        xdevice_id,
        xcountry_id,
        xday,
        xad_clicks,
        xad_impressions,
        xad_revenue,
        xecpm,
	xinventory_pre
      );

    ELSE

      DELETE FROM liverail_master_fact
      WHERE
        co_account_id = xco_account_id and
        co_project_id = xco_project_id and
        co_video_id = xco_video_id and
        pub_account_id = xpub_account_id and
        device_id = xdevice_id and
        country_id = xcountry_id and
        day = xday
       ;

      INSERT INTO liverail_master_fact (
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        device_id,
        country_id,
        day,
        ad_clicks,
        ad_impressions,
        ad_revenue,
        ecpm,
	inventory_pre
      )
      SELECT
        wp_blogs.account_id as co_account_id,
        playlists_0.channel_id as co_project_id,
        playlists_0.post_id as co_video_id,
        liverail_partner_mapping.pub_account_id,
        device_id,
        country_id,
        day,
        sum(clickthroughs) as ad_clicks,
        sum(impressions) as ad_impressions,
        sum(revenue) as ad_revenue,
        IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm,
	sum(inventory_pre) as inventory_pre
      from
        liverail_stage
      INNER JOIN
        liverail_partner_mapping
      ON
        liverail_stage.partner_id = liverail_partner_mapping.partner_id
      INNER JOIN
        v3.playlists_0
      ON
        liverail_stage.playlist_id = playlists_0.id
      INNER JOIN
        v3.wp_blogs
      ON
        playlists_0.channel_id = wp_blogs.blog_id
      WHERE
        playlists_0.post_id IS NOT NULL and
        wp_blogs.account_id = xco_account_id and
        playlists_0.channel_id = xco_project_id and
        playlists_0.post_id = xco_video_id and
        liverail_partner_mapping.pub_account_id = xpub_account_id and
        device_id = xdevice_id and
        country_id = xcountry_id and
        day = xday
      GROUP BY
        wp_blogs.account_id,
        playlists_0.channel_id,
        playlists_0.post_id,
        liverail_partner_mapping.pub_account_id,
        device_id,
        country_id,
        day 
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

