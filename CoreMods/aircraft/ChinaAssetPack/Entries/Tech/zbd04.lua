
mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/zbd04a')

-- ZBD-04A
ZBD04A_chassis = {
    life              = 6,
    mass              = 21500,
    length            = 7.52,
    width             = 2.53,
    max_road_velocity = 22.22,
    max_slope         = 0.7,
    engine_power      = 550,
    canSwim           = true,
    canWade           = true,
    waterline_level   = 1.4,
    max_vert_obstacle = 0.75,
    max_acceleration  = 4.08,
    min_turn_radius   = 2.5,
    X_gear_1          = 1.96,
    Y_gear_1          = 0,
    Z_gear_1          = 1.48,
    X_gear_2          = -2.00,
    Y_gear_2          = 0,
    Z_gear_2          = 1.48,
    gear_type         = GT_t.GEAR_TYPES.TRACKS,
    gear_count        = 6,
    r_max             = 0.2925,
    r_track           = 0.08,
    armour_thickness  = 0.06,
    trace_width       = 0.459,
}

GT = {}
GT_t.ws = 0
set_recursive_metatable(GT, GT_t.generic_track_IFV)
set_recursive_metatable(GT.chassis, ZBD04A_chassis)

GT.visual.shape      = "zbd04a"
GT.visual.shape_dstr = "zbd04a_dstr"

-- Turbine
GT.turbine = false
-- Turbine

--chassis
GT.swing_on_run = false
--GT.toggle_alarm_state_interval = 4.0

--Burning after hit
GT.visual.fire_size   = 0.9 --relative burning size
GT.visual.fire_pos[1] = 1.0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0.762 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time   = 600 --burning time (seconds)

-- see description in GT_t.lua
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_30mm, GT_t.IR_COEFFS_BODY, {0.3, 0.3/1800}}}

GT.visual.min_time_agony       = 3
GT.visual.max_time_agony       = 100
GT.visual.agony_explosion_size = 3

GT.visual.dust_pos    = { 3.0, 0.1, -ZBD04A_chassis.Z_gear_1}
GT.visual.dirt_pos    = {-3.5, 0.8, -ZBD04A_chassis.Z_gear_2}

GT.animation_arguments.stoplights   = 30
GT.animation_arguments.headlights   = 31
GT.animation_arguments.markerlights = 32

GT.IR_emission_coeff = 0.09

GT.sensor = {}
set_recursive_metatable(GT.sensor, GT_t.SN_visual)
GT.sensor.height = 2.45

-- DM
--[[GT.DM = {
    { area_name = "CANNON",             armour = {width=0.400}},
    { area_name = "GUN_MASK",           armour = {width=0.400}},

    { area_name = "TURRET_FRONT",       armour = {width=0.750}},
    { area_name = "TURRET_BACK",        armour = {width=0.040}},
    { area_name = "TURRET_LEFT",        armour = {width=0.220}},
    { area_name = "TURRET_RIGHT",       armour = {width=0.220}},
    { area_name = "TURRET_TOP",         armour = {width=0.020}},

    { area_name = "BODY_FRONT_LOW",     armour = {width=0.060}},
    { area_name = "BODY_FRONT",         armour = {width=0.800}},
    { area_name = "BODY_TOP",           armour = {width=0.800}},
    { area_name = "BODY_LEFT",          armour = {width=0.260}},
    { area_name = "BODY_RIGHT",         armour = {width=0.260}},
    { area_name = "BODY_BACK",          armour = {width=0.040}},

    { area_name = "WHEEL_L_1",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_2",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_3",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_4",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_5",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_6",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_7",          armour = {width=1000.0}},
    { area_name = "WHEEL_L_8",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_1",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_2",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_3",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_4",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_5",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_6",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_7",          armour = {width=1000.0}},
    { area_name = "WHEEL_R_8",          armour = {width=1000.0}},
}]]

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, -0.04, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIRandLLTV"

-- weapon systems

GT.WS = {}
GT.WS.maxTargetDetectionRange = 12000
GT.WS.smoke = {"SMOKE_06", "SMOKE_05", "SMOKE_07", "SMOKE_04", "SMOKE_08", "SMOKE_03", "SMOKE_09", "SMOKE_02", "SMOKE_10", "SMOKE_01",}

local ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER'
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-2), math.rad(60)},
}
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].omegaY = math.rad(40)
GT.WS[ws].omegaZ = math.rad(50)
GT.WS[ws].reference_angle_Z = math.rad(3)
GT.WS[ws].stabilizer = true
GT.WS[ws].laser = true
GT.WS[ws].pointer = 'POINT_SIGHT_01'
GT.WS[ws].cockpit = {"BMP-3/BMP-3_gunner", {0.0, 0.0, 0.0}}

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.PKT) --coaxial machinegun
__LN.distanceMaxForFCS = 2000
__LN.PL[1].ammo_capacity = 2000
__LN.PL[1].portionAmmoCapacity = 2000
__LN.PL[1].reload_time = 600
__LN.PL[1].switch_on_delay = 0.1
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[11])
__LN.beamWidth = math.rad(1)
__LN.BR[1].connector_name = 'POINT_MGUN_01'
__LN.fireAnimationArgument = 45
__LN.secondary = true

--GT.WS[1].LN[2]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.automatic_gun_2A72) --30mm autocannon
__LN.distanceMaxForFCS = 4000
__LN.PL[1].feedSlot = 1
__LN.PL[2].feedSlot = 2
__LN.beamWidth = math.rad(1)
__LN.fireAnimationArgument = 49
__LN.BR = {
    {
        connector_name = 'POINT_GUN_01',
        recoilArgument = 26,
        recoilTime     = 0.1
    }
}
__LN.sightMasterMode = 1
__LN.sightIndicationMode = 1

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.gun_2A70) -- 100mm gun
__LN.distanceMaxForFCS = 4800
__LN.beamWidth = math.rad(1)
__LN.BR = {
    {
        connector_name = 'POINT_GUN',
        recoilArgument = 23,
        recoilTime     = 0.3
    }
}
__LN.sightMasterMode = 1
__LN.sightIndicationMode = 3


--GT.WS[1].LN[4]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t._9M117) -- ATGM
__LN.BR = {
    {
        connector_name = 'POINT_ATGM',
        recoilArgument = 23,
        recoilTime     = 0.3
    }
}
__LN.sightMasterMode = 1
__LN.sightIndicationMode = 4


--GT.WS[2]
ws = GT_t.inc_ws()
GT.WS[ws] = {}
GT.WS[ws].base = 1
GT.WS[ws].center = 'CENTER_PANORAMA'
GT.WS[ws].angles = {
    {math.rad(180),  math.rad(-180),   math.rad(-8), math.rad(30)},
}
GT.WS[ws].drawArgument1 = 25
GT.WS[ws].drawArgument2 = 26
GT.WS[ws].omegaY = math.rad(50)
GT.WS[ws].omegaZ = math.rad(50)
GT.WS[ws].pidY = {p=100,i=0.1,d=12,inn=50,}
GT.WS[ws].pidZ = {p=100,i=0.1,d=12,inn=50,}
--GT.WS[ws].pointer = 'POINT_SIGHT_PANORAMA'
--GT.WS[ws].cockpit = {'CWS/CWS', {0.1, 0.0, 0.0 },}

GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
GT.WS[ws].LN[1].name = "CMD_Periscope"
GT.WS[ws].LN[1].display_name = _("Commander Periscope Sight")
GT.WS[ws].LN[1].type = 103
GT.WS[ws].LN[1].distanceMin = 0
GT.WS[ws].LN[1].distanceMax = 0
GT.WS[ws].LN[1].distanceMaxForFCS = 5000
GT.WS[ws].LN[1].BR = {{connector_name = 'POINT_SIGHT_PANORAMA'}}
GT.WS[ws].LN[1].customViewPoint = { "CWS/CWS", {0.1, 0.0, 0.0} }

--[[
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.PKT)
__LN.name = "CMD_Panorama"
__LN.display_name = _("Commander Panorama Sight")
__LN.type = 10 -- AA machinegun
__LN.distanceMax = 5000
__LN.max_trg_alt = 800
__LN.PL = {{}}
set_recursive_metatable(__LN.PL[1], GT_t.LN_t.machinegun_12_7_M2.PL[1])
__LN.PL[1].ammo_capacity = 0
__LN.PL[1].switch_delay = 1
__LN.BR[1].connector_name = 'POINT_SIGHT_PANORAMA'
__LN.fireAnimationArgument = -1
__LN.sightMasterMode = 1
__LN = nil
]]

GT.Sensors = {
    OPTIC = {
        "TKN-3B day",
        "TKN-3B night",
    },
}

GT.Name             = "ZBD04A"
GT.DisplayName      = _("ZBD-04A")
GT.DisplayNameShort = _("04A")

GT.Rate  = 15
GT.EPLRS = true

GT.DetectionRange = 0
GT.airWeaponDist  = 0
GT.ThreatRange    = GT.WS[1].LN[3].distanceMaxForFCS
GT.mapclasskey    = "P0091000002"
GT.attribute = {
    wsType_Ground, wsType_Tank, wsType_MissGun, WSTYPE_PLACEHOLDER,
    --wsType_Ground, wsType_Tank, wsType_MissGun, wsType_GenericIFV,
    "IFV",
    "ATGM",
    "Datalink"
}
GT.InternalCargo = {
    nominalCapacity = 700,
    maximalCapacity = 700,
}

GT.encyclopediaAnimation = {
    args = {
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

GT.category  = "Armor"
GT.tags      = {
    "Armor",
    "APC",
    "IFV",
}
GT.Countries = {'China'}
add_surface_unit(GT)
GT = nil
