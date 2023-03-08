--/N/ june 2020.


function make_mig21(rewrite_settings)  

local rewrite_settings  = rewrite_settings or {Name = 'MiG-21Bis', DisplayName = 'MiG-21Bis',}

local base_MiG_21Bis = {

	-- ********************* MUST *************************
	Name 	= rewrite_settings.Name or 'MiG-21Bis',
DisplayName	= _(rewrite_settings.DisplayName) or _('MiG-21Bis'),
	
Picture 	= "MiG-21.png",
	Shape 	= "MiG-21Bis", -- /M changed file name for better file organization.
	
	livery_entry	= "MiG-21Bis",
	-- ****************************************************
	
	--******************** COMMON *************************
	EmptyWeight 	= "6255",--5899
	MaxFuelWeight 	= "2280",
	MaxHeight 	= "21000",
	MaxSpeed 	= "2350",
	MaxTakeOffWeight 	= "10400",
	Rate 	= "50",
	WingSpan 	= "7.15",
	
	shape_table_data 	= 
	{
		{
		file 	 = 'MiG-21Bis';--rewrite_settings.Shape or -- /M changed file name for better file organization.  Will need help for weapons later.
		life 	 = 20;
		vis 	 = 4;
		desrt	 = 'MiG-21Bis_Destroyed'; -- /M changed file name for better file organization.
		fire 	 = { 300, 4 };
		username = rewrite_settings.Name or 'MiG-21Bis';
		index	 = WSTYPE_PLACEHOLDER;
		classname = "lLandPlane";
		positioning = "BYNORMAL";
		drawonmap 	= true;
		},

		{
		name 	= "MiG-21Bis_Destroyed"; -- /M changed file name for better file organization.
		file 	= "MiG-21Bis_Destroyed"; -- /M changed file name for better file organization.
		fire 	= { 240, 2 };
		},
	},

	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/MiG-21Bis_OWV.lua"},
	},

	--/N/ staro, do Marta 2017.
	--[[
	passivCounterm = {
	CMDS_Edit = true,
	SingleChargeTotal = 64,
	chaff = {default = 32, increment = 2, chargeSz = 1},
	flare = {default = 32, increment = 2, chargeSz = 1}
	},
	]]
	passivCounterm = {
		CMDS_Edit = false,
		SingleChargeTotal = 58,
		chaff = {default = 18, increment = 18, chargeSz = 1},
		flare = {default = 40, increment = 40, chargeSz = 1}
	},

	Countermeasures =  {

	},
	
	chaff_flare_dispenser 	= {
	[1] = -- SPS D
	{
		dir =  {-1.3, -1.3, 1.3},
		pos =  {-1.35, -0.55, 0.25},
	}, 
	[2] = -- SPS L
	{
		dir =  {-1.3, -1.3, -1.3},
		pos =  {-1.35, -0.55, -0.25},
	}, 
	[3] = -- ASO D
	{
		dir =  {-1.3, -1.3, 1.3},--/N/ brzina u m/s po osama
		pos =  {-1.714, -0.38, 0.5}, --/N/ pozicija po osama
	}, 
	[4] = -- ASO L
	{
		dir =  {-1.3, -1.3, -1.3},
		pos =  {-1.714, -0.38, -0.5},
	},
	}, -- end of chaff_flare_dispenser


	--Waypoint_Panel = true,--?
	
	attribute = {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,"Fighters",},
	
	ammo_type ={
	_("General gun shells mix"),
	_("A-G gun shells mix"),
	_("A-A gun shells mix"),
	},

	--Guns = { GSH_23 ({muzzle_pos_connector	= "GUN_POINT"}) },--"GSh_23_2"
	
	Guns = {
		GSH_23 ({ -- Left Barrel
				muzzle_pos_connector  = "GUN_POINT",
				--azimuth_initial       = inner_guns_convergence,
				--elevation_initial     = inner_guns_elevation,
				--barrel_circular_error = 0.0009,
				ejector_pos_connector = {"EJECT_001", "EJECT_002"},
				effect_arg_number = 432,
					effects = {
						{name = "FireEffect", arg = 432, attenuation = 2.0, light_pos = {0.5, 0.5, 0.0} , light_time = 0.1},
						{name = "HeatEffectExt", shot_heat = 20.9, barrel_k = 0.462 * 16.6, body_k = 0.462 * 35.4},
						{name = "SmokeEffect"},
						--{name = "PortEffect", seal_arg = 330},
					}
			}),
	},
	
	Crew = 1,
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	--sensors
	Sensors = {
	RWR = "Abstract RWR",
	RADAR = "N-008",
	--[[
	RADAR =
		{
			clsid = "RP-22SM_Sapfir",
			type = RADAR_AS,
			scan_volume =
				{
					azimuth = {-30.0, 30.0},
					elevation = {-1.5, 16.0},
				},
			max_measuring_distance = 30000.0,
			centered_scan_volume =
				{
					azimuth_sector = 20.0,
					elevation_sector = 17.5,
				},					
			detection_distance =
				{
					[HEMISPHERE_UPPER] =
						{
							[ASPECT_HEAD_ON] = 30000.0,
							[ASPECT_TAIL_ON] = 25000.0,
						},
					[HEMISPHERE_LOWER] =
						{
							[ASPECT_HEAD_ON] = 20000.0,
							[ASPECT_TAIL_ON] = 15000.0,
						}
				},					
			lock_on_distance_coeff = 0.75,
			velocity_limits =
				{
					radial_velocity_min = 0.0,--100.0 / 3.6, --apparently km/h / 3.6 -> m/s
					relative_radial_velocity_min = 0.0,--100.0 / 3.6,
				},
			scan_period = 3.0,
		},
	]]
	OPTIC = "Shkval", --/N/ needed for GROM
	},
	
	HumanRadio = {
		frequency 	= 124.0, -- /N/ onboard radio, default DCSW frequency, chnl 0
		editable 	= true,
		minFrequency	 = 118.000,
		maxFrequency	 = 390.000,
			rangeFrequency = {	{min = 118.0, max = 140.0},
								{min = 220.0, max = 390.0}  },	
		modulation	 = MODULATION_AM
	},
	
	InheriteCommonCallnames = true,

	mapclasskey = "P0091000024", 
	
	--[[
	Countries = { 
	"Russia","Ukraine","Germany","USA","Italy",
	"UK","Turkey","Canada","France","Spain","Belgium","The Netherlands","Norway",
	"Denmark","Georgia","Israel","Australia","Abkhazia",
	
	"USAF Aggressors","Switzerland","Austria","Belarus","Bulgaria","Czech Republic",
	"China","Croatia","Egypt","Finland","Greece","Hungary","India","Iran","Iraq","Japan",
	"Kazakhstan","North Korea","Pakistan","Poland","Romania","Saudi Arabia","Serbia",
	"Slovakia","South Korea","Sweden","Syria",
	},
	]]
	
	--************************************************************
	
	--******************** AIRCRAFT CONSTRUCTION ********************
	M_empty 	= 6255,--5899
	M_nominal 	= 8620,--8504 
	M_max 		= 10400,
	M_fuel_max 	= 2280,
	H_max 	 	= 20000,
	average_fuel_consumption = 0.01,
	CAS_min 	= 78,--167, -- /N/ 167--> 600; 139-->500
	V_opt 		= 223,--800
	V_take_off 	= 100,--360
	V_land 		= 94, --/N/ 338, affects APPROACH speed! not actual touchdown speed! depends on flaps in SFM (among other things)
	
	V_max_sea_level = 362,
	V_max_h 		= 697,
	Vy_max 		= 200,
	Mach_max 	= 2.05,
	Ny_min 		= -4,
	Ny_max 		= 7.5,--8.0,
	Ny_max_e 	= 7.5,--8.0, 
	AOA_take_off 	= 0.17454,
	bank_angle_max 	= 76,
	
	has_afteburner 	= true,
	has_speedbrake 	= true,
	has_differential_stabilizer	= false,
	
	detection_range_max	 = 30,
	radar_can_see_ground = true,
	
	--[[ 
	nose_gear_pos 	= {4.062, -1.58 + 0.07 + 0.03, 0.00},-- animirani hod 0.17 -- ovo odredjuje "visinu" aviona pri startu misije, ne sabija noge
	main_gear_pos 	= {-0.588, -1.57 + 0.11 + 0.018, 1.30},--animirani hod 0.22 -- ovo odredjuje "visinu" aviona pri startu misije, ne sabija noge
	
	
	nose_gear_amortizer_direct_stroke 	= 0.08,
	nose_gear_amortizer_reversal_stroke 	= -0.09,
	nose_gear_amortizer_normal_weight_stroke	= 0.00,-- ovo odredjuje sabijenost noge pri startu misije

	main_gear_amortizer_direct_stroke 	= 0.11,
	main_gear_amortizer_reversal_stroke	= -0.11,
	main_gear_amortizer_normal_weight_stroke	= 0.00,
	]]
	
	--[[ ]]
	nose_gear_pos 	= {4.062, -1.56 + 0.06, 0.00},-- animirani hod 0.12 -- ovo odredjuje "visinu" aviona pri startu misije, ne sabija noge
	main_gear_pos 	= {-0.588, -1.58 + 0.08, 1.30},--animirani hod 0.16 -- ovo odredjuje "visinu" aviona pri startu misije, ne sabija noge
	
	nose_gear_amortizer_direct_stroke 	= 0.06,
	nose_gear_amortizer_reversal_stroke 	= -0.06,
	nose_gear_amortizer_normal_weight_stroke	= 0.00,-- ovo odredjuje sabijenost noge pri startu misije

	main_gear_amortizer_direct_stroke 	= 0.08,
	main_gear_amortizer_reversal_stroke	= -0.08,
	main_gear_amortizer_normal_weight_stroke	= 0.00,
	

	
	tanker_type = 0, 
	
	wing_area 	= 23.0,
	wing_span 	= 7.154,
	wing_type 	= 0,
	thrust_sum_max 	= 7500,--44000,
	thrust_sum_ab 	= 11400,--71000,
	length 	= 14.50,--15.00,
	height 	= 4.125,
	flaps_maneuver 	= 0.5,
	range 	= 1210.0,
	RCS 	= 3.0,
	IR_emission_coeff 		= 0.6,
	IR_emission_coeff_ab 	= 2.4,
	wing_tip_pos 		= {-2.5, 0.075, 3.55},
	nose_gear_wheel_diameter 	= 0.500,
	main_gear_wheel_diameter 	= 0.800,
	brakeshute_name 	= 3, 
	is_tanker 	= false,
	air_refuel_receptacle_pos 	= {0, 0, 0},
	engines_count	= 1,
	
	engines_nozzles = {
		[1] = 
			{
				pos 	= {-6.0,	0.109,	0.0},
				elevation 	= 0.0,
				diameter 	= 0.75,
				exhaust_length_ab	= 6.5,--5.5,  --/M 20200509
				exhaust_length_ab_K = 0.7,--0.4,  --/M 20200509
				smokiness_level 	= 0.3,--0.5,
				--afterburner_effect_texture = "MiG21Bis_Afterburner_Yellow",  --/M 20200509
			},
	},
	
	crew_size	=	1,
	crew_members = 
	{
		[1] = 
			{
				ejection_seat_name = "pilot+km1",
				drop_canopy_name = "MiG-21Bis_Canopy", -- /M changed file name for better file organization.
				pilot_name	 = "MiG-21_pilot",
				pos = {2.711,	0.65,	0.0},
			},
	},	

	
	fires_pos = {
		[1]		= 	{-0.60, 0.50, 0.00}, --iza CT, na hrbatu
		[2] 	= 	{0.00, 0.00, 1.00}, -- unutr. krilo desno
		[3] 	= 	{0.00, 0.00, -1.00},  --unutr. krilo levo
		[4] 	= 	{-1.00,	0.00, 2.00}, --sred. krilo desno 
		[5] 	= 	{-1.00,	0.00, -2.00}, --sred. krilo desno 
		[6] 	= 	{-2.00,	0.00, 3.00}, --spolj. krilo desno  
		[7] 	= 	{-2.00,	0.00, -3.00}, --spolj. krilo desno 
		[8] 	= 	{-8.0, 0.15, 0.00},--trag
		[9] 	= 	{-8.0, 0.15, 0.00},--trag
		[10] 	= 	{-3.50, 0.20, 0.40},--trup desno
		[11] 	= 	{-3.50, 0.20, -0.40}, --trup levo 
	},
	
	net_animation = {
	
	38, -- Canopy Open/Close & Visibility.  0 - Close, .90 - Open, 1 - Invisible
	
	600, -- Nose Cone In/Out
    
	601, -- Big Air Inlet
    602, -- Small Air Inlet
	
    308, -- Rear Brake Visibility
	
--  Engine
	
	435, -- Afterburner Flame
	90, -- Afterburner Nozzle Ring & Feathers
	610, -- TurbineRotation
	
--  Dragchute Human	
	611,           -- Chute Deploy
	612,           -- Chute Visibility 0-off / 1-on
	613,           -- L/R Doors
	614, 615, 616, -- U/D, L/R, X-Axis Rotation
	
--  Landing Gear
	--0, 1, 2, -- Front Lower/Raise, Compression, Steering 
	--3, 4,    -- Right Lower/Raise, Compression, 
	--5, 6,    -- Left  Lower/Raise, Compression, 
	
--  Tactical Numbers
	443, 444, 445, 442, 31, 32, -- XYZ123

--  Lights
   	51, 208, 209,          -- Landing/Taxi & Lower/Raise  /M 20200509
	69,            -- Visibility to switch from DAY to NIGHT, affects the cockpit night illumination also  
	190, 191, 192, 194,  -- Green, Red, White, Gear /M 20200509

--  600, 601, 602, 611, 612, 613, 614, 615, 616, 617, 618, 619 --/N/ Mike says those are only custom args that we have  --/Mike/ Added more 20140829
	},
	
	--****************************************************

	--******************** FAILURES **********************

	Failures = {
		{ id = 'DC_BUS_FAILURE_TOTAL',	 	 label = _('DC Bus'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 0
		{ id = 'DC_BUS_GENERATOR_FAILURE',	 label = _('DC Generator'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 1
		{ id = 'AC_BUS_FAILURE_TOTAL',	 	 label = _('AC Bus'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 2
		{ id = 'AC_BUS_PO7501_FAILURE',	 	 label = _('PO7501 Inverter'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 3
		{ id = 'AC_BUS_PO7502_FAILURE',	 	 label = _('PO7502 Inverter'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 4
		{ id = 'ENGINE_FAILURE_TOTAL',	 	 label = _('Engine'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 5
		{ id = 'GYROS_FAILURE_TOTAL',	 	 label = _('Gyroscopes'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 6
		{ id = 'PITOT_FAILURE_TOTAL',	 	 label = _('Pitot Tubes'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 7
		{ id = 'WEAPONS_FAILURE_TOTAL',	 	 label = _('Weapons System'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 8
		{ id = 'SOPLO_FAILURE_PARTIAL',	 	 label = _('Engine Nozzle'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 9
		{ id = 'RADAR_FAILURE_TOTAL',	 	 label = _('Radar'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 10
		{ id = 'KPP_FAILURE_PARTIAL',	 	 label = _('Kpp'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 11
		
		{ id = 'LANDING_LIGHTS_FAILURE',	 	 label = _('Landing lights failure'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 }, -- 12, 03. Dec 2014
	},

	--****************************************************

	--******************** PYLONS ************************
	
	Pylons = { 
	
	pylon(1, 0, 0, 0, 0,
	{
	FiX = 0,
	FiY = 0,
	FiZ = 0,
	use_full_connector_position=true,
	},
	{
	
	--/N/ 309, 310, 311, 312, 313, 314, 315, 316 brave, dodate na nosace
	
	--/N/ ROCKETS
	{ CLSID = "{UB-16_S5M}",connector = "PYLON_L_OUT_3",arg = 309,arg_value = 0.5, required = {{station = 5, loadout = {"{UB-16_S5M}"}}}}, -- UB-16 S-5M
--test --{ CLSID = "{UB-32_S5M}",connector = "PYLON_L_OUT_3",arg = 309,arg_value = 0.5},
	--{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5}, -- S-24B ED
	{ CLSID = "{S-24B}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5, required = {{station = 5, loadout = {"{S-24B}"}}}}, -- S-24B ED
	{ CLSID = "{S-24A}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5, required = {{station = 5, loadout = {"{S-24A}"}}}}, -- S-24A
	
	--/N/ BOMBS
	{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}",connector = "PYLON_L_OUT_2", required = {{station = 5, loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}}}, -- FAB-100
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",connector = "PYLON_L_OUT_1", required = {{station = 5, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}}}, -- FAB-250
	{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",connector = "PYLON_L_OUT_2", required = {{station = 5, loadout = {"{4203753F-8198-4E85-9924-6F8FF679F9FF}"}}}}, -- RBK-250 PTAB
	{ CLSID = "{FAB-250-M54-TU}",connector = "PYLON_L_OUT_1", required = {{station = 5, loadout = {"{FAB-250-M54-TU}"}}}},
	{ CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}",connector = "PYLON_L_OUT", required = {{station = 5, loadout = {"{0511E528-EA28-4caf-A212-00D1408DF10A}"}}}},--SAB-100	
	
	--/N/ MISSILES
	{ CLSID = "{R-13M}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5},
	{ CLSID = "{R-13M1}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5},
	{ CLSID = "{R-3R}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5},
	{ CLSID = "{R-3S}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5},
	{ CLSID = "{RS-2US}",connector = "PYLON_L_OUT"},
	--{ CLSID = "{R-55}",connector = "PYLON_L_OUT"},
{ CLSID = "{R-60}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5},
	{ CLSID = "{R-60M}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5}, --R-60M {682A481F-0CB5-4693-A382-D00DD4A156D7}
	--{ CLSID = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5}, --2xR-60M - /N/ bad launcher 3D model
{ CLSID = "{R-60M 2L}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5,
forbidden = {{station = 2, loadout = {"{R-60M 2L}"}}, {station = 2, loadout = {"{R-60 2L}"}}, {station = 4, loadout = {"{R-60M 2R}"}}, {station = 4, loadout = {"{R-60 2R}"}}}, required = {{station = 5, loadout = {"{R-60M 2R}"}}}},
{ CLSID = "{R-60 2L}",connector = "PYLON_L_OUT",arg = 309,arg_value = 0.5,
forbidden = {{station = 2, loadout = {"{R-60 2L}"}}, {station = 2, loadout = {"{R-60M 2L}"}}, {station = 4, loadout = {"{R-60 2R}"}}, {station = 4, loadout = {"{R-60M 2R}"}}}, required = {{station = 5, loadout = {"{R-60 2R}"}}}},
	
	--/N/ FUEL TANKS
	{ CLSID = "{PTB_490_MIG21}",connector = "PYLON_L_OUT_FUEL",arg = 320,arg_value = 0.5, required = {{station = 5, loadout = {"{PTB_490_MIG21}"}}}}, -- /M 20200509 Added connector for fuel tank as old one causes 3d shape to shrink.
	
	}
	),
	
	pylon(2, 0, 0, 0, 0, 
	{
	FiZ = 0,
	use_full_connector_position=true,
	},
	{
	--/N/ ROCKETS
	{ CLSID = "{UB-16_S5M}",connector = "PYLON_L_IN_3",arg = 310,arg_value = 0.5, 	arg = 318,arg_value = 0.5, required = {{station = 4, loadout = {"{UB-16_S5M}"}}}},
	{ CLSID = "{UB-32_S5M}",connector = "PYLON_L_IN_3",arg = 310,arg_value = 0.5, 	arg = 318,arg_value = 0.5, required = {{station = 4, loadout = {"{UB-32_S5M}"}}}},
	--{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5}, -- S-24B ED
	{ CLSID = "{S-24B}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5, required = {{station = 4, loadout = {"{S-24B}"}}}}, -- S-24B ED
	{ CLSID = "{S-24A}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5, required = {{station = 4, loadout = {"{S-24A}"}}}}, -- S-24A
	
	--/N/ BOMBS
	--{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5}, -- MER 4xFAB-100
	{ CLSID = "{FAB-100-4}",connector = "PYLON_L_IN",arg = 318,arg_value = 0.5, required = {{station = 4, loadout = {"{FAB-100-4}"}}}}, -- MER 4xFAB-100 arg = 318 small doors
	{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}",connector = "PYLON_L_IN_2", required = {{station = 4, loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}}}, -- FAB-100
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",connector = "PYLON_L_IN_1", required = {{station = 4, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}}}, -- FAB-250
	{ CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",connector = "PYLON_L_IN_1",arg = 314,arg_value = 0.5, required = {{station = 4, loadout = {"{37DCC01E-9E02-432F-B61D-10C166CA2798}"}}}}, -- FAB-500 M62
	{ CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}",connector = "PYLON_L_IN_2",arg = 314,arg_value = 0.5, required = {{station = 4, loadout = {"{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"}}}}, -- BetAB-500
	{ CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}",connector = "PYLON_L_IN_2",arg = 314,arg_value = 0.5, required = {{station = 4, loadout = {"{BD289E34-DF84-4C5E-9220-4B14C346E79D}"}}}}, -- BetAB-500ShP
	{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",connector = "PYLON_L_IN_2", required = {{station = 4, loadout = {"{4203753F-8198-4E85-9924-6F8FF679F9FF}"}}}}, -- RBK-250 PTAB
	{ CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}",connector = "PYLON_L_IN_2",arg = 314,arg_value = 0.5, required = {{station = 4, loadout = {"{D5435F26-F120-4FA3-9867-34ACE562EF1B}"}}}}, -- RBK-500 PTAB-10-5
	{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",connector = "PYLON_L_IN_2",arg = 314,arg_value = 0.5, required = {{station = 4, loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}}}, -- BL.755	
	{ CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}",connector = "PYLON_L_IN_2", required = {{station = 4, loadout = {"{0511E528-EA28-4caf-A212-00D1408DF10A}"}}}},--SAB-100	
	
	--/N/ MISSILES
	{ CLSID = "{Kh-66_Grom}",connector = "PYLON_L_IN", required = {{station = 4, loadout = {"{Kh-66_Grom}"}}}}, --/N/ Kh-23M AKA 66 Grom
	{ CLSID = "{R-13M}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5},
	{ CLSID = "{R-13M1}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5},
	{ CLSID = "{R-3R}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5},
	{ CLSID = "{R-3S}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5},
	{ CLSID = "{RS-2US}",connector = "PYLON_L_IN"},
	{ CLSID = "{R-55}",connector = "PYLON_L_IN"},
{ CLSID = "{R-60}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5},
	--{ CLSID = "{682A481F-0CB5-4693-A382-D00DD4A156D7}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5}, --R-60M {682A481F-0CB5-4693-A382-D00DD4A156D7}
	{ CLSID = "{R-60M}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5}, --R-60M {682A481F-0CB5-4693-A382-D00DD4A156D7}
	--{ CLSID = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5}, --2xR-60M - /N/ bad launcher 3D model
{ CLSID = "{R-60M 2L}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5,
forbidden = {{station = 1, loadout = {"{R-60M 2L}"}}, {station = 1, loadout = {"{R-60 2L}"}}, {station = 5, loadout = {"{R-60M 2R}"}}, {station = 5, loadout = {"{R-60 2R}"}}}, required = {{station = 4, loadout = {"{R-60M 2R}"}}}},
{ CLSID = "{R-60 2L}",connector = "PYLON_L_IN",arg = 310,arg_value = 0.5,
forbidden = {{station = 1, loadout = {"{R-60 2L}"}}, {station = 1, loadout = {"{R-60M 2L}"}}, {station = 5, loadout = {"{R-60 2R}"}}, {station = 5, loadout = {"{R-60M 2R}"}}}, required = {{station = 4, loadout = {"{R-60 2R}"}}}},

	--/N/ gunpod
	{ CLSID = "{UPK-23-250 MiG-21}", --[["{05544F1A-C39C-466b-BC37-5BD1D52E57BB}",]] connector = "PYLON_L_IN_1",arg = 310,arg_value = 0.5, required = {{station = 4, loadout = {"{UPK-23-250 MiG-21}"}}}}, -- UPK-23-250
	
	}
	),
	
	pylon(3, 0, 0, 0, 0, 
	{
	FiZ = -1.2,
	use_full_connector_position=true,
	},
	{
	--[[
	--/N/ BOMBS
	{ CLSID = "{RN-24}",connector = "PYLON_C_2",arg = 308,arg_value = 0.7}, --"nuclear" 10KT
	{ CLSID = "{RN-28}",connector = "PYLON_C_2",arg = 308,arg_value = 0.7}, --"nuclear" 1KT
	--]]

	--/N/ BOMBS
	{ CLSID = "{RN-24}",connector = "PYLON_C_2",arg = 308,arg_value = 1,
		forbidden = {
		--[[
			{station = 2, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			{station = 4, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			]]
			{station = 2, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250
			{station = 4, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250			
			}
	}, --"nuclear" 10KT
	{ CLSID = "{RN-28}",connector = "PYLON_C_2",arg = 308,arg_value = 1,
		forbidden = {
		--[[
			{station = 2, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			{station = 4, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			]]
			{station = 2, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250
			{station = 4, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250			
			}
	}, --"nuclear" 1KT
	
	--/N/ JAMMER POD
	{ CLSID = "{SPS-141-100}",connector = "PYLON_C",arg = 308,arg_value = 0.5,
		forbidden = {
		--[[
			{station = 2, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			{station = 4, loadout = {"{05544F1A-C39C-466b-BC37-5BD1D52E57BB}"}}, -- UPK-23-250
			]]
			{station = 2, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250
			{station = 4, loadout = {"{UPK-23-250 MiG-21}"}}, -- UPK-23-250			
			
			{station = 6, loadout = {"{ASO-2}"}}, -- ASO
			}
	},
	
	--/N/ FUEL TANKS
	{ CLSID = "{PTB_490C_MIG21}",connector = "PYLON_C_FUEL_490",arg = 308,arg_value = 0.5}, -- /M 20200509 Added connector for fuel tank as old one causes 3d shape to shrink.
	{ CLSID = "{PTB_800_MIG21}",connector = "PYLON_C_FUEL_800",arg = 308,arg_value = 0.5,   -- /M 20200509 Added connector for fuel tank as old one causes 3d shape to shrink.
		--forbidden = {
		--	{station = 1, loadout = {"{PTB_490_MIG21}"}},
		--	{station = 5, loadout = {"{PTB_490_MIG21}"}},
		--	}
	},
	
	}
	),
	
	pylon(4, 0, 0, 0, 0,
	{
	FiZ = 0,
	use_full_connector_position=true,
	},
	{
	--/N/ ROCKETS
	{ CLSID = "{UB-16_S5M}",connector = "PYLON_R_IN_3",arg = 311,arg_value = 0.5, 	arg = 319,arg_value = 0.5, required = {{station = 2, loadout = {"{UB-16_S5M}"}}}},
	{ CLSID = "{UB-32_S5M}",connector = "PYLON_R_IN_3",arg = 311,arg_value = 0.5, 	arg = 319,arg_value = 0.5, required = {{station = 2, loadout = {"{UB-32_S5M}"}}}},
	--{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5}, -- S-24B ED
	{ CLSID = "{S-24B}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5, required = {{station = 2, loadout = {"{S-24B}"}}}}, -- S-24B ED
	{ CLSID = "{S-24A}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5, required = {{station = 2, loadout = {"{S-24A}"}}}}, -- S-24A
	
	--/N/ BOMBS
	--{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5}, -- MER 4xFAB-100
	{ CLSID = "{FAB-100-4}",connector = "PYLON_R_IN",arg = 319,arg_value = 0.5, required = {{station = 2, loadout = {"{FAB-100-4}"}}}}, -- MER 4xFAB-100 arg = 319 small doors
	{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}",connector = "PYLON_R_IN_2", required = {{station = 2, loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}}}, -- FAB-100
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",connector = "PYLON_R_IN_1", required = {{station = 2, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}}}, -- FAB-250
	{ CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",connector = "PYLON_R_IN_1",arg = 315,arg_value = 0.5, required = {{station = 2, loadout = {"{37DCC01E-9E02-432F-B61D-10C166CA2798}"}}}}, -- FAB-500
	{ CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}",connector = "PYLON_R_IN_2",arg = 315,arg_value = 0.5, required = {{station = 2, loadout = {"{35B698AC-9FEF-4EC4-AD29-484A0085F62B}"}}}}, -- BetAB-500
	{ CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}",connector = "PYLON_R_IN_2",arg = 315,arg_value = 0.5, required = {{station = 2, loadout = {"{BD289E34-DF84-4C5E-9220-4B14C346E79D}"}}}}, -- BetAB-500ShP
	{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",connector = "PYLON_R_IN_2", required = {{station = 2, loadout = {"{4203753F-8198-4E85-9924-6F8FF679F9FF}"}}}}, -- RBK-250
	{ CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}",connector = "PYLON_R_IN_2",arg = 315,arg_value = 0.5, required = {{station = 2, loadout = {"{D5435F26-F120-4FA3-9867-34ACE562EF1B}"}}}}, -- RBK-500AO
	{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",connector = "PYLON_R_IN_2",arg = 315,arg_value = 0.5, required = {{station = 2, loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}}}, -- BL.755
	{ CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}",connector = "PYLON_R_IN_2", required = {{station = 2, loadout = {"{0511E528-EA28-4caf-A212-00D1408DF10A}"}}}},--SAB-100
	
	--/N/ MISSILES
	{ CLSID = "{Kh-66_Grom}",connector = "PYLON_R_IN", required = {{station = 2, loadout = {"{Kh-66_Grom}"}}}}, --/N/ Kh-23M AKA 66 Grom
	{ CLSID = "{R-13M}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5},
	{ CLSID = "{R-13M1}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5},
	{ CLSID = "{R-3R}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5},
	{ CLSID = "{R-3S}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5},
	{ CLSID = "{RS-2US}",connector = "PYLON_R_IN"},
	{ CLSID = "{R-55}",connector = "PYLON_R_IN"},
{ CLSID = "{R-60}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5},
	{ CLSID = "{R-60M}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5}, --R-60M {682A481F-0CB5-4693-A382-D00DD4A156D7}
	--{ CLSID = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5}, --2xR-60M - /N/ bad launcher 3D model
{ CLSID = "{R-60M 2R}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5,
forbidden = {{station = 5, loadout = {"{R-60M 2R}"}}, {station = 5, loadout = {"{R-60 2R}"}}, {station = 1, loadout = {"{R-60M 2L}"}}, {station = 1, loadout = {"{R-60 2L}"}}}, required = {{station = 2, loadout = {"{R-60M 2L}"}}}},
{ CLSID = "{R-60 2R}",connector = "PYLON_R_IN",arg = 311,arg_value = 0.5,
forbidden = {{station = 5, loadout = {"{R-60 2R}"}}, {station = 5, loadout = {"{R-60M 2R}"}}, {station = 1, loadout = {"{R-60 2L}"}}, {station = 1, loadout = {"{R-60M 2L}"}}}, required = {{station = 2, loadout = {"{R-60 2L}"}}}},
	
	--/N/ gunpods
	{ CLSID = "{UPK-23-250 MiG-21}", --[["{05544F1A-C39C-466b-BC37-5BD1D52E57BB}",]] connector = "PYLON_R_IN_1",arg = 311,arg_value = 0.5, required = {{station = 2, loadout = {"{UPK-23-250 MiG-21}"}}}}, -- UPK-23-250	
	
	}
	),
	
	pylon(5, 0, 0, 0, 0, 
	{
	FiZ = 0,
	use_full_connector_position=true,
	},
	{
	--/N/ ROCKETS
	{ CLSID = "{UB-16_S5M}",connector = "PYLON_R_OUT_3",arg = 312,arg_value = 0.5, required = {{station = 1, loadout = {"{UB-16_S5M}"}}}}, -- UB-16 S-5M
--test --{ CLSID = "{UB-32_S5M}",connector = "PYLON_R_OUT_3",arg = 312,arg_value = 0.5},
	--{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5}, -- S-24B ED
	{ CLSID = "{S-24B}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5, required = {{station = 1, loadout = {"{S-24B}"}}}}, -- S-24B ED
	{ CLSID = "{S-24A}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5, required = {{station = 1, loadout = {"{S-24A}"}}}}, -- S-24A
	
	--/N/ BOMBS
	{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}",connector = "PYLON_R_OUT_2", required = {{station = 1, loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}}},-- FAB-100
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",connector = "PYLON_R_OUT_1", required = {{station = 1, loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}}},-- FAB-250
	{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}",connector = "PYLON_R_OUT_2", required = {{station = 1, loadout = {"{4203753F-8198-4E85-9924-6F8FF679F9FF}"}}}},-- RBK-250 PTAB
	--{ CLSID = "{40A24F07-CD7D-4F83-89A2-39B2258B62C6}",connector = "PYLON_R_OUT_2"},-- PB-250 /not appearing, not in ED repo/
	{ CLSID = "{FAB-250-M54-TU}",connector = "PYLON_R_OUT_1", required = {{station = 1, loadout = {"{FAB-250-M54-TU}"}}}},
	{ CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}",connector = "PYLON_R_OUT", required = {{station = 1, loadout = {"{0511E528-EA28-4caf-A212-00D1408DF10A}"}}}},--SAB-100
	
	--/N/ MISSILES
	{ CLSID = "{R-13M}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5},
	{ CLSID = "{R-13M1}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5},	
	{ CLSID = "{R-3R}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5},
	{ CLSID = "{R-3S}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5},
	{ CLSID = "{RS-2US}",connector = "PYLON_R_OUT"},
	--{ CLSID = "{R-55}",connector = "PYLON_R_OUT"},
{ CLSID = "{R-60}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5},
	{ CLSID = "{R-60M}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5}, --R-60M {682A481F-0CB5-4693-A382-D00DD4A156D7}
	--{ CLSID = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5}, --2xR-60M - /N/ bad launcher 3D model
{ CLSID = "{R-60M 2R}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5,
forbidden = {{station = 4, loadout = {"{R-60M 2R}"}}, {station = 4, loadout = {"{R-60 2R}"}}, {station = 2, loadout = {"{R-60M 2L}"}}, {station = 2, loadout = {"{R-60 2L}"}}}, required = {{station = 1, loadout = {"{R-60M 2L}"}}}},
{ CLSID = "{R-60 2R}",connector = "PYLON_R_OUT",arg = 312,arg_value = 0.5,
forbidden = {{station = 4, loadout = {"{R-60 2R}"}}, {station = 4, loadout = {"{R-60M 2R}"}}, {station = 2, loadout = {"{R-60 2L}"}}, {station = 2, loadout = {"{R-60M 2L}"}}}, required = {{station = 1, loadout = {"{R-60 2L}"}}}},
	
	--/N/ FUEL TANKS
	{ CLSID = "{PTB_490_MIG21}",connector = "PYLON_R_OUT_FUEL",arg = 321,arg_value = 0.5, required = {{station = 1, loadout = {"{PTB_490_MIG21}"}}}}, -- /M 20200509 Added connector for fuel tank as old one causes 3d shape to shrink.

	}
	),
	
	pylon(6, 0, 0, 0, 0,
	{
	FiZ = 0,
	use_full_connector_position=true,
	},
	{
	{ CLSID = "{ASO-2}",connector = "PYLON_ASO"},
	{ CLSID = "{SPRD}", connector = "PYLON_SPRD", arg = 617,arg_value = 0.5},
	}
	),
	
	pylon(7, 0, 0, 0, 0,
	{
	use_full_connector_position=false,
	},
	{
	{ CLSID = "{MIG21_SMOKE_WHITE}", connector = "SMOKE_PYLON", arg = 400, arg_value = 1.0 },
	}	
	
	),
	
	},
	
	--****************************************************
	
	--******************* TASKS **************************
	--aircraft_task(Nothing),			-- 15 --/N/ NOTE: if this is ENABLED, it will cause a bug of "MiG-21 duplicates in Mission Editor"
	
	Tasks = {
		aircraft_task(Intercept),
		aircraft_task(CAP),
		aircraft_task(Escort),
		aircraft_task(CAS),
		aircraft_task(GroundAttack),
	},	
	DefaultTask = aircraft_task(CAP),

	--****************************************************
	
	--******************** SFM, bots ***************************

	SFM_Data =
	{
		aerodynamics = 
		{	
			Cy0	=	0.10,
			Mzalfa	=	4.2,
			Mzalfadt	=	0.8,
			kjx	=	2.7,
			kjz	=	0.01,
			Czbe	=	-0.014,
			cx_gear	=	0.035,
			cx_flap	=	0.04,
			cy_flap	=	0.30,
			cx_brk	=	0.07,	
			
			table_data =
			{
				-- Cy  = (CyAlpha_ * 57.3) * aoa;-> aoa in RAD
				-- Cx  = Cx0 + B2_ * Cy * Cy + B4_ * Cy * Cy * Cy * Cy;	
				--		M		Cx0			Cya			B2			B4	 		Omxmax	Aldop	Cymax	
				-- /N/ max napadni ugao je korigovan u skladu sa (geometr_AoA * 1.95) + 1.5, da bi AoA AI odgovarao ljudskom modulu.
				-- Takodje je korigovan i Cy0 da omoguci AoA~0 pri Vi~800
				-- U skladu sa tim korigovan je i Cya
				
				[1] = {	0.0	,	0.0250	,	0.0959	,	0.160	,	0.250	,	0.300	,	16.15	,	1.200	},
				[2] = {	0.1	,	0.0255	,	0.0937	,	0.150	,	0.240	,	0.900	,	16.15	,	1.190	},
				[3] = {	0.2	,	0.0260	,	0.0903	,	0.140	,	0.230	,	1.500	,	16.15	,	1.180	},
				[4] = {	0.3	,	0.0265	,	0.0883	,	0.135	,	0.220	,	2.000	,	16.15	,	1.170	},
				[5] = {	0.4	,	0.0270	,	0.0863	,	0.130	,	0.210	,	2.500	,	16.15	,	1.160	},
				[6] = {	0.5	,	0.0278	,	0.0820	,	0.125	,	0.205	,	3.000	,	16.15	,	1.120	},
				[7] = {	0.6	,	0.0285	,	0.0778	,	0.120	,	0.200	,	3.500	,	16.15	,	1.080	},
				[8] = {	0.7	,	0.0303	,	0.0731	,	0.115	,	0.195	,	3.425	,	16.15	,	1.045	},
				[9] = {	0.8	,	0.0320	,	0.0695	,	0.110	,	0.190	,	3.350	,	16.15	,	1.010	},
				[10] = {	0.9	,	0.0364	,	0.0645	,	0.113	,	0.192	,	3.275	,	16.15	,	0.975	},
				[11] = {	1.0	,	0.0500	,	0.0642	,	0.120	,	0.200	,	3.200	,	16.15	,	0.940	},
				[12] = {	1.1	,	0.0535	,	0.0525	,	0.125	,	0.205	,	2.950	,	14.87	,	0.725	},
				[13] = {	1.2	,	0.0530	,	0.0402	,	0.130	,	0.210	,	2.700	,	13.59	,	0.510	},
				[14] = {	1.3	,	0.0482	,	0.0338	,	0.137	,	0.213	,	2.600	,	13.59	,	0.440	},
				[15] = {	1.4	,	0.0410	,	0.0272	,	0.143	,	0.215	,	2.500	,	13.59	,	0.370	},
				[16] = {	1.5	,	0.0390	,	0.0266	,	0.152	,	0.218	,	2.400	,	13.59	,	0.360	},
				[17] = {	1.6	,	0.0370	,	0.0259	,	0.160	,	0.220	,	2.300	,	13.59	,	0.350	},
				[18] = {	1.7	,	0.0355	,	0.0259	,	0.170	,	0.223	,	2.200	,	13.59	,	0.350	},
				[19] = {	1.8	,	0.0340	,	0.0259	,	0.180	,	0.225	,	2.100	,	13.59	,	0.350	},
				[20] = {	1.9	,	0.0330	,	0.0259	,	0.190	,	0.228	,	2.000	,	13.59	,	0.350	},
				[21] = {	2.0	,	0.0320	,	0.0259	,	0.200	,	0.230	,	1.900	,	13.59	,	0.350	},
				[22] = {	2.1	,	0.0320	,	0.0259	,	0.210	,	0.235	,	1.800	,	13.59	,	0.350	},
				[23] = {	2.2	,	0.0320	,	0.0259	,	0.220	,	0.240	,	1.700	,	13.59	,	0.350	},
				[24] = {	2.3	,	0.0320	,	0.0259	,	0.260	,	0.270	,	1.600	,	13.59	,	0.350	},
				[25] = {	2.4	,	0.0320	,	0.0259	,	0.300	,	0.300	,	1.500	,	13.59	,	0.350	},

			},
		},
		engine = 
		{
			Nmg	=	62, 
			MinRUD	=	0,--0.1
			MaxRUD	=	1, 
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			typeng	=	1,
			hMaxEng	=	19.5,--22, 
			dcx_eng	=	0.0114,
			cemax	=	1.24,--1.2,
			cefor	=	2.56,--2.5,
			dpdh_m	=	3500,--4100 sto manje - jaci motor sa visinom, nema znacajnog efekta na malim visinama
			dpdh_f	=	6330,

			table_data =
			{
				[1]={	0.0	,	41000	,	71000	},
				[2]={	0.1	,	40500	,	72355	},
				[3]={	0.2	,	40000	,	73710	},
				[4]={	0.3	,	40500	,	75065	},
				[5]={	0.4	,	41000	,	76420	},
				[6]={	0.5	,	41500	,	78775	},
				[7]={	0.6	,	42000	,	81130	},
				[8]={	0.7	,	44000	,	84840	},--89840
				[9]={	0.8	,	48000	,	89550	},--94550
				[10]={	0.9	,	60000	,	94260	},--99260
				[11]={	1.0	,	40000	,	104000	},--
				[12]={	1.1	,	37500	,	105355	},--106355
				[13]={	1.2	,	35000	,	106710	},--108710
				[14]={	1.3	,	32500	,	109065	},--111065
				[15]={	1.4	,	30000	,	112420	},
				[16]={	1.5	,	27500	,	115775	},--115775
				[17]={	1.6	,	25000	,	118130	},
				[18]={	1.7	,	22500	,	120652	},
				[19]={	1.8	,	20000	,	122840	},
				[20]={	1.9	,	17500	,	125695	},
				[21]={	2.0	,	15000	,	128550	},
				[22]={	2.1	,	12500	,	130405	},
				[23]={	2.2	,	10000	,	132260	},
				[24]={	2.3	,	7500	,	127260	},
				[25]={	2.4	,	5000	,	122260	},
			},
		},
	},	

	
	--****************************************************
	
	--***************** DAMAGES **************************
	-- /M checked and fixed the collision and external model arguments to 
	--    be in line with ED's latest damage table list and argument number list.

Damage = verbose_to_dmg_properties(
	{
		-- 10, 40, 69, 100 ( .1, .4, .69, 1)  Small / Medium / Holes / Large-Holes (Missing)
	
		-- Misc
		["PWD"]			         = {critical_damage = 5, args = {299}, droppable = false}, -- HF Antenna
		["RSBN_1"]               = {critical_damage = 8, args = {301}, droppable = false}, -- RSBN Antenna Nose
		["TAIL_TOP"]             = {critical_damage = 5, args = {144}, droppable = false}, -- Pitot Tube Long
		["FUEL_TANK_F"]        	 = {critical_damage = 5, args = {296}, droppable = false}, -- Avionics	
		["ENGINE"]               = {critical_damage = 8, args = {167}, droppable = false},
		["GUN"]					 = {critical_damage = 7, args = {249}, droppable = false},
		
		 -- Radome
		["NOSE_CENTER"] 		 = {critical_damage = 5, args = {146}, droppable = true},
		
		 -- Fuselage Nose
		["BLADE_1_IN"]			 = {critical_damage = 10, args = {145, 147}, droppable = false},	 
		["NOSE_BOTTOM"]			 = {critical_damage = 10, args = {148, 301}, droppable = false}, -- , dep_cells = {"FRONT_GEAR_BOX", "WHEEL_F"}},
		["NOSE_LEFT_SIDE"]		 = {critical_damage = 10, args =      {150}, droppable = false},
		["NOSE_RIGHT_SIDE"]		 = {critical_damage = 10, args =      {149}, droppable = false},

		 -- Fuselage Surrounding Cockpit
		["COCKPIT"]		     	 = {critical_damage =  6, args =      {300}, droppable = false}, -- Canopy
		["ARMOR_PLATE_LEFT"]     = {critical_damage =  5, args =      {116}, droppable = false}, -- Canopy Glass
		["HOOK"] 		         = {critical_damage =  3, args =      {117}, droppable = false}, -- Canpy Mirror
			
		["BLADE_1_CENTER"]		 = {critical_damage = 10, args =      {151}, droppable = false}, -- Windscreen 
		["ARMOR_PLATE_RIGHT"]    = {critical_damage =  5, args =      {115}, droppable = false}, -- Windscreen Glass
		["CABIN_LEFT_SIDE"]		 = {critical_damage = 10, args =      {154}, droppable = false},
		["CABIN_RIGHT_SIDE"]	 = {critical_damage = 10, args = {145, 153}, droppable = false},
		["CABIN_BOTTOM"]		 = {critical_damage = 10, args =      {152}, droppable = false},
		
		-- Fuselage Middle
		["FUSELAGE_BOTTOM"]		 = {critical_damage = 10, args = {306}, droppable = false}, -- , deps_cells = {"AIR_BRAKE_L", "AIR_BRAKE_R", "GUN"}}, -- Add AIR_BRAKE_C later
		["FUSELAGE_LEFT_SIDE"]	 = {critical_damage = 10, args = {304}, droppable = false}, -- , deps_cells = {"AIR_BRAKE_L", "FUEL_TANK_F"}},
		["FUSELAGE_RIGHT_SIDE"]	 = {critical_damage = 10, args = {305}, droppable = false}, -- , deps_cells = {"AIR_BRAKE_R", "FUEL_TANK_F"}},
		
		-- Fuselage Rear
		["TAIL_BOTTOM"]		     = {critical_damage = 10, args = {156}, droppable = false},
		["TAIL_LEFT_SIDE"]       = {critical_damage = 10, args = {158}, droppable = false},
		["TAIL_RIGHT_SIDE"]	     = {critical_damage = 10, args = {157}, droppable = false},	
		
		-- AB Nozzle
		["MTG_L"]		         = {critical_damage = 8, args = {166}, droppable = false},
		["MTG_R"]	             = {critical_damage = 8, args = {160}, droppable = false},
		
		-- Dragchutes, Doors
		["MTG_L_BOTTOM"]		 = {critical_damage = 3, args = {169}, droppable = false}, -- Human Dragchute
		["MTG_R_BOTTOM"]	     = {critical_damage = 3, args = {169}, droppable = false}, -- AI Dragchute

		["STABILIZER_L_OUT"]     = {critical_damage = 3, args = {168}, droppable = false}, -- Human Door L
		["STABILIZER_R_OUT"]     = {critical_damage = 3, args = {162}, droppable = false}, -- Human Door R	
		
		["STABILIZER_L_IN"]      = {critical_damage = 3, args = {168}, droppable = false}, -- AI Door L
		["STABILIZER_R_IN"]      = {critical_damage = 3, args = {162}, droppable = false}, -- AI Door R
		
		-- Vertical Stabilizer
		["BLADE_2_CENTER"]		 = {critical_damage =  3, args = {289}}, -- ATC Transponder
			
		["FIN_L_TOP"]			 = {critical_damage =  7, args = {244}, deps_cells = {"BLADE_2_CENTER"}},
		["FIN_L_CENTER"]		 = {critical_damage = 10, args = {245}, deps_cells = {"BLADE_2_CENTER", "FIN_L_TOP"}},
		["FIN_L_BOTTOM"]		 = {critical_damage = 14, args = {246}, deps_cells = {"BLADE_2_CENTER", "FIN_L_TOP", "FIN_L_CENTER"}, droppable = false},
		
		-- Rudder
		["BLADE_1_OUT"]		   	 = {critical_damage =  4, args = {290}},                                                            -- Top
		["RUDDER"]		     	 = {critical_damage =  8, args = {291}, deps_cells = {"BLADE_1_OUT"}},                              -- Center
		["RUDDER_R"]			 = {critical_damage = 10, args = {292}, deps_cells = {"BLADE_1_OUT", "RUDDER"}, droppable = false}, -- Bottom
		
		-- Horizontal Stabilizers
		["ELEVATOR_L_OUT"]	     = {critical_damage =  7, args = {235}, dep_cells = {"ELEVATOR_L_IN"}},
		["ELEVATOR_L_IN"]		 = {critical_damage = 14, args = {236}},
		
		["ELEVATOR_R_OUT"]	     = {critical_damage =  7, args = {233}, dep_cells = {"ELEVATOR_R_IN"}},
		["ELEVATOR_R_IN"]        = {critical_damage = 14, args = {234}},

		-- Fuselage Rear, Vert/Horz Stabs, Rudder, HF Antenna, Engine, Nozzle........ as whole.
		--["TAIL"]				 = {critical_damage = 10, args = {81}}, 
		
		-- Air Brakes
		["AIR_BRAKE_L"] 		 = {critical_damage = 5, args = {185}, droppable = false},
		["AIR_BRAKE_R"] 		 = {critical_damage = 5, args = {183}, droppable = false},
		["BLADE_2_IN"] 		     = {critical_damage = 5, args = {187}, droppable = false}, -- Center
		
		-- Wings, Ailerons, Flaps
		["WING_L_IN"] 			 = {critical_damage = 14, args = {225}, deps_cells = {"WING_L_CENTER", "WING_L_OUT", "AILERON_L", "FLAP_L", "PYLON1", "PYLON2", "LEFT_GEAR_BOX", "WHEEL_L"}},
		["WING_L_CENTER"]		 = {critical_damage =  8, args = {224}, deps_cells = {"WING_L_OUT", "AILERON_L", "FLAP_L", "PYLON1", "PYLON2"}},
		["WING_L_OUT"]			 = {critical_damage =  5, args = {223}, deps_cells = {"AILERON_L"}},
		["FLAP_L"]				 = {critical_damage =  3, args = {227}},
		["AILERON_L"]			 = {critical_damage =  3, args = {226}},
			
		["WING_R_IN"]			 = {critical_damage = 14, args = {215}, deps_cells = {"WING_R_CENTER", "WING_R_OUT", "AILERON_R", "FLAP_R", "PYLON3", "PYLON4", "RIGHT_GEAR_BOX", "WHEEL_R"}},
		["WING_R_CENTER"]   	 = {critical_damage =  8, args = {214}, deps_cells = {"WING_R_OUT", "AILERON_R", "FLAP_R", "PYLON3", "PYLON4"}},
		["WING_R_OUT"]      	 = {critical_damage =  3, args = {213}, deps_cells = {"AILERON_R"}},
		["FLAP_R"]          	 = {critical_damage =  3, args = {217}},
		["AILERON_R"]        	 = {critical_damage =  3, args = {216}},
		
		-- Landing Gear, Gear Bay, Gear Doors
		
		["CREW_3"]          	 = {critical_damage = 5, args = {302}}, -- Door F Left
		["CREW_4"]          	 = {critical_damage = 5, args = {303}}, -- Door F Right	
		["FRONT_GEAR_BOX"]		 = {critical_damage = 4, args = {264}},	
		["BLADE_5_IN"]	         = {critical_damage = 5, args = {253}}, -- Front Strut
		["BLADE_5_CENTER"]       = {critical_damage = 3, args = {254}}, -- Front Piston
		["BLADE_5_OUT"]          = {critical_damage = 3, args = {254}}, -- Front Fork
		["WHEEL_F"]				 = {critical_damage = 3, args = {134}},
		

		["WING_L_PART_OUT"]      = {critical_damage = 4, args = {260}}, -- Door L Big
		["WING_L_PART_CENTER"]   = {critical_damage = 4, args = {261}}, -- Door L Small
		["LEFT_GEAR_BOX"]		 = {critical_damage = 4, args = {259}},
		["BLADE_3_IN"]           = {critical_damage = 5, args = {260}}, -- Left Strut
		["BLADE_3_CENTER"]       = {critical_damage = 4, args = {261}}, -- Left Piston
		["WHEEL_L"]				 = {critical_damage = 6, args = {136}},
		
		["BLADE_6_IN"]           = {critical_damage = 3, args = {267}}, -- Fuselage L Gear Bay
		["WING_L_PART_IN"]       = {critical_damage = 5, args = {268}}, -- Fuselage L Door
		
		
		["WING_R_PART_OUT"]      = {critical_damage = 4, args = {256}}, -- Door R Big
		["WING_R_PART_CENTER"]   = {critical_damage = 4, args = {257}}, -- Door R Small	
		["RIGHT_GEAR_BOX"]		 = {critical_damage = 4, args = {255}},
		["BLADE_4_IN"]           = {critical_damage = 5, args = {256}}, -- Right Strut
		["BLADE_4_CENTER"]       = {critical_damage = 4, args = {257}}, -- Right Piston
		["WHEEL_R"]				 = {critical_damage = 6, args = {135}},
		
		["BLADE_6_OUT"]          = {critical_damage = 3, args = {265}}, -- Fuselage R Gear Bay
		["WING_R_PART_IN"]       = {critical_damage = 5, args = {266}}, -- Fuselage R Door

		-- Pylons
		["PYLON1"]          	 = {critical_damage = 5, args = {228}}, -- Left Outer
		["PYLON2"]          	 = {critical_damage = 5, args = {229}}, -- Left Inner
		["PYLON3"]          	 = {critical_damage = 5, args = {218}}, -- Right Inner
		["PYLON4"]          	 = {critical_damage = 5, args = {219}}, -- Right Outer
		["CREW_1"]          	 = {critical_damage = 5, args = {170}}, -- Center Fuel
		["CREW_2"]          	 = {critical_damage = 5, args = {170}}, -- Center Nuke
		
		--Fuel Tanks
		["FUEL_TANK_B"]        	 = {critical_damage = 5, args = {298}}, -- Dorsal

		-- These are non visual and can be used to trigger leaking fuel effects	and/or fuel loss
		["FUEL_TANK_LEFT_SIDE_F"]  = {critical_damage = 5}, -- Left Wing Internal Front
		["FUEL_TANK_LEFT_SIDE_R"]  = {critical_damage = 5}, -- Left Wing Internal Rear
		
		["FUEL_TANK_RIGHT_SIDE_F"] = {critical_damage = 5}, -- Right Wing Internal Front
		["FUEL_TANK_RIGHT_SIDE_R"] = {critical_damage = 5}, -- Right Wing Internal Rear
	
	}
),

DamageParts = 
	{ 
		[1000 +  0] = "MiG-21Bis_Damage_Nose-Cone",
		
		[1000 + 23] = "MiG-21Bis_Damage_Wing-L-Outer",		
		[1000 + 24] = "MiG-21Bis_Damage_Wing-R-Outer",	
		
		[1000 + 25] = "MiG-21Bis_Damage_Aileron-L", 
		[1000 + 26] = "MiG-21Bis_Damage_Aileron-R", 
		
		[1000 + 29] = "MiG-21Bis_Damage_Wing-L-Center",
		[1000 + 30] = "MiG-21Bis_Damage_Wing-R-Center",
		
		[1000 + 35] = "MiG-21Bis_Damage_Wing-L-Inner",
		[1000 + 36] = "MiG-21Bis_Damage_Wing-R-Inner",	

		[1000 + 37] = "MiG-21Bis_Damage_Flap-L", 
		[1000 + 38] = "MiG-21Bis_Damage_Flap-R", 
		
		[1000 + 39] = "MiG-21Bis_Damage_Tail-Top",
		[1000 + 41] = "MiG-21Bis_Damage_Tail-Center",		
		
		[1000 + 45] = "MiG-21Bis_Damage_Antisurge_03",
		[1000 + 46] = "MiG-21Bis_Damage_Antisurge_04",	
		[1000 + 47] = "MiG-21Bis_Damage_Antisurge_01",
		[1000 + 48] = "MiG-21Bis_Damage_Antisurge_02",

		[1000 + 49] = "MiG-21Bis_Damage_Elevator-L-Outer", 
		[1000 + 50] = "MiG-21Bis_Damage_Elevator-R-Outer", 	

		[1000 + 51] = "MiG-21Bis_Damage_Elevator-L-Inner", 
		[1000 + 52] = "MiG-21Bis_Damage_Elevator-R-Inner", 	

		[1000 + 53] = "MiG-21Bis_Damage_Rudder-Center",
		[1000 + 66] = "MiG-21Bis_Damage_Rudder-Top",	

	--	[1000 + 55] = "MiG-21-oblomok-tail",
	},

	--****************************************************
	
	--******************* LIGHTS *************************
	
--	 // 2018 June 05 // Mike - Glow Effects are now managed in 3d model. // x,z,y coordinates // 

	lights_data =  
	{
		typename =	"collection",
		lights 	 = 
		{
			--/N/ Lifgts consiste of 5 collections in precise order. It's recommended that they all exist here, even if empty.
			--/N/ NOTE C++ indexes are lesser for 1

			[1] = -- /N/ STROBE lights WOLALIGHT_STROBES, must be 1
			{
				typename	=	"collection",
				lights = 
				{ 

				},				
			},

			[2] = --/N/ TAXI and LANDING lights WOLALIGHT_SPOTS, must be 2
			{ 
			-- Gear Lights -- odnedavno ovo je direktno povezano sa 3d objektom nogu stajnog trapa, ne moze se kontrolisati iz koda...
			-- Takodje, arg. 192 dodeljen je belom pozicionom svetlu pa se ne moze koristiti ovde. Potrebna su 3 nova argumenta.
				typename	=	"collection", 
				lights = 
				{				
					[1] = 
					{
						typename	=	"argumentlight", -- Left Landing 1 / Taxi Light 0.5  /M 20200509
						argument	=	208,
					},
					[2] = 
					{
						typename	=	"argumentlight", -- Right Landing 1 / Taxi Light 0.5 /M 20200509
						argument	=	209,
					},
					[3] = 
					{
						typename	=	"argumentlight", -- Rotation of light housings. 0-1 /M 20200509
						argument	=	51,
						speed  = 1.0,
					},					
				} ,
			},
			
			[3] = --/N/ POSITIONAL (NAV) lights WOLALIGHT_NAVLIGHTS, must be 3
			{
				typename	=	"collection", 
				lights = 
				{
					[1] =
					{
						typename	=	"argumentlight",
						argument	=	190, -- red, LW
					},
					[2] =
					{
						typename	=	"argumentlight",
						argument	=	191, -- green, RW
					},
					[3] =					
					{
						typename	=	"argumentlight",
						argument	=	192, -- white, tail
					},						
				},
			},	
			
			[4] = --/N/ FORMATION FLIGHT lights WOLALIGHT_FORMATION_LIGHTS, must be 4
			{
				typename	=	"collection",
				lights =
				{
				
				},
			},
			
			[5] = --/N/ WOLALIGHT_TIPS_LIGHTS -- контурные, must be 5 (svetla na trupu, hrbatu i sl)
			{
				typename	=	"collection",
				lights =
				{
					--[1] = 
					--{
					--	typename = "argumentlight",
					--	argument = 194, -- /N/ this arg. controls leg positional lights, which are used by human only, and hardcoded, so not needed here (not used by AI at all)
					--}	
				},
			},	

		},
	},

	--****************************************************
	
	--************** EDITOR CUSTOM SUBMENU ***************
	
	panelRadio = {
        [1] = {  
            name = _("R-832"),
           -- range = {min = 80.0, max = 399.9},
            range = {	{min = 118.0, max = 140.0},
						{min = 220.0, max = 390.0}},
			channels = {
				[1] = { name = _("radiochannel00"), default = 124.0, modulation = _("AM"), connect = true},
				[2] = { name = _("radiochannel01"), default = 150.0, modulation = _("AM")},
				[3] = { name = _("radiochannel02"), default = 121.0, modulation = _("AM")},
				[4] = { name = _("radiochannel03"), default = 131.0, modulation = _("AM")},
				[5] = { name = _("radiochannel04"), default = 141.0, modulation = _("AM")},
				[6] = { name = _("radiochannel05"), default = 126.0, modulation = _("AM")},
				[7] = { name = _("radiochannel06"), default = 130.0, modulation = _("AM")},
				[8] = { name = _("radiochannel07"), default = 133.0, modulation = _("AM")},
				[9] = { name = _("radiochannel08"), default = 122.0, modulation = _("AM")},
				[10] = { name = _("radiochannel09"), default = 124.0, modulation = _("AM")},
				[11] = { name = _("radiochannel10"), default = 134.0, modulation = _("AM")},
				[12] = { name = _("radiochannel11"), default = 125.0, modulation = _("AM")},
				[13] = { name = _("radiochannel12"), default = 135.0, modulation = _("AM")},
				[14] = { name = _("radiochannel13"), default = 137.0, modulation = _("AM")},
				[15] = { name = _("radiochannel14"), default = 136.0, modulation = _("AM")},
				[16] = { name = _("radiochannel15"), default = 123.0, modulation = _("AM")},
				[17] = { name = _("radiochannel16"), default = 132.0, modulation = _("AM")},
				[18] = { name = _("radiochannel17"), default = 127.0, modulation = _("AM")},
				[19] = { name = _("radiochannel18"), default = 129.0, modulation = _("AM")},
				[20] = { name = _("radiochannel19"), default = 138.0, modulation = _("AM")},
			},
		},
	},
	

	--[[		
	AddPropAircraft = {
	{ id = 'radiochannel00', control = 'spinbox', label = _('Radio Channel 0'), defValue = 124.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Main
	{ id = 'radiochannel01', control = 'spinbox', label = _('Radio Channel 1'), defValue = 150.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- AUX
	{ id = 'radiochannel02', control = 'spinbox', label = _('Radio Channel 2'), defValue = 121.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Anapa - Vityazevo
	{ id = 'radiochannel03', control = 'spinbox', label = _('Radio Channel 3'), defValue = 131.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Batumi
	{ id = 'radiochannel04', control = 'spinbox', label = _('Radio Channel 4'), defValue = 141.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Beslan
	{ id = 'radiochannel05', control = 'spinbox', label = _('Radio Channel 5'), defValue = 126.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Gelendzhik
	{ id = 'radiochannel06', control = 'spinbox', label = _('Radio Channel 6'), defValue = 130.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Gudauta - Bambora
	{ id = 'radiochannel07', control = 'spinbox', label = _('Radio Channel 7'), defValue = 133.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Kobuleti
	{ id = 'radiochannel08', control = 'spinbox', label = _('Radio Channel 8'), defValue = 122.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Krasnodar - Center
	{ id = 'radiochannel09', control = 'spinbox', label = _('Radio Channel 9'), defValue = 124.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Krymsk
	{ id = 'radiochannel10', control = 'spinbox', label = _('Radio Channel 10'), defValue = 134.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Kutaisi - Kopitnari
	{ id = 'radiochannel11', control = 'spinbox', label = _('Radio Channel 11'), defValue = 125.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Maykop - Khanskaya
	{ id = 'radiochannel12', control = 'spinbox', label = _('Radio Channel 12'), defValue = 135.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Mineralnye Vody
	{ id = 'radiochannel13', control = 'spinbox', label = _('Radio Channel 13'), defValue = 137.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Mozdok
	{ id = 'radiochannel14', control = 'spinbox', label = _('Radio Channel 14'), defValue = 136.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Nalchik
	{ id = 'radiochannel15', control = 'spinbox', label = _('Radio Channel 15'), defValue = 123.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Novorossiysk
	{ id = 'radiochannel16', control = 'spinbox', label = _('Radio Channel 16'), defValue = 132.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Senaki - Kolkhi
	{ id = 'radiochannel17', control = 'spinbox', label = _('Radio Channel 17'), defValue = 127.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Sochi - Adler
	{ id = 'radiochannel18', control = 'spinbox', label = _('Radio Channel 18'), defValue = 129.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Sukhumi - Babushara
	{ id = 'radiochannel19', control = 'spinbox', label = _('Radio Channel 19'), defValue = 138.00, min = 100.00, max = 150.00, dimension = _('MHz')}, -- Tbilisi - Lochini
	},
	]]
	--****************************************************
	
}


if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
		base_MiG_21Bis[i] = o
   end
end
add_aircraft(base_MiG_21Bis)
end

make_mig21() 

