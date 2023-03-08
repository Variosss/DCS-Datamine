MISTRAL_MBDA =
{
	category		= CAT_MISSILES,
	name			= "Mistral",
	user_name		= _("Mistral"),
	scheme			= "mistral_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "mistral_missile",--mbda_mistral
	mass			= 18.7,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AA_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 1,
	sigma			= {10, 10, 10},
	M				= 18.7,
	H_max			= 3000.0,
	H_min			= -1,
	Diam			= 90.0,
	Cx_pil			= 1,
	D_max			= 6000.0,
	D_min			= 500.0,
	Head_Form		= 1,
	Life_Time		= 20,
	Nr_max			= 32,
	v_min			= 140.0,
	v_mid			= 450.0,
	Mach_max		= 2.5,
	t_b				= 2.0,
	t_acc			= 0.0,
	t_marsh			= 0.0,
	Range_max		= 6000.0,
	H_min_t			= 10.0,
	Fi_start		= math.rad(2),
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.0182,
	KillDistance	= 5.0,
	SeekerSensivityDistance = 10000, 
	ccm_k0					= 0.5,
	SeekerCooled			= true,	
	
	shape_table_data =
	{
		{
			name		= "Mistral",
			file		= "mistral_missile",
			life		= 1,
			fire		= { 0, 1},
			username	= _("Mistral"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	controller = {
		boost_start		= 0,
		march_start		= 0.6,
	},
	
	boost = {
		impulse								= 220,
		fuel_mass							= 0.4,
		work_time							= 0.2,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.94, 0, 0}},
		nozzle_orientationXYZ				= {{0, 0, 0}},
		tail_width							= 0.5,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.5,
		custom_smoke_dissipation_factor		= 0.5,

		wind_sigma					= 0.0,
		impulse_sigma				= 1,
		moment_sigma				= 10.0,

		mass						= 1.0,
		caliber						= 0.1,
		L							= 0.1,
		I							= 1,
		Ma							= 0.05,
		Mw							= 1e-4,
		Cx							= 0.9,

		model_name					= "mistral_booster",
		start_impulse				= 0,
	},
		
	march = {
		impulse								= 242,
		fuel_mass							= 6.2,
		work_time							= 2.2,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-0.9, 0.0, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.2,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.3,	
	},

	fm = {
		mass        = 18.7,  
		caliber     = 0.09,  
		cx_coeff    = {0.6,1.6,0.68,0.55,1.85},
		L           = 1.86,
		I           = 1 / 12 * 18.7 * 1.86 * 1.86,
		Ma          = 0.6,
		Mw          = 1.2,
		Sw			= 0.2,
		dCydA		= {0.07, 0.036},
		A			= 0.6,
		maxAoa		= math.rad(16),
		finsTau		= 0.1,
		Ma_x		= 0.001,
		Mw_x		= 0.011,
		I_x			= 0.02,
	},
	
	simple_IR_seeker = {
		sensitivity		= 9500,
		cooled			= true,
		delay			= 0.0,
		GimbLim			= math.rad(30),
		FOV				= math.rad(4);
		opTime			= 20.0,
		target_H_min	= 0.0,
		flag_dist		= 150.0,
	},
	
	simple_gyrostab_seeker = {
		omega_max = math.rad(40)
	},
	
	fuze_proximity = {
		ignore_inp_armed	= 1,
		radius				= 5,
	},
	
	autopilot = {
		K				= 2.0,
		Kg				= 0.1,
		Ki				= 0.0,
		finsLimit		= 0.2,
		delay 			= 0.5,
		fin2_coeff		= 0.5,
	},
	
	
	warhead		= predefined_warhead("Mistral_MBDA"),
	warhead_air	= predefined_warhead("Mistral_MBDA")
}
declare_weapon(MISTRAL_MBDA)

declare_loadout({
	category			= CAT_AIR_TO_AIR,
	CLSID				= "{9S846_2xIGLA}",
	Picture				= "apu2.png",
	displayName			= _("9S846 Strelets - 2 x 9M39 Igla"),
	attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= {4, 4, 34, 91},
	Cx_pil				= 0.00167,
	Weight				= 2 * (10.6 + 3.1) + 51,
	Weight_Empty		= 2 * 3.1 + 51,
	Count				= 2,
	kind_of_shipping	= 1,
	Elements			= ContainerWithSubshapes("PU_9S846_STRELEC", "9M39", 2, "tube_%02d"),
	weapon_container_data = {
		tube_args				= {4, 5},
		pre_launch_arg_state	= 0,
		launched_arg_state		= 1,
		tube_arg_rate_open		= 1,
		tube_arg_rate_close		= 1,
		endpoint_hold_time		= -1 -- will be held indefinitely
	}
})

Ataka_9M220 = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AA_Missile, WSTYPE_PLACEHOLDER},
	name			= "Ataka_9M220",
	user_name		= _("9M220O Ataka (AT-9 Spiral-2)"),
	scheme			= "shturm_new",
	class_name		= "wAmmunitionVikhr",
	model			= "9M120F",

	Escort			= 1,
	Head_Type		= 7,
	sigma			= {4, 4, 4},
	M				= 49.5,
	H_max			= 4000,
	H_min			= -1,
	Diam			= 130,
	Cx_pil			= 0,
	D_max			= 6000,
	D_min			= 800,
	Head_Form		= 1,
	Life_Time		= 30,
	Nr_max			= 1.2,
	v_min			= 170,
	v_mid			= 300,
	Mach_max		= 1.8,
	t_b				= 0,
	t_acc			= 5,
	t_marsh			= 0,
	Range_max		= 6000,
	H_min_t			= 0,
	Fi_start		= 0.1,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.4,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= -0.922,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.03,
	KillDistance	= 4,

	booster = {
		impulse							= 220,
		fuel_mass						= 1,
		work_time						= 0.05,
		nozzle_position					= {{-1.08, 0, 0}},
		tail_width						= 0.13,
		smoke_color						= {0.8, 0.8, 0.8},
		smoke_transparency				= 0.8,
		custom_smoke_dissipation_factor	= 0.5,
	},

	march = {
		impulse							= 240,
		fuel_mass						= 5.53, -- 6500N for 2s
		work_time						= 2,
		nozzle_position					= {{-0.515, 0, 0.07},{-0.515, 0,-0.07}},
		nozzle_orientationXYZ			= {{0, -0.2, 0},{0, 0.2, 0}},
		tail_width						= 0.06,
		smoke_color						= {0.8, 0.8, 0.8},
		smoke_transparency				= 0.01,
		custom_smoke_dissipation_factor	= 1,
	},

	march2 = {
		impulse							= 250,
		fuel_mass						= 4.29, -- 3500N for 3s
		work_time						= 3,
		nozzle_position					= {{-0.515, 0, 0.07},{-0.515, 0,-0.07}},
		nozzle_orientationXYZ			= {{0, -0.2, 0},{0, 0.2, 0}},
		tail_width						= 0.06,
		smoke_color						= {0.8, 0.8, 0.8},
		smoke_transparency				= 0.01,
		custom_smoke_dissipation_factor	= 1,
	},

	march_smoke = {
		impulse							= 0.5,
		fuel_mass						= 0.6,
		work_time						= 0.5,
		nozzle_position					= {{-0.515, 0, 0.07},{-0.515, 0,-0.07}},
		nozzle_orientationXYZ			= {{0, -0.2, 0.15},{0, 0.2, 0}},
		tail_width						= 0.13,
		smoke_color						= {0.1, 0.1, 0.1},
		smoke_transparency				= 0.01,
		custom_smoke_dissipation_factor	= 1,
	},

	spiral_nav = {
		t_cone_near_rad			= 1000,
		def_cone_max_dist		= 7500,
		def_cone_near_rad		= 1000,
		def_cone_near_rad_st	= 0,
		def_cone_time_stab_rad	= 0,
		gb_angle				= 0.0036,
		gb_min_dist				= 3200,
		gb_use_time				= 5.3,
		gb_max_retW				= 0.4,
		gb_ret_Kp				= 1.1,
	},

	autopilot = {
		Kp					= 0.062,
		Ki					= 0.056,
		Kd					= 0.036,
		max_ctrl_angle		= 1.15,
		delay				= 0.7,
		op_time				= 18,
		fins_discreet		= 0.08,
		no_ctrl_center_ang	= 0.00002,
		fins_limit			= 1,

		self_destruct_maneuver			= 1,
		self_destruct_maneuver_cmd_y	= 0.3,
		self_destruct_maneuver_cmd_z	= 0.6,
		self_destruct_start_timer		= 18,
		self_destruct_command_timer		= 3,
		self_destruct_no_signal_lim		= 0.5,
	},

	fm = {
		mass				= 42.5,
		caliber				= 0.13,
		L					= 1.83,
		I					= 1 / 12 * 49.5 * 1.83 * 1.83,
		Ma					= 2,
		Mw					= 5,
		cx_coeff			= {1, 1.5, 1.2, 0.2, 1.3},
		Sw					= 0.12,
		dCydA				= {0.024, 0.018},
		A					= 0.6,
		maxAoa				= 0.2,
		finsTau				= 0.05,
		freq				= 4,
	},

	eng_err = {
		y_error				= 0,
		z_error				= 0.1,
		min_time_interval	= 0.1,
		max_time_interval	= 1,
	},

	fuze = {
		default_proximity_radius	= 4,
		default_arm_delays			= { 0.8 },
		tdd_position				= { 0.83, 0, 0 }
	},

	shape_table_data = {{
		name		= _("9M220O"),
		file		= "9M120F",
		username	= _("9M220O"),
		index		= WSTYPE_PLACEHOLDER
	}},

	warhead		= predefined_warhead("9M220"),
}
declare_weapon(Ataka_9M220)

declare_loadout({
	category 			= CAT_AIR_TO_AIR,
	CLSID	 			= "{2x9M220_Ataka_V}",
	Picture				= "24_ME_ATGM_Launch+2_Miss.png",
	Cx_pil				= 0.001,
	displayName			= "2 x " .. Ataka_9M220.user_name .. " - " .. _("AAM, SACLOS, Frag"),
	NatoName			= "AT-9",
	Weight				= 13 + 2 * (7 + Ataka_9M220.fm.mass),
	Weight_Empty		= 13 + 2 * 7,
	Count				= 2,
	kind_of_shipping	= 0,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= Ataka_9M220.wsTypeOfWeapon,
	Elements			= {{ ShapeName = "9M120_pylon", IsAdapter = true }}
})
