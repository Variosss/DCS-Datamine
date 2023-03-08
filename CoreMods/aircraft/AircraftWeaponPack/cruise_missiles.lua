
AGM_84D =
{
	category		= CAT_MISSILES,
	name			= "AGM_84D",
	user_name		= _("AGM-84D"),
	scheme			= "Harpoon",
	class_name		= "wAmmunitionAntiShip",
	model			= "agm-84d",
	mass			= 540,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 540.0,
	H_max			= 12000.0,
	H_min			= -1,
	Diam			= 343.0,
	Cx_pil			= 8,
	D_max			= 180000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 180000.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.08,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 2,
	
	LaunchDistData =
	{
		17,		8,

				50,		75,		100,	150,	200,	250,	300,	350,		
		100,	0,		0,		0,		142200,	147100,	150650,	153525,	155875,	
		200,	0,		0,		117525,	142375,	147350,	150950,	153800,	156200,	
		300,	0,		0,		116750,	142550,	147625,	151250,	154150,	156525,	
		500,	0,		86725,	115325,	143000,	148150,	151825,	154750,	157175,	
		700,	0,		86450,	114025,	143425,	148700,	152400,	156250,	158700,	
		1000,	0,		86050,	112300,	144075,	149450,	153225,	156225,	158750,	
		2000,	96400,	127000,	140150,	148000,	152150,	155650,	158450,	160900,	
		3000,	138900,	144100,	147100,	151200,	154700,	157900,	160700,	162850,	
		4000,	143100,	147400,	150300,	153900,	157000,	159900,	163000,	164800,	
		5000,	145800,	149800,	152700,	156300,	159200,	161800,	164800,	166800,	
		6000,	148000,	151500,	154500,	158000,	160750,	163500,	166000,	168750,	
		7000,	150000,	153000,	156250,	159750,	162500,	165250,	167750,	170750,	
		8000,	151500,	155000,	157750,	161500,	164250,	166750,	169250,	172250,	
		9000,	153000,	155000,	159000,	163250,	165750,	168500,	171000,	173500,	
		10000,	154500,	156000,	160000,	164000,	167500,	170000,	172500,	175500,	
		11000,	155500,	157500,	161500,	165500,	170000,	171500,	175000,	178000,	
		12000,	157000,	158500,	162500,	167000,	170500,	173500,	177000,	180000,	
	},

	MinLaunchDistData =
	{
		17,		8,

				50,		75,		100,	150,	200,	250,	300,	350,		
		100,	0,		0,		0,		16125,	13350,	12600,	12500,	12825,	
		200,	0,		0,		18925,	15775,	13825,	14050,	13975,	14375,	
		300,	0,		0,		18000,	15500,	14975,	15050,	15225,	15425,	
		500,	0,		18400,	16775,	16125,	16000,	16375,	16875,	17000,	
		700,	0,		16725,	16725,	17000,	17075,	17475,	18025,	18475,	
		1000,	0,		15225,	15800,	17675,	18425,	18800,	19375,	20050,	
		2000,	18150,	19350,	20150,	21100,	21700,	22150,	22750,	23550,	
		3000,	22800,	22750,	23100,	23700,	24300,	24850,	25300,	26200,	
		4000,	25400,	25400,	25700,	26200,	26700,	27300,	27600,	28500,	
		5000,	27700,	27800,	28100,	28600,	29100,	29500,	29900,	30700,	
		6000,	30250,	30000,	30250,	30750,	31250,	32000,	32500,	32750,	
		7000,	32250,	32500,	32500,	33250,	33500,	34250,	34750,	35000,	
		8000,	34250,	35000,	34750,	35500,	36000,	36250,	37000,	37500,	
		9000,	36500,	37500,	37250,	37750,	38250,	38750,	39250,	40000,	
		10000,	38500,	39500,	39500,	39500,	40500,	41000,	41500,	42500,	
		11000,	40500,	42000,	41500,	42000,	43000,	43500,	44000,	45000,	
		12000,	42500,	44000,	44000,	44500,	45500,	46000,	46500,	47500,	
	},
	
	add_attributes = {"Cruise missiles"},
	
	shape_table_data =
	{
		{
			name		= "AGM-84D",
			file		= "agm-84d",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-84D"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 540.0,  
		caliber     = 0.343,  
		cx_coeff    = {1,0.39,0.38,0.236,1.31},
		L           = 3.85,
		I           = 1 / 12 * 661.5 * 3.85 * 3.85,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.7,
		dCydA		= {0.07, 0.036},
		A			= 0.5,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.05,
	},
	
	seeker = {
		delay						= 0.0,
		op_time						= 9999.0,
		FOV							= math.rad(60),
		max_w_LOS					= 0.06,
		max_target_speed			= 33.0,
		max_target_speed_rnd_coeff	= 10.0,
		ship_track_by_default		= 1,
		flag_dist					= 5000.0,
		sens_near_dist				= 10.0,
		sens_far_dist				= 65000.0,
		primary_target_filter		= 1,
		add_y						= 1.5,		
		sens_ref_rcs				= 10000.0,
		sens_ref_dist				= 40000.0,
		ship_l_error_k				= 0.33,
	},
	
	autopilot =
	{
		glide_height				= 15.0,
		dont_climb_on_cruise_height	= 1,
		vel_proj_div 				= 6.0,
		default_glide_height		= 1524,
		pre_maneuver_glide_height	= 20,
		skim_glide_height			= 8,
		use_start_bar_height		= 1,	
		altim_vel_k					= 4,
		min_glide_height			= 15,		
		
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 2.0,
		Ks					= 0.9,
		K					= 1.6,
		Kd 					= 0.0,
		Ki 					= 20.0,--10
		Kx					= 0.04,
		Kdx					= 0.001,
		w_limit				= math.rad(5),
		fins_limit			= math.rad(50),
		fins_limit_x		= math.rad(25),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	0,
								500,	0},
								
		max_climb_angle		= math.rad(10),
		max_dive_angle		= math.rad(-25),
		max_climb_ang_hdiff	= 200,
		max_dive_ang_hdiff	= -500,
		
		Ksd						= 0.0,
		Ksi						= 0.0,
		integr_val_limit		= 0.5,
		hor_err_limit			= 0.5,
		max_climb_vel			= 200,
		min_climb_vel			= 120,
		min_climb_vel_factor	= 0,
		max_climb_h				= 3000,
		min_climb_h				= 10000,
		min_climb_h_factor		= 0.5,
		
		inertial_km_error		= 0.5,
		glide_height_eq_error	= 0.01,
		glide_height_abs_error	= 1.5,
	},	
	
	final_autopilot = {
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.0,
		Ks					= 8.0,
		K					= 5.4,
		Kd 					= 0.0,
		Ki 					= 0.0,
		Kx					= 0.0,
		Kix					= 0.0,
		w_limit				= math.rad(15),
		fins_limit			= math.rad(50),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	1,
								500,	1},
								
		add_err_val				= 0,
		add_err_vert			= 0,
		add_out_val				= 0.03,
		add_out_vert			= 1,
		loft_angle				= math.rad(8),
		loft_trig_angle			= math.rad(14),
		K_loft_err				= 1,
		loft_angle_vert			= 1,
		loft_active_by_default	= 0,
	},
	
	triggers_control = {
		sensor_tg_dist			= 8000, -- turn on seeker and start horiz. correction if target is locked
		final_maneuver_tg_dist	= 4000,
		straight_nav_tg_dist	= 1000,
		self_destruct_tg_dist	= 1000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		target_upd_jump_dist	= 40000,
		update_pos_from_input	= 0,
		can_increase_tg_dist	= 1,
		
		send_final_maneuver_by_default	= 0,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 15,
		
		check_self_destruct_dist_with_no_target = 1,
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0,
	},
	
	boost = {				--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse			= 3300,
		fuel_mass		= 32.0,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-1.70, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.5,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,	
		
		start_burn_effect			= 1,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
	},
	
	engine_control = {
		default_speed	= 237,
		K				= 350,
		Kd				= 1.0,
		Ki				= 0.001,
		speed_delta		= 5,
	},
	
	warhead		= predefined_warhead("AGM_84D"),
	warhead_air = predefined_warhead("AGM_84D"),
}

declare_weapon(AGM_84D)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_84D}",
	attribute		= AGM_84D.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "agm84d.png",
	displayName		= _("AGM-84D Harpoon AShM"),
	Weight			= AGM_84D.mass,
	Elements  		= {{ShapeName = "agm-84d"}},
})

AGM_84H =
{
	category		= CAT_MISSILES,
	name			= "AGM_84H",
	user_name		= _("AGM-84H"),
	scheme			= "sat_cruise_missile",
	class_name		= "wAmmunitionAntiShip",
	model			= "agm-84h",
	mass			= 675,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 675.0,
	H_max			= 13000.0,
	H_min			= -1,
	Diam			= 343.0,
	Cx_pil			= 8,
	D_max			= 270000.0,
	D_min			= 10000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 270000.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= -3.392,
	Y_back			= 0.064,
	Z_back			= 0.0,
	Reflection		= 0.1,
	KillDistance	= 0.0,
	
	add_attributes = {"Cruise missiles"},
	
	encyclopediaAnimation = {
		args = {
			[25] = 1.000000, -- wings open
		},
	},
		
	shape_table_data =
	{
		{
			name	 = "AGM-84H",
			file	 = "agm-84h",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("AGM-84H"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0.8,
	},
	
	fm = {
		mass        = 675,  
		caliber     = 0.343,  
		cx_coeff    = {1, 0.3, 0.65, 0.023, 1.6},
		L           = 4.37,
		I           = 1500,
		Ma          = 3,	--y
		Mw          = 10,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.2,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.2,
		finsTau		= 0.08,
		Ma_x		= 1.2,
		Ma_z		= 3,
		Mw_x		= 2.7,
		
		addDeplSw			= 0.6,
		no_wings_A_mlt		= 7,
		wingsDeplProcTime	= 5,
		wingsDeplDelay		= 1,	
	},
	
	seeker = {
		coalition				= 2,
		coalition_rnd_coeff		= 5.0,
		can_update_target_pos	= 1,
	},
	
	control_block ={
		seeker_activation_dist		= 20000,
		default_cruise_height		= 50,
		obj_sensor					= 0,
		can_update_target_pos		= 1,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.5,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
		use_horiz_dist				= 1,
	},
	
	final_autopilot =		{
		delay = 0,
		K					= 60,
		Ki					= 0,
		Kg					= 4,
		finsLimit			= 0.8,
		useJumpByDefault	= 1,
		J_Power_K			= 1.5,
		J_Diff_K			= 0.4,
		J_Int_K				= 0,
		J_Angle_K			= 0.22,
		J_FinAngle_K		= 0.35,
		J_Angle_W			= 0.6,
		J_Trigger_Vert		= 1,
		hKp_err				= 120,
		hKp_err_croll		= 0.04,
		hKd					= 0.005,
		max_roll			= 0.8,
	},
	
	cruise_autopilot = {
		delay				= 1,
		Kp_hor_err			= 240,
		Kp_hor_err_croll	= 0.06,
		Kd_hor				= 0,
		Kp_ver				= 9,
		Kii_ver				= 0.2,
		Kd_ver				= 0,
		Kp_eng				= 265,
		Ki_eng				= 0.003,
		Kd_eng				= 0,
		Kp_ver_st1			= 0.009,
		Kd_ver_st1			= 0.015,
		Kp_ver_st2			= 0.00018,
		Kd_ver_st2			= 0.00005,
		
		auto_terrain_following			= 1,
		auto_terrain_following_height	= 50,
		
		alg_points_num			= 7,
		alg_calc_time			= 1.5,
		alg_vel_k				= 6,
		alg_div_k				= 2,
		alg_max_sin_climb		= 0.8,
		alg_section_temp_points	= 3,
		alg_tmp_point_vel_k		= 1.5,
		no_alg_vel_k			= 10,
		
		max_roll			= 0.8,
		max_start_y_vel		= 35,
		stab_vel			= 237.5,
		finsLimit			= 0.8,
		estimated_N_max		= 6,
		eng_min_thrust		= -100,
		eng_max_thrust		= 3000,		
	},
	
	boost = {	--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	booster_animation = {
		start_val = 0,
	},
	
	play_booster_animation = {
		val = 0,
	},
	
	march = {
		impulse			= 690,
		fuel_mass		= 67.5,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-2.25, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.5,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,	
		
		start_burn_effect			= 1,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
		
	},
	
	warhead		= predefined_warhead("AGM_84H"),
	warhead_air = predefined_warhead("AGM_84H"),
}

declare_weapon(AGM_84H)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_84H}",
	attribute		= AGM_84H.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "agm84h.png",
	displayName		= _("AGM-84H SLAM-ER (Expanded Response)"),
	Weight			= AGM_84H.mass,
	Elements  		= {{ShapeName = "agm-84h"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_84E}",
	attribute		= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,63},
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "agm84e.png",
	displayName		= _('AGM-84E Harpoon/SLAM (Stand-Off Land-Attack Missile)'),
	Weight			= 628,
	Elements  		= {{ShapeName = "agm-84e"}},
})

X_59M =
{
	category		= CAT_MISSILES,
	name			= "X_59M",
	user_name		= _("Kh-59M (AS-18 Kazoo)"),
	scheme			= "AGM-84E",
	class_name		= "wAmmunitionAntiShip",
	model			= "X-59M",
	mass			= 930,

	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,X_59M}, -- 54

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {10, 10, 10},
	M				= 930,
	H_max			= 10000,
	H_min			= -1,
	Diam			= 380,
	Cx_pil			= 19.64,
	D_max			= 115000,
	D_min			= 10000,
	Head_Form		= 0,
	Life_Time		= 1800,
	Nr_max			= 16,
	v_min			= 170,
	v_mid			= 250,
	Mach_max		= 0.85,
	t_b				= 0,
	t_acc			= 6,
	t_marsh			= 500,
	Range_max		= 115000,
	H_min_t			= 0,
	Fi_start		= 0.37,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	Reflection		= 0.2,
	KillDistance	= 0,
	X_back			= -0.88,
	Y_back			=-0.67,
	Z_back			= 0,
	X_back_acc		= -3,
	Y_back_acc		= -0.196,
	Z_back_acc		= 0,

	add_attributes = {"Cruise missiles"},

	shape_table_data = {{
		name	 = "X-59M",
		file	 = "X-59M",
		username = _("Kh-59M"),
		index	 = WSTYPE_PLACEHOLDER,
	}},

	controller = {
		boost_start = 0,
		march_start = 1,
	},

	fm = {
		mass		= 930,
		caliber		= 0.380,
		cx_coeff	= {1, 0.3, 0.65, 0.018, 1.6},
		L			= 5.37,
		I			= 1500,
		Ma			= 3,
		Mw			= 10,
		wind_sigma	= 0,
		wind_time	= 0,
		Sw			= 1.2,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.2,
		finsTau		= 0.08,
		Ma_x		= 1.2,
		Ma_z		= 3,
		Mw_x		= 2.7,

		addDeplSw			= 0.6,
		no_wings_A_mlt		= 7,
		wingsDeplProcTime	= 5,
		wingsDeplDelay		= 1,
	},

	seeker = {
		delay				= 0,
		op_time				= 800,
		activate_on_update	= 1,
		FOV					= math.rad(60),
		max_w_LOS			= 0.5,
		max_w_LOS_surf		= 0.016,

		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,

		max_lock_dist		= 40000,
	},

	ins = {
		aim_sigma		= 350,
		check_AI		= 1,
		error_coeff		= 0.05,
	},

	control_block = {
		default_cruise_height		= 100,
	},

	triggers_control = {
		action_wait_timer				= 5,	-- wait for dist functions n sen, then set default values
		default_sensor_tg_dist			= 40000, -- turn on seeker and start horiz. correction if target is locked
		default_final_maneuver_tg_dist	= 7000,
		default_straight_nav_tg_dist	= 7000,
		default_destruct_tg_dist		= 3000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		trigger_by_path					= 0,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 100,	-- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance
		min_cruise_height				= 100,
		min_cruise_height_trigger_sum	= 0,
		min_cruise_height_trigger_mlt	= 0,
	},

	autopilot = {
		glide_height				= 100,
		dont_climb_on_cruise_height	= 0,
		vel_proj_div 				= 6,
		default_glide_height		= 100,
		pre_maneuver_glide_height	= 100,
		skim_glide_height			= 100,
		use_start_bar_height		= 1,
		altim_vel_k					= 4,

		delay				= 1,
		op_time				= 9999,
		Kw					= 3.5,
		Ks					= 0.9,
		K					= 1.4,
		Kd 					= 0,
		Ki 					= 20,
		Kx					= 0.04,
		Kdx					= 0.001,
		w_limit				= math.rad(5),
		fins_limit			= math.rad(50),
		fins_limit_x		= math.rad(25),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	0,
								500,	0},

		max_climb_angle		= math.rad(10),
		max_dive_angle		= math.rad(-25),
		max_climb_ang_hdiff	= 200,
		max_dive_ang_hdiff	= -500,

		Ksd						= 0,
		Ksi						= 0,
		integr_val_limit		= 0.5,
		hor_err_limit			= 0.5,
		max_climb_vel			= 200,
		min_climb_vel			= 120,
		min_climb_vel_factor	= 0,
		max_climb_h				= 3000,
		min_climb_h				= 10000,
		min_climb_h_factor		= 0.5,
	},

	final_autopilot = {
		delay				= 1,
		op_time				= 9999,
		Kw					= 1,
		Ks					= 5,
		K					= 5,
		Kd 					= 0,
		Ki 					= 0,
		Kx					= 0,
		Kix					= 0,
		w_limit				= math.rad(15),
		fins_limit			= math.rad(50),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	1,
								500,	1},

		add_err_val				= 0,
		add_err_vert			= 0,
		add_out_val				= 0.1,
		add_out_vert			= 1,
		loft_angle				= math.rad(8),
		loft_trig_angle			= math.rad(14),
		K_loft_err				= 1,
		loft_angle_vert			= 1,
		loft_active_by_default	= 0,
	},

	boost = {
		impulse								= 235,
		fuel_mass							= 25.5,
		work_time							= 1,
		nozzle_position						= {{-3, -0.196, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0.0}},
		nozzle_exit_area 					= 0.01368,
		tail_width							= 0.5,
		smoke_color							= {0.9, 0.9, 0.9},
		smoke_transparency					= 0.1,
		custom_smoke_dissipation_factor		= 0.3,
	},

	march = {
		impulse			= 550,
		fuel_mass		= 138.5,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3400,
		thrust_Tau		= 0.0017,

		nozzle_position						= {{-0.88, -0.67, 0.0}},
		nozzle_orientationXYZ				= {{0, 0, 0.0}},
		tail_width							= 0.2,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.2,
		custom_smoke_dissipation_factor		= 0.2,

		start_burn_effect			= 1,
		start_effect_delay			= {0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1,		1,	1.0},
		start_effect_x_dist			= {0,		0,	0.0},
		start_effect_x_shift		= {0, 0, 0.0},
	},

	engine_control = {
		default_speed	= 285,
		K				= 240,
		Kd				= 1,
		Ki				= 0.01,
		speed_delta		= 5,
	},

	warhead		= predefined_warhead("X_59M"),
	warhead_air = predefined_warhead("X_59M"),
}

declare_weapon(X_59M)

declare_loadout({
	category		= CAT_MISSILES,
	CLSID			= "{40AB87E8-BEFB-4D85-90D9-B2753ACF9514}",
	wsTypeOfWeapon	= X_59M.wsTypeOfWeapon,
	attribute		= {wsType_Weapon, wsType_Missile, wsType_Container, AKU_58_X_59, "Cruise missiles"}, -- 171
	Count			= 1,
	Cx_pil			= 0.0018,
	Picture			= "kh59m.png",
	displayName		= _("Kh-59M (AS-18 Kazoo) - 930kg, ASM, IN"),
	NatoName		= "(AS-18)",
	Weight			= X_59M.mass + 186,
	Weight_Empty	= 186,
	Elements		= {
		{ ShapeName = "AKU-58" },
		{ Position = {-0.428, -0.234, 0}, ShapeName = "X-59M" }
	}
})

C_802AK =
{
	category		= CAT_MISSILES,
	name			= "C_802AK",
	user_name		= _("C-802AK"),
	scheme			= "Harpoon",
	class_name		= "wAmmunitionAntiShip",
	model			= "c802ak",
	mass			= 600,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 600.0,
	H_max			= 12000.0,
	H_min			= -1,
	Diam			= 360.0,
	Cx_pil			= 8,
	D_max			= 250000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 237.5,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 250000.0,
	H_min_t			= 500.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.25,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 2,
	
	add_attributes = {"Cruise missiles"},
	
	LaunchDistData =
	{
		19,		8,

				200,	250,	300,	350,	400,	450,	500,	550,		
		100,	155700,	159000,	161800,	164200,	166300,	168400,	170600,	173200,	
		300,	156400,	159700,	162400,	164700,	166800,	168700,	171100,	173600,	
		500,	157100,	160200,	162900,	165100,	167000,	169000,	171300,	173900,	
		700,	157500,	160800,	163200,	165500,	167400,	169400,	171800,	174300,	
		1000,	158300,	161600,	164000,	166200,	168100,	170000,	172300,	174900,	
		2000,	160800,	164200,	166300,	168300,	170000,	171900,	174200,	176700,	
		3000,	163000,	166200,	168600,	170200,	172100,	173900,	176000,	178700,	
		4000,	164900,	167700,	170800,	172400,	174000,	175900,	178200,	180700,	
		5000,	166800,	169400,	173000,	174400,	176000,	177800,	180200,	182800,	
		6000,	168400,	171200,	174400,	176400,	177800,	179800,	182200,	184800,	
		7000,	170400,	173000,	175400,	178600,	180000,	181800,	184200,	187000,	
		8000,	171800,	174400,	176800,	180600,	182200,	184000,	186200,	189000,	
		9000,	173200,	175800,	178400,	181800,	184400,	186200,	188600,	191200,	
		10000,	175000,	177000,	179500,	182500,	186000,	188000,	190500,	193000,	
		11000,	176000,	179000,	181000,	184000,	187500,	190500,	193000,	195500,	
		12000,	177500,	180500,	183000,	186000,	189500,	193000,	195000,	198000,	
		13000,	179000,	182000,	184500,	188000,	191000,	194500,	197500,	200000,	
		14000,	181000,	184000,	187000,	190000,	193000,	196000,	199500,	202000,	
		15000,	182500,	186000,	189000,	192000,	195000,	198000,	201000,	204500,	
	},

	MinLaunchDistData =
	{
		19,		8,

				200,	250,	300,	350,	400,	450,	500,	550,		
		100,	20200,	20500,	20400,	20700,	21000,	21500,	22300,	22500,	
		300,	22600,	23000,	23400,	23500,	24100,	24700,	25300,	26100,	
		500,	23900,	24300,	24900,	25200,	25700,	26400,	27200,	28100,	
		700,	25000,	25400,	26000,	26600,	26900,	27700,	28600,	29600,	
		1000,	26200,	26600,	27300,	28100,	28800,	29200,	30200,	31300,	
		2000,	29400,	29700,	30500,	31500,	32300,	33300,	34300,	35500,	
		3000,	32000,	32300,	33000,	34000,	35000,	36100,	37500,	38800,	
		4000,	34300,	34900,	35300,	36200,	37300,	38600,	40100,	41800,	
		5000,	36800,	37200,	37600,	38400,	39400,	40800,	42400,	44400,	
		6000,	38800,	39400,	39800,	40600,	41400,	42800,	44800,	46600,	
		7000,	41200,	41800,	42400,	42800,	43600,	45000,	46800,	49000,	
		8000,	43600,	44000,	44400,	45000,	45800,	47200,	49000,	51200,	
		9000,	45800,	46200,	46800,	47200,	48000,	49400,	51400,	53400,	
		10000,	48000,	48500,	49500,	50000,	50000,	51500,	53500,	56000,	
		11000,	50500,	51000,	51500,	52500,	52500,	53500,	56000,	58000,	
		12000,	53000,	53500,	54000,	55000,	56000,	56000,	58000,	60500,	
		13000,	55500,	56000,	56500,	58000,	59000,	59500,	60500,	62500,	
		14000,	58000,	59000,	59500,	60500,	62000,	63000,	63000,	65000,	
		15000,	60500,	61500,	62500,	63500,	65000,	66000,	67000,	67500,	
	},
	
	shape_table_data =
	{
		{
			name		= "C_802AK",
			file		= "c802ak",
			life		= 1,
			fire		= { 0, 1},
			username	= _("C-802AK"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 600.0,  
		caliber     = 0.360,  
		cx_coeff    = {1,0.39,0.38,0.3,1.31},
		L           = 5.25,
		I           = 1 / 12 * 600.0 * 5.25 * 5.25,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.95,
		dCydA		= {0.07, 0.036},
		A			= 0.5,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.01,
	},
	
	seeker = {
		delay						= 0.0,
		op_time						= 9999.0,
		FOV							= math.rad(60),
		max_w_LOS					= 0.06,
		max_target_speed			= 33.0,
		max_target_speed_rnd_coeff	= 10.0,
		ship_track_by_default		= 1,
		flag_dist					= 5000.0,
		sens_near_dist				= 10.0,
		sens_far_dist				= 65000.0,
		primary_target_filter		= 1,
		add_y						= 1.5,		
		sens_ref_rcs				= 10000.0,
		sens_ref_dist				= 40000.0,
	},
	
	autopilot =
	{
		dont_climb_on_cruise_height	= 0,
		vel_proj_div 				= 6.0,
		default_glide_height		= 1000.0,
		min_glide_height			= 18.0,
		pre_maneuver_glide_height	= 18.0,
		skim_glide_height			= 8,
		use_start_bar_height		= 1,	
		altim_vel_k					= 4,	
		
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.4,
		Ks					= 2.0,
		K					= 1.8,
		Kd 					= 0.0,
		Ki 					= 16.0,
		Kx					= 0.04,
		Kdx					= 0.001,
		w_limit				= math.rad(5),
		fins_limit			= math.rad(35),
		fins_limit_x		= math.rad(20),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	0,
								500,	0},
								
		max_climb_angle		= math.rad(10),
		max_dive_angle		= math.rad(-25),
		max_climb_ang_hdiff	= 200,
		max_dive_ang_hdiff	= -500,
		
		Ksd						= 0.0,
		Ksi						= 0.0,
		integr_val_limit		= 0.5,
		hor_err_limit			= 0.5,
		max_climb_vel			= 200,
		min_climb_vel			= 120,
		min_climb_vel_factor	= 0,
		max_climb_h				= 3000,
		min_climb_h				= 10000,
		min_climb_h_factor		= 0.5,
		
		inertial_km_error		= 4.0,		-- m for 1000m dist
		glide_height_eq_error	= 2.0,		-- percent
	},	
	
	final_autopilot = {
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.0,
		Ks					= 5.0,
		K					= 6.0,
		Kd 					= 0.0,
		Ki 					= 0.0,
		Kx					= 0.0,
		Kix					= 0.0,
		w_limit				= math.rad(15),
		fins_limit			= math.rad(50),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	1,
								500,	1},
								
		add_err_val				= 0,
		add_err_vert			= 0,
		add_out_val				= 0.075,
		add_out_vert			= 1,
		loft_angle				= math.rad(7),
		loft_trig_angle			= math.rad(12),
		K_loft_err				= 1,
		loft_angle_vert			= 1,
		loft_active_by_default	= 0,
	},
	
	triggers_control = {
		sensor_tg_dist			= 10000, -- turn on seeker and start horiz. correction if target is locked
		final_maneuver_tg_dist	= 6000,
		straight_nav_tg_dist	= 1000,
		self_destruct_tg_dist	= 1000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		target_upd_jump_dist	= 40000,
		update_pos_from_input	= 0,
		can_increase_tg_dist	= 1,
		
		send_final_maneuver_by_default	= 1,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 1000,	-- triggers st nav instead 
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0,
	},
	
	boost = {				--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse			= 650,
		fuel_mass		= 180,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 4000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-2.50, -0.18, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.5,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,	
		
		start_burn_effect			= 1,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
	},
	
	engine_control = {
		default_speed	= 220,
		K				= 350,
		Kd				= 1.0,
		Ki				= 0.001,
		speed_delta		= 5,
	},
	
	warhead		= predefined_warhead("C_802A"),
	warhead_air = predefined_warhead("C_802A"),
}

declare_weapon(C_802AK)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{C_802AK}",
	attribute		= C_802AK.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "c802.png",
	displayName		= _("C-802AK"),
	Weight			= C_802AK.mass,
	Elements  		= {{ShapeName = "c802ak"}},
})

CM_802AKG =
{
	category		= CAT_MISSILES,
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	
	name			= "CM_802AKG",
	display_name	= _('AGM-84E'),
	user_name		= _("CM-802AKG"),
	
	scheme			= "AGM-84E",
	class_name		= "wAmmunitionAntiShip",
	model			= "cm802akg",
	
	Escort		= 0,
	Head_Type	= 5,
	sigma		= {25, 25, 25},
	M			= 670.0,
	H_max		= 10000.0,
	H_min		= 500,
	Diam		= 360.0,
	Cx_pil		= 8,
	D_max		= 230000.0,
	D_min		= 5000.0,
	Head_Form	= 0,
	Life_Time	= 1850.0,
	Nr_max		= 18,
	v_min		= 150.0,
	v_mid		= 272.0,
	Mach_max	= 0.9,
	t_b			= 0.01,
	t_acc		= 5.0,
	t_marsh		= 1800.0,
	Range_max	= 230000.0,
	H_min_t		= 0.0,
	Fi_start	= 0.5,
	Fi_rak		= 3.14152,
	Fi_excort	= 1.05,
	Fi_search	= 99.9,
	OmViz_max	= 99.9,

	X_back			= -1.581,
	Y_back			= 0,
	Z_back			= 0.0,
	Reflection		= 0.25,
	KillDistance	= 0.0,
		
	Damage_correction_coeff = 0.7,
	
	add_attributes = {"Cruise missiles"},
	
	LaunchDistData =
	{
		20,		7,

				100,	150,	200,	250,	300,	350,	400,		
		500,	0,		75790,	83280,	87490,	90390,	93090,	93850,	
		600,	0,		73690,	81610,	85620,	88750,	91500,	93860,	
		700,	0,		74170,	82540,	86570,	89730,	92470,	94870,	
		800,	0,		75175,	83750,	87775,	90975,	93725,	96150,	
		900,	0,		75925,	84675,	88775,	91975,	94725,	97175,	
		1000,	0,		76500,	85425,	89550,	92750,	95525,	97975,	
		2000,	0,		79850,	87125,	91600,	95050,	98075,	100775,	
		3000,	81550,	87150,	91150,	94750,	97750,	100250,	102700,	
		4000,	85350,	89850,	93850,	97400,	100900,	103100,	105300,	
		5000,	87500,	92200,	96300,	100000,	103600,	106300,	108700,	
		6000,	90000,	94500,	98500,	102250,	106000,	109250,	112000,	
		7000,	91750,	96500,	101000,	105000,	108750,	112250,	115250,	
		8000,	93750,	98750,	103250,	107500,	111250,	115000,	118500,	
		9000,	95750,	101000,	105750,	110000,	114000,	118000,	122000,	
		10000,	97250,	102750,	108000,	113000,	117250,	121500,	126000,	
		11000,	98500,	104500,	110500,	115500,	120500,	125500,	130500,	
		12000,	100000,	106000,	112500,	119000,	124500,	130000,	135500,	
		13000,	101500,	108000,	115000,	122500,	128500,	136000,	142000,	
		14000,	103000,	110000,	117500,	126000,	133500,	141500,	148000,	
		15000,	103500,	112000,	120000,	129500,	139000,	148500,	155000,	
	},

	MinLaunchDistData =
	{
		20,		7,

				100,	150,	200,	250,	300,	350,	400,		
		500,	0,		14540,	7320,	11250,	8260,	8680,	8970,	
		600,	0,		11400,	7290,	7780,	8230,	8650,	9040,	
		700,	0,		7410,	7410,	7890,	8350,	8770,	9160,	
		800,	0,		7800,	7525,	8025,	8475,	8900,	9300,	
		900,	0,		8325,	7650,	8125,	8575,	9025,	9425,	
		1000,	0,		9325,	7725,	8225,	8675,	9100,	9500,	
		2000,	0,		9200,	8100,	8250,	8825,	9225,	9725,	
		3000,	6050,	6900,	7650,	8200,	8550,	8950,	9350,	
		4000,	6350,	7000,	7500,	7950,	8300,	8650,	9000,	
		5000,	6600,	7300,	7100,	8000,	8500,	8800,	9200,	
		6000,	12750,	7500,	7250,	8250,	8750,	9000,	9500,	
		7000,	13250,	7750,	7250,	8500,	8750,	9250,	9750,	
		8000,	14250,	8250,	8500,	8750,	9250,	9500,	10000,	
		9000,	15000,	14000,	8750,	9250,	9500,	10000,	10500,	
		10000,	16000,	14750,	9250,	9500,	10000,	10250,	10750,	
		11000,	17000,	16000,	14500,	10500,	11000,	11000,	11500,	
		12000,	18500,	17500,	16000,	11000,	11500,	12000,	12500,	
		13000,	19500,	19000,	18000,	16500,	12500,	19500,	22500,	
		14000,	21000,	20500,	20000,	19000,	18000,	27000,	30000,	
		15000,	22500,	22500,	22000,	22000,	31000,	35500,	39000,	
	},		
	
	shape_table_data =
	{
		{
			name		= "CM_802AKG",
			file		= "cm802akg",
			life		= 1,
			fire		= { 0, 1},
			username	= _("CM-802AKG"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 670.0,  
		caliber     = 0.360,  
		cx_coeff    = {1,0.39,0.38,0.3,1.31},
		L           = 5.25,
		I           = 1 / 12 * 600.0 * 5.25 * 5.25,
		Ma          = 0.68,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 1000.0,
		Sw			= 0.95,
		dCydA		= {0.07, 0.036},
		A			= 0.5,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.01,
	},
	
	seeker = {
		delay				= 0.0,
		op_time				= 800,
		activate_on_update	= 1,

		FOV					= math.rad(60),
		max_w_LOS			= 0.06,
		max_w_LOS_surf		= 0.03,

		max_target_speed			= 33,
		max_target_speed_rnd_coeff	= 10,

		max_lock_dist		= 30000,
	},
	
	ins = {
		aim_sigma		= 350,
		check_AI		= 1,
		error_coeff		= 0.05,
	},
	
	autopilot =
	{
		glide_height				= 1000.0,
		dont_climb_on_cruise_height	= 0,
		vel_proj_div 				= 6.0,
		default_glide_height		= 1000.0,
		pre_maneuver_glide_height	= 1000.0,
		skim_glide_height			= 8,
		use_start_bar_height		= 1,	
		altim_vel_k					= 4,	
		
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.6,
		Ks					= 2.0,
		K					= 1.7,
		Kd 					= 0.0,
		Ki 					= 16.0,
		Kx					= 0.04,
		Kdx					= 0.001,
		w_limit				= math.rad(5),
		fins_limit			= math.rad(35),
		fins_limit_x		= math.rad(20),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	0,
								500,	0},
								
		max_climb_angle		= math.rad(10),
		max_dive_angle		= math.rad(-25),
		max_climb_ang_hdiff	= 200,
		max_dive_ang_hdiff	= -500,
		
		Ksd						= 0.0,
		Ksi						= 0.0,
		integr_val_limit		= 0.5,
		hor_err_limit			= 0.5,
		max_climb_vel			= 200,
		min_climb_vel			= 120,
		min_climb_vel_factor	= 0,
		max_climb_h				= 3000,
		min_climb_h				= 10000,
		min_climb_h_factor		= 0.5,
		
		inertial_km_error		= 4.0,		-- m for 1000m dist
		glide_height_eq_error	= 2.0,		-- percent
	},	
	
	final_autopilot = {
		delay				= 1.0,
		op_time				= 9999,
		Kw					= 1.0,
		Ks					= 5.0,
		K					= 5.4,
		Kd 					= 0.0,
		Ki 					= 0.0,
		Kx					= 0.0,
		Kix					= 0.0,
		w_limit				= math.rad(15),
		fins_limit			= math.rad(50),
		rotated_WLOS_input	= 0,
		conv_input			= 0,
		PN_dist_data 		= {	2000,	1,
								500,	1},
								
		add_err_val				= 0,
		add_err_vert			= 0,
		add_out_val				= 0.1,
		add_out_vert			= 1,
		loft_angle				= math.rad(7),
		loft_trig_angle			= math.rad(12),
		K_loft_err				= 1,
		loft_angle_vert			= 1,
		loft_active_by_default	= 0,
	},
	
	triggers_control = {
		action_wait_timer				= 5,	-- wait for dist functions n sen, then set default values
		default_sensor_tg_dist			= 10000, -- turn on seeker and start horiz. correction if target is locked
		default_final_maneuver_tg_dist	= 7000,
		default_straight_nav_tg_dist	= 7000,
		default_destruct_tg_dist		= 3000,	-- if seeker still can not find a target explode warhead after reaching pred. target point + n. km
		trigger_by_path					= 1,
		final_maneuver_trig_v_lim		= 3,
		use_horiz_dist					= 1,
		pre_maneuver_glide_height		= 1000,	-- triggers st nav instead of fin. maneuver if h>2*pre_maneuver_glide_height at fin. maneuver distance
		min_cruise_height				= 1000,
		min_cruise_height_trigger_sum	= 11000,
		min_cruise_height_trigger_mlt	= 220/33,
	},
	
	control_block = {
		default_cruise_height = 1000.0,
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0,
	},
	
	boost = {				--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse			= 650,
		fuel_mass		= 180,
		work_time		= 9999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 4000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-2.50, -0.18, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.5,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,	
		
		start_burn_effect			= 1,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
	},
	
	engine_control = {
		default_speed	= 220,
		K				= 350,
		Kd				= 1.0,
		Ki				= 0.001,
		speed_delta		= 5,
	},
	
	warhead		= predefined_warhead("C_802A"),
	warhead_air = predefined_warhead("C_802A"),
}

declare_weapon(CM_802AKG)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{CM_802AKG}",
	attribute		= CM_802AKG.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "c802akg.png",
	displayName		= _("CM-802AKG"),
	Weight			= CM_802AKG.mass,
	Elements  		= {{ShapeName = "cm802akg"}},
})

AGM_86C =
{
	category		= CAT_MISSILES,
	name			= "AGM_86C",
	user_name		= _("AGM-86C"),
	scheme			= "sat_cruise_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "agm-86",
	mass			= 2050,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 1950.0,
	H_max			= 13000.0,
	H_min			= -1,
	Diam			= 697.0,
	Cx_pil			= 8,
	D_max			= 1200000.0,
	D_min			= 20000.0,
	Head_Form		= 0,
	Life_Time		= 10000,
	Nr_max			= 6,
	v_min			= 170.0,
	v_mid			= 220.0,
	Mach_max		= 0.9,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 1200000.0,
	H_min_t			= 0.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= -3.392,
	Y_back			= 0.064,
	Z_back			= 0.0,
	Reflection		= 0.1691,
	KillDistance	= 0.0,
	
	
	LaunchDistData =
	{
		4,		4,

				100,		125,		175,		250,		
		500,	0,			0,			1170000,	1200000,	
		2000,	1185000,	1185000,	1190000,	1230000,	
		7000,	1220000,	1235000,	1240000,	1245000,	
		13000,	1250000,	1250000,	1260000,	1260000,	
	},
	
	MinLaunchDistData =
	{
		4,		4,

				100,		125,		175,		250,		
		500,	0,			0,			18500,		20000,	
		2000,	21000,		24000,		26000,		63000,	
		7000,	48000,		55000,		56000,		63000,	
		13000,	84000,		88000,		95000,		100000,	
	},
	
	add_attributes = {"Cruise missiles"},
	
	encyclopediaAnimation = {
		args = {
			[25] = 1.000000, -- wings open
		},
	},
		
	shape_table_data =
	{
		{
			name	 = "AGM-86C",
			file	 = "agm-86",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("AGM-86C"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 1950,  
		caliber     = 0.697,  
		cx_coeff    = {1, 0.3, 0.65, 0.023, 1.6},
		L           = 6.6,
		I           = 1 / 12 * 2050.0 * 6.6 * 6.6,
		Ma          = 3,	--y
		Mw          = 10,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.7,
		dCydA		= {0.07, 0.036},
		A			= 0.08,
		maxAoa		= 0.2,
		finsTau		= 0.08,
		Ma_x		= 1.2,
		Ma_z		= 3,
		Mw_x		= 2.7,
		
		addDeplSw			= 0.8,
		no_wings_A_mlt		= 7,
		wingsDeplProcTime	= 5,
		wingsDeplDelay		= 1,	
	},

	seeker = {
		coalition				= 2,
		coalition_rnd_coeff		= 5.0,
		can_update_target_pos	= 1,
	},

	control_block ={
		seeker_activation_dist		= 15500,
		default_cruise_height		= 55,
		obj_sensor					= 0,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.8,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
		use_horiz_dist				= 1,
	},
	
	final_autopilot =		{
		delay				= 0,
		K					= 70,
		Ki					= 0,
		Kg					= 4,
		finsLimit			= 0.8,
		useJumpByDefault	= 1,
		J_Power_K			= 2.2,
		J_Diff_K			= 0.4,
		J_Int_K				= 0.001,
		J_Angle_K			= 0.18,
		J_FinAngle_K		= 0.32,
		J_Angle_W			= 0.8,
		J_Trigger_Vert		= 1,
		hKp_err				= 120,
		hKp_err_croll		= 0.04,
		hKd					= 0.005,
		max_roll			= 0.8,
	},
	
	cruise_autopilot = {
		delay				= 1,
		Kp_hor_err			= 240,
		Kp_hor_err_croll	= 0.06,
		Kd_hor				= 0,
		Kp_ver				= 9,
		Kii_ver				= 0.2,
		Kd_ver				= 0,
		Kp_eng				= 265,
		Ki_eng				= 0.003,
		Kd_eng				= 0,
		Kp_ver_st1			= 0.009,
		Kd_ver_st1			= 0.015,
		Kp_ver_st2			= 0.00018,
		Kd_ver_st2			= 0.00005,
		
		auto_terrain_following			= 1,
		auto_terrain_following_height	= 75,
		
		alg_points_num			= 7,
		alg_calc_time			= 1.5,
		alg_vel_k				= 6,
		alg_div_k				= 2,
		alg_max_sin_climb		= 0.8,
		alg_section_temp_points	= 3,
		alg_tmp_point_vel_k		= 1.5,
		no_alg_vel_k			= 10,
		
		max_roll			= 0.8,
		max_start_y_vel		= 35,
		stab_vel			= 220,
		finsLimit			= 0.8,
		estimated_N_max		= 6,
		eng_min_thrust		= -120,
		eng_max_thrust		= 3923,		
	},
	
	controller = {
		boost_start	= 0,
		march_start = 0.8,
	},
	
	boost = {	--	air launch - no booster
		impulse								= 0,
		fuel_mass							= 0,
		work_time							= 0,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{0, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0,
		smoke_color							= {0.0, 0.0, 0.0},
		smoke_transparency					= 0.0,
		custom_smoke_dissipation_factor		= 0.0,				
	},
	
	march = {
		impulse			= 3000,
		fuel_mass		= 255.0,
		work_time		= 999999,
		min_fuel_rate	= 0.005,
		min_thrust		= -100,
		max_thrust		= 3000,
		thrust_Tau		= 0.0017,
		
		nozzle_position						= {{-2.25, 0.0, 0.0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.5,
		smoke_color							= {0.5, 0.5, 0.5},
		smoke_transparency					= 0.03,
		custom_smoke_dissipation_factor		= 0.2,	
		
		start_burn_effect			= 1,
		start_effect_delay			= {0.0,		0.3, 	0.8},
		start_effect_time			= {0.7,		1.0, 	0.1},
		start_effect_size			= {0.09,	0.104,	0.11},
		start_effect_smoke			= {0.01,	0.4, 	0.01},
		start_effect_x_pow			= {1.0,		1.0,	1.0},
		start_effect_x_dist			= {1.1,		0.9,	0.0},
		start_effect_x_shift		= {0.15,	0.15,	0.2},
		
	},

	play_booster_animation = {
		val = 0,
	},
	
	warhead		= predefined_warhead("AGM_86С"),
	warhead_air = predefined_warhead("AGM_86С"),
}

declare_weapon(AGM_86C)


declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_86C}",
	attribute		= AGM_86C.wsTypeOfWeapon,
	Count 			= 1,
	Picture			= "AGM86.png",
	displayName		= _("AGM-86C"),
	Weight			= AGM_86C.mass,
	Elements  		= {{ShapeName = "agm-86"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{20_x_AGM_86C}",
	attribute		= AGM_86C.wsTypeOfWeapon,
	Count 			= 20,
	Picture			= "AGM86.png",
	displayName		= _("20 x AGM-86C"),
	Weight			= 20 * AGM_86C.mass,
	Elements  		= {{ShapeName = "agm-86"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{8_x_AGM_86C}",
	attribute		= AGM_86C.wsTypeOfWeapon,
	Count 			= 8,
	Picture			= "AGM86.png",
	displayName		= _("8 x AGM-86C"),
	Weight			= 8 * AGM_86C.mass,
	Elements  		= {{ShapeName = "agm-86"}},
})

local function DEPRECATED_ARG3_ROTATION(value)
	return {{3,value}}
end

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{6_x_AGM_86C_MER}",
	attribute		= {4,	4,	32,	67},
	Cx_pil			= 0.000681,
	Count 			= 6,
	Picture			= "AGM86.png",
	displayName		= _("6 x AGM-86C on MER"),
	Weight			= 60 + 6 * AGM_86C.mass,
	Weight_Empty	= 60,
	Elements	=	
	{
		[1]	=	
		{
			ShapeName	=	"B52-MBD_AGM86",
		}, 
		[2]	=	
		{
			Position	=	{-2.096,	0.138,	0},
			ShapeName	=	"AGM-86",
		}, 
		[3]	=	
		{
			Position	=	{4.277,	0.138,	0},
			ShapeName	=	"AGM-86",
		}, 
		[4]	=	
		{
			DrawArgs	=	DEPRECATED_ARG3_ROTATION(-1),			
			Position	=	{-2.096,	0.847,	0.838},
			ShapeName	=	"AGM-86",
		}, 
		[5]	=	
		{
			DrawArgs	=	DEPRECATED_ARG3_ROTATION( 1),			
			Position	=	{-2.096,	0.847,	-0.838},
			ShapeName	=	"AGM-86",
		}, 
		[6]	=	
		{
			DrawArgs	=	DEPRECATED_ARG3_ROTATION(-1),			
			Position	=	{4.277,	0.847,	0.838},
			ShapeName	=	"AGM-86",
		}, 
		[7]	=	
		{
			DrawArgs	=	DEPRECATED_ARG3_ROTATION( 1),			
			Position	=	{4.277,	0.847,	-0.838},
			ShapeName	=	"AGM-86",
		}, 
	}, -- end of Elements
})
