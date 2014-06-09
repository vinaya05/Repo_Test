DROP procedure IF EXISTS liverail_etl;
DELIMITER //
CREATE PROCEDURE liverail_etl(IN irunname varchar(255))
BEGIN
  call populate_liverail_stage(irunname);
  call populate_liverail_master_fact();
  call aggregate_liverail_facts();
  call generic_etl_bulk();
END //
DELIMITER ;

-- SET GLOBAL wait_timeout=30;
-- SET GLOBAL interactive_timeout=30;

