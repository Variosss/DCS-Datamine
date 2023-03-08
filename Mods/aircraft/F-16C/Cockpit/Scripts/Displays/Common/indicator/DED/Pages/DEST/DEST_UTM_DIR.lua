local ASTERISKS_POSITION = 
{
	NONE 			= 0;
	NUM_STEERPOINT 	= 1;
	GRIDDIGIT		= 2;
	GRIDSYMB 		= 3;
	SQUARE 			= 4;
	SQUARE2 		= 5;
	EAST_NORTH 		= 6;
	ELEV 			= 7;
	CNVRT 			= 8;
}

addText("UTM_DEST", "UTM DEST", {2,0}, nil)
	addText("UTM_DEST_SelectedSteerpoint",	"",		{12, 0}, {"DED_UTM_DEST_DataEntry_Inv", ASTERISKS_POSITION.NUM_STEERPOINT}, nil, {{"DED_UTM_DEST_STPT_Num"}})
	addText("UTM_DEST_STPT_IncDecSymbol",	"a",	{16, 0})
	addAsteriscs("Asterisks_NUM_STEERPOINT",{11, 0}, 3, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.NUM_STEERPOINT}})

addText("UTM_DEST_GRID", "GRID", {6,1}, nil)
	addText("GRID_DIGIT", "XX", {12,1}, {"DED_UTM_DEST_DataEntry_Inv", ASTERISKS_POSITION.GRIDDIGIT}, nil, {{"DED_UTM_DEST_GRID_DIGIT_Scratchpad"}})
	addText("GRID_SYMBOL", "A", {14,1}, {"DED_UTM_DEST_DataGridSymb_Inv", 1}, nil, {{"DED_UTM_DEST_GRID_SYMBOL_Scratchpad"}})
	addAsteriscs("Asterisks_GRID_DIGIT",{11, 1}, 3, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.GRIDDIGIT}})	
	addAsteriscs("Asterisks_GRID_SYMBOL",{11, 1}, 3, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.GRIDSYMB}})	
	
addText("UTM_DEST_CNVRT", "CNVRT", {18,1}, {"DED_UTM_DEST_DataEntry_Inv", ASTERISKS_POSITION.CNVRT}, nil, {{"DED_UTM_DEST_CNVRT_Scratchpad"}})
	addAsteriscs("Asterisks_CNVRT",{17, 1}, 5, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.CNVRT}})	
	
addText("UTM_DEST_SQUARE", "SQUARE", {4,2}, nil)
	addText("SQUARE", "", {12,2},{"DED_UTM_DEST_DataSquare_Inv", 1}, nil, {{"DED_UTM_DEST_SQUARE_Scratchpad"}})
	addText("SQUARE2", "", {13,2},{"DED_UTM_DEST_Data_Inv", ASTERISKS_POSITION.SQUARE2}, nil, {{"DED_UTM_DEST_SQUARE2_Scratchpad"}})
	addAsteriscs("Asterisks_SQUARE",{11, 2}, 2, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.SQUARE}})
	addAsteriscs("Asterisks_SQUARE2",{11, 2}, 2, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.SQUARE2}})
	
 addText("UTM_DEST_EAST/NORTH", "EAST/NORTH", {0,3}, nil)
	addText("EAST/NORTH", "XXXXX/XXXXX", {12,3},{"DED_UTM_DEST_DataEntry_Inv", ASTERISKS_POSITION.EAST_NORTH}, nil, {{"DED_UTM_DEST_EAST_NORTH_Scratchpad", ASTERISKS_POSITION.EAST_NORTH}})
	addAsteriscs("Asterisks_EAST/NORTH",{11, 3}, 11, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.EAST_NORTH}})	
	
addText("UTM_DEST_ELEV", "ELEV", {6,4}, nil)
	addText("ELEV", "XXXXFT", {12,4},{"DED_UTM_DEST_DataEntry_Inv", ASTERISKS_POSITION.ELEV}, nil, {{"DED_UTM_DEST_ELEV_Scratchpad"}})
	addAsteriscs("Asterisks_ELEV",{11, 4}, 7, nil, {{"DED_UTM_DEST_AsterisksPos", ASTERISKS_POSITION.ELEV}})	

addText("P1 lbl",					"P1>",					{21, 4})