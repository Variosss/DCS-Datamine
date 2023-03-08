local ASTERISKS_POS =
{
	BQ		= 0,
	BI		= 1,
	SQ		= 2,
	SI		= 3,
}

-- PROG number
addText("CMDS_Prog_label",			"PROG",			{15, 0})
addText("CMDS_Selected_Program",	"",				{21, 0}, nil, nil, {{"DED_CMDS_PROG_Num"}})
addText("CMDS_Prog_IncDecSymbol",	"a",			{23, 0}, nil, nil, {{"DED_CMDS_IncDecSymbolPos", 0}})

-- Bingo scratchpad
addText("CMDS_BQ_lbl",				"BQ",	{6, 1})
addText("CMDS_BQ_Scratchpad",		"",		{10, 1}, {"DED_CMDS_PROG_DataEntry_Inv", ASTERISKS_POS.BQ}, nil, {{"DED_CMDS_BQ_Scratchpad"}})
addAsteriscs("CMDS_BQ_Asterisks",			{9, 1}, 2, nil, {{"DED_CMDS_PROG_AsterisksPos", ASTERISKS_POS.BQ}})

addText("CMDS_BI_lbl",				"BI",	{6, 2})
addText("CMDS_BI_Scratchpad",		"",		{10, 2}, {"DED_CMDS_PROG_DataEntry_Inv", ASTERISKS_POS.BI}, nil, {{"DED_CMDS_BI_Scratchpad", ASTERISKS_POS.BI}})
addAsteriscs("CMDS_BI_Asterisks",			{9, 2}, 6, nil, {{"DED_CMDS_PROG_AsterisksPos", ASTERISKS_POS.BI}})

addText("CMDS_SQ_lbl",				"SQ",	{6, 3})
addText("CMDS_SQ_Scratchpad",		"",		{10, 3}, {"DED_CMDS_PROG_DataEntry_Inv", ASTERISKS_POS.SQ}, nil, {{"DED_CMDS_SQ_Scratchpad"}})
addAsteriscs("CMDS_SQ_Asterisks",			{9, 3}, 2, nil, {{"DED_CMDS_PROG_AsterisksPos", ASTERISKS_POS.SQ}})

addText("CMDS_SI_lbl",				"SI",	{6, 4})
addText("CMDS_SI_Scratchpad",		"",		{10, 4}, {"DED_CMDS_PROG_DataEntry_Inv", ASTERISKS_POS.SI}, nil, {{"DED_CMDS_SI_Scratchpad", ASTERISKS_POS.SI}})
addAsteriscs("CMDS_SI_Asterisks",			{9, 4}, 6, nil, {{"DED_CMDS_PROG_AsterisksPos", ASTERISKS_POS.SI}})
