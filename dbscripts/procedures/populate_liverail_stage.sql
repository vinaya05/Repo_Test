DELIMITER //

CREATE PROCEDURE populate_liverail_stage(IN irunname varchar(255))
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_stage';
DECLARE done INT DEFAULT 0;

-- DEMINSION and METRIC definitions

DECLARE xpartnerid int(11);
DECLARE xcountry_id int(3);
DECLARE xplaylist_id bigint(20);
DECLARE xdevice_id int(2);
DECLARE xdate date;
DECLARE ximpressions int(11);
DECLARE xclickthroughs int(11);
DECLARE xrevenue float(11,4);
DECLARE xinventory_pre int(11);

DECLARE xcount int(1) DEFAULT 0;


DECLARE cur CURSOR FOR 
SELECT
  partnerid,
  country_id,
  playlist_id,
  device_id,
  date,
  sum(impressions),
  sum(clickthroughs),
  sum(revenue),
  sum(inventory_pre)
FROM
(
  SELECT
    partnerid,
    liverail_countries.country_id,
    IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
    liverail_device_mapping.device_id,
    date,
    impressions,
    clickthroughs,
    revenue,
    inventory_pre
  FROM
    ( SELECT * FROM liverail_raw FOR UPDATE) as uliverail_raw
  INNER JOIN
    liverail_countries ON uliverail_raw.country = liverail_countries.name
  INNER JOIN
    liverail_device_mapping ON uliverail_raw.os = liverail_device_mapping.os
) as RAW
GROUP BY
  partnerid,
  country_id,
  playlist_id,
  device_id,
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
    xdevice_id,
    xdate,
    ximpressions,
    xclickthroughs,
    xrevenue,
    xinventory_pre
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_stage
    WHERE 
      playlist_id = xplaylist_id and
      partner_id = xpartnerid and
      device_id = xdevice_id and
      country_id = xcountry_id and
      day = xdate;


    IF NOT xcount THEN
      INSERT INTO liverail_stage (
        playlist_id,
        partner_id,
        device_id,
        country_id,
        day,
        impressions,
        clickthroughs,
        revenue,
	inventory_pre
      )
      VALUES (
        xplaylist_id,
        xpartnerid,
        xdevice_id,
        xcountry_id,
        xdate,
        ximpressions,
        xclickthroughs,
        xrevenue,
	xinventory_pre
      );

    ELSE

      DELETE FROM liverail_stage
      WHERE
        playlist_id = xplaylist_id and
        partner_id = xpartnerid and
        device_id = xdevice_id and
        country_id = xcountry_id and
        day = xdate;

      INSERT INTO liverail_stage (
        partner_id,
        country_id,
        playlist_id,
        device_id,
        day,
        impressions,
        clickthroughs,
        revenue,
	inventory_pre
      )
      SELECT
        partnerid,
        country_id,
        playlist_id,
        device_id,
        date,
        sum(impressions),
        sum(clickthroughs),
        sum(revenue),
	sum(inventory_pre)
      FROM
      (
        SELECT
          partnerid,
          liverail_countries.country_id,
          IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
          liverail_device_mapping.device_id,
          date,
          impressions,
          clickthroughs,
          revenue,
	  inventory_pre
        FROM
          liverail_raw
        INNER JOIN
          liverail_countries
        ON liverail_raw.country = liverail_countries.name 
        INNER JOIN
          liverail_device_mapping
        ON liverail_raw.os = liverail_device_mapping.os
        WHERE
          partnerid = xpartnerid AND
          device_id = xdevice_id AND
          country_id = xcountry_id AND
          date = xdate
      ) as RAW
      WHERE
        playlist_id = xplaylist_id
      GROUP BY
        partnerid,
        country_id,
        playlist_id,
        device_id,
        date
     ;


    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO liverail_raw_processed (
  run_name,
  partnername,
  partnerid,
  partnerid_raw,
  country,
  country_raw,
  mediaid,
  os,
  os_raw,
  date,
  clickthroughs,
  impressions,
  ctr,
  ecpm,
  revenue,
  inventory_pre
)
SELECT
  irunname,
  partnername,
  partnerid,
  partnerid_raw,
  country,
  country_raw,
  mediaid,
  os,
  os_raw,
  date,
  clickthroughs,
  impressions,
  ctr,
  ecpm,
  revenue,
  inventory_pre
FROM
liverail_raw;
    
DELETE FROM liverail_raw;

CLOSE cur;

END //
DELIMITER ;

