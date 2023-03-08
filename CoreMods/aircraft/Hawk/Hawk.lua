--mounting 3d model paths and texture paths 

mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Textures/Hawk.zip")
mount_vfs_texture_path (current_mod_path.."/Textures/XX100_TFC.zip")
--dofile(current_mod_path.."/Views.lua") --no such file in CoreMods, but there is Views.lua in Mods. Is it misplaced?

declare_loadout({
 category    =   CAT_PODS,
 CLSID       =  "{ADEN_GUNPOD}",
 attribute   =   {wsType_Weapon,wsType_GContainer,wsType_Cannon_Cont,WSTYPE_PLACEHOLDER},
 Picture      = "ADEN_GUNPOD.png",
 displayName   = _("ADEN GUNPOD"),
 Weight     = 87,
 Cx_pil     = 0.001220703125,
 Elements     = {{ShapeName = "ADEN_GUNPOD"}},
 kind_of_shipping = 2,--SOLID_MUNITION
 gun_mounts  = {  gun_mount("ADEN",{ count = 130},{muzzle_pos_connector = "Point_Gun"  ,ejector_pos_connector = "extractor1",barrel_circular_error = 0.005, effects = { fire_effect(6,0.05),smoke_effect()}}),
  },
 shape_table_data = {{file    = 'ADEN_GUNPOD'; username = 'ADEN_GUNPOD';index    =  WSTYPE_PLACEHOLDER;}}
})

Hawk =  {
        
	Name 				=   'Hawk',
	DisplayName			= _('Hawk'),
	ViewSettings			= ViewSettings,
	
	Picture 			= "Hawk.png",
	Rate 				= 40, -- RewardPoint in Multiplayer
	Shape 				= "Hawk",
	
	shape_table_data 	= 
	{
		{
			file  	 = 'Hawk';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'hawk_destr'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'Hawk';
			index    =  WSTYPE_PLACEHOLDER;
		},
		{
			name  = "Hawk_destr";
			file  = "Hawk-destr";
			fire  = { 240, 2};
		},

	},
	
	-- add model draw args for network transmitting to this draw_args table (32 limit)
	net_animation ={98, -- canopy
					0, -- gear
					3,
					5,
					--9, -- flaps
					--10,
					--21, -- air brake
					7, -- rat
					13, -- prop slow
					14, -- prop fast
					513, -- lower white strobe
					506, -- lower red strobe
					507 -- landing light
					},
	
	mapclasskey 		= "P0091000025",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	-------------------------
	M_empty 					= 3127, -- kg changed
	M_nominal 					= 5000, -- kg changed
	M_max 						= 5700, -- kg changed
	M_fuel_max 					= 1272, -- kg --2225 changed
	H_max 					 	= 14630, -- m changed
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 10, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 231,-- Cruise speed (for AI)
	V_take_off 					= 77, -- Take off speed in m/s (for AI)
	V_land 						= 61, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 400, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 800, -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 200, -- Max climb speed in m/s (for AI)
	Mach_max 					= 0.80, -- Max speed in Mach (for AI)
	Ny_min 						= -4, -- Min G (for AI)
	Ny_max 						= 7.0,  -- Max G (for AI)
	Ny_max_e 					= 7.0,  -- Max G (for AI)
	AOA_take_off 				= 0.17, -- AoA in take off (for AI)
	bank_angle_max 				= 85, -- Max bank angle (for AI)


	has_afteburner 				= false, -- AFB yes/no changed
	has_speedbrake 				= true, -- Speedbrake yes/no
	
	nose_gear_pos 				= {  4.147, -1.4582 , 0 },     -- nosegear coord 
	main_gear_pos 				= { -0.241, -1.57895, 1.584 }, -- main gear coords 
----------------- SUSPENSION CODE
	nose_gear_amortizer_direct_stroke    	 =  0,  	  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  	 = -0.17647,  -- up 
	main_gear_amortizer_direct_stroke  	 	 =  0, 		  --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 = -0.29722,  --  up 
	nose_gear_amortizer_normal_weight_stroke = -0.05,	  -- down from nose_gear_pos
	main_gear_amortizer_normal_weight_stroke = -0.15,-- down from main_gear_pos
----------------- SUSPENSION CODE
	tand_gear_max 				= 0.4,
	tanker_type 				= 0, -- Tanker type if the plane is airrefuel capable
	wing_area 					= 16.69, -- wing area in m2 changed
	wing_span 					= 9.418, -- wing spain in m changed
	wing_type 					= 0,
	thrust_sum_max 				= 10000, -- thrust in kg (44kN) changed 2310
	thrust_sum_ab 				= 10000, -- thrust inkg (71kN) changed 2310
	length 						= 11.98, -- full lenght in m changed
	height 						= 4.02, -- height in m changed
	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 2000, -- Max range in km (for AI)
	RCS 						= 5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.62, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 1.02, -- With afterburner
	wing_tip_pos 				=  {-1.757,	-0.027, 4.67}, -- wingtip coords for visual effects
	nose_gear_wheel_diameter 	= 0.42, -- in m
	main_gear_wheel_diameter 	= 0.550, -- in m
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	is_tanker 					= false, -- Tanker yes/no
	air_refuel_receptacle_pos 	= {0, 0, 0}, -- refuel coords
	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos 		=  {-4.85,	0.2,	0}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 1, -- AFB cone diameter
			exhaust_length_ab   = 7, -- lenght in m
			exhaust_length_ab_K = 0.76, -- AB animation
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_size	 = 2,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name = "pilot+ejectionseat",
			drop_canopy_name = "Hawk_canopy",
			pos =  {4,	1,	0},
			canopy_pos = {4,	1,	0},
			ejection_order    = 1,
			ejection_added_speed = {0,0,5},
			can_be_playable  = true,	
			role = "pilot",
			role_display_name = _("Pilot"), -- _("Hawk Pilot")
            bailout_arg = -1,
		}, -- end of [1]
		[2] = 
		{
			ejection_seat_name = "pilot+ejectionseat",
			drop_canopy_name = "Hawk_canopy",
			pos =  {4,	1,	0},
			canopy_pos = {4,	1,	0},
			ejection_order    = 2,
			ejection_added_speed = {0,0,-5},
			pilot_body_arg  = 529,
			can_be_playable  = true,	
			role = "instructor",
			role_display_name = _("Instructor pilot"), -- _("Hawk Instructor pilot"),
            bailout_arg = -1,
		}, -- end of [2]
		}, -- end of crew_members

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "at", 0.8},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "at", 1.4},},},}, Flags = {"Reversible", "StepsBackwards"},},
        },
        Door1 = {DuplicateOf = "Door0"},
    }, -- end of mechanimations

	fires_pos = 
		{
			[1] = 	{-2.117,	-0.9,	0},
			[2] = 	{-1.584,	0.176,	2.693},
			[3] = 	{-1.645,	0.213,	-2.182},
			[4] = 	{-0.82,	0.265,	2.774},
			[5] = 	{-0.82,	0.265,	-2.774},
			[6] = 	{-0.82,	0.255,	4.274},
			[7] = 	{-0.82,	0.255,	-4.274},
			[8] = 	{-6.548,	-0.248,	0},
			[9] = 	{-6.548,	-0.248,	0},
			[10] = 	{0.304,	-0.748,	0.442},
			[11] = 	{0.304,	-0.748,	-0.442},
		}, -- end of fires_pos
	
	
	-- Countermeasures
	SingleChargeTotal	 	= 0,
	CMDS_Incrementation 	= 4,
	ChaffDefault 			= 0, 
	ChaffChargeSize 		= 1,
	FlareDefault 			= 0, 
	FlareChargeSize 		= 1,
	CMDS_Edit 				= true,
	chaff_flare_dispenser 	= {
		[1] = 
		{
			dir =  {0, -1, -1},
			pos =  {-3, -1, 2},
		}, -- end of [1]
		[2] = 
		{
			dir =  {0, -1, 1},
			pos =  {-3, -1, -2},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser

	--sensors
	
	detection_range_max		 = 60,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = {
		azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation = {-50.0, 90.0} -- pilot view vertical (AI)
	},
	Sensors = {
--[[		RWR = "Abstract RWR", -- RWR type
		RADAR = "N-019", -- Radar type
]]		
	},
	HumanRadio = {
		frequency = 127.5,  -- Radio Freq
		editable = true,
		minFrequency = 100.000,
		maxFrequency = 156.000,
		modulation = MODULATION_AM
	},


	
	Pylons =     {
        pylon(1, 0, 0, 0, 0, {use_full_connector_position=true,connector = "PYLON_1",arg = 314,arg_value = -1.0}, 
            {
				{ CLSID = "{AIM-9M-ON-ADAPTER}",arg = 315,arg_value = 0.5 }, --    AIM-9M + LAU-7
            }
        ),
        pylon(2, 0, 0, 0, 0, {use_full_connector_position=true,connector = "PYLON_2",arg = 315,arg_value = -1.0}, 
            {
				{ CLSID = "{Matra155RocketPod}",arg = 314,arg_value = 0.5}, --    LAU-61 - 19 2.75' rockets MK151 HE
				{ CLSID = "{CBU-87}",arg = 314,arg_value = 0.5 },								  --    CBU-87
				{ CLSID = "BRU-42_3*BDU-33",arg = 314,arg_value = 0.5 },							  --    BRU-42_3*BDU-33
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",arg = 314,arg_value = 0.5 },  --    MK-82
            }
        ),
        pylon(3, 0, 0.000000, 0, 0.000000, -- Updated for gun pod
            {
				use_full_connector_position=true,
				connector = "PYLON_3",
				arg = 316,
				arg_value = -1.0
            },
            {
				{ CLSID = "{ADEN_GUNPOD}" }, --    Aden Gun Pod
            }
        ),
        pylon(4, 0, 0, 0, 0, 
            {
				use_full_connector_position=true,
				connector = "PYLON_4",
				arg = 317,
				arg_value = -1.0
            },
            {
				{ CLSID = "{Matra155RocketPod}",arg = 318, arg_value = 0.5 }, --    LAU-61 - 19 2.75' rockets MK151 HE
				{ CLSID = "{CBU-87}",arg = 318, arg_value = 0.5 },								  --    CBU-87
				{ CLSID = "BRU-42_3*BDU-33",arg = 318, arg_value = 0.5 },							  --    BDU-50LD
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",arg = 314,arg_value = 0.5 },  --    MK-82
            }
        ),
        pylon(5, 0, 0, 0, 0, 
            {
				use_full_connector_position=true,
				connector = "PYLON_5",
				arg = 318,
				arg_value = -1.0
            },
            {
				{ CLSID = "{AIM-9M-ON-ADAPTER}",arg = 317, arg_value = 0.5 }, --    AIM-9M + LAU-7A
            }
        ),
        pylon(6, 0, 0, 0, 0, -- Smoke Out of Tail
            {
				use_full_connector_position=true,
				connector = "PYLON_SMOKE",
				arg = 319,
				arg_value = -1.0
            },
            {
				{ CLSID	= "{D3F65166-1AB8-490f-AF2F-2FB6E22568B1}" }, --	Red Smoke
				{ CLSID	= "{D3F65166-1AB8-490f-AF2F-2FB6E22568B4}" }, --	White Smoke 
				{ CLSID	= "{D3F65166-1AB8-490f-AF2F-2FB6E22568B3}" }, --	Blue Smoke
            }
        ),		
	},
	
	Tasks = {
		aircraft_task(CAP),				-- 11, Combat Air Patrol
        aircraft_task(CAS),				-- 31, Close air support
        aircraft_task(Escort),			-- 18,
        aircraft_task(FighterSweep),	-- 19,
        aircraft_task(GroundAttack),	-- 32,
        aircraft_task(Intercept),		-- 10,
    },	
	DefaultTask = aircraft_task(CAP),
	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0	=	0,
			Mzalfa	=	4.355,
			Mzalfadt	=	0.8,
			kjx = 2.25,
			kjz = 0.00125,
			Czbe = -0.016,
			cx_gear = 0.12,
			cx_flap = 0.1,
			cy_flap = 0.31,
			cx_brk = 0.1,
			table_data = {
			--      M		Cx0		 Cya		 B		 B4	      Omxmax	Aldop	Cymax

					{0.0,	0.0224,	0.05,		0.1079,	0.07,		3.0,	40,		1.33,	},
					{0.1,	0.0214,	0.075,		0.1079,	0.07,		3.0,	35,		1.33,   },
					{0.2,	0.0209,	0.075,		0.1079,	0.07,		3.0,	30,		1.3,    },
					{0.3,	0.0204,	0.078,		0.1079,	0.07,		3.0,	30,		1.3,    },
					{0.4,	0.0204,	0.079,		0.1079,	0.07,		3.1,	30,		1.3,    },
					{0.5,	0.0204,	0.08,		0.1079,	0.07,		3.2,	30,		1.3,    },
					{0.6,	0.0204,	0.082,		0.1079,	0.07,		3.2,	30,		1.2,    },
					{0.7,	0.0204,	0.085,		0.1079,	0.07,		3.5,	25,		1.1,    },
					{0.8,	0.0206,	0.085,		0.1089,	0.018,		3.5,	20,  	1.0,    },
					{0.9,	0.0313,	0.085,		0.11,	0.02,		3.5,	20,  	1.0,    },
					{0.95,	0.0400,	0.07,		0.107,	0.03,		3.5,	18,	    1.0,	},
					{1.0,	0.0472,	0.085,		0.12,	0.034,		3.5,	20,  	1.0,    },
					{1.1,	0.0489,	0.085,		0.2772,	0.134,		3.5,	20,  	1.0,    },
					{1.2,	0.0460,	0.085,		0.5,	0.28,		3.5,	20,  	1.0,    },
					{1.3,	0.0423,	0.085,		0.44,	0.3,		3.5,	15,		1.0		},
					{2.5,	0.0268,	0.085,		0.5,	0.32,		3.5,	20,  	1.0,    },
					{3.9,	0.027,	0.085,		0.56,	0.4,		3.5,	20,  	1.0,    },
			}
		}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	55.0, -- 67.5
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			typeng	=	0,
			hMaxEng	=	15.5, -- 30.5
			dcx_eng	=	0.0015,
			cemax	=	0.37,
			cefor	=	0.37,
			dpdh_m	=	1800,
			dpdh_f	=	1800,
			table_data = 
			{
			--   M			Pmax
				{0.0,		21750.0}, --16000
				{0.1,		21000.0}, --21000
				{0.2,		20000.0}, --25000
				{0.3,		19430.0}, --28000
				{0.4,		18760.0}, --29700
				{0.5,		18080.0}, --30500
				{0.6,		17500.0}, --31000
				{0.7,		17110.0}, --30000
				{0.8,		16920.0}, --25000
				{0.90,		15570.0}, --23000
				{0.95,		15000.0}, --23000
				{1.0,		14410.0}, --42000
				{1.1,		13250.0}, --38000
				{1.2,		11510.0}, --30000
				{1.3,		8500.0}, --10000
				{2.5,		5700.0}, --10000
				{3.9,		3000.0}, --10000
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
				[1]		= {critical_damage = 5, args = {209}}, -- Nose left -> Previous arg 186
				[2]		= {critical_damage = 5,args = {187}}  , -- Nose right
				[3]		= {critical_damage = 3, args = {188}, deps_cells = {6}}, -- Backseat left
				[4]		= {critical_damage = 3, args = {189}, deps_cells = {5}}, -- Frontseat left
				[5]		= {critical_damage = 3, args = {190}, deps_cells = {4}} , -- Frontseat right
				[6]		= {critical_damage = 3, args = {191}, deps_cells = {3}}, -- Backseat right
				[9]		= {critical_damage = 7, args = {192}}, -- Back of intake left
				[10]	= {critical_damage = 7, args = {193}}, -- back of intake right
				[11]	= {critical_damage = 10, args = {111}}, -- engine top left
				[12]	= {critical_damage = 10, args = {210}}, -- engine top right -> Previous arg 112
				[15]	= {critical_damage = 8, args = {115}}, -- main gear housing left
				[16]	= {critical_damage = 8, args = {116}}, -- main gear housing right
				[19]	= {critical_damage = 3, args = {119}}, -- airbrake
				[21]	= {critical_damage = 7, args = {197}, deps_cells = {23, 25}}, -- wing left 4/5 (5=tip)
				[22]	= {critical_damage = 7, args = {198}, deps_cells = {24, 26}}, -- wing right4/5
				[23]	= {critical_damage = 7, args = {195}, deps_cells = {25}}, -- wing left 5/5
				[24]	= {critical_damage = 7, args = {196}, deps_cells = {26}}, -- wing right 5/5
				[25]	= {critical_damage = 3, args = {207}}, -- aileron left
				[26]	= {critical_damage = 3, args = {206}}, -- aileron right
				[27]	= {critical_damage = 9, args = {201}, deps_cells = {29, 21, 23, 37, 25}}, -- wing left 2/5
				[28]	= {critical_damage = 9, args = {202}, deps_cells = {30, 22, 24, 26, 38}} , -- wing right 2/5
				[29]	= {critical_damage = 8, args = {199}, deps_cells = {21, 23, 25, 37}}, -- wing left 3/5
				[30]	= {critical_damage = 8, args = {200,}, deps_cells = {22, 24, 26, 38}}, -- wing right 3/5
				[33]	= {critical_damage = 10, args = {203}, deps_cells = {27, 29, 21, 23, 37, 25}}, -- wing left 1/5
				[34]	= {critical_damage = 10, args = {204}, deps_cells = {28, 30, 22, 24, 26, 38}}, -- wing right 1/5
				[37]	= {critical_damage = 4, args = {205}}, -- flaps left
				[38]	= {critical_damage = 4, args = {208}}, -- flaps right
				[39]	= {critical_damage = 7, args = {139}, deps_cells = {53}}, -- Tail fin top
				[40]	= {critical_damage = 3, args = {140}, deps_cells = {49}}, -- elevator left mid
				[41]	= {critical_damage = 7, args = {141}, deps_cells = {39, 53}}, -- Tail fin mid
				[42]	= {critical_damage = 3, args = {142}, deps_cells = {50}}, -- elevator right mid
				[43]	= {critical_damage = 8, args = {143}, deps_cells = {41, 39, 53}}, -- Tail fin bottom
				[49]	= {critical_damage = 3, args = {149}}, -- elevator left tip
				[50]	= {critical_damage = 3, args = {150}}, -- elevator right tip
				[51]	= {critical_damage = 3, args = {151}, deps_cells = {40, 49}}, -- elevator left in
				[52]	= {critical_damage = 3, args = {152}, deps_cells = {42, 50}}, -- elevator right in
				[53]	= {critical_damage = 3, args = {153}}, -- rudder
				[56]	= {critical_damage = 7, args = {156}}, -- nozzle top left
				[57]	= {critical_damage = 7, args = {157}}, -- nozzle top right
				[58]	= {critical_damage = 7, args = {158}}, -- nozzle bottom right
				[60]	= {critical_damage = 7, args = {160}}, -- nozzle bottom left
				[61]	= {critical_damage = 5, args = {161}}, -- fuselage mid top left
				[62]	= {critical_damage = 5, args = {162}}, -- fuselage mid top right
				[64]	= {critical_damage = 7, args = {164}}, -- frontseat bottom right
				[65]	= {critical_damage = 4, args = {165}}, -- intake right
				[66]	= {critical_damage = 7, args = {166}}, -- frontseat bottom left
				[67]	= {critical_damage = 7, args = {167}}, -- backseat bottom right
				[68]	= {critical_damage = 4, args = {168}}, -- intake left
				[69]	= {critical_damage = 7, args = {169}}, -- backseat bottom left
				[70]	= {critical_damage = 6, args = {170}}, -- back of backseat right
				[71]	= {critical_damage = 5, args = {171}}, -- fuselage mid bottom right
				[72]	= {critical_damage = 6, args = {172}}, -- back of backseat left
				[73]	= {critical_damage = 5, args = {173}}, -- fuselage mid mid right
				[74]	= {critical_damage = 5, args = {174}}, -- fuselage mid bottom left
				[75]	= {critical_damage = 5, args = {175}}, -- fuselage mid mid left
				[76]	= {critical_damage = 10, args = {176}, deps_cells = {19}}, -- engine bottom right
				[78]	= {critical_damage = 10, args = {178}, deps_cells = {19}}, -- engine bottom left
				[83]	= {critical_damage = 3, args = {183}} ,-- nose wheel
				[84]	= {critical_damage = 3, args = {184}}, -- left wheel
				[85]	= {critical_damage = 3, args = {185}} ,-- right wheel
	},
	
	DamageParts = 
	{  
		[1] = "Hawk-part-wing-R", -- wing R
		[2] = "Hawk-part-wing-L", -- wing L
		[3] = "Hawk-part-nose", -- nose
		[4] = "Hawk-part-tail", -- tail
	},

lights_data = {
typename = "collection",
lights = {
[1] = { typename = "collection", -- nav lights
	lights = {
				{typename = "omnilight",connector = "BANO_1",color = {0.99, 0.0, 0.22},pos_correction = {0, 0, 0},argument = 500}, -- left nav
			 }
		},
[2] = { typename = "collection", -- nav lights
	lights = {
				{typename = "omnilight",connector = "BANO_2",color = {0.0, 0.99, 0.75},pos_correction = {0, 0, 0},argument = 501}, -- right nav
			 }
		},
[3] = { typename = "collection", -- nav lights
	lights = {
				{typename = "omnilight",connector = "BANO_0_BACK",color = {0.95, 0.95, 0.95},pos_correction = {0, 0, 0},argument = 502}, -- tail nav
			 }
		},
[4] = { typename = "collection", -- white strobe upper
	lights = {
				{typename = "natostrobelight",connector = "WHITE_TOP",argument_1 = 512,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.0},
			 }
		},
[5] = { typename = "collection", -- red strobe upper
	lights = {
				{typename = "natostrobelight",connector = "BANO_0_TOP",argument_1 = 503,period = 1.0,color = {1, 0, 0},phase_shift = 0.0},
			 }
		},
[6] = { typename = "collection", -- white strobe lower
	lights = {
				{typename = "natostrobelight",connector = "WHITE_BOTTOM",argument_1 = 513,period = 1.0,color = {0.8, 0.8, 1.0},phase_shift = 0.5},
			 }
		},
[7] = { typename = "collection", -- red strobe lower
	lights = {
				{typename = "natostrobelight",connector = "BANO_1_BOTTOM",argument_1 = 506,period = 1.0,color = {1, 0, 0},phase_shift = 0.5},
			 }
		},
[8] = { typename = "collection", -- land/taxi light
	lights = {
				{typename = "spotlight",connector = "MAIN_SPOT_PTR_01",argument = 507,color = {1.0, 1.0, 0.7},dir_correction = {elevation = math.rad(9)}}, -- 10 looks ok
			 }
		},
[9] = { typename = "collection", -- gear down light
	lights = {
				{typename = "omnilight",connector = "EXT_GEAR_DOWN",color = {0.99, 0.78, 0.0},pos_correction = {0, 0, 0},argument = 508},
			 }
		},
	}
}, -- end lights_data
panelRadio = {
       [1] = {
           name = _("Radio 1"),
           range = {min = 225.0, max = 399.9},
           channels = {
               [1] = { name = _("Channel 1"), default = 225.0, modulation = _("AM"), connect = true},
               [2] = { name = _("Channel 2"), default = 258.0, modulation = _("AM")},
               [3] = { name = _("Channel 3"), default = 260.0, modulation = _("AM")},
               [4] = { name = _("Channel 4"), default = 270.0, modulation = _("AM")},
               [5] = { name = _("Channel 5"), default = 255.0, modulation = _("AM")},
               [6] = { name = _("Channel 6"), default = 259.0, modulation = _("AM")},
               [7] = { name = _("Channel 7"), default = 262.0, modulation = _("AM")},
               [8] = { name = _("Channel 8"), default = 257.0, modulation = _("AM")},
               [9] = { name = _("Channel 9"), default = 253.0, modulation = _("AM")},
               [10] = { name = _("Channel 10"), default = 263.0, modulation = _("AM")},
               [11] = { name = _("Channel 11"), default = 267.0, modulation = _("AM")},
               [12] = { name = _("Channel 12"), default = 254.0, modulation = _("AM")},
               [13] = { name = _("Channel 13"), default = 264.0, modulation = _("AM")},
               [14] = { name = _("Channel 14"), default = 266.0, modulation = _("AM")},
               [15] = { name = _("Channel 15"), default = 265.0, modulation = _("AM")},
               [16] = { name = _("Channel 16"), default = 252.0, modulation = _("AM")},
               [17] = { name = _("Channel 17"), default = 268.0, modulation = _("AM")},
               [18] = { name = _("Channel 18"), default = 269.0, modulation = _("AM")},
           }
       },
   },
}

add_aircraft(Hawk)
