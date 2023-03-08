HOT2 =
{
	category		= CAT_MISSILES,
	name			= "HOT2",
	user_name		= _("HOT2"),
	scheme			= "command_guided_spin_missile",
	class_name		= "wAmmunitionVikhr",
	model			= "hot3",
	mass			= 23.5,

	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	Escort 			= 1,
	Head_Type 		= 7,
	sigma 			= {3, 3, 3},
	M 				= 23.5,
	H_max 			= 18000.0,
	H_min 			= -1,
	Diam 			= 150.0,
	Cx_pil			= 2.5,
	D_max 			= 4300.0,
	D_min 			= 100.0,
	Head_Form 		= 0,
	Life_Time 		= 22.0,
	Nr_max 			= 10,
	v_min 			= 0.0,
	v_mid 			= 235.0,
	Mach_max 		= 1.2,
	t_b 			= 0.0,
	t_acc			= 0.9,
	t_marsh			= 17.5,
	Range_max		= 4300.0,
	H_min_t		    = -1.0,
	Fi_start 		= 0.03,
	Fi_rak 		    = 3.14152,
	Fi_excort 		= 0.79,
	Fi_search 		= 0.09,
	OmViz_max 		= 0.2,
	X_back 			= -1.455,
	Y_back 			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.0182,
	KillDistance 	= 0,

	shape_table_data =
	{
		{
			name	 = "HOT2",
			file	 = "hot3",
			life	 = 1,
			fire	 = { 0, 1},
			username = "HOT2",
			index	 = WSTYPE_PLACEHOLDER,
		},
	},

	controller = {
		boost_start = 0,
		march_start = 0.3,
	},

	booster = {
		impulse								= 145,
		fuel_mass							= 3.9,
		work_time							= 0.24,
		nozzle_position						= {{-0.5, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.035,
		smoke_color							= {0.8, 0.8, 0.8},
		smoke_transparency					= 0.8,
		custom_smoke_dissipation_factor		= 0.0,
	},

	march = {
		impulse								= 170,
		fuel_mass							= 5.24,
		work_time							= 17.5,
		nozzle_position						= {{-0.42, 0.0, 0.074},{-0.42, 0.0, -0.074},{-0.42, 0.074, 0.0},{-0.42,-0.074, 0.0 }},
		nozzle_orientationXYZ				= {{0.0, -0.18, 0.0},{0.0, 0.18, 0.0},{0.0, 0.0, 0.18},{0.0, 0.0, -0.18}},
		tail_width							= 0.025,
		smoke_color							= {0.85, 0.85, 0.85},
		smoke_transparency					= 0.07,
		custom_smoke_dissipation_factor		= 0.06,
	},

	spiral_nav = {
											-- laser guidance simulation--	(use high values for wire/radio guidance)
		t_cone_near_rad			= 1000,		-- simple simulation radius (for bots)
		def_cone_max_dist		= 4300,		-- laser reach
		def_cone_near_rad		= 1000,		-- stab. radius
		def_cone_near_rad_st	= 0,		-- start radius
		def_cone_time_stab_rad	= 0,		-- stab. time

											-- start/dust avoidance program--
		gb_angle				= 0.01,		-- start angle above LOS (rad)
		gb_min_dist				= 1,		-- min distance to use this program
		gb_use_time				= 0.7,		-- time trigger: return aim to LOS
		gb_max_retW				= 0.7,		-- ret W max
		gb_ret_Kp				= 1.0,		-- ret power coeff.
	},

	fm  = {
		mass        = 23.5,
		caliber     = 0.150,
		L           = 1.3,
		I           = 1 / 12 * 24.5 * 1.3 * 1.3,
		Ma          = 1.2,
		Mw          = 9.0,
		cx_coeff    = {1,0.5,0.4,0.3,1.12},
		dCydA		= {0.024, 0.017},
		rail_open	= 0,
		A			= 0.6,
		Sw			= 0.38,
		maxAoa		= 0.16,
		finsTau		= 0.04,
		freq		= 4,
	},

	autopilot = {
		Kp					= 0.05,		--P
		Ki					= 0.005,	--I
		Kd					= 0.05,		--D
		max_ctrl_angle		= 1.0,		--turn off autopilot after reaching max angle
		delay				= 0.2,		--autopilot delay
		op_time				= 22.0,		--autopilot operation time
		no_ctrl_center_ang	= 0.00008,	--blind point at center (rad)
		fins_discreet		= 0.016,
	},

	eng_err = {
		y_error = 0.06,
		z_error = 0.06,
		min_time_interval = 0.1,
		max_time_interval = 0.9,
	},

	fuze = {
		default_arm_delays = { 0.8 },
	},

	warhead		= predefined_warhead("HOT2"),
}

declare_weapon(HOT2)

SA5V28 = {
	category = CAT_MISSILES,
	name = "SA5V28",
	display_name = _("5V28 (SA-5 Gammon)"),
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Missile, wsType_SA_Missile, WSTYPE_PLACEHOLDER};
	Escort = 3,
	Head_Type = 6,
	sigma = {10.81, 10.81, 10.81},
	M = 7018,
	H_max = 40000.0,
	H_min = 300.0,
	Diam = 752.0,
	Cx_pil = 10,
	D_max = 50000.0,
	D_min = 17000.0,
	Head_Form = 1,
	Life_Time = 250.0,
	Nr_max = 12,
	v_min = 0.0,
	v_mid = 1100.0,
	Mach_max = 5.0,
	t_b = 0,
	t_acc = -1,
	t_marsh = -1,
	Range_max = 240000.0,
	H_min_t = 300.0,
	Fi_start = math.rad(60),
	Fi_rak = 3.14152,
	Fi_excort = math.rad(60),
	Fi_search = math.rad(6),
	OmViz_max = math.rad(6.5),
	hasDetachableAccelerator_ = 1,
	warhead = enhanced_a2a_warhead(130.0, 752.0),
	tail_scale = 1.0,
	effect_max_length = 1300.0,
	Reflection = 1.0,
	KillDistance = 45.0,
	ccm_k0 = 1.5,
	PN_coeffs = {3,
		5000.0, 1.0,
		50000.0, 0.5,
		300000.0, 2.0
	},
	exhaust1 = { 1, 1, 1, 1 },
	X_back = -5.420,
	Y_back = 0.0,
	Z_back = 0.0,
	exhaust2 = { 0.9, 0.9, 0.9, 0.05 },
	X_back_acc = -6.1,
	Y_back_acc = 0.0,
	Z_back_acc = 0.0,
	ModelData = {58,
			3.49,
			0.07,
			0.12,
			0.02,
			0.04,
			1.5,
			1.0,

			4.2,
			2.4,
			1.2,

			math.rad(15.0),
			0.0,

			 -1.0,	-1.0,	3.75,		59.0,		0.0,	0.0,	1.0e9,
			 0.0,	0.0,	712.1,		38.47,		0.0,	0.0,	0.0,
			 0.0,	0.0,	960000.0,	91322.0,	0.0,	0.0,	0.0,

			 1e09,
			 250.0,
			 300,
			 4.0,
			 1.0e9,
			 1.0e9,
			 0.0,
			 30.0,
			 0.0,
			 1.19,
			 1.0,
			 2.0,
			 0.0,
			 0.0,
			 0.0,
			 0.0,
			 0.0,
			 11000.0,
			 4000.0,
			 5000.0,
			 0.2,
			 1.0,
			 1.4,
			-3.0,
			0.5,
	},
	shape_table_data =
	{
		{
			name	 = "s-200_5b21_missile";
			file  	 = "s-200_5b21_missile";
			life  	 = 1;
			fire  	 = { 0, 1};
			username = "SA5V28";
			index = WSTYPE_PLACEHOLDER;
		},
	}
};
declare_weapon(SA5V28)

RIM_116A =
{
	category		= CAT_MISSILES,
	name			= "RIM_116A",
	user_name		= _("RIM-116A"),
	scheme			= "passive_plus_IR_homing_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "rim-116",
	mass			= 73.6,

	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_SA_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 3,
	sigma			= {10, 10, 10},
	M				= 73.6,
	H_max			= 4000.0,
	H_min			= -1,
	Diam			= 127.0,
	Cx_pil			= 1,
	D_max			= 10000.0,
	D_min			= 500.0,
	Head_Form		= 0,
	Life_Time		= 24,
	Nr_max			= 20,
	v_min			= 140.0,
	v_mid			= 350.0,
	Mach_max		= 2.5,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 0.0,
	Range_max		= 10000.0,
	H_min_t			= 5.0,
	Fi_start		= math.rad(1),
	Fi_rak			= 3.14152,
	Fi_excort		= 0.79,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.0182,
	KillDistance	= 5.0,

	shape_table_data =
	{
		{
			name		= "RIM_116A",
			file		= "rim-116",
			life		= 1,
			fire		= { 0, 1},
			username	= _("RIM-116A"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},

	controller = {
		boost_start = 0,
		march_start = 0.2,
	},

	booster = {
		impulse								= 160,
		fuel_mass							= 0.5,
		work_time							= 0.2,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.41, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.4,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.3,
	},

	march = {
		impulse								= 230,
		fuel_mass							= 27.4,
		work_time							= 5,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.41, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.2,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.3,
	},

	fm = {
		mass        = 73.6,
		caliber     = 0.127,
		cx_coeff    = {1,2.7,0.8,1.36,1.75},
		L           = 2.82,
		I           = 1 / 12 * 73.6 * 2.82 * 2.82,
		Ma          = 0.6,
		Mw          = 1.2,
		Sw			= 0.22,
		dCydA		= {0.07, 0.036},
		A			= 0.6,
		maxAoa		= 0.3,
		finsTau		= 0.1,
		freq		= 15,
	},


	seeker = {
		delay			= 0.06,
		FOV				= math.rad(7)*2,
		max_w_LOS		= 999,
		aim_sigma 		= 20,
	},

	IR_seeker = {
		sensitivity		= 10500,
		cooled			= true,
		delay			= 0.04,
		GimbLim			= math.rad(130),
		FOV				= math.rad(7)*2,
		opTime			= 45.0,
		target_H_min	= 0.0,
		flag_dist		= 150.0,
	},

	simple_gyrostab_seeker = {
		omega_max	= math.rad(8)
	},

	fuze_proximity = {
		ignore_inp_armed	= 1,
		radius				= 5,
	},

	autopilot = {
		K				= 60.0,
		Kg				= 2.4,
		Ki				= 0.0,
		finsLimit		= 0.4,
		delay 			= 0.5,
		fin2_coeff		= 0.5,
	},


	warhead = predefined_warhead("RAM"),
	warhead_air = predefined_warhead("RAM")
}

declare_weapon(RIM_116A)

Sea_Cat = {
	category		= CAT_MISSILES,
	name			= "Sea_Cat",
	user_name		= _("GWS-20 Mod. 1 Sea Cat"),
	scheme			= "command_guided_missile_sfe",
	class_name		= "wAmmunitionVikhr",
	model			= "SeaCat",
	mass			= 68,

	Escort			= 3,
	Head_Type		= 7,
	sigma			= {3, 3, 3},
	M				= 68,
	H_max			= 1000.0,
	H_min			= 50,
	Diam			= 220.0,
	Cx_pil			= 2.5,
	D_max			= 6500.0,
	D_min			= 100.0,
	Head_Form		= 1,
	Life_Time		= 22.0,
	Nr_max			= 10,
	v_min			= 0.0,
	v_mid			= 300.0,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 0.9,
	t_marsh			= 17.5,
	Range_max		= 6500.0,
	H_min_t			= 50,
	Fi_start		= 0.03,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.79,
	Fi_search		= 0.09,
	OmViz_max		= 0.2,
	X_back			= -1.455,
	Y_back			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.0182,
	KillDistance	= 5,

	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_SA_Missile, WSTYPE_PLACEHOLDER},

	controller = {
		boost_start = 0,
		march_start = 0.8,
	},

	booster = {
		impulse							= 180,
		fuel_mass						= 10,
		work_time						= 0.8,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-0.66, 0, 0}},
		nozzle_orientationXYZ			= {{0.0, 0.0, 0.0}},
		tail_width						= 0.22,
		smoke_color						= {1.0, 1.0, 1.0},
		smoke_transparency				= 0.9,
		custom_smoke_dissipation_factor	= 2.0,
	},

	march = {
		impulse							= 180,
		fuel_mass						= 17.5,
		work_time						= 17.5,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-0.66, 0, 0}},
		nozzle_orientationXYZ			= {{0.0, 0.0, 0.0}},
		tail_width						= 0.22,
		smoke_color						= {1.0, 1.0, 1.0},
		smoke_transparency				= 0.1,
		custom_smoke_dissipation_factor	= 0.05,
	},

	fm = {
		mass		= 68,
		caliber		= 0.22,
		cx_coeff	= {1, 0.55, 1.0, 0.75, 1.2},
		L			= 1.48,
		I			= 1 / 12 * 68 * 1.48 * 1.48,
		Ma			= 0.4,
		Mw			= 1.2,
		wind_sigma	= 0.0,
		wind_time	= 1000.000000,
		Sw			= 0.5,			--! WIP
		dCydA		= {0.07, 0.036},--!
		A			= 0.6,			--!
		maxAoa		= 0.24,			--!
		finsTau		= 0.1,			--!
		lockRoll	= 1,			--! WIP
	},

	spiral_nav = {
										-- laser guidance simulation--	(use high values for wire/radio guidance)
		t_cone_near_rad			= 0,	-- simple simulation radius (for bots)
		def_cone_max_dist		= 10000,-- laser reach
		def_cone_near_rad		= 0,	-- stab. radius
		def_cone_near_rad_st	= 0,	-- start radius
		def_cone_time_stab_rad	= 0,	-- stab. time

										-- start/dust avoidance program--
		gb_angle				= 0.026,-- start angle above LOS (rad)
		gb_min_dist				= 1,	-- min distance to use this program
		gb_use_time				= 0.7,	-- time trigger: return aim to LOS
		gb_max_retW				= 0.7,	-- ret W max
		gb_ret_Kp				= 1.0,	-- ret power coeff.
	},

	autopilot = {
		Kp					= 0.005,	--P
		Ki					= 0.0000,	--I
		Kd					= 0.0035,	--D
		max_ctrl_angle		= 1.0,		--turn off autopilot after reaching max angle
		delay				= 0.2,		--autopilot delay
		op_time				= 22.0,		--autopilot operation time
		no_ctrl_center_ang	= 0.0,		--blind point at center (rad)
		fins_discreet		= 0.016,
	},

	err = {
		y_error				= 0.015,
		z_error				= 0.015,
		min_time_interval	= 0,
		max_time_interval	= 0.9,
	},

	fuze = {
		default_arm_delays = { 0.8 },
		default_proximity_radius = 5,
	},

	warhead = predefined_warhead("GWS20Mod1"),

	shape_table_data = {{
		name	 = "Sea_Cat",
		file	 = "SeaCat",
		username = "Sea Cat",
		index	 = WSTYPE_PLACEHOLDER,
	}}
}
declare_weapon(Sea_Cat)

Sea_Wolf = {
	category		= CAT_MISSILES,
	name			= "Sea_Wolf",
	user_name		= _("GWS-25 Sea Wolf"),
	scheme			= "command_guided_missile_sfe",
	class_name		= "wAmmunitionVikhr",
	model			= "SeaCat",
	mass			= 68,

	Escort			= 3,
	Head_Type		= 7,
	sigma			= {3, 3, 3},
	M				= 82,
	H_max			= 3000,
	H_min			= 10,
	Diam			= 180,
	Cx_pil			= 2.5,
	D_max			= 6500,
	D_min			= 1000,
	Head_Form		= 1,
	Life_Time		= 22,
	Nr_max			= 10,
	v_min			= 0,
	v_mid			= 500,
	Mach_max		= 3,
	t_b				= 0.0,
	t_acc			= 0.9,
	t_marsh			= 17.5,
	Range_max		= 6500,
	H_min_t			= 10,
	Fi_start		= 0.03,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.79,
	Fi_search		= 0.09,
	OmViz_max		= 0.2,
	X_back			= -1.455,
	Y_back			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.0182,
	KillDistance	= 5,

	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_SA_Missile, WSTYPE_PLACEHOLDER},

	controller = {
		boost_start = 0,
		march_start = 0,
	},

	booster = {
		impulse							= 0,
		fuel_mass						= 0,
		work_time						= 0,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-0.66, 0, 0}},
		nozzle_orientationXYZ			= {{0.0, 0.0, 0.0}},
		tail_width						= 0.18,
		smoke_color						= {1.0, 1.0, 1.0},
		smoke_transparency				= 0.9,
		custom_smoke_dissipation_factor	= 2.0,
	},

	march = {
		impulse							= 215,
		fuel_mass						= 25,
		work_time						= 3,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-0.66, 0, 0}},
		nozzle_orientationXYZ			= {{0.0, 0.0, 0.0}},
		tail_width						= 0.18,
		smoke_color						= {1.0, 1.0, 1.0},
		smoke_transparency				= 0.1,
		custom_smoke_dissipation_factor	= 0.05,
	},

	fm = {
		mass		= 82,
		caliber		= 0.18,
		cx_coeff	= {1, 0.55, 1.0, 0.75, 1.2},
		L			= 1.9,
		I			= 1 / 12 * 82 * 1.9 ^ 2,
		Ma			= 0.4,
		Mw			= 1.2,
		wind_sigma	= 0.0,
		wind_time	= 1000,
		Sw			= 0.5,			--! WIP
		dCydA		= {0.07, 0.036},--!
		A			= 0.6,			--!
		maxAoa		= 0.24,			--!
		finsTau		= 0.1,			--!
		lockRoll	= 1,			--! WIP
	},

	spiral_nav = {
										-- laser guidance simulation--	(use high values for wire/radio guidance)
		t_cone_near_rad			= 0,	-- simple simulation radius (for bots)
		def_cone_max_dist		= 10000,-- laser reach
		def_cone_near_rad		= 0,	-- stab. radius
		def_cone_near_rad_st	= 0,	-- start radius
		def_cone_time_stab_rad	= 0,	-- stab. time

										-- start/dust avoidance program--
		gb_angle				= 0.026,-- start angle above LOS (rad)
		gb_min_dist				= 1,	-- min distance to use this program
		gb_use_time				= 0.7,	-- time trigger: return aim to LOS
		gb_max_retW				= 0.7,	-- ret W max
		gb_ret_Kp				= 1,	-- ret power coeff.
	},

	autopilot = {
		Kp					= 0.005,	--P
		Ki					= 0,		--I
		Kd					= 0.0035,	--D
		max_ctrl_angle		= 1.0,		--turn off autopilot after reaching max angle
		delay				= 0.2,		--autopilot delay
		op_time				= 22,		--autopilot operation time
		no_ctrl_center_ang	= 0,		--blind point at center (rad)
		fins_discreet		= 0.016,
	},

	err = {
		y_error				= 0.005,
		z_error				= 0.005,
		min_time_interval	= 0,
		max_time_interval	= 0.2,
	},

	fuze = {
		default_arm_delays = { 0.8 },
		default_proximity_radius = 5,
	},

	warhead = predefined_warhead("GWS25"),

	shape_table_data = {{
		name	 = "Sea_Wolf",
		file	 = "SeaCat",
		username = "Sea Wolf",
		index	 = WSTYPE_PLACEHOLDER,
	}}
}
declare_weapon(Sea_Wolf)

Sea_Dart = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_SA_Missile, WSTYPE_PLACEHOLDER},
	name			= "Sea_Dart",
	user_name		= _("GWS-30 Sea Dart"),
	class_name		= "wAmmunitionSelfHoming",
	scheme			= "sa_missile_semi_active_ramjet_simple",
	model			= "SeaDart",
	mass			= 549,

	Escort			= 3,
	Head_Type		= 6,
	sigma			= {10, 10, 10},
	M				= 549,
	H_max			= 18300,
	H_min			= 30,
	Diam			= 420,
	Cx_pil			= 2.5,
	D_max			= 56000,
	D_min			= 1000,
	Head_Form		= 1,
	Life_Time		= 600,
	Nr_max			= 10,
	v_min			= 0,
	v_mid			= 300,
	Mach_max		= 3,
	t_b				= 0,
	t_acc			= 0,
	t_marsh			= 17.5,
	Range_max		= 56000,
	H_min_t			= 30,
	Fi_start		= math.rad(120),	-- targeting limit
	Fi_rak			= math.rad(180),	-- target aspect limit
	Fi_excort		= math.rad(0),		-- gimbal limit
	Fi_search		= math.rad(120),	-- instantaneous FOV
	OmViz_max		= math.rad(0),		-- gimbal rotation speed limit
	Reflection		= 0.0182,
	KillDistance	= 15,
	X_back			= -1.214,
	Y_back			= 0,
	Z_back			= 0,
	X_back_acc		= -0.03,
	Y_back_acc		= 0,
	Z_back_acc		= 0,

	booster_anim = {
		start_val = 1
	},

	const = {
		booster_anim_target = 0
	},

	controller = {
		boost_start = 0,
		march_start = 2.9
	},

	boost = {
		impulse							= 230,
		fuel_mass						= 150,
		work_time						= 2.5,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-1.6, 0, 0}},
		nozzle_orientationXYZ			= {{1, 0, 0}},
		tail_width						= 0.42,
		smoke_color						= {0.8, 0.8, 0.8},
		smoke_transparency				= 0.8,
		custom_smoke_dissipation_factor	= 0.2,
		effect_type						= 0,
	},

	march = {
		impulse							= 0,
		fuel_mass						= 80,
		work_time						= 0,
		boost_time						= 0,
		boost_factor					= 0,
		nozzle_position					= {{-0.36, 0, 0}},
		nozzle_orientationXYZ			= {{0, 0, 0}},
		tail_width						= 0.42,
		smoke_color						= {0.9, 0.9, 0.9},
		smoke_transparency				= 0.05,
		custom_smoke_dissipation_factor	= 0.45,
		effect_type						= 1,
		min_start_speed					= 480,

		inlet_area	= 0.045,
		Tchamb_max	= 2270,
		LHVof_fuel	= 43e6,
		AFR_stoich	= 14.9,
		AEC			= 1.18,
	},

	fm = {
		mass		= 549,
		caliber		= 0.42,
		cx_coeff	= {1, 0.6, 1.2, 0.3, 1.6},
		L			= 4.4,
		I			= 1 / 12 * 549 * 4.4 ^ 2,
		Ma			= 0.4,
		Mw			= 1.2,
		wind_sigma	= 0,
		wind_time	= 0,
		Sw			= 0.7,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= math.rad(30),
		finsTau		= 0.1,
		lockRoll	= 1,
		Ma_x		= 0.001,
		Mw_x		= 0.15,
		I_x			= 60,
		draw_fins_conv = {math.rad(90), 1, 1},
	},

	seeker = {
		delay					= 0,
		op_time					= 600,
		FOV						= math.rad(120),
		max_w_LOS				= math.rad(0),
		send_off_data			= 0,
		aim_sigma				= 10,
		sens_near_dist			= 0,
		sens_far_dist			= 56000,
		ccm_k0					= 1.5,
		height_error_k			= 0,
		height_error_max_vel	= 50,
		height_error_max_h		= 500
	},

	simple_gyrostab_seeker = {
		omega_max = 0
	},

	-- Roughly measured: Ku == 100, Tu == 0.902
	autopilot = {
		delay		= 0,
		op_time		= 600,
		K			= 80,
		Ki			= 0,
		Kg			= 9.02,
		finsLimit	= math.rad(20),
		fin2_coeff	= 1
	},

	no_signal_destruct = {
		flag_timer = 10
	},

	proximity_fuze = {
		radius		= 15,
		arm_delay	= 10
	},

	warhead = predefined_warhead("GWS30"),

	shape_table_data = {{
		name	 = "Sea_Dart",
		file	 = "SeaDart",
		username = "Sea Dart",
		index	 = WSTYPE_PLACEHOLDER,
	}},
}
declare_weapon(Sea_Dart)
