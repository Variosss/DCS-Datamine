-- Page Label
addText("CMDS_BINGO_label",		"CMDS  BINGO",			{5, 0})

-- STPT
addText("Selected Steerpoint",		"",				{19, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("WPT IncDecSymbol",			"a",			{23, 0})

local ASTERISKS_POS =
{
	CH		= 0,
	FL		= 1,
	O1		= 2,
	O2		= 3,
	FDBK	= 4,
	REQCTR	= 5,
	BINGO	= 6
}
-- Bingo scratchpad
addText("CMDS_CH_lbl",				"CH",	{2, 1})
addText("CMDS_CH_Scratchpad",		"20",	{7, 1}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.CH}, nil, {{"DED_CMDS_BINGO_CH_Scratchpad"}})
addAsteriscs("CMDS_CH_Asterisks",			{6, 1}, 2, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.CH}})

addText("CMDS_FL_lbl",				"FL",	{2, 2})
addText("CMDS_FL_Scratchpad",		"10",	{7, 2}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.FL}, nil, {{"DED_CMDS_BINGO_FL_Scratchpad"}})
addAsteriscs("CMDS_FL_Asterisks",			{6, 2}, 2, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.FL}})

addText("CMDS_O1_lbl",				"O1",	{2, 3})
addText("CMDS_O1_Scratchpad",		"10",	{7, 3}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.O1}, nil, {{"DED_CMDS_BINGO_O1_Scratchpad"}})
addAsteriscs("CMDS_O1_Asterisks",			{6, 3}, 2, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.O1}})

addText("CMDS_O2_lbl",				"O2",	{2, 4})
addText("CMDS_O2_Scratchpad",		"10",	{7, 4}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.O2}, nil, {{"DED_CMDS_BINGO_O2_Scratchpad"}})
addAsteriscs("CMDS_O2_Asterisks",			{6, 4}, 2, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.O2}})

addText("CMDS_FDBK_lbl",			"FDBK",		{11, 2})
addText("CMDS_FDBK_value",			nil,		{19, 2}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.FDBK}, nil, {{"DED_CMDS_FDBK_Value"}}, {"OFF", "ON"})
addAsteriscs("CMDS_FDBK_Asterisks",				{18, 2}, 3, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.FDBK}})

addText("CMDS_REQCTR_lbl",			"REQCTR",	{11, 3})
addText("CMDS_REQCTR_value",		nil,		{19, 3}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.REQCTR}, nil, {{"DED_CMDS_REQCTR_Value"}}, {"OFF", "ON"})
addAsteriscs("CMDS_REQCTR_Asterisks",			{18, 3}, 3, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.REQCTR}})

addText("CMDS_BINGO_lbl",			"BINGO",	{11, 4})
addText("CMDS_BINGO_value",			nil,		{19, 4}, {"DED_CMDS_BINGO_DataEntry_Inv", ASTERISKS_POS.BINGO}, nil, {{"DED_CMDS_BINGO_Value"}}, {"OFF", "ON"})
addAsteriscs("CMDS_BINGO_Asterisks",			{18, 4}, 3, nil, {{"DED_CMDS_BINGO_AsterisksPos", ASTERISKS_POS.BINGO}})
