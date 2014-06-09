/**
 * Routine populate_publisher_content_ad_impressions
 * Copy Data from liverail_stage => publisher_content_adimpressions_2
 *
 * @author Mukesh Sharma <mukesh.sharma@rightster.com> 
 * Wed Jan  8 22:16:28 IST 2014
 */

DELIMITER //

CREATE PROCEDURE populate_publisher_content_ad_impressions()
BEGIN

DECLARE xfrom_table_name varchar(64) DEFAULT 'liverail_stage';
DECLARE xto_table_name   varchar(64) DEFAULT 'publisher_content_adimpressions_2';
DECLARE done INT DEFAULT 0;

-- DEMINSION and METRIC definitions

DECLARE xtid            int(10);
DECLARE xvid            bigint(20);
DECLARE ximpressions    int(10);
DECLARE xserved_on      date;
DECLARE xinventory_pre  int(10);
DECLARE xrevenue        float(11,4);
DECLARE xpartner_id     int(11);

DECLARE xhigh_water_mark    bigint(20) DEFAULT 0;
DECLARE xnew_hwm            bigint(20) DEFAULT 0;
DECLARE xcount              int(1)     DEFAULT 0;

DECLARE cur CURSOR FOR 
SELECT * FROM
(
    SELECT
        ls.playlist_id        as vid,
        (SELECT tid 
            FROM v3.publisher_tracking_codes as pc 
            WHERE pc.lr_partnerId = ls.partner_id 
            ORDER BY tid ASC LIMIT 1
                            ) as tid,
        ls.day                as served_on,
        sum(ls.impressions)   as impressions,
        sum(ls.revenue)       as revenue,
        sum(ls.inventory_pre) as inventory_pre,
        ls.partner_id         as partner_id
    FROM
        t5m_stats.liverail_stage      as ls
    WHERE
        ls.id > xhigh_water_mark
    AND
        ls.id <= xnew_hwm
    AND 
        ls.partner_id != -1
    GROUP BY 
        tid,    
        ls.playlist_id,
        ls.day
) as the_master;


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
    xvid,
    xtid,
    xserved_on,
    ximpressions,
    xrevenue,
    xinventory_pre,
    xpartner_id;


  IF NOT done THEN

    SELECT count(1) INTO xcount FROM v3.publisher_content_adimpressions_2  
    WHERE 
      vid       = xvid and
      tid       = xtid and
      served_on = xserved_on;

    IF NOT xcount THEN
      INSERT INTO v3.publisher_content_adimpressions_2 (
        tid,
        vid,
        impressions,
        served_on,
        inventory_pre,
        revenue
      )
      VALUES (
        xtid,
        xvid,
        ximpressions,
        xserved_on,
        xinventory_pre,
        xrevenue
      );

    ELSE

      DELETE FROM v3.publisher_content_adimpressions_2
      WHERE
          vid       = xvid and
          tid       = xtid and
          served_on = xserved_on;

      INSERT INTO v3.publisher_content_adimpressions_2 (
        tid,
        vid,
        impressions,
        served_on,
        inventory_pre,
        revenue
      ) 
      SELECT
          (SELECT tid 
                FROM v3.publisher_tracking_codes as pc 
                WHERE pc.lr_partnerId = ls.partner_id 
                ORDER BY tid ASC LIMIT 1
                              ) as tid,
          ls.playlist_id        as vid,
          sum(ls.impressions)   as impressions,
          ls.day                as served_on,
          sum(ls.inventory_pre) as inventory_pre,
          sum(ls.revenue)       as revenue
      FROM
          t5m_stats.liverail_stage      as ls
      WHERE
          ls.playlist_id = xvid
      AND
          ls.partner_id  = xpartner_id
      AND 
          ls.day = xserved_on
      GROUP BY
          tid,    
          ls.playlist_id,
          ls.day
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
