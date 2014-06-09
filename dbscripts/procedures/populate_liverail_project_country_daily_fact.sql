DELIMITER //

CREATE PROCEDURE populate_liverail_project_country_daily_fact()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_master_fact';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_project_country_daily_fact';
DECLARE done INT DEFAULT 0;

-- DEMINSION and METRIC definitions

DECLARE xco_account_id bigint(20);
DECLARE xco_project_id bigint(20);
DECLARE xpub_account_id bigint(20);
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
SELECT
    `co_account_id`,
    `co_project_id`,
    `pub_account_id`,
    `country_id`,
    `day`,
    sum(`ad_clicks`),
    sum(`ad_impressions`),
    sum(`ad_revenue`),
    IF ( ( sum(ad_revenue) / sum(ad_impressions) ) * 1000 IS NOT NULL, ( sum(ad_revenue) / sum(ad_impressions) ) * 1000 , 0) as ecpm,
    sum(`inventory_pre`)
FROM
    liverail_master_fact
WHERE
  liverail_master_fact.id > xhigh_water_mark
AND
  liverail_master_fact.id <= xnew_hwm
GROUP BY
    `co_account_id`,
    `co_project_id`,
    `pub_account_id`,
    `country_id`,
    `day`
;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM liverail_master_fact;

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
    `xco_account_id`,
    `xco_project_id`,
    `xpub_account_id`,
    `xcountry_id`,
    `xday`,
    `xad_clicks`,
    `xad_impressions`,
    `xad_revenue`,
    `xecpm`,
    `xinventory_pre`
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_project_country_daily_fact
    WHERE 
      co_account_id = xco_account_id and
      co_project_id = xco_project_id and
      pub_account_id = xpub_account_id and
      country_id = xcountry_id and
      day = xday
    ;

    IF NOT xcount THEN
      INSERT INTO liverail_project_country_daily_fact (
        `co_account_id`,
        `co_project_id`,
        `pub_account_id`,
        `country_id`,
        `day`,
        `ad_clicks`,
        `ad_impressions`,
        `ad_revenue`,
        `ecpm`,
	`inventory_pre`
      )
      VALUES (
        xco_account_id,
        xco_project_id,
        xpub_account_id,
        xcountry_id,
        xday,
        xad_clicks,
        xad_impressions,
        xad_revenue,
        xecpm,
	xinventory_pre
      );

    ELSE

      DELETE FROM liverail_project_country_daily_fact
      WHERE
        co_account_id = xco_account_id and
        co_project_id = xco_project_id and
        pub_account_id = xpub_account_id and
        country_id = xcountry_id and
        day = xday
       ;

      INSERT INTO liverail_project_country_daily_fact (
        `co_account_id`,
        `co_project_id`,
        `pub_account_id`,
        `country_id`,
        `day`,
        `ad_clicks`,
        `ad_impressions`,
        `ad_revenue`,
        `ecpm`,
	`inventory_pre`
      )
      SELECT
          `co_account_id`,
          `co_project_id`,
          `pub_account_id`,
          `country_id`,
          `day`,
          sum(`ad_clicks`),
          sum(`ad_impressions`),
          sum(`ad_revenue`),
          IF ( ( sum(ad_revenue) / sum(ad_impressions) ) * 1000 IS NOT NULL, ( sum(ad_revenue) / sum(ad_impressions) ) * 1000 , 0) as ecpm,
	  sum(`inventory_pre`)
      FROM
          liverail_master_fact
      WHERE
        co_account_id = xco_account_id and
        co_project_id = xco_project_id and
        pub_account_id = xpub_account_id and
        country_id = xcountry_id and
        day = xday
      GROUP BY
          `co_account_id`,
          `co_project_id`,
          `pub_account_id`,
          `country_id`,
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

