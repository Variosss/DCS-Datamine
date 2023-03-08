local y_trans_default = -0.04
ViewSettings = {
	Cockpit = {
		[1] = {
			CockpitLocalPoint       = {3.188000,0.390000,0.000000},
			CameraViewAngleLimits	= {20.000000,140.000000},
			CameraAngleRestriction	= {false,90.000000,0.500000},
			CameraAngleLimits		= {200,-90.000000,90.000000},
			EyePoint				= {0.05000,0.100000,0.000000},
			ShoulderSize			= 0.25,
			Allow360rotation		= false,
			limits_6DOF            = {x = {-0.020000,0.350000},y ={-0.150000,0.165000},z = {-0.170000,0.170000},roll = 90.000000},
		},
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {-0.512000,2.790000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-16.812000,5.390000,0.000000},
		AnglesDefault   = {0.000000,-8.000000},
	}, -- Arcade 
}

local function head_pos_default(tab)
    if not tab then
	   tab = {}
	end

	tab.viewAngle = tab.viewAngle  or  89.777542
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -15.592758
	tab.x_trans   = tab.x_trans    or  0
	tab.y_trans   = tab.y_trans    or y_trans_default
	tab.z_trans   = tab.z_trans    or  0
	tab.rollAngle = tab.rollAngle  or  0
	
	return tab
end
SnapViews = {
[1] = {-- player slot 1
	[1] = head_pos_default({
		viewAngle = 67.452896,--FOV
		vAngle	  = -40.067383,
	}),
	[2] = head_pos_default({
		viewAngle = 37.846794,--FOV
		hAngle	 = 51.644135,
		vAngle	 = -51.870411,
	}),
	[3] = head_pos_default({
		viewAngle = 36.178646,--FOV
		hAngle	 = -1.912186,
		vAngle	 = -34.446247,
		y_trans	 = -0.025421,
		z_trans	 =  0.073226,
	}),
	[4] = head_pos_default({
		viewAngle = 73.605141,--FOV
		hAngle	 = -90.361992,
		vAngle	 = -44.103138,
		x_trans	 =  0.169696,
		y_trans	 = -0.073508,
	}),
	[5] = head_pos_default({
		viewAngle = 91.348198,--FOV
		hAngle	 = 109.752129,
		vAngle	 = 1.484382,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = -0.150335,
	}),
	[6] = head_pos_default({
		viewAngle = 42.512844,--FOV
		vAngle	 = -4.478010,
		x_trans	 =  0.154018,
	}),
	[7] = head_pos_default({
		viewAngle = 91.348198,--FOV
		hAngle	 = -108.852020,
		vAngle	 = 0.085984,
		x_trans	 = 0.190306,
		y_trans	 = 0.044778,
		z_trans	 = 0.139404,
	}),
	[8] = head_pos_default({
		viewAngle = 89.777542,--FOV
		hAngle	 = 16.411518,
		vAngle	 = -27.209915,
		z_trans	 = -0.218292,
	}),
	[9] = head_pos_default({
		viewAngle = 88.727844,--FOV
		vAngle	 = 34.042202,
		x_trans	 = 0.142145,
	}),
	[10] = head_pos_default({
		viewAngle = 59.208893,--FOV
		hAngle	 = -32.128311,
		vAngle	 = -5.720805,
	}),
	[11] = head_pos_default({--look at left  mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = 14.803060,
		vAngle	 = 3.332499,
	}),
	[12] = head_pos_default({--look at right mirror
		viewAngle = 56.032040,--FOV
		hAngle	 = -14.414484,
		vAngle	 = 3.332499,
	}),
	[13] = head_pos_default(),
	[14] = head_pos_default({--HMD view
		vAngle	 = 0
	}),
},
}

