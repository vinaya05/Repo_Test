-- Population of device dimension
-- Device is reported as Unknown when device has no mapping with us.

INSERT INTO `device_dimension` (`device_id`,`name`) VALUES
  (1, 'Unknown'),
  (2, 'Other'),
  (3, 'PC'),
  (4, 'Android'),
  (5, 'Tablet-iOS'),
  (6, 'iPhone/iPod-iOS'),
  (7, 'Symbian'),
  (8, 'Blackberry')
;

-- Population of liverail device mapping

INSERT INTO `liverail_device_mapping` (`os`, `device_id`) VALUES
  ('Unknown',1),
  ('Other',2),
  ('Linux',3),
  ('Mac OS',3),
  ('Windows 2000',3),
  ('Windows 2003',3),
  ('Windows 7',3),
  ('Windows 8',3),
  ('Windows Other',3),
  ('Windows Vista',3),
  ('Windows XP',3),
  ('Android',4),
  ('iOS iPad',5),
  ('iOS iPhone/iPod',6),
  ('SymbianOS',7),
  ('Blackberry',8)
;

-- Populate LiveRail Countries

INSERT INTO `liverail_countries`
  (name, country_id)
VALUES
  ('Bolivia',33),
  ('Puerto Rico',209),
  ('Estonia',75),
  ('Afghanistan',5),
  ('Pakistan',205),
  ('Virgin Islands, U.S.',295),
  ('Poland',206),
  ('Chile',52),
  ('Croatia',118),
  ('Kazakhstan',148),
  ('Ukraine',284),
  ('Bermuda',31),
  ('Iran, Islamic Republic of',130),
  ('Moldova, Republic of',163),
  ('United Arab Emirates',4),
  ('Kenya',138),
  ('Kuwait',146),
  ('Falkland Islands (Malvinas)',89),
  ('Nepal',192),
  ('Zambia',335),
  ('Czech Republic',64),
  ('Russian Federation',241),
  ('Guam',112),
  ('Isle of Man',126),
  ('Korea, Republic of',145),
  ('Georgia',99),
  ('Albania',8),
  ('Argentina',14),
  ('Hong Kong',115),
  ('Azerbaijan',20),
  ('Sierra Leone',254),
  ('Uganda',285),
  ('Greece',109),
  ('Barbados',22),
  ('Serbia',240),
  ('Saint Lucia',151),
  ('Sudan',246),
  ('Brazil',35),
  ('Bulgaria',26),
  ('India',127),
  ('Switzerland',49),
  ('Jersey',134),
  ('Jamaica',133),
  ('Malaysia',182),
  ('Paraguay',213),
  ('Jordan',136),
  ('Zimbabwe',337),
  ('Lebanon',150),
  ('Guernsey',101),
  ('Cyprus',63),
  ('Gibraltar',103),
  ('Venezuela',293),
  ('Singapore',249),
  ('Ireland',124),
  ('China',54),
  ('Turkey',279),
  ('Spain',82),
  ('France',93),
  ('New Zealand',196),
  ('Japan',137),
  ('Europe',84),
  ('Mexico',181),
  ('Finland',87),
  ('Thailand',271),
  ('Indonesia',123),
  ('Belgium',24),
  ('Austria',16),
  ('Canada',44),
  ('Italy',132),
  ('Norway',191),
  ('Australia',17),
  ('Denmark',68),
  ('Netherlands',190),
  ('Sweden',247),
  ('Germany',65),
  ('United States',288),
  ('United Kingdom',96),
  ('Algeria',72),
  ('American Samoa',15),
  ('Andorra',3),
  ('Angola',11),
  ('Anguilla',7),
  ('Antarctica',13),
  ('Antigua And Barbuda',6),
  ('Armenia',9),
  ('Aruba',18),
  ('Bahamas',36),
  ('Bahrain',27),
  ('Bangladesh',23),
  ('Belarus',42),
  ('Belize',43),
  ('Benin',29),
  ('Bhutan',37),
  ('Bosnia And Herzegovina',21),
  ('Botswana',40),
  ('Bouvet Island',39),
  ('British Indian Ocean Territory',128),
  ('Brunei Darussalam',32),
  ('Burkina Faso',25),
  ('Burundi',28),
  ('Cambodia',140),
  ('Cameroon',53),
  ('Cape Verde',60),
  ('Cayman Islands',147),
  ('Central African Republic',47),
  ('Chad',268),
  ('Christmas Island',62),
  ('Cocos (Keeling) Islands',45),
  ('Colombia',55),
  ('Comoros',142),
  ('Congo',48),
  ('Congo, The Democratic Republic Of The',46),
  ('Cook Islands',51),
  ('Costa Rica',57),
  ('Cuba',59),
  ('Djibouti',67),
  ('Dominica',69),
  ('Dominican Republic',70),
  ('Ecuador',74),
  ('Egypt',77),
  ('El Salvador',262),
  ('Equatorial Guinea',108),
  ('Eritrea',81),
  ('Ethiopia',83),
  ('Faroe Islands',92),
  ('Fiji',88),
  ('French Guiana',100),
  ('French Polynesia',201),
  ('French Southern Territories',269),
  ('Gabon',95),
  ('Gambia',105),
  ('Ghana',102),
  ('Greenland',104),
  ('Grenada',98),
  ('Guadeloupe',107),
  ('Guatemala',111),
  ('Guinea',106),
  ('Guinea-Bissau',113),
  ('Guyana',114),
  ('Haiti',119),
  ('Heard Island And Mcdonald Islands',116),
  ('Holy See (Vatican City State)',291),
  ('Honduras',117),
  ('Hungary',120),
  ('Iceland',131),
  ('Iraq',129),
  ('Israel',125),
  ('Kiribati',141),
  ('Korea, Democratic People\'s Republic Of',144),
  ('Kyrgyzstan',139),
  ('Lao People\'s Democratic Republic',149),
  ('Latvia',159),
  ('Lesotho',156),
  ('Liberia',155),
  ('Liechtenstein',90),
  ('Lithuania',157),
  ('Luxembourg',158),
  ('Macao',172),
  ('Macedonia, The Former Yugoslav Republic Of',168),
  ('Madagascar',166),
  ('Malawi',180),
  ('Maldives',179),
  ('Mali',169),
  ('Malta',177),
  ('Marshall Islands',167),
  ('Martinique',174),
  ('Mauritania',175),
  ('Mauritius',178),
  ('Mayotte',331),
  ('Micronesia, Federated States Of',91),
  ('Monaco',162),
  ('Mongolia',171),
  ('Montenegro',164),
  ('Montserrat',176),
  ('Morocco',161),
  ('Mozambique',183),
  ('Myanmar',170),
  ('Namibia',184),
  ('Nauru',193),
  ('New Caledonia',185),
  ('Nicaragua',189),
  ('Niger',186),
  ('Nigeria',188),
  ('Niue',195),
  ('Norfolk Island',187),
  ('Northern Mariana Islands',173),
  ('Oman',198),
  ('Palau',212),
  ('Palestinian Territory, Occupied',210),
  ('Panama',199),
  ('Papua New Guinea',202),
  ('Peru',200),
  ('Philippines',203),
  ('Pitcairn',208),
  ('Portugal',211),
  ('Qatar',214),
  ('Romania',238),
  ('Rwanda',242),
  ('Saint Kitts And Nevis',143),
  ('Saint Pierre And Miquelon',207),
  ('Saint Vincent And The Grenadines',292),
  ('Samoa',302),
  ('San Marino',255),
  ('Sao Tome And Principe',260),
  ('Saudi Arabia',243),
  ('Senegal',256),
  ('Seychelles',245),
  ('Slovakia',253),
  ('Slovenia',251),
  ('Solomon Islands',244),
  ('Somalia',257),
  ('South Africa',334),
  ('South Georgia And The South Sandwich Islands',110),
  ('South Sudan',259),
  ('Sri Lanka',154),
  ('Suriname',258),
  ('Svalbard And Jan Mayen',252),
  ('Swaziland',265),
  ('Syrian Arab Republic',264),
  ('Taiwan, Province Of China',282),
  ('Tajikistan',272),
  ('Tanzania, United Republic Of',283),
  ('Timor-Leste',274),
  ('Togo',270),
  ('Tokelau',273),
  ('Tonga',277),
  ('Trinidad And Tobago',280),
  ('Tunisia',276),
  ('Turkmenistan',275),
  ('Turks And Caicos Islands',267),
  ('Tuvalu',281),
  ('United States Minor Outlying Islands',287),
  ('Uruguay',289),
  ('Uzbekistan',290),
  ('Vanuatu',297),
  ('Viet Nam',296),
  ('Virgin Islands, British',294),
  ('Wallis And Futuna',298),
  ('Western Sahara',78),
  ('Yemen',330),
  ('Unknown', 338)
  ;


-- Mapping for 3rd Party Players for ITN
INSERT INTO `liverail_third_party_player_publisher`
            SELECT partner_id, pub_account_id, 2
                    FROM liverail_partner_mapping
                    WHERE partner_id in (701312, 699386, 700831, 701791, 705491, 702122, 708462);

-- Mapping for 3rd Party Players for MP&Silva
INSERT INTO `liverail_third_party_player_publisher`
             SELECT partner_id, pub_account_id, 2562
                     FROM liverail_partner_mapping
                     WHERE partner_id = 3227;
