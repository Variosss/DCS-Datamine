dofile(LockOn_Options.common_script_path.."devices_defs.lua")

local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 1.0

startup_bit_test_coeff = 1.0

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
CDU_EGI1				= 3
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
CDU_EGI2				= 27
CDU_EGI3				= 28
CDU_EGI4				= 29

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
CDU_ACCREJ				= 27

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
SETTINGS_PATH  = "CDU/SETTINGS.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")

CDU_FAILURE_TOTAL	= 0

Damage = {	{Failure = CDU_FAILURE_TOTAL, Failure_name = "CDU_FAILURE_TOTAL", Failure_editor_name = _("CDU total failure"),  Element = 5, Integrity_Treshold = 0.05, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*350},
}
