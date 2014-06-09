DELIMITER //

CREATE PROCEDURE update_liverail_revenue_master_fact(input_date date)
BEGIN

DECLARE done INT DEFAULT 0;

-- DIMENSION and METRIC definitions

DECLARE cur_year INT;
DECLARE cur_month INT;
DECLARE temp_date VARCHAR(10);
DECLARE start_date DATE;
DECLARE end_date DATE;
DECLARE xid int(11);
DECLARE xorder varchar(64);
DECLARE xadsource varchar(64);
DECLARE xcountry_id int(3);
DECLARE xday date;
DECLARE xcpm float(11,4);

DECLARE cur CURSOR FOR 
			SELECT
			  lrmf.id,
			  lrmf.`order`,
			  lrmf.adsource,
			  lrmf.country_id,
			  lci.cpm
			from
			  liverail_revenue_master_fact lrmf
			inner join 
			  liverail_cpm_info lci
			on
                          lrmf.`order` <=> lci.`order` and
                          lrmf.adsource <=> lci.adsource and
                          lrmf.country_id <=> lci.country_id and
                          month(lci.`month`) = cur_month and
                          year(lci.`month`) = cur_year
			WHERE
			  day between start_date and end_date
;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.
SET cur_year = (SELECT YEAR(input_date));
SET cur_month = (SELECT MONTH(input_date));
SET temp_date = (SELECT CONCAT(cur_year,'-',cur_month,'-01'));
SET start_date = (SELECT CAST(temp_date AS DATE));
SET end_date = (SELECT DATE_ADD(start_date, INTERVAL 1 MONTH));

IF done THEN
  SET done = 0;
END IF;

OPEN cur;

REPEAT

  FETCH cur INTO
    xid,
    xorder,
    xadsource,
    xcountry_id,
    xcpm
  ;

   UPDATE liverail_revenue_master_fact
   SET ad_revenue = xcpm/1000 * ad_impressions
   where
   id=xid
  ;

UNTIL done
END REPEAT;

CLOSE cur;

END //
DELIMITER ;

