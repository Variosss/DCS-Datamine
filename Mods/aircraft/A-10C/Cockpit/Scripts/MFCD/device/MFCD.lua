---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   DEBUG DEFINITIONS  -------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
is_debug = false
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----   END OF DEBUG DEFINITIONS  --------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

package.path = package.path..";./Scripts/?.lua"

local S				= require("Serializer")

default_db			= LockOn_Options.script_path.."MFCD/Database/DataBase.lua"

function get_file_name(loader)
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	local					  name     = db_path
	if campaign ~= "" then    name     = name .. campaign .. "/" end
	if mission  ~= "" then	  name     = name .. mission .. MFCD_DB_name_suffix end
	return 					  name
end

-- Old db format (DTS project)
function ReadButtonsString(str)
	local temp
	local index = 15
	str, temp	= GetStringField(str)
	str, temp	= GetStringField(str)
	for i = 0, 3 do
		if nil ~= string.find(temp, "None", 1, true) then
			temp = ""
		end
		DPP_OSB_labels[index] = TrimStringLeft(TrimStringRight(temp))
		index = index-1
		str, temp	= GetStringField(str)
	end
end

-- Old db format (DTS project)
function ReadButtons(f)
	local str
	str=f:read()
	while nil ~= str do
		if nil ~= string.find(str, MFCD_NAME, 1, true) then
			ReadButtonsString(str)
		end
		str=f:read()
	end
end

if is_debug then
	MFCD_NAME	= "Right MFCD"
end

-- mode enums

MFCD_NONE			 = 0
MFCD_DTS_UPLOAD 	 = 1
MFCD_DISPLAY_PROGRAM = 2
MFCD_STAT 			 = 3
MFCD_MAV 			 = 4
MFCD_DSMS 			 = 5
MFCD_TGP 			 = 6
MFCD_TAD 			 = 7
MFCD_MSG 			 = 8

MFCD_TEST_CICU		 = 11
MFCD_TEST_DISP  	 = 12
MFCD_TEST_KEYS		 = 13
MFCD_TEST_HOTAS 	 = 14

MFCD_CICU_INITIALIZE = 15

--submodes TGP
MFCD_TGP_STBY = 1
MFCD_TGP_AA	  = 2
MFCD_TGP_AG   = 3
--submodes TGP STBY
MFCD_TGP_STBY_INIT	  = 1
MFCD_TGP_STBY_BIT	  = 2
MFCD_TGP_STBY_CONTROL = 3
--submodes TGP AG
MFCD_TGP_AG_CONTROL = 1
--submodes TGP AA
MFCD_TGP_AA_CONTROL = 1
--submodes STAT
MFCD_STAT_PAGE1 = 0
MFCD_STAT_PAGE2 = 1

-- submodes MSG
MFCD_MSG_NO_PAGE   = 0
MFCD_MSG_TEXT_PAGE = 1
MFCD_MSG_CAS_PAGE  = 2
MFCD_MSG_MA_PAGE   = 3

-- CDU pages
-- mode enums
-- level 1
CDU_MASTER				= 10

-- level 2
CDU_OFF					= 0
CDU_STARTUP_BIT 		= 1
CDU_POSINFO				= 2
CDU_STRINFO				= 3
CDU_WPINFO				= 4
CDU_SYS					= 5
CDU_NAV					= 6
CDU_WPMENU				= 7
CDU_OFFSET				= 8
CDU_FPMENU				= 9

-- level 3
CDU_SYS1				= 1
CDU_SYS2				= 2
CDU_EGI					= 3
CDU_INS					= 4
CDU_DTSAS				= 5
CDU_LASTE				= 6
CDU_REINIT				= 7
CDU_GPS					= 8
CDU_DTS					= 9
CDU_RESET				= 10
CDU_DIVERT				= 11
CDU_WAYPT1				= 12
CDU_WAYPT2				= 13
CDU_ANCHOR				= 14
CDU_FPBUILD				= 15
CDU_OFPID1				= 16
CDU_OFPID2				= 17
CDU_CADC				= 18
CDU_HARS				= 19
CDU_MXLOG				= 20
CDU_CDUTEST1			= 21
CDU_CDUTEST2			= 22
CDU_LRUTEST				= 23
CDU_ATTRIB				= 24
CDU_OPTIONS				= 25
CDU_FROM				= 26

-- level 4
CDU_POS					= 1
CDU_ALIGN				= 2
CDU_WIND1				= 3
CDU_WIND2				= 4
CDU_TIME				= 5
CDU_WNDEDIT1			= 6
CDU_WNDEDIT2			= 7
CDU_WPTATT				= 8
CDU_BBCTL				= 9
CDU_BITBALL				= 10
CDU_EGITEST				= 11
CDU_DTSSTAT				= 12
CDU_DTSDNLD				= 13
CDU_DTSUPLD				= 14
CDU_GPSSTAT1			= 15
CDU_GPSSTAT2			= 16
CDU_GPSBIT1				= 17
CDU_GPSBIT2				= 18
CDU_GPSBIT3				= 19
CDU_GPSBIT4				= 20
CDU_GPSBIT5				= 21
CDU_GPSKEYS				= 22
CDU_ALTALGN				= 23
CDU_INSSTAT				= 24
CDU_UPDATE				= 25
CDU_FLDINFO				= 26

page_names = {}
function set_page_name (mode,name)
	
	local L1 = mode[1] or 0
	local L2 = mode[2] or 0
	local L3 = mode[3] or 0
	local L4 = mode[4] or 0
	
	if page_names[L1] == nil then
	   page_names[L1] =  {}
	end
	if page_names[L1][L2] == nil then
	   page_names[L1][L2] =  {}
	end
	if page_names[L1][L2][L3] == nil then
	   page_names[L1][L2][L3] =  {}
	end
	page_names[L1][L2][L3][L4] = name
	
end



brightness_day = 
{
	TAD   = {SYM = 63, BRT = 35, CON = 32},
	TGP   = {SYM = 63, BRT = 32, CON = 32},
	MAV   = {SYM = 63, BRT = 32, CON = 32},
	other = {SYM = 63, BRT = 32, CON = 32},
}

brightness_night = 
{
	TAD   = {SYM = 30, BRT = 20, CON = 30},
	TGP   = {SYM = 30, BRT = 10, CON = 31},
	MAV   = {SYM = 30, BRT = 10, CON = 25},
	other = {SYM = 30, BRT = 25, CON = 25},
}

set_page_name({}							,"NONE")
set_page_name({MFCD_DTS_UPLOAD}				,"DTS_UPLOAD")
set_page_name({MFCD_DISPLAY_PROGRAM}		,"DISPLAY_PROGRAM")
set_page_name({MFCD_MAV}					,"MAV")
set_page_name({MFCD_DSMS}					,"DSMS")
set_page_name({MFCD_DSMS,1}					,"DSMS_PROFILE_LIST")
set_page_name({MFCD_DSMS,2,0}   			,"DSMS_VIEW_PROFILE")
set_page_name({MFCD_DSMS,3,0}   			,"DSMS_PROFILE_SETTINGS")
set_page_name({MFCD_DSMS,4,0}   			,"DSMS_INVENTORY")
set_page_name({MFCD_DSMS,4,1}   			,"DSMS_INVENTORY_SELECT")
set_page_name({MFCD_DSMS,4,2}   			,"DSMS_INVENTORY_BOMB")
set_page_name({MFCD_DSMS,4,3}   			,"DSMS_INVENTORY_CBU")
set_page_name({MFCD_DSMS,4,4}   			,"DSMS_INVENTORY_GBU")
set_page_name({MFCD_DSMS,4,5}   			,"DSMS_INVENTORY_RACK")
set_page_name({MFCD_DSMS,4,6}   			,"DSMS_INVENTORY_AIR")
set_page_name({MFCD_DSMS,4,7}   			,"DSMS_INVENTORY_POD")
set_page_name({MFCD_DSMS,4,8}   			,"DSMS_INVENTORY_MAVERICK")
set_page_name({MFCD_DSMS,4,9}   			,"DSMS_INVENTORY_MISC")
set_page_name({MFCD_DSMS,4,10}  			,"DSMS_INVENTORY_BDU33")
set_page_name({MFCD_DSMS,4,11}  			,"DSMS_INVENTORY_ROCKET")
set_page_name({MFCD_DSMS,4,12}  			,"DSMS_INVENTORY_MK84")
set_page_name({MFCD_DSMS,4,13}  			,"DSMS_INVENTORY_MK82")
set_page_name({MFCD_DSMS,4,14}  			,"DSMS_INVENTORY_GBU10")
set_page_name({MFCD_DSMS,4,15}  			,"DSMS_INVENTORY_GBU12")
set_page_name({MFCD_DSMS,4,16}  			,"DSMS_INVENTORY_GBU31")
set_page_name({MFCD_DSMS,4,17}  			,"DSMS_INVENTORY_GBU38")
set_page_name({MFCD_DSMS,4,18}  			,"DSMS_INVENTORY_CBU87")
set_page_name({MFCD_DSMS,4,19}  			,"DSMS_INVENTORY_CBU89")
set_page_name({MFCD_DSMS,4,20}  			,"DSMS_INVENTORY_CBU97")
set_page_name({MFCD_DSMS,4,21}  			,"DSMS_INVENTORY_BDU56")
set_page_name({MFCD_DSMS,4,22}  			,"DSMS_INVENTORY_BDU50")
set_page_name({MFCD_DSMS,4,23}  			,"DSMS_INVENTORY_MK82A")
set_page_name({MFCD_DSMS,4,24}  			,"DSMS_INVENTORY_FLARE")
set_page_name({MFCD_DSMS,4,25}  			,"DSMS_INVENTORY_CBU103")
set_page_name({MFCD_DSMS,4,26}  			,"DSMS_INVENTORY_CBU104")
set_page_name({MFCD_DSMS,4,27}  			,"DSMS_INVENTORY_CBU105")
set_page_name({MFCD_DSMS,5}     			,"DSMS_MISSILE_CONTROL")
set_page_name({MFCD_DSMS,6}     			,"DSMS_SELECTIVE_JETTISON")
set_page_name({MFCD_TAD}					,"TAD")
set_page_name({MFCD_TAD,1}					,"TAD_PROFILE_PROGRAM")
set_page_name({MFCD_TAD,2}					,"TAD_CONTROL")
set_page_name({MFCD_TAD,2,1}				,"TAD_CONTROL_SETTINGS")
set_page_name({MFCD_TAD,3}					,"TAD_MA_TABLE")
set_page_name({MFCD_TAD,4}					,"TAD_TDL")
set_page_name({MFCD_TAD,5}					,"TAD_SADL")

set_page_name({MFCD_TGP}										,"TGP")
set_page_name({MFCD_TGP,MFCD_TGP_STBY}							,"TGP_STBY")
set_page_name({MFCD_TGP,MFCD_TGP_STBY,MFCD_TGP_STBY_INIT}		,"TGP_STBYINIT")
set_page_name({MFCD_TGP,MFCD_TGP_STBY,MFCD_TGP_STBY_BIT}		,"TGP_STBYBIT")
set_page_name({MFCD_TGP,MFCD_TGP_STBY,MFCD_TGP_STBY_CONTROL}	,"TGP_STBY_CONTROL")
set_page_name({MFCD_TGP,MFCD_TGP_AA}							,"TGP_AA")
set_page_name({MFCD_TGP,MFCD_TGP_AA,MFCD_TGP_AA_CONTROL}		,"TGP_AA_CONTROL")
set_page_name({MFCD_TGP,MFCD_TGP_AG}							,"TGP_AG")
set_page_name({MFCD_TGP,MFCD_TGP_AG,MFCD_TGP_AG_CONTROL}		,"TGP_AG_CONTROL")
set_page_name({MFCD_STAT,MFCD_STAT_PAGE1}						,"STAT_PAGE1")
set_page_name({MFCD_STAT,MFCD_STAT_PAGE2}						,"STAT_PAGE2")

set_page_name({MFCD_TEST_CICU}			,"MFCD_TEST_CICU")
set_page_name({MFCD_TEST_DISP}			,"MFCD_TEST_DISP")
set_page_name({MFCD_TEST_KEYS}			,"MFCD_TEST_KEYS")
set_page_name({MFCD_TEST_HOTAS}			,"MFCD_TEST_HOTAS")

set_page_name({MFCD_MSG,MFCD_MSG_TEXT_PAGE}						,"MSG_TEXT")
set_page_name({MFCD_MSG,MFCD_MSG_CAS_PAGE}						,"MSG_CAS")
set_page_name({MFCD_MSG,MFCD_MSG_MA_PAGE}						,"MSG_MA")

set_page_name({CDU_MASTER,CDU_OFF}								,"CDU_OFF")
set_page_name({CDU_MASTER,CDU_STARTUP_BIT}						,"CDU_STARTUP_BIT")
set_page_name({CDU_MASTER,CDU_POSINFO}							,"CDU_POSINFO")
set_page_name({CDU_MASTER,CDU_STRINFO}							,"CDU_STRINFO")
set_page_name({CDU_MASTER,CDU_WPINFO}							,"CDU_WPINFO")
set_page_name({CDU_MASTER,CDU_SYS,CDU_SYS1}						,"CDU_SYS1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_SYS2}						,"CDU_SYS2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_EGI}						,"CDU_EGI")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS}						,"CDU_INS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS,CDU_POS}				,"CDU_POS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS,CDU_ALIGN}			,"CDU_ALIGN")
set_page_name({CDU_MASTER,CDU_SYS,CDU_DTSAS}					,"CDU_DTSAS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LASTE}					,"CDU_LASTE")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LASTE,CDU_WIND1}			,"CDU_WIND1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LASTE,CDU_WIND2}			,"CDU_WIND2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LASTE,CDU_WNDEDIT1}		,"CDU_WNDEDIT1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LASTE,CDU_WNDEDIT2}		,"CDU_WNDEDIT2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_REINIT}					,"CDU_REINIT")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS}						,"CDU_GPS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_TIME}				,"CDU_TIME")
set_page_name({CDU_MASTER,CDU_SYS,CDU_DTS}						,"CDU_DTS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_RESET}					,"CDU_RESET")
set_page_name({CDU_MASTER,CDU_NAV}								,"CDU_NAV")
set_page_name({CDU_MASTER,CDU_NAV,CDU_DIVERT}					,"CDU_DIVERT")
set_page_name({CDU_MASTER,CDU_WPMENU}							,"CDU_WPMENU")
set_page_name({CDU_MASTER,CDU_WPMENU,CDU_WAYPT1}				,"CDU_WAYPT1")
set_page_name({CDU_MASTER,CDU_WPMENU,CDU_WAYPT2}				,"CDU_WAYPT2")
set_page_name({CDU_MASTER,CDU_WPMENU,CDU_ANCHOR}				,"CDU_ANCHOR")
set_page_name({CDU_MASTER,CDU_OFFSET}							,"CDU_OFFSET")
set_page_name({CDU_MASTER,CDU_FPMENU}							,"CDU_FPMENU")
set_page_name({CDU_MASTER,CDU_FPMENU,CDU_FPBUILD}				,"CDU_FPBUILD")
set_page_name({CDU_MASTER,CDU_FPMENU,CDU_FPBUILD,CDU_WPTATT}	,"CDU_WPTATT")
set_page_name({CDU_MASTER,CDU_SYS,CDU_OFPID1}					,"CDU_OFPID1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_OFPID2}					,"CDU_OFPID2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_CADC}						,"CDU_CADC")
set_page_name({CDU_MASTER,CDU_SYS,CDU_HARS}						,"CDU_HARS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_MXLOG}					,"CDU_MXLOG")
set_page_name({CDU_MASTER,CDU_SYS,CDU_CDUTEST1}					,"CDU_CDUTEST1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_CDUTEST2}					,"CDU_CDUTEST2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LRUTEST}					,"CDU_LRUTEST")
set_page_name({CDU_MASTER,CDU_SYS,CDU_CDUTEST1,CDU_BBCTL}		,"CDU_BBCTL")
set_page_name({CDU_MASTER,CDU_SYS,CDU_CDUTEST1,CDU_BITBALL}		,"CDU_BITBALL")
set_page_name({CDU_MASTER,CDU_SYS,CDU_LRUTEST,CDU_EGITEST}		,"CDU_EGITEST")
set_page_name({CDU_MASTER,CDU_SYS,CDU_DTS,CDU_DTSSTAT}			,"CDU_DTSSTAT")
set_page_name({CDU_MASTER,CDU_SYS,CDU_DTS,CDU_DTSDNLD}			,"CDU_DTSDNLD")
set_page_name({CDU_MASTER,CDU_SYS,CDU_DTS,CDU_DTSUPLD}			,"CDU_DTSUPLD")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSSTAT1}			,"CDU_GPSSTAT1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSSTAT2}			,"CDU_GPSSTAT2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSBIT1}			,"CDU_GPSBIT1")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSBIT2}			,"CDU_GPSBIT2")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSBIT3}			,"CDU_GPSBIT3")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSBIT4}			,"CDU_GPSBIT4")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSBIT5}			,"CDU_GPSBIT5")
set_page_name({CDU_MASTER,CDU_SYS,CDU_GPS,CDU_GPSKEYS}			,"CDU_GPSKEYS")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS,CDU_ALTALGN}			,"CDU_ALTALGN")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS,CDU_INSSTAT}			,"CDU_INSSTAT")
set_page_name({CDU_MASTER,CDU_SYS,CDU_INS,CDU_UPDATE}			,"CDU_UPDATE")
set_page_name({CDU_MASTER,CDU_NAV,CDU_ATTRIB}					,"CDU_ATTRIB")
set_page_name({CDU_MASTER,CDU_NAV,CDU_OPTIONS}					,"CDU_OPTIONS")
set_page_name({CDU_MASTER,CDU_NAV,CDU_DIVERT,CDU_FLDINFO}		,"CDU_FLDINFO")
set_page_name({CDU_MASTER,CDU_WPMENU,CDU_FROM}					,"CDU_FROM")

-- SETTINGS_PATH is left for compatibility with old missions
if MFCD_NAME == "Left MFCD" then
	SETTINGS_PATH = "MFCD/settings_left.lua"
else
	SETTINGS_PATH = "MFCD/settings_right.lua"
end
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
LoadSettings()
