Kh25MP_PRGS1VP =
{
	category		= CAT_MISSILES,
	name			= "Kh25MP_PRGS1VP",
	user_name		= _("Kh-25MP (AS-12 Kegler)"),
	scheme			= "anti_radiation_missile",
	class_name		= "wAmmunitionSelfHoming",
	model			= "X-25MP",
	mass			= 310,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 3,
	sigma			= {0, 0, 0},
	M				= 310.0,
	H_max			= 10000.0,
	H_min			= 50,
	Diam			= 275.0,
	Cx_pil			= 8.57,
	D_max			= 14000.0,
	D_min			= 3000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 12,
	v_min			= 170.0,
	v_mid			= 300.0,
	Mach_max		= 2.65,
	t_b				= 0.0,
	t_acc			= 0.0,
	t_marsh			= 10000.0,
	Range_max		= 14000.0,
	H_min_t			= 0.0,
	Fi_start		= 0.35,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.7,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.06,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 1,
	
	shape_table_data =
	{
		{
			name		= "Kh25MP_PRGS1VP",
			file		= "X-25MP",
			life		= 1,
			fire		= { 0, 1},
			username	= _("Kh-25MP"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	LaunchDistData =
		{
			8,		2,	
			
					50,		300,
			1000,	14000,	14000,
			2000,	14000,	14000,	
			3000,	13000,	13000,
			5000,	13000,	13000,
			6000,	12000,	12000,
			7000,	12000,	12000,
			8000,	11000,	11000,	
			9000,	10000,	10000,
		},
	
	controller = {
		boost_start = 0,
		march_start = 2.0,
	},
	
	booster = {
		impulse								= 208,
		fuel_mass							= 22.1,
		work_time							= 2,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.14, 0.0, 0.15},{-1.14, -0.0, -0.15}},
		nozzle_orientationXYZ				= {{0.0, -0.15, 0.0},{0.0, 0.15, 0.0}},
		tail_width							= 0.1,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,				
	},
	
	
	march = {
		impulse								= 208,
		fuel_mass							= 60.4,
		work_time							= 7,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.14, 0.0, 0.15},{-1.14, -0.0, -0.15}},
		nozzle_orientationXYZ				= {{0.0, -0.15, 0.0},{0.0, 0.15, 0.0}},
		tail_width							= 0.1,
		smoke_color							= {1.0, 1.0, 1.0},
		smoke_transparency					= 0.9,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	
	fm = {
		mass        = 310,  
		caliber     = 0.275,  
		cx_coeff    = {1,0.55,1.0,0.75,1.2},
		L           = 3.7,
		I           = 1 / 12 * 310 * 3.7 * 3.7,
		Ma          = 0.3,
		Mw          = 1.116,
		wind_sigma	= 20.0,
		wind_time	= 1000.000000,
		Sw			= 0.46,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.3,
		finsTau		= 0.1,
		Ma_x		= 0.001,
		Kw_x		= 0.001,
		I_x			= 30,
	},
	
	radio_seeker = {
		FOV						= math.rad(30),
		op_time					= 90,
		keep_aim_time			= 0.1,
		pos_memory_time			= 0.1,
		sens_near_dist			= 300.0,
		sens_far_dist			= 15000.0,
		err_correct_time		= 2.5,
		err_val					= 0.0065,
		calc_aim_dist			= 500000,
		blind_rad_val			= 0.2,
		blind_ctrl_dist			= 2000,
		aim_y_offset			= 2.0,
		min_sens_rad_val		= 0.0005,
		no_signal_turn_off_time	= 0.1,
	},
	
	simple_gyrostab_seeker = {
		omega_max	= math.rad(8)
	},
	
	fuze_proximity = {
		ignore_inp_armed = 0,
	},
	
	autopilot = {
		K				 = 100.0,
		Kg				 = 6.0,
		Ki				 = 0.0,
		finsLimit		 = 0.22,
		useJumpByDefault = 1,
		J_Power_K		 = 1.2,
		J_Diff_K		 = 0.4,
		J_Int_K			 = 0.0,
		J_Angle_K		 = math.rad(12),
		J_FinAngle_K	 = math.rad(18),
		J_Angle_W		 = 3.5,
		delay			 = 1.0,
	},
	
	warhead		= predefined_warhead("X_25MP"),
	warhead_air = predefined_warhead("X_25MP"),
}

declare_weapon(Kh25MP_PRGS1VP)

---

AGM_45A =
{
	category		= CAT_MISSILES,
	name			= "AGM_45A",
	user_name		= _("AGM-45A"),
	scheme			= "anti_radiation_missile2",
	class_name		= "wAmmunitionSelfHoming",
	model			= "agm-45",
	mass			= 177,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 3,
	sigma			= {0, 0, 0},
	M				= 177.0,
	H_max			= 24400.0,
	H_min			= -1,
	Diam			= 203.0,
	Cx_pil			= 4,
	D_max			= 40000.0,
	D_min			= 3000.0,
	Head_Form		= 1,
	Life_Time		= 300.0,
	Nr_max			= 12,
	v_min			= 170.0,
	v_mid			= 400.0,
	Mach_max		= 2.0,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 15.0,
	Range_max		= 40000.0,
	H_min_t			= 0.0,
	Fi_start		= 0.5,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.0,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.05,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 1,
	
	shape_table_data =
	{
		{
			name		= "AGM_45A",
			file		= "agm-45",
			life		= 1,
			fire		= { 0, 1},
			username	= _("AGM-45A"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	LaunchDistData =
		{
		9,		6,

				100,	150,	200,	250,	300,	350,	

		1000,	12000,	13000,	16000,	16000,	17000,	17000,	
		2000,	14000,	17000,	17000,	17000,	17000,	17000,	
		3000,	16000,	17000,	17000,	17000,	17000,	17000,	
		4000,	17000,	17000,	17000,	17000,	17000,	17000,	
		5000,	17000,	17000,	17000,	17000,	17000,	17000,	
		6000,	17000,	17000,	17000,	17000,	17000,	17000,	
		7000,	17000,	17000,	17000,	17000,	17000,	17000,	
		8000,	17000,	17000,	17000,	17000,	17000,	17000,	
		9000,	17000,	17000,	17000,	17000,	17000,	17000,	
	},
	
	controller = {
		march_start = 0,
	},

	march = {
		impulse								= 160,
		fuel_mass							= 36,
		work_time							= 9,
		boost_time							= 0,
		boost_factor						= 0,
		nozzle_position						= {{-1.0, -0.1, 0}},
		nozzle_orientationXYZ				= {{0.0, 0.0, 0.0}},
		tail_width							= 0.3,
		smoke_color							= {0.6, 0.6, 0.6},
		smoke_transparency					= 0.8,
		custom_smoke_dissipation_factor		= 0.2,	
	},
	
	
	fm = {
		mass        = 177,  
		caliber     = 0.203,  
		cx_coeff    = {1,0.4,1.1,0.5,1.4},
		L           = 3.05,
		I           = 1 / 12 * 177 * 3.05 * 3.05,
		Ma          = 0.3,
		Mw          = 1.116,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 0.85,
		dCydA		= {0.07, 0.036},
		A			= 0.36,
		maxAoa		= 0.28,
		finsTau		= 0.1,
		
		Ma_x		= 0.001,
		Kw_x		= 0.001,
		I_x			= 50,
	},
	
	radio_seeker = {
		FOV					= math.rad(5),
		op_time				= 90,
		keep_aim_time		= 0.1,
		pos_memory_time		= 0.1,
		sens_near_dist		= 300.0,
		sens_far_dist		= 20000.0,
		err_correct_time	= 2.8,
		err_val				= 0.01,
		calc_aim_dist		= 500000,
		blind_rad_val		= 0.2,
		blind_ctrl_dist		= 2000,
		aim_y_offset		= 0.0,
		min_sens_rad_val	= 0.00025,
	},
	
	simple_gyrostab_seeker = {
		omega_max	= math.rad(8)
	},
	
	fuze_proximity = {
		ignore_inp_armed	= 0,
		arm_delay			= 10,
		radius				= 10,
	},
	
	autopilot = {
		K				 = 220.0,
		Kg				 = 6.0,
		Ki				 = 0.0001,
		finsLimit		 = 0.1,
		useJumpByDefault = 1,
		J_Power_K		 = 1.2,
		J_Diff_K		 = 0.3,
		J_Int_K			 = 0.0,
		J_Angle_K		 = math.rad(10),
		J_FinAngle_K	 = math.rad(18),
		delay			 = 2.0,
		J_Angle_W		 = 2.5,
	},
	
	start_helper = {
		delay				= 0.2,
		power				= 0.02,
		time				= 2,
		use_local_coord		= 0,
		max_vel				= 200,
		max_height			= 400,
		vh_logic_or			= 1,
	},
	
	warhead		= predefined_warhead("AGM_45"),
	warhead_air = predefined_warhead("AGM_45"),
}

declare_weapon(AGM_45A)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_45A}",
	attribute		= AGM_45A.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= AGM_45A.Cx,
	Picture			= "aim7m.png",
	displayName		= _("AGM-45A Shrike ARM"),
	Weight			= AGM_45A.mass,
	Elements  		= {{ShapeName = "agm-45"}},
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{Kh-25MP}",
	wsTypeOfWeapon	= Kh25MP_PRGS1VP.wsTypeOfWeapon,
	attribute		= {4, 4, 32, WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Cx_pil			= 0.001,
	Picture			= "kh25mpu.png",
	displayName		= _("Kh-25MP (AS-12 Kegler) - 320kg, ARM, Pas Rdr"),
	Weight			= 355,
	Elements		= ContainerWithSubshapes("APU-68", "X-25MP", 1, "Point%02d")
})

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{AGM_122}",
	attribute		= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, 68},
	Count 			= 1,
	Cx_pil			= 1,
	Picture			= "aim9m.png",
	displayName		= _("AGM-122 Sidearm - light ARM"),
	Weight			= 88,
	Elements  		= {{ShapeName = "agm-122"}},
})
declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{Kh-28}",
	attribute		= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,44},
	Count 			= 1,
	Cx_pil			= 5,
	Picture			= "kh22.png",
	displayName		= _('Kh-28 (AS-9 Kyle) - 720kg, ARM, Pas Rdr'),
	Weight			= 715,
	Elements  		= {{ShapeName = "X-28"}},
})
