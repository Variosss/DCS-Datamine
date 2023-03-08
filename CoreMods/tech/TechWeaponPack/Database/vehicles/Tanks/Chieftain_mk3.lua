-- MBT Chieftain Mk.3

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_tank);
set_recursive_metatable(GT.chassis, GT_t.CH_t.CHIEFTAIN_MK3);

GT.visual.shape = "Chieftain_mk3";
GT.visual.shape_dstr = "Chieftain_mk3_p_1";

--Burning after hit
GT.visual.fire_size = 0.75; --relative burning size
GT.visual.fire_pos[1] = -2.3; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.2; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 600; --burning time (seconds)
GT.visual.dust_pos = {3.15, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-3.9, 0.54, -GT.chassis.Z_gear_2}

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_120mm, IR_COEFFS_BODY, {0.3, 0.3/1750}}}

GT.driverViewConnectorName = {"DRIVER_POINT", offset = {0.05, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpitWithIR"

GT.crew_locale = "ENG";
GT.crew_members = {"commander", "gunner"};

GT.swing_on_run = false;

GT.IR_emission_coeff = 0.1
GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.9;

GT.DM = {
	{ area_name = "FRONT_01", 				armour = {width=0.120}},
	{ area_name = "FRONT_02", 				armour = {width=0.0762}},
	{ area_name = "HULL", 					armour = {width=0.090}},
	{ area_name = "BODY_TOP", 				armour = {width=0.022}},
	{ area_name = "BODY_BACK", 				armour = {width=0.037}},
	{ area_name = "BODY_BOTTOM",			armour = {width=0.020}},
	{ area_name = "FENDER_LEFT", 			armour = {width=0.220}},
	{ area_name = "FENDER_RIGHT", 			armour = {width=0.220}},
	{ area_name = "TRACK_LEFT", 			armour = {width=0.120}},
	{ area_name = "TRACK_LEFT_FRONT", 		armour = {width=0.250}},
	{ area_name = "TRACK_RIGHT", 			armour = {width=0.120}},
	{ area_name = "TRACK_RIGHT_FRONT", 		armour = {width=0.250}},
	
	{ area_name = "TURRET_FRONT",			armour = {width=0.200}},
	{ area_name = "TURRET_LEFT",			armour = {width=0.130}},
	{ area_name = "TURRET_RIGHT",			armour = {width=0.130}},
	{ area_name = "TURRET_TOP",				armour = {width=0.0508}},
	{ area_name = "TURRET_BACK",			armour = {width=0.045}},
	{ area_name = "TURRET_COM", 			armour = {width=0.130}},
	{ area_name = "TURRET_COM_TOP",			armour = {width=0.0508}},

	{ area_name = "GUN", 					armour = {width=0.220}},
	
	{ area_name = "ENGINE", 				armour = {width=0.0245}},
	
}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 6000;
--GT.WS.smoke = {"SMOKE_04", "SMOKE_05", "SMOKE_03", "SMOKE_06", "SMOKE_02", "SMOKE_07", "SMOKE_01", "SMOKE_08",};

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pointer = "POINT_SIGHT_01";
GT.WS[ws].angles = {
                    {math.rad(140), math.rad(-140), math.rad(-9), math.rad(19)},
                    {math.rad(-140), math.rad(140), math.rad(0), math.rad(19)},
                    };
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].pidY = {p=100, i=0.0, d=14.0, inn = 10};
GT.WS[ws].pidZ = {p=100, i=0.0, d=14.0, inn = 10};
GT.WS[ws].omegaY = math.rad(24);
GT.WS[ws].omegaZ = math.rad(4);
GT.WS[ws].stabilizer = true;
GT.WS[ws].laser = true;

GT.WS[ws].cockpit = { "Chieftain_mk3/Chieftain_mk3_reticle", {0.0, 0.0, 0.0 }, };

--GT.WS[1].LN[1]
local __LN = add_launcher(GT.WS[ws], GT_t.LN_t.tank_gun_120mm);
__LN.beamWidth = math.rad(1);

__LN.sightMasterMode = 1;
__LN.sightIndicationMode = 1;
__LN.combatRange = 1100
__LN.reactionTime = 2;
__LN.PL[1].shell_name = {"L23A1_APFSDS"}
__LN.PL[1].ammo_capacity = 8;
__LN.PL[1].reload_time = 15 * 8
__LN.PL[1].shot_delay = 6;
__LN.PL[2] = {};
__LN.PL[2].ammo_capacity = 11;
__LN.PL[2].reload_time = 15 * 11
__LN.PL[2].automaticLoader = false;
__LN.PL[2].shot_delay = 10;
__LN.PL[2].shell_name = {"L23A1_APFSDS"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;
__LN.BR[1] = {connector_name = 'POINT_GUN_01',
			recoilArgument = 23,
			recoilTime = 0.3};

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], __LN); -- HE rounds
__LN.type = 6;
__LN.distanceMin = 20;
__LN.distanceMax = 5000;
__LN.combatRange = 700
__LN.PL[1].ammo_capacity = 10;
__LN.PL[1].reload_time = 15 * 10
__LN.PL[1].shell_name = {"L31A7_HESH"};
__LN.PL[2] = {};
__LN.PL[2].ammo_capacity = 24;
__LN.PL[2].reload_time = 15 * 24
__LN.PL[2].shell_name = {"L31A7_HESH"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;

-- GT.WS[ws].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.L94A1);
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[7]);
__LN.secondary = true
__LN.beamWidth = math.rad(1);
__LN.BR[1].connector_name = 'POINT_MG_01'
for i=2,30 do
    __LN.PL[i] = {};
    set_recursive_metatable(__LN.PL[i], __LN.PL[1]);
end;
__LN = nil;

GT.Name = "Chieftain_mk3";
GT.DisplayName = _("MBT Chieftain Mk.3");
GT.DisplayNameShort = _("Chief");
GT.Rate = 13;

GT.Sensors = { OPTIC = {"TRP-2A day", "TRP-2A night"}, };

GT.DetectionRange  = 0;
GT.airWeaponDist = 1500
GT.ThreatRange =  GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000001";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun, WSTYPE_PLACEHOLDER,
                "Tanks",
                "Old Tanks",
                };
GT.category = "Armor";
GT.Countries = {"UK"}
GT.tags  =
{
    "Armor",
	"MBT",
}