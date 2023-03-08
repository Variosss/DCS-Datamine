
mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/ztz96b')

-- MBT 96B
ZTZ96B_chassis = {
    life              = 25,
    mass              = 42000,
    length            = 10.65,
    width             = 3.3,
    max_road_velocity = 18.05,
    max_slope         = 0.56,
    engine_power      = 1000,
    gear_count        = 6,
    canSwim           = false,
    canWade           = true,
    fordingDepth      = 1.2,
    max_vert_obstacle = 0.8,
    max_acceleration  = 2.1,
    min_turn_radius   = 3,
    X_gear_1          = 2.48,
    Y_gear_1          = 0,
    Z_gear_1          = 1.57,
    X_gear_2          = -2.39,
    Y_gear_2          = 0,
    Z_gear_2          = 1.57,
    gear_type         = GT_t.GEAR_TYPES.TRACKS,
    r_max             = 0.38,
    r_track           = 0.08,
    armour_thickness  = 0.12,
    trace_width       = 0.539,
}

GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_tank)
set_recursive_metatable(GT.chassis, ZTZ96B_chassis)

GT.visual.shape      = "ztz96b"
GT.visual.shape_dstr = "ztz96b_dstr"

--GT.CustomAimPoint = {0,1.3,0}

-- Turbine
GT.turbine = false
-- Turbine

-- Sound
GT.sound = {}

-- Engine params
GT.sound.engine = {}
GT.sound.engine.idle = "GndTech/WarriorEngineIdle"
GT.sound.engine.max  = "GndTech/WarriorEngineMax"

GT.sound.engine.acc_start = "GndTech/WarriorEngineAccStart"
GT.sound.engine.acc_end   = "GndTech/WarriorEngineAccEnd"

GT.sound.engine.idle_formula_gain  = "0.2 x * 1 +"
GT.sound.engine.idle_formula_pitch = "1.2436 x * 0.7564 +"

GT.sound.engine.max_formula_gain  = "0.9 x * 0.1 +"
GT.sound.engine.max_formula_pitch = "0.4363 x * 0.5637 +"
-- Engine params

-- Move params
GT.sound.move = {}
GT.sound.move.sound = "GndTech/TankMoveLight"
GT.sound.move.pitch = {{0.0, 0.6}, {10.0, 1.2}}
GT.sound.move.gain  = {{0.0, 0.01}, {0.5, 0.5}, {12.0, 0.9}}
-- Move params

GT.sound.noise = {}
GT.sound.noise.sound = "Damage/VehHit"

-- Crew
GT.crew_locale  = "ENG"
GT.crew_members = {"commander", "gunner"}

--chassis
GT.swing_on_run = false
GT.toggle_alarm_state_interval = 4.0

-- DM
GT.DM = {
-- boxes
    { area_name = "CANNON",             armour = {width=0.400}},
    { area_name = "GUN_MASK",           armour = {width=0.400}},

    { area_name = "TURRET_FRONT",       armour = {width=0.600}},
    { area_name = "TURRET_BACK",        armour = {width=0.040}},
    { area_name = "TURRET_LEFT",        armour = {width=0.200}},
    { area_name = "TURRET_RIGHT",       armour = {width=0.200}},
    { area_name = "TURRET_TOP",         armour = {width=0.020}},

    { area_name = "BODY",               armour = {width=0.160}},
    { area_name = "BODY_FRONT_UP",      armour = {width=0.600}},
    { area_name = "BODY_FRONT_DOWN",    armour = {width=0.200}},
    --{ area_name = "BODY_TOP",         armour = {width=0.800}},
    --{ area_name = "BODY_TOP_L",       armour = {width=0.800}},
    --{ area_name = "BODY_TOP_R",       armour = {width=0.800}},
    { area_name = "BODY_LEFT",          armour = {width=0.100}},
    { area_name = "BODY_RIGHT",         armour = {width=0.100}},
    { area_name = "BODY_BACK",          armour = {width=0.040}},

    { area_name = "WHEEL_L_1",          armour = {width=0.160}},
    { area_name = "WHEEL_L_2",          armour = {width=0.160}},
    { area_name = "WHEEL_L_3",          armour = {width=0.160}},
    { area_name = "WHEEL_L_4",          armour = {width=0.160}},
    { area_name = "WHEEL_L_5",          armour = {width=0.160}},
    { area_name = "WHEEL_L_6",          armour = {width=0.160}},
    { area_name = "WHEEL_L_7",          armour = {width=0.160}},
    { area_name = "WHEEL_L_8",          armour = {width=0.160}},
    { area_name = "WHEEL_R_1",          armour = {width=0.160}},
    { area_name = "WHEEL_R_2",          armour = {width=0.160}},
    { area_name = "WHEEL_R_3",          armour = {width=0.160}},
    { area_name = "WHEEL_R_4",          armour = {width=0.160}},
    { area_name = "WHEEL_R_5",          armour = {width=0.160}},
    { area_name = "WHEEL_R_6",          armour = {width=0.160}},
    { area_name = "WHEEL_R_7",          armour = {width=0.160}},
    { area_name = "WHEEL_R_8",          armour = {width=0.160}},
}

--Burning after hit
GT.visual.fire_size   = 0.9 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time   = 800 --burning time (seconds)

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_120mm, IR_COEFFS_BODY, {0.29, 0.29/1700}}}

GT.visual.min_time_agony       = 10
GT.visual.max_time_agony       = 130
GT.visual.agony_explosion_size = 5

GT.visual.dust_pos    = {ZTZ96B_chassis.X_gear_1, 0.0, -ZTZ96B_chassis.Z_gear_1}
GT.visual.dirt_pos    = {ZTZ96B_chassis.X_gear_2, 0.6, -ZTZ96B_chassis.Z_gear_2}

GT.animation_arguments.stoplights   = 30
GT.animation_arguments.headlights   = 31
GT.animation_arguments.markerlights = 32

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, 0.00, 0.00}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIRandLLTV"

GT.IR_emission_coeff = 0.12

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 2.58

-- weapon systems
GT.WS = {}
GT.WS.maxTargetDetectionRange = 5500
GT.WS.smoke = {"PNT_SMOKE1", "PNT_SMOKE2","PNT_SMOKE3","PNT_SMOKE4","PNT_SMOKE5","PNT_SMOKE6","PNT_SMOKE7","PNT_SMOKE8","PNT_SMOKE9","PNT_SMOKE10","PNT_SMOKE11","PNT_SMOKE12",}

local ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].angles = {
    {math.rad(135), math.rad(-135), math.rad(-6), math.rad(13.5)},
    {math.rad(-135), math.rad(135), math.rad(-2), math.rad(13.5)},
}
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(42)
GT.WS[ws].omegaZ = math.rad(42)

GT.WS[ws].pidY = {p=100, i=0.0, d=14.0, inn = 10}
GT.WS[ws].pidZ = {p=100, i=0.0, d=14.0, inn = 10}
GT.WS[ws].pointer = "PNT_SIGHT_1"
GT.WS[ws].cockpit = {'GPS/GPS', {0.0, 0.0, 0.0 }}
GT.WS[ws].stabilizer = true
GT.WS[ws].laser = true

-- Ammunition: 22 armor piercing, 6 missiles, 14 HE rounds - 42 rounds total

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.tank_gun_2A46)
__LN.distanceMaxForFCS  = 5000
__LN.combatRange        = 1200
__LN.PL[1].virtualStwID = 1
__LN.PL[1].shell_name   = {"ZTZ_125_AP"}
__LN.PL[2].virtualStwID = 2
__LN.PL[2].shell_name   = {"ZTZ_125_AP"}
__LN.beamWidth          = math.rad(1)
__LN.BR[1] = {
    connector_name = 'PNT_CANNON',
    recoilArgument = 23,
    recoilTime     = 0.5
}
__LN.sightMasterMode     = 1
__LN.sightIndicationMode = 1

--GT.WS[1].LN[2] - 125mm D-81 gun
__LN = add_launcher(GT.WS[ws], __LN)
__LN.type                = 2
__LN.distanceMin         = 100
__LN.distanceMax         = 4000
__LN.distanceMaxForFCS   = 4000
__LN.combatRange         = 800
__LN.PL[1].ammo_capacity = 7
__LN.PL[1].reload_time   = 20 * 7
__LN.PL[1].shot_delay    = 6
__LN.PL[1].shell_name    = {"ZTZ_125_HE"}
__LN.PL[1].virtualStwID  = 1
__LN.PL[2].ammo_capacity = 10
__LN.PL[2].reload_time   = 15 * 10
__LN.PL[2].shot_delay    = 30
__LN.PL[2].shell_name    = {"ZTZ_125_HE"}
__LN.PL[2].virtualStwID  = 2
__LN.sightMasterMode     = 1
__LN.sightIndicationMode = 2

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.Reflex) -- ATGM
__LN.PL[1].virtualStwID  = 1
__LN.PL[2].virtualStwID  = 2
__LN.sightMasterMode     = 1
__LN.sightIndicationMode = 4
__LN.BR = {
    [1] = {
        connector_name = 'PNT_CANNON',
        recoilArgument = 23,
        recoilTime     = 0.5
    },
}

--GT.WS[1].LN[4]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_7_62) -- coaxial
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[7])
__LN.secondary = true
__LN.beamWidth = math.rad(1)
__LN.PL[1].ammo_capacity   = 250
__LN.PL[1].switch_on_delay = 12
for i=2,8 do
    __LN.PL[i] = {}
    set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name  = 'PNT_MGUN_COAX'
__LN.fireAnimationArgument = 45
__LN.sightMasterMode       = 1
__LN.sightIndicationMode   = 3

-- 高机
ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].base = 1
GT.WS[ws].center = 'CENTER_MGUN'
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-8), math.rad(63)},
}
GT.WS[ws].drawArgument1 = 25
GT.WS[ws].drawArgument2 = 26
GT.WS[ws].omegaY = math.rad(80)
GT.WS[ws].omegaZ = math.rad(60)
GT.WS[ws].pidY = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].pidZ = {p=100,i=0.1,d=12,inn=50,}

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_utes)
__LN.type = 10 -- AA machinegun
__LN.PL = {{}, {}}
set_recursive_metatable(__LN.PL[1], GT_t.LN_t.machinegun_12_7_utes.PL[1])
__LN.PL[1].ammo_capacity = 150
__LN.PL[1].switch_delay  = 15
set_recursive_metatable(__LN.PL[2], __LN.PL[1])
__LN.BR[1].connector_name = 'PNT_MGUN'
__LN.fireAnimationArgument = 44
__LN.customViewPoint = { "CWS/CWS", {-1.6, 0.19, -0.06} }

GT.WS[ws].LN[2] = {}
__LN = GT.WS[ws].LN[2]
__LN.name = "CMD_Periscope"
__LN.display_name = _("Commander Periscope Sight")
__LN.type = 103
__LN.distanceMin = 0
__LN.distanceMax = 0
__LN.distanceMaxForFCS = 5000
__LN.BR = {{connector_name = 'PNT_SIGHT_CMD'}}
__LN.customViewPoint = { "CWS/CWS", {0.1, 0.0, 0.0} }

GT.Name             = "ZTZ96B"
GT.DisplayName      = _("ZTZ-96B")
GT.DisplayNameShort = _("96B")
GT.Rate             = 17

GT.Sensors = {
    OPTIC = {
        "CITV day", "CITV night",
    },
}

GT.DetectionRange = 0
GT.airWeaponDist  = 3500
GT.ThreatRange    = 5000

GT.EPLRS = true

GT.mapclasskey = "P0091000001"
GT.attribute = {
    wsType_Ground, wsType_Tank, wsType_Gun, WSTYPE_PLACEHOLDER,
    --wsType_Ground, wsType_Tank, wsType_Gun, wsType_GenericTank,
    "Tanks",
    "Modern Tanks",
    "Datalink",
    --"CustomAimPoint",
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

GT.category  = "Armor"
GT.tags      = {
    "Armor",
    "MBT",
}
GT.Countries = {'China'}
add_surface_unit(GT)
GT = nil
