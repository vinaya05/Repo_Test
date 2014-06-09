DELIMITER //

CREATE PROCEDURE populate_liverail_revenue_master_fact_order()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_order_stage';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_revenue_master_fact';
DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE xco_account_id bigint(20);
DECLARE xco_project_id bigint(20);
DECLARE xco_video_id bigint(20);
DECLARE xpub_account_id bigint(20);
DECLARE xorder varchar(64);
DECLARE xcountry_id int(3);
DECLARE xday date;
DECLARE xad_clicks int(11);
DECLARE xad_impressions int(11);
DECLARE xinventory_fill DOUBLE(10,4);
DECLARE xad_revenue float(11,4);
DECLARE xecpm float(14,7);

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
			  `order`,
			  country_id,
			  day,
			  sum(clickthroughs) as ad_clicks,
			  sum(impressions) as ad_impressions,
			  sum(inventory_fill) as inventory_fill,
			  sum(revenue) as ad_revenue,
			  IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm
			from
			  liverail_order_stage
			INNER JOIN
			  liverail_partner_mapping
			ON
			  liverail_order_stage.partner_id = liverail_partner_mapping.partner_id
			INNER JOIN
			  v3.playlists_0
			ON
			  liverail_order_stage.playlist_id = playlists_0.id
			INNER JOIN
			  v3.wp_blogs
			ON
			  playlists_0.channel_id = wp_blogs.blog_id
			WHERE
			  playlists_0.post_id IS NOT NULL
			AND
			  playlists_0.is_playlist = 0
			AND
			  liverail_order_stage.id > xhigh_water_mark
			AND
			  liverail_order_stage.id <= xnew_hwm
			GROUP BY
			  wp_blogs.account_id,
			  playlists_0.channel_id,
			  playlists_0.post_id,
			  liverail_partner_mapping.pub_account_id,
			  `order`,
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
			`order`,
			country_id,
			day,
			sum(clickthroughs) as ad_clicks,
			sum(impressions) as ad_impressions,
            sum(inventory_fill) as inventory_fill,
			sum(revenue) as ad_revenue,
			IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm
		FROM
			t5m_stats.liverail_order_stage
		INNER JOIN
			t5m_stats.liverail_third_party_player_publisher lr
		ON
			  liverail_order_stage.partner_id = lr.partner_id
			AND
			  liverail_order_stage.id > xhigh_water_mark
			AND
			  liverail_order_stage.id <= xnew_hwm
		GROUP BY
		co_account_id,
		co_project_id,
		co_video_id,
		pub_account_id,
		`order`,
		country_id,
		day
	) as two
) as the_master
;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM liverail_order_stage;

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
    xorder,
    xcountry_id,
    xday,
    xad_clicks,
    xad_impressions,
    xinventory_fill,
    xad_revenue,
    xecpm
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_revenue_master_fact
    WHERE 
      co_account_id = xco_account_id and
      co_project_id = xco_project_id and
      co_video_id = xco_video_id and
      pub_account_id = xpub_account_id and
      `order` = xorder and
      country_id = xcountry_id and
      day = xday
    ;

    IF NOT xcount THEN
      INSERT INTO liverail_revenue_master_fact (
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        `order`,
        country_id,
        day,
        ad_clicks,
        ad_impressions,
	inventory_fill,
        ad_revenue,
        ecpm
      )
      VALUES (
        xco_account_id,
        xco_project_id,
        xco_video_id,
        xpub_account_id,
        xorder,
        xcountry_id,
        xday,
        xad_clicks,
        xad_impressions,
	xinventory_fill,
        xad_revenue,
        xecpm
      );

    ELSE

      DELETE FROM liverail_revenue_master_fact
      WHERE
        co_account_id = xco_account_id and
        co_project_id = xco_project_id and
        co_video_id = xco_video_id and
        pub_account_id = xpub_account_id and
        `order` = xorder and
        country_id = xcountry_id and
        day = xday
       ;

      INSERT INTO liverail_revenue_master_fact (
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        `order`,
        country_id,
        day,
        ad_clicks,
        ad_impressions,
	inventory_fill,
        ad_revenue,
        ecpm
      )
      SELECT
        wp_blogs.account_id as co_account_id,
        playlists_0.channel_id as co_project_id,
        playlists_0.post_id as co_video_id,
        liverail_partner_mapping.pub_account_id,
        `order`,
        country_id,
        day,
        sum(clickthroughs) as ad_clicks,
        sum(impressions) as ad_impressions,
	sum(inventory_fill) as inventory_fill,
        sum(revenue) as ad_revenue,
        IF ( ( sum(revenue) / sum(impressions) ) * 1000 IS NOT NULL, ( sum(revenue) / sum(impressions) ) * 1000 , 0) as ecpm
      from
        liverail_order_stage
      INNER JOIN
        liverail_partner_mapping
      ON
        liverail_order_stage.partner_id = liverail_partner_mapping.partner_id
      INNER JOIN
        v3.playlists_0
      ON
        liverail_order_stage.playlist_id = playlists_0.id
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
        `order` = xorder and
        country_id = xcountry_id and
        day = xday
      GROUP BY
        wp_blogs.account_id,
        playlists_0.channel_id,
        playlists_0.post_id,
        liverail_partner_mapping.pub_account_id,
        `order`,
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

