-- ***************** "CV-59 USS Forrestal" ******************************

--   Runways and landing strip for USS Forrestal in LCS

GT.RunWays =
{
	-- landing strip definition (first in table)
	--	VppStartPoint; 					azimuth (degree} 	Length_Vpp; 	Width_Vpp;
	{{-28.28,	18.46, -10.54}, 		350.58, 			170.0, 			25.0,
		-- alsArgument, lowGlidePath, slightlyLowGlidePath, onLowerGlidePath, onUpperGlidePath, slightlyHighGlidePath, highGlidePath
	 0, 			2.5, 		  		2.8, 					3.0, 			  3.0, 				3.2, 				3.5},
	-- runways
	--{{50.83,	18.46, 14.53}, 		356.0,	 			100.0, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},	-- shuttle position
	--{{47.379,	18.46, -3.885}, 	358.25, 			100.0, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},	-- shuttle position
	--{{-41.266,	18.46, -19.396},	355.5,	 			100.0, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},	-- shuttle position
	--{{-57.451,	18.46, -30.17}, 	0.0, 				100.0, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},	-- shuttle position

	{{82.414,	18.46, 13.907}, 	356.72,	 			94.5, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{81.735,	18.46, -11.985}, 	3.03, 				95.0, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{-36.638,	18.46, -17.912},	352.92,	 			96.4, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
	{{-46.811,	18.46, -31.578}, 	0.0, 				127.7, 			25.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
};

GT.RunWays.RunwaysNumber = #GT.RunWays

GT.TaxiRoutes =
-- taxi routes and parking spots in LCS
--    x				y        z			V_target
{
	{ -- 1st spot, far rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ -70.3,	18.46,		 20.8},  	3.0},
		{{ -70.3,	18.46,		 32.8},  	-3.0}
	},
	{ -- 2nd spot, 2nd from the rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ 4.5,		18.46,		 -4.2},  	4.0},
		{{ -59.8,	18.46,		 19.2},  	3.0},
		{{ -59.8,	18.46,		 21.0},  	-3.0},
		{{ -59.8,	18.46,		 32.8},  	-3.0}
	},
	{ -- 3nd spot, 3rd from the rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ 4.5,		18.46,		 -4.2},  	4.0},
		{{ -49.3,	18.46,		 17.4},  	3.0},
		{{ -49.3,	18.46,		 21.0},  	-3.0},
		{{ -49.3,	18.46,		 32.8},  	-3.0}
	},
	{ -- 4th spot, 4th from the rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ 4.5,		18.46,		 -4.2},  	4.0},
		{{ -38.8,	18.46,		 15.6},  	3.0},
		{{ -38.8,	18.46,		 21.6},  	-3.0},
		{{ -38.8,	18.46,		 32.8},  	-3.0}
	},
	{ -- 5th spot, 5th from the rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ 4.5,		18.46,		 -4.2},  	4.0},
		{{ -28.3,	18.46,		 13.7},  	3.0},
		{{ -28.3,	18.46,		 21.7},  	-3.0},
		{{ -28.3,	18.46,		 32.8},  	-3.0}
	},
	{ -- 6th spot, 6th from the rear behind the island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 45.5,	18.46,		 -9.7},  	4.0},
		{{ 4.5,		18.46,		 -4.2},  	4.0},
		{{ -17.8,	18.46,		 11.9},  	3.0},
		{{ -17.8,	18.46,		 21.7},  	-3.0},
		{{ -17.8,	18.46,		 32.8},  	-3.0}
	},
	{ -- 7th spot, directly in front of island
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 61.8,	18.46,		 -11.2},  	4.0},
		{{ 60.8,	18.46,		 7.8},  	3.0},
		{{ 40.6,	18.46,		 0.5},  	3.0},
		{{ 40.0,	18.46,		 20.8},  	-3.0},
		{{ 40.0,	18.46,		 32.8},  	-3.0}
	},
	{ -- 8th spot, further in front of the island.
		{{ 48.8,	18.46,		-26.2},  	6.0},
		{{ 61.8,	18.46,		 -11.2},  	4.0},
		{{ 60.8,	18.46,		 7.8},  	3.0},
		{{ 46.7,	18.46,		 -1.4},  	3.0},
		{{ 50.5,	18.46,		 20.8},  	-3.0},
		{{ 50.5,	18.46,		 32.8},  	-3.0}
	},
	--{ -- 9th spot, onto port elevator.
	--	{{ 48.8,	18.46,		-25.0},  	6.0},
	--	{{ 58.0,	18.46,		 1.0},  	4.0},
	--	{{ 59.0,	18.46,		-33.4},  	-3.0, 3.0*60.0}  -- Should be despawining?
	--},
}
GT.TaxiRoutes.RoutesNumber = #GT.TaxiRoutes


GT.TaxiForTORoutes =
-- taxi routes and parking spots in LCS
--    x				y        z			V_target
{
	{ RunwayIdx = 2, Points =
	{ -- 1: 1st in six pack -> cat 2
		{{ 58.2,	18.46,		   1.3}, 	2.0, 20.0},
		{{ 56.0,	18.46,		   -8.7},  	2.0},
		{{ 71.6,	18.46,		  -15.7},  	1.0},
		{{ 83.3,	18.46,		  -13.1},  	1.0}
	}
	},
	{ RunwayIdx = 1, Points =
	{ -- 2: 2nd in six pack -> cat 1
		{{  47.2,	18.46,	      3.2}, 	2.0, 20.0},
		{{  46.2,	18.46,		  -2.1},  	2.0},
		{{ 74.0,	18.46,		 15.3}, 	2.0},
		{{ 82.4,	18.46,		 12.7}, 	1.0}
	}
	},
	{ RunwayIdx = 3, Points =
	{ -- 3: 3rd in six pack -> cat 3
		{{ 36.0,	18.46,		   5.6}, 	3.0, 20.0},
		{{ 31.9,	18.46,		  -15.0},  	4.0},
		{{ 10.5,	18.46,		  -15.2},  	4.0},
		{{ -32.6,	18.46,		  -3.9},  	4.0},
		{{ -49.4,	18.46,		  -9.3},  	2.0},
		{{ -36.6,	18.46,		  -19.3},  	1.0}
	}
	},
	{ RunwayIdx = 4, Points =
	{ -- 4: 4th in six pack -> cat 4
		{{ 24.4,	18.46,		   7.8}, 	3.0, 20.0},
		{{ 21.6,	18.46,		  -3.9},  	4.0},
		{{ -50.4,	18.46,		  -2.2},  	4.0},
		{{ -61.0,	18.46,		  -32.2},  	3.0},
		{{ -46.8,	18.46,		  -32.8},  	1.0}
	}
	},
	{ RunwayIdx = 1, Points =
	{ -- 5: Furthest directly forward from island -> cat 1
		{{ 54.8,	18.46,		   32.6}, 	2.0},
		{{ 54.8,	18.46,		  28.0},  	1.5},
		{{ 62.1,	18.46,		  11.9},  	2.0},
		{{ 82.4,	18.46,		 12.7}, 	0.5}
	}
	},
	{ RunwayIdx = 2, Points =
	{ -- 6: Closest directly forward from island -> cat 2
		{{ 43.0,	18.46,		   32.6}, 	3.0},
		{{ 43.0,	18.46,		   21.8}, 	3.0},
		{{ 17.0,	18.46,		  6.8}, 	3.0},
		{{ 68.0,	18.46,		  -14.1},  	3.0},
		{{ 82.7,	18.46,		  -13.1},  	2.0}
	}
	},
	{ RunwayIdx = 3, Points =
	{ -- 7: Closest directly behind island -> cat 3
		{{ -17.8,	18.46,		   32.6}, 	2.0},
		{{ -17.8,	18.46,		   6.0}, 	3.0},
		{{ -73.0,	18.46,		  -3.8},  	2.0},
		{{ -36.6,	18.46,		  -19.3},  	2.0}
	}
	},
	{ RunwayIdx = 4, Points =
	{ -- 8: 2nd directly behind island -> cat 4
		{{ -28.3,	18.46,		   32.6}, 	0.5},
		{{ -27.5,	18.46,		   6.0}, 	1.0},
		{{ -49.3,	18.46,		  2.1},  	2.0},
		{{ -78.9,	18.46,		  -16.9},  	3.0},
		{{ -63.2,	18.46,		  -33.2},  	2.0},
		{{ -47.0,	18.46,		  -33.0},  	1.0}
	}
	},
	{ RunwayIdx = 3, Points =
	{ -- 9: 3rd directly behind island -> cat 3
		{{ -38.8,	18.46,		   32.6}, 	2.0},
		{{ -38.8,	18.46,		   13.5}, 	2.0},
		{{ -32.7,	18.46,		  	2.0},  	3.0},
		{{ -82.0,	18.46,		  	3.1},  	2.0},
		{{ -36.6,	18.46,		  -19.3},  	2.0}
	}
	},
	{ RunwayIdx = 4, Points =
	{ -- 10: 4th directly behind island -> cat 4
		{{ -49.3,	18.46,		   32.6}, 	0.5},
		{{ -49.3,	18.46,		   17.7}, 	0.5},
		{{ -47.1,	18.46,		  	4.0}, 	2.0},
		{{ -94.7,	18.46,		  	2.6},  	3.0},
		{{ -83.0,	18.46,		  -11.6},  	3.0},
		{{ -63.2,	18.46,		  -33.2},  	2.0},
		{{ -47.0,	18.46,		  -33.0},  	2.0}
	}
	},
	{ RunwayIdx = 3, Points =
	{ -- 11: 5th directly behind island -> cat 3
		{{ -59.8,	18.46,		   32.6}, 	0.5},
		{{ -59.8,	18.46,		   17.7}, 	1.0},
		{{ -32.7,	18.46,		  	8.0},  	2.0},
		{{ -82.0,	18.46,		  	5.1},  	3.0},
		{{ -36.6,	18.46,		  -19.3},  	2.0}
	}
	},
	{ RunwayIdx = 4, Points =
	{ -- 12: 6th directly behind island -> cat 4
		{{ -70.3,	18.46,		   32.6}, 	0.5},
		{{ -70.3,	18.46,		   25.7}, 	0.5},
		{{ -47.1,	18.46,		   14.0}, 	2.0},
		{{ -94.7,	18.46,		  	2.6},  	3.0},
		{{ -83.0,	18.46,		  -14.6},  	3.0},
		{{ -63.2,	18.46,		  -33.2},  	2.0},
		{{ -47.0,	18.46,		  -33.0},  	2.0}
	}
	},
}
GT.TaxiForTORoutes.RoutesForTONumber = #GT.TaxiForTORoutes


GT.HelicopterSpawnTerminal =
-- taxi routes and parking spots in LCS
--    x				y        z			direction
{
	{ TerminalIdx = 1, Points =
	{ -- 1
		{{ -58.2,	18.46,	-31.9}, 	2.0}
	}
	},
	{ TerminalIdx = 2, Points =
	{ -- 2
		{{   59.4,	18.46,	-29.9}, 	0.0}
	}
	},
	{ TerminalIdx = 3, Points =
	{ -- 3
		{{   -119.6,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 4, Points =
	{ -- 4
		{{   -96.4,	18.46,	7.1}, 	0.0}
	}
	},
	{ TerminalIdx = 5, Points =
	{ -- 5
		{{   171.0,	18.46,	-8.3}, 	0.0}
	}
	},
	{ TerminalIdx = 6, Points =
	{ -- 6
		{{   151.2,	18.46,	7.2}, 	0.0}
	}
	},
	{ TerminalIdx = 7, Points =
	{ -- 7
		{{   -70.0,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 8, Points =
	{ -- 8
		{{   -46.9,	18.46,	7.1}, 	0.0}
	}
	},
	{ TerminalIdx = 9, Points =
	{ -- 9
		{{   -21.3,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 10, Points =
	{ -- 10
		{{   1.9,	18.46,	7.1}, 	0.0}
	}
	},
	{ TerminalIdx = 11, Points =
	{ -- 11
		{{   28.3,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 12, Points =
	{ -- 12
		{{   51.5,	18.46,	7.1}, 	0.0}
	}
	},
	{ TerminalIdx = 13, Points =
	{ -- 13
		{{   78.5,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 14, Points =
	{ -- 14
		{{   101.7,	18.46,	7.1}, 	0.0}
	}
	},
	{ TerminalIdx = 15, Points =
	{ -- 15
		{{   128.0,	18.46,	-9.3}, 	0.0}
	}
	},
	{ TerminalIdx = 16, Points =
	{ -- 16
		{{   3.0,	18.46,	-29.7}, 	0.0}
	}
	},
}
GT.HelicopterSpawnTerminal.TerminalNumber = #GT.HelicopterSpawnTerminal

GT.ArrestingGears =
{
	--[[
	--[example]
	{
		-- coordinates for spools (Left and Right) in LCS:
		-- if connector exists write connector name
		-- else write position coordinates manually  -- [pos] omitted when [connector_name] exists
		Left =	{ connector_name = '',	pos = {xl,yl,zl} },
		Right =	{ connector_name = '',	pos = {xr,yr,zr} }
	},
	--]]
	{
		Left = {	connector_name = 'POINT_TROS_01_01' },
		Right = {	connector_name = 'POINT_TROS_01_02' }
	},
	{
		Left = {	connector_name = 'POINT_TROS_02_01' },
		Right = {	connector_name = 'POINT_TROS_02_02' }
	},
	{
		Left = {	connector_name = 'POINT_TROS_03_01' },
		Right = {	connector_name = 'POINT_TROS_03_02' }
	},
	{
		Left = {	connector_name = 'POINT_TROS_04_01' },
		Right = {	connector_name = 'POINT_TROS_04_02' }
	},
}

GT.ArrestingGears.ArrestingGearsNumber = #GT.ArrestingGears

GT.Elevators =
-- ElevatorTypes :	SPAWN	= 0, DESPAWN = 1, BOTH	= 2
-- elevator routes and parking spots in LCS
--    x				y        z			V_target
{
	--{ 	ElevatorIdx = 4, ElevatorType = 1, TerminalIdx = 1,	Points =
	--	{
	--		{{59.0,		 7.05,		-33.4}, 	1.0},
	--		{{59.0,		 7.05,		 0.0}, 	1.0},
	--		{{20.0,		 7.05,		 0.0}, 	1.0}
	--	}
	--},
	--{ 	ElevatorIdx = 2, ElevatorType = 1, TerminalIdx = 1,	Points =
	--	{
	--		{{-22.5,	 7.05,		 36.0}, 	1.0},
	--		{{-22.5,	 7.05,		 -3.0}, 	1.0},
	--		{{-36.5,	 7.05,		 -4.5}, 	1.0}
	--	}
	--},
	--{
	--	ElevatorIdx = 3, ElevatorType = 1, TerminalIdx = 1,	Points =
	--	{
	--		{{-67.0,	 7.05,		 36.0}, 	1.0},
	--		{{-67.0,	 7.05,		 -3.0}, 	1.0},
	--		{{-53.0,	 7.05,		 -4.5}, 	1.0}
	--	}
	--},
}
GT.Elevators.ElevatorsNumber = #GT.Elevators
