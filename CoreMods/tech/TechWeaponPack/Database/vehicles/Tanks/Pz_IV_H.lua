-- Medium Tank Panzerkampfwagen IV Ausf. H

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_tank);
set_recursive_metatable(GT.chassis, GT_t.CH_t.PZ_IV);

GT.armour_scheme = {
						hull_elevation = { {-90, -45, 0.5 }, {-45, 45, 1.0 }, { 45, 90, 0.4 } },
						hull_azimuth = { {0, 33.6, 2.0 }, { 33.6, 180.0, 0.75 } },
						turret_elevation = { {-90,25, 1.0 }, {25,90, 0.4} },
						turret_azimuth = { {0,20, 2.0}, {20,180, 0.75}}
					};

GT.DM = {
	{ area_name = "GUN_MASK", 			armour = {width=0.100}},
	{ area_name = "TURRET_FRONT", 		armour = {width=0.050}},
	{ area_name = "TURRET",				armour = {width=0.030}},
	{ area_name = "TURRET_TOP", 		armour = {width=0.016}},
	{ area_name = "TURRET_COM", 		armour = {width=0.095}},
	{ area_name = "TURRET_COM_TOP",		armour = {width=0.008}},
	{ area_name = "FRONT_01", 			armour = {width=0.080}},
	{ area_name = "FRONT_02", 			armour = {width=0.020}},
	{ area_name = "FRONT_03", 			armour = {width=0.080}},
	{ area_name = "FRONT_04", 			armour = {width=0.030}},
	{ area_name = "BODY_TOP",			armour = {width=0.010}},
	{ area_name = "BODY_BOTTOM",		armour = {width=0.010}},
	{ area_name = "BODY_LEFT", 			armour = {width=0.030}},
	{ area_name = "BODY_LEFT_2", 		armour = {width=0.020}},
	{ area_name = "BODY_RIGHT", 		armour = {width=0.030}},
	{ area_name = "BODY_RIGHT_2", 		armour = {width=0.020}},
	{ area_name = "BODY_BACK", 			armour = {width=0.020}},
	{ area_name = "ENGINE", 			armour = {width=0.010}},
	{ area_name = "COL_MG_02",			armour = {width=0.030}, area_life = 1.0},
	{ area_name = "WHEEL_01_L", 		armour = {width=0.100}},
	{ area_name = "WHEEL_02_L", 		armour = {width=0.050}},
	{ area_name = "WHEEL_03_L", 		armour = {width=0.060}},
	{ area_name = "WHEEL_01_R", 		armour = {width=0.100}},
	{ area_name = "WHEEL_02_R", 		armour = {width=0.050}},
	{ area_name = "WHEEL_03_R", 		armour = {width=0.060}},
	{ area_name = "GUN",		 		armour = {width=1000.0}},
}

GT.visual.shape = "Pz_IV_H";
GT.visual.shape_dstr = "Pz_IV_H_p_1";

GT.IR_emission_coeff = 0.1

GT.animation_arguments.exterior_randomization = 60;
GT.animation_arguments.rollers_rotation = {
										   [12] = 1.0,
										   [14] = 1.0,
										   [61] = 1.6,
										   [62] = 1.6,
										   [63] = 2.69,
										   [64] = 2.69}

--chassis
GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 3.27;

--Burning after hit
GT.visual.fire_size = 0.55; --relative burning size
GT.visual.fire_pos[1] = -1.3; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.3; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 650; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {2.85, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-2.6, 0.2, -GT.chassis.Z_gear_2}

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_100mm, IR_COEFFS_BODY, {0.23, 0.23/1250}}}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.02, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 5000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pointer = 'POINT_SIGHT_01';
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-10), math.rad(20)},
                    };
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].pidY = GT_t.TANK_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.TANK_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(14.6);
GT.WS[ws].omegaZ = math.rad(10);
GT.WS[ws].cockpit = {"TZF_5f/TZF_5f", {0.0, 0.0, 0.0} }

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.KwK40);
__LN.reactionTime = 2;
__LN.PL[1].ammo_capacity = 30;
__LN.PL[1].reload_time = 15 * 30
__LN.PL[1].shot_delay = 7;
__LN.PL[2] = {};
__LN.PL[2].shell_name = {"Pzgr_39/40"};
__LN.PL[2].ammo_capacity = 30;
__LN.PL[2].reload_time = 15 * 30
__LN.PL[2].automaticLoader = false;
__LN.PL[2].shot_delay = 15.0;
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;
__LN.BR[1] = {connector_name = 'POINT_GUN_01',
			recoilArgument = 23,
			recoilTime = 0.5,
			muzzleBrakeType = 2};
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

--GT.WS[1].LN[2]
__LN = add_launcher(GT.WS[ws], __LN); -- HE rounds
__LN.type = 6;
__LN.distanceMin = 300;
__LN.distanceMax = 6000;
__LN.PL[1].ammo_capacity = 8;
__LN.PL[1].reload_time = 15 * 8
__LN.PL[1].shell_name = {"Sprgr_34_L48"};
__LN.PL[2].ammo_capacity = 16;
__LN.PL[2].reload_time = 15 * 16
__LN.PL[2].shell_name = {"Sprgr_34_L48"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_MG34);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[6]);
for i=2,11 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_01';
__LN.fireAnimationArgument = 45;
__LN.secondary = true;

-- WS[2]
ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_MG_02';
GT.WS[ws].pointer = 'POINT_SIGHT_02';
GT.WS[ws].cockpit = {"KZF_2/KZF_2", {0.0, 0.0, 0.0} }
GT.WS[ws].area = "COL_MG_02";
GT.WS[ws].angles = {
                    {math.rad(20), math.rad(-20), math.rad(-10), math.rad(20)},
                    };
GT.WS[ws].drawArgument1 = 24;
GT.WS[ws].drawArgument2 = 25;
GT.WS[ws].pidY = GT_t.MG_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MG_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(60);
GT.WS[ws].omegaZ = math.rad(60);

--GT.WS[2].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_MG34);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[2]);
for i=2,16 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_02';
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

GT.Name = "Pz_IV_H";
GT.DisplayName = _("MT Pz.Kpfw.IV Ausf.H");
GT.DisplayNameShort = _("Pz.IV");
GT.Rate = 20;

GT.Sensors = { OPTIC = {"TRP-2A day", "TRP-2A night"}, };

GT.DetectionRange  = 0;
GT.airWeaponDist = 0
GT.ThreatRange =  GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000001";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun,wsType_GenericTank,
                "Tanks",
                "Old Tanks",
                };
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"Tank",
}
GT.Countries = AXIS