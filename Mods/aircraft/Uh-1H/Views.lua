local seat_points = 
{

[3] = {point = {-0.121463, -0.139260 + 0.5,  1.477076 - 0.5 ,absolute_position = true },vAngle = 0				 ,hAngle = -90, limits  = {x = {-3.0, 0.35} ,  y = {-0.6,0.5},   z = {-0.25,1.4}}},
[4] = {point = {-0.121377, -0.139260 + 0.5, -1.514663 + 0.5 ,absolute_position = true} ,vAngle = 0				 ,hAngle =  90, limits  = {x = {-3.0, 0.35} ,  y = {-0.6,0.5},   z = {-1.4,0.25}}},
}

cockpit_local_point = {2.34, 0.37 , 0.0}

ViewSettings = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint      = {2.34, 0.37 , 0.0},
		CameraViewAngleLimits  = {20.000000,140.000000},
		CameraAngleRestriction = {false,90.000000,0.400000},
		CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = {0.090000,0.000000,0.000000},
		limits_6DOF            = {x = {-0.100000,0.500000},
								  y = {-0.200000,0.350000},
								  z = {-0.200000,0.750000},
								  roll = 90.000000},
	},
	
	[2] = {-- player slot 2
		CockpitLocalPoint      = {2.34, 0.37 , 0.0},
		CameraViewAngleLimits  = {60.000000,140.000000},
		CameraAngleRestriction = {false,90.000000,0.400000},
		CameraAngleLimits      = {140.000000,-65.000000,90.000000},
		EyePoint               = {0.090000,0.000000,0.000000},
		limits_6DOF            = {x = {-0.100000,0.500000},
								  y = {-0.200000,0.350000},
								  z = {-0.750000,0.200000},
								  roll = 90.000000},
	},
	
	[3] = {-- player slot 3
		CockpitLocalPoint			= {2.34, 0.37 , 0.0},
		CockpitLocalPointAzimuth	= 90,
		CameraViewAngleLimits		= {20.000000,135.000000},
		CameraAngleRestriction		= {false,90.000000,0.400000},
		CameraAngleLimits			= {80.000000,-45.000000,15.000000},
		EyePoint					= {0.090000,0.000000,0.000000},
		limits_6DOF					= {	x 	= {-3.0, 0.35},
										y 	= {-0.6,0.5}, 
										z 	= {-1.4,0.25},
										roll  = 90.000000},
		 ExternalShapeUsed	   		= true,
		 Allow360rotation			= false,
	},
	
	[4] = {-- player slot 4
		CockpitLocalPoint			= {2.34, 0.37 , 0.0},
		CockpitLocalPointAzimuth	= -90,
		CameraViewAngleLimits		= {20.000000,135.000000},
		CameraAngleRestriction		= {false,90.000000,0.400000},
		CameraAngleLimits			= {80.000000,-45.000000,15.000000},
		EyePoint					= {0.090000,0.000000,0.000000},
		limits_6DOF					= {	x 	= {-3.0, 0.35} , 
										y 	= {-0.6,0.5},
										z 	= {-0.25,1.4},
										roll  = 90.000000},
		ExternalShapeUsed	   		= true,
		Allow360rotation			= false,
	},
	
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-3.700000,2.400000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-20.000000,5.000000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}

SnapViews = {
[1] = {-- player slot 1
	[1] = {
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 = 0.073226,
		rollAngle = 0.000000,
	},
	[4] = {
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
		rollAngle = 0.000000,
	},
	[6] = {
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {
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
		vAngle	 = -15.592758472369,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[14] = {--HMD view
		x_trans	 = 0.165,
		y_trans	 = 0.000,
		z_trans	 = 0.000,
	},
},

[2] = {-- player slot 2
	[1] = {
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 = 0.073226,
		rollAngle = 0.000000,
	},
	[4] = {
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
		rollAngle = 0.000000,
	},
	[6] = {
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {
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
		x_trans	 = 0.165,
		y_trans	 = 0.000,
		z_trans	 = 0.000,
	},
},

[3] = {-- player slot 3
	[1] = {
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 = 0.073226,
		rollAngle = 0.000000,
	},
	[4] = {
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
		rollAngle = 0.000000,
	},
	[6] = {
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {
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
},

[4] = {-- player slot 4
	[1] = {
		viewAngle = 67.452896,--FOV
		hAngle	 = 15.000000,
		vAngle	 = -20.067383,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[2] = {
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[3] = {
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		x_trans	 = 0.000000,
		y_trans	 = -0.025421,
		z_trans	 = 0.073226,
		rollAngle = 0.000000,
	},
	[4] = {
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 = 0.169696,
		y_trans	 = -0.073508,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[5] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
		rollAngle = 0.000000,
	},
	[6] = {
		viewAngle = 42.512844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = -4.478010,
		x_trans	 = 0.154018,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[7] = {
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
		rollAngle = 0.000000,
	},
	[8] = {
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = -0.218292,
		rollAngle = 0.000000,
	},
	[9] = {
		viewAngle = 88.727844,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
	},
	[10] = {
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
},

}