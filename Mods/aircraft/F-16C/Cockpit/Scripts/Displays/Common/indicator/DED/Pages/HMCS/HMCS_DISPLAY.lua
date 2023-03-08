-- Page Label
addText("HMCS_DISPLAY_label", "HMCS DISPLAY", 	{6, 0})

-- STPT
addText("INS_SelectedSteerpoint",	"",		{19, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

local ASTERISKS_POS = 
{
	HUD_BLANK = 0,
	CKPT_BLANK = 1,
	DECLUTTER = 2,
	RWR_DISPLAY = 3
}

local DED_HMCS_DISPLAY_ROOT = addLocalPlaceholder("DED_HMCS_DISPLAY_ROOT", nil)

addText("HMCS_DISPLAY_TOPIC", "HMCS DISPLAY", 	{6, 0}, nil, DED_HMCS_DISPLAY_ROOT.name)

addText("HMCS_HUD_BLANK", "HUD BLNK", 			{2, 1}, {"DED_HMCS_HUD_BLNK_Highlight"}, DED_HMCS_DISPLAY_ROOT.name)
	addAsteriscs("Asterisks_HUD_BLANK",			{1, 1}, 8, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_AsterisksPos", ASTERISKS_POS.HUD_BLANK}})	
addText("HMCS_CKPT_BLANK", "CKPT BLNK", 		{2, 2}, {"DED_HMCS_CKPT_BLNK_Highlight"}, DED_HMCS_DISPLAY_ROOT.name)
	addAsteriscs("Asterisks_CKPT_BLANK",		{1, 2}, 9, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_AsterisksPos", ASTERISKS_POS.CKPT_BLANK}})	
addText("HMCS_DECLUTTER", "DECLUTTER  LVL", 	{2, 3}, nil, DED_HMCS_DISPLAY_ROOT.name)
addText("HMCS_DECLUTTER_STATUS", "1",			{16, 3}, nil, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_DECLUTTER"}})
	addAsteriscs("Asterisks_DECLUTTER",			{11,3}, 5, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_AsterisksPos", ASTERISKS_POS.DECLUTTER}})	
addText("HMCS_RWR_DISPLAY", "RWR DSPLY", 		{2, 4}, nil, DED_HMCS_DISPLAY_ROOT.name)	
addText("HMCS_RWR_DISPLAY_STATUS", "XXX", 		{12, 4}, nil, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_RWR_DSPLY"}})
	addAsteriscs("Asterisks_RWR_DISPLAY",		{11,4}, 3, DED_HMCS_DISPLAY_ROOT.name, {{"DED_HMCS_AsterisksPos", ASTERISKS_POS.RWR_DISPLAY}})	