dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/DLNK/DLNK_Common.lua")

addText("LINK16 lbl",					"LINK16",				{7, 0})

addText("FC lbl",						"FC",					{3, 1})
addText("FC value",						"XXX",					{6, 1}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.FC}, nil, {{"DED_DLNK_LINK16_FC"}})
addAsteriscs("Asterisks on FC",									{5, 1}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.FC}})

addText("MC lbl",						"MC",					{3, 2})
addText("MC value",						"XXX",					{6, 2}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.MC}, nil, {{"DED_DLNK_LINK16_MC"}})
addAsteriscs("Asterisks on MC",									{5, 2}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.MC}})

addText("SC lbl",						"SC",					{3, 3})
addText("SC value",						"XXX",					{6, 3}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.SC}, nil, {{"DED_DLNK_LINK16_SC"}})
addAsteriscs("Asterisks on SC",									{5, 3}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.SC}})

addText("CallSign Name char1",			"V",					{11, 1}, {"DED_DLNK_LINK16_CallSignName_Inv", ASTERISKS_POS.CS_NAME, 0}, nil, {{"DED_DLNK_LINK16_CallsignName", 0}})
addText("CallSign Name char2",			"I",					{12, 1}, {"DED_DLNK_LINK16_CallSignName_Inv", ASTERISKS_POS.CS_NAME, 1}, nil, {{"DED_DLNK_LINK16_CallsignName", 1}})
addAsteriscs("Asterisks on CS Name",							{10, 1}, 2, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.CS_NAME}})
addText("VCS IncDecSymbol",				"a",					{14, 1}, nil, nil, {{"DED_DLNK_LINK16_IncDecSymbol", ASTERISKS_POS.CS_NAME}})

addText("CallSign Number",				"00",					{16, 1}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.CS_NUM}, nil, {{"DED_DLNK_LINK16_CallsignNumber"}})
addAsteriscs("Asterisks on CS Number",							{15, 1}, 2, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.CS_NUM}})

addText("FL lbl",						"FL",					{12, 2})
addText("FL status",					"YES",					{16, 2}, nil, nil, {{"DED_DLNK_LINK16_FL"}}, {"", "NO", "YES"})
addAsteriscs("Asterisks on FL",									{15, 2}, 3, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.FL}})

addText("XMT lbl",						"XMT",					{11, 3})
addText("XMT status",					"HI",					{16, 3}, nil, nil, {{"DED_DLNK_LINK16_XMT"}}, {"", "NONE", "LO", "MED", "HI"})
addAsteriscs("Asterisks on XMT",								{15, 3}, 4, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.XMT}})

addText("P2 lbl",						"P2>",					{21, 4})
