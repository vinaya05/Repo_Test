DELIMITER //

CREATE PROCEDURE update_generic_master_fact_for_duplicate_videos()
BEGIN

-- Variables for cursor

DECLARE xfrom_table_name varchar(64) DEFAULT 'duplicate_video_tracking';
DECLARE xto_table_name varchar(64) DEFAULT 'generic_master_fact';

DECLARE xhigh_water_mark bigint(20) DEFAULT 0;
DECLARE xnew_hwm bigint(20) DEFAULT 0;

-- Following statements can trigger NOT FOUND handler, thus we'll reset.

SELECT mark INTO xhigh_water_mark FROM high_water_mark WHERE from_table_name = xfrom_table_name AND to_table_name = xto_table_name;
SELECT max(id) INTO xnew_hwm FROM t5m_stats.generic_master_fact;

UPDATE t5m_stats.generic_master_fact as gmt
SET gmt.parent_video_id = 
    (
        SELECT dvt.parent_video_id
        FROM
                v3.duplicate_video_tracking AS dvt
        WHERE
                dvt.video_id=gmt.co_video_id
        AND
                dvt.project_id=gmt.co_project_id
    ),
    gmt.parent_project_id = 
    (
        SELECT dvt.parent_project_id
        FROM
                v3.duplicate_video_tracking AS dvt
        WHERE
                dvt.video_id=gmt.co_video_id
        AND
                dvt.project_id=gmt.co_project_id
    )
    WHERE
        gmt.id>xhigh_water_mark AND gmt.id<=xnew_hwm;

UPDATE t5m_stats.generic_master_fact as gmt
SET gmt.parent_account_id =
    (
        SELECT a.account_id
        FROM
                v3.wp_blog_posts AS a
        WHERE
        a.ID = gmt.parent_video_id AND
        a.blog_id = gmt.parent_project_id
    )
    WHERE
        gmt.id>xhigh_water_mark AND gmt.id<=xnew_hwm;

INSERT INTO high_water_mark (from_table_name, to_table_name, mark) VALUES (xfrom_table_name, xto_table_name, xnew_hwm)
ON DUPLICATE KEY UPDATE mark = xnew_hwm;

END //
DELIMITER ;
