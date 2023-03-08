dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/CRUS/CRUS_COMMON.lua")

local ASTERISKS_POSITION = 
{
	NONE 		= 0,
	CRUS_MODE 	= 1,
	DES_TOS		= 2,
}

addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

addText("TOS_MODE",	"TOS",	{13, 0}, {"DED_CRUS_TOS_MODE_ModeHighlight"})

	addAsteriscs("Asterisks_TOS_MODE",{12, 0}, 3, nil, {{"DED_CRUS_AsterisksPos", ASTERISKS_POSITION.CRUS_MODE}})

addText("TOS_SYSTEM_TIME_label",	"TIME",	{7, 1})
	addText("TOS_SYSTEM_TIME_value",	"XX:XX:XX",	{13, 1}, nil, nil,  {{"DED_CRUS_TOS_SystemTime"}})
	
addText("TOS_DES_TOS_label",	"DES TOS",	{4, 2})
	addText("TOS_DES_TOS_value",	"XX:XX:XX",	{13, 2}, {"DED_CRUS_TOS_DataEntry_Inv", ASTERISKS_POSITION.DES_TOS}, nil,  {{"DED_CRUS_TOS_DES_TOS"}})
	addAsteriscs("Asterisks_DES_TOS",{12, 2}, 8, nil, {{"DED_CRUS_AsterisksPos", ASTERISKS_POSITION.DES_TOS}})
	
addText("TOS_ETA_label",	"ETA",	{8, 3})
	addText("TOS_ETA_value",	"XX:XX:XX",	{13, 3}, nil, nil,  {{"DED_CRUS_TOS_ETA"}})
	
addText("TOS_REQ_GS_label",	"REQ G/S",	{4, 4})
	addText("TOS_REQ_GS_value",	"",	{13, 4}, nil, nil,  {{"DED_CRUS_TOS_REQ_GS"}})