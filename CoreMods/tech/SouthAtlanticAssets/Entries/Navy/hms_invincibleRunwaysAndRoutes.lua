-- ***************** "HMS Invincible R05 1980" ******************************

--   Runways and landing strip for HMS Invincible R05 in DCS

-- ===========================================================================================================================

GT.RunWays =
{     
-- landing strip definition (first in table)
--	VppStartPoint; 					azimuth (degree} 	Length_Vpp; 	Width_Vpp;  alsArgument, lowGlidePath, slightlyLowGlidePath, onLowerGlidePath, onUpperGlidePath, slightlyHighGlidePath, highGlidePath
--	{{-100.0, 14.709, -9.952}, 				359.330, 				180.0, 				25,  	0, 			2.5, 		  		2.8, 					3.0, 			  3.0, 				3.2, 				3.5},
	{{ -12.0, 14.709, -10.5 }, 				359.330, 				180.0, 				25,  	0, 			2.5, 		  		2.8, 					3.0, 			  3.0, 				3.2, 				3.5},
-- runways 
	{{ -88.0,	  14.709,   -9.952}, 		359.330, 			180, 	    12.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},  --runway 1	
--	{{-100.0,	  14.709,   -9.952}, 		359.330, 			180, 	    12.0, 		0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},  --runway 1	
};

GT.RunWays.RunwaysNumber = #GT.RunWays;

-- ===========================================================================================================================

GT.Landing_Point	= {-97.0, 14.709, -9.952} 						-- Landing touch-down point (Y, Z, X : -Y = port, +Y = Stbd : Z should = deck level)

-- ===========================================================================================================================

-- ==============================================================================
-- ================                                                    ==========
-- ================         Parking/Ramp and taxi paths                ==========
-- ================                                                    ==========
-- ================ Parking is at the first waypoint, with the         ==========
-- ================    aircraft following the waypoints to the         ==========
-- ================                                                    ==========
-- ================ There needs to be one entry for every combination  ==========
-- ================      of path from parking to each runway.          ==========
-- ================                                                    ==========
-- ==============================================================================

GT.TaxiRoutes = 
{					
--[[
--]]
--       x, z, y (-y = port, +y = stbd),     V_target (m/s)

	{ -- 1 parking spot
		--{{ -30,   14.709,     2.5 },		2.0}, --wp1
		{{ -40,	14.709,	    -9.0 },		2.0}, --wp2
		{{-80, 	14.709, 	-5.5}, 		2.0}, --wp3 Turn
	    {{-102,  14.709,	2.5 },	   -2.0} -- end park spot Reverse after 2 minutes despawn
	},
	
	{ -- 2 parking spot 
		--{{ -30,   14.709,    2.5 },		2.0}, --wp1
		{{ -40,	14.709,	   -9.0 },		2.0}, --wp2
	    {{ -75,	14.709,	   -4.0 },		2.0}, -- wp3
		{{ -96,	14.709,	   11.5},		-2.0} -- end park spot
	},

	{ -- 3 parking spot
		--{{ -30,   14.709,    2.5 },		2.0}, --wp1
		{{ -40,	14.709,	   -9.0 },		2.0}, --wp2
	    {{-85,	14.709,	   -5.5 },		2.0}, -- wp3 Turn
		{{ -85,	14.709,	   12.0 },		-2.0} -- end park spot
	},

	{ -- 4 parking spot
		{{ -40,   14.709,   -9.0 },		2.0}, --wp1
		{{ -72,	14.709,	   -5.0 },		2.0}, --wp2
		{{ -72,  14.709,   12.0 },		-1.0} -- end park spot
	},	

	{ -- 5 parking spot		
		{{ -40,	14.709,	   -9.0 },		2.0}, --wp1
		{{ -60,	  14.709,     -5.5 },		2.0}, --wp2
		{{ -60,	  14.709,     12.0 },	    -1.0} -- end park spot
    },

	{ -- 6 parking spot	
		{{ 0,   14.709,   -5.0 },		2.0}, --wp1
		{{ 10,	14.709,	   2.0 },		2.0}, --wp2
		{{ 58,	  14.709,     3.0 },		1.0}  -- end park spot
    },

}
GT.TaxiRoutes.RoutesNumber = #GT.TaxiRoutes

-- ===========================================================================================================================

GT.TaxiForTORoutes = 
	-- taxi routes and parking spots in LCS
	--    x				z        y		V_target
{		
	{ RunwayIdx = 1, Points =
		{ -- 1 spawn Stbd pos 1 aft of island
			{{  -98.8,	14.709,    10.5	},      1.0 },
			{{  -98.8,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,    -5.8 },      1.0 },
			{{  -96.3,	14.709,    -9.5 },      1.0 },
			{{  -88.5,	14.709,  -9.536 },      0.5 },
		}
	},
	{ RunwayIdx = 1, Points =
		{ -- 2 spawn Stbd pos 2 aft of island
			{{  -83.9,	14.709,	    9.9 },      1.0 },
			{{  -89.5,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,    -5.8 },      1.0 },
			{{  -96.3,	14.709,    -9.5 },      1.0 },
			{{  -88.5,	14.709,  -9.536 },      0.5 },
		}
	},
	{ RunwayIdx = 1, Points =
		{ -- 3 spawn Stbd pos 3 aft of island
			{{  -71.7,	14.709,	   10.0 },      1.0 },
			{{  -77.4,	14.709,     2.0 },      1.0 },
			{{  -89.5,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,    -5.8 },      1.0 },
			{{  -96.3,	14.709,    -9.5 },      1.0 },
			{{  -88.5,	14.709,  -9.536 },      0.5 },
		}
	},	
	{ RunwayIdx = 1, Points =
		{ -- 4 spawn Stbd pos 4 aft of island
			{{  -60.0,	14.709,	    9.6 },      1.0 },
			{{  -65.3,	14.709,	    2.0 },      1.0 },
			{{  -77.4,	14.709,     2.0 },      1.0 },
			{{  -89.5,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,     2.0 },      1.0 },
			{{  -98.8,	14.709,    -5.8 },      1.0 },
			{{  -96.3,	14.709,    -9.5 },      1.0 },
			{{  -88.5,	14.709,  -9.536 },      0.5 },
		}
	},
}
GT.TaxiForTORoutes.RoutesForTONumber = #GT.TaxiForTORoutes;

-- ===========================================================================================================================

GT.HelicopterSpawnTerminal = 
	-- taxi routes and parking spots in LCS
	--    x				z        y			direction
{		
	{ TerminalIdx = 1, Points =
		{ -- 1 spawn spot
			{{   45.8,	14.709,	-14.7 },	0.0 }
		}
	},
	
	{ TerminalIdx = 2, Points =
		{ -- 2 spawn spot
			{{    8.0,	14.709,	-14.3 },	0.0 }
		}
	},

	{ TerminalIdx = 3, Points =
		{ -- 3 spawn spot
			{{  -26.3,	14.709,	-13.9 },	0.0 }
		}
	},	
	
	{ TerminalIdx = 4, Points =
		{ -- 4 spawn spot
			{{  -65.4,	14.709,	-13.1 },	0.0 }
		}
	},	
	{ TerminalIdx = 5, Points =
		{ -- 8 spawn spot
			{{  -93.4,	14.709,	-12.4 },	0.0 }
		}
	},	
	
	{ TerminalIdx = 6, Points =
		{ -- 5 spawn spot
			{{  -65.5,	14.709,	 10.9 },	0.0 }
		}
	},	
	
	{ TerminalIdx = 7, Points =
		{ -- 9 spawn spot
			{{  -93.6,	14.709,	 10.5 },	0.0 }
		}
	},
-- Never used in reality	
	-- { TerminalIdx = 8, Points =
		-- { -- 6 spawn spot
			-- {{  -79.4,	14.709,	-12.9 },	0.0 }
		-- }
	-- },
	-- { TerminalIdx = 9, Points =
		-- { -- 7 spawn spot
			-- {{	-79.2,	14.709,	 10.9 },	0.0 }
		-- }
	-- },
}

GT.HelicopterSpawnTerminal.TerminalNumber = #GT.HelicopterSpawnTerminal;

-- ===========================================================================================================================

