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

addText("INS_lbl",								"INS",				{2, 0})

addText("INS_AlignTime",						"XX.X",				{7, 0}, nil, nil, {{"DED_INS_AlignTime"}})
addText("INS_AlignSlash",						"/",				{11, 0})
addText("INS_AlignStatusCode",					"XX",				{12, 0}, nil, nil, {{"DED_INS_AlignStatusCode"}})

addText("INS_Ready",							"RDY",				{15, 0}, nil, nil, {{"DED_INS_RDY"}})

addText("INS_LAT_lbl",							"LAT",				{2, 1})
addText("INS_LAT_Scratchpad",					"N XXoXX.X'",		{7, 1}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.LAT}, nil, {{"DED_INS_LAT_Scratchpad"}})
addAsteriscs("Asterisks_on_LAT_Scratchpad",							{6, 1}, 10, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.LAT}})

addText("INS_LNG_lbl",							"LNG",				{2, 2})
addText("INS_LNG_Scratchpad",					"WXXXoXX.X'",		{7, 2}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.LNG}, nil, {{"DED_INS_LNG_Scratchpad"}})
addAsteriscs("Asterisks_on_LNG_Scratchpad",							{6, 2}, 10, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.LNG}})

addText("INS_SALT_lbl",							"SALT",				{1, 3})
addText("INS_SALT_Scratchpad",					"XXXXXFT",			{8, 3}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.SALT}, nil, {{"DED_INS_SALT_Scratchpad"}})
addAsteriscs("Asterisks_on_SALT_Scratchpad",						{7, 3}, 7, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.SALT}})

addText("INS_THDG_lbl",							"THDG",				{1, 4})
addText("INS_THDG_Scratchpad",					"XXX.Xo",			{7, 4}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.THDG}, nil, {{"DED_INS_TrueHdg_Scratchpad"}})
addAsteriscs("Asterisks_on_THDG_Scratchpad",						{6, 4}, 6, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.THDG}})

addText("INS_GS_lbl",							"G/S",				{16, 4})
addText("INS_GS_value",							"XXX",				{20, 4}, nil, nil, {{"DED_INS_GroundSpeed"}})
