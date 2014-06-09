use t5m_stats;

select
  distinct(lrp.os_raw) as NEW_LIVERAIL_DEVICE
from
  t5m_stats.liverail_raw_processed lrp
left outer join
  t5m_stats.liverail_device_mapping ldm
on
  lrp.os_raw = ldm.os
;

