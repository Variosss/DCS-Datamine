ViewSettings = {
	Cockpit = {
	[1] = {-- player slot 1
		CockpitLocalPoint		= {4.802242, 0.720387, 0.0},
		CameraViewAngleLimits  = {20.000000,170.000000}, 
		CameraAngleRestriction = {false,90.000000,0.400000}, 
		CameraAngleLimits      = {200,-90.000000,90.000000}, 
		EyePoint               = {0.00000,0.000,0.000000},
		ShoulderSize 		   = 0.15,
		Allow360rotation       = false,
		limits_6DOF            = {x = {-0.15,0.50},y = {-0.25,0.25},z = {-0.2,0.2},roll = 90.000000},
	},
	
	}, -- Cockpit 
	Chase = {
		LocalPoint      = {0.200000,1.7000,-1.300000},
		AnglesDefault   = {0.000000,-5.000000},
	}, -- Chase 
	Arcade = {
		LocalPoint      = {-27.000000,12.000000,0.000000},
		AnglesDefault   = {0.000000,-12.000000},
	}, -- Arcade
}

local function head_pos_default(tab)
    if not tab then
	   tab = {}
	end

	tab.viewAngle = tab.viewAngle  or 85
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -8.0
	tab.x_trans   = tab.x_trans    or  0.0
	tab.y_trans   = tab.y_trans    or  0.115 --/N/ position precisely, so the aim is at the eye level
	tab.z_trans   = tab.z_trans    or  0.0
	tab.rollAngle = tab.rollAngle  or  0
	
	return tab
end

SnapViews = {
[1] = {-- player slot 1
		[1]  = head_pos_default({viewAngle = 85, hAngle = 0, vAngle = 70}),--Num 0
		[2]  = head_pos_default({viewAngle = 85, hAngle = 120, vAngle = -8}),--Num 1
		[3]  = head_pos_default({viewAngle = 50, hAngle = 0, vAngle = -35}),--Num 2
		[4]  = head_pos_default({viewAngle = 85, hAngle = -120, vAngle = -8}),--Num 3
		[5]  = head_pos_default({viewAngle = 85, hAngle = 80, vAngle = -8}),--Num 4
		[6]  = head_pos_default({}),--Num 5 Default view
		[7]  = head_pos_default({viewAngle = 85, hAngle = -80, vAngle = -8}),--Num 6
		[8]  = head_pos_default({viewAngle = 85, hAngle = 45, vAngle = 25}),--Num 7
		[9]  = head_pos_default({viewAngle = 85, vAngle = 45}),--Num 8
		[10] = head_pos_default({viewAngle = 85, hAngle = -45, vAngle = 25}),--Num 9
		[11] = head_pos_default({viewAngle = 85, vAngle = -8}),--look left
		[12] = head_pos_default({viewAngle = 85, vAngle = -8}),--look right
		[13] = head_pos_default({}),--default view
},
}