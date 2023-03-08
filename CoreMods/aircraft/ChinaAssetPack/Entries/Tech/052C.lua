---- main part ----
mount_vfs_texture_path (current_mod_path .. '/Textures/Navy/052c')

GT = {}
GT_t.ws = 0

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "052c"
GT.visual.shape_dstr = ""

GT.animation_arguments.radar1_rotation = 1
GT.radar1_period = 3
GT.animation_arguments.radar2_rotation = 2
GT.radar2_period = 1
GT.animation_arguments.radar3_rotation = 3
GT.radar3_period = 6
GT.animation_arguments.luna_lights = -1
GT.animation_arguments.water_propeller = 8
GT.animation_arguments.flight_deck_fences = 150


GT.life              = 3200
GT.mass              = 6.80e+006
GT.max_velocity      = 15.4333
GT.race_velocity     = 15.4333
GT.economy_velocity  = 7.71667
GT.economy_distance  = 8.337e+006
GT.race_distance     = 3.278e+006
GT.shipLength        = 155.5
GT.Width             = 17.2
GT.Height            = 37.2
GT.Length            = 155.5
GT.X_nose            = 67
GT.X_tail            = -74
GT.Tail_Width        = 11
GT.draft             = 15
GT.Gamma_max         = 0.35
GT.Om                = 0.05
GT.speedup           = 0.229734
GT.R_min             = 345.6
GT.distFindObstacles = 568.4
GT.RCS               = 75000

GT.numParking      = 1
GT.Plane_Num_      = 0
GT.Helicopter_Num_ = 1

GT.airWeaponDist = 100000
GT.airFindDist   = 260000

GT.DeckLevel     = 3.98
GT.Landing_Point = {-68.450, 3.98, 0.0}  ----


GT.DM = {
    -- 052C damage arg 70-75
    { area_name = "NOSE_L",  area_arg = 73, area_life = 1000, area_fire = { pos = {14.0, 4.0, -3.5}, size = 0.8}}, -- 9m317 Launcher Fwd
    { area_name = "NOSE_R",  area_arg = 70, area_life = 1000, area_fire = { pos = {14.0, 4.0, 3.5}, size = 0.8}}, --Main Gun
    { area_name = "BORT_L",  area_arg = 74, area_life = 1200, area_fire = { pos = {0.0,  2.0, -3.5}, size = 0.8}}, --Left CIWS
    { area_name = "BORT_R",  area_arg = 71, area_life = 1200, area_fire = { pos = {0.0,  2.0, 3.5}, size = 0.8}}, --Right CIWS
    { area_name = "KORMA_L", area_arg = 75, area_life = 1000, area_fire = { pos = {-15.0, 2.0, 0}, size = 0.8}},
    { area_name = "KORMA_R", area_arg = 72, area_life = 1000, area_fire = { pos = {-15.0, 2.0, 0}, size = 0.8}},

    { area_name = "MAIN_GUN", area_arg = -1, area_life = 40, },
    { area_name = "CIWS_F",   area_arg = -1, area_life = 40, },
    { area_name = "CIWS_B",   area_arg = -1, area_life = 40, },
    --[[
    --{ area_name = "ASM_LAUNCHER", area_arg = 72, area_life = 80, },

    --{ area_name = "RADAR_TOP", area_arg = 72, area_life = 80, },
    { area_name = "RADAR_MGUN", area_arg = 72, area_life = 80, },
    ]]
}

-----------------------------------------------------------------------------------------------------------
-- weapon systems
-----------------------------------------------------------------------------------------------------------

GT.WS = {}
local ws
GT.WS.maxTargetDetectionRange = 450000
GT.WS.radar_type = 102
GT.WS.searchRadarMaxElevation = math.rad(80)
GT.WS.searchRadarFrequencies  = {{50.0e6, 54.0e6}, {2.0e9, 2.2e9}}

------------------------    AK130 main gun  ----------------------

--Main Gun
PJ87 = {}
PJ87.angles = {
    {math.rad(125), math.rad(-125), math.rad(-10), math.rad(70)},
}
PJ87.omegaY = 0.6
PJ87.omegaZ = 0.6
PJ87.reference_angle_Z = 0
PJ87.LN = {}
PJ87.LN[1] = {}
PJ87.LN[1].type = 6
PJ87.LN[1].distanceMin = 50
PJ87.LN[1].max_trg_alt = 10000
PJ87.LN[1].reactionTime = 4
PJ87.LN[1].sensor = {}
set_recursive_metatable(PJ87.LN[1].sensor, GT_t.WSN_t[10])
PJ87.LN[1].PL = {}
PJ87.LN[1].PL[1] = {}
PJ87.LN[1].PL[1].ammo_capacity = 480
PJ87.LN[1].PL[1].shell_name = {"AK100_100"} --100mm shell
PJ87.LN[1].PL[1].shot_delay = 0.66 --90 rounds in 1 min
PJ87.LN[1].BR = { {pos = {10, 5, 0},} }

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], PJ87)
GT.WS[ws].area = 'MAIN_GUN'
GT.WS[ws].center = 'CENTER_AK100_1_1'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_AK100_1_1'
--GT.WS[ws].LN[1].BR[1].recoilArgument = 33
GT.WS[ws].LN[1].BR[1].recoilTime = 0.667
--GT.WS[ws].LN[1].customViewPoint = { "genericHowitzer", {-0.5, 0.4, 0.0 }, }


local reflect_limit_share = 0.05

--------------------------------------------------------------------
----------------------------- HHQ9 radars
--------------------------------------------------------------------
ws = GT_t.inc_ws()
local first_HHQ_tracker_id = ws
GT.WS[ws] = {
    omegaY = 2,
    omegaZ = 2,
    pidY = {p=100, i=0.05, d=12, inn = 50},
    pidZ = {p=100, i=0.05, d=12, inn = 50},
    pos = {0.0, 19.0, 0.0},
    angles = { {math.rad(180), math.rad(-180), math.rad(-90), math.rad(80)} },
    LN = {
        [1] = {
            type = 102,
            frequencyRange = {0.5e9, 0.58e9},
            distanceMin = 1000,
            distanceMax = GT.airFindDist,
            reactionTime = 2.0,
            reflection_limit = reflect_limit_share,
            ECM_K = 0.5,
            min_trg_alt = 5,
            max_trg_alt = 30000,
            max_number_of_missiles_channels = 2,
            beamWidth = math.rad(90)
        }
    }
}

local HHQ_tracker_ws = {{{'self', ws}}}

for i=2,8 do -- 12 SAM Channels
    ws = GT_t.inc_ws()
    GT.WS[ws] = {}
    set_recursive_metatable(GT.WS[ws], GT.WS[first_HHQ_tracker_id])
    table.insert(HHQ_tracker_ws, {{'self', ws}})
end

----------------------------------------------------------------------------
---------------------------HQ9 SAM Missile
----------------------------------------------------------------------------
ship_HHQ9 = {}
ship_HHQ9.moveable = false
ship_HHQ9.angles = {
    {math.rad(180), math.rad(-180), math.rad(-90), math.rad(90)},
}

ship_HHQ9.LN = {}
for i = 1, 1 do
    ship_HHQ9.LN[i] = {}
    ship_HHQ9.LN[i].type = 4
    ship_HHQ9.LN[i].out_velocity = 2
    ship_HHQ9.LN[i].distanceMin = 7000
    ship_HHQ9.LN[i].distanceMax = GT.airWeaponDist
    ship_HHQ9.LN[i].reactionTime = 2
    ship_HHQ9.LN[i].launch_delay = 2
    ship_HHQ9.LN[i].barrels_reload_type = 2
    ship_HHQ9.LN[i].reflection_limit = reflect_limit_share
    ship_HHQ9.LN[i].ECM_K = 0.5
    ship_HHQ9.LN[i].sensor = {}
    ship_HHQ9.LN[i].max_number_of_missiles_channels = 2
    set_recursive_metatable(ship_HHQ9.LN[i].sensor, GT_t.WSN_t[0])
    ship_HHQ9.LN[i].PL = {}
    ship_HHQ9.LN[i].PL[1] = {}
    ship_HHQ9.LN[i].PL[1].ammo_capacity = 12
    ship_HHQ9.LN[i].PL[1].type_ammunition = HHQ_9.wsTypeOfWeapon
    ship_HHQ9.LN[i].PL[1].reload_time = 1000000 -- never during the mission
    ship_HHQ9.LN[i].BR = { {pos = {0, 0, 0} } }
end
----------------------------------------------
------------------ HHQ9 VLS
----------------------------------------------
-- front left
local HHQ9_CNT_L = 'POINT_HHQ9_1_'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_HHQ9 ) --ship_HHQ9
--GT.WS[ws].animation_alarm_state = {time = 1.5, arg = hh9larg[i] }
GT.WS[ws].area = 'NOSE_L'
GT.WS[ws].center = HHQ9_CNT_L..'9'
GT.WS[ws].LN[1].depends_on_unit = HHQ_tracker_ws
GT.WS[ws].LN[1].max_number_of_missiles_channels = 2
GT.WS[ws].LN[1].BR = {
    {connector_name = HHQ9_CNT_L..'1',  recoilArgument = 183, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'2',  recoilArgument = 188, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'3',  recoilArgument = 187, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'4',  recoilArgument = 186, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'5',  recoilArgument = 185, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'6',  recoilArgument = 184, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'7',  recoilArgument = 195, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'8',  recoilArgument = 200, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'9',  recoilArgument = 199, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'10', recoilArgument = 198, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'11', recoilArgument = 197, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'12', recoilArgument = 196, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
}

-- GT.WS[ws].pointer = "PNT_SAM_SIGHT_F"
-- GT.WS[ws].cockpit = { "genericMissile", {0.0, 0.0, 0.0} }
-- GT.WS[ws].isoviewOffset = {0.0, 6.0, 0.0}
-- GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"


-- front right
local HHQ9_CNT_R = 'POINT_HHQ9_2_'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_HHQ9 ) --ship_HHQ9
--GT.WS[ws].animation_alarm_state = {time = 1.5, arg = hh9rarg[i] }
GT.WS[ws].area = 'NOSE_R'
GT.WS[ws].center = HHQ9_CNT_R..'9'
GT.WS[ws].LN[1].depends_on_unit = HHQ_tracker_ws
GT.WS[ws].LN[1].max_number_of_missiles_channels = 2
GT.WS[ws].LN[1].BR = {
    {connector_name = HHQ9_CNT_R..'1',  recoilArgument = 177, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'2',  recoilArgument = 182, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'3',  recoilArgument = 181, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'4',  recoilArgument = 180, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'5',  recoilArgument = 179, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'6',  recoilArgument = 178, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'7',  recoilArgument = 189, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'8',  recoilArgument = 194, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'9',  recoilArgument = 193, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'10', recoilArgument = 192, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'11', recoilArgument = 191, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'12', recoilArgument = 190, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
}


-- front rear
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_HHQ9 ) --ship_HHQ9
--GT.WS[ws].animation_alarm_state = {time = 1.5, arg = hh9rarg[i] }
GT.WS[ws].area = 'NOSE_R'
GT.WS[ws].center = HHQ9_CNT_R..'9'
GT.WS[ws].LN[1].depends_on_unit = HHQ_tracker_ws
GT.WS[ws].LN[1].max_number_of_missiles_channels = 2
GT.WS[ws].LN[1].BR = {
    {connector_name = HHQ9_CNT_L..'13', recoilArgument = 207, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'14', recoilArgument = 212, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'15', recoilArgument = 211, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'16', recoilArgument = 210, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'17', recoilArgument = 209, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_L..'18', recoilArgument = 208, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'13', recoilArgument = 201, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'14', recoilArgument = 206, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'15', recoilArgument = 205, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'16', recoilArgument = 204, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'17', recoilArgument = 203, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_R..'18', recoilArgument = 202, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
}

-- GT.WS[ws].pointer = "PNT_SAM_SIGHT_F"
-- GT.WS[ws].isoviewOffset = {0.0, 6.0, 0.0}
-- GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"


-- rear front
local HHQ9_CNT_BF = 'POINT_HHQ9_3_'

-- rear back
local HHQ9_CNT_BB = 'POINT_HHQ9_4_'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_HHQ9 ) --ship_HHQ9
GT.WS[ws].area = 'NOSE_R'
GT.WS[ws].center = HHQ9_CNT_BF..'3'
GT.WS[ws].LN[1].depends_on_unit = HHQ_tracker_ws
GT.WS[ws].LN[1].BR = {
    -- {213, 218, 217, 216, 215, 214}
    {connector_name = HHQ9_CNT_BF..'1', recoilArgument = 213, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BF..'2', recoilArgument = 218, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BF..'3', recoilArgument = 217, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BF..'4', recoilArgument = 216, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BF..'5', recoilArgument = 215, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BF..'6', recoilArgument = 214, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},

    -- {219, 224, 223, 222, 221, 220}
    {connector_name = HHQ9_CNT_BB..'1', recoilArgument = 219, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BB..'2', recoilArgument = 224, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BB..'3', recoilArgument = 223, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BB..'4', recoilArgument = 222, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BB..'5', recoilArgument = 221, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
    {connector_name = HHQ9_CNT_BB..'6', recoilArgument = 220, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0},
}

-- GT.WS[ws].pointer = "PNT_SAM_SIGHT_B"
-- GT.WS[ws].cockpit = { "genericMissile", {0.0, 0.0, 0.0} }
-- GT.WS[ws].isoviewOffset = {0.0, 6.0, 0.0}
-- GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"
-- GT.WS[ws].drawArgument1 = 406
-- GT.WS[ws].drawArgument2 = 407


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


--Type730 - front
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type730)
GT.WS[ws].area = 'CIWS_F'
GT.WS[ws].center = 'CENTER_CIWS_1_1'
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].angles_mech = {
    {math.rad(120), math.rad(-120), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    {math.rad(120), math.rad(-120), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(0) --Reversed for CIWS, 90 means 90deg left
GT.WS[ws].LN[1].fireAnimationArgument = 119
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_CIWS_1_1' --TBD
-- GT.WS[ws].LN[1].customViewPoint = { "IronSight/IronSight", {0.0, 0.0, 0.0} }
-- GT.WS[ws].pointer = "PNT_CIWS_SIGHT_F"
ws = nil


--Type730 - rear
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type730)
GT.WS[ws].area = 'CIWS_B'
GT.WS[ws].center = 'CENTER_CIWS_2_1'
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].angles_mech = {
    {math.rad(-30), math.rad(30), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    {math.rad(-30), math.rad(30), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(-180) --Reversed for CIWS, this is actually rad(90)
GT.WS[ws].LN[1].fireAnimationArgument = 120
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_CIWS_2_1' --TBD
-- GT.WS[ws].LN[1].customViewPoint = { "IronSight/IronSight", {0.0, 0.0, 0.0} }
-- GT.WS[ws].pointer = "PNT_CIWS_SIGHT_B"
ws = nil


-----------------------------------------------------------------------
------------------------  8 Anti-Ship Launchers  ----------------------
-----------------------------------------------------------------------

-- yj62
YJ62 = { name = "YJ62", display_name = _("YJ-62"), } -- YJ62 Missile Launcher
YJ62.type = 1
YJ62.distanceMin = 12000
YJ62.distanceMax = 300000
YJ62.reactionTime = 6
YJ62.launch_delay = 3
YJ62.external_tracking_awacs = true
YJ62.max_number_of_missiles_channels = 2
YJ62.sensor = {}
set_recursive_metatable(YJ62.sensor, GT_t.WSN_t[0])
YJ62.PL = {}
YJ62.PL[1] = {}
YJ62.PL[1].ammo_capacity = 4
YJ62.PL[1].type_ammunition = YJ_62_AS.wsTypeOfWeapon -- TODO: change to YJ62
YJ62.PL[1].reload_time = 1000000 -- never during the mission
YJ62.PL[1].shot_delay = 3 --Yankee Proved
YJ62.BR = { {pos = {0, 0, 0},} }


ship_YJ62 = {}
ship_YJ62.angles = {
    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(90)},
}
ship_YJ62.reference_angle_Z = math.rad(0)
ship_YJ62.moveable = false
ship_YJ62.LN = {}
__LN = add_launcher(ship_YJ62, YJ62)
__LN.show_external_missile = true



-- left
ship_YJ62.angles = {
    {math.rad(190), math.rad(-10), math.rad(-10), math.rad(90)},
}

local YJ_62_CNT = 'POINT_ASM_1_' --TBD
local YJ_62_Center = 'POINT_ASM_1_' --TBD

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ62)
--GT.WS[ws].animation_alarm_state = {time = 2, arg = 225}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_62_Center..'1' --TBD
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_62_CNT..'1', recoilArgument = 225, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'2', recoilArgument = 226, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'3', recoilArgument = 227, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'4', recoilArgument = 228, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
-- GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
-- GT.WS[ws].pointer = "PNT_ASM_SIGHT_L"
-- GT.WS[ws].drawArgument1 = 400
-- GT.WS[ws].drawArgument2 = 401


-- right
ship_YJ62.angles = {
    {math.rad(10), math.rad(-190), math.rad(-10), math.rad(90)},
}

YJ_62_CNT = 'POINT_ASM_2_'
YJ_62_Center = 'POINT_ASM_2_'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ62)
--GT.WS[ws].animation_alarm_state = {time = 2, arg = 229}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_62_Center..'1'
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].LN[1].BR = {
    {connector_name = YJ_62_CNT..'1', recoilArgument = 229, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'2', recoilArgument = 230, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'3', recoilArgument = 231, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
    {connector_name = YJ_62_CNT..'4', recoilArgument = 232, recoilT0 = -2, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 2.0,},
}
-- GT.WS[ws].LN[1].customViewPoint = { "genericMissile", {0.0, 0.0, 0.0} }
-- GT.WS[ws].pointer = "PNT_ASM_SIGHT_R"
-- GT.WS[ws].drawArgument1 = 402
-- GT.WS[ws].drawArgument2 = 403


--------------------------------------------------------------------------------------------------------------------------------------------------------------

GT.Name             = "Type_052C"
GT.DisplayName      = _("Type 052C Destroyer")
GT.DisplayNameShort = _("052C")
GT.Rate             = 4000

GT.Sensors =
{
    OPTIC = {
        "long-range naval optics",
        "long-range naval LLTV",
        "long-range naval FLIR",
    },
    RADAR = {
        "PLAN Search Radar A",
        "052C SAM STR",
    }
}

GT.DetectionRange  = GT.airFindDist
GT.ThreatRange = GT.airWeaponDist
GT.Singleton   ="no"
GT.mapclasskey = "P0091000069" -- icon's still destroyer
GT.attribute = {
    wsType_Navy, wsType_Ship, wsType_HCarrier, WSTYPE_PLACEHOLDER,
    "Cruisers", -- to attract more fire that makes it able to be sunk
    "RADAR_BAND1_FOR_ARM",
    "RADAR_BAND2_FOR_ARM",
    "DetectionByAWACS",
}
GT.Categories = {
    { name = "Armed Ship" },
    { name = "HelicopterCarrier" }
}
GT.tags = {
    "Destroyer",
}

GT.Countries = {'China'}
--------------------------------------------------------------------------------

GT.encyclopediaAnimation = {
    args = {
        [19] = 1.0, -- aft Phalanxs rotation
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
