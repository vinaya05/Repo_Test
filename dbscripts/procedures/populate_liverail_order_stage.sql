DELIMITER //

CREATE PROCEDURE populate_liverail_order_stage()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_order_raw';
DECLARE xto_table_name varchar(64) DEFAULT 'liverail_order_stage';
DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE xpartnerid int(11);
DECLARE xcountry_id int(3);
DECLARE xplaylist_id bigint(20);
DECLARE xorder_raw varchar(64);
DECLARE xdate date;
DECLARE ximpressions int(11);
DECLARE xclickthroughs int(11);
DECLARE xinventory_fill DOUBLE(20,4);
DECLARE xrevenue float(11,4);

DECLARE xcount int(1) DEFAULT 0;


DECLARE cur CURSOR FOR 
SELECT
  partnerid,
  country_id,
  playlist_id,
  order_raw,
  date,
  sum(impressions),
  sum(clickthroughs),
  sum(inventory_fill),
  sum(revenue)
FROM
(
  SELECT
    partnerid,
    liverail_countries.country_id,
    IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
    order_raw,
    date,
    impressions,
    inventory_fill,
    clickthroughs,
    revenue
  FROM
    ( SELECT * FROM liverail_order_raw WHERE `order_raw` NOT LIKE 'Unknown%' FOR UPDATE) as uliverail_order_raw
  INNER JOIN
    liverail_countries ON uliverail_order_raw.country = liverail_countries.name
) as RAW
GROUP BY
  partnerid,
  country_id,
  playlist_id,
  order_raw,
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
    xorder_raw,
    xdate,
    ximpressions,
    xinventory_fill,
    xclickthroughs,
    xrevenue
  ;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM liverail_order_stage
    WHERE 
      playlist_id = xplaylist_id and
      partner_id = xpartnerid and
      `order` = xorder_raw and
      country_id = xcountry_id and
      day = xdate;


    IF NOT xcount THEN
      INSERT INTO liverail_order_stage (
        playlist_id,
        partner_id,
        `order`,
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
        xorder_raw,
        xcountry_id,
        xdate,
        ximpressions,
	xclickthroughs,
	xinventory_fill,
        xrevenue
      );

    ELSE

      DELETE FROM liverail_order_stage
      WHERE
        playlist_id = xplaylist_id and
        partner_id = xpartnerid and
        `order` = xorder_raw and
        country_id = xcountry_id and
        day = xdate;

      INSERT INTO liverail_order_stage (
        partner_id,
        country_id,
        playlist_id,
        `order`,
        day,
        impressions,
	clickthroughs,
	inventory_fill,
        revenue
      )
      SELECT
        partnerid,
        country_id,
        playlist_id,
        order_raw,
        date,
        sum(impressions),
        sum(clickthroughs),
	sum(inventory_fill),
        sum(revenue)
      FROM
      (
        SELECT
          partnerid,
          liverail_countries.country_id,
          IF ( (4294967295 - CONV(mediaid,36,10)) between 0 and 4294967295, 4294967295 - CONV(mediaid,36,10), -1 ) as playlist_id,
          order_raw,
          date,
          impressions,
	  inventory_fill,
          clickthroughs,
          revenue
        FROM
          liverail_order_raw
        INNER JOIN
          liverail_countries
        ON liverail_order_raw.country = liverail_countries.name
        WHERE
          partnerid = xpartnerid AND
          order_raw = xorder_raw AND
          country_id = xcountry_id AND
          date = xdate
      ) as RAW
      WHERE
        playlist_id = xplaylist_id
      GROUP BY
        partnerid,
        country_id,
        playlist_id,
        order_raw,
        date
     ;


    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO liverail_order_raw_processed (
  partnername,
  partnerid,
  partnerid_raw,
  country,
  country_raw,
  mediaid,
  order_raw,
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
  order_raw,
  date,
  clickthroughs,
  impressions,
  inventory_fill,
  ecpm,
  revenue
FROM
liverail_order_raw;
    
DELETE FROM liverail_order_raw;

CLOSE cur;

END //
DELIMITER ;

