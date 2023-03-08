dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/NAV/NAV_Asterisks.lua")

addText("NAV Status lbl",					"NAV STATUS",		{7, 0})

addText("SYS ACCURACY label",				"SYS ACCUR",		{3, 1})
addText("SYS ACCURACY value",				"HIGH",				{14, 1}, nil, nil, {{"DED_NAV_SYS_Accur"}}, {"", "HIGH", "MED", "LOW", "FAIL"})

addText("GPS ACCURACY label",				"GPS ACCUR",		{3, 2})
addText("GPS ACCURACY value",				"HIGH",				{14, 2}, nil, nil, {{"DED_NAV_GPS_Accur"}}, {"", "HIGH", "LOW", "NO TRK"})

addText("MSN DUR label",					"MSN DUR",			{3, 3})
addText("DAYS label",						"DAYS",				{16, 3})
addText("Scratchpad",						"84",				{12, 3}, {"DED_NAV_DataEntry_Inv", ASTERISKS_POS.MSN_DUR}, nil, {{"DED_NAV_MSN_DUR_Scratchpad"}})
addAsteriscs("Asterisks on Scratchpad",							{11, 3}, 2, nil, {{"DED_NAV_AsterisksPos", ASTERISKS_POS.MSN_DUR}})

addText("Keys Msg",							"KEYS VERIFIED",	{3, 4}, nil, nil, {{"DED_NAV_KeyStatus"}}, {"", "EXPIRE AT 2400 HRS", "KEY VALID", "KEY INVALID", "KEYS VERIFIED", "KEY NOT VERIFIED", "INSUFF KEYS"})
