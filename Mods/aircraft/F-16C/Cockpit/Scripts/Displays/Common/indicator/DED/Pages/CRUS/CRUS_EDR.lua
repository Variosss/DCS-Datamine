dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/CRUS/CRUS_COMMON.lua")

addText("EDR_MODE",	"EDR",	{13, 0}, {"DED_CRUS_EDR_MODE_ModeHighlight"})
addAsteriscs("Asterisks_RNG_MODE",{12, 0}, 3, nil, {{"DED_CRUS_AsterisksPos", 1}})

addText("EDR_STPT_NUM",	"STPT",	{7, 1})
addText("EDR_INS_SelectedSteerpoint",	"",		{12, 1}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("EDR_INS_STPT_IncDecSymbol",	"a",	{16, 1})

addText("EDR_TO_BINGO_label",	"TO BNGO",	{4, 2})
	addText("EDR_TO_BINGO_value",	"XX:XX:XX",	{13, 2}, nil, nil, {{"DED_CRUS_EDR_TOBNGO"}})
	
addText("EDR_OPT_MACH_label",	"OPT MACH",	{3, 3})
	addText("EDR_OPT_MACH_value", "",	{13, 3}, nil, nil, {{"DED_CRUS_EDR_OPT_MACH"}})

addText("EDR_WIND_AT_ALTITUDE",	"WIND",	{7, 4})
	addText("EDR_WIND_AT_ALTITUDE_Value",	"",	{13, 4}, nil, nil, {{"DED_CRUS_RNG_Wind"}}, {"%3do %3dKTS"})