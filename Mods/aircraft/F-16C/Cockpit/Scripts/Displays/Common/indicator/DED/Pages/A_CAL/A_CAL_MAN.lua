addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

local ASTERISKS_POSITION = 
{
	NONE = 0;
	ACAL_SENSORS = 1;
	ACAL_MODE = 2;
	ELEV = 3;
}

addText("ACAL_SENSORS", "ACAL", {1,0}, nil)
	addText("ACAL_SelectedSensors",	"",	{8, 0}, {"DED_ACAL_SelectedSensors_Inverse", 1}, nil, {{"DED_ACAL_SelectedSensors"}})
	addAsteriscs("Asterisks_ACAL_SENSORS", {7, 0}, 4, nil, {{"DED_ACAL_AsterisksPos", ASTERISKS_POSITION.ACAL_SENSORS}})
	
addText("ACAL_ALT_label",	"",	{14, 0}, nil, nil, {{"DED_ACAL_SelectedType"}})

addText("ACAL_MODE", "MAN", {8,1}, nil, nil, {{"DED_ACAL_SelectedMode"}})
	addAsteriscs("Asterisks_ACAL_SelectedMode", {7, 1}, 4, nil, {{"DED_ACAL_AsterisksPos", ASTERISKS_POSITION.ACAL_MODE}})	
	
addText("ACAL_ALEV", "ELEV", {8,2}, nil)
	addText("ELEV", "XXXXXFT", {16,2},{"DED_ACAL_DataEntry_Inv", ASTERISKS_POSITION.ELEV}, nil, {{"DED_ACAL_Elev_Scratchpad"}})
	addAsteriscs("Asterisks_ELEV", {15, 2}, 7, nil, {{"DED_ACAL_AsterisksPos", ASTERISKS_POSITION.ELEV}})	
	
addText("ACAL_ALT_DELTA", "DELTA", {8,3}, nil)
	addText("ACAL_ALT_DELTA_label",	"ALT",	{2, 3})
	addText("DELTA_ALT", "XXXXXFT", {16,3}, nil, nil, {{"DED_ACAL_ALT_Delta"}})
	
addText("ACAL_POS_DELTA", "DELTA", {8,4}, nil)
	addText("ACAL_POS_DELTA_label",	"POS",	{2, 4})
	addText("DELTA_POS", "XXXXXFT", {16,4}, nil, nil, {{"DED_ACAL_POS_Delta"}})