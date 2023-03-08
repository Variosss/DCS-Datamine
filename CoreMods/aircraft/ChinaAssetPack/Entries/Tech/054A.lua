---- main part ----
mount_vfs_texture_path (current_mod_path .. '/Textures/Navy/054a')

GT = {}
GT_t.ws = 0

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "054a"
GT.visual.shape_dstr = ""

GT.animation_arguments.radar1_rotation = 1
GT.radar1_period = 3
GT.animation_arguments.radar2_rotation = 2
GT.radar2_period = 1
GT.animation_arguments.radar3_rotation = 3
GT.radar3_period = 1
GT.animation_arguments.luna_lights = -1
GT.animation_arguments.water_propeller = 8
GT.animation_arguments.flight_deck_fences = 150


GT.life              = 2500
GT.mass              = 4.20e+006
GT.max_velocity      = 15.4333
GT.race_velocity     = 15.4333
GT.economy_velocity  = 9.62
GT.economy_distance  = 6.437e+006
GT.race_distance     = 2.778e+006
GT.shipLength        = 135
GT.Width             = 16
GT.Height            = 37.2
GT.Length            = 135
GT.X_nose            = 66.0
GT.X_tail            = -60
GT.Tail_Width        = 11
GT.draft             = 15
GT.Gamma_max         = 0.35
GT.Om                = 0.05
GT.speedup           = 0.229734
GT.R_min             = 345.6
GT.distFindObstacles = 568.4
GT.RCS               = 60000

GT.numParking      = 1
GT.Plane_Num_      = 0
GT.Helicopter_Num_ = 1

GT.airWeaponDist = 45000
GT.airFindDist   = 160000

GT.DeckLevel     = 3.795
GT.Landing_Point = {-54.385, 3.795, 0.0}  ----


GT.DM = {
    -- 054A damage arg 70-75
    { area_name = "NOSE_R",  area_arg = 70, area_life = 800, area_fire = { pos = {46.8, 2.9, 5.0}, size = 0.8}}, --Main Gun
    { area_name = "BORT_R",  area_arg = 71, area_life = 800, area_fire = { pos = {21.1,  2.9, 7.4}, size = 0.8}}, --Right CIWS
    { area_name = "KORMA_R", area_arg = 72, area_life = 840, area_fire = { pos = {-38.7, 2.0, 7.4}, size = 0.8}},
    { area_name = "NOSE_L",  area_arg = 73, area_life = 840, area_fire = { pos = {36.5, 4.5, -6.4}, size = 0.8}}, -- 9m317 Launcher Fwd
    { area_name = "BORT_L",  area_arg = 74, area_life = 800, area_fire = { pos = {-5.4,  7.9, -7.2}, size = 0.8}}, --Left CIWS
    { area_name = "KORMA_L", area_arg = 75, area_life = 800, area_fire = { pos = {-54.9, 4.4, -3.3}, size = 0.8}},

    --[[
    { area_name = "MAIN_GUN", area_arg = 72, area_life = 80, },
    { area_name = "CIWS_L", area_arg = 74, area_life = 80, },
    { area_name = "CIWS_R", area_arg = 71, area_life = 80, },
    { area_name = "ASM_LAUNCHER", area_arg = 72, area_life = 80, },

    { area_name = "RADAR_TOP", area_arg = 72, area_life = 80, },
    { area_name = "RADAR_MGUN", area_arg = 72, area_life = 80, },
    ]]
}

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
PJ26 = {}
PJ26.angles = {
    {math.rad(125), math.rad(-125), math.rad(-10), math.rad(70)},
}
PJ26.omegaY = 0.6
PJ26.omegaZ = 0.6
PJ26.reference_angle_Z = 0
PJ26.LN = {}
PJ26.LN[1] = {}
PJ26.LN[1].type = 6
PJ26.LN[1].distanceMin = 50
PJ26.LN[1].max_trg_alt = 10000
PJ26.LN[1].reactionTime = 4
PJ26.LN[1].sensor = {}
set_recursive_metatable(PJ26.LN[1].sensor, GT_t.WSN_t[10])
PJ26.LN[1].PL = {}
PJ26.LN[1].PL[1] = {}
PJ26.LN[1].PL[1].ammo_capacity = 480
PJ26.LN[1].PL[1].shell_name = {"MK75_76"} --76mm shell
PJ26.LN[1].PL[1].shot_delay = 0.66 --90 rounds in 1 min
PJ26.LN[1].BR = { {pos = {10, 5, 0},} }

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], PJ26)
GT.WS[ws].area = 'NOSE_R'
GT.WS[ws].center = 'TARGET_AK76_1'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_AK76_1_1'
--GT.WS[ws].LN[1].BR[1].recoilArgument = 33
GT.WS[ws].LN[1].BR[1].recoilTime = 0.667


--------------------------------------------------------------------
----------------------------- 4 x HQ16 radars
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
            distanceMin = 1000,
            distanceMax = GT.airFindDist,
            reactionTime = 2.0,
            reflection_limit = reflect_limit_share,
            ECM_K = 0.45,
            min_trg_alt = 5,
            max_trg_alt = 30000,
            max_number_of_missiles_channels = 2,
            beamWidth = math.rad(90)
        }
    },
    animation_alarm_state = {time = 1.5, arg = 217 },
}

local HHQ_tracker_ws = {}
HHQ_tracker_ws[1] = {{{'self', ws}}}

for i=2,4 do -- 4 SAM Radars
    ws = GT_t.inc_ws()
    GT.WS[ws] = {}
    set_recursive_metatable(GT.WS[ws], GT.WS[first_HHQ_tracker_id])
    GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 216+i }
    HHQ_tracker_ws[i] = {{{'self', ws}}}
    --table.insert(HHQ_tracker_ws, {{{'self', ws}}})
end
----------------------------------------------------------------------------
---------------------------HQ16 SAM Missile
----------------------------------------------------------------------------
ship_HHQ16 = {}
ship_HHQ16.moveable = false
ship_HHQ16.angles = {
    {math.rad(180), math.rad(-180), math.rad(-90), math.rad(90)},
}

ship_HHQ16.LN = {}
ship_HHQ16.LN[1] = {}
ship_HHQ16.LN[1].type = 4
ship_HHQ16.LN[1].distanceMin = 1000
ship_HHQ16.LN[1].distanceMax = GT.airWeaponDist
ship_HHQ16.LN[1].reactionTime = 8
ship_HHQ16.LN[1].launch_delay = 6
ship_HHQ16.LN[1].barrels_reload_type = 2
ship_HHQ16.LN[1].reflection_limit = reflect_limit_share
ship_HHQ16.LN[1].ECM_K = 0.45
ship_HHQ16.LN[1].sensor = {}
set_recursive_metatable(ship_HHQ16.LN[1].sensor, GT_t.WSN_t[0])
ship_HHQ16.LN[1].PL = {}
ship_HHQ16.LN[1].PL[1] = {}
ship_HHQ16.LN[1].PL[1].ammo_capacity = 1
ship_HHQ16.LN[1].PL[1].type_ammunition = HQ_16.wsTypeOfWeapon
ship_HHQ16.LN[1].PL[1].reload_time = 1000000 -- never during the mission
ship_HHQ16.LN[1].BR = { {pos = {0, 0, 0} } }

----------------------------------------------
------------------ HHQ16 VLS
----------------------------------------------
local HHQ16_CNT = 'POINT_HHQ16_1_'

for i=0,3 do
    for j=1,8 do
        local idx = i*8+j
        ws = GT_t.inc_ws()
        GT.WS[ws] = {}
        set_recursive_metatable(GT.WS[ws], ship_HHQ16 ) --ship_HHQ16
        GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 184 + idx }

        if idx <= 16 then
            GT.WS[ws].area = 'NOSE_L'
        else
            GT.WS[ws].area = 'NOSE_R'
        end

        GT.WS[ws].center = HHQ16_CNT..idx
        GT.WS[ws].LN[1].depends_on_unit = HHQ_tracker_ws[i+1]
        GT.WS[ws].LN[1].BR = {{connector_name = HHQ16_CNT..idx}}
    end
end

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
GT.WS[ws].center = 'CENTER_CIWS_L001'
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].angles_mech = {
    {math.rad(-150), math.rad(-30), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    {math.rad(-150), math.rad(-30), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(90) --Reversed for CIWS, 90 means 90deg left
--GT.WS[ws].LN[1].fireAnimationArgument = 120
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_CIWS_L' --TBD
ws = nil


--Type730 - right
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], Type730)
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = 'CENTER_CIWS_R001'
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].angles_mech = {
    {math.rad(30), math.rad(150), math.rad(-25), math.rad(87)},
}
GT.WS[ws].angles = {
    --{math.rad(180), math.rad(-10), math.rad(-12), math.rad(88)}, --From 180 deg (right) to -10 deg (left) counter-clock coverage (190deg coverage)
    --Reversed for CIWS
    {math.rad(30), math.rad(150), math.rad(-25), math.rad(87)},
}
GT.WS[ws].reference_angle_Y = math.rad(-90) --Reversed for CIWS, this is actually rad(90)
--GT.WS[ws].LN[1].fireAnimationArgument = 119
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_CIWS_R' --TBD
ws = nil

-----------------------------------------------------------------------
------------------------  8 Anti-Ship Launchers  ----------------------
-----------------------------------------------------------------------

-- yj83
YJ83 = { name = "YJ83", display_name = _("YJ-83"), } -- YJ83 Missile Launcher
YJ83.type = 1
YJ83.distanceMin = 12000
YJ83.distanceMax = 180000
YJ83.reactionTime = 8
YJ83.launch_delay = 3
YJ83.external_tracking_awacs = true
YJ83.sensor = {}
set_recursive_metatable(YJ83.sensor, GT_t.WSN_t[0])
YJ83.PL = {}
YJ83.PL[1] = {}
YJ83.PL[1].ammo_capacity = 1
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


-- left
ship_YJ83.angles = {
    {math.rad(190), math.rad(-10), math.rad(-10), math.rad(90)},
}

local YJ_83_CNT = 'POINT_YJ83_1_' --TBD
local YJ_83_Center = 'POINT_YJ83_1_' --TBD

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 181}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_Center..'1' --TBD
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'1' --TBD

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 182}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_Center..'2'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'2'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 183}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_Center..'3'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'3'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 184}
GT.WS[ws].area = 'BORT_L'
GT.WS[ws].center = YJ_83_Center..'4'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'4'

-- right
ship_YJ83.angles = {
    {math.rad(10), math.rad(-190), math.rad(-10), math.rad(90)},
}

YJ_83_CNT = 'POINT_YJ83_2_'
YJ_83_Center = 'POINT_YJ83_2_'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 177}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_Center..'1'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'1'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 178}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_Center..'2'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'2'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 179}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_Center..'3'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'3'

ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], ship_YJ83)
GT.WS[ws].animation_alarm_state = {time = 1.5, arg = 180}
GT.WS[ws].area = 'BORT_R'
GT.WS[ws].center = YJ_83_Center..'4'
GT.WS[ws].LN[1].BR[1].connector_name = YJ_83_CNT..'4'

--------------------------------------------------------------------------------------------------------------------------------------------------------------

GT.Name             = "Type_054A"
GT.DisplayName      = _("Type 054A Frigate")
GT.DisplayNameShort = _("054A")
GT.Rate             = 4000

GT.Sensors =
{
    OPTIC = {
        "long-range naval optics",
        "long-range naval LLTV",
        "long-range naval FLIR",
    },
    RADAR = {
        "PLAN Search Radar B",
        "052B SAM TR",
    }
}

GT.DetectionRange = GT.airFindDist
GT.ThreatRange = GT.airWeaponDist
GT.Singleton   ="no"
GT.mapclasskey = "P0091000070"
GT.attribute = {
    wsType_Navy, wsType_Ship, wsType_HCarrier, WSTYPE_PLACEHOLDER,
    "Frigates",
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
        [14] = 0.1, -- front cannon elevation
        [17] = -0.2, -- SB Phalanxs rotation
        [19] = 0.2, -- PS Phalanxs rotation
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
