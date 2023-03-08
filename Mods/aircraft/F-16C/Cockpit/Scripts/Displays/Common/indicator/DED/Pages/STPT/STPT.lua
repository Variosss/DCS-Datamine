local count = 0
local function counter()
	count = count + 1
	return count
end

count = -1
local ASTERISKS_POS =
{
	NUMBER				= counter();
	SEQUENCE           	= counter();
	LATITUDE			= counter();
	LONGITUDE			= counter();
	GRIDDIGIT			= counter();
	GRIDSYMB			= counter();
	SQUARE				= counter();
	SQUARE2				= counter();
	EAST_NORTH  		= counter();
	ELEVATION   		= counter();
	TOS             	= counter();
	CNVRT           	= counter();
}

addText("STEERPOINT LABEL",                     "STPT",		        {6, 0})
addText("STEERPOINT NUMBER",                    "",		            {12, 0}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.NUMBER}, nil, {{"DED_STPT_WPT_Num"}})
addText("STEERPOINT IncDecSymbol",		        "a",	            {16, 0})
addAsteriscs("STEERPOINT NUMBER Asteriscs",                         {11, 0}, 3, nil, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.NUMBER}})
addText("STEERPOINT SEQUENCE",		            "",	                {18, 0}, nil, nil, {{"DED_STPT_Sequence"}}, {"", "MAN", "AUTO"})
addAsteriscs("STEERPOINT SEQUENCE Asteriscs",                       {17, 0}, 4, nil, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.SEQUENCE}})

local latLonStatePH = addLocalPlaceholder("STEERPOINT LAT LON STATE PH", 	nil, {{"DED_STPT_DataShowState", 0}})
addText("STEERPOINT Latitude",                  "LAT",		        {3, 1}, nil, latLonStatePH.name)
addText("STEERPOINT Latitude Value",            "",	                {8, 1}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.LATITUDE}, latLonStatePH.name, {{"DED_STPT_Latitude"}}, {"%c%3do%2d.%03d'"})
addAsteriscs("STEERPOINT Latitude Asteriscs",                       {7, 1}, 12, latLonStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.LATITUDE}})

addText("STEERPOINT Longitude",                 "LNG",		        {3, 2}, nil, latLonStatePH.name)
addText("STEERPOINT Longitude Value",           "",	                {8, 2}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.LONGITUDE}, latLonStatePH.name, {{"DED_STPT_Longitude"}}, {"%c%3do%2d.%03d'"})
addAsteriscs("STEERPOINT Longitude Asteriscs",                      {7, 2}, 12, latLonStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.LONGITUDE}})

addText("STEERPOINT Elevation",                 "ELEV",		        {2, 3}, nil, latLonStatePH.name)
addText("STEERPOINT Elevation Value",           "",     	        {8, 3}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.ELEVATION}, latLonStatePH.name, {{"DED_STPT_Elevation"}})
addAsteriscs("STEERPOINT Elevation Asteriscs",                      {7, 3}, 8, latLonStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.ELEVATION}})

addText("STEERPOINT Time over current STP",     "TOS",		        {3, 4}, nil, latLonStatePH.name)
addText("STEERPOINT TOS Value",                 "",	                {8, 4}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.TOS}, latLonStatePH.name, {{"DED_STPT_TOS"}})
addAsteriscs("STEERPOINT TOS Asteriscs",                            {7, 4}, 8, latLonStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.TOS}})

local mgrsStatePH = addLocalPlaceholder("STEERPOINT MGRS STATE PH", 		nil, {{"DED_STPT_DataShowState", 1}})
addText("STEERPOINT GRID",                  	"GRID",		        {6, 1},	nil, mgrsStatePH.name)
addText("STEERPOINT GRID DIGIT Value",          "",			 	    {12, 1}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.GRIDDIGIT}, mgrsStatePH.name, {{"DED_STPT_ZONE_DIGIT"}})
addText("STEERPOINT GRID SYMBOL Value",         "",			 	    {14, 1}, {"DED_STPT_DataGridSymb_Inv", 1}, mgrsStatePH.name, {{"DED_STPT_ZONE_SYMBOL"}})
addAsteriscs("STEERPOINT GRID DIGIT Asteriscs",                 	{11, 1}, 3, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.GRIDDIGIT}})
addAsteriscs("STEERPOINT GRID SYMBOL Asteriscs",                 	{11, 1}, 3, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.GRIDSYMB}})

addText("STEERPOINT GRID CNVRT",            	"CNVRT",			{17, 1},{"DED_STPT_DataEntry_Inv", ASTERISKS_POS.CNVRT}, mgrsStatePH.name, {{"DED_STPT_CNVRT"}})
addAsteriscs("STEERPOINT CNVRT Asteriscs",                 			{16, 1}, 5, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.CNVRT}})

addText("STEERPOINT SQUARE",                  	"SQUARE",		    {4, 2},	nil, mgrsStatePH.name)
addText("STEERPOINT SQUARE Value1",              "",				{12, 2}, {"DED_STPT_DataSquare_Inv", 1},  mgrsStatePH.name, {{"DED_STPT_SQUARE_FIRST_SYMBOL"}})
addText("STEERPOINT SQUARE Value2",              "",				{13, 2}, {"DED_STPT_Data_Inv", 		 ASTERISKS_POS.SQUARE2}, mgrsStatePH.name, {{"DED_STPT_SQUARE_SECOND_SYMBOL"}})
addAsteriscs("STEERPOINT SQUARE Asteriscs",                 		{11, 2}, 2, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.SQUARE}})
addAsteriscs("STEERPOINT SQUARE2 Asteriscs",                 		{11, 2}, 2, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.SQUARE2}})

addText("STEERPOINT EAST NORTH",                "EAST/NORTH",		{0, 3}, nil, mgrsStatePH.name)
addText("STEERPOINT EAST NORTH Value",        		"",				{12, 3}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.EAST_NORTH},  mgrsStatePH.name, {{"DED_STPT_EAST_NORTH", ASTERISKS_POS.EAST_NORTH}})
addAsteriscs("STEERPOINT EAST NORTH Asteriscs",                 	{11, 3}, 11, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.EAST_NORTH}})

addText("STEERPOINT ElevationMGRS",             "ELEV",		        {6, 4}, nil, mgrsStatePH.name)
addText("STEERPOINT ElevationMGRS Value",       "",     	        {11, 4}, {"DED_STPT_DataEntry_Inv", ASTERISKS_POS.ELEVATION}, mgrsStatePH.name, {{"DED_STPT_Elevation"}})
addAsteriscs("STEERPOINT ElevationMGRS Asteriscs",                  {11, 4}, 8, mgrsStatePH.name, {{"DED_STPT_AsterisksPos", ASTERISKS_POS.ELEVATION}})