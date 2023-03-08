AcftMasterMode =
{
	NONE	= 0,
	NAV		= 1,
	AA		= 2,
	AG		= 3,
	DGFT	= 4,
	MSL		= 5,
	SJ		= 6,
	EJ		= 7,
}

AcftMasterModeLbl =
{
	"",
	"NAV",
	"A-A",
	"A-G",
	"DGFT",
	"MSL",
	"S-J",
	"E-J",
}

AcftSubMode = 
{
	NONE	= 0,
	NAV		= 1,
	DGFT_E	= 2,
	DGFT_L	= 3,
	MSL		= 4,
	AAM		= 5,
	SRM		= 6,
	MRM		= 7,
	EEGS	= 8,
	LCOS	= 9,
	SNAP	= 10,
	STRF	= 11,
	CCIP	= 12,
	DTOS	= 13,
	CCRP	= 14,
	LADD	= 15,
	MAN		= 16,
	PRE		= 17,
	VIS		= 18,
	BORE	= 19,
	HARM	= 20,
	HARM_POS = 21,
	S_J		= 22,
	E_J		= 23,
	HTS		= 24,
}

AcftSubModeLbl = 
{
	"",
	"NAV",
	"EEGS",
	"LCOS",
	"MSL",
	"AAM",
	"SRM",
	"MRM",
	"EEGS",
	"LCOS",
	"SNAP",
	"STRF",
	"CCIP",
	"DTOS",
	"CCRP",
	"LADD",
	"MAN",
	"PRE",
	"VIS",
	"BORE",
	"HARM",
	"HARM",
	"S-J",
	"E-J",
	"HTS",
	"VRPCRP",
	"VIPCRP",
}

HarmMode = 
{
	NONE 	= 0,
	POS 	= 1,
	HAS 	= 2,
	DL 		= 3,
}

HarmModeLbl = 
{
	"",
	"POS",
	"HAS",
	"DL",
}

HarmFlightProfile =
{
	NONE	= 0,
	EOM		= 1,
	RUK		= 2,
	PB		= 3,
}

HarmFlightProfileLabel = 
{
	"",
	"EOM",
	"RUK",
	"PB",
}

HarmFOVSelection = 
{
	NONE 	= 0,
	CTR 	= 1,
	LT 		= 2,
	RT 		= 3,
	WIDE 	= 4,
}

HarmFOVSelectionLabel =
{
	"",
	"CTR",
	"LT",
	"RT",
	"WIDE",
}

HarmThreatTablesLabel = 
{
	"",
	"TBL1",
	"TBL2",
	"TBL3",
	"TBL4",
	"TBL5",
}

JDAMSybModes = 
{
	NONE 	= 0,
	PRE 	= 1,
	VIS		= 2,
}

JDAMSubModesLabel =
{
	"",
	"PRE",
	"VIS",
}

JSOWSubModesLabel = 
{
	"",
	"PRE",
	"VIS",
}

WCMDSubModesLabel = 
{
	"",
	"PRE",
	"VIS",
}

-- Waypoints
WPT_Types = 
{
	BLANK			= 0,
	STPT			= 1,
	STPT_SELECTED	= 2,
	OA1				= 3,
	OA2				= 4,
}

-- HUD Window 7 Mode
HUD_Window7_Type =
{
	BLANK				= 0,
	ALIGN_STATUS		= 1,	-- STBY, ALIGN, MAN
	BALLISTIC_MODE		= 2,	-- MBAL, DRNG
	SYSTEM_ACCURACY		= 3,	-- SYS M, SYS L, SYS F
	MAX_G				= 4,
}
