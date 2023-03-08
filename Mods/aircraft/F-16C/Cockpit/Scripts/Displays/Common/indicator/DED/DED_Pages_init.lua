--
local count = 0
local function counter()
	count = count + 1
	return count
end

-- list of subsets
count = -1
local id_subset =
{
	CNI					= counter(),

	COM_1				= counter(),
	COM_1_GUARD			= counter(),

	COM_2				= counter(),
	COM_2_GUARD			= counter(),

	IFF_MAIN_STAT		= counter(),
	IFF_MAIN_POS		= counter(),
	IFF_MAIN_TIM		= counter(),
	IFF_BACKUP			= counter(),

	LIST				= counter(),

	T_ILS_COMMON		= counter(),
	T_ILS_PRIMARY		= counter(),
	T_ILS_BACKUP		= counter(),

	ALOW				= counter(),

	STPT				= counter(),
	STPT_BACKUP			= counter(),

	CRUS_COMMON			= counter(),
	CRUS_TOS			= counter(),
	CRUS_RNG			= counter(),
	CRUS_EDR			= counter(),
	CRUS_HOME			= counter(),	

	TIME				= counter(),

	MARK				= counter(),

	FIX					= counter(),

	A_CAL_MAN			= counter(),
	A_CAL_AUTO			= counter(),

	DEST_UTM_DIR		= counter(),
	DEST_DIR			= counter(),
	DEST_OA1			= counter(),
	DEST_OA2			= counter(),

	BINGO				= counter(),

	VIP					= counter(),

	NAV_COMMON			= counter(),
	NAV_STATUS			= counter(),
	NAV_COMMANDS		= counter(),

	MAN					= counter(),

	INS_COMMON			= counter(),
	INS					= counter(),
	INS_INFLT_ALGN		= counter(),

	CMDS_COMMON			= counter(),
	CMDS_BINGO			= counter(),
	CMDS_CHAFF			= counter(),
	CMDS_FLARE			= counter(),
	CMDS_OTHER_1		= counter(),
	CMDS_OTHER_2		= counter(),

	MODE				= counter(),

	VRP					= counter(),

	DLNK_NET_STATUS		= counter(),
	DLNK_LINK16			= counter(),
	DLNK_LINK16_STN		= counter(),
	DLNK_AG_DL			= counter(),
	DLNK_INTRAFLIGHT	= counter(),

	MISC				= counter(),

	CORR_COMMON_1_5		= counter(),
	CORR_COMMON_6_9		= counter(),
	CORR_COMMON_ANGLES	= counter(),
	CORR_HUD_1			= counter(),
	CORR_HUD_2			= counter(),
	CORR_CTVS_1			= counter(),
	CORR_CTVS_2			= counter(),
	CORR_CAMERA			= counter(),
	CORR_FLIR			= counter(),
	CORR_LT_HDPT		= counter(),
	CORR_RT_HDPT		= counter(),
	CORR_INS			= counter(),
	CORR_FCR			= counter(),

	MAGV				= counter(),

	OFP_COMMON			= counter(),
	OFP_1				= counter(),
	OFP_2				= counter(),

	INSM				= counter(),

	LASER				= counter(),

	GPS_INIT_1			= counter(),
	GPS_INIT_2			= counter(),

	DRNG				= counter(),

	BULLSEYE			= counter(),

	HARM_COMMON			= counter(),
	HARM				= counter(),
	HARM_PG1			= counter(),
	HARM_PG2			= counter(),

	INTG				= counter(),
	
	HMCS_DISPLAY		= counter(),
	HMCS_ALIGN			= counter(),
	
	HTS_COMMON			= counter(),
	HTS_MAN				= counter(),
	HTS_SEAD			= counter(),
	HTS_SEAD_DL			= counter(),
}


--local DED_PagesPath = LockOn_Options.script_path.."Displays/DED/indicator/Pages/"

-- construct subsets
page_subsets = {}
page_subsets[id_subset.CNI]					= DED_PagesPath.."CNI.lua"

page_subsets[id_subset.COM_1]				= DED_PagesPath.."COM/COM_1.lua"
page_subsets[id_subset.COM_1_GUARD]			= DED_PagesPath.."COM/COM_1_GUARD.lua"

page_subsets[id_subset.COM_2]				= DED_PagesPath.."COM/COM_2.lua"
page_subsets[id_subset.COM_2_GUARD]			= DED_PagesPath.."COM/COM_2_GUARD.lua"

page_subsets[id_subset.IFF_MAIN_STAT]		= DED_PagesPath.."IFF/IFF_MAIN_STAT.lua"
page_subsets[id_subset.IFF_MAIN_POS]		= DED_PagesPath.."IFF/IFF_MAIN_POS.lua"
page_subsets[id_subset.IFF_MAIN_TIM]		= DED_PagesPath.."IFF/IFF_MAIN_TIM.lua"
page_subsets[id_subset.IFF_BACKUP]			= DED_PagesPath.."IFF/IFF_BACKUP.lua"

page_subsets[id_subset.LIST]				= DED_PagesPath.."LIST.lua"

page_subsets[id_subset.T_ILS_COMMON]		= DED_PagesPath.."T_ILS/T_ILS_COMMON.lua"
page_subsets[id_subset.T_ILS_PRIMARY]		= DED_PagesPath.."T_ILS/T_ILS_PRIMARY.lua"
page_subsets[id_subset.T_ILS_BACKUP]		= DED_PagesPath.."T_ILS/T_ILS_BACKUP.lua"

page_subsets[id_subset.ALOW]				= DED_PagesPath.."ALOW.lua"

page_subsets[id_subset.STPT]				= DED_PagesPath.."STPT/STPT.lua"
page_subsets[id_subset.STPT_BACKUP]			= DED_PagesPath.."STPT/STPT_BACKUP.lua"

page_subsets[id_subset.CRUS_COMMON]			= DED_PagesPath.."CRUS/CRUS_COMMON.lua"
page_subsets[id_subset.CRUS_TOS]			= DED_PagesPath.."CRUS/CRUS_TOS.lua"
page_subsets[id_subset.CRUS_RNG]			= DED_PagesPath.."CRUS/CRUS_RNG.lua"
page_subsets[id_subset.CRUS_EDR]			= DED_PagesPath.."CRUS/CRUS_EDR.lua"
page_subsets[id_subset.CRUS_HOME]			= DED_PagesPath.."CRUS/CRUS_HOME.lua"

page_subsets[id_subset.TIME]				= DED_PagesPath.."TIME.lua"

page_subsets[id_subset.MARK]				= DED_PagesPath.."MARK.lua"

page_subsets[id_subset.FIX]					= DED_PagesPath.."FIX.lua"

page_subsets[id_subset.A_CAL_MAN]			= DED_PagesPath.."A_CAL/A_CAL_MAN.lua"
page_subsets[id_subset.A_CAL_AUTO]			= DED_PagesPath.."A_CAL/A_CAL_AUTO.lua"

page_subsets[id_subset.DEST_UTM_DIR]		= DED_PagesPath.."DEST/DEST_UTM_DIR.lua"
page_subsets[id_subset.DEST_DIR]			= DED_PagesPath.."DEST/DEST_DIR.lua"
page_subsets[id_subset.DEST_OA1]			= DED_PagesPath.."DEST/DEST_OA1.lua"
page_subsets[id_subset.DEST_OA2]			= DED_PagesPath.."DEST/DEST_OA2.lua"

page_subsets[id_subset.BINGO]				= DED_PagesPath.."BINGO.lua"

page_subsets[id_subset.VIP]					= DED_PagesPath.."VIP.lua"

page_subsets[id_subset.NAV_COMMON]			= DED_PagesPath.."NAV/NAV_COMMON.lua"
page_subsets[id_subset.NAV_STATUS]			= DED_PagesPath.."NAV/NAV_STATUS.lua"
page_subsets[id_subset.NAV_COMMANDS]		= DED_PagesPath.."NAV/NAV_COMMANDS.lua"

page_subsets[id_subset.MAN]					= DED_PagesPath.."MAN.lua"

page_subsets[id_subset.INS_COMMON]			= DED_PagesPath.."INS/INS_COMMON.lua"
page_subsets[id_subset.INS]					= DED_PagesPath.."INS/INS.lua"
page_subsets[id_subset.INS_INFLT_ALGN]		= DED_PagesPath.."INS/INS_INFLT_ALGN.lua"

page_subsets[id_subset.CMDS_COMMON]			= DED_PagesPath.."CMDS/CMDS_COMMON.lua"
page_subsets[id_subset.CMDS_BINGO]			= DED_PagesPath.."CMDS/CMDS_BINGO.lua"
page_subsets[id_subset.CMDS_CHAFF]			= DED_PagesPath.."CMDS/CMDS_CHAFF.lua"
page_subsets[id_subset.CMDS_FLARE]			= DED_PagesPath.."CMDS/CMDS_FLARE.lua"
page_subsets[id_subset.CMDS_OTHER_1]		= DED_PagesPath.."CMDS/CMDS_OTHER_1.lua"
page_subsets[id_subset.CMDS_OTHER_2]		= DED_PagesPath.."CMDS/CMDS_OTHER_2.lua"

page_subsets[id_subset.MODE]				= DED_PagesPath.."MODE/MODE.lua"

page_subsets[id_subset.VRP]					= DED_PagesPath.."VRP.lua"

page_subsets[id_subset.DLNK_NET_STATUS]		= DED_PagesPath.."DLNK/NET_STATUS.lua"
page_subsets[id_subset.DLNK_LINK16]			= DED_PagesPath.."DLNK/LINK16.lua"
page_subsets[id_subset.DLNK_LINK16_STN]		= DED_PagesPath.."DLNK/LINK16_STN.lua"
page_subsets[id_subset.DLNK_AG_DL]			= DED_PagesPath.."DLNK/AG_DL.lua"
page_subsets[id_subset.DLNK_INTRAFLIGHT]	= DED_PagesPath.."DLNK/INTRAFLIGHT.lua"

page_subsets[id_subset.MISC]				= DED_PagesPath.."MISC.lua"

page_subsets[id_subset.CORR_COMMON_1_5]		= DED_PagesPath.."CORR/CORR_COMMON_1_5.lua"
page_subsets[id_subset.CORR_COMMON_6_9]		= DED_PagesPath.."CORR/CORR_COMMON_6_9.lua"
page_subsets[id_subset.CORR_COMMON_ANGLES]	= DED_PagesPath.."CORR/CORR_COMMON_ANGLES.lua"
page_subsets[id_subset.CORR_HUD_1]			= DED_PagesPath.."CORR/CORR_HUD_1.lua"
page_subsets[id_subset.CORR_HUD_2]			= DED_PagesPath.."CORR/CORR_HUD_2.lua"
page_subsets[id_subset.CORR_CTVS_1]			= DED_PagesPath.."CORR/CORR_CTVS_1.lua"
page_subsets[id_subset.CORR_CTVS_2]			= DED_PagesPath.."CORR/CORR_CTVS_2.lua"
page_subsets[id_subset.CORR_CAMERA]			= DED_PagesPath.."CORR/CORR_CAMERA.lua"
page_subsets[id_subset.CORR_FLIR]			= DED_PagesPath.."CORR/CORR_FLIR.lua"
page_subsets[id_subset.CORR_LT_HDPT]		= DED_PagesPath.."CORR/CORR_LT_HDPT.lua"
page_subsets[id_subset.CORR_RT_HDPT]		= DED_PagesPath.."CORR/CORR_RT_HDPT.lua"
page_subsets[id_subset.CORR_INS]			= DED_PagesPath.."CORR/CORR_INS.lua"
page_subsets[id_subset.CORR_FCR]			= DED_PagesPath.."CORR/CORR_FCR.lua"

page_subsets[id_subset.MAGV]				= DED_PagesPath.."MAGV.lua"

page_subsets[id_subset.OFP_COMMON]			= DED_PagesPath.."OFP/OFP_COMMON.lua"
page_subsets[id_subset.OFP_1]				= DED_PagesPath.."OFP/OFP_1.lua"
page_subsets[id_subset.OFP_2]				= DED_PagesPath.."OFP/OFP_2.lua"

page_subsets[id_subset.INSM]				= DED_PagesPath.."INSM.lua"

page_subsets[id_subset.LASER]				= DED_PagesPath.."LASER.lua"

page_subsets[id_subset.GPS_INIT_1]			= DED_PagesPath.."GPS/GPS_INIT_1.lua"
page_subsets[id_subset.GPS_INIT_2]			= DED_PagesPath.."GPS/GPS_INIT_2.lua"

page_subsets[id_subset.DRNG]				= DED_PagesPath.."DRNG.lua"

page_subsets[id_subset.BULLSEYE]			= DED_PagesPath.."BULLSEYE.lua"

page_subsets[id_subset.HARM_COMMON]			= DED_PagesPath.."HARM/HARM_COMMON.lua"
page_subsets[id_subset.HARM]				= DED_PagesPath.."HARM/HARM.lua"
page_subsets[id_subset.HARM_PG1]			= DED_PagesPath.."HARM/HARM_PG1.lua"
page_subsets[id_subset.HARM_PG2]			= DED_PagesPath.."HARM/HARM_PG2.lua"

page_subsets[id_subset.INTG]				= DED_PagesPath.."INTG.lua"

page_subsets[id_subset.HMCS_DISPLAY]		= DED_PagesPath.."HMCS/HMCS_DISPLAY.lua"
page_subsets[id_subset.HMCS_ALIGN]			= DED_PagesPath.."HMCS/HMCS_ALIGN.lua"

page_subsets[id_subset.HTS_COMMON]			= DED_PagesPath.."HTS/HTS_COMMON.lua"
page_subsets[id_subset.HTS_MAN]				= DED_PagesPath.."HTS/HTS_MAN.lua"
page_subsets[id_subset.HTS_SEAD]			= DED_PagesPath.."HTS/HTS_SEAD.lua"
page_subsets[id_subset.HTS_SEAD_DL]			= DED_PagesPath.."HTS/HTS_SEAD_DL.lua"

-- list of pages
count = -1
id_Page =
{
	OFF					= counter(),
	
	CNI					= counter(),
	
	COM_1				= counter(),
	COM_1_GUARD			= counter(),
	
	COM_2				= counter(),
	COM_2_GUARD			= counter(),

	IFF_MAIN_STAT		= counter(),
	IFF_MAIN_POS		= counter(),
	IFF_MAIN_TIM		= counter(),
	IFF_BACKUP			= counter(),

	LIST				= counter(),

	T_ILS_PRIMARY		= counter(),
	T_ILS_BACKUP		= counter(),

	ALOW				= counter(),

	STPT				= counter(),
	STPT_BACKUP			= counter(),

	CRUS_TOS			= counter(),
	CRUS_RNG			= counter(),
	CRUS_HOME			= counter(),
	CRUS_EDR			= counter(),	

	TIME				= counter(),

	MARK				= counter(),

	FIX					= counter(),

	A_CAL_MAN			= counter(),
	A_CAL_AUTO			= counter(),

	DEST_UTM_DIR		= counter(),
	DEST_DIR			= counter(),
	DEST_OA1			= counter(),
	DEST_OA2			= counter(),
	
	BINGO				= counter(),

	VIP					= counter(),

	NAV_STATUS			= counter(),
	NAV_COMMANDS		= counter(),

	MAN					= counter(),

	INS					= counter(),
	INS_INFLT_ALGN		= counter(),

	CMDS_BINGO			= counter(),
	CMDS_CHAFF			= counter(),
	CMDS_FLARE			= counter(),
	CMDS_OTHER_1		= counter(),
	CMDS_OTHER_2		= counter(),

	MODE				= counter(),

	VRP					= counter(),

	DLNK_NET_STATUS		= counter(),
	DLNK_LINK16			= counter(),
	DLNK_LINK16_STN		= counter(),
	DLNK_AG_DL			= counter(),
	DLNK_INTRAFLIGHT	= counter(),

	MISC				= counter(),

	CORR_HUD_1			= counter(),
	CORR_HUD_2			= counter(),
	CORR_CTVS_1			= counter(),
	CORR_CTVS_2			= counter(),
	CORR_CAMERA			= counter(),
	CORR_FLIR			= counter(),
	CORR_LT_HDPT		= counter(),
	CORR_RT_HDPT		= counter(),
	CORR_INS			= counter(),
	CORR_FCR			= counter(),

	MAGV				= counter(),

	OFP_1				= counter(),
	OFP_2				= counter(),

	INSM				= counter(),

	LASER				= counter(),

	GPS_INIT_1			= counter(),
	GPS_INIT_2			= counter(),

	DRNG				= counter(),

	BULLSEYE			= counter(),

	HARM				= counter(),
	HARM_PG1			= counter(),
	HARM_PG2			= counter(),

	INTG				= counter(),
	
	HMCS_DISPLAY		= counter(),
	HMCS_ALIGN			= counter(),
	
	HTS_MAN				= counter(),
	HTS_SEAD			= counter(),
	HTS_SEAD_DL			= counter(),
}

init_pageID	= id_Page.OFF

-- construct pages
pages = {}
pages[id_Page.OFF]					= {}
pages[id_Page.CNI]					= {id_subset.CNI}

pages[id_Page.COM_1]				= {id_subset.COM_1}
pages[id_Page.COM_1_GUARD]			= {id_subset.COM_1_GUARD}

pages[id_Page.COM_2]				= {id_subset.COM_2}
pages[id_Page.COM_2_GUARD]			= {id_subset.COM_2_GUARD}

pages[id_Page.IFF_MAIN_STAT]		= {id_subset.IFF_MAIN_STAT}
pages[id_Page.IFF_MAIN_POS]			= {id_subset.IFF_MAIN_POS}
pages[id_Page.IFF_MAIN_TIM]			= {id_subset.IFF_MAIN_TIM}
pages[id_Page.IFF_BACKUP]			= {id_subset.IFF_BACKUP}

pages[id_Page.LIST]					= {id_subset.LIST}

pages[id_Page.T_ILS_PRIMARY]		= {id_subset.T_ILS_COMMON, id_subset.T_ILS_PRIMARY}
pages[id_Page.T_ILS_BACKUP]			= {id_subset.T_ILS_COMMON, id_subset.T_ILS_BACKUP}

pages[id_Page.ALOW]					= {id_subset.ALOW}

pages[id_Page.STPT]					= {id_subset.STPT}
pages[id_Page.STPT_BACKUP]			= {id_subset.STPT_BACKUP}

pages[id_Page.CRUS_TOS]				= {id_subset.CRUS_COMMON, id_subset.CRUS_TOS}
pages[id_Page.CRUS_RNG]				= {id_subset.CRUS_COMMON, id_subset.CRUS_RNG}
pages[id_Page.CRUS_EDR]				= {id_subset.CRUS_COMMON, id_subset.CRUS_EDR}
pages[id_Page.CRUS_HOME]			= {id_subset.CRUS_COMMON, id_subset.CRUS_HOME}

pages[id_Page.TIME]					= {id_subset.TIME}

pages[id_Page.MARK]					= {id_subset.MARK}

pages[id_Page.FIX]					= {id_subset.FIX}

pages[id_Page.A_CAL_MAN]			= {id_subset.A_CAL_COMMON, id_subset.A_CAL_MAN}
pages[id_Page.A_CAL_AUTO]			= {id_subset.A_CAL_COMMON, id_subset.A_CAL_AUTO}

pages[id_Page.DEST_UTM_DIR]			= {id_subset.DEST_UTM_DIR}
pages[id_Page.DEST_DIR]				= {id_subset.DEST_DIR}
pages[id_Page.DEST_OA1]				= {id_subset.DEST_OA1}
pages[id_Page.DEST_OA2]				= {id_subset.DEST_OA2}

pages[id_Page.BINGO]				= {id_subset.BINGO}

pages[id_Page.VIP]					= {id_subset.VIP}

pages[id_Page.NAV_STATUS]			= {id_subset.NAV_COMMON, id_subset.NAV_STATUS}
pages[id_Page.NAV_COMMANDS]			= {id_subset.NAV_COMMON, id_subset.NAV_COMMANDS}

pages[id_Page.MAN]					= {id_subset.MAN}

pages[id_Page.INS]					= {id_subset.INS_COMMON, id_subset.INS}
pages[id_Page.INS_INFLT_ALGN]		= {id_subset.INS_COMMON, id_subset.INS_INFLT_ALGN}

pages[id_Page.CMDS_BINGO]			= {id_subset.CMDS_BINGO}
pages[id_Page.CMDS_CHAFF]			= {id_subset.CMDS_COMMON, id_subset.CMDS_CHAFF}
pages[id_Page.CMDS_FLARE]			= {id_subset.CMDS_COMMON, id_subset.CMDS_FLARE}
pages[id_Page.CMDS_OTHER_1]			= {id_subset.CMDS_COMMON, id_subset.CMDS_OTHER_1}
pages[id_Page.CMDS_OTHER_2]			= {id_subset.CMDS_COMMON, id_subset.CMDS_OTHER_2}

pages[id_Page.MODE]					= {id_subset.MODE}

pages[id_Page.VRP]					= {id_subset.VRP}

pages[id_Page.DLNK_NET_STATUS]		= {id_subset.DLNK_NET_STATUS}
pages[id_Page.DLNK_LINK16]			= {id_subset.DLNK_LINK16}
pages[id_Page.DLNK_LINK16_STN]		= {id_subset.DLNK_LINK16_STN}
pages[id_Page.DLNK_AG_DL]			= {id_subset.DLNK_AG_DL}
pages[id_Page.DLNK_INTRAFLIGHT]		= {id_subset.DLNK_INTRAFLIGHT}

pages[id_Page.MISC]					= {id_subset.MISC}

pages[id_Page.CORR_HUD_1]			= {id_subset.CORR_COMMON_1_5, id_subset.CORR_HUD_1}
pages[id_Page.CORR_HUD_2]			= {id_subset.CORR_COMMON_6_9, id_subset.CORR_HUD_2}
pages[id_Page.CORR_CTVS_1]			= {id_subset.CORR_COMMON_1_5, id_subset.CORR_CTVS_1}
pages[id_Page.CORR_CTVS_2]			= {id_subset.CORR_COMMON_6_9, id_subset.CORR_CTVS_2}
pages[id_Page.CORR_CAMERA]			= {id_subset.CORR_COMMON_1_5, id_subset.CORR_CAMERA}
pages[id_Page.CORR_FLIR]			= {id_subset.CORR_COMMON_1_5, id_subset.CORR_FLIR}
pages[id_Page.CORR_LT_HDPT]			= {id_subset.CORR_COMMON_ANGLES, id_subset.CORR_LT_HDPT}
pages[id_Page.CORR_RT_HDPT]			= {id_subset.CORR_COMMON_ANGLES, id_subset.CORR_RT_HDPT}
pages[id_Page.CORR_INS]				= {id_subset.CORR_COMMON_ANGLES, id_subset.CORR_INS}
pages[id_Page.CORR_FCR]				= {id_subset.CORR_COMMON_ANGLES, id_subset.CORR_FCR}

pages[id_Page.MAGV]					= {id_subset.MAGV}

pages[id_Page.OFP_1]				= {id_subset.OFP_COMMON, id_subset.OFP_1}
pages[id_Page.OFP_2]				= {id_subset.OFP_COMMON, id_subset.OFP_2}

pages[id_Page.INSM]					= {id_subset.INSM}

pages[id_Page.LASER]				= {id_subset.LASER}

pages[id_Page.GPS_INIT_1]			= {id_subset.GPS_INIT_1}
pages[id_Page.GPS_INIT_2]			= {id_subset.GPS_INIT_2}

pages[id_Page.DRNG]					= {id_subset.DRNG}

pages[id_Page.BULLSEYE]				= {id_subset.BULLSEYE}

pages[id_Page.HARM]					= {id_subset.HARM_COMMON, id_subset.HARM}
pages[id_Page.HARM_PG1]				= {id_subset.HARM_COMMON, id_subset.HARM_PG1}
pages[id_Page.HARM_PG2]				= {id_subset.HARM_COMMON, id_subset.HARM_PG2}

pages[id_Page.INTG]					= {id_subset.INTG}

pages[id_Page.HMCS_DISPLAY]			= {id_subset.HMCS_DISPLAY}
pages[id_Page.HMCS_ALIGN]			= {id_subset.HMCS_ALIGN}

pages[id_Page.HTS_MAN]				= {id_subset.HTS_COMMON, id_subset.HTS_MAN}
pages[id_Page.HTS_SEAD]				= {id_subset.HTS_COMMON, id_subset.HTS_SEAD}
pages[id_Page.HTS_SEAD_DL]			= {id_subset.HTS_COMMON, id_subset.HTS_SEAD_DL}

--
dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/DED_formats_IDs.lua")

local function tablelen(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

pages_by_mode = {}
clear_mode_table(pages_by_mode, tablelen(DED_DISP_FMT_LEV1), tablelen(DED_DISP_FMT_LEV2), tablelen(DED_DISP_FMT_LEV3), tablelen(DED_DISP_FMT_LEV4))

--
pages_by_mode[DED_DISP_FMT_LEV1.OFF]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.OFF

pages_by_mode[DED_DISP_FMT_LEV1.CNI]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CNI

pages_by_mode[DED_DISP_FMT_LEV1.COM_1]		[DED_DISP_FMT_LEV2.COM_1]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.COM_1
pages_by_mode[DED_DISP_FMT_LEV1.COM_1]		[DED_DISP_FMT_LEV2.COM_1_GUARD]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.COM_1_GUARD

pages_by_mode[DED_DISP_FMT_LEV1.COM_2]		[DED_DISP_FMT_LEV2.COM_2]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.COM_2
pages_by_mode[DED_DISP_FMT_LEV1.COM_2]		[DED_DISP_FMT_LEV2.COM_2_GUARD]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.COM_2_GUARD

pages_by_mode[DED_DISP_FMT_LEV1.IFF]		[DED_DISP_FMT_LEV2.IFF_MAIN_STAT]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.IFF_MAIN_STAT
pages_by_mode[DED_DISP_FMT_LEV1.IFF]		[DED_DISP_FMT_LEV2.IFF_MAIN_POS]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.IFF_MAIN_POS
pages_by_mode[DED_DISP_FMT_LEV1.IFF]		[DED_DISP_FMT_LEV2.IFF_MAIN_TIM]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.IFF_MAIN_TIM
pages_by_mode[DED_DISP_FMT_LEV1.IFF]		[DED_DISP_FMT_LEV2.IFF_BACKUP]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.IFF_BACKUP

pages_by_mode[DED_DISP_FMT_LEV1.LIST]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.LIST

pages_by_mode[DED_DISP_FMT_LEV1.T_ILS]		[DED_DISP_FMT_LEV2.T_ILS_PRIMARY]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.T_ILS_PRIMARY
pages_by_mode[DED_DISP_FMT_LEV1.T_ILS]		[DED_DISP_FMT_LEV2.T_ILS_BACKUP]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.T_ILS_BACKUP

pages_by_mode[DED_DISP_FMT_LEV1.ALOW]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.ALOW

pages_by_mode[DED_DISP_FMT_LEV1.STPT]		[DED_DISP_FMT_LEV2.STPT]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.STPT
pages_by_mode[DED_DISP_FMT_LEV1.STPT]		[DED_DISP_FMT_LEV2.STPT_BACKUP]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.STPT_BACKUP

pages_by_mode[DED_DISP_FMT_LEV1.CRUS]		[DED_DISP_FMT_LEV2.CRUS_TOS]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CRUS_TOS
pages_by_mode[DED_DISP_FMT_LEV1.CRUS]		[DED_DISP_FMT_LEV2.CRUS_RNG]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CRUS_RNG
pages_by_mode[DED_DISP_FMT_LEV1.CRUS]		[DED_DISP_FMT_LEV2.CRUS_EDR]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CRUS_EDR
pages_by_mode[DED_DISP_FMT_LEV1.CRUS]		[DED_DISP_FMT_LEV2.CRUS_HOME]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CRUS_HOME

pages_by_mode[DED_DISP_FMT_LEV1.TIME]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.TIME

pages_by_mode[DED_DISP_FMT_LEV1.MARK]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.MARK

pages_by_mode[DED_DISP_FMT_LEV1.FIX]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.FIX

pages_by_mode[DED_DISP_FMT_LEV1.A_CAL]		[DED_DISP_FMT_LEV2.A_CAL_MAN]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.A_CAL_MAN
pages_by_mode[DED_DISP_FMT_LEV1.A_CAL]		[DED_DISP_FMT_LEV2.A_CAL_AUTO]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.A_CAL_AUTO

pages_by_mode[DED_DISP_FMT_LEV1.DEST]		[DED_DISP_FMT_LEV2.DEST_UTM_DIR]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DEST_UTM_DIR
pages_by_mode[DED_DISP_FMT_LEV1.DEST]		[DED_DISP_FMT_LEV2.DEST_DIR]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DEST_DIR
pages_by_mode[DED_DISP_FMT_LEV1.DEST]		[DED_DISP_FMT_LEV2.DEST_OA1]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DEST_OA1
pages_by_mode[DED_DISP_FMT_LEV1.DEST]		[DED_DISP_FMT_LEV2.DEST_OA2]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DEST_OA2

pages_by_mode[DED_DISP_FMT_LEV1.BINGO]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.BINGO

pages_by_mode[DED_DISP_FMT_LEV1.VIP]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.VIP

pages_by_mode[DED_DISP_FMT_LEV1.NAV]		[DED_DISP_FMT_LEV2.NAV_STATUS]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.NAV_STATUS
pages_by_mode[DED_DISP_FMT_LEV1.NAV]		[DED_DISP_FMT_LEV2.NAV_COMMANDS]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.NAV_COMMANDS

pages_by_mode[DED_DISP_FMT_LEV1.MAN]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.MAN

pages_by_mode[DED_DISP_FMT_LEV1.INS]		[DED_DISP_FMT_LEV2.INS]					[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.INS
pages_by_mode[DED_DISP_FMT_LEV1.INS]		[DED_DISP_FMT_LEV2.INS_INFLT_ALGN]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.INS_INFLT_ALGN

pages_by_mode[DED_DISP_FMT_LEV1.CMDS]		[DED_DISP_FMT_LEV2.CMDS_BINGO]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CMDS_BINGO
pages_by_mode[DED_DISP_FMT_LEV1.CMDS]		[DED_DISP_FMT_LEV2.CMDS_CHAFF]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CMDS_CHAFF
pages_by_mode[DED_DISP_FMT_LEV1.CMDS]		[DED_DISP_FMT_LEV2.CMDS_FLARE]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CMDS_FLARE
pages_by_mode[DED_DISP_FMT_LEV1.CMDS]		[DED_DISP_FMT_LEV2.CMDS_OTHER_1]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CMDS_OTHER_1
pages_by_mode[DED_DISP_FMT_LEV1.CMDS]		[DED_DISP_FMT_LEV2.CMDS_OTHER_2]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CMDS_OTHER_2

pages_by_mode[DED_DISP_FMT_LEV1.MODE]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.MODE

pages_by_mode[DED_DISP_FMT_LEV1.VRP]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.VRP

pages_by_mode[DED_DISP_FMT_LEV1.DLNK]		[DED_DISP_FMT_LEV2.DLNK_NET_STATUS]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DLNK_NET_STATUS
pages_by_mode[DED_DISP_FMT_LEV1.DLNK]		[DED_DISP_FMT_LEV2.DLNK_LINK16]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DLNK_LINK16
pages_by_mode[DED_DISP_FMT_LEV1.DLNK]		[DED_DISP_FMT_LEV2.DLNK_LINK16_STN]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DLNK_LINK16_STN
pages_by_mode[DED_DISP_FMT_LEV1.DLNK]		[DED_DISP_FMT_LEV2.DLNK_AG_DL]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DLNK_AG_DL
pages_by_mode[DED_DISP_FMT_LEV1.DLNK]		[DED_DISP_FMT_LEV2.DLNK_INTRAFLIGHT]	[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DLNK_INTRAFLIGHT

pages_by_mode[DED_DISP_FMT_LEV1.MISC]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.MISC

pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_HUD_1]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_HUD_1
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_HUD_2]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_HUD_2
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_CTVS_1]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_CTVS_1
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_CTVS_2]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_CTVS_2
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_CAMERA]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_CAMERA
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_FLIR]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_FLIR
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_LT_HDPT]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_LT_HDPT
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_RT_HDPT]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_RT_HDPT
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_INS]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_INS
pages_by_mode[DED_DISP_FMT_LEV1.CORR]		[DED_DISP_FMT_LEV2.CORR_FCR]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.CORR_FCR

pages_by_mode[DED_DISP_FMT_LEV1.MAGV]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.MAGV

pages_by_mode[DED_DISP_FMT_LEV1.OFP]		[DED_DISP_FMT_LEV2.OFP_1]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.OFP_1
pages_by_mode[DED_DISP_FMT_LEV1.OFP]		[DED_DISP_FMT_LEV2.OFP_2]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.OFP_2

pages_by_mode[DED_DISP_FMT_LEV1.INSM]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.INSM

pages_by_mode[DED_DISP_FMT_LEV1.LASER]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.LASER

pages_by_mode[DED_DISP_FMT_LEV1.GPS]		[DED_DISP_FMT_LEV2.GPS_INIT_1]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.GPS_INIT_1
pages_by_mode[DED_DISP_FMT_LEV1.GPS]		[DED_DISP_FMT_LEV2.GPS_INIT_2]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.GPS_INIT_2

pages_by_mode[DED_DISP_FMT_LEV1.DRNG]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.DRNG

pages_by_mode[DED_DISP_FMT_LEV1.BULLSEYE]	[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.BULLSEYE

pages_by_mode[DED_DISP_FMT_LEV1.HARM]		[DED_DISP_FMT_LEV2.HARM]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HARM
pages_by_mode[DED_DISP_FMT_LEV1.HARM]		[DED_DISP_FMT_LEV2.HARM_PG1]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HARM_PG1
pages_by_mode[DED_DISP_FMT_LEV1.HARM]		[DED_DISP_FMT_LEV2.HARM_PG2]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HARM_PG2

pages_by_mode[DED_DISP_FMT_LEV1.INTG]		[DED_DISP_FMT_LEV2.NONE]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.INTG

pages_by_mode[DED_DISP_FMT_LEV1.HMCS]		[DED_DISP_FMT_LEV2.HMCS_DISPLAY]		[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HMCS_DISPLAY
pages_by_mode[DED_DISP_FMT_LEV1.HMCS]		[DED_DISP_FMT_LEV2.HMCS_ALIGN]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HMCS_ALIGN

pages_by_mode[DED_DISP_FMT_LEV1.HTS]		[DED_DISP_FMT_LEV2.HTS_MAN]				[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HTS_MAN
pages_by_mode[DED_DISP_FMT_LEV1.HTS]		[DED_DISP_FMT_LEV2.HTS_SEAD]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HTS_SEAD
pages_by_mode[DED_DISP_FMT_LEV1.HTS]		[DED_DISP_FMT_LEV2.HTS_SEAD_DL]			[DED_DISP_FMT_LEV3.NONE]	[DED_DISP_FMT_LEV4.NONE]	= id_Page.HTS_SEAD_DL

--
function get_page_by_mode(master, L2, L3, L4)
	return get_page_by_mode_global(pages_by_mode, init_pageID, master, L2, L3, L4)
end
