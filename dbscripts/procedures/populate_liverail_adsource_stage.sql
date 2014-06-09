DELIMITER //

CREATE PROCEDURE populate_liverail_adsource_stage()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_adsource_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_adsource_stage';
DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE xpartnerid int(11);
DECLARE xcountry_id int(3);
DECLARE xplaylist_id bigint(20);
DECLARE xadsource_raw varchar(64);
DECLARE xdate date;
DECLARE ximpressions int(11);
DECLARE xinventory_fill DOUBLE(10,4);
DECLARE xclickthroughs int(11);
DECLARE xrevenue float(11,4);

DECLARE xcount int(1) DEFAULT 0;


DECLARE cur CURSOR FOR 
SELECT
  partnerid,
  country_id,
  playlist_id,
  adsource_raw,
  date,
  sum(impressions),
  sum(inventory_fill),
  sum(clickthroughs),
  sum(revenue)
FROM
(
  SELECT
    partnerid,
    liverail_countries.country_id,
    IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
    adsource_raw,
    date,
    impressions,
    inventory_fill,
    clickthroughs,
    revenue
  FROM
    ( SELECT * FROM liverail_adsource_raw WHERE adsource_raw NOT LIKE 'Direct Sold%' FOR UPDATE) as uliverail_adsource_raw
  INNER JOIN
    liverail_countries ON uliverail_adsource_raw.country = liverail_countries.name
) as RAW
GROUP BY
  partnerid,
  country_id,
  playlist_id,
  adsource_raw,
  date
;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

IF done THEN
  SET done = 0;
END IF;


OPEN cur;

REPEAT

  FETCH cur INTO
    xpartnerid,
    xcountry_id,
    xplaylist_id,
    xadsource_raw,
    xdate,
    ximpressions,
    xinventory_fill,
    xclickthroughs,
    xrevenue
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_adsource_stage
    WHERE 
      playlist_id = xplaylist_id and
      partner_id = xpartnerid and
      adsource = xadsource_raw and
      country_id = xcountry_id and
      day = xdate;


    IF NOT xcount THEN
      INSERT INTO liverail_adsource_stage (
        playlist_id,
        partner_id,
        `adsource`,
        country_id,
        day,
        impressions,
	clickthroughs,
	inventory_fill,
        revenue
      )
      VALUES (
        xplaylist_id,
        xpartnerid,
        xadsource_raw,
        xcountry_id,
        xdate,
        ximpressions,
	xinventory_fill,
        xclickthroughs,
        xrevenue
      );

    ELSE

      DELETE FROM liverail_adsource_stage
      WHERE
        playlist_id = xplaylist_id and
        partner_id = xpartnerid and
        `adsource` = xadsource_raw and
        country_id = xcountry_id and
        day = xdate;

      INSERT INTO liverail_adsource_stage (
        partner_id,
        country_id,
        playlist_id,
        `adsource`,
        day,
        impressions,
	inventory_fill,
        clickthroughs,
        revenue
      )
      SELECT
        partnerid,
        country_id,
        playlist_id,
        adsource_raw,
        date,
        sum(impressions),
	sum(inventory_fill),
        sum(clickthroughs),
        sum(revenue)
      FROM
      (
        SELECT
          partnerid,
          liverail_countries.country_id,
          IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
          adsource_raw,
          date,
          impressions,
	  inventory_fill,
          clickthroughs,
          revenue
        FROM
          liverail_adsource_raw
        INNER JOIN
          liverail_countries
        ON liverail_adsource_raw.country = liverail_countries.name
        WHERE
          partnerid = xpartnerid AND
          adsource_raw = xadsource_raw AND
          country_id = xcountry_id AND
          date = xdate
      ) as RAW
      WHERE
        playlist_id = xplaylist_id
      GROUP BY
        partnerid,
        country_id,
        playlist_id,
        adsource_raw,
        date
     ;


    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO liverail_adsource_raw_processed (
  partnername,
  partnerid,
  partnerid_raw,
  country,
  country_raw,
  mediaid,
  adsource_raw,
  date,
  clickthroughs,
  impressions,
  inventory_fill,
  ecpm,
  revenue
)
SELECT
  partnername,
  partnerid,
  partnerid_raw,
  country,
  country_raw,
  mediaid,
  adsource_raw,
  date,
  clickthroughs,
  impressions,
  inventory_fill,
  ecpm,
  revenue
FROM
liverail_adsource_raw;
    
DELETE FROM liverail_adsource_raw;

CLOSE cur;

END //
DELIMITER ;

