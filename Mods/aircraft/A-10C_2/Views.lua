ViewSettings = {
	Cockpit = {
	[1] = {													
		CameraViewAngleLimits  = {20.000000,140.000000},
		CockpitLocalPoint      = {4.300000,1.282000,0.000000},
		CameraAngleRestriction = {false,90.000000,0.500000},
		CameraAngleLimits      = {200,-90.000000,90.000000},
		EyePoint               = {0.05000,0.100000,0.000000},
		ShoulderSize		   = 0.25,
		Allow360rotation	   = false,
		limits_6DOF            = {x = {-0.05,0.6},y = {-0.3,0.1},z = {-0.25,0.25},roll =  90.000000},
	},
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.600000,3.682000,0.000000},
		AnglesDefault   = {180.000000,-8.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade 
}

local cockpit_shape_version = 1;

local function makeSnapView(t)-- t is copy paste from  STATS window 
	return {
		x_trans = t.xyz[1],
		y_trans = t.xyz[2],
		z_trans = t.xyz[3],
		
		hAngle    = t.ypr[1],
		vAngle    = t.ypr[2],
		rollAngle = t.ypr[3],
		viewAngle = t.FOV,
		cockpit_version = cockpit_shape_version,
	}
end


SnapViews = {
[1] = {-- player slot 1
	[1] = makeSnapView({xyz = {-0.050,  0.000,  0.000},ypr = { 0.000,  -26.000, 0.000},FOV = 65}),
	[2] = makeSnapView({xyz = { 0.282, -0.100, -0.250},ypr = { 0.000,  -90.000, 0.000},FOV = 50}),
	[3] = makeSnapView({xyz = { 0.494, -0.055,  0.250},ypr = { 0.000,  -90.000, 0.000},FOV = 31}),
	[4] = makeSnapView({xyz = { 0.261, -0.065,  0.250},ypr = { 0.000,  -90.000, 0.000},FOV = 55}),
	[5] = makeSnapView({xyz = { 0.238, -0.281, -0.231},ypr = { 0.000,  -10.000, 0.000},FOV = 35}),
	[6] = makeSnapView({xyz = { 0.323, -0.053,  0.000},ypr = { 0.000,  -9.500, 0.000},FOV = 52}),
	[7] = makeSnapView({xyz = { 0.238, -0.281,  0.231},ypr = { 0.000,  -10.000, 0.000},FOV = 35}),
	[8] = {
		viewAngle = 68.628296,--FOV
		hAngle	 = 68.292320,
		vAngle	 = -11.477349,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
		cockpit_version = cockpit_shape_version,
	},
	[9] = {
		viewAngle = 68.628296,--FOV
		hAngle	 = 0.000000,
		vAngle	 = 30.227919,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
		cockpit_version = cockpit_shape_version,
	},
	[10] = {
		viewAngle = 68.628296,--FOV
		hAngle	 = -67.172974,
		vAngle	 = -11.477349,
		x_trans	 = 0.000000,
		y_trans	 = 0.000000,
		z_trans	 = 0.000000,
		rollAngle = 0.000000,
		cockpit_version = cockpit_shape_version,
	},
	[11] = makeSnapView({xyz = {0.238,  0.100, -0.114},ypr = { 5.888,   -2.468,   -22},FOV = 73}),
	[12] = makeSnapView({xyz = {0.238,  0.100,  0.114},ypr = {-5.888,   -2.468,    22},FOV = 73}),
	[13] = makeSnapView({xyz = {0.150,  -0.000,  0.000},ypr = { 0.000,  -19.000, 0.000},FOV = 73}),--default view
	[14] = makeSnapView({xyz = {0.150,  -0.000,  0.000},ypr = { 0.000,  -19.000, 0.000},FOV = 73}),--VR 
},
}
