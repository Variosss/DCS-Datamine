--/N/ rev okt 2018.

ViewSettings = {
	Cockpit = {
		[1] = {
			
			--/N/ unlimited
			CockpitLocalPoint	 = { 3.00, 0.94, 0.0 },
			CameraViewAngleLimits = { 30.0, 150.0 },
			CameraAngleLimits	 = { 180, -80.0, 120.0 },
			CameraAngleRestriction = {false, 90.0, 0.50},			
			
			--[[
			CockpitLocalPoint	 = { 3.00, 0.94, 0.0 },
			CameraViewAngleLimits = { 30.0, 105.0 },
			CameraAngleLimits	 = { 110, -80.0, 80.0 }, --/N/ relaxed settings
			--CameraAngleLimits	 = { 110, -90.0, 90.0 }, --/N/ Nick's settings
			CameraAngleRestriction = {false, 90.0, 0.50},
			]]
			
			--[[ --/N/ original settings
			CockpitLocalPoint	 = { 3.00, 0.94, 0.0 },
			CameraViewAngleLimits = { 30.0, 105.0 },
			CameraAngleLimits	 = { 105, -70.0, 60.0 }, 
			CameraAngleRestriction = {false, 90.0, 0.50},
			]]
			
			--[[ 3 monitor setup
			CameraViewAngleLimits = { 60.0, 175.0 },
			CameraAngleLimits  = { 105, -100.0, 100.0 },
			]]
   
   
			EyePoint	 = { 0.02, 0.08, 0.0 },--/N/ original, note: Y axis is not responding to inputs
			ShoulderSize	 = 0.15,
			Allow360rotation	 = false,
			limits_6DOF	 = { x = {-0.15, 0.28}, y = {-0.2, 0.06}, z = {-0.15, 0.15}, roll = 45.0 },
			--limits_6DOF	 = { x = {-0.1, 0.3}, y = {-0.1, 0.06}, z = {-0.15, 0.15}, roll = 40.0 }, --/N/ original settings
		},		
		
	},
	Chase = {
		LocalPoint	= {0.6, 3.7, 0.0},
		AnglesDefault	= {180.0, -8.0},
	},
	Arcade = {
		LocalPoint	= {-25.0, 6.0, 0.0},
		AnglesDefault	= {0.0, -8.0},
	},
}

local function head_pos_default(tab)
    if not tab then
	   tab = {}
	end

	tab.viewAngle = tab.viewAngle  or 90
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -8.0
	tab.x_trans   = tab.x_trans    or  0.0
	tab.y_trans   = tab.y_trans    or  0.015
	tab.z_trans   = tab.z_trans    or  0.0
	tab.rollAngle = tab.rollAngle  or  0
	
	return tab
end

SnapViews = {
[1] = {-- player slot 1
		[1]  = head_pos_default({viewAngle = 85, hAngle = 0, vAngle = 65}),--Num 0
		[2]  = head_pos_default({viewAngle = 85, hAngle = 120, vAngle = -4}),--Num 1
		[3]  = head_pos_default({viewAngle = 50, hAngle = 0, vAngle = -35}),--Num 2
		[4]  = head_pos_default({viewAngle = 85, hAngle = -120, vAngle = -4}),--Num 3
		[5]  = head_pos_default({viewAngle = 85, hAngle = 80, vAngle = -4}),--Num 4
		[6]  = head_pos_default({}),--Num 5 Default view
		[7]  = head_pos_default({viewAngle = 85, hAngle = -80, vAngle = -4}),--Num 6
		[8]  = head_pos_default({viewAngle = 85, hAngle = 45, vAngle = 25}),--Num 7
		[9]  = head_pos_default({viewAngle = 85, vAngle = 45}),--Num 8
		[10] = head_pos_default({viewAngle = 85, hAngle = -45, vAngle = 25}),--Num 9
		[11] = head_pos_default({viewAngle = 85, vAngle = -8}),--look left
		[12] = head_pos_default({viewAngle = 85, vAngle = -8}),--look right
		[13] = head_pos_default({}),--default view
},
}
