-- MBT Type 59

mount_vfs_texture_path (current_mod_path .. '/Textures/Vehicles/ztz59')

Type59_chassis = {
    life              = 18,
    mass              = 36000,
    length            = 9,
    width             = 3.27,
    max_road_velocity = 12,
    max_slope         = 0.27,
    fordingDepth      = 1.4,
    engine_power      = 580,
    max_vert_obstacle = 0.5,
    max_acceleration  = 1.85185,
    min_turn_radius   = 3,
    X_gear_1          = 2.062,
    Y_gear_1          = 0,
    Z_gear_1          = 1.3,
    X_gear_2          = -1.9,
    Y_gear_2          = 0,
    Z_gear_2          = 1.3,
    gear_type         = GT_t.GEAR_TYPES.TRACKS,
    r_max             = 0.42,
    r_track           = 0.08,
    armour_thickness  = 0.100,
    trace_width       = 0.539,
}

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_tank);
set_recursive_metatable(GT.chassis, Type59_chassis);

GT.armour_scheme = {
    hull_elevation   = { {-90, -45, 0.2 }, {-45, 30, 0.8 }, { 30, 90, 0.4 }, },
    hull_azimuth     = { {0, 30, 1.2 }, { 30, 150, 1 }, { 150,180, 0.56 }, },
    turret_elevation = { {-90,23, 1.0}, { 23,90, 0.2 }, },
    turret_azimuth   = { {0,30,2.0}, {30,150,1.6}, {150,180,0.65}, },
};

GT.visual.shape = "ztz59";
GT.visual.shape_dstr = "ztz59_dstr";

GT.IR_emission_coeff = 0.1

-- Turbine
GT.turbine = false;
-- Turbine

-- Crew

GT.crew_locale = "CHN";
GT.crew_members = {"gunner"};

-- Crew

--chassis
GT.swing_on_run = false;


GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.723;

--Burning after hit
GT.visual.fire_size = 0.8; --relative burning size
GT.visual.fire_pos[1] = -0.7; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.1; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 750; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 70;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {2.9, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-2.8, 0.5, -GT.chassis.Z_gear_2}

-- see description in GT_t.lua
GT.visual.IR = {
    coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_100mm, IR_COEFFS_BODY, {0.29, 0.29/1400}}
}

GT.driverViewConnectorName = {"PNT_DRIVER", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 6000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].angles = {
    {math.rad(180), math.rad(-180), math.rad(-4), math.rad(17)},
};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].omegaY = math.rad(17);
GT.WS[ws].omegaZ = math.rad(10);
GT.WS[ws].stabilizer = true;
GT.WS[ws].pointer = "PNT_SIGHT_1";
GT.WS[ws].cockpit = {'TSh2B-32P/TSh2B-32P', {0.1, 0.0, 0.0}}

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.tank_gun_105mm); -- temporary, to fix, must be 100mm D-10T2C cannon
__LN.PL[1].ammo_capacity = 6;
__LN.PL[1].reload_time = 15 * 6
__LN.PL[1].shot_delay = 8.5;
__LN.PL[1].shell_name = {"3UBM11_100mm_AP"};
__LN.BR[1] = {
    connector_name = 'PNT_CANNON',
	recoilArgument = 23,
	recoilTime = 0.5
};
__LN.PL[2] = {};
__LN.PL[2].ammo_capacity = 26;
__LN.PL[2].reload_time = 15 * 26
__LN.PL[2].automaticLoader = false;
__LN.PL[2].shot_delay = 13.5;
__LN.PL[2].shell_name = {"3UBM11_100mm_AP"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

--GT.WS[1].LN[2]
__LN = add_launcher(GT.WS[ws], __LN); -- HE rounds
__LN.type = 6;
__LN.distanceMin = 20;
__LN.distanceMax = 8000;
__LN.PL[1].ammo_capacity = 2;
__LN.PL[1].reload_time = 15 * 2
__LN.PL[1].shot_delay = 8.5;
__LN.PL[1].shell_name = {"UOF412_100HE"};
__LN.PL[2].ammo_capacity = 9;
__LN.PL[2].reload_time = 15 * 9
__LN.PL[2].shot_delay = 13.5;
__LN.PL[2].shell_name = {"UOF412_100HE"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.PKT);-- coaxial
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[6]);
__LN.secondary = true;
for i=2,11 do
    __LN.PL[i] = {};
    set_recursive_metatable(__LN.PL[i], __LN.PL[1]);
end;
__LN.BR[1].connector_name = 'PNT_MGUN_COAX';
__LN.fireAnimationArgument = 45;

--
ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].base = 1;
GT.WS[ws].center = 'CENTER_MGUN';
GT.WS[ws].angles = {
    {math.rad(180), math.rad(86), math.rad(-8), math.rad(40)},
    {math.rad(86), math.rad(59), math.rad(20), math.rad(40)},
    {math.rad(59), math.rad(-180), math.rad(-8), math.rad(40)},
};
GT.WS[ws].drawArgument1 = 25;
GT.WS[ws].drawArgument2 = 26;
GT.WS[ws].omegaY = math.rad(40);
GT.WS[ws].omegaZ = math.rad(30);
GT.WS[ws].pidY = {p=60,i=0.1,d=8,inn=5.5,};
GT.WS[ws].pidZ = {p=60,i=0.1,d=8,inn=5.5,};
GT.WS[ws].reference_angle_Y = math.pi;

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_utes);
__LN.type = 10; -- AA Machinegun
__LN.BR[1].connector_name = 'PNT_MGUN';
__LN.fireAnimationArgument = 44;
__LN.customViewPoint = { "genericAAA", {-2.0, 0.2, 0 }, };
__LN = nil;


-------
GT.Name             = "TYPE-59";
GT.DisplayName      = _("MT Type 59");
GT.DisplayNameShort = _("MT59");
GT.Rate             = 10;

GT.Sensors = {
    OPTIC = {
        "TPKU-2B", "TPN1",
    },
};

GT.DetectionRange  = 0;
GT.airWeaponDist   = GT.WS[2].LN[1].distanceMax;
GT.ThreatRange     = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey     = "P0091000001";
GT.attribute       = {
    wsType_Ground,wsType_Tank,wsType_Gun,wsType_GenericTank,
    "Tanks",
    "Old Tanks",
};

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

GT.category = "Armor";
GT.tags =
{
    "Armor",
    "MBT",
}
GT.Countries = {'China'}
add_surface_unit(GT)
GT = nil
