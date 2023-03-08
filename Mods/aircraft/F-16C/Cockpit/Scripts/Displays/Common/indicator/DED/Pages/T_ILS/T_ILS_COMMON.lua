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
-- Common -----------------------------------------------------------------
---------------------------------------------------------------------------
addText("TILS Scratchpad",				"      ",		{8, 2}, {"DED_TILS_DataEntry_Inv", ASTERISKS_POS.SCRATCHPAD}, nil, {{"DED_TILS_Scratchpad"}})
addAsteriscs("TILS Asterisks",							{7, 2}, 6, nil, {{"DED_TILS_AsterisksPos", ASTERISKS_POS.SCRATCHPAD}})

---------------------------------------------------------------------------
-- TACAN ------------------------------------------------------------------
---------------------------------------------------------------------------
addText("TCN Label",					"TCN",			{1, 0})

addText("TCN Mode",						"OFF",			{5, 0}, false, nil, {{"DED_TILS_TCN_Mode"}}, {"", "ON", "REC", "T/R", "A/A TR"})

addBigOFF("TCN BIG OFF Label", {5, 0}, {{"DED_TILS_TCN_BIG_OFF"}})

---------------------------------------------------------------------------
-- ILS --------------------------------------------------------------------
---------------------------------------------------------------------------
addText("ILS Label",					"ILS",			{13, 0})
addText("ILS Mode",						"OFF",			{18, 0}, false, nil, {{"DED_TILS_ILS_ONOFF"}}, {"ON", "OFF"})

addText("ILS CMD STRG",					"CMD STRG",		{15, 2}, {"DED_TILS_ILS_CmdStrg"})

addText("ILS FRQ Label",				"FRQ",			{12, 3})
addText("ILS FRQ Scratchpad",			"108.10",		{17, 3}, {"DED_TILS_DataEntry_Inv", ASTERISKS_POS.ILS_FREQ}, nil, {{"DED_TILS_ILS_FREQ_Scratchpad"}})
addAsteriscs("ILS FRQ Asterisks",						{16, 3}, 6, nil, {{"DED_TILS_AsterisksPos", ASTERISKS_POS.ILS_FREQ}})

addText("ILS CRS Label",				"CRS",			{12, 4})
addText("ILS CRS Scratchpad",			"  0o",			{17, 4}, {"DED_TILS_DataEntry_Inv", ASTERISKS_POS.ILS_CRS}, nil, {{"DED_TILS_ILS_CRS_Scratchpad"}})
addAsteriscs("ILS CRS Asterisks",						{16, 4}, 4, nil, {{"DED_TILS_AsterisksPos", ASTERISKS_POS.ILS_CRS}})

