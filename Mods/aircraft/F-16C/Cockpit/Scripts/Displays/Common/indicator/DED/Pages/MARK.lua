local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	SOURCE				= counter();
    NUMBER				= counter();
    LATITUDE			= counter();
    LONGITUDE			= counter();
    ELEVATION			= counter();
    MGRS			    = counter();
}

count = -1
local MGRS_STATE =
{
	GRID_DIGIT			= counter();
    GRID_SYMBOL			= counter();
    SQUARE0	        	= counter();
    SQUARE1	        	= counter();
    EAST	        	= counter();
    NORTH	        	= counter();
}

addText("MARK",		                      "MARK",		{1, 0})
addText("MARK SOURCE",		              "",   		{7, 0}, nil, nil, {{"DED_MARK_WPT_Source"}})
addAsteriscs("MARK SOURCE Asteriscs",                   {6, 0}, 4, nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.SOURCE}})
addText("STPT NUMBER",                    "",		    {14, 0}, {"DED_MARK_DataEntry_Inv", ASTERISKS_POS.NUMBER}, nil, {{"DED_MARK_STPT_Num"}})
addText("MARK IncDecSymbol",              "a",	        {17, 0})
addAsteriscs("MARK Number Asteriscs",                   {13, 0}, 4, nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.NUMBER}})
addText("STPT",		                      "STPT",		{19, 0}, {"DED_MARK_STPTState", 1})

addText("MARK Latitude",                  "LAT",		{2, 1}, nil)
addText("MARK Latitude Value",            "",	        {6, 1}, {"DED_MARK_DataEntry_Inv", ASTERISKS_POS.LATITUDE}, nil, {{"DED_MARK_Latitude"}}, {"%c%3do%2d.%03d'"})
addAsteriscs("MARK Latitude Asteriscs",                 {5, 1}, 12, nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.LATITUDE}})

addText("MARK Longitude",                 "LNG",		{2, 2}, nil)
addText("MARK Longitude Value",           "",	        {6, 2}, {"DED_MARK_DataEntry_Inv", ASTERISKS_POS.LONGITUDE}, nil, {{"DED_MARK_Longitude"}}, {"%c%3do%2d.%03d'"})
addAsteriscs("MARK Longitude Asteriscs",                {5, 2}, 12, nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.LONGITUDE}})

addText("MARK Elevation",                 "ELEV",		{1, 3}, nil)
addText("MARK Elevation Value",           "",     	    {6, 3}, {"DED_MARK_DataEntry_Inv", ASTERISKS_POS.ELEVATION}, nil, {{"DED_MARK_Elevation"}})
addAsteriscs("MARK Elevation Asteriscs",                {5, 3}, 8, nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.ELEVATION}})

addText("MARK MGRS",                  	  "MGRS",		{1,  4}, nil)
addText("MARK GRID DIGIT Value",          "",		    {6,  4}, {"DED_MARK_MGRSGridDigitEntry_Inv", 1},                 nil, {{"DED_MARK_ZONE_DIGIT"}})
addText("MARK GRID SYMBOL Value",         "",			{8,  4}, {"DED_MARK_MGRSDataEntry_Inv", MGRS_STATE.GRID_SYMBOL}, nil, {{"DED_MARK_ZONE_SYMBOL"}})
addText("MARK SQUARE Value1",             "",			{9,  4}, {"DED_MARK_MGRSDataEntry_Inv", MGRS_STATE.SQUARE0},     nil, {{"DED_MARK_SQUARE_FIRST_SYMBOL"}})
addText("MARK SQUARE Value2",             "",			{10, 4}, {"DED_MARK_MGRSDataEntry_Inv", MGRS_STATE.SQUARE1},     nil, {{"DED_MARK_SQUARE_SECOND_SYMBOL"}})
addText("MARK EAST Value",        		  "",		    {12, 4}, {"DED_MARK_MGRSDataEntry_Inv", MGRS_STATE.EAST},        nil, {{"DED_MARK_EAST"}})
addText("MARK Slash",        		     "/",			{17, 4}, nil)
addText("MARK NORTH Value",          	  "",			{18, 4}, {"DED_MARK_MGRSDataEntry_Inv", MGRS_STATE.NORTH},       nil, {{"DED_MARK_NORTH"}})
addAsteriscs("MARK MGRS Asteriscs",                     {5,  4}, 17,  nil, {{"DED_MARK_AsterisksPos", ASTERISKS_POS.MGRS}})