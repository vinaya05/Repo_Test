insert into source_dimension(id,source) values 
(6,'youtube_cms'),
(5,'youtube_api'),
(4,'rightster_player_plays'),
(3,'rightster_player_views'),
(2,'youtube'),
(1,'liverail')
;              

insert into ui_source_list(id,name) values
(4,'rightster_player'),
(3,'liverail'),
(2,'youtube'),
(1,'all')
;

insert into source_dimension_mapping(ui_source_id,source_id) values
(4,1),
(4,3),
(4,4),
(3,1),
(2,2),
(1,1),
(1,2),
(1,3),
(1,4)
;
