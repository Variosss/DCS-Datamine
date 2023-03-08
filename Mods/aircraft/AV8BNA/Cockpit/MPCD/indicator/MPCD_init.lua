dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
local mpcd_path = LockOn_Options.script_path.."MPCD/indicator/"

update_screenspace_diplacement(1.0, monitorpos == 'L')

dofile(mpcd_path.."Global/MPCD_Materials.lua")
dofile(mpcd_path.."Global/MPCD_Parameters.lua")
dofile(mpcd_path.."Global/MPCD_PageDefs.lua")

if monitorpos == 'R' then
	try_find_assigned_viewport("RIGHT_MFCD")
else 
	try_find_assigned_viewport("LEFT_MFCD")
end

page_subsets = {
	[SRC_MPCD_BASE]				= mpcd_path.."MPCD_base.lua",
	[SRC_MPCD_MENU]				= mpcd_path.."MENU/MENU_Page_0.lua",
	-- FLIR
	[SRC_FLIR_NAV]				= mpcd_path.."FLIR/FLIR_Page_00.lua",
	-- EHSD
	[SRC_EHSD_NAV]				= mpcd_path.."EHSD/NAV/EHSD_NAV_DSPLY.lua",
	[SRC_EHSD_DATA]				= mpcd_path.."EHSD/DATA/EHSD_DAT_DSPLY.lua",
	[SRC_EHSD_DATA_GPS]			= mpcd_path.."EHSD/DATA/EHSD_DAT_GPS.lua",
	[SRC_EHSD_ALIGN]			= mpcd_path.."EHSD/ALGN/EHSD_ALN_DSPLY.lua",
	[SRC_EHSD_TEST]				= mpcd_path.."EHSD/EHSD_TST_DSPLY.lua",
	[SRC_EHSD_NOINS]			= mpcd_path.."EHSD/EHSD_NO_INS.lua",
	[SRC_EHSD_INS_OFF]			= mpcd_path.."EHSD/EHSD_OFF_DSPLY.lua",
	[SRC_EHSD_CHART]			= mpcd_path.."EHSD/EHSD_CHART_DSPLY.lua",
	-- DMT
	[SRC_MPCD_DMT]				= mpcd_path.."DMT/DMT_Page_00.lua",
	-- STRS
	[SRC_MPCD_STRS]				= mpcd_path.."STRS/STRS_Page_GENORD.lua",
	[SRC_STRS_LSM]				= mpcd_path.."STRS/STRS_Page_AGM65E.lua",
	[SRC_STRS_IRM]				= mpcd_path.."STRS/STRS_Page_AGM65X.lua",
	[SRC_STRS_IRM_VIDEO]		= mpcd_path.."STRS/STRS_Page_IRMAV.lua",
	[SRC_STRS_DMGD]				= mpcd_path.."STRS/STRS_Page_DMGD.lua",
	[SRC_STRS_JDAM]				= mpcd_path.."STRS/STRS_Page_JDAM.lua",
	-- HUD
	[SRC_MPCD_HUD]				= mpcd_path.."HUD/MPCD_HUD_Base.lua",
	-- VRST
	[SRC_VRST_BSC]				= mpcd_path.."VRST/VRST_BASIC.lua",
	[SRC_VRST_VTO]				= mpcd_path.."VRST/VRST_VLTO.lua",
	[SRC_VRST_STO]				= mpcd_path.."VRST/VRST_STO.lua",
	[SRC_VRST_CRS]				= mpcd_path.."VRST/VRST_CRUS.lua",
	[SRC_VRST_BNG]				= mpcd_path.."VRST/VRST_BINGO.lua",
	-- BIT
	[SRC_MPCD_BIT_1]			= mpcd_path.."BIT/BIT_Page_0.lua",
	[SRC_MPCD_BIT_2]			= mpcd_path.."BIT/BIT_Page_1.lua",
	[SRC_MPCD_BIT_SMS]			= mpcd_path.."BIT/BIT_Page_SMS.lua",
	[SRC_MPCD_BIT_FBST]			= mpcd_path.."FLIR/FLIR_Page_10.lua",
	-- ENG
	[SRC_MPCD_ENG]				= mpcd_path.."ENG/ENG_Page_0.lua",
	[SRC_MPCD_ENG_PHOV]			= mpcd_path.."ENG/ENG_Page_2.lua",
	-- CONF
	[SRC_MPCD_CONF_1]			= mpcd_path.."CONF/CONF_Page_0.lua",
	[SRC_MPCD_CONF_2]			= mpcd_path.."CONF/CONF_Page_1.lua",
	[SRC_MPCD_CONF_3]			= mpcd_path.."CONF/CONF_Page_2.lua",
	--TPOD
	[SRC_TPOD_CCD_PR]			= mpcd_path.."TPOD/TPOD_PRI_DISPY.lua",
	[SRC_TPOD_CCD_DT]			= mpcd_path.."TPOD/TPOD_DTA_DISPY.lua",
	[SRC_TPOD_FLIR_PR]			= mpcd_path.."TPOD/TPOD_PRI_DISPY.lua",
	[SRC_TPOD_FLIR_DT]			= mpcd_path.."TPOD/TPOD_DTA_DISPY.lua",
	[SRC_TPOD_NAV_PR]			= mpcd_path.."TPOD/TPOD_NAV_PRI.lua",
	[SRC_TPOD_NAV_DT]			= mpcd_path.."TPOD/TPOD_NAV_DAT.lua",
	[SRC_TPOD_VCR_DSPLY]		= mpcd_path.."TPOD/TPOD_VCR_DSPLY.lua",
	-- EW
	[SRC_EW_RWR]				= mpcd_path.."EW/EW_Page_00.lua",
	[SRC_EW_CMD_PRG]			= mpcd_path.."EW/EW_Page_01.lua",
	-- CARD
	[SRC_MPCD_CARD]				= mpcd_path.."CARD/CARD_PAGE.lua",
	-- CAS
	[SRC_CAS_PAGE]				= mpcd_path.."CAS/CAS_PAGE.lua",
	[SRC_CAS_LIST]				= mpcd_path.."CAS/CAS_LST.lua",
	-- EPCD
	[SRC_EPCD_MENU]				= mpcd_path.."EPCD/EPCD_BASE.lua",
	-- SDAT
	[SRC_MPCD_SDAT]				= mpcd_path.."SDAT/SDAT_PAGE.lua",
	-- COMM
	[SRC_MPCD_COMM]				= mpcd_path.."COMM/COMM_PAGE_1.lua",
}

----------------------
pages = {
	[MPCD_MENU]				= {SRC_MPCD_BASE, SRC_MPCD_MENU},
	-- FLIR
	[MPCD_FLIR]				= {SRC_MPCD_BASE, SRC_FLIR_NAV},
	-- EHSD
	[MPCD_EHSD_STR]			= {SRC_MPCD_BASE, SRC_EHSD_NAV},
	[MPCD_EHSD_DATA]		= {SRC_MPCD_BASE, SRC_EHSD_DATA},
	[MPCD_EHSD_DATA_GPS]	= {SRC_MPCD_BASE, SRC_EHSD_DATA_GPS},
	[MPCD_EHSD_ALIGN]		= {SRC_MPCD_BASE, SRC_EHSD_ALIGN},
	[MPCD_EHSD_TEST]		= {SRC_MPCD_BASE, SRC_EHSD_TEST},
	[MPCD_EHSD_INS_OFF]		= {SRC_MPCD_BASE, SRC_EHSD_INS_OFF},
	[MPCD_EHSD_NOINS]		= {SRC_MPCD_BASE, SRC_EHSD_NOINS},
	[MPCD_EHSD_CHART]		= {SRC_MPCD_BASE, SRC_EHSD_CHART},
	-- DMT
	[MPCD_DMT]				= {SRC_MPCD_BASE, SRC_MPCD_DMT},
	-- STORES
	[MPCD_STRS_BASE]		= {SRC_MPCD_BASE, SRC_MPCD_STRS},
	[MPCD_STRS_LSM]			= {SRC_MPCD_BASE, SRC_STRS_LSM},
	[MPCD_STRS_IRM]			= {SRC_MPCD_BASE, SRC_STRS_IRM},
	[MPCD_STRS_IRM_VIDEO]	= {SRC_MPCD_BASE, SRC_STRS_IRM_VIDEO},
	[MPCD_STRS_DMGD]		= {SRC_MPCD_BASE, SRC_STRS_DMGD},
	[MPCD_STRS_JDAM]		= {SRC_MPCD_BASE, SRC_STRS_JDAM},
	-- HUD
	[MPCD_HUD_BASE]			= {SRC_MPCD_BASE, SRC_MPCD_HUD},
	-- VRST
	[MPCD_VRST_BSC]			= {SRC_MPCD_BASE, SRC_VRST_BSC},
	[MPCD_VRST_VTO]			= {SRC_MPCD_BASE, SRC_VRST_VTO},
	[MPCD_VRST_STO]			= {SRC_MPCD_BASE, SRC_VRST_STO},
	[MPCD_VRST_CRS]			= {SRC_MPCD_BASE, SRC_VRST_CRS},
	[MPCD_VRST_BNG]			= {SRC_MPCD_BASE, SRC_VRST_BNG},
	-- BIT
	[MPCD_BIT_1]			= {SRC_MPCD_BASE, SRC_MPCD_BIT_1},
	[MPCD_BIT_2]			= {SRC_MPCD_BASE, SRC_MPCD_BIT_2},
	[MPCD_BIT_SMS]			= {SRC_MPCD_BASE, SRC_MPCD_BIT_SMS},
	[MPCD_BIT_FBST]			= {SRC_MPCD_BASE, SRC_MPCD_BIT_FBST},
	-- ENG
	[MPCD_ENG]				= {SRC_MPCD_BASE, SRC_MPCD_ENG},
	[MPCD_ENG_PHOV]			= {SRC_MPCD_BASE, SRC_MPCD_ENG_PHOV},
	-- CONF
	[MPCD_CONF_1]			= {SRC_MPCD_BASE, SRC_MPCD_CONF_1},
	[MPCD_CONF_2]			= {SRC_MPCD_BASE, SRC_MPCD_CONF_2},
	[MPCD_CONF_3]			= {SRC_MPCD_BASE, SRC_MPCD_CONF_3},
	-- TPOD
	[MPCD_TPOD_CCD_PR]		= {SRC_MPCD_BASE, SRC_TPOD_CCD_PR},
	[MPCD_TPOD_CCD_DT]		= {SRC_MPCD_BASE, SRC_TPOD_CCD_DT},
	[MPCD_TPOD_FLIR_PR]		= {SRC_MPCD_BASE, SRC_TPOD_FLIR_PR},
	[MPCD_TPOD_FLIR_DT]		= {SRC_MPCD_BASE, SRC_TPOD_FLIR_DT},
	[MPCD_TPOD_NAV_PR]		= {SRC_MPCD_BASE, SRC_TPOD_NAV_PR},
	[MPCD_TPOD_NAV_DT]		= {SRC_MPCD_BASE, SRC_TPOD_NAV_DT},
	[MPCD_TPOD_VCR_DSPLY]	= {SRC_MPCD_BASE, SRC_TPOD_VCR_DSPLY},
	-- EW
	[MPCD_EW_RWR]			= {SRC_MPCD_BASE, SRC_EW_RWR},
	[MPCD_EW_CMD_PRG]		= {SRC_MPCD_BASE, SRC_EW_CMD_PRG},
	-- CARD
	[MPCD_CARD]				= {SRC_MPCD_BASE, SRC_MPCD_CARD},
	-- CAS
	[MPCD_CAS_PAGE]			= {SRC_MPCD_BASE, SRC_CAS_PAGE},
	[MPCD_CAS_LIST]			= {SRC_MPCD_BASE, SRC_CAS_LIST},
	-- EPCD
	[MPCD_EPCD_MENU]		= {SRC_MPCD_BASE, SRC_EPCD_MENU},
	-- SDAT
	[MPCD_SDAT]				= {SRC_MPCD_BASE, SRC_MPCD_SDAT},
	-- COMM
	[MPCD_COMM]				= {SRC_MPCD_BASE, SRC_MPCD_COMM},
}

init_pageID			= MPCD_MENU

