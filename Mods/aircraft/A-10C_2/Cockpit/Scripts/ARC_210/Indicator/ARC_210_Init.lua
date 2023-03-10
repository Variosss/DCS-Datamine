dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")

indicator_type 	 = indicator_types.COMMON

opacity_sensitive_materials = 
{
	"font_ARC210_small",
	"font_ARC210_big"
}

-- mode enums
ARC_210_NONE				= 0
ARC_210_POWER_ON			= 1
ARC_210_TEST				= 2
ARC_210_TR					= 3
ARC_210_CHG_PRST			= 4
ARC_210_GUARD				= 5
ARC_210_MARITIME			= 6
ARC_210_MENU				= 7
ARC_210_GPS_TIME			= 8
ARC_210_ECCM				= 9
ARC_210_ZEROIZE				= 10

--TEST submodes
ARC_210_TEST_START			= 0
ARC_210_TEST_PROGRES		= 1

--TR submodes
ARC_210_TR_PRSET			= 0
ARC_210_TR_MAN				= 1
ARC_210_TR_PRSET_SATCOM		= 2

--CHG_PRSET submodes
ARC_210_CHG_PRST_PRST		= 0

--GUARD submodes
ARC_210_GUARD_121			= 0
ARC_210_GUARD_243			= 1

--MENU submodes
ARC_210_MENU_ROOT			= 0
ARC_210_MENU_RADIO_ID_NUMBERS	= 1
ARC_210_MENU_PRESET_CH_26_30	= 2
ARC_210_MENU_DAMA_CHANNELS	= 3
ARC_210_MENU_BEEP_ENABLE	= 4
ARC_210_MENU_USER_DATA_PORT	= 5
ARC_210_MENU_SWITCH_TEST	= 6
ARC_210_MENU_ENTER_KEY_ENABLE	= 7
ARC_210_MENU_EMCON			= 8
ARC_210_HQ_MENU_OPER_DATE	= 9
ARC_210_HQ_MENU_VERIFY_WOD	= 10
ARC_210_HQ_MENU_WOD_LOAD	= 11
ARC_210_HQ_MENU_WOD_ERASE	= 12
ARC_210_HQ_MENU_HQ_II_FMT	= 13
ARC_210_COMSEC_MENU			= 14

--GPS time submodes
ARC_210_GPS_TIME_MENU		= 0
ARC_210_GPS_LOADING_TIME	= 1
ARC_210_GPS_TIME_RECIEVED	= 2

--COMSEC menu submodes
ARC_210_COMSEC_ROOT			= 0
ARC_210_COMSEC_UPDATED		= 1
ARC_210_COMSEC_MODE			= 2
ARC_210_COMSEC_DATA_RATE	= 3
ARC_210_COMSEC_BASEBAND		= 4
ARC_210_COMSEC_CVSD			= 5
ARC_210_COMSEC_DATA_RATE_KY_58	= 6
ARC_210_COMSEC_DATA_TYPE	= 7
ARC_210_COMSEC_DATA_RATE_ANDVT	= 8

--ECCM submodes
ARC_210_ECCM_RECV_HOPSET	= 1
ARC_210_ECCM_SEND_HOPSET	= 2
ARC_210_ECCM_LOAD_TIME		= 3

-------PAGE IDs-------
id_Page =
{
	PAGE_ARC_210_NONE				= 0,
	PAGE_ARC_210_POWER_ON_FIRST		= 1,
	PAGE_ARC_210_POWER_ON			= 2,
	PAGE_ARC_210_TEST				= 3,
	PAGE_ARC_210_TEST_PROGRES		= 4,
	PAGE_ARC_210_TR_PRSET			= 5,
	PAGE_ARC_210_TR_MAN				= 6,
	PAGE_ARC_210_CHG_PRSET			= 7,
	PAGE_ARC_210_GUARD_121			= 8,
	PAGE_ARC_210_GUARD_243			= 9,
	PAGE_ARC_210_MARITIME			= 10,
	PAGE_ARC_210_TR_PRSET_SATCOM	= 11,
	PAGE_ARC_210_MENU_ROOT			= 12,
	PAGE_ARC_210_MENU_RADIO_ID_NUMBERS	= 13,
	PAGE_ARC_210_MENU_RADIO_ID_NUMBERS_PAGE	= 14,
	PAGE_ARC_210_MENU_PRESET_CH_26_30	= 15,
	PAGE_ARC_210_MENU_PRESET_CH_26_30_PAGE	= 16,
	PAGE_ARC_210_MENU_DAMA_CHANNELS		= 17,
	PAGE_ARC_210_MENU_DAMA_CHANNELS_PAGE= 18,
	PAGE_ARC_210_MENU_BEEP_ENABLE		= 19,
	PAGE_ARC_210_MENU_BEEP_ENABLE_PAGE	= 20,
	PAGE_ARC_210_MENU_USER_DATA_PORT	= 21,
	PAGE_ARC_210_MENU_USER_DATA_PORT_PAGE	= 22,
	PAGE_ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE	= 23,
	PAGE_ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE	= 24,
	PAGE_ARC_210_MENU_SWITCH_TEST		= 25,
	PAGE_ARC_210_MENU_SWITCH_TEST_PAGE	= 26,
	PAGE_ARC_210_MENU_ENTER_KEY_ENABLE	= 27,
	PAGE_ARC_210_MENU_ENTER_KEY_ENABLE_PAGE	= 28,
	PAGE_ARC_210_MENU_EMCON				= 29,
	PAGE_ARC_210_GPS_TIME				= 30,
	PAGE_ARC_210_GPS_LOADING_TIME		= 31,
	PAGE_ARC_210_GPS_TIME_RECIEVED		= 32,
	PAGE_ARC_210_HQ_MENU_OPER_DATE		= 33,
	PAGE_ARC_210_HQ_MENU_OPER_DATE_PAGE	= 34,
	PAGE_ARC_210_HQ_MENU_VERIFY_WOD		= 35,
	PAGE_ARC_210_HQ_MENU_VERIFY_WOD_PAGE= 36,
	PAGE_ARC_210_HQ_MENU_WOD_LOAD		= 37,
	PAGE_ARC_210_HQ_MENU_WOD_LOAD_PAGE	= 38,
	PAGE_ARC_210_HQ_MENU_WOD_ERASE		= 39,
	PAGE_ARC_210_HQ_MENU_WOD_ERASE_PAGE	= 40,
	PAGE_ARC_210_HQ_MENU_WOD_ERASED		= 41,
	PAGE_ARC_210_HQ_MENU_HQ_II_FMT		= 42,
	PAGE_ARC_210_HQ_MENU_HQ_II_FMT_PAGE	= 43,
	PAGE_ARC_210_COMSEC_MENU_LOS_COMSEC	= 44,
	PAGE_ARC_210_COMSEC_MENU_UPDATED	= 45,
	PAGE_ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE	= 46,
	PAGE_ARC_210_COMSEC_MENU_DATA_RATE_PAGE	= 47,
	PAGE_ARC_210_COMSEC_MENU_BASEBAND_PAGE	= 48,
	PAGE_ARC_210_COMSEC_MENU_CVSD_PAGE	= 49,
	PAGE_ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE	= 50,
	PAGE_ARC_210_COMSEC_MENU_DATA_TYPE_PAGE	= 51,
	PAGE_ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE	= 52,
	PAGE_ARC_210_ECCM					= 53,
	PAGE_ARC_210_ECCM_RECV_HOPSET		= 54,
	PAGE_ARC_210_ECCM_SEND_HOPSET		= 55,
	PAGE_ARC_210_ECCM_LOAD_TIME			= 56,
	PAGE_ARC_210_ZEROIZE				= 57,
}

id_pagesubset =
{
	ARC_210_NONE				= 0,
	ARC_210_POWER_ON_FIRST		= 1,
	ARC_210_POWER_ON			= 2,
	ARC_210_TEST				= 3,
	ARC_210_TEST_PROGRES		= 4,
	ARC_210_TR_PRSET			= 5,
	ARC_210_TR_MAN				= 6,
	ARC_210_CUR_FREQ_MOD		= 7,
	ARC_210_CHG_PRSET			= 8,
	ARC_210_KY					= 9,
	ARC_210_GUARD_121			= 10,
	ARC_210_GUARD_243			= 11,
	ARC_210_MARITIME			= 12,
	ARC_210_TR_PRSET_SATCOM		= 13,
	ARC_210_MENU_ROOT			= 14,
	ARC_210_MENU_RADIO_ID_NUMBERS	= 15,
	ARC_210_MENU_RADIO_ID_NUMBERS_PAGE	= 16,
	ARC_210_MENU_PRESET_CH_26_30	= 17,
	ARC_210_MENU_PRESET_CH_26_30_PAGE	= 18,
	ARC_210_MENU_DAMA_CHANNELS		= 19,
	ARC_210_MENU_DAMA_CHANNELS_PAGE	= 20,
	ARC_210_MENU_BEEP_ENABLE		= 21,
	ARC_210_MENU_BEEP_ENABLE_PAGE	= 22,
	ARC_210_MENU_USER_DATA_PORT		= 23,
	ARC_210_MENU_USER_DATA_PORT_PAGE= 24,
	ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE	= 25,
	ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE	= 26,
	ARC_210_MENU_SWITCH_TEST		= 27,
	ARC_210_MENU_SWITCH_TEST_PAGE	= 28,
	ARC_210_MENU_ENTER_KEY_ENABLE	= 29,
	ARC_210_MENU_ENTER_KEY_ENABLE_PAGE	= 30,
	ARC_210_MENU_EMCON				= 31,
	ARC_210_GPS_TIME				= 32,
	ARC_210_GPS_LOADING_TIME		= 33,
	ARC_210_GPS_TIME_RECIEVED		= 34,
	ARC_210_HQ_MENU_OPER_DATE		= 35,
	ARC_210_HQ_MENU_OPER_DATE_PAGE	= 36,
	ARC_210_HQ_MENU_VERIFY_WOD		= 37,
	ARC_210_HQ_MENU_VERIFY_WOD_PAGE	= 38,
	ARC_210_HQ_MENU_WOD_LOAD		= 39,
	ARC_210_HQ_MENU_WOD_LOAD_PAGE	= 40,
	ARC_210_HQ_MENU_WOD_ERASE		= 41,
	ARC_210_HQ_MENU_WOD_ERASE_PAGE	= 42,
	ARC_210_HQ_MENU_WOD_ERASED		= 43,
	ARC_210_HQ_MENU_HQ_II_FMT		= 44,
	ARC_210_HQ_MENU_HQ_II_FMT_PAGE	= 45,
	ARC_210_COMSEC_MENU_LOS_COMSEC	= 46,
	ARC_210_COMSEC_MENU_UPDATED		= 47,
	ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE	= 48,
	ARC_210_COMSEC_MENU_DATA_RATE_PAGE	= 49,
	ARC_210_COMSEC_MENU_BASEBAND_PAGE	= 50,
	ARC_210_COMSEC_MENU_CVSD_PAGE	= 51,
	ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE	= 52,
	ARC_210_COMSEC_MENU_DATA_TYPE_PAGE	= 53,
	ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE	= 54,
	ARC_210_ECCM					= 55,
	ARC_210_ECCM_RECV_HOPSET		= 56,
	ARC_210_ECCM_SEND_HOPSET		= 57,
	ARC_210_ECCM_LOAD_TIME			= 58,
	ARC_210_ZEROIZE					= 59,
}

page_subsets = {}
page_subsets[id_pagesubset.ARC_210_NONE]   			= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_POWER_ON.lua"
page_subsets[id_pagesubset.ARC_210_POWER_ON_FIRST]  = LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_POWER_ON_FIRST.lua"
page_subsets[id_pagesubset.ARC_210_POWER_ON]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_POWER_ON.lua"
page_subsets[id_pagesubset.ARC_210_TEST]   			= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TEST.lua"
page_subsets[id_pagesubset.ARC_210_TEST_PROGRES]   	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TEST_PROGRES.lua"
page_subsets[id_pagesubset.ARC_210_TR_PRSET]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TR_PRSET.lua"
page_subsets[id_pagesubset.ARC_210_TR_MAN]   		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TR_MAN.lua"
page_subsets[id_pagesubset.ARC_210_CUR_FREQ_MOD]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_CUR_FREQ_MOD.lua"
page_subsets[id_pagesubset.ARC_210_CHG_PRSET]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_CHG_PRSET.lua"
page_subsets[id_pagesubset.ARC_210_KY]				= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_KY.lua"
page_subsets[id_pagesubset.ARC_210_GUARD_121]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_GUARD_121.lua"
page_subsets[id_pagesubset.ARC_210_GUARD_243]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_GUARD_243.lua"
page_subsets[id_pagesubset.ARC_210_MARITIME]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MARITIME.lua"
page_subsets[id_pagesubset.ARC_210_TR_PRSET_SATCOM]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_TR_PRSET_SATCOM.lua"
page_subsets[id_pagesubset.ARC_210_MENU_ROOT]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_ROOT.lua"
page_subsets[id_pagesubset.ARC_210_MENU_RADIO_ID_NUMBERS]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_RADIO_ID_NUMBERS.lua"
page_subsets[id_pagesubset.ARC_210_MENU_RADIO_ID_NUMBERS_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_RADIO_ID_NUMBERS_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_PRESET_CH_26_30]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_PRESET_CH_26_30.lua"
page_subsets[id_pagesubset.ARC_210_MENU_PRESET_CH_26_30_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_PRESET_CH_26_30_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_DAMA_CHANNELS]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_DAMA_CHANNELS.lua"
page_subsets[id_pagesubset.ARC_210_MENU_DAMA_CHANNELS_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_DAMA_CHANNELS_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_BEEP_ENABLE]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_BEEP_ENABLE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_BEEP_ENABLE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_BEEP_ENABLE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_USER_DATA_PORT]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_USER_DATA_PORT.lua"
page_subsets[id_pagesubset.ARC_210_MENU_USER_DATA_PORT_PAGE]= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_USER_DATA_PORT_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_USER_DATA_PORT_SYNC_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_USER_DATA_PORT_CLOCK_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_SWITCH_TEST]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_SWITCH_TEST.lua"
page_subsets[id_pagesubset.ARC_210_MENU_SWITCH_TEST_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_SWITCH_TEST_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_ENTER_KEY_ENABLE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_ENTER_KEY_ENABLE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_ENTER_KEY_ENABLE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_ENTER_KEY_ENABLE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_MENU_EMCON]				= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_MENU_EMCON.lua"
page_subsets[id_pagesubset.ARC_210_GPS_TIME]				= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_GPS_TIME.lua"
page_subsets[id_pagesubset.ARC_210_GPS_LOADING_TIME]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_GPS_LOADING_TIME.lua"
page_subsets[id_pagesubset.ARC_210_GPS_TIME_RECIEVED]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_GPS_TIME_RECIEVED.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_OPER_DATE]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_OPER_DATE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_OPER_DATE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_OPER_DATE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_VERIFY_WOD]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_VERIFY_WOD.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_VERIFY_WOD_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_VERIFY_WOD_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_WOD_LOAD]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_WOD_LOAD.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_WOD_LOAD_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_WOD_LOAD_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_WOD_ERASE]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_WOD_ERASE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_WOD_ERASE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_WOD_ERASE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_WOD_ERASED]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_WOD_ERASED.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_HQ_II_FMT]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_HQ_II_FMT.lua"
page_subsets[id_pagesubset.ARC_210_HQ_MENU_HQ_II_FMT_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_HQ_MENU_HQ_II_FMT_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_LOS_COMSEC]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_LOS_COMSEC.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_UPDATED]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_UPDATED.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_COMSEC_MODE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_DATA_RATE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_BASEBAND_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_BASEBAND_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_CVSD_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_CVSD_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_DATA_RATE_KY_58_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_DATA_TYPE_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_DATA_TYPE_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE]	= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_COMSEC_MENU_DATA_RATE_ANDVT_PAGE.lua"
page_subsets[id_pagesubset.ARC_210_ECCM]					= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_ECCM.lua"
page_subsets[id_pagesubset.ARC_210_ECCM_RECV_HOPSET]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_ECCM_RECV_HOPSET.lua"
page_subsets[id_pagesubset.ARC_210_ECCM_SEND_HOPSET]		= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_ECCM_SEND_HOPSET.lua"
page_subsets[id_pagesubset.ARC_210_ECCM_LOAD_TIME]			= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_ECCM_LOAD_TIME.lua"
page_subsets[id_pagesubset.ARC_210_ZEROIZE]					= LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_page_ZEROIZE.lua"

----------------------
pages = {}
pages[id_Page.PAGE_ARC_210_NONE]			= {}
pages[id_Page.PAGE_ARC_210_POWER_ON_FIRST]	= {id_pagesubset.ARC_210_POWER_ON_FIRST}
pages[id_Page.PAGE_ARC_210_POWER_ON] 		= {id_pagesubset.ARC_210_POWER_ON}
pages[id_Page.PAGE_ARC_210_TEST] 			= {id_pagesubset.ARC_210_TEST}
pages[id_Page.PAGE_ARC_210_TEST_PROGRES] 	= {id_pagesubset.ARC_210_TEST_PROGRES}
pages[id_Page.PAGE_ARC_210_TR_PRSET] 		= {id_pagesubset.ARC_210_TR_PRSET, id_pagesubset.ARC_210_CUR_FREQ_MOD, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_TR_MAN] 			= {id_pagesubset.ARC_210_TR_MAN, id_pagesubset.ARC_210_CUR_FREQ_MOD, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_CHG_PRSET] 		= {id_pagesubset.ARC_210_CHG_PRSET, id_pagesubset.ARC_210_CUR_FREQ_MOD, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_GUARD_121] 		= {id_pagesubset.ARC_210_GUARD_121, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_GUARD_243] 		= {id_pagesubset.ARC_210_GUARD_243, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_MARITIME] 		= {id_pagesubset.ARC_210_MARITIME, id_pagesubset.ARC_210_KY}
pages[id_Page.PAGE_ARC_210_TR_PRSET_SATCOM] = {id_pagesubset.ARC_210_TR_PRSET_SATCOM}
pages[id_Page.PAGE_ARC_210_MENU_ROOT] 		= {id_pagesubset.ARC_210_MENU_ROOT}
pages[id_Page.PAGE_ARC_210_MENU_RADIO_ID_NUMBERS]	= {id_pagesubset.ARC_210_MENU_RADIO_ID_NUMBERS}
pages[id_Page.PAGE_ARC_210_MENU_RADIO_ID_NUMBERS_PAGE]	= {id_pagesubset.ARC_210_MENU_RADIO_ID_NUMBERS_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_PRESET_CH_26_30]	= {id_pagesubset.ARC_210_MENU_PRESET_CH_26_30}
pages[id_Page.PAGE_ARC_210_MENU_PRESET_CH_26_30_PAGE]	= {id_pagesubset.ARC_210_MENU_PRESET_CH_26_30_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_DAMA_CHANNELS]		= {id_pagesubset.ARC_210_MENU_DAMA_CHANNELS}
pages[id_Page.PAGE_ARC_210_MENU_DAMA_CHANNELS_PAGE]	= {id_pagesubset.ARC_210_MENU_DAMA_CHANNELS_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_BEEP_ENABLE]		= {id_pagesubset.ARC_210_MENU_BEEP_ENABLE}
pages[id_Page.PAGE_ARC_210_MENU_BEEP_ENABLE_PAGE]	= {id_pagesubset.ARC_210_MENU_BEEP_ENABLE_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT]		= {id_pagesubset.ARC_210_MENU_USER_DATA_PORT}
pages[id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_PAGE]= {id_pagesubset.ARC_210_MENU_USER_DATA_PORT_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE]	= {id_pagesubset.ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE]	= {id_pagesubset.ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_SWITCH_TEST]		= {id_pagesubset.ARC_210_MENU_SWITCH_TEST}
pages[id_Page.PAGE_ARC_210_MENU_SWITCH_TEST_PAGE]	= {id_pagesubset.ARC_210_MENU_SWITCH_TEST_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_ENTER_KEY_ENABLE]	= {id_pagesubset.ARC_210_MENU_ENTER_KEY_ENABLE}
pages[id_Page.PAGE_ARC_210_MENU_ENTER_KEY_ENABLE_PAGE]	= {id_pagesubset.ARC_210_MENU_ENTER_KEY_ENABLE_PAGE}
pages[id_Page.PAGE_ARC_210_MENU_EMCON]		= {id_pagesubset.ARC_210_MENU_EMCON}
pages[id_Page.PAGE_ARC_210_GPS_TIME]		= {id_pagesubset.ARC_210_GPS_TIME}
pages[id_Page.PAGE_ARC_210_GPS_LOADING_TIME]= {id_pagesubset.ARC_210_GPS_LOADING_TIME}
pages[id_Page.PAGE_ARC_210_GPS_TIME_RECIEVED]= {id_pagesubset.ARC_210_GPS_TIME_RECIEVED}
pages[id_Page.PAGE_ARC_210_HQ_MENU_OPER_DATE]= {id_pagesubset.ARC_210_HQ_MENU_OPER_DATE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_OPER_DATE_PAGE]	= {id_pagesubset.ARC_210_HQ_MENU_OPER_DATE_PAGE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_VERIFY_WOD]	= {id_pagesubset.ARC_210_HQ_MENU_VERIFY_WOD}
pages[id_Page.PAGE_ARC_210_HQ_MENU_VERIFY_WOD_PAGE]	= {id_pagesubset.ARC_210_HQ_MENU_VERIFY_WOD_PAGE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_WOD_LOAD]	= {id_pagesubset.ARC_210_HQ_MENU_WOD_LOAD}
pages[id_Page.PAGE_ARC_210_HQ_MENU_WOD_LOAD_PAGE]	= {id_pagesubset.ARC_210_HQ_MENU_WOD_LOAD_PAGE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASE]		= {id_pagesubset.ARC_210_HQ_MENU_WOD_ERASE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASE_PAGE]	= {id_pagesubset.ARC_210_HQ_MENU_WOD_ERASE_PAGE}
pages[id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASED]		= {id_pagesubset.ARC_210_HQ_MENU_WOD_ERASED}
pages[id_Page.PAGE_ARC_210_HQ_MENU_HQ_II_FMT]		= {id_pagesubset.ARC_210_HQ_MENU_HQ_II_FMT}
pages[id_Page.PAGE_ARC_210_HQ_MENU_HQ_II_FMT_PAGE]	= {id_pagesubset.ARC_210_HQ_MENU_HQ_II_FMT_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_LOS_COMSEC]	= {id_pagesubset.ARC_210_COMSEC_MENU_LOS_COMSEC}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_UPDATED]		= {id_pagesubset.ARC_210_COMSEC_MENU_UPDATED}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_BASEBAND_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_BASEBAND_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_CVSD_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_CVSD_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_TYPE_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_DATA_TYPE_PAGE}
pages[id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE]	= {id_pagesubset.ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE}
pages[id_Page.PAGE_ARC_210_ECCM]					= {id_pagesubset.ARC_210_ECCM}
pages[id_Page.PAGE_ARC_210_ECCM_RECV_HOPSET]		= {id_pagesubset.ARC_210_ECCM_RECV_HOPSET}
pages[id_Page.PAGE_ARC_210_ECCM_SEND_HOPSET]		= {id_pagesubset.ARC_210_ECCM_SEND_HOPSET}
pages[id_Page.PAGE_ARC_210_ECCM_LOAD_TIME]			= {id_pagesubset.ARC_210_ECCM_LOAD_TIME}
pages[id_Page.PAGE_ARC_210_ZEROIZE]					= {id_pagesubset.ARC_210_ZEROIZE}

--init_pageID          = id_Page.PAGE_MFCD_NONE
use_parswer            = false
HUD_Only_status        = false
--HUD_Only_scale       = 10;
--HUD_Only_diplacement = {0.5*1.3333, -0.3};

function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, 10, 14, 8)

pages_by_mode[ARC_210_NONE]		[0][0][0]   					= id_Page.PAGE_ARC_210_NONE
pages_by_mode[ARC_210_POWER_ON]	[0][0][0]   					= id_Page.PAGE_ARC_210_POWER_ON_FIRST
pages_by_mode[ARC_210_POWER_ON]	[1][0][0]   					= id_Page.PAGE_ARC_210_POWER_ON
pages_by_mode[ARC_210_TEST]		[ARC_210_TEST_START][0][0]		= id_Page.PAGE_ARC_210_TEST
pages_by_mode[ARC_210_TEST]		[ARC_210_TEST_PROGRES][0][0]	= id_Page.PAGE_ARC_210_TEST_PROGRES
pages_by_mode[ARC_210_TR]		[ARC_210_TR_PRSET][0][0]		= id_Page.PAGE_ARC_210_TR_PRSET
pages_by_mode[ARC_210_TR]		[ARC_210_TR_MAN][0][0]			= id_Page.PAGE_ARC_210_TR_MAN
pages_by_mode[ARC_210_TR]		[ARC_210_TR_PRSET_SATCOM][0][0]	= id_Page.PAGE_ARC_210_TR_PRSET_SATCOM
pages_by_mode[ARC_210_CHG_PRST]	[ARC_210_CHG_PRST_PRST][0][0]	= id_Page.PAGE_ARC_210_CHG_PRSET
pages_by_mode[ARC_210_GUARD]	[ARC_210_GUARD_121][0][0]		= id_Page.PAGE_ARC_210_GUARD_121
pages_by_mode[ARC_210_GUARD]	[ARC_210_GUARD_243][0][0]		= id_Page.PAGE_ARC_210_GUARD_243
pages_by_mode[ARC_210_MARITIME]	[0][0][0]   					= id_Page.PAGE_ARC_210_MARITIME
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_ROOT][0][0]		= id_Page.PAGE_ARC_210_MENU_ROOT
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_RADIO_ID_NUMBERS][0][0]	= id_Page.PAGE_ARC_210_MENU_RADIO_ID_NUMBERS
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_RADIO_ID_NUMBERS][1][0]	= id_Page.PAGE_ARC_210_MENU_RADIO_ID_NUMBERS_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_PRESET_CH_26_30][0][0]	= id_Page.PAGE_ARC_210_MENU_PRESET_CH_26_30
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_PRESET_CH_26_30][1][0]	= id_Page.PAGE_ARC_210_MENU_PRESET_CH_26_30_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_DAMA_CHANNELS][0][0]	= id_Page.PAGE_ARC_210_MENU_DAMA_CHANNELS
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_DAMA_CHANNELS][1][0]	= id_Page.PAGE_ARC_210_MENU_DAMA_CHANNELS_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_BEEP_ENABLE][0][0]	= id_Page.PAGE_ARC_210_MENU_BEEP_ENABLE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_BEEP_ENABLE][1][0]	= id_Page.PAGE_ARC_210_MENU_BEEP_ENABLE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_USER_DATA_PORT][0][0]	= id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_USER_DATA_PORT][1][0]	= id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_USER_DATA_PORT][2][0]	= id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_SYNC_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_USER_DATA_PORT][3][0]	= id_Page.PAGE_ARC_210_MENU_USER_DATA_PORT_CLOCK_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_SWITCH_TEST][0][0]	= id_Page.PAGE_ARC_210_MENU_SWITCH_TEST
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_SWITCH_TEST][1][0]	= id_Page.PAGE_ARC_210_MENU_SWITCH_TEST_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_ENTER_KEY_ENABLE][0][0]	= id_Page.PAGE_ARC_210_MENU_ENTER_KEY_ENABLE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_ENTER_KEY_ENABLE][1][0]	= id_Page.PAGE_ARC_210_MENU_ENTER_KEY_ENABLE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_MENU_EMCON][0][0]			= id_Page.PAGE_ARC_210_MENU_EMCON
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_OPER_DATE][0][0]	= id_Page.PAGE_ARC_210_HQ_MENU_OPER_DATE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_OPER_DATE][1][0]	= id_Page.PAGE_ARC_210_HQ_MENU_OPER_DATE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_VERIFY_WOD][0][0]	= id_Page.PAGE_ARC_210_HQ_MENU_VERIFY_WOD
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_VERIFY_WOD][1][0]	= id_Page.PAGE_ARC_210_HQ_MENU_VERIFY_WOD_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_WOD_LOAD][0][0]	= id_Page.PAGE_ARC_210_HQ_MENU_WOD_LOAD
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_WOD_LOAD][1][0]	= id_Page.PAGE_ARC_210_HQ_MENU_WOD_LOAD_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_WOD_ERASE][0][0]	= id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_WOD_ERASE][1][0]	= id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_WOD_ERASE][2][0]	= id_Page.PAGE_ARC_210_HQ_MENU_WOD_ERASED
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_HQ_II_FMT][0][0]	= id_Page.PAGE_ARC_210_HQ_MENU_HQ_II_FMT
pages_by_mode[ARC_210_MENU]		[ARC_210_HQ_MENU_HQ_II_FMT][1][0]	= id_Page.PAGE_ARC_210_HQ_MENU_HQ_II_FMT_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_ROOT][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_LOS_COMSEC
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_UPDATED][0]= id_Page.PAGE_ARC_210_COMSEC_MENU_UPDATED
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_MODE][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_COMSEC_MODE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_DATA_RATE][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_BASEBAND][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_BASEBAND_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_CVSD][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_CVSD_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_DATA_RATE_KY_58][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_KY_58_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_DATA_TYPE][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_TYPE_PAGE
pages_by_mode[ARC_210_MENU]		[ARC_210_COMSEC_MENU][ARC_210_COMSEC_DATA_RATE_ANDVT][0]	= id_Page.PAGE_ARC_210_COMSEC_MENU_DATA_RATE_ANDVT_PAGE
pages_by_mode[ARC_210_GPS_TIME]	[ARC_210_GPS_TIME_MENU][0][0]		= id_Page.PAGE_ARC_210_GPS_TIME
pages_by_mode[ARC_210_GPS_TIME]	[ARC_210_GPS_LOADING_TIME][0][0]	= id_Page.PAGE_ARC_210_GPS_LOADING_TIME
pages_by_mode[ARC_210_GPS_TIME]	[ARC_210_GPS_TIME_RECIEVED][0][0]	= id_Page.PAGE_ARC_210_GPS_TIME_RECIEVED
pages_by_mode[ARC_210_ECCM]		[0][0][0]							= id_Page.PAGE_ARC_210_ECCM
pages_by_mode[ARC_210_ECCM]		[ARC_210_ECCM_RECV_HOPSET][0][0]	= id_Page.PAGE_ARC_210_ECCM_RECV_HOPSET
pages_by_mode[ARC_210_ECCM]		[ARC_210_ECCM_SEND_HOPSET][0][0]	= id_Page.PAGE_ARC_210_ECCM_SEND_HOPSET
pages_by_mode[ARC_210_ECCM]		[ARC_210_ECCM_LOAD_TIME][0][0]		= id_Page.PAGE_ARC_210_ECCM_LOAD_TIME
pages_by_mode[ARC_210_ZEROIZE]	[0][0][0]							= id_Page.PAGE_ARC_210_ZEROIZE


function post_initialize()
local 	dev  = GetSelf() 
		
		dev:performClickableAction(device_commands.Button_44,3);
		dev:performClickableAction(device_commands.Button_15,1);
end