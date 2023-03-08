local ASTERISKS_POSITION = 
{
	NONE = 0;
	NUM_STEERPOINT = 1;
	LAT = 2;
	LON = 3;
	ELEV = 4;
	TOS = 5;
}

addText("DEST_DIR", "DEST DIR", {2,0}, nil)
	addText("DEST_DIR_SelectedSteerpoint",	"",		{12, 0}, {"DED_DEST_DIR_DataEntry_Inv", ASTERISKS_POSITION.NUM_STEERPOINT}, nil, {{"DED_DEST_DIR_STPT_Num"}})
	addText("DEST_DIR_STPT_IncDecSymbol",	"a",	{16, 0})
	addAsteriscs("Asterisks_NUM_STEERPOINT",{11, 0}, 3, nil, {{"DED_DEST_DIR_AsterisksPos", ASTERISKS_POSITION.NUM_STEERPOINT}})

addText("DEST_LAT", "LAT", {3,1}, nil)
	addText("LAT", "N XXoXX.XXX'", {8,1},{"DED_DEST_DIR_DataEntry_Inv", ASTERISKS_POSITION.LAT}, nil, {{"DED_DEST_LAT_Scratchpad"}})
	addAsteriscs("Asterisks_LAT",{7, 1}, 12, nil, {{"DED_DEST_DIR_AsterisksPos", ASTERISKS_POSITION.LAT}})	
	
addText("DEST_LON", "LON", {3,2}, nil)
	addText("LON", "WXXXoXX.XXX'", {8,2},{"DED_DEST_DIR_DataEntry_Inv", ASTERISKS_POSITION.LON}, nil, {{"DED_DEST_LON_Scratchpad"}})
	addAsteriscs("Asterisks_LON",{7, 2}, 12, nil, {{"DED_DEST_DIR_AsterisksPos", ASTERISKS_POSITION.LON}})	
	
addText("DEST_ELEV", "ELEV", {2,3}, nil)
	addText("ELEV", "XXXXFT", {8,3},{"DED_DEST_DIR_DataEntry_Inv", ASTERISKS_POSITION.ELEV}, nil, {{"DED_DEST_ELEV_Scratchpad"}})
	addAsteriscs("Asterisks_ELEV",{7, 3}, 7, nil, {{"DED_DEST_DIR_AsterisksPos", ASTERISKS_POSITION.ELEV}})	
	
 addText("DEST_TOS", "TOS", {3,4}, nil)
	addText("TOS", "XX:XX:XX", {8,4},{"DED_DEST_DIR_DataEntry_Inv", ASTERISKS_POSITION.TOS}, nil, {{"DED_DEST_DIR_TOS"}})
	addAsteriscs("Asterisks_TOS",{7, 4}, 8, nil, {{"DED_DEST_DIR_AsterisksPos", ASTERISKS_POSITION.TOS}})
	
addText("P2lbl",					"P2>",					{21, 4})

