mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/santa_fe/santa_fe.zip")

GT = {};
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape      = "santafe"
GT.visual.shape_dstr = ""
GT.life              = 3;
GT.mass              = 5.30e+006;
GT.max_velocity      = 14.9
GT.race_velocity     = 14.9
GT.economy_velocity  = 5.15
GT.economy_distance  = 7.2e+007
GT.race_distance     = 7.2e+006
GT.shipLength        = 93
GT.Width             = 8.4
GT.Height            = 15
GT.Length            = 94
GT.DeckLevel         = 3.0
GT.baseSubmersion    = 0.5;
GT.X_nose            = 22
GT.X_tail            = -50
GT.Tail_Width        = 1
GT.draft			 = 6
GT.Gamma_max         = 0.25
GT.Om                = 0.01
GT.speedup           = 0.4
GT.R_min             = 345.6
GT.distFindObstacles = 568.4

GT.airWeaponDist     = 30000
GT.airFindDist       = 10000

GT.minPeriscopeDepth = 9.0;  
GT.maxPeriscopeDepth = 12.0;

GT.animation_arguments = {
    nav_lights       = 69, 
    radar1_rotation  = -1,
    radar2_rotation  = -1,
    radar3_rotation  = -1,
    flag_animation   = -1,
    water_propeller  = 65,
    locator_rotation = 1,
    periscope        = 14,
	
}
GT.propeller_omega_max                 = 120.0

local start_diving_  = 1
local stop_diving_   = 15
local start_rising_  = stop_diving_
local stop_rising_   = 20

local totalDuration_ = stop_rising_

GT.toggle_alarm_state_interval = totalDuration_

GT.animation_arguments.alarm_state_sequence =
{
    totalDuration = totalDuration_,
    { 3, {{startTime=0.0, endTime = start_diving_, startVal = 0.0, endVal = 0.0},
          {startTime=start_diving_, endTime = stop_diving_, startVal = 0.0, endVal = 0.75},
          {startTime=start_rising_, endTime = totalDuration_, startVal = 0.75, endVal = 0.75}}
    },
    -- periscope etc
    {14, {{startTime=0.0, endTime = start_rising_, startVal = 0.0, endVal = 0.0},
          {startTime=start_rising_, endTime = stop_rising_, startVal = 0.0, endVal = 1.0},
          {startTime=stop_rising_, endTime = totalDuration_, startVal = 1.0, endVal = 1.0}}
    },
    {15, {{startTime=0.0, endTime = start_rising_, startVal = 0.0, endVal = 0.0},
          {startTime=start_rising_, endTime = stop_rising_, startVal = 0.0, endVal = 1.0},
          {startTime=stop_rising_, endTime = totalDuration_, startVal = 1.0, endVal = 1.0}}
    },
    {16, {{startTime=0.0, endTime = start_diving_, startVal = 0.0, endVal = 1.0},
         {startTime=start_diving_, endTime = stop_diving_/3.0, startVal = 0.0, endVal = 1.0},
         {startTime=stop_diving_/3.0, endTime = totalDuration_, startVal = 0.0, endVal = 0.0}}
    },
    {18, {{startTime=0.0, endTime = start_diving_, startVal = 0.0, endVal = 1.0},
         {startTime=start_diving_, endTime = stop_diving_/3.0, startVal = 0.0, endVal = 1.0},
         {startTime=stop_diving_/3.0, endTime = totalDuration_, startVal = 0.0, endVal = 0.0}}
    },
   

}

-- {depth, fx_dx, fx_len, fx_width)
--fx_dx - distance from stern to stern fx position
--fx_len - distance from bow to stern fx
GT.sternEffectDX = {{0.0, 0.0, 70, 5}, {4.5, 40, 20.5, 1.0}, {7.0, 40, 10.2, 1.0}, {9.0, 40, 10, 1}}
GT.WS = {};
GT.WS.maxTargetDetectionRange = 450000;
GT.WS.radar_type = 102;
GT.WS.searchRadarMaxElevation = math.rad(60);
GT.WS.searchRadarFrequencies = {{50.0e6, 54.0e6}, {2.0e9, 2.2e9}}

local ws;

ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_Torpedo84 );
GT.WS[ws].reference_angle_Z = math.rad(5);
GT.WS[ws].canSetTacticalDir = false
GT.WS[ws].LN[1].BR = {
	{connector_name = 'TPO_01', recoilArgument = 177, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
	{connector_name = 'TPO_02', recoilArgument = 178, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
	{connector_name = 'TPO_03', recoilArgument = 179, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
	{connector_name = 'TPO_04', recoilArgument = 180, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
	{connector_name = 'TPO_05', recoilArgument = 181, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
	{connector_name = 'TPO_06', recoilArgument = 182, recoilT0 = -1, recoilT1 = -0.5, recoilT2 = 0.5, recoilTime = 1.0},
}

GT.Name = "santafe"
GT.DisplayName = _("ARA Santa Fe S-21")
GT.Rate = 50

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
};


GT.Singleton      = "no";
GT.mapclasskey    = "P0091000038";

GT.attribute = {
    wsType_Navy, wsType_Ship, wsType_Submarine, WSTYPE_PLACEHOLDER,
    "Submarines",
    "RADAR_BAND1_FOR_ARM",
    "DetectionByAWACS",
};


GT.tags  =
{
	"Submarine",
}
--GT.Countries = {'China', 'Russia', 'Argentina',};
GT.Countries = {'USA', 'Argentina',};
--GT.Countries = {'USA', 'ARG',};
--GT.Countries = {'USA', 'Chile',};
add_surface_unit(GT);