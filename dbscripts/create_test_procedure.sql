DROP TABLE IF EXISTS `nv_test`;

CREATE TABLE `nv_test` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dim1` varchar(10) NOT NULL,
  `dim2` varchar(10) NOT NULL,
  `metric1` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`dim1`,`dim2`),
  KEY (`dim1`),
  KEY (`dim2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `nv_test1`;

CREATE TABLE `nv_test1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dim1` varchar(10) NOT NULL,
  `metric1` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`dim1`),
  KEY (`dim1`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `nv_hwm`;

CREATE TABLE `nv_hwm` (
  `from_table_name` varchar(64),
  `to_table_name` varchar(64),
  `mark` bigint(20),
  PRIMARY KEY (`from_table_name`, `to_table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP PROCEDURE IF EXISTS test1;

DELIMITER // 
CREATE PROCEDURE test1()

-- http://dev.mysql.com/doc/refman/5.0/en/fetch.html

BEGIN

DECLARE done INT DEFAULT 0;
DECLARE xdim1 varchar(10);
DECLARE xmetric1 int(10);
DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;
DECLARE xcount int(1) DEFAULT 0;
DECLARE cur CURSOR FOR 
SELECT
  dim1, sum(metric1) 
FROM 
  nv_test
WHERE
  id > xhigh_water_mark
GROUP BY
dim1;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SELECT mark INTO xhigh_water_mark FROM nv_hwm WHERE from_table_name = 'nv_test' and to_table_name = 'nv_test1';

IF done THEN
  SET done = 0;
END IF;

SELECT max(id) INTO xnew_hwm FROM nv_test;
SELECT xhigh_water_mark as HWM;

OPEN cur;

REPEAT

  FETCH cur INTO xdim1, xmetric1;
  SELECT done as DONE;
  IF NOT done THEN
    SELECT count(1) INTO xcount FROM nv_test1 where dim1 = xdim1;
    SELECT xdim1 as DIM1, xcount as Count;
    IF NOT xcount THEN
      INSERT INTO nv_test1 (dim1, metric1) VALUES (xdim1, xmetric1);
    ELSE
      DELETE FROM nv_test1 WHERE dim1 = xdim1;
      INSERT INTO nv_test1 (dim1, metric1) SELECT dim1, sum(metric1) FROM nv_test WHERE dim1 = xdim1 GROUP BY dim1;
    END IF;
  END IF;

UNTIL done
END REPEAT;

INSERT INTO nv_hwm (from_table_name, to_table_name, mark) VALUES ('nv_test', 'nv_test1', xnew_hwm)
ON DUPLICATE KEY UPDATE mark = xnew_hwm;

CLOSE cur;

END //
DELIMITER ; 


INSERT INTO `nv_test`
  (`dim1`, `dim2`, `metric1`)
VALUES
  ('A1', 'A2', 87),
  ('A1', 'B2', 97),
  ('B1', 'B2', 90),
  ('C1', 'C2', 10)
;

SELECT * from nv_test;

-- INSERT INTO `nv_test1`
--   (`dim1`, `metric1`)
-- VALUES
--   ('A1', 187),
--   ('D1', 56)
-- ;


call test1();

SELECT * from nv_test1;

INSERT INTO `nv_test`
  (`dim1`, `dim2`, `metric1`)
VALUES
  ('E1', 'A2', 89),
  ('F1', 'B2', 97),
  ('E1', 'B2', 88),
  ('C1', 'D2', 10)
;

SELECT * from nv_test;

call test1();


SELECT * from nv_test1;


INSERT INTO `nv_test`
  (`dim1`, `dim2`, `metric1`)
VALUES
  ('E1', 'E2', 89),
  ('F1', 'A2', 97),
  ('E1', 'F2', 88),
  ('C1', 'E2', 10)
;


call test1();


