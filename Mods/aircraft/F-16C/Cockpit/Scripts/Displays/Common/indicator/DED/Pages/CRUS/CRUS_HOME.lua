dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/CRUS/CRUS_COMMON.lua")

local ASTERISKS_POSITION = 
{
	NONE 		= 0,
	CRUS_MODE 	= 1,
	STPT_NUM	= 2,
}

addText("HOME_MODE",	"HOME",	{13, 0}, {"DED_CRUS_HOME_MODE_ModeHighlight"})
	addAsteriscs("Asterisks_RNG_MODE",{12, 0}, 4, nil, {{"DED_CRUS_AsterisksPos", ASTERISKS_POSITION.CRUS_MODE}})

addText("HOME_STPT_NUM",	"HMPT",	{7, 1})
	addAsteriscs("Asterisks_HOME_STPT_NUM",{11, 1}, 5, nil, {{"DED_CRUS_AsterisksPos", ASTERISKS_POSITION.STPT_NUM}})
	addText("HOME_INS_SelectedSteerpoint",	"",		{12, 1}, {"DED_CRUS_HOME_DataEntry_Inv", ASTERISKS_POSITION.STPT_NUM}, nil, {{"DED_CRUS_WPT_Num"}})
	addText("HOME_INS_STPT_IncDecSymbol",	"a",	{16, 1})

addText("HOME_FUEL_REMANING",	"FUEL",	{7, 2})
	addText("HOME_FUEL_REMANING_Value",	"",	{12, 2}, nil, nil, {{"DED_CRUS_HOME_Fuel"}})

addText("HOME_OPT_ALT_label",	"OPT ALT",	{4, 3})
	addText("HOME_OPT_ALT_value", "",	{13, 3}, nil, nil, {{"DED_CRUS_HOME_OPT_ALT"}})
	
addText("HOME_WIND_AT_ALTITUDE",	"WIND",	{7, 4})
	addText("HOME_WIND_AT_ALTITUDE_Value",	"",	{13, 4}, nil, nil, {{"DED_CRUS_RNG_Wind"}}, {"%3do %3dKTS"})