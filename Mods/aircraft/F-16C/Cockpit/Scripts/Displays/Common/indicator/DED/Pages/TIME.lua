ASTERISKS_POS =
{
	SYSTEM		= 0,
	HACK		= 1,
	DELTA_TOS	= 2,
	DATE		= 3,
}

addText("TIME_label",					"TIME",				{9, 0})

-- System
addText("SYSTEM_label",					"SYSTEM",			{4, 1}, nil, nil, {{"DED_TIME_SystemType", 0}})
addText("GPS_SYSTEM_label",				"GPS SYSTEM",		{0, 1}, nil, nil, {{"DED_TIME_SystemType", 1}})
addText("SYSTEM_value",					"00:00:00",			{13, 1}, {"DED_TIME_DataEntry_Inv", ASTERISKS_POS.SYSTEM}, nil, {{"DED_TIME_SYSTEM_Scratchpad"}})
addAsteriscs("Asterisks_on_SYSTEM",							{12, 1}, 8, nil, {{"DED_TIME_AsterisksPos", ASTERISKS_POS.SYSTEM}})

-- Hack
addText("HACK_label",					"HACK",				{6, 2})
addText("HACK_value",					"00:00:00",			{13, 2}, {"DED_TIME_DataEntry_Inv", ASTERISKS_POS.HACK}, nil, {{"DED_TIME_HACK_Scratchpad"}})
addAsteriscs("Asterisks_on_HACK",							{12, 2}, 8, nil, {{"DED_TIME_AsterisksPos", ASTERISKS_POS.HACK}})
addText("HACK_IncDecSymbol",			"a",				{22, 2})

-- Delta TOS
addText("DELTA_TOS_label",				"DELTA TOS",		{1, 3})
addText("DELTA_TOS_value",				"000:00:00",		{12, 3}, {"DED_TIME_DataEntry_Inv", ASTERISKS_POS.DELTA_TOS}, nil, {{"DED_TIME_DELTA_TOS_Scratchpad"}})
addAsteriscs("Asterisks_on_DELTA_TOS",						{11, 3}, 9, nil, {{"DED_TIME_AsterisksPos", ASTERISKS_POS.DELTA_TOS}})

-- Date
addText("DATE_FORMAT_label",			"MM/DD/YY",			{2, 4})
addText("DATE_value",					"00/00/00",			{13, 4}, {"DED_TIME_DataEntry_Inv", ASTERISKS_POS.DATE}, nil, {{"DED_TIME_DATE_Scratchpad"}})
addAsteriscs("Asterisks_on_DATE",							{12, 4}, 8, nil, {{"DED_TIME_AsterisksPos", ASTERISKS_POS.DATE}})
