local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	NONE				= counter();
	SCRATCHPAD			= counter();
	BAND				= counter();
	PRESET_CHANNEL		= counter();
	PRESET_FREQUENCY	= counter();
}

addText("Secure Voice",						"SEC",			{1, 0}, nil, nil, {{"DED_COM1_SecureVoiceEnabled"}})
addText("COM 1 Mode",						"UHF",			{5, 0}, nil, nil, nil, {"UHF", " HQ"})
addText("Receiver Mode",					"MAIN",			{13, 0}, nil, nil, {{"DED_COM1_Mode"}}, {"", "MAIN", "BOTH", " OFF"})

addText("Active Frequency or Channel",		"10",			{2, 1}, nil, nil, {{"DED_COM1_FrequencyOrChannel"}})

addText("Scratchpad",						"      ",		{14, 2}, {"DED_COM1_DataEntry_Inv", ASTERISKS_POS.SCRATCHPAD}, nil, {{"DED_COM1_Scratchpad"}})
addAsteriscs("Asterisks on Scratchpad",						{13, 2}, 6, nil, {{"DED_COM1_AsterisksPos", ASTERISKS_POS.SCRATCHPAD}})

addText("Preset Label",						"PRE     a",	{2, 3})
addText("Preset Number",					"10",			{7, 3}, {"DED_COM1_DataEntry_Inv", ASTERISKS_POS.PRESET_CHANNEL}, nil, {{"DED_COM1_PresetChannel"}})
addAsteriscs("Asterisks on PresetChannel",					{6, 3}, 2, nil, {{"DED_COM1_AsterisksPos", ASTERISKS_POS.PRESET_CHANNEL}})
addText("Preset Frequency",					"225.00",		{5, 4}, {"DED_COM1_DataEntry_Inv", ASTERISKS_POS.PRESET_FREQUENCY}, nil, {{"DED_COM1_PresetFrequency"}})
addAsteriscs("Asterisks on PresetFrequency",				{4, 4}, 6, nil, {{"DED_COM1_AsterisksPos", ASTERISKS_POS.PRESET_FREQUENCY}})

addText("TOD Label",						"TOD",			{17, 3})

addText("Bandwidth",						"NB",			{18, 4}, {"DED_COM1_Rotary_Inv", ASTERISKS_POS.BAND}, nil, {{"DED_COM1_Band"}}, {"", "NB", "WB"})
addAsteriscs("Asterisks on Band",							{17, 4}, 2, nil, {{"DED_COM1_AsterisksPos", ASTERISKS_POS.BAND}})
