WOLALIGHT_STROBES 		   = 1--must be collection
WOLALIGHT_SPOTS  		   = 2--must be collection
WOLALIGHT_NAVLIGHTS 	   = 3--must be collection
WOLALIGHT_FORMATION_LIGHTS = 4--must be collection
WOLALIGHT_TIPS_LIGHTS      = 5--must be collection

KC135MPRS =  {

	Name 				=   'KC135MPRS',
	DisplayName			= _('KC-135MPRS'),

	Picture 			= "KC135.png",
	Rate 				= 70, -- RewardPoint in Multiplayer
	Shape 				= "KC-135MPRS",
		
    WorldID == WSTYPE_PLACEHOLDER,		
	-------------------------
	shape_table_data 	=
	{
		{
			file  	 = 'KC-135MPRS';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'KC-135MPRS-oblomok'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'KC135MPRS';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "KC-135MPRS-oblomok";
			file  = "KC-135MPRS-oblomok";
			fire  = { 240, 2};
		},

	},
	
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
	
	-------------------------
	mapclasskey = "P0091000064",
	attribute = {
		wsType_Air, 
		wsType_Airplane, 
		wsType_Cruiser,
		WSTYPE_PLACEHOLDER,
		"Tankers",
		"Refuelable",
		"Datalink", 
		"Link16",
	},
	
	Categories = {"{8A302789-A55D-4897-B647-66493FA6826F}", "Tanker",},
	EPLRS = true,
	
	--------- General Characteristics ---------
    singleInFlight				= 	true,
	length	=	46.61,
	height	=	12.93,
	wing_area	=	226,
	wing_span	=	40,
    wing_tip_pos = 	{-11.0, 0.5,	19.8},
    RCS							=	80,
	brakeshute_name	=	0,
    has_speedbrake				=	false,
    stores_number				=	0,
    tanker_type					=	0,
    is_tanker					=	true,
    refueling_points_count		=	1,
	
	refueling_points = 
    {
		--          Front/Rear, Up/Down, Left/Right
		--            +   -      +  -      -    +
        [1] = 	{ pos = {-34.535, -4.026, -18.837}, clientType = 3 },
        [2] = 	{ pos = {-34.535, -4.026,  18.806}, clientType = 3 },
    }, -- end of refueling_points

	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{7.916,	0.986,	0},
		}, -- end of [1]
		[2] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{3.949,	1.01,	0},
		}, -- end of [2]
		[3] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{3.949,	1.01,	0},
		}, -- end of [3]
		[4] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
			pos = 	{3.949,	1.01,	0},
		}, -- end of [4]
	}, -- end of crew_members
    mechanimations = "Default",

	EmptyWeight = 44663,
	MaxFuelWeight = 90700.0,
	MaxHeight = 12000.0,
	MaxSpeed =  980,
	MaxTakeOffWeight = 146000.0,
    Picture						= "KC135.png",
	Rate = "100",
    WingSpan = 40,
    
	----- Weight & Fuel Characteristics  ------
	M_empty	=	44663,
	M_nominal	=	100000,
	M_max	=	146000,
	M_fuel_max	=	90700,
	H_max	=	12000,
	average_fuel_consumption	=	0.1893,
	CAS_min	=	54,
	
	---------- AI Flight Parameters -----------
	V_opt	=	220,
	V_take_off	=	58,
	V_land	=	61,
	V_max_sea_level	=	280.28,
	V_max_h	=	280.28,
	Vy_max	=	10,
	Mach_max	=	0.9,
	Ny_min	=	0.5,
	Ny_max	=	2.5,
	Ny_max_e	=	2,
	AOA_take_off	=	0.14,
	bank_angle_max	=	45,
	flaps_maneuver	=	0.5,
	range	=	12247,
	
	-------- Suspension Characteristics -------
    has_differential_stabilizer	=	false,
    tand_gear_max				=	0.577,
    nose_gear_pos = 	{17.671,	-3.665,	0},
    nose_gear_wheel_diameter	=	0.754,
    main_gear_pos = 	{-2.293,	-3.761,	4.147},
    main_gear_wheel_diameter	=	0.972,
	
	---------- Engine Characteristics ---------
    has_afteburner				=	false,
	thrust_sum_max				=	38100,
	thrust_sum_ab				=	38100,
    engines_count				=	4,
    IR_emission_coeff			=	4,
    IR_emission_coeff_ab		=	0,
	
	engines_nozzles = 
	{

		{
			pos = 	{-5.024,	-1.353,	-13.986},
			elevation	=	0,
			diameter	=	1.523,
			exhaust_length_ab	=	11.794,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.02, 
		}, 	
		{
			pos = 	{-0.347,	-1.875,	8.138},
			elevation	=	0,
			diameter	=	1.523,
			exhaust_length_ab	=	11.794,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.02, 
		}, 	
		{
			pos = 	{-0.347,	-1.875,	-8.138},
			elevation	=	0,
			diameter	=	1.523,
			exhaust_length_ab	=	11.794,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.02, 
		}, 
		{
			pos = 	{-5.024,	-1.353,	13.986},
			elevation	=	0,
			diameter	=	1.523,
			exhaust_length_ab	=	11.794,
			exhaust_length_ab_K	=	0.76,
			smokiness_level     = 	0.02, 
		}, 

	}, -- end of engines_nozzles
	
	--------- Sensors Characteristics ---------
    radar_can_see_ground		= true,
    detection_range_max			= 0,
	
    Sensors = {
        RWR = "Abstract RWR"
    },
	
	---------- Radio Characteristics ----------
	TACAN = true,
	
	----------- ECM Characteristics -----------
    passivCounterm = {
        CMDS_Edit = true,
        SingleChargeTotal = 240,
        chaff = {default = 120, increment = 30, chargeSz = 1},
        flare = {default = 60, increment = 15, chargeSz = 2}
    },
    
    Countermeasures = {         
        IRCM = "AN/ALQ-157",
        DISPENSER = "AN/ALE-47"
    },
    
	--------- Armament Characteristics ---------
    Pylons = {
    },
	
	Tasks = {
        aircraft_task(Refueling),
    },
    
	DefaultTask = aircraft_task(Refueling),	
	
	------------- Damage Table Reference -------------
	fires_pos = 
	{
		[1] = 	{-0.138,	-0.79,	0},
		[2] = 	{-0.138,	-0.79,	5.741},
		[3] = 	{-0.138,	-0.79,	-5.741},
		[4] = 	{-0.82,	0.265,	2.774},
		[5] = 	{-0.82,	0.265,	-2.774},
		[6] = 	{-0.82,	0.255,	4.274},
		[7] = 	{-0.82,	0.255,	-4.274},
		[8] = 	{-0.347,	-1.875,	8.138},
		[9] = 	{-0.347,	-1.875,	-8.138},
		[10] = 	{-5.024,	-1.353,	13.986},
		[11] = 	{-5.024,	-1.353,	-13.986},
	}, -- end of fires_pos
	
	DamageParts = 
 	{
		[1] = "KC-135MPRS-oblomok-wing-r",
		[2] = "KC-135MPRS-oblomok-wing-l",
	},	
	
	------- Flight Model Characteristics -------
	SFM_Data =
	{
		aerodynamics = 
		{
			Cy0	=	0,
			Mzalfa	=	4.355,
			Mzalfadt	=	0.8,
			kjx	=	2.75,
			kjz	=	0.00125,
			Czbe	=	-0.016,
			cx_gear	=	0.015,
			cx_flap	=	0.05,
			cy_flap	=	1,
			cx_brk	=	0.06,
			table_data = 
			{
				[1] = 	{0,	0.023,	0.117,	0.064,	0,	0.5,	20,	1.4},
				[2] = 	{0.2,	0.023,	0.117,	0.064,	0,	1.5,	20,	1.4},
				[3] = 	{0.4,	0.023,	0.117,	0.064,	0,	2.5,	20,	1.4},
				[4] = 	{0.6,	0.025,	0.117,	0.064,	0.022,	3.5,	20,	1.4},
				[5] = 	{0.7,	0.03,	0.117,	0.083,	0.031,	3.5,	20,	1.2},
				[6] = 	{0.8,	0.032,	0.117,	0.107,	0.04,	3.5,	20,	1},
				[7] = 	{0.9,	0.045,	0.117,	0.148,	0.058,	3.5,	20,	0.8},
				[8] = 	{1,	0.054,	0.117,	0.199,	0.1,	3.5,	20,	0.7},
				[9] = 	{1.5,	0.054,	0.117,	0.199,	0.1,	3.5,	20,	0.2},
			}, -- end of table_data
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			type	=	"TurboJet",
			hMaxEng	=	19.5,
			dcx_eng	=	0.0085,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	9000,
			dpdh_f	=	9000,
			table_data = 
			{
				[1] = 	{0,	373600,	373600},
				[2] = 	{0.2,	312756.6,	312756.6},
				[3] = 	{0.4,	279000,	279000},
				[4] = 	{0.6,	251000,	251000},
				[5] = 	{0.7,	253000,	253000},
				[6] = 	{0.8,	262000,	262000},
				[7] = 	{0.9,	274000,	274000},
				[8] = 	{1,	279000,	279000},
				[9] = 	{1.1,	280000,	280000},
				[10] = 	{1.2,	266000,	266000},
				[11] = 	{1.3,	95001.1,	95001.1},
			}, -- end of table_data
		}, -- end of engine
	}, -- end of [SFM_Data]
	
	-- External Lights
	lights_data = 	{
		typename = "collection",
		lights = {
	        [WOLALIGHT_STROBES]   		 = {},--must be collection
	        [WOLALIGHT_SPOTS] 			 = {
				typename = "collection",
				lights = {
					{
						typename  = "spotlight" ,
						connector = "MAIN_SPOT_PTR",
						position  = {-0.173, -1.512, 2.648},
						argument  = 209,
					},
					{
						typename  = "spotlight" ,
						connector = "RESERV_SPOT_PTR",
						position  = {-0.173, -1.512, -2.648},
						argument  = 208,
					},
				},
			},
	        [WOLALIGHT_NAVLIGHTS] 		 = {
				typename = "collection",
				lights = {
					{
						typename  = "omnilight" ,
						connector = "BANO_0",
						color     = {1,1,1},
						position  = {-6.079, 2.896, 0.0},
						argument  = 192,
					},
					{
						typename  = "omnilight" ,
						connector = "BANO_1",
						color     = {0.99,0.11,0.3},
						position  = {-1.516, -0.026, -7.249},
						argument  = 190,
					},
					{
						typename  = "omnilight" ,
						connector = "BANO_2",
						color     = {0,0.894,0.6},
						position  = {-1.516, -0.026,  7.249},
						argument  = 191,
					},	
				},
			},
	        [WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights = {
					{typename  = "argumentlight" ,argument  = 200,},--formation_lights_tail_1 = 200;
					{typename  = "argumentlight" ,argument  = 201,},--formation_lights_tail_2 = 201;
					{typename  = "argumentlight" ,argument  = 202,},--formation_lights_left   = 202;
					{typename  = "argumentlight" ,argument  = 203,},--formation_lights_right  = 203;
					{typename  = "argumentlight" ,argument  = 88,},-- old aircraft arg 
				},
			},
		},
	},  -- end of [lights_data]
}

add_aircraft(KC135MPRS)

