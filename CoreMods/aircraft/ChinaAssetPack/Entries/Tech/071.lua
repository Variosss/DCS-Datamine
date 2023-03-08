
mount_vfs_texture_path (current_mod_path .. '/Textures/Navy/071')

GT = {}
GT_t.ws = 0

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "071"
GT.visual.shape_dstr = ""

--------------------------------------------------------------------------------
-- SHIP DESCRIPTION
--------------------------------------------------------------------------------
GT.life                     = 7300
GT.mass                     = 25000000
GT.max_velocity             = 12.7777
GT.race_velocity            = 12.7777
GT.economy_velocity         = 9.16667
GT.economy_distance         = 19000000
GT.race_distance            = 9000000
GT.shipLength               = 210
GT.Width                    = 28
GT.Height                   = 40
GT.Length                   = 210
GT.X_nose                   = 108
GT.X_tail                   = -104
GT.Tail_Width               = 31.753
GT.draft                    = 5
GT.Gamma_max                = 0.35
GT.Om                       = 0.05
GT.speedup                  = 0.119249
GT.R_min                    = 665.8
GT.distFindObstacles        = 1048.7
GT.RCS                      = 400000

GT.TACAN                    = true
GT.TACAN_position           = {35.0, 40.0, 0.0}

--------------------------------------------------------------------------------
-- Engine
GT.exhaust = {
    [1] = { size = 0.20, pos = {-8.00, 25,  10.00 } },
    [2] = { size = 0.20, pos = {-8.00, 25, -10.00 } },
}

--------------------------------------------------------------------------------
GT.DM = {
    { area_name = "NOSE_L",              area_arg = 73, area_life = 2400, area_fire = { pos = {80.0, -8.0, 10.0}, size = 0.5} },
    { area_name = "NOSE_R",              area_arg = 70, area_life = 2400, area_fire = { pos = {80.0,  8.0, 10.0}, size = 0.5} },

    { area_name = "CENTER_L",            area_arg = 74, area_life = 2800, area_fire = { pos = {20.0, -8.0, 15.5}, size = 0.5} },
    { area_name = "CENTER_R",            area_arg = 71, area_life = 2800, area_fire = { pos = {20.0,  8.0, 15.5}, size = 0.5} },

    { area_name = "BACK_L",              area_arg = 75, area_life = 2400, area_fire = { pos = {-60.0, -8.0, 10.5}, size = 0.5} },
    { area_name = "BACK_R",              area_arg = 72, area_life = 2400, area_fire = { pos = {-60.0,  8.0, 10.5}, size = 0.5} },

    { area_name = "BACK",                area_arg = 79, area_life = 300 },
    { area_name = "BACK-2",              area_arg = 79, area_life = 300 },
    --{ area_name = "INTERNAL",            area_arg = 80, area_life = 600 },
    { area_name = "INTERNAL-1",          area_arg = 80, area_life = 600 },
}

--------------------------------------------------------------------------------

GT.LSOView = {
    cockpit = "empty",
    position = {
        --connector = "DECK_LSO",
        offset = {-21.0, 20.5, 0.0, 180.0, 0.0}
    }
}

GT.OLS = {Type = GT_t.OLS_TYPE.Luna, MeatBallArg = -1}

GT.numParking      = 2
GT.Helicopter_Num_ = 2

local deck_level_f = 11.6 - 0.9
local deck_level_r = deck_level_f + 0.3

GT.DeckLevel       = deck_level_f
GT.Landing_Point   = {-76.0, deck_level_r, 3.5}


GT.RunWays =
{
    -- landing strip definition (first in table)
    --  VppStartPoint            azimuth (degree}   Length_Vpp     Width_Vpp
    {{-76.5, deck_level_f,  3.5},         0.0,             5.0,          14.0,
    -- alsArgument, lowGlidePath, slightlyLowGlidePath, onLowerGlidePath, onUpperGlidePath, slightlyHighGlidePath, highGlidePath
       0,             2.5,              2.8,               3.0,               3.0,                 3.2,               3.5 },
    -- runways
    {{-38.5, deck_level_f, -3.5},         0.0,             5.0,          14.0,         0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
    {{-76.0, deck_level_r,  3.5},         0.0,             5.0,          14.0,         0, 2.5, 2.8, 3.0, 3.0, 3.2, 3.5},
}
GT.RunWays.RunwaysNumber = #GT.RunWays

GT.TaxiRoutes =
{
    -- taxi routes and parking spots in LCS
    --    {x, y, z},  direction
}
GT.TaxiRoutes.RoutesNumber = #GT.TaxiRoutes


GT.HelicopterSpawnTerminal =
{
    -- taxi routes and parking spots in LCS
    --    {x, y, z},  direction
    {
        TerminalIdx = 1, Points =
        { -- 1 spawn spot
            {{-38.5, deck_level_f, -3.5},     0.0},
        }
    },
    {
        TerminalIdx = 2, Points =
        { -- 1 spawn spot
            {{-76.0, deck_level_r,  3.5},     0.0},
        }
    },
}
GT.HelicopterSpawnTerminal.TerminalNumber = #GT.HelicopterSpawnTerminal

--------------------------------------------------------------------------------

GT.deck_crew = {
    { pos = {-75.343,  10.540, 11.009}, shape = "sailor_01" },
    { pos = {-39.638, -10.336, 10.690}, shape = "tech_01" },
}

--------------------------------------------------------------------------------
GT.radar1_period = 3
GT.animation_arguments.radar1_rotation = 11 -- Radar 1 Rotation
GT.animation_arguments.radar2_rotation = -1 -- Radar 2 Rotation (DISABLED)
GT.animation_arguments.radar3_rotation = -1 -- Radar 3 Rotation (DISABLED)
GT.animation_arguments.luna_lights = 100

GT.animation_arguments.water_propeller = 8
GT.animation_arguments.flight_deck_fences = 150

GT.animation_arguments.alarm_state = 500
GT.animation_arguments.toggle_alarm_state_interval = 20

GT.WS = {}
GT.WS.radar_type = 104
GT.WS.maxTargetDetectionRange = 30000
GT.WS.searchRadarMaxElevation = math.rad(50)


-- Vympel Left
-- 1
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.SS_t.VYMPEL_TRACKER[1])
GT.WS[ws].center = 'CENTER_AK630_RADAR_01'
GT.WS[ws].angles[1][1] = math.rad(170)
GT.WS[ws].angles[1][2] = math.rad(10)
GT.WS[ws].drawArgument1 = 8
GT.WS[ws].reference_angle_Y = math.rad(90)
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.SS_t.VYMPEL_TRACKER[2])
GT.WS[ws].base = ws-1
local vympel_trackers_l = {{{"self", ws-1}}, {{"self", ws}}}

-- Vympel Right
-- 3
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.SS_t.VYMPEL_TRACKER[1])
GT.WS[ws].center = 'CENTER_AK630_RADAR_02'
GT.WS[ws].angles[1][1] = math.rad(-10)
GT.WS[ws].angles[1][2] = math.rad(-170)
GT.WS[ws].drawArgument1 = 7
GT.WS[ws].reference_angle_Y = math.rad(-90)
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.SS_t.VYMPEL_TRACKER[2])
GT.WS[ws].base = ws-1
local vympel_trackers_r = {{{"self", ws-1}}, {{"self", ws}}}

------------------------  AK176 main gun  ----------------------
-- 5
ws = GT_t.inc_ws()
GT.WS[ws] = {}
--GT.WS[ws].area = "TOWER_F"
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_AK176)
GT.WS[ws].center = 'CENTER_AK176'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].LN[1].BR[1].connector_name = 'PNT_AK176'
GT.WS[ws].LN[1].BR[1].recoilArgument = 116
GT.WS[ws].LN[1].BR[1].recoilTime = 0.4

--------------------------------------------------------------------------------

-- Left
-- 6
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_AK630_01"
--GT.WS[ws].area = "ZA_01"
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].angles = { {math.rad(170), math.rad(10), math.rad(-12), math.rad(88)}}
GT.WS[ws].reference_angle_Y = math.rad(90)
--GT.WS[ws].LN[1].depends_on_unit = vympel_trackers_l
GT.WS[ws].LN[1].BR[1].connector_name = 'PNT_AK630_01'
GT.WS[ws].LN[1].fireAnimationArgument = 117

-- 7
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_AK630_02"
--GT.WS[ws].area = "ZA_02"
GT.WS[ws].angles = { {math.rad(170), math.rad(10), math.rad(-12), math.rad(88)}}
GT.WS[ws].reference_angle_Y = math.rad(90)
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
--GT.WS[ws].LN[1].depends_on_unit = vympel_trackers_l
GT.WS[ws].LN[1].BR[1].connector_name = 'PNT_AK630_02'
GT.WS[ws].LN[1].fireAnimationArgument = 118

-- Right
-- 8
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_AK630_03"
--GT.WS[ws].area = "ZA_03"
GT.WS[ws].angles = { {math.rad(-10), math.rad(-170), math.rad(-12), math.rad(88)}}
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].drawArgument1 = 21
GT.WS[ws].drawArgument2 = 22
--GT.WS[ws].LN[1].depends_on_unit = vympel_trackers_r
GT.WS[ws].LN[1].BR[1].connector_name = 'PNT_AK630_03'
GT.WS[ws].LN[1].fireAnimationArgument = 119

-- 9
ws = GT_t.inc_ws()
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.AK630)
GT.WS[ws].center = "CENTER_AK630_04"
--GT.WS[ws].area = "ZA_04"
GT.WS[ws].angles = { {math.rad(-10), math.rad(-170), math.rad(-12), math.rad(88)}}
GT.WS[ws].reference_angle_Y = math.rad(-90)
GT.WS[ws].drawArgument1 = 23
GT.WS[ws].drawArgument2 = 24
--GT.WS[ws].LN[1].depends_on_unit = vympel_trackers_r
GT.WS[ws].LN[1].BR[1].connector_name = 'PNT_AK630_04'
GT.WS[ws].LN[1].fireAnimationArgument = 120



--------------------------------------------------------------------------------


ws = GT_t.inc_ws()
GT.WS[ws] = {}
--GT.WS[ws].base = 1
GT.WS[ws].center = 'DOCK_VIEW'
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-8), math.rad(63)},
}
GT.WS[ws].drawArgument1 = 27
GT.WS[ws].drawArgument2 = -1
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(60)
GT.WS[ws].pidY = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].pidZ = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].reference_angle_X = 0
GT.WS[ws].reference_angle_Y = 0
GT.WS[ws].reference_angle_Z = 0

GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
GT.WS[ws].LN[1].name = "Dock_View"
GT.WS[ws].LN[1].display_name = _("Dock View")
GT.WS[ws].LN[1].type = 103
GT.WS[ws].LN[1].distanceMin = 0
GT.WS[ws].LN[1].distanceMax = 0
GT.WS[ws].LN[1].distanceMaxForFCS = 5000
GT.WS[ws].LN[1].BR = {{connector_name = 'DOCK_VIEW'}}
GT.WS[ws].LN[1].customViewPoint = { "DriverCockpit/DriverCockpitWithIRandLLTV", {0.1, 0.0, 0.0} }


--------------------------------------------------------------------------------


GT.Name             = "Type_071"
GT.DisplayName      = _("Type 071 Amphibious Transport Dock")
GT.DisplayNameShort = _("071")
GT.Rate             = 3000

GT.Sensors = {
    OPTIC = {"long-range naval optics", "long-range naval LLTV"},
    RADAR = {"PLAN Search Radar B"}
}

GT.airFindDist      = 300000    -- Max detenction range air threats (meters)
GT.airWeaponDist    = 150000    -- Max engagement range air threats (meters)

GT.DetectionRange   = GT.airFindDist
GT.ThreatRange      = GT.airWeaponDist
GT.Singleton        = "yes"
GT.mapclasskey      = "P0091000067"
GT.attribute        = {
    wsType_Navy, wsType_Ship, wsType_AirCarrier, WSTYPE_PLACEHOLDER,
    "Aircraft Carriers",
    "RADAR_BAND1_FOR_ARM",
    "RADAR_BAND2_FOR_ARM",
    "DetectionByAWACS",
    "Straight_in_approach_type",
    "NO_SAM"
}
GT.Categories       = {
    { name = "Armed Ship" },
    { name = "HelicopterCarrier" },
    { name = "AircraftCarrier" },
    { name = "AircraftCarrier With Tramplin" },
}

GT.Countries        = { "China",}
--------------------------------------------------------------------------------

GT.encyclopediaAnimation = {
    args = {
        [17] = 0.5, -- PS fwd Phalanxs rotation
        [19] = 1.0, -- PS aft Phalanxs rotation
        [21] = -0.5, -- SB fwd Phalanxs rotation
        [23] = 1.0, -- SB aft Phalanxs rotation
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
