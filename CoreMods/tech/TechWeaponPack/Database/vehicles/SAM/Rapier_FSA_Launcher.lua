-- Rapier FSA Launcher

-- Missile
local weap_name = "Rapier"
local weap_disp_name = _("Rapier");

Rapier_FSA_Missile =
{
	category	= CAT_MISSILES,
	name			= weap_name,
	display_name	= weap_disp_name,
	user_name		= weap_disp_name,
	scheme			= "command_guided_missile_sfe",
	class_name		= "wAmmunitionVikhr",
	model			= "rapier_fsa_missile",
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Missile,wsType_SA_Missile,WSTYPE_PLACEHOLDER};
	mass			= 45,
	Escort			= 3,
	Head_Type		= 8,
	sigma			= {5, 5, 5},
	M				= 45.0,
	H_max			= 3000.0,
	H_min			= 50,
	Diam			= 133.0,
	Cx_pil			= 1,
	D_max			= 6800.0,
	D_min			= 400.0,
	Head_Form		= 1,
	Life_Time		= 30.0,
	Nr_max			= 14,
	v_min			= 170.0,
	v_mid			= 600.0,
	Mach_max		= 2.5,
	t_b				= 0.0,
	t_acc			= 2.0,
	t_marsh			= 12.0,
	Range_max		= 6800.0,
	H_min_t			= 50.0,
	Fi_start		= 3.14152,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.0,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	
	exhaust			= { 1, 1, 1, 0.4 },
	X_back			= -0.9,
	Y_back			= 0.0,
	Z_back			= 0.0,
	tail_scale		= 0.3,
	Reflection		= 0.08,
	KillDistance	= 0.0,
	
	shape_table_data = 
	{
		{
			name	 = weap_name;
			file  	 = "rapier_fsa_missile";
			life  	 = 1;
			fire  	 = { 0, 1};
			username = weap_disp_name;
			index = WSTYPE_PLACEHOLDER;
		},
	},
	
	controller = {
		boost_start = 0.001,
		march_start = 1.001,
	},
	
	booster = {
		impulse								= 160,
		fuel_mass							= 4,
		work_time							= 1,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.86, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.08,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.2,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse								= 180,
		fuel_mass							= 11.5,
		work_time							= 5,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.86, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.08,
		smoke_color							= {0.7, 0.7, 0.7},
		smoke_transparency					= 0.1,
		custom_smoke_dissipation_factor		= 0.01,
	},
	
	spiral_nav = {
		t_cone_near_rad			= 1000,
		def_cone_max_dist		= 7500,
		def_cone_near_rad		= 0,
		def_cone_near_rad_st	= 0,
		def_cone_time_stab_rad	= 0,
		gb_angle				= math.rad(9),
		gb_min_dist				= 1,
		gb_use_time				= 2.0,
		gb_max_retW				= math.rad(4.5),
		gb_ret_Kp				= 2.6,
	},
	
	
	autopilot = {
		Kp					= 0.016,
		Ki					= 0.003,
		Kd					= 0.01,
		max_ctrl_angle		= 1.1,
		delay				= 0.5,
		op_time				= 20.0,
		fins_discreet		= 0.01,
		no_ctrl_center_ang	= 0.00002,
	},

	fm = {
		mass        = 45,  
		caliber     = 0.13,  
		cx_coeff    = {1,0.28,0.43,0.18,1.12},
		L           = 2.235,
		I           = 1 / 12 * 45 * 2.235 * 2.235,
		Ma          = 0.5,
		Mw          = 2.0,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.2,
		dCydA		= {0.024, 0.018},
		A			= 0.6,
		maxAoa		= 0.28,
		finsTau		= 0.05,
		lockRoll	= 1,
	},

	err = {
		y_error = 0.01,
		z_error = 0.01,
		min_time_interval = 0.1,
		max_time_interval = 0.9,
	},

	fuze = {
		default_arm_delays = { 0.8 },
		default_function_delays = { 0, 0.02 },
		default_proximity_radius = 7,
	},

	warhead = predefined_warhead("FSA_Rapier"),
}

declare_weapon(Rapier_FSA_Missile)

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 3

GT.snd.radarRotation = "GndTech/RadarRotation"; -- не поворот, но звук работы
GT.radar_rotation_period = 1.0;

GT.visual.shape = "rapier_fsa_launcher";
GT.visual.shape_dstr = "rapier_fsa_launcher_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.03

--IR.coefs[1..4] ={heat collect coef, heat loose coef}
--IR.coefs[5] = {0.3 - initial value for FLIR param C0 for dead model, 0.3/1800 - param C0 decrease speed (0.3 in 1800 secs)}
GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_Cold_SAM, {0.0, 0.00}, {0.15, 0.15/550}}}

GT.sensor = {};
GT.sensor.max_range_finding_target = 30000;
GT.sensor.min_range_finding_target = 500;
GT.sensor.max_alt_finding_target = 4000;
GT.sensor.min_alt_finding_target = 50;
GT.sensor.height = 2.5;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = -1;
GT.visual.agony_explosion_size = 1;

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 30000;
GT.WS.radar_type = 104;
GT.WS.radar_rotation_type = 0;
GT.WS.searchRadarMaxElevation = math.rad(20);

-- zero tracker, dummy
ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {0, GT.sensor.height, 0};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), 0.0, math.rad(60)},
					};
GT.WS[ws].omegaY = 3.0;
GT.WS[ws].omegaZ = 3.0;
GT.WS[ws].pidY = {p=100,i=0.1,d=10};
GT.WS[ws].pidZ = {p=100,i=0.1,d=10};

GT.WS[ws].LN = {{}}
local __LN = GT.WS[ws].LN[1]
__LN.type = 100;
__LN.distanceMin = 400;
__LN.distanceMax = GT.WS.maxTargetDetectionRange;
__LN.min_trg_alt = 20;
__LN.max_trg_alt = 8000;
__LN.reactionTime = 4;
__LN.reflection_limit = 0.1;
__LN.ECM_K = -1
__LN.maxShootingSpeed = 0;
__LN.sensor = {};
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[0]);

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].pos = {0, 1.857,0};
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), 0.0, math.rad(60)},
					};
GT.WS[ws].drawArgument1 = 0;
GT.WS[ws].drawArgument2 = 1;
GT.WS[ws].reference_angle_Y = math.pi
GT.WS[ws].omegaY = 1.0;
GT.WS[ws].omegaZ = 1.0;
GT.WS[ws].pidY = {p=10,i=0.1,d=3};
GT.WS[ws].pidZ = {p=10,i=0.1,d=3};

GT.WS[ws].LN = {{}}
local __LN = GT.WS[ws].LN[1]
__LN.type = 4;
__LN.distanceMin = 400;
__LN.distanceMax = 6800;
__LN.launch_delay = 3;
__LN.reactionTime = 2;
__LN.reflection_limit = 0.1;
__LN.ECM_K = -1
__LN.maxShootingSpeed = 0;
__LN.beamWidth = math.rad(90)
__LN.max_number_of_missiles_channels = 1;
--__LN.min_launch_angle = math.rad(10);
__LN.show_external_missile = true;
__LN.sensor = {};
set_recursive_metatable(__LN.sensor, GT_t.WSN_t[0]);
__LN.barrels_reload_type = GT_t.BarrelsReloadTypes.SEQUENTIALY;
__LN.PL = {};
__LN.PL[1] = {};
__LN.PL[1].ammo_capacity = 4;
__LN.PL[1].automaticLoader = false;
__LN.PL[1].type_ammunition=Rapier_FSA_Missile.wsTypeOfWeapon;
__LN.PL[1].name_ammunition= weap_disp_name;
__LN.PL[1].reload_time = 60*2.5;	
__LN.PL[1].shot_delay = 0.1;
__LN.depends_on_unit = {{{"rapier_fsa_blindfire_radar", 1}}, {{"rapier_fsa_optical_tracker_unit", 1}}};
__LN.BR = {
		{connector_name = 'missile_point_1'},
		{connector_name = 'missile_point_2'},
		{connector_name = 'missile_point_3'},
		{connector_name = 'missile_point_4'},
};

GT.Name = "rapier_fsa_launcher";
GT.DisplayName = _("SAM Rapier FSA Launcher");
GT.DisplayNameShort = _("Rapier LN");
GT.Rate = 5;

GT.Sensors = { RADAR = "Roland Radar" }

GT.DetectionRange  = GT.WS.maxTargetDetectionRange;
GT.ThreatRange = GT.WS[2].LN[1].distanceMax;
GT.mapclasskey = "P0091000082";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Miss, WSTYPE_PLACEHOLDER,
				"AA_missile",
				"SR SAM",
				"SAM SR",
				"SAM TR",
				"SAM LL",
				"RADAR_BAND1_FOR_ARM",
				"RADAR_BAND2_FOR_ARM",
				};
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"SAM SHORAD",
}
GT.Countries = {"UK", "Iran", "Malaysia", "Oman", "Singapore", "Switzerland", "Turkey", "United Arab Emirates", "Zambia", "Australia", "Libya", "Netherlands", "Iraq"}