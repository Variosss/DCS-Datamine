-- just a copy from DED_Formats_F16.h

local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
DED_DISP_FMT_LEV1 =
{
	OFF			= counter(),

	CNI			= counter(),
	
	COM_1		= counter(),
	COM_2		= counter(),
	IFF			= counter(),
	LIST		= counter(),
	T_ILS		= counter(),
	ALOW		= counter(),
	STPT		= counter(),
	CRUS		= counter(),
	TIME		= counter(),
	MARK		= counter(),
	FIX			= counter(),
	A_CAL		= counter(),

	DEST		= counter(),
	BINGO		= counter(),
	VIP			= counter(),
	NAV			= counter(),
	MAN			= counter(),
	INS			= counter(),
	CMDS		= counter(),
	MODE		= counter(),
	VRP			= counter(),
	DLNK		= counter(),
	MISC		= counter(),

	CORR		= counter(),
	MAGV		= counter(),
	OFP			= counter(),
	INSM		= counter(),
	LASER		= counter(),
	GPS			= counter(),
	DRNG		= counter(),
	BULLSEYE	= counter(),
	HARM		= counter(),

	INTG		= counter(),
	
	HMCS		= counter(),
	HTS			= counter(),
}

count = -1
DED_DISP_FMT_LEV2 =
{
	NONE				= counter(),

	COM_1				= counter(),
	COM_1_GUARD			= counter(),

	COM_2				= counter(),
	COM_2_GUARD			= counter(),

	IFF_MAIN_STAT		= counter(),
	IFF_MAIN_POS		= counter(),
	IFF_MAIN_TIM		= counter(),
	IFF_BACKUP			= counter(),

	T_ILS_PRIMARY		= counter(),
	T_ILS_BACKUP		= counter(),

	STPT				= counter(),
	STPT_BACKUP			= counter(),

	CRUS_TOS			= counter(),
	CRUS_RNG			= counter(),	
	CRUS_EDR			= counter(),	
	CRUS_HOME			= counter(),

	A_CAL_MAN			= counter(),
	A_CAL_AUTO			= counter(),

	DEST_UTM_DIR		= counter(),
	DEST_DIR			= counter(),
	DEST_OA1			= counter(),
	DEST_OA2			= counter(),

	NAV_STATUS			= counter(),
	NAV_COMMANDS		= counter(),

	INS					= counter(),
	INS_INFLT_ALGN		= counter(),

	CMDS_BINGO			= counter(),
	CMDS_CHAFF			= counter(),
	CMDS_FLARE			= counter(),
	CMDS_OTHER_1		= counter(),
	CMDS_OTHER_2		= counter(),

	DLNK_NET_STATUS		= counter(),
	DLNK_LINK16			= counter(),
	DLNK_LINK16_STN		= counter(),
	DLNK_AG_DL			= counter(),
	DLNK_INTRAFLIGHT	= counter(),

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

	OFP_1				= counter(),
	OFP_2				= counter(),

	GPS_INIT_1			= counter(),
	GPS_INIT_2			= counter(),

	HARM				= counter(),
	HARM_PG1			= counter(),
	HARM_PG2			= counter(),
	
	HMCS_DISPLAY		= counter(),
	HMCS_ALIGN			= counter(),
	
	HTS_MAN				= counter(),
	HTS_SEAD			= counter(),
	HTS_SEAD_DL			= counter(),
}

DED_DISP_FMT_LEV3 =
{
	NONE			= 0,
}

DED_DISP_FMT_LEV4 =
{
	NONE			= 0,
}