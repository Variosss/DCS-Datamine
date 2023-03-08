dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/NAV/NAV_Asterisks.lua")

addText("NAV Status lbl",					"NAV COMMANDS",		{6, 0})

addText("FILTER MODE label",				"FILTER MODE",		{3, 2})
addText("FILTER MODE value",				"AUTO",				{16, 2}, nil, nil, {{"DED_NAV_FilterMode"}}, {"", "AUTO", "INS"})
addAsteriscs("Asterisks",										{15, 2}, 4, nil, {{"DED_NAV_AsterisksPos", ASTERISKS_POS.FILTER_MODE}})

addText("RESET GPS label",					"  RESET GPS",		{6, 3}, {"DED_NAV_RESET_GPS_InProgress"})
addAsteriscs("Asterisks on RESET",								{5, 3}, 11, nil, {{"DED_NAV_AsterisksPos", ASTERISKS_POS.RESET_GPS}})

addText("ZEROIZE GPS label",				"ZEROIZE GPS",		{6, 4}, {"DED_NAV_ZEROIZE_GPS_InProgress"})
addAsteriscs("Asterisks on ZEROIZE",							{5, 4}, 11, nil, {{"DED_NAV_AsterisksPos", ASTERISKS_POS.ZEROIZE_GPS}})
