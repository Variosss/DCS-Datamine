-- Medium Tank M4 Sherman

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_tank);
set_recursive_metatable(GT.chassis, GT_t.CH_t.M4_SHERMAN);

GT.visual.shape = "M4_Sherman";
GT.visual.shape_dstr = "M4_Sherman_p_1";

GT.IR_emission_coeff = 0.1

GT.animation_arguments.rollers_rotation = {
										   [12] = 1.0,
										   [14] = 1.0,
										   [63] = 2.69,
										   [64] = 2.69}

GT.armour_scheme = {
						hull_elevation = { {-90, -45, 0.5 }, {-45, 30, 1.0 }, { 30, 90, 0.4 } },
						hull_azimuth = { {0, 30, 2.0 }, { 30, 180.0, 1.09 } },
						turret_elevation = { {-90,25, 1.5 }, {25,90, 0.4} },
						turret_azimuth = { {0,20, 1.69}, {20,168, 1.42}, {168,180, 1.0},}
					};

GT.DM = {
	{ area_name = "GUN_MASK", 			armour = {width=0.089}},
	{ area_name = "TURRET_FRONT", 		armour = {width=0.076}},
	{ area_name = "TURRET_LEFT",		armour = {width=0.051}},
	{ area_name = "TURRET_RIGHT",		armour = {width=0.051}},
	{ area_name = "TURRET_TOP", 		armour = {width=0.025}},
	{ area_name = "TURRET_BACK", 		armour = {width=0.065}},
	{ area_name = "FRONT_01", 			armour = {width=0.050}},
	{ area_name = "FRONT_02", 			armour = {width=0.050}},
	{ area_name = "COL_LUK1", 			armour = {width=0.050}},
	{ area_name = "COL_LUK1_FRONT",		armour = {width=0.080}},
	{ area_name = "COL_LUK1_TOP",		armour = {width=0.019}},
	{ area_name = "COL_LUK2", 			armour = {width=0.050}},
	{ area_name = "COL_LUK2_FRONT",		armour = {width=0.080}},
	{ area_name = "COL_LUK2_TOP",		armour = {width=0.019}},
	{ area_name = "COL_MG_02",			armour = {width=0.030}},
	{ area_name = "BODY_TOP",			armour = {width=0.019}},
	{ area_name = "BODY_BOTTOM",		armour = {width=0.015}},
	{ area_name = "BODY_LEFT", 			armour = {width=0.038}},
	{ area_name = "BODY_UPPER_LEFT", 	armour = {width=0.038}},
	{ area_name = "BODY_UPPER_LEFT_2", 	armour = {width=0.019}},
	{ area_name = "ADD_ARMOR_L_1",	 	armour = {width=0.063}},
	{ area_name = "BODY_RIGHT", 		armour = {width=0.038}},
	{ area_name = "BODY_UPPER_RIGHT",	armour = {width=0.038}},
	{ area_name = "BODY_UPPER_RIGHT_2",	armour = {width=0.019}},
	{ area_name = "ADD_ARMOR_R_1",	 	armour = {width=0.063}},
	{ area_name = "ADD_ARMOR_R_2",	 	armour = {width=0.063}},
	{ area_name = "BODY_BACK", 			armour = {width=0.038}},
	{ area_name = "BODY_UPPER_BACK", 	armour = {width=0.038}},
	{ area_name = "ADD_ARMOR_HULL",	 	armour = {width=0.140}}, -- armor ring around the turret (temp value)
	{ area_name = "TURRET_COM", 		armour = {width=0.050}},
	{ area_name = "TURRET_COM_TOP", 	armour = {width=0.019}},
	{ area_name = "BOX_LEFT", 			armour = {width=0.1000}},
	{ area_name = "BOX_RIGHT", 			armour = {width=0.1000}},
	{ area_name = "BOX_TOP", 			armour = {width=0.1000}},
	{ area_name = "BOX_BOTTOM",			armour = {width=0.1000}},
	{ area_name = "BOX_BACK", 			armour = {width=0.1000}},
	{ area_name = "ENGINE", 			armour = {width=0.019}},
	{ area_name = "SIDE_GEAR_L", 		armour = {width=0.050}},
	{ area_name = "SIDE_GEAR_R", 		armour = {width=0.050}},
	{ area_name = "WHEEL_01_L", 		armour = {width=0.068}},
	{ area_name = "WHEEL_02_L", 		armour = {width=0.048}},
	{ area_name = "WHEEL_03_L", 		armour = {width=0.048}},
	{ area_name = "WHEEL_04_L", 		armour = {width=0.048}},
	{ area_name = "WHEEL_05_L", 		armour = {width=0.048}},
	{ area_name = "WHEEL_01_R", 		armour = {width=0.068}},
	{ area_name = "WHEEL_02_R", 		armour = {width=0.048}},
	{ area_name = "WHEEL_03_R", 		armour = {width=0.048}},
	{ area_name = "WHEEL_04_R", 		armour = {width=0.048}},
	{ area_name = "WHEEL_05_R", 		armour = {width=0.048}},
	{ area_name = "GUN",		 		armour = {width=1000.0}},
}

GT.AddPropVehicle = {
			{ id = "HedgeCutter" , control = 'checkbox', label = _('Hedge Cutter'), defValue = false, arg=60, boolean_inverted = false} -- boolean_inverted = true by default: element present - argVal=0, absent - argVal=1
		}

--chassis
GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.5;

--Burning after hit
GT.visual.fire_size = 0.6; --relative burning size
GT.visual.fire_pos[1] = -1.1; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.2; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 650; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {2.7, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-2.5, 0.4, -GT.chassis.Z_gear_2}

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_100mm, GT_t.IR_COEFFS_BODY, {0.3, 0.3/1250}}}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.02, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 4000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pointer = 'POINT_SIGHT_01';
GT.WS[ws].cockpit = {"M70F/M70F", {0.0, 0.0, 0.0}}
GT.WS[ws].angles = {{math.rad(180), math.rad(-180), math.rad(-5), math.rad(20)}};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].pidY = GT_t.TANK_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.TANK_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(20);
GT.WS[ws].omegaZ = math.rad(18);

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.M3);
__LN.reactionTime = 2;
__LN.PL[1].ammo_capacity = 29;
__LN.PL[1].reload_time = 15 * 29
__LN.PL[1].virtualStwID = 1;
__LN.PL[2] = {};
__LN.PL[2].shell_name = {"M61"};
__LN.PL[2].ammo_capacity = 44;
__LN.PL[2].reload_time = 15 * 44
__LN.PL[2].automaticLoader = false;
__LN.PL[2].shot_delay = 15.0;
__LN.PL[2].virtualStwID = 2;
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

__LN.BR[1] = {connector_name = 'POINT_GUN_01',
			recoilArgument = 23,
			recoilTime = 0.3,
			muzzleBrakeType = 2};

--GT.WS[1].LN[2]
__LN = add_launcher(GT.WS[ws], __LN); -- HE rounds
__LN.type = 6;
__LN.distanceMin = 10;
__LN.distanceMax = 4000;
__LN.PL[1].ammo_capacity = 8;
__LN.PL[1].reload_time = 15 * 8
__LN.PL[1].shell_name = {"M46"};
__LN.PL[2].ammo_capacity = 16;
__LN.PL[2].reload_time = 15 * 16
__LN.PL[2].shell_name = {"M46"};

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.Browning_M1919);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[6]);
for i=2,15 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_01';
__LN.secondary = true;

-- WS[2]
ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_MG_02';
GT.WS[ws].pointer = 'POINT_SIGHT_02';
GT.WS[ws].cockpit = { "IronSight/IronSight"}
GT.WS[ws].area = "COL_MG_02";
GT.WS[ws].angles = {
                    {math.rad(15), math.rad(-15), math.rad(-15), math.rad(15)},
                    };
GT.WS[ws].drawArgument1 = 24;
GT.WS[ws].drawArgument2 = 25;
GT.WS[ws].pidY = GT_t.MG_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MG_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(60);
GT.WS[ws].omegaZ = math.rad(60);
--GT.WS[2].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.Browning_M1919);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[2]);
for i=2,10 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_02';
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

GT.Name = "M4_Sherman";
GT.DisplayName = _("MT M4 Sherman");
GT.DisplayNameShort = _("Sherman");
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
GT.Countries = ALIES