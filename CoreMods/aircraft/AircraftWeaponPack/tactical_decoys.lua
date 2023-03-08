ADM_141A =
{
	category		= CAT_MISSILES,
	name			= "ADM_141A",
	user_name		= _("ADM-141A"),
	scheme			= "glide_decoy",
	class_name		= "wAmmunitionDecoy",
	model			= "ADM_141",
	mass			= 180,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 180.0,
	H_max			= 12000.0,
	H_min			= -1,
	Diam			= 340.0,
	Cx_pil			= 8,
	D_max			= 120000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 80.0,
	v_mid			= 200.0,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 120000.0,
	H_min_t			= 500.0,
	Fi_start		= 1.0,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.0,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 5.0,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 20,

	add_attributes = {"Cruise missiles", "Planes"},
	
	encyclopediaAnimation = {
		args = {
			[25] = 1.000000, -- wings open
		},
	},
	
	shape_table_data =
	{
		{
			name		= "ADM_141A",
			file		= "ADM_141",
			life		= 1,
			fire		= { 0, 1},
			username	= _("ADM-141A"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 180.0,  
		caliber     = 0.343,  
		cx_coeff	= {1, 0.85, 0.8, 0.15, 1.55},
		L           = 2.34,
		I           = 1 / 12 * 180.0 * 2.34 * 2.34,
		Ma          = 2.4,
		Mw          = 3.6,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.4,
		dCydA		= {0.07, 0.036},
		A			= 0.15,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.02,
		Kp_ret		= 4.5,
	},
	
	control_block ={
		seeker_activation_dist		= 0,
		default_cruise_height		= 500,
		obj_sensor					= 1,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.8,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
	},
	
	autopilot =		{
		delay				= 1.2,
		start_fins_vert_val	= -0.0015,
		Kpv					= 0.012,
		Kdv					= 0.92,
		Kiv					= 0.00001,
		Kp_hor_err			= 100,
		Kp_hor_err_croll	= 0.005,
		max_roll			= 0.7,
		glide_height		= 1000,
		max_vert_speed		= 30,
		altim_vel_k			= 1,
		finsLimit			= 0.5,
		inertial_km_error	= 4,
		stab_vel			= 160,
		landing_vel			= 150,
		vel_save_k			= 1.7,
	},
	
	march = {
		impulse			= 0,
		fuel_mass		= 0,
		work_time		= 0,
		min_fuel_rate	= 0,
		min_thrust		= 0,
		max_thrust		= 0,
		thrust_Tau		= 0,
	},
	
	engine_control = {
		default_speed	= 0,
		K				= 0,
		Kd				= 0,
		Ki				= 0,
	},

	snare_block = {
		delay			= 0,
		activate_by_rad	= 0,
		spawn_pos		= {0,0,0},
		spawn_interval	= 0,
		sens_dist		= 0,
		chaff_mass		= 0,
		chaff_sum_mass	= 0,
	},
	
	warhead		= predefined_warhead("BDU"),
}

declare_weapon(ADM_141A)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{ADM_141A}",
	attribute		= ADM_141A.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.001953125,
	Picture			= "agm154.png",
	displayName		= _("ADM-141A TALD"),
	Weight			= ADM_141A.mass,
	Elements  		= {{ShapeName = "ADM_141"}},
})

ADM_141B =
{
	category		= CAT_MISSILES,
	name			= "ADM_141B",
	user_name		= _("ADM-141B"),
	scheme			= "glide_decoy",
	class_name		= "wAmmunitionDecoy",
	model			= "ADM_141",
	mass			= 180,
	
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},

	Escort			= 0,
	Head_Type		= 5,
	sigma			= {20, 20, 20},
	M				= 180.0,
	H_max			= 12000.0,
	H_min			= -1,
	Diam			= 340.0,
	Cx_pil			= 8,
	D_max			= 120000.0,
	D_min			= 5000.0,
	Head_Form		= 0,
	Life_Time		= 100000,
	Nr_max			= 6,
	v_min			= 80.0,
	v_mid			= 200.0,
	Mach_max		= 0.95,
	t_b				= 0.0,
	t_acc			= 5.0,
	t_marsh			= 10000.0,
	Range_max		= 120000.0,
	H_min_t			= 500.0,
	Fi_start		= 1.0,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.0,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= 0,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 5.0,
	KillDistance	= 0.0,
	
	manualWeaponFlag = 20,

	
	add_attributes = {"Cruise missiles", "Planes"},
	
	shape_table_data =
	{
		{
			name		= "ADM_141B",
			file		= "ADM_141",
			life		= 1,
			fire		= { 0, 1},
			username	= _("ADM-141B"),
			index		= WSTYPE_PLACEHOLDER,
		},
	},
	
	fm = {
		mass        = 180.0,  
		caliber     = 0.34,  
		cx_coeff	= {1, 0.85, 0.8, 0.15, 1.55},
		L           = 2.34,
		I           = 1 / 12 * 180.0 * 2.34 * 2.34,
		Ma          = 2.4,
		Mw          = 3.6,
		wind_sigma	= 0.0,
		wind_time	= 0.0,
		Sw			= 1.4,
		dCydA		= {0.07, 0.036},
		A			= 0.15,
		maxAoa		= 0.3,
		finsTau		= 0.05,
		Ma_x		= 3,
		Ma_z		= 3,
		Kw_x		= 0.02,
		Kp_ret		= 4.5,
	},
	

	control_block ={
		seeker_activation_dist		= 0,
		default_cruise_height		= 500,
		obj_sensor					= 1,
		can_update_target_pos		= 0,
		turn_before_point_reach		= 1,
		turn_hor_N					= 0.8,
		turn_max_calc_angle_deg		= 90,
		turn_point_trigger_dist		= 100,
	},
	
	autopilot =		{
		delay				= 1.2,
		start_fins_vert_val	= -0.0015,
		Kpv					= 0.012,
		Kdv					= 0.12,
		Kiv					= 0.00001,
		Kp_hor_err			= 100,
		Kp_hor_err_croll	= 0.005,
		max_roll			= 0.7,
		glide_height		= 1000,
		max_vert_speed		= 35,
		altim_vel_k			= 1,
		finsLimit			= 0.5,
		inertial_km_error	= 4,
		stab_vel			= 160,
		landing_vel			= 150,
		vel_save_k			= 1.7,
	},
	
	march = {
		impulse			= 0,
		fuel_mass		= 0,
		work_time		= 0,
		min_fuel_rate	= 0,
		min_thrust		= 0,
		max_thrust		= 0,
		thrust_Tau		= 0,
	},
	
	engine_control = {
		default_speed	= 0,
		K				= 0,
		Kd				= 0,
		Ki				= 0,
	},

	snare_block = {
		delay			= 1,
		activate_by_rad	= 1,
		spawn_pos		= {-4,0,0},
		spawn_interval	= 0.5,
		sens_dist		= 30000,
		chaff_mass		= 0.05,
		chaff_sum_mass	= 36,
	},
	
	warhead		= predefined_warhead("BDU"),
}

declare_weapon(ADM_141B)

declare_loadout({
	category 		= CAT_MISSILES,
	CLSID	 		= "{ADM_141B}",
	attribute		= ADM_141B.wsTypeOfWeapon,
	Count 			= 1,
	Cx_pil			= 0.001953125,
	Picture			= "agm154.png",
	displayName		= _("ADM-141B TALD"),
	Weight			= ADM_141B.mass,
	Elements  		= {{ShapeName = "ADM_141"}},
})

ADM_141A_x3 = {
	category 			= CAT_MISSILES,
	CLSID	 			= "{BRU_42A_x3_ADM_141A}",
	Picture				= "agm154.png",
	Cx_pil				= 0.00244140625 + 3*0.001953125,
	displayName			= _("BRU-42 with 3 x ADM-141A TALD"),
	Count				= 3,
	Weight				= 50.80 + 3 * ADM_141A.mass,
	wsTypeOfWeapon		= ADM_141A.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			=	
		{
			{	ShapeName	=	"BRU_42A"	   	  ,	IsAdapter  	   =   true  }, 
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point01"},
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point02"},
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point03"},
		}-- end of Elements
}

declare_loadout(ADM_141A_x3)

ADM_141A_x2 = {
	category 			= CAT_MISSILES,
	CLSID	 			= "{BRU_42A_x2_ADM_141A}",
	Picture				= "agm154.png",
	Cx_pil				= 0.00244140625 + 2*0.001953125,
	displayName			= _("BRU-42 with 2 x ADM-141A TALD"),
	Count				= 2,
	Weight				= 50.80 + 2 * ADM_141A.mass,
	wsTypeOfWeapon		= ADM_141A.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			=	
		{
			{	ShapeName	=	"BRU_42A"	   	  ,	IsAdapter  	   =   true  }, 
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point02"},
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point03"},
		}-- end of Elements
}

declare_loadout(ADM_141A_x2)


ADM_141A_x1 = {
	category 			= CAT_MISSILES,
	CLSID	 			= "{BRU_42A_x1_ADM_141A}",
	Picture				= "agm154.png",
	Cx_pil				= 0.00244140625 + 0.001953125,
	displayName			= _("BRU-42 with ADM-141A TALD"),
	Count				= 1,
	Weight				= 50.80 + ADM_141A.mass,
	wsTypeOfWeapon		= ADM_141A.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			=	
		{
			{	ShapeName	=	"BRU_42A"	   	  ,	IsAdapter  	   =   true  }, 
			{	payload_CLSID =	 "{ADM_141A}",	connector_name =  "Point01"},
		}-- end of Elements
}

declare_loadout(ADM_141A_x1)
