-- ***************** "USS Tarawa LHA-1" ******************************

--   Runways and landing strip for Tarawa in LCS

GT.RunWays =
{     
-- landing strip definition (first in table)
--	VppStartPoint; 					azimuth (degree} 	Length_Vpp; 	Width_Vpp;
	{{-4.54,	20.0, -5.7}, 		1.22, 			240.0, 			36.0, 		
-- alsArgument, lowGlidePath, slightlyLowGlidePath, onLowerGlidePath, onUpperGlidePath, slightlyHighGlidePath, highGlidePath
	0, 			2.5, 		  		2.8, 					3.0, 			  3.0, 				3.2, 				3.5},
-- runways
	{{-25,	20.0, -5.65}, 		1.22, 			145, 			36.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{-50,	20.0, -6.29}, 		1.22, 			170, 			36.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{-75,	20.0, -6.78}, 		1.22, 			195, 			36.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{-100,	20.0, -7.33}, 		1.22, 			220, 			36.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
};
GT.RunWays.RunwaysNumber = #GT.RunWays

GT.TaxiRoutes = 
	-- taxi routes and parking spots in LCS
	--    x				y        z			V_target
{		
	{ -- 1 parking spot
		{{ 	82.0, 	20.0,		-3.5},		4.0},
		{{	88.0,	20.0,		 8.0},		2.0},
		{{  90.0,	20.0,		14.0},		1.0}
	},
	{ -- 2 parking spot
		{{ 	67.0, 	20.0,		-3.8},		4.0},
		{{	73.0,	20.0,		 8.0},		2.0},
		{{  75.0,	20.0,		14.0},		1.0}
	},
	{ -- 3 parking spot
		{{ 	52.0, 	20.0,		-4.2},		3.0},
		{{	58.0,	20.0,		 8.0},		2.0},
		{{  60.0,	20.0,		14.0},		1.0}
	},
	{ -- 4 parking spot
		{{ 	37.0, 	20.0,		-4.5},		3.0},
		{{	43.0,	20.0,		 8.0},		2.0},
		{{  45.0,	20.0,		14.0},		1.0}
	},
	{ -- 5 parking spot
		{{-105.0, 	20.0,		-6.5},		2.0},
		{{-113.0,	20.0,		 8.0},		2.0},
		{{-115.0,	20.0,		14.0},		1.0}
	},	
	{ -- 7parking spot
		{{ -75.0, 	20.0,		-5.5},		2.0},
		{{ -83.0,	20.0,		 8.0},		2.0},
		{{ -85.0,	20.0,		14.0},		1.0}
	},
	{ -- 6parking spot
		{{ -90.0, 	20.0,		-5.5},		2.0},
		{{ -98.0,	20.0,		 9.0},		2.0},
		{{-100.0,	20.0,		14.0},		1.0}
	},
	{ -- 8parking spot
		{{ -60.0, 	20.0,		-5.5},		2.0},
		{{ -68.0,	20.0,		 8.0},		2.0},
		{{ -70.0,	20.0,		14.0},		1.0}
	},
}
GT.TaxiRoutes.RoutesNumber = #GT.TaxiRoutes

GT.TaxiForTORoutes = 
	-- taxi routes and parking spots in LCS
	--    x				y        z			V_target
	{		
	{ RunwayIdx = 1, Points =
		{  
			-- 4 spawn spot(TP12) -> StartPos 2
			{{ -70.0,	20.0,		14.0},		1.0},
			{{ -68.0,	20.0,		 8.0},		2.0},
			{{ -60.0, 	20.0,		-5.5},		2.0},
			{{ -35.0, 	20.0,		-5.5},		2.0}
		}
	},
	{ RunwayIdx = 2, Points =
		{ -- 3 spawn spot(TP10) -> StartPos 1
			{{ -85.0,	20.0,		14.0},		1.0},
			{{ -83.0,	20.0,		 8.0},		2.0},		
			{{ -75.0, 	20.0,		-5.5},		2.0},
			{{ -60.0, 	20.0,		-6.2},		2.0}
		}
	},
	{ RunwayIdx = 3, Points =
		{ -- 2 spawn spot(TP8) -> StartPos 2
			{{-100.0,	20.0,		14.0},		1.0},
			{{ -98.0,	20.0,		 9.0},		2.0},
			{{ -90.0, 	20.0,		-5.5},		2.0},
			{{ -65.0, 	20.0,		-6.5},		2.0}
		}
	},
	{ RunwayIdx = 4, Points =
		{ -- 
			{{-115.0,	20.0,		14.0},		1.0},
			{{-113.0,	20.0,		 8.0},		2.0},
			{{-110.0, 	20.0,		-7.5},		2.0}
		}
	},
}
GT.TaxiForTORoutes.RoutesForTONumber = #GT.TaxiForTORoutes

GT.HelicopterSpawnTerminal = 
	-- taxi routes and parking spots in LCS
	--    x				y        z			direction
{		
	{ TerminalIdx = 5, Points =
		{ -- 1 spawn spot
			{{ 102.3,	20.0,		0.5}, 	0.0}			
		}
	},
	{ TerminalIdx = 6, Points =
		{ -- 3 spawn spot									
			{{	78.2,	20.0,	  13.65},  	15.0}
		}
	},
	{ TerminalIdx = 7, Points =
		{ -- 2 spawn spot
			{{   78.2,	20.0,	  -14.0}, 	0.0}			
		}
	},
	{ TerminalIdx = 8, Points =
		{ -- 4 spawn spot									
			{{	47.2,	20.0,	  -14.0},  	0.0}
		}
	},	
	{ TerminalIdx = 9, Points =
		{ -- 5 spawn spot
			{{	15.8,	20.0,	 -14.0},	0.0}
		}
	},	
	{ TerminalIdx = 10, Points =
		{ -- 6 spawn spot
			{{ -15.0,	20.0,	 -14.0},  	0.0}
		}
	},
	{ TerminalIdx = 11, Points =
		{ -- 7 spawn spot
			{{-46.5,	20.0,	 -14.0},  	0.0}
		}
	},
	{ TerminalIdx = 12, Points =
		{ -- 8 spawn spot
			{{-91.0,	20.0,	 -14.0},	0.0}
		}
	},	
	--[[{ TerminalIdx = 9, Points =
		{ -- 3A spawn spot									
			{{	51.8,	20.0,	  13.65},  	30.0}
		}
	},
	{ TerminalIdx = 10, Points =
		{ -- 9 spawn spot									
			{{	-91.5,	20.0,	  13.65},  	0.0}
		}
	},]]--
}
GT.HelicopterSpawnTerminal.TerminalNumber = #GT.HelicopterSpawnTerminal