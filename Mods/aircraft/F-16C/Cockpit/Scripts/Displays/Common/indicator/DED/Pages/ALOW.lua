local ASTERISKS_POS =
{
	CARA_ALOW	= 0;
	MSL_FLOOR	= 1;
}

addText("ALOW label",				"ALOW",			{10, 0})

-- STPT
addText("Selected Steerpoint",		"",				{19, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("WPT IncDecSymbol",			"a",			{23, 0}, nil, nil, {{"DED_CNI_IncDecSymbolPos", 0}})

-- CARA ALOW
addText("CARA ALOW label",			"CARA ALOW",	{3, 2})
addText("CARA ALOW Scratchpad",		" 1000FT",		{15, 2}, {"DED_ALOW_DataEntry_Inv", ASTERISKS_POS.CARA_ALOW}, nil, {{"DED_ALOW_CARA_ALOW_Scratchpad"}})
addAsteriscs("CARA ALOW Asterisks",					{14, 2}, 7, nil, {{"DED_ALOW_AsterisksPos", ASTERISKS_POS.CARA_ALOW}})

-- MSL FLOOR
addText("MSL FLOOR label",			"MSL FLOOR",	{3, 3})
addText("MSL FLOOR Scratchpad",		"20000FT",		{15, 3}, {"DED_ALOW_DataEntry_Inv", ASTERISKS_POS.MSL_FLOOR}, nil, {{"DED_ALOW_MSL_FLOOR_Scratchpad"}})
addAsteriscs("MSL FLOOR Asterisks",					{14, 3}, 7, nil, {{"DED_ALOW_AsterisksPos", ASTERISKS_POS.MSL_FLOOR}})
