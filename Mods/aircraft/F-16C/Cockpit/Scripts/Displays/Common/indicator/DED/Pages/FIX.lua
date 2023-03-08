
local ASTERISKS_POSITION = 
{
	NONE = 0;
	FIX_SENSORS = 1;
	STPT_NUMBER = 2;
}

addText("FIX_SENSORS", "FIX", {6,0}, nil)
	addText("FIX_SelectedSensors",	"",	{11, 0}, {"DED_FIX_SelectedSensors_Inverse", 1}, nil, {{"DED_FIX_SelectedSensors"}})
	addAsteriscs("Asterisks_FIX_SENSORS", {10, 0}, 4, nil, {{"DED_FIX_AsterisksPos", ASTERISKS_POSITION.FIX_SENSORS}})

addText("FIX_STPT", "STPT", {4,1}, nil)
	addText("INS_SelectedSteerpoint",	"",		{10, 1}, {"DED_FIX_DataEntry_Inv", ASTERISKS_POSITION.STPT_NUMBER}, nil, {{"DED_FIX_WPT_Num"}})
	addAsteriscs("Asterisks_STPT_NUMBER", {9, 1}, 3, nil, {{"DED_FIX_AsterisksPos", ASTERISKS_POSITION.STPT_NUMBER}})
	addText("INS_STPT_IncDecSymbol",	"a",	{14, 1})
	
addText("FIX_DELTA", "DELTA", {3,2}, nil)
	addText("DELTA", "XX.XXNM", {13,2}, nil, nil, {{"DED_FIX_Delta"}})
	
addText("SYS ACCURACY label",				"SYS ACCUR",		{4, 3})
	addText("SYS ACCURACY value",				"HIGH",			{14, 3}, nil, nil, {{"DED_FIX_SYS_Accur"}}, {"", "HIGH", "MED", "LOW", "FAIL"})

addText("GPS ACCURACY label",				"GPS ACCUR",		{4, 4})
	addText("GPS ACCURACY value",				"",			{14, 4}, nil, nil, {{"DED_FIX_GPS_Accur"}}, {"", "HIGH", "MED", "LOW", "FAIL"})