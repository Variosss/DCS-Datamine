---- main part ----
mount_vfs_texture_path (current_mod_path .. '/Textures/Navy/093')

GT = {}
GT_t.ws = 0

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape      = "093"
GT.visual.shape_dstr = ""

GT.life              = 1500
GT.mass              = 5.30e+006
GT.max_velocity      = 14.9
GT.race_velocity     = 14.9
GT.economy_velocity  = 5.15
GT.economy_distance  = 7.2e+007
GT.race_distance     = 7.2e+006
GT.shipLength        = 103
GT.Width             = 10.5
GT.Height            = 10.4
GT.Length            = 103
GT.DeckLevel         = 3.0
GT.X_nose            = 22
GT.X_tail            = -45
GT.Tail_Width        = 7.3
GT.Gamma_max         = 0.00
GT.Om                = 0.02
GT.speedup           = 0.4
GT.R_min             = 345.6
GT.distFindObstacles = 568.4
GT.RCS               = 4000

GT.airWeaponDist     = 30000
GT.airFindDist       = 10000

GT.minPeriscopeDepth = 10.0
GT.maxPeriscopeDepth = 15.0

GT.animation_arguments = {
    nav_lights       = 69, -- навигационные огни
    radar1_rotation  = -1,
    radar2_rotation  = -1,
    radar3_rotation  = -1,
    flag_animation   = -1,
    water_propeller  = 65,
    periscope        = 15,
}

--GT.propeller_omega_max = 120.0

-- times
local start_diving_  = 1
local stop_diving_   = 15
local start_rising_  = stop_diving_
local stop_rising_   = 20

local totalDuration_ = stop_rising_

--GT.toggle_alarm_state_interval = totalDuration_
--GT.toggle_alarm_state_interval = 5.0

GT.animation_arguments.alarm_state_sequence =
{
    totalDuration = 5.0, --totalDuration_,
    --[[{ 3, {{startTime=0.0, endTime = start_diving_, startVal = 0.0, endVal = 0.0},
          {startTime=start_diving_, endTime = stop_diving_, startVal = 0.0, endVal = 1.0},
          {startTime=start_rising_, endTime = totalDuration_, startVal = 1.0, endVal = 1.0}}
    },]]
    -- periscope etc
    --[[{15, {{startTime=0.0, endTime = start_rising_, startVal = 0.0, endVal = 0.0},
          {startTime=start_rising_, endTime = stop_rising_, startVal = 0.0, endVal = 1.0},
          {startTime=stop_rising_, endTime = totalDuration_, startVal = 1.0, endVal = 1.0}}
    },
    {16, {{startTime=0.0, endTime = start_rising_, startVal = 0.0, endVal = 0.0},
          {startTime=start_rising_, endTime = stop_rising_, startVal = 0.0, endVal = 1.0},
          {startTime=stop_rising_, endTime = totalDuration_, startVal = 1.0, endVal = 1.0}}
    },
    {14, {{startTime=0.0, endTime = start_diving_, startVal = 1.0, endVal = 1.0},
          {startTime=start_diving_, endTime = stop_diving_/3.0, startVal = 1.0, endVal = 0.0},
          {startTime=stop_diving_/3.0, endTime = totalDuration_, startVal = 0.0, endVal = 0.0}}
    },
    {17, {{startTime=0.0, endTime = start_diving_, startVal = 1.0, endVal = 1.0},
          {startTime=start_diving_, endTime = stop_diving_/3.0, startVal = 1.0, endVal = 0.0},
          {startTime=stop_diving_/3.0, endTime = totalDuration_, startVal = 0.0, endVal = 0.0}}
    },]]
    {18, {{startTime=0.0, endTime = 1.0, startVal = 0.0, endVal = 0.0},
          {startTime=1.0, endTime = 4.0, startVal = 0.0, endVal = 1.0},
          {startTime=4.0, endTime = 5.0, startVal = 1.0, endVal = 1.0}}
    },
}
-- {depth, fx_dx, fx_len, fx_width)
--fx_dx - distance from stern to stern fx position
--fx_len - distance from bow to stern fx
--GT.sternEffectDX = {{0.0, 0.0, 95.0, 5.0}, {1.0, 6.0, 88.0, 4.0}, {2.0, 14.0, 75.0, 3.5}, {2.8, 24.0, 55.0, 2.0}, {2.9, 58.0, 14.0, 2.0}, {10.5, 58.0, 14.0, 2.0},}
GT.sternEffectDX = {{0.0, 0.0, 58.0, 6.0}, {2.0, 10.0, 41.0, 4.0}, {2.5, 14.5, 31.0, 3.0}, {2.7, 29.0, 13.0, 2.0}, {7.5, 29.0, 13.0, 2.0},}

GT.DM = {
    { area_name = "BODY_FRONT", area_arg = 71, area_life = 80, area_fire = { pos = { -7.379, 2.46, 0}, size = 0.8}},
    { area_name = "BODY_TOP",   area_arg = 70, area_life = 80, area_fire = { pos = { 18.327, 7.4, 0}, size = 0.8}},
    -- { area_name = "BODY_BACK",  area_arg = -1, area_life = 80, area_fire = { pos = {-20, 5.0, 0}, size = 0.8}},
}


-----------------------------------------------------------------------------------------------------------
-- weapon systems
-----------------------------------------------------------------------------------------------------------

-- [[ YU-6 Begin ]] --
YU6 = { name = "YU6", display_name = _("YU-6"), }
YU6.type = 32
YU6.distanceMin = 5000
YU6.distanceMax = 20000
YU6.reactionTime = 0.1
YU6.launch_delay = 0.1
YU6.external_tracking_awacs = false
YU6.sensor = {}
set_recursive_metatable(YU6.sensor, GT_t.WSN_t[0])
YU6.max_number_of_missiles_channels = 18
YU6.PL = {}
YU6.PL[1] = {}
YU6.PL[1].ammo_capacity = 18
YU6.PL[1].type_ammunition = YU_6.wsTypeOfWeapon
YU6.PL[1].name_ammunition = YU_6.name
YU6.PL[1].reload_time = 20
YU6.PL[1].shot_delay = 0.1
YU6.BR = {
    {connector_name = "TPO_00", recoilArgument = 177, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    {connector_name = "TPO_00", recoilArgument = 178, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    {connector_name = "TPO_00", recoilArgument = 179, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    {connector_name = "TPO_00", recoilArgument = 180, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    {connector_name = "TPO_00", recoilArgument = 181, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    {connector_name = "TPO_00", recoilArgument = 182, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
    --[[
    {connector_name = "TPO_01", recoilArgument = 177, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    {connector_name = "TPO_02", recoilArgument = 178, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    {connector_name = "TPO_03", recoilArgument = 179, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    {connector_name = "TPO_04", recoilArgument = 180, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    {connector_name = "TPO_05", recoilArgument = 181, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    {connector_name = "TPO_06", recoilArgument = 182, recoilT0 = -5, recoilT1 = -3, recoilT2 = 3.0, recoilTime = 5.0},
    ]]
}
-- [[ YU-6 End ]] --

-- [[ YJ84 Begin ]] --
YJ84 = { name = "YJ84", display_name = _("YJ-84"), }
YJ84.type = 1
YJ84.distanceMin = 5000
YJ84.distanceMax = 60000
YJ84.reactionTime = 10
YJ84.launch_delay = 8
YJ84.external_tracking_awacs = true
YJ84.sensor = {}
set_recursive_metatable(YJ84.sensor, GT_t.WSN_t[0])
YJ84.max_number_of_missiles_channels = 2
YJ84.PL = {}
YJ84.PL[1] = {}
YJ84.PL[1].ammo_capacity = 4
YJ84.PL[1].type_ammunition = YJ_84_AS.wsTypeOfWeapon
YJ84.PL[1].name_ammunition = YJ_84_AS.name
YJ84.PL[1].reload_time = 1000000 -- never during the mission
YJ84.PL[1].shot_delay = 3
YJ84.BR = {
    {connector_name = "MSL_01",},
    {connector_name = "MSL_02",},
    {connector_name = "MSL_03",},
    {connector_name = "MSL_04",},
}
-- [[ YJ84 End ]] --

GT.WS = {}
local ws

-- yu6
ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(90)},
}
GT.WS[ws].angles_mech = {
    {math.rad(60), math.rad(-60), math.rad(-5), math.rad(5)},
}
GT.WS[ws].reference_angle_Z = math.rad(0)
GT.WS[ws].moveable = true
GT.WS[ws].drawArgument1 = 902
GT.WS[ws].drawArgument2 = 903
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(60)
GT.WS[ws].pidY = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].pidZ = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].reference_angle_X = 0
GT.WS[ws].reference_angle_Y = 0
GT.WS[ws].reference_angle_Z = 0
GT.WS[ws].center = 'CENTER_SCOPE_01'
GT.WS[ws].pointer = "PNT_SCOPE_01"
GT.WS[ws].cockpit = {'genericAAA', {0.0, 0.0, 0.0 }}

__LN2 = add_launcher(GT.WS[ws], YU6)
__LN2.show_external_missile = false
__LN2.barrels_reload_type = BarrelsReloadTypes.SIMULTANEOUSLY
__LN2.sightMasterMode = 1
__LN2.sightIndicationMode = 1


-- yj84
GT.WS.maxTargetDetectionRange = 40000
GT.WS.radar_type              = 102
GT.WS.searchRadarMaxElevation = math.rad(80)

ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(90)},
}
GT.WS[ws].angles_mech = {
    {math.rad(180), math.rad(-180), math.rad(-5), math.rad(5)},
}
GT.WS[ws].reference_angle_Z = math.rad(0)
GT.WS[ws].moveable = true
GT.WS[ws].drawArgument1 = 900
GT.WS[ws].drawArgument2 = 901
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(60)
GT.WS[ws].pidY = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].pidZ = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].reference_angle_X = 0
GT.WS[ws].reference_angle_Y = 0
GT.WS[ws].reference_angle_Z = 0
GT.WS[ws].center = 'CENTER_SCOPE'
GT.WS[ws].pointer = "PNT_SCOPE"
GT.WS[ws].cockpit = {'genericMissile', {0.0, 0.0, 0.0 }}

__LN1 = add_launcher(GT.WS[ws], YJ84)
__LN1.show_external_missile = false
__LN1.barrels_reload_type = BarrelsReloadTypes.SIMULTANEOUSLY
__LN1.sightMasterMode = 1
__LN1.sightIndicationMode = 1


-------------------------

GT.Name             = "Type_093"
GT.DisplayName      = _("Type 093 Attack Submarine")
GT.DisplayNameShort = _("093")
GT.Rate             = 2000

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

GT.DetectionRange = GT.WS.maxTargetDetectionRange
GT.ThreatRange    = GT.WS.maxTargetDetectionRange
GT.Singleton      = "no"
GT.mapclasskey    = "P0091000038"

GT.attribute = {
    wsType_Navy, wsType_Ship, wsType_Submarine, WSTYPE_PLACEHOLDER,
    "Submarines",
    "RADAR_BAND1_FOR_ARM",
    "DetectionByAWACS",
    "NO_SAM"
}

GT.Categories = {
    { name = "Armed Ship" },
}
GT.tags = {
	"Submarine",
}

GT.Countries = {'China'}
--------------------------------------------------------------------------------

GT.encyclopediaAnimation = {
    args = {
        [14] = 1.0, --
        [15] = 1.0, --
        [16] = 1.0, --
        [17] = 1.0, --
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
