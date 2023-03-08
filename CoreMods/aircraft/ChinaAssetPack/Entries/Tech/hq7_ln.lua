-- SAM HQ-7 LN SP
mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/hq7')


local function InitChassis(gt)

    gt.visual.shape      = "hq7_ln"
    gt.visual.shape_dstr = "hq7_ln_dstr"

    --chassis
    gt.swing_on_run = true
    gt.animation_arguments.locator_rotation = 11
    gt.radar_rotation_period = 1

    gt.animation_arguments.stoplights   = 37
    gt.animation_arguments.headlights   = 38
    gt.animation_arguments.markerlights = 39

    gt.IR_emission_coeff = 0.08

    gt.sensor = {}
    gt.sensor.max_range_finding_target = 15000
    gt.sensor.min_range_finding_target = 200
    gt.sensor.max_alt_finding_target   = 5500
    gt.sensor.min_alt_finding_target   = 10
    gt.sensor.height = 3.675

    --Burning after hit
    gt.visual.fire_size   = 0.8 --relative burning size
    gt.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
    gt.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
    gt.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
    gt.visual.fire_time   = 500 --burning time (seconds)

    gt.visual.min_time_agony       = 5
    gt.visual.max_time_agony       = 120
    gt.visual.agony_explosion_size = 5

    gt.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_Cold_SAM, IR_COEFFS_BODY, {0.2, 0.2/1200}}}

    --[[gt.DM = {
        { area_name = "TURRET_FRONT",       armour = {width=0.3}},
        { area_name = "BODY_FRONT",         armour = {width=0.4}},
    }]]

    return gt
end

local function AddToDataBase(gt)

    gt.encyclopediaAnimation = {
        args = {
            [1]  = 0.3, --
            [3]  = 1.0, --
            [18] = 1.0, --
            [19] = 1.0, --
            [27] = 1.0, --
            [28] = 1.0, --
        }
    }

    gt.shape_table_data =
    {
        {
            file        = gt.visual.shape,
            username    = gt.Name,
            desrt       = gt.visual.shape_dstr,
            classname   = "lLandVehicle",
            positioning = "BYNORMAL",
            life        = gt.chassis.life or 5,
        },
        {
            name  = gt.visual.shape_dstr,
            file  = gt.visual.shape_dstr,
        },
    }
    gt.MaxSpeed = gt.chassis and gt.chassis.max_road_velocity and (gt.chassis.max_road_velocity * 3.6)

    gt.category  = "Air Defence"
    gt.tags      = {
        "Air Defence",
        "Launcher",
    }
    gt.Countries = {'China', 'Pakistan', 'Algeria'}
    add_surface_unit(gt)
    return gt
end

-- TODO: HQ-7
_HQ7 = {}
_HQ7.type = 33
_HQ7.distanceMin = 1000
_HQ7.distanceMax = 12000
_HQ7.reactionTime = 5
_HQ7.launch_delay = 1
_HQ7.radialDisperse = 0.0
_HQ7.dispertionReductionFactor = 0.0
_HQ7.ECM_K = -1
_HQ7.maxShootingSpeed = 0.0
_HQ7.reflection_limit = 0.12
_HQ7.sensor = {}
set_recursive_metatable(_HQ7.sensor, GT_t.WSN_t[0])
_HQ7.barrels_reload_type = BarrelsReloadTypes.SEQUENTIALY
_HQ7.max_number_of_missiles_channels = 1
_HQ7.PL = {}
_HQ7.PL[1] = {}
_HQ7.PL[1].ammo_capacity = 4
_HQ7.PL[1].type_ammunition = HQ_7.wsTypeOfWeapon
_HQ7.PL[1].name_ammunition = _("HQ-7")
_HQ7.PL[1].automaticLoader = false
_HQ7.PL[1].reload_time = 960
_HQ7.PL[1].shot_delay = 0.1
_HQ7.BR = {
    {connector_name = 'POINT_SAM_01', drawArgument = 18},
    {connector_name = 'POINT_SAM_02', drawArgument = 19},
    {connector_name = 'POINT_SAM_03', drawArgument = 27},
    {connector_name = 'POINT_SAM_04', drawArgument = 28},
}


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


---------------------------------
----
---------------------------------

GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_wheel_IFV)
set_recursive_metatable(GT.chassis, HQ7_chassis)

GT = InitChassis(GT)

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = GT.sensor.max_range_finding_target
GT.WS.fire_on_march = false;
GT.WS.radar_type = 104
--GT.WS.radar_rotation_type = 1
GT.WS.searchRadarMaxElevation = math.rad(45)

--
local ws = GT_t.inc_ws();
GT.WS[ws] = {};
local base = ws;
GT.WS[ws].pos = {0, 3.1, 0};
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-5), math.rad(45)},
};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].mount_before_move = true;
GT.WS[ws].omegaY = 0.523599;
GT.WS[ws].omegaZ = math.rad(10);
GT.WS[ws].pidY = {p=40, i=0.1, d=7, inn=4};
GT.WS[ws].reference_angle_Y = math.pi;
GT.WS[ws].LN = {};
GT.WS[ws].LN[1] = {};
GT.WS[ws].LN[1].type = 102;
GT.WS[ws].LN[1].reactionTime = 5;
GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target;
GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target;
GT.WS[ws].LN[1].ECM_K = 0.65;
GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target;
GT.WS[ws].LN[1].min_trg_alt = GT.sensor.min_alt_finding_target;
GT.WS[ws].LN[1].reflection_limit = 0.18;
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].maxShootingSpeed = 0;
GT.WS[ws].LN[1].depends_on_unit = {{{"self", 3}}, {{"HQ-7_STR_SP"}}};

ws = GT_t.inc_ws()
GT.WS[ws] = {}

--[[GT.WS[ws].type = 4
GT.WS[ws].center = "CENTER_TOWER"
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-5), math.rad(45)},
}
--GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(80)
GT.WS[ws].pidY = {p=80, i=1.0, d=10, inn=10}
GT.WS[ws].pidZ = {p=80, i=1.0, d=10, inn=10}
GT.WS[ws].reference_angle_Y = math.pi
GT.WS[ws].stabilizer = true]]

GT.WS[ws].pos = {0, 0, 0};
GT.WS[ws].base = base;
base = ws;
GT.WS[ws].reference_angle_Z = math.rad(2)--math.pi;
GT.WS[ws].angles = {
    {math.rad(2), math.rad(-2), math.rad(-5), math.rad(45)},
};
GT.WS[ws].omegaY = 1;
GT.WS[ws].omegaZ = 1;
GT.WS[ws].pidY = {p=4, i=0.1, d=2, inn=1};
GT.WS[ws].pidZ = {p=4, i=0.1, d=2, inn=1};
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].mount_before_move = true;

__LN = add_launcher(GT.WS[ws], _HQ7)
__LN.depends_on_unit = {{{"self", 1}}, --[[{{"HQ-7_STR_SP"}},]]}
__LN.inclination_correction_upper_limit = math.rad(30.0)
__LN.inclination_correction_bias = math.rad(6.0)
__LN = nil


ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].pos = {0, 0, 0}
GT.WS[ws].base = base
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-5), math.rad(45)},
};
GT.WS[ws].omegaY = 1;
GT.WS[ws].omegaZ = 1;
GT.WS[ws].pidY = {p=10,i=0.1,d=3, inn=3};
GT.WS[ws].pidZ = {p=10,i=0.1,d=3, inn=3};
GT.WS[ws].LN = {};
GT.WS[ws].LN[1] = {};
GT.WS[ws].LN[1].type = 101;
GT.WS[ws].LN[1].reactionTime = 5;
GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
GT.WS[ws].LN[1].distanceMax = GT.sensor.max_range_finding_target;
GT.WS[ws].LN[1].distanceMin = GT.sensor.min_range_finding_target;
GT.WS[ws].LN[1].ECM_K = 0.65;
GT.WS[ws].LN[1].max_trg_alt = GT.sensor.max_alt_finding_target;
GT.WS[ws].LN[1].min_trg_alt = GT.sensor.min_alt_finding_target;
GT.WS[ws].LN[1].beamWidth = math.rad(90);
GT.WS[ws].LN[1].reflection_limit = 0.18;
GT.WS[ws].LN[1].maxShootingSpeed = 0;

--
GT.Name             = "HQ-7_LN_SP"
GT.DisplayName      = _("HQ-7 Self-Propelled LN")
GT.DisplayNameShort = _("HQ7-LN")
GT.Rate             = 20

GT.Sensors = {
    OPTIC = {
        "TKN-3B day",
        "TKN-3B night",
        "Tunguska optic sight"
    },
    RADAR = "HQ-7 TR",
}

GT.DetectionRange = GT.sensor.max_range_finding_target
GT.ThreatRange    = GT.WS[1].LN[1].distanceMax
GT.mapclasskey    = "P0091000081"
GT.attribute = {
    wsType_Ground, wsType_SAM, wsType_Radar_Miss, WSTYPE_PLACEHOLDER, --wsType_GenericIFV,
    "AA_missile",
    "SR SAM",
    "SAM TR",
    "SAM LL",
    "RADAR_BAND1_FOR_ARM",
    "RADAR_BAND2_FOR_ARM",
}

GT = AddToDataBase(GT)
GT = nil

---------------------------------
---- HQ-7 EO homing launcher ----
---------------------------------

GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_wheel_IFV)
set_recursive_metatable(GT.chassis, HQ7_chassis)

GT = InitChassis(GT)
GT.sensor.max_range_finding_target = 8000

GT.driverViewConnectorName = "DRIVER_POINT"
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIRandLLTV"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = GT.sensor.max_range_finding_target
GT.WS.fire_on_march = false;
GT.WS.radar_type = 104
GT.WS.searchRadarMaxElevation = math.rad(45)


ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].type = 4
GT.WS[ws].center = "CENTER_TOWER"
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-5), math.rad(45)},
}
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(80)
GT.WS[ws].pidY = {p=80, i=1.0, d=10, inn=10}
GT.WS[ws].pidZ = {p=80, i=1.0, d=10, inn=10}
GT.WS[ws].reference_angle_Y = math.pi
GT.WS[ws].stabilizer = true
GT.WS[ws].isoviewOffset = {0.0, 3.5, 0.0}
GT.WS[ws].pointer = "POINT_SIGHT_01"
GT.WS[ws].cockpit = {'_1A29/_1A29', {0.0, 0.0, 0.0} }
--GT.WS[ws].PPI_view = "GenericPPI/GenericPPI"


__LN = add_launcher(GT.WS[ws], _HQ7)
__LN.inclination_correction_upper_limit = math.rad(30.0)
__LN.inclination_correction_bias = math.rad(6.0)
__LN.sightMasterMode = 1
__LN.sightIndicationMode = 4


GT.Name             = "HQ-7_LN_EO"
GT.DisplayName      = _("HQ-7 LN Electro-Optics")
GT.DisplayNameShort = _("HQ7-LNE")
GT.Rate             = 20

GT.Sensors = {
    OPTIC = {
        "TKN-3B day",
        "TKN-3B night",
        "Tunguska optic sight"
    },
}

GT.DetectionRange = GT.sensor.max_range_finding_target
GT.ThreatRange    = GT.WS[1].LN[1].distanceMax
GT.mapclasskey    = "P0091000014"
GT.attribute = {
    wsType_Ground, wsType_SAM, wsType_Radar_Miss, WSTYPE_PLACEHOLDER, --wsType_GenericIFV,
    "AA_missile",
    "SR SAM",
    --"SAM SR",
    --"SAM TR",
    --"RADAR_BAND1_FOR_ARM",
}

GT = AddToDataBase(GT)
GT = nil
