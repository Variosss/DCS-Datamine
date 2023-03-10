-----------------------------------------------------------------------------------------------
WOLALIGHT_STROBES 		   = 1--must be collection
WOLALIGHT_SPOTS  		   = 2--must be collection
WOLALIGHT_NAVLIGHTS 	   = 3--must be collection
WOLALIGHT_FORMATION_LIGHTS = 4--must be collection
WOLALIGHT_TIPS_LIGHTS      = 5--must be collection
-----------------------------------------------------------------------------------------------

MB_339A =  {
        
	Name 					=   'MB-339A',
	DisplayName				= _('MB-339A'),
	ViewSettings 			= ViewSettings,
	SnapViews	 			= SnapViews,
-----------------------------------------------------------------------------------------------	
	Picture 				= "MB-339A.png",
	Rate 					= 40, -- RewardPoint in Multiplayer
	Shape 					= "MB-339A",
-----------------------------------------------------------------------------------------------	
	shape_table_data 		= 
	{
		{
			file  	 		= 'MB-339A';
			life  	 		= 18; -- lifebar
			vis   	 		= 3; -- visibility gain.
			desrt    		= 'Fighter-2-crush';--'NCPC-7_destr'; -- Name of destroyed object file name
			fire  	 		= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username 		= 'MB-339A';
			index    		=  WSTYPE_PLACEHOLDER;
			classname 		= "lLandPlane";
			positioning 	= "BYNORMAL";
			drawonmap 		= true;
		},
		--[[{
			name 			= "NCPC-7_destr";
			file 			= "NCPC-7_destr";
			fire  			= { 240, 2};
		},]]

	},
	mapclasskey 			= "P0091000025",
	attribute  				= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,"Battleplanes",},	--"Refuelable"
	Categories 				= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
--	WorldID					=    WSTYPE_PLACEHOLDER,        
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_AVERAGE, LOOK_AVERAGE, LOOK_AVERAGE),
----------------- SUSPENSION CODE -------------------------------------

--  convenzione x,y,z   x = forw, y = up,  z = dx

	tand_gear_max 	            				= 0.5236,

	main_gear_pos                               = {-0.652,-1.573,1.250},--{-0.652,-1.331,1.250},
    main_gear_wheel_diameter                    = 0.540,                    --  in m
    main_gear_amortizer_direct_stroke	        = 0,--1.593-1.331, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke         = -0.297,--1.299-1.331, --  up 
	main_gear_amortizer_normal_weight_stroke    = -0.262, --0               

	nose_gear_pos                               = {3.675,-1.471,0.0},--{3.675,-1.338,0.0}, 
    nose_gear_wheel_diameter                    = 0.395,                    --  in m
    nose_gear_amortizer_direct_stroke           = 0,--1.491-1.338, --  down from nose_gear_pos !!!
    nose_gear_amortizer_reversal_stroke         = -0.189, --  up 
    nose_gear_amortizer_normal_weight_stroke    = -0.153,--0.0, 

----------------- END OF SUSPENSION CODE -------------------------------

	AOA_take_off 			    = 0.16, -- AoA in take off (for AI)
	CAS_min 				    = 56,   -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	radar_can_see_ground        = true, -- this should be examined (what is this exactly?)
	range 						= 1015, -- Max range in km (for AI)                   
	thrust_sum_max 				= 1815, -- thrust in kg (44kN)
	thrust_sum_ab 				= 1815, -- thrust inkg (71kN)
	wing_span 					= 10.5, -- wing spain in m
	wing_area 					= 19.5, -- wing area in m2
	wing_tip_pos 				= {-0.522, -0.039,	-5.172}, -- wingtip coords for visual effects
	wing_type 					= 0,
	IR_emission_coeff 			= 0.2,  -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0,    -- With afterburner    
	M_empty 					= 3125+85, -- kg
	M_fuel_max 					= 626, --1154, -- kg --2225
	M_max 						= 5900, -- kg
	M_nominal 					= 4400, -- kg
	Mach_max                    = 0.8,  -- Max speed in Mach (for AI)
    MaxHeight                   = 11000,
    MaxSpeed                    = 500,
    MaxTakeOffWeight            = 5900,
	Ny_max 						= 8.0,  -- Max G (for AI)
	Ny_max_e 					= 8.0,  -- Max G (for AI)
	Ny_min 						= -4,   -- Min G (for AI)
	RCS 						= 1.5,  -- Radar Cross Section m2    

	H_max 					 	= 11000, -- m
	V_land 						= 50,   -- Land speed in m/s (for AI)
	V_max_h 					= 212,  -- Max speed at max altitude in m/s (for AI)
	V_max_sea_level 			= 250,  -- Max speed at sea level in m/s (for AI)
	V_opt 						= 125,  -- Cruise speed (for AI)
	V_take_off 					= 53,   -- Take off speed in m/s (for AI)
	Vy_max 						= 22,   -- Max climb speed in m/s (for AI)

	average_fuel_consumption 	= 0.333, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	bank_angle_max 				= 60,   -- Max bank angle (for AI)

	brakeshute_name 			= 0,    -- Landing - brake chute visual shape after separation
	detection_range_max	        = 60,
	engines_count				= 1,    -- Engines count    
	flaps_maneuver 				= 0.5,  -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
    has_afteburner 				= false, -- AFB yes/no
	has_differential_stabilizer	= false, -- differential stabilizers
	has_speedbrake 				= true, -- Speedbrake yes/no
	height 						= 4.77, -- height in m
	length 						= 12.13, -- full lenght in m	
	bigParkingRamp				= false,
	is_tanker 					= false, -- Tanker yes/no
	--tanker_type 				= 0,    -- Tanker type if the plane is airrefuel capable  
	--air_refuel_receptacle_pos = {0, 0, 0}, -- refuel coords
--------------------------------------------------------------------------------------------------------------------

	crew_size	 = 2,	
	crew_members = 
	{
-- FRONT SEAT
		[1] = 
		{
			ejection_through_canopy = true, --no openbeta usare mechanimations
			ejection_seat_name = "pilot_mb339_seat_F", --arg0: frame 0~10 seat+pilota, 10~100 solo seat
			pilot_name  = "pilot_c-101_01", --modello richiamato dopo separazione seggiolino 
			drop_canopy_name = 0, --nessun tettuccio da espellere
			drop_parachute_name =  "pilot_f15_parachute",			
			pos =  {2.4-0.15,0.25,0}, --posizionamento seggiolino (centro assi)
			canopy_pos = {2,0.5,0},
			ejection_play_arg = 50+1000, --rottura vetro
			pilot_body_arg = 50, -- frame 0~50:pilota+seggiolino, 50~99:solo seggiolino, 100: asta espulsione
			can_be_playable = true,
			canopy_args = {38,0.8}, --da disabilitare con ejection_through_canopy
			ejection_added_speed = {-4.5,15,0.4}, --X,Y,Z metri: direzione espulsione(determina punto di caduta)
			ejection_order 		 = 2,			
			role 				 = "pilot",
			role_display_name    = _("Pilot"),	
			g_suit 			   =  1,
			bailout_arg = -1, --abilitare su openbeta con mechanimations
			
		}, -- end of [1]

-- BACK SEAT		
	[2] = 
		{
			ejection_through_canopy = true,
			ejection_seat_name = "pilot_mb339_seat_B",
			pilot_name = "pilot_c-101_02",			
			drop_canopy_name = 0,
			drop_parachute_name =  "pilot_f15_parachute",			
			pos =  {0.9-0.15,0.5,0},
			canopy_pos = {2,0.5,0},
			ejection_added_speed = {-4,14.5,-0.4},
			ejection_play_arg = 472+1000,			
			can_be_playable = true,
			canopy_args = {38,0.8},
			pilot_body_arg		= 472,
			ejection_order 		= 1,			
			role 				 = "instructor",
			role_display_name    = _("Instructor pilot"),
			g_suit 			   =  1,
			bailout_arg = -1,

		}, -- end of crew_members
	},

--    mechanimations openbeta ok
   	mechanimations = {
        Door0 = {
			{Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.9, "in", 2.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 2.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0}}}, {C = {{"Sleep", "for", 0.275}}}, {C = {{"Arg", 1050, "set", 1.0}}}}},
			--{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0}, {"Arg", 1050, "set", 1.0},},},},},
        },
		Door1 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.9, "in", 2.0}}}}, Flags = {"Reversible"}},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 2.0}}}}, Flags = {"Reversible", "StepsBackwards"}},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 1}}}, {C = {{"Sleep", "for", 0.275}}}, {C = {{"Arg", 1472, "set", 1.0}}}}},
        },
    }, -- end of mechanimations

--------------------------------------------------------------------------------------------------------------------    
	net_animation               =  {38,     --	Canopy Ext        						-- 2
                                    190,    --	non usato Posizione Rossa Ala Sx        -- 3
                                    191,    --	Posizione Verde Ala Dx e Sx             -- 4
                                    192,    --	Luce sul Timone                         -- 5
                                    203,    --	Luce sulla Coda                         -- 6
                                    202,	--	Luce sulla Gobba                        -- 7
                                    201,	--	Luce sulla Pancia                       -- 8
									208,    --	Luce Sul Carrello                       -- 9
									200,	--	Luci di Formazione                      -- 10
                                    477,	--	Collimatore                             -- 11
									1003,	--	HaangLoose								-- 12
									525,	--	Nav Light e visibilità Tip              -- 13
									526,	--	Form Light Su Tank Ellittiche           -- 14
									527,	--	Form Light Su Tank Cilindriche          -- 15
									39,     --	Pilot Front L/R                         -- 16
									99,     --	Pilot Front Up/Down                     -- 1
									337,     --	Pilot Back L/R                      	-- 17
									399,     --	Pilot Back Up/Down                      -- 18
									480,	--  Rotazione LDG LT semiala sx				-- 19
									524,	--	Nav Light e visibilità Tip              -- 
									},                                                                                                     
--------------------------------------------------------------------------------------------------------------------                                    
	


	engines_nozzles = {
		[1] = 
		{
			pos 		        = {-7.5, 0, 0}, -- nozzle coords
			elevation           = 0,                -- AFB cone elevation
			diameter	        = 0.2,                -- AFB cone diameter
			exhaust_length_ab   = 0.2,                -- lenght in m
			exhaust_length_ab_K = 0.4,             -- AB animation
			smokiness_level 	= 0.0
		},  -- end of [1]
	},      -- end of engines_nozzles


    fires_pos = -- Agg. 20/06/2020
		{ 
        [1] = {-0.5,	 0.5, 		0}, -- Fuselage Fuel Tank
        [2] = {-0.7, 	-0.40,	 1.25}, -- Wing R In
        [3] = {-0.7, 	-0.40,	-1.25}, -- Wing L In
        [4] = {-0.9, 	-0.3,	 3.15}, -- Wing R Center
        [5] = {-0.9, 	-0.3,	-3.15}, -- Wing L Center
        [6] = {-1.10, 	-0.20,	 5.02}, -- Wing R Out
        [7] = {-1.10, 	-0.20,	-5.02}, -- Wing L Out
        [8] = {-6.35,	-0.21,		0}, -- Engine R In (eng2)
        [9] = {-6.35,	-0.21,		0}, -- Engine L In (eng1)
        [10] = {-6.35,	-0.21,		0}, -- Engine R Out (eng4)
        [11] = {-6.35,	-0.21,		0} -- Engine L Out (eng3)
		},

	effects_presets = {
		{effect = "JET_ENGINE_STARTUP_BLAST", preset = "F18", scale = 1.0, ttl = 5.0},
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/MB339_overwingVapor.lua", preset = "MB339_Overwing_Vapour"},
	},

    Sensors = {
    },

    HumanRadio = {
        frequency     = 124.0, -- onboard radio, default DCSW frequency
        editable     = true,
        minFrequency     = 30.000,
        maxFrequency     = 399.975,
		modulation		 = MODULATION_AM,
		rangeFrequency = {
			{min = 30.0,  max = 87.975},
			{min = 108.0, max = 173.975},
			{min = 225.0, max = 399.975},
		},
    },
	
	panelRadio = {
        [1] = {
            name = _("AN/ARC-150(V)-2"), --UHF
            range = {
                {min = 225.0, max = 399.975}
            },
            channels = {
                [1] = { name = _("Channel 1"), default = 317.5, modulation = _("AM")}, -- default
                [2] = { name = _("Channel 2"), default = 257.8, modulation = _("AM")},
                [3] = { name = _("Channel 3"), default = 385.4, modulation = _("AM")},
                [4] = { name = _("Channel 4"), default = 344.0, modulation = _("AM")},
                [5] = { name = _("Channel 5"), default = 362.3, modulation = _("AM")},
                [6] = { name = _("Channel 6"), default = 340.3, modulation = _("AM")},
                [7] = { name = _("Channel 7"), default = 364.2, modulation = _("AM")},
                [8] = { name = _("Channel 8"), default = 267.15, modulation = _("AM")},
                [9] = { name = _("Channel 9"), default = 369.5, modulation = _("AM")},
                [10] = { name = _("Channel 10"), default = 279.4, modulation = _("AM")},
                [11] = { name = _("Channel 11"), default = 337.95, modulation = _("AM")},
                [12] = { name = _("Channel 12"), default = 292.7, modulation = _("AM")},
                [13] = { name = _("Channel 13"), default = 344.5, modulation = _("AM")},
                [14] = { name = _("Channel 14"), default = 315.7, modulation = _("AM")},
                [15] = { name = _("Channel 15"), default = 370.15, modulation = _("AM")},
                [16] = { name = _("Channel 16"), default = 338.825, modulation = _("AM")},
                [17] = { name = _("Channel 17"), default = 360.775, modulation = _("AM")},
                [18] = { name = _("Channel 18"), default = 307.8, modulation = _("AM")},
                [19] = { name = _("Channel 19"), default = 261.0, modulation = _("AM")},
                [20] = { name = _("Channel 20"), default = 291.15, modulation = _("AM")},
            }
        },
		[2] = {
            name = _("SRT-651/N"), --VHF/UHF
            range = {{min = 30.0, max = 87.975},
					 {min = 108.0, max = 117.975},
					 {min = 118.0, max = 136.9917},
					 {min = 137.0, max = 155.975},
					 {min = 225.0, max = 399.975}},
            channels = {
                [1] = { name = _("Channel 0"), default = 225.0},
                [2] = { name = _("Channel 1"), default = 258.0},
                [3] = { name = _("Channel 2"), default = 260.0},
                [4] = { name = _("Channel 3"), default = 270.0},
                [5] = { name = _("Channel 4"), default = 255.0},
                [6] = { name = _("Channel 5"), default = 259.0},
                [7] = { name = _("Channel 6"), default = 262.0},
                [8] = { name = _("Channel 7"), default = 257.0},
                [9] = { name = _("Channel 8"), default = 253.0},
                [10] = { name = _("Channel 9"), default = 263.0},
                [11] = { name = _("Channel 10"), default = 267.0},
                [12] = { name = _("Channel 11"), default = 254.0},
                [13] = { name = _("Channel 12"), default = 264.0},
                [14] = { name = _("Channel 13"), default = 266.0},
                [15] = { name = _("Channel 14"), default = 265.0},
                [16] = { name = _("Channel 15"), default = 252.0},
                [17] = { name = _("Channel 16"), default = 268.0},
                [18] = { name = _("Channel 17"), default = 269.0},
                [19] = { name = _("Channel 18"), default = 268.0},
                [20] = { name = _("Channel 19"), default = 269.0},
                [21] = { name = _("Channel 20"), default = 225.0},
                [22] = { name = _("Channel 21"), default = 258.0},
                [23] = { name = _("Channel 22"), default = 260.0},
                [24] = { name = _("Channel 23"), default = 270.0},
                [25] = { name = _("Channel 24"), default = 255.0},
                [26] = { name = _("Channel 25"), default = 259.0},
                [27] = { name = _("Channel 26"), default = 262.0},
                [28] = { name = _("Channel 27"), default = 257.0},
                [29] = { name = _("Channel 28"), default = 253.0},
                [30] = { name = _("Channel 29"), default = 263.0},
            }
        },
    },
	
--------------------- WEAPONS STATIONS -----------------------------------------------

	Pylons =     {			-- 3DS: x,z,y  x=Forward -x=Back z=Up -z=Down y=Sx -yDx


        pylon(1, 0, -0.905, -0.201, -5.11,			
            {
				use_full_connector_position=true,
				connector 		= "TIP_SX",
				DisplayName 	= "TT", 
				arg				= 524,
				arg_value		= 0,
            },
            {
				{ CLSID	= "{FUEL-TIP-TANK-500-L}", required ={{station =10, loadout={"{FUEL-TIP-TANK-500-R}"}}},	arg_value = 0.6},
				{ CLSID	= "{FUEL-TIP-ELLITTIC-L}", required ={{station =10, loadout={"{FUEL-TIP-ELLITTIC-R}"}}},	arg_value = 0.3},			   
            }                                                                          
        ),
	
		pylon(2, 0, -0.611, -0.509, -4.281,
            {
				use_full_connector_position=true,
				connector 		= "Pylon1",				
				DisplayName 	= "1",
				arg				= 314,
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            { --pyl outer max allowed weight: 750lbs - 340kgs
				{CLSID = "<CLEAN>", arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
                {CLSID = "{14_3_M2_6xBAP100}",						required ={{station =9, loadout={"{14_3_M2_6xBAP100}"}}},						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =9, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120				
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =9, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}",						required ={{station =9, loadout={"{LR25_ARF8M3_API}"}}},						arg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =9, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =9, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81					
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =9, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82	
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =9, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82 SE
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =9, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =9, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =9, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =9, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B	
				{CLSID = "{BLU107B_DURANDAL}",						required ={{station =9, loadout={"{BLU107B_DURANDAL}"}}},						arg_value = 0.35},	-- BLU-107B DURANDAL
				{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =9, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755 
				{CLSID = "{BLG66_BELOUGA_AC}",	attach_point_position = {0.1, -0.01, 0}, required ={{station =9, loadout={"{BLG66_BELOUGA_AC}"}}},  arg_value = 0.1},	-- BLG-66 BELUGA					
				
			}
        ),

		pylon(3, 0, -0.474, -0.557, -3.542,  
            {
				use_full_connector_position=true,
				connector 		= "Pylon2",
				DisplayName 	= "2",
				arg				= 309,
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            {--pyl center max allowed weight: 1000lbs - 454kgs
				{CLSID = "<CLEAN>", arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
                {CLSID = "{FUEL-SUBAL_TANK-330}", 					required ={{station =8, loadout={"{FUEL-SUBAL_TANK-330}"}}},					arg_value = 0.4},	-- FUEL TANK
                {CLSID = "{14_3_M2_6xBAP100}", 						required ={{station =8, loadout={"{14_3_M2_6xBAP100}"}}},  						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =8, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120				
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =8, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}", 						required ={{station =8, loadout={"{LR25_ARF8M3_API}"}}},						arg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =8, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =8, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =8, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82	
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =8, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82SE	
				{CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",	required ={{station =8, loadout={"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}}},	arg_value = 0.01},	-- MK83
				{CLSID = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",	required ={{station =8, loadout={"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}}},	arg_value = 0.2},	-- LAU-10	
				{CLSID = "{BRD_4_250_4xMK76}", 																										arg_value = 0.3},	-- BRD-4-250 Mk-76
				{CLSID = "{BRD_4_250_4xMK106}", 																									arg_value = 0.3},	-- BRD-4-250 Mk-106
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =8, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =8, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =8, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =8, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B	
				{CLSID = "{BLU107B_DURANDAL}",						required ={{station =8, loadout={"{BLU107B_DURANDAL}"}}},						arg_value = 0.35},	-- BLU-107B DURANDAL
				{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =8, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755 
				{CLSID = "{BLG66_BELOUGA_AC}",	attach_point_position = {0.1, -0.01, 0}, required ={{station =8, loadout={"{BLG66_BELOUGA_AC}"}}},  arg_value = 0.1},	-- BLG-66 BELUGA					
            }
        ),

		pylon(4, 0, -0.423, -0.606, -2.799,
            {
				use_full_connector_position=true,
				connector 		= "Pylon3",
				DisplayName 	= "3",
				arg				= 310,
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            {--pyl inner max allowed weight: 1000lbs - 454kgs
				{CLSID = "<CLEAN>", 								arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
                {CLSID = "{14_3_M2_6xBAP100}",						required ={{station =7, loadout={"{14_3_M2_6xBAP100}"}}}, 						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =7, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120				
				{CLSID = "{MB339_TRAVELPOD}",						arg_value = 0.5},	--libero					
				{CLSID = "{MB339_VINTEN}",							arg_value = 1}, --pOD FOTO può essere abbinato ad an-m3 su semiala dx
				{CLSID = "{MB339_ANM3_L}",							required ={{station =7, loadout={"{MB339_ANM3_R}"}}},  							arg_value = 1}, 	-- Gun Pod AN-M3
				{CLSID = "{MB339_DEFA553_L}",						required ={{station =7, loadout={"{MB339_DEFA553_R}"}}},						arg_value = 1}, 	-- Gun Pod DEFA 553
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =7, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}",						required ={{station =7, loadout={"{LR25_ARF8M3_API}"}}},						arg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =7, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =7, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =7, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =7, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82 SE
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =7, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =7, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =7, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =7, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B					
				--{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =7, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755	
            }
		),

		pylon(5, 0, -8.0, 0.05, 0,
            {
				use_full_connector_position=true,
                connector 		= "SmokeColor",
				DisplayName 	= "-X-",
            },
            {			
            }
        ),

		pylon(6, 0, -8.0, 0.05, 0,
            {
				use_full_connector_position=true,
                connector 		= "SmokeWhite",
				DisplayName 	= "-X-",
            },
            {
            }
        ),

		
		pylon(7, 0, -0.423, -0.606, 2.799,
            {
				use_full_connector_position=true,
				connector 		= "Pylon5",
				DisplayName 	= "4", 				
				arg				= 312,
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            {
				{CLSID = "<CLEAN>", arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
                {CLSID = "{14_3_M2_6xBAP100}",						required ={{station =4, loadout={"{14_3_M2_6xBAP100}"}}},  						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =4, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120				
				{CLSID = "{MB339_TRAVELPOD}",						arg_value = 0.5}, --libero
				{CLSID = "{MB339_ANM3_R}",							arg_value = 1}, 	-- Gun Pod AN-M3 (si può abbinare a vinten opposto)
				{CLSID = "{MB339_DEFA553_R}",						required ={{station =4, loadout={"{MB339_DEFA553_L}"}}},						arg_value = 1}, 	-- Gun Pod DEFA 553
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =4, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}",						required ={{station =4, loadout={"{LR25_ARF8M3_API}"}}},						arg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =4, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =4, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =4, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82	
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =4, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82 SE			
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =4, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =4, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =4, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =4, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B	
				--{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =4, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755
			}
        ),

		pylon(8, 0, -0.474, -0.557, 3.542,
            {
				use_full_connector_position=true,
				connector 		= "Pylon6",
				DisplayName 	= "5",
				arg				= 313,
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            {
				{CLSID = "<CLEAN>", arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
                {CLSID = "{FUEL-SUBAL_TANK-330}",					required ={{station =3, loadout={"{FUEL-SUBAL_TANK-330}"}}},					arg_value = 0.4},	-- FUEL TANK
                {CLSID = "{14_3_M2_6xBAP100}",						required ={{station =3, loadout={"{14_3_M2_6xBAP100}"}}},						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =3, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120				
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =3, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}",						required ={{station =3, loadout={"{LR25_ARF8M3_API}"}}},						rg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =3, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =3, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =3, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =3, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82 SE
				{CLSID = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",	required ={{station =3, loadout={"{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}"}}},	arg_value = 0.01},	-- MK83
				{CLSID = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",  required ={{station =3, loadout={"{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}"}}},	arg_value = 0.2}, 	-- LAU-10
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =3, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =3, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =3, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =3, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B					
				{CLSID = "{BRD_4_250_4xMK76}", 																										arg_value = 0.3},	-- BRD-4-250 Mk-76
				{CLSID = "{BRD_4_250_4xMK106}", 																									arg_value = 0.3},	-- BRD-4-250 Mk-106
				{CLSID = "{BLU107B_DURANDAL}",						required ={{station =3, loadout={"{BLU107B_DURANDAL}"}}},						arg_value = 0.35},	-- BLU-107B DURANDAL
				{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =3, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755
				{CLSID = "{BLG66_BELOUGA_AC}",	attach_point_position = {0.1, -0.01, 0}, required ={{station =3, loadout={"{BLG66_BELOUGA_AC}"}}},  arg_value = 0.1},	-- BLG-66 BELUGA 				
			}
        ),

		pylon(9, 0, -0.611, -0.509, 4.281,
            {
				use_full_connector_position=true,
				connector 		= "Pylon7",				
				DisplayName 	= "6",
				arg				= 315,				
				arg_value		= 0,--1,
				--mass=23, --included in total weight
            },
            {
				{CLSID = "<CLEAN>", arg_value = 1, add_mass = -23, cx_gain = -0.0003 },  --NO PYLON
				{CLSID = "{14_3_M2_6xBAP100}",						required ={{station =2, loadout={"{14_3_M2_6xBAP100}"}}},						arg_value = 0.0},	-- 6XBAP100
				{CLSID = "{14_3_M2_6xBAT120}",						required ={{station =2, loadout={"{14_3_M2_6xBAT120}"}}},						arg_value = 0.0},	-- 6XBAT120
				{CLSID = "{LR25_ARF8M3_HEI}",						required ={{station =2, loadout={"{LR25_ARF8M3_HEI}"}}},						arg_value = 0.3},	-- LR-25 HEI ROCKET POD	
				{CLSID = "{LR25_ARF8M3_API}",						required ={{station =2, loadout={"{LR25_ARF8M3_API}"}}},						arg_value = 0.3},	-- LR-25 API ROCKET POD
				{CLSID = "{LR25_ARF8M3_TPSM}",						required ={{station =2, loadout={"{LR25_ARF8M3_TPSM}"}}},						arg_value = 0.3},	-- LR-25 TPSM ROCKET POD
				{CLSID = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",	required ={{station =2, loadout={"{90321C8E-7ED1-47D4-A160-E074D5ABD902}"}}},	arg_value = 0.9},	-- MK81				
				{CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",	required ={{station =2, loadout={"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}},	arg_value = 0.6},	-- MK82
				{CLSID = "{Mk82SNAKEYE}",							required ={{station =2, loadout={"{Mk82SNAKEYE}"}}},							arg_value = 0.6},	-- MK82 SE
				{CLSID = "{Matra155RocketPod}",	attach_point_position = {0, -0.01, 0}, required ={{station =2, loadout={"{Matra155RocketPod}"}}},	arg_value = 0.05},  -- MATRA 155
				{CLSID = "LAU3_WP156",								required ={{station =2, loadout={"LAU3_WP156"}}}, 								arg_value = 0.3},	-- LAU3_WP156	
				{CLSID = "LAU3_HE151",								required ={{station =2, loadout={"LAU3_HE151"}}}, 								arg_value = 0.3},	-- LAU3_HE151
				{CLSID = "LAU3_WP1B",								required ={{station =2, loadout={"LAU3_WP1B"}}}, 								arg_value = 0.3},	-- LAU3_WP1B
				{CLSID = "{BLU107B_DURANDAL}",						required ={{station =2, loadout={"{BLU107B_DURANDAL}"}}},						arg_value = 0.35},	-- BLU-107B DURANDAL
				{CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}",	required ={{station =2, loadout={"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}},   arg_value = 0.1},	-- BL-755
				{CLSID = "{BLG66_BELOUGA_AC}",	attach_point_position = {0.1, -0.01, 0}, required ={{station =2, loadout={"{BLG66_BELOUGA_AC}"}}},  arg_value = 0.1},	-- BLG-66 BELUGA				
            }
        ),
		
		pylon(10, 0, -0.905, -0.201, 5.11,
            {
				use_full_connector_position=true,
				connector 		= "TIP_DX",
				DisplayName 	= "TT",
				arg				= 525,				
				arg_value		= 0,
            },
            {
				{ CLSID	= "{FUEL-TIP-TANK-500-R}",	required ={{station =1, loadout={"{FUEL-TIP-TANK-500-L}"}}},	arg_value = 0.6},
				{ CLSID	= "{FUEL-TIP-ELLITTIC-R}",	required ={{station =1, loadout={"{FUEL-TIP-ELLITTIC-L}"}}},	arg_value = 0.3},			   
            }
        ),		
		
    },

------------------ END OF WEAPONS STATIONS -------------------------------	

	Tasks = {
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
		aircraft_task(CAS),
		aircraft_task(AntishipStrike),
		aircraft_task(Reconnaissance),
		aircraft_task(Transport),			
    },	
	DefaultTask = aircraft_task(CAS),

------------------SFM + ENGINE AI---------------------------------------------------------	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0				=	0.045,
			Mzalfa			=	6.6,
			Mzalfadt		=	2.5,
			kjx 			= 	3.5,
			kjz 			= 	0.00125,
			Czbe 			= 	-0.008,
			cx_gear 		= 	0.065,
			cx_flap 		= 	0.087,
			cy_flap 		= 	0.38,
			cx_brk 			= 	0.065,
			table_data =
			{ 
			--      M		Cx0 	Cya			 B		 	B4			Omxmax		Aldop		Cymax                       -- Cx0 Originale	-- Cx0 - Pylon	
            --
				[1 ] =	{0.0,	0.0170, 	0.100,		0.060,		0.020,		0.824,		12,			1.2,		},              -- 0.0170,          -- 0.012,	
				[2 ] =	{0.1,	0.0175, 	0.100,		0.060,		0.020,		1.330,		12,			1.2,		},              -- 0.0200,          -- 0.015,	
				[3 ] =	{0.2,	0.0185,  	0.100,		0.060,		0.020,		1.878,		12,			1.225,		},              -- 0.0235,          -- 0.0185,
				[4 ] =	{0.3,	0.0200, 	0.100,		0.065,		0.020,		2.434,		12,			1.255,		},              -- 0.0240,          -- 0.019,	
				[5 ] =	{0.4,	0.0210, 	0.100,		0.070,		0.020,		2.656,		12,			1.270,		},              -- 0.0250,          -- 0.02,	
				[6 ] =	{0.5,	0.0210, 	0.100,		0.080,		0.020,		2.688,		10.2,		1.275,		},              -- 0.0280,          -- 0.023,	
				[7 ] =	{0.55,	0.0210,  	0.100,		0.090,		0.020,		2.688,		9.7,		1.255,		},              -- 0.0308,          -- 0.0258,
				[8 ] =	{0.6,	0.0210, 	0.090,		0.090,		0.020,		2.675,		9.2,		1.220,		},              -- 0.0308,          -- 0.0258,
				[9 ] =	{0.7,	0.0220, 	0.090,		0.097,		0.026,		2.592,		7,			0.857,		},              -- 0.0310,          -- 0.026,	
				[10] =	{0.8,	0.0250,		0.070,		0.180,		0.036,		2.486,		3.9,  		0.85,		},              -- 0.0312,          -- 0.0262,
				[11] =	{0.9,	0.0290,		0.070,		0.270,		0.049,		2.304,		3.55,  		0.75,		},              -- 0.0322,          -- 0.0272,
				[12] =	{1.0,	0.0555,		0.070,		0.500,		0.060,		1.997,		3.53,  		0.7,		},              -- 0.0325,          -- 0.0275,
			},   
			-- M   - Mach number
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
			type = "TurboJet",
			Nominal_RPM = 13760.0,
			Startup_Prework = 12.0,
			Startup_Duration = 33.0,
			Startup_Flame_FX_Time = 3.0,
			Shutdown_Duration = 40.0,
			Nmg				=	40.0,
			MinRUD			=	0,
			MaxRUD			=	1,
			MaksRUD			=	1,
			ForsRUD			=	1,
			typeng			=	0,
			hMaxEng			=	12.5, -- 30.5
			dcx_eng			=	0.0015, --0.0015
			cemax			=	0.37,
			cefor			=	0.37,
			dpdh_m			=	1800,
			dpdh_f			=	1800,
			table_data = 
			{
			--   M			Pmax
				{0.0,       17917.4},
				{0.1,		17823.3},
				{0.2,		17678.3},
				{0.3,		17055.8},
				{0.4,		16342.3},
				{0.5,		15702.2},
				{0.6,		15831.2},
				{0.7,		16120.3},
				{0.8,		16262.7},
				{0.9,	    16382.8},
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB

            extended =
                {
                
                    thrust_max = -- thrust interpolation table by altitude and mach number, 2d table
                        { -- Minimum thrust 2000 kN, maximum thrust 16700 kN
                            M 		 = {0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9},
                            H		 = {0,3048,6096,9144,10500,12192},
                            thrust	 = {-- M 0         0.1      0.2      0.3      0.4     0.5     0.6     0.7      0.8      0.9
                                        {    17793,   17126,   16458,   16192,   16425,  16469,  16514,  16869,   16925,  17259 },--H = 0 (sea level)
                                        {    14323,   13567,   12811,   12677,   12544,  12633,  12722,  12855,   12989,  13656 },--H = 3048 (10kft)
                                        {    11210,   10409,   9608,    9530,    9452,   9619,   9786,   10053,   10320,  10765 },--H = 6096 (20kft)
                                        {    8429,    7684,    6939,    6928,    6917,   7050,   7184,   7440,    7695,   8062 	},--H = 9144 (30kft)
                                        {    6939,    6294,    5649,    5638,    5627,   5749,   5872,   6094,    6316,   6628 	},--H = 10500 (34kft)
										{    3327,    2782,    2237,    2248,    2260,   2349,   2438,   2627,    2816,   3071 	},--H = 12192 (40kft)
                                        
                            },
                        },
		

                }, -- end of extended data

           
		}, -- end of engine
	},
---------------------------------------------------------------------------
-----------------------------------
--- DAMAGE: fires_pos + Damage + DamageParts + failures (ID)
-----------------------------------
	
		Damage = verbose_to_dmg_properties( --Agg. 30/06/2020
	{
--MUSO
		["NOSE_CENTER"]    		= {critical_damage = 3, args = {146}}, --[0] PUNTA MUSO
		["NOSE_BOTTOM"]			= {critical_damage = 3, args = {148}, deps_cells = {"FRONT_GEAR_BOX"}}, --[59]	
		["NOSE_RIGHT_SIDE"]		= {critical_damage = 3, args = {149}, deps_cells = {"PITOT"}}, --[2]
		["NOSE_LEFT_SIDE"]		= {critical_damage = 3, args = {150}, deps_cells = {"PITOT"}}, --[1]
--CABINA
		["COCKPIT"]			 	= {critical_damage = 7, args = {65}, deps_cells = {"CREW_1", "CREW_2"}}, --[3] vetro windscreen e canopy
		["CREW_1"] 				= {critical_damage = 2, args = {663}}, --[90] pilota fwd
		["ARMOR_PLATE_LEFT"]	= {critical_damage = 5, deps_cells = {"CREW_1"}}, --[96] --seggiolino fwd
		["CREW_2"] 				= {critical_damage = 2, args = {664}}, --[91] pilota aft
		["ARMOR_PLATE_RIGHT"]	= {critical_damage = 5, deps_cells = {"CREW_2"}}, --[97] --seggiolino aft
		["CABIN_BOTTOM"]		= {critical_damage = 3, args = {297}}, --[6]		
		["CABIN_RIGHT_SIDE"]	= {critical_damage = 5, args = {298}}, --[5]		
		["CABIN_LEFT_SIDE"]  	= {critical_damage = 5, args = {299}}, --[4]
--SEMIALA DX
		["WING_R_OUT"]			= {critical_damage = 4,  args = {213}}, --[24]
		["WING_R_CENTER"]		= {critical_damage = 8,  args = {214}, deps_cells = {"AILERON_R", "WING_R_OUT"}}, --[30]		
		["WING_R_IN"]			= {critical_damage = 12, args = {215}, deps_cells = {"WING_R_CENTER", "FLAP_R", "AILERON_R", "WING_R_OUT"}}, --[36]
		["AILERON_R"]			= {critical_damage = 3,  args = {216}, droppable = true,  droppable_shape = "MB-339PAN_OBLOMOK_WING_R"}, --[26]
		["FLAP_R"]				= {critical_damage = 4,  args = {217}, droppable = true,  droppable_shape = "MB-339PAN_OBLOMOK_WING_R"},--[38]
--SEMIALA SX		
		["WING_L_OUT"]			= {critical_damage = 4,  args = {223}}, --[23]
		["WING_L_CENTER"]		= {critical_damage = 8,  args = {224}, deps_cells = {"AILERON_L", "WING_L_OUT"}}, --[29]
		["WING_L_IN"]			= {critical_damage = 12, args = {225}, deps_cells = {"WING_L_CENTER", "FLAP_L", "AILERON_L", "WING_L_OUT"}}, --[35]		
		["AILERON_L"]			= {critical_damage = 3,  args = {226}, droppable = true,  droppable_shape = "MB-339PAN_OBLOMOK_WING_L"}, --[25]
		["FLAP_L"]				= {critical_damage = 4,  args = {227}, droppable = true,  droppable_shape = "MB-339PAN_OBLOMOK_WING_L"}, --[37]
--FUSOLIERA CENTRALE
		["FUSELAGE_BOTTOM"]  	= {critical_damage = 5,  args = {152}, deps_cells = {"AIR_BRAKE_L"}}, --[82]	
		["FUSELAGE_RIGHT_SIDE"]	= {critical_damage = 4,  args = {153}, deps_cells = {"ENGINE"}}, --[10]		
		["FUSELAGE_LEFT_SIDE"]	= {critical_damage = 4,  args = {154}, deps_cells = {"ENGINE"}}, --[9]
		["AIR_BRAKE_L"]			= {critical_damage = 2,  args = {183}}, --[19]		
--DERIVA
		["TAIL_BOTTOM"]			= {critical_damage = 4,  args = {156}}, --[58]
		["TAIL_RIGHT_SIDE"]		= {critical_damage = 4,  args = {157}}, --[57]
		["TAIL_LEFT_SIDE"]		= {critical_damage = 4,  args = {158}}, --[56]
		["TAIL"]				= {critical_damage = 20, args = {159}},	--[55]tailskid

		["STABILIZATOR_R"]		= {critical_damage = 4,  args = {233}, deps_cells = {"ELEVATOR_R", "ELEVATOR_R_OUT"}}, --[48]
		["ELEVATOR_R"]			= {critical_damage = 3,  args = {238}, deps_cells = {"ELEVATOR_R_OUT"}}, --[52]
		["ELEVATOR_R_OUT"]		= {critical_damage = 1,  args = {237}}, --[50] trim elevatore DX
		
		["STABILIZATOR_L"]		= {critical_damage = 4,  args = {235}, deps_cells = {"ELEVATOR_L", "ELEVATOR_L_OUT"}}, --[47]
		["ELEVATOR_L"]			= {critical_damage = 3,  args = {240}, deps_cells = {"ELEVATOR_L_OUT"}}, --[51]
		["ELEVATOR_L_OUT"]		= {critical_damage = 1,  args = {239}},	--[49] trim elevatore SX	

		["FIN_L_TOP"]			= {critical_damage = 5,	 args = {242}, deps_cells = {"RUDDER"}}, --[39]
		["FIN_L_BOTTOM"]		= {critical_damage = 7,	 args = {246}, deps_cells = {"FIN_L_TOP", "RUDDER"}}, --[43]
		["RUDDER"]				= {critical_damage = 3,  args = {248}}, --[53]
		
--CARRELLI 
		--COLLISION_SHELL
		["FRONT_GEAR_BOX"]		= {critical_damage = 4,  args = {265}, deps_cells = {"WHEEL_F"}}, --[8] portelli carrello
		["RIGHT_GEAR_BOX"]		= {critical_damage = 4,  args = {266}, deps_cells = {"WHEEL_R"}}, --[16] ""
		["LEFT_GEAR_BOX"]		= {critical_damage = 4,  args = {267}, deps_cells = {"WHEEL_L"}}, --[15] ""
		--COLLISION_LINE
		["WHEEL_F"]				= {critical_damage = 3,  args = {134}}, --[83] scoppio pneumatico ruotino
		["WHEEL_R"]				= {critical_damage = 3,  args = {135}}, --[85] scoppio pneumatico ruota DX
		["WHEEL_L"]				= {critical_damage = 3,  args = {136}}, --[84] scoppio pneumatico ruota SX

--x_ray???, no danno visuale
		["ENGINE"]				= {critical_damage = 3}, --[11]
		["PITOT"]				= {critical_damage = 3}, --[60]
		["FUEL_TANK_F"]			= {critical_damage = 8}, --[61]
		--custom collision line	declaration	
		["Cerchione_L"] = {},
		["Pneumatico_L"] = {},
		["Cerchione_F"] = {},
		["Pneumatico_F"] = {},
		["Cerchione_R"] = {},
		["Pneumatico_R"] = {},
		["LEFT_WHEEL"] = {},
		["FRONT_WHEEL"] = {},
		["RIGHT_WHEEL"] = {},
		["Line_WING_L_IN"] = {},
		["Line_WING_L_CENTER"] = {},
		["Line_WING_L_OUT"] = {},
		["Line_WING_R_IN"] = {},
		["Line_WING_R_CENTER"] = {},
		["Line_WING_R_OUT"] = {},
	}),-- end of Damage

	DamageParts = 
	{  --parti custom iniziano a @ 1000, aggiungere numero del damage [xx] corrispondente
		[1000+23] = "MB-339_OBLOMOK_WING_L", --semiala ext sx
		[1000+24] = "MB-339_OBLOMOK_WING_R",	--semiala ext dx
		--[1000+25] = "MB-339_OBLOMOK_WING_L", --aileron sx
		--[1000+26] = "MB-339_OBLOMOK_WING_R", --aileron dx
		[1000+29] = "MB-339_OBLOMOK_WING_L", --semiala centr sx
		[1000+30] = "MB-339_OBLOMOK_WING_R",	--semiala centr dx
		--[1000+31] = "MB-339_OBLOMOK_WING_L", --flap sx
		--[1000+32] = "MB-339_OBLOMOK_WING_R", --flap dx
		[1000+35] = "MB-339_OBLOMOK_WING_L",	--semiala int sx
		[1000+36] = "MB-339_OBLOMOK_WING_R", --semiala int dx
	},

	Failures = 
	{
		{ id = "1", label = _("Starter/Generator 1 failure"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "2", label = _("Generator 2 failure"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "3", label = _("Inverter failure"),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "4", label = _("Backup Inverter failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "5", label = _("Batteries failure"),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "6", label = _("Engine low responsive"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "7", label = _("Engine low performance"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "8", label = _("Engine casual RPM drop"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "9", label = _("JPT limiter fail"), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "10", label = _("Engine failure"), 			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "11", label = _("Oil pressure drop"),    	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "12", label = _("Engine compressor stall"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "13", label = _("Engine flameout with relight"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "14", label = _("Engine fire"),    			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "15", label = _("Fuel leak"),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "16", label = _("Electrical pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "17", label = _("Machanical pump failure"),   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "18", label = _("Engine anti-ice failure"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "19", label = _("Antiskid fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "20", label = _("Hydraulic pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "21", label = _("Main Hyd Circuit leak"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "22", label = _("Emerg Hyd Circuit leak"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "23", label = _("Left Oxygen tank leak"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "24", label = _("Right Oxygen tank leak"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "25", label = _("Nose gear electrical fault"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "26", label = _("Left gear electrical fault"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "27", label = _("Right gear electrical fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "28", label = _("Nose gear mechanical fault"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "29", label = _("Left gear mechanical fault"),  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "30", label = _("Right gear mechanical fault"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "31", label = _("Elevator loss"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "32", label = _("Aileron loss"),     enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "33", label = _("Rudder loss"),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "34", label = _("Elevator trim loss"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "35", label = _("Aileron trim loss"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "36", label = _("Rudder trim loss"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "37", label = _("Flaps fault"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "38", label = _("Depressurization"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		--{ id = "39", label = _("Explosive depressurization"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "40", label = _("Fwd Pitot tube blocked"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "41", label = _("Aft Pitot tube blocked"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "42", label = _("Fwd Pitot anti-ice fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "43", label = _("Aft Pitot anti-ice fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "44", label = _("Windshield Demist fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "45", label = _("Nosewheel Steering failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "gs_fail", label = _("ILS receiver GS signal fail"), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "loc_fail", label = _("ILS receiver LOC signal fail"), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "vor_fail", label = _("VOR receiver nav signal fail"), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "tacan_fail", label = _("TACAN receiver nav signal fail"), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "dme_fail", label = _("DME signal fail"), 					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},

	
	lights_data = {
	
		typename = "collection",
		lights = 
		{
			[1] = 	{ typename = "collection",
						lights = {
									{typename = "argnatostrobelight",
									connector = "WHITE_TOP",
									argument = 190,
									period = 1.333,
									color = {0.99, 0.11, 0.3},
									phase_shift = 0.0
									}						
								}
					},
			[2] = 	{ typename = "collection",
						lights = {-- Landing light
									{typename = "spotlight",
									connector = "MAIN_SPOT_PTR_02",
									argument = 190,
									--position  = {3.889, 0.006, -0.875},
									dir_correction = {elevation = math.rad(2)}
									}, --,
									{-- Landing/Taxi light
									typename = "spotlight",
									connector = "MAIN_SPOT_PTR_01",
									argument = 190,	
									dir_correction = {elevation = math.rad(3)}
									}
								}
					},
			[3]	= {	typename = "collection",
						lights = {-- Left Position Light (red)
									{typename = "argumentlight",
									connector = "BANO_1",
									color = {0.99, 0.11, 0.3},
									pos_correction  = {0, 0, -0.2},
									argument  = 190
									},
									-- Right Position Light (green)
									{typename = "argumentlight",
									connector = "BANO_2",
									color = {0, 0.894, 0.6},
									pos_correction = {0, 0, 0.2},
									argument  = 190
									},
									-- Tail Position Light (white)
									{typename = "argumentlight",
									connector = "BANO_0_BACK",
									color = {1, 1, 1},
									--pos_correction  = {-0.826, -0.799, 0},
									argument  = 190
									}		
								}
				},
			[4] = { typename = "collection", 
						lights = {
									-- Top Formation Light (white) "Gobba"
									{typename = "argumentlight",
									connector = "BANO_0_TOP",
									color = {1, 1, 1},
									--pos_correction  = {-0.826, -0.799, 0},
									argument  = 190
									},
									-- Bottom Formation Light Pancia
									{typename = "argumentlight",
									connector = "BANO_0_BOTTOM",
									color = {1, 1, 1},
									--pos_correction  = {-0.826, -0.799, 0},
									argument  = 190
									}													
								}
				},
			[5] = {	typename = "collection",
						lights = {
									-- red recognotion light 
									{typename = "argumentlight",
									 connector = "FORM_LIGHTS_1",
									 color = {0.99, 0.11, 0.3},
									 pos_correction  = {0, 0, 0},
									 argument  = 190
									},
								--	 -- amber recognotion light 
									{typename = "argumentlight",
									connector = "FORM_LIGHTS_2",
									color = {1.0, 0.5, 0.0},
									pos_correction = {0, 0, 0},
									argument  = 190
									},
								--	-- green recognotion light 
									{typename = "argumentlight",
									connector = "FORM_LIGHTS_3",
									color = {0, 0.894, 0.6},
									pos_correction  = {0, 0, 0},
									argument  = 190
									}
								}
				},
					
		}
	},	
					
--=======================================================================================================		
		AddPropAircraft = {
			{ id = "SoloFlight" 			, control = 'checkbox' , label = _('Solo Flight')			   , defValue = false, weightWhenOn = -85},
			{ id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
		  		values = {{id =  0, dispName = _("Pilot")},
							{id =  1, dispName = _("Instructor")},
							{id = -1, dispName = _("Ask Always")},
							{id = -2, dispName = _("Equally Responsible")}},
		  		defValue  = 1,
		  		wCtrl     = 150
			},
			{ id = "MountBlindHood", control = 'checkbox' , label = _('Mount Blind Hood'), playerOnly = false, defValue = false},
			{ id = "PilotEquipment" , control = 'comboList', label = _('Pilot Equipment'), playerOnly = false, 
				values = {{id =  0, dispName = _("HGU-33 only")},
							{id =  1, dispName = _("HGU-33 + Aerazur")},
							{id = -1, dispName = _("HGU-55P + Secumar")},
							{id = -2, dispName = _("HGU-2A + Secumar")}},
				defValue  = 1,
				wCtrl     = 150
			},
			{ id = "ARMAMENT", control = 'groupbox', label = _('ARMAMENT'),
				defValue  = 1,
				wCtrl     = 150
			},
			{ id = "SAAB_RGS-2_Gunsight", control = 'checkbox' , label = _('SAAB RGS-2 Gunsight'), defValue = true},
			{ id = "DEFA_553_Burst", control = 'comboList', label = _('DEFA 553 Burst'),
				values = {
							{id =  0.5, dispName = _("0.5 Second")},
							{id =  1, dispName = _("1.0 Second")}},
				defValue  = 0.5,
				wCtrl     = 150
				},
			{ id = "EnableCutOff" , control = 'checkbox', label = _('Enable Cut Off'), defValue = false},
			{ id = "RocketRippleTiming" , control = 'slider', label = _('Rocket Ripple Timing'), defValue = 250, min = 100, max = 500, dimension = 'ms', playerOnly = true},
			{ id = "BombsRippleTiming" , control = 'slider', label = _('Bombs Ripple Timing'), defValue = 300, min = 100, max = 1500, dimension = 'ms', playerOnly = true},
		},  
}

add_aircraft(MB_339A)