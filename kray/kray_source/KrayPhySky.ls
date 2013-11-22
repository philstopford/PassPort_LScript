
/*

Kray Physical Sky Script
by Jure Judez
Modification and *FREE* redistribution allowed

User Interface Modifcations, Get Time/Date/Location functions Matt Gorner

*/

@asyncspawn
@warnings 
@version 2.4
@script master
@save relative
@name Kray Physical Sky
@define KRAY_COMRING "kray_hub_comring"

version=1096;
guisetup_flag=0;

c_onFlag;
v_onFlag=1;

modal=0;

c_north;
v_north=0; // north direction (~90 is LW north)

c_second;
v_second=0;
c_minute;
v_minute=0;
c_hour;
v_hour=15;

c_day;
v_day=2;
c_month;
v_month=6; // June
months_list=@"January","February","March","April","May","June","July","August","September","October","November","December"@;
c_year;
v_year=2009;

// Longitude / Latitude variables moved below HUGE arrays!  So we can pull the values from there
// Initial selected city on launch
c_city_preset;
v_city_preset = 1;

c_lattitude;
v_lattitude=15; // (-90,90) south to north
c_longitude;
v_longitude=46; // (-180>+180)

c_time_zone;
v_time_zone=1;  // 0=GMT 1=CET ... (0-23)
c_day_of_year;
v_day_of_year=172; // (1-365)
c_time_of_day;
v_time_of_day=12; // (0.0,23.99) 14.25 = 2:15PM
c_turbidity;
v_turbidity=2;  // (1.0,30+) 2-6 are most useful for clear days.
c_exposure;
v_exposure=3;

c_volumetric;
v_volumetric=0;

ignoreID;
v_ignore = nil; c_ignore; 
skyON = 1; c_skyON;
sunON = 1; c_sunON;

// map image frame
frame_x = 46;
frame_y = 84;

frame_w = 360;
frame_h = 180;

frame_max_x = 360 + frame_x;
frame_max_y = 180 + frame_y;

map_image;

mouse_x;
mouse_y;

c_SunIntensity;
v_SunIntensity=1;
c_SunShadow;
v_SunShadow=1;

sunarea_min = 1;
sunarea_max = 1;

c_SunPower;
v_sunpower = 1;

city_presets_list=@"(none)",
"AFGHANISTAN - Kabul",
"ALBANIA - Tirane",
"ALGERIA - Algiers",
"ANTARTICA - Casey",
"ANTARTICA - Mawson",
"ANTARTICA - South Pole",
"ARGENTINA - Buenos Aires",
"ARGENTINA - Cordoba",
"ARGENTINA - Tucuman",
"ARMENIA - Yerevan",
"AUSTRALIA - Adelaide",
"AUSTRALIA - Alice Springs",
"AUSTRALIA - Brisbane",
"AUSTRALIA - Broken Hill",
"AUSTRALIA - Darwin",
"AUSTRALIA - Hobart",
"AUSTRALIA - Lindeman",
"AUSTRALIA - Lord Howe",
"AUSTRALIA - Melbourne",
"AUSTRALIA - Perth",
"AUSTRALIA - Sydney",
"AUSTRIA - Vienna",
"AZORES - Lajes (Terceira)",
"BANGLADESH - Dacca",
"BELARUS - Minsk",
"BELGIUM - Brussels",
"BENIN - Porto-Novo",
"BERMUDA - Kindley",
"BHUTAN - Thimbu",
"BOLIVIA - La Paz",
"BOSNIA AND HERZEGOVINA - Sarajevo",
"BOTSWANA - Gaborone",
"BRAZIL - Belem",
"BRAZIL - Belo Horizonte",
"BRAZIL - Brasilia",
"BRAZIL - Fortaleza",
"BRAZIL - Rio De Janeiro",
"BRAZIL - Salvador",
"BRAZIL - Sao Paulo",
"BRAZIL - Vera Cruz",
"BRITISH VIRGIN ISLANDS - Tortola",
"BULGARIA - Sofia",
"BURKINA FASO - Ouagadougou",
"CAMBODIA - Phnom Penh",
"CANADA - Calgary",
"CANADA - Dawson Creek",
"CANADA - Edmonton",
"CANADA - Halifax",
"CANADA - Hamilton",
"CANADA - Montreal",
"CANADA - Oshawa",
"CANADA - Ottawa",
"CANADA - Quebec",
"CANADA - Regina",
"CANADA - Saskatoon",
"CANADA - Sydney",
"CANADA - Toronto",
"CANADA - Vancouver",
"CANADA - Windsor",
"CANADA - Winnipeg",
"CARIBBEAN - Bermuda",
"CARIBBEAN - Canary",
"CARIBBEAN - Cape Verde",
"CARIBBEAN - Faeroe",
"CARIBBEAN - St Kitts",
"CARIBBEAN - St Lucia",
"CARIBBEAN - St Vincent",
"CENTRAL AMERICA - Belize",
"CENTRAL AMERICA - Dominica",
"CENTRAL AMERICA - Grand Turk",
"CENTRAL AMERICA - Grenada",
"CENTRAL AMERICA - Guadalajara",
"CENTRAL AMERICA - Guadeloupe",
"CENTRAL AMERICA - Guatemala",
"CENTRAL AMERICA - Jamaica",
"CENTRAL AMERICA - La Paz",
"CENTRAL AMERICA - Managua",
"CHAD - Ndjamena",
"CHILE - Santiago",
"CHILE - Valparaiso",
"CHINA - Macao",
"CHINA - Shanghai",
"COLOMBIA - Bogota",
"COLOMBIA - Cali",
"COLOMBIA - Medellin",
"CONGO - Brazzaville",
"CROATIA - Zagreb",
"CUBA - Guantanamo Bay",
"CUBA - Havana",
"CYPRUS - Nicosia",
"CZECH REPUBLIC - Prague",
"DENMARK - Copenhagen",
"DOMINICAN REPUBLIC - Santo Domingo",
"ECUADOR - Quito",
"EGYPT - Cairo",
"EL SALVADOR - San Salvador",
"ESTONIA - Tallinn",
"ETHIOPIA - Addis Ababa",
"ETHIOPIA - Asmara",
"FALKLAND - Port Stanley",
"FALKLAND-South Georgia",
"FINLAND - Helsinki",
"FRANCE - Lyon",
"FRANCE - Marseilles",
"FRANCE - Nantes",
"FRANCE - Nice",
"FRANCE - Paris",
"FRANCE - Strasbourg",
"FRENCH GUIANA - Cayenne",
"GEORGIA - Tbilisi",
"GERMANY - Berlin",
"GERMANY - Frankfurt a. Main",
"GERMANY - Hamburg",
"GERMANY - Hannover",
"GERMANY - Leipzig",
"GERMANY - Mannheim",
"GERMANY - Munich",
"GHANA - Accra",
"GREECE - Athens",
"GREECE - Thessaloniki",
"GUYANA - Georgetown",
"HAITI - Port Au Prince",
"HONDURAS - Tegucigalpa",
"HONG KONG - Hong Kong",
"HUNGARY - Budapest",
"ICELAND - Reykjavik",
"INDIA - Ahmedabad",
"INDIA - Bangalore",
"INDIA - Bombay",
"INDIA - Calcutta",
"INDIA - New Delhi",
"INDONESIA - Jakarta",
"INDONESIA - Kupang",
"INDONESIA - Medan",
"INDONESIA - Palembang",
"IRAN - Tehran",
"IRAQ - Baghdad",
"IRAQ - Mosul",
"IRELAND - Dublin",
"ISRAEL - Jerusalem",
"ISRAEL - Tel Aviv",
"ITALY - Milan",
"ITALY - Napoli",
"ITALY - Rome",
"IVORY COAST - Abidjan",
"JAPAN - Sapporo",
"JAPAN - Tokyo",
"JORDAN - Amman",
"KAZAKHSTAN - Alma Ata",
"KENYA - Nairobi",
"KOREA - Seoul",
"KUWAIT - Kuwait",
"LAOS - Vientiane",
"LATVIA - Riga",
"LEBANON - Beirut",
"LIBERIA - Monrovia",
"LIBYA - Tripoli",
"LUXEMBOURG - Luxembourg",
"MACEDONIA - Skopje",
"MADAGASCAR - Antananarivo",
"MALAYSIA - Kuala Lumpur",
"MALAYSIA - Penang",
"MALTA - Malta",
"MAURITANIA - Nouakchott",
"MEXICO - Acapulco",
"MEXICO - Mexico City",
"MEXICO - Monterrey",
"MONACO - Monaco",
"MONGOLIA - Ulaanbaatar",
"MOROCCO - Casablanca",
"MYANMAR - Rangoon",
"N. ATLANTIC - St Helena",
"NAMIBIA - Windhoek",
"NEPAL - Kathmandu",
"NETHERLANDS - Amsterdam",
"NEW PRODIVENCE - Nassau",
"NEW ZEALAND - Auckland",
"NEW ZEALAND - Christchurch",
"NEW ZEALAND - Wellington",
"NIGERIA - Lagos",
"NIGER - Niamey",
"NORTH ATLANTIC - Jan Mayen",
"NORTH KOREA - Pyongyang",
"NORWAY - Bergen",
"NORWAY - Oslo",
"OMAN - Muscat",
"PACIFIC - Fiji",
"PACIFIC - Fukuoka",
"PACIFIC - Galapagos",
"PACIFIC - Guadalcanal",
"PACIFIC - Guam",
"PACIFIC - Nauru",
"PACIFIC - Niue",
"PACIFIC - Norfolk",
"PACIFIC - Pago Pago",
"PACIFIC - Palau",
"PACIFIC - Port Moresby",
"PACIFIC - Saipan",
"PAKISTAN - Karachi",
"PAKISTAN - Lahore",
"PAKISTAN - Peshawar",
"PANAMA - Panama City",
"PAPUA NEW GUINEA - Port Moresby",
"PARAGUAY - Asuncion",
"PERU - Lima",
"Puerto RICO - San Juan",
"PHILIPPINES - Manila",
"POLAND - Krakow",
"POLAND - Warsaw",
"PORTUGAL - Lisbon",
"QATAR - Qatar",
"ROMANIA - Bucharest",
"RUSSIA - Kaliningrad",
"RUSSIA - Krasnoyarsk",
"RUSSIA - Moscow",
"RUSSIA - Rostov",
"RUSSIA - Vladivostok",
"RUSSIA - Volgograd",
"SAN MARINO - San Marino",
"SAO TOME AND PRINCIPE - Sao Tome",
"SAUDI ARABIA - Dhahran",
"SAUDI ARABIA - Riyadh",
"SENEGAL - Dakar",
"SERBIA - Belgrade",
"SINGAPORE - Singapore",
"SLOVAKIA - Bratislava",
"SLOVENIA - Ljubljana",
"SOMALIA - Mogadishu",
"SOUTH AFRICA - Cape Town",
"SOUTH AFRICA - Johannesburg",
"SOUTH AFRICA - Pretoria",
"SOUTH YEMEN - Aden",
"SPAIN - Barcelona",
"SPAIN - Madrid",
"SPAIN - Valencia",
"SRI LANKA - Colombo",
"SUDAN - Khartoum",
"SURINAME - Paramaribo",
"SWEDEN - Stockholm",
"SWITZERLAND - Zurich",
"SYRIA - Damascus",
"TAIWAN - Taipei",
"TAJIKISTAN - Dushanbe",
"TANZANIA - Dar es Salaam",
"THAILAND - Bangkok",
"TONGA - Tongatapu",
"TRINIDAD&TOBAGO - Port of Spain",
"TUNISIA - Tunis",
"TURKEY - Ankara",
"TURKEY - Istanbul",
"TURKEY - Izmir",
"TURKMENISTAN - Ashkhabad",
"UAE - Dubai",
"UKRANIE - Kiev",
"UKRANIE - Odessa",
"UNITED KINGDOM - Belfast",
"UNITED KINGDOM - Birmingham",
"UNITED KINGDOM - Cardiff",
"UNITED KINGDOM - Edinburgh",
"UNITED KINGDOM - Gibraltar",
"UNITED KINGDOM - Glasgow",
"UNITED KINGDOM - London",
"URUGUAY - Montevideo",
"US VIRGIN ISLANDS - St Thomas",
"USA - Albany",
"USA - Albuquerque",
"USA - Atlanta",
"USA - Atlantic City",
"USA - Baltimore",
"USA - Boston",
"USA - Buffalo",
"USA - Chicago",
"USA - Columbia",
"USA - Dallas",
"USA - Denver",
"USA - Detroit",
"USA - Honolulu",
"USA - Houston",
"USA - Indianapolis",
"USA - Las Vegas",
"USA - Little Rock",
"USA - Los Angeles",
"USA - Memphis",
"USA - Miami",
"USA - Milwaukee",
"USA - Minneapolis - St. Paul",
"USA - Nashville",
"USA - New Orleans",
"USA - NYC-Central Park",
"USA - Oklahoma City",
"USA - Orlando",
"USA - Philadelphia",
"USA - Phoenix",
"USA - Pittsburgh",
"USA - Portland",
"USA - Reno",
"USA - Salt Lake City",
"USA - San Diego",
"USA - San Francisco",
"USA - Santa Fe",
"USA - Seattle",
"USA - Tampa",
"USA - Tulsa",
"USA - Washington",
"UZBEKISTAN - Tashkent",
"VENEZUELA - Caracas",
"VENEZUELA - Maracaibo",
"VIETNAM - Hanoi",
"VIETNAM - Saigon",
"ZIMBABWE - Harare"@;

city_coords_list=@"34.516666","69.199997","450",
"41.333332","19.833334","100",
"36.76667","30.05000","100",
"-66.283333","110.516670","800",
"-67.599998","62.883335","600",
"-90.000000","0.000000","1300",
"-34.58333","-58.48333","-300",
"-31.36667","-64.25000","-300",
"-26.83333","-65.16667","-300",
"40.183334","44.500000","400",
"-34.916668","138.583328","1050",
"-23.80000","133.88333","930",
"-27.466667","153.033340","1000",
"-31.950001","141.449997","1050",
"-12.466666","130.833328","930",
"-42.883335","147.316666","1100",
"-20.266666","149.000000","1000",
"-31.549999","159.083328","1100",
"-37.816666","144.966660","1100",
"-31.950001","115.849998","800",
"-33.866665","151.216660","1100",
"48.25000","16.36667","100",
"38.75000","-27.08333","100",
"23.716667","90.416664","600",
"53.900002","27.566668","200",
"50.833332","4.333333","100",
"6.483333","2.616667","100",
"33.36667","-64.68333","-400",
"27.466667","89.650002","600",
"-16.50000","-68.15000","-400",
"43.866665","18.416666","100",
"-25.750000","25.916666","200",
"-1.45000","-48.48333","-300",
"-19.93333","-43.95000","-300",
"-15.86667","-47.91667","-300",
"-3.76667","-38.55000","-300",
"-22.91667","-43.20000","-300",
"-13.00000","-38.50000","-300",
"-23.55000","-46.63333","-300",
"19.20000","-96.13333","-300",
"18.450001","-64.616669","-400",
"42.683334","23.316668","200",
"12.366667","-1.516667","0",
"11.550000","104.916664","700",
"51.10000","-114.01667","-700",
"55.73333","-120.18333","-700",
"53.56667","-113.51667","-700",
"44.65000","-63.56667","-400",
"43.26667","-79.90000","-500",
"45.46667","-73.75000","-500",
"43.90000","-78.86667","-500",
"45.31667","-75.66667","-500",
"46.80000","-71.38333","-500",
"50.43333","-104.66667","-600",
"52.16667","-106.68333","-600",
"46.16667","-60.05000","-400",
"43.68333","-79.63333","-500",
"49.18333","-123.16667","-800",
"42.26667","-82.96667","-500",
"49.90000","-97.23333","-600",
"32.283333","-64.766670","-400",
"28.100000","-15.400000","0",
"14.916667","-23.516666","-100",
"62.016666","-6.766667","0",
"17.299999","-62.716667","-400",
"14.016666","-61.000000","-400",
"13.150000","-61.233334","-400",
"17.51667","-88.18333","-600",
"15.300000","-61.400002","-400",
"21.466667","-71.133331","-500",
"12.050000","-61.750000","-400",
"20.68333","-103.33333","-600",
"16.233334","-61.533333","-400",
"14.633333","-90.516670","-600",
"18.000000","-76.800003","-500",
"-16.500000","-68.150002","-400",
"12.16667","-86.25000","-600",
"12.116667","15.050000","100",
"-33.450001","-70.666664","-300",
"-33.01667","-71.63333","-400",
"22.233334","113.583336","800",
"31.20000","121.43333","800",
"4.60000","-74.08333","-500",
"3.41667","-76.50000","-500",
"6.21667","-75.60000","-500",
"-4.25000","15.25000","100",
"45.799999","15.966666","100",
"19.90000","-75.15000","-500",
"23.133333","-82.366669","-500",
"35.166668","33.366665","200",
"50.083332","14.433333","100",
"55.68333","12.55000","100",
"18.48333","-69.90000","-400",
"-0.21667","-78.53333","-500",
"29.86667","31.33333","200",
"13.700000","-89.199997","-600",
"59.416668","24.750000","200",
"9.022736","038.7000","300",
"15.28333","38.91667","300",
"-51.700001","-57.849998","-300",
"-54.266666","-36.533333","-200",
"60.166668","24.966667","200",
"45.70000","4.78333","200",
"43.30000","5.38333","100",
"47.25000","-1.56667","100",
"43.70000","7.26667","100",
"48.866665","2.333333","100",
"48.58333","7.76667","100",
"4.93333","-52.45000","-300",
"41.716667","44.816666","400",
"52.500000","13.366667","100",
"50.116667","8.683333","100",
"53.55000","9.96667","100",
"52.40000","9.66667","100",
"51.333333","12.383333","100",
"49.56667","8.46667","100",
"48.15000","11.56667","100",
"5.555717","-000.2000","100",
"37.96667","23.71667","200",
"40.61667","22.95000","200",
"6.83333","-58.20000","200",
"18.55000","-72.33333","-500",
"14.100000","-87.216667","-600",
"22.30000","114.16667","800",
"47.500000","19.083334","100",
"64.150002","-21.850000","100",
"23.03333","72.58333","550",
"12.95000","77.61667","550",
"18.90000","72.81667","550",
"22.533333","88.366669","550",
"28.58333","77.20000","550",
"-6.18333","106.83333","700",
"-10.16667","123.56667","800",
"3.58333","98.68333","700",
"-3.00000","104.76667","700",
"35.666668","51.433334","350",
"33.33333","44.40000","300",
"36.31667","43.15000","300",
"53.333332","-6.250000","0",
"31.78333","35.21667","200",
"32.10000","34.78333","200",
"45.45000","9.28333","100",
"40.88333","14.30000","100",
"41.900002","12.483334","100",
"5.336318","-004.0167","0",
"43.06667","141.35000","900",
"35.68333","139.76667","900",
"31.950001","35.933334","200",
"43.23333","76.88333","600",
"-1.283333","36.816666","300",
"37.549999","126.966667","900",
"29.333334","47.983334","300",
"17.966667","102.599998","700",
"56.950001","24.100000","200",
"33.90000","35.46667","200",
"6.30000","-10.80000","0",
"32.900002","13.183333","200",
"49.599998","6.150000","100",
"41.983334","21.433332","100",
"-18.916666","47.516666","300",
"3.11667","101.70000","800",
"5.41667","100.31667","800",
"35.900002","14.516666","100",
"18.100000","-15.950000","0",
"17.0000","-100.0000","-600",
"19.40000","-99.20000","-600",
"25.66667","-100.30000","-600",
"43.700001","7.383333","100",
"47.916668","106.883331","800",
"33.58333","-7.65000","0",
"16.783333","96.166664","650",
"-15.916667","-5.700000","0",
"-22.566668","17.100000","200",
"27.716667","85.316666","575",
"52.38333","4.91667","100",
"25.08333","-77.35000","-500",
"-36.85000","174.76667","1200",
"-43.53333","172.61667","1200",
"-41.28333","174.76667","1200",
"6.45000","3.40000","100",
"13.516666","2.116667","100",
"70.983330","-8.083333","-100",
"39.016666","125.750000","900",
"60.40000","5.31667","100",
"59.916668","10.750000","100",
"23.600000","58.583332","400",
"-18.133333","178.416672","1300",
"33.58333","130.45000","900",
"-0.900000","-89.599998","-600",
"-9.533334","160.199997","1100",
"13.466666","144.750000","1000",
"-0.516667","166.916672","1200",
"-19.016666","169.916672","-1100",
"-29.049999","167.966660","1150",
"-14.266666","-170.699997","-1100",
"7.333333","134.483337","900",
"-9.500000","147.166672","1000",
"15.200000","145.750000","1000",
"24.866667","67.050003","500",
"31.58333","74.33333","500",
"34.01667","71.58333","500",
"8.966666","-79.533333","-500",
"-9.48333","147.15000","1000",
"-25.28333","-57.50000","-400",
"-12.08333","-77.0500","-500",
"18.48333","-66.11667","-400",
"14.583333","121.000000","800",
"50.06667","19.95000","100",
"52.250000","21.000000","100",
"38.716667","-9.133333","0",
"25.283333","51.533333","300",
"44.433334","26.100000","200",
"54.71667","20.50000","200",
"56.01667","92.95000","700",
"55.76667","37.66667","300",
"47.21667","39.71667","300",
"43.11667","131.91667","1000",
"48.70000","44.51667","300",
"43.916668","12.466666","100",
"-0.333333","6.733333","0",
"26.28333","50.15000","300",
"24.633333","46.716667","300",
"14.70000","-17.48333","0",
"44.833332","20.500000","100",
"1.283333","103.849998","800",
"48.150002","17.116667","100",
"46.049999","14.516666","100",
"2.03333","49.31667","300",
"-33.93333","18.48333","200",
"-26.250000","28.000000","200",
"-25.75000","28.23333","200",
"12.750000","45.200001","300",
"41.40000","2.15000","100",
"40.400002","-3.683333","100",
"39.46667","-0.38333","100",
"6.933333","79.849998","600",
"15.61667","32.55000","300",
"5.833333","-55.166668","-300",
"59.333332","18.049999","100",
"47.383335","8.533334","100",
"33.500000","36.299999","200",
"25.049999","121.500000","800",
"38.583332","68.800003","500",
"-6.83333","39.30000","300",
"13.7333","100.5000","700",
"-21.166666","175.166672","1400",
"10.66667","-61.5166","-400",
"36.799999","10.183333","100",
"39.95000","32.88333","200",
"41.016666","28.966667","200",
"38.43333","27.16667","200",
"37.950001","58.383335","500",
"25.299999","55.299999","400",
"50.45000","30.50000","200",
"46.48333","30.73333","200",
"54.60000","-5.91667","0",
"52.48333","-1.93333","0",
"51.46667","-3.16667","0",
"55.91667","-3.18333","0",
"36.133335","-5.350000","100",
"55.86667","-4.28333","0",
"51.500000","-0.126111","0",
"-34.85000","-56.21667","-300",
"18.350000","-64.933334","-400",
"42.75000","-73.80000","-500",
"35.05000","-106.61667","-500",
"33.65000","-84.43333","-500",
"39.38333","-74.43333","-500",
"39.18333","-76.66667","-500",
"42.36667","-71.03333","-500",
"42.93333","-78.73333","-500",
"41.88333","-87.63333","-600",
"33.95000","-81.11667","-500",
"32.85000","-96.85000","-600",
"39.75000","-104.86667","-700",
"42.41667","-83.01667","-500",
"21.33333","-157.91667","-1000",
"29.96667","-95.35000","-600",
"39.73333","-86.28333","-500",
"36.08333","-115.16667","-800",
"34.73333","-92.23333","-600",
"33.93333","-118.40000","-800",
"35.05000","-90.00000","-600",
"25.80000","-80.26667","-500",
"42.95000","-87.90000","-600",
"44.88333","-93.21667","-500",
"36.11667","-86.68333","-600",
"29.98333","-90.25000","-600",
"40.78333","-73.96667","-500",
"35.40000","-97.60000","-600",
"28.55000","-81.38333","-500",
"39.88333","-75.25000","-500",
"33.43333","-112.01667","-700",
"40.45000","-80.00000","-500",
"45.60000","-122.60000","-800",
"39.50000","-119.78333","-800",
"40.76667","-111.96667","-700",
"32.73333","-117.16667","-800",
"37.61667","-122.38333","-800",
"35.61667","-106.08333","-800",
"47.65000","-122.30000","-800",
"27.96667","-82.53333","-500",
"36.20000","-95.90000","-600",
"38.85000","-77.03333","-500",
"41.333332","69.300003","500",
"10.50000","-66.93333","-450",
"10.65000","-71.60000","-450",
"21.03333","105.86667","700",
"10.750000","106.666664","700",
"-17.833334","31.049999","200"@;

lsver{
	v=lscriptVersion();
	
	return v[2]*100+v[3]*10+v[4];
}
lscomringactive{
	return lsver()>270;
}
create
{
	// one-time initialization takes place here
	guisetup_flag=0;
	
	if (lscomringactive()){
		comringattach(KRAY_COMRING,"process_comring_message");
		send_comring_message(1,2,v_onFlag);
	}
}

destroy
{
	// take care of final clean-up activities here
	
    if (lscomringactive()){
		send_comring_message(1,2,0);
		comringdetach(KRAY_COMRING);
	}
}

flags
{
	// indicates the type of the Master script.  it can
	// be either SCENE or LAYOUT.  SCENE scripts will be
	// removed whenever the current scene is cleared or
	// replaced.  LAYOUT scripts persist until manually
	// removed.

	return(SCENE);
}

process: event, command
{
	// called for each event that occurs within the filter
	// you specified in flags()
	
	if (!modal && reqisopen()){
		get_values();
	}
}

load: what,io
{
    if(what == SCENEMODE){
        load_settings_general(io);
    	send_comring_message(1,2,v_onFlag);
    }
}

save: what,io
{
    if(what == SCENEMODE)
    {
        save_general(io);
		save_krayscript(io);
    }
}


read_line: io{
	line=string(io.read());

	if (size(line)>0){  // strip strange ascii chars
		if (strright(line,1)<" "){
			line=strleft(line,len+(-1));
		}
	}
	return line;
}
read_int: io{
	return int(read_line(io));
}

setsafevalue:ctrl,value{
	if (guisetup_flag){
		setvalue(ctrl,value);
	}
}
	
// Utilities
file_exists : file{
	f=File(file,"r");

	res=0;
	
	if (f){
		res=1;
		f.close();
	}
	
	return res;
}
find_image : file{

	plugs=getdir("Plugins");

	running_script = split(SCRIPTID);

	if(running_script[1] != nil ){
		running_script_path = (running_script[1]) + (running_script[2]);
	}else{
		running_script_path = running_script[2];
	}
	if (!plugs){
		plugs=running_script_path;
	}

	if (file_exists(plugs+"/"+file)){
		return plugs+"/"+file;
	}else if (file_exists(plugs+"/lscripts/"+file)){
		return plugs+"/lscripts/"+file;
	}else if (file_exists(plugs+"/lscripts/kray/"+file)){
		return plugs+"/lscripts/kray/"+file;
	}else if (file_exists(running_script_path+"/"+file)){
		return running_script_path+"/"+file;
	}else{
		return 0;
	}
	return file;
}
is_1:value{
    return (value==1);
}
options
{
	if (reqisopen()){  // check if requester is already open then close it
		reqabort();
	}


	// User Interface Layout Variables

	gad_x				= 0;								// Gadget X coord
	gad_y				= 24;								// Gadget Y coord
	gad_w				= 200;								// Gadget width
	gad_h				= 19;								// Gadget height
	gad_text_offset		= 95;								// Gadget text offset
	slider_w			= 22;								// Gadget slider width
	gad_prev_w			= 0;								// Previous gadget width temp variable

	ui_window_w			= 440;								// Window width
	ui_window_h			= 460 + modal * 40;					// Window height
	ui_banner_height	= 53;								// Height of banner graphic
	ui_spacing			= 3;								// Spacing gap size
	spacer_w			= 21;								// Horizontal spacing

	ui_offset_x 		= 0;								// Main X offset from 0
	ui_offset_y 		= ui_banner_height+(ui_spacing*2);	// Main Y offset from 0
	ui_row				= 0;								// Row number
	ui_column			= 0;								// Column number
	ui_tab_offset		= ui_offset_y + 23;					// Offset for tab height
	ui_seperator_w		= ui_window_w + 2;					// Width of seperators
	ui_row_offset		= gad_h + ui_spacing;				// Row offset

	ui_tab_bottom		= ui_offset_y + ui_row_offset + ui_spacing + gad_h; // The bottom of the tab gadgets

	// ctlposition(controlId, X, Y, [W], [H], [Text_Offset])
	
	// Check if compiled	
	cname=SCRIPTID;
	cname=strsub(cname,size(cname),1);
	compiled=1;
	if (cname=="s" || cname=="S"){
		compiled=0;
	}

	cmp="LS";
	if (compiled){
		cmp="LSC";
	}
	
	reqbegin("Kray Physical Sky (Build " + version + " " + cmp + ")");
	reqsize(ui_window_w, ui_window_h + 200);

	// Banner Graphic

	if (compiled){
		c_banner=ctlimage("kray_physical_sky_banner.tga");
		ctlposition(c_banner,0,0);
	}else{
		f_banner=find_image("kray_physical_sky_banner.tga");
		if (f_banner){
			c_banner=ctlimage(f_banner);
			ctlposition(c_banner,0,0);
		}
	}

	// Turn off plugin
	
	c_onFlag = ctlcheckbox("Enable Plugin",v_onFlag);
	ctlposition(c_onFlag, gad_x - 49, ui_offset_y, 210, gad_h, gad_text_offset);
	ctlrefresh(c_onFlag,"toggle_kray_physky");
	
	// Location preset popup menu
	c_city_preset=ctlpopup("Location Preset", v_city_preset, city_presets_list);
	ctlposition(c_city_preset, gad_x + 196, ui_offset_y, 210, gad_h, gad_text_offset);
	ctlrefresh(c_city_preset,"city_presets_refresh");

	ui_offset_y += ui_row_offset + 3;

	if (compiled){
		c_map=ctlimage("kray_physical_sky_map.tga");
		ctlposition(c_map,frame_x,ui_offset_y);
	}else{
		f_map=find_image("kray_physical_sky_map.tga");
		if (f_map){
			c_map=ctlimage(f_map);	
		}
		ctlposition(c_map,frame_x,ui_offset_y);
	}
	map_image = Glyph(MapGlyph);

	ui_offset_y += 180 - ui_row_offset + 3;

	ui_offset_y += ui_row_offset + 4;
	c_sep = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

	// c_hour = ctlinteger("Hour",v_hour);
	c_hour = ctlminislider("Hour", v_hour, 0, 24);
	ctlposition(c_hour, gad_x, ui_offset_y, gad_w - slider_w, gad_h, gad_text_offset);

	c_time_now = ctlbutton("Get Current Time",1,"get_time");
	ctlposition(c_time_now, gad_x + gad_w + 117, ui_offset_y, gad_w - gad_text_offset, gad_h);

	ui_offset_y += ui_row_offset;

	// c_minute = ctlinteger("Minute",v_minute);
	c_minute = ctlminislider("Minute", v_minute, 0, 60);
	ctlposition(c_minute, gad_x, ui_offset_y, gad_w - slider_w, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	// c_second = ctlinteger("Seconds",v_second);
	c_second = ctlminislider("Seconds", v_second, 0, 60);
	ctlposition(c_second, gad_x, ui_offset_y, gad_w - slider_w, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset + 4;
	c_sep1 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep1, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

	// c_day = ctlinteger("Day",v_day);
	c_day = ctlminislider("Day", v_day, 1, 31);
	ctlposition(c_day, gad_x, ui_offset_y, gad_w - slider_w, gad_h, gad_text_offset);

	c_date_now = ctlbutton("Get Current Date",1,"get_date");
	ctlposition(c_date_now, gad_x + gad_w + 117, ui_offset_y, gad_w - gad_text_offset, gad_h);

	ui_offset_y += ui_row_offset;

	c_month=ctlpopup("Month", v_month, months_list);
	ctlposition(c_month, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	c_year = ctlinteger("Year",v_year);
	ctlposition(c_year, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset + 4;
	c_sep2 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep2, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

	c_longitude = ctlnumber("Longitude (E)",v_longitude);
	ctlposition(c_longitude, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
	ctlrefresh(c_longitude,"longituderefresh");

	c_north = ctlangle("North Offset",v_north);
	ctlposition(c_north, gad_x + gad_w + ui_spacing + spacer_w, ui_offset_y, gad_w - slider_w, gad_h, 93);

	ui_offset_y += ui_row_offset;

	c_lattitude = ctlnumber("Lattitude (N)",v_lattitude);
	ctlposition(c_lattitude, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
	ctlrefresh(c_lattitude,"lattituderefresh");
	
	c_time_zone = ctlinteger("Time Zone",v_time_zone);
	//c_time_zone = ctlminislider("Time Zone", v_time_zone, -12, 12);
	ctlposition(c_time_zone, gad_x + gad_w + ui_spacing + spacer_w, ui_offset_y, gad_w, gad_h, 93);

	ui_offset_y += ui_row_offset + 4;
	c_sep3 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep3, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

	c_turbidity = ctlnumber("Turbidity",v_turbidity);
	ctlposition(c_turbidity, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);

	c_exposure = ctlnumber("Exposure",v_exposure);
	ctlposition(c_exposure, gad_x + gad_w + ui_spacing + spacer_w, ui_offset_y, gad_w, gad_h, 93);

	ui_offset_y += ui_row_offset + 4;
	c_sep4 = ctlsep(0, ui_seperator_w + 4);
	ctlposition(c_sep4, -2, ui_offset_y);
	ui_offset_y += ui_spacing + 5;

	c_volumetric = ctlpopup("Volumetrics:",v_volumetric,@"Off","Affect Only Background","Affect Shadows","Affect All"@);
	ctlposition(c_volumetric, gad_x, ui_offset_y, ui_window_w - 16, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	c_ignore = ctllightitems("Ignore Light",v_ignore);
	ctlposition(c_ignore, gad_x, ui_offset_y, ui_window_w - 16, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	c_skyON = ctlcheckbox("Ignore LightWave Backdrop",skyON);
	ctlposition(c_skyON, gad_x, ui_offset_y, ui_window_w - 16, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;

	c_sunON = ctlcheckbox("Use Physical Sun",sunON);
	ctlposition(c_sunON, gad_x, ui_offset_y, ui_window_w - 16, gad_h, gad_text_offset);

	ui_offset_y += ui_row_offset;
	
	c_SunIntensity = ctlnumber("Sun Intensity",v_SunIntensity);
	ctlposition(c_SunIntensity, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
	
	c_SunShadow = ctlnumber("Sun Softness",v_SunShadow);
	ctlposition(c_SunShadow, gad_x + gad_w + ui_spacing + spacer_w, ui_offset_y, gad_w, gad_h, 93);
	
	ui_offset_y += ui_row_offset;
	
	c_SunPower = ctlnumber("Sun Power Mult.",v_sunpower);
	ctlposition(c_SunPower, gad_x, ui_offset_y, gad_w, gad_h, gad_text_offset);
	
	ctlactive(c_onFlag,"is_1",
	c_city_preset,c_hour,c_time_now,c_minute,c_second,c_day,c_date_now,c_month,
	c_year,c_longitude,c_north,c_lattitude,c_time_zone,c_turbidity,c_exposure,c_ignore,
	c_volumetric,c_skyON,c_sunON,c_SunIntensity,c_SunShadow,c_SunPower);
		

	// Update to show crosshairs
	reqredraw("move_map_crosshair");


	guisetup_flag=1;

	if (modal){
		return if !reqpost();
		get_values();
		reqend();
	}else{
		reqopen();
	}
}


save_general: io
{
		io.writeln(version);    // version number

		if (!create_flag){	// not inited, do not save settings
			io.writeln(int,117);
			io.writeln(v_north);
			io.writeln(int,v_second);
			io.writeln(int,v_minute);
			io.writeln(int,v_hour);
			io.writeln(int,v_day);
			io.writeln(int,v_month);
			io.writeln(int,v_year);
			io.writeln(v_lattitude);
			io.writeln(v_longitude);
			io.writeln(v_time_zone);
			io.writeln(v_turbidity);
			io.writeln(v_exposure);
			
			if (v_ignore != nil){
				io.writeln(v_ignore.id);
			}else{
				io.writeln(0);
			}

			io.writeln(v_volumetric);
			io.writeln(skyON);
			io.writeln(sunON);
			io.writeln(int,v_city_preset);
			
			io.writeln(int,201);
			io.writeln(bool,v_onFlag);
			
			io.writeln(int,302);	
			io.writeln(v_SunIntensity);
			io.writeln(v_SunShadow);
			
			io.writeln(int,402);
			io.writeln(sunarea_min);
			io.writeln(sunarea_max);
			
			io.writeln(int,501);
			io.writeln(v_sunpower);
		}
		
		io.writeln(int,0);  // end hunk
}

get_values {
	v_onFlag=getvalue(c_onFlag);
	v_north=getvalue(c_north);
	v_second=getvalue(c_second);
	v_minute=getvalue(c_minute);
	v_hour=getvalue(c_hour);
	v_day=getvalue(c_day);
	v_month=getvalue(c_month);
	v_year=getvalue(c_year);
	v_lattitude=getvalue(c_lattitude);
	v_longitude=getvalue(c_longitude);
	v_time_zone=getvalue(c_time_zone);
	v_turbidity=getvalue(c_turbidity);
	v_exposure=getvalue(c_exposure);
	v_ignore=getvalue(c_ignore);
	v_volumetric=getvalue(c_volumetric);
	skyON=getvalue(c_skyON);
	sunON=getvalue(c_sunON);
	v_city_preset=getvalue(c_city_preset);
	v_SunIntensity=getvalue(c_SunIntensity);
	v_SunShadow=getvalue(c_SunShadow);
	v_sunpower=getvalue(c_SunPower);
}

load_settings_general: io{
	loaded_version=io.read().asNum();

	v_onFlag=1;

	if (loaded_version>0){
		if (loaded_version>version && runningUnder() != SCREAMERNET){
			warn("Scene was saved with newer version of Physky plugin.<br>Some features may not be available and could be lost if you save the scene.");
		}
		hunk=100;
		while(hunk>=100){
			hunk=read_int(io);
			switch(hunk){
				case 0:
				break;
				case 117:
					v_north=io.read().asNum();
					v_second=io.read().asNum();
					v_minute=io.read().asNum();
					v_hour=io.read().asNum();
					v_day=io.read().asNum();
					v_month=io.read().asNum();
					v_year=io.read().asNum();
					v_lattitude=io.read().asNum();
					v_longitude=io.read().asNum();
					v_time_zone=io.read().asNum();
					v_turbidity=io.read().asNum();
					v_exposure=io.read().asNum();
					ignoreID = integer(io.read());
					if(ignoreID != 0){
						v_ignore=Light(ignoreID);  
					}
					v_volumetric=io.read().asNum();
					skyON=io.read().asNum();
					sunON=io.read().asNum();
					v_city_preset=read_int(io);
				break;
				case 201:
					v_onFlag=read_int(io);
				break;
				case 302:
					v_SunIntensity=io.read().asNum();
					v_SunShadow=io.read().asNum();
				break;
				case 402:
					sunarea_min=io.read().asNum();
					sunarea_max=io.read().asNum();
				break;	
				case 501:
					v_sunpower=io.read().asNum();
				break;
				default:
					// if (runningUnder() != SCREAMERNET){
						// warn("General info hunk "+string(hunk)+" unrecognized.");
					// }
					hunk_len=hunk%100;
					for (skip=0 ; skip<hunk_len ; skip++){
						s=read_line(io);
					}
				break;
			}
		}
		
	}else{
		v_north=read_int(io);
		v_second=io.read().asNum();
		v_minute=io.read().asNum();
		v_hour=io.read().asNum();
		v_day=io.read().asNum();
		v_month=io.read().asNum();
		v_year=io.read().asNum();
        v_lattitude=read_int(io);
        v_longitude=read_int(io);
        v_time_zone=read_int(io);
        v_turbidity=read_int(io);
        v_exposure=read_int(io);
		ignoreID = integer(io.read());
        if(ignoreID != nil){
            v_ignore=Light(ignoreID);  
		}
		v_volumetric=io.read().asNum();
		skyON=io.read().asNum();
		sunON=1;
		v_city_preset=1;
		v_SunIntensity=1;
		v_SunShadow=1;
		v_sunpower=1;
	}
}



save_krayscript:krayfile{
	if (v_onFlag){
		// and script for Kray
		// will be executed after header commands (-1000) and scene load (0), but before tailer commands (1000)

		krayfile.writeln("KrayScriptLWSInlined 100;");
		krayfile.writeln("onevent framesetup;");
		krayfile.writeln("var time_of_day,"+v_hour+"+("+v_minute+"/60)+("+v_second+"/3600);");
		krayfile.writeln("var day_of_year,floor("+v_day+"+30.5*("+v_month+"-1));");
		krayfile.writeln("hpbaxes sky_axes,"+v_north+"+90,-180,0;");
		krayfile.writeln("physkysundir sun_direction,"+v_lattitude+","+v_longitude+",day_of_year,time_of_day,"+v_time_zone+";");
		// reverse west and east
		krayfile.writeln("axes rev_east_west_axes,(1,0,0),(0,1,0),(0,0,-1);");
		krayfile.writeln("vecaxismult sun_direction,rev_east_west_axes;");
		krayfile.writeln("vecaxisdiv sun_direction,sky_axes;");
		krayfile.writeln("physky mysky,sun_direction,"+v_turbidity+","+v_exposure+",sky_axes;");
		krayfile.writeln("physkyparam mysky,sunintensity,"+v_SunIntensity+";");
		krayfile.writeln("physkyparam mysky,sunspotangle,"+v_SunShadow+";");
		krayfile.writeln("echo '*** Kray physical sky applied ***';");
		
		if (skyON){
			krayfile.writeln("background physky,mysky;");
			krayfile.writeln("echo '*** Applying Physical Sky Backdrop ***';");		
		}
		switch(v_volumetric){
		case 1:
			krayfile.writeln("echo '*** No Volumetrics Applied ***';");
			break;
		case 2:
			krayfile.writeln("environment physky,mysky,8;");
			krayfile.writeln("echo '*** Applying Physical Sky Volumetrics to backdrop ***';");
			break;
		case 3:
			krayfile.writeln("environment physky,mysky,4;");
			krayfile.writeln("echo '*** Applying Physical Sky Volumetrics to shadows ***';");					
			break;					
		case 4:
			krayfile.writeln("environment physky,mysky,2;");
			krayfile.writeln("echo '*** Applying Physical Sky Volumetrics to FG ***';");					
			break;
		}
		krayfile.writeln("echo '*** Time: "+v_hour+" h "+v_minute+" min "+v_second+" sec, Month: "+v_month+" Day: "+v_day+" Year: "+v_year+" Timezone: "+v_time_zone+" ***';");
		krayfile.writeln("echo '*** Lattitude: "+v_lattitude+" Longitude: "+v_longitude+" North direction: "+v_north+" ***';");
		krayfile.writeln("echo '*** Turbidity: "+v_turbidity+" Exposure: "+v_exposure+" ***';");

		lcmd="light ";
		lightname="mysun";
		if(v_ignore){
			krayfile.writeln("ignorelwitemid "+hex(v_ignore.id)+";");
			krayfile.writeln("echo '*** Ignoring Light: "+hex(v_ignore.id)+" ***';");

			SelectedLight = hex(v_ignore.id);
			lcmd="replacelwlight "+SelectedLight+",";

			SelectedLight=string(SelectedLight);			
			SelectedLight=strright(SelectedLight,8);
			lightname="LW"+SelectedLight;
		}else{
			lcmd="lightname "+lightname+",";
		}
		if (sunON){
			krayfile.writeln(lcmd+"physky,mysky,adaptive,10000000,0.002,"+sunarea_min+","+sunarea_max+";");
			krayfile.writeln("lightphotonmultiplier "+lightname+",1,"+v_sunpower+";");
		}
		krayfile.writeln("end;");
		// end of our script
		krayfile.writeln("end;");
	}
}

// Callback functions ...


get_time
{
	// Grab current time array
	sys_time = time();

	// Set the hour
	setvalue(c_hour,sys_time[1]);

	// Set the minutes
	setvalue(c_minute,sys_time[2]);

	// Set the seconds
	setvalue(c_second,sys_time[3]);
}

get_date
{
	// Grab current date array
	sys_date = date();

	// Set the day
	setvalue(c_day, sys_date[1]);

	// Set the month
	setvalue(c_month, sys_date[2]);

	// Set the year
	setvalue(c_year, sys_date[3]);
}


city_presets_refresh : value
{
	if (value > 1) {
		value = (value - 1) * 3 - 2;

		// Set the Longitude
		setvalue(c_lattitude, city_coords_list[value]);

		// Set the Latitude
		setvalue(c_longitude, city_coords_list[value + 1]);
		
		// Set the Time zone
		tz = city_coords_list[value + 2];
		tz = int(tz) * 0.01;
		setvalue(c_time_zone, tz);
		
		move_map_crosshair();
	}
}

longituderefresh : value{

	if (value<-180) setvalue(c_longitude,360+value);
	if (value>180) setvalue(c_longitude,-360+value);

	move_map_crosshair();
	timezone_refresh();
}

lattituderefresh : value{

	if (value<-90) setvalue(c_lattitude,180+value);
	if (value>90) setvalue(c_lattitude,-180+value);

	move_map_crosshair();
}

timezone_refresh {

	tz = getvalue(c_longitude)/15;
	setvalue(c_time_zone, tz);
}

// mouse moves

reqmousemove: md {

	mouse_x = md.x;
	mouse_y = md.y;

	// Is LMB down and within map image?
	if(mouse_x >= frame_x && mouse_x <= frame_max_x && mouse_y >= frame_y && mouse_y <= frame_max_y)
	{
		lg = -180 + (mouse_x - frame_x);
		lt = (-90 + (mouse_y - frame_y)) * -1;

		setvalue(c_longitude, lg);
		setvalue(c_lattitude, lt);
		setvalue(c_city_preset,1);
	}
}

reqmousedown: md {
	mouse_x = md.x;
	mouse_y = md.y;

	// Is LMB down and within map image?
	if(mouse_x >= frame_x && mouse_x <= frame_max_x && mouse_y >= frame_y && mouse_y <= frame_max_y)
	{
		lg = -180 + (mouse_x - frame_x);
		lt = (-90 + (mouse_y - frame_y)) * -1;

		setvalue(c_longitude, lg);
		setvalue(c_lattitude, lt);
		setvalue(c_city_preset,1);
	}
}

move_map_crosshair {
	if (map_image){
		mouse_x = getvalue(c_longitude) + 180 + frame_x;
		mouse_y = ((getvalue(c_lattitude))/-1) + 90 + frame_y;

		// Remove drawing bug where crosshair lines go over the specified area (far right and bottom edges)  Don't know why!
		drawerase(frame_x, frame_max_y, frame_w, 2);
		drawerase(frame_max_x, frame_y, 2, frame_h);
		drawglyph(map_image,frame_x,frame_y);

		// Vertical crosshair
		drawline(<255,000,000>, mouse_x, frame_y + 1, mouse_x, frame_max_y - 2);

		// Horizontal crosshair
		drawline(<255,000,000>, frame_x + 1, mouse_y, frame_max_x - 2, mouse_y);
	}
}

toggle_kray_physky: value
{
    send_comring_message(1,2,value);
}

send_comring_message: dest, from, value
{
	if (lscomringactive()){
		comringdata_out = comringencode(@"i","i","i"@,dest,from,value);
		comringmsg(KRAY_COMRING, 1, comringdata_out);
	}
}

// Process events coming IN from the Kray Comring
process_comring_message: eventCode, dataPointer
{
	if(eventCode == 1)
	{
		(dest,from,state) = comringdecode(@"i","i","i"@, dataPointer);

		// Message from PhySky Plugin
		if(dest == 2 && from == 1)
		{
	        if(reqisopen())
	        {
	            setvalue(c_onFlag, state);
	            v_onFlag = state;
	        }else
	        {
	            v_onFlag = state;
	        }
		}

	}
	if(eventCode == 2)
	{
		(dest,from,v_planrmin,v_planrmax) = comringdecode(@"i","i","i","i"@, dataPointer);
		// Message from PhySky Plugin
		if(dest == 2 && from == 1)
		{
			sunarea_min = v_planrmin;
			sunarea_max = v_planrmax;
		}
	}

}

@data MapGlyph 194500
000 000 002 000 000 000 000 000 000 000 000 000 104 001 180 000 024 000 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 177 124 098 170 115 089 174 120 094 170 115 089 170 115 089 170 115 089 170
115 089 169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 169 113 087 170 115
089 170 115 089 174 119 093 174 119 093 174 119 093 170 115 089 170 115 089 170
115 089 169 113 087 168 112 085 170 115 089 174 119 093 170 115 089 174 120 094
174 120 094 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 170 115 089
169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 174 120 094 174 119
093 174 119 093 174 119 093 174 120 094 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 174 119 093 174 119 093 174 119 093 174 119 093 173 118 092
173 118 092 170 115 089 170 115 089 173 118 092 174 119 093 174 119 093 174 119
093 174 119 093 174 119 093 174 120 094 174 120 094 174 120 094 174 120 094 174
120 094 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093
174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119
093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174
119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 120 094
174 120 094 174 120 094 174 120 094 174 120 094 174 119 093 174 119 093 174 119
093 174 119 093 174 120 094 174 120 094 174 120 094 174 120 094 174 120 094 174
120 094 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093
174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119
093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 174 119 093 173
118 092 170 115 089 170 115 089 170 115 089 173 118 092 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 174 119 093 173 118 092
173 118 092 173 118 092 174 119 093 173 118 092 173 118 092 173 118 092 173 118
092 173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 173 118 092 170 115 089 170 115 089 170 115 089 173 118 092 173 118 092 173
118 092 173 118 092 173 118 092 173 118 092 173 118 092 173 118 092 173 118 092
173 118 092 173 118 092 173 118 092 174 119 093 173 118 092 173 118 092 173 118
092 173 118 092 173 118 092 173 118 092 173 118 092 173 118 092 173 118 092 173
118 092 173 118 092 174 119 093 173 118 092 170 115 089 170 115 089 170 115 089
170 115 089 173 118 092 174 120 094 170 115 089 174 120 094 080 048 033 080 048
033 176 122 097 166 110 083 168 112 085 170 115 089 170 115 089 170 115 089 166
110 083 174 120 094 174 120 094 179 127 101 177 124 098 179 127 101 179 127 102
183 132 106 187 137 112 183 132 106 179 127 101 183 131 106 179 127 101 173 118
092 174 119 093 174 120 094 170 115 089 170 115 089 170 115 089 169 113 087 170
115 089 174 120 094 177 124 098 174 119 093 169 113 087 174 120 094 173 118 092
170 115 089 173 118 092 173 118 092 170 115 089 173 118 092 173 118 092 170 115
089 174 120 094 174 119 093 174 120 094 174 120 094 174 120 094 170 115 089 170
115 089 170 115 089 174 120 094 176 122 097 183 131 106 183 132 106 179 127 101
179 127 101 179 127 101 176 122 097 174 120 094 173 118 092 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087
170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 170 115 089 170 115
089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 174 119 093 174
120 094 177 124 098 174 119 093 173 118 092 174 119 093 174 120 094 174 119 093
174 119 093 170 115 089 170 115 089 173 118 092 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 169 113 087
169 113 087 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 169 113 087 168 112 085 169 113 087 170 115 089 168 112 085
169 113 087 169 113 087 170 115 089 170 115 089 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083 166
110 083 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110
083 166 110 083 166 109 082 166 109 082 166 109 082 166 109 082 166 109 082 166
110 083 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166
110 083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085
168 112 085 166 110 083 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087
169 113 087 170 115 089 168 112 085 168 112 085 170 115 089 169 113 087 168 112
085 170 115 089 170 115 089 169 113 087 169 113 087 170 115 089 169 113 087 170
115 089 168 112 085 169 113 087 166 109 082 168 112 085 168 112 085 169 113 087
168 112 085 169 113 087 170 115 089 170 115 089 170 115 089 080 048 033 080 048
033 185 135 110 177 124 098 170 115 089 168 112 085 174 120 094 177 124 098 170
115 089 170 115 089 168 112 085 162 107 079 157 102 076 151 098 074 152 100 074
148 096 071 134 086 064 148 096 071 162 107 079 151 098 074 153 100 074 174 120
094 146 095 071 130 083 061 129 083 061 134 086 064 144 093 069 168 112 085 174
120 094 166 110 083 168 112 085 169 113 087 152 100 074 162 107 079 144 093 069
135 086 064 148 096 071 165 108 081 169 113 087 170 115 089 165 108 081 161 106
079 161 106 079 157 102 076 162 107 079 152 100 074 144 093 069 144 093 069 152
100 074 166 109 082 168 112 085 153 100 074 138 089 065 146 095 071 153 100 074
148 096 071 151 098 074 155 101 076 162 107 079 166 109 082 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 170 115 089 169 113 087 168 112 085 168 112 085 168 112 085
170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 170 115
089 173 118 092 174 119 093 173 118 092 170 115 089 169 113 087 169 113 087 168
112 085 168 112 085 169 113 087 170 115 089 170 115 089 173 118 092 174 120 094
174 119 093 170 115 089 173 118 092 174 120 094 173 118 092 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 173 118 092 173 118 092 170 115 089 170 115 089 173 118 092
174 119 093 174 119 093 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 168 112 085 168 112 085 170 115 089 170 115 089 168
112 085 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089 168 112 085
169 113 087 169 113 087 169 113 087 170 115 089 169 113 087 169 113 087 169 113
087 169 113 087 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 166 110 083 168 112 085
168 112 085 168 112 085 168 112 085 166 109 082 166 110 083 166 110 083 166 110
083 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083 166 109 082 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 170 115 089 169 113 087 169 113 087 170 115 089 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 173 118 092 173 118 092 169 113 087 170 115 089 173 118 092 170 115
089 168 112 085 168 112 085 166 109 082 174 120 094 170 115 089 174 120 094 173
118 092 168 112 085 179 127 101 179 127 101 181 129 104 183 132 106 179 127 102
179 127 101 179 127 101 176 122 097 181 129 104 176 122 097 080 048 033 080 048
033 155 101 076 151 098 074 170 115 089 174 120 094 143 092 069 148 096 071 166
110 083 144 093 069 144 093 069 162 107 079 155 101 076 151 098 074 144 093 069
130 083 061 104 066 047 129 083 061 168 112 085 165 108 081 151 098 074 166 110
083 168 112 085 170 115 089 162 107 079 162 107 079 168 112 085 174 119 093 173
118 092 165 108 081 165 108 081 168 112 085 169 113 087 169 113 087 170 115 089
173 118 092 170 115 089 174 120 094 174 120 094 170 115 089 168 112 085 168 112
085 168 112 085 168 112 085 165 108 081 168 112 085 170 115 089 170 115 089 168
112 085 174 119 093 170 115 089 161 106 079 144 093 069 146 095 071 151 098 074
155 101 076 161 106 079 165 108 081 168 112 085 170 115 089 170 115 089 173 118
092 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 170 115 089 170 115 089 170 115 089 169 113 087 168 112 085
173 118 092 173 118 092 170 115 089 170 115 089 170 115 089 169 113 087 166 110
083 161 106 079 162 107 079 162 107 079 162 107 079 165 108 081 162 107 079 153
100 074 146 095 071 151 098 074 168 112 085 161 106 079 155 101 076 165 108 081
162 107 079 166 110 083 169 113 087 168 112 085 168 112 085 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
169 113 087 162 107 079 166 110 083 168 112 085 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089
170 115 089 170 115 089 169 113 087 168 112 085 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 169 113 087 169 113 087 169 113 087 168 112 085 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 109 082 166 110 083 166 110 083 166 110 083 166 110
083 166 110 083 166 110 083 166 110 083 166 110 083 166 109 082 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 166 110 083 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092
174 120 094 170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115
089 174 119 093 176 122 097 168 112 085 165 108 081 162 107 079 170 115 089 174
120 094 179 127 102 179 127 101 162 107 079 144 093 069 134 086 064 134 086 064
162 107 079 155 101 076 144 093 069 162 107 079 174 119 093 080 048 033 080 048
033 161 106 079 138 089 065 157 102 076 168 112 085 151 098 074 151 098 074 166
109 082 155 101 076 165 108 081 170 115 089 170 115 089 174 119 093 174 120 094
179 127 101 179 127 101 169 113 087 174 119 093 174 120 094 170 115 089 168 112
085 168 112 085 168 112 085 174 119 093 170 115 089 166 110 083 168 112 085 168
112 085 168 112 085 170 115 089 170 115 089 170 115 089 169 113 087 168 112 085
170 115 089 168 112 085 168 112 085 166 110 083 170 115 089 170 115 089 169 113
087 174 119 093 173 118 092 174 120 094 174 120 094 174 120 094 173 118 092 174
119 093 170 115 089 170 115 089 177 124 098 183 131 106 183 131 106 179 127 102
179 127 101 177 124 098 174 120 094 174 120 094 173 118 092 170 115 089 168 112
085 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112
085 166 110 083 166 110 083 168 112 085 170 115 089 174 119 093 176 122 097 170
115 089 168 112 085 166 110 083 174 120 094 168 112 085 162 107 079 165 108 081
162 107 079 166 109 082 168 112 085 168 112 085 166 110 083 166 110 083 166 110
083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 169 113 087 168 112 085 168 112 085 166 110 083 168 112 085
166 110 083 168 112 085 168 112 085 174 120 094 174 120 094 173 118 092 174 119
093 173 118 092 174 120 094 170 115 089 168 112 085 166 109 082 166 109 082 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170 115 089
170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168
112 085 169 113 087 169 113 087 169 113 087 168 112 085 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 168 112 085 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 109 082 166 110 083 166 110 083 166 110 083 166 110
083 166 110 083 166 110 083 166 110 083 166 110 083 166 109 082 169 113 087 168
112 085 168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 174 119 093 170 115 089 170 115 089 173 118
092 170 115 089 169 113 087 165 108 081 166 109 082 144 093 069 111 070 051 111
070 051 152 100 074 135 086 064 153 100 074 151 098 074 123 079 058 115 073 054
138 089 065 138 089 065 121 077 057 138 089 065 162 107 079 080 048 033 080 048
033 181 129 104 174 119 093 169 113 087 168 112 085 173 118 092 174 119 093 169
113 087 170 115 089 170 115 089 173 118 092 170 115 089 168 112 085 168 112 085
168 112 085 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 162 107
079 170 115 089 170 115 089 169 113 087 170 115 089 174 119 093 170 115 089 170
115 089 169 113 087 170 115 089 170 115 089 169 113 087 170 115 089 173 118 092
170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 166 110 083 166 109
082 166 109 082 166 109 082 166 109 082 168 112 085 169 113 087 170 115 089 170
115 089 169 113 087 168 112 085 170 115 089 169 113 087 166 109 082 166 110 083
170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 169 113 087 169 113
087 169 113 087 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 170 115 089 169 113 087 169 113 087 170 115 089 168 112 085
168 112 085 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 169 113
087 174 120 094 174 119 093 173 118 092 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 174 120 094 173 118 092 170 115 089 170 115 089 173 118 092
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169
113 087 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 166 110 083 166 110 083 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 169 113 087 170 115 089 173 118 092 170 115 089 170
115 089 161 106 079 153 100 074 153 100 074 166 109 082 174 120 094 170 115 089
168 112 085 169 113 087 174 120 094 176 122 097 170 115 089 169 113 087 170 115
089 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089 170 115 089 168
112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083
168 112 085 168 112 085 168 112 085 166 110 083 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 173 118 092 170 115 089 170 115 089 170 115
089 170 115 089 173 118 092 170 115 089 170 115 089 170 115 089 173 118 092 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 174 119 093 173 118 092 173 118 092 173 118
092 174 119 093 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
166 109 082 168 112 085 168 112 085 166 110 083 181 129 104 174 120 094 162 107
079 136 087 064 146 095 071 173 118 092 181 129 104 144 093 069 111 070 051 115
073 054 152 100 074 143 092 069 168 112 085 170 115 089 174 120 094 170 115 089
170 115 089 183 131 106 174 120 094 173 118 092 168 112 085 080 048 033 080 048
033 176 122 097 166 110 083 168 112 085 166 109 082 166 110 083 170 115 089 168
112 085 173 118 092 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087
169 113 087 168 112 085 170 115 089 168 112 085 162 107 079 166 110 083 170 115
089 168 112 085 168 112 085 166 109 082 162 107 079 166 109 082 155 101 076 155
101 076 168 112 085 166 109 082 166 109 082 162 107 079 165 108 081 165 108 081
166 110 083 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 173 118
092 170 115 089 170 115 089 170 115 089 168 112 085 166 109 082 168 112 085 168
112 085 168 112 085 166 110 083 168 112 085 170 115 089 168 112 085 170 115 089
168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 168 112 085 170 115 089 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 166 110 083
168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 165 108 081 166 110
083 166 110 083 162 107 079 162 107 079 170 115 089 168 112 085 166 110 083 168
112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 166 110 083
170 115 089 169 113 087 170 115 089 168 112 085 173 118 092 170 115 089 170 115
089 170 115 089 174 119 093 173 118 092 170 115 089 170 115 089 170 115 089 173
118 092 170 115 089 168 112 085 168 112 085 168 112 085 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 168 112 085 168 112 085 168 112 085 168 112
085 170 115 089 168 112 085 169 113 087 170 115 089 170 115 089 174 119 093 170
115 089 174 120 094 170 115 089 173 118 092 174 119 093 168 112 085 155 101 076
170 115 089 174 120 094 166 109 082 170 115 089 174 120 094 174 120 094 174 119
093 174 120 094 174 120 094 173 118 092 170 115 089 173 118 092 174 119 093 174
120 094 170 115 089 170 115 089 170 115 089 173 118 092 174 120 094 173 118 092
174 119 093 173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 169 113
087 170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 168
112 085 170 115 089 170 115 089 169 113 087 168 112 085 169 113 087 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 169 113 087 168 112 085 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 169 113 087 166 110 083 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 166 110 083
166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166
110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110
083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 166 109 082 166 109 082 166 109 082
166 109 082 166 109 082 168 112 085 168 112 085 168 112 085 168 112 085 166 110
083 169 113 087 168 112 085 168 112 085 168 112 085 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 173 118 092 174 120 094 170 115 089 169 113 087
173 118 092 166 109 082 136 087 064 152 100 074 152 100 074 138 089 065 144 093
069 125 079 058 126 080 059 143 092 069 148 096 071 151 098 074 168 112 085 174
120 094 174 120 094 177 124 098 168 112 085 165 108 081 169 113 087 170 115 089
170 115 089 165 108 081 168 112 085 170 115 089 170 115 089 080 048 033 080 048
033 174 120 094 161 106 079 168 112 085 165 108 081 166 110 083 166 110 083 166
110 083 166 109 082 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 166 110 083 166 109 082 165 108 081 169 113
087 166 110 083 166 110 083 174 120 094 168 112 085 166 110 083 166 109 082 166
109 082 170 115 089 166 109 082 170 115 089 173 118 092 173 118 092 168 112 085
168 112 085 170 115 089 169 113 087 169 113 087 170 115 089 170 115 089 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 162 107 079 162 107
079 166 109 082 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 168
112 085 169 113 087 166 110 083 168 112 085 168 112 085 168 112 085 166 110 083
170 115 089 169 113 087 169 113 087 169 113 087 170 115 089 166 110 083 168 112
085 166 109 082 166 110 083 166 110 083 165 108 081 166 109 082 166 110 083 166
110 083 162 107 079 166 109 082 169 113 087 168 112 085 168 112 085 166 109 082
170 115 089 168 112 085 170 115 089 162 107 079 166 109 082 168 112 085 168 112
085 168 112 085 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083 166 109 082
162 107 079 166 109 082 166 109 082 166 109 082 166 109 082 166 109 082 168 112
085 168 112 085 165 108 081 170 115 089 170 115 089 168 112 085 168 112 085 168
112 085 174 119 093 170 115 089 162 107 079 168 112 085 168 112 085 162 107 079
166 110 083 177 124 098 166 110 083 144 093 069 161 106 079 169 113 087 170 115
089 170 115 089 168 112 085 174 119 093 174 119 093 170 115 089 168 112 085 173
118 092 177 124 098 174 120 094 170 115 089 169 113 087 168 112 085 168 112 085
170 115 089 169 113 087 170 115 089 170 115 089 169 113 087 170 115 089 170 115
089 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 174 119 093 173 118 092 170 115 089 170 115 089 168 112 085 166 109 082
168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168 112 085 168 112
085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 166 110 083
166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166
109 082 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 110 083 169 113 087 168 112 085 168 112 085 168 112
085 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 109 082 166 109 082 166 109 082 166 109
082 166 109 082 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 166 110 083 166 110 083 166 110 083
166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 174 119 093 174 120 094 177 124 098
179 127 101 177 124 098 188 139 114 174 120 094 134 086 064 155 101 076 168 112
085 161 106 079 165 108 081 170 115 089 169 113 087 168 112 085 169 113 087 168
112 085 166 109 082 165 108 081 168 112 085 166 110 083 166 109 082 168 112 085
169 113 087 162 107 079 165 108 081 165 108 081 169 113 087 080 048 033 080 048
033 181 129 104 169 113 087 168 112 085 174 119 093 169 113 087 169 113 087 169
113 087 170 115 089 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085
166 110 083 166 109 082 166 110 083 168 112 085 170 115 089 166 110 083 146 095
071 162 107 079 162 107 079 170 115 089 170 115 089 170 115 089 174 120 094 168
112 085 173 118 092 170 115 089 166 110 083 173 118 092 173 118 092 168 112 085
169 113 087 170 115 089 170 115 089 170 115 089 168 112 085 169 113 087 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168
112 085 168 112 085 165 108 081 168 112 085 168 112 085 168 112 085 166 110 083
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 166 109 082 166 110 083 168 112 085 168 112 085 170
115 089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 168 112 085 169 113 087 166 110 083 168 112 085 168 112 085 168
112 085 166 110 083 162 107 079 166 109 082 170 115 089 170 115 089 174 119 093
176 122 097 174 120 094 162 107 079 153 100 074 166 110 083 173 118 092 166 110
083 166 109 082 161 106 079 162 107 079 168 112 085 168 112 085 168 112 085 168
112 085 166 109 082 168 112 085 169 113 087 170 115 089 170 115 089 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115
089 168 112 085 170 115 089 162 107 079 161 106 079 165 108 081 155 101 076 151
098 074 151 098 074 168 112 085 165 108 081 148 096 071 152 100 074 155 101 076
151 098 074 151 098 074 155 101 076 174 119 093 173 118 092 170 115 089 168 112
085 162 107 079 155 101 076 161 106 079 170 115 089 166 110 083 162 107 079 162
107 079 170 115 089 170 115 089 168 112 085 162 107 079 155 101 076 168 112 085
165 108 081 168 112 085 166 109 082 168 112 085 168 112 085 170 115 089 174 120
094 174 119 093 173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 166 109 082
166 109 082 166 109 082 166 109 082 166 109 082 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166
109 082 166 110 083 166 110 083 166 110 083 166 110 083 166 109 082 166 109 082
166 109 082 166 109 082 166 109 082 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 169 113 087
169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 166 109 082 166 110 083 166 110 083 166 110 083 166 109
082 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 166 110 083 169 113 087 168 112 085 168 112 085
168 112 085 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 162 107 079 155 101 076 148 096 071
144 093 069 129 083 061 115 073 054 146 095 071 144 093 069 126 080 059 140 090
067 179 127 102 183 131 106 173 118 092 170 115 089 166 110 083 170 115 089 166
110 083 162 107 079 165 108 081 166 110 083 162 107 079 162 107 079 162 107 079
165 108 081 174 119 093 174 120 094 173 118 092 173 118 092 080 048 033 080 048
033 168 112 085 155 101 076 155 101 076 165 108 081 151 098 074 151 098 074 151
098 074 151 098 074 151 098 074 152 100 074 152 100 074 152 100 074 151 098 074
153 100 074 155 101 076 155 101 076 162 107 079 162 107 079 168 112 085 170 115
089 168 112 085 170 115 089 168 112 085 166 109 082 162 107 079 166 109 082 161
106 079 152 100 074 162 107 079 161 106 079 153 100 074 155 101 076 157 102 076
162 107 079 161 106 079 165 108 081 162 107 079 166 109 082 168 112 085 169 113
087 169 113 087 169 113 087 169 113 087 168 112 085 162 107 079 166 110 083 169
113 087 169 113 087 168 112 085 168 112 085 168 112 085 169 113 087 170 115 089
168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112
085 168 112 085 166 110 083 166 110 083 168 112 085 170 115 089 170 115 089 170
115 089 173 118 092 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 174 119 093 166 109 082 166 110 083 162 107 079 153 100 074
136 087 064 123 079 058 157 102 076 174 120 094 166 109 082 168 112 085 168 112
085 169 113 087 173 118 092 170 115 089 166 110 083 168 112 085 168 112 085 168
112 085 168 112 085 166 110 083 162 107 079 162 107 079 166 110 083 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 170 115 089 169
113 087 162 107 079 169 113 087 177 124 098 183 131 106 184 134 109 190 140 115
174 120 094 153 100 074 162 107 079 174 120 094 176 122 097 170 115 089 162 107
079 166 109 082 168 112 085 157 102 076 165 108 081 168 112 085 165 108 081 162
107 079 155 101 076 166 109 082 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 168 112 085 168 112 085 166 110 083 166 110 083 162 107 079 162 107
079 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087
170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085 168 112
085 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168
112 085 166 109 082 166 110 083 166 110 083 166 109 082 169 113 087 169 113 087
169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169 113
087 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 166 109 082 166 109 082 166 109 082
166 109 082 166 109 082 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 168
112 085 168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110
083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 109 082 166
109 082 166 109 082 166 109 082 168 112 085 168 112 085 166 109 082 162 107 079
165 108 081 162 107 079 138 089 065 136 087 064 140 090 067 102 065 046 129 083
061 166 110 083 162 107 079 166 109 082 168 112 085 177 124 098 170 115 089 177
124 098 190 140 115 174 120 094 166 109 082 166 110 083 174 120 094 174 120 094
170 115 089 169 113 087 168 112 085 166 110 083 168 112 085 080 048 033 080 048
033 162 107 079 162 107 079 166 109 082 165 108 081 169 113 087 168 112 085 168
112 085 168 112 085 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 153 100 074 155 101 076 153 100 074 148 096 071 155 101 076 162 107
079 166 109 082 179 127 101 157 102 076 152 100 074 155 101 076 162 107 079 169
113 087 165 108 081 170 115 089 174 120 094 174 119 093 173 118 092 174 120 094
170 115 089 170 115 089 168 112 085 168 112 085 170 115 089 161 106 079 155 101
076 161 106 079 161 106 079 155 101 076 165 108 081 166 110 083 165 108 081 165
108 081 162 107 079 162 107 079 162 107 079 166 109 082 168 112 085 174 119 093
168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 166 110 083 166 110
083 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170
115 089 173 118 092 168 112 085 170 115 089 173 118 092 170 115 089 166 110 083
169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 173 118 092 170 115
089 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 173 118 092 170 115 089 174 120 094 173 118 092 135 086 064
082 050 035 126 080 059 162 107 079 174 120 094 161 106 079 146 095 071 157 102
076 162 107 079 168 112 085 166 109 082 157 102 076 166 109 082 166 110 083 166
109 082 168 112 085 170 115 089 166 110 083 165 108 081 162 107 079 166 109 082
166 109 082 166 109 082 166 110 083 166 109 082 166 110 083 166 110 083 162 107
079 162 107 079 166 109 082 168 112 085 169 113 087 170 115 089 174 119 093 179
127 101 185 135 110 168 112 085 138 089 065 155 101 076 152 100 074 136 087 064
157 102 076 155 101 076 157 102 076 151 098 074 134 086 064 143 092 069 153 100
074 157 102 076 162 107 079 162 107 079 148 096 071 157 102 076 170 115 089 166
109 082 153 100 074 153 100 074 152 100 074 153 100 074 155 101 076 153 100 074
157 102 076 166 110 083 169 113 087 169 113 087 162 107 079 166 109 082 166 110
083 165 108 081 166 109 082 166 109 082 166 109 082 166 109 082 166 109 082 168
112 085 168 112 085 170 115 089 169 113 087 174 119 093 170 115 089 169 113 087
170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085 168 112
085 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166
110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 109 082 166 109 082 166 109 082 166 109
082 165 108 081 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 169 113 087
169 113 087 169 113 087 169 113 087 170 115 089 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 169 113
087 166 109 082 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083 166
110 083 166 110 083 166 110 083 166 110 083 168 112 085 166 110 083 166 110 083
166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 166 109 082 166 110 083 166 110 083 166 109 082 168 112 085 169 113 087 168
112 085 168 112 085 169 113 087 169 113 087 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110
083 169 113 087 168 112 085 168 112 085 169 113 087 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087
170 115 089 166 110 083 174 119 093 162 107 079 146 095 071 166 110 083 129 083
061 091 056 039 111 070 051 111 070 051 115 073 054 125 079 058 134 086 064 125
079 058 125 079 058 143 092 069 166 110 083 152 100 074 143 092 069 144 093 069
151 098 074 144 093 069 144 093 069 143 092 069 155 101 076 080 048 033 080 048
033 198 151 127 199 152 129 200 154 131 198 151 127 199 152 129 199 152 129 199
152 129 199 152 129 199 152 129 198 151 127 198 151 127 198 151 127 199 152 129
198 151 127 200 154 131 198 151 127 193 144 120 185 135 110 192 143 119 183 131
106 146 095 071 146 095 071 166 110 083 162 107 079 134 086 064 140 090 067 153
100 074 148 096 071 138 089 065 153 100 074 166 110 083 168 112 085 168 112 085
170 115 089 170 115 089 169 113 087 168 112 085 166 110 083 174 119 093 170 115
089 165 108 081 168 112 085 170 115 089 168 112 085 162 107 079 161 106 079 165
108 081 168 112 085 166 110 083 166 110 083 166 110 083 155 101 076 146 095 071
155 101 076 166 109 082 157 102 076 162 107 079 157 102 076 165 108 081 170 115
089 166 110 083 162 107 079 170 115 089 170 115 089 166 110 083 166 110 083 168
112 085 166 109 082 181 129 104 170 115 089 155 101 076 170 115 089 183 131 106
170 115 089 174 119 093 174 119 093 168 112 085 162 107 079 170 115 089 169 113
087 169 113 087 170 115 089 173 118 092 168 112 085 168 112 085 169 113 087 168
112 085 168 112 085 168 112 085 170 115 089 174 120 094 179 127 102 169 113 087
155 101 076 174 119 093 161 106 079 152 100 074 161 106 079 157 102 076 155 101
076 157 102 076 151 098 074 166 110 083 174 120 094 162 107 079 162 107 079 162
107 079 165 108 081 162 107 079 174 120 094 179 127 101 174 120 094 170 115 089
170 115 089 168 112 085 165 108 081 168 112 085 165 108 081 166 110 083 184 134
109 183 132 106 174 120 094 166 110 083 165 108 081 162 107 079 153 100 074 144
093 069 157 102 076 121 077 057 168 112 085 168 112 085 121 077 057 135 086 064
181 129 104 202 157 134 192 143 118 174 120 094 168 112 085 174 120 094 183 132
106 187 137 112 185 135 110 183 132 106 179 127 102 169 113 087 162 107 079 157
102 076 166 110 083 168 112 085 166 110 083 166 109 082 168 112 085 174 119 093
165 108 081 155 101 076 155 101 076 157 102 076 170 115 089 169 113 087 162 107
079 166 110 083 166 109 082 168 112 085 166 109 082 168 112 085 166 110 083 165
108 081 166 109 082 165 108 081 166 110 083 168 112 085 166 110 083 166 110 083
166 109 082 168 112 085 165 108 081 168 112 085 169 113 087 169 113 087 168 112
085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083 166
110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 110 083 166 110 083 166 110 083 168 112
085 168 112 085 166 110 083 168 112 085 166 110 083 168 112 085 168 112 085 168
112 085 166 110 083 168 112 085 166 109 082 166 109 082 169 113 087 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 166 110 083 168 112 085 168 112 085 166 110 083 168 112 085 170
115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 170 115 089 169 113 087 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 166 109 082 168 112 085 168
112 085 168 112 085 166 109 082 166 110 083 166 110 083 166 110 083 166 110 083
166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
170 115 089 166 110 083 166 110 083 177 124 098 170 115 089 170 115 089 138 089
065 123 079 058 126 080 059 153 100 074 193 144 120 166 110 083 114 072 052 090
054 039 099 061 044 153 100 074 181 129 104 169 113 087 165 108 081 166 109 082
174 119 093 185 135 110 187 137 112 192 143 118 193 146 122 080 048 033 080 048
033 185 135 110 185 135 110 185 135 110 187 137 112 185 135 110 185 135 110 185
135 110 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 190 140 115 190 140 115 192 143 119 192 143 118 200 154 131 198 151
127 183 132 106 181 129 104 193 144 120 192 143 118 183 132 106 200 154 131 202
157 134 192 143 118 169 113 087 161 106 079 153 100 074 161 106 079 111 070 051
120 076 056 162 107 079 168 112 085 170 115 089 170 115 089 174 119 093 173 118
092 174 119 093 173 118 092 174 119 093 162 107 079 161 106 079 183 131 106 162
107 079 168 112 085 176 122 097 168 112 085 170 115 089 168 112 085 152 100 074
162 107 079 170 115 089 166 109 082 170 115 089 174 119 093 166 109 082 166 110
083 157 102 076 152 100 074 157 102 076 165 108 081 176 122 097 179 127 101 168
112 085 166 109 082 177 124 098 166 109 082 170 115 089 173 118 092 174 119 093
174 120 094 174 119 093 168 112 085 169 113 087 174 120 094 170 115 089 173 118
092 177 124 098 174 120 094 168 112 085 170 115 089 170 115 089 169 113 087 170
115 089 170 115 089 179 127 101 173 118 092 168 112 085 166 110 083 169 113 087
170 115 089 166 109 082 166 110 083 165 108 081 169 113 087 181 129 104 174 119
093 166 110 083 166 110 083 174 120 094 173 118 092 162 107 079 153 100 074 153
100 074 157 102 076 146 095 071 136 087 064 138 089 065 144 093 069 162 107 079
170 115 089 174 120 094 174 119 093 174 119 093 174 120 094 168 112 085 151 098
074 157 102 076 155 101 076 155 101 076 162 107 079 170 115 089 170 115 089 168
112 085 168 112 085 185 135 110 200 155 132 196 149 125 200 155 132 204 160 137
193 144 120 188 139 114 193 144 120 200 155 132 200 155 132 198 151 127 196 149
125 196 149 125 196 149 125 198 151 127 200 155 132 196 149 125 188 139 114 190
140 115 185 135 110 181 129 104 173 118 092 166 109 082 148 096 071 157 102 076
179 127 101 185 135 110 183 131 106 179 127 101 179 127 101 174 119 093 174 120
094 173 118 092 170 115 089 173 118 092 170 115 089 174 120 094 170 115 089 168
112 085 170 115 089 170 115 089 168 112 085 168 112 085 165 108 081 165 108 081
166 110 083 168 112 085 170 115 089 166 110 083 165 108 081 166 110 083 168 112
085 166 110 083 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 166 110 083 166 109 082 166 109 082 168 112
085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168 112 085 170
115 089 169 113 087 170 115 089 168 112 085 166 110 083 170 115 089 169 113 087
169 113 087 169 113 087 168 112 085 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 169 113 087 168 112 085 169 113 087 169 113 087 168 112 085 170 115 089 170
115 089 170 115 089 170 115 089 173 118 092 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 166 109 082 166 110 083 166 110 083 166 110 083 166 110 083 168 112 085 168
112 085 168 112 085 166 110 083 166 110 083 166 110 083 166 110 083 166 110 083
166 110 083 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 166 110 083 166 110 083 166 110 083 166 110 083 169 113 087 168 112 085 168
112 085 168 112 085 168 112 085 170 115 089 173 118 092 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 174 119 093 173 118 092 174 120 094 153 100
074 144 093 069 115 073 054 174 119 093 202 158 135 202 158 135 190 140 115 202
157 134 209 167 145 204 160 137 198 151 127 193 144 120 198 151 127 198 151 127
200 154 131 196 149 125 193 144 120 193 144 120 190 140 115 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 185 135 110 185 135 110 184 134 109 184 134 109 184 134 109 185 135
110 185 135 110 184 134 109 192 143 118 199 152 129 193 144 120 192 143 118 193
146 122 190 140 115 198 151 127 199 152 129 193 146 122 196 149 125 153 100 074
143 092 069 179 127 101 170 115 089 155 101 076 138 089 065 143 092 069 162 107
079 168 112 085 157 102 076 152 100 074 144 093 069 144 093 069 170 115 089 153
100 074 143 092 069 173 118 092 177 124 098 174 120 094 177 124 098 179 127 102
170 115 089 174 120 094 173 118 092 174 120 094 177 124 098 174 120 094 176 122
097 184 134 109 183 132 106 170 115 089 162 107 079 169 113 087 174 120 094 174
120 094 166 109 082 144 093 069 162 107 079 169 113 087 134 086 064 162 107 079
166 109 082 143 092 069 157 102 076 161 106 079 155 101 076 170 115 089 162 107
079 165 108 081 169 113 087 165 108 081 165 108 081 170 115 089 173 118 092 168
112 085 162 107 079 168 112 085 170 115 089 169 113 087 169 113 087 169 113 087
168 112 085 169 113 087 170 115 089 174 119 093 168 112 085 153 100 074 162 107
079 165 108 081 166 109 082 162 107 079 165 108 081 170 115 089 166 109 082 155
101 076 155 101 076 166 110 083 155 101 076 152 100 074 130 083 061 114 072 052
115 073 054 134 086 064 155 101 076 170 115 089 168 112 085 170 115 089 168 112
085 162 107 079 174 120 094 193 144 120 193 144 120 198 151 127 199 152 129 198
151 127 198 151 127 198 151 127 185 135 110 193 144 120 198 151 127 185 135 110
188 139 114 188 139 114 185 135 110 183 131 106 190 140 115 188 139 114 187 137
112 185 135 110 185 135 110 190 140 115 187 137 112 192 143 118 196 149 125 193
146 122 187 137 112 192 143 119 200 154 131 198 151 127 193 146 122 166 110 083
168 112 085 151 098 074 153 100 074 174 119 093 166 109 082 170 115 089 174 120
094 168 112 085 174 120 094 174 120 094 181 129 104 174 119 093 170 115 089 173
118 092 170 115 089 170 115 089 168 112 085 169 113 087 166 110 083 166 109 082
166 109 082 162 107 079 165 108 081 162 107 079 166 110 083 165 108 081 168 112
085 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168
112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 168 112 085 170 115 089 170 115 089 174 119 093 170 115 089 169
113 087 170 115 089 170 115 089 173 118 092 170 115 089 168 112 085 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 168 112 085 169 113 087 169 113 087 169 113 087 168 112 085 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 166 110 083 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 166 109 082 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087
169 113 087 170 115 089 170 115 089 168 112 085 166 109 082 169 113 087 162 107
079 148 096 071 130 083 061 144 093 069 174 120 094 209 167 145 202 157 134 192
143 119 193 144 120 173 118 092 179 127 101 190 140 115 185 135 110 185 135 110
183 131 106 184 134 109 184 134 109 184 134 109 185 135 110 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 198 151
127 196 149 125 185 135 110 183 131 106 187 137 112 188 139 114 187 137 112 187
137 112 187 137 112 181 129 104 183 132 106 188 139 114 187 137 112 198 151 127
200 155 132 196 149 125 198 151 127 188 139 114 192 143 118 185 135 110 179 127
102 179 127 101 170 115 089 170 115 089 174 120 094 176 122 097 165 108 081 177
124 098 174 119 093 161 106 079 157 102 076 146 095 071 148 096 071 157 102 076
155 101 076 155 101 076 151 098 074 143 092 069 140 090 067 161 106 079 153 100
074 148 096 071 153 100 074 151 098 074 162 107 079 126 080 059 129 083 061 162
107 079 138 089 065 155 101 076 174 120 094 185 135 110 168 112 085 162 107 079
140 090 067 162 107 079 207 161 140 192 143 118 115 073 054 162 107 079 168 112
085 174 119 093 170 115 089 169 113 087 173 118 092 166 110 083 162 107 079 170
115 089 174 119 093 169 113 087 170 115 089 173 118 092 174 120 094 173 118 092
169 113 087 169 113 087 170 115 089 170 115 089 169 113 087 162 107 079 162 107
079 174 119 093 170 115 089 165 108 081 162 107 079 168 112 085 170 115 089 168
112 085 169 113 087 174 119 093 170 115 089 176 122 097 174 120 094 169 113 087
155 101 076 134 086 064 115 073 054 144 093 069 089 054 039 143 092 069 209 166
144 198 151 127 193 144 120 183 131 106 185 135 110 183 132 106 184 134 109 184
134 109 193 144 120 181 129 104 185 135 110 187 137 112 188 139 114 185 135 110
185 135 110 187 137 112 190 140 115 188 139 114 190 140 115 190 140 115 192 143
118 187 137 112 187 137 112 187 137 112 183 131 106 183 131 106 183 131 106 177
124 098 190 140 115 187 137 112 185 135 110 185 135 110 192 143 119 196 149 125
193 144 120 174 120 094 168 112 085 173 118 092 144 093 069 134 086 064 173 118
092 179 127 102 177 124 098 170 115 089 146 095 071 162 107 079 176 122 097 170
115 089 168 112 085 169 113 087 170 115 089 170 115 089 173 118 092 174 119 093
170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 173 118 092 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169
113 087 169 113 087 168 112 085 170 115 089 169 113 087 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 170 115 089 170 115 089 170 115 089 173 118 092 174 119 093 170
115 089 170 115 089 169 113 087 169 113 087 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083 168
112 085 168 112 085 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110
083 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 166 110 083 166 110 083 166 110 083 166 110 083
166 110 083 166 109 082 162 107 079 161 106 079 157 102 076 161 106 079 170 115
089 144 093 069 078 047 032 102 065 046 089 054 039 120 076 056 173 118 092 198
151 127 202 158 135 202 158 135 187 137 112 187 137 112 190 140 115 192 143 118
192 143 119 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 183 131
106 187 137 112 190 140 115 188 139 114 188 139 114 188 139 114 184 134 109 183
131 106 185 135 110 185 135 110 192 143 118 192 143 118 192 143 118 183 132 106
188 139 114 193 144 120 190 140 115 187 137 112 190 140 115 198 151 127 199 152
129 198 151 127 200 155 132 199 152 129 198 151 127 196 149 125 196 149 125 193
144 120 193 146 122 193 144 120 188 139 114 185 135 110 179 127 102 179 127 101
157 102 076 168 112 085 168 112 085 168 112 085 173 118 092 179 127 101 179 127
101 179 127 101 183 131 106 185 135 110 193 144 120 188 139 114 190 140 115 198
151 127 198 151 127 192 143 119 190 140 115 198 151 127 200 155 132 192 143 118
207 163 141 179 127 101 166 110 083 138 089 065 146 095 071 155 101 076 176 122
097 179 127 101 174 119 093 177 124 098 170 115 089 152 100 074 151 098 074 157
102 076 168 112 085 165 108 081 165 108 081 162 107 079 166 109 082 162 107 079
165 108 081 162 107 079 157 102 076 148 096 071 153 100 074 174 120 094 165 108
081 111 070 051 143 092 069 168 112 085 143 092 069 155 101 076 174 120 094 152
100 074 162 107 079 179 127 102 174 120 094 179 127 102 179 127 101 183 131 106
183 131 106 181 129 104 143 092 069 148 096 071 123 079 058 114 072 052 144 093
069 185 135 110 187 137 112 185 135 110 185 135 110 184 134 109 187 137 112 190
140 115 183 131 106 188 139 114 198 151 127 187 137 112 179 127 101 188 139 114
188 139 114 185 135 110 187 137 112 190 140 115 190 140 115 190 140 115 188 139
114 190 140 115 190 140 115 185 135 110 187 137 112 190 140 115 193 144 120 192
143 118 185 135 110 185 135 110 187 137 112 184 134 109 183 131 106 183 131 106
190 140 115 200 154 131 199 152 129 193 146 122 190 140 115 174 119 093 148 096
071 161 106 079 152 100 074 148 096 071 161 106 079 155 101 076 170 115 089 179
127 101 174 119 093 170 115 089 170 115 089 168 112 085 168 112 085 170 115 089
168 112 085 169 113 087 168 112 085 174 119 093 179 127 101 170 115 089 169 113
087 166 110 083 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 169 113 087 170 115 089 170 115 089 174 119 093 173 118 092
170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 173 118 092 170 115
089 173 118 092 174 120 094 174 119 093 169 113 087 170 115 089 170 115 089 166
110 083 166 110 083 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113
087 170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083 166 110 083
168 112 085 169 113 087 169 113 087 166 110 083 166 109 082 166 109 082 166 110
083 166 110 083 162 107 079 162 107 079 165 108 081 162 107 079 168 112 085 179
127 101 170 115 089 170 115 089 173 118 092 168 112 085 170 115 089 173 118 092
170 115 089 169 113 087 170 115 089 170 115 089 169 113 087 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 168 112 085 169 113 087 169 113 087 169 113 087 168 112 085 168 112 085 168
112 085 169 113 087 170 115 089 170 115 089 168 112 085 168 112 085 168 112 085
169 113 087 168 112 085 169 113 087 169 113 087 166 109 082 168 112 085 166 109
082 173 118 092 168 112 085 135 086 064 115 073 054 082 050 035 061 035 024 134
086 064 157 102 076 181 129 104 209 166 144 190 140 115 185 135 110 184 134 109
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 183 132
106 183 132 106 185 135 110 187 137 112 190 140 115 188 139 114 190 140 115 188
139 114 185 135 110 190 140 115 193 144 120 187 137 112 190 140 115 187 137 112
185 135 110 188 139 114 188 139 114 188 139 114 187 137 112 187 137 112 184 134
109 185 135 110 187 137 112 185 135 110 183 131 106 181 129 104 188 139 114 183
132 106 185 135 110 190 140 115 190 140 115 192 143 119 193 144 120 193 146 122
198 151 127 198 151 127 199 152 129 199 152 129 200 155 132 193 144 120 193 144
120 198 151 127 193 144 120 190 140 115 187 137 112 193 144 120 192 143 119 188
139 114 190 140 115 187 137 112 187 137 112 184 134 109 185 135 110 188 139 114
196 149 125 185 135 110 155 101 076 140 090 067 144 093 069 144 093 069 126 080
059 106 067 048 111 070 051 108 068 049 135 086 064 183 131 106 176 122 097 183
131 106 155 101 076 153 100 074 153 100 074 162 107 079 151 098 074 168 112 085
190 140 115 183 131 106 183 131 106 179 127 102 183 132 106 198 151 127 190 140
115 168 112 085 136 087 064 162 107 079 187 137 112 183 131 106 165 108 081 126
080 059 148 096 071 155 101 076 162 107 079 155 101 076 168 112 085 168 112 085
176 122 097 179 127 101 165 108 081 138 089 065 162 107 079 138 089 065 165 108
081 199 152 129 192 143 119 185 135 110 190 140 115 190 140 115 188 139 114 190
140 115 185 135 110 188 139 114 190 140 115 190 140 115 183 132 106 185 135 110
188 139 114 190 140 115 187 137 112 185 135 110 187 137 112 187 137 112 187 137
112 188 139 114 188 139 114 190 140 115 192 143 118 192 143 118 190 140 115 192
143 119 190 140 115 190 140 115 185 135 110 188 139 114 192 143 118 193 144 120
190 140 115 185 135 110 185 135 110 185 135 110 199 152 129 199 152 129 177 124
098 174 119 093 166 109 082 144 093 069 165 108 081 151 098 074 140 090 067 153
100 074 170 115 089 173 118 092 176 122 097 179 127 102 179 127 101 174 120 094
174 120 094 174 119 093 170 115 089 165 108 081 165 108 081 166 109 082 170 115
089 170 115 089 166 110 083 168 112 085 168 112 085 166 110 083 166 109 082 170
115 089 173 118 092 174 119 093 174 119 093 169 113 087 157 102 076 166 110 083
173 118 092 170 115 089 169 113 087 173 118 092 174 120 094 170 115 089 170 115
089 170 115 089 169 113 087 170 115 089 181 129 104 170 115 089 168 112 085 179
127 101 177 124 098 173 118 092 169 113 087 170 115 089 170 115 089 162 107 079
162 107 079 168 112 085 179 127 101 168 112 085 168 112 085 174 119 093 179 127
102 174 120 094 166 110 083 166 110 083 166 109 082 168 112 085 170 115 089 170
115 089 170 115 089 168 112 085 166 109 082 168 112 085 168 112 085 168 112 085
168 112 085 162 107 079 162 107 079 168 112 085 168 112 085 168 112 085 166 109
082 166 109 082 168 112 085 166 110 083 166 109 082 155 101 076 162 107 079 168
112 085 173 118 092 176 122 097 176 122 097 176 122 097 169 113 087 165 108 081
168 112 085 174 120 094 170 115 089 162 107 079 174 119 093 168 112 085 168 112
085 170 115 089 170 115 089 173 118 092 168 112 085 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169
113 087 168 112 085 170 115 089 170 115 089 168 112 085 168 112 085 170 115 089
170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 169 113 087
170 115 089 168 112 085 166 110 083 169 113 087 169 113 087 168 112 085 170 115
089 170 115 089 170 115 089 170 115 089 169 113 087 173 118 092 174 120 094 174
120 094 170 115 089 166 109 082 169 113 087 170 115 089 169 113 087 170 115 089
170 115 089 168 112 085 166 110 083 169 113 087 170 115 089 166 110 083 166 109
082 170 115 089 198 151 127 188 139 114 190 140 115 184 134 109 152 100 074 120
076 056 090 054 039 037 019 011 162 107 079 204 160 137 184 134 109 188 139 114
192 143 118 188 139 114 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 188 139 114 188 139 114 187 137 112 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 187 137 112 188 139 114 185 135 110 188 139
114 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 187 137 112 190
140 115 190 140 115 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110
188 139 114 185 135 110 187 137 112 185 135 110 184 134 109 185 135 110 187 137
112 185 135 110 185 135 110 188 139 114 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 187 137 112 188 139 114 188 139 114 184 134 109
179 127 101 200 154 131 207 161 140 200 155 132 177 124 098 184 134 109 190 140
115 193 144 120 193 144 120 188 139 114 187 137 112 200 155 132 193 146 122 199
152 129 198 151 127 193 146 122 198 151 127 200 154 131 196 149 125 198 151 127
193 144 120 193 144 120 193 144 120 193 146 122 196 149 125 196 149 125 198 151
127 202 157 134 192 143 119 202 157 134 190 140 115 115 073 054 121 077 057 155
101 076 183 131 106 174 119 093 174 120 094 155 101 076 157 102 076 144 093 069
169 113 087 170 115 089 153 100 074 121 077 057 134 086 064 148 096 071 198 151
127 200 155 132 193 146 122 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 185 135 110 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 185 135 110 185
135 110 185 135 110 187 137 112 190 140 115 188 139 114 185 135 110 185 135 110
185 135 110 187 137 112 187 137 112 188 139 114 183 132 106 185 135 110 193 146
122 193 144 120 200 154 131 198 151 127 185 135 110 183 132 106 185 135 110 173
118 092 144 093 069 151 098 074 151 098 074 153 100 074 162 107 079 168 112 085
166 110 083 168 112 085 174 120 094 168 112 085 155 101 076 183 131 106 188 139
114 179 127 102 177 124 098 179 127 101 177 124 098 174 120 094 177 124 098 174
119 093 170 115 089 174 120 094 174 120 094 169 113 087 179 127 101 174 120 094
174 119 093 183 131 106 179 127 101 177 124 098 176 122 097 170 115 089 173 118
092 174 120 094 170 115 089 157 102 076 174 120 094 168 112 085 161 106 079 181
129 104 179 127 102 179 127 101 176 122 097 176 122 097 177 124 098 176 122 097
168 112 085 183 131 106 174 120 094 174 120 094 176 122 097 179 127 101 157 102
076 174 120 094 181 129 104 176 122 097 174 120 094 170 115 089 168 112 085 168
112 085 174 120 094 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 168 112 085 166 109 082 166 110 083 169 113 087 169 113 087 168 112
085 166 109 082 166 109 082 166 110 083 162 107 079 168 112 085 140 090 067 123
079 058 166 109 082 166 110 083 151 098 074 174 120 094 177 124 098 166 110 083
174 119 093 176 122 097 170 115 089 170 115 089 169 113 087 173 118 092 170 115
089 165 108 081 168 112 085 168 112 085 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 169 113 087 169 113 087
169 113 087 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 168 112
085 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169
113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 173 118 092 169 113 087 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 173 118 092 170 115 089 170 115 089
170 115 089 169 113 087 168 112 085 168 112 085 168 112 085 165 108 081 166 109
082 169 113 087 170 115 089 170 115 089 170 115 089 166 110 083 161 106 079 166
109 082 166 109 082 169 113 087 162 107 079 168 112 085 174 120 094 168 112 085
166 109 082 179 127 101 177 124 098 174 120 094 174 120 094 168 112 085 136 087
064 153 100 074 125 079 058 108 068 049 134 086 064 144 093 069 157 102 076 136
087 064 153 100 074 135 086 064 161 106 079 193 144 120 185 135 110 193 144 120
192 143 118 188 139 114 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 190 140 115 193 144 120 193 146 122 196 149 125 198 151 127 193 144
120 193 144 120 192 143 119 193 144 120 187 137 112 185 135 110 193 144 120 185
135 110 192 143 119 193 144 120 185 135 110 185 135 110 190 140 115 192 143 118
184 134 109 185 135 110 185 135 110 187 137 112 185 135 110 183 131 106 183 131
106 183 131 106 192 143 118 202 157 134 151 098 074 082 050 035 144 093 069 179
127 101 168 112 085 157 102 076 089 054 039 114 072 052 200 154 131 179 127 101
169 113 087 169 113 087 134 086 064 134 086 064 155 101 076 161 106 079 192 143
119 193 144 120 193 144 120 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 188 139 114 185 135
110 187 137 112 190 140 115 193 144 120 193 146 122 193 146 122 193 146 122 200
154 131 198 151 127 179 127 101 166 109 082 170 115 089 168 112 085 157 102 076
153 100 074 148 096 071 144 093 069 140 090 067 144 093 069 174 119 093 161 106
079 129 083 061 148 096 071 146 095 071 144 093 069 146 095 071 144 093 069 144
093 069 146 095 071 146 095 071 144 093 069 153 100 074 148 096 071 157 102 076
157 102 076 148 096 071 157 102 076 140 090 067 126 080 059 134 086 064 135 086
064 140 090 067 162 107 079 146 095 071 148 096 071 146 095 071 140 090 067 126
080 059 135 086 064 151 098 074 166 110 083 170 115 089 162 107 079 188 139 114
185 135 110 174 120 094 168 112 085 146 095 071 135 086 064 170 115 089 179 127
101 174 120 094 173 118 092 170 115 089 166 110 083 166 109 082 162 107 079 170
115 089 170 115 089 162 107 079 174 119 093 170 115 089 168 112 085 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 166 110
083 166 109 082 166 109 082 166 110 083 168 112 085 170 115 089 161 106 079 144
093 069 170 115 089 179 127 101 166 110 083 170 115 089 185 135 110 183 131 106
161 106 079 151 098 074 169 113 087 183 132 106 174 120 094 162 107 079 170 115
089 174 120 094 170 115 089 168 112 085 170 115 089 170 115 089 168 112 085 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087
169 113 087 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 169 113 087 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089
169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 168 112 085 169 113 087 168 112 085 169 113 087
168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 166 109
082 168 112 085 170 115 089 173 118 092 170 115 089 168 112 085 168 112 085 170
115 089 174 119 093 174 120 094 174 120 094 170 115 089 168 112 085 174 119 093
183 132 106 170 115 089 162 107 079 177 124 098 174 120 094 152 100 074 138 089
065 144 093 069 170 115 089 176 122 097 166 109 082 155 101 076 174 120 094 183
132 106 200 154 131 204 160 137 190 140 115 184 134 109 184 134 109 192 143 119
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
185 135 110 183 132 106 183 131 106 176 122 097 179 127 102 185 135 110 185 135
110 185 135 110 183 132 106 185 135 110 196 149 125 192 143 119 185 135 110 196
149 125 183 132 106 170 115 089 187 137 112 190 140 115 187 137 112 183 131 106
190 140 115 187 137 112 187 137 112 190 140 115 185 135 110 184 134 109 190 140
115 192 143 119 196 149 125 187 137 112 153 100 074 174 120 094 200 155 132 168
112 085 096 059 042 061 035 024 152 100 074 181 129 104 126 080 059 170 115 089
174 120 094 151 098 074 130 083 061 161 106 079 179 127 101 165 108 081 190 140
115 192 143 118 190 140 115 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 184 134
109 185 135 110 185 135 110 183 132 106 188 139 114 184 134 109 187 137 112 184
134 109 183 131 106 190 140 115 198 151 127 199 152 129 199 152 129 198 151 127
200 154 131 200 155 132 190 140 115 202 157 134 183 131 106 135 086 064 165 108
081 179 127 101 193 144 120 190 140 115 190 140 115 188 139 114 190 140 115 185
135 110 179 127 102 179 127 102 179 127 102 187 137 112 179 127 102 165 108 081
162 107 079 168 112 085 177 124 098 181 129 104 179 127 102 179 127 101 185 135
110 192 143 118 196 149 125 198 151 127 200 155 132 193 146 122 179 127 101 183
131 106 179 127 101 168 112 085 152 100 074 148 096 071 151 098 074 120 076 056
130 083 061 136 087 064 177 124 098 193 144 120 177 124 098 134 086 064 155 101
076 162 107 079 157 102 076 169 113 087 173 118 092 170 115 089 170 115 089 181
129 104 174 120 094 170 115 089 174 119 093 170 115 089 169 113 087 168 112 085
168 112 085 170 115 089 170 115 089 170 115 089 169 113 087 174 119 093 174 120
094 174 120 094 174 120 094 176 122 097 174 120 094 174 119 093 170 115 089 146
095 071 151 098 074 170 115 089 173 118 092 153 100 074 152 100 074 143 092 069
111 070 051 152 100 074 173 118 092 144 093 069 174 119 093 181 129 104 174 120
094 176 122 097 173 118 092 170 115 089 170 115 089 166 110 083 169 113 087 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087
169 113 087 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169
113 087 170 115 089 170 115 089 170 115 089 166 110 083 166 110 083 168 112 085
168 112 085 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 168 112 085
169 113 087 168 112 085 166 109 082 168 112 085 169 113 087 170 115 089 169 113
087 170 115 089 170 115 089 173 118 092 174 119 093 174 120 094 179 127 102 179
127 101 174 119 093 162 107 079 170 115 089 162 107 079 153 100 074 168 112 085
153 100 074 144 093 069 146 095 071 134 086 064 155 101 076 155 101 076 183 131
106 199 152 129 200 155 132 198 151 127 193 146 122 200 155 132 198 151 127 192
143 118 193 144 120 181 129 104 188 139 114 192 143 119 185 135 110 188 139 114
190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
188 139 114 184 134 109 192 143 119 192 143 118 198 151 127 190 140 115 192 143
118 192 143 118 190 140 115 188 139 114 193 144 120 184 134 109 176 122 097 185
135 110 185 135 110 174 119 093 185 135 110 190 140 115 192 143 118 188 139 114
187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 190 140 115 188 139
114 185 135 110 183 131 106 190 140 115 198 151 127 193 144 120 193 144 120 199
152 129 183 131 106 183 131 106 200 155 132 204 160 137 170 115 089 089 054 039
136 087 064 179 127 101 168 112 085 170 115 089 166 109 082 165 108 081 198 151
127 185 135 110 188 139 114 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 183 132 106 187 137 112 190 140
115 187 137 112 185 135 110 192 143 118 192 143 119 185 135 110 185 135 110 193
144 120 193 144 120 185 135 110 183 131 106 187 137 112 185 135 110 183 131 106
185 135 110 192 143 118 193 144 120 200 154 131 198 151 127 185 135 110 196 149
125 200 155 132 198 151 127 196 149 125 193 146 122 193 146 122 193 144 120 198
151 127 199 152 129 196 149 125 196 149 125 193 146 122 200 154 131 200 154 131
198 151 127 199 152 129 196 149 125 200 155 132 202 157 134 198 151 127 193 146
122 196 149 125 183 132 106 183 132 106 190 140 115 193 144 120 198 151 127 200
155 132 200 155 132 199 152 129 192 143 119 193 144 120 198 151 127 174 120 094
177 124 098 193 144 120 196 149 125 198 151 127 204 160 137 183 132 106 169 113
087 170 115 089 155 101 076 162 107 079 169 113 087 174 120 094 174 120 094 138
089 065 155 101 076 185 135 110 177 124 098 174 120 094 174 120 094 173 118 092
174 119 093 179 127 101 183 132 106 177 124 098 168 112 085 165 108 081 161 106
079 162 107 079 162 107 079 162 107 079 162 107 079 153 100 074 157 102 076 165
108 081 138 089 065 114 072 052 155 101 076 179 127 101 144 093 069 144 093 069
179 127 102 200 155 132 198 151 127 177 124 098 144 093 069 168 112 085 151 098
074 155 101 076 179 127 101 179 127 101 176 122 097 174 120 094 174 120 094 170
115 089 174 120 094 174 120 094 176 122 097 174 119 093 174 120 094 174 119 093
173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169 113
087 170 115 089 173 118 092 170 115 089 170 115 089 170 115 089 174 119 093 173
118 092 173 118 092 174 119 093 174 120 094 170 115 089 173 118 092 173 118 092
174 120 094 174 120 094 179 127 101 174 120 094 174 119 093 174 120 094 177 124
098 177 124 098 176 122 097 179 127 101 173 118 092 170 115 089 174 120 094 174
119 093 170 115 089 174 120 094 173 118 092 170 115 089 170 115 089 170 115 089
169 113 087 169 113 087 173 118 092 170 115 089 173 118 092 174 119 093 177 124
098 174 120 094 168 112 085 166 109 082 174 120 094 168 112 085 144 093 069 143
092 069 144 093 069 162 107 079 165 108 081 161 106 079 152 100 074 152 100 074
166 109 082 190 140 115 196 149 125 190 140 115 192 143 118 200 155 132 192 143
119 183 132 106 185 135 110 190 140 115 188 139 114 183 131 106 183 132 106 185
135 110 185 135 110 188 139 114 190 140 115 192 143 119 190 140 115 184 134 109
188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 188 139 114 190 140 115 190 140 115 192 143 119 190 140 115 187 137
112 187 137 112 190 140 115 190 140 115 184 134 109 185 135 110 187 137 112 183
132 106 190 140 115 193 146 122 188 139 114 185 135 110 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115 187 137
112 188 139 114 187 137 112 190 140 115 184 134 109 187 137 112 184 134 109 183
132 106 200 155 132 215 174 153 174 120 094 102 065 046 126 080 059 126 080 059
093 057 041 152 100 074 190 140 115 181 129 104 138 089 065 153 100 074 200 155
132 179 127 101 183 131 106 190 140 115 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 187 137
112 188 139 114 185 135 110 185 135 110 185 135 110 187 137 112 184 134 109 188
139 114 196 149 125 192 143 119 190 140 115 184 134 109 185 135 110 187 137 112
185 135 110 185 135 110 192 143 119 183 131 106 183 132 106 198 151 127 192 143
118 183 132 106 184 134 109 185 135 110 185 135 110 185 135 110 185 135 110 185
135 110 184 134 109 184 134 109 184 134 109 184 134 109 183 132 106 188 139 114
190 140 115 184 134 109 185 135 110 184 134 109 184 134 109 185 135 110 184 134
109 183 131 106 185 135 110 187 137 112 190 140 115 190 140 115 190 140 115 183
131 106 183 132 106 187 137 112 192 143 119 192 143 118 190 140 115 204 160 137
202 157 134 192 143 119 185 135 110 181 129 104 184 134 109 198 151 127 200 154
131 198 151 127 185 135 110 179 127 102 170 115 089 166 110 083 162 107 079 162
107 079 111 070 051 136 087 064 136 087 064 179 127 102 174 120 094 168 112 085
157 102 076 155 101 076 144 093 069 165 108 081 151 098 074 148 096 071 170 115
089 173 118 092 174 120 094 174 120 094 174 119 093 168 112 085 174 120 094 188
139 114 185 135 110 183 132 106 193 144 120 202 158 135 199 152 129 193 146 122
198 151 127 183 131 106 185 135 110 200 154 131 192 143 119 179 127 102 190 140
115 151 098 074 144 093 069 174 120 094 162 107 079 157 102 076 170 115 089 183
132 106 168 112 085 155 101 076 151 098 074 165 108 081 157 102 076 166 110 083
173 118 092 174 120 094 181 129 104 179 127 101 174 119 093 174 120 094 183 131
106 183 131 106 179 127 101 174 120 094 183 131 106 177 124 098 155 101 076 166
109 082 157 102 076 153 100 074 165 108 081 174 120 094 168 112 085 161 106 079
162 107 079 166 110 083 144 093 069 152 100 074 157 102 076 146 095 071 144 093
069 174 120 094 170 115 089 162 107 079 179 127 101 177 124 098 168 112 085 161
106 079 151 098 074 153 100 074 176 122 097 176 122 097 173 118 092 170 115 089
177 124 098 183 131 106 176 122 097 170 115 089 169 113 087 155 101 076 146 095
071 152 100 074 151 098 074 144 093 069 134 086 064 134 086 064 166 110 083 193
144 120 193 144 120 193 144 120 193 144 120 198 151 127 193 146 122 193 144 120
200 155 132 200 154 131 193 144 120 193 146 122 187 137 112 184 134 109 185 135
110 188 139 114 192 143 119 183 132 106 170 115 089 185 135 110 190 140 115 190
140 115 190 140 115 193 144 120 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 188 139 114 190
140 115 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112 188 139 114 190
140 115 181 129 104 181 129 104 192 143 119 183 132 106 187 137 112 198 151 127
120 076 056 068 041 028 111 070 051 174 120 094 179 127 101 146 095 071 188 139
114 196 149 125 192 143 118 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115 185
135 110 185 135 110 185 135 110 185 135 110 188 139 114 187 137 112 190 140 115
187 137 112 187 137 112 185 135 110 188 139 114 190 140 115 185 135 110 185 135
110 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 188 139 114 188 139 114 188 139 114 190 140 115 187 137 112
185 135 110 188 139 114 188 139 114 187 137 112 187 137 112 188 139 114 188 139
114 190 140 115 190 140 115 187 137 112 185 135 110 185 135 110 187 137 112 188
139 114 188 139 114 187 137 112 187 137 112 187 137 112 185 135 110 184 134 109
184 134 109 185 135 110 185 135 110 190 140 115 187 137 112 184 134 109 185 135
110 187 137 112 190 140 115 193 146 122 193 144 120 190 140 115 185 135 110 202
158 135 198 151 127 179 127 101 138 089 065 151 098 074 152 100 074 162 107 079
162 107 079 135 086 064 120 076 056 184 134 109 196 149 125 193 144 120 193 146
122 198 151 127 193 144 120 193 144 120 193 144 120 196 149 125 193 146 122 192
143 119 193 144 120 196 149 125 190 140 115 184 134 109 187 137 112 190 140 115
185 135 110 190 140 115 187 137 112 185 135 110 190 140 115 192 143 118 202 158
135 151 098 074 121 077 057 173 118 092 170 115 089 173 118 092 143 092 069 146
095 071 162 107 079 177 124 098 187 137 112 170 115 089 168 112 085 169 113 087
166 110 083 151 098 074 151 098 074 151 098 074 144 093 069 151 098 074 161 106
079 162 107 079 155 101 076 166 109 082 136 087 064 114 072 052 155 101 076 174
120 094 184 134 109 170 115 089 151 098 074 151 098 074 152 100 074 151 098 074
153 100 074 151 098 074 165 108 081 184 134 109 196 149 125 192 143 119 155 101
076 104 066 047 155 101 076 136 087 064 144 093 069 138 089 065 146 095 071 185
135 110 199 152 129 162 107 079 144 093 069 168 112 085 168 112 085 155 101 076
144 093 069 144 093 069 152 100 074 166 109 082 168 112 085 162 107 079 169 113
087 179 127 102 185 135 110 192 143 119 193 146 122 187 137 112 193 146 122 200
155 132 193 144 120 190 140 115 187 137 112 190 140 115 192 143 118 192 143 119
185 135 110 184 134 109 185 135 110 185 135 110 190 140 115 190 140 115 185 135
110 188 139 114 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 190 140 115 185 135 110 185 135 110 193 146 122 198 151 127 183 131 106
202 157 134 174 120 094 058 033 022 082 050 035 144 093 069 138 089 065 123 079
058 215 174 153 204 160 137 183 132 106 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 188 139
114 187 137 112 185 135 110 188 139 114 188 139 114 185 135 110 190 140 115 192
143 118 188 139 114 198 151 127 198 151 127 183 132 106 192 143 119 190 140 115
190 140 115 198 151 127 200 155 132 193 144 120 185 135 110 192 143 119 183 132
106 185 135 110 192 143 118 190 140 115 190 140 115 190 140 115 188 139 114 185
135 110 185 135 110 185 135 110 185 135 110 187 137 112 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 192 143
118 179 127 101 183 131 106 198 151 127 200 155 132 192 143 118 192 143 118 192
143 119 188 139 114 198 151 127 196 149 125 193 144 120 190 140 115 200 154 131
209 166 144 144 093 069 134 086 064 168 112 085 176 122 097 179 127 101 157 102
076 157 102 076 165 108 081 155 101 076 157 102 076 174 120 094 200 155 132 196
149 125 200 154 131 200 154 131 193 144 120 185 135 110 181 129 104 183 131 106
192 143 119 200 154 131 192 143 118 200 154 131 200 155 132 200 155 132 193 144
120 179 127 101 200 155 132 193 146 122 183 132 106 188 139 114 200 155 132 193
144 120 196 149 125 193 144 120 192 143 119 190 140 115 187 137 112 202 157 134
152 100 074 135 086 064 190 140 115 193 144 120 196 149 125 196 149 125 198 151
127 193 144 120 193 144 120 193 144 120 196 149 125 190 140 115 185 135 110 187
137 112 190 140 115 190 140 115 185 135 110 185 135 110 185 135 110 185 135 110
185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 190 140 115 193 144 120 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 196 149 125 192 143 118 183 131 106 177 124 098 190 140 115
200 155 132 198 151 127 162 107 079 111 070 051 126 080 059 157 102 076 078 047
032 054 029 019 098 061 044 188 139 114 198 151 127 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 188 139 114 187 137 112 187 137 112 188 139 114 187 137 112 185
135 110 192 143 119 183 131 106 190 140 115 196 149 125 193 146 122 192 143 119
190 140 115 188 139 114 190 140 115 193 144 120 193 144 120 190 140 115 187 137
112 193 144 120 185 135 110 188 139 114 188 139 114 190 140 115 187 137 112 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135
110 192 143 118 193 144 120 190 140 115 185 135 110 177 124 098 193 144 120 200
155 132 192 143 119 192 143 119 185 135 110 192 143 118 185 135 110 184 134 109
202 158 135 196 149 125 192 143 118 193 144 120 193 146 122 198 151 127 198 151
127 198 151 127 200 155 132 187 137 112 202 157 134 193 146 122 190 140 115 183
131 106 181 129 104 184 134 109 185 135 110 199 152 129 198 151 127 193 144 120
187 137 112 183 131 106 192 143 118 190 140 115 187 137 112 183 131 106 185 135
110 199 152 129 190 140 115 193 146 122 193 146 122 190 140 115 193 144 120 187
137 112 190 140 115 200 154 131 192 143 118 183 131 106 188 139 114 193 146 122
199 152 129 193 146 122 198 151 127 198 151 127 190 140 115 183 131 106 185 135
110 190 140 115 187 137 112 185 135 110 183 131 106 190 140 115 190 140 115 184
134 109 184 134 109 188 139 114 188 139 114 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 187 137 112 184 134 109 184 134 109 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 185 135 110 187 137 112 190 140 115 187 137 112 188 139 114 188 139 114
181 129 104 198 151 127 204 160 137 202 158 135 200 154 131 188 139 114 183 131
106 126 080 059 115 073 054 187 137 112 196 149 125 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 185 135 110 185 135 110 187 137 112 187 137 112 185
135 110 183 131 106 192 143 118 187 137 112 193 144 120 188 139 114 184 134 109
183 131 106 181 129 104 185 135 110 193 144 120 192 143 119 185 135 110 190 140
115 184 134 109 184 134 109 185 135 110 184 134 109 184 134 109 185 135 110 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 192 143 118 183 131 106 183 131 106 198 151 127 185 135 110 183
131 106 185 135 110 183 131 106 183 132 106 200 155 132 185 135 110 179 127 101
183 131 106 190 140 115 190 140 115 188 139 114 185 135 110 183 131 106 190 140
115 192 143 118 185 135 110 190 140 115 183 132 106 179 127 102 192 143 118 192
143 118 185 135 110 185 135 110 190 140 115 188 139 114 184 134 109 184 134 109
185 135 110 190 140 115 193 146 122 188 139 114 183 131 106 184 134 109 185 135
110 183 132 106 188 139 114 185 135 110 184 134 109 188 139 114 181 129 104 187
137 112 183 131 106 190 140 115 179 127 102 185 135 110 188 139 114 183 131 106
185 135 110 192 143 119 184 134 109 183 132 106 192 143 119 193 144 120 193 144
120 193 144 120 192 143 118 187 137 112 184 134 109 193 144 120 193 144 120 187
137 112 183 132 106 187 137 112 193 144 120 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 187 137 112 190 140 115 190 140 115 190 140 115
187 137 112 185 135 110 188 139 114 193 146 122 184 134 109 144 093 069 200 154
131 193 144 120 185 135 110 198 151 127 188 139 114 190 140 115 185 135 110 192
143 118 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
198 151 127 190 140 115 185 135 110 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 187 137 112 188 139 114 190 140 115 190 140 115 187
137 112 185 135 110 187 137 112 185 135 110 187 137 112 188 139 114 188 139 114
190 140 115 190 140 115 188 139 114 185 135 110 183 132 106 185 135 110 187 137
112 183 132 106 188 139 114 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 190 140 115 188 139 114 188 139 114 192 143 119 188 139 114 187
137 112 187 137 112 185 135 110 185 135 110 190 140 115 185 135 110 185 135 110
188 139 114 190 140 115 185 135 110 188 139 114 190 140 115 187 137 112 188 139
114 190 140 115 185 135 110 190 140 115 192 143 118 185 135 110 188 139 114 190
140 115 190 140 115 188 139 114 188 139 114 187 137 112 188 139 114 190 140 115
188 139 114 190 140 115 188 139 114 185 135 110 184 134 109 185 135 110 188 139
114 192 143 118 192 143 119 188 139 114 187 137 112 190 140 115 192 143 118 188
139 114 185 135 110 187 137 112 190 140 115 192 143 118 190 140 115 192 143 119
188 139 114 184 134 109 184 134 109 184 134 109 185 135 110 188 139 114 187 137
112 187 137 112 185 135 110 185 135 110 183 132 106 185 135 110 192 143 118 190
140 115 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112
188 139 114 188 139 114 185 135 110 185 135 110 185 135 110 193 144 120 192 143
119 173 118 092 181 129 104 196 149 125 173 118 092 174 119 093 192 143 119 188
139 114 185 135 110 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112
183 131 106 188 139 114 190 140 115 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 188
139 114 188 139 114 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112
187 137 112 188 139 114 187 137 112 187 137 112 188 139 114 188 139 114 187 137
112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 185 135 110 188 139 114 187 137 112 185 135 110 187 137 112 187
137 112 187 137 112 190 140 115 188 139 114 185 135 110 187 137 112 190 140 115
187 137 112 185 135 110 187 137 112 187 137 112 185 135 110 188 139 114 185 135
110 185 135 110 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 185
135 110 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 187 137 112 190 140 115 187 137 112 187 137
112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 188 139 114 190 140 115 190 140 115 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 190 140 115 190 140 115 187 137 112 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 190 140 115 185 135
110 200 154 131 193 146 122 187 137 112 183 132 106 183 132 106 193 144 120 190
140 115 185 135 110 187 137 112 187 137 112 187 137 112 192 143 118 184 134 109
152 100 074 183 132 106 200 154 131 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 187 137 112 187 137 112 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 193 144
120 183 131 106 190 140 115 188 139 114 192 143 118 193 144 120 183 131 106 183
131 106 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
192 143 118 193 146 122 181 129 104 192 143 118 190 140 115 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 188 139 114 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109
185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 185 135 110 188
139 114 190 140 115 187 137 112 188 139 114 185 135 110 185 135 110 188 139 114
188 139 114 188 139 114 188 139 114 185 135 110 192 143 119 185 135 110 190 140
115 190 140 115 185 135 110 188 139 114 187 137 112 190 140 115 187 137 112 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110
185 135 110 185 135 110 190 140 115 190 140 115 185 135 110 188 139 114 187 137
112 185 135 110 185 135 110 187 137 112 184 134 109 185 135 110 190 140 115 185
135 110 188 139 114 187 137 112 187 137 112 187 137 112 185 135 110 179 127 102
183 131 106 185 135 110 190 140 115 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 185 135 110 185 135 110 183 131 106 185 135 110 193
146 122 192 143 119 187 137 112 188 139 114 190 140 115 179 127 101 183 132 106
187 137 112 185 135 110 185 135 110 185 135 110 185 135 110 187 137 112 185 135
110 188 139 114 187 137 112 187 137 112 185 135 110 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
185 135 110 187 137 112 190 140 115 187 137 112 187 137 112 183 132 106 185 135
110 196 149 125 196 149 125 177 124 098 184 134 109 185 135 110 192 143 119 184
134 109 185 135 110 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112
185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 190 140 115 193 146 122 187 137 112 185 135 110 183
131 106 183 132 106 193 144 120 207 161 140 207 163 141 207 161 140 200 154 131
193 146 122 198 151 127 187 137 112 187 137 112 188 139 114 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 190 140 115 188 139
114 185 135 110 188 139 114 200 154 131 204 160 137 193 144 120 187 137 112 192
143 119 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 188 139 114 190 140 115 190 140 115 192 143 119 200
155 132 202 157 134 174 120 094 120 076 056 065 038 025 108 068 049 162 107 079
179 127 102 179 127 102 179 127 101 190 140 115 190 140 115 185 135 110 187 137
112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 184 134 109 190 140 115 185 135
110 187 137 112 200 155 132 183 132 106 179 127 101 193 146 122 190 140 115 184
134 109 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 183 132 106 177 124 098 199 152 129 212 168 148 192
143 118 126 080 059 037 019 011 062 035 024 115 073 054 117 074 054 134 086 064
165 108 081 170 115 089 176 122 097 190 140 115 190 140 115 187 137 112 185 135
110 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 192 143 119 179 127 102 193 144
120 196 149 125 151 098 074 099 061 044 168 112 085 193 146 122 185 135 110 185
135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 183 132 106 193 144 120 193 144 120 120 076 056 033
016 010 072 043 030 126 080 059 168 112 085 151 098 074 185 135 110 204 160 137
193 144 120 193 144 120 192 143 118 184 134 109 190 140 115 202 157 134 207 163
141 204 160 137 190 140 115 185 135 110 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 190 140
115 183 131 106 170 115 089 187 137 112 200 155 132 190 140 115 190 140 115 188
139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 192
143 118 188 139 114 192 143 118 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 187
137 112 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 187 137 112 190 140 115 190 140 115 104 066 047 046
024 015 138 089 065 161 106 079 087 053 037 114 072 052 202 157 134 193 144 120
179 127 102 188 139 114 187 137 112 198 151 127 190 140 115 138 089 065 130 083
061 134 086 064 190 140 115 192 143 119 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135
110 188 139 114 198 151 127 198 151 127 188 139 114 185 135 110 188 139 114 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 185
135 110 190 140 115 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 192 143 118 185
135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 190 140 115 200 154 131 146 095 071 087 053 037 098
061 044 181 129 104 174 120 094 115 073 054 193 146 122 204 160 137 174 119 093
202 157 134 185 135 110 185 135 110 185 135 110 192 143 118 144 093 069 085 051
036 102 063 046 183 131 106 198 151 127 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 184 134 109 188
139 114 188 139 114 187 137 112 190 140 115 184 134 109 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 183 132 106 179 127 101 193
144 120 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 196 149 125 190 140 115 074 043 030 064 036 024 146
095 071 162 107 079 170 115 089 168 112 085 143 092 069 198 151 127 204 160 137
184 134 109 190 140 115 187 137 112 177 124 098 185 135 110 204 160 137 212 168
148 209 166 144 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 193
144 120 204 160 137 190 140 115 190 140 115 196 149 125 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 192 143 118 179 127 101 174 119 093 198
151 127 185 135 110 192 143 119 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 184 134 109 204 160 137 174 120 094 087 053 037 091 056 039 125
079 058 155 101 076 153 100 074 168 112 085 126 080 059 144 093 069 202 157 134
200 155 132 185 135 110 183 131 106 192 143 118 193 144 120 183 132 106 177 124
098 179 127 102 192 143 118 192 143 119 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 181 129 104 190
140 115 185 135 110 053 029 019 120 076 056 204 160 137 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 185 135 110 192
143 119 181 129 104 183 132 106 185 135 110 190 140 115 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 185 135 110 202 158 135 168 112 085 068 041 028 115 073 054 135
086 064 162 107 079 174 120 094 152 100 074 162 107 079 155 101 076 152 100 074
173 118 092 198 151 127 192 143 118 193 146 122 185 135 110 183 132 106 198 151
127 192 143 118 183 132 106 183 132 106 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183 131 106 193
144 120 192 143 119 153 100 074 192 143 118 193 144 120 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 192 143 118 192
143 118 188 139 114 188 139 114 190 140 115 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 183 131 106 192
143 118 204 160 137 193 146 122 190 140 115 184 134 109 185 135 110 190 140 115
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 193 146 122 190 140 115 144 093 069 115 073 054 140
090 067 115 073 054 176 122 097 148 096 071 151 098 074 190 140 115 134 086 064
129 083 061 204 160 137 190 140 115 185 135 110 185 135 110 188 139 114 187 137
112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 184 134 109 184 134 109 187 137 112 190 140
115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 192 143 118 202 158 135 196 149 125 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 185 135 110 193
144 120 185 135 110 192 143 118 193 144 120 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 207 161 140 187
137 112 176 122 097 200 155 132 200 154 131 183 132 106 185 135 110 196 149 125
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 198 151 127 155 101 076 104 066 047 111 070 051 111
070 051 125 079 058 179 127 101 157 102 076 173 118 092 144 093 069 198 151 127
200 155 132 183 131 106 162 107 079 193 146 122 193 146 122 185 135 110 187 137
112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 184 134 109 185 135 110 187 137 112 190 140
115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 179 127 101 179
127 101 185 135 110 181 129 104 183 131 106 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 196 149 125 176 122 097 104
066 047 140 090 067 151 098 074 161 106 079 204 160 137 193 144 120 179 127 102
185 135 110 187 137 112 190 140 115 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 202 158 135 170 115 089 078 047 032 099
061 044 138 089 065 174 120 094 151 098 074 161 106 079 135 086 064 144 093 069
185 135 110 200 155 132 184 134 109 188 139 114 187 137 112 188 139 114 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 185 135 110 187 137 112 193 144 120 190
140 115 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 200 154 131 148 096 071 080
048 033 144 093 069 114 072 052 091 056 039 190 140 115 200 155 132 179 127 101
184 134 109 190 140 115 185 135 110 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 185 135 110 200 155 132 209 166 144 169 113 087 102
065 046 121 077 057 173 118 092 153 100 074 144 093 069 174 120 094 130 083 061
111 070 051 209 166 144 204 160 137 179 127 101 184 134 109 190 140 115 185 135
110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 187 137 112 183 132 106 200 154 131 199 152 129 202
158 135 193 146 122 187 137 112 193 144 120 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 207 163 141 181
129 104 087 053 037 111 070 051 111 070 051 140 090 067 193 144 120 193 144 120
185 135 110 185 135 110 190 140 115 187 137 112 190 140 115 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 187 137 112 193 144 120 174 120 094 177 124 098 115
073 054 108 068 049 169 113 087 151 098 074 140 090 067 155 101 076 183 131 106
161 106 079 143 092 069 184 134 109 187 137 112 187 137 112 185 135 110 185 135
110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135
110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139
114 188 139 114 187 137 112 185 135 110 199 152 129 181 129 104 125 079 058 155
101 076 200 155 132 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 193 144 120 193
146 122 202 157 134 174 120 094 104 066 047 082 050 035 111 070 051 200 155 132
202 157 134 187 137 112 184 134 109 185 135 110 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 183 132 106 193 146 122 169 113 087 136 087 064 120
076 056 099 061 044 151 098 074 166 109 082 152 100 074 117 074 054 155 101 076
185 135 110 078 047 032 155 101 076 207 163 141 183 132 106 184 134 109 193 146
122 193 144 120 181 129 104 184 134 109 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192 143
118 185 135 110 184 134 109 196 149 125 200 154 131 117 074 054 129 083 061 093
057 041 146 095 071 200 155 132 179 127 101 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 184 134 109 185
135 110 196 149 125 200 155 132 199 152 129 148 096 071 106 067 048 102 065 046
190 140 115 202 157 134 193 144 120 185 135 110 183 131 106 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 185 135 110 188 139 114 192 143 118 162 107 079 115
073 054 099 061 044 170 115 089 170 115 089 169 113 087 168 112 085 144 093 069
162 107 079 185 135 110 165 108 081 170 115 089 192 143 119 179 127 102 192 143
118 181 129 104 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139
114 179 127 101 183 131 106 199 152 129 173 118 092 115 073 054 144 093 069 136
087 064 115 073 054 198 151 127 192 143 119 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188
139 114 185 135 110 185 135 110 209 166 144 168 112 085 078 047 032 089 054 039
144 093 069 146 095 071 185 135 110 199 152 129 192 143 118 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 193 144 120 185 135 110 168 112 085 151
098 074 104 066 047 168 112 085 170 115 089 168 112 085 170 115 089 169 113 087
152 100 074 176 122 097 134 086 064 126 080 059 204 160 137 199 152 129 193 144
120 192 143 119 184 134 109 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183 131
106 184 134 109 199 152 129 193 144 120 181 129 104 179 127 102 202 158 135 184
134 109 126 080 059 193 146 122 196 149 125 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 187
137 112 187 137 112 185 135 110 185 135 110 198 151 127 183 131 106 212 170 149
196 149 125 111 070 051 123 079 058 198 151 127 202 157 134 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 190 140 115 192 143 119 170 115 089 162
107 079 104 066 047 134 086 064 176 122 097 168 112 085 151 098 074 170 115 089
181 129 104 168 112 085 174 120 094 155 101 076 165 108 081 184 134 109 183 131
106 192 143 119 198 151 127 188 139 114 185 135 110 188 139 114 190 140 115 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 190 140 115 188 139 114 187 137 112 185 135 110 187 137 112 190 140
115 185 135 110 188 139 114 188 139 114 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 185 135 110
185 135 110 190 140 115 188 139 114 185 135 110 185 135 110 187 137 112 198 151
127 200 155 132 199 152 129 179 127 102 200 155 132 200 155 132 179 127 101 200
155 132 193 144 120 202 157 134 192 143 119 183 131 106 188 139 114 187 137 112
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 192 143 118 183 132 106 202 158 135 199 152 129
115 073 054 162 107 079 111 070 051 138 089 065 193 144 120 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 188 139 114 190 140 115 199 152 129 138 089 065 170
115 089 136 087 064 123 079 058 166 110 083 155 101 076 173 118 092 157 102 076
166 110 083 162 107 079 179 127 101 165 108 081 114 072 052 138 089 065 135 086
064 138 089 065 169 113 087 202 158 135 190 140 115 185 135 110 185 135 110 181
129 104 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115 190 140
115 190 140 115 190 140 115 190 140 115 188 139 114 187 137 112 185 135 110 188
139 114 187 137 112 187 137 112 188 139 114 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 190 140 115
188 139 114 185 135 110 190 140 115 185 135 110 190 140 115 185 135 110 183 131
106 190 140 115 185 135 110 185 135 110 184 134 109 185 135 110 188 139 114 187
137 112 187 137 112 187 137 112 185 135 110 187 137 112 188 139 114 188 139 114
187 137 112 185 135 110 185 135 110 192 143 119 185 135 110 190 140 115 179 127
102 153 100 074 151 098 074 138 089 065 143 092 069 148 096 071 082 050 035 170
115 089 198 151 127 185 135 110 200 154 131 185 135 110 187 137 112 188 139 114
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 196 149 125 179 127 101 176 122 097 198 151 127
166 110 083 174 120 094 169 113 087 082 050 035 134 086 064 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 185 135 110 185 135 110 207 161 140 120 076 056 148
096 071 146 095 071 090 054 039 123 079 058 162 107 079 170 115 089 166 109 082
169 113 087 168 112 085 166 109 082 174 119 093 174 120 094 179 127 101 174 120
094 162 107 079 134 086 064 179 127 101 193 146 122 184 134 109 185 135 110 187
137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 184 134 109 185 135
110 187 137 112 187 137 112 192 143 118 193 144 120 188 139 114 183 132 106 185
135 110 192 143 118 190 140 115 188 139 114 192 143 118 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 183 131 106 183 132 106 192 143 118
193 144 120 185 135 110 179 127 102 188 139 114 190 140 115 187 137 112 190 140
115 192 143 118 185 135 110 187 137 112 188 139 114 193 144 120 187 137 112 187
137 112 187 137 112 190 140 115 184 134 109 181 129 104 190 140 115 193 144 120
193 144 120 179 127 102 190 140 115 199 152 129 196 149 125 187 137 112 138 089
065 157 102 076 165 108 081 170 115 089 138 089 065 152 100 074 155 101 076 111
070 051 096 059 042 106 067 048 190 140 115 200 155 132 181 129 104 192 143 119
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 192 143 118 184 134 109 170 115 089 204 160 137
166 109 082 077 047 032 188 139 114 190 140 115 155 101 076 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 193 146 122 179 127 101 190 140 115 192 143 118 153
100 074 161 106 079 059 034 023 130 083 061 148 096 071 161 106 079 169 113 087
169 113 087 168 112 085 169 113 087 174 120 094 162 107 079 173 118 092 161 106
079 168 112 085 162 107 079 161 106 079 200 155 132 200 155 132 192 143 119 196
149 125 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 184 134 109 183 132 106 188 139 114 193 144
120 184 134 109 183 131 106 184 134 109 185 135 110 185 135 110 184 134 109 184
134 109 183 132 106 190 140 115 192 143 118 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 192 143 118 183 132 106 183 131 106
190 140 115 196 149 125 193 146 122 200 155 132 198 151 127 185 135 110 185 135
110 185 135 110 190 140 115 193 146 122 190 140 115 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 188 139 114 181 129 104 190 140 115
185 135 110 202 158 135 190 140 115 166 109 082 200 155 132 173 118 092 144 093
069 181 129 104 165 108 081 170 115 089 174 120 094 179 127 101 179 127 101 144
093 069 138 089 065 115 073 054 166 110 083 198 151 127 184 134 109 192 143 118
183 131 106 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 184 134 109 193 144 120 209 167 145 179 127 101
078 047 032 151 098 074 200 154 131 207 161 140 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 193 144 120 185 135 110 173 118 092 202 158 135 162
107 079 162 107 079 111 070 051 136 087 064 153 100 074 153 100 074 174 120 094
169 113 087 168 112 085 168 112 085 168 112 085 166 109 082 170 115 089 174 120
094 176 122 097 157 102 076 188 139 114 183 131 106 179 127 101 200 154 131 187
137 112 183 132 106 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 190 140 115 204 160 137 209 166 144 198 151
127 199 152 129 202 158 135 202 157 134 199 152 129 198 151 127 198 151 127 188
139 114 184 134 109 185 135 110 190 140 115 192 143 119 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 193 144 120 177 124 098 183 131 106
196 149 125 193 144 120 174 120 094 168 112 085 183 131 106 198 151 127 198 151
127 193 144 120 200 154 131 198 151 127 179 127 101 173 118 092 192 143 118 187
137 112 188 139 114 185 135 110 192 143 119 192 143 119 174 120 094 190 140 115
190 140 115 196 149 125 162 107 079 114 072 052 144 093 069 138 089 065 168 112
085 170 115 089 170 115 089 168 112 085 168 112 085 174 120 094 179 127 102 170
115 089 174 119 093 155 101 076 126 080 059 190 140 115 200 154 131 184 134 109
187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 202 158 135 196 149 125 065 038 025
162 107 079 209 166 144 192 143 119 188 139 114 188 139 114 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 183 132 106 190 140 115 179 127 101 200 154 131 187
137 112 140 090 067 134 086 064 077 047 032 179 127 102 166 109 082 168 112 085
170 115 089 168 112 085 166 110 083 170 115 089 168 112 085 168 112 085 179 127
101 135 086 064 152 100 074 177 124 098 136 087 064 125 079 058 177 124 098 202
157 134 192 143 118 183 131 106 187 137 112 188 139 114 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 185 135 110 185 135 110 204 160 137 174 119 093 121 077 057 148 096
071 162 107 079 174 119 093 165 108 081 144 093 069 170 115 089 198 151 127 200
155 132 196 149 125 183 132 106 183 131 106 187 137 112 187 137 112 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 193 144 120 174 120 094 193 146 122
192 143 119 144 093 069 136 087 064 138 089 065 138 089 065 166 109 082 184 134
109 181 129 104 174 120 094 179 127 101 200 155 132 198 151 127 181 129 104 184
134 109 185 135 110 183 132 106 193 146 122 188 139 114 170 115 089 199 152 129
198 151 127 123 079 058 151 098 074 162 107 079 135 086 064 173 118 092 174 119
093 168 112 085 170 115 089 162 107 079 170 115 089 168 112 085 162 107 079 170
115 089 170 115 089 166 110 083 111 070 051 170 115 089 202 157 134 184 134 109
192 143 118 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 192 143 119 196 149 125 166 110 083 173 118 092
202 158 135 185 135 110 187 137 112 187 137 112 183 131 106 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 184 134 109 184 134 109 190 140 115 193 144 120 202
157 134 143 092 069 138 089 065 050 027 018 170 115 089 185 135 110 151 098 074
151 098 074 169 113 087 168 112 085 173 118 092 168 112 085 170 115 089 170 115
089 125 079 058 162 107 079 174 119 093 168 112 085 169 113 087 111 070 051 170
115 089 207 163 141 187 137 112 185 135 110 185 135 110 193 144 120 188 139 114
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
192 143 119 188 139 114 193 144 120 188 139 114 135 086 064 093 057 041 117 074
054 126 080 059 134 086 064 121 077 057 114 072 052 121 077 057 123 079 058 138
089 065 192 143 119 204 160 137 179 127 101 190 140 115 192 143 118 188 139 114
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 190 140 115 188 139 114 179 127 102 196 149 125
190 140 115 148 096 071 174 120 094 177 124 098 170 115 089 151 098 074 129 083
061 138 089 065 126 080 059 136 087 064 174 120 094 193 146 122 200 155 132 202
157 134 200 154 131 192 143 119 187 137 112 188 139 114 200 154 131 202 158 135
155 101 076 152 100 074 174 120 094 121 077 057 162 107 079 170 115 089 168 112
085 162 107 079 170 115 089 168 112 085 174 120 094 162 107 079 161 106 079 166
110 083 170 115 089 170 115 089 144 093 069 143 092 069 200 155 132 196 149 125
183 131 106 188 139 114 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 183 131 106 183 132 106 190 140 115 209 166 144
188 139 114 188 139 114 185 135 110 184 134 109 188 139 114 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 184 134 109 193 144 120 193 144 120 200
155 132 161 106 079 090 054 039 074 043 030 125 079 058 190 140 115 177 124 098
144 093 069 121 077 057 173 118 092 168 112 085 166 109 082 170 115 089 169 113
087 166 110 083 168 112 085 153 100 074 162 107 079 168 112 085 146 095 071 111
070 051 173 118 092 202 157 134 199 152 129 179 127 102 185 135 110 190 140 115
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114
190 140 115 187 137 112 190 140 115 199 152 129 143 092 069 121 077 057 174 120
094 144 093 069 165 108 081 168 112 085 153 100 074 155 101 076 136 087 064 099
061 044 126 080 059 192 143 119 207 163 141 183 131 106 190 140 115 190 140 115
188 139 114 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 187 137 112 192 143 118 183 132 106
198 151 127 185 135 110 153 100 074 170 115 089 170 115 089 170 115 089 176 122
097 176 122 097 169 113 087 168 112 085 146 095 071 161 106 079 170 115 089 165
108 081 173 118 092 193 146 122 198 151 127 183 132 106 187 137 112 151 098 074
148 096 071 170 115 089 179 127 102 146 095 071 155 101 076 176 122 097 166 109
082 166 109 082 169 113 087 170 115 089 170 115 089 173 118 092 168 112 085 168
112 085 174 119 093 166 109 082 170 115 089 126 080 059 155 101 076 198 151 127
184 134 109 192 143 119 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 188 139 114 188 139 114 183 131 106
185 135 110 188 139 114 187 137 112 190 140 115 188 139 114 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 193 146 122 198
151 127 170 115 089 093 057 041 093 057 041 138 089 065 134 086 064 169 113 087
169 113 087 111 070 051 166 110 083 174 119 093 170 115 089 166 110 083 179 127
102 155 101 076 161 106 079 183 131 106 138 089 065 138 089 065 174 120 094 168
112 085 090 054 039 177 124 098 202 158 135 187 137 112 185 135 110 185 135 110
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 184 134 109 196 149 125 188 139 114
179 127 101 190 140 115 198 151 127 185 135 110 136 087 064 089 054 039 170 115
089 176 122 097 155 101 076 166 110 083 162 107 079 157 102 076 166 110 083 165
108 081 111 070 051 102 063 046 204 160 137 198 151 127 181 129 104 185 135 110
190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 184 134 109 187 137 112 193 144 120
188 139 114 165 108 081 168 112 085 168 112 085 169 113 087 166 110 083 166 110
083 174 120 094 165 108 081 155 101 076 170 115 089 170 115 089 134 086 064 144
093 069 144 093 069 140 090 067 162 107 079 165 108 081 126 080 059 148 096 071
179 127 101 174 119 093 166 109 082 177 124 098 165 108 081 157 102 076 183 131
106 170 115 089 162 107 079 166 110 083 170 115 089 170 115 089 166 110 083 170
115 089 170 115 089 168 112 085 168 112 085 135 086 064 114 072 052 170 115 089
198 151 127 192 143 119 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 185 135 110 187 137 112 190 140 115 193 144 120 196
149 125 170 115 089 121 077 057 051 027 018 151 098 074 166 110 083 155 101 076
184 134 109 173 118 092 151 098 074 174 120 094 170 115 089 168 112 085 170 115
089 170 115 089 115 073 054 135 086 064 155 101 076 176 122 097 174 119 093 179
127 101 134 086 064 098 061 044 200 154 131 198 151 127 185 135 110 185 135 110
190 140 115 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 184 134 109 200 154 131 188 139 114
174 119 093 193 144 120 198 151 127 151 098 074 134 086 064 138 089 065 183 131
106 169 113 087 173 118 092 177 124 098 174 120 094 166 110 083 179 127 101 126
080 059 111 070 051 111 070 051 089 054 039 200 155 132 202 157 134 183 132 106
184 134 109 192 143 118 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 183 132 106 188 139 114 199 152 129
179 127 102 148 096 071 169 113 087 165 108 081 170 115 089 170 115 089 170 115
089 174 119 093 169 113 087 162 107 079 155 101 076 161 106 079 179 127 102 173
118 092 168 112 085 162 107 079 155 101 076 166 109 082 170 115 089 169 113 087
166 109 082 170 115 089 168 112 085 170 115 089 170 115 089 138 089 065 170 115
089 174 120 094 169 113 087 168 112 085 169 113 087 170 115 089 170 115 089 170
115 089 170 115 089 169 113 087 170 115 089 161 106 079 104 066 047 162 107 079
199 152 129 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 184 134 109 192 143 118 190 140 115 200
155 132 168 112 085 126 080 059 069 041 028 111 070 051 123 079 058 151 098 074
157 102 076 176 122 097 170 115 089 168 112 085 166 109 082 169 113 087 166 110
083 179 127 101 162 107 079 135 086 064 177 124 098 173 118 092 151 098 074 151
098 074 157 102 076 115 073 054 144 093 069 209 166 144 183 131 106 190 140 115
187 137 112 185 135 110 184 134 109 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 192 143 118 181 129 104
179 127 101 207 163 141 179 127 102 130 083 061 165 108 081 179 127 102 174 120
094 168 112 085 155 101 076 155 101 076 168 112 085 169 113 087 169 113 087 151
098 074 106 067 048 117 074 054 121 077 057 134 086 064 200 154 131 183 131 106
190 140 115 188 139 114 193 144 120 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 185 135 110 187 137 112 190 140 115 188 139 114 187
137 112 188 139 114 184 134 109 187 137 112 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 183 131 106 190 140 115 200 154 131
173 118 092 144 093 069 170 115 089 168 112 085 168 112 085 169 113 087 168 112
085 166 110 083 170 115 089 169 113 087 170 115 089 166 110 083 174 120 094 169
113 087 170 115 089 174 119 093 168 112 085 170 115 089 174 120 094 166 110 083
170 115 089 168 112 085 168 112 085 170 115 089 179 127 101 170 115 089 166 110
083 174 119 093 170 115 089 170 115 089 168 112 085 169 113 087 169 113 087 169
113 087 169 113 087 168 112 085 173 118 092 183 131 106 135 086 064 162 107 079
200 155 132 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 184 134 109 192 143 119 185 135 110 199
152 129 173 118 092 162 107 079 134 086 064 068 041 028 125 079 058 151 098 074
104 066 047 174 120 094 174 120 094 168 112 085 170 115 089 166 110 083 169 113
087 173 118 092 190 140 115 168 112 085 138 089 065 169 113 087 177 124 098 174
119 093 170 115 089 179 127 101 098 061 044 153 100 074 202 158 135 185 135 110
188 139 114 192 143 119 193 144 120 192 143 118 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183 131 106
198 151 127 192 143 118 129 083 061 104 066 047 157 102 076 136 087 064 153 100
074 174 120 094 170 115 089 151 098 074 165 108 081 168 112 085 174 119 093 179
127 101 143 092 069 130 083 061 166 110 083 121 077 057 165 108 081 193 146 122
183 131 106 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 193 144 120 188 139 114 183 131 106 185 135 110 188
139 114 185 135 110 193 144 120 190 140 115 184 134 109 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 190 140 115 185 135 110 185 135 110 198 151 127 193 144 120
155 101 076 168 112 085 174 120 094 170 115 089 168 112 085 168 112 085 169 113
087 170 115 089 170 115 089 170 115 089 174 119 093 168 112 085 165 108 081 169
113 087 168 112 085 162 107 079 168 112 085 176 122 097 157 102 076 161 106 079
174 120 094 173 118 092 170 115 089 166 109 082 166 109 082 173 118 092 169 113
087 170 115 089 170 115 089 168 112 085 173 118 092 169 113 087 169 113 087 169
113 087 168 112 085 170 115 089 166 109 082 174 119 093 162 107 079 162 107 079
196 149 125 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 193
146 122 183 132 106 151 098 074 151 098 074 093 057 041 074 043 030 108 068 049
134 086 064 187 137 112 166 109 082 162 107 079 169 113 087 166 109 082 170 115
089 165 108 081 144 093 069 152 100 074 138 089 065 121 077 057 166 110 083 162
107 079 157 102 076 170 115 089 143 092 069 114 072 052 202 158 135 190 140 115
187 137 112 192 143 118 192 143 119 192 143 118 188 139 114 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 185 135 110
202 158 135 136 087 064 123 079 058 153 100 074 179 127 101 148 096 071 168 112
085 173 118 092 168 112 085 179 127 102 162 107 079 169 113 087 166 110 083 166
110 083 183 131 106 174 120 094 144 093 069 126 080 059 134 086 064 200 155 132
185 135 110 187 137 112 188 139 114 184 134 109 188 139 114 187 137 112 190 140
115 187 137 112 179 127 102 193 146 122 188 139 114 183 132 106 185 135 110 183
131 106 193 144 120 196 149 125 181 129 104 179 127 102 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 185 135 110 192 143 118 198 151 127 170 115 089
143 092 069 179 127 101 168 112 085 170 115 089 173 118 092 170 115 089 170 115
089 169 113 087 168 112 085 169 113 087 168 112 085 169 113 087 168 112 085 168
112 085 170 115 089 169 113 087 169 113 087 166 109 082 168 112 085 168 112 085
162 107 079 166 109 082 168 112 085 168 112 085 168 112 085 165 108 081 168 112
085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 166 110 083 166 110 083 174 119 093 170 115 089 143 092 069 144 093 069
198 151 127 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 185 135 110 190
140 115 193 144 120 136 087 064 170 115 089 126 080 059 125 079 058 104 066 047
091 056 039 168 112 085 174 120 094 169 113 087 165 108 081 166 110 083 174 119
093 153 100 074 144 093 069 173 118 092 166 110 083 136 087 064 136 087 064 166
110 083 162 107 079 168 112 085 144 093 069 144 093 069 202 158 135 200 154 131
177 124 098 174 119 093 179 127 102 181 129 104 187 137 112 190 140 115 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 198 151 127
179 127 101 151 098 074 168 112 085 143 092 069 173 118 092 169 113 087 135 086
064 144 093 069 138 089 065 173 118 092 168 112 085 177 124 098 170 115 089 162
107 079 166 109 082 188 139 114 144 093 069 085 051 036 104 066 047 188 139 114
202 158 135 193 144 120 185 135 110 188 139 114 187 137 112 187 137 112 188 139
114 185 135 110 184 134 109 204 160 137 192 143 119 198 151 127 209 167 145 192
143 118 190 140 115 181 129 104 188 139 114 193 146 122 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 185 135 110 192 143 118 199 152 129 115 073 054
144 093 069 183 131 106 168 112 085 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 169 113 087 169 113 087 162 107 079 162 107 079 165 108 081 166 109 082
170 115 089 169 113 087 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168 112 085 168
112 085 166 110 083 162 107 079 179 127 101 179 127 101 125 079 058 174 120 094
200 154 131 179 127 101 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 193 144 120 165 108 081 170 115 089 093 057 041 144 093 069 121 077 057
082 050 035 153 100 074 174 119 093 168 112 085 170 115 089 179 127 101 173 118
092 148 096 071 144 093 069 174 120 094 183 131 106 144 093 069 151 098 074 170
115 089 166 109 082 179 127 102 162 107 079 102 063 046 185 135 110 204 160 137
200 155 132 190 140 115 179 127 101 188 139 114 190 140 115 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 131 106 202 157 134
168 112 085 155 101 076 174 120 094 120 076 056 170 115 089 170 115 089 111 070
051 174 120 094 174 119 093 125 079 058 155 101 076 130 083 061 168 112 085 174
119 093 166 109 082 177 124 098 120 076 056 117 074 054 143 092 069 169 113 087
174 120 094 204 160 137 185 135 110 183 132 106 188 139 114 187 137 112 188 139
114 185 135 110 188 139 114 192 143 119 162 107 079 138 089 065 170 115 089 192
143 118 193 144 120 183 131 106 185 135 110 192 143 118 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 185 135 110 185 135 110 200 155 132 151 098 074
146 095 071 183 131 106 168 112 085 168 112 085 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 169 113 087 166 110 083 168 112 085 170 115 089 168 112 085 170 115 089
169 113 087 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 168 112
085 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 168 112 085 168
112 085 166 109 082 166 110 083 169 113 087 165 108 081 099 061 044 155 101 076
198 151 127 181 129 104 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 184
134 109 202 157 134 155 101 076 143 092 069 135 086 064 135 086 064 136 087 064
065 038 025 143 092 069 174 119 093 170 115 089 174 120 094 144 093 069 138 089
065 151 098 074 173 118 092 173 118 092 162 107 079 140 090 067 173 118 092 179
127 101 151 098 074 168 112 085 166 109 082 129 083 061 111 070 051 155 101 076
193 146 122 200 155 132 199 152 129 207 163 141 192 143 118 183 131 106 188 139
114 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 200 154 131
162 107 079 168 112 085 162 107 079 166 109 082 179 127 101 151 098 074 153 100
074 170 115 089 170 115 089 170 115 089 179 127 102 166 110 083 134 086 064 169
113 087 170 115 089 134 086 064 140 090 067 170 115 089 165 108 081 173 118 092
134 086 064 161 106 079 198 151 127 185 135 110 188 139 114 187 137 112 187 137
112 190 140 115 192 143 118 162 107 079 151 098 074 146 095 071 102 065 046 129
083 061 213 171 150 185 135 110 179 127 101 198 151 127 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 192 143 119 190 140 115 165 108 081
168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170 115
089 168 112 085 169 113 087 170 115 089 168 112 085 168 112 085 169 113 087 170
115 089 170 115 089 169 113 087 168 112 085 168 112 085 166 110 083 162 107 079
166 109 082 166 109 082 165 108 081 166 110 083 168 112 085 168 112 085 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 168
112 085 166 109 082 174 119 093 169 113 087 152 100 074 166 110 083 187 137 112
198 151 127 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 190 140 115 184 134 109 188 139 114 188
139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 185 135 110 185 135 110 190 140 115 192 143 118 187 137 112 187 137 112 187
137 112 185 135 110 185 135 110 185 135 110 187 137 112 187 137 112 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 199 152 129 151 098 074 151 098 074 174 119 093 102 065 046 165 108 081
123 079 058 104 066 047 202 157 134 173 118 092 134 086 064 151 098 074 170 115
089 173 118 092 181 129 104 170 115 089 136 087 064 162 107 079 174 119 093 173
118 092 166 109 082 166 109 082 174 119 093 170 115 089 168 112 085 135 086 064
115 073 054 152 100 074 192 143 118 176 122 097 192 143 118 198 151 127 185 135
110 185 135 110 193 144 120 190 140 115 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 185 135 110 185 135 110 188 139 114 188 139 114 183 131 106 200 155 132
173 118 092 168 112 085 144 093 069 155 101 076 173 118 092 151 098 074 170 115
089 179 127 102 153 100 074 176 122 097 166 110 083 176 122 097 155 101 076 125
079 058 179 127 102 174 120 094 161 106 079 146 095 071 157 102 076 181 129 104
162 107 079 138 089 065 198 151 127 188 139 114 185 135 110 188 139 114 185 135
110 188 139 114 200 155 132 166 109 082 157 102 076 176 122 097 140 090 067 138
089 065 198 151 127 193 146 122 183 131 106 185 135 110 188 139 114 190 140 115
185 135 110 188 139 114 188 139 114 187 137 112 190 140 115 187 137 112 190 140
115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 196 149 125 166 110 083
166 110 083 170 115 089 170 115 089 166 109 082 166 109 082 166 110 083 169 113
087 170 115 089 168 112 085 166 110 083 170 115 089 170 115 089 168 112 085 169
113 087 170 115 089 170 115 089 170 115 089 168 112 085 162 107 079 166 110 083
162 107 079 162 107 079 168 112 085 168 112 085 168 112 085 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 170 115 089 168 112 085 168 112 085 169
113 087 169 113 087 170 115 089 136 087 064 173 118 092 204 160 137 193 146 122
193 144 120 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 190 140
115 185 135 110 185 135 110 184 134 109 183 131 106 202 157 134 198 151 127 187
137 112 185 135 110 184 134 109 190 140 115 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 187
137 112 185 135 110 185 135 110 185 135 110 187 137 112 190 140 115 183 132 106
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 185 135 110 187 137 112 187 137 112 185 135 110 185 135 110 188 139
114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 193 144 120 168 112 085 169 113 087 125 079 058 102 063 046 134 086 064
136 087 064 082 050 035 155 101 076 121 077 057 155 101 076 177 124 098 169 113
087 174 120 094 140 090 067 125 079 058 143 092 069 179 127 101 170 115 089 165
108 081 173 118 092 173 118 092 165 108 081 168 112 085 179 127 101 166 109 082
143 092 069 102 063 046 091 056 039 111 070 051 153 100 074 202 158 135 192 143
118 184 134 109 193 146 122 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 190 140 115 185 135 110 185 135 110 185 135 110 198 151 127
168 112 085 134 086 064 152 100 074 168 112 085 169 113 087 153 100 074 152 100
074 173 118 092 168 112 085 168 112 085 174 120 094 162 107 079 174 120 094 162
107 079 130 083 061 152 100 074 138 089 065 125 079 058 179 127 102 174 120 094
166 109 082 151 098 074 193 144 120 193 144 120 187 137 112 187 137 112 187 137
112 188 139 114 192 143 119 155 101 076 138 089 065 169 113 087 153 100 074 111
070 051 183 131 106 200 155 132 188 139 114 183 131 106 192 143 118 183 132 106
193 144 120 198 151 127 192 143 119 184 134 109 185 135 110 183 132 106 192 143
118 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 183 132 106 209 166 144 162 107 079
114 072 052 173 118 092 170 115 089 166 110 083 170 115 089 170 115 089 169 113
087 170 115 089 169 113 087 166 110 083 168 112 085 173 118 092 169 113 087 168
112 085 170 115 089 170 115 089 169 113 087 168 112 085 168 112 085 173 118 092
170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 169 113 087 170 115 089 165 108 081 174 119 093 179
127 101 179 127 101 121 077 057 135 086 064 198 151 127 188 139 114 187 137 112
187 137 112 183 132 106 190 140 115 187 137 112 187 137 112 188 139 114 184 134
109 190 140 115 184 134 109 183 131 106 207 161 140 174 120 094 130 083 061 193
144 120 190 140 115 192 143 118 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 192 143 118 185 135 110 174 120 094 184 134 109 185 135 110 187
137 112 187 137 112 190 140 115 192 143 118 184 134 109 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 188 139 114 187 137 112 188 139 114 183 131 106 185 135 110 185 135
110 185 135 110 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 200 155 132 179 127 101 161 106 079 089 054 039 155 101 076 168 112 085
111 070 051 089 054 039 129 083 061 144 093 069 181 129 104 170 115 089 170 115
089 168 112 085 130 083 061 166 109 082 174 120 094 168 112 085 166 110 083 170
115 089 169 113 087 168 112 085 170 115 089 170 115 089 165 108 081 157 102 076
168 112 085 168 112 085 148 096 071 138 089 065 102 063 046 181 129 104 202 158
135 192 143 118 179 127 102 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 192 143 118 192 143 118 185 135 110 185 135 110 202 157 134 161 106 079
144 093 069 170 115 089 157 102 076 176 122 097 176 122 097 170 115 089 151 098
074 168 112 085 173 118 092 157 102 076 166 109 082 170 115 089 183 131 106 170
115 089 120 076 056 151 098 074 168 112 085 168 112 085 153 100 074 166 109 082
155 101 076 176 122 097 187 137 112 188 139 114 188 139 114 187 137 112 187 137
112 190 140 115 185 135 110 162 107 079 155 101 076 168 112 085 155 101 076 102
065 046 177 124 098 202 158 135 179 127 102 179 127 101 188 139 114 187 137 112
183 131 106 152 100 074 183 132 106 198 151 127 192 143 118 187 137 112 187 137
112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 183 131 106 198 151 127 183 132 106
170 115 089 169 113 087 143 092 069 153 100 074 168 112 085 170 115 089 170 115
089 168 112 085 170 115 089 170 115 089 165 108 081 161 106 079 170 115 089 170
115 089 168 112 085 168 112 085 173 118 092 170 115 089 170 115 089 170 115 089
170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 169 113 087 168 112 085 161 106 079 170 115 089 185
135 110 134 086 064 153 100 074 204 160 137 193 144 120 190 140 115 188 139 114
184 134 109 185 135 110 190 140 115 187 137 112 187 137 112 188 139 114 185 135
110 188 139 114 190 140 115 193 144 120 168 112 085 115 073 054 152 100 074 161
106 079 192 143 118 193 146 122 187 137 112 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 183 131 106 187 137 112 190 140 115 183 131 106 183 132 106 185 135 110 187
137 112 187 137 112 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 184 134 109 188 139 114 187 137 112 188 139 114 185 135 110 185 135
110 185 135 110 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 198 151 127 181 129 104 168 112 085 104 066 047 170 115 089 170 115 089
111 070 051 096 059 042 162 107 079 155 101 076 144 093 069 173 118 092 176 122
097 140 090 067 151 098 074 179 127 101 170 115 089 165 108 081 166 109 082 170
115 089 169 113 087 169 113 087 170 115 089 170 115 089 165 108 081 165 108 081
170 115 089 179 127 101 162 107 079 168 112 085 111 070 051 111 070 051 190 140
115 190 140 115 183 131 106 185 135 110 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 188 139 114 185 135 110 185 135 110 198 151 127 193 144 120 138 089 065
121 077 057 177 124 098 169 113 087 155 101 076 166 109 082 179 127 101 161 106
079 162 107 079 170 115 089 170 115 089 168 112 085 174 120 094 155 101 076 130
083 061 176 122 097 165 108 081 151 098 074 166 109 082 120 076 056 143 092 069
155 101 076 198 151 127 202 158 135 181 129 104 187 137 112 188 139 114 187 137
112 185 135 110 196 149 125 190 140 115 153 100 074 177 124 098 170 115 089 099
061 044 115 073 054 209 166 144 193 144 120 185 135 110 184 134 109 192 143 119
187 137 112 174 119 093 187 137 112 168 112 085 185 135 110 190 140 115 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 179 127 102 193 146 122
202 158 135 192 143 118 166 109 082 165 108 081 155 101 076 157 102 076 165 108
081 168 112 085 170 115 089 173 118 092 168 112 085 162 107 079 170 115 089 170
115 089 168 112 085 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 169 113 087 166 110 083 168 112 085 161 106 079 129
083 061 129 083 061 181 129 104 202 157 134 192 143 118 193 144 120 193 144 120
183 132 106 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 192 143
118 183 131 106 199 152 129 185 135 110 125 079 058 190 140 115 209 166 144 179
127 101 192 143 118 183 132 106 187 137 112 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 080 048 033 080 048
033 185 135 110 185 135 110 187 137 112 185 135 110 185 135 110 188 139 114 188
139 114 190 140 115 181 129 104 176 122 097 193 144 120 185 135 110 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 192 143 118 188 139 114 187 137 112 188 139 114
185 135 110 185 135 110 187 137 112 187 137 112 185 135 110 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 185 135 110 184 134 109 192 143 118 188 139 114 181
129 104 193 146 122 198 151 127 140 090 067 130 083 061 185 135 110 114 072 052
134 086 064 121 077 057 134 086 064 183 131 106 136 087 064 138 089 065 162 107
079 134 086 064 134 086 064 181 129 104 166 110 083 155 101 076 168 112 085 169
113 087 166 110 083 166 110 083 173 118 092 170 115 089 174 120 094 166 109 082
162 107 079 179 127 102 143 092 069 157 102 076 174 120 094 126 080 059 176 122
097 200 154 131 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 185 135 110 188 139 114 185 135 110 192 143 118 146 095 071 144 093 069
162 107 079 166 110 083 174 119 093 169 113 087 166 110 083 179 127 101 161 106
079 166 109 082 183 132 106 174 120 094 187 137 112 161 106 079 146 095 071 181
129 104 174 120 094 168 112 085 168 112 085 165 108 081 114 072 052 134 086 064
174 120 094 144 093 069 185 135 110 200 155 132 184 134 109 184 134 109 187 137
112 185 135 110 190 140 115 200 155 132 144 093 069 151 098 074 179 127 101 153
100 074 096 059 042 183 131 106 200 155 132 196 149 125 190 140 115 184 134 109
193 144 120 196 149 125 187 137 112 179 127 102 190 140 115 190 140 115 192 143
118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 190 140 115 196 149 125 177 124 098 181 129 104
190 140 115 190 140 115 202 157 134 202 157 134 187 137 112 183 131 106 174 120
094 148 096 071 173 118 092 174 120 094 170 115 089 170 115 089 168 112 085 168
112 085 169 113 087 170 115 089 168 112 085 168 112 085 170 115 089 170 115 089
169 113 087 170 115 089 166 110 083 168 112 085 169 113 087 170 115 089 169 113
087 169 113 087 173 118 092 170 115 089 169 113 087 169 113 087 143 092 069 161
106 079 185 135 110 200 155 132 183 131 106 183 132 106 185 135 110 187 137 112
185 135 110 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 185 135
110 188 139 114 185 135 110 183 131 106 196 149 125 193 144 120 190 140 115 202
158 135 170 115 089 169 113 087 192 143 119 188 139 114 187 137 112 187 137 112
187 137 112 188 139 114 187 137 112 202 158 135 202 158 135 080 048 033 080 048
033 190 140 115 190 140 115 187 137 112 187 137 112 192 143 118 185 135 110 187
137 112 190 140 115 185 135 110 183 131 106 192 143 119 185 135 110 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 190 140 115 183 131 106 184 134 109 190 140 115 190 140 115
185 135 110 185 135 110 187 137 112 187 137 112 185 135 110 187 137 112 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 192 143 118 193 144 120 179 127 101 184 134 109 200
155 132 209 166 144 162 107 079 089 054 039 126 080 059 192 143 118 125 079 058
111 070 051 104 066 047 126 080 059 179 127 102 179 127 101 169 113 087 155 101
076 168 112 085 146 095 071 173 118 092 168 112 085 170 115 089 170 115 089 162
107 079 166 109 082 169 113 087 168 112 085 166 109 082 168 112 085 155 101 076
148 096 071 157 102 076 151 098 074 138 089 065 162 107 079 170 115 089 161 106
079 199 152 129 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 193
144 120 185 135 110 185 135 110 199 152 129 176 122 097 144 093 069 162 107 079
170 115 089 174 120 094 169 113 087 179 127 101 174 119 093 170 115 089 152 100
074 135 086 064 144 093 069 134 086 064 144 093 069 136 087 064 143 092 069 177
124 098 179 127 101 168 112 085 174 120 094 174 120 094 126 080 059 126 080 059
179 127 101 168 112 085 121 077 057 183 132 106 204 160 137 193 146 122 192 143
118 179 127 101 184 134 109 187 137 112 146 095 071 148 096 071 155 101 076 174
119 093 114 072 052 148 096 071 202 157 134 181 129 104 192 143 119 190 140 115
185 135 110 188 139 114 188 139 114 190 140 115 190 140 115 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 187 137 112 192 143 119 185 135 110 184 134 109
188 139 114 185 135 110 179 127 101 184 134 109 188 139 114 193 144 120 198 151
127 166 110 083 165 108 081 177 124 098 174 119 093 177 124 098 174 119 093 170
115 089 170 115 089 170 115 089 168 112 085 169 113 087 170 115 089 170 115 089
166 109 082 168 112 085 177 124 098 174 119 093 177 124 098 165 108 081 157 102
076 170 115 089 166 109 082 168 112 085 170 115 089 126 080 059 144 093 069 204
160 137 196 149 125 190 140 115 192 143 118 183 132 106 185 135 110 183 132 106
187 137 112 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 183 131 106 190 140 115 192 143 119 187 137 112 183 131 106 185
135 110 179 127 101 183 131 106 192 143 119 185 135 110 187 137 112 187 137 112
187 137 112 188 139 114 190 140 115 143 092 069 157 102 076 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 192 143 119 190 140 115 185
135 110 183 131 106 192 143 118 192 143 119 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 185 135 110 166 110 083 185 135 110 190 140 115 183 131 106
179 127 101 185 135 110 187 137 112 188 139 114 192 143 118 188 139 114 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 185 135 110 192 143 119 193 144 120 190 140 115 209 166 144 209
167 145 140 090 067 065 038 025 117 074 054 168 112 085 143 092 069 108 068 049
093 057 041 148 096 071 174 120 094 170 115 089 168 112 085 173 118 092 179 127
101 155 101 076 157 102 076 179 127 101 170 115 089 170 115 089 168 112 085 169
113 087 168 112 085 168 112 085 168 112 085 162 107 079 157 102 076 173 118 092
179 127 102 157 102 076 161 106 079 155 101 076 148 096 071 174 120 094 136 087
064 187 137 112 198 151 127 184 134 109 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 199
152 129 190 140 115 185 135 110 199 152 129 157 102 076 104 066 047 140 090 067
161 106 079 152 100 074 155 101 076 144 093 069 135 086 064 151 098 074 166 110
083 166 109 082 102 065 046 121 077 057 123 079 058 155 101 076 148 096 071 080
048 033 155 101 076 184 134 109 169 113 087 179 127 101 151 098 074 153 100 074
170 115 089 168 112 085 173 118 092 148 096 071 168 112 085 190 140 115 202 157
134 185 135 110 198 151 127 185 135 110 162 107 079 168 112 085 170 115 089 170
115 089 121 077 057 143 092 069 207 163 141 190 140 115 185 135 110 185 135 110
187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 190 140 115
187 137 112 190 140 115 190 140 115 187 137 112 187 137 112 185 135 110 193 144
120 193 146 122 144 093 069 111 070 051 179 127 102 170 115 089 168 112 085 173
118 092 165 108 081 165 108 081 170 115 089 170 115 089 168 112 085 169 113 087
168 112 085 166 110 083 179 127 102 174 119 093 121 077 057 151 098 074 170 115
089 144 093 069 179 127 102 174 119 093 174 120 094 134 086 064 166 109 082 199
152 129 185 135 110 183 132 106 187 137 112 190 140 115 190 140 115 190 140 115
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 187 137 112 187 137 112 183 131 106 196 149 125 192
143 118 183 131 106 198 151 127 185 135 110 188 139 114 187 137 112 187 137 112
188 139 114 183 132 106 193 146 122 130 083 061 121 077 057 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 200
155 132 183 131 106 183 132 106 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 190 140 115 184 134 109 188 139 114 183 131 106 190 140 115
188 139 114 185 135 110 187 137 112 188 139 114 192 143 118 183 131 106 183 131
106 188 139 114 190 140 115 187 137 112 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 187 137 112 202 158 135 196 149 125 135 086 064 068
041 028 072 043 030 144 093 069 166 109 082 135 086 064 089 054 039 121 077 057
169 113 087 187 137 112 179 127 101 157 102 076 173 118 092 169 113 087 143 092
069 135 086 064 169 113 087 174 120 094 170 115 089 155 101 076 162 107 079 170
115 089 168 112 085 168 112 085 168 112 085 170 115 089 166 110 083 157 102 076
170 115 089 174 119 093 169 113 087 148 096 071 138 089 065 151 098 074 138 089
065 176 122 097 192 143 119 187 137 112 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 183 132 106 187 137 112 200 154 131 170 115 089 134 086 064 153 100 074
170 115 089 165 108 081 170 115 089 174 119 093 169 113 087 170 115 089 170 115
089 169 113 087 157 102 076 176 122 097 174 120 094 174 120 094 185 135 110 151
098 074 082 050 035 169 113 087 169 113 087 146 095 071 135 086 064 183 131 106
146 095 071 082 050 035 144 093 069 155 101 076 140 090 067 144 093 069 179 127
102 200 155 132 192 143 118 193 144 120 162 107 079 138 089 065 151 098 074 183
132 106 176 122 097 121 077 057 179 127 102 200 155 132 184 134 109 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140
115 198 151 127 179 127 101 126 080 059 130 083 061 174 120 094 162 107 079 155
101 076 170 115 089 183 131 106 169 113 087 170 115 089 168 112 085 166 110 083
174 120 094 168 112 085 121 077 057 155 101 076 168 112 085 174 120 094 198 151
127 166 109 082 176 122 097 179 127 101 161 106 079 138 089 065 198 151 127 200
154 131 190 140 115 181 129 104 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 192 143 119 188 139 114 129
083 061 174 120 094 198 151 127 185 135 110 188 139 114 187 137 112 187 137 112
185 135 110 185 135 110 198 151 127 215 174 153 177 124 098 080 048 033 080 048
033 187 137 112 187 137 112 185 135 110 190 140 115 185 135 110 183 131 106 200
155 132 196 149 125 183 131 106 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 187 137 112 184 134 109 188 139 114
187 137 112 190 140 115 187 137 112 185 135 110 192 143 118 183 131 106 183 131
106 188 139 114 190 140 115 187 137 112 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 183 131 106 204 160 137 185 135 110 102 063 046 062 035 024 104
066 047 151 098 074 161 106 079 114 072 052 082 050 035 148 096 071 174 120 094
177 124 098 170 115 089 165 108 081 173 118 092 183 131 106 151 098 074 144 093
069 166 109 082 168 112 085 155 101 076 166 110 083 162 107 079 162 107 079 161
106 079 170 115 089 174 120 094 166 110 083 170 115 089 155 101 076 155 101 076
166 109 082 166 109 082 170 115 089 161 106 079 151 098 074 153 100 074 135 086
064 174 119 093 193 146 122 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 185 135 110 184 134 109 193 146 122 190 140 115 168 112 085 155 101 076
168 112 085 176 122 097 168 112 085 161 106 079 166 110 083 170 115 089 170 115
089 155 101 076 155 101 076 174 120 094 170 115 089 165 108 081 165 108 081 185
135 110 173 118 092 115 073 054 104 066 047 134 086 064 168 112 085 168 112 085
123 079 058 155 101 076 138 089 065 144 093 069 170 115 089 143 092 069 134 086
064 193 146 122 181 129 104 198 151 127 190 140 115 174 120 094 138 089 065 135
086 064 188 139 114 082 050 035 146 095 071 200 155 132 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139
114 190 140 115 200 155 132 200 155 132 135 086 064 138 089 065 179 127 101 152
100 074 134 086 064 148 096 071 161 106 079 168 112 085 170 115 089 170 115 089
169 113 087 162 107 079 170 115 089 199 152 129 198 151 127 198 151 127 199 152
129 166 109 082 161 106 079 174 120 094 136 087 064 151 098 074 200 155 132 193
144 120 190 140 115 183 131 106 185 135 110 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 198 151 127 161 106 079 143
092 069 185 135 110 192 143 118 185 135 110 188 139 114 187 137 112 187 137 112
185 135 110 196 149 125 185 135 110 183 131 106 193 144 120 080 048 033 080 048
033 187 137 112 187 137 112 188 139 114 185 135 110 190 140 115 193 144 120 151
098 074 169 113 087 193 144 120 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 185 135 110 184 134 109 184 134 109 192 143 118 177 124 098
179 127 101 198 151 127 185 135 110 187 137 112 188 139 114 190 140 115 185 135
110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 185 135 110 193 144 120 198 151 127 104 066 047 111 070 051 170 115 089 166
109 082 155 101 076 134 086 064 108 068 049 111 070 051 162 107 079 174 120 094
173 118 092 169 113 087 174 120 094 173 118 092 168 112 085 143 092 069 173 118
092 166 109 082 151 098 074 168 112 085 165 108 081 173 118 092 170 115 089 162
107 079 168 112 085 174 119 093 162 107 079 174 120 094 146 095 071 173 118 092
173 118 092 162 107 079 174 120 094 168 112 085 170 115 089 165 108 081 126 080
059 188 139 114 204 160 137 183 131 106 188 139 114 187 137 112 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 184 134 109 190 140 115 193 144 120 192 143 119 134 086 064 153 100 074
169 113 087 170 115 089 168 112 085 162 107 079 161 106 079 161 106 079 179 127
101 155 101 076 153 100 074 179 127 102 174 120 094 168 112 085 165 108 081 169
113 087 183 131 106 153 100 074 125 079 058 170 115 089 126 080 059 138 089 065
111 070 051 130 083 061 168 112 085 162 107 079 174 120 094 168 112 085 134 086
064 190 140 115 185 135 110 179 127 102 196 149 125 207 161 140 204 160 137 126
080 059 111 070 051 099 061 044 166 110 083 207 163 141 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 185 135 110
185 135 110 185 135 110 187 137 112 190 140 115 190 140 115 185 135 110 184 134
109 193 144 120 188 139 114 198 151 127 200 155 132 152 100 074 134 086 064 152
100 074 174 119 093 144 093 069 162 107 079 176 122 097 168 112 085 168 112 085
169 113 087 155 101 076 174 120 094 196 149 125 179 127 102 188 139 114 192 143
118 170 115 089 174 120 094 144 093 069 138 089 065 196 149 125 193 144 120 177
124 098 188 139 114 190 140 115 192 143 118 187 137 112 187 137 112 185 135 110
187 137 112 190 140 115 188 139 114 185 135 110 185 135 110 187 137 112 190 140
115 190 140 115 185 135 110 184 134 109 187 137 112 185 135 110 176 122 097 198
151 127 193 146 122 183 131 106 190 140 115 187 137 112 187 137 112 187 137 112
187 137 112 193 144 120 181 129 104 183 131 106 192 143 119 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 192 143 119 188 139 114 144
093 069 170 115 089 198 151 127 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 192 143 118 185 135 110 190 140 115 187 137 112
185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 190 140 115 187 137
112 185 135 110 185 135 110 190 140 115 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183 132
106 184 134 109 207 161 140 151 098 074 093 057 041 168 112 085 114 072 052 090
054 039 093 057 041 138 089 065 148 096 071 155 101 076 183 131 106 168 112 085
168 112 085 170 115 089 170 115 089 153 100 074 121 077 057 144 093 069 176 122
097 177 124 098 166 109 082 170 115 089 170 115 089 169 113 087 170 115 089 170
115 089 168 112 085 168 112 085 166 110 083 170 115 089 166 110 083 170 115 089
168 112 085 165 108 081 168 112 085 152 100 074 135 086 064 165 108 081 138 089
065 157 102 076 200 155 132 193 144 120 187 137 112 187 137 112 183 131 106 188
139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 183 132 106 190 140 115 190 140 115 198 151 127 155 101 076 151 098 074
155 101 076 161 106 079 170 115 089 170 115 089 168 112 085 155 101 076 170 115
089 161 106 079 143 092 069 152 100 074 166 110 083 169 113 087 169 113 087 179
127 101 166 109 082 151 098 074 126 080 059 173 118 092 162 107 079 151 098 074
144 093 069 120 076 056 177 124 098 173 118 092 174 119 093 155 101 076 146 095
071 196 149 125 193 146 122 190 140 115 183 132 106 179 127 101 204 160 137 193
144 120 130 083 061 121 077 057 192 143 119 192 143 119 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 183 132 106 185 135 110 190 140 115
192 143 119 190 140 115 183 132 106 183 131 106 183 131 106 193 144 120 192 143
118 173 118 092 190 140 115 187 137 112 193 144 120 202 157 134 179 127 101 190
140 115 204 160 137 185 135 110 140 090 067 174 120 094 174 120 094 168 112 085
179 127 102 136 087 064 099 061 044 207 161 140 193 144 120 181 129 104 193 144
120 155 101 076 166 109 082 144 093 069 198 151 127 198 151 127 179 127 101 185
135 110 193 144 120 190 140 115 185 135 110 185 135 110 190 140 115 190 140 115
190 140 115 185 135 110 185 135 110 190 140 115 187 137 112 192 143 118 187 137
112 181 129 104 188 139 114 193 144 120 187 137 112 187 137 112 193 144 120 187
137 112 187 137 112 192 143 118 190 140 115 187 137 112 187 137 112 187 137 112
190 140 115 185 135 110 184 134 109 193 146 122 190 140 115 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 198
151 127 198 151 127 183 132 106 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139
114 185 135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 188 139 114
190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 185 135 110 187 137
112 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 183 131 106 193 144 120 183 131
106 198 151 127 200 155 132 091 056 039 135 086 064 087 053 037 114 072 052 121
077 057 106 067 048 185 135 110 179 127 102 153 100 074 179 127 101 168 112 085
162 107 079 146 095 071 146 095 071 155 101 076 174 120 094 177 124 098 168 112
085 168 112 085 170 115 089 168 112 085 168 112 085 170 115 089 169 113 087 169
113 087 168 112 085 168 112 085 170 115 089 168 112 085 170 115 089 170 115 089
162 107 079 168 112 085 166 109 082 153 100 074 162 107 079 170 115 089 161 106
079 138 089 065 177 124 098 202 157 134 187 137 112 184 134 109 183 131 106 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 190 140 115 185 135 110 185 135 110 193 144 120 192 143 119 153 100 074
129 083 061 161 106 079 170 115 089 166 109 082 170 115 089 166 109 082 170 115
089 170 115 089 170 115 089 155 101 076 157 102 076 174 120 094 161 106 079 151
098 074 143 092 069 143 092 069 177 124 098 136 087 064 179 127 101 121 077 057
152 100 074 174 120 094 134 086 064 166 109 082 174 120 094 168 112 085 166 109
082 198 151 127 200 154 131 170 115 089 161 106 079 179 127 101 190 140 115 204
160 137 177 124 098 134 086 064 199 152 129 190 140 115 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 192 143 118
192 143 119 192 143 118 198 151 127 190 140 115 183 131 106 188 139 114 185 135
110 181 129 104 200 155 132 198 151 127 173 118 092 192 143 119 192 143 118 192
143 118 193 144 120 200 154 131 134 086 064 111 070 051 155 101 076 168 112 085
165 108 081 134 086 064 134 086 064 200 155 132 198 151 127 183 131 106 200 155
132 169 113 087 120 076 056 173 118 092 200 155 132 183 132 106 192 143 118 188
139 114 174 119 093 173 118 092 192 143 119 190 140 115 184 134 109 190 140 115
190 140 115 183 131 106 179 127 101 187 137 112 193 146 122 183 131 106 173 118
092 190 140 115 199 152 129 192 143 119 193 144 120 192 143 119 187 137 112 188
139 114 185 135 110 183 132 106 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 190 140 115 184 134 109 185 135 110 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 188
139 114 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 188 139 114 188 139 114 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 192 143 118 190 140 115 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 183 131 106 183 132 106 193 144
120 207 163 141 125 079 058 126 080 059 121 077 057 106 067 048 162 107 079 184
134 109 190 140 115 174 119 093 125 079 058 138 089 065 170 115 089 181 129 104
161 106 079 151 098 074 166 109 082 173 118 092 174 120 094 166 110 083 168 112
085 166 110 083 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085 170
115 089 169 113 087 169 113 087 170 115 089 168 112 085 166 109 082 162 107 079
166 109 082 168 112 085 170 115 089 166 109 082 162 107 079 153 100 074 170 115
089 168 112 085 135 086 064 185 135 110 198 151 127 190 140 115 192 143 118 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 183 132 106 200 155 132 174 119 093
144 093 069 168 112 085 170 115 089 166 110 083 174 119 093 169 113 087 170 115
089 166 110 083 155 101 076 166 110 083 115 073 054 134 086 064 151 098 074 169
113 087 153 100 074 161 106 079 185 135 110 157 102 076 161 106 079 151 098 074
117 074 054 126 080 059 134 086 064 126 080 059 162 107 079 125 079 058 121 077
057 200 154 131 193 144 120 168 112 085 184 134 109 199 152 129 183 131 106 187
137 112 193 144 120 188 139 114 200 154 131 181 129 104 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 192 143 119 188 139 114 185 135 110
190 140 115 188 139 114 185 135 110 185 135 110 185 135 110 198 151 127 204 160
137 198 151 127 168 112 085 187 137 112 212 170 149 187 137 112 174 120 094 177
124 098 183 131 106 179 127 101 155 101 076 138 089 065 126 080 059 176 122 097
192 143 118 177 124 098 170 115 089 185 135 110 187 137 112 187 137 112 202 158
135 190 140 115 098 061 044 198 151 127 200 155 132 179 127 101 187 137 112 188
139 114 200 155 132 209 166 144 200 154 131 196 149 125 187 137 112 183 131 106
183 131 106 183 131 106 188 139 114 193 144 120 190 140 115 184 134 109 198 151
127 199 152 129 174 120 094 185 135 110 190 140 115 179 127 101 183 131 106 190
140 115 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 190
140 115 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 188 139 114 188 139 114 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 188 139
114 184 134 109 183 132 106 190 140 115 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 200 155
132 188 139 114 102 065 046 117 074 054 093 057 041 170 115 089 174 120 094 174
119 093 151 098 074 126 080 059 152 100 074 170 115 089 134 086 064 155 101 076
151 098 074 166 110 083 170 115 089 162 107 079 166 109 082 165 108 081 168 112
085 168 112 085 168 112 085 166 110 083 169 113 087 166 110 083 168 112 085 170
115 089 168 112 085 168 112 085 170 115 089 168 112 085 166 109 082 168 112 085
166 109 082 162 107 079 168 112 085 170 115 089 148 096 071 161 106 079 170 115
089 162 107 079 165 108 081 151 098 074 185 135 110 200 155 132 190 140 115 185
135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 198 151 127 162 107 079
155 101 076 173 118 092 169 113 087 165 108 081 173 118 092 168 112 085 170 115
089 166 109 082 130 083 061 168 112 085 153 100 074 170 115 089 168 112 085 170
115 089 151 098 074 166 110 083 168 112 085 185 135 110 179 127 101 099 061 044
089 054 039 168 112 085 190 140 115 166 110 083 177 124 098 138 089 065 121 077
057 199 152 129 192 143 118 190 140 115 193 144 120 190 140 115 181 129 104 187
137 112 193 146 122 193 146 122 192 143 118 183 131 106 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 185 135 110 185 135 110 185 135 110 187 137 112 185 135 110 184 134 109
185 135 110 192 143 119 198 151 127 200 155 132 202 158 135 174 120 094 138 089
065 193 146 122 212 170 149 126 080 059 144 093 069 215 175 154 209 166 144 196
149 125 188 139 114 193 146 122 196 149 125 193 146 122 198 151 127 196 149 125
196 149 125 200 155 132 192 143 119 183 131 106 183 132 106 190 140 115 192 143
118 200 155 132 199 152 129 190 140 115 179 127 101 179 127 101 198 151 127 202
157 134 174 119 093 129 083 061 091 056 039 168 112 085 200 155 132 192 143 118
193 144 120 188 139 114 184 134 109 185 135 110 190 140 115 183 131 106 192 143
118 174 120 094 146 095 071 193 144 120 190 140 115 183 131 106 184 134 109 190
140 115 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 183 131 106 190
140 115 183 131 106 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140
115 183 131 106 181 129 104 188 139 114 192 143 118 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 132 106 179 127
102 185 135 110 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 177 124 098 209 166
144 170 115 089 082 050 035 096 059 042 135 086 064 174 120 094 174 120 094 138
089 065 148 096 071 138 089 065 177 124 098 179 127 102 170 115 089 135 086 064
138 089 065 169 113 087 174 119 093 168 112 085 170 115 089 173 118 092 169 113
087 169 113 087 170 115 089 166 110 083 165 108 081 169 113 087 168 112 085 168
112 085 165 108 081 165 108 081 168 112 085 170 115 089 170 115 089 166 109 082
166 110 083 170 115 089 168 112 085 166 109 082 161 106 079 176 122 097 174 120
094 152 100 074 177 124 098 140 090 067 140 090 067 196 149 125 188 139 114 177
124 098 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 192 143 119 179 127 101 155 101 076
169 113 087 170 115 089 166 110 083 169 113 087 179 127 102 170 115 089 174 120
094 162 107 079 153 100 074 183 131 106 174 119 093 170 115 089 146 095 071 144
093 069 138 089 065 179 127 101 192 143 118 148 096 071 157 102 076 080 048 033
121 077 057 143 092 069 183 132 106 169 113 087 166 109 082 151 098 074 185 135
110 200 155 132 179 127 101 192 143 118 193 146 122 183 131 106 184 134 109 190
140 115 183 132 106 190 140 115 181 129 104 190 140 115 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 188 139 114 185 135 110 192
143 119 192 143 119 192 143 119 198 151 127 200 154 131 200 154 131 202 157 134
200 155 132 192 143 118 162 107 079 157 102 076 184 134 109 135 086 064 093 057
041 174 120 094 209 166 144 188 139 114 082 050 035 078 047 032 174 120 094 196
149 125 193 146 122 193 144 120 193 146 122 193 146 122 184 134 109 188 139 114
190 140 115 192 143 119 184 134 109 187 137 112 202 157 134 196 149 125 179 127
102 155 101 076 170 115 089 170 115 089 200 155 132 200 154 131 202 157 134 104
066 047 062 035 024 104 066 047 157 102 076 177 124 098 179 127 102 177 124 098
187 137 112 184 134 109 192 143 118 207 163 141 200 155 132 188 139 114 080 048
033 121 077 057 207 161 140 192 143 118 190 140 115 190 140 115 190 140 115 187
137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 185
135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 184 134 109 187 137 112 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 183 132
106 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 188 139 114 185 135 110 198 151 127 190 140
115 102 065 046 080 048 033 134 086 064 179 127 101 183 132 106 146 095 071 165
108 081 179 127 102 179 127 101 161 106 079 162 107 079 179 127 101 174 119 093
176 122 097 169 113 087 166 110 083 170 115 089 168 112 085 166 110 083 170 115
089 170 115 089 168 112 085 168 112 085 169 113 087 168 112 085 166 110 083 169
113 087 170 115 089 170 115 089 168 112 085 168 112 085 170 115 089 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 179 127 101 170 115 089 151 098
074 152 100 074 165 108 081 161 106 079 126 080 059 179 127 102 200 155 132 183
131 106 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 188 139 114 188 139 114 192 143 119 193 146 122 187 137 112 144 093 069
155 101 076 161 106 079 173 118 092 161 106 079 140 090 067 161 106 079 190 140
115 136 087 064 144 093 069 177 124 098 168 112 085 161 106 079 162 107 079 162
107 079 146 095 071 138 089 065 123 079 058 102 063 046 138 089 065 177 124 098
183 132 106 117 074 054 115 073 054 177 124 098 157 102 076 140 090 067 200 154
131 199 152 129 183 132 106 190 140 115 192 143 119 188 139 114 185 135 110 190
140 115 185 135 110 185 135 110 185 135 110 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 192 143 119 190 140 115 185 135 110 179 127 101 190 140 115 202 158 135 193
144 120 193 144 120 193 144 120 179 127 101 162 107 079 162 107 079 144 093 069
111 070 051 126 080 059 108 068 049 099 061 044 120 076 056 179 127 101 168 112
085 126 080 059 121 077 057 168 112 085 179 127 101 111 070 051 058 033 022 170
115 089 207 161 140 174 120 094 177 124 098 179 127 101 190 140 115 179 127 101
192 143 118 185 135 110 196 149 125 174 120 094 140 090 067 174 120 094 166 109
082 115 073 054 155 101 076 146 095 071 202 158 135 204 160 137 134 086 064 072
043 030 144 093 069 198 151 127 200 155 132 193 144 120 181 129 104 183 131 106
188 139 114 202 157 134 200 154 131 136 087 064 165 108 081 155 101 076 165 108
081 176 122 097 193 146 122 192 143 118 190 140 115 185 135 110 187 137 112 187
137 112 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 185 135 110 192 143 119 200 155 132 129 083
061 072 043 030 111 070 051 166 109 082 152 100 074 170 115 089 134 086 064 173
118 092 166 109 082 166 109 082 170 115 089 166 110 083 162 107 079 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 166 110 083 166
109 082 170 115 089 169 113 087 166 110 083 169 113 087 166 110 083 170 115 089
166 110 083 162 107 079 168 112 085 170 115 089 166 110 083 166 110 083 161 106
079 162 107 079 169 113 087 166 110 083 134 086 064 165 108 081 200 154 131 192
143 119 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 190 140 115 187 137 112 187 137 112 200 154 131 185 135 110 144 093 069
170 115 089 190 140 115 151 098 074 138 089 065 155 101 076 134 086 064 136 087
064 138 089 065 168 112 085 169 113 087 170 115 089 170 115 089 161 106 079 166
110 083 176 122 097 140 090 067 099 061 044 157 102 076 169 113 087 174 119 093
168 112 085 179 127 101 093 057 041 144 093 069 170 115 089 162 107 079 193 144
120 185 135 110 190 140 115 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 188 139 114 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 177 124 098 192 143 119 200 155 132 193 144 120 166 109 082 114
072 052 108 068 049 114 072 052 090 054 039 126 080 059 104 066 047 074 043 030
162 107 079 190 140 115 202 158 135 209 166 144 179 127 102 198 151 127 196 149
125 199 152 129 204 160 137 169 113 087 190 140 115 207 163 141 161 106 079 196
149 125 190 140 115 170 115 089 193 146 122 138 089 065 185 135 110 204 160 137
196 149 125 193 144 120 184 134 109 202 157 134 138 089 065 134 086 064 162 107
079 169 113 087 185 135 110 144 093 069 125 079 058 134 086 064 089 054 039 104
066 047 209 166 144 202 158 135 198 151 127 207 161 140 185 135 110 176 122 097
200 154 131 212 168 148 138 089 065 125 079 058 174 120 094 168 112 085 207 163
141 199 152 129 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 187 137 112 193 144 120 177 124 098 143 092
069 121 077 057 111 070 051 130 083 061 173 118 092 179 127 102 140 090 067 151
098 074 185 135 110 169 113 087 161 106 079 165 108 081 168 112 085 169 113 087
168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 168 112 085 166 110 083 168 112 085 170 115 089 162
107 079 169 113 087 162 107 079 155 101 076 170 115 089 168 112 085 166 110 083
166 109 082 166 110 083 168 112 085 169 113 087 161 106 079 166 110 083 168 112
085 168 112 085 165 108 081 170 115 089 144 093 069 169 113 087 196 149 125 192
143 118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 193
144 120 187 137 112 179 127 102 188 139 114 193 144 120 144 093 069 151 098 074
174 120 094 170 115 089 121 077 057 166 110 083 181 129 104 168 112 085 143 092
069 168 112 085 174 119 093 166 109 082 170 115 089 174 119 093 166 110 083 165
108 081 170 115 089 129 083 061 144 093 069 174 119 093 176 122 097 174 120 094
153 100 074 179 127 101 134 086 064 121 077 057 161 106 079 143 092 069 200 154
131 185 135 110 185 135 110 188 139 114 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139
114 179 127 102 184 134 109 200 155 132 207 161 140 152 100 074 089 054 039 117
074 054 168 112 085 188 139 114 174 120 094 168 112 085 174 120 094 174 120 094
193 144 120 183 131 106 183 132 106 188 139 114 198 151 127 193 144 120 193 146
122 193 144 120 212 168 148 199 152 129 187 137 112 198 151 127 204 160 137 190
140 115 179 127 101 192 143 118 198 151 127 198 151 127 198 151 127 185 135 110
059 034 023 181 129 104 190 140 115 202 157 134 168 112 085 170 115 089 170 115
089 170 115 089 174 119 093 089 054 039 070 042 028 134 086 064 099 061 044 061
035 024 184 134 109 179 127 102 117 074 054 170 115 089 209 166 144 190 140 115
184 134 109 096 059 042 151 098 074 190 140 115 200 155 132 202 157 134 190 140
115 183 132 106 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 198 151 127 179 127 101 166 109 082 096 059
042 111 070 051 169 113 087 162 107 079 174 120 094 169 113 087 170 115 089 138
089 065 151 098 074 179 127 101 177 124 098 168 112 085 169 113 087 168 112 085
170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 166 110 083 162 107 079 168 112 085 169
113 087 168 112 085 165 108 081 161 106 079 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 174 119 093 170 115 089 155 101
076 179 127 102 162 107 079 151 098 074 162 107 079 185 135 110 193 146 122 188
139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 192
143 119 183 132 106 181 129 104 200 155 132 190 140 115 098 061 044 140 090 067
151 098 074 170 115 089 166 109 082 168 112 085 170 115 089 174 120 094 166 110
083 173 118 092 170 115 089 166 110 083 169 113 087 170 115 089 168 112 085 168
112 085 162 107 079 134 086 064 176 122 097 174 119 093 166 110 083 174 120 094
169 113 087 152 100 074 168 112 085 155 101 076 138 089 065 134 086 064 198 151
127 192 143 119 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 207 161 140 193 144 120 111 070 051 121 077 057 174 120 094 199
152 129 200 155 132 200 154 131 193 144 120 202 157 134 209 166 144 202 157 134
198 151 127 204 160 137 198 151 127 185 135 110 198 151 127 144 093 069 146 095
071 209 166 144 089 054 039 169 113 087 202 157 134 187 137 112 193 146 122 193
144 120 185 135 110 193 144 120 188 139 114 190 140 115 179 127 101 198 151 127
168 112 085 209 167 145 209 166 144 162 107 079 151 098 074 181 129 104 148 096
071 093 057 041 134 086 064 148 096 071 134 086 064 134 086 064 134 086 064 179
127 102 168 112 085 134 086 064 108 068 049 050 027 018 161 106 079 220 181 161
151 098 074 151 098 074 207 161 140 196 149 125 185 135 110 183 132 106 188 139
114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 190 140 115 188 139 114 190 140 115 187 137 112 188 139 114 190 140 115
187 137 112 187 137 112 185 135 110 200 155 132 181 129 104 082 050 035 069 041
028 098 061 044 174 120 094 173 118 092 170 115 089 166 109 082 169 113 087 168
112 085 155 101 076 117 074 054 162 107 079 179 127 101 166 110 083 174 119 093
170 115 089 170 115 089 173 118 092 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 168 112 085 168 112 085 173 118 092 170 115 089 168 112 085 168
112 085 170 115 089 169 113 087 170 115 089 169 113 087 166 109 082 170 115 089
168 112 085 174 120 094 173 118 092 174 120 094 168 112 085 155 101 076 168 112
085 138 089 065 153 100 074 183 131 106 198 151 127 196 149 125 184 134 109 187
137 112 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 190
140 115 179 127 101 199 152 129 202 158 135 151 098 074 143 092 069 148 096 071
130 083 061 144 093 069 166 110 083 166 110 083 173 118 092 170 115 089 166 109
082 168 112 085 170 115 089 166 109 082 168 112 085 169 113 087 169 113 087 168
112 085 138 089 065 091 056 039 151 098 074 177 124 098 173 118 092 174 120 094
174 119 093 151 098 074 183 131 106 181 129 104 093 057 041 126 080 059 193 146
122 193 146 122 185 135 110 190 140 115 187 137 112 185 135 110 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 184 134 109 185 135 110 183 131
106 207 163 141 179 127 101 078 047 032 161 106 079 166 110 083 176 122 097 204
160 137 200 155 132 177 124 098 193 144 120 202 157 134 196 149 125 193 146 122
183 131 106 168 112 085 183 131 106 193 144 120 204 160 137 166 110 083 165 108
081 179 127 101 062 035 024 146 095 071 198 151 127 184 134 109 185 135 110 185
135 110 204 160 137 202 157 134 183 131 106 192 143 119 202 157 134 170 115 089
217 177 157 106 067 048 093 057 041 098 061 044 089 054 039 111 070 051 096 059
042 126 080 059 168 112 085 166 109 082 146 095 071 144 093 069 193 146 122 202
157 134 200 154 131 200 154 131 207 163 141 193 144 120 042 023 014 130 083 061
209 167 145 198 151 127 188 139 114 193 144 120 192 143 119 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 185 135 110 188 139 114 190 140 115 187
137 112 181 129 104 181 129 104 183 131 106 187 137 112 183 131 106 185 135 110
190 140 115 187 137 112 187 137 112 187 137 112 200 154 131 174 120 094 102 065
046 082 050 035 153 100 074 168 112 085 174 120 094 168 112 085 170 115 089 168
112 085 179 127 102 121 077 057 134 086 064 181 129 104 165 108 081 170 115 089
168 112 085 169 113 087 162 107 079 166 109 082 170 115 089 170 115 089 166 110
083 170 115 089 173 118 092 170 115 089 168 112 085 170 115 089 170 115 089 166
109 082 169 113 087 181 129 104 188 139 114 181 129 104 166 110 083 170 115 089
169 113 087 166 109 082 170 115 089 161 106 079 135 086 064 134 086 064 151 098
074 170 115 089 202 158 135 198 151 127 196 149 125 190 140 115 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 190 140 115 187 137 112 185 135 110 187 137 112 185
135 110 190 140 115 200 155 132 165 108 081 091 056 039 179 127 101 187 137 112
176 122 097 136 087 064 140 090 067 183 131 106 166 110 083 168 112 085 170 115
089 157 102 076 168 112 085 170 115 089 162 107 079 173 118 092 161 106 079 170
115 089 134 086 064 089 054 039 134 086 064 165 108 081 168 112 085 174 120 094
170 115 089 134 086 064 146 095 071 093 057 041 138 089 065 157 102 076 166 110
083 207 163 141 185 135 110 179 127 101 192 143 119 192 143 119 179 127 102 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 187 137 112 181 129 104 199 152 129 190 140 115 196 149
125 200 154 131 102 065 046 166 110 083 190 140 115 170 115 089 157 102 076 179
127 102 173 118 092 202 158 135 174 120 094 162 107 079 153 100 074 155 101 076
151 098 074 099 061 044 134 086 064 198 151 127 200 155 132 093 057 041 130 083
061 111 070 051 144 093 069 204 160 137 198 151 127 209 166 144 111 070 051 162
107 079 111 070 051 099 061 044 134 086 064 200 155 132 168 112 085 125 079 058
082 050 035 099 061 044 121 077 057 155 101 076 138 089 065 162 107 079 152 100
074 108 068 049 138 089 065 157 102 076 183 131 106 202 158 135 204 160 137 192
143 118 185 135 110 190 140 115 190 140 115 173 118 092 155 101 076 188 139 114
190 140 115 179 127 101 192 143 118 192 143 118 190 140 115 190 140 115 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 185 135 110 185 135 110
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 187 137 112 183
131 106 199 152 129 212 170 149 192 143 119 192 143 119 187 137 112 183 132 106
190 140 115 187 137 112 187 137 112 188 139 114 193 144 120 174 120 094 157 102
076 070 042 028 136 087 064 140 090 067 161 106 079 183 131 106 148 096 071 144
093 069 151 098 074 168 112 085 135 086 064 169 113 087 174 120 094 161 106 079
166 109 082 161 106 079 168 112 085 169 113 087 161 106 079 168 112 085 170 115
089 166 109 082 168 112 085 170 115 089 169 113 087 168 112 085 169 113 087 170
115 089 162 107 079 166 110 083 114 072 052 155 101 076 185 135 110 168 112 085
170 115 089 121 077 057 155 101 076 170 115 089 176 122 097 187 137 112 192 143
118 198 151 127 192 143 118 185 135 110 183 132 106 185 135 110 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 192 143 119 192 143 119 190 140 115 184 134 109 181
129 104 200 155 132 153 100 074 162 107 079 165 108 081 111 070 051 138 089 065
170 115 089 170 115 089 134 086 064 176 122 097 174 120 094 169 113 087 170 115
089 170 115 089 169 113 087 170 115 089 168 112 085 176 122 097 157 102 076 162
107 079 138 089 065 087 053 037 146 095 071 143 092 069 157 102 076 125 079 058
179 127 102 115 073 054 114 072 052 135 086 064 151 098 074 174 120 094 155 101
076 183 132 106 202 157 134 184 134 109 193 144 120 190 140 115 183 131 106 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 190 140 115 200 155
132 104 066 047 144 093 069 193 144 120 169 113 087 098 061 044 115 073 054 173
118 092 168 112 085 198 151 127 143 092 069 144 093 069 168 112 085 162 107 079
174 119 093 146 095 071 143 092 069 193 144 120 187 137 112 126 080 059 085 051
036 106 067 048 193 146 122 209 166 144 174 120 094 152 100 074 157 102 076 209
166 144 177 124 098 138 089 065 185 135 110 199 152 129 126 080 059 111 070 051
148 096 071 213 171 150 151 098 074 143 092 069 148 096 071 143 092 069 166 110
083 165 108 081 183 131 106 193 146 122 199 152 129 192 143 118 165 108 081 168
112 085 192 143 119 185 135 110 166 109 082 157 102 076 202 157 134 198 151 127
179 127 102 192 143 119 185 135 110 185 135 110 185 135 110 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 185 135 110 185 135 110
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 193
144 120 179 127 101 176 122 097 188 139 114 185 135 110 196 149 125 185 135 110
187 137 112 187 137 112 185 135 110 192 143 119 185 135 110 134 086 064 179 127
102 057 032 021 155 101 076 192 143 118 140 090 067 162 107 079 115 073 054 174
119 093 174 119 093 183 131 106 144 093 069 165 108 081 168 112 085 161 106 079
174 119 093 166 110 083 166 109 082 168 112 085 170 115 089 170 115 089 169 113
087 168 112 085 173 118 092 166 110 083 169 113 087 170 115 089 161 106 079 174
120 094 144 093 069 099 061 044 153 100 074 108 068 049 161 106 079 162 107 079
135 086 064 174 120 094 200 155 132 193 144 120 193 146 122 193 146 122 187 137
112 179 127 102 177 124 098 188 139 114 188 139 114 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 190 140 115 190 140 115 183 131 106 183 131 106 187 137 112 193
144 120 177 124 098 144 093 069 168 112 085 181 129 104 174 119 093 140 090 067
134 086 064 181 129 104 148 096 071 155 101 076 173 118 092 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 174 119 093 168 112 085 166
110 083 144 093 069 120 076 056 120 076 056 115 073 054 193 144 120 192 143 119
121 077 057 135 086 064 120 076 056 173 118 092 162 107 079 170 115 089 170 115
089 087 053 037 177 124 098 207 163 141 184 134 109 183 131 106 199 152 129 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 179 127 102 202 157 134 162 107 079 179 127 101 170 115
089 080 048 033 174 120 094 168 112 085 144 093 069 151 098 074 185 135 110 199
152 129 200 155 132 184 134 109 165 108 081 155 101 076 151 098 074 166 110 083
179 127 101 174 119 093 120 076 056 192 143 119 200 154 131 170 115 089 099 061
044 108 068 049 091 056 039 140 090 067 179 127 101 111 070 051 200 154 131 148
096 071 185 135 110 202 158 135 165 108 081 134 086 064 143 092 069 062 035 024
177 124 098 190 140 115 108 068 049 179 127 101 168 112 085 179 127 101 199 152
129 200 155 132 196 149 125 190 140 115 179 127 102 185 135 110 184 134 109 181
129 104 188 139 114 177 124 098 192 143 118 204 160 137 190 140 115 185 135 110
190 140 115 187 137 112 185 135 110 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 187 137 112 190 140 115 185 135 110
184 134 109 188 139 114 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 192 143 118 188 139 114 185 135 110 207
163 141 121 077 057 098 061 044 179 127 102 185 135 110 187 137 112 185 135 110
187 137 112 187 137 112 188 139 114 184 134 109 202 158 135 162 107 079 168 112
085 117 074 054 074 043 030 207 163 141 114 072 052 123 079 058 179 127 101 174
120 094 169 113 087 161 106 079 144 093 069 170 115 089 168 112 085 173 118 092
174 120 094 179 127 101 162 107 079 166 110 083 174 119 093 165 108 081 170 115
089 176 122 097 166 110 083 155 101 076 166 109 082 166 109 082 155 101 076 173
118 092 151 098 074 077 047 032 144 093 069 157 102 076 155 101 076 176 122 097
193 146 122 196 149 125 193 144 120 181 129 104 185 135 110 190 140 115 188 139
114 190 140 115 193 144 120 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 188 139 114 192 143 118 190 140 115 188 139 114 181 129 104 196
149 125 185 135 110 134 086 064 166 110 083 170 115 089 173 118 092 170 115 089
146 095 071 168 112 085 176 122 097 148 096 071 152 100 074 174 120 094 168 112
085 166 109 082 173 118 092 170 115 089 166 110 083 170 115 089 169 113 087 174
120 094 174 119 093 121 077 057 169 113 087 157 102 076 170 115 089 188 139 114
099 061 044 179 127 102 144 093 069 078 047 032 162 107 079 174 120 094 152 100
074 148 096 071 146 095 071 179 127 101 200 154 131 183 131 106 192 143 119 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 181 129 104 200 155 132 198 151 127 174 120 094 111 070
051 162 107 079 196 149 125 148 096 071 176 122 097 212 168 148 192 143 118 187
137 112 196 149 125 130 083 061 168 112 085 179 127 101 165 108 081 155 101 076
151 098 074 181 129 104 174 120 094 117 074 054 209 167 145 153 100 074 126 080
059 212 168 148 170 115 089 134 086 064 209 166 144 200 154 131 209 166 144 144
093 069 144 093 069 212 170 149 155 101 076 123 079 058 143 092 069 170 115 089
204 160 137 155 101 076 181 129 104 212 168 148 196 149 125 192 143 119 185 135
110 187 137 112 184 134 109 188 139 114 193 146 122 192 143 118 187 137 112 190
140 115 188 139 114 192 143 118 188 139 114 188 139 114 187 137 112 192 143 119
193 144 120 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110
184 134 109 188 139 114 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 192 143 118 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 185 135 110 187 137 112 187 137 112 188
139 114 183 131 106 198 151 127 193 146 122 192 143 119 188 139 114 190 140 115
187 137 112 187 137 112 188 139 114 183 132 106 200 155 132 183 131 106 143 092
069 162 107 079 042 023 014 120 076 056 190 140 115 170 115 089 169 113 087 138
089 065 174 120 094 162 107 079 114 072 052 174 120 094 188 139 114 138 089 065
108 068 049 157 102 076 181 129 104 168 112 085 169 113 087 174 120 094 169 113
087 144 093 069 173 118 092 183 132 106 170 115 089 170 115 089 174 120 094 170
115 089 176 122 097 121 077 057 130 083 061 209 166 144 198 151 127 193 146 122
193 146 122 184 134 109 183 132 106 190 140 115 188 139 114 188 139 114 192 143
118 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 185 135 110 188 139 114 188 139 114 187 137 112 185 135 110 185 135 110
187 137 112 187 137 112 188 139 114 185 135 110 185 135 110 187 137 112 188 139
114 190 140 115 187 137 112 190 140 115 193 146 122 187 137 112 168 112 085 185
135 110 204 160 137 130 083 061 148 096 071 170 115 089 170 115 089 169 113 087
151 098 074 177 124 098 177 124 098 138 089 065 155 101 076 174 120 094 169 113
087 170 115 089 170 115 089 168 112 085 169 113 087 168 112 085 170 115 089 170
115 089 190 140 115 115 073 054 106 067 048 193 144 120 148 096 071 161 106 079
134 086 064 148 096 071 148 096 071 138 089 065 165 108 081 183 131 106 151 098
074 166 109 082 174 120 094 126 080 059 184 134 109 202 157 134 179 127 101 184
134 109 190 140 115 187 137 112 185 135 110 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 190 140
115 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 187 137 112
185 135 110 187 137 112 196 149 125 165 108 081 202 157 134 120 076 056 138 089
065 209 166 144 144 093 069 136 087 064 198 151 127 193 144 120 188 139 114 198
151 127 185 135 110 134 086 064 151 098 074 157 102 076 169 113 087 123 079 058
093 057 041 126 080 059 170 115 089 146 095 071 148 096 071 192 143 119 102 065
046 104 066 047 135 086 064 126 080 059 098 061 044 200 154 131 202 157 134 136
087 064 070 042 028 207 161 140 179 127 102 198 151 127 198 151 127 199 152 129
192 143 119 193 144 120 198 151 127 181 129 104 185 135 110 193 144 120 193 144
120 184 134 109 187 137 112 190 140 115 192 143 119 192 143 118 184 134 109 185
135 110 190 140 115 188 139 114 184 134 109 185 135 110 192 143 118 183 132 106
183 132 106 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 185 135 110 188 139 114
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139
114 192 143 119 170 115 089 179 127 101 192 143 119 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 185 135 110 185
135 110 198 151 127 193 144 120 185 135 110 190 140 115 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 183 132 106 204 160 137 179 127
101 144 093 069 130 083 061 053 029 019 143 092 069 198 151 127 166 110 083 153
100 074 168 112 085 170 115 089 138 089 065 144 093 069 099 061 044 138 089 065
166 109 082 129 083 061 130 083 061 134 086 064 155 101 076 179 127 101 140 090
067 125 079 058 155 101 076 140 090 067 155 101 076 170 115 089 155 101 076 166
109 082 170 115 089 155 101 076 190 140 115 202 157 134 184 134 109 185 135 110
183 132 106 190 140 115 185 135 110 192 143 119 192 143 118 185 135 110 184 134
109 183 131 106 183 131 106 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 193 144 120 183 132 106 187 137 112 185 135 110 190 140 115 193 146 122
190 140 115 185 135 110 185 135 110 193 146 122 192 143 119 190 140 115 187 137
112 183 131 106 190 140 115 185 135 110 184 134 109 184 134 109 193 146 122 183
131 106 202 158 135 165 108 081 099 061 044 136 087 064 170 115 089 099 061 044
148 096 071 151 098 074 168 112 085 166 110 083 157 102 076 174 120 094 166 110
083 170 115 089 170 115 089 168 112 085 170 115 089 169 113 087 166 110 083 162
107 079 170 115 089 187 137 112 096 059 042 115 073 054 183 131 106 193 144 120
161 106 079 115 073 054 151 098 074 134 086 064 170 115 089 179 127 102 155 101
076 155 101 076 174 119 093 168 112 085 146 095 071 166 109 082 204 160 137 200
154 131 179 127 101 193 144 120 198 151 127 179 127 102 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 190 140 115 190 140 115 185 135 110 183 131 106 179 127
101 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112 188 139 114
190 140 115 188 139 114 184 134 109 168 112 085 155 101 076 121 077 057 174 120
094 136 087 064 117 074 054 126 080 059 125 079 058 193 146 122 190 140 115 190
140 115 192 143 119 138 089 065 121 077 057 126 080 059 134 086 064 148 096 071
114 072 052 162 107 079 144 093 069 135 086 064 115 073 054 202 158 135 209 166
144 162 107 079 176 122 097 198 151 127 144 093 069 155 101 076 200 155 132 125
079 058 104 066 047 200 154 131 196 149 125 188 139 114 185 135 110 185 135 110
183 131 106 185 135 110 185 135 110 185 135 110 190 140 115 187 137 112 187 137
112 188 139 114 190 140 115 188 139 114 184 134 109 185 135 110 190 140 115 190
140 115 187 137 112 185 135 110 190 140 115 185 135 110 190 140 115 190 140 115
184 134 109 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 185 135 110 181 129 104 176 122 097
193 144 120 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135
110 187 137 112 183 132 106 183 131 106 185 135 110 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 185 135 110 185 135 110 188 139 114 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 187 137 112 196 149
125 179 127 101 173 118 092 117 074 054 053 029 019 130 083 061 174 120 094 170
115 089 162 107 079 168 112 085 177 124 098 170 115 089 126 080 059 174 120 094
196 149 125 153 100 074 120 076 056 181 129 104 183 131 106 166 110 083 138 089
065 193 146 122 161 106 079 114 072 052 143 092 069 125 079 058 125 079 058 129
083 061 151 098 074 169 113 087 192 143 119 185 135 110 187 137 112 187 137 112
190 140 115 185 135 110 188 139 114 185 135 110 185 135 110 190 140 115 187 137
112 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 192 143 118 185 135 110 183 131 106 190 140 115 204 160 137 190 140 115
179 127 102 184 134 109 179 127 101 185 135 110 193 144 120 188 139 114 187 137
112 187 137 112 187 137 112 185 135 110 185 135 110 183 131 106 198 151 127 198
151 127 202 158 135 174 120 094 126 080 059 144 093 069 155 101 076 144 093 069
177 124 098 130 083 061 129 083 061 181 129 104 146 095 071 168 112 085 174 120
094 174 119 093 170 115 089 170 115 089 168 112 085 166 110 083 161 106 079 168
112 085 169 113 087 184 134 109 170 115 089 138 089 065 187 137 112 183 131 106
148 096 071 143 092 069 174 120 094 168 112 085 166 110 083 166 110 083 169 113
087 143 092 069 170 115 089 169 113 087 155 101 076 143 092 069 146 095 071 200
154 131 190 140 115 185 135 110 190 140 115 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 185 135 110 185 135 110 190 140 115 190 140 115 188 139
114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 198 151 127 183 131 106 185 135 110
200 154 131 173 118 092 188 139 114 202 158 135 104 066 047 121 077 057 184 134
109 155 101 076 166 109 082 155 101 076 170 115 089 200 155 132 190 140 115 187
137 112 198 151 127 184 134 109 198 151 127 174 120 094 138 089 065 168 112 085
155 101 076 104 066 047 130 083 061 161 106 079 196 149 125 190 140 115 187 137
112 207 161 140 198 151 127 193 144 120 202 158 135 187 137 112 193 144 120 198
151 127 174 119 093 179 127 102 192 143 119 185 135 110 188 139 114 187 137 112
190 140 115 190 140 115 187 137 112 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 185 135 110 184 134 109
190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137
112 185 135 110 193 144 120 192 143 118 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 179 127 101 181 129
104 209 166 144 170 115 089 117 074 054 111 070 051 082 050 035 135 086 064 209
166 144 166 109 082 165 108 081 168 112 085 177 124 098 138 089 065 146 095 071
120 076 056 111 070 051 136 087 064 135 086 064 162 107 079 174 120 094 151 098
074 165 108 081 144 093 069 173 118 092 179 127 102 153 100 074 179 127 102 177
124 098 098 061 044 185 135 110 200 155 132 170 115 089 192 143 119 192 143 118
185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 187
137 112 177 124 098 184 134 109 200 155 132 198 151 127 190 140 115 190 140 115
192 143 118 193 144 120 200 155 132 200 155 132 192 143 118 192 143 119 192 143
118 193 144 120 188 139 114 187 137 112 200 155 132 185 135 110 185 135 110 193
146 122 170 115 089 136 087 064 187 137 112 173 118 092 170 115 089 179 127 101
173 118 092 144 093 069 151 098 074 143 092 069 121 077 057 174 120 094 177 124
098 155 101 076 162 107 079 173 118 092 173 118 092 174 119 093 181 129 104 183
132 106 170 115 089 177 124 098 144 093 069 136 087 064 148 096 071 106 067 048
111 070 051 183 131 106 179 127 101 140 090 067 134 086 064 143 092 069 153 100
074 126 080 059 151 098 074 174 120 094 174 119 093 174 120 094 126 080 059 146
095 071 207 161 140 190 140 115 173 118 092 200 155 132 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 184 134 109 183 131 106 185 135 110 192 143 118 198 151
127 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 192 143 118 183 132 106 183 131 106
193 144 120 202 157 134 179 127 102 090 054 039 136 087 064 168 112 085 193 144
120 162 107 079 146 095 071 168 112 085 202 158 135 185 135 110 185 135 110 190
140 115 185 135 110 198 151 127 198 151 127 202 157 134 183 131 106 136 087 064
130 083 061 096 059 042 129 083 061 155 101 076 198 151 127 200 155 132 190 140
115 183 131 106 188 139 114 185 135 110 183 131 106 184 134 109 179 127 102 190
140 115 200 154 131 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 193 144 120
185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137
112 190 140 115 183 132 106 187 137 112 193 144 120 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 185 135 110 193 144 120 188 139 114 170 115
089 200 154 131 184 134 109 138 089 065 080 048 033 134 086 064 061 035 024 174
119 093 185 135 110 162 107 079 173 118 092 183 132 106 120 076 056 115 073 054
138 089 065 104 066 047 143 092 069 123 079 058 108 068 049 102 065 046 108 068
049 148 096 071 152 100 074 176 122 097 174 120 094 135 086 064 155 101 076 166
110 083 144 093 069 200 155 132 190 140 115 179 127 101 193 144 120 190 140 115
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 198 151 127 190 140 115 170 115 089 126 080 059 155 101 076
183 131 106 179 127 102 193 146 122 174 120 094 161 106 079 183 132 106 193 144
120 199 152 129 196 149 125 192 143 119 202 158 135 165 108 081 140 090 067 155
101 076 114 072 052 120 076 056 143 092 069 155 101 076 170 115 089 174 120 094
135 086 064 166 109 082 174 120 094 168 112 085 155 101 076 144 093 069 125 079
058 151 098 074 144 093 069 151 098 074 157 102 076 152 100 074 157 102 076 151
098 074 140 090 067 126 080 059 151 098 074 166 109 082 168 112 085 138 089 065
144 093 069 134 086 064 134 086 064 144 093 069 155 101 076 170 115 089 134 086
064 148 096 071 155 101 076 153 100 074 157 102 076 170 115 089 193 146 122 151
098 074 165 108 081 188 139 114 185 135 110 192 143 119 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 188 139 114 187 137 112 190 140 115 200 154
131 192 143 119 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 190 140 115 181 129 104 187 137 112
202 157 134 170 115 089 078 047 032 078 047 032 176 122 097 198 151 127 162 107
079 111 070 051 129 083 061 140 090 067 199 152 129 190 140 115 183 131 106 185
135 110 181 129 104 183 131 106 176 122 097 183 131 106 204 160 137 202 158 135
136 087 064 059 034 023 130 083 061 121 077 057 120 076 056 168 112 085 192 143
119 193 144 120 185 135 110 185 135 110 198 151 127 200 155 132 174 120 094 179
127 101 190 140 115 183 131 106 185 135 110 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 184 134 109 183 131 106 187 137 112
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 193 144
120 187 137 112 192 143 119 190 140 115 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 190 140 115 184 134 109 184 134 109 192 143 119 200 154 131 183 131
106 193 144 120 170 115 089 152 100 074 080 048 033 157 102 076 126 080 059 053
029 019 179 127 102 183 131 106 162 107 079 143 092 069 162 107 079 162 107 079
129 083 061 155 101 076 185 135 110 151 098 074 108 068 049 126 080 059 161 106
079 183 132 106 140 090 067 130 083 061 169 113 087 146 095 071 143 092 069 170
115 089 204 160 137 198 151 127 185 135 110 188 139 114 192 143 118 188 139 114
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 188 139 114 187 137 112 185 135 110 185 135 110 190
140 115 202 157 134 188 139 114 157 102 076 165 108 081 120 076 056 162 107 079
161 106 079 157 102 076 117 074 054 117 074 054 162 107 079 143 092 069 166 109
082 188 139 114 183 131 106 193 146 122 184 134 109 144 093 069 170 115 089 170
115 089 157 102 076 162 107 079 115 073 054 169 113 087 173 118 092 166 110 083
144 093 069 157 102 076 168 112 085 174 120 094 173 118 092 144 093 069 162 107
079 174 120 094 173 118 092 162 107 079 162 107 079 161 106 079 143 092 069 121
077 057 174 120 094 174 120 094 170 115 089 174 120 094 174 119 093 193 144 120
168 112 085 104 066 047 138 089 065 130 083 061 138 089 065 151 098 074 151 098
074 161 106 079 177 124 098 168 112 085 155 101 076 134 086 064 157 102 076 183
131 106 135 086 064 179 127 101 204 160 137 184 134 109 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
188 139 114 190 140 115 187 137 112 185 135 110 190 140 115 183 131 106 170 115
089 192 143 118 193 146 122 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 192 143 119 179 127 101 188 139 114
200 155 132 138 089 065 155 101 076 181 129 104 199 152 129 190 140 115 151 098
074 115 073 054 134 086 064 169 113 087 193 144 120 193 144 120 185 135 110 187
137 112 190 140 115 193 144 120 200 154 131 183 131 106 181 129 104 198 151 127
212 170 149 165 108 081 093 057 041 143 092 069 125 079 058 173 118 092 179 127
101 183 131 106 200 154 131 199 152 129 170 115 089 168 112 085 207 163 141 192
143 119 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190
140 115 188 139 114 187 137 112 188 139 114 187 137 112 185 135 110 187 137 112
185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 187 137 112 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115
198 151 127 181 129 104 184 134 109 193 144 120 200 155 132 192 143 118 183 131
106 200 155 132 179 127 101 151 098 074 069 041 028 146 095 071 204 160 137 070
042 028 140 090 067 170 115 089 129 083 061 162 107 079 168 112 085 174 120 094
151 098 074 144 093 069 168 112 085 174 120 094 135 086 064 162 107 079 190 140
115 126 080 059 168 112 085 193 144 120 185 135 110 192 143 119 193 144 120 200
154 131 190 140 115 181 129 104 190 140 115 190 140 115 185 135 110 187 137 112
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 185 135 110 184 134 109 193 144 120 187 137 112 198 151 127 200
155 132 161 106 079 153 100 074 183 132 106 140 090 067 157 102 076 173 118 092
169 113 087 173 118 092 144 093 069 152 100 074 177 124 098 162 107 079 152 100
074 117 074 054 111 070 051 153 100 074 151 098 074 152 100 074 165 108 081 173
118 092 179 127 102 135 086 064 111 070 051 115 073 054 155 101 076 174 120 094
146 095 071 134 086 064 174 120 094 174 119 093 179 127 101 174 119 093 174 119
093 168 112 085 168 112 085 170 115 089 176 122 097 179 127 101 143 092 069 174
120 094 170 115 089 168 112 085 170 115 089 170 115 089 174 120 094 179 127 101
155 101 076 108 068 049 087 053 037 120 076 056 166 109 082 072 043 030 125 079
058 162 107 079 152 100 074 165 108 081 174 120 094 170 115 089 121 077 057 162
107 079 174 120 094 155 101 076 200 154 131 181 129 104 185 135 110 188 139 114
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 192 143 119 183 132 106
185 135 110 177 124 098 184 134 109 196 149 125 200 154 131 174 119 093 099 061
044 125 079 058 190 140 115 198 151 127 188 139 114 190 140 115 192 143 119 185
135 110 187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 174 120 094
185 135 110 193 146 122 202 157 134 202 157 134 202 157 134 193 144 120 111 070
051 102 063 046 187 137 112 202 157 134 183 131 106 183 131 106 192 143 118 187
137 112 190 140 115 196 149 125 193 144 120 185 135 110 192 143 119 183 131 106
190 140 115 212 168 148 138 089 065 111 070 051 204 160 137 209 166 144 202 157
134 162 107 079 170 115 089 207 161 140 144 093 069 093 057 041 153 100 074 193
144 120 183 132 106 200 155 132 190 140 115 185 135 110 185 135 110 185 135 110
185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 188 139 114 183
132 106 184 134 109 185 135 110 192 143 118 192 143 118 185 135 110 190 140 115
185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110
174 119 093 187 137 112 212 170 149 199 152 129 111 070 051 115 073 054 209 166
144 196 149 125 099 061 044 140 090 067 162 107 079 135 086 064 161 106 079 099
061 044 069 041 028 170 115 089 187 137 112 169 113 087 174 119 093 162 107 079
162 107 079 144 093 069 162 107 079 166 110 083 155 101 076 117 074 054 146 095
071 162 107 079 193 146 122 202 157 134 192 143 118 193 144 120 192 143 119 188
139 114 184 134 109 190 140 115 185 135 110 187 137 112 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 190 140 115 184 134 109 200 155 132 193 144 120 144
093 069 134 086 064 138 089 065 138 089 065 104 066 047 162 107 079 170 115 089
162 107 079 170 115 089 162 107 079 140 090 067 173 118 092 183 131 106 134 086
064 135 086 064 144 093 069 153 100 074 174 119 093 169 113 087 152 100 074 162
107 079 179 127 101 183 131 106 174 119 093 111 070 051 126 080 059 185 135 110
136 087 064 123 079 058 136 087 064 138 089 065 161 106 079 176 122 097 174 120
094 165 108 081 166 110 083 179 127 101 161 106 079 126 080 059 165 108 081 176
122 097 168 112 085 168 112 085 170 115 089 170 115 089 168 112 085 129 083 061
170 115 089 162 107 079 115 073 054 111 070 051 165 108 081 140 090 067 111 070
051 153 100 074 162 107 079 174 120 094 168 112 085 183 131 106 169 113 087 104
066 047 165 108 081 151 098 074 185 135 110 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 192 143 118 185 135 110
190 140 115 184 134 109 204 160 137 173 118 092 198 151 127 183 132 106 144 093
069 125 079 058 181 129 104 198 151 127 190 140 115 188 139 114 190 140 115 185
135 110 187 137 112 187 137 112 188 139 114 185 135 110 192 143 118 179 127 101
183 131 106 193 144 120 183 131 106 179 127 102 179 127 101 151 098 074 123 079
058 198 151 127 202 157 134 183 131 106 188 139 114 200 155 132 185 135 110 183
132 106 185 135 110 179 127 102 179 127 101 190 140 115 187 137 112 190 140 115
185 135 110 185 135 110 198 151 127 212 170 149 198 151 127 170 115 089 198 151
127 185 135 110 104 066 047 117 074 054 111 070 051 115 073 054 117 074 054 190
140 115 192 143 118 193 144 120 184 134 109 193 144 120 190 140 115 185 135 110
179 127 102 183 131 106 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112 190
140 115 190 140 115 187 137 112 192 143 119 185 135 110 193 144 120 185 135 110
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 187 137 112 185 135 110 188 139 114 179 127 102
193 146 122 220 181 161 134 086 064 059 034 023 087 053 037 111 070 051 162 107
079 121 077 057 091 056 039 135 086 064 188 139 114 174 120 094 125 079 058 152
100 074 115 073 054 072 043 030 181 129 104 174 120 094 170 115 089 169 113 087
173 118 092 181 129 104 176 122 097 187 137 112 177 124 098 138 089 065 168 112
085 200 155 132 193 146 122 183 132 106 185 135 110 185 135 110 185 135 110 185
135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 185 135 110 181 129 104 193 146 122 174 120 094 161
106 079 190 140 115 104 066 047 151 098 074 151 098 074 115 073 054 183 131 106
176 122 097 170 115 089 174 120 094 151 098 074 162 107 079 183 131 106 146 095
071 140 090 067 140 090 067 157 102 076 177 124 098 169 113 087 173 118 092 165
108 081 152 100 074 155 101 076 185 135 110 179 127 101 114 072 052 155 101 076
166 109 082 168 112 085 173 118 092 168 112 085 134 086 064 138 089 065 162 107
079 179 127 101 183 131 106 140 090 067 134 086 064 161 106 079 174 119 093 168
112 085 166 109 082 170 115 089 170 115 089 170 115 089 168 112 085 130 083 061
136 087 064 166 110 083 169 113 087 165 108 081 135 086 064 134 086 064 152 100
074 102 065 046 144 093 069 168 112 085 138 089 065 144 093 069 166 109 082 161
106 079 162 107 079 155 101 076 152 100 074 196 149 125 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 184 134 109 188 139 114 190 140 115
190 140 115 202 158 135 192 143 119 082 050 035 174 120 094 207 161 140 126 080
059 155 101 076 198 151 127 192 143 119 188 139 114 185 135 110 188 139 114 185
135 110 187 137 112 187 137 112 188 139 114 184 134 109 190 140 115 185 135 110
188 139 114 185 135 110 185 135 110 198 151 127 135 086 064 098 061 044 168 112
085 202 157 134 170 115 089 198 151 127 200 154 131 146 095 071 202 157 134 193
144 120 184 134 109 185 135 110 184 134 109 187 137 112 188 139 114 187 137 112
185 135 110 185 135 110 207 161 140 125 079 058 170 115 089 212 170 149 168 112
085 188 139 114 192 143 119 157 102 076 166 109 082 104 066 047 155 101 076 200
154 131 187 137 112 192 143 119 184 134 109 187 137 112 187 137 112 185 135 110
187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 193 146 122 183 132 106 157
102 076 183 131 106 198 151 127 174 120 094 169 113 087 193 144 120 183 132 106
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115 192 143 119
170 115 089 146 095 071 051 027 018 115 073 054 212 170 149 192 143 119 104 066
047 130 083 061 204 160 137 200 154 131 117 074 054 185 135 110 168 112 085 126
080 059 183 132 106 111 070 051 121 077 057 166 110 083 134 086 064 125 079 058
157 102 076 151 098 074 151 098 074 151 098 074 123 079 058 196 149 125 209 166
144 174 120 094 177 124 098 192 143 119 185 135 110 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 199 152 129 190 140 115 123 079 058 115
073 054 151 098 074 165 108 081 192 143 119 165 108 081 129 083 061 174 120 094
162 107 079 138 089 065 130 083 061 138 089 065 179 127 101 183 131 106 143 092
069 146 095 071 168 112 085 151 098 074 168 112 085 166 109 082 166 110 083 170
115 089 155 101 076 111 070 051 162 107 079 173 118 092 148 096 071 134 086 064
138 089 065 155 101 076 179 127 102 170 115 089 170 115 089 166 109 082 134 086
064 151 098 074 181 129 104 151 098 074 166 109 082 179 127 101 165 108 081 162
107 079 170 115 089 169 113 087 166 110 083 162 107 079 179 127 102 174 120 094
123 079 058 162 107 079 138 089 065 125 079 058 157 102 076 121 077 057 162 107
079 174 120 094 161 106 079 144 093 069 138 089 065 143 092 069 162 107 079 179
127 102 170 115 089 183 131 106 144 093 069 185 135 110 193 144 120 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 184 134 109 188 139 114 192 143 118
187 137 112 200 155 132 152 100 074 111 070 051 151 098 074 174 120 094 144 093
069 193 144 120 199 152 129 188 139 114 188 139 114 185 135 110 187 137 112 188
139 114 187 137 112 187 137 112 188 139 114 185 135 110 190 140 115 190 140 115
188 139 114 187 137 112 185 135 110 204 160 137 162 107 079 115 073 054 200 155
132 190 140 115 188 139 114 196 149 125 166 110 083 117 074 054 162 107 079 199
152 129 207 163 141 196 149 125 196 149 125 187 137 112 187 137 112 187 137 112
190 140 115 183 131 106 185 135 110 185 135 110 089 054 039 176 122 097 209 166
144 192 143 118 176 122 097 093 057 041 200 155 132 140 090 067 151 098 074 204
160 137 188 139 114 190 140 115 183 131 106 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 193 144 120 187 137 112 157
102 076 190 140 115 193 144 120 184 134 109 185 135 110 193 144 120 185 135 110
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139
114 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 190 140 115 187
137 112 190 140 115 190 140 115 187 137 112 183 131 106 192 143 119 200 155 132
111 070 051 082 050 035 168 112 085 207 163 141 185 135 110 193 146 122 207 161
140 204 160 137 184 134 109 196 149 125 179 127 101 117 074 054 065 038 025 123
079 058 140 090 067 174 119 093 138 089 065 130 083 061 134 086 064 111 070 051
190 140 115 155 101 076 082 050 035 134 086 064 108 068 049 170 115 089 202 158
135 185 135 110 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
187 137 112 190 140 115 188 139 114 185 135 110 187 137 112 187 137 112 187 137
112 190 140 115 183 131 106 199 152 129 196 149 125 136 087 064 161 106 079 138
089 065 138 089 065 170 115 089 179 127 101 153 100 074 138 089 065 126 080 059
111 070 051 155 101 076 166 110 083 135 086 064 170 115 089 153 100 074 106 067
048 148 096 071 193 146 122 151 098 074 155 101 076 170 115 089 155 101 076 166
109 082 176 122 097 166 109 082 166 109 082 168 112 085 166 110 083 134 086 064
144 093 069 143 092 069 174 120 094 166 109 082 166 109 082 174 120 094 183 131
106 138 089 065 134 086 064 157 102 076 177 124 098 166 109 082 169 113 087 170
115 089 168 112 085 165 108 081 155 101 076 162 107 079 173 118 092 174 120 094
144 093 069 148 096 071 143 092 069 130 083 061 085 051 036 108 068 049 138 089
065 190 140 115 155 101 076 138 089 065 177 124 098 155 101 076 121 077 057 123
079 058 121 077 057 153 100 074 115 073 054 161 106 079 200 155 132 192 143 119
192 143 119 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 190 140 115 185 135 110
190 140 115 185 135 110 134 086 064 162 107 079 168 112 085 135 086 064 199 152
129 196 149 125 183 132 106 188 139 114 193 146 122 181 129 104 183 131 106 190
140 115 187 137 112 187 137 112 188 139 114 184 134 109 198 151 127 200 154 131
185 135 110 193 144 120 177 124 098 204 160 137 155 101 076 130 083 061 204 160
137 183 131 106 212 170 149 155 101 076 085 051 036 161 106 079 162 107 079 144
093 069 174 120 094 199 152 129 190 140 115 187 137 112 187 137 112 187 137 112
188 139 114 187 137 112 185 135 110 207 163 141 179 127 101 111 070 051 204 160
137 202 157 134 091 056 039 077 047 032 108 068 049 151 098 074 202 158 135 192
143 119 183 131 106 190 140 115 185 135 110 190 140 115 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 192
143 118 188 139 114 185 135 110 193 144 120 192 143 118 188 139 114 187 137 112
185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 190 140 115 183 131
106 181 129 104 183 131 106 190 140 115 193 144 120 190 140 115 187 137 112 193
144 120 190 140 115 183 131 106 183 132 106 200 155 132 204 160 137 174 120 094
117 074 054 151 098 074 165 108 081 198 151 127 181 129 104 185 135 110 185 135
110 183 131 106 183 132 106 190 140 115 204 160 137 176 122 097 168 112 085 123
079 058 121 077 057 157 102 076 096 059 042 165 108 081 207 163 141 204 160 137
200 155 132 200 154 131 187 137 112 199 152 129 190 140 115 174 120 094 185 135
110 193 144 120 185 135 110 188 139 114 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 183 131 106
187 137 112 190 140 115 190 140 115 190 140 115 185 135 110 190 140 115 190 140
115 185 135 110 196 149 125 190 140 115 121 077 057 134 086 064 155 101 076 174
120 094 155 101 076 151 098 074 155 101 076 130 083 061 179 127 101 183 132 106
165 108 081 146 095 071 183 131 106 169 113 087 153 100 074 153 100 074 169 113
087 151 098 074 138 089 065 134 086 064 174 119 093 174 120 094 173 118 092 170
115 089 173 118 092 179 127 101 169 113 087 170 115 089 183 131 106 162 107 079
111 070 051 174 119 093 179 127 101 170 115 089 165 108 081 155 101 076 173 118
092 181 129 104 140 090 067 140 090 067 174 120 094 169 113 087 168 112 085 168
112 085 168 112 085 169 113 087 166 109 082 155 101 076 153 100 074 170 115 089
166 110 083 144 093 069 181 129 104 170 115 089 104 066 047 114 072 052 173 118
092 155 101 076 064 036 024 138 089 065 213 171 150 200 155 132 185 135 110 185
135 110 169 113 087 146 095 071 115 073 054 151 098 074 200 155 132 183 131 106
190 140 115 193 144 120 193 144 120 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 183 132 106 185 135 110 183 131 106
200 155 132 162 107 079 111 070 051 166 109 082 155 101 076 162 107 079 199 152
129 193 144 120 184 134 109 188 139 114 188 139 114 185 135 110 188 139 114 187
137 112 187 137 112 187 137 112 183 132 106 209 166 144 173 118 092 170 115 089
193 146 122 185 135 110 190 140 115 200 155 132 155 101 076 093 057 041 199 152
129 204 160 137 174 120 094 093 057 041 170 115 089 153 100 074 130 083 061 170
115 089 064 036 024 161 106 079 202 158 135 184 134 109 188 139 114 187 137 112
187 137 112 187 137 112 188 139 114 185 135 110 202 157 134 166 110 083 190 140
115 185 135 110 123 079 058 200 155 132 085 051 036 102 063 046 202 157 134 184
134 109 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 190 140 115 185 135 110 187 137 112 193 144 120 188 139 114 185
135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 198 151 127 174 120 094 173
118 092 192 143 118 185 135 110 185 135 110 187 137 112 185 135 110 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 192 143 119 185 135
110 181 129 104 190 140 115 192 143 118 183 132 106 183 131 106 179 127 101 183
131 106 193 144 120 200 155 132 200 154 131 209 166 144 174 120 094 102 065 046
148 096 071 170 115 089 157 102 076 192 143 119 192 143 119 185 135 110 188 139
114 190 140 115 190 140 115 183 132 106 188 139 114 193 144 120 200 155 132 193
144 120 174 119 093 193 144 120 198 151 127 187 137 112 193 144 120 192 143 118
184 134 109 190 140 115 200 154 131 192 143 119 192 143 119 192 143 118 188 139
114 192 143 119 190 140 115 184 134 109 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 131 106
181 129 104 185 135 110 187 137 112 190 140 115 190 140 115 187 137 112 185 135
110 190 140 115 202 158 135 125 079 058 129 083 061 155 101 076 117 074 054 161
106 079 111 070 051 152 100 074 146 095 071 144 093 069 170 115 089 170 115 089
181 129 104 148 096 071 144 093 069 179 127 102 170 115 089 173 118 092 183 131
106 146 095 071 121 077 057 138 089 065 162 107 079 183 131 106 162 107 079 161
106 079 152 100 074 138 089 065 161 106 079 173 118 092 168 112 085 179 127 102
104 066 047 165 108 081 176 122 097 169 113 087 173 118 092 170 115 089 173 118
092 162 107 079 135 086 064 161 106 079 151 098 074 170 115 089 170 115 089 165
108 081 170 115 089 169 113 087 169 113 087 170 115 089 166 109 082 170 115 089
169 113 087 151 098 074 168 112 085 151 098 074 146 095 071 121 077 057 170 115
089 174 120 094 093 057 041 151 098 074 162 107 079 190 140 115 209 166 144 200
155 132 204 160 137 202 158 135 188 139 114 185 135 110 185 135 110 146 095 071
151 098 074 185 135 110 183 131 106 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 185 135 110 187 137 112 200 154 131
188 139 114 130 083 061 168 112 085 155 101 076 140 090 067 126 080 059 162 107
079 198 151 127 188 139 114 187 137 112 185 135 110 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 209 167 145 121 077 057 138 089 065
204 160 137 185 135 110 183 132 106 200 155 132 153 100 074 090 054 039 181 129
104 169 113 087 099 061 044 173 118 092 179 127 102 173 118 092 170 115 089 166
110 083 115 073 054 130 083 061 202 158 135 185 135 110 188 139 114 187 137 112
187 137 112 185 135 110 188 139 114 190 140 115 185 135 110 199 152 129 166 110
083 111 070 051 209 166 144 099 061 044 104 066 047 190 140 115 193 144 120 187
137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 183 131 106 185 135 110 192 143 118 185
135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 192
143 118 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 192 143 119 192 143
118 190 140 115 190 140 115 192 143 119 183 132 106 183 132 106 193 146 122 207
163 141 200 155 132 168 112 085 130 083 061 108 068 049 087 053 037 099 061 044
125 079 058 170 115 089 168 112 085 200 155 132 198 151 127 184 134 109 187 137
112 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 185 135 110 200
154 131 200 154 131 192 143 119 199 152 129 199 152 129 192 143 119 183 132 106
187 137 112 187 137 112 185 135 110 188 139 114 184 134 109 174 119 093 193 144
120 188 139 114 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 188 139 114
184 134 109 193 144 120 192 143 119 185 135 110 188 139 114 187 137 112 185 135
110 192 143 119 193 144 120 134 086 064 120 076 056 099 061 044 151 098 074 183
131 106 152 100 074 174 120 094 179 127 101 170 115 089 173 118 092 168 112 085
174 120 094 176 122 097 151 098 074 140 090 067 162 107 079 185 135 110 146 095
071 162 107 079 183 131 106 183 132 106 129 083 061 138 089 065 148 096 071 157
102 076 161 106 079 153 100 074 157 102 076 157 102 076 126 080 059 153 100 074
170 115 089 134 086 064 169 113 087 174 119 093 170 115 089 170 115 089 176 122
097 157 102 076 130 083 061 183 131 106 148 096 071 157 102 076 170 115 089 170
115 089 174 119 093 169 113 087 162 107 079 170 115 089 173 118 092 173 118 092
174 119 093 166 110 083 143 092 069 136 087 064 135 086 064 120 076 056 121 077
057 115 073 054 166 110 083 151 098 074 085 051 036 082 050 035 102 063 046 123
079 058 157 102 076 209 166 144 202 158 135 193 144 120 192 143 118 193 146 122
185 135 110 181 129 104 181 129 104 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 185 135 110 193 146 122 183 132 106 202 158 135
173 118 092 134 086 064 168 112 085 179 127 102 170 115 089 130 083 061 173 118
092 198 151 127 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 184 134 109 193 144 120 181 129 104 176 122 097
200 155 132 192 143 119 179 127 102 198 151 127 144 093 069 123 079 058 152 100
074 143 092 069 126 080 059 174 120 094 166 109 082 151 098 074 177 124 098 162
107 079 130 083 061 140 090 067 207 161 140 184 134 109 188 139 114 187 137 112
187 137 112 187 137 112 192 143 118 185 135 110 184 134 109 200 154 131 165 108
081 114 072 052 104 066 047 078 047 032 207 163 141 204 160 137 183 131 106 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 190 140 115 183 131 106 183 131 106 190 140 115 185
135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 183 131 106 184 134
109 192 143 118 199 152 129 202 158 135 200 155 132 204 160 137 212 170 149 155
101 076 102 063 046 068 041 028 069 041 028 123 079 058 126 080 059 123 079 058
106 067 048 126 080 059 129 083 061 188 139 114 193 144 120 185 135 110 187 137
112 188 139 114 187 137 112 190 140 115 192 143 119 187 137 112 184 134 109 188
139 114 187 137 112 183 131 106 185 135 110 181 129 104 179 127 102 185 135 110
192 143 118 184 134 109 183 132 106 196 149 125 176 122 097 165 108 081 198 151
127 183 132 106 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
193 146 122 177 124 098 168 112 085 193 146 122 187 137 112 190 140 115 190 140
115 198 151 127 174 119 093 151 098 074 176 122 097 170 115 089 183 131 106 140
090 067 152 100 074 176 122 097 166 110 083 168 112 085 170 115 089 168 112 085
174 119 093 174 119 093 170 115 089 162 107 079 153 100 074 144 093 069 111 070
051 162 107 079 170 115 089 170 115 089 174 120 094 168 112 085 168 112 085 174
120 094 177 124 098 179 127 101 168 112 085 176 122 097 174 119 093 136 087 064
193 146 122 170 115 089 162 107 079 170 115 089 170 115 089 166 109 082 174 120
094 174 120 094 135 086 064 179 127 101 183 131 106 166 110 083 157 102 076 170
115 089 170 115 089 169 113 087 161 106 079 165 108 081 166 109 082 166 109 082
169 113 087 166 110 083 126 080 059 134 086 064 151 098 074 093 057 041 098 061
044 173 118 092 202 157 134 130 083 061 121 077 057 151 098 074 146 095 071 120
076 056 090 054 039 099 061 044 162 107 079 196 149 125 209 166 144 192 143 119
198 151 127 192 143 119 193 144 120 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 193 144 120 193 144 120
134 086 064 166 110 083 170 115 089 170 115 089 179 127 101 144 093 069 188 139
114 204 160 137 183 131 106 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 192 143 119 199 152 129 192 143 119
204 160 137 207 163 141 193 146 122 176 122 097 096 059 042 151 098 074 181 129
104 170 115 089 174 119 093 162 107 079 173 118 092 123 079 058 120 076 056 126
080 059 104 066 047 179 127 101 200 155 132 183 132 106 188 139 114 187 137 112
185 135 110 187 137 112 192 143 118 184 134 109 192 143 119 193 144 120 143 092
069 115 073 054 165 108 081 190 140 115 192 143 118 192 143 118 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 185 135 110 183 132 106 184 134 109 188
139 114 188 139 114 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 192 143 119 183 131 106 183
131 106 190 140 115 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137
112 188 139 114 188 139 114 187 137 112 185 135 110 188 139 114 187 137 112 187
137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 185 135 110 183 131 106 185 135 110 198 151 127 207 161
140 209 166 144 173 118 092 126 080 059 162 107 079 192 143 118 168 112 085 111
070 051 070 042 028 162 107 079 123 079 058 121 077 057 144 093 069 126 080 059
151 098 074 140 090 067 162 107 079 196 149 125 190 140 115 190 140 115 190 140
115 185 135 110 185 135 110 183 131 106 184 134 109 185 135 110 187 137 112 183
131 106 183 131 106 187 137 112 192 143 118 184 134 109 190 140 115 184 134 109
185 135 110 188 139 114 188 139 114 193 144 120 157 102 076 183 131 106 193 144
120 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 190 140 115
192 143 118 190 140 115 168 112 085 174 120 094 193 144 120 185 135 110 185 135
110 193 146 122 185 135 110 138 089 065 179 127 101 184 134 109 143 092 069 153
100 074 140 090 067 144 093 069 151 098 074 144 093 069 148 096 071 143 092 069
135 086 064 174 120 094 169 113 087 170 115 089 173 118 092 155 101 076 155 101
076 152 100 074 143 092 069 126 080 059 170 115 089 170 115 089 168 112 085 170
115 089 169 113 087 169 113 087 170 115 089 168 112 085 173 118 092 151 098 074
134 086 064 181 129 104 170 115 089 166 109 082 174 120 094 170 115 089 168 112
085 179 127 102 170 115 089 135 086 064 174 119 093 174 120 094 166 110 083 168
112 085 168 112 085 173 118 092 170 115 089 166 109 082 166 109 082 169 113 087
170 115 089 168 112 085 140 090 067 176 122 097 168 112 085 099 061 044 162 107
079 207 161 140 170 115 089 121 077 057 153 100 074 183 131 106 153 100 074 179
127 101 179 127 102 135 086 064 121 077 057 111 070 051 170 115 089 198 151 127
200 155 132 198 151 127 187 137 112 185 135 110 187 137 112 185 135 110 188 139
114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 188 139 114 188 139 114 190 140 115 183 132 106 204 160 137 155 101 076
138 089 065 184 134 109 166 109 082 165 108 081 146 095 071 143 092 069 155 101
076 185 135 110 199 152 129 190 140 115 183 131 106 188 139 114 188 139 114 187
137 112 188 139 114 185 135 110 188 139 114 183 131 106 183 132 106 192 143 118
170 115 089 152 100 074 193 144 120 193 144 120 104 066 047 136 087 064 179 127
102 169 113 087 165 108 081 173 118 092 170 115 089 161 106 079 155 101 076 093
057 041 143 092 069 202 157 134 183 131 106 188 139 114 187 137 112 187 137 112
185 135 110 188 139 114 196 149 125 184 134 109 199 152 129 174 120 094 121 077
057 111 070 051 198 151 127 200 155 132 174 119 093 196 149 125 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 190 140 115 185 135 110 188 139 114 187 137 112 183 131 106 188
139 114 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190 140 115 190
140 115 185 135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192 143 119 187 137
112 179 127 102 184 134 109 196 149 125 185 135 110 187 137 112 187 137 112 185
135 110 192 143 118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112
185 135 110 185 135 110 196 149 125 207 161 140 198 151 127 187 137 112 170 115
089 104 066 047 104 066 047 080 048 033 085 051 036 136 087 064 111 070 051 134
086 064 104 066 047 165 108 081 162 107 079 126 080 059 204 160 137 192 143 119
193 144 120 193 146 122 193 146 122 192 143 119 187 137 112 185 135 110 192 143
118 190 140 115 200 155 132 200 155 132 179 127 102 198 151 127 202 157 134 196
149 125 207 161 140 202 157 134 188 139 114 193 144 120 193 146 122 193 146 122
192 143 119 192 143 119 192 143 119 185 135 110 165 108 081 184 134 109 188 139
114 184 134 109 192 143 118 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115
183 131 106 174 120 094 174 119 093 170 115 089 192 143 118 187 137 112 187 137
112 184 134 109 204 160 137 155 101 076 117 074 054 148 096 071 136 087 064 179
127 102 168 112 085 168 112 085 170 115 089 170 115 089 174 119 093 173 118 092
143 092 069 165 108 081 173 118 092 170 115 089 170 115 089 174 120 094 179 127
102 173 118 092 174 120 094 155 101 076 146 095 071 174 120 094 168 112 085 168
112 085 168 112 085 166 110 083 174 119 093 168 112 085 166 110 083 176 122 097
151 098 074 138 089 065 174 120 094 169 113 087 173 118 092 170 115 089 166 109
082 168 112 085 174 120 094 151 098 074 144 093 069 176 122 097 173 118 092 170
115 089 168 112 085 170 115 089 173 118 092 166 109 082 169 113 087 170 115 089
170 115 089 183 131 106 152 100 074 157 102 076 089 054 039 170 115 089 199 152
129 198 151 127 146 095 071 129 083 061 152 100 074 151 098 074 121 077 057 143
092 069 170 115 089 185 135 110 177 124 098 155 101 076 102 065 046 144 093 069
173 118 092 185 135 110 196 149 125 192 143 118 192 143 118 193 144 120 185 135
110 184 134 109 190 140 115 187 137 112 187 137 112 187 137 112 190 140 115 190
140 115 185 135 110 184 134 109 179 127 102 185 135 110 196 149 125 143 092 069
152 100 074 176 122 097 162 107 079 166 110 083 162 107 079 161 106 079 168 112
085 138 089 065 170 115 089 200 155 132 192 143 119 184 134 109 183 132 106 183
131 106 185 135 110 192 143 119 183 131 106 183 131 106 198 151 127 193 146 122
135 086 064 138 089 065 155 101 076 170 115 089 115 073 054 162 107 079 183 131
106 121 077 057 168 112 085 183 131 106 138 089 065 179 127 101 129 083 061 121
077 057 188 139 114 207 161 140 183 132 106 185 135 110 187 137 112 190 140 115
187 137 112 192 143 119 193 144 120 179 127 102 192 143 119 199 152 129 115 073
054 102 063 046 162 107 079 202 157 134 192 143 119 184 134 109 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 132 106 192 143
118 188 139 114 183 131 106 181 129 104 213 171 150 196 149 125 187 137 112 185
135 110 179 127 101 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112
199 152 129 200 154 131 200 155 132 187 137 112 166 110 083 072 043 030 089 054
039 121 077 057 152 100 074 121 077 057 170 115 089 169 113 087 155 101 076 144
093 069 155 101 076 148 096 071 166 109 082 121 077 057 184 134 109 202 158 135
190 140 115 192 143 118 190 140 115 187 137 112 187 137 112 185 135 110 188 139
114 190 140 115 162 107 079 146 095 071 193 144 120 181 129 104 177 124 098 188
139 114 151 098 074 179 127 102 200 155 132 187 137 112 179 127 101 170 115 089
174 120 094 183 131 106 183 132 106 188 139 114 190 140 115 190 140 115 187 137
112 183 132 106 188 139 114 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 183 132 106 192 143 118 192 143 119 187 137 112 187 137 112 188 139
114 184 134 109 200 155 132 185 135 110 144 093 069 170 115 089 181 129 104 166
110 083 166 109 082 169 113 087 169 113 087 169 113 087 174 119 093 166 110 083
155 101 076 174 120 094 168 112 085 169 113 087 170 115 089 168 112 085 165 108
081 169 113 087 173 118 092 177 124 098 168 112 085 168 112 085 166 109 082 170
115 089 153 100 074 146 095 071 168 112 085 169 113 087 169 113 087 170 115 089
174 119 093 144 093 069 168 112 085 166 110 083 170 115 089 170 115 089 174 120
094 166 110 083 170 115 089 168 112 085 151 098 074 169 113 087 170 115 089 170
115 089 170 115 089 170 115 089 169 113 087 169 113 087 173 118 092 168 112 085
168 112 085 174 120 094 170 115 089 098 061 044 082 050 035 198 151 127 200 155
132 174 120 094 120 076 056 134 086 064 121 077 057 162 107 079 181 129 104 166
110 083 136 087 064 168 112 085 183 131 106 190 140 115 169 113 087 144 093 069
121 077 057 138 089 065 183 131 106 198 151 127 192 143 119 188 139 114 185 135
110 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 190 140 115 190
140 115 185 135 110 185 135 110 192 143 118 198 151 127 183 131 106 144 093 069
155 101 076 170 115 089 169 113 087 170 115 089 170 115 089 168 112 085 170 115
089 168 112 085 096 059 042 157 102 076 209 166 144 193 144 120 184 134 109 185
135 110 185 135 110 196 149 125 192 143 118 200 155 132 181 129 104 202 158 135
143 092 069 152 100 074 174 120 094 123 079 058 108 068 049 162 107 079 144 093
069 120 076 056 174 120 094 173 118 092 168 112 085 111 070 051 114 072 052 204
160 137 200 155 132 179 127 101 192 143 119 193 146 122 185 135 110 185 135 110
185 135 110 193 144 120 190 140 115 179 127 101 190 140 115 209 166 144 144 093
069 082 050 035 161 106 079 200 154 131 190 140 115 183 132 106 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 190 140
115 190 140 115 185 135 110 198 151 127 152 100 074 181 129 104 193 144 120 185
135 110 190 140 115 183 131 106 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110
199 152 129 190 140 115 121 077 057 091 056 039 106 067 048 144 093 069 111 070
051 173 118 092 111 070 051 121 077 057 170 115 089 134 086 064 185 135 110 170
115 089 138 089 065 169 113 087 179 127 102 099 061 044 126 080 059 204 160 137
184 134 109 185 135 110 185 135 110 187 137 112 183 132 106 185 135 110 193 144
120 184 134 109 140 090 067 162 107 079 202 158 135 188 139 114 115 073 054 082
050 035 064 036 024 093 057 041 138 089 065 146 095 071 185 135 110 151 098 074
168 112 085 188 139 114 190 140 115 188 139 114 190 140 115 181 129 104 188 139
114 188 139 114 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 193 146 122
192 143 119 192 143 118 192 143 119 192 143 118 185 135 110 187 137 112 187 137
112 185 135 110 193 144 120 183 132 106 157 102 076 173 118 092 168 112 085 168
112 085 170 115 089 168 112 085 168 112 085 166 109 082 176 122 097 151 098 074
144 093 069 176 122 097 166 110 083 168 112 085 168 112 085 169 113 087 166 110
083 173 118 092 177 124 098 140 090 067 151 098 074 174 119 093 170 115 089 179
127 101 166 109 082 136 087 064 170 115 089 173 118 092 166 110 083 166 109 082
173 118 092 151 098 074 162 107 079 174 119 093 179 127 101 166 109 082 157 102
076 168 112 085 179 127 102 166 109 082 155 101 076 177 124 098 162 107 079 165
108 081 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089 166 109 082
170 115 089 170 115 089 165 108 081 130 083 061 173 118 092 193 144 120 204 160
137 153 100 074 134 086 064 174 120 094 151 098 074 170 115 089 170 115 089 170
115 089 162 107 079 140 090 067 153 100 074 143 092 069 108 068 049 179 127 102
193 146 122 170 115 089 134 086 064 170 115 089 193 146 122 192 143 118 192 143
119 183 131 106 190 140 115 187 137 112 187 137 112 187 137 112 185 135 110 185
135 110 187 137 112 192 143 118 192 143 119 200 155 132 170 115 089 138 089 065
165 108 081 168 112 085 170 115 089 170 115 089 168 112 085 168 112 085 168 112
085 151 098 074 157 102 076 115 073 054 144 093 069 199 152 129 200 154 131 190
140 115 183 132 106 187 137 112 198 151 127 181 129 104 198 151 127 199 152 129
125 079 058 155 101 076 174 120 094 106 067 048 111 070 051 162 107 079 144 093
069 115 073 054 125 079 058 099 061 044 115 073 054 114 072 052 196 149 125 200
155 132 168 112 085 072 043 030 170 115 089 200 154 131 188 139 114 187 137 112
184 134 109 187 137 112 193 144 120 184 134 109 185 135 110 198 151 127 170 115
089 144 093 069 173 118 092 193 144 120 185 135 110 185 135 110 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 185 135
110 190 140 115 204 160 137 209 166 144 037 019 011 130 083 061 204 160 137 185
135 110 199 152 129 193 144 120 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 199 152 129
183 131 106 085 051 036 085 051 036 155 101 076 099 061 044 130 083 061 170 115
089 151 098 074 126 080 059 099 061 044 190 140 115 204 160 137 193 146 122 200
154 131 183 131 106 152 100 074 183 132 106 170 115 089 144 093 069 193 146 122
190 140 115 185 135 110 188 139 114 192 143 118 185 135 110 184 134 109 190 140
115 200 154 131 174 120 094 193 144 120 169 113 087 190 140 115 185 135 110 091
056 039 130 083 061 138 089 065 143 092 069 183 131 106 200 155 132 198 151 127
192 143 118 192 143 118 188 139 114 192 143 118 190 140 115 183 131 106 192 143
119 190 140 115 183 132 106 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112
185 135 110 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 188 139
114 183 131 106 202 157 134 176 122 097 143 092 069 179 127 101 168 112 085 166
109 082 170 115 089 170 115 089 170 115 089 169 113 087 174 120 094 151 098 074
151 098 074 170 115 089 166 110 083 168 112 085 169 113 087 170 115 089 173 118
092 174 120 094 151 098 074 106 067 048 146 095 071 144 093 069 151 098 074 177
124 098 166 109 082 166 109 082 170 115 089 168 112 085 169 113 087 162 107 079
170 115 089 162 107 079 174 119 093 166 109 082 115 073 054 153 100 074 179 127
102 174 120 094 170 115 089 143 092 069 126 080 059 168 112 085 174 120 094 162
107 079 168 112 085 168 112 085 168 112 085 170 115 089 168 112 085 168 112 085
173 118 092 170 115 089 136 087 064 168 112 085 202 157 134 200 155 132 170 115
089 130 083 061 151 098 074 168 112 085 168 112 085 170 115 089 170 115 089 170
115 089 174 119 093 170 115 089 168 112 085 161 106 079 155 101 076 146 095 071
135 086 064 169 113 087 170 115 089 134 086 064 170 115 089 202 158 135 185 135
110 187 137 112 188 139 114 187 137 112 188 139 114 187 137 112 187 137 112 187
137 112 184 134 109 190 140 115 198 151 127 202 157 134 170 115 089 146 095 071
168 112 085 168 112 085 168 112 085 170 115 089 168 112 085 168 112 085 168 112
085 153 100 074 179 127 101 153 100 074 102 065 046 151 098 074 184 134 109 193
144 120 192 143 118 183 132 106 184 134 109 183 131 106 209 166 144 138 089 065
111 070 051 187 137 112 157 102 076 120 076 056 117 074 054 138 089 065 146 095
071 108 068 049 161 106 079 143 092 069 074 043 030 135 086 064 192 143 118 200
155 132 181 129 104 146 095 071 138 089 065 184 134 109 188 139 114 190 140 115
192 143 118 192 143 118 185 135 110 183 131 106 190 140 115 192 143 119 193 146
122 209 167 145 200 155 132 196 149 125 183 131 106 185 135 110 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 198 151
127 200 154 131 181 129 104 117 074 054 183 131 106 204 160 137 183 132 106 187
137 112 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188
139 114 185 135 110 190 140 115 185 135 110 190 140 115 185 135 110 200 154 131
170 115 089 102 065 046 155 101 076 179 127 102 170 115 089 162 107 079 136 087
064 135 086 064 162 107 079 176 122 097 199 152 129 183 132 106 183 132 106 187
137 112 199 152 129 155 101 076 134 086 064 179 127 102 148 096 071 155 101 076
200 155 132 200 154 131 198 151 127 192 143 119 193 144 120 198 151 127 200 154
131 193 144 120 126 080 059 121 077 057 096 059 042 144 093 069 179 127 101 199
152 129 207 161 140 185 135 110 199 152 129 202 157 134 185 135 110 187 137 112
187 137 112 184 134 109 190 140 115 188 139 114 187 137 112 193 144 120 188 139
114 187 137 112 192 143 118 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 132 106
183 132 106 187 137 112 179 127 102 184 134 109 190 140 115 187 137 112 187 137
112 188 139 114 198 151 127 153 100 074 155 101 076 168 112 085 168 112 085 157
102 076 168 112 085 169 113 087 170 115 089 168 112 085 170 115 089 155 101 076
166 109 082 174 120 094 170 115 089 165 108 081 170 115 089 176 122 097 170 115
089 144 093 069 144 093 069 170 115 089 176 122 097 170 115 089 153 100 074 126
080 059 162 107 079 174 120 094 176 122 097 169 113 087 166 109 082 166 110 083
169 113 087 144 093 069 135 086 064 130 083 061 104 066 047 168 112 085 169 113
087 134 086 064 144 093 069 169 113 087 162 107 079 153 100 074 179 127 102 174
120 094 170 115 089 176 122 097 179 127 101 176 122 097 179 127 101 174 119 093
169 113 087 176 122 097 130 083 061 153 100 074 200 155 132 165 108 081 098 061
044 153 100 074 168 112 085 157 102 076 179 127 101 169 113 087 161 106 079 168
112 085 166 110 083 170 115 089 170 115 089 173 118 092 183 131 106 179 127 102
148 096 071 136 087 064 179 127 102 165 108 081 129 083 061 185 135 110 200 155
132 185 135 110 185 135 110 187 137 112 185 135 110 190 140 115 187 137 112 185
135 110 198 151 127 193 146 122 144 093 069 177 124 098 179 127 101 161 106 079
174 119 093 170 115 089 168 112 085 169 113 087 162 107 079 173 118 092 174 119
093 179 127 102 157 102 076 157 102 076 168 112 085 151 098 074 138 089 065 185
135 110 204 160 137 190 140 115 196 149 125 196 149 125 169 113 087 111 070 051
136 087 064 187 137 112 144 093 069 130 083 061 166 110 083 121 077 057 108 068
049 151 098 074 144 093 069 138 089 065 102 063 046 165 108 081 155 101 076 169
113 087 200 154 131 173 118 092 115 073 054 204 160 137 202 158 135 196 149 125
190 140 115 183 131 106 184 134 109 188 139 114 193 144 120 187 137 112 199 152
129 188 139 114 183 131 106 185 135 110 181 129 104 185 135 110 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 190 140 115 170 115
089 174 119 093 157 102 076 179 127 102 200 154 131 190 140 115 185 135 110 190
140 115 185 135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 192 143 119 187
137 112 185 135 110 193 144 120 198 151 127 188 139 114 185 135 110 200 155 132
193 144 120 111 070 051 111 070 051 161 106 079 162 107 079 144 093 069 117 074
054 168 112 085 162 107 079 192 143 118 193 144 120 185 135 110 188 139 114 183
132 106 198 151 127 183 132 106 153 100 074 166 110 083 153 100 074 179 127 101
200 155 132 166 109 082 165 108 081 170 115 089 196 149 125 176 122 097 157 102
076 114 072 052 136 087 064 170 115 089 198 151 127 204 160 137 173 118 092 168
112 085 183 132 106 200 155 132 185 135 110 183 131 106 187 137 112 188 139 114
187 137 112 188 139 114 188 139 114 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
188 139 114 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 185 135
110 198 151 127 183 131 106 111 070 051 153 100 074 162 107 079 157 102 076 151
098 074 174 119 093 162 107 079 173 118 092 166 110 083 170 115 089 151 098 074
165 108 081 169 113 087 169 113 087 174 119 093 176 122 097 165 108 081 140 090
067 157 102 076 181 129 104 174 119 093 169 113 087 170 115 089 170 115 089 170
115 089 138 089 065 143 092 069 174 120 094 174 119 093 170 115 089 174 120 094
166 109 082 155 101 076 174 120 094 184 134 109 138 089 065 093 057 041 152 100
074 166 110 083 170 115 089 181 129 104 176 122 097 126 080 059 144 093 069 146
095 071 148 096 071 148 096 071 140 090 067 146 095 071 134 086 064 136 087 064
162 107 079 183 131 106 098 061 044 170 115 089 204 160 137 129 083 061 170 115
089 174 120 094 165 108 081 166 110 083 151 098 074 170 115 089 166 110 083 165
108 081 168 112 085 170 115 089 166 110 083 165 108 081 170 115 089 179 127 101
179 127 102 152 100 074 166 109 082 185 135 110 176 122 097 138 089 065 190 140
115 192 143 118 190 140 115 192 143 118 185 135 110 185 135 110 185 135 110 200
155 132 192 143 119 144 093 069 157 102 076 143 092 069 102 063 046 173 118 092
162 107 079 162 107 079 161 106 079 165 108 081 162 107 079 162 107 079 153 100
074 168 112 085 174 120 094 168 112 085 169 113 087 166 109 082 148 096 071 165
108 081 146 095 071 146 095 071 192 143 118 193 146 122 102 063 046 106 067 048
161 106 079 179 127 101 146 095 071 166 110 083 162 107 079 134 086 064 096 059
042 115 073 054 130 083 061 111 070 051 130 083 061 179 127 102 155 101 076 102
065 046 166 110 083 161 106 079 130 083 061 155 101 076 168 112 085 176 122 097
198 151 127 196 149 125 193 144 120 190 140 115 181 129 104 198 151 127 193 146
122 200 154 131 174 119 093 179 127 101 188 139 114 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 177 124
098 190 140 115 193 144 120 193 146 122 183 131 106 187 137 112 188 139 114 187
137 112 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 193 144 120 183 132 106 183 132 106 190
140 115 199 152 129 190 140 115 162 107 079 183 132 106 202 158 135 200 155 132
135 086 064 074 043 030 140 090 067 174 120 094 162 107 079 135 086 064 143 092
069 155 101 076 152 100 074 199 152 129 190 140 115 187 137 112 188 139 114 188
139 114 187 137 112 193 144 120 198 151 127 198 151 127 193 144 120 193 146 122
193 144 120 153 100 074 111 070 051 104 066 047 130 083 061 123 079 058 126 080
059 125 079 058 183 132 106 202 157 134 198 151 127 161 106 079 174 119 093 177
124 098 179 127 101 192 143 118 187 137 112 188 139 114 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 193 144 120 168 112 085 165 108 081 183 132 106 151 098 074 134
086 064 181 129 104 170 115 089 166 109 082 170 115 089 174 120 094 152 100 074
165 108 081 174 119 093 176 122 097 173 118 092 144 093 069 143 092 069 169 113
087 174 120 094 166 110 083 170 115 089 177 124 098 146 095 071 134 086 064 173
118 092 170 115 089 157 102 076 136 087 064 169 113 087 179 127 101 173 118 092
138 089 065 146 095 071 170 115 089 152 100 074 155 101 076 157 102 076 179 127
101 174 120 094 168 112 085 169 113 087 169 113 087 136 087 064 148 096 071 151
098 074 151 098 074 153 100 074 151 098 074 138 089 065 153 100 074 170 115 089
130 083 061 123 079 058 162 107 079 198 151 127 190 140 115 129 083 061 174 120
094 174 119 093 170 115 089 170 115 089 155 101 076 168 112 085 168 112 085 168
112 085 168 112 085 168 112 085 169 113 087 176 122 097 151 098 074 161 106 079
138 089 065 135 086 064 179 127 102 140 090 067 121 077 057 117 074 054 196 149
125 202 158 135 183 131 106 187 137 112 190 140 115 184 134 109 183 131 106 202
158 135 184 134 109 082 050 035 166 110 083 187 137 112 143 092 069 168 112 085
166 110 083 162 107 079 168 112 085 170 115 089 162 107 079 166 109 082 169 113
087 138 089 065 151 098 074 165 108 081 148 096 071 169 113 087 155 101 076 166
110 083 126 080 059 152 100 074 120 076 056 155 101 076 136 087 064 069 041 028
179 127 101 179 127 101 126 080 059 155 101 076 161 106 079 093 057 041 152 100
074 155 101 076 082 050 035 096 059 042 120 076 056 104 066 047 099 061 044 170
115 089 162 107 079 162 107 079 168 112 085 138 089 065 140 090 067 130 083 061
138 089 065 162 107 079 184 134 109 202 158 135 190 140 115 188 139 114 102 065
046 161 106 079 202 158 135 192 143 119 193 146 122 193 146 122 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 184 134 109 193 144 120 196 149
125 192 143 119 192 143 118 192 143 118 185 135 110 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 198 151 127 183 131 106 181 129 104 192
143 118 198 151 127 134 086 064 093 057 041 196 149 125 188 139 114 136 087 064
091 056 039 129 083 061 170 115 089 183 131 106 169 113 087 134 086 064 099 061
044 144 093 069 168 112 085 198 151 127 185 135 110 187 137 112 187 137 112 192
143 118 183 131 106 174 120 094 192 143 119 190 140 115 193 144 120 190 140 115
193 144 120 200 155 132 187 137 112 174 119 093 192 143 118 192 143 118 198 151
127 207 161 140 179 127 102 185 135 110 176 122 097 169 113 087 196 149 125 193
144 120 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 187 137
112 184 134 109 193 146 122 199 152 129 144 093 069 174 120 094 166 109 082 136
087 064 143 092 069 174 120 094 168 112 085 168 112 085 168 112 085 155 101 076
176 122 097 183 131 106 151 098 074 130 083 061 152 100 074 173 118 092 174 119
093 170 115 089 168 112 085 162 107 079 181 129 104 166 109 082 130 083 061 162
107 079 173 118 092 174 119 093 170 115 089 121 077 057 136 087 064 148 096 071
144 093 069 155 101 076 157 102 076 162 107 079 184 134 109 183 131 106 157 102
076 166 109 082 168 112 085 168 112 085 170 115 089 166 109 082 170 115 089 170
115 089 170 115 089 176 122 097 183 131 106 174 119 093 166 110 083 185 135 110
166 110 083 090 054 039 200 155 132 200 154 131 148 096 071 126 080 059 173 118
092 170 115 089 166 110 083 168 112 085 162 107 079 166 110 083 161 106 079 165
108 081 162 107 079 170 115 089 179 127 101 143 092 069 144 093 069 155 101 076
155 101 076 170 115 089 162 107 079 099 061 044 134 086 064 193 144 120 200 154
131 185 135 110 192 143 119 192 143 119 198 151 127 190 140 115 200 155 132 166
109 082 136 087 064 162 107 079 155 101 076 176 122 097 174 120 094 166 109 082
176 122 097 166 110 083 168 112 085 169 113 087 166 110 083 170 115 089 170 115
089 170 115 089 170 115 089 162 107 079 162 107 079 148 096 071 165 108 081 176
122 097 166 109 082 185 135 110 181 129 104 135 086 064 161 106 079 102 063 046
157 102 076 162 107 079 174 119 093 123 079 058 091 056 039 117 074 054 148 096
071 115 073 054 120 076 056 144 093 069 155 101 076 121 077 057 155 101 076 162
107 079 151 098 074 166 110 083 161 106 079 165 108 081 161 106 079 166 110 083
135 086 064 121 077 057 111 070 051 140 090 067 202 158 135 212 168 148 078 047
032 065 038 025 209 166 144 190 140 115 176 122 097 192 143 119 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 185 135
110 187 137 112 188 139 114 190 140 115 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 193 144 120 179 127 101 192 143 119 204
160 137 144 093 069 104 066 047 200 155 132 193 146 122 155 101 076 099 061 044
138 089 065 170 115 089 161 106 079 169 113 087 157 102 076 138 089 065 138 089
065 166 109 082 146 095 071 196 149 125 192 143 119 187 137 112 187 137 112 188
139 114 187 137 112 192 143 118 192 143 119 184 134 109 193 144 120 193 144 120
187 137 112 188 139 114 192 143 119 207 163 141 188 139 114 170 115 089 204 160
137 126 080 059 129 083 061 198 151 127 157 102 076 190 140 115 192 143 119 184
134 109 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 192 143 118 200 155 132 168 112 085 153 100 074 183 131 106 168
112 085 126 080 059 183 131 106 174 120 094 168 112 085 165 108 081 144 093 069
146 095 071 143 092 069 146 095 071 173 118 092 176 122 097 168 112 085 169 113
087 168 112 085 168 112 085 155 101 076 152 100 074 169 113 087 183 131 106 155
101 076 166 109 082 166 110 083 126 080 059 155 101 076 179 127 101 168 112 085
174 120 094 174 119 093 168 112 085 169 113 087 168 112 085 168 112 085 169 113
087 168 112 085 166 110 083 170 115 089 162 107 079 162 107 079 174 119 093 166
109 082 166 110 083 166 110 083 170 115 089 170 115 089 165 108 081 179 127 102
151 098 074 151 098 074 200 155 132 162 107 079 115 073 054 152 100 074 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 174 119 093 168 112 085 170
115 089 169 113 087 179 127 101 151 098 074 099 061 044 199 152 129 177 124 098
166 110 083 111 070 051 091 056 039 196 149 125 212 168 148 193 146 122 192 143
118 190 140 115 193 146 122 193 146 122 192 143 119 200 155 132 187 137 112 140
090 067 144 093 069 181 129 104 138 089 065 135 086 064 183 131 106 148 096 071
161 106 079 162 107 079 173 118 092 174 120 094 169 113 087 170 115 089 166 110
083 173 118 092 170 115 089 161 106 079 177 124 098 173 118 092 179 127 101 146
095 071 143 092 069 183 131 106 161 106 079 129 083 061 148 096 071 134 086 064
099 061 044 176 122 097 174 120 094 144 093 069 104 066 047 135 086 064 130 083
061 115 073 054 161 106 079 151 098 074 144 093 069 144 093 069 144 093 069 143
092 069 166 109 082 166 109 082 161 106 079 136 087 064 114 072 052 129 083 061
153 100 074 169 113 087 162 107 079 070 042 028 126 080 059 212 170 149 170 115
089 078 047 032 190 140 115 185 135 110 169 113 087 177 124 098 190 140 115 192
143 118 192 143 118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135 110 183 132
106 187 137 112 185 135 110 183 132 106 187 137 112 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 174 120 094 193 144 120 204 160 137 199
152 129 074 043 030 190 140 115 200 154 131 129 083 061 111 070 051 126 080 059
155 101 076 151 098 074 153 100 074 157 102 076 166 109 082 126 080 059 174 119
093 168 112 085 106 067 048 176 122 097 193 144 120 188 139 114 190 140 115 185
135 110 185 135 110 192 143 118 185 135 110 181 129 104 179 127 102 185 135 110
185 135 110 183 132 106 184 134 109 196 149 125 161 106 079 111 070 051 188 139
114 204 160 137 174 120 094 174 119 093 192 143 118 193 146 122 190 140 115 190
140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 188 139 114 184 134 109 185 135 110 196 149 125 135 086 064 166 110 083 179
127 102 111 070 051 146 095 071 148 096 071 168 112 085 185 135 110 136 087 064
117 074 054 161 106 079 174 120 094 173 118 092 166 110 083 168 112 085 170 115
089 170 115 089 166 110 083 170 115 089 153 100 074 155 101 076 170 115 089 166
110 083 152 100 074 134 086 064 161 106 079 181 129 104 173 118 092 170 115 089
168 112 085 168 112 085 170 115 089 162 107 079 162 107 079 166 110 083 170 115
089 170 115 089 170 115 089 170 115 089 155 101 076 153 100 074 174 119 093 168
112 085 169 113 087 165 108 081 157 102 076 169 113 087 174 119 093 151 098 074
134 086 064 209 166 144 188 139 114 130 083 061 138 089 065 179 127 101 168 112
085 155 101 076 170 115 089 170 115 089 170 115 089 166 109 082 170 115 089 168
112 085 174 120 094 179 127 101 102 065 046 114 072 052 190 140 115 199 152 129
209 166 144 170 115 089 157 102 076 190 140 115 111 070 051 129 083 061 138 089
065 121 077 057 136 087 064 151 098 074 120 076 056 138 089 065 148 096 071 151
098 074 177 124 098 181 129 104 134 086 064 165 108 081 173 118 092 170 115 089
166 110 083 162 107 079 170 115 089 168 112 085 166 109 082 170 115 089 169 113
087 166 109 082 170 115 089 169 113 087 174 119 093 176 122 097 183 131 106 170
115 089 143 092 069 169 113 087 170 115 089 169 113 087 168 112 085 170 115 089
089 054 039 115 073 054 177 124 098 152 100 074 115 073 054 115 073 054 134 086
064 161 106 079 144 093 069 146 095 071 135 086 064 120 076 056 148 096 071 144
093 069 135 086 064 125 079 058 111 070 051 144 093 069 165 108 081 134 086 064
135 086 064 146 095 071 162 107 079 169 113 087 077 047 032 134 086 064 212 168
148 187 137 112 183 131 106 200 155 132 198 151 127 183 131 106 190 140 115 183
132 106 184 134 109 190 140 115 185 135 110 188 139 114 187 137 112 187 137 112
188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139
114 188 139 114 188 139 114 187 137 112 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 185 135
110 185 135 110 190 140 115 185 135 110 196 149 125 193 144 120 187 137 112 082
050 035 126 080 059 200 155 132 166 110 083 120 076 056 111 070 051 168 112 085
162 107 079 170 115 089 162 107 079 129 083 061 130 083 061 153 100 074 157 102
076 134 086 064 136 087 064 204 160 137 193 144 120 183 131 106 185 135 110 193
144 120 190 140 115 181 129 104 188 139 114 196 149 125 188 139 114 187 137 112
202 157 134 183 131 106 193 146 122 173 118 092 138 089 065 144 093 069 174 120
094 165 108 081 157 102 076 188 139 114 196 149 125 183 132 106 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 200 155 132 207 161 140 183 132 106 140 090 067 170
115 089 176 122 097 162 107 079 165 108 081 126 080 059 138 089 065 170 115 089
179 127 102 170 115 089 166 109 082 166 110 083 169 113 087 168 112 085 166 109
082 166 110 083 170 115 089 173 118 092 170 115 089 166 110 083 155 101 076 165
108 081 174 120 094 144 093 069 170 115 089 169 113 087 166 110 083 170 115 089
168 112 085 168 112 085 166 110 083 170 115 089 169 113 087 165 108 081 168 112
085 174 120 094 174 120 094 169 113 087 166 109 082 152 100 074 170 115 089 168
112 085 166 110 083 170 115 089 168 112 085 166 110 083 168 112 085 121 077 057
198 151 127 200 155 132 126 080 059 134 086 064 165 108 081 165 108 081 166 110
083 162 107 079 155 101 076 168 112 085 166 109 082 162 107 079 168 112 085 174
120 094 179 127 101 129 083 061 144 093 069 204 160 137 200 155 132 152 100 074
126 080 059 134 086 064 155 101 076 140 090 067 126 080 059 152 100 074 146 095
071 138 089 065 102 063 046 130 083 061 162 107 079 111 070 051 111 070 051 146
095 071 185 135 110 130 083 061 161 106 079 187 137 112 166 109 082 169 113 087
170 115 089 165 108 081 162 107 079 166 109 082 168 112 085 166 109 082 166 110
083 170 115 089 179 127 101 181 129 104 174 119 093 155 101 076 138 089 065 126
080 059 102 065 046 089 054 039 134 086 064 165 108 081 162 107 079 183 131 106
192 143 119 102 063 046 125 079 058 166 110 083 123 079 058 104 066 047 115 073
054 125 079 058 102 063 046 134 086 064 146 095 071 135 086 064 177 124 098 153
100 074 138 089 065 162 107 079 134 086 064 148 096 071 179 127 102 155 101 076
140 090 067 170 115 089 146 095 071 146 095 071 152 100 074 089 054 039 183 131
106 209 166 144 181 129 104 192 143 119 184 134 109 187 137 112 193 146 122 166
110 083 162 107 079 198 151 127 193 144 120 187 137 112 188 139 114 190 140 115
192 143 118 193 144 120 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137
112 188 139 114 185 135 110 187 137 112 204 160 137 152 100 074 106 067 048 115
073 054 198 151 127 161 106 079 151 098 074 115 073 054 143 092 069 151 098 074
174 119 093 155 101 076 162 107 079 138 089 065 151 098 074 177 124 098 138 089
065 179 127 101 144 093 069 151 098 074 204 160 137 198 151 127 170 115 089 185
135 110 200 155 132 198 151 127 200 155 132 190 140 115 184 134 109 183 131 106
193 144 120 193 146 122 198 151 127 157 102 076 153 100 074 134 086 064 198 151
127 187 137 112 188 139 114 198 151 127 185 135 110 188 139 114 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 193 146 122 174 119 093 144 093 069 207 161 140 185 135 110 111
070 051 143 092 069 155 101 076 155 101 076 148 096 071 170 115 089 174 120 094
174 120 094 169 113 087 166 110 083 169 113 087 170 115 089 170 115 089 169 113
087 166 109 082 166 110 083 169 113 087 169 113 087 170 115 089 174 119 093 170
115 089 179 127 101 143 092 069 162 107 079 170 115 089 165 108 081 162 107 079
168 112 085 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089 165 108
081 170 115 089 170 115 089 170 115 089 165 108 081 162 107 079 174 119 093 170
115 089 162 107 079 166 110 083 173 118 092 170 115 089 179 127 101 115 073 054
179 127 101 152 100 074 138 089 065 170 115 089 174 119 093 174 119 093 162 107
079 165 108 081 170 115 089 169 113 087 170 115 089 179 127 102 174 120 094 176
122 097 140 090 067 162 107 079 200 155 132 193 146 122 121 077 057 126 080 059
117 074 054 087 053 037 108 068 049 176 122 097 185 135 110 153 100 074 170 115
089 174 120 094 126 080 059 161 106 079 193 144 120 165 108 081 108 068 049 134
086 064 185 135 110 169 113 087 144 093 069 146 095 071 174 119 093 173 118 092
168 112 085 166 109 082 162 107 079 166 110 083 169 113 087 170 115 089 181 129
104 174 119 093 144 093 069 126 080 059 129 083 061 099 061 044 074 043 030 054
029 019 068 041 028 065 038 025 054 029 019 070 042 028 033 016 010 050 027 018
170 115 089 207 161 140 102 065 046 072 043 030 098 061 044 121 077 057 104 066
047 099 061 044 125 079 058 111 070 051 166 110 083 157 102 076 138 089 065 165
108 081 153 100 074 152 100 074 148 096 071 143 092 069 174 120 094 168 112 085
152 100 074 179 127 102 152 100 074 136 087 064 151 098 074 115 073 054 098 061
044 209 166 144 198 151 127 190 140 115 193 144 120 185 135 110 190 140 115 184
134 109 183 131 106 181 129 104 190 140 115 183 132 106 185 135 110 190 140 115
188 139 114 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140
115 183 131 106 181 129 104 193 144 120 198 151 127 165 108 081 082 050 035 184
134 109 168 112 085 129 083 061 140 090 067 134 086 064 173 118 092 136 087 064
166 109 082 177 124 098 146 095 071 136 087 064 155 101 076 143 092 069 170 115
089 181 129 104 166 110 083 098 061 044 135 086 064 193 144 120 200 155 132 200
155 132 185 135 110 177 124 098 185 135 110 193 144 120 192 143 118 192 143 118
179 127 102 200 155 132 192 143 119 148 096 071 170 115 089 166 109 082 200 154
131 198 151 127 183 131 106 184 134 109 188 139 114 185 135 110 187 137 112 187
137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 193 144 120 185 135 110 121 077 057 183 132 106 168 112 085 148 096 071 200
155 132 170 115 089 151 098 074 120 076 056 138 089 065 192 143 118 176 122 097
170 115 089 169 113 087 168 112 085 165 108 081 162 107 079 170 115 089 170 115
089 174 119 093 169 113 087 168 112 085 170 115 089 169 113 087 170 115 089 174
119 093 176 122 097 140 090 067 155 101 076 170 115 089 170 115 089 168 112 085
169 113 087 166 110 083 168 112 085 162 107 079 166 109 082 168 112 085 166 110
083 165 108 081 165 108 081 170 115 089 155 101 076 155 101 076 170 115 089 168
112 085 174 119 093 166 110 083 166 109 082 183 131 106 129 083 061 130 083 061
072 043 030 082 050 035 179 127 101 179 127 101 168 112 085 170 115 089 176 122
097 170 115 089 169 113 087 177 124 098 165 108 081 155 101 076 162 107 079 144
093 069 144 093 069 193 146 122 200 154 131 117 074 054 111 070 051 129 083 061
155 101 076 157 102 076 129 083 061 085 051 036 125 079 058 170 115 089 174 120
094 114 072 052 144 093 069 170 115 089 129 083 061 190 140 115 135 086 064 108
068 049 192 143 118 162 107 079 173 118 092 155 101 076 134 086 064 176 122 097
179 127 101 168 112 085 170 115 089 168 112 085 179 127 101 179 127 101 134 086
064 130 083 061 120 076 056 061 035 024 061 035 024 096 059 042 136 087 064 130
083 061 161 106 079 151 098 074 138 089 065 151 098 074 120 076 056 061 035 024
053 029 019 102 063 046 078 047 032 099 061 044 085 051 036 115 073 054 121 077
057 090 054 039 135 086 064 072 043 030 157 102 076 174 119 093 123 079 058 130
083 061 130 083 061 151 098 074 152 100 074 157 102 076 174 120 094 162 107 079
121 077 057 152 100 074 184 134 109 174 119 093 151 098 074 148 096 071 126 080
059 117 074 054 193 144 120 185 135 110 183 131 106 196 149 125 184 134 109 192
143 118 190 140 115 169 113 087 190 140 115 193 144 120 185 135 110 185 135 110
190 140 115 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135
110 185 135 110 184 134 109 200 154 131 170 115 089 115 073 054 173 118 092 166
110 083 144 093 069 168 112 085 134 086 064 155 101 076 151 098 074 162 107 079
166 109 082 126 080 059 114 072 052 134 086 064 136 087 064 162 107 079 169 113
087 157 102 076 173 118 092 169 113 087 148 096 071 130 083 061 170 115 089 155
101 076 157 102 076 121 077 057 104 066 047 190 140 115 196 149 125 193 144 120
173 118 092 179 127 102 166 110 083 166 109 082 155 101 076 174 120 094 200 155
132 183 131 106 183 132 106 193 144 120 187 137 112 185 135 110 188 139 114 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 187 137 112 200 155 132 193 146 122 193 146 122 181 129 104 198
151 127 204 160 137 193 144 120 151 098 074 115 073 054 121 077 057 153 100 074
168 112 085 176 122 097 177 124 098 166 109 082 162 107 079 168 112 085 170 115
089 173 118 092 173 118 092 170 115 089 168 112 085 168 112 085 168 112 085 168
112 085 170 115 089 146 095 071 177 124 098 174 120 094 169 113 087 168 112 085
166 110 083 170 115 089 169 113 087 174 120 094 161 106 079 161 106 079 179 127
101 166 110 083 162 107 079 179 127 101 143 092 069 162 107 079 168 112 085 170
115 089 173 118 092 165 108 081 166 110 083 183 131 106 096 059 042 192 143 119
155 101 076 102 063 046 146 095 071 165 108 081 179 127 101 165 108 081 155 101
076 183 131 106 176 122 097 146 095 071 143 092 069 143 092 069 153 100 074 130
083 061 165 108 081 188 139 114 155 101 076 143 092 069 121 077 057 126 080 059
151 098 074 170 115 089 168 112 085 096 059 042 144 093 069 196 149 125 136 087
064 098 061 044 170 115 089 146 095 071 111 070 051 151 098 074 148 096 071 104
066 047 148 096 071 123 079 058 153 100 074 193 144 120 153 100 074 134 086 064
176 122 097 170 115 089 162 107 079 184 134 109 174 120 094 104 066 047 062 035
024 061 035 024 098 061 044 136 087 064 134 086 064 138 089 065 138 089 065 125
079 058 125 079 058 121 077 057 106 067 048 115 073 054 151 098 074 126 080 059
082 050 035 061 035 024 120 076 056 144 093 069 115 073 054 138 089 065 148 096
071 129 083 061 069 041 028 165 108 081 183 131 106 166 110 083 170 115 089 134
086 064 129 083 061 135 086 064 115 073 054 168 112 085 181 129 104 170 115 089
151 098 074 155 101 076 179 127 101 151 098 074 126 080 059 144 093 069 138 089
065 096 059 042 181 129 104 199 152 129 187 137 112 185 135 110 183 131 106 192
143 118 196 149 125 188 139 114 193 144 120 187 137 112 187 137 112 185 135 110
190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 188 139 114 187 137 112 187 137 112 192 143
118 183 131 106 193 146 122 200 155 132 085 051 036 153 100 074 198 151 127 162
107 079 174 119 093 138 089 065 134 086 064 148 096 071 168 112 085 192 143 118
140 090 067 135 086 064 185 135 110 169 113 087 162 107 079 179 127 101 155 101
076 161 106 079 165 108 081 168 112 085 183 131 106 166 109 082 104 066 047 166
110 083 166 109 082 143 092 069 125 079 058 134 086 064 106 067 048 126 080 059
140 090 067 136 087 064 151 098 074 117 074 054 121 077 057 198 151 127 190 140
115 185 135 110 184 134 109 183 131 106 187 137 112 188 139 114 187 137 112 187
137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139
114 185 135 110 188 139 114 196 149 125 179 127 101 183 131 106 207 161 140 179
127 102 183 131 106 202 157 134 153 100 074 114 072 052 108 068 049 093 057 041
136 087 064 151 098 074 165 108 081 185 135 110 174 120 094 165 108 081 157 102
076 169 113 087 166 109 082 166 110 083 170 115 089 168 112 085 170 115 089 169
113 087 170 115 089 125 079 058 155 101 076 174 119 093 165 108 081 166 110 083
174 119 093 165 108 081 157 102 076 151 098 074 144 093 069 155 101 076 176 122
097 170 115 089 170 115 089 185 135 110 136 087 064 138 089 065 166 109 082 148
096 071 138 089 065 151 098 074 162 107 079 152 100 074 168 112 085 138 089 065
117 074 054 174 120 094 192 143 118 123 079 058 157 102 076 179 127 101 174 119
093 166 109 082 144 093 069 138 089 065 181 129 104 183 131 106 179 127 102 148
096 071 134 086 064 165 108 081 151 098 074 089 054 039 135 086 064 166 110 083
177 124 098 174 119 093 151 098 074 134 086 064 176 122 097 173 118 092 151 098
074 151 098 074 174 120 094 179 127 101 183 131 106 173 118 092 143 092 069 099
061 044 143 092 069 148 096 071 123 079 058 177 124 098 183 131 106 152 100 074
135 086 064 177 124 098 183 131 106 162 107 079 080 048 033 064 036 024 106 067
048 134 086 064 134 086 064 143 092 069 148 096 071 155 101 076 151 098 074 138
089 065 138 089 065 166 110 083 144 093 069 125 079 058 152 100 074 134 086 064
108 068 049 138 089 065 136 087 064 120 076 056 138 089 065 148 096 071 135 086
064 126 080 059 059 034 023 115 073 054 193 144 120 176 122 097 168 112 085 161
106 079 144 093 069 134 086 064 111 070 051 143 092 069 176 122 097 174 120 094
183 131 106 151 098 074 125 079 058 155 101 076 151 098 074 162 107 079 162 107
079 168 112 085 200 155 132 200 155 132 183 132 106 183 132 106 190 140 115 190
140 115 190 140 115 202 157 134 166 110 083 168 112 085 196 149 125 185 135 110
185 135 110 188 139 114 190 140 115 190 140 115 185 135 110 190 140 115 192 143
118 188 139 114 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 185 135 110 185 135 110 188 139 114 185 135 110 183 132
106 193 146 122 202 158 135 157 102 076 146 095 071 169 113 087 134 086 064 155
101 076 130 083 061 144 093 069 130 083 061 115 073 054 162 107 079 144 093 069
126 080 059 152 100 074 162 107 079 169 113 087 174 119 093 165 108 081 168 112
085 170 115 089 168 112 085 168 112 085 168 112 085 174 120 094 144 093 069 190
140 115 138 089 065 155 101 076 185 135 110 136 087 064 152 100 074 173 118 092
151 098 074 152 100 074 170 115 089 179 127 101 151 098 074 179 127 102 209 166
144 193 146 122 174 120 094 184 134 109 190 140 115 193 144 120 190 140 115 179
127 101 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 187 137 112 192 143 118 184 134 109 187 137 112 184
134 109 183 132 106 193 146 122 144 093 069 157 102 076 174 120 094 125 079 058
102 063 046 138 089 065 126 080 059 140 090 067 138 089 065 162 107 079 170 115
089 174 119 093 174 120 094 153 100 074 168 112 085 170 115 089 168 112 085 170
115 089 166 109 082 143 092 069 129 083 061 168 112 085 168 112 085 155 101 076
157 102 076 146 095 071 174 120 094 176 122 097 200 154 131 184 134 109 126 080
059 174 120 094 166 110 083 144 093 069 129 083 061 140 090 067 170 115 089 168
112 085 193 144 120 192 143 118 162 107 079 135 086 064 185 135 110 193 144 120
120 076 056 111 070 051 170 115 089 134 086 064 162 107 079 157 102 076 148 096
071 129 083 061 165 108 081 183 131 106 162 107 079 170 115 089 188 139 114 153
100 074 190 140 115 179 127 102 091 056 039 148 096 071 179 127 101 165 108 081
126 080 059 155 101 076 130 083 061 148 096 071 177 124 098 148 096 071 138 089
065 157 102 076 170 115 089 177 124 098 177 124 098 174 119 093 161 106 079 168
112 085 130 083 061 102 065 046 170 115 089 177 124 098 162 107 079 185 135 110
146 095 071 174 120 094 170 115 089 087 053 037 068 041 028 134 086 064 166 110
083 170 115 089 155 101 076 123 079 058 138 089 065 146 095 071 148 096 071 143
092 069 166 109 082 174 120 094 166 110 083 165 108 081 155 101 076 134 086 064
136 087 064 134 086 064 121 077 057 136 087 064 114 072 052 125 079 058 136 087
064 126 080 059 117 074 054 035 018 011 126 080 059 188 139 114 161 106 079 157
102 076 111 070 051 123 079 058 123 079 058 115 073 054 173 118 092 165 108 081
165 108 081 146 095 071 155 101 076 173 118 092 174 119 093 174 120 094 151 098
074 099 061 044 183 131 106 200 155 132 183 132 106 183 132 106 200 155 132 190
140 115 174 119 093 207 163 141 117 074 054 111 070 051 204 160 137 200 155 132
183 131 106 190 140 115 190 140 115 183 132 106 190 140 115 187 137 112 192 143
118 187 137 112 192 143 119 188 139 114 183 132 106 190 140 115 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 192 143 118 185 135 110 185 135 110 183 132 106 200 155
132 207 161 140 181 129 104 108 068 049 144 093 069 134 086 064 143 092 069 168
112 085 168 112 085 162 107 079 144 093 069 143 092 069 136 087 064 152 100 074
136 087 064 155 101 076 144 093 069 148 096 071 170 115 089 166 109 082 173 118
092 174 120 094 174 119 093 177 124 098 185 135 110 152 100 074 134 086 064 165
108 081 129 083 061 157 102 076 179 127 101 140 090 067 170 115 089 183 132 106
157 102 076 140 090 067 177 124 098 183 131 106 126 080 059 120 076 056 177 124
098 198 151 127 200 155 132 190 140 115 187 137 112 184 134 109 190 140 115 190
140 115 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 183 132 106 173 118 092 185 135 110 190 140 115 185 135 110 192
143 118 193 146 122 193 144 120 183 131 106 148 096 071 179 127 101 193 146 122
138 089 065 120 076 056 170 115 089 140 090 067 134 086 064 135 086 064 170 115
089 162 107 079 179 127 102 170 115 089 153 100 074 169 113 087 174 119 093 166
110 083 148 096 071 183 132 106 170 115 089 121 077 057 144 093 069 146 095 071
155 101 076 183 131 106 200 154 131 192 143 119 204 160 137 193 146 122 151 098
074 135 086 064 144 093 069 170 115 089 185 135 110 200 155 132 200 154 131 187
137 112 196 149 125 199 152 129 196 149 125 187 137 112 184 134 109 202 157 134
184 134 109 058 033 022 155 101 076 168 112 085 130 083 061 126 080 059 173 118
092 174 119 093 173 118 092 168 112 085 169 113 087 183 131 106 136 087 064 111
070 051 134 086 064 099 061 044 121 077 057 165 108 081 151 098 074 162 107 079
140 090 067 143 092 069 173 118 092 155 101 076 166 110 083 151 098 074 115 073
054 153 100 074 157 102 076 136 087 064 104 066 047 115 073 054 115 073 054 155
101 076 179 127 101 069 041 028 143 092 069 174 120 094 157 102 076 174 120 094
166 109 082 108 068 049 093 057 041 125 079 058 121 077 057 111 070 051 143 092
069 121 077 057 143 092 069 155 101 076 153 100 074 148 096 071 157 102 076 129
083 061 134 086 064 170 115 089 153 100 074 155 101 076 151 098 074 146 095 071
161 106 079 140 090 067 129 083 061 134 086 064 126 080 059 144 093 069 152 100
074 123 079 058 170 115 089 129 083 061 062 035 024 120 076 056 140 090 067 123
079 058 126 080 059 138 089 065 144 093 069 162 107 079 179 127 101 168 112 085
166 109 082 174 120 094 169 113 087 174 120 094 166 109 082 174 119 093 129 083
061 144 093 069 204 160 137 190 140 115 190 140 115 190 140 115 179 127 101 202
157 134 198 151 127 151 098 074 072 043 030 144 093 069 170 115 089 181 129 104
199 152 129 200 155 132 198 151 127 185 135 110 183 131 106 183 131 106 183 131
106 188 139 114 190 140 115 192 143 118 188 139 114 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 184 134 109 200 154 131 196 149 125 170 115
089 153 100 074 121 077 057 106 067 048 155 101 076 138 089 065 168 112 085 161
106 079 143 092 069 130 083 061 126 080 059 115 073 054 155 101 076 173 118 092
140 090 067 179 127 101 162 107 079 144 093 069 176 122 097 166 109 082 168 112
085 162 107 079 143 092 069 144 093 069 148 096 071 134 086 064 152 100 074 161
106 079 125 079 058 151 098 074 198 151 127 162 107 079 165 108 081 179 127 101
151 098 074 174 119 093 187 137 112 157 102 076 151 098 074 181 129 104 135 086
064 140 090 067 192 143 119 207 161 140 200 154 131 179 127 101 179 127 102 193
144 120 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 185 135 110 185 135 110 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 185 135 110 185 135 110 188 139 114 190 140 115 184 134 109 192
143 118 185 135 110 174 120 094 209 167 145 183 131 106 138 089 065 136 087 064
188 139 114 144 093 069 146 095 071 196 149 125 151 098 074 155 101 076 161 106
079 144 093 069 138 089 065 161 106 079 168 112 085 176 122 097 192 143 118 125
079 058 169 113 087 187 137 112 120 076 056 177 124 098 200 154 131 192 143 119
204 160 137 199 152 129 179 127 102 183 131 106 190 140 115 200 154 131 188 139
114 185 135 110 188 139 114 200 154 131 204 160 137 202 158 135 185 135 110 187
137 112 187 137 112 188 139 114 192 143 119 190 140 115 190 140 115 202 158 135
207 163 141 111 070 051 089 054 039 176 122 097 144 093 069 157 102 076 166 110
083 174 120 094 168 112 085 170 115 089 170 115 089 162 107 079 115 073 054 121
077 057 099 061 044 153 100 074 170 115 089 134 086 064 166 109 082 170 115 089
166 110 083 170 115 089 165 108 081 151 098 074 170 115 089 168 112 085 123 079
058 183 132 106 153 100 074 106 067 048 120 076 056 126 080 059 104 066 047 104
066 047 165 108 081 136 087 064 065 038 025 162 107 079 200 155 132 138 089 065
085 051 036 093 057 041 115 073 054 162 107 079 114 072 052 078 047 032 138 089
065 134 086 064 138 089 065 138 089 065 135 086 064 151 098 074 155 101 076 144
093 069 151 098 074 157 102 076 155 101 076 138 089 065 162 107 079 179 127 101
162 107 079 134 086 064 134 086 064 144 093 069 170 115 089 162 107 079 140 090
067 134 086 064 183 131 106 153 100 074 082 050 035 114 072 052 140 090 067 120
076 056 140 090 067 130 083 061 126 080 059 120 076 056 151 098 074 174 119 093
168 112 085 170 115 089 161 106 079 174 119 093 176 122 097 174 119 093 146 095
071 192 143 119 193 144 120 190 140 115 190 140 115 193 144 120 144 093 069 192
143 118 207 161 140 170 115 089 126 080 059 104 066 047 102 065 046 093 057 041
151 098 074 153 100 074 144 093 069 213 171 150 207 161 140 199 152 129 198 151
127 185 135 110 185 135 110 185 135 110 190 140 115 188 139 114 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 185 135 110 190 140 115 185 135 110 202 158 135 173 118 092 072 043
030 111 070 051 168 112 085 166 110 083 146 095 071 115 073 054 148 096 071 151
098 074 134 086 064 170 115 089 174 120 094 153 100 074 143 092 069 162 107 079
170 115 089 176 122 097 153 100 074 148 096 071 179 127 101 155 101 076 126 080
059 143 092 069 151 098 074 162 107 079 151 098 074 144 093 069 170 115 089 183
131 106 179 127 101 144 093 069 162 107 079 144 093 069 143 092 069 155 101 076
121 077 057 155 101 076 099 061 044 144 093 069 174 119 093 144 093 069 162 107
079 143 092 069 155 101 076 165 108 081 183 131 106 192 143 119 190 140 115 188
139 114 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 192 143 118 190 140 115 185 135 110 192 143 119 183
131 106 183 132 106 190 140 115 192 143 118 192 143 119 198 151 127 170 115 089
157 102 076 143 092 069 104 066 047 148 096 071 104 066 047 162 107 079 183 131
106 179 127 101 153 100 074 151 098 074 153 100 074 168 112 085 151 098 074 125
079 058 126 080 059 152 100 074 157 102 076 193 144 120 202 157 134 184 134 109
193 146 122 187 137 112 185 135 110 198 151 127 185 135 110 179 127 102 190 140
115 200 155 132 190 140 115 174 120 094 161 106 079 143 092 069 173 118 092 199
152 129 193 144 120 193 144 120 193 146 122 193 144 120 152 100 074 134 086 064
192 143 119 190 140 115 104 066 047 168 112 085 173 118 092 168 112 085 130 083
061 157 102 076 170 115 089 166 110 083 177 124 098 148 096 071 129 083 061 138
089 065 161 106 079 174 120 094 121 077 057 179 127 101 177 124 098 176 122 097
170 115 089 176 122 097 176 122 097 151 098 074 165 108 081 165 108 081 129 083
061 166 109 082 166 110 083 146 095 071 166 110 083 138 089 065 135 086 064 143
092 069 096 059 042 134 086 064 089 054 039 102 063 046 151 098 074 085 051 036
090 054 039 144 093 069 111 070 051 093 057 041 134 086 064 153 100 074 134 086
064 138 089 065 157 102 076 166 109 082 155 101 076 152 100 074 151 098 074 168
112 085 168 112 085 161 106 079 168 112 085 170 115 089 157 102 076 165 108 081
165 108 081 148 096 071 166 110 083 166 109 082 170 115 089 138 089 065 135 086
064 161 106 079 144 093 069 130 083 061 138 089 065 151 098 074 126 080 059 135
086 064 157 102 076 152 100 074 155 101 076 140 090 067 136 087 064 168 112 085
176 122 097 168 112 085 170 115 089 174 120 094 155 101 076 143 092 069 193 146
122 199 152 129 174 120 094 193 144 120 187 137 112 199 152 129 134 086 064 135
086 064 165 108 081 190 140 115 212 168 148 143 092 069 121 077 057 108 068 049
090 054 039 111 070 051 123 079 058 138 089 065 143 092 069 168 112 085 181 129
104 185 135 110 185 135 110 185 135 110 192 143 118 188 139 114 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
192 143 119 187 137 112 184 134 109 202 158 135 183 131 106 115 073 054 190 140
115 157 102 076 136 087 064 151 098 074 104 066 047 111 070 051 162 107 079 174
120 094 174 119 093 187 137 112 155 101 076 166 109 082 174 119 093 144 093 069
151 098 074 165 108 081 155 101 076 165 108 081 185 135 110 157 102 076 162 107
079 188 139 114 185 135 110 179 127 102 183 132 106 153 100 074 144 093 069 152
100 074 183 131 106 136 087 064 111 070 051 179 127 101 157 102 076 166 110 083
151 098 074 135 086 064 114 072 052 104 066 047 140 090 067 174 120 094 165 108
081 181 129 104 183 132 106 082 050 035 111 070 051 202 158 135 193 146 122 188
139 114 184 134 109 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 185 135 110 187 137 112 190 140 115 190 140 115 190 140 115 185 135 110
192 143 119 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185
135 110 193 144 120 196 149 125 174 120 094 190 140 115 198 151 127 202 157 134
089 054 039 148 096 071 212 170 149 202 157 134 185 135 110 144 093 069 129 083
061 153 100 074 168 112 085 174 120 094 153 100 074 126 080 059 134 086 064 174
119 093 153 100 074 155 101 076 146 095 071 170 115 089 198 151 127 196 149 125
179 127 101 193 146 122 187 137 112 185 135 110 192 143 119 179 127 101 181 129
104 200 155 132 212 168 148 165 108 081 099 061 044 151 098 074 170 115 089 200
154 131 204 160 137 185 135 110 192 143 119 212 170 149 193 144 120 104 066 047
166 110 083 207 161 140 144 093 069 183 132 106 170 115 089 174 120 094 174 120
094 144 093 069 179 127 101 181 129 104 190 140 115 099 061 044 089 054 039 177
124 098 179 127 101 143 092 069 151 098 074 120 076 056 078 047 032 104 066 047
162 107 079 152 100 074 162 107 079 153 100 074 157 102 076 169 113 087 140 090
067 111 070 051 138 089 065 126 080 059 157 102 076 143 092 069 138 089 065 138
089 065 125 079 058 115 073 054 099 061 044 069 041 028 085 051 036 129 083 061
111 070 051 111 070 051 078 047 032 093 057 041 138 089 065 126 080 059 111 070
051 121 077 057 121 077 057 162 107 079 173 118 092 174 120 094 161 106 079 162
107 079 165 108 081 157 102 076 161 106 079 166 110 083 166 110 083 140 090 067
120 076 056 146 095 071 155 101 076 151 098 074 153 100 074 121 077 057 151 098
074 151 098 074 114 072 052 155 101 076 168 112 085 166 110 083 146 095 071 161
106 079 157 102 076 146 095 071 138 089 065 162 107 079 144 093 069 144 093 069
174 119 093 169 113 087 174 119 093 162 107 079 153 100 074 144 093 069 183 131
106 204 160 137 200 154 131 179 127 101 188 139 114 198 151 127 176 122 097 134
086 064 111 070 051 152 100 074 200 155 132 198 151 127 174 120 094 143 092 069
151 098 074 157 102 076 129 083 061 111 070 051 068 041 028 099 061 044 152 100
074 192 143 118 193 144 120 183 132 106 192 143 118 190 140 115 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
199 152 129 174 120 094 190 140 115 202 158 135 099 061 044 161 106 079 190 140
115 108 068 049 069 041 028 115 073 054 134 086 064 115 073 054 115 073 054 129
083 061 138 089 065 161 106 079 123 079 058 134 086 064 174 119 093 126 080 059
111 070 051 130 083 061 121 077 057 108 068 049 130 083 061 114 072 052 143 092
069 148 096 071 151 098 074 138 089 065 151 098 074 138 089 065 143 092 069 143
092 069 140 090 067 151 098 074 117 074 054 136 087 064 168 112 085 162 107 079
165 108 081 144 093 069 165 108 081 115 073 054 098 061 044 138 089 065 162 107
079 138 089 065 168 112 085 111 070 051 157 102 076 202 157 134 179 127 102 184
134 109 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 190 140 115 190 140 115 190 140 115 190 140 115 188 139 114
183 131 106 183 132 106 193 144 120 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192
143 118 190 140 115 179 127 102 200 155 132 184 134 109 177 124 098 193 144 120
136 087 064 140 090 067 174 119 093 155 101 076 190 140 115 200 155 132 174 119
093 125 079 058 134 086 064 135 086 064 121 077 057 140 090 067 155 101 076 144
093 069 114 072 052 157 102 076 099 061 044 170 115 089 202 158 135 209 166 144
162 107 079 185 135 110 202 158 135 177 124 098 190 140 115 187 137 112 202 157
134 193 144 120 102 065 046 198 151 127 204 160 137 183 131 106 204 160 137 157
102 076 111 070 051 121 077 057 091 056 039 166 109 082 138 089 065 115 073 054
123 079 058 174 120 094 082 050 035 143 092 069 166 109 082 151 098 074 162 107
079 134 086 064 148 096 071 166 109 082 102 065 046 104 066 047 173 118 092 148
096 071 138 089 065 111 070 051 108 068 049 115 073 054 168 112 085 117 074 054
126 080 059 161 106 079 153 100 074 170 115 089 138 089 065 111 070 051 134 086
064 165 108 081 185 135 110 166 110 083 135 086 064 174 119 093 187 137 112 166
110 083 162 107 079 169 113 087 144 093 069 093 057 041 087 053 037 098 061 044
082 050 035 098 061 044 134 086 064 155 101 076 099 061 044 106 067 048 155 101
076 179 127 101 168 112 085 162 107 079 152 100 074 151 098 074 161 106 079 153
100 074 170 115 089 170 115 089 166 109 082 115 073 054 130 083 061 161 106 079
168 112 085 179 127 101 168 112 085 166 110 083 138 089 065 140 090 067 173 118
092 115 073 054 087 053 037 121 077 057 155 101 076 170 115 089 161 106 079 157
102 076 166 110 083 168 112 085 155 101 076 126 080 059 174 119 093 129 083 061
134 086 064 183 132 106 152 100 074 162 107 079 177 124 098 155 101 076 106 067
048 114 072 052 165 108 081 198 151 127 193 144 120 202 157 134 170 115 089 174
119 093 155 101 076 143 092 069 184 134 109 192 143 118 198 151 127 200 154 131
200 154 131 200 155 132 161 106 079 111 070 051 151 098 074 125 079 058 135 086
064 183 132 106 193 146 122 179 127 101 193 144 120 185 135 110 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
183 131 106 192 143 118 209 166 144 130 083 061 129 083 061 198 151 127 111 070
051 064 036 024 138 089 065 170 115 089 151 098 074 134 086 064 117 074 054 123
079 058 099 061 044 136 087 064 134 086 064 136 087 064 102 063 046 126 080 059
129 083 061 144 093 069 174 119 093 138 089 065 134 086 064 155 101 076 144 093
069 144 093 069 144 093 069 144 093 069 144 093 069 135 086 064 179 127 101 170
115 089 174 120 094 174 120 094 148 096 071 125 079 058 151 098 074 144 093 069
161 106 079 192 143 118 169 113 087 134 086 064 157 102 076 108 068 049 129 083
061 185 135 110 185 135 110 129 083 061 125 079 058 204 160 137 193 144 120 176
122 097 193 144 120 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 190 140 115 187 137 112 185 135 110 183 132 106 183 132 106 192 143 119
166 110 083 179 127 101 193 144 120 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 188 139 114 188 139 114 200 155 132 153 100 074 130 083 061 126 080 059
169 113 087 162 107 079 134 086 064 090 054 039 082 050 035 173 118 092 209 166
144 200 155 132 198 151 127 198 151 127 188 139 114 200 154 131 179 127 102 174
119 093 190 140 115 185 135 110 179 127 101 199 152 129 162 107 079 098 061 044
068 041 028 102 063 046 204 160 137 202 158 135 183 131 106 188 139 114 207 161
140 135 086 064 054 029 019 120 076 056 162 107 079 173 118 092 212 170 149 115
073 054 091 056 039 169 113 087 106 067 048 089 054 039 151 098 074 179 127 102
093 057 041 099 061 044 123 079 058 111 070 051 146 095 071 166 110 083 166 109
082 152 100 074 099 061 044 102 065 046 069 041 028 187 137 112 188 139 114 115
073 054 089 054 039 152 100 074 181 129 104 204 160 137 204 160 137 174 120 094
134 086 064 155 101 076 143 092 069 126 080 059 111 070 051 121 077 057 174 120
094 176 122 097 168 112 085 190 140 115 177 124 098 146 095 071 104 066 047 123
079 058 151 098 074 144 093 069 120 076 056 104 066 047 120 076 056 135 086 064
129 083 061 082 050 035 099 061 044 166 110 083 174 120 094 181 129 104 179 127
101 170 115 089 174 120 094 179 127 101 173 118 092 174 119 093 144 093 069 130
083 061 138 089 065 144 093 069 157 102 076 157 102 076 174 120 094 190 140 115
188 139 114 140 090 067 111 070 051 146 095 071 129 083 061 144 093 069 146 095
071 117 074 054 130 083 061 166 110 083 168 112 085 157 102 076 173 118 092 174
119 093 162 107 079 162 107 079 174 119 093 134 086 064 155 101 076 148 096 071
155 101 076 183 131 106 157 102 076 170 115 089 165 108 081 166 109 082 165 108
081 155 101 076 176 122 097 200 155 132 179 127 102 162 107 079 138 089 065 134
086 064 087 053 037 166 110 083 200 155 132 185 135 110 187 137 112 185 135 110
184 134 109 193 144 120 185 135 110 174 120 094 166 109 082 104 066 047 099 061
044 174 120 094 198 151 127 184 134 109 193 146 122 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
170 115 089 204 160 137 179 127 101 082 050 035 190 140 115 174 119 093 096 059
042 153 100 074 165 108 081 136 087 064 153 100 074 130 083 061 151 098 074 179
127 101 111 070 051 168 112 085 146 095 071 151 098 074 151 098 074 138 089 065
121 077 057 143 092 069 183 131 106 162 107 079 153 100 074 190 140 115 179 127
101 179 127 102 179 127 101 183 131 106 183 131 106 148 096 071 174 120 094 174
119 093 179 127 101 126 080 059 166 110 083 183 131 106 126 080 059 157 102 076
144 093 069 136 087 064 151 098 074 121 077 057 173 118 092 196 149 125 099 061
044 138 089 065 155 101 076 102 063 046 080 048 033 174 120 094 200 155 132 183
131 106 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 188 139 114
187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 187
137 112 190 140 115 190 140 115 183 131 106 166 110 083 146 095 071 187 137 112
187 137 112 188 139 114 187 137 112 185 135 110 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 192
143 118 187 137 112 190 140 115 173 118 092 161 106 079 155 101 076 155 101 076
177 124 098 151 098 074 162 107 079 179 127 101 155 101 076 085 051 036 179 127
102 187 137 112 179 127 101 199 152 129 202 157 134 199 152 129 196 149 125 193
146 122 196 149 125 193 144 120 200 154 131 193 146 122 179 127 101 166 109 082
198 151 127 151 098 074 082 050 035 202 157 134 193 146 122 200 155 132 179 127
101 087 053 037 104 066 047 054 029 019 153 100 074 207 163 141 111 070 051 108
068 049 155 101 076 162 107 079 165 108 081 168 112 085 179 127 102 166 109 082
174 120 094 162 107 079 155 101 076 144 093 069 111 070 051 135 086 064 140 090
067 140 090 067 144 093 069 153 100 074 135 086 064 151 098 074 138 089 065 121
077 057 069 041 028 185 135 110 215 174 153 179 127 102 193 146 122 209 166 144
155 101 076 146 095 071 143 092 069 136 087 064 174 120 094 183 132 106 170 115
089 169 113 087 174 120 094 166 110 083 146 095 071 162 107 079 168 112 085 078
047 032 062 035 024 111 070 051 123 079 058 117 074 054 102 065 046 134 086 064
125 079 058 117 074 054 170 115 089 192 143 119 183 131 106 162 107 079 162 107
079 166 110 083 168 112 085 168 112 085 170 115 089 176 122 097 177 124 098 179
127 101 155 101 076 111 070 051 125 079 058 136 087 064 166 110 083 120 076 056
144 093 069 135 086 064 134 086 064 146 095 071 135 086 064 121 077 057 143 092
069 153 100 074 173 118 092 190 140 115 183 131 106 157 102 076 143 092 069 173
118 092 174 120 094 165 108 081 162 107 079 166 109 082 111 070 051 111 070 051
143 092 069 179 127 101 183 131 106 161 106 079 151 098 074 207 163 141 199 152
129 165 108 081 199 152 129 198 151 127 200 155 132 111 070 051 151 098 074 115
073 054 165 108 081 204 160 137 185 135 110 185 135 110 187 137 112 187 137 112
187 137 112 184 134 109 193 144 120 202 158 135 198 151 127 168 112 085 126 080
059 134 086 064 187 137 112 199 152 129 181 129 104 188 139 114 187 137 112 187
137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 183 132 106
202 157 134 199 152 129 115 073 054 138 089 065 170 115 089 104 066 047 138 089
065 170 115 089 140 090 067 151 098 074 166 110 083 115 073 054 129 083 061 176
122 097 152 100 074 138 089 065 144 093 069 135 086 064 143 092 069 138 089 065
121 077 057 176 122 097 185 135 110 151 098 074 123 079 058 166 109 082 152 100
074 155 101 076 155 101 076 166 109 082 140 090 067 144 093 069 174 119 093 177
124 098 140 090 067 157 102 076 177 124 098 170 115 089 151 098 074 184 134 109
155 101 076 114 072 052 183 131 106 174 120 094 144 093 069 151 098 074 130 083
061 072 043 030 121 077 057 144 093 069 089 054 039 146 095 071 200 155 132 202
158 135 190 140 115 190 140 115 188 139 114 190 140 115 188 139 114 183 132 106
190 140 115 190 140 115 184 134 109 185 135 110 188 139 114 187 137 112 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 183 132 106 185 135 110 192 143 118 190 140 115 183 131 106 183 131 106
193 144 120 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 184 134 109 188 139 114 176 122 097 155 101 076 136 087 064 120 076 056
155 101 076 143 092 069 173 118 092 179 127 102 130 083 061 099 061 044 179 127
101 204 160 137 153 100 074 120 076 056 181 129 104 188 139 114 187 137 112 192
143 118 144 093 069 089 054 039 187 137 112 187 137 112 187 137 112 200 155 132
209 166 144 181 129 104 077 047 032 174 120 094 196 149 125 174 120 094 082 050
035 135 086 064 136 087 064 166 109 082 209 167 145 202 157 134 082 050 035 136
087 064 169 113 087 161 106 079 166 109 082 143 092 069 165 108 081 143 092 069
174 119 093 174 119 093 173 118 092 169 113 087 102 065 046 102 065 046 123 079
058 138 089 065 162 107 079 138 089 065 130 083 061 077 047 032 054 029 019 174
119 093 161 106 079 151 098 074 193 144 120 198 151 127 192 143 118 115 073 054
146 095 071 177 124 098 183 131 106 181 129 104 170 115 089 169 113 087 170 115
089 185 135 110 155 101 076 136 087 064 162 107 079 165 108 081 181 129 104 153
100 074 111 070 051 126 080 059 099 061 044 104 066 047 136 087 064 117 074 054
082 050 035 104 066 047 153 100 074 166 109 082 174 120 094 183 132 106 170 115
089 170 115 089 170 115 089 166 109 082 168 112 085 170 115 089 166 110 083 174
120 094 183 132 106 181 129 104 177 124 098 174 119 093 176 122 097 146 095 071
146 095 071 173 118 092 152 100 074 120 076 056 144 093 069 168 112 085 177 124
098 173 118 092 162 107 079 146 095 071 166 109 082 162 107 079 148 096 071 177
124 098 165 108 081 170 115 089 168 112 085 181 129 104 166 110 083 136 087 064
096 059 042 115 073 054 176 122 097 168 112 085 153 100 074 129 083 061 200 154
131 161 106 079 104 066 047 168 112 085 138 089 065 173 118 092 166 110 083 098
061 044 202 157 134 212 170 149 183 132 106 185 135 110 187 137 112 187 137 112
192 143 119 177 124 098 190 140 115 185 135 110 193 144 120 187 137 112 152 100
074 102 065 046 162 107 079 212 168 148 179 127 101 187 137 112 190 140 115 187
137 112 185 135 110 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
204 160 137 183 131 106 093 057 041 134 086 064 170 115 089 126 080 059 138 089
065 168 112 085 146 095 071 162 107 079 155 101 076 144 093 069 170 115 089 155
101 076 138 089 065 104 066 047 102 063 046 152 100 074 157 102 076 123 079 058
104 066 047 168 112 085 168 112 085 134 086 064 136 087 064 166 109 082 151 098
074 152 100 074 166 110 083 168 112 085 111 070 051 135 086 064 143 092 069 135
086 064 111 070 051 174 120 094 179 127 101 170 115 089 153 100 074 183 131 106
176 122 097 146 095 071 181 129 104 181 129 104 177 124 098 114 072 052 179 127
102 173 118 092 155 101 076 179 127 101 170 115 089 121 077 057 117 074 054 173
118 092 193 144 120 200 155 132 188 139 114 183 131 106 190 140 115 193 146 122
183 131 106 181 129 104 193 144 120 190 140 115 187 137 112 188 139 114 185 135
110 190 140 115 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 185 135 110 185 135 110 190 140 115 196 149 125 190 140 115
183 132 106 183 131 106 192 143 119 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192
143 118 193 144 120 179 127 102 200 155 132 170 115 089 143 092 069 130 083 061
165 108 081 134 086 064 143 092 069 176 122 097 166 110 083 125 079 058 129 083
061 190 140 115 209 166 144 193 144 120 179 127 102 188 139 114 196 149 125 193
146 122 162 107 079 121 077 057 183 131 106 204 160 137 193 144 120 202 158 135
152 100 074 102 063 046 126 080 059 126 080 059 183 132 106 181 129 104 082 050
035 130 083 061 144 093 069 106 067 048 108 068 049 170 115 089 111 070 051 157
102 076 138 089 065 089 054 039 144 093 069 120 076 056 123 079 058 144 093 069
126 080 059 130 083 061 126 080 059 111 070 051 126 080 059 121 077 057 115 073
054 099 061 044 123 079 058 121 077 057 121 077 057 151 098 074 168 112 085 165
108 081 106 067 048 102 065 046 170 115 089 207 161 140 183 131 106 134 086 064
157 102 076 170 115 089 155 101 076 168 112 085 169 113 087 176 122 097 170 115
089 153 100 074 126 080 059 170 115 089 176 122 097 169 113 087 144 093 069 170
115 089 192 143 118 111 070 051 062 035 024 151 098 074 168 112 085 138 089 065
126 080 059 129 083 061 072 043 030 074 043 030 059 034 023 151 098 074 200 155
132 183 131 106 183 131 106 179 127 101 177 124 098 181 129 104 173 118 092 162
107 079 166 109 082 146 095 071 161 106 079 174 119 093 161 106 079 174 120 094
169 113 087 169 113 087 168 112 085 166 110 083 174 119 093 170 115 089 169 113
087 176 122 097 179 127 101 174 119 093 174 119 093 170 115 089 162 107 079 170
115 089 174 119 093 166 110 083 138 089 065 144 093 069 153 100 074 170 115 089
146 095 071 111 070 051 126 080 059 138 089 065 151 098 074 136 087 064 136 087
064 185 135 110 165 108 081 155 101 076 134 086 064 115 073 054 121 077 057 090
054 039 074 043 030 151 098 074 212 170 149 188 139 114 185 135 110 192 143 118
184 134 109 193 144 120 193 146 122 183 131 106 187 137 112 200 155 132 129 083
061 091 056 039 200 155 132 202 158 135 174 120 094 183 131 106 184 134 109 190
140 115 188 139 114 192 143 119 190 140 115 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
200 155 132 184 134 109 087 053 037 114 072 052 166 109 082 140 090 067 111 070
051 135 086 064 148 096 071 153 100 074 136 087 064 126 080 059 115 073 054 072
043 030 108 068 049 166 109 082 170 115 089 165 108 081 161 106 079 155 101 076
165 108 081 138 089 065 144 093 069 168 112 085 179 127 101 174 120 094 174 120
094 174 120 094 181 129 104 165 108 081 152 100 074 183 131 106 170 115 089 173
118 092 176 122 097 134 086 064 155 101 076 174 120 094 138 089 065 140 090 067
148 096 071 117 074 054 117 074 054 144 093 069 174 120 094 138 089 065 179 127
101 166 110 083 143 092 069 144 093 069 138 089 065 135 086 064 115 073 054 099
061 044 123 079 058 099 061 044 173 118 092 196 149 125 183 131 106 196 149 125
187 137 112 176 122 097 193 146 122 190 140 115 183 132 106 185 135 110 183 131
106 183 131 106 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112
188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 187 137 112 192 143 118 204 160 137 140 090 067 102 065 046 144 093 069
185 135 110 190 140 115 168 112 085 152 100 074 169 113 087 193 144 120 165 108
081 082 050 035 098 061 044 185 135 110 193 146 122 192 143 119 193 144 120 200
154 131 143 092 069 120 076 056 207 163 141 193 144 120 162 107 079 085 051 036
082 050 035 120 076 056 157 102 076 207 161 140 215 174 153 151 098 074 085 051
036 104 066 047 126 080 059 106 067 048 085 051 036 098 061 044 148 096 071 161
106 079 153 100 074 176 122 097 193 144 120 174 119 093 143 092 069 134 086 064
111 070 051 096 059 042 146 095 071 185 135 110 193 146 122 196 149 125 204 160
137 151 098 074 115 073 054 140 090 067 111 070 051 106 067 048 114 072 052 058
033 022 085 051 036 190 140 115 200 154 131 204 160 137 155 101 076 157 102 076
155 101 076 126 080 059 108 068 049 151 098 074 177 124 098 166 109 082 138 089
065 143 092 069 170 115 089 179 127 102 152 100 074 179 127 102 144 093 069 121
077 057 168 112 085 173 118 092 061 035 024 070 042 028 089 054 039 098 061 044
129 083 061 138 089 065 155 101 076 176 122 097 089 054 039 053 029 019 085 051
036 125 079 058 129 083 061 148 096 071 152 100 074 151 098 074 168 112 085 152
100 074 138 089 065 179 127 101 183 131 106 165 108 081 179 127 102 179 127 101
185 135 110 157 102 076 165 108 081 166 109 082 170 115 089 174 120 094 181 129
104 176 122 097 162 107 079 162 107 079 134 086 064 157 102 076 169 113 087 130
083 061 151 098 074 161 106 079 183 131 106 169 113 087 155 101 076 168 112 085
170 115 089 165 108 081 138 089 065 135 086 064 143 092 069 168 112 085 148 096
071 136 087 064 174 120 094 179 127 101 161 106 079 151 098 074 126 080 059 151
098 074 111 070 051 072 043 030 179 127 101 202 158 135 200 155 132 192 143 119
200 155 132 200 155 132 183 131 106 183 131 106 196 149 125 198 151 127 099 061
044 161 106 079 200 154 131 176 122 097 204 160 137 193 144 120 190 140 115 190
140 115 190 140 115 193 144 120 187 137 112 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
199 152 129 173 118 092 111 070 051 153 100 074 153 100 074 138 089 065 169 113
087 161 106 079 138 089 065 144 093 069 174 120 094 166 110 083 173 118 092 170
115 089 121 077 057 140 090 067 168 112 085 161 106 079 176 122 097 169 113 087
166 109 082 162 107 079 155 101 076 170 115 089 153 100 074 152 100 074 162 107
079 157 102 076 138 089 065 115 073 054 170 115 089 179 127 101 162 107 079 174
119 093 174 120 094 115 073 054 135 086 064 125 079 058 165 108 081 174 120 094
144 093 069 185 135 110 183 132 106 121 077 057 165 108 081 166 109 082 115 073
054 144 093 069 161 106 079 166 109 082 174 119 093 168 112 085 155 101 076 129
083 061 117 074 054 138 089 065 212 170 149 200 155 132 168 112 085 185 135 110
200 155 132 198 151 127 181 129 104 188 139 114 183 131 106 190 140 115 193 144
120 183 132 106 184 134 109 187 137 112 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 183 131 106 192 143 119 181 129 104 111 070 051 121 077 057 102 063 046
117 074 054 148 096 071 144 093 069 121 077 057 125 079 058 102 063 046 077 047
032 102 065 046 068 041 028 134 086 064 204 160 137 199 152 129 183 131 106 204
160 137 170 115 089 126 080 059 200 155 132 126 080 059 136 087 064 089 054 039
157 102 076 200 154 131 198 151 127 174 120 094 099 061 044 082 050 035 108 068
049 143 092 069 120 076 056 134 086 064 166 109 082 168 112 085 161 106 079 115
073 054 181 129 104 198 151 127 185 135 110 200 155 132 192 143 118 192 143 119
188 139 114 183 132 106 198 151 127 200 154 131 193 144 120 202 157 134 209 166
144 157 102 076 091 056 039 098 061 044 102 063 046 090 054 039 104 066 047 135
086 064 179 127 101 199 152 129 192 143 119 184 134 109 125 079 058 121 077 057
151 098 074 166 109 082 170 115 089 155 101 076 126 080 059 134 086 064 173 118
092 188 139 114 170 115 089 162 107 079 181 129 104 152 100 074 129 083 061 185
135 110 179 127 101 176 122 097 144 093 069 104 066 047 120 076 056 121 077 057
129 083 061 102 063 046 108 068 049 138 089 065 162 107 079 129 083 061 093 057
041 108 068 049 106 067 048 115 073 054 111 070 051 090 054 039 082 050 035 091
056 039 121 077 057 153 100 074 148 096 071 162 107 079 152 100 074 157 102 076
126 080 059 179 127 101 168 112 085 138 089 065 130 083 061 143 092 069 143 092
069 125 079 058 144 093 069 157 102 076 151 098 074 135 086 064 152 100 074 155
101 076 151 098 074 146 095 071 138 089 065 174 119 093 181 129 104 168 112 085
168 112 085 177 124 098 179 127 101 143 092 069 140 090 067 173 118 092 174 120
094 170 115 089 166 109 082 169 113 087 169 113 087 174 120 094 169 113 087 176
122 097 179 127 102 123 079 058 082 050 035 162 107 079 177 124 098 115 073 054
170 115 089 204 160 137 193 146 122 183 131 106 192 143 119 177 124 098 099 061
044 143 092 069 134 086 064 134 086 064 183 131 106 199 152 129 200 154 131 184
134 109 187 137 112 179 127 102 185 135 110 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
192 143 118 170 115 089 148 096 071 136 087 064 151 098 074 170 115 089 174 119
093 168 112 085 138 089 065 162 107 079 155 101 076 120 076 056 140 090 067 184
134 109 176 122 097 146 095 071 108 068 049 153 100 074 168 112 085 153 100 074
190 140 115 165 108 081 115 073 054 155 101 076 162 107 079 153 100 074 155 101
076 161 106 079 155 101 076 134 086 064 144 093 069 138 089 065 151 098 074 143
092 069 104 066 047 165 108 081 179 127 101 162 107 079 188 139 114 192 143 118
162 107 079 166 110 083 155 101 076 148 096 071 152 100 074 179 127 102 117 074
054 138 089 065 170 115 089 140 090 067 179 127 101 183 132 106 123 079 058 115
073 054 135 086 064 165 108 081 170 115 089 166 110 083 200 155 132 207 163 141
140 090 067 168 112 085 207 161 140 196 149 125 192 143 119 185 135 110 185 135
110 193 146 122 183 132 106 185 135 110 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 190 140 115 188 139 114 198 151 127 183 131 106 170 115 089 157 102 076
148 096 071 136 087 064 155 101 076 165 108 081 152 100 074 173 118 092 179 127
102 192 143 118 179 127 101 126 080 059 144 093 069 155 101 076 111 070 051 108
068 049 200 154 131 209 166 144 111 070 051 129 083 061 126 080 059 166 109 082
212 170 149 204 160 137 074 043 030 062 035 024 104 066 047 136 087 064 166 110
083 166 110 083 134 086 064 151 098 074 166 109 082 155 101 076 157 102 076 126
080 059 144 093 069 199 152 129 184 134 109 193 144 120 200 154 131 198 151 127
199 152 129 202 158 135 199 152 129 199 152 129 199 152 129 155 101 076 068 041
028 098 061 044 114 072 052 136 087 064 176 122 097 185 135 110 179 127 101 153
100 074 204 160 137 199 152 129 174 120 094 125 079 058 173 118 092 174 120 094
173 118 092 165 108 081 157 102 076 184 134 109 148 096 071 166 110 083 151 098
074 143 092 069 148 096 071 166 109 082 151 098 074 140 090 067 173 118 092 176
122 097 143 092 069 161 106 079 183 131 106 181 129 104 183 131 106 185 135 110
174 119 093 152 100 074 174 120 094 134 086 064 115 073 054 170 115 089 168 112
085 174 119 093 169 113 087 121 077 057 126 080 059 138 089 065 143 092 069 166
110 083 111 070 051 104 066 047 129 083 061 153 100 074 153 100 074 111 070 051
134 086 064 151 098 074 151 098 074 166 109 082 151 098 074 155 101 076 136 087
064 151 098 074 162 107 079 153 100 074 170 115 089 173 118 092 169 113 087 170
115 089 170 115 089 183 132 106 162 107 079 115 073 054 168 112 085 177 124 098
170 115 089 170 115 089 170 115 089 162 107 079 136 087 064 157 102 076 176 122
097 173 118 092 168 112 085 169 113 087 170 115 089 169 113 087 153 100 074 162
107 079 166 109 082 174 119 093 143 092 069 108 068 049 161 106 079 130 083 061
090 054 039 151 098 074 204 160 137 202 157 134 188 139 114 196 149 125 198 151
127 151 098 074 126 080 059 130 083 061 082 050 035 072 043 030 169 113 087 200
154 131 200 155 132 192 143 119 190 140 115 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 188 139 114 187 137 112 187 137 112 185 135 110
202 158 135 179 127 101 138 089 065 170 115 089 162 107 079 166 110 083 152 100
074 157 102 076 111 070 051 104 066 047 144 093 069 135 086 064 099 061 044 104
066 047 123 079 058 117 074 054 114 072 052 144 093 069 111 070 051 129 083 061
162 107 079 126 080 059 146 095 071 190 140 115 174 119 093 174 119 093 179 127
101 179 127 101 183 131 106 162 107 079 168 112 085 170 115 089 183 131 106 151
098 074 155 101 076 183 131 106 177 124 098 174 120 094 125 079 058 179 127 102
153 100 074 157 102 076 153 100 074 200 154 131 176 122 097 136 087 064 166 109
082 170 115 089 176 122 097 138 089 065 134 086 064 165 108 081 126 080 059 144
093 069 080 048 033 123 079 058 153 100 074 104 066 047 146 095 071 173 118 092
130 083 061 130 083 061 170 115 089 181 129 104 174 119 093 202 157 134 202 157
134 190 140 115 183 131 106 185 135 110 185 135 110 184 134 109 185 135 110 185
135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183
131 106 185 135 110 192 143 118 190 140 115 200 155 132 199 152 129 198 151 127
200 155 132 199 152 129 196 149 125 202 157 134 185 135 110 166 109 082 177 124
098 166 110 083 174 120 094 140 090 067 134 086 064 152 100 074 080 048 033 080
048 033 183 131 106 161 106 079 148 096 071 187 137 112 168 112 085 202 157 134
169 113 087 080 048 033 102 065 046 170 115 089 152 100 074 115 073 054 204 160
137 148 096 071 085 051 036 166 109 082 169 113 087 151 098 074 165 108 081 188
139 114 138 089 065 151 098 074 204 160 137 192 143 118 200 154 131 168 112 085
174 119 093 174 120 094 169 113 087 169 113 087 144 093 069 134 086 064 162 107
079 176 122 097 183 132 106 181 129 104 174 119 093 179 127 101 135 086 064 174
120 094 209 167 145 179 127 101 155 101 076 115 073 054 162 107 079 162 107 079
179 127 101 162 107 079 143 092 069 168 112 085 153 100 074 198 151 127 188 139
114 143 092 069 165 108 081 170 115 089 169 113 087 170 115 089 170 115 089 166
110 083 168 112 085 170 115 089 170 115 089 170 115 089 174 120 094 161 106 079
166 110 083 183 132 106 177 124 098 188 139 114 157 102 076 080 048 033 068 041
028 093 057 041 123 079 058 126 080 059 170 115 089 183 132 106 179 127 101 179
127 101 176 122 097 179 127 101 173 118 092 152 100 074 168 112 085 169 113 087
134 086 064 102 065 046 168 112 085 162 107 079 146 095 071 151 098 074 151 098
074 168 112 085 157 102 076 170 115 089 177 124 098 173 118 092 166 109 082 169
113 087 162 107 079 168 112 085 184 134 109 148 096 071 126 080 059 151 098 074
138 089 065 168 112 085 179 127 101 174 120 094 151 098 074 144 093 069 146 095
071 168 112 085 170 115 089 170 115 089 168 112 085 166 110 083 179 127 101 151
098 074 153 100 074 165 108 081 165 108 081 126 080 059 173 118 092 170 115 089
173 118 092 106 067 048 123 079 058 209 166 144 200 155 132 176 122 097 204 160
137 168 112 085 102 065 046 177 124 098 202 157 134 162 107 079 157 102 076 153
100 074 155 101 076 196 149 125 200 154 131 185 135 110 185 135 110 188 139 114
185 135 110 187 137 112 190 140 115 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 187 137 112 187 137 112 187 137 112 190 140 115 188 139 114
185 135 110 198 151 127 130 083 061 134 086 064 106 067 048 151 098 074 157 102
076 146 095 071 111 070 051 104 066 047 161 106 079 102 063 046 123 079 058 155
101 076 138 089 065 108 068 049 135 086 064 166 110 083 148 096 071 148 096 071
157 102 076 144 093 069 138 089 065 155 101 076 143 092 069 144 093 069 151 098
074 151 098 074 152 100 074 126 080 059 174 119 093 170 115 089 161 106 079 130
083 061 183 132 106 169 113 087 168 112 085 143 092 069 093 057 041 162 107 079
155 101 076 111 070 051 173 118 092 200 155 132 152 100 074 151 098 074 170 115
089 170 115 089 146 095 071 161 106 079 138 089 065 114 072 052 153 100 074 177
124 098 162 107 079 134 086 064 179 127 101 187 137 112 140 090 067 144 093 069
179 127 101 106 067 048 069 041 028 121 077 057 121 077 057 126 080 059 187 137
112 193 144 120 179 127 102 193 144 120 202 157 134 199 152 129 200 155 132 198
151 127 184 134 109 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 185 135 110 177 124 098 183 131 106 192 143 118 185 135 110
183 131 106 183 132 106 168 112 085 202 157 134 192 143 118 108 068 049 165 108
081 166 110 083 138 089 065 138 089 065 165 108 081 162 107 079 082 050 035 068
041 028 134 086 064 165 108 081 155 101 076 126 080 059 179 127 102 135 086 064
032 016 010 143 092 069 177 124 098 135 086 064 104 066 047 134 086 064 161 106
079 157 102 076 148 096 071 115 073 054 148 096 071 136 087 064 115 073 054 184
134 109 108 068 049 111 070 051 193 146 122 200 155 132 155 101 076 111 070 051
102 065 046 102 065 046 161 106 079 161 106 079 179 127 101 184 134 109 176 122
097 174 120 094 168 112 085 166 110 083 168 112 085 170 115 089 155 101 076 146
095 071 179 127 102 196 149 125 207 161 140 184 134 109 176 122 097 168 112 085
130 083 061 170 115 089 155 101 076 134 086 064 144 093 069 181 129 104 190 140
115 168 112 085 166 110 083 170 115 089 173 118 092 170 115 089 166 110 083 170
115 089 170 115 089 166 110 083 168 112 085 166 109 082 177 124 098 126 080 059
115 073 054 185 135 110 174 120 094 170 115 089 177 124 098 183 131 106 168 112
085 134 086 064 125 079 058 151 098 074 143 092 069 177 124 098 183 131 106 165
108 081 162 107 079 181 129 104 130 083 061 115 073 054 146 095 071 136 087 064
117 074 054 151 098 074 120 076 056 126 080 059 157 102 076 152 100 074 168 112
085 143 092 069 144 093 069 170 115 089 155 101 076 162 107 079 168 112 085 162
107 079 166 110 083 166 110 083 170 115 089 168 112 085 155 101 076 169 113 087
152 100 074 134 086 064 152 100 074 174 119 093 183 132 106 177 124 098 138 089
065 155 101 076 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089 166
109 082 166 110 083 161 106 079 162 107 079 151 098 074 135 086 064 121 077 057
176 122 097 166 109 082 099 061 044 114 072 052 198 151 127 200 155 132 190 140
115 151 098 074 169 113 087 207 163 141 199 152 129 200 155 132 202 157 134 169
113 087 144 093 069 157 102 076 168 112 085 193 146 122 193 144 120 185 135 110
190 140 115 190 140 115 183 132 106 185 135 110 190 140 115 188 139 114 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 185 135 110 188 139 114 190 140 115 185 135 110 185 135 110 184 134 109
190 140 115 193 144 120 144 093 069 144 093 069 121 077 057 126 080 059 161 106
079 165 108 081 134 086 064 162 107 079 152 100 074 099 061 044 166 110 083 123
079 058 161 106 079 162 107 079 166 110 083 177 124 098 177 124 098 173 118 092
181 129 104 170 115 089 151 098 074 162 107 079 153 100 074 155 101 076 157 102
076 168 112 085 153 100 074 138 089 065 173 118 092 166 109 082 183 131 106 151
098 074 121 077 057 177 124 098 168 112 085 115 073 054 153 100 074 161 106 079
161 106 079 102 063 046 151 098 074 151 098 074 135 086 064 168 112 085 166 110
083 143 092 069 146 095 071 168 112 085 168 112 085 170 115 089 168 112 085 169
113 087 174 120 094 143 092 069 166 109 082 148 096 071 151 098 074 169 113 087
188 139 114 157 102 076 115 073 054 146 095 071 193 144 120 102 065 046 174 120
094 200 154 131 200 155 132 202 158 135 157 102 076 199 152 129 170 115 089 170
115 089 199 152 129 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 192 143 118 196 149 125
181 129 104 198 151 127 199 152 129 193 144 120 126 080 059 173 118 092 174 120
094 170 115 089 179 127 101 176 122 097 170 115 089 174 119 093 121 077 057 144
093 069 096 059 042 072 043 030 046 024 015 069 041 028 082 050 035 064 036 024
121 077 057 120 076 056 134 086 064 176 122 097 176 122 097 179 127 101 138 089
065 153 100 074 166 109 082 165 108 081 187 137 112 138 089 065 151 098 074 168
112 085 162 107 079 126 080 059 134 086 064 152 100 074 134 086 064 166 110 083
115 073 054 166 109 082 202 157 134 161 106 079 091 056 039 169 113 087 170 115
089 173 118 092 169 113 087 169 113 087 168 112 085 166 109 082 183 132 106 155
101 076 064 036 024 162 107 079 185 135 110 192 143 118 188 139 114 170 115 089
162 107 079 170 115 089 170 115 089 179 127 101 174 120 094 136 087 064 093 057
041 134 086 064 183 131 106 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 173 118 092 170 115 089 170 115 089 165 108 081 166 110 083 179 127 101
152 100 074 115 073 054 121 077 057 115 073 054 111 070 051 168 112 085 187 137
112 174 120 094 129 083 061 136 087 064 120 076 056 082 050 035 129 083 061 174
120 094 193 144 120 179 127 102 120 076 056 108 068 049 123 079 058 130 083 061
148 096 071 165 108 081 157 102 076 162 107 079 162 107 079 155 101 076 138 089
065 120 076 056 153 100 074 170 115 089 162 107 079 166 110 083 170 115 089 173
118 092 168 112 085 162 107 079 165 108 081 165 108 081 170 115 089 174 120 094
174 120 094 173 118 092 146 095 071 162 107 079 144 093 069 146 095 071 151 098
074 143 092 069 169 113 087 170 115 089 169 113 087 169 113 087 166 109 082 179
127 102 134 086 064 144 093 069 176 122 097 179 127 102 184 134 109 166 109 082
151 098 074 177 124 098 155 101 076 091 056 039 130 083 061 207 161 140 202 157
134 193 144 120 121 077 057 126 080 059 187 137 112 193 144 120 192 143 119 193
144 120 209 166 144 183 131 106 157 102 076 179 127 102 179 127 101 193 144 120
190 140 115 183 132 106 179 127 102 183 131 106 183 132 106 190 140 115 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 187 137 112 187 137 112 185 135 110 183 132 106 185 135 110
213 171 150 174 119 093 080 048 033 170 115 089 173 118 092 091 056 039 170 115
089 187 137 112 174 120 094 144 093 069 114 072 052 153 100 074 140 090 067 151
098 074 183 132 106 179 127 101 173 118 092 166 110 083 174 120 094 174 120 094
174 119 093 166 110 083 162 107 079 183 131 106 181 129 104 179 127 102 174 120
094 183 132 106 162 107 079 155 101 076 185 135 110 183 132 106 173 118 092 183
131 106 125 079 058 123 079 058 181 129 104 179 127 101 190 140 115 199 152 129
183 131 106 161 106 079 168 112 085 169 113 087 187 137 112 166 109 082 138 089
065 173 118 092 179 127 102 169 113 087 169 113 087 173 118 092 161 106 079 169
113 087 162 107 079 082 050 035 093 057 041 121 077 057 143 092 069 174 120 094
120 076 056 144 093 069 209 167 145 202 157 134 190 140 115 200 155 132 183 131
106 134 086 064 166 110 083 151 098 074 087 053 037 138 089 065 078 047 032 138
089 065 204 160 137 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 183 132 106 183 132 106
196 149 125 174 119 093 168 112 085 120 076 056 146 095 071 176 122 097 170 115
089 168 112 085 174 120 094 170 115 089 161 106 079 181 129 104 162 107 079 123
079 058 162 107 079 123 079 058 126 080 059 126 080 059 120 076 056 134 086 064
146 095 071 140 090 067 126 080 059 162 107 079 173 118 092 155 101 076 188 139
114 166 109 082 162 107 079 161 106 079 102 063 046 120 076 056 157 102 076 136
087 064 140 090 067 126 080 059 168 112 085 153 100 074 161 106 079 179 127 101
183 131 106 173 118 092 162 107 079 157 102 076 123 079 058 136 087 064 177 124
098 166 110 083 169 113 087 177 124 098 162 107 079 173 118 092 170 115 089 161
106 079 152 100 074 162 107 079 155 101 076 144 093 069 140 090 067 155 101 076
179 127 101 166 110 083 170 115 089 165 108 081 168 112 085 174 120 094 170 115
089 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 165
108 081 168 112 085 169 113 087 170 115 089 166 109 082 151 098 074 176 122 097
174 119 093 148 096 071 166 110 083 176 122 097 162 107 079 162 107 079 168 112
085 146 095 071 143 092 069 155 101 076 169 113 087 144 093 069 162 107 079 173
118 092 146 095 071 108 068 049 098 061 044 136 087 064 162 107 079 170 115 089
179 127 101 162 107 079 162 107 079 138 089 065 135 086 064 140 090 067 135 086
064 155 101 076 168 112 085 166 109 082 169 113 087 155 101 076 155 101 076 155
101 076 153 100 074 161 106 079 169 113 087 168 112 085 170 115 089 168 112 085
162 107 079 168 112 085 144 093 069 155 101 076 144 093 069 148 096 071 166 109
082 138 089 065 153 100 074 170 115 089 170 115 089 169 113 087 166 110 083 170
115 089 165 108 081 148 096 071 157 102 076 148 096 071 162 107 079 166 110 083
123 079 058 153 100 074 168 112 085 168 112 085 102 065 046 126 080 059 202 158
135 199 152 129 098 061 044 183 131 106 207 163 141 185 135 110 190 140 115 192
143 118 183 131 106 188 139 114 200 155 132 179 127 102 174 120 094 192 143 118
185 135 110 192 143 119 193 144 120 193 144 120 187 137 112 183 131 106 185 135
110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 183 132 106 183 131 106 193 144 120 200 155 132 209 166 144
188 139 114 091 056 039 125 079 058 138 089 065 098 061 044 087 053 037 091 056
039 121 077 057 123 079 058 091 056 039 126 080 059 134 086 064 108 068 049 165
108 081 152 100 074 140 090 067 144 093 069 140 090 067 153 100 074 151 098 074
152 100 074 140 090 067 135 086 064 155 101 076 144 093 069 155 101 076 152 100
074 155 101 076 138 089 065 144 093 069 165 108 081 135 086 064 134 086 064 140
090 067 169 113 087 155 101 076 138 089 065 148 096 071 169 113 087 162 107 079
153 100 074 174 120 094 174 120 094 157 102 076 166 109 082 173 118 092 151 098
074 173 118 092 170 115 089 168 112 085 173 118 092 170 115 089 155 101 076 168
112 085 185 135 110 176 122 097 129 083 061 135 086 064 162 107 079 138 089 065
093 057 041 140 090 067 207 161 140 184 134 109 173 118 092 200 155 132 183 131
106 068 041 028 136 087 064 168 112 085 183 131 106 136 087 064 089 054 039 198
151 127 200 154 131 184 134 109 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 187 137 112 187 137 112 188 139 114 185 135 110 183 131 106
202 158 135 151 098 074 111 070 051 166 109 082 155 101 076 151 098 074 170 115
089 170 115 089 162 107 079 168 112 085 174 119 093 179 127 101 192 143 119 108
068 049 143 092 069 179 127 101 183 132 106 190 140 115 174 120 094 134 086 064
126 080 059 153 100 074 153 100 074 126 080 059 135 086 064 091 056 039 089 054
039 134 086 064 102 065 046 129 083 061 152 100 074 170 115 089 135 086 064 126
080 059 151 098 074 174 120 094 181 129 104 170 115 089 166 109 082 161 106 079
174 119 093 170 115 089 166 109 082 174 120 094 198 151 127 148 096 071 151 098
074 168 112 085 170 115 089 166 110 083 166 110 083 179 127 102 130 083 061 140
090 067 185 135 110 170 115 089 162 107 079 168 112 085 177 124 098 168 112 085
166 109 082 165 108 081 170 115 089 170 115 089 165 108 081 168 112 085 157 102
076 157 102 076 170 115 089 170 115 089 169 113 087 173 118 092 168 112 085 165
108 081 168 112 085 168 112 085 170 115 089 168 112 085 170 115 089 166 110 083
168 112 085 168 112 085 157 102 076 170 115 089 169 113 087 166 110 083 170 115
089 176 122 097 170 115 089 183 132 106 179 127 101 121 077 057 099 061 044 087
053 037 106 067 048 151 098 074 146 095 071 134 086 064 166 110 083 174 119 093
166 109 082 166 109 082 170 115 089 168 112 085 155 101 076 134 086 064 157 102
076 162 107 079 170 115 089 151 098 074 151 098 074 168 112 085 169 113 087 155
101 076 140 090 067 138 089 065 144 093 069 165 108 081 170 115 089 170 115 089
179 127 101 129 083 061 170 115 089 169 113 087 174 120 094 183 131 106 165 108
081 157 102 076 148 096 071 155 101 076 168 112 085 166 110 083 170 115 089 174
119 093 179 127 101 169 113 087 120 076 056 138 089 065 144 093 069 161 106 079
155 101 076 168 112 085 192 143 118 162 107 079 125 079 058 085 051 036 177 124
098 202 157 134 102 063 046 179 127 101 181 129 104 188 139 114 184 134 109 187
137 112 192 143 119 181 129 104 188 139 114 190 140 115 196 149 125 188 139 114
174 120 094 202 157 134 193 144 120 185 135 110 193 146 122 183 131 106 183 132
106 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 185
135 110 185 135 110 185 135 110 185 135 110 187 137 112 188 139 114 185 135 110
190 140 115 188 139 114 185 135 110 185 135 110 188 139 114 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112 190 140 115 188
139 114 188 139 114 190 140 115 183 131 106 193 144 120 188 139 114 152 100 074
082 050 035 143 092 069 144 093 069 082 050 035 114 072 052 148 096 071 125 079
058 120 076 056 093 057 041 117 074 054 130 083 061 082 050 035 165 108 081 174
119 093 168 112 085 146 095 071 138 089 065 166 110 083 155 101 076 151 098 074
155 101 076 155 101 076 161 106 079 161 106 079 121 077 057 144 093 069 174 119
093 155 101 076 148 096 071 190 140 115 134 086 064 051 027 018 170 115 089 183
132 106 170 115 089 185 135 110 174 119 093 106 067 048 140 090 067 152 100 074
176 122 097 179 127 101 174 120 094 179 127 101 170 115 089 179 127 101 155 101
076 173 118 092 168 112 085 169 113 087 169 113 087 170 115 089 168 112 085 157
102 076 155 101 076 174 120 094 174 119 093 166 109 082 134 086 064 146 095 071
199 152 129 183 132 106 134 086 064 134 086 064 169 113 087 190 140 115 202 157
134 198 151 127 135 086 064 126 080 059 155 101 076 165 108 081 199 152 129 207
163 141 181 129 104 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 185 135 110 187 137 112 190 140 115 187 137 112 188 139 114 192 143 119
170 115 089 185 135 110 202 158 135 193 144 120 152 100 074 193 144 120 170 115
089 151 098 074 174 119 093 185 135 110 144 093 069 121 077 057 121 077 057 155
101 076 169 113 087 170 115 089 174 119 093 170 115 089 120 076 056 151 098 074
183 131 106 170 115 089 153 100 074 144 093 069 117 074 054 143 092 069 134 086
064 151 098 074 134 086 064 162 107 079 190 140 115 170 115 089 173 118 092 183
132 106 179 127 102 170 115 089 170 115 089 170 115 089 165 108 081 169 113 087
176 122 097 177 124 098 157 102 076 151 098 074 155 101 076 126 080 059 136 087
064 177 124 098 168 112 085 166 110 083 166 109 082 170 115 089 162 107 079 148
096 071 155 101 076 173 118 092 179 127 102 161 106 079 165 108 081 174 120 094
179 127 101 170 115 089 170 115 089 176 122 097 174 120 094 168 112 085 176 122
097 179 127 101 165 108 081 168 112 085 170 115 089 174 119 093 174 119 093 170
115 089 168 112 085 168 112 085 170 115 089 169 113 087 170 115 089 168 112 085
166 110 083 174 119 093 168 112 085 170 115 089 170 115 089 170 115 089 179 127
101 183 131 106 170 115 089 125 079 058 126 080 059 126 080 059 099 061 044 108
068 049 126 080 059 117 074 054 140 090 067 134 086 064 165 108 081 174 120 094
138 089 065 136 087 064 143 092 069 143 092 069 170 115 089 146 095 071 121 077
057 155 101 076 155 101 076 134 086 064 126 080 059 165 108 081 170 115 089 129
083 061 126 080 059 136 087 064 136 087 064 115 073 054 125 079 058 138 089 065
155 101 076 146 095 071 151 098 074 143 092 069 140 090 067 170 115 089 174 120
094 166 110 083 153 100 074 152 100 074 166 110 083 170 115 089 170 115 089 140
090 067 143 092 069 152 100 074 162 107 079 184 134 109 155 101 076 144 093 069
155 101 076 165 108 081 170 115 089 166 110 083 162 107 079 144 093 069 134 086
064 198 151 127 143 092 069 111 070 051 138 089 065 200 155 132 190 140 115 185
135 110 192 143 118 192 143 119 190 140 115 187 137 112 183 132 106 188 139 114
179 127 102 148 096 071 190 140 115 209 167 145 184 134 109 183 131 106 190 140
115 190 140 115 185 135 110 187 137 112 190 140 115 187 137 112 187 137 112 187
137 112 188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 080 048 033 080 048
033 192 143 119 192 143 119 187 137 112 190 140 115 193 146 122 193 146 122 193
144 120 192 143 118 190 140 115 187 137 112 185 135 110 185 135 110 192 143 118
185 135 110 185 135 110 192 143 119 190 140 115 187 137 112 190 140 115 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 183 131 106 183
132 106 190 140 115 190 140 115 200 155 132 184 134 109 089 054 039 078 047 032
089 054 039 111 070 051 099 061 044 090 054 039 134 086 064 162 107 079 148 096
071 138 089 065 123 079 058 121 077 057 078 047 032 148 096 071 185 135 110 166
110 083 185 135 110 170 115 089 162 107 079 183 131 106 173 118 092 177 124 098
174 120 094 174 120 094 174 120 094 176 122 097 162 107 079 181 129 104 170 115
089 138 089 065 173 118 092 162 107 079 143 092 069 166 110 083 185 135 110 168
112 085 174 119 093 176 122 097 157 102 076 151 098 074 183 132 106 176 122 097
170 115 089 162 107 079 165 108 081 165 108 081 183 131 106 152 100 074 115 073
054 183 131 106 179 127 101 168 112 085 168 112 085 166 110 083 168 112 085 168
112 085 155 101 076 153 100 074 170 115 089 173 118 092 155 101 076 140 090 067
162 107 079 162 107 079 136 087 064 162 107 079 165 108 081 144 093 069 144 093
069 204 160 137 184 134 109 085 051 036 185 135 110 198 151 127 187 137 112 184
134 109 185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 188 139 114 190 140 115 199 152 129 193 144 120 196 149 125 202 158 135
170 115 089 140 090 067 146 095 071 170 115 089 165 108 081 151 098 074 170 115
089 165 108 081 146 095 071 115 073 054 165 108 081 129 083 061 135 086 064 183
131 106 151 098 074 169 113 087 165 108 081 155 101 076 144 093 069 138 089 065
143 092 069 146 095 071 134 086 064 151 098 074 176 122 097 183 131 106 179 127
101 183 132 106 179 127 102 146 095 071 166 109 082 179 127 101 174 120 094 170
115 089 165 108 081 166 110 083 155 101 076 174 119 093 173 118 092 183 131 106
166 110 083 134 086 064 151 098 074 152 100 074 138 089 065 166 109 082 174 119
093 170 115 089 166 109 082 170 115 089 166 109 082 166 109 082 176 122 097 162
107 079 126 080 059 136 087 064 174 120 094 177 124 098 173 118 092 170 115 089
135 086 064 134 086 064 155 101 076 144 093 069 144 093 069 153 100 074 152 100
074 148 096 071 166 110 083 170 115 089 168 112 085 168 112 085 168 112 085 168
112 085 169 113 087 166 110 083 168 112 085 174 119 093 170 115 089 169 113 087
168 112 085 166 109 082 174 119 093 162 107 079 174 120 094 170 115 089 148 096
071 134 086 064 155 101 076 111 070 051 085 051 036 151 098 074 134 086 064 136
087 064 165 108 081 125 079 058 115 073 054 152 100 074 135 086 064 134 086 064
144 093 069 151 098 074 136 087 064 111 070 051 126 080 059 162 107 079 162 107
079 143 092 069 115 073 054 130 083 061 121 077 057 121 077 057 134 086 064 166
110 083 155 101 076 155 101 076 170 115 089 153 100 074 146 095 071 151 098 074
140 090 067 168 112 085 151 098 074 155 101 076 138 089 065 129 083 061 174 120
094 168 112 085 148 096 071 151 098 074 162 107 079 174 120 094 165 108 081 134
086 064 179 127 101 181 129 104 168 112 085 129 083 061 168 112 085 168 112 085
106 067 048 134 086 064 143 092 069 168 112 085 162 107 079 144 093 069 120 076
056 199 152 129 155 101 076 129 083 061 192 143 118 198 151 127 183 131 106 192
143 118 188 139 114 187 137 112 190 140 115 193 144 120 184 134 109 184 134 109
200 155 132 136 087 064 126 080 059 199 152 129 207 161 140 174 120 094 183 132
106 187 137 112 192 143 118 188 139 114 183 131 106 190 140 115 185 135 110 188
139 114 185 135 110 185 135 110 185 135 110 185 135 110 190 140 115 187 137 112
185 135 110 187 137 112 188 139 114 190 140 115 190 140 115 080 048 033 080 048
033 169 113 087 135 086 064 166 109 082 200 154 131 173 118 092 168 112 085 185
135 110 198 151 127 192 143 119 193 144 120 199 152 129 198 151 127 190 140 115
185 135 110 193 144 120 193 146 122 193 144 120 181 129 104 183 132 106 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 184 134 109 192 143 119 193 146 122 177 124 098 204
160 137 187 137 112 183 131 106 202 158 135 212 170 149 126 080 059 093 057 041
089 054 039 134 086 064 176 122 097 165 108 081 174 119 093 144 093 069 104 066
047 134 086 064 104 066 047 078 047 032 121 077 057 183 131 106 170 115 089 168
112 085 168 112 085 153 100 074 155 101 076 170 115 089 168 112 085 170 115 089
166 110 083 170 115 089 169 113 087 165 108 081 168 112 085 183 131 106 082 050
035 120 076 056 155 101 076 111 070 051 144 093 069 169 113 087 173 118 092 166
110 083 170 115 089 165 108 081 170 115 089 183 132 106 162 107 079 170 115 089
173 118 092 157 102 076 170 115 089 184 134 109 151 098 074 126 080 059 146 095
071 144 093 069 173 118 092 168 112 085 170 115 089 168 112 085 169 113 087 166
109 082 169 113 087 162 107 079 162 107 079 155 101 076 174 120 094 170 115 089
148 096 071 111 070 051 161 106 079 148 096 071 140 090 067 162 107 079 138 089
065 125 079 058 162 107 079 104 066 047 148 096 071 200 155 132 185 135 110 184
134 109 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 207 163 141 174 119 093 123 079 058 170 115 089 166 110 083 193 144 120
204 160 137 168 112 085 093 057 041 121 077 057 162 107 079 168 112 085 144 093
069 143 092 069 193 144 120 135 086 064 111 070 051 166 109 082 152 100 074 179
127 101 179 127 101 174 119 093 151 098 074 168 112 085 183 131 106 179 127 101
129 083 061 144 093 069 185 135 110 181 129 104 169 113 087 169 113 087 170 115
089 155 101 076 177 124 098 144 093 069 134 086 064 161 106 079 144 093 069 144
093 069 153 100 074 144 093 069 138 089 065 161 106 079 173 118 092 169 113 087
121 077 057 151 098 074 181 129 104 176 122 097 176 122 097 174 119 093 169 113
087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 162 107 079 177
124 098 184 134 109 151 098 074 144 093 069 144 093 069 143 092 069 155 101 076
143 092 069 168 112 085 165 108 081 140 090 067 152 100 074 170 115 089 134 086
064 151 098 074 179 127 101 166 109 082 157 102 076 170 115 089 170 115 089 168
112 085 168 112 085 168 112 085 170 115 089 168 112 085 162 107 079 168 112 085
170 115 089 170 115 089 162 107 079 179 127 102 170 115 089 135 086 064 138 089
065 157 102 076 170 115 089 144 093 069 166 110 083 166 109 082 162 107 079 134
086 064 135 086 064 134 086 064 136 087 064 151 098 074 108 068 049 130 083 061
151 098 074 153 100 074 166 109 082 152 100 074 102 065 046 120 076 056 144 093
069 114 072 052 120 076 056 152 100 074 125 079 058 106 067 048 153 100 074 166
109 082 155 101 076 169 113 087 170 115 089 162 107 079 155 101 076 153 100 074
165 108 081 170 115 089 168 112 085 168 112 085 174 120 094 140 090 067 134 086
064 168 112 085 166 109 082 152 100 074 152 100 074 162 107 079 140 090 067 161
106 079 170 115 089 165 108 081 174 120 094 144 093 069 138 089 065 166 110 083
121 077 057 144 093 069 183 131 106 174 119 093 138 089 065 168 112 085 165 108
081 165 108 081 135 086 064 151 098 074 196 149 125 187 137 112 188 139 114 187
137 112 187 137 112 187 137 112 185 135 110 185 135 110 188 139 114 190 140 115
185 135 110 207 161 140 162 107 079 093 057 041 188 139 114 207 163 141 181 129
104 181 129 104 192 143 118 188 139 114 185 135 110 192 143 118 188 139 114 187
137 112 185 135 110 184 134 109 183 132 106 192 143 118 193 144 120 190 140 115
185 135 110 192 143 119 185 135 110 179 127 101 170 115 089 080 048 033 080 048
033 185 135 110 177 124 098 184 134 109 198 151 127 162 107 079 152 100 074 177
124 098 188 139 114 185 135 110 179 127 101 165 108 081 185 135 110 193 144 120
193 144 120 184 134 109 183 131 106 187 137 112 193 144 120 188 139 114 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 196 149 125 179 127 102 200 154 131 174
120 094 104 066 047 209 166 144 193 144 120 138 089 065 096 059 042 123 079 058
170 115 089 174 119 093 170 115 089 161 106 079 157 102 076 134 086 064 111 070
051 090 054 039 106 067 048 162 107 079 185 135 110 174 119 093 165 108 081 177
124 098 176 122 097 155 101 076 155 101 076 173 118 092 168 112 085 170 115 089
170 115 089 170 115 089 170 115 089 169 113 087 155 101 076 114 072 052 106 067
048 198 151 127 170 115 089 162 107 079 157 102 076 138 089 065 185 135 110 170
115 089 170 115 089 165 108 081 166 110 083 170 115 089 168 112 085 170 115 089
165 108 081 165 108 081 177 124 098 162 107 079 077 047 032 184 134 109 209 166
144 138 089 065 135 086 064 173 118 092 170 115 089 169 113 087 170 115 089 168
112 085 168 112 085 170 115 089 162 107 079 179 127 101 173 118 092 082 050 035
168 112 085 151 098 074 099 061 044 162 107 079 162 107 079 157 102 076 169 113
087 173 118 092 174 119 093 153 100 074 136 087 064 207 161 140 193 144 120 179
127 102 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183
131 106 192 143 118 204 160 137 090 054 039 114 072 052 170 115 089 130 083 061
200 155 132 155 101 076 114 072 052 181 129 104 181 129 104 190 140 115 134 086
064 125 079 058 196 149 125 200 155 132 151 098 074 104 066 047 117 074 054 126
080 059 188 139 114 169 113 087 168 112 085 168 112 085 173 118 092 179 127 101
155 101 076 183 131 106 155 101 076 168 112 085 177 124 098 169 113 087 157 102
076 170 115 089 179 127 101 138 089 065 162 107 079 166 109 082 157 102 076 170
115 089 170 115 089 169 113 087 177 124 098 126 080 059 126 080 059 140 090 067
166 110 083 179 127 101 165 108 081 166 110 083 169 113 087 169 113 087 169 113
087 169 113 087 170 115 089 168 112 085 169 113 087 168 112 085 168 112 085 165
108 081 166 109 082 177 124 098 170 115 089 168 112 085 166 110 083 166 109 082
177 124 098 177 124 098 161 106 079 169 113 087 169 113 087 179 127 101 138 089
065 140 090 067 174 120 094 174 119 093 174 119 093 166 110 083 166 110 083 170
115 089 166 110 083 169 113 087 166 110 083 170 115 089 177 124 098 179 127 101
179 127 101 174 119 093 181 129 104 170 115 089 126 080 059 162 107 079 184 134
109 170 115 089 173 118 092 179 127 101 174 120 094 174 120 094 173 118 092 174
119 093 166 110 083 161 106 079 157 102 076 135 086 064 130 083 061 144 093 069
135 086 064 138 089 065 162 107 079 168 112 085 144 093 069 115 073 054 123 079
058 126 080 059 166 110 083 179 127 101 179 127 101 169 113 087 121 077 057 104
066 047 138 089 065 126 080 059 155 101 076 170 115 089 173 118 092 157 102 076
143 092 069 152 100 074 162 107 079 155 101 076 170 115 089 153 100 074 099 061
044 146 095 071 170 115 089 155 101 076 151 098 074 151 098 074 144 093 069 179
127 101 168 112 085 166 110 083 174 120 094 174 119 093 151 098 074 161 106 079
130 083 061 106 067 048 173 118 092 168 112 085 148 096 071 169 113 087 130 083
061 104 066 047 153 100 074 151 098 074 192 143 118 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
185 135 110 199 152 129 174 119 093 121 077 057 096 059 042 193 146 122 202 158
135 192 143 119 183 131 106 183 132 106 193 146 122 192 143 118 196 149 125 185
135 110 192 143 119 192 143 118 188 139 114 193 144 120 170 115 089 181 129 104
193 144 120 190 140 115 187 137 112 184 134 109 184 134 109 080 048 033 080 048
033 192 143 118 193 144 120 188 139 114 185 135 110 202 158 135 207 161 140 198
151 127 190 140 115 199 152 129 184 134 109 138 089 065 115 073 054 140 090 067
192 143 119 200 154 131 202 158 135 188 139 114 190 140 115 188 139 114 184 134
109 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 192 143 119 183 132 106 200 155 132 082
050 035 169 113 087 198 151 127 035 018 011 108 068 049 117 074 054 162 107 079
169 113 087 162 107 079 151 098 074 151 098 074 157 102 076 117 074 054 102 063
046 135 086 064 170 115 089 176 122 097 168 112 085 173 118 092 170 115 089 168
112 085 170 115 089 157 102 076 155 101 076 173 118 092 168 112 085 173 118 092
166 109 082 166 109 082 173 118 092 169 113 087 165 108 081 115 073 054 115 073
054 157 102 076 153 100 074 177 124 098 174 120 094 153 100 074 136 087 064 170
115 089 181 129 104 174 120 094 170 115 089 166 109 082 169 113 087 170 115 089
179 127 101 174 120 094 177 124 098 162 107 079 161 106 079 202 158 135 193 144
120 144 093 069 174 120 094 176 122 097 168 112 085 170 115 089 169 113 087 170
115 089 166 110 083 170 115 089 168 112 085 176 122 097 138 089 065 166 109 082
185 135 110 170 115 089 168 112 085 181 129 104 174 119 093 120 076 056 121 077
057 153 100 074 135 086 064 123 079 058 168 112 085 204 160 137 193 146 122 183
132 106 183 131 106 190 140 115 187 137 112 187 137 112 187 137 112 188 139 114
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 183
131 106 190 140 115 200 155 132 102 065 046 143 092 069 196 149 125 129 083 061
168 112 085 200 155 132 155 101 076 138 089 065 174 119 093 117 074 054 134 086
064 200 155 132 179 127 102 188 139 114 185 135 110 170 115 089 155 101 076 138
089 065 125 079 058 169 113 087 183 131 106 174 120 094 179 127 101 148 096 071
121 077 057 162 107 079 153 100 074 174 120 094 170 115 089 151 098 074 170 115
089 183 131 106 174 120 094 126 080 059 152 100 074 179 127 101 176 122 097 170
115 089 168 112 085 166 109 082 183 131 106 155 101 076 115 073 054 174 120 094
179 127 101 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 168 112 085 168 112 085 168 112 085 170 115 089 168
112 085 157 102 076 170 115 089 166 110 083 169 113 087 170 115 089 166 109 082
161 106 079 166 109 082 174 120 094 151 098 074 138 089 065 174 120 094 174 120
094 089 054 039 140 090 067 170 115 089 162 107 079 169 113 087 179 127 101 174
119 093 174 119 093 174 120 094 174 120 094 170 115 089 151 098 074 126 080 059
134 086 064 162 107 079 157 102 076 121 077 057 166 109 082 184 134 109 165 108
081 170 115 089 168 112 085 170 115 089 166 109 082 166 110 083 162 107 079 177
124 098 151 098 074 129 083 061 151 098 074 170 115 089 183 132 106 161 106 079
143 092 069 140 090 067 120 076 056 121 077 057 138 089 065 155 101 076 155 101
076 168 112 085 176 122 097 162 107 079 173 118 092 174 119 093 161 106 079 138
089 065 162 107 079 138 089 065 135 086 064 140 090 067 169 113 087 174 119 093
168 112 085 161 106 079 151 098 074 151 098 074 135 086 064 162 107 079 155 101
076 135 086 064 134 086 064 136 087 064 151 098 074 153 100 074 170 115 089 170
115 089 162 107 079 168 112 085 155 101 076 155 101 076 168 112 085 170 115 089
151 098 074 162 107 079 144 093 069 102 065 046 146 095 071 140 090 067 125 079
058 187 137 112 140 090 067 157 102 076 200 155 132 184 134 109 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
193 144 120 179 127 102 144 093 069 136 087 064 125 079 058 091 056 039 192 143
118 209 166 144 185 135 110 183 131 106 183 131 106 192 143 119 198 151 127 187
137 112 192 143 118 190 140 115 185 135 110 192 143 119 174 119 093 183 131 106
190 140 115 184 134 109 187 137 112 190 140 115 190 140 115 080 048 033 080 048
033 190 140 115 193 144 120 190 140 115 185 135 110 193 144 120 193 144 120 190
140 115 185 135 110 184 134 109 190 140 115 204 160 137 193 144 120 183 131 106
181 129 104 148 096 071 111 070 051 144 093 069 209 167 145 207 163 141 200 155
132 199 152 129 185 135 110 183 132 106 190 140 115 185 135 110 185 135 110 188
139 114 188 139 114 190 140 115 187 137 112 188 139 114 187 137 112 190 140 115
187 137 112 184 134 109 187 137 112 187 137 112 187 137 112 190 140 115 185 135
110 185 135 110 187 137 112 192 143 118 183 132 106 200 154 131 200 155 132 125
079 058 213 171 150 134 086 064 090 054 039 126 080 059 143 092 069 174 120 094
143 092 069 155 101 076 173 118 092 152 100 074 120 076 056 143 092 069 155 101
076 192 143 118 179 127 101 162 107 079 151 098 074 166 110 083 170 115 089 166
109 082 179 127 101 162 107 079 155 101 076 173 118 092 168 112 085 173 118 092
168 112 085 168 112 085 177 124 098 166 110 083 161 106 079 193 144 120 181 129
104 106 067 048 130 083 061 183 132 106 169 113 087 181 129 104 173 118 092 140
090 067 144 093 069 173 118 092 181 129 104 170 115 089 179 127 102 169 113 087
135 086 064 162 107 079 155 101 076 148 096 071 202 157 134 207 163 141 148 096
071 126 080 059 165 108 081 174 120 094 170 115 089 168 112 085 169 113 087 168
112 085 169 113 087 168 112 085 174 120 094 174 120 094 121 077 057 134 086 064
144 093 069 155 101 076 168 112 085 169 113 087 162 107 079 169 113 087 134 086
064 072 043 030 111 070 051 199 152 129 200 154 131 183 132 106 190 140 115 188
139 114 184 134 109 190 140 115 187 137 112 187 137 112 188 139 114 184 134 109
188 139 114 190 140 115 190 140 115 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 190 140 115 183 131 106 200 155 132 162 107 079 068 041 028 125 079 058
165 108 081 170 115 089 121 077 057 151 098 074 144 093 069 144 093 069 202 157
134 199 152 129 183 131 106 190 140 115 190 140 115 200 155 132 202 158 135 204
160 137 151 098 074 117 074 054 144 093 069 102 063 046 129 083 061 155 101 076
185 135 110 181 129 104 173 118 092 152 100 074 121 077 057 146 095 071 115 073
054 136 087 064 117 074 054 166 110 083 170 115 089 126 080 059 161 106 079 174
120 094 168 112 085 187 137 112 165 108 081 130 083 061 174 119 093 179 127 101
162 107 079 166 110 083 174 119 093 168 112 085 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 170 115 089 168 112 085 166 110 083 169 113 087 170
115 089 168 112 085 168 112 085 168 112 085 169 113 087 166 109 082 166 109 082
174 119 093 162 107 079 173 118 092 162 107 079 138 089 065 144 093 069 173 118
092 166 109 082 168 112 085 155 101 076 136 087 064 151 098 074 151 098 074 146
095 071 162 107 079 173 118 092 155 101 076 138 089 065 148 096 071 161 106 079
165 108 081 165 108 081 125 079 058 155 101 076 184 134 109 168 112 085 168 112
085 168 112 085 170 115 089 168 112 085 168 112 085 166 109 082 173 118 092 168
112 085 126 080 059 148 096 071 169 113 087 155 101 076 155 101 076 161 106 079
135 086 064 146 095 071 151 098 074 152 100 074 168 112 085 170 115 089 181 129
104 170 115 089 166 109 082 155 101 076 153 100 074 151 098 074 174 120 094 170
115 089 166 110 083 152 100 074 130 083 061 152 100 074 144 093 069 146 095 071
155 101 076 157 102 076 173 118 092 170 115 089 140 090 067 148 096 071 170 115
089 170 115 089 155 101 076 161 106 079 168 112 085 166 109 082 162 107 079 155
101 076 169 113 087 174 120 094 166 110 083 134 086 064 115 073 054 143 092 069
152 100 074 135 086 064 169 113 087 162 107 079 168 112 085 174 120 094 193 144
120 199 152 129 170 115 089 193 144 120 190 140 115 187 137 112 185 135 110 187
137 112 190 140 115 188 139 114 190 140 115 190 140 115 187 137 112 187 137 112
193 146 122 166 110 083 161 106 079 115 073 054 169 113 087 152 100 074 090 054
039 126 080 059 192 143 118 199 152 129 193 146 122 179 127 101 148 096 071 179
127 101 184 134 109 190 140 115 183 131 106 192 143 119 193 144 120 192 143 118
187 137 112 187 137 112 188 139 114 190 140 115 185 135 110 080 048 033 080 048
033 190 140 115 190 140 115 190 140 115 184 134 109 185 135 110 183 131 106 185
135 110 187 137 112 183 132 106 185 135 110 187 137 112 198 151 127 204 160 137
196 149 125 174 119 093 173 118 092 152 100 074 089 054 039 080 048 033 146 095
071 177 124 098 202 158 135 202 158 135 176 122 097 200 155 132 200 154 131 190
140 115 184 134 109 185 135 110 188 139 114 185 135 110 185 135 110 179 127 102
187 137 112 193 146 122 190 140 115 190 140 115 185 135 110 185 135 110 190 140
115 193 144 120 190 140 115 174 119 093 188 139 114 204 160 137 168 112 085 102
063 046 068 041 028 068 041 028 148 096 071 136 087 064 126 080 059 144 093 069
138 089 065 146 095 071 146 095 071 125 079 058 152 100 074 165 108 081 162 107
079 170 115 089 166 110 083 176 122 097 168 112 085 155 101 076 168 112 085 174
119 093 170 115 089 155 101 076 157 102 076 173 118 092 168 112 085 173 118 092
169 113 087 166 109 082 170 115 089 153 100 074 143 092 069 170 115 089 176 122
097 174 120 094 184 134 109 166 109 082 165 108 081 169 113 087 170 115 089 174
120 094 169 113 087 146 095 071 162 107 079 170 115 089 151 098 074 152 100 074
153 100 074 168 112 085 174 120 094 179 127 102 185 135 110 193 144 120 200 155
132 179 127 101 155 101 076 155 101 076 166 109 082 170 115 089 168 112 085 170
115 089 168 112 085 169 113 087 168 112 085 169 113 087 140 090 067 148 096 071
174 119 093 155 101 076 111 070 051 155 101 076 162 107 079 152 100 074 177 124
098 196 149 125 200 155 132 202 157 134 183 132 106 183 131 106 192 143 118 190
140 115 188 139 114 187 137 112 187 137 112 187 137 112 185 135 110 193 146 122
188 139 114 183 131 106 184 134 109 184 134 109 187 137 112 188 139 114 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 192
143 119 185 135 110 184 134 109 204 160 137 190 140 115 170 115 089 196 149 125
091 056 039 091 056 039 166 110 083 152 100 074 170 115 089 200 154 131 196 149
125 185 135 110 190 140 115 185 135 110 192 143 119 181 129 104 174 119 093 192
143 118 170 115 089 115 073 054 117 074 054 104 066 047 111 070 051 170 115 089
168 112 085 193 144 120 204 160 137 185 135 110 183 131 106 209 166 144 161 106
079 108 068 049 170 115 089 170 115 089 193 144 120 165 108 081 114 072 052 148
096 071 165 108 081 138 089 065 121 077 057 165 108 081 183 132 106 166 110 083
170 115 089 170 115 089 166 109 082 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 170 115 089 168 112 085 168 112 085 168
112 085 170 115 089 168 112 085 169 113 087 170 115 089 170 115 089 162 107 079
170 115 089 168 112 085 162 107 079 168 112 085 174 120 094 162 107 079 162 107
079 179 127 101 170 115 089 170 115 089 174 120 094 170 115 089 162 107 079 161
106 079 144 093 069 151 098 074 157 102 076 170 115 089 179 127 101 174 120 094
176 122 097 170 115 089 176 122 097 174 120 094 162 107 079 168 112 085 173 118
092 168 112 085 170 115 089 170 115 089 173 118 092 170 115 089 170 115 089 170
115 089 170 115 089 169 113 087 170 115 089 165 108 081 140 090 067 170 115 089
166 110 083 170 115 089 185 135 110 173 118 092 169 113 087 168 112 085 166 110
083 168 112 085 169 113 087 174 120 094 162 107 079 136 087 064 152 100 074 187
137 112 130 083 061 091 056 039 151 098 074 144 093 069 140 090 067 120 076 056
111 070 051 135 086 064 151 098 074 140 090 067 151 098 074 148 096 071 157 102
076 165 108 081 165 108 081 153 100 074 153 100 074 155 101 076 152 100 074 155
101 076 162 107 079 144 093 069 146 095 071 138 089 065 135 086 064 123 079 058
135 086 064 117 074 054 138 089 065 173 118 092 204 160 137 200 154 131 183 132
106 174 119 093 193 144 120 190 140 115 179 127 101 193 144 120 190 140 115 185
135 110 184 134 109 187 137 112 183 132 106 185 135 110 188 139 114 187 137 112
200 154 131 170 115 089 170 115 089 151 098 074 096 059 042 170 115 089 140 090
067 091 056 039 174 120 094 193 146 122 190 140 115 176 122 097 168 112 085 181
129 104 179 127 102 192 143 118 193 144 120 184 134 109 185 135 110 190 140 115
190 140 115 190 140 115 187 137 112 185 135 110 185 135 110 080 048 033 080 048
033 187 137 112 185 135 110 187 137 112 188 139 114 187 137 112 190 140 115 190
140 115 193 144 120 183 132 106 169 113 087 190 140 115 183 132 106 185 135 110
185 135 110 184 134 109 207 163 141 207 161 140 176 122 097 177 124 098 106 067
048 057 032 021 117 074 054 192 143 119 204 160 137 152 100 074 165 108 081 204
160 137 183 131 106 181 129 104 193 144 120 192 143 118 190 140 115 185 135 110
190 140 115 192 143 119 190 140 115 188 139 114 185 135 110 190 140 115 192 143
118 183 132 106 181 129 104 204 160 137 198 151 127 117 074 054 080 048 033 087
053 037 085 051 036 121 077 057 114 072 052 121 077 057 134 086 064 138 089 065
134 086 064 125 079 058 120 076 056 134 086 064 181 129 104 151 098 074 130 083
061 168 112 085 162 107 079 169 113 087 165 108 081 166 110 083 162 107 079 168
112 085 177 124 098 155 101 076 144 093 069 174 119 093 174 119 093 166 110 083
161 106 079 166 109 082 174 120 094 146 095 071 144 093 069 176 122 097 166 109
082 170 115 089 168 112 085 169 113 087 165 108 081 166 109 082 170 115 089 151
098 074 165 108 081 140 090 067 104 066 047 151 098 074 174 120 094 200 154 131
196 149 125 200 155 132 199 152 129 198 151 127 187 137 112 181 129 104 183 131
106 193 144 120 198 151 127 134 086 064 166 109 082 174 119 093 165 108 081 173
118 092 170 115 089 179 127 101 161 106 079 176 122 097 184 134 109 183 131 106
183 131 106 152 100 074 162 107 079 115 073 054 099 061 044 193 144 120 202 157
134 193 146 122 188 139 114 184 134 109 190 140 115 190 140 115 185 135 110 187
137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
188 139 114 183 132 106 183 132 106 188 139 114 188 139 114 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185
135 110 188 139 114 188 139 114 181 129 104 183 132 106 209 166 144 198 151 127
037 019 011 148 096 071 165 108 081 108 068 049 193 146 122 193 144 120 183 131
106 183 132 106 185 135 110 190 140 115 193 146 122 188 139 114 200 155 132 188
139 114 148 096 071 134 086 064 140 090 067 202 157 134 123 079 058 130 083 061
162 107 079 138 089 065 123 079 058 193 144 120 192 143 118 202 157 134 187 137
112 138 089 065 177 124 098 114 072 052 144 093 069 174 120 094 179 127 102 168
112 085 130 083 061 151 098 074 170 115 089 183 131 106 169 113 087 168 112 085
166 109 082 168 112 085 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 168 112 085
166 110 083 168 112 085 168 112 085 170 115 089 170 115 089 168 112 085 168 112
085 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 173 118 092 174
120 094 174 120 094 173 118 092 174 120 094 173 118 092 169 113 087 170 115 089
169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 173 118 092 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 173 118 092 170 115 089 170 115 089 170 115 089 165 108 081 168 112 085
170 115 089 169 113 087 169 113 087 168 112 085 166 110 083 168 112 085 168 112
085 166 110 083 166 109 082 168 112 085 170 115 089 161 106 079 161 106 079 166
109 082 169 113 087 134 086 064 123 079 058 138 089 065 157 102 076 138 089 065
120 076 056 136 087 064 134 086 064 111 070 051 130 083 061 134 086 064 126 080
059 129 083 061 146 095 071 161 106 079 155 101 076 161 106 079 148 096 071 134
086 064 135 086 064 138 089 065 161 106 079 148 096 071 155 101 076 166 109 082
168 112 085 174 120 094 144 093 069 096 059 042 134 086 064 196 149 125 204 160
137 196 149 125 183 131 106 183 132 106 192 143 118 185 135 110 190 140 115 192
143 118 185 135 110 184 134 109 179 127 102 174 120 094 183 131 106 184 134 109
198 151 127 174 120 094 134 086 064 170 115 089 174 119 093 115 073 054 138 089
065 166 110 083 078 047 032 168 112 085 209 166 144 192 143 118 202 158 135 198
151 127 193 144 120 192 143 118 196 149 125 193 144 120 183 131 106 183 132 106
193 144 120 188 139 114 185 135 110 188 139 114 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 187 137 112 190
140 115 185 135 110 183 132 106 190 140 115 190 140 115 185 135 110 179 127 102
183 131 106 192 143 118 181 129 104 183 132 106 202 157 134 200 154 131 199 152
129 199 152 129 134 086 064 120 076 056 170 115 089 155 101 076 035 018 011 053
029 019 209 167 145 207 161 140 177 124 098 184 134 109 187 137 112 193 146 122
185 135 110 174 120 094 184 134 109 183 131 106 185 135 110 183 131 106 183 131
106 200 155 132 215 175 154 196 149 125 077 047 032 053 029 019 068 041 028 085
051 036 135 086 064 165 108 081 143 092 069 138 089 065 136 087 064 135 086 064
126 080 059 111 070 051 138 089 065 170 115 089 174 120 094 162 107 079 146 095
071 168 112 085 169 113 087 169 113 087 161 106 079 179 127 101 174 119 093 152
100 074 166 110 083 174 120 094 168 112 085 179 127 101 179 127 101 174 119 093
166 110 083 165 108 081 170 115 089 152 100 074 151 098 074 173 118 092 168 112
085 168 112 085 166 110 083 170 115 089 176 122 097 170 115 089 161 106 079 138
089 065 176 122 097 183 132 106 192 143 118 199 152 129 196 149 125 185 135 110
190 140 115 188 139 114 185 135 110 181 129 104 193 144 120 185 135 110 179 127
102 200 155 132 179 127 101 144 093 069 174 120 094 168 112 085 169 113 087 173
118 092 166 110 083 166 110 083 168 112 085 146 095 071 166 110 083 151 098 074
179 127 101 188 139 114 144 093 069 072 043 030 168 112 085 204 160 137 181 129
104 181 129 104 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 183 131 106
185 135 110 193 144 120 192 143 119 190 140 115 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 185 135 110 187 137 112 185 135 110 198 151 127 179 127 101 104 066 047
114 072 052 123 079 058 108 068 049 162 107 079 166 109 082 183 132 106 183 131
106 187 137 112 190 140 115 190 140 115 185 135 110 209 166 144 188 139 114 185
135 110 193 144 120 174 119 093 198 151 127 176 122 097 151 098 074 179 127 102
170 115 089 138 089 065 130 083 061 199 152 129 151 098 074 179 127 101 199 152
129 170 115 089 166 109 082 193 144 120 138 089 065 148 096 071 170 115 089 117
074 054 168 112 085 190 140 115 173 118 092 168 112 085 166 109 082 166 109 082
170 115 089 173 118 092 165 108 081 168 112 085 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 170 115 089 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 170 115 089 170 115 089 168 112 085 170 115
089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 166 110 083 168
112 085 170 115 089 170 115 089 168 112 085 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 169
113 087 168 112 085 170 115 089 170 115 089 173 118 092 177 124 098 168 112 085
169 113 087 170 115 089 162 107 079 166 109 082 169 113 087 169 113 087 168 112
085 166 110 083 162 107 079 157 102 076 166 110 083 170 115 089 169 113 087 165
108 081 170 115 089 170 115 089 165 108 081 155 101 076 151 098 074 155 101 076
161 106 079 151 098 074 144 093 069 134 086 064 148 096 071 144 093 069 136 087
064 157 102 076 173 118 092 168 112 085 168 112 085 169 113 087 144 093 069 151
098 074 148 096 071 138 089 065 138 089 065 134 086 064 148 096 071 162 107 079
161 106 079 168 112 085 170 115 089 155 101 076 104 066 047 111 070 051 170 115
089 200 154 131 202 157 134 193 146 122 185 135 110 193 144 120 198 151 127 190
140 115 200 155 132 190 140 115 192 143 118 207 161 140 202 158 135 200 154 131
200 155 132 200 154 131 173 118 092 121 077 057 170 115 089 179 127 101 144 093
069 168 112 085 162 107 079 185 135 110 204 160 137 190 140 115 183 132 106 187
137 112 188 139 114 183 131 106 183 132 106 192 143 119 185 135 110 181 129 104
187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 188 139 114 188
139 114 185 135 110 187 137 112 193 146 122 187 137 112 202 158 135 207 163 141
200 154 131 185 135 110 198 151 127 207 161 140 138 089 065 153 100 074 173 118
092 179 127 101 155 101 076 161 106 079 123 079 058 111 070 051 170 115 089 138
089 065 177 124 098 200 155 132 200 155 132 192 143 119 196 149 125 188 139 114
185 135 110 190 140 115 198 151 127 200 155 132 207 161 140 202 158 135 207 161
140 204 160 137 121 077 057 062 035 024 078 047 032 108 068 049 099 061 044 148
096 071 170 115 089 138 089 065 144 093 069 138 089 065 144 093 069 138 089 065
140 090 067 144 093 069 168 112 085 173 118 092 179 127 101 166 110 083 152 100
074 177 124 098 174 119 093 169 113 087 166 109 082 162 107 079 173 118 092 179
127 102 174 119 093 134 086 064 161 106 079 174 119 093 162 107 079 162 107 079
176 122 097 173 118 092 176 122 097 153 100 074 151 098 074 179 127 102 174 119
093 174 120 094 174 119 093 176 122 097 179 127 101 155 101 076 148 096 071 183
131 106 200 155 132 200 155 132 204 160 137 200 154 131 183 132 106 177 124 098
192 143 118 187 137 112 187 137 112 188 139 114 190 140 115 202 158 135 209 166
144 130 083 061 121 077 057 183 131 106 173 118 092 166 110 083 170 115 089 166
110 083 179 127 101 169 113 087 129 083 061 134 086 064 162 107 079 146 095 071
136 087 064 115 073 054 014 005 004 138 089 065 213 171 150 185 135 110 185 135
110 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 183 131 106
184 134 109 202 157 134 207 161 140 190 140 115 184 134 109 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 185 135 110 190 140 115 183 132 106 174 119 093
185 135 110 155 101 076 114 072 052 179 127 101 212 170 149 193 146 122 190 140
115 190 140 115 184 134 109 188 139 114 190 140 115 170 115 089 126 080 059 098
061 044 126 080 059 199 152 129 198 151 127 106 067 048 170 115 089 185 135 110
179 127 102 151 098 074 151 098 074 179 127 102 183 132 106 200 154 131 200 155
132 174 120 094 104 066 047 170 115 089 152 100 074 144 093 069 169 113 087 121
077 057 155 101 076 179 127 102 162 107 079 166 110 083 174 119 093 169 113 087
168 112 085 170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168 112 085
168 112 085 168 112 085 168 112 085 170 115 089 166 109 082 161 106 079 170 115
089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 169
113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 151 098 074
157 102 076 165 108 081 165 108 081 168 112 085 168 112 085 168 112 085 162 107
079 166 109 082 169 113 087 170 115 089 166 109 082 166 109 082 168 112 085 169
113 087 155 101 076 157 102 076 170 115 089 174 119 093 144 093 069 143 092 069
155 101 076 152 100 074 140 090 067 144 093 069 169 113 087 168 112 085 169 113
087 169 113 087 173 118 092 155 101 076 168 112 085 170 115 089 155 101 076 168
112 085 168 112 085 155 101 076 146 095 071 168 112 085 177 124 098 155 101 076
151 098 074 161 106 079 134 086 064 155 101 076 192 143 119 162 107 079 104 066
047 144 093 069 183 131 106 196 149 125 202 157 134 185 135 110 183 132 106 190
140 115 181 129 104 200 155 132 209 167 145 170 115 089 166 109 082 179 127 101
170 115 089 193 146 122 198 151 127 183 131 106 168 112 085 161 106 079 136 087
064 082 050 035 162 107 079 183 132 106 165 108 081 204 160 137 207 161 140 193
144 120 183 131 106 190 140 115 192 143 119 179 127 101 185 135 110 193 146 122
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 185 135 110 185 135 110 184 134 109 185 135 110 187 137 112 184 134 109 183
132 106 184 134 109 185 135 110 192 143 118 196 149 125 170 115 089 136 087 064
198 151 127 212 168 148 166 109 082 151 098 074 121 077 057 121 077 057 098 061
044 140 090 067 170 115 089 166 110 083 135 086 064 069 041 028 151 098 074 212
170 149 102 063 046 104 066 047 173 118 092 187 137 112 188 139 114 202 158 135
204 160 137 196 149 125 181 129 104 181 129 104 174 120 094 179 127 102 102 065
046 046 024 015 057 032 021 099 061 044 082 050 035 123 079 058 157 102 076 130
083 061 152 100 074 135 086 064 144 093 069 157 102 076 155 101 076 152 100 074
152 100 074 148 096 071 166 110 083 155 101 076 144 093 069 135 086 064 130 083
061 165 108 081 148 096 071 170 115 089 169 113 087 153 100 074 152 100 074 155
101 076 166 110 083 152 100 074 099 061 044 082 050 035 111 070 051 134 086 064
151 098 074 152 100 074 169 113 087 138 089 065 126 080 059 166 109 082 152 100
074 155 101 076 155 101 076 155 101 076 111 070 051 144 093 069 200 154 131 196
149 125 179 127 102 176 122 097 179 127 101 188 139 114 193 144 120 193 144 120
187 137 112 187 137 112 184 134 109 188 139 114 185 135 110 179 127 101 199 152
129 183 131 106 120 076 056 155 101 076 174 120 094 170 115 089 166 110 083 168
112 085 179 127 102 151 098 074 093 057 041 200 154 131 202 157 134 200 155 132
148 096 071 026 011 008 146 095 071 209 166 144 192 143 119 185 135 110 193 144
120 185 135 110 185 135 110 187 137 112 185 135 110 190 140 115 190 140 115 190
140 115 192 143 118 187 137 112 184 134 109 193 144 120 200 155 132 193 146 122
209 166 144 170 115 089 169 113 087 193 144 120 188 139 114 187 137 112 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 187 137 112 185 135 110 187 137 112 185 135 110 184 134 109 188 139
114 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 185 135 110 187
137 112 187 137 112 187 137 112 188 139 114 185 135 110 192 143 119 200 155 132
190 140 115 200 155 132 190 140 115 190 140 115 170 115 089 174 120 094 198 151
127 190 140 115 190 140 115 187 137 112 202 158 135 108 068 049 099 061 044 183
131 106 123 079 058 104 066 047 091 056 039 134 086 064 169 113 087 155 101 076
177 124 098 176 122 097 117 074 054 082 050 035 115 073 054 184 134 109 183 132
106 200 155 132 170 115 089 144 093 069 168 112 085 153 100 074 173 118 092 179
127 101 152 100 074 152 100 074 162 107 079 144 093 069 168 112 085 176 122 097
166 110 083 166 110 083 173 118 092 168 112 085 170 115 089 169 113 087 170 115
089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 173 118 092 152 100 074 155 101 076 174 119
093 166 110 083 170 115 089 169 113 087 169 113 087 169 113 087 170 115 089 170
115 089 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 173 118 092 170
115 089 170 115 089 169 113 087 170 115 089 162 107 079 153 100 074 166 109 082
169 113 087 155 101 076 162 107 079 166 109 082 157 102 076 166 109 082 170 115
089 168 112 085 170 115 089 170 115 089 166 110 083 168 112 085 166 110 083 168
112 085 162 107 079 170 115 089 168 112 085 168 112 085 165 108 081 162 107 079
165 108 081 155 101 076 138 089 065 162 107 079 166 110 083 155 101 076 166 110
083 151 098 074 166 110 083 170 115 089 166 109 082 166 109 082 169 113 087 165
108 081 165 108 081 170 115 089 173 118 092 170 115 089 170 115 089 168 112 085
162 107 079 173 118 092 166 110 083 138 089 065 155 101 076 153 100 074 153 100
074 134 086 064 129 083 061 144 093 069 155 101 076 138 089 065 136 087 064 153
100 074 126 080 059 144 093 069 143 092 069 085 051 036 125 079 058 135 086 064
078 047 032 193 146 122 207 163 141 190 140 115 200 154 131 193 146 122 173 118
092 144 093 069 099 061 044 138 089 065 144 093 069 179 127 102 174 120 094 188
139 114 207 163 141 196 149 125 174 120 094 204 160 137 207 161 140 192 143 118
185 135 110 185 135 110 185 135 110 190 140 115 185 135 110 080 048 033 080 048
033 193 144 120 192 143 119 193 146 122 193 144 120 193 146 122 185 135 110 181
129 104 192 143 119 192 143 119 183 132 106 193 144 120 174 119 093 162 107 079
155 101 076 072 043 030 138 089 065 111 070 051 155 101 076 193 144 120 138 089
065 151 098 074 183 132 106 176 122 097 161 106 079 170 115 089 089 054 039 082
050 035 166 110 083 148 096 071 087 053 037 090 054 039 129 083 061 098 061 044
104 066 047 099 061 044 111 070 051 126 080 059 082 050 035 069 041 028 078 047
032 104 066 047 144 093 069 151 098 074 126 080 059 144 093 069 138 089 065 143
092 069 144 093 069 130 083 061 161 106 079 161 106 079 126 080 059 144 093 069
129 083 061 089 054 039 126 080 059 174 120 094 168 112 085 166 110 083 168 112
085 166 110 083 152 100 074 126 080 059 155 101 076 170 115 089 162 107 079 170
115 089 168 112 085 177 124 098 169 113 087 165 108 081 174 120 094 169 113 087
157 102 076 157 102 076 162 107 079 157 102 076 162 107 079 162 107 079 162 107
079 161 106 079 161 106 079 162 107 079 144 093 069 151 098 074 202 157 134 204
160 137 179 127 102 174 120 094 200 154 131 193 146 122 179 127 101 188 139 114
185 135 110 185 135 110 202 158 135 199 152 129 179 127 102 179 127 102 200 155
132 200 154 131 138 089 065 173 118 092 174 120 094 177 124 098 173 118 092 174
120 094 144 093 069 104 066 047 144 093 069 190 140 115 174 120 094 209 166 144
196 149 125 166 110 083 212 170 149 193 146 122 179 127 102 192 143 118 187 137
112 188 139 114 184 134 109 185 135 110 193 144 120 184 134 109 184 134 109 183
132 106 179 127 101 185 135 110 204 160 137 190 140 115 155 101 076 168 112 085
106 067 048 077 047 032 062 035 024 179 127 101 204 160 137 185 135 110 190 140
115 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 187 137 112 188 139 114
184 134 109 190 140 115 188 139 114 187 137 112 192 143 118 196 149 125 184 134
109 188 139 114 190 140 115 190 140 115 185 135 110 187 137 112 188 139 114 190
140 115 185 135 110 187 137 112 188 139 114 184 134 109 193 146 122 200 155 132
193 144 120 183 131 106 198 151 127 193 146 122 161 106 079 176 122 097 190 140
115 188 139 114 179 127 102 193 146 122 202 158 135 078 047 032 078 047 032 161
106 079 155 101 076 126 080 059 151 098 074 169 113 087 106 067 048 165 108 081
170 115 089 173 118 092 126 080 059 134 086 064 193 146 122 170 115 089 190 140
115 162 107 079 125 079 058 162 107 079 152 100 074 134 086 064 170 115 089 176
122 097 099 061 044 146 095 071 168 112 085 183 131 106 134 086 064 155 101 076
187 137 112 170 115 089 152 100 074 174 119 093 162 107 079 166 109 082 165 108
081 166 110 083 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 170 115 089 174 119 093 153 100 074 138 089 065 173 118
092 173 118 092 168 112 085 169 113 087 170 115 089 168 112 085 169 113 087 170
115 089 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 169
113 087 169 113 087 168 112 085 168 112 085 166 110 083 165 108 081 166 109 082
169 113 087 166 109 082 155 101 076 157 102 076 168 112 085 169 113 087 170 115
089 168 112 085 169 113 087 169 113 087 169 113 087 170 115 089 168 112 085 174
119 093 170 115 089 169 113 087 168 112 085 166 110 083 168 112 085 168 112 085
168 112 085 168 112 085 162 107 079 170 115 089 170 115 089 162 107 079 166 109
082 168 112 085 165 108 081 162 107 079 168 112 085 166 110 083 166 110 083 169
113 087 170 115 089 170 115 089 168 112 085 165 108 081 165 108 081 170 115 089
170 115 089 170 115 089 165 108 081 144 093 069 123 079 058 136 087 064 173 118
092 152 100 074 123 079 058 146 095 071 111 070 051 136 087 064 153 100 074 135
086 064 153 100 074 140 090 067 120 076 056 165 108 081 144 093 069 148 096 071
129 083 061 115 073 054 174 120 094 209 166 144 204 160 137 198 151 127 155 101
076 188 139 114 177 124 098 153 100 074 157 102 076 120 076 056 111 070 051 136
087 064 148 096 071 148 096 071 129 083 061 138 089 065 179 127 101 202 157 134
200 154 131 200 155 132 192 143 118 179 127 101 193 146 122 080 048 033 080 048
033 185 135 110 184 134 109 190 140 115 188 139 114 185 135 110 187 137 112 176
122 097 190 140 115 196 149 125 202 158 135 184 134 109 202 157 134 199 152 129
087 053 037 153 100 074 187 137 112 183 132 106 169 113 087 173 118 092 174 120
094 153 100 074 144 093 069 174 120 094 179 127 101 143 092 069 117 074 054 099
061 044 144 093 069 151 098 074 114 072 052 104 066 047 120 076 056 115 073 054
136 087 064 134 086 064 121 077 057 102 063 046 117 074 054 143 092 069 176 122
097 151 098 074 153 100 074 170 115 089 173 118 092 148 096 071 130 083 061 165
108 081 168 112 085 166 110 083 144 093 069 104 066 047 102 063 046 134 086 064
146 095 071 125 079 058 151 098 074 176 122 097 170 115 089 169 113 087 179 127
101 151 098 074 130 083 061 152 100 074 151 098 074 155 101 076 183 132 106 146
095 071 155 101 076 185 135 110 183 132 106 179 127 101 170 115 089 170 115 089
176 122 097 176 122 097 174 119 093 177 124 098 177 124 098 174 120 094 173 118
092 174 119 093 174 119 093 170 115 089 184 134 109 168 112 085 134 086 064 179
127 102 207 163 141 193 144 120 200 154 131 192 143 119 185 135 110 179 127 102
183 132 106 198 151 127 179 127 101 190 140 115 204 160 137 170 115 089 153 100
074 174 119 093 130 083 061 155 101 076 138 089 065 162 107 079 169 113 087 111
070 051 157 102 076 202 158 135 200 155 132 198 151 127 200 155 132 170 115 089
184 134 109 200 155 132 179 127 102 176 122 097 192 143 119 185 135 110 185 135
110 187 137 112 188 139 114 188 139 114 185 135 110 183 132 106 192 143 119 179
127 102 188 139 114 212 170 149 162 107 079 096 059 042 151 098 074 111 070 051
089 054 039 169 113 087 121 077 057 111 070 051 207 163 141 199 152 129 183 131
106 184 134 109 183 132 106 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110
190 140 115 185 135 110 190 140 115 198 151 127 185 135 110 185 135 110 192 143
118 190 140 115 183 132 106 196 149 125 185 135 110 184 134 109 185 135 110 188
139 114 188 139 114 187 137 112 185 135 110 198 151 127 170 115 089 123 079 058
192 143 118 192 143 118 192 143 118 184 134 109 200 154 131 193 146 122 185 135
110 190 140 115 179 127 102 199 152 129 192 143 119 045 024 015 043 023 014 098
061 044 138 089 065 153 100 074 135 086 064 138 089 065 135 086 064 165 108 081
161 106 079 173 118 092 144 093 069 166 110 083 200 155 132 193 144 120 200 154
131 138 089 065 181 129 104 179 127 101 168 112 085 179 127 101 155 101 076 162
107 079 168 112 085 161 106 079 129 083 061 179 127 101 174 120 094 168 112 085
138 089 065 120 076 056 151 098 074 166 109 082 179 127 101 184 134 109 168 112
085 166 109 082 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 166 110 083 174 119 093 174 120 094 138 089 065 165 108
081 174 120 094 169 113 087 168 112 085 170 115 089 169 113 087 170 115 089 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115 089
170 115 089 170 115 089 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 166 110 083 146 095 071
151 098 074 166 109 082 155 101 076 161 106 079 174 120 094 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 166 109 082 169 113 087 168
112 085 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 169 113 087 170 115 089 170 115 089 168 112
085 168 112 085 170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 165
108 081 162 107 079 168 112 085 169 113 087 169 113 087 168 112 085 162 107 079
169 113 087 168 112 085 151 098 074 151 098 074 144 093 069 136 087 064 130 083
061 134 086 064 115 073 054 126 080 059 138 089 065 138 089 065 155 101 076 152
100 074 146 095 071 136 087 064 148 096 071 161 106 079 162 107 079 161 106 079
168 112 085 115 073 054 099 061 044 148 096 071 170 115 089 151 098 074 090 054
039 144 093 069 170 115 089 155 101 076 166 109 082 161 106 079 170 115 089 169
113 087 121 077 057 120 076 056 144 093 069 104 066 047 099 061 044 151 098 074
166 110 083 177 124 098 193 146 122 198 151 127 188 139 114 080 048 033 080 048
033 183 131 106 185 135 110 183 131 106 188 139 114 190 140 115 192 143 118 198
151 127 179 127 101 169 113 087 170 115 089 179 127 101 193 144 120 193 144 120
176 122 097 125 079 058 143 092 069 155 101 076 151 098 074 155 101 076 173 118
092 177 124 098 162 107 079 151 098 074 165 108 081 170 115 089 168 112 085 153
100 074 121 077 057 102 063 046 126 080 059 140 090 067 168 112 085 179 127 101
168 112 085 161 106 079 129 083 061 144 093 069 166 110 083 152 100 074 162 107
079 162 107 079 166 110 083 166 109 082 151 098 074 146 095 071 162 107 079 135
086 064 151 098 074 170 115 089 115 073 054 120 076 056 144 093 069 126 080 059
155 101 076 169 113 087 144 093 069 151 098 074 155 101 076 173 118 092 166 109
082 168 112 085 181 129 104 173 118 092 135 086 064 115 073 054 148 096 071 161
106 079 138 089 065 090 054 039 104 066 047 170 115 089 173 118 092 169 113 087
170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 169 113
087 168 112 085 166 110 083 168 112 085 168 112 085 166 110 083 157 102 076 140
090 067 143 092 069 183 131 106 202 158 135 179 127 101 190 140 115 209 167 145
190 140 115 198 151 127 144 093 069 129 083 061 209 166 144 192 143 119 161 106
079 179 127 101 165 108 081 168 112 085 174 119 093 123 079 058 151 098 074 193
144 120 185 135 110 148 096 071 161 106 079 155 101 076 106 067 048 104 066 047
155 101 076 157 102 076 207 161 140 187 137 112 183 132 106 190 140 115 187 137
112 187 137 112 187 137 112 187 137 112 183 131 106 192 143 119 193 144 120 190
140 115 200 155 132 170 115 089 089 054 039 155 101 076 170 115 089 170 115 089
181 129 104 183 131 106 155 101 076 059 034 023 166 109 082 209 167 145 183 132
106 183 132 106 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
190 140 115 185 135 110 183 131 106 193 146 122 200 154 131 198 151 127 192 143
119 193 144 120 204 160 137 207 161 140 199 152 129 193 144 120 190 140 115 190
140 115 185 135 110 187 137 112 185 135 110 198 151 127 170 115 089 136 087 064
192 143 118 183 131 106 187 137 112 190 140 115 185 135 110 187 137 112 187 137
112 187 137 112 188 139 114 193 144 120 200 154 131 174 119 093 126 080 059 117
074 054 111 070 051 130 083 061 174 120 094 169 113 087 153 100 074 169 113 087
173 118 092 166 109 082 170 115 089 115 073 054 162 107 079 200 155 132 199 152
129 111 070 051 151 098 074 181 129 104 181 129 104 168 112 085 170 115 089 174
119 093 174 119 093 168 112 085 146 095 071 114 072 052 170 115 089 183 131 106
104 066 047 108 068 049 190 140 115 174 120 094 176 122 097 170 115 089 176 122
097 170 115 089 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 170 115 089 174 119 093 162 107 079 157 102 076 173 118
092 170 115 089 168 112 085 169 113 087 176 122 097 168 112 085 166 109 082 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113
087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 170
115 089 166 110 083 169 113 087 169 113 087 170 115 089 168 112 085 161 106 079
166 109 082 168 112 085 173 118 092 170 115 089 174 119 093 168 112 085 165 108
081 162 107 079 165 108 081 166 110 083 170 115 089 169 113 087 170 115 089 168
112 085 166 110 083 166 110 083 166 110 083 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 170 115 089 169 113 087 169 113 087 169 113 087 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 166 110 083 170
115 089 177 124 098 174 120 094 177 124 098 177 124 098 179 127 102 181 129 104
179 127 101 177 124 098 181 129 104 152 100 074 135 086 064 126 080 059 136 087
064 144 093 069 168 112 085 170 115 089 174 120 094 146 095 071 153 100 074 168
112 085 134 086 064 136 087 064 169 113 087 135 086 064 165 108 081 165 108 081
166 110 083 162 107 079 166 109 082 136 087 064 089 054 039 121 077 057 173 118
092 148 096 071 146 095 071 162 107 079 125 079 058 152 100 074 168 112 085 174
120 094 179 127 101 174 120 094 151 098 074 166 110 083 169 113 087 140 090 067
115 073 054 138 089 065 111 070 051 161 106 079 148 096 071 080 048 033 080 048
033 192 143 118 185 135 110 193 144 120 207 163 141 192 143 119 193 146 122 209
167 145 168 112 085 134 086 064 140 090 067 162 107 079 198 151 127 198 151 127
196 149 125 187 137 112 196 149 125 173 118 092 157 102 076 143 092 069 153 100
074 174 120 094 173 118 092 155 101 076 157 102 076 166 109 082 174 119 093 187
137 112 173 118 092 143 092 069 140 090 067 166 110 083 146 095 071 140 090 067
151 098 074 136 087 064 144 093 069 176 122 097 168 112 085 130 083 061 148 096
071 144 093 069 146 095 071 140 090 067 134 086 064 143 092 069 155 101 076 155
101 076 136 087 064 089 054 039 121 077 057 165 108 081 121 077 057 130 083 061
170 115 089 165 108 081 153 100 074 174 119 093 174 119 093 183 131 106 174 119
093 165 108 081 174 119 093 148 096 071 162 107 079 174 120 094 166 109 082 177
124 098 168 112 085 155 101 076 148 096 071 170 115 089 168 112 085 168 112 085
169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 170 115 089 170 115
089 169 113 087 170 115 089 168 112 085 151 098 074 173 118 092 173 118 092 130
083 061 093 057 041 114 072 052 183 131 106 202 157 134 183 131 106 155 101 076
140 090 067 140 090 067 181 129 104 162 107 079 121 077 057 168 112 085 212 168
148 174 120 094 152 100 074 193 144 120 200 155 132 192 143 119 193 146 122 170
115 089 138 089 065 146 095 071 155 101 076 115 073 054 115 073 054 179 127 102
091 056 039 090 054 039 212 170 149 190 140 115 179 127 101 192 143 118 187 137
112 187 137 112 190 140 115 181 129 104 190 140 115 193 146 122 187 137 112 209
166 144 162 107 079 093 057 041 174 119 093 179 127 102 170 115 089 170 115 089
170 115 089 166 110 083 166 109 082 102 063 046 040 020 012 162 107 079 207 163
141 192 143 118 185 135 110 183 131 106 185 135 110 185 135 110 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 185 135 110 188 139 114 188 139 114
183 131 106 193 146 122 200 154 131 174 119 093 162 107 079 168 112 085 155 101
076 136 087 064 138 089 065 144 093 069 173 118 092 200 154 131 200 155 132 192
143 118 184 134 109 187 137 112 187 137 112 183 131 106 198 151 127 209 166 144
193 144 120 192 143 118 193 144 120 187 137 112 185 135 110 187 137 112 187 137
112 190 140 115 181 129 104 192 143 119 198 151 127 209 166 144 207 163 141 184
134 109 161 106 079 121 077 057 102 065 046 138 089 065 144 093 069 138 089 065
166 110 083 170 115 089 168 112 085 166 109 082 123 079 058 155 101 076 157 102
076 190 140 115 173 118 092 129 083 061 144 093 069 168 112 085 169 113 087 174
119 093 165 108 081 183 131 106 153 100 074 157 102 076 170 115 089 152 100 074
183 131 106 181 129 104 140 090 067 152 100 074 138 089 065 148 096 071 173 118
092 174 120 094 168 112 085 168 112 085 169 113 087 169 113 087 169 113 087 169
113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087
169 113 087 169 113 087 170 115 089 168 112 085 157 102 076 143 092 069 170 115
089 179 127 101 170 115 089 166 110 083 166 110 083 170 115 089 168 112 085 168
112 085 168 112 085 168 112 085 168 112 085 168 112 085 169 113 087 169 113 087
169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 169 113 087 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089 169
113 087 168 112 085 168 112 085 166 110 083 162 107 079 169 113 087 168 112 085
170 115 089 165 108 081 148 096 071 146 095 071 155 101 076 162 107 079 166 110
083 162 107 079 162 107 079 162 107 079 162 107 079 162 107 079 166 109 082 166
110 083 168 112 085 168 112 085 166 110 083 169 113 087 168 112 085 168 112 085
168 112 085 168 112 085 170 115 089 169 113 087 169 113 087 169 113 087 170 115
089 170 115 089 170 115 089 170 115 089 168 112 085 170 115 089 170 115 089 166
109 082 166 110 083 161 106 079 168 112 085 162 107 079 144 093 069 138 089 065
143 092 069 144 093 069 144 093 069 140 090 067 146 095 071 153 100 074 166 109
082 168 112 085 173 118 092 166 110 083 144 093 069 170 115 089 162 107 079 130
083 061 157 102 076 166 109 082 144 093 069 155 101 076 165 108 081 162 107 079
168 112 085 151 098 074 165 108 081 173 118 092 161 106 079 126 080 059 140 090
067 173 118 092 162 107 079 111 070 051 151 098 074 155 101 076 144 093 069 155
101 076 173 118 092 174 120 094 166 109 082 174 119 093 166 109 082 152 100 074
170 115 089 173 118 092 144 093 069 140 090 067 130 083 061 080 048 033 080 048
033 204 160 137 193 144 120 202 158 135 168 112 085 148 096 071 102 065 046 091
056 039 207 163 141 204 160 137 207 161 140 192 143 119 204 160 137 169 113 087
144 093 069 174 120 094 170 115 089 168 112 085 162 107 079 153 100 074 166 110
083 134 086 064 166 110 083 169 113 087 155 101 076 165 108 081 161 106 079 153
100 074 155 101 076 183 131 106 183 131 106 151 098 074 168 112 085 165 108 081
152 100 074 140 090 067 140 090 067 146 095 071 144 093 069 134 086 064 144 093
069 143 092 069 136 087 064 134 086 064 143 092 069 123 079 058 126 080 059 111
070 051 106 067 048 130 083 061 129 083 061 123 079 058 138 089 065 162 107 079
155 101 076 179 127 101 168 112 085 170 115 089 166 110 083 115 073 054 162 107
079 176 122 097 177 124 098 169 113 087 176 122 097 176 122 097 170 115 089 168
112 085 169 113 087 179 127 102 174 120 094 168 112 085 168 112 085 169 113 087
170 115 089 169 113 087 168 112 085 170 115 089 168 112 085 169 113 087 169 113
087 166 109 082 168 112 085 166 109 082 165 108 081 174 120 094 148 096 071 152
100 074 170 115 089 170 115 089 161 106 079 134 086 064 152 100 074 157 102 076
169 113 087 183 131 106 130 083 061 123 079 058 152 100 074 181 129 104 198 151
127 184 134 109 111 070 051 134 086 064 121 077 057 140 090 067 161 106 079 151
098 074 111 070 051 146 095 071 179 127 101 174 120 094 193 144 120 140 090 067
155 101 076 199 152 129 188 139 114 202 158 135 192 143 118 185 135 110 188 139
114 187 137 112 187 137 112 184 134 109 185 135 110 183 131 106 212 170 149 196
149 125 108 068 049 091 056 039 168 112 085 177 124 098 170 115 089 176 122 097
173 118 092 173 118 092 174 120 094 196 149 125 077 047 032 078 047 032 202 157
134 207 161 140 209 166 144 200 155 132 193 146 122 188 139 114 183 132 106 187
137 112 188 139 114 188 139 114 188 139 114 187 137 112 185 135 110 190 140 115
192 143 118 192 143 119 190 140 115 108 068 049 080 048 033 157 102 076 162 107
079 166 109 082 148 096 071 123 079 058 111 070 051 114 072 052 169 113 087 200
155 132 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 185 135 110
184 134 109 192 143 119 190 140 115 185 135 110 188 139 114 187 137 112 187 137
112 190 140 115 183 131 106 183 131 106 190 140 115 184 134 109 183 132 106 200
155 132 202 157 134 202 157 134 166 110 083 102 065 046 123 079 058 143 092 069
115 073 054 170 115 089 170 115 089 179 127 101 168 112 085 165 108 081 106 067
048 170 115 089 200 155 132 196 149 125 170 115 089 146 095 071 170 115 089 162
107 079 174 120 094 157 102 076 126 080 059 179 127 101 173 118 092 174 120 094
148 096 071 170 115 089 162 107 079 096 059 042 161 106 079 183 131 106 143 092
069 155 101 076 174 119 093 176 122 097 173 118 092 162 107 079 168 112 085 170
115 089 168 112 085 170 115 089 169 113 087 168 112 085 169 113 087 169 113 087
169 113 087 170 115 089 168 112 085 173 118 092 181 129 104 126 080 059 120 076
056 148 096 071 174 119 093 177 124 098 168 112 085 168 112 085 166 110 083 170
115 089 170 115 089 168 112 085 170 115 089 170 115 089 170 115 089 170 115 089
168 112 085 169 113 087 173 118 092 169 113 087 170 115 089 170 115 089 170 115
089 169 113 087 169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 170
115 089 173 118 092 165 108 081 148 096 071 151 098 074 166 110 083 161 106 079
162 107 079 157 102 076 152 100 074 146 095 071 152 100 074 151 098 074 166 109
082 170 115 089 168 112 085 165 108 081 161 106 079 153 100 074 157 102 076 165
108 081 165 108 081 168 112 085 170 115 089 168 112 085 168 112 085 168 112 085
168 112 085 168 112 085 165 108 081 170 115 089 173 118 092 168 112 085 162 107
079 170 115 089 169 113 087 169 113 087 168 112 085 173 118 092 166 110 083 155
101 076 144 093 069 115 073 054 134 086 064 134 086 064 135 086 064 140 090 067
144 093 069 155 101 076 151 098 074 165 108 081 170 115 089 173 118 092 157 102
076 138 089 065 129 083 061 115 073 054 144 093 069 146 095 071 144 093 069 155
101 076 129 083 061 138 089 065 168 112 085 179 127 102 166 109 082 151 098 074
161 106 079 169 113 087 170 115 089 168 112 085 155 101 076 157 102 076 157 102
076 165 108 081 161 106 079 157 102 076 153 100 074 151 098 074 146 095 071 148
096 071 151 098 074 140 090 067 162 107 079 179 127 102 166 109 082 155 101 076
174 120 094 155 101 076 192 143 118 155 101 076 120 076 056 080 048 033 080 048
033 165 108 081 162 107 079 136 087 064 134 086 064 169 113 087 174 120 094 135
086 064 099 061 044 126 080 059 193 144 120 198 151 127 114 072 052 089 054 039
121 077 057 130 083 061 151 098 074 169 113 087 152 100 074 162 107 079 173 118
092 155 101 076 168 112 085 179 127 101 170 115 089 153 100 074 157 102 076 170
115 089 144 093 069 130 083 061 166 109 082 174 120 094 151 098 074 146 095 071
151 098 074 157 102 076 168 112 085 165 108 081 152 100 074 152 100 074 155 101
076 157 102 076 155 101 076 162 107 079 174 120 094 177 124 098 153 100 074 102
065 046 162 107 079 183 131 106 168 112 085 173 118 092 170 115 089 162 107 079
162 107 079 152 100 074 162 107 079 096 059 042 117 074 054 155 101 076 161 106
079 130 083 061 144 093 069 174 120 094 169 113 087 165 108 081 152 100 074 166
110 083 177 124 098 165 108 081 168 112 085 179 127 102 183 131 106 170 115 089
165 108 081 168 112 085 170 115 089 168 112 085 174 120 094 166 110 083 170 115
089 170 115 089 166 110 083 168 112 085 179 127 102 169 113 087 168 112 085 174
120 094 170 115 089 165 108 081 117 074 054 114 072 052 138 089 065 143 092 069
162 107 079 138 089 065 121 077 057 204 160 137 204 160 137 187 137 112 192 143
118 193 144 120 157 102 076 174 119 093 185 135 110 106 067 048 134 086 064 198
151 127 138 089 065 165 108 081 183 131 106 174 120 094 093 057 041 179 127 101
198 151 127 138 089 065 074 043 030 148 096 071 202 158 135 193 144 120 185 135
110 187 137 112 192 143 118 188 139 114 183 132 106 198 151 127 184 134 109 098
061 044 121 077 057 179 127 101 176 122 097 179 127 101 155 101 076 168 112 085
170 115 089 170 115 089 162 107 079 162 107 079 174 119 093 130 083 061 126 080
059 135 086 064 151 098 074 169 113 087 193 144 120 209 167 145 204 160 137 179
127 102 183 132 106 184 134 109 183 132 106 188 139 114 190 140 115 187 137 112
199 152 129 170 115 089 078 047 032 070 042 028 099 061 044 143 092 069 130 083
061 111 070 051 121 077 057 179 127 101 166 109 082 090 054 039 165 108 081 196
149 125 188 139 114 187 137 112 187 137 112 190 140 115 183 132 106 181 129 104
185 135 110 187 137 112 184 134 109 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 183 132 106 187 137 112 185 135 110 179 127 101 183
131 106 185 135 110 200 155 132 209 166 144 198 151 127 098 061 044 125 079 058
135 086 064 138 089 065 169 113 087 165 108 081 168 112 085 183 131 106 185 135
110 104 066 047 151 098 074 190 140 115 161 106 079 153 100 074 173 118 092 162
107 079 179 127 101 144 093 069 151 098 074 174 119 093 179 127 101 170 115 089
146 095 071 200 155 132 199 152 129 177 124 098 198 151 127 183 132 106 136 087
064 168 112 085 165 108 081 126 080 059 152 100 074 188 139 114 174 119 093 174
119 093 174 120 094 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085
166 110 083 166 109 082 170 115 089 166 109 082 162 107 079 169 113 087 162 107
079 143 092 069 143 092 069 157 102 076 162 107 079 177 124 098 179 127 101 165
108 081 162 107 079 174 119 093 177 124 098 176 122 097 170 115 089 170 115 089
174 120 094 174 119 093 162 107 079 173 118 092 170 115 089 169 113 087 170 115
089 170 115 089 168 112 085 170 115 089 170 115 089 170 115 089 168 112 085 169
113 087 166 109 082 168 112 085 162 107 079 169 113 087 166 110 083 166 110 083
162 107 079 157 102 076 162 107 079 153 100 074 161 106 079 166 110 083 162 107
079 161 106 079 162 107 079 166 109 082 166 109 082 166 110 083 168 112 085 166
109 082 166 109 082 166 109 082 162 107 079 157 102 076 168 112 085 168 112 085
162 107 079 166 109 082 169 113 087 168 112 085 170 115 089 168 112 085 169 113
087 168 112 085 168 112 085 169 113 087 170 115 089 169 113 087 144 093 069 146
095 071 151 098 074 146 095 071 162 107 079 166 110 083 169 113 087 173 118 092
174 120 094 162 107 079 162 107 079 157 102 076 151 098 074 146 095 071 121 077
057 114 072 052 114 072 052 151 098 074 168 112 085 123 079 058 138 089 065 157
102 076 146 095 071 155 101 076 179 127 101 170 115 089 157 102 076 165 108 081
146 095 071 152 100 074 169 113 087 152 100 074 166 110 083 176 122 097 146 095
071 136 087 064 148 096 071 157 102 076 157 102 076 157 102 076 155 101 076 165
108 081 155 101 076 151 098 074 166 109 082 153 100 074 165 108 081 177 124 098
157 102 076 152 100 074 170 115 089 174 120 094 185 135 110 080 048 033 080 048
033 126 080 059 151 098 074 161 106 079 170 115 089 144 093 069 096 059 042 140
090 067 126 080 059 138 089 065 187 137 112 199 152 129 185 135 110 202 157 134
183 131 106 165 108 081 168 112 085 155 101 076 090 054 039 111 070 051 125 079
058 185 135 110 161 106 079 130 083 061 157 102 076 168 112 085 155 101 076 169
113 087 176 122 097 161 106 079 136 087 064 162 107 079 174 120 094 177 124 098
170 115 089 173 118 092 181 129 104 174 120 094 153 100 074 155 101 076 170 115
089 155 101 076 183 132 106 174 120 094 136 087 064 143 092 069 123 079 058 173
118 092 170 115 089 161 106 079 170 115 089 174 120 094 157 102 076 170 115 089
169 113 087 126 080 059 136 087 064 104 066 047 153 100 074 174 119 093 123 079
058 151 098 074 134 086 064 179 127 101 173 118 092 177 124 098 170 115 089 155
101 076 165 108 081 174 119 093 183 131 106 162 107 079 138 089 065 169 113 087
168 112 085 183 131 106 174 120 094 166 110 083 174 120 094 166 109 082 153 100
074 179 127 102 192 143 119 179 127 101 161 106 079 168 112 085 165 108 081 166
110 083 170 115 089 174 120 094 151 098 074 174 120 094 183 132 106 123 079 058
144 093 069 134 086 064 093 057 041 176 122 097 192 143 118 200 155 132 183 131
106 183 131 106 200 155 132 193 146 122 193 146 122 204 160 137 176 122 097 146
095 071 181 129 104 176 122 097 155 101 076 161 106 079 106 067 048 157 102 076
111 070 051 082 050 035 104 066 047 033 016 010 121 077 057 202 157 134 188 139
114 185 135 110 190 140 115 179 127 102 200 154 131 209 166 144 099 061 044 102
065 046 177 124 098 165 108 081 177 124 098 181 129 104 170 115 089 169 113 087
170 115 089 170 115 089 168 112 085 153 100 074 153 100 074 174 120 094 134 086
064 082 050 035 065 038 025 080 048 033 077 047 032 106 067 048 187 137 112 209
167 145 200 154 131 202 158 135 198 151 127 192 143 118 193 144 120 183 132 106
187 137 112 196 149 125 155 101 076 146 095 071 198 151 127 190 140 115 190 140
115 169 113 087 170 115 089 162 107 079 143 092 069 177 124 098 200 155 132 184
134 109 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115
188 139 114 187 137 112 190 140 115 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 187 137 112 190 140 115 190 140 115 190
140 115 187 137 112 183 131 106 179 127 102 202 158 135 193 144 120 099 061 044
125 079 058 136 087 064 140 090 067 155 101 076 165 108 081 169 113 087 162 107
079 155 101 076 168 112 085 120 076 056 126 080 059 176 122 097 161 106 079 155
101 076 170 115 089 152 100 074 166 110 083 183 131 106 144 093 069 111 070 051
155 101 076 148 096 071 170 115 089 174 120 094 170 115 089 151 098 074 130 083
061 166 110 083 174 120 094 165 108 081 157 102 076 179 127 102 165 108 081 135
086 064 151 098 074 166 109 082 174 120 094 179 127 102 173 118 092 173 118 092
174 119 093 170 115 089 168 112 085 169 113 087 174 119 093 170 115 089 181 129
104 181 129 104 176 122 097 148 096 071 144 093 069 155 101 076 162 107 079 166
110 083 174 120 094 174 120 094 090 054 039 102 063 046 162 107 079 148 096 071
170 115 089 170 115 089 161 106 079 183 132 106 177 124 098 170 115 089 168 112
085 166 109 082 174 119 093 169 113 087 165 108 081 170 115 089 166 110 083 173
118 092 166 110 083 155 101 076 162 107 079 170 115 089 161 106 079 155 101 076
155 101 076 155 101 076 155 101 076 166 110 083 161 106 079 151 098 074 161 106
079 168 112 085 168 112 085 169 113 087 169 113 087 168 112 085 162 107 079 162
107 079 162 107 079 161 106 079 162 107 079 169 113 087 166 110 083 162 107 079
166 109 082 170 115 089 168 112 085 168 112 085 166 110 083 168 112 085 168 112
085 169 113 087 166 110 083 169 113 087 170 115 089 170 115 089 151 098 074 126
080 059 140 090 067 168 112 085 169 113 087 161 106 079 155 101 076 165 108 081
166 110 083 144 093 069 155 101 076 168 112 085 146 095 071 126 080 059 148 096
071 170 115 089 168 112 085 144 093 069 140 090 067 153 100 074 161 106 079 169
113 087 174 120 094 169 113 087 168 112 085 170 115 089 169 113 087 170 115 089
162 107 079 161 106 079 166 110 083 151 098 074 166 109 082 165 108 081 157 102
076 162 107 079 168 112 085 166 110 083 161 106 079 166 110 083 166 110 083 155
101 076 138 089 065 162 107 079 155 101 076 136 087 064 138 089 065 166 110 083
166 109 082 140 090 067 151 098 074 144 093 069 162 107 079 080 048 033 080 048
033 174 120 094 155 101 076 134 086 064 104 066 047 169 113 087 179 127 101 173
118 092 192 143 119 207 163 141 193 144 120 183 132 106 193 146 122 200 154 131
187 137 112 179 127 101 162 107 079 120 076 056 129 083 061 155 101 076 144 093
069 152 100 074 153 100 074 140 090 067 111 070 051 104 066 047 117 074 054 121
077 057 125 079 058 121 077 057 115 073 054 102 065 046 117 074 054 138 089 065
170 115 089 169 113 087 162 107 079 174 120 094 152 100 074 151 098 074 177 124
098 173 118 092 165 108 081 098 061 044 151 098 074 183 131 106 179 127 102 183
132 106 168 112 085 162 107 079 174 120 094 181 129 104 165 108 081 174 120 094
174 120 094 179 127 101 176 122 097 179 127 102 179 127 101 166 110 083 152 100
074 187 137 112 162 107 079 169 113 087 161 106 079 153 100 074 174 119 093 174
120 094 166 109 082 151 098 074 170 115 089 114 072 052 102 063 046 183 131 106
183 132 106 169 113 087 151 098 074 165 108 081 169 113 087 162 107 079 183 131
106 144 093 069 114 072 052 130 083 061 117 074 054 183 131 106 185 135 110 153
100 074 170 115 089 179 127 102 181 129 104 138 089 065 151 098 074 129 083 061
170 115 089 183 131 106 169 113 087 144 093 069 114 072 052 183 132 106 200 155
132 198 151 127 162 107 079 130 083 061 162 107 079 173 118 092 183 131 106 155
101 076 168 112 085 161 106 079 174 119 093 183 131 106 185 135 110 111 070 051
099 061 044 123 079 058 170 115 089 200 155 132 193 144 120 187 137 112 184 134
109 190 140 115 190 140 115 183 131 106 188 139 114 204 160 137 129 083 061 102
063 046 151 098 074 161 106 079 157 102 076 176 122 097 179 127 102 168 112 085
169 113 087 169 113 087 170 115 089 170 115 089 169 113 087 161 106 079 162 107
079 170 115 089 176 122 097 183 131 106 153 100 074 089 054 039 089 054 039 157
102 076 183 131 106 183 132 106 198 151 127 202 157 134 204 160 137 207 163 141
200 155 132 192 143 118 209 166 144 207 163 141 200 154 131 199 152 129 202 157
134 199 152 129 200 155 132 193 144 120 202 158 135 204 160 137 185 135 110 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 183 131 106 199 152 129 204 160 137
162 107 079 082 050 035 093 057 041 129 083 061 123 079 058 169 113 087 184 134
109 183 131 106 170 115 089 121 077 057 170 115 089 177 124 098 162 107 079 162
107 079 166 110 083 136 087 064 152 100 074 157 102 076 135 086 064 151 098 074
155 101 076 174 120 094 162 107 079 162 107 079 161 106 079 136 087 064 140 090
067 184 134 109 202 157 134 198 151 127 126 080 059 098 061 044 148 096 071 192
143 118 170 115 089 166 109 082 166 109 082 155 101 076 155 101 076 170 115 089
162 107 079 161 106 079 155 101 076 161 106 079 176 122 097 148 096 071 166 109
082 174 120 094 170 115 089 176 122 097 177 124 098 143 092 069 111 070 051 157
102 076 170 115 089 168 112 085 165 108 081 143 092 069 144 093 069 185 135 110
170 115 089 155 101 076 193 144 120 115 073 054 102 065 046 174 119 093 168 112
085 168 112 085 173 118 092 168 112 085 174 119 093 168 112 085 162 107 079 174
119 093 170 115 089 168 112 085 155 101 076 146 095 071 143 092 069 138 089 065
146 095 071 155 101 076 162 107 079 170 115 089 157 102 076 134 086 064 155 101
076 170 115 089 170 115 089 170 115 089 170 115 089 168 112 085 168 112 085 169
113 087 170 115 089 170 115 089 173 118 092 166 109 082 166 110 083 170 115 089
170 115 089 162 107 079 168 112 085 170 115 089 170 115 089 168 112 085 168 112
085 168 112 085 168 112 085 170 115 089 170 115 089 174 119 093 151 098 074 111
070 051 134 086 064 151 098 074 155 101 076 162 107 079 155 101 076 165 108 081
162 107 079 157 102 076 165 108 081 165 108 081 134 086 064 125 079 058 170 115
089 170 115 089 165 108 081 170 115 089 170 115 089 174 120 094 179 127 101 170
115 089 146 095 071 168 112 085 174 119 093 168 112 085 170 115 089 174 119 093
173 118 092 174 120 094 170 115 089 170 115 089 168 112 085 152 100 074 162 107
079 174 120 094 176 122 097 166 110 083 165 108 081 155 101 076 144 093 069 148
096 071 138 089 065 152 100 074 170 115 089 176 122 097 168 112 085 151 098 074
151 098 074 162 107 079 155 101 076 138 089 065 144 093 069 080 048 033 080 048
033 162 107 079 166 110 083 185 135 110 200 154 131 204 160 137 202 158 135 198
151 127 196 149 125 183 131 106 183 131 106 193 144 120 193 146 122 152 100 074
117 074 054 134 086 064 138 089 065 176 122 097 181 129 104 151 098 074 166 109
082 162 107 079 170 115 089 179 127 101 170 115 089 166 110 083 168 112 085 166
109 082 169 113 087 170 115 089 165 108 081 151 098 074 155 101 076 138 089 065
126 080 059 111 070 051 111 070 051 134 086 064 121 077 057 134 086 064 161 106
079 162 107 079 136 087 064 123 079 058 099 061 044 106 067 048 168 112 085 144
093 069 155 101 076 176 122 097 177 124 098 162 107 079 155 101 076 155 101 076
173 118 092 170 115 089 153 100 074 169 113 087 170 115 089 157 102 076 162 107
079 135 086 064 157 102 076 162 107 079 138 089 065 129 083 061 155 101 076 170
115 089 155 101 076 134 086 064 162 107 079 146 095 071 108 068 049 082 050 035
115 073 054 166 110 083 152 100 074 168 112 085 207 163 141 202 158 135 179 127
102 093 057 041 082 050 035 120 076 056 181 129 104 135 086 064 123 079 058 200
155 132 162 107 079 121 077 057 151 098 074 129 083 061 193 144 120 207 163 141
148 096 071 140 090 067 200 154 131 153 100 074 129 083 061 204 160 137 190 140
115 183 131 106 207 163 141 144 093 069 134 086 064 099 061 044 121 077 057 161
106 079 157 102 076 179 127 102 174 120 094 115 073 054 089 054 039 166 109 082
187 137 112 204 160 137 200 154 131 196 149 125 190 140 115 188 139 114 187 137
112 185 135 110 192 143 119 192 143 118 185 135 110 209 166 144 212 170 149 174
120 094 099 061 044 123 079 058 181 129 104 162 107 079 161 106 079 170 115 089
169 113 087 169 113 087 169 113 087 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 166 109 082 169 113 087 170 115 089 174 120 094 138 089 065 070
042 028 093 057 041 074 043 030 102 065 046 111 070 051 104 066 047 125 079 058
146 095 071 200 154 131 207 161 140 198 151 127 183 131 106 183 132 106 185 135
110 185 135 110 183 131 106 193 144 120 190 140 115 184 134 109 193 146 122 192
143 118 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 184 134 109 190 140 115 212 170 149
157 102 076 068 041 028 082 050 035 058 033 022 111 070 051 125 079 058 129 083
061 144 093 069 135 086 064 151 098 074 155 101 076 157 102 076 179 127 102 190
140 115 152 100 074 152 100 074 174 120 094 170 115 089 155 101 076 165 108 081
162 107 079 146 095 071 152 100 074 144 093 069 170 115 089 183 131 106 183 131
106 193 146 122 192 143 119 168 112 085 151 098 074 165 108 081 187 137 112 200
155 132 157 102 076 134 086 064 155 101 076 179 127 101 151 098 074 117 074 054
143 092 069 162 107 079 166 110 083 162 107 079 152 100 074 170 115 089 157 102
076 162 107 079 166 110 083 155 101 076 162 107 079 140 090 067 162 107 079 176
122 097 148 096 071 174 119 093 190 140 115 184 134 109 152 100 074 170 115 089
146 095 071 151 098 074 138 089 065 093 057 041 166 109 082 179 127 101 169 113
087 166 110 083 176 122 097 179 127 101 166 109 082 170 115 089 170 115 089 157
102 076 157 102 076 173 118 092 146 095 071 111 070 051 129 083 061 136 087 064
136 087 064 138 089 065 136 087 064 136 087 064 146 095 071 155 101 076 157 102
076 162 107 079 165 108 081 168 112 085 168 112 085 169 113 087 168 112 085 168
112 085 168 112 085 170 115 089 170 115 089 166 110 083 162 107 079 166 109 082
168 112 085 166 109 082 166 110 083 170 115 089 170 115 089 168 112 085 168 112
085 168 112 085 166 109 082 168 112 085 169 113 087 170 115 089 161 106 079 134
086 064 140 090 067 146 095 071 155 101 076 162 107 079 151 098 074 153 100 074
168 112 085 161 106 079 148 096 071 153 100 074 161 106 079 155 101 076 146 095
071 151 098 074 157 102 076 179 127 101 168 112 085 168 112 085 169 113 087 168
112 085 173 118 092 168 112 085 166 110 083 169 113 087 170 115 089 169 113 087
166 110 083 170 115 089 170 115 089 170 115 089 162 107 079 179 127 101 174 120
094 161 106 079 155 101 076 153 100 074 151 098 074 138 089 065 144 093 069 170
115 089 152 100 074 148 096 071 170 115 089 176 122 097 166 110 083 155 101 076
162 107 079 140 090 067 144 093 069 146 095 071 143 092 069 080 048 033 080 048
033 200 155 132 202 157 134 198 151 127 190 140 115 179 127 101 183 132 106 185
135 110 185 135 110 185 135 110 188 139 114 185 135 110 193 144 120 192 143 118
198 151 127 193 144 120 168 112 085 115 073 054 151 098 074 170 115 089 168 112
085 174 119 093 168 112 085 179 127 101 183 131 106 177 124 098 174 119 093 176
122 097 169 113 087 168 112 085 170 115 089 176 122 097 169 113 087 143 092 069
121 077 057 134 086 064 135 086 064 136 087 064 155 101 076 138 089 065 153 100
074 162 107 079 188 139 114 207 161 140 144 093 069 072 043 030 148 096 071 138
089 065 091 056 039 099 061 044 144 093 069 143 092 069 123 079 058 170 115 089
121 077 057 111 070 051 162 107 079 170 115 089 155 101 076 153 100 074 170 115
089 196 149 125 198 151 127 144 093 069 151 098 074 162 107 079 153 100 074 162
107 079 170 115 089 174 119 093 169 113 087 177 124 098 170 115 089 140 090 067
140 090 067 176 122 097 166 109 082 068 041 028 098 061 044 193 144 120 193 144
120 162 107 079 169 113 087 168 112 085 179 127 102 115 073 054 146 095 071 144
093 069 078 047 032 181 129 104 193 146 122 200 155 132 198 151 127 202 157 134
146 095 071 099 061 044 144 093 069 120 076 056 138 089 065 162 107 079 114 072
052 138 089 065 192 143 118 130 083 061 148 096 071 168 112 085 169 113 087 183
131 106 179 127 101 143 092 069 085 051 036 049 026 017 072 043 030 193 144 120
200 155 132 188 139 114 181 129 104 181 129 104 183 131 106 185 135 110 188 139
114 187 137 112 188 139 114 190 140 115 198 151 127 104 066 047 082 050 035 146
095 071 190 140 115 117 074 054 181 129 104 184 134 109 151 098 074 168 112 085
170 115 089 169 113 087 169 113 087 169 113 087 166 109 082 170 115 089 174 119
093 170 115 089 177 124 098 161 106 079 166 110 083 161 106 079 136 087 064 179
127 102 176 122 097 162 107 079 166 110 083 130 083 061 121 077 057 134 086 064
106 067 048 093 057 041 121 077 057 174 119 093 200 155 132 185 135 110 193 144
120 193 144 120 183 131 106 183 131 106 185 135 110 183 132 106 190 140 115 192
143 118 185 135 110 187 137 112 188 139 114 193 146 122 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 190 140 115
198 151 127 185 135 110 187 137 112 140 090 067 096 059 042 046 024 015 068 041
028 096 059 042 117 074 054 162 107 079 168 112 085 135 086 064 130 083 061 174
120 094 148 096 071 065 038 025 111 070 051 168 112 085 098 061 044 166 109 082
193 144 120 168 112 085 177 124 098 193 144 120 199 152 129 200 154 131 183 131
106 185 135 110 192 143 119 187 137 112 193 146 122 200 155 132 200 155 132 188
139 114 162 107 079 138 089 065 183 131 106 196 149 125 204 160 137 199 152 129
198 151 127 199 152 129 200 154 131 200 155 132 174 120 094 140 090 067 129 083
061 155 101 076 169 113 087 151 098 074 157 102 076 177 124 098 187 137 112 166
110 083 161 106 079 168 112 085 170 115 089 166 109 082 166 110 083 174 120 094
143 092 069 151 098 074 151 098 074 184 134 109 187 137 112 155 101 076 166 109
082 179 127 101 157 102 076 151 098 074 170 115 089 170 115 089 173 118 092 170
115 089 166 109 082 155 101 076 138 089 065 134 086 064 157 102 076 153 100 074
152 100 074 144 093 069 136 087 064 153 100 074 162 107 079 162 107 079 168 112
085 165 108 081 165 108 081 168 112 085 166 110 083 168 112 085 152 100 074 155
101 076 155 101 076 152 100 074 146 095 071 170 115 089 169 113 087 166 110 083
166 110 083 170 115 089 169 113 087 168 112 085 168 112 085 168 112 085 168 112
085 166 109 082 165 108 081 168 112 085 170 115 089 170 115 089 170 115 089 166
110 083 162 107 079 157 102 076 162 107 079 165 108 081 176 122 097 162 107 079
151 098 074 168 112 085 161 106 079 173 118 092 176 122 097 166 110 083 157 102
076 162 107 079 162 107 079 161 106 079 166 110 083 162 107 079 165 108 081 168
112 085 161 106 079 157 102 076 157 102 076 170 115 089 174 120 094 165 108 081
170 115 089 170 115 089 173 118 092 170 115 089 179 127 101 151 098 074 146 095
071 155 101 076 144 093 069 161 106 079 155 101 076 151 098 074 174 119 093 169
113 087 082 050 035 176 122 097 143 092 069 111 070 051 129 083 061 155 101 076
161 106 079 161 106 079 152 100 074 151 098 074 174 119 093 080 048 033 080 048
033 170 115 089 183 132 106 193 144 120 190 140 115 183 131 106 185 135 110 188
139 114 192 143 118 188 139 114 179 127 102 190 140 115 192 143 118 192 143 118
185 135 110 190 140 115 204 160 137 176 122 097 169 113 087 151 098 074 091 056
039 155 101 076 165 108 081 121 077 057 111 070 051 155 101 076 162 107 079 140
090 067 136 087 064 157 102 076 157 102 076 169 113 087 169 113 087 179 127 101
187 137 112 192 143 118 185 135 110 185 135 110 198 151 127 200 154 131 196 149
125 198 151 127 198 151 127 193 144 120 207 161 140 207 163 141 200 155 132 200
155 132 202 158 135 169 113 087 177 124 098 176 122 097 144 093 069 196 149 125
200 155 132 193 146 122 199 152 129 187 137 112 188 139 114 200 154 131 202 157
134 209 167 145 140 090 067 106 067 048 121 077 057 153 100 074 138 089 065 136
087 064 187 137 112 174 120 094 168 112 085 170 115 089 174 120 094 179 127 102
176 122 097 170 115 089 157 102 076 153 100 074 169 113 087 190 140 115 202 158
135 192 143 119 193 146 122 162 107 079 106 067 048 185 135 110 166 110 083 085
051 036 170 115 089 207 161 140 185 135 110 108 068 049 121 077 057 135 086 064
136 087 064 155 101 076 168 112 085 165 108 081 155 101 076 162 107 079 151 098
074 138 089 065 144 093 069 170 115 089 181 129 104 177 124 098 152 100 074 115
073 054 082 050 035 082 050 035 111 070 051 144 093 069 200 155 132 198 151 127
179 127 101 185 135 110 193 144 120 192 143 118 192 143 118 187 137 112 183 131
106 192 143 118 185 135 110 179 127 102 204 160 137 153 100 074 082 050 035 111
070 051 080 048 033 121 077 057 179 127 102 174 120 094 168 112 085 169 113 087
169 113 087 169 113 087 169 113 087 168 112 085 168 112 085 170 115 089 174 119
093 174 119 093 176 122 097 173 118 092 162 107 079 168 112 085 174 120 094 176
122 097 170 115 089 166 109 082 144 093 069 090 054 039 082 050 035 069 041 028
155 101 076 179 127 101 129 083 061 093 057 041 146 095 071 204 160 137 183 132
106 185 135 110 196 149 125 184 134 109 187 137 112 190 140 115 184 134 109 185
135 110 190 140 115 190 140 115 190 140 115 162 107 079 179 127 101 193 144 120
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110
192 143 118 200 155 132 199 152 129 212 168 148 199 152 129 183 131 106 188 139
114 192 143 118 082 050 035 091 056 039 135 086 064 080 048 033 120 076 056 114
072 052 096 059 042 129 083 061 126 080 059 185 135 110 193 146 122 200 155 132
193 146 122 196 149 125 193 146 122 193 144 120 188 139 114 181 129 104 184 134
109 193 144 120 190 140 115 185 135 110 188 139 114 185 135 110 183 131 106 188
139 114 200 155 132 204 160 137 192 143 119 193 144 120 196 149 125 165 108 081
162 107 079 162 107 079 102 065 046 165 108 081 200 154 131 162 107 079 177 124
098 192 143 119 190 140 115 192 143 119 193 144 120 202 158 135 170 115 089 089
054 039 179 127 101 162 107 079 162 107 079 168 112 085 162 107 079 179 127 102
173 118 092 177 124 098 168 112 085 170 115 089 162 107 079 184 134 109 168 112
085 173 118 092 130 083 061 136 087 064 173 118 092 173 118 092 166 109 082 170
115 089 170 115 089 168 112 085 168 112 085 176 122 097 181 129 104 174 120 094
170 115 089 157 102 076 168 112 085 174 120 094 170 115 089 166 110 083 162 107
079 168 112 085 166 110 083 157 102 076 168 112 085 162 107 079 170 115 089 166
110 083 166 110 083 165 108 081 170 115 089 155 101 076 165 108 081 166 109 082
170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 173 118 092 174 120
094 170 115 089 166 109 082 168 112 085 157 102 076 157 102 076 157 102 076 170
115 089 162 107 079 146 095 071 143 092 069 161 106 079 174 120 094 176 122 097
161 106 079 162 107 079 170 115 089 152 100 074 144 093 069 181 129 104 184 134
109 174 120 094 166 109 082 166 109 082 177 124 098 174 120 094 174 119 093 174
120 094 176 122 097 183 131 106 176 122 097 148 096 071 135 086 064 168 112 085
153 100 074 153 100 074 151 098 074 144 093 069 157 102 076 134 086 064 184 134
109 198 151 127 199 152 129 196 149 125 200 154 131 198 151 127 200 154 131 192
143 119 179 127 101 202 158 135 196 149 125 183 132 106 183 131 106 187 137 112
188 139 114 192 143 118 196 149 125 198 151 127 187 137 112 080 048 033 080 048
033 143 092 069 168 112 085 183 132 106 184 134 109 190 140 115 190 140 115 187
137 112 185 135 110 187 137 112 192 143 118 187 137 112 185 135 110 187 137 112
187 137 112 185 135 110 185 135 110 200 155 132 202 157 134 198 151 127 196 149
125 192 143 118 183 131 106 165 108 081 168 112 085 192 143 119 188 139 114 190
140 115 196 149 125 198 151 127 187 137 112 190 140 115 198 151 127 199 152 129
196 149 125 193 144 120 193 146 122 193 146 122 190 140 115 188 139 114 190 140
115 187 137 112 185 135 110 184 134 109 185 135 110 187 137 112 188 139 114 190
140 115 192 143 119 204 160 137 198 151 127 200 155 132 204 160 137 193 144 120
176 122 097 176 122 097 134 086 064 152 100 074 144 093 069 152 100 074 183 132
106 129 083 061 099 061 044 130 083 061 143 092 069 174 120 094 179 127 101 155
101 076 138 089 065 157 102 076 173 118 092 144 093 069 138 089 065 179 127 101
170 115 089 140 090 067 196 149 125 200 155 132 199 152 129 193 144 120 170 115
089 130 083 061 165 108 081 162 107 079 151 098 074 126 080 059 155 101 076 200
154 131 209 166 144 179 127 102 093 057 041 123 079 058 166 110 083 174 120 094
070 042 028 162 107 079 192 143 118 162 107 079 184 134 109 170 115 089 165 108
081 168 112 085 170 115 089 157 102 076 111 070 051 078 047 032 120 076 056 136
087 064 138 089 065 193 144 120 209 167 145 204 160 137 193 146 122 190 140 115
190 140 115 188 139 114 185 135 110 185 135 110 190 140 115 192 143 119 188 139
114 185 135 110 183 131 106 198 151 127 161 106 079 126 080 059 192 143 118 104
066 047 068 041 028 173 118 092 162 107 079 155 101 076 174 119 093 169 113 087
168 112 085 168 112 085 168 112 085 169 113 087 170 115 089 168 112 085 168 112
085 166 110 083 166 109 082 170 115 089 174 119 093 170 115 089 169 113 087 168
112 085 169 113 087 166 109 082 151 098 074 114 072 052 102 065 046 091 056 039
082 050 035 170 115 089 185 135 110 077 047 032 151 098 074 200 155 132 185 135
110 192 143 119 200 154 131 185 135 110 188 139 114 187 137 112 187 137 112 190
140 115 188 139 114 188 139 114 192 143 118 170 115 089 183 131 106 192 143 118
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 185 135 110 185 135 110 183 131 106 192 143 118 207 161 140 200 154
131 200 155 132 204 160 137 200 155 132 200 155 132 185 135 110 199 152 129 192
143 119 183 132 106 207 161 140 198 151 127 198 151 127 192 143 119 184 134 109
184 134 109 187 137 112 187 137 112 185 135 110 185 135 110 190 140 115 190 140
115 185 135 110 185 135 110 188 139 114 188 139 114 187 137 112 190 140 115 185
135 110 187 137 112 188 139 114 193 144 120 183 131 106 082 050 035 085 051 036
155 101 076 173 118 092 187 137 112 193 146 122 183 131 106 192 143 119 193 144
120 185 135 110 193 144 120 192 143 119 190 140 115 190 140 115 179 127 102 157
102 076 155 101 076 170 115 089 185 135 110 162 107 079 136 087 064 144 093 069
148 096 071 135 086 064 115 073 054 064 036 024 123 079 058 179 127 101 183 131
106 138 089 065 108 068 049 144 093 069 168 112 085 173 118 092 166 109 082 162
107 079 174 120 094 174 119 093 166 109 082 168 112 085 168 112 085 166 110 083
170 115 089 174 120 094 173 118 092 170 115 089 170 115 089 170 115 089 168 112
085 170 115 089 170 115 089 170 115 089 174 120 094 176 122 097 181 129 104 176
122 097 168 112 085 170 115 089 168 112 085 170 115 089 165 108 081 173 118 092
174 120 094 170 115 089 170 115 089 173 118 092 170 115 089 165 108 081 162 107
079 169 113 087 168 112 085 166 110 083 165 108 081 168 112 085 168 112 085 179
127 101 162 107 079 138 089 065 193 144 120 183 131 106 140 090 067 169 113 087
170 115 089 152 100 074 168 112 085 120 076 056 111 070 051 114 072 052 146 095
071 188 139 114 170 115 089 165 108 081 161 106 079 162 107 079 166 110 083 161
106 079 148 096 071 098 061 044 151 098 074 174 120 094 173 118 092 190 140 115
187 137 112 188 139 114 181 129 104 177 124 098 185 135 110 200 155 132 199 152
129 185 135 110 190 140 115 190 140 115 190 140 115 190 140 115 188 139 114 192
143 118 200 155 132 187 137 112 192 143 118 198 151 127 199 152 129 193 146 122
192 143 119 193 144 120 192 143 118 190 140 115 174 120 094 080 048 033 080 048
033 204 160 137 198 151 127 192 143 119 192 143 118 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137 112
190 140 115 192 143 119 185 135 110 183 131 106 183 132 106 187 137 112 190 140
115 190 140 115 196 149 125 207 161 140 204 160 137 192 143 119 190 140 115 193
146 122 190 140 115 187 137 112 196 149 125 192 143 119 188 139 114 184 134 109
185 135 110 185 135 110 185 135 110 185 135 110 185 135 110 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 185 135 110 185
135 110 184 134 109 185 135 110 185 135 110 184 134 109 183 132 106 200 155 132
123 079 058 111 070 051 174 120 094 170 115 089 169 113 087 155 101 076 155 101
076 111 070 051 148 096 071 183 131 106 166 110 083 108 068 049 136 087 064 170
115 089 099 061 044 126 080 059 157 102 076 144 093 069 136 087 064 157 102 076
115 073 054 174 120 094 200 155 132 165 108 081 111 070 051 123 079 058 140 090
067 193 144 120 108 068 049 125 079 058 198 151 127 168 112 085 199 152 129 200
155 132 184 134 109 188 139 114 126 080 059 170 115 089 184 134 109 165 108 081
125 079 058 077 047 032 134 086 064 174 120 094 134 086 064 078 047 032 098 061
044 096 059 042 070 042 028 068 041 028 162 107 079 183 131 106 209 166 144 202
158 135 202 157 134 199 152 129 190 140 115 183 132 106 179 127 101 184 134 109
188 139 114 187 137 112 187 137 112 188 139 114 183 132 106 188 139 114 193 146
122 190 140 115 184 134 109 202 157 134 176 122 097 104 066 047 123 079 058 174
119 093 193 144 120 174 119 093 176 122 097 170 115 089 165 108 081 168 112 085
168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 168 112
085 168 112 085 168 112 085 168 112 085 168 112 085 166 109 082 166 110 083 166
110 083 168 112 085 161 106 079 152 100 074 169 113 087 152 100 074 099 061 044
072 043 030 096 059 042 062 035 024 045 024 015 209 166 144 212 170 149 192 143
118 174 120 094 177 124 098 192 143 118 187 137 112 187 137 112 187 137 112 190
140 115 185 135 110 185 135 110 190 140 115 190 140 115 192 143 118 185 135 110
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 187 137 112 184 134
109 185 135 110 192 143 119 190 140 115 187 137 112 198 151 127 185 135 110 192
143 119 202 157 134 190 140 115 192 143 119 183 131 106 185 135 110 187 137 112
187 137 112 185 135 110 185 135 110 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 192 143 118 188 139 114 187 137 112 190 140 115 144 093 069 153 100 074
168 112 085 117 074 054 183 131 106 207 161 140 192 143 118 183 131 106 187 137
112 192 143 119 185 135 110 185 135 110 187 137 112 183 131 106 202 157 134 204
160 137 173 118 092 140 090 067 126 080 059 135 086 064 144 093 069 209 167 145
153 100 074 121 077 057 212 168 148 157 102 076 102 063 046 123 079 058 166 110
083 117 074 054 153 100 074 170 115 089 162 107 079 168 112 085 183 131 106 155
101 076 166 110 083 170 115 089 173 118 092 174 119 093 169 113 087 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 169 113 087 168 112
085 166 109 082 170 115 089 174 120 094 138 089 065 123 079 058 121 077 057 157
102 076 169 113 087 173 118 092 174 120 094 183 132 106 183 131 106 165 108 081
161 106 079 155 101 076 170 115 089 174 120 094 155 101 076 138 089 065 138 089
065 144 093 069 129 083 061 153 100 074 179 127 101 170 115 089 157 102 076 166
110 083 136 087 064 144 093 069 200 155 132 192 143 118 181 129 104 193 144 120
200 154 131 198 151 127 200 155 132 199 152 129 202 157 134 162 107 079 115 073
054 144 093 069 146 095 071 138 089 065 168 112 085 166 110 083 155 101 076 151
098 074 155 101 076 168 112 085 198 151 127 193 146 122 199 152 129 192 143 118
192 143 118 200 154 131 196 149 125 185 135 110 183 131 106 183 132 106 187 137
112 185 135 110 185 135 110 185 135 110 185 135 110 185 135 110 185 135 110 185
135 110 184 134 109 185 135 110 184 134 109 184 134 109 184 134 109 184 134 109
185 135 110 188 139 114 188 139 114 190 140 115 198 151 127 080 048 033 080 048
033 183 131 106 183 132 106 185 135 110 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 183 132 106 188 139 114 188 139 114 188 139 114 185 135 110 184 134
109 187 137 112 187 137 112 185 135 110 184 134 109 185 135 110 192 143 119 183
131 106 184 134 109 193 144 120 193 144 120 190 140 115 187 137 112 185 135 110
185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 185 135 110 190 140 115 188 139 114 185 135 110 188 139 114
215 175 154 151 098 074 152 100 074 170 115 089 161 106 079 157 102 076 140 090
067 157 102 076 153 100 074 117 074 054 146 095 071 187 137 112 193 146 122 193
144 120 198 151 127 190 140 115 190 140 115 200 154 131 183 131 106 126 080 059
123 079 058 181 129 104 199 152 129 187 137 112 166 109 082 098 061 044 144 093
069 111 070 051 080 048 033 196 149 125 200 154 131 200 154 131 199 152 129 183
132 106 198 151 127 190 140 115 196 149 125 179 127 102 165 108 081 146 095 071
151 098 074 129 083 061 173 118 092 177 124 098 162 107 079 169 113 087 181 129
104 166 109 082 138 089 065 169 113 087 204 160 137 207 161 140 198 151 127 183
132 106 185 135 110 185 135 110 185 135 110 190 140 115 193 144 120 188 139 114
185 135 110 185 135 110 185 135 110 184 134 109 190 140 115 188 139 114 187 137
112 193 144 120 204 160 137 185 135 110 111 070 051 166 110 083 183 131 106 168
112 085 173 118 092 162 107 079 169 113 087 170 115 089 166 109 082 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 174 119 093 170 115 089 170 115 089 173 118 092 169
113 087 173 118 092 176 122 097 174 119 093 162 107 079 121 077 057 111 070 051
089 054 039 072 043 030 090 054 039 126 080 059 104 066 047 138 089 065 193 144
120 200 154 131 200 154 131 184 134 109 187 137 112 187 137 112 187 137 112 187
137 112 184 134 109 185 135 110 185 135 110 187 137 112 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114
188 139 114 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 187 137
112 185 135 110 184 134 109 190 140 115 185 135 110 181 129 104 183 132 106 190
140 115 183 132 106 187 137 112 188 139 114 193 144 120 190 140 115 185 135 110
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 192
143 118 185 135 110 187 137 112 188 139 114 199 152 129 199 152 129 169 113 087
049 026 017 062 035 024 072 043 030 111 070 051 193 144 120 207 163 141 200 155
132 193 144 120 190 140 115 185 135 110 183 132 106 188 139 114 179 127 102 181
129 104 193 146 122 187 137 112 134 086 064 162 107 079 200 154 131 192 143 118
174 120 094 196 149 125 188 139 114 196 149 125 200 155 132 199 152 129 157 102
076 169 113 087 181 129 104 161 106 079 162 107 079 146 095 071 130 083 061 185
135 110 169 113 087 166 110 083 170 115 089 161 106 079 168 112 085 169 113 087
162 107 079 151 098 074 155 101 076 161 106 079 162 107 079 168 112 085 170 115
089 170 115 089 170 115 089 173 118 092 162 107 079 165 108 081 121 077 057 144
093 069 161 106 079 104 066 047 136 087 064 166 110 083 126 080 059 117 074 054
174 120 094 165 108 081 157 102 076 161 106 079 161 106 079 183 131 106 199 152
129 193 144 120 192 143 118 153 100 074 151 098 074 166 110 083 166 109 082 155
101 076 161 106 079 192 143 118 199 152 129 185 135 110 192 143 118 199 152 129
202 158 135 176 122 097 170 115 089 200 155 132 202 158 135 204 160 137 115 073
054 121 077 057 161 106 079 187 137 112 202 157 134 193 146 122 193 144 120 199
152 129 200 155 132 200 154 131 202 158 135 179 127 101 179 127 102 183 131 106
183 132 106 192 143 118 192 143 119 188 139 114 185 135 110 183 131 106 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 188 139 114 188 139 114 187 137 112 080 048 033 080 048
033 190 140 115 190 140 115 190 140 115 188 139 114 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 190 140 115 188 139 114 184 134 109 190 140 115 199 152
129 190 140 115 184 134 109 185 135 110 183 132 106 183 131 106 183 132 106 184
134 109 188 139 114 185 135 110 183 131 106 185 135 110 184 134 109 183 132 106
185 135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 185 135 110 185 135 110 190 140 115 185 135 110
198 151 127 155 101 076 153 100 074 185 135 110 174 120 094 174 120 094 177 124
098 181 129 104 179 127 101 185 135 110 204 160 137 184 134 109 134 086 064 148
096 071 146 095 071 173 118 092 185 135 110 190 140 115 192 143 118 185 135 110
200 155 132 185 135 110 198 151 127 212 168 148 209 166 144 193 144 120 188 139
114 173 118 092 202 157 134 185 135 110 144 093 069 151 098 074 183 131 106 198
151 127 166 109 082 183 131 106 183 131 106 168 112 085 162 107 079 140 090 067
153 100 074 200 154 131 165 108 081 138 089 065 173 118 092 129 083 061 181 129
104 209 167 145 199 152 129 200 154 131 192 143 119 185 135 110 181 129 104 192
143 119 183 131 106 181 129 104 190 140 115 193 144 120 202 157 134 204 160 137
198 151 127 200 155 132 198 151 127 199 152 129 193 144 120 192 143 119 200 154
131 196 149 125 168 112 085 102 063 046 162 107 079 183 131 106 174 119 093 168
112 085 168 112 085 174 120 094 173 118 092 166 109 082 170 115 089 174 119 093
170 115 089 173 118 092 173 118 092 173 118 092 169 113 087 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 166 110 083 162 107 079 168 112 085 170 115 089 168 112 085 168 112 085
170 115 089 161 106 079 168 112 085 138 089 065 053 029 019 070 042 028 170 115
089 166 110 083 162 107 079 193 144 120 187 137 112 187 137 112 187 137 112 185
135 110 181 129 104 187 137 112 185 135 110 192 143 119 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 188 139 114 188 139 114 188 139 114 187 137 112 185 135 110
183 131 106 183 131 106 185 135 110 188 139 114 179 127 101 179 127 101 193 146
122 185 135 110 187 137 112 187 137 112 190 140 115 183 132 106 185 135 110 190
140 115 190 140 115 183 132 106 183 131 106 183 132 106 185 135 110 190 140 115
187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 188 139 114 188 139 114 185 135 110 183 131 106 192 143 118 199 152 129
204 160 137 111 070 051 089 054 039 091 056 039 093 057 041 136 087 064 161 106
079 190 140 115 193 144 120 202 158 135 204 160 137 199 152 129 200 155 132 202
157 134 192 143 119 198 151 127 209 166 144 198 151 127 187 137 112 183 132 106
202 157 134 193 144 120 192 143 118 183 131 106 192 143 118 200 155 132 190 140
115 198 151 127 184 134 109 193 144 120 200 155 132 183 131 106 080 048 033 138
089 065 153 100 074 153 100 074 157 102 076 161 106 079 168 112 085 170 115 089
168 112 085 179 127 101 174 120 094 165 108 081 168 112 085 174 119 093 170 115
089 166 110 083 165 108 081 157 102 076 169 113 087 170 115 089 185 135 110 173
118 092 170 115 089 146 095 071 148 096 071 135 086 064 082 050 035 179 127 101
207 163 141 190 140 115 184 134 109 192 143 118 198 151 127 199 152 129 199 152
129 188 139 114 193 144 120 192 143 118 185 135 110 190 140 115 193 146 122 198
151 127 193 146 122 185 135 110 198 151 127 192 143 118 179 127 101 193 144 120
188 139 114 168 112 085 174 120 094 179 127 102 179 127 101 155 101 076 123 079
058 174 120 094 166 109 082 168 112 085 185 135 110 190 140 115 187 137 112 162
107 079 138 089 065 143 092 069 138 089 065 199 152 129 199 152 129 190 140 115
179 127 102 185 135 110 190 140 115 193 144 120 192 143 118 190 140 115 190 140
115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
190 140 115 181 129 104 187 137 112 185 135 110 183 131 106 080 048 033 080 048
033 185 135 110 190 140 115 190 140 115 190 140 115 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 185 135 110 188 139 114 188 139 114 187 137
112 185 135 110 188 139 114 187 137 112 187 137 112 190 140 115 188 139 114 190
140 115 192 143 118 187 137 112 183 132 106 187 137 112 188 139 114 187 137 112
190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 187 137 112 185 135 110 192 143 118
179 127 101 193 146 122 207 161 140 174 119 093 162 107 079 185 135 110 184 134
109 162 107 079 153 100 074 111 070 051 059 034 023 093 057 041 111 070 051 106
067 048 093 057 041 146 095 071 087 053 037 111 070 051 102 063 046 111 070 051
153 100 074 166 109 082 104 066 047 091 056 039 126 080 059 082 050 035 098 061
044 155 101 076 144 093 069 151 098 074 136 087 064 170 115 089 165 108 081 138
089 065 099 061 044 078 047 032 093 057 041 162 107 079 183 131 106 144 093 069
143 092 069 166 109 082 135 086 064 151 098 074 152 100 074 093 057 041 126 080
059 202 158 135 193 146 122 177 124 098 179 127 101 185 135 110 184 134 109 185
135 110 193 144 120 200 155 132 207 163 141 198 151 127 157 102 076 170 115 089
192 143 118 173 118 092 179 127 101 183 131 106 183 131 106 168 112 085 153 100
074 144 093 069 134 086 064 174 119 093 177 124 098 162 107 079 168 112 085 170
115 089 170 115 089 166 110 083 169 113 087 169 113 087 169 113 087 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 168 112 085 168 112 085 168 112 085 168 112 085 168
112 085 162 107 079 165 108 081 166 110 083 169 113 087 173 118 092 157 102 076
174 120 094 179 127 102 183 131 106 152 100 074 104 066 047 085 051 036 179 127
102 146 095 071 162 107 079 200 154 131 187 137 112 185 135 110 190 140 115 188
139 114 185 135 110 188 139 114 190 140 115 190 140 115 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 190 140 115 183 132 106 179 127 101 179 127 102 185 135 110 184 134 109
200 154 131 204 160 137 202 158 135 200 155 132 188 139 114 190 140 115 192 143
118 183 132 106 192 143 118 190 140 115 190 140 115 188 139 114 193 146 122 188
139 114 185 135 110 190 140 115 187 137 112 183 131 106 185 135 110 190 140 115
188 139 114 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 183
131 106 183 132 106 187 137 112 190 140 115 185 135 110 183 131 106 184 134 109
202 157 134 193 146 122 183 131 106 170 115 089 161 106 079 134 086 064 089 054
039 102 063 046 121 077 057 121 077 057 136 087 064 161 106 079 170 115 089 179
127 101 185 135 110 185 135 110 183 132 106 184 134 109 183 132 106 193 144 120
190 140 115 183 131 106 193 144 120 187 137 112 184 134 109 185 135 110 200 155
132 162 107 079 153 100 074 190 140 115 190 140 115 198 151 127 192 143 119 173
118 092 166 109 082 168 112 085 169 113 087 168 112 085 143 092 069 120 076 056
161 106 079 140 090 067 134 086 064 152 100 074 144 093 069 126 080 059 155 101
076 170 115 089 169 113 087 173 118 092 179 127 101 170 115 089 170 115 089 151
098 074 151 098 074 168 112 085 155 101 076 162 107 079 126 080 059 108 068 049
179 127 102 193 146 122 192 143 118 188 139 114 185 135 110 183 131 106 183 132
106 185 135 110 183 131 106 190 140 115 190 140 115 184 134 109 187 137 112 188
139 114 185 135 110 183 132 106 187 137 112 190 140 115 185 135 110 193 144 120
184 134 109 170 115 089 152 100 074 091 056 039 143 092 069 126 080 059 151 098
074 126 080 059 070 042 028 134 086 064 115 073 054 174 119 093 183 131 106 126
080 059 130 083 061 151 098 074 173 118 092 188 139 114 192 143 118 192 143 118
193 144 120 188 139 114 185 135 110 188 139 114 188 139 114 192 143 118 188 139
114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 183 132 106 188 139 114 192 143 118 188 139 114 080 048 033 080 048
033 188 139 114 187 137 112 185 135 110 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 188 139 114 188 139 114 190 140 115 187 137 112 187 137 112 187
137 112 185 135 110 187 137 112 190 140 115 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
188 139 114 193 146 122 192 143 119 140 090 067 135 086 064 126 080 059 104 066
047 091 056 039 121 077 057 102 065 046 111 070 051 151 098 074 185 135 110 202
157 134 199 152 129 212 170 149 140 090 067 123 079 058 185 135 110 207 161 140
196 149 125 144 093 069 098 061 044 157 102 076 115 073 054 115 073 054 179 127
101 138 089 065 174 119 093 200 154 131 155 101 076 140 090 067 130 083 061 181
129 104 129 083 061 126 080 059 166 110 083 146 095 071 126 080 059 153 100 074
168 112 085 138 089 065 140 090 067 144 093 069 134 086 064 152 100 074 089 054
039 114 072 052 204 160 137 202 158 135 204 160 137 183 132 106 184 134 109 204
160 137 190 140 115 162 107 079 111 070 051 098 061 044 096 059 042 085 051 036
104 066 047 121 077 057 126 080 059 126 080 059 114 072 052 115 073 054 134 086
064 146 095 071 166 110 083 162 107 079 155 101 076 166 109 082 166 109 082 166
110 083 166 109 082 168 112 085 166 110 083 168 112 085 168 112 085 169 113 087
169 113 087 169 113 087 169 113 087 168 112 085 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170
115 089 173 118 092 173 118 092 173 118 092 170 115 089 173 118 092 176 122 097
162 107 079 143 092 069 169 113 087 143 092 069 121 077 057 151 098 074 121 077
057 143 092 069 215 175 154 188 139 114 187 137 112 185 135 110 190 140 115 190
140 115 188 139 114 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 190 140 115 190 140 115 193 144 120 200 155 132 193 144 120 198 151 127
198 151 127 177 124 098 151 098 074 179 127 101 200 155 132 181 129 104 181 129
104 207 161 140 202 157 134 200 154 131 193 146 122 183 132 106 179 127 102 187
137 112 192 143 118 188 139 114 190 140 115 190 140 115 187 137 112 185 135 110
187 137 112 192 143 118 193 146 122 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 190 140 115 187 137 112 185 135 110 187 137 112 188 139 114 185 135 110
179 127 101 192 143 119 200 155 132 192 143 119 198 151 127 193 146 122 183 131
106 174 120 094 190 140 115 170 115 089 152 100 074 140 090 067 126 080 059 102
065 046 114 072 052 174 119 093 198 151 127 188 139 114 190 140 115 185 135 110
185 135 110 188 139 114 185 135 110 188 139 114 188 139 114 188 139 114 185 135
110 190 140 115 198 151 127 190 140 115 183 131 106 193 144 120 200 155 132 200
155 132 199 152 129 188 139 114 193 144 120 200 155 132 192 143 118 177 124 098
185 135 110 111 070 051 121 077 057 193 144 120 170 115 089 140 090 067 170 115
089 129 083 061 170 115 089 174 120 094 135 086 064 134 086 064 111 070 051 140
090 067 168 112 085 157 102 076 161 106 079 162 107 079 168 112 085 174 120 094
188 139 114 192 143 119 185 135 110 190 140 115 187 137 112 190 140 115 190 140
115 188 139 114 190 140 115 187 137 112 188 139 114 190 140 115 187 137 112 187
137 112 187 137 112 190 140 115 185 135 110 188 139 114 183 131 106 185 135 110
190 140 115 185 135 110 200 155 132 184 134 109 179 127 101 185 135 110 193 146
122 181 129 104 192 143 118 204 160 137 193 146 122 200 155 132 196 149 125 193
146 122 204 160 137 202 158 135 202 158 135 185 135 110 185 135 110 185 135 110
185 135 110 187 137 112 188 139 114 187 137 112 185 135 110 185 135 110 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 190 140 115 187 137 112 185 135 110 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
179 127 101 179 127 101 200 155 132 207 163 141 209 167 145 196 149 125 190 140
115 185 135 110 174 120 094 135 086 064 199 152 129 177 124 098 140 090 067 148
096 071 117 074 054 068 041 028 193 144 120 202 157 134 198 151 127 198 151 127
151 098 074 157 102 076 220 181 161 200 154 131 174 120 094 183 131 106 162 107
079 193 144 120 198 151 127 121 077 057 061 035 024 093 057 041 183 132 106 200
155 132 198 151 127 209 166 144 209 166 144 179 127 101 089 054 039 153 100 074
120 076 056 089 054 039 151 098 074 152 100 074 134 086 064 121 077 057 126 080
059 104 066 047 138 089 065 179 127 102 193 146 122 202 158 135 196 149 125 185
135 110 155 101 076 082 050 035 078 047 032 098 061 044 115 073 054 089 054 039
121 077 057 190 140 115 173 118 092 179 127 101 179 127 101 176 122 097 169 113
087 169 113 087 169 113 087 153 100 074 157 102 076 162 107 079 166 110 083 168
112 085 168 112 085 166 110 083 168 112 085 168 112 085 168 112 085 169 113 087
169 113 087 169 113 087 169 113 087 169 113 087 168 112 085 169 113 087 169 113
087 169 113 087 168 112 085 169 113 087 169 113 087 169 113 087 169 113 087 169
113 087 168 112 085 168 112 085 168 112 085 168 112 085 168 112 085 170 115 089
173 118 092 157 102 076 157 102 076 169 113 087 144 093 069 102 063 046 120 076
056 144 093 069 168 112 085 193 144 120 185 135 110 187 137 112 185 135 110 185
135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188
139 114 185 135 110 185 135 110 202 157 134 217 177 157 209 167 145 177 124 098
062 035 024 043 023 014 085 051 036 093 057 041 140 090 067 199 152 129 207 163
141 108 068 049 091 056 039 093 057 041 146 095 071 204 160 137 204 160 137 187
137 112 193 144 120 200 154 131 183 132 106 184 134 109 185 135 110 188 139 114
190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 190
140 115 190 140 115 184 134 109 179 127 102 183 131 106 192 143 118 193 144 120
193 144 120 190 140 115 185 135 110 184 134 109 187 137 112 193 144 120 198 151
127 198 151 127 192 143 119 199 152 129 202 157 134 204 160 137 199 152 129 193
144 120 198 151 127 193 144 120 193 144 120 190 140 115 185 135 110 187 137 112
187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 185 135 110 187 137 112 190 140 115 185 135 110 188 139 114 196
149 125 188 139 114 179 127 102 190 140 115 181 129 104 192 143 119 198 151 127
202 157 134 202 157 134 200 155 132 198 151 127 200 154 131 200 155 132 190 140
115 190 140 115 170 115 089 166 110 083 146 095 071 111 070 051 170 115 089 181
129 104 198 151 127 196 149 125 202 158 135 193 144 120 193 144 120 200 155 132
188 139 114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110
190 140 115 192 143 118 190 140 115 204 160 137 200 155 132 192 143 119 190 140
115 190 140 115 200 155 132 184 134 109 187 137 112 190 140 115 196 149 125 190
140 115 183 132 106 193 144 120 192 143 118 184 134 109 188 139 114 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
190 140 115 185 135 110 185 135 110 185 135 110 179 127 102 192 143 118 193 144
120 193 146 122 200 155 132 200 155 132 193 146 122 183 131 106 166 110 083 129
083 061 108 068 049 080 048 033 162 107 079 202 158 135 192 143 118 183 131 106
183 131 106 074 043 030 068 041 028 134 086 064 091 056 039 089 054 039 162 107
079 209 167 145 072 043 030 143 092 069 179 127 101 209 166 144 190 140 115 072
043 030 089 054 039 082 050 035 082 050 035 111 070 051 117 074 054 134 086 064
115 073 054 072 043 030 115 073 054 093 057 041 181 129 104 184 134 109 162 107
079 169 113 087 072 043 030 032 016 010 028 013 009 174 120 094 207 161 140 165
108 081 166 110 083 179 127 101 153 100 074 162 107 079 179 127 101 176 122 097
193 146 122 187 137 112 170 115 089 170 115 089 173 118 092 170 115 089 168 112
085 173 118 092 174 120 094 174 120 094 177 124 098 176 122 097 174 119 093 174
120 094 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089
170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115 089 170 115
089 170 115 089 170 115 089 166 110 083 168 112 085 168 112 085 168 112 085 168
112 085 169 113 087 169 113 087 169 113 087 168 112 085 168 112 085 168 112 085
170 115 089 166 109 082 152 100 074 151 098 074 125 079 058 152 100 074 215 175
154 213 171 150 174 119 093 190 140 115 188 139 114 187 137 112 185 135 110 185
135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 181
129 104 184 134 109 202 158 135 174 119 093 068 041 028 093 057 041 138 089 065
108 068 049 082 050 035 070 042 028 155 101 076 166 109 082 162 107 079 089 054
039 096 059 042 177 124 098 183 131 106 192 143 118 199 152 129 193 144 120 193
146 122 144 093 069 169 113 087 193 144 120 193 146 122 198 151 127 192 143 119
185 135 110 185 135 110 192 143 118 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112 192 143 119 202
158 135 198 151 127 193 144 120 187 137 112 184 134 109 193 146 122 198 151 127
184 134 109 187 137 112 204 160 137 207 163 141 207 161 140 200 155 132 188 139
114 185 135 110 183 131 106 183 131 106 184 134 109 190 140 115 190 140 115 192
143 119 192 143 119 181 129 104 177 124 098 185 135 110 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135
110 190 140 115 190 140 115 188 139 114 188 139 114 190 140 115 183 132 106 183
131 106 185 135 110 183 131 106 174 120 094 207 163 141 212 168 148 202 158 135
199 152 129 188 139 114 168 112 085 183 132 106 183 131 106 121 077 057 117 074
054 140 090 067 126 080 059 104 066 047 136 087 064 193 144 120 193 146 122 173
118 092 190 140 115 193 144 120 188 139 114 193 146 122 198 151 127 183 132 106
192 143 118 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 192 143 118 190 140 115
184 134 109 184 134 109 179 127 101 185 135 110 184 134 109 179 127 101 185 135
110 185 135 110 183 131 106 185 135 110 196 149 125 179 127 101 183 132 106 188
139 114 181 129 104 181 129 104 185 135 110 190 140 115 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114
187 137 112 185 135 110 179 127 102 185 135 110 185 135 110 188 139 114 188 139
114 190 140 115 183 131 106 185 135 110 187 137 112 198 151 127 202 157 134 200
155 132 202 158 135 209 166 144 199 152 129 183 131 106 179 127 102 199 152 129
179 127 101 140 090 067 166 110 083 183 132 106 188 139 114 198 151 127 192 143
118 115 073 054 199 152 129 204 160 137 115 073 054 078 047 032 106 067 048 121
077 057 120 076 056 129 083 061 170 115 089 151 098 074 153 100 074 121 077 057
111 070 051 162 107 079 151 098 074 121 077 057 089 054 039 135 086 064 152 100
074 168 112 085 111 070 051 102 065 046 098 061 044 058 033 022 108 068 049 146
095 071 135 086 064 200 154 131 200 155 132 198 151 127 192 143 118 179 127 101
155 101 076 102 063 046 174 120 094 170 115 089 174 120 094 169 113 087 170 115
089 173 118 092 173 118 092 174 119 093 170 115 089 173 118 092 170 115 089 168
112 085 168 112 085 169 113 087 168 112 085 169 113 087 170 115 089 168 112 085
170 115 089 169 113 087 170 115 089 170 115 089 170 115 089 173 118 092 173 118
092 173 118 092 174 119 093 170 115 089 170 115 089 170 115 089 173 118 092 169
113 087 170 115 089 170 115 089 170 115 089 173 118 092 176 122 097 173 118 092
173 118 092 183 131 106 190 140 115 185 135 110 170 115 089 125 079 058 062 035
024 129 083 061 183 131 106 198 151 127 199 152 129 200 155 132 198 151 127 190
140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 184
134 109 185 135 110 200 155 132 183 131 106 082 050 035 085 051 036 099 061 044
144 093 069 129 083 061 144 093 069 136 087 064 090 054 039 098 061 044 072 043
030 104 066 047 151 098 074 153 100 074 143 092 069 121 077 057 108 068 049 177
124 098 185 135 110 173 118 092 198 151 127 179 127 101 168 112 085 179 127 102
190 140 115 193 144 120 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 188 139 114 185 135 110 190 140 115 193 146 122 192 143 119 170
115 089 170 115 089 190 140 115 202 158 135 193 144 120 174 119 093 170 115 089
199 152 129 204 160 137 183 132 106 196 149 125 176 122 097 151 098 074 204 160
137 202 158 135 204 160 137 202 158 135 200 155 132 193 144 120 187 137 112 188
139 114 190 140 115 192 143 119 192 143 118 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 192 143
118 190 140 115 190 140 115 190 140 115 185 135 110 183 132 106 193 144 120 190
140 115 183 131 106 192 143 118 209 167 145 140 090 067 099 061 044 098 061 044
114 072 052 130 083 061 126 080 059 099 061 044 111 070 051 098 061 044 173 118
092 174 120 094 165 108 081 168 112 085 179 127 102 200 154 131 193 144 120 190
140 115 190 140 115 185 135 110 183 132 106 179 127 102 181 129 104 183 132 106
190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 190 140 115 185 135 110 185 135 110 190 140 115
185 135 110 188 139 114 193 144 120 188 139 114 185 135 110 190 140 115 193 144
120 190 140 115 187 137 112 192 143 119 196 149 125 184 134 109 192 143 119 193
144 120 193 144 120 192 143 119 185 135 110 188 139 114 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
190 140 115 190 140 115 188 139 114 190 140 115 190 140 115 190 140 115 187 137
112 187 137 112 188 139 114 190 140 115 185 135 110 185 135 110 187 137 112 187
137 112 188 139 114 183 132 106 190 140 115 187 137 112 183 132 106 190 140 115
193 146 122 202 157 134 200 154 131 200 154 131 200 154 131 200 155 132 179 127
101 165 108 081 204 160 137 188 139 114 099 061 044 037 019 011 053 029 019 166
109 082 174 120 094 192 143 118 161 106 079 089 054 039 121 077 057 115 073 054
064 036 024 136 087 064 102 065 046 061 035 024 115 073 054 123 079 058 077 047
032 087 053 037 143 092 069 161 106 079 170 115 089 169 113 087 135 086 064 106
067 048 091 056 039 087 053 037 129 083 061 148 096 071 140 090 067 146 095 071
123 079 058 108 068 049 155 101 076 168 112 085 168 112 085 174 120 094 181 129
104 181 129 104 168 112 085 174 119 093 173 118 092 179 127 102 185 135 110 188
139 114 192 143 118 183 132 106 174 120 094 177 124 098 183 132 106 183 131 106
192 143 119 183 131 106 170 115 089 174 119 093 170 115 089 165 108 081 157 102
076 155 101 076 155 101 076 166 109 082 169 113 087 173 118 092 170 115 089 185
135 110 183 132 106 179 127 101 179 127 101 176 122 097 176 122 097 177 124 098
179 127 101 117 074 054 115 073 054 161 106 079 146 095 071 117 074 054 068 041
028 046 024 015 058 033 022 130 083 061 162 107 079 174 119 093 190 140 115 192
143 119 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190
140 115 187 137 112 187 137 112 193 146 122 200 155 132 204 160 137 193 144 120
200 155 132 200 155 132 196 149 125 179 127 102 148 096 071 144 093 069 185 135
110 170 115 089 148 096 071 162 107 079 170 115 089 170 115 089 155 101 076 181
129 104 202 158 135 193 146 122 190 140 115 179 127 101 155 101 076 177 124 098
192 143 118 190 140 115 183 132 106 188 139 114 187 137 112 187 137 112 187 137
112 190 140 115 192 143 118 193 146 122 162 107 079 126 080 059 102 065 046 040
020 012 089 054 039 115 073 054 089 054 039 162 107 079 190 140 115 165 108 081
151 098 074 082 050 035 017 006 005 040 020 012 111 070 051 155 101 076 093 057
041 078 047 032 157 102 076 155 101 076 166 109 082 179 127 101 190 140 115 188
139 114 190 140 115 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112
187 137 112 185 135 110 190 140 115 192 143 119 193 144 120 174 119 093 126 080
059 183 132 106 196 149 125 188 139 114 188 139 114 187 137 112 183 131 106 184
134 109 200 154 131 193 144 120 174 119 093 099 061 044 064 036 024 125 079 058
126 080 059 121 077 057 117 074 054 093 057 041 179 127 102 190 140 115 192 143
119 200 155 132 199 152 129 198 151 127 193 146 122 185 135 110 185 135 110 190
140 115 185 135 110 185 135 110 190 140 115 185 135 110 185 135 110 188 139 114
187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 187 137 112
187 137 112 190 140 115 190 140 115 187 137 112 190 140 115 192 143 118 188 139
114 188 139 114 190 140 115 188 139 114 185 135 110 190 140 115 190 140 115 187
137 112 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135
110 188 139 114 188 139 114 185 135 110 188 139 114 187 137 112 187 137 112 187
137 112 185 135 110 188 139 114 185 135 110 187 137 112 190 140 115 185 135 110
185 135 110 185 135 110 185 135 110 184 134 109 185 135 110 183 132 106 192 143
119 200 155 132 183 131 106 192 143 118 212 170 149 190 140 115 152 100 074 168
112 085 144 093 069 117 074 054 062 035 024 082 050 035 099 061 044 068 041 028
102 063 046 104 066 047 104 066 047 096 059 042 134 086 064 153 100 074 104 066
047 106 067 048 138 089 065 108 068 049 135 086 064 155 101 076 165 108 081 165
108 081 170 115 089 125 079 058 089 054 039 080 048 033 099 061 044 099 061 044
111 070 051 146 095 071 136 087 064 143 092 069 082 050 035 134 086 064 126 080
059 089 054 039 134 086 064 151 098 074 152 100 074 125 079 058 093 057 041 129
083 061 111 070 051 106 067 048 170 115 089 168 112 085 157 102 076 166 110 083
108 068 049 157 102 076 185 135 110 187 137 112 193 144 120 193 146 122 190 140
115 179 127 101 174 119 093 179 127 101 183 131 106 177 124 098 143 092 069 115
073 054 117 074 054 151 098 074 161 106 079 148 096 071 108 068 049 111 070 051
165 108 081 138 089 065 102 065 046 143 092 069 173 118 092 144 093 069 174 119
093 166 109 082 140 090 067 125 079 058 121 077 057 108 068 049 104 066 047 157
102 076 200 155 132 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 188 139 114 185 135 110 185 135 110 192 143 119 193 146 122 198 151 127
193 144 120 192 143 118 190 140 115 199 152 129 209 166 144 204 160 137 204 160
137 204 160 137 202 158 135 202 157 134 200 155 132 200 155 132 204 160 137 192
143 119 183 132 106 188 139 114 185 135 110 193 144 120 198 151 127 193 144 120
187 137 112 185 135 110 184 134 109 188 139 114 187 137 112 187 137 112 187 137
112 187 137 112 184 134 109 193 144 120 192 143 119 185 135 110 193 146 122 200
155 132 202 157 134 202 157 134 188 139 114 193 144 120 196 149 125 202 157 134
174 120 094 155 101 076 155 101 076 121 077 057 135 086 064 196 149 125 179 127
101 179 127 101 151 098 074 115 073 054 162 107 079 168 112 085 192 143 119 188
139 114 185 135 110 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 187 137 112 185 135 110 185 135 110 183 132 106 174 119
093 190 140 115 187 137 112 187 137 112 187 137 112 188 139 114 184 134 109 185
135 110 199 152 129 190 140 115 140 090 067 190 140 115 209 167 145 207 163 141
188 139 114 183 132 106 192 143 118 204 160 137 198 151 127 200 155 132 192 143
118 184 134 109 188 139 114 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 190 140 115 187 137 112 187 137 112 188 139 114 190 140 115 187 137 112
188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 185 135 110 185 135
110 185 135 110 187 137 112 187 137 112 185 135 110 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187 137
112 185 135 110 190 140 115 184 134 109 184 134 109 202 157 134 204 160 137 207
161 140 202 157 134 184 134 109 193 144 120 202 158 135 183 131 106 151 098 074
166 110 083 185 135 110 146 095 071 091 056 039 089 054 039 111 070 051 148 096
071 170 115 089 134 086 064 085 051 036 138 089 065 140 090 067 111 070 051 134
086 064 138 089 065 130 083 061 129 083 061 115 073 054 102 065 046 134 086 064
151 098 074 136 087 064 134 086 064 152 100 074 157 102 076 187 137 112 184 134
109 183 131 106 179 127 101 166 109 082 179 127 101 179 127 101 157 102 076 170
115 089 136 087 064 143 092 069 179 127 101 155 101 076 093 057 041 059 034 023
026 011 008 062 035 024 102 063 046 117 074 054 072 043 030 093 057 041 121 077
057 146 095 071 168 112 085 155 101 076 143 092 069 130 083 061 106 067 048 089
054 039 108 068 049 117 074 054 098 061 044 125 079 058 099 061 044 068 041 028
117 074 054 134 086 064 121 077 057 153 100 074 190 140 115 179 127 101 193 144
120 199 152 129 199 152 129 183 132 106 185 135 110 193 144 120 190 140 115 193
144 120 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185
135 110 187 137 112 187 137 112 187 137 112 185 135 110 184 134 109 184 134 109
184 134 109 185 135 110 185 135 110 185 135 110 188 139 114 184 134 109 183 131
106 188 139 114 187 137 112 183 132 106 185 135 110 188 139 114 187 137 112 190
140 115 188 139 114 185 135 110 187 137 112 190 140 115 184 134 109 183 132 106
183 131 106 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 190 140 115 188 139 114 192 143 119 198 151 127 199 152 129 200
155 132 192 143 118 188 139 114 192 143 118 183 131 106 183 131 106 185 135 110
199 152 129 207 161 140 209 166 144 209 166 144 192 143 118 185 135 110 200 155
132 200 155 132 204 160 137 202 157 134 200 154 131 193 144 120 188 139 114 187
137 112 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 188 139 114 185 135 110 185 135 110 183 131 106 198 151 127 207 161
140 192 143 119 184 134 109 187 137 112 187 137 112 188 139 114 183 132 106 184
134 109 187 137 112 192 143 119 200 155 132 193 144 120 193 146 122 185 135 110
196 149 125 192 143 119 199 152 129 202 158 135 183 131 106 184 134 109 192 143
118 190 140 115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 185 135 110 179 127 102 184 134 109 179 127 101 179
127 101 187 137 112 190 140 115 196 149 125 199 152 129 200 155 132 209 166 144
200 155 132 200 154 131 204 160 137 209 166 144 202 158 135 184 134 109 192 143
118 192 143 119 183 131 106 181 129 104 184 134 109 184 134 109 185 135 110 183
131 106 185 135 110 192 143 119 192 143 118 192 143 118 193 146 122 198 151 127
192 143 118 192 143 118 192 143 118 200 154 131 204 160 137 192 143 119 199 152
129 207 161 140 193 146 122 200 155 132 198 151 127 200 154 131 202 158 135 200
155 132 207 163 141 209 166 144 196 149 125 202 158 135 198 151 127 181 129 104
193 144 120 173 118 092 162 107 079 174 120 094 138 089 065 138 089 065 134 086
064 134 086 064 146 095 071 166 109 082 146 095 071 123 079 058 138 089 065 166
109 082 166 110 083 155 101 076 140 090 067 161 106 079 162 107 079 174 120 094
196 149 125 198 151 127 193 144 120 190 140 115 187 137 112 199 152 129 183 131
106 185 135 110 193 144 120 196 149 125 192 143 119 196 149 125 192 143 119 192
143 118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 188 139 114 185 135 110 185 135 110
185 135 110 188 139 114 190 140 115 181 129 104 183 131 106 185 135 110 179 127
102 183 131 106 184 134 109 181 129 104 183 131 106 181 129 104 183 131 106 188
139 114 188 139 114 187 137 112 187 137 112 190 140 115 190 140 115 192 143 118
192 143 119 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 193 144 120 187 137 112 188 139 114 187 137 112 183 131 106 190
140 115 192 143 119 183 131 106 184 134 109 183 132 106 184 134 109 193 144 120
185 135 110 185 135 110 188 139 114 188 139 114 193 144 120 190 140 115 185 135
110 185 135 110 193 144 120 185 135 110 181 129 104 183 132 106 183 132 106 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 188 139 114 187 137 112 187 137 112 193 144 120 190 140
115 184 134 109 190 140 115 187 137 112 187 137 112 190 140 115 185 135 110 188
139 114 190 140 115 184 134 109 183 132 106 185 135 110 184 134 109 185 135 110
183 132 106 183 132 106 187 137 112 181 129 104 188 139 114 177 124 098 179 127
101 192 143 118 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 185 135 110 192 143 119 185 135 110 183 132 106 192
143 118 183 132 106 183 131 106 192 143 118 192 143 118 184 134 109 181 129 104
185 135 110 185 135 110 190 140 115 185 135 110 190 140 115 202 158 135 200 154
131 192 143 118 198 151 127 200 155 132 198 151 127 193 146 122 199 152 129 198
151 127 198 151 127 190 140 115 193 144 120 200 154 131 193 144 120 198 151 127
193 144 120 190 140 115 183 132 106 190 140 115 183 131 106 184 134 109 192 143
118 184 134 109 183 131 106 185 135 110 184 134 109 183 132 106 183 131 106 185
135 110 183 131 106 183 131 106 184 134 109 190 140 115 193 146 122 202 157 134
202 157 134 198 151 127 200 155 132 200 155 132 207 163 141 207 163 141 207 161
140 202 158 135 198 151 127 198 151 127 200 154 131 199 152 129 200 155 132 199
152 129 198 151 127 200 155 132 200 155 132 200 154 131 200 155 132 200 154 131
202 158 135 188 139 114 187 137 112 202 157 134 183 131 106 183 131 106 192 143
119 193 144 120 192 143 118 185 135 110 190 140 115 184 134 109 190 140 115 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115
187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 198 151 127 192 143
118 187 137 112 193 144 120 192 143 119 192 143 118 192 143 118 192 143 118 187
137 112 188 139 114 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112
190 140 115 190 140 115 190 140 115 187 137 112 187 137 112 187 137 112 190 140
115 184 134 109 181 129 104 184 134 109 187 137 112 185 135 110 188 139 114 188
139 114 184 134 109 198 151 127 193 146 122 192 143 119 190 140 115 185 135 110
187 137 112 183 131 106 183 131 106 187 137 112 190 140 115 185 135 110 190 140
115 185 135 110 179 127 101 184 134 109 193 144 120 193 144 120 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 190 140 115 184 134 109 185 135 110 184 134 109 181 129
104 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 184
134 109 183 132 106 188 139 114 190 140 115 184 134 109 192 143 119 187 137 112
187 137 112 192 143 118 181 129 104 183 131 106 192 143 118 193 144 120 193 146
122 188 139 114 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 188 139 114 190 140 115 190 140 115 192 143 118 190
140 115 188 139 114 187 137 112 185 135 110 187 137 112 187 137 112 184 134 109
185 135 110 188 139 114 190 140 115 190 140 115 184 134 109 185 135 110 185 135
110 184 134 109 185 135 110 185 135 110 185 135 110 185 135 110 184 134 109 185
135 110 187 137 112 187 137 112 188 139 114 188 139 114 185 135 110 188 139 114
188 139 114 187 137 112 187 137 112 185 135 110 188 139 114 192 143 118 190 140
115 190 140 115 188 139 114 185 135 110 188 139 114 190 140 115 187 137 112 188
139 114 184 134 109 185 135 110 190 140 115 185 135 110 184 134 109 188 139 114
183 132 106 185 135 110 188 139 114 190 140 115 183 132 106 183 132 106 183 132
106 185 135 110 185 135 110 183 132 106 187 137 112 185 135 110 183 132 106 185
135 110 185 135 110 185 135 110 185 135 110 185 135 110 184 134 109 184 134 109
188 139 114 190 140 115 187 137 112 185 135 110 188 139 114 190 140 115 188 139
114 188 139 114 190 140 115 185 135 110 187 137 112 185 135 110 185 135 110 185
135 110 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 190 140 115 188 139 114 187 137 112 188 139
114 190 140 115 187 137 112 188 139 114 188 139 114 190 140 115 190 140 115 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190 140 115 185
135 110 184 134 109 187 137 112 185 135 110 185 135 110 188 139 114 183 132 106
188 139 114 190 140 115 185 135 110 185 135 110 187 137 112 188 139 114 187 137
112 184 134 109 187 137 112 187 137 112 187 137 112 187 137 112 188 139 114 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 188 139 114 188 139 114 187 137 112 188 139
114 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115 190
140 115 185 135 110 188 139 114 188 139 114 187 137 112 187 137 112 185 135 110
190 140 115 185 135 110 188 139 114 190 140 115 188 139 114 190 140 115 190 140
115 185 135 110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 185 135 110 185 135 110 187 137 112 185
135 110 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 190 140 115
188 139 114 187 137 112 185 135 110 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 187 137 112 188 139 114 187 137 112 187 137 112 188 139 114 188
139 114 187 137 112 188 139 114 187 137 112 185 135 110 190 140 115 185 135 110
185 135 110 187 137 112 188 139 114 187 137 112 187 137 112 187 137 112 185 135
110 187 137 112 187 137 112 190 140 115 187 137 112 187 137 112 188 139 114 187
137 112 190 140 115 190 140 115 187 137 112 187 137 112 188 139 114 187 137 112
187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 190 140 115 185 135 110 190 140 115 190 140 115 190
140 115 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 190 140 115
185 135 110 185 135 110 190 140 115 187 137 112 187 137 112 187 137 112 187 137
112 185 135 110 185 135 110 187 137 112 187 137 112 188 139 114 188 139 114 188
139 114 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 190 140 115 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 190 140 115 187 137 112 188 139 114 188 139 114 187 137 112 190 140 115
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 190 140 115 188 139 114 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 185 135 110 185 135
110 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137
112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187
137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 187 137 112
187 137 112 187 137 112 187 137 112 187 137 112 187 137 112 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048
033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080
048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033
080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 080 048 033 000 000
000 000 000 000 000 000 084 082 085 069 086 073 083 073 079 078 045 088 070 073
076 069 046 000 
@end
