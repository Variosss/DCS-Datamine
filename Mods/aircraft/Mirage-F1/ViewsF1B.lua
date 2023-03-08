
local function copyTable(src, target)
    if not target then
        target = {}
    end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            if not target[i] then
                target[i] = {}
            end
            copyTable(v, target[i])
        else
            target[i] = v
        end
    end
	
    return target
end


local function player(x,y)
	return {CockpitLocalPoint      	= {x,y,0.0},
		CameraViewAngleLimits  	= {20.000000,140.000000},
		CameraAngleRestriction 	= {false,90.000000,0.500000},
		CameraAngleLimits      	= {200,-90.000000,90.000000},
		EyePoint                = {0.05000,0.100000,0.000000},
		ShoulderSize     		= 0.25,
		Allow360rotation    	= false,
		limits_6DOF             = {x = {-0.050000,0.20000},y ={-0.100000,0.100000},z = {-0.22000,0.22000},roll = 90.000000},
		}
end

ViewSettingsF1B = {
	Cockpit = {
	player(3.225, 0.368),--front cockpit
	player(1.74, 0.841),--rear cockpit
	}, -- Cockpit 
Chase = {
	--LocalPoint      = {0.200000,-0.652000,-0.650000},
	--AnglesDefault   = {0.000000,0.000000},
	LocalPoint      = {-5.0,1.0,3.0},
	AnglesDefault   = {0.000000,0.000000},
}, -- Chase 
Arcade = {
	LocalPoint      = {-21.500000,5.618000,0.000000},
	AnglesDefault   = {0.000000,-8.000000},
}, -- Arcade 
}



local function head_pos_default(tab)
    if not tab then
	   tab = {}
	end
	tab.viewAngle = tab.viewAngle  or  80
	tab.hAngle    = tab.hAngle     or  0
	tab.vAngle    = tab.vAngle     or -11.5
	tab.x_trans   = tab.x_trans    or  0
	tab.y_trans   = tab.y_trans    or  0
	tab.z_trans   = tab.z_trans    or  0
	tab.rollAngle = tab.rollAngle  or  0
	
	return tab
end

local playerSnapViewsCommon = {
		[1]  = head_pos_default({}), -- Num 0
		[2]  = head_pos_default({
		            viewAngle = 69.780899, -- FOV
		            hAngle	 = 90.382431,
		            vAngle	 = -52.480587,
		            x_trans	 = 0.077940,
		            y_trans	 = -0.099448,
		            z_trans	 = -0.043705,
		            rollAngle = 0.000000,
					}), -- LWin + Num4 : Snap View 1 - Left Console
		[3]  = head_pos_default({
					viewAngle = 72.555000, -- FOV
		            hAngle	 = 6.741884,
		            vAngle	 = -40.086639,
		            x_trans	 = 0.000000,
		            y_trans	 = 0.000000,
		            z_trans	 = 0.194226,
		            rollAngle = 0.000000,
					}), -- LWin + Num2 : Snap View 2 - Central Panel
		[4]  = head_pos_default({
					viewAngle = 58.012501, -- FOV
					hAngle	 = -74.849602,
		            vAngle	 = -47.992794,
		            x_trans	 = 0.000000,
		            y_trans	 = -0.099955,
		            z_trans	 = 0.008404,
		            rollAngle = 0.000000,
					}), -- LWin + Num6 : Snap View 3 - Right Console
		[5]  = head_pos_default({
				    viewAngle = 52.877102, -- FOV
		            hAngle	 = 28.081524,
		            vAngle	 = -36.981689,
		            x_trans	 = 0.199877,
		            y_trans	 = -0.099924,
		            z_trans	 = 0.000000,
		            rollAngle = 0.000000,
					}), -- LWin + Num1 : Snap View 4 - Left Panel
		[6]  = head_pos_default({}), -- LWin + Num5 : Snap View 5 - Default view
		[7]  = head_pos_default({
				    viewAngle = 43.796249, -- FOV
		            hAngle	 = -38.423161,
		            vAngle	 = -38.288990,
		            x_trans	 = 0.199001,
		            y_trans	 = -0.098100,
		            z_trans	 = 0.000000,
		            rollAngle = 0.000000,
					}), -- LWin + Num3 : Snap View 6 - Right Panel
		[8]  = head_pos_default({
					viewAngle = 99.106483, -- FOV
					hAngle	 = 131.835434,
					vAngle	 = -7.700000,
					x_trans	 = 0.116748,
					y_trans	 = 0.040000,
					z_trans	 = -0.063734,
					rollAngle = 0.000000,}), -- LWin + Num7 : Snap View 7 - Left Wing
		[9]  = head_pos_default({
		            viewAngle = 87.000000, -- FOV
		            hAngle	 = -166.500000,
		            vAngle	 = 8.120656,
		            x_trans	 = 0.200000,
		            y_trans	 = 0.099448,
		            z_trans	 = 0.300000,
		            rollAngle = 0.000000,
					}), -- LWin + Num8 : Snap View 8 - Check Six
		[10]  = head_pos_default({
					viewAngle = 99.106483, -- FOV
					hAngle	 = -131.835434,
					vAngle	 = -7.700000,
					x_trans	 = 0.116748,
					y_trans	 = 0.040000,
					z_trans	 = 0.063734,
					rollAngle = 0.000000,}), -- LWin + Num9 : Snap View 9 - Right Wing
		[11] = head_pos_default({viewAngle = 60, vAngle = 10}), -- look at left  mirror
		[12] = head_pos_default({viewAngle = 60, vAngle = 10}), -- look at right mirror
		[13] = head_pos_default({}) -- default view
}

local playerSnapViewsFwd = copyTable(playerSnapViewsCommon)
local playerSnapViewsRear = copyTable(playerSnapViewsCommon)

-- TODO: to update the vertical position after the new sight model is integrated
local defaultPosXY_Fwd = {x_trans = 0.02, y_trans = 0.0492}

playerSnapViewsFwd[1]  = head_pos_default(defaultPosXY_Fwd) -- Num 0
playerSnapViewsFwd[6]  = head_pos_default(defaultPosXY_Fwd) -- LWin + Num5 : Snap View 5 - Default view
playerSnapViewsFwd[13] = head_pos_default(defaultPosXY_Fwd) -- default view

SnapViewsF1B = 
{
[1] = playerSnapViewsFwd,
[2] = playerSnapViewsRear,
}
