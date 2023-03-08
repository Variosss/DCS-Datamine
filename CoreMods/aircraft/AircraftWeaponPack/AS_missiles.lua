local MLData = {
	M299 = {
		attribute		= {4, 4, 32, WSTYPE_PLACEHOLDER},
		category		= CAT_MISSILES,
		connNamePattern	= "Point%03d",
		Count			= 4,
		Cx_pil			= 0.00208,
		modelFileName	= "M299",
		Picture			= "agm114.png",
		Weight_Empty	= 64.9,
	},
}
--					Kh-25 loadouts					--

declare_loadout({
	CLSID			= "{X-25ML}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	45},
	attribute		= {4,	4,	32,	99},
	Count			= 1,
	Cx_pil			= 0.001,
	Picture			= "kh25ml.png",
	displayName		= _("Kh-25ML (AS-10 Karen) - 300kg, ASM, Semi-Act Laser"),
	Weight			= 360,
	Elements		= ContainerWithSubshapes("APU-68", "X-25ML", 1, "Point%02d")
})

declare_loadout({
	CLSID	 		= "{X-25MR}",
	category 		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	74},
	attribute		= {4,	4,	32,	170},
	Count 			= 1,
	Cx_pil			= 0.001,
	Picture			= "kh25mr.png",
	displayName		= _("Kh-25MR (AS-10 Karen) - 300kg, ASM, RC Guided"),
	Weight			= 360,
	Elements		= ContainerWithSubshapes("APU-68", "X-25MR", 1, "Point%02d")
})

declare_loadout({
	CLSID			= "{X-25MPU}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	47},
	attribute		= {4,	4,	32,	100},
	Count			= 1,
	Cx_pil			= 0.001,
	Picture			= "kh25mpu.png",
	displayName		= _("Kh-25MPU (Updated AS-12 Kegler) - 320kg, ARM, IN & Pas Rdr"),
	Weight			= 370,
	Elements		= ContainerWithSubshapes("APU-68", "X-25MP", 1, "Point%02d")
})


--					Kh-29 loadouts					--

declare_loadout({
	CLSID			= "{X-29T}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	75},
	attribute		= {4,	4,	32,	92},
	Count			= 1,
	Cx_pil			= 0.001,
	ejectImpulse	= 2000,
	Picture			= "kh29T.png",
	displayName		= _("Kh-29T (AS-14 Kedge) - 670kg, ASM, TV Guided"),
	Weight			= 690,
	Elements		= {{
		ShapeName	= "X-29T",
		Position	= {-0.482, 0, 0}
	}}
})

declare_loadout({
	CLSID			= "{X-29L}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	49},
	attribute		= {4,	4,	32,	93},
	Count			= 1,
	Cx_pil			= 0.001,
	ejectImpulse	= 2000,
	Picture			= "kh29L.png",
	displayName		= _("Kh-29L (AS-14 Kedge) - 657kg, ASM, Semi-Act Laser"),
	Weight			= 660,
	Elements		= {{
		ShapeName	= "X-29L",
		Position	= {-0.482, 0, 0}
	}}
})


--					Kh-31 loadouts					--

declare_loadout({
	CLSID			= "{X-31A}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	53},
	attribute		= {4,	4,	32,	96},
	Count			= 1,
	Cx_pil			= 0.001,
	ejectImpulse	= 2000,
	Picture			= "kh31a.png",
	displayName		= _("Kh-31A (AS-17 Krypton) - 610kg, AShM, IN & Act Rdr"),
	NatoName		= "(AS-17)",
	Weight			= 610,
	Elements		= {{
		ShapeName	= "X-31",
		Position	= {0.245, 0, 0},
	}},
})

declare_loadout({
	CLSID			= "{X-31P}",
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4,	4,	8,	76},
	attribute		= {4,	4,	32,	97},
	Count			= 1,
	Cx_pil			= 0.001,
	ejectImpulse	= 2000,
	Picture			= "kh31p.png",
	displayName		= _("Kh-31P (AS-17 Krypton) - 600kg, ARM, IN & Pas Rdr"),
	NatoName		= "(AS-17)",
	Weight			= 600,
	Elements		= {{
		ShapeName	= "X-31",
		Position	= {0.245, 0, 0}
	}},
})

-- Hydra 70 with APKWS (AGR-20A) laser guidance kit, M151 HE DP warhead --
local AGR_20A =
{
	category		= CAT_MISSILES,
	name			= "AGR_20A",
	user_name		= _("HYDRA-70 HE APKWS"),
	scheme			= "APKWS",
	class_name		= "wAmmunitionLaserHoming",
	model			= "AGR_20",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	
	mass			= 15,
	Escort			= 1,
	Head_Type		= 4,
	sigma			= {1, 1, 1},
	H_max			= 5000.0,
	H_min			= 1.0,
	Diam			= 70.0,
	Cx_pil			= 0.00244140625,
	D_max			= 5000.0,
	D_min			= 1000.0,
	Head_Form		= 1,
	Life_Time		= 90.0,
	Nr_max			= 25,
	v_min			= 140.0,
	v_mid			= 500.0,
	Mach_max		= 3.0,
	t_b				= 0.0,
	t_acc			= 0.0,
	t_marsh			= 1.1,
	Range_max		= 5000.0,
	H_min_t			= 15.0,
	Fi_start		= 0.4,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 0.7,
	OmViz_max		= 0.35,
	exhaust			= {0.78, 0.78, 0.78, 0.3};
	X_back			= -2.0,
	Y_back			= -0.0,
	Z_back			= 0.0, -- -0.1,
	Reflection		= 0.04,
	KillDistance	= 0.0,
	M				= 15,
	
	warhead		= predefined_warhead("HYDRA_70_M151"),
	
	shape_table_data =
	{
		{
			name  = "AGR_20A";
			file  = "AGR_20";
			life  = 1;
			fire  = { 0, 1};
			username = _("APKWS"),
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	march = {
		fuel_mass   			= 3.175,
		impulse     			= 210,
		boost_time  			= 0,
		work_time   			= 1.1,
		boost_factor			= 1,
		nozzle_position 	    = {{-0.95, 0, 0}},
		nozzle_orientationXYZ   = {{0, 0, 0}},
		tail_width  			= 0.052,
		boost_tail  			= 1,
		work_tail   			= 1,
		smoke_color				= {0.5, 0.474, 0.443},
		smoke_transparency		= 0.5,
		custom_smoke_dissipation_factor		= 0.2,		
	},

	fm = {
		mass        = 15,  
		caliber     = 0.07, 
		cx_coeff    = {1, 1.5, 0.68, 0.7, 1.75},
		L           = 1.81,
		I           = 1 / 12 * 15 * 1.81 * 1.81,
		Ma          = 0.84,
		Mw          = 3.5,
		shapeName   = "AGR_20",
		wind_sigma	= 5.0,
		wind_time	= 1.1,
		dCydA		= {0.11, 0.11},
		A			= 0.36,
		Sw			= 0.04,
		maxAoa		= math.rad(8),		
		finsTau		= 0.1,
		Mx0			= 0.2,
		Ma_x		= 1.8,
		Mw_x		= 1.12,
		I_x			= 1.01,
	},
	
	seeker = {
		delay				= 1.1,
		FOV					= math.rad(40),
		max_seeker_range	= 13000,
	},

	autopilot = {
		delay				= 0.9,
		op_time				= 45,
		dV_dt				= 20,
		Knav				= 12,
		Tf					= 0.2,
		Kd					= 150,
		Kdx					= 0.2,
		Kix					= 0.8,
		gload_limit			= 10,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(10),
	},
}

declare_weapon(AGR_20A)

local function lau_131_elements_connector(adapter,elem,count)
	local dest = {{ ShapeName	= adapter, IsAdapter = true}}
	for i = 1, count do
		dest[#dest + 1] = {ShapeName = elem, connector_name = string.format("tube_%02d",i) }
	end
	return dest
end

declare_loadout({
	category 			= CAT_MISSILES,
	CLSID	 			= "{LAU-131 - 7 AGR-20A}",
	Picture				= "LAU131.png",
	--PictureBlendColor	= "0xffffffff",
	Cx_pil				= 0.00146484375,
	--displayName		= _("LAU-131 - 7 2.75' AGR-20A (HE)"),
	displayName			= _("LAU-131 pod - 7 x 2.75\" Hydra, Laser Guided Rkts M151, HE APKWS"),
	Count				= 7,
	Weight				= 29.5 + 7*15,
	wsTypeOfWeapon		= AGR_20A.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			= lau_131_elements_connector("LAU-131","AGR_20", 7)
})

declare_loadout({
	category 			= CAT_MISSILES,
	CLSID	 			= "{LAU-131x3 - 7 AGR-20A}",
	Picture				= "LAU131.png",
	Cx_pil				= 0.00244140625,
	--displayName		= _("LAU-131*3 - 7 2.75' AGR-20A (HE)"),
	displayName			= _("BRU-42 with 3 x LAU-131 pods - 7 x 2.75\" Hydra, Laser Guided Rkts M151, HE APKWS"),
	Count				= 21,
	Weight				= 50.80 + 3*(29.5 +7*15),
	wsTypeOfWeapon		= AGR_20A.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			= lau_131_elements_connector("BRU-42_LS_(LAU-131)","AGR_20", 21),
})

-- Hydra 70 with APKWS (AGR-20A) laser guidance kit, M282 HEI MPP warhead --
local AGR_20_M282 =
{
	category		= CAT_MISSILES,
	name			= "AGR_20_M282",
	user_name		= _("HYDRA-70 MPP APKWS"),
	scheme			= "APKWS",
	class_name		= "wAmmunitionLaserHoming",
	model			= "AGR_20",
	wsTypeOfWeapon 	= {wsType_Weapon,wsType_Missile,wsType_AS_Missile,WSTYPE_PLACEHOLDER},
	
	mass			= 17,
	Escort			= 1,
	Head_Type		= 4,
	sigma			= {1, 1, 1},
	H_max			= 5000.0,
	H_min			= 1.0,
	Diam			= 70.0,
	Cx_pil			= 0.00244140625,
	D_max			= 5000.0,
	D_min			= 1000.0,
	Head_Form		= 1,
	Life_Time		= 90.0,
	Nr_max			= 25,
	v_min			= 140.0,
	v_mid			= 500.0,
	Mach_max		= 3.0,
	t_b				= 0.0,
	t_acc			= 0.0,
	t_marsh			= 1.1,
	Range_max		= 5000.0,
	H_min_t			= 15.0,
	Fi_start		= 0.4,
	Fi_rak			= 3.14152,
	Fi_excort		= 1.05,
	Fi_search		= 0.7,
	OmViz_max		= 0.35,
	exhaust			= {0.78, 0.78, 0.78, 0.3};
	X_back			= -2.0,
	Y_back			= -0.0,
	Z_back			= 0.0,
	Reflection		= 0.04,
	KillDistance	= 0.0,
	M				= 15,
	
	warhead		= predefined_warhead("HYDRA_70_M282"),
	
	shape_table_data =
	{
		{
			name  = "AGR_20_M282";
			file  = "AGR_20";
			life  = 1;
			fire  = { 0, 1};
			username = _("APKWS M282"),
			index 	 = WSTYPE_PLACEHOLDER,
		},
	},
	
	march = {
		fuel_mass   			= 3.175,
		impulse     			= 210,
		boost_time  			= 0,
		work_time   			= 1.1,
		boost_factor			= 1,
		nozzle_position 	    = {{-0.95, 0, 0}},
		nozzle_orientationXYZ   = {{0, 0, 0}},
		tail_width  			= 0.052,
		boost_tail  			= 1,
		work_tail   			= 1,
		smoke_color				= {0.5, 0.474, 0.443},
		smoke_transparency		= 0.5,
		custom_smoke_dissipation_factor		= 0.2,		
	},

	fm = {
		mass        = 17,  
		caliber     = 0.07, 
		cx_coeff    = {1, 1.5, 0.68, 0.7, 1.75},
		L           = 1.81,
		I           = 1 / 12 * 15 * 1.81 * 1.81,
		Ma          = 0.84,
		Mw          = 3.5,
		shapeName   = "AGR_20",
		wind_sigma	= 5.0,
		wind_time	= 1.1,
		dCydA		= {0.11, 0.11},
		A			= 0.36,
		Sw			= 0.04,
		maxAoa		= math.rad(8),		
		finsTau		= 0.1,
		Mx0			= 0.2,
		Ma_x		= 1.8,
		Mw_x		= 1.12,
		I_x			= 1.01,
	},
	
	seeker = {
		delay				= 1.1,
		FOV					= math.rad(40),
		max_seeker_range	= 13000,
	},

	autopilot = {
		delay				= 0.9,
		op_time				= 45,
		dV_dt				= 20,
		Knav				= 12,
		Tf					= 0.2,
		Kd					= 150,
		Kdx					= 0.2,
		Kix					= 0.8,
		gload_limit			= 10,
		fins_limit			= math.rad(20),
		fins_limit_x		= math.rad(10),
	},
}

declare_weapon(AGR_20_M282)

declare_loadout({
	category 			= CAT_MISSILES,
	CLSID	 			= "{LAU-131 - 7 AGR-20 M282}",
	Picture				= "LAU131.png",
	--PictureBlendColor	= "0xffffffff",
	Cx_pil				= 0.00146484375,
	--displayName			= _("LAU-131 - 7 2.75' AGR-20 M282"),
	displayName			= _("LAU-131 pod - 7 x 2.75\" Hydra, Laser Guided Rkts M282, MPP APKWS"),
	Count				= 7,
	Weight				= 29.5 + 7*17,
	wsTypeOfWeapon		= AGR_20_M282.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			= lau_131_elements_connector("LAU-131","AGR_20", 7)
})

declare_loadout({
	category 			= CAT_MISSILES,
	CLSID	 			= "{LAU-131x3 - 7 AGR-20 M282}",
	Picture				= "LAU131.png",
	Cx_pil				= 0.00244140625,
	--displayName			= _("LAU-131*3 - 7 2.75' AGR-20 M282"),
	displayName			= _("BRU-42 with 3 x LAU-131 pods - 7 x 2.75\" Hydra, Laser Guided Rkts M282, MPP APKWS"),
	Count				= 21,
	Weight				= 50.80 + 3*(29.5 +7*17),
	wsTypeOfWeapon		= AGR_20_M282.wsTypeOfWeapon,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	Elements			= lau_131_elements_connector("BRU-42_LS_(LAU-131)","AGR_20", 21),
})

BatchDeclareLoadout(
	MLData.M299,
	{
		["{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}"]	= {
			displayName		= _("M299 - 4 x AGM-114K Hellfire"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 4, MLData.M299.connNamePattern),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_3xAGM_114K_OUTBOARD_PORT}"]			= {
			displayName		= _("M299 - 3 x AGM-114K Hellfire, Port"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 3, MLData.M299.connNamePattern),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wpnCount		= 3,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_3xAGM_114K_OUTBOARD_STARBOARD}"]	= {
			displayName		= _("M299 - 3 x AGM-114K Hellfire, Starboard"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 3, MLData.M299.connNamePattern, {2}),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wpnCount		= 3,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_2xAGM_114K}"] = {
			displayName		= _("M299 - 2 x AGM-114K Hellfire"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 2, MLData.M299.connNamePattern, {2}),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wpnCount		= 2,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_1xAGM_114K_OUTBOARD_PORT}"]			= {
			displayName		= _("M299 - 1 x AGM-114K Hellfire, Port"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 1, MLData.M299.connNamePattern),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wpnCount		= 1,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_1xAGM_114K_OUTBOARD_STARBOARD}"]	= {
			displayName		= _("M299 - 1 x AGM-114K Hellfire, Starboard"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName, "AGM-114K", 1, MLData.M299.connNamePattern, {1, 2}),
			Picture			= "agm114.png",
			singleWpnMass	= 44.9,
			wpnCount		= 1,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		},
		["{M299_EMPTY}"] = {
			displayName		= _("M299 - Empty Launcher"),
			Elements		= ContainerWithSubshapes(MLData.M299.modelFileName),
			Picture			= "M299.png",
			shape_table_data= {{ file = "M299", username = "M299", index = WSTYPE_PLACEHOLDER, }},
			wpnCount		= 0,
			wsTypeOfWeapon	= "weapons.missiles.AGM_114K",
		}
	}
)

AT_6 = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4, 4, 8, 48},
	name			= "AT_6",
	user_name		= _("9M114 Shturm-V (AT-6 Spiral)"),
	scheme			= "shturm_new",
	class_name		= "wAmmunitionVikhr",
	model			= "9M114",

	Escort			= 1,
	Head_Type		= 7,
	sigma			= {4, 4, 4},
	M				= 35.4,
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
	KillDistance	= 0,

	booster = {
		impulse							= 220,
		fuel_mass						= 1,
		work_time						= 0.05,
		nozzle_position					= {{-0.92, 0, 0}},
		tail_width						= 0.13,
		smoke_color						= {0.8, 0.8, 0.8},
		smoke_transparency				= 0.8,
		custom_smoke_dissipation_factor	= 0.5,
	},

	march = {
		impulse							= 240,
		fuel_mass						= 6.46, -- 7600N for 2s
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
		fuel_mass						= 2.94, -- 3600N for 3s
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
		def_cone_max_dist		= 6500,
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
		mass		= 35.4,
		caliber		= 0.13,
		L			= 1.83,
		I			= 1 / 12 * 35.4 * 1.83 ^ 2,
		Ma			= 2,
		Mw			= 5,
		cx_coeff	= {1, 1.5, 1.2, 0.2, 1.3},
		Sw			= 0.12,
		dCydA		= {0.024, 0.018},
		A			= 0.6,
		maxAoa		= 0.2,
		finsTau		= 0.05,
		freq		= 4,
	},

	eng_err = {
		y_error				= 0,
		z_error				= 0.1,
		min_time_interval	= 0.1,
		max_time_interval	= 1,
	},

	fuze = {
		default_arm_delays = { 0.8 }
	},

	shape_table_data = {{
		name		= "AT_6",
		file		= "9M114",
		username	= _("AT-6"),
		index		= WSTYPE_PLACEHOLDER
	}},

	warhead		= predefined_warhead("AT_6"),
}
declare_weapon(AT_6)

Ataka_9M120 = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	name			= "Ataka_9M120",
	user_name		= _("9M120 Ataka (AT-9 Spiral-2)"),
	scheme			= "shturm_new",
	class_name		= "wAmmunitionVikhr",
	model			= "9M120T",

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
	KillDistance	= 0,

	manualWeaponFlag = 3,

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
		nozzle_position					= {{-0.685, 0, 0.07},{-0.685, 0,-0.07}},
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
		nozzle_position					= {{-0.685, 0, 0.07},{-0.685, 0,-0.07}},
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
		nozzle_position					= {{-0.685, 0, 0.07},{-0.685, 0,-0.07}},
		nozzle_orientationXYZ			= {{0, -0.2, 0.15},{0, 0.2, 0}},
		tail_width						= 0.13,
		smoke_color						= {0.1, 0.1, 0.1},
		smoke_transparency				= 0.01,
		custom_smoke_dissipation_factor	= 1,
	},

	spiral_nav = {
		t_cone_near_rad			= 1000,
		def_cone_max_dist		= 6500,
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
		L					= 1.83, -- 2.1 with leading charge deployed
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
		default_arm_delays = { 0.8 }
	},

	shape_table_data = {{
		name		= _("9M120"),
		file		= "9M120T",
		username	= _("9M120"),
		index		= WSTYPE_PLACEHOLDER
	}},

	warhead		= predefined_warhead("9M120"),
}
declare_weapon(Ataka_9M120)

Ataka_9M120F = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {wsType_Weapon, wsType_Missile, wsType_AS_Missile, WSTYPE_PLACEHOLDER},
	name			= "Ataka_9M120F",
	user_name		= _("9M120F Ataka (AT-9 Spiral-2)"),
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
	KillDistance	= 0,

	manualWeaponFlag = 3,

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
		def_cone_max_dist		= 6500,
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
		default_arm_delays = { 0.8 }
	},

	shape_table_data = {{
		name		= _("9M120F"),
		file		= "9M120F",
		username	= _("9M120F"),
		index		= WSTYPE_PLACEHOLDER
	}},

	warhead		= predefined_warhead("9M120F"),
}
declare_weapon(Ataka_9M120F)

Vikhr_9M127_1 = {
	category		= CAT_MISSILES,
	wsTypeOfWeapon	= {4, 4, 8, 58},
	name			= "Vikhr_M",
	user_name		= _("9M127-1 Vikhr-M"),
	scheme			= "command_guided_spin_missile",
	class_name		= "wAmmunitionVikhr",
	model			= "vikhr",

	Escort			= 1,
	Head_Type		= 4,
	sigma			= {3, 3, 3},
	M				= 45,
	H_max			= 5000,
	H_min			= 5,
	Diam			= 130,
	Cx_pil			= 1,
	D_max			= 7000,
	D_min			= 800,
	Head_Form		= 0,
	Life_Time		= 30,
	Nr_max			= 12,
	v_min			= 170,
	v_mid			= 461,
	Mach_max		= 2.2,
	t_b				= 0,
	t_acc			= 5,
	t_marsh			= 5,
	Range_max		= 11000,
	H_min_t			= 0,
	Fi_start		= 0.0175,
	Fi_rak			= 3.14152,
	Fi_excort		= 0.8,
	Fi_search		= 99.9,
	OmViz_max		= 99.9,
	X_back			= -1.2,
	Y_back			= 0,
	Z_back			= 0,
	Reflection		= 0.03,
	KillDistance	= 7,
	
	controller = {
		boost_start = 0,
		march_start = 0.5,
	},

	booster = {
		impulse							= 220,
		fuel_mass						= 5.1,
		work_time						= 0.5,
		nozzle_position					= {{-1.375, 0, -0.034}, {-1.375, 0, 0.034}},
		nozzle_orientationXYZ			= {{0, 0, 0}, {0, 0, 0}},
		tail_width						= 0.2,
		smoke_color						= {1, 1, 1},
		smoke_transparency				= 0.2,
		custom_smoke_dissipation_factor	= 0.8,
		max_effect_length				= 10
	},
	
	march = {
		impulse							= 240,
		fuel_mass						= 8.1,
		work_time						= 6.3,
		nozzle_position					= {{0.165, 0, -0.064}, {0.165, 0, 0.064}},
		nozzle_orientationXYZ			= {{-0.946, 0, -0.325}, {-0.946, 0, 0.325}},
		tail_width						= 0.05,
		smoke_color						= {1, 1, 1},
		smoke_transparency				= 0.01,
		custom_smoke_dissipation_factor	= 0.2,
	},

	spiral_nav = {
		def_cone_max_dist		= 8500,
		t_cone_near_rad			= 1000,
		def_cone_near_rad		= 15,
		def_cone_near_rad_st	= 50,
		def_cone_time_stab_rad	= 5,
		gb_angle				= 0,
		gb_min_dist				= 0,
		gb_use_time				= 0,
		gb_max_retW				= 0,
		gb_ret_Kp				= 0,
	},

	autopilot = {
		Kp					= 0.078,
		Ki					= 0.058,
		Kd					= 0.038,
		max_ctrl_angle		= 1.35,
		delay				= 0.2,
		op_time				= 24,
		fins_discreet		= 0.04,
		no_ctrl_center_ang	= 0.00004,
	},

	fm = {
		mass		= 45,
		caliber		= 0.13,
		L			= 2.75,
		I			= 1 / 12 * 45 * 2.75 ^ 2,
		Ma			= 2,
		Mw			= 5,
		cx_coeff	= {1, 0.65, 0.85, 0.85, 1.4},
		Sw			= 0.1,
		dCydA		= {0.024, 0.018},
		A			= 0.6,
		maxAoa		= 0.2,
		finsTau		= 0.1,
		freq		= 2,
	},

	eng_err = {
		y_error = 0,
		z_error = 0,
		min_time_interval = 0.1,
		max_time_interval = 1,
	},

	fuze = {
		default_arm_delays = { 0.8 },
		default_function_delays = { 0, 0.02 },
		default_proximity_radius = 7,
		tdd_position = { 1.09, 0, 0 }
	},

	warhead = predefined_warhead("Vikhr_M"),

	shape_table_data = {{
		name		= _("9M127-1"),
		file		= "vikhr",
		username	= _("9M127-1 Vikhr-M"),
		index		= Vikhr_M
	}},
}
declare_weapon(Vikhr_9M127_1)

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{9M114 Shturm-V-2 Rack}",
	Picture				= "24_ME_Empty_ATGM_Launch.png",
	Cx_pil				= 0.001,
	displayName			= _("Missile Launcher Rack (Empty)"),
	Weight				= 13,
	Count				= 0,
	attribute			= {4, 4, 32, WSTYPE_PLACEHOLDER},
	Elements			= {{ ShapeName = "9M114-PYLON_EMPTY", IsAdapter = true }}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}",
	Picture				= "24_ME_ATGM_Launch+2_Miss.png",
	Cx_pil				= 0.001,
	displayName			= "2 x " .. AT_6.user_name .. " - " .. _("ATGM, SACLOS, HEAT"),
	NatoName			= "AT-6",
	Weight				= 13 + 2 * (7 + AT_6.fm.mass),
	Weight_Empty		= 13 + 2 * 7,
	Count				= 2,
	kind_of_shipping	= 0,
	attribute			= {4, 4, 32, 60},
	wsTypeOfWeapon		= AT_6.wsTypeOfWeapon,
	Elements			= {{ ShapeName = "9M114-PILON", IsAdapter = true }}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{57232979-8B0F-4db7-8D9A-55197E06B0F5}",
	Picture				= "apu8.png",
	Cx_pil				= 0.002,
	displayName			= "8 x " .. AT_6.user_name .. " - " .. _("ATGM, SACLOS, HEAT"),
	NatoName			= "AT-6",
	Weight				= 50 + 8 * (15.5 + AT_6.fm.mass),
	Weight_Empty		= 50 + 8 * 15.5,
	Count				= 8,
	kind_of_shipping	= 0,
	attribute			= {4, 4, 32, 113},
	wsTypeOfWeapon		= AT_6.wsTypeOfWeapon,
	Elements			= {{ ShapeName = "9K114_Shturm", IsAdapter = true }}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{2x9M120_Ataka_V}",
	Picture				= "24_ME_ATGM_Launch+2_Miss.png",
	Cx_pil				= 0.001,
	displayName			= "2 x " .. Ataka_9M120.user_name .. " - " .. _("ATGM, SACLOS, Tandem HEAT"),
	NatoName			= "AT-9",
	Weight				= 13 + 2 * (7 + Ataka_9M120.fm.mass),
	Weight_Empty		= 13 + 2 * 7,
	Count				= 2,
	kind_of_shipping	= 0,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= Ataka_9M120.wsTypeOfWeapon,
	Elements			= {{ ShapeName = "9M120_pylon", IsAdapter = true }}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{2x9M120F_Ataka_V}",
	Picture				= "24_ME_ATGM_Launch+2_Miss.png",
	Cx_pil				= 0.001,
	displayName			= "2 x " .. Ataka_9M120F.user_name .. " - " .. _("AGM, SACLOS, HE"),
	NatoName			= "AT-9",
	Weight				= 13 + 2 * (7 + Ataka_9M120F.fm.mass),
	Weight_Empty		= 13 + 2 * 7,
	Count				= 2,
	kind_of_shipping	= 0,
	attribute			= {4,	4,	32,	WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon		= Ataka_9M120F.wsTypeOfWeapon,
	Elements			= {{ ShapeName = "9M120_pylon", IsAdapter = true }}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{F789E86A-EE2E-4E6B-B81E-D5E5F903B6ED}",
	Picture				= "APU8.png",
	Cx_pil				= 0.001,
	displayName			= _("APU-8 - 8 x 9M127-1 Vikhr-M") .. " " .. _("ATGM, LOSBR, Tandem HEAT/Frag"),
	NatoName			= "(AT-16)",
	Weight				= 60 + 8 * (14.375 + Vikhr_9M127_1.fm.mass),
	Weight_Empty		= 60 + 8 * 14.375,
	Count				= 8,
	kind_of_shipping	= 0,
	attribute			= {4, 4, 32, 47},
	wsTypeOfWeapon		= "weapons.missiles.Vikhr_M",
	Elements			= {
		{ ShapeName	=	"9M120" },
		{ Position	=	{0,	-0.235,	-0.263} },
		{ Position	=	{0,	-0.235,	-0.116} },
		{ Position	=	{0,	-0.235,	 0.116} },
		{ Position	=	{0,	-0.235,	 0.263} },
		{ Position	=	{0,	-0.474,	-0.263} },
		{ Position	=	{0,	-0.474,	-0.116} },
		{ Position	=	{0,	-0.474,	 0.116} },
		{ Position	=	{0,	-0.474,	 0.263} },
	}
})

declare_loadout({
	category			= CAT_MISSILES,
	CLSID				= "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}",
	Picture				= "APU6.png",
	Cx_pil				= 0.001,
	displayName			= _("APU-6 - 6 x 9M127-1 Vikhr-M") .. " " .. _("ATGM, LOSBR, Tandem HEAT/Frag"),
	NatoName			= "(AT-16)",
	Weight				= 60 + 6 * (14.375 + Vikhr_9M127_1.fm.mass),
	Weight_Empty		= 60 + 6 * 14.375,
	Count				= 6,
	kind_of_shipping	= 0,
	attribute			= {4, 4, 32, 86},
	wsTypeOfWeapon		= "weapons.missiles.Vikhr_M",
	Elements			= {{ ShapeName = "9k121", IsAdapter = true }},
})
