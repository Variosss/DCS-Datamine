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
	TCN_CHAN			= counter();
	ILS_FREQ			= counter();
	ILS_CRS				= counter();
}


---------------------------------------------------------------------------
-- TACAN ------------------------------------------------------------------
---------------------------------------------------------------------------
addText("TCN BCN Label",				"BCN",			{0, 2}, false, nil, {{"DED_TILS_TCN_ID", 0}})
addText("TCN BCN ID",					"ABC",			{4, 2}, false, nil, {{"DED_TILS_TCN_ID", 1}})

addText("TCN CHAN Label",				"CHAN",			{0, 3})
addText("TCN CHAN Scratchpad",			"   ",			{5, 3}, {"DED_TILS_DataEntry_Inv", ASTERISKS_POS.TCN_CHAN}, nil, {{"DED_TILS_TCN_CHAN_Scratchpad"}})
addAsteriscs("TCN CHAN Asterisks",						{4, 3}, 3, nil, {{"DED_TILS_AsterisksPos", ASTERISKS_POS.TCN_CHAN}})

addText("TCN BAND Label",				"BAND",			{0, 4})
addText("TCN BAND XY",					"X",			{5, 4}, false, nil, {{"DED_TILS_TCN_Band"}}, {"X", "Y"})
addText("TCN BAND Key",					"(0)",			{6, 4})
