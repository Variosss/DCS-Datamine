local gettext = require("i_18n")
_ = gettext.translate


awls_channels = {}

-- User Modifiable channels (20 channels max)
-- Data explanation sheet. Any value outside valid parameters will invalidate entry.
-- awls_channels[channel_number]["mapID"] 		= World map where the ILS station is located
--												  World Map IDs
--												  1 == Caucasus
--												  2 == Nevada
--												  3 == Normandy		(Not Applicable)
--												  4 == Persian Gulf
--												  5 == The Channel	(Not Applicable)
--												  6 == Syria
--												  7 == Mariannas
--												  8 == South Atlantic
-- awls_channels[channel_number]["name"]		= Airport name (alphanumeric)
-- awls_channels[channel_number]["runway"]		= Runway number (alhpanumeric)
-- awls_channels[channel_number]["ils_freq"]	= ILS frequency in Mhz. Range 108.0 - 112.0 Mhz
-- awls_channels[channel_number]["tacan_ch"]	= Airport TACAN channel (if exists). 0 if the airport does not have a TACAN
-- awls_channels[channel_number]["tacan_xymod"]	= Airport TACAN channel mode: 0 == X, 1 == Y. 
-- awls_channels[channel_number]["ils_gs"]		= ILS glideslope in degrees. Valid values 2.0 to 6.0 in 0.1 increments
-- awls_channels[channel_number]["ils_az_os"]	= ILS Azimuth offset from RWY. Value is in feet (integer). Range: +/- 310 feet in 1 feet increment
-- awls_channels[channel_number]["ils_el_os"]	= ILS Elevation offset from RWY. Valie is in feet (integer). Range +/1 31 feet in 1 feet increment

--[[ MapID = 1 :: Caucasus ]]--
local table_idx = 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "KOBULETI"
awls_channels[table_idx]["runway"]			= "07"
awls_channels[table_idx]["ils_freq"]		= 111.50
awls_channels[table_idx]["tacan_ch"]		= 67
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "VAZIANI"
awls_channels[table_idx]["runway"]			= "13-31"
awls_channels[table_idx]["ils_freq"]		= 108.75
awls_channels[table_idx]["tacan_ch"]		= 22
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "KUTAISI"
awls_channels[table_idx]["runway"]			= "08"
awls_channels[table_idx]["ils_freq"]		= 109.75
awls_channels[table_idx]["tacan_ch"]		= 44
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "SENAKI-KHOLKI"
awls_channels[table_idx]["runway"]			= "09"
awls_channels[table_idx]["ils_freq"]		= 108.90
awls_channels[table_idx]["tacan_ch"]		= 31
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "BATUMI"
awls_channels[table_idx]["runway"]			= "13"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 16
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "TIBLISI-LOCHINI"
awls_channels[table_idx]["runway"]			= "13R"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "TIBLISI-LOCHINI"
awls_channels[table_idx]["runway"]			= "31L"
awls_channels[table_idx]["ils_freq"]		= 108.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "MINERALNYE-VODY"
awls_channels[table_idx]["runway"]			= "12"
awls_channels[table_idx]["ils_freq"]		= 111.70
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "MINERALNYE-VODY"
awls_channels[table_idx]["runway"]			= "30"
awls_channels[table_idx]["ils_freq"]		= 109.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "MALCHIK"
awls_channels[table_idx]["runway"]			= "24"
awls_channels[table_idx]["ils_freq"]		= 110.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "BESLAN"
awls_channels[table_idx]["runway"]			= "10"
awls_channels[table_idx]["ils_freq"]		= 110.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 1
awls_channels[table_idx]["name"]			= "SOCHI-ADLER"
awls_channels[table_idx]["runway"]			= "06"
awls_channels[table_idx]["ils_freq"]		= 111.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

--[[ MapID = 2 :: Nevada Testing Range ]]--
table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "NELLIS AFB"
awls_channels[table_idx]["runway"]			= "21"
awls_channels[table_idx]["ils_freq"]		= 109.10
awls_channels[table_idx]["tacan_ch"]		= 12
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "CREECH AFB"
awls_channels[table_idx]["runway"]			= "08"
awls_channels[table_idx]["ils_freq"]		= 108.70
awls_channels[table_idx]["tacan_ch"]		= 87
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "CREECH AFB"
awls_channels[table_idx]["runway"]			= "13"
awls_channels[table_idx]["ils_freq"]		= 108.50
awls_channels[table_idx]["tacan_ch"]		= 87
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "GROOM LAKE AFB"
awls_channels[table_idx]["runway"]			= "32"
awls_channels[table_idx]["ils_freq"]		= 109.30
awls_channels[table_idx]["tacan_ch"]		= 18
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "TONOPAH TR AIRFIELD"
awls_channels[table_idx]["runway"]			= "32"
awls_channels[table_idx]["ils_freq"]		= 111.70
awls_channels[table_idx]["tacan_ch"]		= 77
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "TONOPAH TR AIRFIELD"
awls_channels[table_idx]["runway"]			= "14"
awls_channels[table_idx]["ils_freq"]		= 108.30
awls_channels[table_idx]["tacan_ch"]		= 77
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"]			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "MCCARRAN INTL"
awls_channels[table_idx]["runway"]			= "25R"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 116
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "MCCARRAN INTL"
awls_channels[table_idx]["runway"]			= "25R"
awls_channels[table_idx]["ils_freq"]		= 111.75
awls_channels[table_idx]["tacan_ch"]		= 116
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 2
awls_channels[table_idx]["name"]			= "NORTH LAS VEGAS"
awls_channels[table_idx]["runway"]			= "12L"
awls_channels[table_idx]["ils_freq"]		= 110.70
awls_channels[table_idx]["tacan_ch"]		= 116
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

--[[ MapID = 3 :: Normandy (WWII) ]]--
-- NO RADIO NAVAIDS

--[[ MapID = 4 :: Persian Gulf ]]--
table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "AL MAKTOUM INTL"
awls_channels[table_idx]["runway"]			= "12"
awls_channels[table_idx]["ils_freq"]		= 111.75
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "AL MAKTOUM INTL"
awls_channels[table_idx]["runway"]			= "30"
awls_channels[table_idx]["ils_freq"]		= 109.75
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "AL MINHAD AB"
awls_channels[table_idx]["runway"]			= "09"
awls_channels[table_idx]["ils_freq"]		= 110.70
awls_channels[table_idx]["tacan_ch"]		= 99
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "AL MINHAD AB"
awls_channels[table_idx]["runway"]			= "27"
awls_channels[table_idx]["ils_freq"]		= 110.75
awls_channels[table_idx]["tacan_ch"]		= 99
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "DUBAI INTL"
awls_channels[table_idx]["runway"]			= "12L"
awls_channels[table_idx]["ils_freq"]		= 110.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "DUBAI INTL"
awls_channels[table_idx]["runway"]			= "12R"
awls_channels[table_idx]["ils_freq"]		= 109.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "DUBAI INTL"
awls_channels[table_idx]["runway"]			= "30R"
awls_channels[table_idx]["ils_freq"]		= 110.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "DUBAI INTL"
awls_channels[table_idx]["runway"]			= "30L"
awls_channels[table_idx]["ils_freq"]		= 111.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "SHARJAH INTL"
awls_channels[table_idx]["runway"]			= "12L"
awls_channels[table_idx]["ils_freq"]		= 108.55
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "SHARJAH INTL"
awls_channels[table_idx]["runway"]			= "30R"
awls_channels[table_idx]["ils_freq"]		= 111.95
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "SHARJAH INTL"
awls_channels[table_idx]["runway"]			= "29"
awls_channels[table_idx]["ils_freq"]		= 111.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "KHASAB"
awls_channels[table_idx]["runway"]			= "19"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 84
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "BANDAR ABBAS INTL"
awls_channels[table_idx]["runway"]			= "19"
awls_channels[table_idx]["ils_freq"]		= 338.80
awls_channels[table_idx]["tacan_ch"]		= 78
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "LAR AB"
awls_channels[table_idx]["runway"]			= "09"
awls_channels[table_idx]["ils_freq"]		= 111.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "LAR AB"
awls_channels[table_idx]["runway"]			= "19"
awls_channels[table_idx]["ils_freq"]		= 111.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 4
awls_channels[table_idx]["name"]			= "SHIRAZ INTL"
awls_channels[table_idx]["runway"]			= "29L"
awls_channels[table_idx]["ils_freq"]		= 109.90
awls_channels[table_idx]["tacan_ch"]		= 94
awls_channels[table_idx]["tacan_xymod"]	= 0
awls_channels[table_idx]["ils_gs"] 		= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

--[[ MapID = 5 :: The Channel (WWII) ]]--
-- NO RADIO NAVAIDS

--[[ MapID = 6 :: Syria ]]--
table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "RAMAT DAVID AB"
awls_channels[table_idx]["runway"]			= "33"
awls_channels[table_idx]["ils_freq"]		= 110.10
awls_channels[table_idx]["tacan_ch"]		= 84
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "DAMASCUS"
awls_channels[table_idx]["runway"]			= "05R"
awls_channels[table_idx]["ils_freq"]		= 110.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "DAMASCUS"
awls_channels[table_idx]["runway"]			= "23R"
awls_channels[table_idx]["ils_freq"]		= 109.9
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "BEIRUT-RAFIC"
awls_channels[table_idx]["runway"]			= "03"
awls_channels[table_idx]["ils_freq"]		= 110.70
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "BEIRUT-RAFIC"
awls_channels[table_idx]["runway"]			= "16"
awls_channels[table_idx]["ils_freq"]		= 110.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "BEIRUT-RAFIC"
awls_channels[table_idx]["runway"]			= "17"
awls_channels[table_idx]["ils_freq"]		= 109.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "BASSEL AL-ASSAD"
awls_channels[table_idx]["runway"]			= "17R"
awls_channels[table_idx]["ils_freq"]		= 109.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "HATAY"
awls_channels[table_idx]["runway"]			= "04"
awls_channels[table_idx]["ils_freq"]		= 108.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "GAZIANTEP"
awls_channels[table_idx]["runway"]			= "28"
awls_channels[table_idx]["ils_freq"]		= 109.10
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "INCIRLIK"
awls_channels[table_idx]["runway"]			= "23"
awls_channels[table_idx]["ils_freq"]		= 111.70
awls_channels[table_idx]["tacan_ch"]		= 21
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "INCIRLIK"
awls_channels[table_idx]["runway"]			= "05"
awls_channels[table_idx]["ils_freq"]		= 109.30
awls_channels[table_idx]["tacan_ch"]		= 21
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "ADANA SAKIRPASA"
awls_channels[table_idx]["runway"]			= "05"
awls_channels[table_idx]["ils_freq"]		= 108.70
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "GAZIPASA"
awls_channels[table_idx]["runway"]			= "08"
awls_channels[table_idx]["ils_freq"]		= 108.50
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "PAPHOS"
awls_channels[table_idx]["runway"]			= "29"
awls_channels[table_idx]["ils_freq"]		= 108.90
awls_channels[table_idx]["tacan_ch"]		= 79
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "AKROTIRI"
awls_channels[table_idx]["runway"]			= "28"
awls_channels[table_idx]["ils_freq"]		= 109.70
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "LARNACA"
awls_channels[table_idx]["runway"]			= "22"
awls_channels[table_idx]["ils_freq"]		= 110.80
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 6
awls_channels[table_idx]["name"]			= "ERCAN"
awls_channels[table_idx]["runway"]			= "29"
awls_channels[table_idx]["ils_freq"]		= 108.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

--[[ MapID = 7 :: Marianna Islands ]]--
table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "SAIPAN INTL"
awls_channels[table_idx]["runway"]			= "7"
awls_channels[table_idx]["ils_freq"]		= 109.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANTONIO INTL"
awls_channels[table_idx]["runway"]			= "6L"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANTONIO INTL"
awls_channels[table_idx]["runway"]			= "6R"
awls_channels[table_idx]["ils_freq"]		= 110.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANDERSEN AFB"
awls_channels[table_idx]["runway"]			= "06L"
awls_channels[table_idx]["ils_freq"]		= 109.30
awls_channels[table_idx]["tacan_ch"]		= 54
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANDERSEN AFB"
awls_channels[table_idx]["runway"]			= "06R"
awls_channels[table_idx]["ils_freq"]		= 110.10
awls_channels[table_idx]["tacan_ch"]		= 54
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANDERSEN AFB"
awls_channels[table_idx]["runway"]			= "24L"
awls_channels[table_idx]["ils_freq"]		= 109.35
awls_channels[table_idx]["tacan_ch"]		= 54
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 7
awls_channels[table_idx]["name"]			= "ANDERSEN AFB"
awls_channels[table_idx]["runway"]			= "24R"
awls_channels[table_idx]["ils_freq"]		= 110.15
awls_channels[table_idx]["tacan_ch"]		= 54
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

--[[ MapID = 8 :: South Atlantic ]]--
table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 8
awls_channels[table_idx]["name"]			= "MOUNT PLEASANT"
awls_channels[table_idx]["runway"]			= "28"
awls_channels[table_idx]["ils_freq"]		= 110.90
awls_channels[table_idx]["tacan_ch"]		= 59
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 8
awls_channels[table_idx]["name"]			= "RIO GALLEGOS"
awls_channels[table_idx]["runway"]			= "25"
awls_channels[table_idx]["ils_freq"]		= 110.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 8
awls_channels[table_idx]["name"]			= "RIO GRANDE"
awls_channels[table_idx]["runway"]			= "26"
awls_channels[table_idx]["ils_freq"]		= 109.50
awls_channels[table_idx]["tacan_ch"]		= 31
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 8
awls_channels[table_idx]["name"]			= "USHUAIA"
awls_channels[table_idx]["runway"]			= "25"
awls_channels[table_idx]["ils_freq"]		= 111.30
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

table_idx = table_idx + 1
awls_channels[table_idx] = {}
awls_channels[table_idx]["mapID"]			= 8
awls_channels[table_idx]["name"]			= "PUNTA ARENAS"
awls_channels[table_idx]["runway"]			= "25"
awls_channels[table_idx]["ils_freq"]		= 109.90
awls_channels[table_idx]["tacan_ch"]		= 0
awls_channels[table_idx]["tacan_xymod"]		= 0
awls_channels[table_idx]["ils_gs"] 			= 3.0
awls_channels[table_idx]["ils_az_os"]		= 0
awls_channels[table_idx]["ils_el_os"]		= 0

need_to_be_closed = true