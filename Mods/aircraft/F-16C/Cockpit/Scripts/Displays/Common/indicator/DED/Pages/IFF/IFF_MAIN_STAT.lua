------------------------------------------------------------------------------------
-- COMMON --------------------------------------------------------------------------

addText("IFF label",			"IFF",				{1, 0})
addText("IFF Power Status",		"STBY",				{5, 0}, nil, nil, {{"DED_IFF_MasterMode"}}, {"", " OFF", "STBY", " ON "})

------------------------------------------------------------------------------------
-- STAT PAGE -----------------------------------------------------------------------

addText("Mode label",			"STAT",				{12, 0}, false, nil, nil)

addText("Event Occured",		"P/T",				{18, 0}, true, nil, {{"DED_IFF_Event"}}, {"", "POS", "TIM", "P/T"})

addText("M1 Mode",				"M1",				{0, 2}, {"DED_IFF_M1_Enable"}, nil)
addText("M2 Mode",				"M2",				{0, 3}, {"DED_IFF_M2_Enable"}, nil)
addText("M3 Mode",				"M3",				{0, 4}, {"DED_IFF_M3_Enable"}, nil)

addText("M1 Lockout Status",	":",				{3, 2}, nil, nil)
addText("M2 Lockout Status",	":",				{3, 3}, nil, nil)
addText("M3 Lockout Status",	":",				{3, 4}, nil, nil)

addText("M1 Code",				"23",				{4, 2}, nil, nil, {{"DED_IFF_M1Code"}})
addText("M2 Code",				"1234",				{4, 3}, nil, nil, {{"DED_IFF_M2Code"}})
addText("M3 Code",				"4567",				{4, 4}, nil, nil, {{"DED_IFF_M3Code"}})

addText("M4 Mode",				"M4",				{8, 2}, {"DED_IFF_M4_Enable"}, nil)
addText("M4 Code",				"A",				{12, 2}, nil, nil, {{"DED_IFF_M4Code"}}, {"", "A", "B"})
addText("M4 Key",				"(6)",				{14, 2}, nil, nil)

addText("M4 Monitoring",		"OUT",				{9, 4}, nil, nil, {{"DED_IFF_M4_Monitoring"}}, {"", "OUT", "LIT", "AUD"})
addText("M4 Monitoring Key",	"(7)",				{14, 4}, nil, nil)

addText("MC Mode",				"MC",				{9, 3}, {"DED_IFF_MC_Enable"}, nil)
addText("MC Code",				"",					{12, 3}, nil, nil)
addText("MC Key",				"(5)",				{14, 3}, nil, nil)

addText("MS Mode",				"MS",				{18, 4}, {"DED_IFF_MS_Enable"}, nil)
addText("MS Code",				"1",				{20, 4}, nil, nil, {{"DED_IFF_MSCode"}}, {"", "1", "2"})
addText("MS Key",				"(8)",				{21, 4}, nil, nil)

addAsteriscs("Mode Asterisks",						{17, 1}, 5, nil, nil)
addText("Mode Scratchpad",		"",					{18, 1}, {"DED_IFF_DataEntry_Inv", 0}, nil, {{"DED_IFF_Scratchpad"}})

addText("POS EVENT - Side",		"N",				{19, 2}, false, nil, nil)
addText("POS EVENT - OF",		"OF",				{20, 2}, false, nil, nil)
addText("POS EVENT - Number",	"1",				{22, 2}, false, nil, nil)

addText("TIM EVENT - Time",		"01:23",			{18, 3}, false, nil, nil)
