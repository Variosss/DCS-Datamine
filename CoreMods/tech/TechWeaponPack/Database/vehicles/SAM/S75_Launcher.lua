-- S-75M Volhov

-- Missile
local SA2V755 = {
	category = CAT_MISSILES,
	name = "SA2V755",
	display_name = _("SA2V755"),
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_SA_Missile,WSTYPE_PLACEHOLDER};
	Escort = 3,
	Head_Type = 6,
	sigma = {50, 50, 50},
	M = 2388.0,
	H_max = 25000.0,
	H_min = 100,
	Diam = 500.0,
	Cx_pil = 1,
	D_max = 40000.0,
	D_min = 7000.0,
	Head_Form = 1,
	Life_Time = 60.0,
	Nr_max = 17,
	v_min = 170.0,
	v_mid = 338.0,
	Mach_max = 3.0,
	t_b = 0.0,
	t_acc = 5.0,
	t_marsh = 23.0,
	Range_max = 30000.0,
	H_min_t = 100.0,
	Fi_start = 3.14152,
	Fi_rak = 3.14152,
	Fi_excort = 0.75,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	ccm_k0 = 3.0,
	PN_coeffs = {2,
					1000.0 , 1.0,
					40000.0, 0.5},
	warhead 		= 
	{
		mass 					= 196; 
		expl_mass 				= 196; 
		other_factors 			= {1, 1, 1};
		obj_factors 			= {1, 1};
		concrete_factors 		= {1, 1, 1};
		cumulative_factor 		= 0;
		concrete_obj_factor 	= 0.0;
		cumulative_thickness 	= 0.0;
		piercing_mass			= 40.0;
		caliber					= 500,
	},
	exhaust1 = {0.8, 0.8, 0.8, 0.7},
	X_back = -3.463,
	Y_back = 0.0,
	Z_back = 0.0,
	exhaust2 = {0.63, 0.67, 0.75, 0.1},
	X_back_acc = -6.0,
	Y_back_acc = 0.0,
	Z_back_acc = 0.0,
	Reflection = 0.3967,
	KillDistance = 20.0,
	shape_table_data = 
	{
		{
			name	 = "S_75_Rocket";
			file  	 = "S_75_Rocket";
			life  	 = 1;
			fire  	 = { 0, 1};
			username = "SA2V755";
			index = WSTYPE_PLACEHOLDER;
		},
	}
};
declare_weapon(SA2V755)

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);

GT.visual.shape = "S_75_Launcher";
GT.visual.shape_dstr = "S_75_Launcher_p_1";

GT.IR_emission_coeff = 0.03

GT.toggle_alarm_state_interval = 0.01;
GT.animation_arguments.alarm_state = -1;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.617;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 0.1;

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, {0.0, 0.0}, GT_t.IR_COEFFS_Hot_SAM, {0.0, 0.00}, {0.15, 0.15/550}}}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 65000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
--GT.WS[ws].center = 'CENTER_TOWER';
GT.WS[ws].pos = {0.0, 1.7, 0.0}
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(0), math.rad(80.0)},
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].omegaY = 0.323599;
GT.WS[ws].omegaZ = 0.174533;
GT.WS[ws].reference_angle_Z = math.rad(30.6);
GT.WS[ws].reloadAngleY = 0.0;
GT.WS[ws].reloadAngleZ = 0.0;
GT.WS[ws].pidY = { p = 5, i = 0, d = 2, inn = 1};
GT.WS[ws].pidZ = { p = 5, i = 0, d = 2, inn = 1};
GT.WS[ws].LN = {}
GT.WS[ws].LN[1] = {}
GT.WS[ws].LN[1].type = 4
GT.WS[ws].LN[1].distanceMin = 7000
GT.WS[ws].LN[1].distanceMax = 43000
GT.WS[ws].LN[1].ECM_K = -1
GT.WS[ws].LN[1].reactionTime = 5
GT.WS[ws].LN[1].min_launch_angle = math.rad(9);
GT.WS[ws].LN[1].show_external_missile = true
GT.WS[ws].LN[1].barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;
GT.WS[ws].LN[1].depends_on_unit = {{{"SNR_75V", 1},},};
GT.WS[ws].LN[1].sensor = {}
set_recursive_metatable(GT.WS[ws].LN[1].sensor, GT_t.WSN_t[0])
GT.WS[ws].LN[1].PL = {}
GT.WS[ws].LN[1].PL[1] = {}
GT.WS[ws].LN[1].PL[1].ammo_capacity = 1
GT.WS[ws].LN[1].PL[1].type_ammunition = SA2V755.wsTypeOfWeapon;
GT.WS[ws].LN[1].PL[1].name_ammunition = SA2V755.shape_table_data.username
GT.WS[ws].LN[1].PL[1].reload_time = 2700;
GT.WS[ws].LN[1].PL[1].shot_delay = 0.1
GT.WS[ws].LN[1].max_number_of_missiles_channels = 1;
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_ROCKET'},
	}
	
GT.Name = "S_75M_Volhov";
GT.DisplayName = _("SAM SA-2 LN SM-90");
GT.DisplayNameShort = _("SA-2");
GT.Rate = 10;

GT.DetectionRange  = 0;
GT.ThreatRangeMin = GT.WS[1].LN[1].distanceMin;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000082";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, SA3_LN,
				"AA_missile",
				"LR SAM",
				"SAM LL",
                };
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"Launcher",
}
GT.Countries = {"Algeria", "Bulgaria", "China", "Czech Republic", "Egypt", "Ethiopia", "Georgia", "Germany", "Hungary", "Indonesia", "Iran", "Kazakhstan", "Libya", "North Korea", "Pakistan", "Romania", "Russia", "Sudan", "Syria", "Poland", "Ukraine", "USSR", "Vietnam", "Yemen", "Yugoslavia", "Cuba"}