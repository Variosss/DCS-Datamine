-- SAM HQ-7 LN SP
mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/hq7')

HQ7_chassis = {
    life              = 2,
    mass              = 13600,
    length            = 7.540,
    width             = 3.3,
    max_road_velocity = 22,
    canSwim           = false,
    waterline_level   = 0.8,
    max_slope         = 0.6,
    engine_power      = 260,
    max_vert_obstacle = 0.5,
    max_acceleration  = 0.925926,
    min_turn_radius   = 7,
    X_gear_1          = 2.9,
    Y_gear_1          = 0,
    Z_gear_1          = 1.2,
    X_gear_2          = -2.4,
    Y_gear_2          = 0,
    Z_gear_2          = 1.2,
    gear_type         = GT_t.GEAR_TYPES.WHEELS,
    r_max             = 0.56,
    armour_thickness  = 0.015,
    trace_width       = 0.343,
}


GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_wheel_IFV)
set_recursive_metatable(GT.chassis, HQ7_chassis)

GT.visual.shape      = "hq7_str"
GT.visual.shape_dstr = "hq7_str_dstr"

--chassis
GT.swing_on_run = true
GT.animation_arguments.locator_rotation = 11
GT.radar_rotation_period = 1
GT.snd.radarRotation = "GndTech/RadarRotation"

GT.animation_arguments.stoplights   = 37
GT.animation_arguments.headlights   = 38
GT.animation_arguments.markerlights = 39

GT.IR_emission_coeff = 0.08

GT.sensor = {}
GT.sensor.max_range_finding_target = 30000
GT.sensor.min_range_finding_target = 200
GT.sensor.max_alt_finding_target   = 5500
GT.sensor.min_alt_finding_target   = 15
GT.sensor.height = 3.675

--Burning after hit
GT.visual.fire_size   = 0.8 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time   = 500 --burning time (seconds)

GT.visual.min_time_agony       = 5
GT.visual.max_time_agony       = 120
GT.visual.agony_explosion_size = 5

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_ENGINE_Radar, GT_t.IR_COEFFS_BODY, {0.2, 0.2/1200}}}


--[[GT.DM = {
    { area_name = "TURRET_FRONT",       armour = {width=0.3}},
    { area_name = "BODY_FRONT",         armour = {width=0.4}},
}]]

GT.driverViewConnectorName = "DRIVER_POINT"
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIRandLLTV"

-- weapon systems

local reflect_limit_share = 0.12

GT.WS = {}
GT.WS.radar_type = 103
GT.WS.radar_rotation_type = 1
--GT.WS.searchRadarMaxElevation = math.rad(60)
GT.WS.maxTargetDetectionRange = GT.sensor.max_range_finding_target

-- 1st for AI LN
local ws = 0

for i = 1,10 do
    ws = GT_t.inc_ws()
    GT.WS[ws] = {}
    --GT.WS[ws].newZ = GT_t.ANGLE_Z_TRANSLATION_OPTIONS.TRANSLATE_MAX_ANGLE_TO_ONE
    GT.WS[ws].pos = {0,5,0}
    GT.WS[ws].angles = {
        {math.rad(180), math.rad(-180), math.rad(0), math.rad(60)},
    }
    GT.WS[ws].drawArgument1 = 0
    GT.WS[ws].mount_before_move = true
    GT.WS[ws].omegaY = math.rad(30)
    GT.WS[ws].omegaZ = math.rad(30)
    GT.WS[ws].pidY = {p=40, i=0.1, d=8, inn=5}
    GT.WS[ws].pidZ = {p=80, i=0.1, d=9, inn=10}

    GT.WS[ws].LN = {}
    GT.WS[ws].LN[1] = {}
    GT.WS[ws].LN[1].type = 101
    GT.WS[ws].LN[1].reactionTime = 10
    GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target
    GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target
    GT.WS[ws].LN[1].ECM_K = 0.03
    GT.WS[ws].LN[1].min_trg_alt = GT.sensor.min_alt_finding_target
    GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target
    --GT.WS[ws].LN[1].max_number_of_missiles_channels = 4
    --GT.WS[ws].LN[1].beamWidth = math.rad(90)
    GT.WS[ws].LN[1].reflection_limit = reflect_limit_share
    GT.WS[ws].LN[1].maxShootingSpeed = 0
end

GT.Name             = "HQ-7_STR_SP"
GT.DisplayName      = _("HQ-7 Self-Propelled STR")
GT.DisplayNameShort = _("HQ7-STR")
GT.Rate             = 10

GT.Sensors = {
    RADAR = "HQ-7 SR",
}

GT.DetectionRange = GT.sensor.max_range_finding_target
GT.ThreatRange = 0
GT.mapclasskey = "P0091000083"
GT.attribute = {
    wsType_Ground, wsType_SAM, wsType_Radar, WSTYPE_PLACEHOLDER, --wsType_GenericIFV,
    "SR SAM",
    "SAM SR",
    "RADAR_BAND1_FOR_ARM",
}

GT.encyclopediaAnimation = {
    args = {
        [3]  = 1.0, --
        [11] = 1.0, --
    }
}

GT.shape_table_data =
{
    {
        file        = GT.visual.shape,
        username    = GT.Name,
        desrt       = GT.visual.shape_dstr,
        classname   = "lLandVehicle",
        positioning = "BYNORMAL",
        life        = GT.chassis.life or 5,
    },
    {
        name  = GT.visual.shape_dstr,
        file  = GT.visual.shape_dstr,
    },
}
GT.MaxSpeed = GT.chassis and GT.chassis.max_road_velocity and (GT.chassis.max_road_velocity * 3.6)

GT.category  = "Air Defence"
GT.tags      = {
    "Air Defence",
    "Search Radar",
}
GT.Countries = {'China', 'Pakistan', 'Algeria'}
add_surface_unit(GT)
GT = nil
