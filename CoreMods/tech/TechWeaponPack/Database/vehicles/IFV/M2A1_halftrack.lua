-- Sonderkraftfahrzeug 251

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_track_IFV);
set_recursive_metatable(GT.chassis, GT_t.CH_t.M2A1_halftrack);

GT.visual.shape = "M2A1_halftrack";
GT.visual.shape_dstr = "M2A1_halftrack_p_1";

GT.IR_emission_coeff = 0.08

--Burning after hit
GT.visual.fire_size = 0.55; --relative burning size
GT.visual.fire_pos[1] = 1.7; -- center of burn at long axis shift(meters) 
GT.visual.fire_pos[2] = 0.80; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 480 --burning time (seconds)
GT.visual.min_time_agony = 15;
GT.visual.max_time_agony = 120;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {1.5, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-1.5, 0.1, -GT.chassis.Z_gear_2}

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_HMG, GT_t.IR_COEFFS_BODY, {0.3, 0.3/1500}}}

GT.toggle_alarm_state_interval = 1.3;

--[[ 
GT.DM = {
	{ area_name = "FRONT_01", 			armour = {width=0.030}},
	{ area_name = "FRONT_02", 			armour = {width=0.030}},
	{ area_name = "BODY_BOTTOM",		armour = {width=0.005}},
	{ area_name = "BODY_LEFT", 			armour = {width=0.008}},
	{ area_name = "BODY_UPPER_LEFT",	armour = {width=0.0085}},
	{ area_name = "BODY_RIGHT", 		armour = {width=0.008}},
	{ area_name = "BODY_UPPER_RIGHT",	armour = {width=0.0085}},
	{ area_name = "BODY_BACK", 			armour = {width=0.010}},
	{ area_name = "BODY_UPPER_BACK",	armour = {width=0.010}},
	{ area_name = "BODY_TOP",			armour = {width=0.006}},
	{ area_name = "ENGINE", 			armour = {width=0.006}},
	{ area_name = "TOWER_FRONT", 		armour = {width=0.030}},
	{ area_name = "TOWER_LEFT", 		armour = {width=0.0145}},
	{ area_name = "TOWER_RIGHT", 		armour = {width=0.0145}},
	{ area_name = "TOWER_BACK", 		armour = {width=0.0145}},
	{ area_name = "GUN_MASK", 			armour = {width=0.050}},
	{ area_name = "GUN", 				armour = {width=0.2}},
	{ area_name = "WHEEL_01_L", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_02_L", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_03_L", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_04_L", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_01_R", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_02_R", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_03_R", 		armour = {width=0.0085}},
	{ area_name = "WHEEL_04_R", 		armour = {width=0.0085}},
}]]

--chassis
GT.swing_on_run = true;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 3.0;

GT.animation_arguments.rollers_rotation = {
										   [8] = 1.0,
										   [61] = 1.3,
										   [62] = 1.3,
										   [63] = 2.3,
										   [64] = 2.3}
GT.animation_arguments.wheels_turn_angle = 9; -- has front wheel

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, -0.1, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

-- weapon systems
GT.WS = {}
GT.WS.maxTargetDetectionRange = 6000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER_01'
GT.WS[ws].cockpit = { "IronSight/IronSight", {-1.6, 0.1, 0.006}, open = true};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(166), math.rad(-10), math.rad(50)},
					{math.rad(166), math.rad(125), math.rad(2), math.rad(50)},
					{math.rad(125), math.rad(-180), math.rad(-10), math.rad(50)},
                    };
GT.WS[ws].drawArgument1 = 80
GT.WS[ws].drawArgument2 = 82
GT.WS[ws].pidY = GT_t.MG_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MG_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(50);
GT.WS[ws].omegaZ = math.rad(50);

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_M2);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[2]);
__LN.fireAnimationArgument = 23;
for i=2,14 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_01';
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;


--.30cal M1919A4 MG (7750 rnds)
ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER_02'
GT.WS[ws].cockpit = { "IronSight/IronSight", {-1.05, 0.1, 0.006}, open = true};
GT.WS[ws].angles = {
					{math.rad(160), math.rad(10), math.rad(-10), math.rad(62)},
					{math.rad(10), math.rad(6.5), math.rad(-10), math.rad(40)},
                    };
GT.WS[ws].reference_angle_Y = math.rad(90);
GT.WS[ws].drawArgument1 = 83;
GT.WS[ws].drawArgument2 = 85;
GT.WS[ws].pidY = GT_t.MG_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MG_TOWER_PIDZ
GT.WS[ws].omegaY = math.rad(60);
GT.WS[ws].omegaZ = math.rad(60);

--GT.WS[2].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.Browning_M1919);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[2]);
__LN.fireAnimationArgument = 26;
for i=2,31 do
	__LN.PL[i] = {}
	set_recursive_metatable(__LN.PL[i], __LN.PL[1])
end
__LN.BR[1].connector_name = 'POINT_MG_02';
__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;

GT.Name = "M2A1_halftrack";
GT.DisplayName = _("APC M2A1");
GT.DisplayNameShort = _("M2A1");
GT.Rate = 8;

GT.DetectionRange  = 0;
GT.airWeaponDist = 0
GT.ThreatRange =  GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000004";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun,wsType_GenericAPC,
                "APC"
                };
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"APC",
}
GT.Countries = ALIES

GT.InternalCargo = {
			nominalCapacity = 700,
			maximalCapacity = 700, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}