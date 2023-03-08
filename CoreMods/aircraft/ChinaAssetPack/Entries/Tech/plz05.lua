
mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/plz05')

-- PLZ-05
PLZ05_chassis = {
    life              = 4,
    mass              = 35000,
    length            = 11.6,
    width             = 3.38,
    max_road_velocity = 15.55,
    max_slope         = 0.6,
    engine_power      = 800,
    canSwim           = false,
    canCrossRiver     = false,
    waterline_level   = 1.4,
    max_vert_obstacle = 0.75,
    max_acceleration  = 3.08,
    min_turn_radius   = 2.5,
    X_gear_1          = 2.46,
    Y_gear_1          = 0,
    Z_gear_1          = 1.48,
    X_gear_2          = -2.35,
    Y_gear_2          = 0,
    Z_gear_2          = 1.48,
    gear_type         = GT_t.GEAR_TYPES.TRACKS,
    gear_count        = 6,
    r_max             = 0.44,
    r_track           = 0.08,
    armour_thickness  = 0.012,
    trace_width       = 0.539,
}


-- PLZ-05
GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_track_vehicle)
set_recursive_metatable(GT.chassis, PLZ05_chassis)

GT.armour_scheme = {
    hull_elevation   = { {-90,11,0.8}, {11,40,1}, {40,90,0.9}, },
    hull_azimuth     = { {0,15,1.5}, {15,160,1.0}, {160,180,0.7}},
    turret_elevation = { {-90,40,1}, {40,90,0.7}},
    turret_azimuth   = { {0,180,1.0}}
}

GT.visual.shape      = "plz05"
GT.visual.shape_dstr = "plz05_dstr"


--chassis
GT.swing_on_run                = false
GT.toggle_alarm_state_interval = 4

GT.animation_arguments.stoplights   = 30
GT.animation_arguments.headlights   = 31
--GT.animation_arguments.markerlights = 32

GT.IR_emission_coeff = 0.10

-- visual
GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 3.55

--Burning after hit
GT.visual.fire_size   = 1.1 --relative burning size
GT.visual.fire_pos[1] = 1.0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time   = 600 --burning time (seconds)

GT.visual.min_time_agony       = 5
GT.visual.max_time_agony       = 120
GT.visual.agony_explosion_size = 5

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_152mm, IR_COEFFS_BODY, {0.3, 0.3/1800}}}

GT.visual.dust_pos    = { 3.57, 0.03, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos    = {-2.90, 0.50, -GT.chassis.Z_gear_2}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIRandLLTV"

-- weapon systems
--GT.WS[1]
GT.WS = {}
GT.WS.maxTargetDetectionRange = 5000
GT.WS.smoke = {"SMOKE_04", "SMOKE_08", "SMOKE_03", "SMOKE_07", "SMOKE_02", "SMOKE_06", "SMOKE_01", "SMOKE_05"}
GT.WS.fire_on_march = false

local ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-4), math.rad(68)},
}
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].mount_before_move = true
GT.WS[ws].omegaY = math.rad(22)
GT.WS[ws].omegaZ = math.rad(14)
GT.WS[ws].pidY = {p=30, i=0.0, d=9, inn=2}
GT.WS[ws].pidZ = {p=30, i=0.0, d=9, inn=2}
GT.WS[ws].isoviewOffset = {0.0, 3.8, 0.0}
GT.WS[ws].pointer = 'POINT_SIGHT_02'
GT.WS[ws].cockpit = {"genericHowitzer", {0.1, 0.0, 0.0}}

--GT.WS[1].LN[1]

howitzer_155 = {} -- 155mm for PLZ-05
howitzer_155.type = 6
howitzer_155.xc = 0.608
howitzer_155.distanceMin = 60
howitzer_155.max_trg_alt = 5000
howitzer_155.reactionTimeLOFAC = 3
howitzer_155.reactionTime = 40
howitzer_155.maxShootingSpeed = 0
howitzer_155.sensor = {}
set_recursive_metatable(howitzer_155.sensor, GT_t.WSN_t[8])
howitzer_155.PL = {}
howitzer_155.PL[1] = {}
howitzer_155.PL[1].ammo_capacity = 20
howitzer_155.PL[1].shell_name = {"PLZ_155_HE"}
howitzer_155.PL[1].shot_delay = 6
howitzer_155.PL[1].reload_time = howitzer_155.PL[1].ammo_capacity * 24
howitzer_155.PL[1].automaticLoader = false
howitzer_155.PL[2] = {}
howitzer_155.PL[2].ammo_capacity = 30
howitzer_155.PL[2].shell_name = {"PLZ_155_HE"}
howitzer_155.PL[2].shot_delay = 6
howitzer_155.PL[2].reload_time = howitzer_155.PL[2].ammo_capacity * 20
howitzer_155.PL[2].automaticLoader = false
howitzer_155.BR = { {pos = {8.7, 0 ,0} } }


__LN = add_launcher(GT.WS[ws], howitzer_155)
__LN.sightMasterMode     = 1
__LN.sightIndicationMode = 1

__LN.BR[1] = {
    connector_name = 'POINT_GUN',
    recoilArgument = 23,
    recoilTime     = 0.5
}

--GT.WS[2]
ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].base = 1
GT.WS[ws].center = 'CENTER_MGUN'
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-3), math.rad(70)},
}
GT.WS[ws].drawArgument1 = 25
GT.WS[ws].drawArgument2 = 26
GT.WS[ws].omegaY = math.rad(50)
GT.WS[ws].omegaZ = math.rad(50)
GT.WS[ws].pidY = {p=10, i=0.1, d=4, inn=3}
GT.WS[ws].pidZ = {p=10, i=0.1, d=4, inn=3}
GT.WS[ws].reference_angle_Y = 0
GT.WS[ws].reference_angle_Z = 0

--GT.WS[2].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_utes)
__LN.type = 10 -- AA Machinegun
__LN.reactionTime = 0.5
__LN.BR[1].connector_name = 'POINT_MGUN'
__LN.fireAnimationArgument = 44
__LN.customViewPoint = { "PZU-7/PZU-7", {-1.9, 0.1, 0 }, }
__LN = nil


GT.Name        = "PLZ05"
GT.DisplayName = _("PLZ-05")

GT.Rate  = 15
GT.EPLRS = true

GT.Sensors = {
    OPTIC = {
        "TKN-3B day", "TKN-3B night",
	}
}

GT.DetectionRange = 0
GT.ThreatRangeMin = GT.WS[1].LN[1].distanceMin
GT.ThreatRange    = 23500
GT.mapclasskey    = "P0091000006"
GT.attribute      = {
    --wsType_Ground, wsType_Tank, wsType_Gun, wsType_GenericSAU,
    wsType_Ground, wsType_Tank, wsType_Gun, WSTYPE_PLACEHOLDER,
    "Artillery",
}

GT.encyclopediaAnimation = {
    args = {
        [0]  = 0.2, --
        [1]  = 0.2, --
        [3]  = 1.0, --
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

GT.category  = "Artillery"
GT.tags      = {
    "Artillery",
    "SPA",
}
GT.Countries = {'China'}
add_surface_unit(GT)
GT = nil
