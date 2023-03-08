local IntgName = "INTG "

addText(IntgName.."INTG label",						"INTG",				{13, 0})
addText(IntgName.."INTG Mode",						"SCAN",				{8, 0}, nil, nil, {{"DED_INTG_Mode"}}, {"", "SCAN", " LOS"})

addText(IntgName.."TIM Event",						"TIM",				{20, 0}, true, nil, {{"DED_IFF_Event"}})

addText(IntgName.."M1 Mode",						"M1",				{0, 2}, {"DED_INTG_M1_Enable"})
addText(IntgName.."M2 Mode",						"M2",				{0, 3}, {"DED_INTG_M2_Enable"})
addText(IntgName.."M3 Mode",						"M3",				{0, 4}, {"DED_INTG_M3_Enable"})

addText(IntgName.."M1 Decoupled Status",			":",				{3, 2}, nil, nil, {{"DED_INTG_M1_Decoupled"}})
addText(IntgName.."M2 Decoupled Status",			":",				{3, 3}, nil, nil, {{"DED_INTG_M2_Decoupled"}})
addText(IntgName.."M3 Decoupled Status",			":",				{3, 4}, nil, nil, {{"DED_INTG_M3_Decoupled"}})

addText(IntgName.."M1 Code",						"23",				{4, 2}, nil, nil, {{"DED_INTG_M1Code"}})
addText(IntgName.."M2 Code",						"1234",				{4, 3}, nil, nil, {{"DED_INTG_M2Code"}})
addText(IntgName.."M3 Code",						"4567",				{4, 4}, nil, nil, {{"DED_INTG_M3Code"}})

addAsteriscs(IntgName.."Asterisks",										{9, 4}, 5)
addText(IntgName.."Scratchpad",						"",					{10, 4}, {"DED_INTG_DataEntry_Inv", 0}, nil, {{"DED_INTG_Scratchpad"}})

addText(IntgName.."M4 Mode",						"M4",				{16, 2}, {"DED_INTG_M4_Enable"})
addText(IntgName.."M4 Decoupled Status",			":",				{19, 2}, nil, nil, {{"DED_INTG_M4_Decoupled"}})
addText(IntgName.."M4 Code",						"A",				{20, 2}, nil, nil, {{"DED_INTG_M4Code"}}, {"", "A", "B"})
addText(IntgName.."M4 Key",							"(6)",				{21, 2}, nil, nil, nil)

addText(IntgName.."IJAM Mode",						"IJAM",				{15, 3}, {"DED_INTG_IJAM_Enable"})
addText(IntgName.."IJAM Key",						"(7)",				{20, 3})

addText(IntgName.."COUPLE Mode",					"DCPL",				{16, 4}, nil, nil, nil, {"", "DCPL", "ALL", "SOME"})
addText(IntgName.."COUPLE Key",						"(9)",				{20, 4})
