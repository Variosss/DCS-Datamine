dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/DLNK/DLNK_Common.lua")


addText("NET STATUS lbl",			"NET STATUS",			{5, 0})

addText("GPS TIME lbl",				"GPS TIME",				{0, 1})
addText("GPS TIME status",			"OFF",					{9, 1}, nil, nil, {{"DED_DLNK_NET_STATUS_ETR"}}, {"", "OFF", "ON"})
addAsteriscs("Asterisks on ETR",							{8, 1}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.ETR}})

addText("IPF Reset lbl",			"IPF RESET",			{14, 1}, nil, nil, {{"DED_DLNK_NET_STATUS_IPF"}})
addAsteriscs("Asterisks on IPF",							{13, 1}, 9, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.IPF}})

addText("TIME lbl",					"TIME",					{4, 2})
addText("TIME value",				"XX:XX:XX",				{9, 2}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.TIME}, nil, {{"DED_DLNK_NET_STATUS_TIME"}})
addAsteriscs("Asterisks on TIME",							{8, 2}, 8, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.TIME}})

addText("NTR lbl",					"NTR",					{5, 3})
addText("NTR status",				"OFF",					{9, 3}, nil, nil, {{"DED_DLNK_NET_STATUS_NTR"}}, {"", "OFF", "ON"})
addAsteriscs("Asterisks on NTR",							{8, 3}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.NTR}})

addText("SYNC lbl",					"SYNC",					{4, 4})
addText("SYNC status",				"FINE",					{9, 4}, nil, nil, {{"DED_DLNK_NET_STATUS_SYNC"}}, {"", "INPROG", "COARSE", "FINE"})
addAsteriscs("Asterisks on SYNC",							{8, 4}, 6, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.SYNC}})

addText("P1 lbl",					"P1>",					{21, 4})
