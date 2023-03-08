Mark_46 = 
{
	category = CAT_TORPEDOES,
	name = "Mark_46",
	user_name = _("Mark 46"),
	scheme          = "guided_stab_torpedo",
	class_name      = "wAmmunition",
	model           = "mk46torp",
	mass            = 230,
	
	wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_A_Torpedo,WSTYPE_PLACEHOLDER},

	-- torpedo data
	Head_Type   = 0,
	Diam        = 324.0,
	D_max       = 12000.0,
	D_min       = 500.0,
	V_min       = 10.0,
	V_max       = 250.0,
	H_max       = 75.0,
	H_min       = 5.0,
	Life_Time   = 1000.0,
	Nr_max      = 5.0,
	v_mid       = 20.0,

	
	shape_table_data =
	{
		{
			name        = "Mark_46",
			file        = "mk46torp",
			life        = 1,
			fire        = { 0, 1},
			username    = _("Mark 46"),
			index       = WSTYPE_PLACEHOLDER,
		},
	},

	fm = {
		mass            = 230.0,  
		caliber         = 0.324,  
		cx_coeff        = {1,0.39,0.38,0.236,1.31},
		L               = 2.59,
		I               = 1 / 12 * 230 * 2.59 * 2.59,
		Ma              = 0.16,
		Mw              = 0.28,
		wind_sigma      = 0.0,
		wind_time       = 0.0,
		Sw              = 1.4,
		dCydA           = {0.07, 0.036},
		A               = 0.5,
		maxAoa          = 0.3,
		finsTau         = 0.02,
		Ma_x            = 0.1,
		Mw_x            = 0.01,
		fins_val_div    = 10000,
		rho_w           = 1013,
		int_rho_y       = 0.8,
		Sww             = 0.15,
		splash_time     = 1.4,
		splash_dt       = 0.00002,
	},

	autopilot =
	{
		delay                   = 2.0,
		x_channel_delay         = 1.0,
		Kpv                     = 0.03,
		Kdv                     = 0.0,
		Kiv                     = 0.00002,
		Kph                     = 28.0,
		Kdh                     = 3.0,
		Kih                     = 0.0,
		steady_depth            = 3.0,
		x_fins_limit            = 0.1,
		fins_limit              = 0.1,
		hKp_err_croll           = 0.04,
		vel_proj_div            = 10.0,
		v_vel_limit             = 25.0,
		roll_diff_correction    = 1,
		
		hor_spir_on_time    = 0,
		hor_spir_period     = 0,
		hor_spir_power      = 0,
		
		air_ctrl			= 1,
		hor_ctrl			= 1,
	},

	air_stab_autopilot =
	{
		x_channel_delay     = 0.6,
		delay               = 1.2,
		op_time             = 50,
		stab_dive_value     = math.rad(2),
		Kconv               = 300.0,
		Knv                 = 0.005,
		Kd                  = 0.4,
		Ki                  = 0.25,
		Kout                = 1.0,
		Kx                  = 0.1,
		Krx                 = 2.0,
		fins_limit          = math.rad(20),
		fins_limit_x        = math.rad(5),
		Areq_limit          = 10,
		max_side_N          = 10,
		max_signal_Fi       = math.rad(12),
		rotate_fins_output  = 0,
		null_roll           = math.rad(0),
	},

	engine = {
		thrust              = 4080,
	},
	
	warhead         = predefined_warhead("Mark_46"),
	warhead_water   = predefined_warhead("Mark_46"),
}

declare_weapon(Mark_46)
declare_loadout({
	category		= CAT_TORPEDOES,
	CLSID			= "{Mark_46}",
	displayName		= _("Mark 46"),
	attribute       = Mark_46.wsTypeOfWeapon,
	Count           = 1,
	Cx_pil          = 0.0018,
	Picture         = "fab100.png",
	Weight          = Mark_46.mass,
	Elements        = {{ShapeName = "mk46torp"}},
})
