DELIMITER //
CREATE PROCEDURE proc_aggregate_video_all_time_from_generic_video_daily_fact()
BEGIN
-- Variables for cursor
START TRANSACTION;
DELETE FROM aggregate_video_all_time;

INSERT INTO aggregate_video_all_time (
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        content_type,
        source_id,
        loads,
        plays,
        ad_clicks,
        ad_impressions,
        ad_revenue,
	inventory_pre,
	parent_video_id,
	parent_project_id,
	parent_account_id
        )
SELECT
        co_account_id,
        co_project_id,
        co_video_id,
        pub_account_id,
        content_type,
        source_id,
        IFNULL(SUM(loads),0),
        IFNULL(SUM(plays),0),
        IFNULL(SUM(ad_clicks),0),
        IFNULL(SUM(ad_impressions),0),
        IFNULL(SUM(ad_revenue),0),
	IFNULL(SUM(inventory_pre),0),
	parent_video_id,
	parent_project_id,
	parent_account_id
FROM
        t5m_stats.generic_video_daily_fact
GROUP BY
        `co_account_id`,
        `co_project_id`,
        `co_video_id`,
        `pub_account_id`,
        `content_type`,
        `source_id`
;
COMMIT;

END //
DELIMITER ;
