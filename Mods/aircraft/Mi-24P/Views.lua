local anchor = {3.176, 0.586, -0.007}
		
local function player(x,y)
	return {	
		CockpitLocalPoint      = {x,y,anchor[3]},
		CameraViewAngleLimits  = {20.000000,140.000000},
		CameraAngleRestriction = {false,90.000000,0.400000},
		CameraAngleLimits      = {200,-65.000000,90.000000},
		EyePoint               = {0.05000,0.100000,0.000000},
		ShoulderSize		   = 0.25,
		Allow360rotation	   = false,
		limits_6DOF            = {x = {-0.1,0.5},y ={-0.3,0.1},z = {-0.3,0.3},roll = 90.0},
	}
end

local function gunner(x,y, ang)
	return {	
		CockpitLocalPoint      = {x,y, 0.0},
		CockpitLocalPointAzimuth  = ang,
		CameraViewAngleLimits  = {20.000000,100.000000},
		CameraAngleRestriction = {false,60.000000,0.400000},
		CameraAngleLimits      = {90,-45.000000,60.000000},
		EyePoint               = {0.090000,0.000000,0.000000},
		Allow360rotation	   = false,
		ExternalShapeUsed	   = true,
		limits_6DOF            = {x 	= {-1.1, 1.6},
								  y 	= {-0.55, 0.55}, 
								  z 	= {-0.46, 0.46},
								  roll  = 45.000000},

	}
end

ViewSettings = {
	--}, -- Cockpit
	Cockpit = {
		CockpitAnchorPoint = anchor,
		player(3.15, 0.57),
		player(4.65, -0.05),--видимо X Y(4.65, 0.04)
		gunner(0.0, 0.0, 90),
	}, --Cockpit
	Chase = {
		LocalPoint      = {-5.700000,1.400000,-3},
		AnglesDefault   = {0,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-20.000000,5.000000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}

SnapViews = {
[1] = {-- player slot 1
	[1] = {--LWin + Num0 : Snap View 0
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {--LWin + Num1 : Snap View 1
		viewAngle = 29.415312,--FOV
		hAngle	 = -93.376801,
		vAngle	 = 9.582571,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {--LWin + Num2 : Snap View 2
		viewAngle = 50.895313,--FOV
		hAngle	 = -48.569939,
		vAngle	 = 25.302469,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[4] = {--LWin + Num3 : Snap View 3
		viewAngle = 44.628349,--FOV
		hAngle	 = -58.224052,
		vAngle	 = -52.560867,
		x_trans	 = 0.000000,
		y_trans	 = 0.067124,
		z_trans	 = 0.016026,
		rollAngle = 0.000000,
	},
	[5] = {--LWin + Num4 : Snap View 4
		viewAngle = 81.069313,--FOV
		hAngle	 = 0.352628,
		vAngle	 = 62.929485,
		x_trans	 = 0.000000,
		y_trans	 = 0.135126,
		z_trans	 = 0.200000,
		rollAngle = 0.000000,
	},
	[6] = {--LWin + Num5 : Snap View 5
		viewAngle = 59.741261,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 41.349342,
		x_trans	 = 0.000000,
		y_trans	 = -0.050205,
		z_trans	 = -0.004188,
		rollAngle = 0.000000,
	},
	[7] = {--LWin + Num6 : Snap View 6
		viewAngle = 28.216700,--FOV
		hAngle	 = -76.491844,
		vAngle	 = 9.112473,
		x_trans	 = 0.000000,
		y_trans	 = -0.050205,
		z_trans	 = -0.024370,
		rollAngle = 0.000000,
	},
	[8] = {--LWin + Num7 : Snap View 7
		viewAngle = 56.762150,--FOV
		hAngle	 = 31.801413,
		vAngle	 = 102.962082,
		x_trans	 = 0.000000,
		y_trans	 = -0.050205,
		z_trans	 = -0.024370,
		rollAngle = 0.000000,
	},
	[9] = {--LWin + Num8 : Snap View 8
		viewAngle = 39.324799,--FOV
		hAngle	 = 4.669143,
		vAngle	 = -1.769594,
		x_trans	 = 0.000000,
		y_trans	 = 0.067124,
		z_trans	 = 0.016026,
		rollAngle = 0.000000,
	},
	[10] = {--LWin + Num9 : Snap View 9
		viewAngle = 59.208893,--FOV
		hAngle	 = -32.128311,
		vAngle	 = -5.720805,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[11] = {--look at left  mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = 14.803060,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[12] = {--look at right mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = -14.414484,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[13] = {--default view
		viewAngle = 89.777542,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -15.907917,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
},

[2] = {-- player slot 2
	[1] = {--LWin + Num0 : Snap View 0
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {--LWin + Num1 : Snap View 1
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {--LWin + Num2 : Snap View 2
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 =  0.073226,
		rollAngle = 0.000000,
	},
	[4] = {--LWin + Num3 : Snap View 3
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {--LWin + Num4 : Snap View 4
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
		rollAngle = 0.000000,
	},
	[6] = {--LWin + Num5 : Snap View 5
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {--LWin + Num6 : Snap View 6
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {--LWin + Num7 : Snap View 7
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {--LWin + Num8 : Snap View 8
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {--LWin + Num9 : Snap View 9
		viewAngle = 59.208893,--FOV
		hAngle	 = -32.128311,
		vAngle	 = -5.720805,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[11] = {--look at left  mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = 14.803060,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[12] = {--look at right mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = -14.414484,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[13] = {--default view
		viewAngle = 89.777542,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -17.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
},
[3] = {-- player slot 3
	[1] = {--LWin + Num0 : Snap View 0
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {--LWin + Num1 : Snap View 1
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {--LWin + Num2 : Snap View 2
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 = 0.073226,
		rollAngle = 0.000000,
	},
	[4] = {--LWin + Num3 : Snap View 3
		viewAngle = 90.348198,--FOV
		hAngle	 = 0.0,
		vAngle	 = -90.0,
		x_trans	 = -4.0,
		y_trans	 = 0.0,
		z_trans	 = 0.0,
		rollAngle = 0.00,
	},
	[5] = {--LWin + Num4 : Snap View 4
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[6] = {--LWin + Num5 : Snap View 5
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	
	[7] = {--LWin + Num6 : Snap View 6
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {--LWin + Num7 : Snap View 7
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {--LWin + Num8 : Snap View 8
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {--LWin + Num9 : Snap View 9
		viewAngle = 59.208893,--FOV
		hAngle	 = -32.128311,
		vAngle	 = -5.720805,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[11] = {--look at left  mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = 14.803060,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[12] = {--look at right mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = -14.414484,
		vAngle	 = 3.332499,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[13] = {--default view
		viewAngle = 89.777542,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 0.000000,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[14] = {--HMD view
		x_trans	 = -0.120,
		y_trans	 = 0.030,
		z_trans	 = 0.000,
	},
},
}