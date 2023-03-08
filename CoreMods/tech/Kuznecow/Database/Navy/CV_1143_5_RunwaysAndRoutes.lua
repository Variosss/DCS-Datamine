-- ***************** "Admiral Kuznecov" ******************************

--   Runways and landing strip for Kuznecov in LCS

GT.RunWays =
{     
-- landing strip definition (first in table)
--	VppStartPoint; 					azimuth (degree} 	Length_Vpp; 	Width_Vpp;
	{{-15.55, 16.14, -14.42},		352.27036, 			201.84, 		25.0,
-- alsArgument, lowGlidePath, slightlyLowGlidePath, onLowerGlidePath, onUpperGlidePath, slightlyHighGlidePath, highGlidePath
		0, 			0, 				0, 						0, 				0, 					0, 					0},
-- runways
	{{78.36,  16.14,  11.23},		353.8, 				102.368, 		25.0, 0, 0, 0, 0, 0, 0, 0},
	{{78.34,  16.14, -11.23},		6.0, 				102.368, 		25.0, 0, 0, 0, 0, 0, 0, 0},
	--{{30.5, 16.1, -16.78},		7.0, 				146.118, 		25.0, 0, 0, 0, 0, 0, 0, 0},
	{{-14.26,  16.14, -20.3},		  	5.7, 				189.868, 		25.0, 0, 0, 0, 0, 0, 0, 0},
};
GT.RunWays.RunwaysNumber = #GT.RunWays

GT.TaxiRoutes = 
	-- taxi routes and parking spots (LCS)
	--    x				y        z			V_target
{
	{ -- 1 parking spot
		{{65.0,		16.14,     -25.0},		3.0},
		{{70.0,		16.14,   	 0.0},		2.0},
		{{-10.0,	16.14, 	  	 7.0},		2.0},
		{{-80.0,	16.14,  	15.0},		2.0},
		{{-88.5,	16.14,    	 8.5},		2.0},
		{{-105.17,	16.14,    	15.7},	   -2.0}
	},
	{ -- 2 parking spot
		{{65.0,		16.14,     -25.0},		3.0},
		{{70.0,		16.14,   	 0.0},		2.0},
		{{-10.0,	16.14,   	 7.0},		2.0},
		{{-66.0,	16.14,   	13.0},		2.0},
		{{-75.0,	16.14,   	 8.0},		2.0},
		{{-90.45,	16.14,   	18.3},	   -2.0}
	},
	{ -- 3 parking spot
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,   	 0.0},		2.0},
		{{-10.0,   	16.14,    	 6.0},		2.0},
		{{-54.0,   	16.14,   	12.0},		2.0},
		{{-61.7,   	16.14,   	 8.3},		2.0},
		{{-76.4,   	16.14,   	18.4},	   -2.0}
	},		
	{ -- 4 parking spot		
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,   	 0.0},		2.0},
		{{-12.0,   	16.14,   	 7.0},		2.0},
		{{-26.0,   	16.14,   	10.0},		2.0},
		{{-53.5,   	16.14,   	 7.0},		2.0},
		{{-60.8,   	16.14,   	19.2},	   -2.0}
	},
	{ -- 5 parking spot
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,   	 0.0},		2.0},
		{{42.0,   	16.14,   	 5.0},		2.0},
		{{-3.0,   	16.14,   	 7.0},		2.0},
		{{-20.3,   	16.14,   	 2.5},		2.0},
		{{-31.6,   	16.14,     13.06},	   -2.0}
	},
	{ -- 6 parking spot
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,   	 0.0},		2.0},
		{{20.0,   	16.14,   	 7.0},		2.0},
		{{1.5,   	16.14,   	 0.0},		2.0},
		{{-9.0,   	16.14,   	10.7},	   -2.0}
	},
	{ -- 7 parking spot
		{{65.0,		16.14,     -25.0},		3.0},
		{{70.0,		16.14,	 	 0.0},		2.0},
		{{42.0,		16.14,	 	 5.0},		2.0},
		{{14.8,   	16.14,    	-0.5},		2.0},
		{{5.2,   	16.14,   	 9.7},	   -2.0}
	},
	{ -- 8 parking spot
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,    	 0.0},		2.0},
		{{55.0,   	16.14,   	18.0},		2.0},
		{{29.1,   	16.14,   	-2.4},		2.0},
		{{19.7,   	16.14,    	 9.7},	   -2.0}
	},
	{ -- 9 parking spot
		{{65.0,   	16.14,     -25.0},		3.0},
		{{70.0,   	16.14,       5.0},		2.0},
		{{42.0,   	16.14,      -2.0},		2.0},
		{{32.0,   	16.14,      10.0},		-2.0}
	}
};
GT.TaxiRoutes.RoutesNumber = #GT.TaxiRoutes


GT.TaxiForTORoutes = 
	-- taxi routes and parking spots in LCS
	--    x				y        z			V_target
	{		
	{ RunwayIdx = 1, Points =
		{ -- 1 spawn spot(TP6) -> StartPos 1
			{{ 36.3,   		16.14,         9.0}, 	1.0},
			{{ 40.0,   		16.14,         3.5},  	1.0},		
			{{ 58.0,   		16.14,        12.5},  	1.0},		
			{{ 78.35,   	16.14,  	 11.23},	1.0}
		}
	},
	{ RunwayIdx = 2, Points =
		{ -- 2 spawn spot(TP8) -> StartPos 2
			{{  23.5,   	16.14,         7.4}, 	1.0},
			{{  30.5,   	16.14,     	  -2.4},  	1.0},
			{{  55.0,   	16.14,       -13.7},  	2.0},
			{{  78.33,  	16.14, 		-11.23}, 	1.0}
		}
	},
	{ RunwayIdx = 1, Points =
		{ -- 3 spawn spot(TP10) -> StartPos 1
			{{ 8.2,   		16.14,         8.8}, 	1.0},
			{{ 20.0,   		16.14,        -6.5},  	2.0},			
			{{ 49.0,   		16.14,        -6.8},  	2.0},
			{{ 52.0,   		16.14,        10.3},  	1.0},		
			{{ 78.34,  		16.14, 		 11.23},	1.0}
		}
	},	
	{ RunwayIdx = 2, Points =
		{  
			-- 4 spawn spot(TP12) -> StartPos 2
			{{  -6.7,   	16.14,         9.0}, 	1.0},
			{{   0.0,   	16.14,     	   0.0},  	1.0},
			{{  16.0,   	16.14, 	      -9.7},  	2.0},
			{{  20.0,   	16.14,       -10.0}, 	2.0},		
			{{  55.0,   	16.14,       -13.7},  	2.0},
			{{ 78.33,  		16.14, 		-11.23}, 	1.0}
		}
	},	
	{ RunwayIdx = 1, Points =
		{  
			-- 5 spawn spot(TP14) -> StartPos 1
			{{ -29.5,   	16.14,        11.5}, 	1.0},
			{{ -23.0,   	16.14,         3.5}, 	1.0},
			{{  -8.0,   	16.14,        -6.0}, 	1.0},
			{{  20.0,   	16.14,       -10.0}, 	2.0},			
			{{ 49.0,   		16.14,        -6.8},  	2.0},
			{{ 52.0,   		16.14,        10.3},  	1.0},		
			{{ 78.34,  		16.14, 	 	 11.23},	1.0}			
--			{{  55.0,   	16.1,        -13.7},  	2.0},
--			{{  78.23,  	16.1, 		-11.23}, 	1.0}
		}
	},
	{ RunwayIdx = 3, Points =
		{ -- 6 spawn spot(TP18) -> StartPos 3
			{{ -57.5,   	16.14,        17.0}, 	1.0},
			{{ -51.5,   	16.14,  	   7.0},  	1.0},
			{{ -38.0,   	16.14, 	     -14.0},  	2.0},
			{{ -33.0,   	16.14,       -21.0},  	1.0},
			{{  -14.26,  	16.14, 	     -20.3}, 	1.0}
		}
	},
	{ RunwayIdx = 3, Points =
		{ -- 7 spawn spot(TP19) -> StartPos 3
			{{ -73.1,   	16.14,        16.8}, 	1.0},
			{{ -54.0,		16.14,        -1.5},  	1.0},
			{{ -33.0,   	16.14,     	 -21.5},  	2.0},
			{{  -14.26,  	16.14, 	 	 -20.3}, 	1.0}
		}
	},
	{ RunwayIdx = 3, Points =
		{  -- 8 spawn spot(TP20) -> StartPos 3
			{{ -86.8,		16.14,        17.0}, 	1.0},
			{{ -76.0,		16.14,    	   8.0},  	1.0},
			{{ -33.0,   	16.14,       -21.5},  	2.0},
			{{  -14.26,  	16.14, 	     -20.3}, 	1.0}
		}
	},
	{ RunwayIdx = 3, Points =
		{  -- 9 spawn spot(TP21) -> StartPos 3
			{{ -101.3,		16.14,       14.3}, 	1.0},
			{{ -90.5,		16.14,     	  8.5},  	1.0},			
			{{ -33.0,   	16.14,      -21.5},  	2.0},
			{{  -14.26,  	16.14, 	    -20.3}, 	1.0}
		}
	},	
}
GT.TaxiForTORoutes.RoutesForTONumber = #GT.TaxiForTORoutes


GT.HelicopterSpawnTerminal = 
	-- taxi routes and parking spots in LCS
	--    x				y        z			direction
{		
	{ TerminalIdx = 1, Points =
		{ -- 1 spawn spot
			{{ 115.8,	16.20,	  -7.62},   0.0}			
		}
	},
	{ TerminalIdx = 2, Points =
		{ -- 2 spawn spot
			{{   91.6,	16.14,	   -9.0},   0.0}			
		}
	},
	{ TerminalIdx = 3, Points =
		{ -- 3 spawn spot								
			{{	73.2,	16.14,	  -27.9},   0.0}
		}
	},	
	{ TerminalIdx = 4, Points =
		{ -- 4 spawn spot
			{{	50.4,	16.14,	  -27.9},	0.0}
		}
	},
	{ TerminalIdx = 5, Points =
		{ -- 5 spawn spot
			{{	24.4,	16.14,	  -22.5},	0.0}
		}
	},
	{ TerminalIdx = 6, Points =
		{ -- 6 spawn spot
			{{	-2.2,	16.14,	  -21.7},	0.0}
		}
	},
	{ TerminalIdx = 7, Points =
		{ -- 7 spawn spot
			{{	-53.0,	16.14,	  -25.0},	0.0}
		}
	},
	{ TerminalIdx = 8, Points =
		{ -- M spawn spot
			{{	-92.0,	16.14,	   -3.7},	0.0}
		}
	},
}
GT.HelicopterSpawnTerminal.TerminalNumber = #GT.HelicopterSpawnTerminal