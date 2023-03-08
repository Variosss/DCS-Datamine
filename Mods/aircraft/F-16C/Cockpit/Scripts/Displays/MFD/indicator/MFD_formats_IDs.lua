local count = -1
local function counter()
	count = count + 1
	return count
end
MFD_DISPL_FMT_LEV1 =
{
	NONE            = counter(),
	STANDBY			= counter(),
	FCR         	= counter(),
	WPN         	= counter(),
	SMS         	= counter(),
	IFF         	= counter(),
	DTE         	= counter(),
	TEST       		= counter(),
	FLCS        	= counter(),
	HSD         	= counter(),
	MENU         	= counter(),
	BLANK         	= counter(),
	INIT         	= counter(),
	TCN				= counter(),
	TGP				= counter(),
	HAD				= counter(),
}

count = -1
MFD_DISPL_FMT_LEV2 =
{
	NONE			= counter(),
 	
	FCR_STBY		= counter(),
	FCR_AA			= counter(),
	FCR_AG			= counter(),
	
	SMS_INV			= counter(),
	SMS_AAM			= counter(),
	SMS_MSL			= counter(),
	SMS_DGFT		= counter(),
	SMS_GUN			= counter(),
	SMS_AG			= counter(),
	
	TGP_AA			= counter(),
	TGP_AG			= counter(),
	
	DATA_ENTRY		= counter(),
	
	WPN_MAV			= counter(),
	WPN_HARM		= counter(),
}

count = -1
MFD_DISPL_FMT_LEV3 =
{
	NONE			= counter(),
	OFF				= counter(),
	CNTL			= counter(),
	WPN_HARM_HAS	= counter(),
	WPN_HARM_POS	= counter(),
	THRT			= counter(),
}

count = -1
MFD_DISPL_FMT_LEV4 =
{
	NONE			= counter(),
}