use v3;

-- Populate LiveRail partner mapping

INSERT IGNORE INTO 
  publisher_tracking_codes (
    lr_partnerId,
    account_id
  )
VALUES
  (1, 1001),
  (2, 1002)
;

INSERT IGNORE INTO
  playlists_0 (
    id,
    post_id
  )
VALUES
  (7711, 1),
  (7708, 2),
  (7743, 3),
  (7742, 4),
  (2923303198, 5),
  (4247120441, 6),
  (4255458064, 7),
  (4293955285, 8),
  (4294372046, 9),
  (4293693921, 10),
  (4246509178, 11)
;

INSERT IGNORE INTO
  wp_blog_posts (
    id,
    blog_id,
    post_title
  )
VALUES
  (1, 1, '1'),
  (2, 3, '2'),
  (3, 2, '3'),
  (4, 2, '4'),
  (5, 2, '5'),
  (6, 2, '6'),
  (7, 2, '7'),
  (8, 2, '8'),
  (9, 2, '9'),
  (10, 2, '10'),
  (11, 2, '11')
;

INSERT IGNORE INTO
  wp_blogs (
    blog_id,
    account_id,
    name
  )
VALUES
  (1, 1, '1'),
  (2, 1, '2'),
  (3, 2, '3')
;


INSERT IGNORE INTO
  wp_bp_groups (
    id,
    name
  )
VALUES
  (1, '1'),
  (2, '2'),
  (1001, '1001'),
  (1002, '1002')
;

use t5m_stats;

SET autocommit=0;

INSERT INTO `liverail_raw`
  (partnerid, country, mediaid, os, date, impressions, clickthroughs, revenue)
VALUES
  (1, 'India', '1z13w0w', 'Linux', '2012-12-04', 8, 2, 0.1),
  (1, 'United Kingdom', '1z13w0z', 'Windows XP', '2012-12-04', 8, 2, 0.1),
  (1, 'United Kingdom', 'crap', 'Windows XP', '2012-12-06', 900, 72, 0.8),
  (1, 'United Kingdom', '01z13w00', 'Windows XP', '2012-12-07', 900, 73, 0.8),
  (1, 'United Kingdom', 'rightster', 'Windows XP', '2012-12-07', 900, 74, 0.8),
  (1, 'United Kingdom', 'monish', 'Windows XP', '2012-12-07', 900, 75, 0.8),
  (1, 'United Kingdom', 'nitin', 'Windows XP', '2012-12-07', 900, 76, 0.8),
  (1, 'United Kingdom', 'raji', 'Windows XP', '2012-12-07', 900, 77, 0.8),
  (1, 'United Kingdom', '1z13w0z', 'Windows 2003', '2012-12-04', 2000, 100, 9.1)
;

INSERT INTO `liverail_raw`
  (partnerid, mediaid, date, impressions, clickthroughs, revenue)
VALUES
  (1, '1z13w0w', '2012-12-04', 8, 2, 0.1)
;


-- call liverail_etl();

COMMIT;

INSERT INTO `liverail_raw`
  (partnerid, country, mediaid, os, date, impressions, clickthroughs, revenue)
VALUES
  (2, 'India', '1z13w0w', 'Linux', '2012-12-05', 9, 5, 0.5),
  (1, 'India', '1z13w0z', 'Windows XP', '2012-12-04', 80, 20, 0.1),
  (1, 'India', '1z13w0z', 'Windows 2003', '2012-12-04', 80, 20, 0.1),
  (2, 'United Kingdom', '1z13w0z', 'Windows XP', '2012-12-05', 9, 7, 0.8),
  (2, 'United Kingdom', '1z13w0z', 'Android', '2012-12-05', 9, 7, 0.8),
  (1, 'United Kingdom', '1z13w00', 'Windows XP', '2012-12-04', 900, 70, 0.8),
  (1, 'United Kingdom', '1z13w01', 'Windows XP', '2012-12-04', 786, 89, 0.9),
  (1, 'United Kingdom', 'unknown', 'Windows XP', '2012-12-04', 900, 70, 0.8),
  (1, 'United Kingdom', '-1', 'Windows XP', '2012-12-04', 1900, 170, 0.8),
  (1, 'United Kingdom', '-1', 'Windows XP', '2012-12-05', 1900, 170, 0.8),
  (1, 'United Kingdom', '1z13w00', 'Windows XP', '2012-12-06', 900, 71, 0.8),
  (1, 'United Kingdom', 'shiva', 'Windows XP', '2012-12-07', 900, 78, 0.8),
  (1, 'United Kingdom', 'love', 'Windows XP', '2012-12-07', 900, 79, 0.8),
  (1, 'United Kingdom', 'sumit', 'Windows XP', '2012-12-07', 900, 80, 0.8),
  (1, 'Germany', 'sumit', 'Windows XP', '2012-12-07', 0, 0, 0)
;

-- call liverail_etl();

COMMIT;

