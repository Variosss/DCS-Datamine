-- MBT T-72B3

-- new AP shell
declare_weapon({
	category 	= CAT_SHELLS,
	name 		= "3BM59_125_AP", -- Svinets-1
	user_name 	= _("3BM59_125_AP_Svinets_1"),
	model_name  = "kinetic_type1",
	v0    = 1650.0,
	Dv0   = 0.009,
	Da0     = 0.0002,
	Da1     = 0.0000,
	mass      = 6.8,
	explosive     = 0,
	life_time     = 100,
	caliber     	 = 125.0,
	AP_cap_caliber = 31.0,  --указана масса и диаметр "стрелы"
	subcalibre     = true,
	s         = 0.0,
	j         = 0.0,
	l         = 0.0,
	charTime    = 0,
	cx        = {1.0,1.40,0.81,0.172,1.59},
	k1        = 2.2e-10,
	tracer_off     = 100,
	rotation_freq  = 0,
	
	cartridge = 0,
});

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_tank);
set_recursive_metatable(GT.chassis, GT_t.CH_t.T72B3);

GT.visual.shape = "T-72B3";
GT.visual.shape_dstr = "T-72B3_p_1";

GT.IR_emission_coeff = 0.105

GT.CustomAimPoint = {0,1.3,0}

-- Crew
GT.crew_locale = "RUS";
GT.crew_members = {"gunner"};

--chassis
GT.swing_on_run = false;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.723;

--Burning after hit
GT.visual.fire_size = 0.95; --relative burning size
GT.visual.fire_pos[1] = -1.5; -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.2; -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0; -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 750; --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 5;
GT.visual.dust_pos = {2.85, 0.1, -GT.chassis.Z_gear_1}
GT.visual.dirt_pos = {-3.1, 0.55, -GT.chassis.Z_gear_2}

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_Tank, GT_t.IR_COEFFS_ROLLERS_Tank, GT_t.IR_COEFFS_120mm, GT_t.IR_COEFFS_BODY, {0.3, 0.3/1750}}}

GT.DM = {
	{ area_name = "TURRET_FRONT", 		armour = {width=0.400}},
	{ area_name = "TURRET_L",			armour = {width=0.250}},
	{ area_name = "TURRET_R",			armour = {width=0.250}},
	{ area_name = "TURRET_BACK",		armour = {width=0.060}},
	{ area_name = "TURRET_TOP", 		armour = {width=0.040}},
	{ area_name = "COMMANDER", 			armour = {width=0.040}},
	{ area_name = "COMMANDER_SCUTE",	armour = {width=0.800}}, -- nearly invulnerable to prevent penetration speculations
	{ area_name = "HULL_FRONT_01", 		armour = {width=0.400}},
	{ area_name = "HULL_FRONT_02", 		armour = {width=0.300}},
	{ area_name = "HULL_TOP",			armour = {width=0.060}},
	{ area_name = "HULL_BOTTOM",		armour = {width=0.040}},
	{ area_name = "HULL_BACK",			armour = {width=0.040}},
	{ area_name = "ENGINE", 			armour = {width=0.040}},
	{ area_name = "BULWARK_R",			armour = {width=0.200}},
	{ area_name = "BULWARK_L",			armour = {width=0.200}},
	{ area_name = "CHASSIS_R",			armour = {width=0.160}},
	{ area_name = "CHASSIS_L",			armour = {width=0.160}},
	{ area_name = "GUN",		 		armour = {width=0.500}},
}

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 6000;
GT.WS.smoke = {"SMOKE_02", "SMOKE_05", "SMOKE_04", "SMOKE_07", "SMOKE_01", "SMOKE_06", "SMOKE_03", "SMOKE_08",};

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].angles = {
                    {math.rad(145), math.rad(-145), math.rad(-4), math.rad(14)},
                    {math.rad(-145), math.rad(145), math.rad(3.5), math.rad(14)},
                    };
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].omegaY = math.rad(20);
GT.WS[ws].omegaZ = math.rad(12);
GT.WS[ws].pidY = GT_t.MODERN_TANK_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MODERN_TANK_TOWER_PIDZ
GT.WS[ws].stabilizer = true;
GT.WS[ws].laser = true;

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.tank_gun_2A46);
__LN.PL[1].shell_name = {"3BM59_125_AP"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].shell_name = {"3BM59_125_AP"};
__LN.PL[2].virtualStwID = 2;
__LN.beamWidth = math.rad(1);
__LN.BR[1] = {connector_name = 'POINT_GUN',
			recoilArgument = 23,
			recoilTime = 0.3};

--GT.WS[1].LN[2] - 125mm D-81 gun
__LN = add_launcher(GT.WS[ws], __LN);
__LN.type = 6; -- howitzer type
__LN.distanceMin = 20;
__LN.distanceMax = 8000;
__LN.PL[1].ammo_capacity = 7;
__LN.PL[1].reload_time = 20 * 7
__LN.PL[1].shell_name = {"2A46M_125_HE"};
__LN.PL[2].ammo_capacity = 10;
__LN.PL[2].reload_time = 15 * 10
__LN.PL[2].shot_delay = 30;
__LN.PL[2].shell_name = {"2A46M_125_HE"};
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;

--GT.WS[1].LN[3]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.Svir);
__LN.PL[1].virtualStwID = 1;
__LN.PL[2].virtualStwID = 2;
__LN.BR = {
			{connector_name = 'POINT_GUN',
			recoilArgument = 23,
			recoilTime = 0.3}
		  }
		  
--GT.WS[1].LN[4]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.PKT);-- coaxial
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[7]);
__LN.secondary = true;
__LN.beamWidth = math.rad(1);
for i=2,8 do
    __LN.PL[i] = {};
    set_recursive_metatable(__LN.PL[i], __LN.PL[1]);
end;
__LN.BR[1].connector_name = 'POINT_MGUN_01';

ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].base = 1;
GT.WS[ws].center = 'CENTER_MGUN';
GT.WS[ws].angles = {
                    {math.rad(180), math.rad(-180), math.rad(-8), math.rad(63)},
                    };
GT.WS[ws].drawArgument1 = 24;
GT.WS[ws].drawArgument2 = 25;
GT.WS[ws].omegaY = math.rad(80);
GT.WS[ws].omegaZ = math.rad(60);
GT.WS[ws].pidY = GT_t.MG_TOWER_PIDY
GT.WS[ws].pidZ = GT_t.MG_TOWER_PIDZ
GT.WS[ws].reference_angle_Y = math.pi;

__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_12_7_utes);
__LN.type = 10; -- AA machinegun
__LN.BR[1].connector_name = 'POINT_MGUN';
__LN = nil;

GT.Name = "T-72B3";
GT.DisplayName = _("MBT T-72B3");
GT.DisplayNameShort = _("T72B3");
GT.Rate = 17;

GT.Sensors = { OPTIC = {"TKN-3B day", "TKN-3B night",
                        --"TSH-2-22 day","BPK-2-42 night", -- T-72 TPN3-49 = BPK-2-42 night
                        },
            };

GT.DetectionRange  = 0;
GT.airWeaponDist = 3500
GT.ThreatRange = GT.WS[1].LN[3].distanceMax;
GT.mapclasskey = "P0091000001";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_Gun,wsType_GenericTank,
                "Tanks",
                "Modern Tanks",
                "CustomAimPoint",
                };
GT.category = "Armor";
GT.tags  =
{
    "Armor",
	"MBT",
}
GT.Countries = {"Belarus", "Russia", "Syria"}
