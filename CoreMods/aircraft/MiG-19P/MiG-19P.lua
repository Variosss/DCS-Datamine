dofile(current_mod_path.."/WEAPONS/MiG-19P_Weapons.lua")


-- Aircraft Definition
MiG_19P = {
	
	-- General Information
	Name 				=   'MiG-19P',
	DisplayName			= _('MiG-19P'),
	ViewSettings		= ViewSettings,

	Picture 			= "MiG-19P_FarmerB.png",
	Rate 				= 50, -- RewardPoint in Multiplayer
	Shape 				= "MiG_19P",
	
	-------------------------
	shape_table_data 	=
	{
		{
			file  	 = 'MiG_19P';
			life  	 = 18; 				-- lifebar
			vis   	 = 3; 				-- visibility gain.
			desrt    = 'MiG-19P_destr';	-- Name of destroyed object file name
			fire  	 = { 300, 2};		-- Fire on the ground after destoyed: 300sec 2m
			username = 'MiG-19P';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "MiG-19P_destr";
			file  = "MiG-19P_destr";
			fire  = { 240, 2};
		},

	},
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	-------------------------
	-- Model draw args for network transmitting to this draw_args table (32 limit)
	net_animation = 
	{
		49,  -- NAV_LIGHTS
		51,  -- LANDING_LIGHTS
		83,  -- STROBE_LIGHT_TOP
		88,  -- FORM_LIGHTS
		190, -- LEFT_NAV_LIGHT
		191, -- TAIL_NAV_LIGHT
		192, -- RIGHT_NAV_LIGHT
		208, -- LANDING_LIGHT
		209, -- TAXI_LIGHT
		802, -- STRONG_LIGHT_BOTTOM
		900, -- Pilot throttle movement
		901, -- Helmet visor UP_DOWN
		902, -- Pilot taxi signal
		903, -- Navigation lights intensity
        904, -- Chute hidden but chute door open flag
	},
	
	-------------------------
	mapclasskey	= "P0091000024",
	attribute	= {
		wsType_Air, 
		wsType_Airplane, 
		wsType_Fighter,
		WSTYPE_PLACEHOLDER,
		"Fighters",
	},
	
	Categories	= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor", "15"},
	
	--------- General Characteristics ---------
	length					=	13.025,
	height					=	 3.8885,
	wing_area				=	25.16,
	wing_span				=	 9.000,
	wing_tip_pos			= 	{-2.537, -0.265, 4.5},
	RCS						=	5,
	air_refuel_receptacle_pos	= 	{0,	0,	0},
	has_speedbrake			=	true,
	brakeshute_name			=	2,
	tanker_type				=	0,
	is_tanker				=	false,
	stores_number			=	4,		-- MiG-19P: Wing Outer x 2, Wing Middle x 2
	
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	= "mig19p_pilot_seat",
			drop_canopy_name	= "mig19p_canopy",
			pilot_name			= "pilot_mig15",
			drop_parachute_name	= "pilot_mig15_parachute",
			pos					= {3.756, 0.391, 0.0},	-- {2.112,	-0.369,	0},
            g_suit				= 0.8,					-- % G suit efectivity: 0.0 to 1.0 (1.0 == modern g-suits)
		}, 
	},
	
	----- Mechanimations  ---------------------
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 0}, {"Arg", 38, "to", 0.9, "in", 1.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 0}, {"Arg", 38, "to", 0.0, "in", 1.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
        },
    }, 
	
	----- Weight & Fuel Characteristics  ------
	M_empty		=	5252.0,		-- with pilot and nose load, kg (5170Kg (empty) + 82Kg (pilot))
	M_nominal	=	7052.0,		-- kg (Empty Plus Full Internal Fuel of 1800kg) (Old value == 7384.0)
	M_max		=	8738.0,		-- kg (Maximum Take Off Weight - Rolling)
	M_fuel_max	=	1800.0,		-- kg (Maximum Internal Fuel Only)
	H_max		=	17500,		-- m  (Maximum Operational Ceiling)
	CAS_min		=	60,			-- Minimum CAS speed (m/s) (for AI)
	average_fuel_consumption	=	0.5,
	
	---------- AI Flight Parameters -----------
	V_opt 						= 850 / 3.6,-- Cruise speed (for AI)*
	V_take_off 					= 63, 		-- Take off speed in m/s (for AI)*	(122)
	V_land 						= 78, 		-- Land speed in m/s (for AI)
	V_max_sea_level 			= 1059/3.6, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 992/3.6 ,	-- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 51, 		-- Max climb speed in m/s (for AI)
	Mach_max 					= 1.1, 	    -- Max speed in Mach (for AI)
	Ny_min 						= -3, 		-- Min G (for AI)
	Ny_max 						= 7.0,  	-- Max G (for AI)
	Ny_max_e 					= 7.0, 		-- ?? Max G (for AI)
	AOA_take_off 				= 0.17, 	-- AoA in take off radians (for AI)
	bank_angle_max 				= 85,		-- Max bank angle (for AI)
	flaps_maneuver 				= 0.5, 		-- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 1200, 	-- Max range in km (for AI)
	
	-------- Suspension Characteristics -------
	tand_gear_max 								= 0.700, 					-- tangent on maximum yaw angle of front wheel, 50 degrees

	nose_gear_pos 								= { 4.700, -1.375, 0.000},		-- nosegear coord 
	nose_gear_wheel_diameter 					=  0.480,					-- in m
	nose_gear_amortizer_direct_stroke   		=  0.100,						-- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  		= -0.100,					-- up 
	nose_gear_amortizer_normal_weight_stroke 	=  0.000,					-- up 
	
	main_gear_pos								= { 0.200, -1.375 , 2.100},	-- main gear coords (base = 3810)
	main_gear_wheel_diameter					=  0.660,					-- in m
	main_gear_amortizer_direct_stroke			=  0.150,						-- down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke			= -0.150,					-- up 
	main_gear_amortizer_normal_weight_stroke	=  0.000,					-- down from main_gear_pos
	
	---------- Engine Characteristics ---------
	has_afteburner			=	true,
	thrust_sum_max			=	5243,
	thrust_sum_ab			=	6506,
	engines_count			=	2,
	IR_emission_coeff		=	0.34,	-- Corrected numbesr provided by ED based on Su-27 IR Coeff = MIL Thrust / Su-27 MIL Thrust
	IR_emission_coeff_ab	=	1.60,	-- Corrected number provided by ED based on Su-27 AB IR Coeff = MIL IR * 4: 0.4 *4 = 1.6
	
	engines_nozzles = 
	{
		[1] = 
		{
			engine_number		= 1,
			pos 				= {-4.000, 0.039, -0.375},
			elevation			= 0,
			diameter			= 0.75,
			exhaust_length_ab	= 5.000,
			exhaust_length_ab_K	= 0.76,
			smokiness_level		= 0.2,
		}, -- end of [1]
		[2] = 
		{
			engine_number		= 2,
			pos 				= {-4.000, 0.039, 0.375},
			elevation			= 0,
			diameter			= 0.75,
			exhaust_length_ab	= 5.000,
			exhaust_length_ab_K	= 0.76,
			smokiness_level		= 0.2,
		}, -- end of [2]
	}, -- end of engines_nozzles
	
	--------- Sensors Characteristics ---------
	detection_range_max		=	100,
	radar_can_see_ground	=	true,
	Sensors = {
		RWR = "Abstract RWR",
		RADAR = "N-008",
	},
	
	---------- Radio Characteristics ----------
	HumanRadio = {
		frequency		= 124.0,  -- Radio Freq
		editable		= true,
		minFrequency	= 100.0,
		maxFrequency	= 150.0,
		modulation		= MODULATION_AM
	},
	
	panelRadio = {
		[1] = {
			name = _("RSIU-4V Radio"),
			range = {
				{min = 100.0, max = 150.0},
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 121.0, modulation = _("AM")}, -- Anapa-Vityazevo
                [2] = { name = _("Channel 2"),		default = 124.0, modulation = _("AM")}, -- Krymsk
                [3] = { name = _("Channel 3"),		default = 122.0, modulation = _("AM")},	-- Krasnodar-Center
                [4] = { name = _("Channel 4"),		default = 125.0, modulation = _("AM")},	-- Maykop-Khanskaya
                [5] = { name = _("Channel 5"),		default = 127.0, modulation = _("AM")},	-- Sochi-Adler
				[6] = { name = _("Channel 6"),		default = 135.0, modulation = _("AM")},	-- Mineralnye-Vody
            }
		},
	},
	
	----------- ECM Characteristics -----------
	-- NONE
	
	--------- Armament Characteristics ---------
	Guns = {
		nr30({
			muzzle_pos				= { 4.0, 0.0, -0.92 },
			muzzle_pos_connector	= "GUN_L",
			azimuth_initial			= 0,
			elevation_initial		= 0,	-- 0.7,
			ejector_pos				= { -3.5, -0.4 , 0.0},
			-- ejector_pos_connector	= "EJECTOR_L",
		}),	-- LEFT
		nr30({
			muzzle_pos				= { 4.0, 0.0,  0.92 },
			muzzle_pos_connector	= "GUN_R",
			azimuth_initial			= 0,
			elevation_initial		= 0,	-- 0.7,
			ejector_pos				= { -3.5, -0.4 ,  0.0},
			-- ejector_pos_connector	= "EJECTOR_R",
		}),	-- RIGHT
	},
	
	ammo_type ={
		_("AP-T, APHE, HEI-T, HEI-T, HEI-T"),
		_("OFZT 30x155 HEI-T"),
		_("BT 30x155 AP-T"),
		_("BR 30x155 APHE"),
	},
	
	Pylons = {
		--          Front/Rear, Up/Down, Left/Right
		--            +   -      +  -      -    +
		-- Left Wing
		pylon(1, 0, 0.172, -0.515, -3.165, 
			{ arg = 308, arg_value = 0, connector = "str_pnt_001", use_full_connector_position = true, },
			{
				{
				  CLSID = "{K-13A}",
				  arg_value = 0.15,
				  required = {{station = 6, loadout = {"{K-13A}"}}}
				},
				
				-- Smoke Generators
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder red
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder green
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder blue
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder white
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder yellow
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder orange
			}
		),
		pylon(2, 0, -0.404, -0.39, -2.595, 
			{ arg = 309, arg_value = 0, connector = "str_pnt_002", use_full_connector_position = true, },
			{
				-- Bombs
				{ CLSID = "FAB_50",									arg_value = 0.15, attach_point_position = { 0.20, 0.03, 0.0}, required = {{station = 5, loadout = {"FAB_50"}}} },
				{ CLSID = "FAB_100M",								arg_value = 0.15, attach_point_position = { 0.20, 0.03, 0.0}, required = {{station = 5, loadout = {"FAB_100M"}}} },
				{ CLSID	= "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",	arg_value = 0.15, attach_point_position = { 0.15, 0.03, 0.0}, required = {{station = 5, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },
				
				-- Rockets
				{ 
					CLSID	=	"{ORO57K_S5M_HEFRAG}",	
					arg_value = 0.15, 
					attach_point_position = { 0.075, -0.125, 0.0}, 
					required = {{station = 5, loadout = {"{ORO57K_S5M_HEFRAG}"}}} 
				},
				--[[
				{ 
					CLSID	=	"{ORO57K_S5M1_HEFRAG}",	
					arg_value = 0.15, 
					attach_point_position = { 0.075, -0.125, 0.0}, 
					required = {{station = 5, loadout = {"{ORO57K_S5M1_HEFRAG}"}}} 
				},
				{ 
					CLSID	=	"{ORO57K_S5MO_HEFRAG}",	
					arg_value = 0.15, 
					attach_point_position = { 0.075, -0.125, 0.0}, 
					required = {{station = 5, loadout = {"{ORO57K_S5MO_HEFRAG}"}}} 
				},
				--]]
				
				-- Fuel tanks
				{ CLSID = "PTB760_MIG19",							arg_value = 0.35, attach_point_position = { 0.0, -0.10, 0.0}, required = {{station = 5, loadout = {"PTB760_MIG19"}}} },
			}
		),
		pylon(3, 0, -0.297, -0.395, -1.81, 
			{ arg = 312, arg_value = 0, connector = "str_pnt_003", use_full_connector_position = true, },
			{
				{ 
				  CLSID	=	"{ORO57K_S5M_HEFRAG}",	
				  arg_value = 0.15, 
				  required = {{station = 4, loadout = {"{ORO57K_S5M_HEFRAG}"}}},
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				--[[
				{ 
				  CLSID	=	"{ORO57K_S5M1_HEFRAG}",	
				  arg_value = 0.15, 
				  required = {{station = 4, loadout = {"{ORO57K_S5M1_HEFRAG}"}}},
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				{ 
				  CLSID	=	"{ORO57K_S5MO_HEFRAG}",	
				  arg_value = 0.15, 
				  required = {{station = 4, loadout = {"{ORO57K_S5MO_HEFRAG}"}}},
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				--]]
			}
		),
		pylon(4, 0, -0.297, -0.395, 1.81, 
			{ arg = 313, arg_value = 0, connector = "str_pnt_004", use_full_connector_position = true, },
			{
				{
				  CLSID		=	"{ORO57K_S5M_HEFRAG}",	
				  arg_value	= 0.15, 
				  required	= {{station = 3, loadout = {"{ORO57K_S5M_HEFRAG}"}}}, 
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				--[[
				{
				  CLSID		=	"{ORO57K_S5M1_HEFRAG}",	
				  arg_value	= 0.15, 
				  required	= {{station = 3, loadout = {"{ORO57K_S5M1_HEFRAG}"}}}, 
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				{
				  CLSID		=	"{ORO57K_S5MO_HEFRAG}",	
				  arg_value	= 0.15, 
				  required	= {{station = 3, loadout = {"{ORO57K_S5MO_HEFRAG}"}}}, 
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				--]]
			}
		),
		pylon(5, 0, -0.404, -0.39, 2.595, 
			{ arg = 310, arg_value = 0, connector = "str_pnt_005", use_full_connector_position = true, },
			{
				-- Bombs
				{ CLSID = "FAB_50",									arg_value = 0.15, attach_point_position = { 0.20, 0.03, 0.0}, required = {{station = 2, loadout = {"FAB_50"}}} },
				{ CLSID = "FAB_100M",								arg_value = 0.15, attach_point_position = { 0.20, 0.03, 0.0}, required = {{station = 2, loadout = {"FAB_100M"}}} },
				{ CLSID	= "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",	arg_value = 0.15, attach_point_position = { 0.15, 0.03, 0.0}, required = {{station = 2, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },
				
				-- Rockets
				{ 
					CLSID	=	"{ORO57K_S5M_HEFRAG}",	
					arg_value = 0.15, 
					attach_point_position = { 0.075, -0.125, 0.0}, 
					required = {{station = 2, loadout = {"{ORO57K_S5M_HEFRAG}"}}} 
				},
				
				--[[
				{ 
					CLSID	=	"{ORO57K_S5M1_HEFRAG}",	
					arg_value = 0.15, 
					attach_point_position = { 0.075, -0.125, 0.0}, 
					required = {{station = 2, loadout = {"{ORO57K_S5M1_HEFRAG}"}}} 
				},
				{
				  CLSID		=	"{ORO57K_S5MO_HEFRAG}",	
				  arg_value	= 0.15, 
				  required	= {{station = 3, loadout = {"{ORO57K_S5MO_HEFRAG}"}}}, 
				  attach_point_position	= {-0.05, -0.16, 0.0} 
				},
				--]]
				
				-- Fuel tanks
				{ CLSID = "PTB760_MIG19",							arg_value = 0.35, attach_point_position = { 0.0, -0.10, 0.0}, required = {{station = 2, loadout = {"PTB760_MIG19"}}} },
			}
		),
		pylon(6, 0, 0.172, -0.515, 3.165, 
			{ arg = 311, arg_value = 0, connector = "str_pnt_006", use_full_connector_position = true, },
			{
				{
				  CLSID = "{K-13A}",
				  arg_value = 0.15,
				  required = {{station = 1, loadout = {"{K-13A}"}}}
				},
				
				-- Smoke Generators
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder red
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B2}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder green
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder blue
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder white
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B5}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder yellow
				{
					CLSID = "{D3F65166-1AB8-490f-AF2F-2FB6E22568B6}", 
					arg_value = 0.15,
					attach_point_position = { -0.20, 0.0, 0.0},
					forbidden = {{station = 2}, {station = 3}, {station = 4}, {station = 5}}
				},	-- Smokewinder orange
			}
		),
	},
	
	Tasks = {
		aircraft_task(CAP),				-- 11,
        aircraft_task(CAS),				-- 31,
        aircraft_task(Escort),			-- 18,
        aircraft_task(FighterSweep),	-- 19,
        aircraft_task(GroundAttack),	-- 32,
        aircraft_task(Intercept),		-- 10,
    },	
	
	DefaultTask = aircraft_task(CAP),
	
	------- Flight Model Characteristics -------
	SFM_Data =
	{		
		aerodynamics =
		{
			Cy0	        =   0, -- zero AoA lift coefficient*
			Mzalfa	    =   3.500, -- coefficients for pitch agility
			Mzalfadt	=   0.800, -- coefficients for pitch agility
			kjx	        =   2.150, -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations)
			kjz	        =   0.015, -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe	    =  -0.016, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	    =   0.020, -- coefficient, drag, gear ??
			cx_flap	    =   0.125, -- coefficient, drag, full flaps
			cy_flap	    =   0.350, -- coefficient, normal force, lift, flaps
			cx_brk	    =   0.040, -- coefficient, drag, breaks
			table_data  = 
			{
                --M     Cx0*	 	Cya*	B2		B4	 	Omxmax	Aldop*	Cymax*
                {0.00,	0.02400,	0.0670,	0.125,	0.070,	0.3500,	22.0,	1.100},
                {0.20,	0.02400,	0.0670,	0.125,	0.070,	0.7000,	22.0,	1.100},
                {0.40,	0.02400,	0.0682,	0.125,	0.120,	1.1000,	22.0,	1.050},
                {0.60,	0.02400,	0.0746,	0.130,	0.140,	1.7204,	21.5,	1.000},
                {0.70,	0.01800,	0.0798,	0.130,	0.140,	2.1299,	21.0,	0.990},
                {0.80,	0.01500,	0.0850,	0.120,	0.230,	2.4261,	20.5,	0.980},
                {0.90,	0.01550,	0.0760,	0.135,	0.170,	2.6090,	20.0,	0.960},
                {1.00,	0.03700,	0.0735,	0.160,	0.135,	2.6786,	17.0,	0.950},
                {1.05,	0.03750,	0.0744,	0.185,	0.080,	2.6709,	16.0,	0.940},
                {1.10,	0.04000,	0.0760,	0.185,	0.080,	2.6348,	14.0,	0.930},
                {1.20,	0.04000,	0.0760,	0.190,	0.120,	2.4777,	14.0,	0.700},
                {1.30,	0.04000,	0.0760,	0.210,	0.120,	2.2073,	14.0,	0.600},
                {1.40,	0.04000,	0.0760,	0.220,	0.120,	1.8236,	14.0,	0.500},
                {1.50,	0.04000,	0.0760,	0.280,	0.120,	1.3265,	14.0,	0.475},
			}, -- end of table_data
            -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B2 - Polar 2nd power coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		}, -- end of aerodynamics
		
		engine =
		{
			Nmg		=	50,		-- RPM at idle
			MinRUD	=	0,		-- Min state of the РУД
			MaxRUD	=	1,		-- Max state of the РУД
			MaksRUD	=	0.85,	-- Military power state of the РУД
			ForsRUD	=	0.91,	-- Afterburner state of the РУД
			typeng	=	1,		-- 0 - engine with high bypass ratio, 1 - jet engine
			hMaxEng	=	19,		-- Max altitude for safe engine operation in km
			dcx_eng	=	0.0150,	-- Engine drag coeficient
			cemax	=	1.24,	-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56,	-- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1600,	-- altitude coefficient for max thrust
			dpdh_f	=	2500,	-- altitude coefficient for AB thrust
			table_data = 
			{         --   M    Pmax    Pfor
				[1] = 	{0.00,	41141,	51049},
				[2] = 	{0.08,	39118,	49639},
				[3] = 	{0.16,	37742,	48546},
				[4] = 	{0.24,	36890,	47930},
				[5] = 	{0.32,	36429,	47952},
				[6] = 	{0.40,	36358,	47973},
				[7] = 	{0.49,	36421,	47995},
				[8] = 	{0.57,	36481,	48174},
				[9] = 	{0.65,	36931,	48355},
				[10] = 	{0.73,	37385,	48535},
				[11] = 	{0.81,	37966,	48715},
				[12] = 	{0.89,	38677,	48896},
				[13] = 	{0.97,	39130,	49235},
				[14] = 	{1.05,	39445,	49574},
			}, -- end of table_data
		}, -- end of engine
	},-- end of SFM_Data
	
	------------- Damage Table Reference -------------
	Damage = verbose_to_dmg_properties(
	{
		-- Dynamic Index values are for visual damage only. They cannot be used for component damage.
		-- AVIONICS
		["BLADE_1_IN"]				= {critical_damage = 2},		-- RP-5 Search antenna
		["BLADE_1_CENTER"]			= {critical_damage = 2},		-- RP-5 Tracking antenna
		["BLADE_4_OUT"]				= {critical_damage = 2},		-- RSIU-4V Radio
		["BLADE_4_CENTER"]			= {critical_damage = 2},		-- Radio Altimeter
		["BLADE_5_IN"]				= {critical_damage = 2},		-- ASP-5 Gunsight
		["BLADE_5_CENTER"]			= {critical_damage = 2},		-- ARK-5 Receiver
		
		-- ARMAMENT
		["PYLON1"]					= {critical_damage = 2},		-- Left NR-30 Gun
		["PYLON2"]					= {critical_damage = 2},		-- Right NR-30 Gun
		
		-- FUEL TANKS
		["FUEL_TANK_F"]				= {critical_damage = 2},		-- No 1 Fuel Tank (Main)
		["FUEL_TANK_B"]				= {critical_damage = 2},		-- No 2, 3 & 4 tanks
		
		-- ENGINES
		["ENGINE_L"]				= {critical_damage = 7},				-- Left Engine
		["ENGINE_L_OUT"]			= {critical_damage = 4, args = {272}},	-- Left Engine Jet Pipe
		["ENGINE_R"]				= {critical_damage = 7},				-- Right Engine
		["ENGINE_R_OUT"]			= {critical_damage = 4, args = {270}},	-- Right Engine Jet Pipe
		
		-- ENGINE COMPONENTS
		["BLADE_2_CENTER"]			= {critical_damage = 2},		-- Hydraulic System Oil Tank
		["BLADE_3_CENTER"]			= {critical_damage = 2},		-- Left engine oil tank
		["BLADE_5_OUT"]				= {critical_damage = 2},		-- Left engine generator
		["BLADE_6_CENTER"]			= {critical_damage = 2},		-- Left engine hydraulic pump
		["BLADE_3_IN"]				= {critical_damage = 2},		-- Right engine oil tank
		["BLADE_6_IN"]				= {critical_damage = 2},		-- Right engine generator
		["BLADE_6_OUT"]				= {critical_damage = 2},		-- Right engine hydraulic pump
		
		-- CONTROL SURFACES
		["PYLON3"]					= {critical_damage = 2},		-- Brake Parachute
		["BLADE_2_OUT"]				= {critical_damage = 2},		-- Elevator Actuator
		["BLADE_4_IN"]				= {critical_damage = 2},		-- Elevator Transmition relation control (ARU-2)
		["BLADE_3_OUT"]				= {critical_damage = 2},		-- Aileron Boost control (BU-14)
		["AILERON_L"]				= {critical_damage = 4, args = {226}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_AILERON_L"},	-- Left wing aileron
		["FLAP_L"]					= {critical_damage = 4, args = {227}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_FLAP_L"},      -- Left wing flaps
		["AILERON_R"]				= {critical_damage = 4, args = {216}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_AILERON_R"},	-- Right wing aileron
		["FLAP_R"]					= {critical_damage = 4, args = {217}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_FLAP_R"},	    -- Right wing flaps
		["AIR_BRAKE_L"]				= {critical_damage = 4, args = {185}},	-- Left Airbrake
		["AIR_BRAKE_R"]				= {critical_damage = 4, args = {183}},	-- Right Airbrake
		["HOOK"]					= {critical_damage = 4, args = {187}},	-- Center Airbrake
		["RUDDER"]					= {critical_damage = 4, args = {247}, damage_boundary = 0.7, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_RUDDER"},		-- Tail rudder
		["ELEVATOR_L"]				= {critical_damage = 4, args = {240}, damage_boundary = 0.7, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_ELEVATOR_L"},	-- Left elevator
		["ELEVATOR_R"]				= {critical_damage = 4, args = {238}, damage_boundary = 0.7, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_ELEVATOR_R"},	-- Right elevator
		
		-- LANDING GEAR
		["FRONT_WHEEL"]				= {critical_damage = 3, args = {253}},									-- NOSE GEAR ASSEMBLY ** Dynamic Index
		["FRONT_GEAR_BOX"]			= {critical_damage = 4, args = {265}, deps_cells = {"FRONT_WHEEL"}},	-- NOSE GEAR HOUSING
		["LEFT_WHEEL"]				= {critical_damage = 3, args = {259}},									-- LEFT GEAR ASSEMBLY ** Dynamic Index
		["LEFT_GEAR_BOX"]			= {critical_damage = 4, args = {267}, deps_cells = {"LEFT_WHEEL"}},		-- LEFT GEAR HOUSING
		["RIGHT_WHEEL"]				= {critical_damage = 3, args = {255}},									-- RIGHT GEAR ASSEMBLY ** Dynamic Index
		["RIGHT_GEAR_BOX"]			= {critical_damage = 4, args = {266}, deps_cells = {"RIGHT_WHEEL"}},	-- RIGHT GEAR HOUSING
		
		-- WINGS
		["PITOT"]					= {critical_damage = 2},																					-- Pitot tube probe
		["WING_L_OUT"]				= {critical_damage = 4, args = {223}},																		-- Left wing tip
		["WING_L_CENTER"]			= {critical_damage = 4, args = {224}, damage_boundary = 0.7, deps_cells = {"WING_L_OUT", "AILERON_L"}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_WING_L"}, -- Left wing Center
		["WING_L_IN"]				= {critical_damage = 4, args = {225}, deps_cells = {"WING_L_CENTER", "FLAP_L", "PYLON1"}},					-- Left Wing Root
		["WING_R_OUT"]				= {critical_damage = 4, args = {213}, deps_cells = {"PITOT"}},												-- Right wing tip
		["WING_R_CENTER"]			= {critical_damage = 4, args = {214}, damage_boundary = 0.7, deps_cells = {"WING_R_OUT", "AILERON_R"}, droppable = true,  droppable_shape = "MIG_19P_OBLOMOK_WING_R"}, -- Right wing Center
		["WING_R_IN"]				= {critical_damage = 4, args = {215}, deps_cells = {"WING_R_CENTER", "FLAP_R", "PYLON2", "BLADE_3_OUT"}},	-- Right Wing Root
		
		-- FUSELAGE
		["FUSELAGE_TOP"]			= {critical_damage = 4, args = {151}},												-- Fuselage top.
		["BLADE_2_IN"]				= {critical_damage = 4, args = {157}},												-- Left engine housing cover
		["BLADE_1_OUT"]				= {critical_damage = 4, args = {158}},												-- Right engine housing cover
		["FUSELAGE_LEFT_SIDE"]		= {critical_damage = 4, args = {154}, deps_cells = {"AIR_BRAKE_L", "BLADE_2_IN"}},	-- Fuselage left side 
		["FUSELAGE_RIGHT_SIDE"]		= {critical_damage = 4, args = {153}, deps_cells = {"AIR_BRAKE_R", "BLADE_1_OUT"}},	-- Fuselage right side 
		["FUSELAGE_BOTTOM"]			= {critical_damage = 4, args = {156}, deps_cells = {"HOOK"}},						-- Fuselage bottom
		["PYLON4"]					= {critical_damage = 4, args = {160}, deps_cells = {"PYLON3"}},						-- Parachute door
		
		-- TAIL
		["FIN_L_TOP"]				= {critical_damage = 4, args = {242}},													-- Tail fin top
		["FIN_L_CENTER"]			= {critical_damage = 4, args = {242}, deps_cells = {"FIN_L_TOP", "RUDDER"}},			-- Tail fin center
		["FIN_L_BOTTOM"]			= {critical_damage = 4, args = {242}, deps_cells = {"FIN_L_CENTER"}},					-- Tail fin bottom
		["TAIL"]					= {critical_damage = 4, args = {159}, deps_cells = {"ENGINE_L_OUT", "ENGINE_R_OUT"}},	-- Tail pipe cover
		["TAIL_LEFT_SIDE"]			= {critical_damage = 4, args = {167}, deps_cells = {"ELEVATOR_L"}},						-- Tail left side
		["TAIL_RIGHT_SIDE"]			= {critical_damage = 4, args = {161}, deps_cells = {"ELEVATOR_R"}},						-- Tail right side
		["TAIL_BOTTOM"]				= {critical_damage = 4, args = {152}, deps_cells = {"PYLON3"}},							-- Tail bottom
				
		-- NOSE SECTION
		["NOSE_CENTER"]				= {critical_damage = 4, args = {146}, deps_cells = {"BLADE_1_IN", "BLADE_1_CENTER"}},
		["NOSE_BOTTOM"]				= {critical_damage = 4, args = {148}, deps_cells = {"BLADE_1_CENTER"}},
		["NOSE_LEFT_SIDE"]			= {critical_damage = 4, args = {296}, deps_cells = {"BLADE_4_OUT", "BLADE_4_CENTER"}},
		["NOSE_RIGHT_SIDE"]			= {critical_damage = 4, args = {297}, deps_cells = {"BLADE_4_OUT", "BLADE_4_CENTER"}},
		
		-- COCKPIT
		["CABIN_LEFT_SIDE"]			= {critical_damage = 4, args = {298}, deps_cells = {"BLADE_5_IN"}},
		["CABIN_RIGHT_SIDE"]		= {critical_damage = 4, args = {299}, deps_cells = {"BLADE_5_CENTER"}},
		["CABIN_BOTTOM"]			= {critical_damage = 4, args = {300}},
		["CREW_1"]					= {critical_damage = 2},							-- Pilot
		["ARMOR_PLATE_LEFT"]		= {critical_damage = 6, deps_cells = {"CREW_1"}},	-- Armored seat
		["COCKPIT"]					= {critical_damage = 1, args = {65}},				-- Canopy
		
	}
	),-- end of Damage

	DamageParts 	=
 	{
        [1] = "MIG_19P_OBLOMOK_WING_L",
        [2] = "MIG_19P_OBLOMOK_WING_R",
        [1000 + 35] = "MIG_19P_OBLOMOK_WING_L", -- Wing L
        [1000 + 36] = "MIG_19P_OBLOMOK_WING_R", -- Wing R
        [1000 + 25] = "MIG_19P_OBLOMOK_AILERON_L", --Aileron L
        [1000 + 26] = "MIG_19P_OBLOMOK_AILERON_R", --Aileron R
        [1000 + 37] = "MIG_19P_OBLOMOK_FLAP_L", --Flap L
        [1000 + 38] = "MIG_19P_OBLOMOK_FLAP_R", --Flap R

        [1000 + 51] = "MIG_19P_OBLOMOK_ELEVATOR_L", --Elevator L
        [1000 + 52] = "MIG_19P_OBLOMOK_ELEVATOR_R", -- Elevator R
        [1000 + 53] = "MIG_19P_OBLOMOK_RUDDER", -- Rudder
	},
	
	--------- Failure Table Reference ----------
	
	----- External Lights Table Reference ------
	-- Must create the connectors in the exernal model for the external lights
	--[[ LIGHT COLLECTION DATA
		LIGHT COLLECTION DATA
		WOLALIGHT_STROBES          = 1		--White strobe anti-collision lights.--
		WOLALIGHT_SPOTS            = 2		--Take-off and landing high power headlights.--
		WOLALIGHT_LANDING_LIGHTS   = 2		--Take-off and landing high power headlights.--
		WOLALIGHT_NAVLIGHTS        = 3		--P-Z colored navigation (position) wingtip lights..--
		WOLALIGHT_FORMATION_LIGHTS = 4		--Formation / Logo lights.--
		WOLALIGHT_TIPS_LIGHTS      = 5		--Helicopter-specific: rotor anti-collision tips lights.--
		WOLALIGHT_TAXI_LIGHTS      = 6		--Taxi headlights.--
		WOLALIGHT_BEACONS          = 7		--Rotary anti-collision lights.--
		WOLALIGHT_CABIN_BOARDING   = 8		--Cabin incandescence illumination.--
		WOLALIGHT_CABIN_NIGHT      = 9		--Cabin night time (UV) illumination.--
		WOLALIGHT_REFUEL_LIGHTS    = 10		--Refuel apparatus illumination.--
		WOLALIGHT_PROJECTORS       = 11		--Search lights, direction-controlled.--
		WOLALIGHT_AUX_LIGHTS       = 12		--Signal lights, also all aux. lights not fitting into other categories.--
		WOLALIGHT_IR_FORMATION     = 13		--IR formation strips. Currently not implemented due to engine NVG limitations.--
	]]--
	
	-- Position
	-- formation
	-- anti-collision
	-- landing/taxi
	-- aux lights
	-- slidelip vane lights
	-- air refueling probe
	lights_data = 	{
		typename = "collection",
		lights = 	{
			--[Taxi Light]--
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", argument = 208, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[Landing Light]--
			[WOLALIGHT_LANDING_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", argument = 209, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[Navigation Lights]--
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 190}, --Red Position
					{typename = "argumentlight",  argument  = 191}, --White Position
					{typename = "argumentlight",  argument  = 192}, --Green Position
				}
			},
		},
	},
	
	------ Aircraft Additional Properties ------
	AddPropAircraft = {
		{ id = "MountSIRENA", 				control = 'checkbox',	label = _('Mount SPO-2 Sirena RWR'),	defValue = false, weightWhenOn = -80, arg = 498},
		{ id = "MissileToneVolume",			control = 'spinbox',	label = _('Volume level for R-3S'),		defValue = 5, min = 0, max = 9, dimension = ' ' },
		{ id = "NAV_Initial_Hdg",			control = 'spinbox',	label = _('Initial course'),			defValue = 0, min = 0, max = 359, dimension = ' ' },
		{ id = "ADF_FAR_Frequency",			control = 'spinbox',	label = _('ADF FAR Frequency Preset'),	defValue = 625, min = 150, max = 1300, dimension = ' ' },	-- FAR
		{ id = "ADF_NEAR_Frequency",		control = 'spinbox',	label = _('ADF NEAR Frequency Preset'),	defValue = 303, min = 150, max = 1300, dimension = ' ' },	-- NEAR
		{ id = "ADF_Selected_Frequency",	control = 'comboList',	label = _('ADF Selected Preset'),
			values = {
				{id = 1, dispName = _("FAR")},
				{id = 2, dispName = _("NEAR")},
			},
			defValue = 1,
			wCtrl	 = 150
		},
	}
	
}

add_aircraft(MiG_19P)
