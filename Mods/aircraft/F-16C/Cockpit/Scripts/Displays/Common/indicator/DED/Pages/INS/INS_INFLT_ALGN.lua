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

addText("INS_lbl",						"INS",				{4, 0})
addText("INS_INFLT_ALGN_lbl",			"INFLT ALGN",		{8, 0})

addText("INS_COMPASS_HDG_lbl",			"COMPASS HDG",		{3, 2})
addText("INS_CompassHdgScratchpad",		"XXXo",				{16, 2}, {"DED_INS_DataEntry_Inv", ASTERISKS_POS.HDG}, nil, {{"DED_INS_IFA_CmpsHdgScratchpad"}})
addAsteriscs("Asterisks on Scratchpad",						{15, 2}, 4, nil, {{"DED_INS_AsterisksPos", ASTERISKS_POS.HDG}})

addText("INS_FIX_NECESSARY_lbl",		"",					{3, 3}, nil, nil, {{"DED_INS_IFA_Errors"}}, {"", "FIX NECESSARY", "ALIGN UNAVAILABLE"})
