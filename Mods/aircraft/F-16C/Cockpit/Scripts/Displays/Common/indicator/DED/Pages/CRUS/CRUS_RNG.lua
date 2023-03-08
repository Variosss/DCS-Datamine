dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/CRUS/CRUS_COMMON.lua")

addText("RNG_MODE",	"RNG",	{13, 0}, {"DED_CRUS_RNG_MODE_ModeHighlight"})
addAsteriscs("Asterisks_RNG_MODE",{12, 0}, 3, nil, {{"DED_CRUS_AsterisksPos", 1}})

addText("RNG_STPT_NUM",	"STPT",	{7, 1})
addText("RNG_INS_SelectedSteerpoint",	"",		{12, 1}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("RNG_INS_STPT_IncDecSymbol",	"a",	{16, 1})

addText("RNG_FUEL_REMANING",	"FUEL",	{7, 2})
	addText("RNG_FUEL_REMANING_Value",	"",	{12, 2}, nil, nil, {{"DED_CRUS_RNG_Fuel"}})

addText("RNG_WIND_AT_ALTITUDE",	"WIND",	{7, 4})
	addText("RNG_WIND_AT_ALTITUDE_Value",	"",	{13, 4}, nil, nil, {{"DED_CRUS_RNG_Wind"}}, {"%3do %3dKTS"})