local ASTERISKS_POSITION = 
{
	NONE = 0;
	NUM_STEERPOINT = 1;
	RNG = 2;
	BRG = 3;
	ELEV = 4;
}

addText("DEST_OA2", "DEST OA2", {2,0}, nil)
	addText("DEST_OA2_SelectedSteerpoint",	"",		{11, 0}, {"DED_DEST_OA2_DataEntry_Inv", ASTERISKS_POSITION.NUM_STEERPOINT}, nil, {{"DED_DEST_DIR_STPT_Num"}})
	addText("DEST_OA2_STPT_IncDecSymbol",	"a",	{15, 0})
	addAsteriscs("Asterisks_NUM_STEERPOINT",{10, 0}, 3, nil, {{"DED_DEST_OA2_AsterisksPos", ASTERISKS_POSITION.NUM_STEERPOINT}})
	
	
 addText("DEST_OA2_RNG", "RNG", {3,2}, nil)
	addText("RNG", "XXXXX FT", {8,2}, {"DED_DEST_OA2_DataEntry_Inv", ASTERISKS_POSITION.RNG}, nil, {{"DED_DEST_OA2_RNG"}})	
	addAsteriscs("Asterisks_RNG",{7, 2}, 8, nil, {{"DED_DEST_OA2_AsterisksPos", ASTERISKS_POSITION.RNG}})
	
 addText("DEST_OA2_BRG", "BRG", {3,3}, nil)
	addText("BRG", "XXX.Xo", {8,3}, {"DED_DEST_OA2_DataEntry_Inv", ASTERISKS_POSITION.BRG}, nil, {{"DED_DEST_OA2_BRG"}})
	addAsteriscs("Asterisks_BRG",{7, 3}, 6, nil, {{"DED_DEST_OA2_AsterisksPos", ASTERISKS_POSITION.BRG}})	

 addText("DEST_OA2_ELEV", "ELEV", {2,4}, nil)
	addText("ELEV", "XXXXXXFT", {8,4}, {"DED_DEST_OA2_DataEntry_Inv", ASTERISKS_POSITION.ELEV}, nil, {{"DED_DEST_OA2_ELEV"}})
	addAsteriscs("Asterisks_ELEV",{7, 4}, 8, nil, {{"DED_DEST_OA2_AsterisksPos", ASTERISKS_POSITION.ELEV}})
	
addText("P4lbl",					"P4>",					{21, 4})
