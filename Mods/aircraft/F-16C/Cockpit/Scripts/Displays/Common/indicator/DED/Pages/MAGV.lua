addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

local ASTERISKS_POS =
{
	NONE		= 0;
	LAT			= 1;
	LNG			= 2;
	SALT		= 3;
	THDG		= 4,
	HDG			= 5;
	MAGV_MODE	= 6;
	MAGV		= 7;
}

addText("MAGV lbl",								"MAGV",		{7, 0})

addText("MAGV Mode",							"AUTO",		{13, 0}, nil, nil, {{"DED_MAGV_Mode"}}, {"AUTO", "MAN"})
addAsteriscs("Asterisks_on_MAGV_Mode",						{12, 0}, 4, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.MAGV_MODE}})

addText("INS_MAGV_Scratchpad",					"EXX.Xo",	{9, 2}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.MAGV}, nil, {{"DED_MAGV_Scratchpad"}})
addAsteriscs("Asterisks_on_MAGV_Scratchpad",				{8, 2}, 6, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.MAGV}})
