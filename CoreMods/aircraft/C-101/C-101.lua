mount_vfs_liveries_path(current_mod_path .. "/Liveries")

function make_aviojet(rewrite_settings) 

local rewrite_settings  = rewrite_settings or {Shape = 'C-101EB', Name = 'C-101EB'}

local canopyMoveTime 	= 2.75
local canopyArgFwd		= 38
local canopyArgRear		= 421
		
local C_101 = {
        
	Picture 			= "C-101EB.png",
	ViewSettings		= ViewSettings,
---------------------------------------------------------------------------------------------------------------------------------------------	
	shape_table_data 	= 
	{
		{
			file  	 = rewrite_settings.Shape   or 'C-101EB',
			life  	 = 18, -- lifebar
			vis   	 = 3, -- visibility gain
			desrt    = 'C-101_destr', -- Name of destroyed object file name
			fire  	 = { 300, 2}, -- Fire on the ground after destoyed: 300sec 2m
			username = rewrite_settings.Name    or 'C-101EB',
			index    = WSTYPE_PLACEHOLDER,
			classname = "lLandPlane",
			positioning = "BYNORMAL",			
		},
		{
			name  = "C-101_destr",
			file  = "C-101_destr",
			fire  = { 240, 2},
			classname = "lLandPlane",
			positioning = "BYNORMAL",			
		},

	},
	-- add model draw args for network transmitting to this draw_args table (32 limit)
---------------------------------------------------------------------------------------------------------------------------------------------	

	DisplayName									=	_("C-101EB"),
	mapclasskey									=	"P0091000024",
	WorldID										=    WSTYPE_PLACEHOLDER,
	
	attribute 									= 	{wsType_Air, wsType_Airplane, wsType_Battleplane, WSTYPE_PLACEHOLDER,
													"Battleplanes",
													"All",
													"NonAndLightArmoredUnits",
													"NonArmoredUnits",
													"Air",
													"Planes",
													"Battle airplanes"},
													
	Rate										=	50,
	AOA_take_off								=	0.165,
	CAS_min										=	56,
	CanopyGeometry 								= 	{-0.34202014332567,	-0.64085638205579,	-0.93969262078591,	-0.036833608500735,	0.86602540378444},
	Categories 									= 	{"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	radar_can_see_ground						=	false,
	range										=	1015,
	tanker_type									=	0,
	thrust_sum_max 								=   1588, -- thrust in kg (16.4 kN)
	thrust_sum_ab 								=   1588, -- thrust in kg (0 kN)
	wing_area									=	20,
	wing_span									=	14,
	wing_tip_pos 								=  	{-0.77, -0.049, 5.294},
	IR_emission_coeff							=	0.2,
	IR_emission_coeff_ab						=	0,
	
	-- BOW. 3377 kg of empty aircraft with unusable fluids (not including fuel) + two pilots (160 kg)
	-- WARNING! cpp OEW value should always be set to [M_empty - 160 kg] in the case when M_empty is updated
	M_empty 									= 	3537.0,
	M_nominal 									= 	4756.0,
	-- BOW (3537 kg) + max fuel load (1796 kg) + smoke system (33 kg)
	M_max										= 	5366.0,
	-- M_fuel_max:
	-- previous - 4148 lb (1881.501 kg) max, including unusable fuel
	-- updated - 3960 lb (1796 kg) max, including unusable fuel
	M_fuel_max 									= 	1796.0,
	MaxFuelWeight								=	1796.0,
	MaxTakeOffWeight							=	5366.0, -- was 5600.0
		
	Mach_max									=	0.8,
	MaxHeight									=	12500,
	MaxSpeed									=	770,
	Ny_min 										= 	-3.9, -- Min G (for AI)
	Ny_max 										= 	6,  -- Max G (for AI)
	Ny_max_e 									= 	6,  -- Max G (for AI)
	RCS											=	2.5,
	defFuelRatio								=	0.84, -- топливо по умолчанию в долях от полного
	H_max										=	12500,
	V_opt 										= 	125,-- Cruise speed (for AI)
	V_take_off 									= 	53, -- Take off speed in m/s (for AI)
	V_land 										= 	61, -- Land speed in m/s (for AI)
	V_max_sea_level 							= 	205, -- Max speed at sea level in m/s (for AI)
	V_max_h 									= 	257, -- Max speed at max altitude in m/s (for AI)
	Vy_max 										= 	10, -- Max climb speed in m/s (for AI)
	WingSpan									=	10.60,
	average_fuel_consumption					=	0.08,
	bank_angle_max								=	60,
	bigParkingRamp								=	false,
	brakeshute_name								=	0,
	detection_range_max							=	0,
	engines_count								=	1,
	flaps_maneuver								=	0.5,
	has_afteburner								=	false,
	has_differential_stabilizer					=	false,
	has_speedbrake								=	true,
	height 										= 	4.25,
	is_tanker									=	false,
	length 										= 	12.25,	
---------------------------------------------------------------------------------------------------------------------------------------------	
----------------- SUSPENSION CODE
	--nose gear position z (-1.719m..-1.653..-1.574m)
	--main gear position z (-1.81m..-1.749..-1.677m)
	
	main_gear_pos 								= {-0.162, -1.900, 1.367},
	nose_gear_pos 								= {4.619, -1.746, 0.0},

	nose_gear_amortizer_direct_stroke    		= 1.762 - 1.746,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  		= 1.619 - 1.746,  -- up 
	nose_gear_amortizer_normal_weight_stroke 	= -0.00311633945,
	
	main_gear_amortizer_direct_stroke	 		= 1.914  - 1.900, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  		= 1.648 - 1.900, --  up 
	main_gear_amortizer_normal_weight_stroke 	= -0.04,

	nose_gear_wheel_diameter 					= 0.462, -- in m
	main_gear_wheel_diameter 					= 0.637, -- in m
	
	tand_gear_max 								= 0.577,
----------------- SUSPENSION CODE
---------------------------------------------------------------------------------------------------------------------------------------------
	net_animation =
	{
		--canopyArgFwd,  			-- Forward canopy position
		--canopyArgRear, 			-- Rear canopy position
								
		2,						-- Nose wheel rotation (nose wheel steering)
								
		23,  					-- AI Chocks
		39,  					-- Turn forward pilot head
		75,  					-- GPU
		99,  					-- Incline forward pilot head
								
		148, 					-- CANOPY_OUT_FWR
								
		287, 					-- Horizontal stabilizer
								
		337, 					-- Turn rear pilot head
		399, 					-- Incline rear pilot head
								
		420, 					-- PILOT arm

		530,					-- IFR Hood installed
		--531,					-- IFR Hood position (open/close)
								
		780, 					-- ADI pitch
		781, 					-- ADI roll
								
		818, 					-- PILOT VISOR FWD
		819, 					-- PILOT VISOR REAR
	
		843, 					-- Disable wheel chocks
		844, 					-- Chocks
		845, 					-- Forward ladder
		846, 					-- Rear ladder
		
		848,					-- GPS installed and it's position (fwd/rear seat)
		
		-- Data
		920,					-- is human
		921,					-- rear seat occupied
		--922,					-- cockpit audibility
		923,					-- reset arguments
		924,					-- GPU status - off, start, idle, etc..
		925,					-- Battery status
		926, 					-- IFR Hood position (open/close)
		
		1000,					-- Rudder trim (C-101CC)
		
		1005,					-- Rear canopy position
		1007,					-- Forward canopy position
	},	

---------------------------------------------------------------------------------------------------------------------------------------------	
	engines_nozzles = {
		[1] = 
		{
			pos 		=  {-4.123,	-0.157,	0}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0.392, -- AFB cone diameter
			exhaust_length_ab   = 7, -- lenght in m
			exhaust_length_ab_K = 0.76, -- AB animation
			smokiness_level = 0.02,
		}, -- end of [1]
	}, -- end of engines_nozzles
---------------------------------------------------------------------------------------------------------------------------------------------	
	crew_size	 = 2,
	crew_members = 
	{
		-- Forward cockpit
		[1] = 
		{
			ejection_seat_name   			= "pilot+c-101+ejectionseat_1",
			pilot_name		     			= "pilot_c-101_01",
			drop_canopy_name     			= "C-101-oblomok-canopy-glass_1",
			
			drop_parachute_name  			= "C-101_parachute",			
			pos 							= {3.233,0.066,-0,005},
			canopy_pos 						= {2.677,2.677,0},
			can_be_playable 	 			= true,				
			bailout_arg 		 			= -1,
			canopy_arg           			= canopyArgFwd,
			ejection_play_arg    			= 149,
			ejection_through_canopy 		= true,
			ejection_added_speed 			= {-5,15,0},
			ejection_order 		 			= 2,			
			role 				 			= "pilot",
			role_display_name    			= _("Pilot"),	
			g_suit 			     			= 0.8,
			
			pilot_body_arg					= 50,
			boarding_arg					= canopyArgFwd,
			canopy_args						= {canopyArgFwd, 1},
			canopy_ejection_dir				= {-0.4, 1.0, 0.0},
		},

		-- Rear cockpit
		[2] = 
		{
			ejection_seat_name  			= "pilot+c-101+ejectionseat_2",
			pilot_name		    			= "pilot_c-101_02",			
			drop_canopy_name    			= "C-101-oblomok-canopy-glass_2",
			
			drop_parachute_name 			= "C-101_parachute",			
			pos 							= {1.681,0.339,-0,005},
			canopy_pos 						= {1.01,0.786,-0.0},
			can_be_playable 				= true,	
			bailout_arg 					= -1,
			canopy_arg          			= canopyArgRear,
			ejection_play_arg   			= 473,			
			ejection_through_canopy 		= true,		
			ejection_added_speed 			= {-5,15,0},
			ejection_order 					= 1,		
			role 							= "instructor",
			role_display_name   			= _("Instructor pilot"),
			g_suit 			    			= 0.8,
			
			pilot_body_arg					= 472,
			boarding_arg					= canopyArgRear,
			canopy_args						= {canopyArgRear, 1},
			canopy_ejection_dir				= {-0.4, 1.0, 0.0},	
		},
	}, -- end of crew_members
---------------------------------------------------------------------------------------------------------------------------------------------
    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", canopyArgFwd, "to", 0.9, "in", canopyMoveTime}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", canopyArgFwd, "to", 0.0, "in", canopyMoveTime}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"},Sequence = {{C = {{"TearCanopy", 0},},},},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Origin", "x", 2.871, "y", 0.677, "z", 0.0}, {"Impulse", 1, "tertiary", 0.001}, {"Arg", 149, "set", 1.0}}}}},
			{Transition = {"Any", "TearOff"}, Sequence = {{C = {{"TearCanopy", 0},},},},},
        },
        Door1 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"PosType", 9}, {"Sleep", "for", 2.0}}}, {C = {{"VelType", 4}, {"Arg", canopyArgRear, "to", 0.9, "in", canopyMoveTime}}}, {C = {{"Sleep", "for", 0.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Sleep", "for", 0.0}}},                 {C = {{"VelType", 4}, {"Arg", canopyArgRear, "to", 0.0, "in", canopyMoveTime}}}, {C = {{"PosType", 9}, {"Sleep", "for", 2.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Open", "Bailout"},Sequence = {{C = {{"TearCanopy", 1},},},},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Origin", "x", 1.709, "y", 0.817, "z", 0.0}, {"Impulse", 1, "tertiary", 0.001}, {"Arg", 473, "set", 1.0}}}}},
			{Transition = {"Any", "TearOff"}, Sequence = {{C = {{"TearCanopy", 1},},},},},
        },
        HeadLights = {
            {Transition = {"Any", "Off"},     Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 427, "to", 0.0, "speed", 0.333}, {"Arg", 419, "to", 0.0, "speed", 0.333},},},},},
            {Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 427, "to", 1.0, "speed", 0.333}, {"Arg", 419, "to", 1.0, "speed", 0.333},},},},},
            {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 427, "to", 1.0, "speed", 0.333}, {"Arg", 419, "to", 1.0, "speed", 0.333},},},},},
        },
        HeadLight0 = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 427, "to", 0.0, "speed", 0.333},},},},},
            {Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 427, "to", 1.0, "speed", 0.333},},},},},
        },
        HeadLight1 = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 419, "to", 0.0, "speed", 0.333},},},},},
            {Transition = {"Any", "Extend"},  Sequence = {{C = {{"Arg", 419, "to", 1.0, "speed", 0.333},},},},},
        },
    },
---------------------------------------------------------------------------------------------------------------------------------------------
	fires_pos = 
		{
			[1] = 	{ 0.39,		 0.826,	   0.0},	-- Fuselage					10 - fuselage right
			[2] = 	{ 0.274,	-0.409,	 2.643},	-- Wing inner Right--done
			[3] = 	{ 0.226,	-0.388,	-2.732},	-- Wing inner Left--done
			[4] = 	{ 0.523,	 -0.12,	 3.663},	-- Wing middle Right---done
			[5] = 	{ 0.418,	-0.079,	 -4.17},	-- Wing middle Left--done
			[6] = 	{ 0.419,	-0.101,	 5.029},	-- Wing outer Right
			[7] = 	{ 0.418,	-0.079,	-4.993},	-- Wing outer Left
			[8] = 	{-3.637,	-0.157,	   0.0},	-- Engine (inner Right)
			[9] = 	{-3.637,	-0.157,	   0.0},	-- Engine (inner Left)
					-- y   ,       z   ,  x 3dmax--
		}, -- end of fires_pos

	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/C-101_overwingVapor.lua"},
	},
---------------------------------------------------------------------------------------------------------------------------------------------	
	
	-- Countermeasures
	SingleChargeTotal	 	= 0,
	CMDS_Incrementation 	= 1,
	ChaffDefault 			= 0, 
	ChaffChargeSize 		= 1,
	FlareDefault 			= 0, 
	FlareChargeSize 		= 1,
	CMDS_Edit 				= false,
	chaff_flare_dispenser 	= {
	}, -- end of chaff_flare_dispenser
---------------------------------------------------------------------------------------------------------------------------------------------
	--sensors
	
	detection_range_max		 = 30,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = {
		azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation = {-50.0, 90.0} -- pilot view vertical (AI)
	},
	Sensors = {
	},
	HumanRadio = {
		frequency = 225.000,  -- Radio Freq
		editable = true,
		minFrequency = 225.000,
		maxFrequency = 399.975,
		modulation = MODULATION_AM
	},
	
		panelRadio = {
        [1] = {  
            name = _("AN/ARC-164"),
            range = {min = 225.0, max = 399.975},
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
                [18] = { name = _("Channel 18"), default = 271.0, modulation = _("AM")},
				[19] = { name = _("Channel 19"), default = 275.0, modulation = _("AM")},
				[20] = { name = _("Channel 20"), default = 285.0, modulation = _("AM")},
            }			
        },
    },	
---------------------------------------------------------------------------------------------------------------------------------------------	
	Pylons =     {

        pylon(1, 0, -4.755, -0.156, 0.144,
            { 	arg = 316 ,arg_value = 0,
				use_full_connector_position = true, 
			},
            {
				{ CLSID = "{SMOKE-SYSTEM-AVIOJET}", arg = 316 ,arg_value = 1},--Sorbciya
            }
	),
        pylon(2, 0, -4.755, -0.156, 0.144,
            { 	arg = 317 ,arg_value = 0,
				use_full_connector_position = true, 
			},
            {
				{ CLSID	= "{SMOKE-RED-AVIOJET}",  arg = 317 ,arg_value = 1, required =  {{station = 1,loadout = {"{SMOKE-SYSTEM-AVIOJET}"}}}},--Sorbciya
				{ CLSID	= "{SMOKE-YELLOW-AVIOJET}", arg = 317 ,arg_value = 1, required = {{station = 1,loadout = {"{SMOKE-SYSTEM-AVIOJET}"}}}},--Sorbciya				
            }
	),
    },
---------------------------------------------------------------------------------------------------------------------------------------------	
	Tasks = {
        -- aircraft_task(GroundAttack),
        -- aircraft_task(RunwayAttack),
        -- aircraft_task(PinpointStrike),
        -- aircraft_task(CAS),
        aircraft_task(AFAC),
		-- aircraft_task(CAP),
        -- aircraft_task(Escort),
        -- aircraft_task(FighterSweep),
        -- aircraft_task(Intercept),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(Reconnaissance),
---------------------------------------------------------------------------------------------------------------------------------------------	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0			= 0.0,		-- zero AoA lift coefficient
			Mzalfa		= 5.0,		-- coefficients for pitch agility 5.0
			Mzalfadt 	= 1.0,		-- coefficients for pitch agility
			kjx			= 2.25,		-- affects roll inertia - smaller = massive inertia
			kjz 		= 0.00125,	-- affects pitch inertia
			Czbe 		= -0.016,	-- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear 	= 0.12,		-- coefficient, drag, gear
			cx_flap 	= 0.05,		-- coefficient, drag, full flaps
			cy_flap 	= 0.18,		-- coefficient, normal force, lift, flaps 0.12
			cx_brk 		= 0.06,		-- coefficient, drag, air brake
			table_data 	= {
			--      	M	Cx0	Cya	B	B4	      Omxmax	Aldop		Cymax

					{0.0,	0.012,	0.10,	0.04,	0.03,		1.0,	14,		1.0,	},
					{0.1,	0.012,	0.11,	0.04,	0.03,		1.5,	14,		1.3,    },
					{0.2,	0.013,	0.12,	0.04,	0.03,		2.3,	14,		1.3,    },
					{0.3,	0.014,	0.11,	0.04,	0.03,		2.6,	14,		1.3,    },
					{0.4,	0.0145,	0.10,	0.04,	0.03,		2.6,	14,		1.4,    },
					{0.5,	0.015,	0.09,	0.04,	0.03,		2.3,	14,		1.5,    },
					{0.6,	0.015,	0.08,	0.04,	0.03,		2.3,	14,		1.6,    },
					{0.7,	0.015,	0.07,	0.04,	0.03,		2.3,	14,		1.5,    },
					{0.8,	0.015,	0.06,	0.04,	0.03,		2.3,	14,  	1.4,    }, -- Cx0
					{0.85,	0.015,	0.06,	0.04,	0.03,		2.3,	14,  	1.4,    }, -- 0.030
					{0.9,	0.045,	0.05,	0.04,	0.03,		1.0,	14,		1.4,	}, -- 0.060
					{0.95,	0.085,	0.04,	0.04,	0.03,		-2.0,	14,		1.4,	}, -- 0.060
					{1.0,	0.115,	0.03,	0.04,	0.03,		-1.0,	14,		1.4	}, -- 0.100
			}

			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)

		}, -- end of aerodynamics
---------------------------------------------------------------------------------------------------------------------------------------------		
		engine = 
		{
			type	=	"TurboFan",
			Nmg		=	60.1, --54.5
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			hMaxEng	=	15.0,
			dcx_eng	=	0.0168, -- Affects drag of engine when shutdown
			-- cemax/cefor affect sponginess of elevator/inertia at slow speed
			-- affects available g load apparently
			cemax	=	0.037, -- 0.0037 0.037
			cefor	=	0.037, -- 0.0037 0.037
			-- following affect thrust/max alt
			-- 
			dpdh_m	=	1000, -- affects max alt?
			dpdh_f	=	1000, -- affects thrust?? Apparently makes no diff. between 1000 and 20000
			table_data = 
			{
			--   M			Pmax
				{0.0,		16400.0}, --
				{0.1,		16400.0}, --
				{0.2,		15700.0}, -- 130 KTS = 3650 FT VS. 3800 FT MANUAL
				{0.3,		10200.0}, -- 12800 = 2 mins 40 sec vs. 4 mins
				{0.4,		11500.0}, --24800.0 22800.0 23800.0 21200.0 19500.0 14800.0 11700.0
				{0.5,		14000.0}, --26000.0 23000.0 24000.0 21800.0 19000.0 14700.0 14000.0
				{0.6,		14500.0}, --28200.0 23200.0 24200.0 22400.0 18000.0 14600.0 14500.0 30% (30 mins vs. 40 mins tables)
				{0.7,		14500.0}, --30400.0 23400.0 24400.0 23000.0 17500.0 14500.0 14500.0
				{0.8,		14500.0}, --32600.0 23600.0 24600.0 23600.0 17000.0 14400.0 14500.0
				{0.9,		14500.0}, --34800.0 23800.0 24800.0 24200.0 16000.0 14300.0 14500.0
				{1.0,		14500.0}  --36000.0 24000.0 25000.0 22000.0 15000.0 14200.0 14500.0
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power - kilo Newtons (CC version is 16.4 kN)
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
---------------------------------------------------------------------------------------------------------------------------------------------	
--------------------------------------------Damage Table Reference--------------------------------------------------
	Damage = verbose_to_dmg_properties(
	{
--------------------------------------------------------CREW----------------------------------------------------
		["CREW_1"] 	= {critical_damage = 2, args = {400}},--CREW_1
		["CREW_2"] 	= {critical_damage = 2, args = {401}},--CREW_2
----------------------------------------------------------------------------------------------------------------					
		["NOSE_CENTER"]	= {critical_damage = 3, args = {146}},--NOSE_CENTER
		["NOSE_LEFT_SIDE"]= {critical_damage = 3,args = {150}},-- NOSE_LEFT_SIDE
		["NOSE_RIGHT_SIDE"]	= {critical_damage = 3, args = {151}, deps_cells = {"NOSE_CENTER","NOSE_LEFT_SIDE", "FRONT_GEAR_BOX", "WHEEL_F"}, droppable = true,  droppable_shape = "C-101-oblomok-nose"},-- NOSE_RIGHT_SIDE
		["COCKPIT"]	= {critical_damage = 20,args = {65}, deps_cells = {"CREW_1"}} ,--CABINA FRONT	
		["BLADE_1_CENTER"]= {critical_damage = 20,args = {223}, deps_cells = {"CREW_2"}} ,--CABINA REAR						
		["CABIN_LEFT_SIDE"]	= {critical_damage = 10, args = {224}},--CABIN_LEFT_SIDE
		["CABIN_RIGHT_SIDE"]	= {critical_damage = 10, args = {225}},--CABIN_RIGHT_SIDE
		["CABIN_BOTTOM"]	= {critical_damage = 10, args = {226}},--CABIN_BOTTOM					
		["AIR_BRAKE_R"]	= {critical_damage = 3, args = {227}, droppable = true,  droppable_shape = "C-101-oblomok-airbrake"},--AIR_BRAKE_R
		["AIR_BRAKE_L"]	= {critical_damage = 2, args = {243}, droppable = true,  droppable_shape = "C-101-oblomok-airbrake-1"},--AIR_BRAKE_L					
		["BLADE_1_IN"]	= {critical_damage = 10, args = {228}},--BLADE_1_IN
		["BLADE_1_OUT"]	= {critical_damage = 10, args = {229}},--BLADE_1_OUT
		["FUEL_TANK_LEFT_SIDE"]	= {critical_damage = 10, args = {230}},--FUEL_TANK_LEFT_SIDE
		["FUEL_TANK_RIGHT_SIDE"]= {critical_damage = 10, args = {231}},--FUEL_TANK_RIGHT_SIDE
		["FUSELAGE_RIGHT_SIDE"]	= {critical_damage = 8, args = {232}},--FUSELAGE_RIGHT_SIDE	
		["FUSELAGE_LEFT_SIDE"]	= {critical_damage = 8, args = {233}},--FUSELAGE_LEFT_SIDE
		["FUSELAGE_BOTTOM"]	= {critical_damage = 8, args = {234}},--FUSELAGE_BOTTOM
		["BLADE_6_IN"]	= {critical_damage = 10, args = {235}},--BLADE_6_IN
		["BLADE_6_OUT"]	= {critical_damage = 10, args = {236}},--BLADE_6_OUT
		["MTG_R"]	= {critical_damage = 10, args = {237}},--MTG_R
		["MTG_L"]	= {critical_damage = 10, args = {238}},--MTG_L					

		["ENGINE_L"]	= {critical_damage = 3, args = {167}},--ENGINE_L
		
--------------------------------GEAR---------------------------------------------					
		["FRONT_GEAR_BOX"]	= {critical_damage = 5,args = {241}, deps_cells = {"WHEEL_F"}} ,--FRONT_GEAR_BOX
		["LEFT_GEAR_BOX"]	= {critical_damage = 5,args = {242}, deps_cells = {"WHEEL_L"}} ,--LEFT_GEAR_BOX
		["RIGHT_GEAR_BOX"]	= {critical_damage = 5,args = {244}, deps_cells = {"WHEEL_R"}} ,--RIGHT_GEAR_BOX					
		["WHEEL_F"]	= {critical_damage = 3, args = {134}} ,-- nose wheel
		["WHEEL_L"] = {critical_damage = 3, args = {136}},  -- wheel left ***					
		["WHEEL_R"] = {critical_damage = 3, args = {135}},  -- wheel right ***
--------------------------------TAIL---------------------------------------------
		["TAIL"]	= {critical_damage = 10, args = {239}, deps_cells = {"RUDDER","FIN_L_TOP","FIN_L_BOTTOM","STABILIZER_L_OUT","STABILIZER_L_IN","ELEVATOR_L_OUT","STABILIZER_R_OUT","STABILIZER_R_IN","ELEVATOR_R_OUT"}, droppable = true,  droppable_shape = "C-101-oblomok-tail"},--TAIL
		["STABILIZER_L_OUT"]	= {critical_damage = 4, args = {267}, deps_cells = {"ELEVATOR_L_OUT"}},--STABILIZER_L_OUT
		["STABILIZER_L_IN"]	= {critical_damage = 3, args = {269}, deps_cells = {"STABILIZER_L_OUT"}},--STABILIZER_L_IN
		["ELEVATOR_L_OUT"]	= {critical_damage = 2, args = {270}},--ELEVATOR_L_OUT
		
		["STABILIZER_R_OUT"]	= {critical_damage = 4, args = {271}, deps_cells = {"ELEVATOR_R_OUT"}},--	STABILIZER_R_OUT			
		["STABILIZER_R_IN"]	= {critical_damage = 3, args = {273}, deps_cells = {"STABILIZER_R_OUT"}},--STABILIZER_R_IN ?
		["ELEVATOR_R_OUT"]	= {critical_damage = 2, args = {221}},--ELEVATOR_R_OUT

		["FIN_L_TOP"]	= {critical_damage = 7,	args = {249}},--FIN_L_TOP
		["FIN_L_BOTTOM"]= {critical_damage = 7,	args = {250}, deps_cells = {"FIN_L_TOP","RUDDER"}},--FIN_L_BOTTOM
		["RUDDER"]	    = {critical_damage = 3, args = {252}, droppable = true,  droppable_shape = "C-101-oblomok-rudder"},--RUDDER
--------------------------------WING L--------------------------------
		["WING_L_OUT"] 	 = {critical_damage = 3, args = {253}}, -- WING_L_OUT
		["WING_L_CENTER"]= {critical_damage = 5, args = {254}, deps_cells = {"WING_L_OUT","AILERON_L"}}, -- WING_L_CENTER					
		["WING_L_IN"] 	 = {critical_damage = 10, args = {255}, deps_cells = {"WING_L_CENTER","FLAP_L"}}, -- WING_L_IN
		
--		["PYLON1"] 	= {critical_damage = 2},  -- LEFT WING OUTER PYLON
--		["PYLON2"] 	= {critical_damage = 2},  -- LEFT WING INNER PYLON				

		["AILERON_L"]    = {critical_damage = 3, args = {256}},--AILERON_L 
		["FLAP_L"]	= {critical_damage = 4, args = {257}, droppable = true,  droppable_shape = "C-101-oblomok-flap-L-base"},--FLAP_L					
		
--------------------------------WING R--------------------------------
		["WING_R_OUT"]	= {critical_damage = 3, args = {263}}, -- WING_R_OUT
		["WING_R_CENTER"] 	= {critical_damage = 5, args = {262}, deps_cells = {"WING_R_OUT","AILERON_R"}}, -- WING_R_CENTER
		["WING_R_IN"] 	= {critical_damage = 10, args = {261}, deps_cells = {"WING_R_CENTER","FLAP_R"}}, -- WING_R_IN
		
--		["PYLON3"] 	= {critical_damage = 2},  --   RIGHT WING INNER PYLON
--		["PYLON4"]	= {critical_damage = 2},	-- RIGHT WING OUTER PYLON				

		["AILERON_R"]    = {critical_damage = 3, args = {264}},--AILERON_R 
		["FLAP_R"]	= {critical_damage = 4, args = {265}, droppable = true,  droppable_shape = "C-101-oblomok-flap-R-base"},--FLAP_R						

--------------------------------PWD--------------------------------
		["PWD"]	= {critical_damage = 1, args = {110}},--PWD
--------------------------------GUN--------------------------------
		["GUN"] 	= {critical_damage = 4, args = {402}},--GUN				
	}
	),-- end of Damage	
---------------------------------------------------------------------------------------------------------------------------------------------	
	DamageParts = 
	{  
		[1000 + 35] = "C-101-oblomok-wing-L-base",
		[1000 + 36] = "C-101-oblomok-wing-R-base", 
	},
---------------------------------------------------------------------------------------------------------------------------------------------
	Failures = 
	{
		{ id = "generator_fail", label = _("Generator failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "starter_fail",   label = _("Starter failure"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "batteries_fail", label = _("Batteries failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "inverters_fail", label = _("Inverters failure"),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "inverter1_fail", label = _("Normal inverter failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "inverter2_fail", label = _("Standby inverter failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "engine_flameout_irrecoverable", label = _("Engine flameout without relight"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_flameout_recoverable", label = _("Engine flameout with relight"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_fire", label = _("Engine fire"),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "oil_press_drop", label = _("Oil pressure drop"),    enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "chip_in_oil",    label = _("Chip in oil"),          enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "fuel_leak",      label = _("Fuel leak"),            enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_seized",  label = _("Engine seized"),        enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_antiice_fail", label = _("Engine anti-ice failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "eng_computer_fail", label = _("Engine computer fail (manual mode)"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "hydr_leak",      label = _("Hydraulic leak"),       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "elevator_loss",   label = _("Elevator loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "aileron_loss",   label = _("Aileron loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "rudder_loss",   label = _("Rudder loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_trim_runaway_up", label = _("Pitch trim runaway - Nose up"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "pitch_trim_runaway_down", label = _("Pitch trim runaway - Nose down"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_trim_fail", label = _("Control stick pitch trim switch failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "aileron_trim_fail", label = _("Control stick aileron trim switch failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "airbrake_cutout_microsw_malf", label = _("Airbrake autotrim cutout malfunction"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "LGear_ext_fault", label = _("Left gear extension fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "LGear_ret_fault", label = _("Left gear retraction fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "RGear_ext_fault", label = _("Right gear extension fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "RGear_ret_fault", label = _("Right gear retraction fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "NGear_ext_fault", label = _("Nose gear extension fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "NGear_ret_fault", label = _("Nose gear retraction fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "antiskid_fail", label = _("Antiskid fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flaps_fault", label = _("Flaps fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "explosive_depressurization", label = _("Explosive depressurization"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "pitot_blocked",  label = _("Pitot tube blocked"),   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "static_blocked", label = _("Static port blocked"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitot_heat_fail", label = _("Pitot heat fail"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gs_fail", label = _("ILS receiver GS signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "loc_fail", label = _("ILS receiver LOC signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "vor_fail", label = _("VOR receiver nav signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "tacan_fail", label = _("TACAN receiver nav signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "dme_fail", label = _("DME signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	---------------------------------------------------------------------------------------------------------------------------------------------
	lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_STROBES] = {
                typename = "collection",
                lights = {
                    { -- 0 -- red strobe
                        typename = "argnatostrobelight",  argument = 83,  period = 1.333,  phase_shift = 0.0},
                    },
                },
            [WOLALIGHT_LANDING_LIGHTS] = {
                typename = "collection",
                lights = {
                    [1] = { -- 0 -- left light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-98.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(30.0), angle_min = math.rad(20.0), angle_change_rate = math.rad(45.0 * 0.25),
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-98.0)},
                                proto = lamp_prototypes.LFS_P_27_450, range = 2.0, angle_max = math.rad(180.0), angle_min = math.rad(172.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                                proto = lamp_prototypes.LFS_P_27_450, range = 3.0,
                                movable = true,
                            },
                        },
                    },
                    [2] = { -- 1 -- right light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(-98.0)}, argument = 209,
                                proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(30.0), angle_min = math.rad(20.0), angle_change_rate = math.rad(45.0 * 0.25),
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(-98.0)},
                                proto = lamp_prototypes.LFS_P_27_450, range = 2.0, angle_max = math.rad(180.0), angle_min = math.rad(172.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                                proto = lamp_prototypes.LFS_P_27_450, range = 3.0,
                                movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    [1] = { -- 0 -- left light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-109.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_R_27_250,
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-109.0)},
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.0, angle_max = math.rad(180.0), angle_min = math.rad(172.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 3.0,
                                movable = true,
                            },
                        },
                    },
                    [2] = { -- 1 -- right light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(-109.0)}, argument = 209,
                                proto = lamp_prototypes.LFS_R_27_250,
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(-109.0)},
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.0, angle_max = math.rad(180.0), angle_min = math.rad(172.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 3.0,
                                movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    [1] = { -- 0 -- left assy
                        typename = "collection",
                        lights = {
                            {
                                typename = "argumentlight", argument = 190,
                            },
                            {
                                typename = "Spot", position = {0.376, -0.594, -0.750}, direction = {azimuth = math.rad(-90.0), elevation = math.rad(70.0)},
                                proto = lamp_prototypes.FR_100, angle_max = math.rad(110.0), angle_min = math.rad(28.0), angle_change_rate = math.rad(60.0),
                            },
                        },
                    },
                    [2] = { -- 1 -- right assy
                        typename = "collection",
                        lights = {
                            {
                                typename = "argumentlight", argument = 191,
                            },
                            {
                                typename = "Spot", position = {0.376, -0.594, 0.750}, direction = {azimuth = math.rad(90.0), elevation = math.rad(70.0)},
                                proto = lamp_prototypes.FR_100, angle_max = math.rad(110.0), angle_min = math.rad(28.0), angle_change_rate = math.rad(60.0),
                            },
                        },
                    },
                    [3] = { -- 2 -- tail light
                        typename = "argumentlight", argument = 192,
                    },
                },
            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "argumentlight", argument = 88,
                        --power_up_t = 1.0, cool_down_t = 1.0,
                    },
                },
            },
            [WOLALIGHT_CABIN_NIGHT] = {
                typename = "collection",
                lights = {
					[1] = { -- 0 -- forward cockpit
                        typename = "collection",
                        lights = {
							[1] = { -- 0 -- red flood lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 1010,
									},
									{
										typename = "argumentlight", argument = 1011,
									},
									{
										typename = "argumentlight", argument = 1012,
									},
									{
										typename = "argumentlight", argument = 1013,
									},
									{
										typename = "argumentlight", argument = 1014,
									},
								},
							},
							[2] = { -- 1 -- storm lights
								typename = "collection",
									lights = {
									{
										typename = "argumentlight", argument = 1015,
									},
									{
										typename = "argumentlight", argument = 1016,
									},
								},
							},
							[3] = { -- 2 -- instrument lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 69,
									},
								},
							},
							[4] = { -- 3 -- console lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 970,
									},
								},
							},
                        },
                    },
					[2] = { -- 1 -- rear cockpit
                        typename = "collection",
                        lights = {
							[1] = { -- 0 -- red flood lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 1017,
									},
									{
										typename = "argumentlight", argument = 1018,
									},
									{
										typename = "argumentlight", argument = 1019,
									},
									{
										typename = "argumentlight", argument = 1020,
									},
									{
										typename = "argumentlight", argument = 1021,
									},
								},
							},
							[2] = { -- 1 -- storm lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 1022,
									},
									{
										typename = "argumentlight", argument = 1023,
									},
								},
							},
							[3] = { -- 2 -- instrument lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 519,
									},
								},
							},
							[4] = { -- 3 -- console lights
								typename = "collection",
								lights = {
									{
										typename = "argumentlight", argument = 971,
									},
								},
							},
                        },
                    },
                },
            },
        },
    }, -- end lights_data
	---------------------------------------------------------------------------------------------------------------------------------------------	
	AddPropAircraft = {
		{ id = "SoloFlight" 			, control = 'checkbox' , label = _('Solo Flight')			   , playerOnly = true, defValue = false, weightWhenOn = -80},
		{ id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true, 
		  values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Instructor")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}},
		  defValue  = 1,
		  wCtrl     = 150
		},
		{ id = "MountIFRHood", control = 'checkbox' , label = _('Mount IFR Hood'), playerOnly = true, defValue = false},
		{ id = "NS430allow", control = 'comboList', label = _('NS430 Setup'), playerOnly = true, 
		  values = {{id = 0, dispName = _("Not installed")},
					{id = 1, dispName = _("Forward seat")},
					{id = 2, dispName = _("Rear seat")}},
		  defValue  = 1,
		  wCtrl     = 150
		},
		{ id = "SmokeOnGround" , control = 'checkbox', label = _('Allow Smoke On Ground'), playerOnly = true, defValue = false},
		
	},
}

if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
		C_101[i] = o
   end
end
add_aircraft(C_101)
end

make_aviojet()

	