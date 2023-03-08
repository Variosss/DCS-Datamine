local explosivePercent = 0.4

--------------------------------------------------------------------------
--								AGM-154									--
--------------------------------------------------------------------------


--[[declare_loadout({
	category 		= CAT_BOMBS,
	CLSID	 		= "{AGM_154C}",
	attribute		= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, 132},
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "agm154.png",
	displayName		= _("AGM-154C - JSOW Unitary BROACH"),
	Weight			= 485,
	Elements  		= {{ShapeName = "agm-154"}},
})]]


AGM_154A =
{
	category		= CAT_MISSILES,
	name			= "AGM_154A",
	user_name		= _("AGM-154A"),
	scheme			= "AGM-154AB",
	class_name		= "wAmmunitionCruise",
	model			= "agm-154",
	mass			= 485,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 485.0,
	H_max			= 28000.0,
	H_min			= 300,
	Diam			= 400.0,
	Cx_pil			= 8,
	D_max			= 130000.0,
	D_min			= 5000.0,
	Head_Form		= 1,
	Life_Time		= 9999,
	Nr_max			= 10,
	v_min			= 150.0,
	v_mid			= 200.0,
	Mach_max		= 1.7,
	t_b				= 0.0,
	t_acc			= 0.0,
	t_marsh			= 0.0,
	Range_max		= 132000.0,
	H_min_t			= 0.0,
	Fi_start		= 3.14152,
	Fi_rak			= 3.14152,
	Fi_excort		= 3.14152,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0.0,
	Y_back			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.05,
	KillDistance	= 0.0,
	
	LaunchDistData =
	{
		22,		9,

				150,	200,	250,	300,	350,	400,	450,	500,	550,	
		300,	0,		0,		13510,	23300,	29100,	32610,	34710,	36230,	37720,	
		400,	0,		0,		13580,	24040,	29850,	33270,	35390,	37020,	38540,	
		500,	0,		0,		14400,	24780,	30650,	34040,	36180,	37810,	39320,	
		600,	0,		0,		15200,	25520,	31360,	34820,	36940,	38580,	40120,	
		700,	0,		5740,	16060,	26250,	32110,	35570,	37720,	39370,	40910,	
		800,	0,		7475,	17150,	26975,	32825,	36300,	38325,	40125,	41700,	
		900,	0,		8500,	18175,	27575,	33550,	36900,	39200,	40900,	42500,	
		1000,	0,		9600,	19375,	28350,	34275,	37775,	39975,	41675,	43250,	
		2000,	14175,	22425,	29500,	41150,	41175,	44850,	47225,	49075,	50875,	
		3000,	20100,	27200,	33800,	39750,	48000,	51900,	54350,	56450,	58450,	
		4000,	25150,	32100,	38850,	45300,	54800,	58750,	61550,	63800,	65950,	
		5000,	30100,	37000,	44300,	50800,	61100,	65500,	68500,	71000,	73500,	
		6000,	35000,	41750,	49250,	56000,	60250,	71750,	75000,	77750,	80750,	
		7000,	39500,	46500,	54500,	61250,	65750,	78250,	81500,	84750,	87750,	
		8000,	44500,	51500,	59500,	66750,	71250,	84000,	87750,	91000,	94500,	
		9000,	49000,	56250,	64250,	71500,	76250,	79250,	93750,	97250,	101250,	
		10000,	75250,	80500,	84750,	87250,	89000,	90500,	99000,	103250,	107500,	
		11000,	87000,	92000,	96000,	98500,	100000,	101000,	104500,	108500,	113500,	
		12000,	93500,	98000,	102500,	104500,	106000,	107000,	108000,	113500,	118500,	
		13000,	99500,	104000,	108000,	110500,	112000,	113000,	113500,	118000,	123000,	
		14000,	105500,	110000,	113500,	116000,	118000,	118500,	119500,	121500,	127000,	
		15000,	110500,	115000,	118500,	121500,	123000,	124000,	124500,	126000,	130000,	
	},

	MinLaunchDistData =
	{
		22,		9,

				150,	200,	250,	300,	350,	400,	450,	500,	550,	
		300,	0,		0,		5450,	3690,	4430,	6550,	6730,	5990,	6170,	
		400,	0,		0,		5380,	4090,	4940,	5470,	5930,	6360,	6790,	
		500,	0,		0,		5450,	4470,	5980,	5880,	6370,	6590,	6770,	
		600,	0,		0,		5240,	4800,	5670,	6370,	6540,	6670,	6830,	
		700,	0,		3290,	4330,	5120,	6130,	6470,	6680,	6820,	6950,	
		800,	0,		4775,	5550,	5650,	6200,	6525,	4975,	6975,	7100,	
		900,	0,		4875,	4675,	5700,	6225,	4775,	6850,	7025,	7250,	
		1000,	0,		4200,	5700,	5750,	6325,	6600,	6850,	7125,	7275,	
		2000,	5150,	5800,	6425,	6025,	6375,	6850,	7125,	7350,	7550,	
		3000,	5400,	6150,	6850,	7050,	6550,	6900,	7100,	7800,	8100,	
		4000,	5550,	6200,	5050,	7300,	6550,	6900,	8050,	8300,	7800,	
		5000,	5400,	6100,	6800,	7400,	6200,	6600,	8600,	9500,	9900,	
		6000,	5500,	6000,	6750,	7500,	8000,	7500,	9750,	10000,	11000,	
		7000,	4250,	5500,	5750,	6500,	7000,	7500,	8500,	10750,	11750,	
		8000,	4500,	5750,	6000,	7000,	7750,	8250,	8750,	10000,	11500,	
		9000,	5250,	6000,	7000,	7500,	8250,	8500,	10000,	10500,	11000,	
		10000,	7250,	8250,	8250,	8250,	9250,	9750,	51500,	11500,	11500,	
		11000,	7500,	7500,	8000,	8000,	9500,	10000,	11000,	11500,	15000,	
		12000,	8000,	8500,	8500,	9000,	9000,	10000,	10500,	12000,	12000,	
		13000,	8500,	8500,	8500,	9500,	9000,	10500,	11000,	12500,	13500,	
		14000,	8500,	9000,	10500,	11000,	10500,	11000,	11500,	13500,	13000,	
		15000,	9500,	10000,	10500,	10500,	10000,	11500,	12500,	13000,	14500,	
	},
	
	shape_table_data =
	{
		{
			name	 = "AGM_154A",
			file	 = "AGM-154",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("AGM-154A"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	warhead		= simple_warhead(0),

	fm =	{
		mass				= 485,
		caliber				= 0.4,
		cx_coeff			= {1, 0.85, 0.8, 0.15, 1.55},
		L					= 4.06,
		I					= 1000,
		Ma					= 2,
		Mw					= 7,
		wind_sigma			= 0.0,
		wind_time			= 0.0,
		Sw					= 1.2,
		dCydA				= {0.07, 0.036},
		A					= 0.15,
		maxAoa				= 0.4,
		finsTau				= 0.2,
		Ma_x				= 2,
		Ma_z				= 2,
		Mw_x				= 1.4,

		addDeplSw			= 0.6,
		no_wings_A_mlt		= 2,
		wingsDeplProcTime	= 5,
		wingsDeplDelay		= 9999,
		no_wings_cx_coeff = {1, 0.45, 0.8, 0.10, 1.55},
	},
	
	simple_seeker =	{
		sensitivity = 0,
		delay		= 0.0,
		FOV			= 0.6,
		maxW		= 500,
		opTime		= 9999,
	},
	
	control_block =	{
		seeker_activation_dist		= 7000,
		default_cruise_height		= -1,
		obj_sensor					= 0,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 2.2,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
	},
	
	control_block2 ={
		delay							= 0.5,
		add_y							= 500,
		wind_k							= 0,
		use_snake_maneuver				= 1,
		max_no_vert_offset_open_h		= 90,
		vert_offset_before_end_game_k	= 0.8,	
		can_update_target_pos			= 0,
	},

	open_trigger = {
		delay							= 0.1,
		trigger_add_time				= 1,
		bomblet_char_time				= 23.9,
		chute_bomblet_char_time			= 70.1,
		chute_open_time					= 2.6,
		chute_cut_time					= 400,
		char_time_vel_correction_coeff	= -0.0132,
		char_time_h_correction_coeff	= 0.0,
		default_add_y					= 500,
		out_w_add_y						= 0,
		wind_correction_coeff			= 1,
		time_coeff_data 				= {	25,		0.9,
											18,		0.86,
											15,		0.8,
											11.7,	0.58,
											6.8,	0.3,
											3,		0.2	},
	},
	
	autopilot =	{
		delay						= 2,
		K							= 200,
		Ki							= 0.00005,
		Kg							= 6,
		nw_K						= 22,
		nw_Ki						= 0.0,
		nw_Kg						= 1.8,
		finsLimit					= 0.8,
		useJumpByDefault			= 0,
		J_Power_K					= 4.0,
		J_Diff_K					= 3.0,
		J_Int_K						= 0.0,
		J_Angle_W					= 0.1,
		hKp_err						= 460,
		hKp_err_croll				= 0.012,
		hKd							= -0.008,
		max_roll					= 1.3,
		egm_Angle_K					= 0.2,
		egm_FinAngle_K				= 0.3,
		egm_add_power_K				= 0.2,
		wings_depl_fins_limit_K		= 0.3,
		err_new_wlos_k				= 0.84,
		err_aoaz_k					= 28,
		err_aoaz_sign_k				= 0.18,
	},


	launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, 
		{
			scheme = 
			{
				dispenser = 
				{
					mass					= 485,
					caliber					= 0.55,
					L						= 3.5,
					I						= 270.0,
					Ma						= 1,
					Mw						= 3,
					cx_coeff				= {1, 0.3, 0.65, 0.018, 1.6},
					model_name				= "agm-154",
					set_start_args			= {},
					spawn_time				= {0},
					spawn_weight_loss		= {300},
					spawn_args_change		= {},
					op_spawns				= 2,
					use_effects				= 0,
					hide_effect_0			= 0,
				},
				
				bomblets =
				{
					wind_sigma					= 25,
					impulse_sigma				= 2,
					moment_sigma				= 0.1,
					count						= 145,
					effect_count				= 28,
					mass						= 1.54,
					caliber						= 0.063,
					cx_coeff					= {1.0, 0.39, 0.38, 0.236, 1.31},
					L							= 1.68000,
					I							= 0.061333,
					Ma							= 0.2,
					Mw							= 0.8,
					model_name					= "BLU_97B",
					connectors_model_name		= "RBK_250_PTAB_25M_tail",
					explosion_impulse_coeff		= 15,
					explosion_dont_use_x_axis	= 0,
					release_rnd_coeff			= 0.8,
					chute_open_time				= 2.6,
					chute_cut_time				= 500.0,
					chute_diam					= 0.2,
					chute_Cx					= 0.7,
					chute_rnd_coeff				= 0.5,
					explosion_center			= {{0,0.3,0}},
					spawn_options				= {{0,0,145}},
				},
				warhead = predefined_warhead("BLU-97B"),
			},
			
			name    		= _("BLU-97/B"),
			type_name		= _("cluster"),
			cluster_scheme	= "disp_bomblets",
		}
		)
    },
	
}

declare_weapon(AGM_154A)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM-154A}",
	attribute		= AGM_154A.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "AGM154.png",
	displayName		= _("AGM-154A - JSOW CEB (CBU-type)"),
	Weight			= AGM_154A.mass,
	Elements  		= {{ShapeName = "kab-500s"}},
	ejectImpulse    = 140,
})

AGM_154B =
{
	category		= CAT_MISSILES,
	name			= "AGM_154B",
	user_name		= _("AGM-154B"),
	scheme			= "AGM-154AB",
	class_name		= "wAmmunitionCruise",
	model			= "agm-154",
	mass			= 485,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 485.0,
	H_max			= 28000.0,
	H_min			= 300,
	Diam			= 400.0,
	Cx_pil			= 8,
	D_max			= 130000.0,
	D_min			= 5000.0,
	Head_Form		= 1,
	Life_Time		= 9999,
	Nr_max			= 10,
	v_min			= 150.0,
	v_mid			= 200.0,
	Mach_max		= 1.7,
	t_b				= 0.0,
	t_acc			= 0.0,
	t_marsh			= 0.0,
	Range_max		= 132000.0,
	H_min_t			= 0.0,
	Fi_start		= 3.14152,
	Fi_rak			= 3.14152,
	Fi_excort		= 3.14152,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0.0,
	Y_back			= 0.0,
	Z_back			= 0.0,
	Reflection		= 0.05,
	KillDistance	= 0.0,
	
		LaunchDistData =
	{
		22,		9,

				150,	200,	250,	300,	350,	400,	450,	500,	550,	
		300,	0,		0,		13510,	23300,	29100,	32610,	34710,	36230,	37720,	
		400,	0,		0,		13580,	24040,	29850,	33270,	35390,	37020,	38540,	
		500,	0,		0,		14400,	24780,	30650,	34040,	36180,	37810,	39320,	
		600,	0,		0,		15200,	25520,	31360,	34820,	36940,	38580,	40120,	
		700,	0,		5740,	16060,	26250,	32110,	35570,	37720,	39370,	40910,	
		800,	0,		7475,	17150,	26975,	32825,	36300,	38325,	40125,	41700,	
		900,	0,		8500,	18175,	27575,	33550,	36900,	39200,	40900,	42500,	
		1000,	0,		9600,	19375,	28350,	34275,	37775,	39975,	41675,	43250,	
		2000,	14175,	22425,	29500,	41150,	41175,	44850,	47225,	49075,	50875,	
		3000,	20100,	27200,	33800,	39750,	48000,	51900,	54350,	56450,	58450,	
		4000,	25150,	32100,	38850,	45300,	54800,	58750,	61550,	63800,	65950,	
		5000,	30100,	37000,	44300,	50800,	61100,	65500,	68500,	71000,	73500,	
		6000,	35000,	41750,	49250,	56000,	60250,	71750,	75000,	77750,	80750,	
		7000,	39500,	46500,	54500,	61250,	65750,	78250,	81500,	84750,	87750,	
		8000,	44500,	51500,	59500,	66750,	71250,	84000,	87750,	91000,	94500,	
		9000,	49000,	56250,	64250,	71500,	76250,	79250,	93750,	97250,	101250,	
		10000,	75250,	80500,	84750,	87250,	89000,	90500,	99000,	103250,	107500,	
		11000,	87000,	92000,	96000,	98500,	100000,	101000,	104500,	108500,	113500,	
		12000,	93500,	98000,	102500,	104500,	106000,	107000,	108000,	113500,	118500,	
		13000,	99500,	104000,	108000,	110500,	112000,	113000,	113500,	118000,	123000,	
		14000,	105500,	110000,	113500,	116000,	118000,	118500,	119500,	121500,	127000,	
		15000,	110500,	115000,	118500,	121500,	123000,	124000,	124500,	126000,	130000,	
	},

	MinLaunchDistData =
	{
		22,		9,

				150,	200,	250,	300,	350,	400,	450,	500,	550,	
		300,	0,		0,		5450,	3690,	4430,	6550,	6730,	5990,	6170,	
		400,	0,		0,		5380,	4090,	4940,	5470,	5930,	6360,	6790,	
		500,	0,		0,		5450,	4470,	5980,	5880,	6370,	6590,	6770,	
		600,	0,		0,		5240,	4800,	5670,	6370,	6540,	6670,	6830,	
		700,	0,		3290,	4330,	5120,	6130,	6470,	6680,	6820,	6950,	
		800,	0,		4775,	5550,	5650,	6200,	6525,	4975,	6975,	7100,	
		900,	0,		4875,	4675,	5700,	6225,	4775,	6850,	7025,	7250,	
		1000,	0,		4200,	5700,	5750,	6325,	6600,	6850,	7125,	7275,	
		2000,	5150,	5800,	6425,	6025,	6375,	6850,	7125,	7350,	7550,	
		3000,	5400,	6150,	6850,	7050,	6550,	6900,	7100,	7800,	8100,	
		4000,	5550,	6200,	5050,	7300,	6550,	6900,	8050,	8300,	7800,	
		5000,	5400,	6100,	6800,	7400,	6200,	6600,	8600,	9500,	9900,	
		6000,	5500,	6000,	6750,	7500,	8000,	7500,	9750,	10000,	11000,	
		7000,	4250,	5500,	5750,	6500,	7000,	7500,	8500,	10750,	11750,	
		8000,	4500,	5750,	6000,	7000,	7750,	8250,	8750,	10000,	11500,	
		9000,	5250,	6000,	7000,	7500,	8250,	8500,	10000,	10500,	11000,	
		10000,	7250,	8250,	8250,	8250,	9250,	9750,	51500,	11500,	11500,	
		11000,	7500,	7500,	8000,	8000,	9500,	10000,	11000,	11500,	15000,	
		12000,	8000,	8500,	8500,	9000,	9000,	10000,	10500,	12000,	12000,	
		13000,	8500,	8500,	8500,	9500,	9000,	10500,	11000,	12500,	13500,	
		14000,	8500,	9000,	10500,	11000,	10500,	11000,	11500,	13500,	13000,	
		15000,	9500,	10000,	10500,	10500,	10000,	11500,	12500,	13000,	14500,	
	},
		
	shape_table_data =
	{
		{
			name	 = "AGM_154B",
			file	 = "AGM-154",
			life	 = 1,
			fire	 = { 0, 1},
			username = _("AGM-154B"),
			index	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	warhead		= simple_warhead(0),
	
	fm =	{
		mass				= 485,
		caliber				= 0.4,
		cx_coeff			= {1, 0.85, 0.8, 0.15, 1.55},
		L					= 4.06,
		I					= 1000,
		Ma					= 2,
		Mw					= 7,
		wind_sigma			= 0.0,
		wind_time			= 0.0,
		Sw					= 1.2,
		dCydA				= {0.07, 0.036},
		A					= 0.15,
		maxAoa				= 0.4,
		finsTau				= 0.2,
		Ma_x				= 2,
		Ma_z				= 2,
		Mw_x				= 1.4,

		addDeplSw			= 0.6,
		no_wings_A_mlt		= 2,
		wingsDeplProcTime	= 5,
		wingsDeplDelay		= 9999,
		no_wings_cx_coeff	= {1, 0.45, 0.8, 0.10, 1.55},
	},
	
	simple_seeker =	{
		sensitivity = 0,
		delay		= 0.0,
		FOV			= 0.6,
		maxW		= 500,
		opTime		= 9999,
	},
	
	control_block =	{
		seeker_activation_dist		= 7000,
		default_cruise_height		= -1,
		obj_sensor					= 0,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 2.2,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
	},
	
	control_block2 = {
		delay							= 0.5,
		add_y							= 180,
		wind_k							= 0,
		use_snake_maneuver				= 0,
		max_no_vert_offset_open_h		= 90,
		vert_offset_before_end_game_k	= 0.8,	
		can_update_target_pos			= 0,		
	},
	
	open_trigger = {
		delay							= 0.1,
		trigger_add_time				= 0.5,
		bomblet_char_time				= 49,
		chute_bomblet_char_time			= 150,
		chute_open_time					= 0.5,
		chute_cut_time					= 500,
		char_time_vel_correction_coeff	= 0,
		char_time_h_correction_coeff	= 0,
		default_add_y					= 180,
		out_w_add_y						= 0,
		wind_correction_coeff			= 1,
		time_coeff_data 				= {	41,		1.92,	--900
											32.4,	1.78,	--700
											23.8,	1.55,	--500
											21.6,	1.3,	--450
											20.0,	1.08,	--400
											17.3,	1.0,	--350
											15,		1.2,	--300
											13,		1.2,	--250
											9.8,	0.96,	--180
											5.8,	0.85	},--90
	},
	
	autopilot =	{
		delay						= 2,
		K							= 200,
		Ki							= 0.00005,
		Kg							= 6,
		nw_K						= 22,
		nw_Ki						= 0.0,
		nw_Kg						= 1.8,
		finsLimit					= 0.8,
		useJumpByDefault			= 0,
		J_Power_K					= 4.0,
		J_Diff_K					= 3.0,
		J_Int_K						= 0.0,
		J_Angle_W					= 0.1,
		hKp_err						= 460,
		hKp_err_croll				= 0.012,
		hKd							= -0.008,
		max_roll					= 1.3,
		egm_Angle_K					= 0.2,
		egm_FinAngle_K				= 0.3,
		egm_add_power_K				= 0.2,
		wings_depl_fins_limit_K		= 0.3,
		err_new_wlos_k				= 0.84,
		err_aoaz_k					= 28,
		err_aoaz_sign_k				= 0.18,
	},
	
	launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, 
		{
			scheme = 
			{
				dispenser = 
					{
						op_time					= 9000,
						wind_sigma				= 20,
						impulse_sigma			= 1,
						moment_sigma			= 1,
						mass					= 360,
						caliber					= 0.45,
						L						= 2.5,
						I						= 100,
						Ma						= 0.228,
						Mw						= 2.33,
						cx_coeff				= {1, 1, 1, 1, 2},
						model_name				= "agm-154",
						set_start_args			= {0,12,13},
						spawn_args_change		= {{1,12,0},{1,1,0.6}},
						spawn_time				= {0.02, 0.22, 0.42},
						spawn_weight_loss		= {0, 150, 150},
						spawm_args_change		= {{1,1,1},{1,12,0},{2,2,1}},
						op_spawns				= 3,
					},
	
					empty_dispenser = 
					{
						op_time					= 50,
						wind_sigma				= 5,
						impulse_sigma			= 1,
						moment_sigma			= 1,
						mass					= 45,
						caliber					= 0.45,
						L						= 2.5,
						I						= 2,
						Ma						= 0.03,
						Mw						= 0.3,
						cx_coeff				= {1, 1, 1, 1, 2},
						model_name				= "agm-154",
						set_start_args			= {0, 1, 2},
						spawn_options			= {{2, 2, 1}},
					},
	
					BLU_108 =
					{
						op_time					= 9000,
						count					= 6,
						effect_count			= 6,
						wind_sigma				= 5,
						impulse_sigma			= 1,
						moment_sigma			= 2,
						mass					= 29.5,
						caliber					= 0.133,
						L						= 0.7,
						I						= 0.4,
						Ma						= 0.90985,
						Mw						= 1.67549,
						cx_coeff				= {1, 0.39, 0.38, 0.236, 1.31},
						model_name				= "cbu97_blu108",
						set_start_args			= {13},
						connectors_model_name	= "cbu97_shaft",
						explosion_impulse_coeff	= 42,
						explosion_center		= {{0.36,0,0},{-0.44,0,0}},
						release_rnd_coeff		= 7,
						chute_open_time			= 0.5,
						chute_diam				= 2,
						chute_Cx				= 1.2,
						chute_rnd_coeff			= 0.5,
						spawn_options			= {{0,1,3},{0,2,3}},
			
						submunition_engine_impulse			= 50,
						submunition_engine_fuel_mass		= 0.1,
						submunition_engine_work_time		= 0.22,
						submunition_engine_rotation_moment	= 9,
						submunition_engine_start_height		= 32,
						skeets_release_delay				= 1.05,
						skeets_in_seq_release_delay			= 0.02,
						main_chute_open_speed				= 4,
						extr_chute_max_diam					= 0.3,
						opening_speed_k						= 2,
						jump_error_sum						= 440,
					},
	
					BLU_108_panel =
					{
						op_time 				= 50,
						wind_sigma				= 5,
						impulse_sigma			= 1,
						moment_sigma			= 1,
						mass					= 5,
						caliber					= 0.1,
						L						= 1,
						I						= 1,
						Ma						= 0.5,
						Mw						= 1,
						cx_coeff				= {1, 0.4, 0.4, 0.4, 1.4},
						model_name				= "cbu97_blu108_panel",
						init_pos				= {{0,0,0}},
						init_impulse			= {{0,125,0}},
						spawn_options			= {{0,1,1}},
					},
	
					skeet = 
					{
						op_time					= 9000,
						count					= 4,
						effect_count			= 4,
						wind_sigma				= 1,
						impulse_sigma			= 1,
						moment_sigma			= 0.1,
						mass					= 5,
						caliber					= 0.1,
						L						= 1,
						I						= 1,
						Ma						= 1,
						Mw						= 1,
						cx_coeff				= {1, 0.4, 0.4, 0.4, 1.4},
						model_name				= "cbu97_skeet",
						init_pos				= {{0.02,-0.15,0},{0.02,0.15,0},{0.25,-0.15,0},{0.25,0.15,0}},
						omega_impulse_coeff		= 3.6,
						release_rnd_coeff		= 12,
						set_start_args			= 10,
						spawm_options			= {{2,2,1},{3,3,1},{4,4,1},{5,5,1}},
			
						shell_model_name		= "shell",
						seeker_local_point		= {{0.05, -0.07, 0}},
						seeker_rotation_point	= {0, 0, 0},
						seeker_max_angle		= 0.392699,
						seeker_max_range		= 160,
						seeker_activation_time	= 0.3,
						shot_error				= 0.05,
						aim_lock_efficiency		= 0.66,
						shell_speed				= 500,
					},
					warhead		= predefined_warhead("CBU97"),
			},
			
			name    		= _("BLU-108"),
			type_name		= _("cluster"),
			cluster_scheme	= "AGM-154B_cluster",
		}
		)
    },
}

declare_weapon(AGM_154B)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM-154B}",
	attribute		= AGM_154B.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.0018,
	Picture			= "AGM154.png",
	displayName		= _("AGM-154B - JSOW Anti-Armour"),
	Weight			= AGM_154B.mass,
	Elements  		= {{ShapeName = "kab-500s"}},
	ejectImpulse    = 140,
})

JSOW_data =
{
	["AGM-154A"]		= {name = "AGM-154A - JSOW CEB (CBU-type)",		payload_CLSID = "{AGM-154A}",								mass = AGM_154A.mass, wsType = AGM_154A.wsTypeOfWeapon,	Cx = 0.0018,	picture = "AGM154.png"},
	["AGM-154B"]		= {name = "AGM-154B - JSOW Anti-Armour",		payload_CLSID = "{AGM-154B}",								mass = AGM_154B.mass, wsType = AGM_154B.wsTypeOfWeapon,	Cx = 0.0018,	picture = "AGM154.png"},
	["AGM-154C"]		= {name = "AGM-154C - JSOW Unitary BROACH",		payload_CLSID = "{9BCC2A2B-5708-4860-B1F1-053A18442067}",	mass = 484,			  wsType = {4,	4,	8,	132},		Cx = 0.0018,	picture = "AGM154.png"},
}

local function bru_55_JSOW(clsid,element)
	local JSOW_variant = JSOW_data[element] or JSOW_data["AGM-154A"]
	local ret = {
		category			=	CAT_MISSILES,
		CLSID				=	clsid,
		Picture				=	JSOW_variant.picture,
		displayName			=	_("BRU-55 with 2 x "..JSOW_variant.name),
		wsTypeOfWeapon		=	JSOW_variant.wsType,
		attribute			=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
		Count				=	2,
		Weight				=	bru_55VER_mass +  2*JSOW_variant.mass,
		Cx_pil				=	0.00244140625 + 2*JSOW_variant.Cx,
		Elements 			=	{{ShapeName	=	"BRU_55",IsAdapter  	   =   true  },}
	}
	ret.Elements[#ret.Elements + 1] = {payload_CLSID = JSOW_variant.payload_CLSID, connector_name =	"Point02"}
	ret.Elements[#ret.Elements + 1] = {payload_CLSID = JSOW_variant.payload_CLSID, connector_name =	"Point01"}

	declare_loadout(ret)
end

bru_55_JSOW("{BRU55_2*AGM-154A}",	"AGM-154A")
bru_55_JSOW("{BRU55_2*AGM-154C}",	"AGM-154C")

local function bru_57_JSOW(element)
	local JSOW_variant = JSOW_data[element] or JSOW_data["AGM-154A"]
	local ret = {
		category			=	CAT_MISSILES,
		CLSID				=	"{BRU57_2*"..element.."}",
		Picture				=	JSOW_variant.picture,
		displayName			=	_("BRU-57 with 2 x "..JSOW_variant.name),
		wsTypeOfWeapon		=	JSOW_variant.wsType,
		attribute			=	{4,	4,	32,	WSTYPE_PLACEHOLDER},
		Count				=	2,
		Weight				=	bru_57VER_mass +  2*JSOW_variant.mass,
		Cx_pil				=	0.00244140625 + 2*JSOW_variant.Cx,
		Elements 			=	{{ShapeName	=	"BRU_57",IsAdapter  	   =   true  },}
	}
	ret.Elements[#ret.Elements + 1] = {payload_CLSID = JSOW_variant.payload_CLSID, connector_name =	"Point02"}
	ret.Elements[#ret.Elements + 1] = {payload_CLSID = JSOW_variant.payload_CLSID, connector_name =	"Point01"}

	declare_loadout(ret)
end

bru_57_JSOW("AGM-154A")				-- {BRU57_2*AGM-154A}
bru_57_JSOW("AGM-154B")				-- {BRU57_2*AGM-154B}

--------------------------------------------------------------------------
--							BOMBKAPSEL-90								--
--------------------------------------------------------------------------

function BK_90 (name, user_name, scheme, cluster_name, cluster_scheme_, open_dist_k, bomblets_data)
	
	local bk ={}
	bk.category		= CAT_MISSILES
	bk.name			= name
	bk.user_name	= user_name
	bk.scheme		= scheme
	bk.class_name	= "wAmmunitionSelfHoming"
	bk.model		= "BK_90"
	bk.mass			= 605
	
	bk.wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER}

	bk.Escort			= 0
	bk.Head_Type		= 5
	bk.sigma			= {20, 20, 20}
	bk.M				= 605.0
	bk.H_max			= 1600.0
	bk.H_min			= 50
	bk.Diam				= 400.0
	bk.Cx     			= 0.0024
	bk.Cx_pil     		= 10
	bk.D_max			= 10000.0
	bk.D_min			= 1500.0
	bk.Head_Form		= 0
	bk.Life_Time		= 1000
	bk.Nr_max			= 4
	bk.v_min			= 170.0
	bk.v_mid			= 240.0
	bk.Mach_max			= 0.95
	bk.t_b				= 0.0
	bk.t_acc			= 0.0
	bk.t_marsh			= 0.0
	bk.Range_max		= 10000.0
	bk.H_min_t			= 0.0
	bk.Fi_start			= 1.57
	bk.Fi_rak			= 3.14152
	bk.Fi_excort		= 3.14152
	bk.Fi_search		= 99.9
	bk.OmViz_max		= 99.9
	bk.X_back			= 0.0
	bk.Y_back			= 0.0
	bk.Z_back			= 0.0
	bk.Reflection		= 0.15
	bk.KillDistance		= 0.0
	
	bk.LaunchDistData = 
	{		
		10,		8,
		
				160,	180,	200,	220,	240,	260,	280,	300,	
		50,		500,	2200,	3000,	4800,	6800,	8800,	9600,	10000,	
		100,	1200,	2600,	4000,	5800,	7600,	9500,	9800,	10000,	
		150,	1600,	3000,	4200,	6000,	8000,	9600,	9900,	10000,	
		200,	1800,	3000,	4400,	6200,	8200,	9600,	9900,	10000,	
		250,	2000,	3200,	4600,	6200,	8200,	9600,	10000,	10000,	
		300,	2200,	3300,	4600,	6400,	8400,	9700,	10000,	10000,	
		350,	2200,	3400,	4700,	6400,	8400,	9800,	10000,	10000,	
		400,	2400,	3400,	4700,	6600,	8500,	9800,	10000,	10000,	
		450,	2400,	3400,	4700,	6600,	8500,	9900,	10000,	10000,	
		500,	2500,	3500,	4800,	6700,	8600,	9900,	10000,	10000,	
	}
		
	bk.shape_table_data =
	{
		{
			name	 = name,
			file	 = "BK_90",
			life	 = 1,
			fire	 = { 0, 1},
			username = user_name,
			index	 = WSTYPE_PLACEHOLDER,
		},
	}
	
	bk.warhead		= simple_warhead(0)
	
	bk.fm =
	{
		mass        = 605.0,  
		caliber     = 0.55,  
		L           = 3.5,
		I           = 270,
		Ma          = 1.0,
		Mw          = 3.0,
		cx_coeff	= {1, 0.3, 0.65, 0.09, 1.4},
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		dCydA		= {0.09, 0.036},
		A			= 0.13,
		maxAoa		= 0.4,
		finsTau		= 0.2,
		Sw			= 0.3,
		Ma_x		= 1.0,
		Kw_x		= 0.01,
		I_x			= 25,
	}
	
	bk.autopilot =
	{
		delay				= 2.0,
		Kpv					= 0.024,
		Kdv					= 3.0,
		Kiv					= 0.000012,
		Kph					= 28.0,
		Kdh					= 2.0,
		Kih					= 0.0,
		glide_height		= 120.0,
		use_current_height	= 1,
		max_vert_speed 		= 40.0,
		altim_vel_k			= 1.0,
		finsLimit			= 0.8,
	}
	
	bk.open_trigger = 
	{
		delay			= 2.0,
		trigger_dist_k	= open_dist_k,
	}

	local scheme_data =  bomblets_data
	
	scheme_data.dispenser = 
	{
		mass					= 605,
		caliber					= 0.55,
		L						= 3.5,
		I						= 270.0,
		Ma						= 1,
		Mw						= 3,
		cx_coeff				= {1, 0.3, 0.65, 0.09, 1.4},
		model_name				= "BK_90",
		set_start_args			= {},
		spawn_time				=	{
										0,
										0.2,	0.22,	0.24,	0.26,
										0.4,	0.42,	0.44,	0.46,
										0.6,	0.62,	0.64,	0.66,
										0.8,	0.82,	0.84,	0.86,
										1.0,	1.02,	1.04,	1.06,
										1.2,	1.22,	1.24,	1.26,
									},
		spawn_weight_loss		= {0,	16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,
										16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,
										16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9, 16.9,},
		spawn_args_change		=	{
										{1,31,1},	{2,32,1},	{3,33,1},	{4,34,1},
										{5,35,1},	{6,36,1},	{7,37,1},	{8,38,1},
										{9,39,1},	{10,40,1},	{11,41,1},	{12,42,1},
										{13,43,1},	{14,44,1},	{15,45,1},	{16,46,1},
										{17,47,1},	{18,48,1},	{19,49,1},	{20,50,1},
										{21,51,1},	{22,52,1},	{23,53,1},	{24,54,1},
									},
		op_spawns				= 26,
		use_effects				= 0,
		hide_effect_0			= 1,
	}
	
	local levParam = 
	{
		scheme			= scheme_data,
		name    		= cluster_name,
		type_name		= _("cluster"),
		cluster_scheme	= cluster_scheme_,
	}
	
	bk.launcher =
    {
        cluster = cluster_desc("Bomb_Other", wsType_Bomb_Cluster, levParam),
    }
	
	declare_weapon(bk)
	return bk
end

local DWS39_MJ1 = BK_90("DWS39_MJ1", _("DWS39 MJ1"), "inertial_guided_glide_bomb", _("MJ1"), "disp_bomblets", 1.4, {
	bomblets =
	{
		wind_sigma					= 25,
		impulse_sigma				= 4,
		moment_sigma				= 0.1,
		count						= 72,
		effect_count				= 72,
		mass						= 6,
		caliber						= 0.132,
		cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
		L							= 0.3,
		I							= 0.02,
		Ma							= 0.06,
		Mw							= 0.8,
		model_name					= "MUS_JAS_1",
		init_pos					=	{
											{1.0674599409103394,	0.12363214790821075,	-0.2},
											{1.0674599409103394,	0.12363214790821075,	0.0},
											{1.0674599409103394,	0.12363214790821075,	0.2},
											
											{1.0674779415130615,	-0.0071935374289751053,	-0.2},
											{1.0674779415130615,	-0.0071935374289751053,	0.0},
											{1.0674779415130615,	-0.0071935374289751053,	0.2},
											
											{0.90919733047485352,	-0.0064242500811815262,	-0.2},
											{0.90919733047485352,	-0.0064242500811815262,	0.0},
											{0.90919733047485352,	-0.0064242500811815262,	0.2},
											
											{0.90921545028686523,	0.12363214790821075,	-0.2},
											{0.90921545028686523,	0.12363214790821075,	0.0},
											{0.90921545028686523,	0.12363214790821075,	0.2},
											
											{0.75522589683532715,	0.12363214790821075,	-0.2},
											{0.75522589683532715,	0.12363214790821075,	0.0},
											{0.75522589683532715,	0.12363214790821075,	0.2},
											
											{0.75508940219879150,	-0.0071935374289751053,	-0.2},
											{0.75508940219879150,	-0.0071935374289751053,	0.0},
											{0.75508940219879150,	-0.0071935374289751053,	0.2},
											
											{0.59696328639984131,	-0.0064242500811815262,	-0.2},
											{0.59696328639984131,	-0.0064242500811815262,	0.0},
											{0.59696328639984131,	-0.0064242500811815262,	0.2},														
											
											{0.59682685136795044,	0.12363214790821075,	-0.2},
											{0.59682685136795044,	0.12363214790821075,	0.0},
											{0.59682685136795044,	0.12363214790821075,	0.2},
											
											{0.44255921244621277,	0.12363214790821075,	-0.2},
											{0.44255921244621277,	0.12363214790821075,	0.0},
											{0.44255921244621277,	0.12363214790821075,	0.2},
											
											{0.44267767667770386,	-0.0071935374289751053,	-0.2},
											{0.44267767667770386,	-0.0071935374289751053,	0.0},
											{0.44267767667770386,	-0.0071935374289751053,	0.2},
											
											{0.28429663181304932,	-0.0064242351800203323,	-0.2},
											{0.28429663181304932,	-0.0064242351800203323,	0.0},
											{0.28429663181304932,	-0.0064242351800203323,	0.2},
											
											{0.28441512584686279,	0.12363214790821075,	-0.2},
											{0.28441512584686279,	0.12363214790821075,	0.0},
											{0.28441512584686279,	0.12363214790821075,	0.2},
											
											{0.13067781925201416,	0.12363214790821075,	-0.2},
											{0.13067781925201416,	0.12363214790821075,	0.0},
											{0.13067781925201416,	0.12363214790821075,	0.2},
											
											{0.13079625368118286,	-0.0071935225278139114,	-0.2},
											{0.13079625368118286,	-0.0071935225278139114,	0.0},
											{0.13079625368118286,	-0.0071935225278139114,	0.2},
											
											{-0.027584791183471680,	-0.0064242351800203323,	-0.2},
											{-0.027584791183471680,	-0.0064242351800203323,	0.0},
											{-0.027584791183471680,	-0.0064242351800203323,	0.2},
											
											{-0.027466297149658203,	0.12363214790821075,	-0.2},
											{-0.027466297149658203,	0.12363214790821075,	0.0},
											{-0.027466297149658203,	0.12363214790821075,	0.2},
											
											{-0.18173396587371826,	0.12363214790821075,	-0.2},
											{-0.18173396587371826,	0.12363214790821075,	0.0},
											{-0.18173396587371826,	0.12363214790821075,	0.2},
											
											{-0.18187046051025391,	-0.0071935225278139114,	-0.2},
											{-0.18187046051025391,	-0.0071935225278139114,	0.0},
											{-0.18187046051025391,	-0.0071935225278139114,	0.2},
											
											{-0.33999657630920410,	-0.0064242351800203323,	-0.2},
											{-0.33999657630920410,	-0.0064242351800203323,	0.0},
											{-0.33999657630920410,	-0.0064242351800203323,	0.2},
											
											{-0.34013295173645020,	0.12363214790821075,	-0.2},
											{-0.34013295173645020,	0.12363214790821075,	0.0},
											{-0.34013295173645020,	0.12363214790821075,	0.2},
											
											{-0.49412250518798828,	0.12363214790821075,	-0.2},
											{-0.49412250518798828,	0.12363214790821075,	0.0},
											{-0.49412250518798828,	0.12363214790821075,	0.2},
											
											{-0.49410438537597656,	-0.0071935225278139114,	-0.2},
											{-0.49410438537597656,	-0.0071935225278139114,	0.0},
											{-0.49410438537597656,	-0.0071935225278139114,	0.2},
											
											{-0.65238511562347412,	-0.0064242649823427200,	-0.2},
											{-0.65238511562347412,	-0.0064242649823427200,	0.0},
											{-0.65238511562347412,	-0.0064242649823427200,	0.2},
											
											{-0.65236699581146240,	0.12363214790821075,	-0.2},
											{-0.65236699581146240,	0.12363214790821075,	0.0},
											{-0.65236699581146240,	0.12363214790821075,	0.2},
										},
										
		init_ypr					=	{
											{4.7123886426183308,0,0},
											{4.7123886426183308,0,0},
											{4.7123886426183308,0,0},
											{1.5707963148700226,0,0},
											{1.5707963148700226,0,0},
											{1.5707963148700226,0,0},
										},
										
		explosion_impulse_coeff		= 350,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.4,
		chute_cut_time				= 500.0,
		chute_diam					= 0.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.5,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,3}, {0,2,3}, {0,3,3}, {0,4,3},
											{0,5,3}, {0,6,3}, {0,7,3}, {0,8,3},
											{0,9,3}, {0,10,3}, {0,11,3}, {0,12,3},
											{0,13,3}, {0,14,3}, {0,15,3}, {0,16,3},
											{0,17,3}, {0,18,3}, {0,19,3}, {0,20,3},
											{0,21,3}, {0,22,3}, {0,23,3}, {0,24,3},
										},
	},
	warhead			=  simple_warhead(5.7, 120),
})

local DWS39_MJ2 = BK_90("DWS39_MJ2", _("DWS39 MJ2"), "inertial_guided_glide_bomb", _("MJ2"), "disp_bomblets", 1.5,{
	bomblets =
	{
		wind_sigma					= 25,
		impulse_sigma				= 4,
		moment_sigma				= 0.1,
		count						= 24,
		effect_count				= 24,
		mass						= 18,
		caliber						= 0.132,
		cx_coeff					= {1, 0.39, 0.38, 0.236, 1.31},
		L							= 0.5,
		I							= 0.061333,
		Ma							= 0.06,
		Mw							= 0.8,
		model_name					= "MUS_JAS_2",
		connectors_model_name		= "BK_90",
		explosion_impulse_coeff		= 550,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.7,
		chute_cut_time				= 500.0,
		chute_diam					= 1.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.65,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,1}, {0,2,1}, {0,3,1}, {0,4,1},
											{0,5,1}, {0,6,1}, {0,7,1}, {0,8,1},
											{0,9,1}, {0,10,1}, {0,11,1}, {0,12,1},
											{0,13,1}, {0,14,1}, {0,15,1}, {0,16,1},
											{0,17,1}, {0,18,1}, {0,19,1}, {0,20,1},
											{0,21,1}, {0,22,1}, {0,23,1}, {0,24,1},
										},
	},
	warhead			=  cumulative_warhead(16.7, 120),
})

local DWS39_MJ1_MJ2 = BK_90("DWS39_MJ1_MJ2", _("DWS39 MJ1-MJ2"), "inertial_guided_glide_bomb", _("MJ1-MJ2"), "disp_2bomblets", 1.6, {
	bomblets =
	{
		wind_sigma			= 25,
		impulse_sigma		= 4,
		moment_sigma		= 0.1,
		count				= 36,
		effect_count		= 36,
		mass				= 6,
		caliber				= 0.132,
		cx_coeff			= {1, 0.39, 0.38, 0.236, 1.31},
		L					= 0.3,
		I					= 0.02,
		Ma					= 0.06,
		Mw					= 0.8,
		model_name			= "MUS_JAS_1",
		init_pos			=	{
									{1.0674599409103394,	0.12363214790821075,	-0.2},
									{1.0674599409103394,	0.12363214790821075,	0.0},
									{1.0674599409103394,	0.12363214790821075,	0.2},
									
									{0.90919733047485352,	-0.0064242500811815262,	-0.2},
									{0.90919733047485352,	-0.0064242500811815262,	0.0},
									{0.90919733047485352,	-0.0064242500811815262,	0.2},
						
									{0.75522589683532715,	0.12363214790821075,	-0.2},
									{0.75522589683532715,	0.12363214790821075,	0.0},
									{0.75522589683532715,	0.12363214790821075,	0.2},
									
									{0.59696328639984131,	-0.0064242500811815262,	-0.2},
									{0.59696328639984131,	-0.0064242500811815262,	0.0},
									{0.59696328639984131,	-0.0064242500811815262,	0.2},														
												
									{0.44255921244621277,	0.12363214790821075,	-0.2},
									{0.44255921244621277,	0.12363214790821075,	0.0},
									{0.44255921244621277,	0.12363214790821075,	0.2},
									
									{0.28429663181304932,	-0.0064242351800203323,	-0.2},
									{0.28429663181304932,	-0.0064242351800203323,	0.0},
									{0.28429663181304932,	-0.0064242351800203323,	0.2},
									
									{0.13067781925201416,	0.12363214790821075,	-0.2},
									{0.13067781925201416,	0.12363214790821075,	0.0},
									{0.13067781925201416,	0.12363214790821075,	0.2},
									
									{-0.027584791183471680,	-0.0064242351800203323,	-0.2},
									{-0.027584791183471680,	-0.0064242351800203323,	0.0},
									{-0.027584791183471680,	-0.0064242351800203323,	0.2},
									
									{-0.18173396587371826,	0.12363214790821075,	-0.2},
									{-0.18173396587371826,	0.12363214790821075,	0.0},
									{-0.18173396587371826,	0.12363214790821075,	0.2},
									
									{-0.33999657630920410,	-0.0064242351800203323,	-0.2},
									{-0.33999657630920410,	-0.0064242351800203323,	0.0},
									{-0.33999657630920410,	-0.0064242351800203323,	0.2},
									
									{-0.49412250518798828,	0.12363214790821075,	-0.2},
									{-0.49412250518798828,	0.12363214790821075,	0.0},
									{-0.49412250518798828,	0.12363214790821075,	0.2},
									
									{-0.65238511562347412,	-0.0064242649823427200,	-0.2},
									{-0.65238511562347412,	-0.0064242649823427200,	0.0},
									{-0.65238511562347412,	-0.0064242649823427200,	0.2},
								},
										
		init_ypr			=	{
									{4.7123886426183308,0,0},
									{4.7123886426183308,0,0},
									{4.7123886426183308,0,0},
									{1.5707963148700226,0,0},
									{1.5707963148700226,0,0},
									{1.5707963148700226,0,0},
								},
		explosion_impulse_coeff		= 350,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.4,
		chute_cut_time				= 500.0,
		chute_diam					= 0.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.5,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,1,3}, {0,3,3}, 
											{0,5,3},  {0,7,3}, 
											{0,9,3},  {0,11,3},
											{0,13,3}, {0,15,3}, 
											{0,17,3}, {0,19,3},
											{0,21,3}, {0,23,3},
										},
	},
				
	bomblets2 =
	{
		wind_sigma				= 25,
		impulse_sigma			= 4,
		moment_sigma			= 0.1,
		count					= 12,
		effect_count			= 12,
		mass					= 18,
		caliber					= 0.132,
		cx_coeff				= {1, 0.39, 0.38, 0.236, 1.31},
		L						= 0.5,
		I						= 0.061333,
		Ma						= 0.06,
		Mw						= 0.8,
		model_name				= "MUS_JAS_2",
		init_pos				=	{
										{1.0674779415130615,	-0.0071935374289751053,	0.0},
										{0.90921545028686523,	0.12363214790821075,	0.0},
										{0.75508940219879150,	-0.0071935374289751053,	0.0},
										{0.59682685136795044,	0.12363214790821075,	0.0},
										{0.44267767667770386,	-0.0071935374289751053,	0.0},
										{0.28441512584686279,	0.12363214790821075,	0.0},
										{0.13079625368118286,	-0.0071935225278139114,	0.0},
										{-0.027466297149658203,	0.12363214790821075,	0.0},
										{-0.18187046051025391,	-0.0071935225278139114,	0.0},
										{-0.34013295173645020,	0.12363214790821075,	0.0},
										{-0.49410438537597656,	-0.0071935225278139114,	0.0},
										{-0.65236699581146240,	0.12363214790821075,	0.0},
									},
													
		init_ypr				=	{
										{4.7123886426183308,0,0},
										{1.5707963148700226,0,0},
									},
													
		explosion_impulse_coeff		= 550,
		explosion_dont_use_x_axis	= 1,
		release_rnd_coeff			= 0.9,
		chute_open_time				= 0.7,
		chute_cut_time				= 500.0,
		chute_diam					= 1.8,
		chute_Cx					= 1,
		chute_rnd_coeff				= 0.65,
		explosion_center			=	{{0,0, -10000},{0,0,10000},},
		spawn_options				=	{
											{0,2,1}, {0,4,1},
											{0,6,1}, {0,8,1},
											{0,10,1}, {0,12,1},
											{0,14,1}, {0,16,1},
											{0,18,1}, {0,20,1},
											{0,22,1}, {0,24,1},
										},
	},
	
	warhead			=  simple_warhead(5.7, 120),
	warhead2		=  cumulative_warhead(16.7, 120),
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{DWS39_MJ1}",
	attribute		= DWS39_MJ1.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= DWS39_MJ1.Cx,
	Picture			= "bk90.png",
	displayName		= DWS39_MJ1.user_name,
	Weight			= DWS39_MJ1.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{DWS39_MJ2}",
	attribute		= DWS39_MJ2.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= DWS39_MJ2.Cx,
	Picture			= "bk90.png",
	displayName		= DWS39_MJ2.user_name,
	Weight			= DWS39_MJ2.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{DWS39_MJ1_MJ2}",
	attribute		= DWS39_MJ1_MJ2.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= DWS39_MJ1_MJ2.Cx,
	Picture			= "bk90.png",
	displayName		= DWS39_MJ1_MJ2.user_name,
	Weight			= DWS39_MJ1_MJ2.mass,
	Elements  		= {{ShapeName = "BK_90"}},
})
