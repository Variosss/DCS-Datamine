---- main part ----
mount_vfs_texture_path (current_mod_path .. '/Textures/Navy/052b')

GT = {}
GT_t.ws = 0

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "052b"
GT.visual.shape_dstr = ""

GT.animation_arguments.radar1_rotation = 1
GT.radar1_period = 3
GT.animation_arguments.radar2_rotation = 2
GT.radar2_period = 1
GT.animation_arguments.radar3_rotation = -1
GT.radar3_period = 3
GT.animation_arguments.luna_lights = -1
GT.animation_arguments.water_propeller = 8
GT.animation_arguments.flight_deck_fences = 150

GT.life              = 2700
GT.mass              = 5.850e+006
GT.max_velocity      = 15.4333
GT.race_velocity     = 15.4333
GT.economy_velocity  = 7.716
GT.economy_distance  = 8.334e+006
GT.race_distance     = 2.778e+006
GT.shipLength        = 154
GT.Width             = 16
GT.Height            = 37.2
GT.Length            = 154
GT.X_nose            = 81
GT.X_tail            = -60
GT.Tail_Width        = 13
GT.draft             = 15
GT.Gamma_max         = 0.35
GT.Om                = 0.05
GT.speedup           = 0.229734
GT.R_min             = 345.6
GT.distFindObstacles = 568.4
GT.RCS               = 70000

GT.numParking      = 1
GT.Plane_Num_      = 0
GT.Helicopter_Num_ = 1

GT.DeckLevel     = 4.10
GT.Landing_Point = {-53.81, 4.10, 0.0}

GT.airWeaponDist = 30000
GT.airFindDist   = 100000

GT.DM = {
    -- 052B damage arg 70-75
    { area_name = "NOSE_R",  area_arg = 70, area_life = 700, area_fire = { pos = {69.2, 5.7, 2.1}, size = 0.8}}, --Main Gun
    { area_name = "BORT_R",  area_arg = 71, area_life = 700, area_fire = { pos = {31.2, 7.6, 7.4}, size = 0.8}}, --Right CIWS
    { area_name = "KORMA_R", area_arg = 72, area_life = 700, area_fire = { pos = {-35.4, 5.0, 7.3}, size = 0.8}}, --9m317 Launcher Aft
    { area_name = "NOSE_L",  area_arg = 73, area_life = 700, area_fire = { pos = {64.5, 5.7, -3.3}, size = 0.8}}, -- 9m317 Launcher Fwd
    { area_name = "BORT_L",  area_arg = 74, area_life = 700, area_fire = { pos = {-4.1, 5.0, -7.5}, size = 0.8}}, --Left CIWS
    { area_name = "KORMA_L", area_arg = 75, area_life = 700, area_fire = { pos = {-45.6, 3.9, -4.0}, size = 0.8}},

    --[[
    { area_name = "MAIN_GUN", area_arg = 72, area_life = 80, },
    { area_name = "CIWS_L", area_arg = 74, area_life = 80, },
    { area_name = "CIWS_R", area_arg = 71, area_life = 80, },

    { area_name = "SAM_FRONT_ARM", area_arg = 72, area_life = 80, },
    { area_name = "SAM_FRONT_BASE", area_arg = 72, area_life = 80, },

    { area_name = "SAM_REAR_ARM", area_arg = 72, area_life = 80, },
    { area_name = "SAM_REAR_BASE", area_arg = 72, area_life = 80, },
    ]]
}

GT.driverViewConnectorName = {"POINT_MUSICRADAR", offset = {3.0, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-----------------------------------------------------------------------------------------------------------
-- weapon systems
-----------------------------------------------------------------------------------------------------------
local reflect_limit_share = 0.07

GT.WS = {}
local ws
GT.WS.maxTargetDetectionRange = 450000
GT.WS.radar_type = 102
GT.WS.searchRadarMaxElevation = math.rad(80)

------------------------    AK130 main gun  ----------------------

--Main Gun
Type210 = {}
Type210.angles = {
    {math.rad(125), math.rad(-125), math.rad(-10), math.rad(70)},
}
Type210.omegaY = 0.6
Type210.omegaZ = 0.6
Type210.reference_angle_Z = 0
Type210.LN = {}
Type210.LN[1] = {}
Type210.LN[1].type = 6
Type210.LN[1].distanceMin = 50
Type210.LN[1].max_trg_alt = 10000
Type210.LN[1].reactionTime = 8
Type210.LN[1].sensor = {}
set_recursive_metatable(Type210.LN[1].sensor, GT_t.WSN_t[10])
Type210.LN[1].PL = {}
Type210.LN[1].PL[1] = {}
Type210.LN[1].PL[1].ammo_capacity = 480
Type210.LN[1].PL[1].shell_name = {"AK100_100"} --100mm shell
Type210.LN[1].PL[1].shot_delay = 0.66 --90 rounds in 1 min
Type210.LN[1].BR = { {pos = {10, 5, 0},} }

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type210)
GT.WS[ws].area = 'NOSE_R'
GT.WS[ws].center = 'TARGET_AK130_1'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_AK130_1_1'
--GT.WS[ws].LN[1].BR[1].recoilArgument = 33
GT.WS[ws].LN[1].BR[1].recoilTime = 0.667
GT.WS[ws].LN[1].customViewPoint = { "genericHowitzer", {-0.5, 0.4, 0.0 }, }
--GT.WS[ws].cockpit = { "genericHowitzer", {-4.5, 0.6, 0.6 }, }
--GT.WS[ws].LN[1].sightMasterMode = 1


------------------------  16 Anti-Ship Launchers  ----------------------


-- yj83
YJ83 = { name = "YJ83", display_name = _("YJ-83"), } -- YJ83 Missile Launcher
YJ83.type = 1
YJ83.distanceMin = 12000
YJ83.distanceMax = 180000
YJ83.reactionTime = 6
YJ83.launch_delay = 3
YJ83.external_tracking_awacs = true
YJ83.max_number_of_missiles_channels = 2
YJ83.sensor = {}
set_recursive_metatable(YJ83.sensor, GT_t.WSN_t[0])
YJ83.PL = {}
YJ83.PL[1] = {}
YJ83.PL[1].ammo_capacity = 4
YJ83.PL[1].type_ammunition = YJ_83_AS.wsTypeOfWeapon --{4,4,11,126} --{weapon_by_CLSID('{YJ-83}')} --something caused shot_delay not working
YJ83.PL[1].reload_time = 1000000 -- never during the mission
YJ83.PL[1].shot_delay = 3 --Yankee Proved
YJ83.BR = { {pos = {0, 0, 0},} }


ship_YJ83 = {}
ship_YJ83.angles = {
    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(90)},
}
ship_YJ83.reference_angle_Z = math.rad(0)
ship_YJ83.moveable = false
ship_YJ83.LN = {}
__LN = add_launcher(ship_YJ83, YJ83)
__LN.show_external_missile = true


local YJ_83_CNT = 'POINT_YJ83_'

-- port
ship_YJ83.angles = {
    {math.rad(190), math.rad(-10), math.rad(-10), math.rad(90)},
}

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'1_1'
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_83_CNT..'1_1', recoilArgument = 192, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'3_1', recoilArgument = 191, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'6_1', recoilArgument = 190, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'7_1', recoilArgument = 189, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_ASM_SIGHT_L1"
GT.WS[ws].drawArgument1 = 200
GT.WS[ws].drawArgument2 = 201

--[[
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 191}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'3_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'3_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 190}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'6_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'6_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 189}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'7_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'7_1'
]]

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'2_1'
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_83_CNT..'2_1', recoilArgument = 188, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'4_1', recoilArgument = 187, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'5_1', recoilArgument = 186, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'8_1', recoilArgument = 185, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_ASM_SIGHT_L2"
GT.WS[ws].drawArgument1 = 202
GT.WS[ws].drawArgument2 = 203

--[[
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 187}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'4_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'4_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 186}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'5_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'5_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 185}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_CNT..'8_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'8_1'
]]

-- starboard
ship_YJ83.angles = {
    {math.rad(10), math.rad(-190), math.rad(-10), math.rad(90)},
}

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'10_1'
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_83_CNT..'10_1', recoilArgument = 184, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'12_1', recoilArgument = 183, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'14_1', recoilArgument = 182, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'16_1', recoilArgument = 181, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_ASM_SIGHT_R1"
GT.WS[ws].drawArgument1 = 204
GT.WS[ws].drawArgument2 = 205

--[[
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 183}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'12_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'12_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 182}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'14_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'14_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 181}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'16_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'16_1'
]]

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'9_1'
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_83_CNT..'9_1',  recoilArgument = 180, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'11_1', recoilArgument = 179, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'13_1', recoilArgument = 178, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_83_CNT..'15_1', recoilArgument = 177, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_ASM_SIGHT_R2"
GT.WS[ws].drawArgument1 = 206
GT.WS[ws].drawArgument2 = 207

--[[
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 179}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'11_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'11_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 178}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'13_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'13_1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 177}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_CNT..'15_1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'15_1'
]]


----------------------------------------------------------------------------------------------------------------------------------------
--                    SAM Trackers
----------------------------------------------------------------------------------------------------------------------------------------
ws = GT_t.inc_ws()
local first_tracker_id = ws
GT.WS[ws] = {
    omegaY = 2,
    omegaZ = 2,
    pidY = {p=100, i=0.05, d=12, inn = 50},
    pidZ = {p=100, i=0.05, d=12, inn = 50},
    pos = {0.0, 19.0, 0.0},
    angles = { {math.rad(135), math.rad(-135), math.rad(-10), math.rad(90)} }, --From 135 deg (left) to -135deg (right) clock coverage (270deg coverage)
    reference_angle_Y = math.rad(0),
    LN = {
        [1] = {
            type = 102,
            distanceMin = 1000,
            distanceMax = 220000,
            reactionTime = 2.0,
            reflection_limit = reflect_limit_share,
            ECM_K = 0.4,
            min_trg_alt = 5,
            max_trg_alt = 30000,
            max_number_of_missiles_channels = 1,
            beamWidth = math.rad(90)
        }
    }
}

local SAM_tracker_ws1 = {{{'self', ws}},}

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT.WS[first_tracker_id])
table.insert(SAM_tracker_ws1, {{'self', ws}})


ws = GT_t.inc_ws()
local second_tracker_id = ws
GT.WS[ws] = {
    omegaY = 2,
    omegaZ = 2,
    pidY = {p=100, i=0.05, d=12, inn = 50},
    pidZ = {p=100, i=0.05, d=12, inn = 50},
    pos = {0.0, 19.0, 0.0},
    angles = { {math.rad(-45), math.rad(45), math.rad(-10), math.rad(90)} }, --  Achieve dual targets engagement by Mutha 2017/10/11
    reference_angle_Y = math.rad(180),
    LN = {
        [1] = {
            type = 102,
            distanceMin = 1000,
            distanceMax = 220000,
            reactionTime = 2.0,
            reflection_limit = reflect_limit_share,
            ECM_K = 0.4,
            min_trg_alt = 5,
            max_trg_alt = 30000,
            max_number_of_missiles_channels = 1,
            beamWidth = math.rad(90)
        }
    }
}

local SAM_tracker_ws2 = {{{'self', ws}},}

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT.WS[second_tracker_id])
table.insert(SAM_tracker_ws2, {{'self', ws}})


------------------------    Anti-Air SAMs  ----------------------

-- 9m317
_9M317 = {}
_9M317.type = 4
_9M317.distanceMin = 3500
_9M317.distanceMax = 40000
--_9M317.ECM_K = 0.8
_9M317.reactionTime = 6
_9M317.reflection_limit = reflect_limit_share
-- скорострельность: 2 ракеты в минуту, пуск двух ракет с паузой 2-3 с.
_9M317.launch_delay = 6
_9M317.maxShootingSpeed = 0.0
_9M317.beamWidth = math.rad(1)
_9M317.sensor = {}
set_recursive_metatable(_9M317.sensor, GT_t.WSN_t[0])
_9M317.barrels_reload_type = 1
_9M317.max_number_of_missiles_channels = 1
_9M317.PL = {}
_9M317.PL[1] = {}
_9M317.PL[1].ammo_capacity = 1  --24 for each launcher
_9M317.PL[1].type_ammunition = SA_N_12_9M317.wsTypeOfWeapon --{4,4,34,87} --{weapon_by_CLSID('{9M317}')}
_9M317.PL[1].name_ammunition = _("9M317")
_9M317.PL[1].reload_time = 10 --Yankee Proved (less than 10sec)
_9M317.PL[1].shot_delay = 9
_9M317.BR = {
    -- TODO (No need to do here)
    [1] = {}, --{connector_name = 'POINT_ROCKET_01', drawArgument = 4},
}

ship_9M317 = {}
ship_9M317.angles = {
    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(90)},
}
ship_9M317.angles_mech = ship_9M317.angles
ship_9M317.omegaY = 1
ship_9M317.omegaZ = 1
ship_9M317.reference_angle_Z = 0
ship_9M317.reference_angle_Y = 0
ship_9M317.reloadAngleY = math.rad(0)
ship_9M317.reloadAngleZ = math.rad(89.9) --should not be exactly 90deg
ship_9M317.LN = {}
__LN = add_launcher(ship_9M317, _9M317)
--__LN.ECM_K = -1
__LN.show_external_missile = true
__LN.launch_delay = 8
__LN.reactionTime = 10
__LN.maxShootingSpeed = 15
__LN.barrels_reload_type = 2
__LN.beamWidth = math.rad(1)
__LN.PL[1].ammo_capacity = 24 --24 for each launcher
__LN.PL[1].shot_delay = 9


----------------------------------------------------------------------------------------------------------------------------------------
--                    SAM Launchers
----------------------------------------------------------------------------------------------------------------------------------------

-- 9m317 Launcher Fwd
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_9M317)
GT.WS[ws].pointer = "POINT_9M317_1_1"
GT.WS[ws].center = "TARGET_9M317_1"
GT.WS[ws].area = "NOSE_L"
GT.WS[ws].board = 1
GT.WS[ws].drawArgument1 = 49
GT.WS[ws].drawArgument2 = 50
GT.WS[ws].reference_angle_Y = math.rad(0)
GT.WS[ws].angles = {
    {math.rad(135), math.rad(-135), math.rad(-10), math.rad(90)}, --From 135 deg (right) to -135deg (left) counter-clock coverage (270deg coverage)
}
GT.WS[ws].reloadAngleY = math.rad(0)
GT.WS[ws].LN[1].depends_on_unit = SAM_tracker_ws1
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_9M317_1_1'

GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 3.0, 0.0} }
GT.WS[ws].isoviewOffset = {0.0, 6.0, 0.0}
GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"

--GT.WS[ws].LN[1].BR[1].drawArgument = 96 -- Needs double check!

-- 9m317 Launcher Aft
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_9M317)
GT.WS[ws].pointer = "POINT_9M317_2_1"
GT.WS[ws].center = "TARGET_9M317_2"
GT.WS[ws].area = "KORMA_R"
GT.WS[ws].board = 1
GT.WS[ws].drawArgument1 = 51
GT.WS[ws].drawArgument2 = 52
GT.WS[ws].reference_angle_Y = math.rad(180)
GT.WS[ws].angles = {
    {math.rad(-90), math.rad(90), math.rad(-10), math.rad(90)},
}
GT.WS[ws].reloadAngleY = math.rad(180)
GT.WS[ws].LN[1].depends_on_unit = SAM_tracker_ws2
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_9M317_2_1'
--GT.WS[ws].LN[1].BR[1].drawArgument = 4 -- Needs double check!

GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 3.0, 0.0} }
GT.WS[ws].isoviewOffset = {0.0, 6.0, 0.0}
GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"

----------------------------------------------------------------------------------------------------------------------------------------
--                    CIWS Type730
----------------------------------------------------------------------------------------------------------------------------------------

-- Type730
Type730 = {name = "Type730", display_name = _("Type 730 CIWS")}
Type730.angles_mech = {
    {math.rad(180), math.rad(-180), math.rad(-25), math.rad(87),},
}
Type730.omegaY = math.rad(130)
Type730.omegaZ = math.rad(150)
Type730.pidY = {p=300, i = 0.05, d = 10.0, inn = 1000}
Type730.pidZ = {p=300, i = 0.05, d = 10.0, inn = 1000}
Type730.ammo_capacity = 15550
Type730.reactionTime = 0.1
Type730.beamWidth = math.rad(90)
Type730.reference_angle_Z = 0
Type730.LN = {}
add_launcher(Type730, GT_t.LN_t.GSH_6_30K)


--Type730 - left
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type730)
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = 'TARGET_AK530_1_1'
GT.WS[ws].drawArgument1 = 19   ------ Right/Left
GT.WS[ws].drawArgument2 = 20   ------ Down/Up
GT.WS[ws].angles_mech = {
    {math.rad(180), math.rad(10), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    --{math.rad(10), math.rad(-180), math.rad(-12), math.rad(88)}, --From 15 deg (right) to -180 deg (left) counter-clock coverage (190deg coverage)
    --Reversed for CIWS
    {math.rad(180), math.rad(10), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(90) --Reversed for CIWS, this is actually rad(-90)
GT.WS[ws].LN[1].fireAnimationArgument = 120
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_AK530_1_1'
--GT.WS[ws].LN[1].sightMasterMode = 4
GT.WS[ws].LN[1].customViewPoint = { "IronSight/IronSight", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_CIWS_SIGHT_L"
ws = nil


--Type730 - right
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type730)
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = 'TARGET_AK530_2_1'
GT.WS[ws].drawArgument1 = 17   ------ Right/Left
GT.WS[ws].drawArgument2 = 18   ------ Down/Up
GT.WS[ws].angles_mech = {
    {math.rad(-10), math.rad(-180), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    --{math.rad(180), math.rad(-10), math.rad(-12), math.rad(88)}, --From 180 deg (right) to -10 deg (left) counter-clock coverage (190deg coverage)
    --Reversed for CIWS
    {math.rad(-10), math.rad(-180), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(-90) --Reversed for CIWS, this is actually rad(90)
GT.WS[ws].LN[1].fireAnimationArgument = 119
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_AK530_2_1'
--GT.WS[ws].LN[1].sightMasterMode = 5
GT.WS[ws].LN[1].customViewPoint = { "IronSight/IronSight", {0.0, 0.0, 0.0} }
GT.WS[ws].pointer = "PNT_CIWS_SIGHT_R"
ws = nil

---------------------------------------------------------------------------------------------------
--  Parte Finale - Final Section
---------------------------------------------------------------------------------------------------

GT.Name             = "Type_052B"
GT.DisplayName      = _("Type 052B Destroyer")
GT.DisplayNameShort = _("052B")
GT.Rate             = 4000

GT.Sensors = {
    OPTIC = {
        "long-range naval optics",
        "long-range naval LLTV",
        "long-range naval FLIR",
    },
    RADAR = {
        "PLAN Search Radar B",
        "052B SAM SR",
        "052B SAM TR",
    }
}

GT.DetectionRange = GT.airFindDist
GT.ThreatRange    = GT.airWeaponDist
GT.Singleton      = "no"
GT.mapclasskey    = "P0091000069"

GT.attribute = {
    wsType_Navy, wsType_Ship, wsType_HCarrier, WSTYPE_PLACEHOLDER,
    "Destroyers",
    "RADAR_BAND1_FOR_ARM",
    "RADAR_BAND2_FOR_ARM",
    "DetectionByAWACS",
}

GT.Categories = {
    {name = "Armed Ship"},
    {name = "HelicopterCarrier"}
}
GT.tags = {
    "Destroyer",
}

GT.Countries = {'China'}
--------------------------------------------------------------------------------

GT.encyclopediaAnimation = {
    args = {
        [17] = -0.15, -- SB Phalanxs rotation
        [19] = 0.15, -- PS Phalanxs rotation
        [51] = 1.0, -- aft SAM launcher rotation
    }
}

GT.shape_table_data =
{
    {
        file        = GT.visual.shape,
        username    = GT.Name,
        desrt       = GT.visual.shape_dstr,
        classname   = "lLandShip",
        positioning = "BYNORMAL",
    },
    {
        name  = GT.visual.shape_dstr,
        file  = GT.visual.shape_dstr,
    },
}

add_surface_unit(GT)

GT = nil
