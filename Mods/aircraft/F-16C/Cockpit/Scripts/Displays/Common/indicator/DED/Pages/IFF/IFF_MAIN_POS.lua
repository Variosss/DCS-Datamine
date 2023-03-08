------------------------------------------------------------------------------------
-- COMMON --------------------------------------------------------------------------

addText("IFF label",			"IFF",				{1, 0})
addText("IFF Power Status",		"STBY",				{5, 0}, nil, nil, {{"DED_IFF_MasterMode"}}, {"", " OFF", "STBY", " ON "})

------------------------------------------------------------------------------------
-- POS PAGE ------------------------------------------------------------------------

addText("Event Occured",		"POS",				{18, 0}, true, nil, nil)
addText("Mode Group State",		"1",				{22, 0}, false, nil, {{"DED_IFF_ModeGroup"}})
addText("IncDec Symbol",		"a",				{23, 0}, nil, nil)

addText("M1 Mode",				"M1",				{1, 2}, {"DED_IFF_M1_Enable"}, nil)
addText("M2 Mode",				"M2",				{1, 3}, {"DED_IFF_M2_Enable"}, nil)
addText("M3 Mode",				"M3",				{1, 4}, {"DED_IFF_M3_Enable"}, nil)

--addText("M1 Lockout Status",	":",				{3, 2}, nil, nil)
--addText("M1 Code",			"23",				{4, 2}, nil, nil, {{"DED_IFF_M1Code"}})

--addText("M2 Lockout Status",	":",				{3, 3}, nil, nil)
addText("M2 Code",				"1234",				{4, 3}, nil, nil, {{"DED_IFF_M2Code"}})

--addText("M3 Lockout Status",	":",				{3, 4}, nil, nil)
--addText("M3 Code",			"4567",				{4, 4}, nil, nil, {{"DED_IFF_M3Code"}})

addText("M4 Mode",				"M4",				{9, 2}, {"DED_IFF_M4_Enable"}, nil)
--addText("M4 Code",			"A",				{13, 2}, nil, nil, {{"DED_IFF_M4Code"}}, {"", "A", "B"})
--addText("M4 Key",				"(6)",				{14, 2}, nil, nil)

--addText("M4 Monitoring",		"AUT",				{9, 4}, nil, nil, {{"DED_IFF_M4_Monitoring"}}, {"", "AUT", "LIT", "AUD"})
--addText("M4 Monitoring Key",	"(7)",				{14, 4}, nil, nil)

addText("MC Mode",				"MC",				{9, 3}, {"DED_IFF_MC_Enable"}, nil)
--addText("MC Code",			"",					{12, 3}, nil, nil)
addText("MC Key",				"(5)",				{14, 3}, nil, nil)

addText("MS Mode",				"MS",				{18, 4}, {"DED_IFF_MS_Enable"}, nil)
addText("MS Code",				"1",				{20, 4}, nil, nil, {{"DED_IFF_MSCode"}}, {"", "1", "2"})
addText("MS Key",				"(8)",				{21, 4}, nil, nil)

addAsteriscs("Mode Asterisks",						{18, 2}, 4, nil, nil)
addText("Mode Scratchpad",		"",					{19, 2}, {"DED_IFF_DataEntry_Inv", 0}, nil, nil)

addText("POS EVENT - Side",		"N",				{19, 3}, false, nil, nil)
addText("POS EVENT - OF",		"OF",				{20, 3}, false, nil, nil)
addText("POS EVENT - Number",	"1",				{22, 3}, false, nil, nil)
