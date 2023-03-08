local gettext = require("i_18n")
_ = gettext.translate

-- TACAN Config values here
tacan_stations = {}

-- User Modifiable channels (5 channels per map)
-- Data explanation sheet. Any value outside valid parameters will invalidate entry.
-- tacan_stations[channel_number]["mapID"]		= World map where the TACAN station is located
--												  World Map IDs
--												  1 == Caucasus
--												  2 == Nevada (Not Applicable)
--												  3 == Normandy
--												  4 == Persian Gulf
--												  5 == Syria
-- tacan_stations[channel_number]["name"]		= TACAN Station IDENT (alphanumeric)
-- tacan_stations[channel_number]["channel"]	= TACAN Station Channel (numeric 1 to 126)
-- tacan_stations[channel_number]["xy_mode"]	= TACAN Station channel mode: 0 == X, 1 == Y. 
-- tacan_stations[channel_number]["latitude"]	= TACAN Station Latitude (numeric)
-- tacan_stations[channel_number]["longitude"]	= TACAN Station Longitude (numeric)
-- tacan_stations[channel_number]["elevation"]	= TACAN Station Elevation (meters)
-- tacan_stations[channel_number]["VOR"]		= TACAN Station VOR Frequency (if station is a VORTAC)

tacan_stations[1] = {}
tacan_stations[1]["mapID"]		= 1
tacan_stations[1]["name"]		= "KBL"
tacan_stations[1]["channel"]	= 67
tacan_stations[1]["xy_mode"]	= 0
tacan_stations[1]["latitude"]	= 41.93055556
tacan_stations[1]["longitude"]	= 41.86194444
tacan_stations[1]["elevation"]	= 17.98
tacan_stations[1]["VOR"]		= 0

tacan_stations[2] = {}
tacan_stations[2]["mapID"]		= 1
tacan_stations[2]["name"]		= "BTM"
tacan_stations[2]["channel"]	= 16
tacan_stations[2]["xy_mode"]	= 0
tacan_stations[2]["latitude"]	= 41.61083333
tacan_stations[2]["longitude"]	= 41.60027778
tacan_stations[2]["elevation"]	= 10.06
tacan_stations[2]["VOR"]		= 0

tacan_stations[3] = {}
tacan_stations[3]["mapID"]		= 1
tacan_stations[3]["name"]		= "KTS"
tacan_stations[3]["channel"]	= 44
tacan_stations[3]["xy_mode"]	= 0
tacan_stations[3]["latitude"]	= 42.17833333
tacan_stations[3]["longitude"]	= 42.47916667
tacan_stations[3]["elevation"]	= 45.11
tacan_stations[3]["VOR"]		= 0

tacan_stations[4] = {}
tacan_stations[4]["mapID"]		= 1
tacan_stations[4]["name"]		= "TSK"
tacan_stations[4]["channel"]	= 31
tacan_stations[4]["xy_mode"]	= 0
tacan_stations[4]["latitude"]	= 42.24194444
tacan_stations[4]["longitude"]	= 42.04694444
tacan_stations[4]["elevation"]	= 13.11
tacan_stations[4]["VOR"]		= 0

tacan_stations[5] = {}
tacan_stations[5]["mapID"]		= 1
tacan_stations[5]["name"]		= "GTP"
tacan_stations[5]["channel"]	= 25
tacan_stations[5]["xy_mode"]	= 0
tacan_stations[5]["latitude"]	= 41.67055556
tacan_stations[5]["longitude"]	= 44.93027778
tacan_stations[5]["elevation"]	= 484.02
tacan_stations[5]["VOR"]		= 0

-- NEVADA
tacan_stations[6] = {}
tacan_stations[6]["mapID"]		= 2
tacan_stations[6]["name"]		= "LSV"
tacan_stations[6]["channel"]	= 12
tacan_stations[6]["xy_mode"]	= 0
tacan_stations[6]["latitude"]	= 36.24444444
tacan_stations[6]["longitude"]	= -115.02500000
tacan_stations[6]["elevation"]	= 656.1
tacan_stations[6]["VOR"]		= 0

tacan_stations[7] = {}
tacan_stations[7]["mapID"]		= 2
tacan_stations[7]["name"]		= "MMM"
tacan_stations[7]["channel"]	= 90
tacan_stations[7]["xy_mode"]	= 0
tacan_stations[7]["latitude"]	= 36.76916667
tacan_stations[7]["longitude"]	= -114.27750000
tacan_stations[7]["elevation"]	= 640.99
tacan_stations[7]["VOR"]		= 114.3

tacan_stations[8] = {}
tacan_stations[8]["mapID"]		= 2
tacan_stations[8]["name"]		= "ILC"
tacan_stations[8]["channel"]	= 110
tacan_stations[8]["xy_mode"]	= 0
tacan_stations[8]["latitude"]	= 38.25000000
tacan_stations[8]["longitude"]	= -114.39416667
tacan_stations[8]["elevation"]	= 2778.86
tacan_stations[8]["VOR"]		= 116.3

tacan_stations[9] = {}
tacan_stations[9]["mapID"]		= 2
tacan_stations[9]["name"]		= "BTY"
tacan_stations[9]["channel"]	= 94
tacan_stations[9]["xy_mode"]	= 0
tacan_stations[9]["latitude"]	= 36.76722222
tacan_stations[9]["longitude"]	= -116.72833333
tacan_stations[9]["elevation"]	= 860.15
tacan_stations[9]["VOR"]		= 114.7

tacan_stations[10] = {}
tacan_stations[10]["mapID"]		= 2
tacan_stations[10]["name"]		= "GFS"
tacan_stations[10]["channel"]	= 91
tacan_stations[10]["xy_mode"]	= 0
tacan_stations[10]["latitude"]	= 37.13111111
tacan_stations[10]["longitude"]	= -115.17638889
tacan_stations[10]["elevation"]	= 1224.99
tacan_stations[10]["VOR"]		= 114.4

-- PERSIAN GULF
tacan_stations[11] = {}
tacan_stations[11]["mapID"]		= 4
tacan_stations[11]["name"]		= "MA"
tacan_stations[11]["channel"]	= 96
tacan_stations[11]["xy_mode"]	= 0
tacan_stations[11]["latitude"]	= 24.24666667
tacan_stations[11]["longitude"]	= 54.54527778
tacan_stations[11]["elevation"]	= 15.85
tacan_stations[11]["VOR"]		= 114.9

tacan_stations[12] = {}
tacan_stations[12]["mapID"]		= 4
tacan_stations[12]["name"]		= "MIN"
tacan_stations[12]["channel"]	= 99
tacan_stations[12]["xy_mode"]	= 0
tacan_stations[12]["latitude"]	= 25.02694444
tacan_stations[12]["longitude"]	= 55.39527778
tacan_stations[12]["elevation"]	= 57.0
tacan_stations[12]["VOR"]		= 0

tacan_stations[13] = {}
tacan_stations[13]["mapID"]		= 4
tacan_stations[13]["name"]		= "KSB"
tacan_stations[13]["channel"]	= 84
tacan_stations[13]["xy_mode"]	= 0
tacan_stations[13]["latitude"]	= 26.17777778
tacan_stations[13]["longitude"]	= 56.24083333
tacan_stations[13]["elevation"]	= 15.85
tacan_stations[13]["VOR"]		= 0

tacan_stations[14] = {}
tacan_stations[14]["mapID"]		= 4
tacan_stations[14]["name"]		= "BND"
tacan_stations[14]["channel"]	= 78
tacan_stations[14]["xy_mode"]	= 0
tacan_stations[14]["latitude"]	= 27.21694444
tacan_stations[14]["longitude"]	= 56.38083333
tacan_stations[14]["elevation"]	= 4.88
tacan_stations[14]["VOR"]		= 0

tacan_stations[15] = {}
tacan_stations[15]["mapID"]		= 4
tacan_stations[15]["name"]		= "SYZ1"
tacan_stations[15]["channel"]	= 94
tacan_stations[15]["xy_mode"]	= 0
tacan_stations[15]["latitude"]	= 29.54166667
tacan_stations[15]["longitude"]	= 52.58444444
tacan_stations[15]["elevation"]	= 1487.12
tacan_stations[15]["VOR"]		= 0


need_to_be_closed = true