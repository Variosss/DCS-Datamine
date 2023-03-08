-- Page Label
local DED_HMCS_ALIGN_ROOT = addLocalPlaceholder("DED_HMCS_ALIGN_ROOT", nil)

-- STPT
addText("INS_SelectedSteerpoint",	"",		{19, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

local alignNames = 
{
	COARSE = 0,
	AZ_EL = 1,
	ROLL = 2
}


addText("HMCS_ALIGN_TOPIC", "HMCS ALIGN", 	{6,0}, nil, DED_HMCS_ALIGN_ROOT.name)

addText("HMCS_COARSE", "COARSE", 			{2, 1}, {"DED_HMCS_ALIGN_COARSE_Highlight"}, DED_HMCS_ALIGN_ROOT.name)
	addAsteriscs("Asterisks_COARSE",		{1, 1}, 6, DED_HMCS_ALIGN_ROOT.name, {{"DED_HMCS_AsterisksPos", alignNames.COARSE}})	
addText("HMCS_AZ_EL", "AZ/EL", 				{2, 2}, {"DED_HMCS_ALIGN_AZ_EL_Highlight"}, DED_HMCS_ALIGN_ROOT.name)
	addAsteriscs("Asterisks_AZ_ELAZ_EL",	{1, 2}, 5, DED_HMCS_ALIGN_ROOT.name, {{"DED_HMCS_AsterisksPos", alignNames.AZ_EL}})	
addText("HMCS_ROLL", "ROLL", 				{2, 3}, {"DED_HMCS_ALIGN_ROLL_Highlight"}, DED_HMCS_ALIGN_ROOT.name)
	addAsteriscs("Asterisks_ROLL",			{1, 3}, 4, DED_HMCS_ALIGN_ROOT.name, {{"DED_HMCS_AsterisksPos", alignNames.ROLL}})	