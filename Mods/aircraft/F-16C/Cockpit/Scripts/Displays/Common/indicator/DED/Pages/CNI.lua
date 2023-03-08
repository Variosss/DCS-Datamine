
addText("UHF Mode Rotary",			"   ",	{1, 0}, {"DED_CNI_UHF_ModeHighlight"}, nil, {{"DED_CNI_UHF_Mode"}}, {"", "UHF", "HQ"})
addText("UHF Status",				"",		{1, 1}, nil, nil, {{"DED_CNI_UHF_Status"}}, {"", "OFF", "GRD", "BUP"})
addText("Selected UHF Frequency",	"",		{6, 0}, nil, nil, {{"DED_CNI_UHF_FrequencyOrChannel"}})
addText("UHF IncDecSymbol",			"a",	{5, 0}, nil, nil, {{"DED_CNI_IncDecSymbolPos", 1}})

addText("VHF Label",				"VHF",	{1, 2}, {"DED_CNI_VHF_ModeHighlight"})
addText("VHF Status",				"",		{1, 3}, nil, nil, {{"DED_CNI_VHF_Status"}}, {"", "OFF", "GRD"})
addText("Selected VHF Frequency",	"",		{6, 2}, nil, nil, {{"DED_CNI_VHF_FrequencyOrChannel"}})
addText("VHF IncDecSymbol",			"a",	{5, 2}, nil, nil, {{"DED_CNI_IncDecSymbolPos", 2}})

local IFF_placeholder = addLocalPlaceholder("DED CNI IFF PH", nil, {{"DED_CNI_IFF_State"}})
addText("IFF Modes Label",			"M",	{1, 4},  nil, IFF_placeholder.name)
addText("IFF Modes Enabled",		"",		{2, 4},  nil, IFF_placeholder.name, {{"DED_CNI_IFF_Modes"}})
addText("Active Mode 3 Code",		"",		{9, 4},  nil, IFF_placeholder.name, {{"DED_CNI_IFF_Mode3Code"}})
addText("IFF Switching",			"",		{14, 4}, nil, IFF_placeholder.name, {{"DED_CNI_IFF_Status"}}, {"", "OFF", "BUP", "STBY", "DEGR", "POS", "TIM", "P/T"})

addText("Steerpoint Use",			"",		{14, 0}, nil, nil, {{"DED_CNI_WPT_Type"}}, {"", "STPT", "TGT", "IP"})
addText("Selected Steerpoint",		"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("WPT IncDecSymbol",			"a",	{19, 0}, nil, nil, {{"DED_CNI_IncDecSymbolPos", 0}})

local wind_PH = addLocalPlaceholder("DED CNI Wind PH", nil, {{"DED_CNI_Wind_Show"}})
addText("Default Value Indication",	"",		{11, 1}, nil, wind_PH.name, {{"DED_CNI_DefaultValueIndication"}}, {"", "DFLT"})
addText("Wind Magnetic Direction",	"",		{16, 1}, nil, wind_PH.name, {{"DED_CNI_Wind_MagDirection"}})
addText("Wind Speed",				"",		{20, 1}, nil, wind_PH.name, {{"DED_CNI_Wind_Speed"}})

addText("System Time",				"10:15:07",	{15, 2}, nil, nil, {{"DED_CNI_SystemTime"}})
addText("Hack Time",				" 2:30:15",	{15, 3}, nil, nil, {{"DED_CNI_HackTime"}})

-- TACAN Section
local tacan_not_aa = addLocalPlaceholder("DED CNI TACAN PH", nil, {{"DED_CNI_TACAN_AA", 0}})
local tacan_aa = addLocalPlaceholder("DED CNI A-A TACAN PH", nil, {{"DED_CNI_TACAN_AA", 1}})

addText("TACAN Label",				"T",		{19, 4}, nil, tacan_not_aa.name)
addText("TACAN Channel",			"",			{20, 4}, nil, tacan_not_aa.name, {{"DED_CNI_TACAN_Channel"}})
addText("TACAN Band",				"",			{23, 4}, nil, tacan_not_aa.name, {{"DED_CNI_TACAN_Band"}}, {"", "X", "Y"})

addText("TACAN A-A Distance",		"-----",	{19, 4}, {"DED_CNI_TACAN_AA_DistExtrapolated"}, tacan_aa.name, {{"DED_CNI_TACAN_AA_Dist"}})