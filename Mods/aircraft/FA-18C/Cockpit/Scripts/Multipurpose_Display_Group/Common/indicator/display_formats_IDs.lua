local count = -1
local function counter()
	count = count + 1
	return count
end
local function reset_counter()
	count = -1
end


reset_counter()
-- just a copy from MDG_DisplayFormats_F18.h
MDG_DISPL_FMT_LEV1 =
{
	NONE			= counter(),
	STANDBY			= counter(),
	HUD				= counter(),
	MENU			= counter(),
	ADI				= counter(),
	AZ_EL			= counter(),
	BIT				= counter(),
	CHECKLISTS		= counter(),
	ENG				= counter(),
	EW				= counter(),
	FCS				= counter(),
	FLIR			= counter(),
	FPAS			= counter(),
	FUEL			= counter(),
	HSI				= counter(),
	HSI_AMPCD		= counter(),
	MUMI			= counter(),
	RDR				= counter(),
	SA				= counter(),
	SA_AMPCD		= counter(),
	STORES			= counter(),
	UFC_BU			= counter(),
	SPIN			= counter(),
	MAV				= counter(),
	ACL				= counter(),
	UTM_GRID		= counter(),
	WEAPON			= counter(),
	HMD				= counter(),
	MIDS			= counter(),
	HARM			= counter(),
	TGT_DATA		= counter(),
	JDAM_JSOW		= counter(),
	MISSION_DATA	= counter(),
	SLAM			= counter(),
	WALLEYE			= counter(),
	DATALINK		= counter(),
	JPF				= counter(),
}

reset_counter()
MDG_DISPL_FMT_LEV2 =
{
	NONE				= counter(),
	
	HUD_NAV				= counter(),
	HUD_AA				= counter(),
	HUD_AG				= counter(),
	HUD_HMD_ALIGN		= counter(),
	
	MENU_SUPT			= counter(),
	MENU_TAC			= counter(),
	
	HSI_MAIN			= counter(),
	HSI_DATA			= counter(),
	
	BIT_MAIN			= counter(),
	BIT_COMM			= counter(),
	BIT_DISPLAYS		= counter(),
	BIT_EW				= counter(),
	BIT_FCS_MC			= counter(),
	BIT_NAV				= counter(),
	BIT_SENSORS			= counter(),
	BIT_STAT_MON		= counter(),
	BIT_STORES			= counter(),
	SW_CONFIG			= counter(), -- is called from BIT format
	
	RDR_AA				= counter(),
	RDR_AG				= counter(),
	
	EW_MAIN				= counter(),
	EW_MAIN_RWR			= counter(),
	EW_PROG				= counter(),
	
	HMD_REJECT			= counter(),
	HMD_MIDS			= counter(),

	HARM_SP				= counter(),
	HARM_TOO			= counter(),
	HARM_PB				= counter(),
	HARM_CLASS			= counter(),
	HARM_SCAN			= counter(),

	TGT_DATA_OWNSHIP	= counter(),
	TGT_DATA_GROUP		= counter(),
	
	FLIR_AG				= counter(),
	FLIR_AA				= counter(),
	FLIR_LSS			= counter(),
}

reset_counter()
MDG_DISPL_FMT_LEV3 =
{
	NONE			= counter(),
	BACKUP			= counter(),
	-- HSI / DATA
	AC				= counter(),
	WYPT			= counter(),
	TCN				= counter(),
	GRID			= counter(),
	-- RDR
	DATA			= counter(),
	AGR				= counter(), --Alyona
}

reset_counter()
MDG_DISPL_FMT_LEV4 =
{
	NONE			= counter(),
	DATA			= counter(),
}
