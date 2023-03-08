

ViewSettings = {
    Cockpit = {
        [1] = {

           
            CockpitLocalPoint      = { 7.114937, 1.39846, 0.0 },
            CameraViewAngleLimits  = { 30.0, 140.0 },
            CameraAngleLimits      = { 180, -80.0, 120.0 },
            CameraAngleRestriction = {false, 90.0, 0.50},


            EyePoint         = { 0.00000,0.100000,0.000000},
            ShoulderSize     = 0.1,
            Allow360rotation = false,
            limits_6DOF      = { x = {-0.3, 0.37}, y = {-0.55, 0.10}, z = {-0.25, 0.25}, roll = 45.0 },
            
        },
        [2] = {

            
            CockpitLocalPoint      = { 5.596174, 1.605, 0.0 },
            CameraViewAngleLimits  = { 30.0, 140.0 },
            CameraAngleLimits      = { 180, -80.0, 120.0 },
            CameraAngleRestriction = {false, 90.0, 0.50},


            EyePoint         = { 0.05000,0.100000,0.000000 },
            ShoulderSize     = 0.15,
            Allow360rotation = false,
            limits_6DOF      = { x = {-0.3, 0.45}, y = {-0.55, 0.10}, z = {-0.25, 0.25}, roll = 45.0 },
            
        },
    },
    Chase = {
        --LocalPoint    = {0.6, 3.7, 0.0},
        --AnglesDefault = {180.0, -8.0},
        LocalPoint    = {-10.0,1.0,3.0},
        AnglesDefault = {0.000000, 0.000000},
    },
    Arcade = {
        LocalPoint    = {-25.0, 6.0, 0.0},
        AnglesDefault = {0.0, -8.0},
    },
}

local function head_pos_default(tab)
    if not tab then
       tab = {}
    end

    tab.viewAngle = tab.viewAngle  or 85
    tab.hAngle    = tab.hAngle     or  0
    tab.vAngle    = tab.vAngle     or -8.0
    tab.x_trans   = tab.x_trans    or  0.0
    tab.y_trans   = tab.y_trans    or  0.02
    tab.z_trans   = tab.z_trans    or  0.0
    tab.rollAngle = tab.rollAngle  or  0

    return tab
end

SnapViews = {
[1] = {-- player slot 1
        [1]  = head_pos_default({viewAngle = 50, hAngle = 3.5, vAngle = -33.5}),--Num 0
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
        [13] = head_pos_default({x_trans=0.085, y_trans = -0, vAngle=-12}),--default view
},

[2] = {-- player slot 2
        [1]  = head_pos_default({viewAngle = 68, hAngle = 0, vAngle = -34, y_trans = -0.09}),--Num 0
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
        [13] = head_pos_default({x_trans=-0.02, y_trans = -0.04, vAngle=-12}),--default view
},
}
