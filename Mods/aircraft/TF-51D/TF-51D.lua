dofile(current_mod_path.."/Views.lua")

TF_51D = {

	Name 				=   'TF-51D',
	DisplayName			= _('TF-51D'),

	EmptyWeight = 3289,
    MaxFuelWeight = 501, 
    MaxHeight = 13000, 
    MaxSpeed = 750, 
    MaxTakeOffWeight = 4800,

	Picture 			= "TF-51D.png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	
	WingSpan = 9.12,
    WorldID  = TF_51D,
    defFuelRatio = 0.68, -- топливо по умолчанию в долях от полного
	
	country_of_origin	= "USA",

	Shape 				= "TF-51D",
    propellorShapeType  = "3ARG_PROC_BLUR",
    propellorShapeName  = "P-51D_blade.FBX",
	shape_table_data 	= 
	{
		{
			file  	 	= 'TF-51D';
			life  	 	= 18; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'p51-oblomoki'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'TF-51D';
			index    	=  TF_51D;
			classname 	= "lLandPlane";
			positioning = "BYNORMAL";
			drawonmap 	= true;
		},
		{
			name  = "p51-oblomoki";
			file  = "p51-oblomoki";
			fire  = { 240, 2};
		},
	},
	
	mapclasskey = "P0091000026",
	attribute = {wsType_Air, wsType_Airplane, wsType_Fighter, TF_51D, "Battleplanes"},
	
    panelRadio = {
            [1] = {  
                ID = "SCR522",
                name = _("SCR-522"),
                displayUnits = "MHz",
                range = {min = 38, max = 156},
                channels = {
                    [1] = { name = _("Channel A"), default = 105, modulation = _("AM"), connect = true},
                    [2] = { name = _("Channel B"), default = 124, modulation = _("AM")},
                    [3] = { name = _("Channel C"), default = 131, modulation = _("AM")},
                    [4] = { name = _("Channel D"), default = 139, modulation = _("AM")},
                }
            },
            [2] = {
                ID = "BC1206",
                name = _("BC-1206"),
                displayUnits = "MHz",
                range = {min = 100.000, max = 200.000},
                channels = {
                    [1] = {name = _("Initial Frequency"), default = 108.9, modulation = _("AM")},
                }
            },
    },
	
	------------------
	M_empty 					= 3289, -- kg
	M_nominal					= 4000,
	M_max 						= 4800, -- kg
	M_fuel_max 					= 501, -- kg 
	H_max 					 	= 13000, -- m
	
	average_fuel_consumption 	= 0.302, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 56, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 125,-- Cruise speed (for AI)
	V_take_off 					= 53, -- Take off speed in m/s (for AI)
	V_land 						= 50, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 250, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 212, -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 22, -- Max climb speed in m/s (for AI)
	Mach_max 					= 0.8, -- Max speed in Mach (for AI)
	Ny_min 						= -4, -- Min G (for AI)
	Ny_max 						= 8.0,  -- Max G (for AI)
	Ny_max_e 					= 8.0,  -- Max G (for AI)
	AOA_take_off 				= 0.14, -- AoA in take off (for AI)
	bank_angle_max 				= 60, -- Max bank angle (for AI)
	
	has_afteburner 				= false, -- AFB yes/no
	has_speedbrake 				= false, -- Speedbrake yes/no
	has_differential_stabilizer	= false, -- differential stabilizers
	
	main_gear_pos 				= { 0.03, -2.1 + 0.150, 1.779},
	nose_gear_pos 				= {-4.99, -0.92 + 0.100,0.0},  
	tand_gear_max 				= 0.577,
	wing_area 					= 22.0, -- wing area in m2
	wing_span 					= 9.12, -- wing spain in m
	wing_type 					= 0,
	thrust_sum_max 				= 8224, -- thrust in kg (44kN)
	thrust_sum_ab 				= 8224, -- thrust inkg (71kN)
	length 						= 12.13, -- full lenght in m
	height 						= 4.77, -- height in m
	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 1015, -- Max range in km (for AI)
	RCS 						= 2.5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.1, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0, -- With afterburner
	wing_tip_pos 				= {-2.1,	0,	5.6},
	nose_gear_wheel_diameter 	= 0.319, -- in m
	main_gear_wheel_diameter 	= 0.683, -- in m
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	engines_count				= 1, -- Engines count
	engines_nozzles =
	{
		[1] = 
		{
			pos 		=  {1.624990,0.047866,-0.56}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
			engine_number  = 1, --both to first engine
		}, -- end of [1]
		[2] = 
		{
			pos 		=  {1.624990,0.047866,0.56}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 0*0.1, -- AFB cone diameter
			exhaust_length_ab   = -3.0, -- lenght in m
			exhaust_length_ab_K = 0.3, -- AB animation
			engine_number  = 1, --both to first engine
		}, -- end of [1]
	},
	crew_members = 
	{
		[1] = 
		{
			pilot_name		  	 = 56,
			ejection_seat_name	 = 0,
			drop_canopy_name 	 = "p-51D-fonar", --57
			pos					 =  {-1.460000,-0.045000,0.000000},
			canopy_pos = {0,0,0},
			drop_parachute_name	 = "pilot_p51_parachute",
		}, -- end of [1]
	}, -- end of crew_members
	
	fires_pos = 
	{
		[1] = 	{-2,	0.595,	0.5},
		[2] = 	{0,	0,	2.237},
		[3] = 	{0,	0,	-2.237},
		[4] = 	{0.265,	0,	1.5},
		[5] = 	{-0.265,	0,	-1.5},
		[6] = 	{0.5,	0,	4.274},
		[7] = 	{0.5,	0,	-4.274},
		[8] = 	{-5,	0.5,	0},
		[9] = 	{-5,	0.5,	0},
		[10] = 	{-5,	0.5,	0},
		[11] = 	{-5,	0.5,	0},
	}, -- end of fires_pos

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "at", 0.11111111111111},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "at", 0.16666666666667},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"TearCanopy", 0},},},},},
        },
    },

	net_animation = { 
			278,
			279,
			420 --[[external_model_throttle_arg]]},
	
	detection_range_max		 = 0,
	radar_can_see_ground 	 = false, -- this should be examined (what is this exactly?)
	CanopyGeometry = makeAirplaneCanopyGeometry(LOOK_BAD, LOOK_GOOD, LOOK_GOOD),
	Sensors = {
		OPTIC = "Merkury LLTV", -- For night goggles imitation
   	},
	
	HumanRadio = {
			frequency = 124.0,
			editable = true,
			minFrequency = 100.000,
			maxFrequency = 156.000,
			modulation = MODULATION_AM
	},
	
	Pylons = {},
	
	Tasks ={
        aircraft_task(Reconnaissance),
    },
	DefaultTask = aircraft_task(Reconnaissance),
	
	SFM_Data = {
	aerodynamics = 
		{
			Cy0	=	0.1,
			Mzalfa	=	4.355,
			Mzalfadt	=	0.8,
			kjx = 2.25,
			kjz = 0.00125,
			Czbe = -0.016,
			cx_gear = 0.0277,
			cx_flap = 0.095,
			cy_flap = 0.31,
			cx_brk = 0.06,
			table_data = {
			--      M		Cx0		 Cya		 B		 B4	      Omxmax	Aldop	Cymax

					{0.0,	0.0187,	0.0746,		0.052,	0.012,	0.15,		22.0,		1.45,	},
					{0.2,	0.0187,	0.0746,		0.052,	0.012,	0.796144,	22.0,		1.45,   },
					{0.3,	0.0187,	0.0722,		0.052,	0.015,	1.24,		19.0,		1.2,    },
					{0.5,	0.0187,	0.0798,		0.045,	0.025,	1.323,		17.0,		1.08,   },
					{0.59,	0.0187,	0.084,		0.047,	0.026,	1.129077,	17.0,		1.07,   },
					{0.67,	0.0187,	0.0907,		0.047,	0.021,	0.943,		14.5,		0.98,   },
					{0.74,	0.0227,	0.0855,		0.08,	0.16,	0.675,		10.0,	  	0.72,   },
					{0.76,	0.032,	0.078,		0.1,	0.25,	0.577,		9.0,  		0.6,    },
					{0.8,	0.063,	0.072,		0.2,	0.36,	0.456,		6.0,	    0.4,	},
					{0.83,	0.1,	0.0725,		0.34,	2.4,	0.32,		4.5,		0.3,	},
					{0.9,	0.126,	0.073,		0.56,	3.0,	0.076,		3.0,	    0.2,	},
					{1.1,	0.16,	0.03,		0.56,	3.0,	0.076,		1.0,		0.3		},
			}
		}, -- end of aerodynamics
		engine = 
		{
			Nmg		=	23.0,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	1,
			ForsRUD	=	1,
			type	=	"Piston",
			hMaxEng	=	12.5,
			dcx_eng	=	0.0015,
			cemax	=	0.37,
			cefor	=	0.37,
			dpdh_m	=	1800,
			dpdh_f	=	1800,
			k_adiab_1			= 0.037923,
			k_adiab_2			= 0.0562,
			MAX_Manifold_P_1	= 155774,		
			MAX_Manifold_P_2	= 206570,		
			MAX_Manifold_P_3	= 226648,		
			k_after_cool		= 0.54,
			Displ				= 27,
			k_Eps				= 6,
			Stroke				= 0.152,
			V_pist_0			= 12,
			Nu_0				= 1.2,
			Nu_1				= 0.9,
			Nu_2				= 0.001,
			N_indic_0			= 1023040,
			N_fr_0				= 0.072,
			N_fr_1				= 0.02,
			Init_Mom			= 220,
			D_prop				= 3.45,
			MOI_prop			= 65,
			k_gearbox			= 2.088,
			P_oil				= 495438,
			k_boost				= 3,
			k_cfug				= 0.003,
			k_oil				= 0.00004,
			k_piston			= 3000,
			k_reg				= 0.003,
			k_vel				= 0.017,
			table_data = 
			{
			--   M			Pmax
				{0.0,		16620.0},
				{0.1,		15600.0},
				{0.2,		14340.0},
				{0.3,		13320.0},
				{0.4,		12230.0},
				{0.5,		11300.0},
				{0.6,		10600.0},
				{0.7,		10050.0},
				{0.8,		 9820.0},
				{0.9,		 5902.0},
				{1.9,		 3469.0}
			},
            Startup_Prework = 15.0,
            Startup_RPMs = {
                {0.0, 0},
                {1.0, 60},
                {7.0, 60},
                {9.0, 400},
                {11.0, 880},
                {15.0, 550},
            },
            Startup_Ignition_Time = 8.0,
            Shutdown_Duration = 9.8,
                Nominal_RPM = 3000.0,
				prop_pitch_min		= 23.0,	-- prop pitch min, degrees 
				prop_pitch_max		= 65.0,	-- prop pitch max, degrees 
				prop_pitch_feather	= 80.0,	-- prop pitch feather position, degrees if feather < prop_pitch_max no feathering available
                prop_blades_count   = 4,
                prop_locations      = {
                    {2.211, -0.014, 0.000}, {0.0, 0.0, math.rad(-1.87)},
                },
		}, -- end of engine
	},
	
	Damage = {
		[11]		= {critical_damage = 3, args = {147}}, -- engine l
		[39]		= {critical_damage = 4, args = {242}}, -- fin top left
		[43]		= {critical_damage = 6, args = {243}, deps_cells = {39, 54, 45, 46, 49, 50}}, -- fin bottom left
		[54]		= {critical_damage = 3, args = {247}}, -- rudder right
		[45]		= {critical_damage = 4, args = {235}}, -- stabilizer out left
		[47]		= {critical_damage = 6, args = {236}, deps_cells = {49}} ,-- stabilizer in left
		[46]		= {critical_damage = 4, args = {233}}, -- stabilizer out right
		[48]		= {critical_damage = 6, args = {234}, deps_cells = {50}}, -- stabilizer in right
		[49]		= {critical_damage = 3, args = {240}},-- elevator out left
		[50]		= {critical_damage = 3, args = {238}},-- elevator out right
		[4]		    = {critical_damage = 5, args = {154}},-- cabin left
		[5]		    = {critical_damage = 5, args = {153}},-- cabin right
		[82]		= {critical_damage = 5, args = {152}},-- fuselage bottom
		[56]		= {critical_damage = 5, args = {158}},-- tail left
		[57]		= {critical_damage = 5, args = {157}},-- tail right
		[55]		= {critical_damage = 7, args = {81}, deps_cells = {43, 54, 45, 46}}, -- tail 
		[3]		    = {critical_damage = 3, args = {296}}, -- cockpit 
		[59]		= {critical_damage = 5, args = {148}}, -- nose bottom 
		[1]		    = {critical_damage = 5, args = {150}}, -- nose left
		[2]		    = {critical_damage = 5, args = {149}}, -- nose right
		[24]		= {critical_damage = 7, args = {213}, deps_cells = {26}},-- wing out right 
		[30]		= {critical_damage = 7, args = {214}, deps_cells = {24, 26, 38}},-- wing center right 
		[36]		= {critical_damage = 7, args = {215}, deps_cells = {30, 24, 26, 38}}, -- wing in right 
		[26]		= {critical_damage = 3, args = {216}}, -- eleron right 
		[38]		= {critical_damage = 4, args = {217}},-- flap in right 
		[23]		= {critical_damage = 7, args = {223}, deps_cells = {25}}, -- wing out left
		[29]		= {critical_damage = 7, args = {224}, deps_cells = {23, 25, 37}}, -- wing center left 
		[35]		= {critical_damage = 7, args = {225}, deps_cells = {29, 23, 25, 37}}, -- wing in left 
		[25]		= {critical_damage = 3, args = {226}}, -- eleron left 
		[37]		= {critical_damage = 4, args = {227}}, -- flap in left 
		[83]		= {critical_damage = 2, args = {134}}, -- wheel nose 
		[85]		= {critical_damage = 3, args = {135}}, -- wheel right 
		[84]		= {critical_damage = 3, args = {136}}, -- wheel left 
		[63]		= {critical_damage = 6, args = {53}, deps_cells = {66, 69, 72, 75}}, -- rotor
		[66]		= {critical_damage = 3, args = {380}}, -- blade 1 out  (for contact model!)
		[69]		= {critical_damage = 3, args = {381}}, -- blade 2 out  (for contact model!)
		[72]		= {critical_damage = 3, args = {382}}, -- blade 3 out  (for contact model!)
		[75]		= {critical_damage = 3, args = {383}}, -- blade 4 out  (for contact model!)
		[64]		= {critical_damage = 3, args = {429}}, -- blade 1 in
		[67]		= {critical_damage = 3, args = {430}}, -- blade 2 in
		[70]		= {critical_damage = 3, args = {431}}, -- blade 3 in
		[73]		= {critical_damage = 3, args = {119}}, -- blade 4 in
	},
	
	DamageParts = 
	{  
		[1] = "p51-oblomok-wing-r", -- wing R
		[2] = "p51-oblomok-wing-l", -- wing L
		[3] = "p51-oblomok_nose", -- nose
		[4] = "p51-oblomok_tail", -- tail
	},
	
	Failures = {
		{ id = 'HORIZON_BAR_NOT_SETTLE',	  	  label = _('Artificial Horizon'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_POINTER_FAILS_NO_VACUUM', label = _('Turn ind. No vac.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_POINTER_FAILS_DEFECTIVE', label = _('Turn ind. defective'),	 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_INCORRECT_SENS_DEFECTIVE',label = _('Turn ind. Incorrect  sens.'),	 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_INCORRECT_SENS_VAC_HIGH', label = _('Turn ind. Vacuum high'),		 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_INCORRECT_SENS_VAC_LOW',  label = _('Turn ind. Vacuum low'),			 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_POINTER_NOT_SET_ZERO',	  label = _('Turn ind. Pointer does not set on 0(N/F)'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURNIND_POINTER_VIBRATES',	  	  label = _('Turn ind. Pointer vibrates(N/F)'),		 enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PUMP_SEPARATOR_CLOGGED',	  	  label = _('Vacuum pump separator clogged'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PUMP_RELIEF_VALVE_SCREEN_CLOGGED',	label = _('Vacuum valve screen clogged'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PUMP_RELIEF_VALVE_LEAKS',	  		label = _('Vacuum relief valve leaks'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PUMP_FAILS',	  					label = _('Vacuum pump fails'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MANIFOLD_SHIFT',					label = _('Manifold pressure ind. pointer shifted'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MANIFOLD_LINE_LEAK',				label = _('Manifold pressure ind. line leak'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'COOLANT_RADIATOR_WIRING',		label = _('Coolant radiator flap. No volt.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_RADIATOR_MOTOR',		label = _('Coolant radiator flap. Motor fault.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_RADIATOR_SENSOR',		label = _('Coolant radiator sensor fault.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'OIL_RADIATOR_WIRING',			label = _('Oil radiator flap. No volt.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_RADIATOR_MOTOR',			label = _('Oil radiator flap. Motor fault.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_RADIATOR_SENSOR',			label = _('Oil radiator sensor fault.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_LEAK',						label = _('Oil Leak.'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		{ id = 'COMPASS_NO_TORQUE',	  			label = _('Remote Compass. No torque'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COMPASS_ERRATIC_OPERATION',	  	label = _('Remote Compass. Erratic operation'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COMPASS_POINTER_PULLS',	  		label = _('Remote Compass. Pointer pulls'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COMPASS_ERRATIC_INDIACATON',	label = _('Remote Compass. Loose pointer'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'DEFECTIVE_INSTRUMENT',	  		label = _('Directional gyro fail'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DEFECTIVE_MECHANISM',			label = _('Directional gyro mechanism fail'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = 'PITOT_HEAT_WIRING',				label = _('Pitot heating wire broken'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PITOT_HEAT_ELEMENT',			label = _('Pitot heating element burned out'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BAT_SOLENOID_WIRING',			label = _('Bat. solenoid wiring fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BAT_SOLENOID_DEFECTIVE',		label = _('Bat. solenoid defective'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'SUPERCHARGER_LIGHT',		label = _('Supercharger light fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'SUPERCHARGER_WIRE',			label = _('Supercharger wiring fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'SUPERCHARGER_SOLENOID',		label = _('Supercharger solenoid fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_DILUTION_SOLENOID',		label = _('Oil dilution solenoid fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_DILUTION_WIRE',			label = _('Oil dilution wiring fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'TACH_BREAK_CIRCUIT',		label = _('Tachometer circuit break'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TACH_BREAK_IN_INDICATOR',	label = _('Tachometer indicator break'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TACH_POOR_CONNECTION',		label = _('Tachometer poor connection'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TACH_RESISTANCE_ADJ',		label = _('Tachometer indicator adjustment fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = 'VHF_CRYSTAL',				label = _('Radio. Crystal or tube failure'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_SHORTED_CTL_BOX',		label = _('Radio. Shorted control box'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_VT_BURNED_OUT',			label = _('Radio. Receiver burned out'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_VT207_DEFECTIVE',		label = _('Radio. Squelch tube burned out'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'VHF_SQUELCH_RELAY',			label = _('Radio. Squelch relay not working'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		{ id = 'F2_TOP_CYLINDER',		label = _('Top oxygen cylinder leakage'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'F2_BOTTOM_CYLINDER',	label = _('Bottom oxygen cylinder leakage'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'D2_LEFT_CYLINDER',		label = _('Left oxygen cylinder leakage'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'D2_RIGHT_CYLINDER',		label = _('Right oxygen cylinder leakage'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	
		{ id = 'COOLANT_BREAK_BULB',		label = _('Coolant temp. ind. bulb fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_DEFECTIVE_IND',		label = _('Coolant temp. ind. defective'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_POOR_CONNTECT',		label = _('Coolant temp. ind. poor connection'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_SHORT_CIRCUIT',		label = _('Coolant temp. ind. short circuit'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'CARBAIR_SHORT_CIRCUIT',		label = _('Carb. air ind. open or short circuit'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CARBAIR_SHORT_CIRCUIT_LEADS',label = _('Carb. air ind. short circuit in leads'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CARBAIR_GND_LEAD',			label = _('Carb. air ind. gnd in leads'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CARBAIR_SHORT_CIRCUIT_BLB',	label = _('Carb. air ind. bulb short circuit'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CARBAIR_BREAK_LEADS',		label = _('Carb. air ind. breaks in leads'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CARBAIR_OPEN_CIRCUIT_BLB',	label = _('Carb. air ind. open circuit in bulb'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = 'EXT_HYDRO_LEAK',	  		label = _('External hydro leak'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
        { id = 'INT_HYDRO_LEAK',	  		label = _('Internal hydro leak'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDRO_LOW_AIR_PRESSURE',	label = _('Hydro acc. low air pressure'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UNLOAD_VALVE_NOT_LOAD',	  	label = _('Hydro relief valve stuck in unload'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'UNLOAD_VALVE_NOT_UNLOAD',	label = _('Hydro relief valve stuck in load'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	
		{ id = 'MAIN_L_GEAR_D_LOCK',	label = _('Left gear downlock fail'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAIN_R_GEAR_D_LOCK',	label = _('Right gear downlock fail'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAIL_GEAR_D_LOCK',		label = _('Tail gear downlock fail'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAIL_GEAR_U_LOCK',		label = _('Tail gear lock spring broken'), 	  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAIL_GEAR_FAIL_GO_DOWN',label = _('Tail gear up-latch cable broken'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAIL_GEAR_FAIL_GO_UP',	label = _('Tail gear down-lock cable broken'),enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAIL_GEAR_C_CABLE',		label = _('Tail gear cable jammed'), 		  enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_GEAR_UPL_FAULT',		label = _('Left gear up-latch locked'),	 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_GEAR_UPL_FAULT',		label = _('Right gear up-latch locked'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'L_GEAR_DLK_FAULT',		label = _('Left gear down-lock locked'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'R_GEAR_DLK_FAULT',		label = _('Right gear down-lock locked'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DOORS_TV_JAMMED',		label = _('Doors timing valve jammed'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DOORS_TVC_BROKEN',		label = _('Doors timing valve cable broken'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },	
			
		{ id = 'IGNITION_NO_OUTPUT',	label = _('Ignition condenser burned out'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'IGNITION_TERM_CONNECT',	label = _('Ignition terminal connection fault'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BOOSTER_COIL',			label = _('Booster coil fault'), 			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = 'STARTER_WIRING',		label = _('Starter wiring fault'), 			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STARTER_RELAY',			label = _('Starter relay fault'), 			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STARTER_SOLENOID',		label = _('Starter solenoid fault'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'FUEL_PUMP_FAILURE',		label = _('Fuel pump defective'),	 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INSUF_FUEL_PRES',		label = _('Fuel pressure insufficient'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CLOGGED_FUEL_STRAINER',	label = _('Fuel strainer clogged'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUEL_VALVE_LEAK',		label = _('Fuel valve leak'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'LEFT_WING_TANK_LEAK',	label = _('Left fuel tank leak'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RIGHT_WING_TANK_LEAK',	label = _('Right fuel tank leak'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'LEFT_TANK_PUMP_FAULT',	label = _('Left tank pump fault'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RIGHT_TANK_PUMP_FAULT',	label = _('Right tank pump fault'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		{ id = 'BOOST_REG',				label = _('Boost regulator failure'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'PROP_GOVERNOR',			label = _('Prop governor failure'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAGNETO_1',				label = _('Magneto 1 failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAGNETO_2',				label = _('Magneto 2 failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENGINE_JAM',			label = _('Engine jam'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COOLANT_UNPRES',		label = _('Coolant system unpressurized'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BATTERY_OVERHEAT',		label = _('Battery overheated'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'STARTER_BURNOUT',		label = _('Starter burn out'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			
		{ id = 'GENERATOR_FAULT',		label = _('Generator failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

    lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_LANDING_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-6.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(50.0), angle_max = math.rad(40.0),
                                exposure = {{5, 0.090, 0.095}}, movable = true, power_up_t = 0.9,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR",
                                proto = lamp_prototypes.LFS_P_27_200, range = 18.0, angle_max = math.rad(180.0), angle_max = math.rad(180.0),
                                exposure = {{5, 0.090, 0.095}}, movable = true, power_up_t = 0.9,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-6.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(50.0), angle_max = math.rad(40.0),
                                exposure = {{5, 0.090, 0.095}}, movable = true, power_up_t = 0.9,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR",
                                proto = lamp_prototypes.LFS_P_27_200, range = 18.0, angle_max = math.rad(180.0), angle_max = math.rad(180.0),
                                exposure = {{5, 0.090, 0.095}}, movable = true, power_up_t = 0.9,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Left Position Light (RED)
                        typename = "Spot", connector = "BANO_2", dir_correction = {elevation = math.rad(-45.0)}, argument = 190,
                        proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
                    },
                    { -- 1 -- Right Position Light (GREEN)
                        typename = "Spot", connector = "BANO_1", dir_correction = {elevation = math.rad(45.0)}, argument = 191,
                        proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
                    },
                    { -- 2 -- Tail Position Light (white)
                        typename = "collection",
                        lights = {
                            {
                                typename = "Spot", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                                proto = lamp_prototypes.ANO_3_Bl,
                                movable = true,
                            },
                            {
                                typename = "Omni", connector = "BANO_0",
                                proto = lamp_prototypes.ANO_3_Bl, range = 6.2,
                                movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_AUX_LIGHTS] = {
                typename = "collection",
                lights = {
                    {
                        typename = "spotlight", connector = "FORM_LIGHTS_1", argument = 200,
                        color = {0.99, 0.11, 0.3, 0.22}, range = 30.0, angle_max = math.rad(60.0), angle_min = math.rad(0.0),
                        power_up_t = 0.050,
                    },
                    {
                        typename = "spotlight", connector = "FORM_LIGHTS_2", argument = 201,
                        color = {0.0, 0.894, 0.6, 0.25}, range = 30.0, angle_max = math.rad(60.0), angle_min = math.rad(0.0),
                        power_up_t = 0.050,
                    },
                    {
                        typename = "spotlight", connector = "FORM_LIGHTS_3", argument = 202,
                        color = {1.0, 0.5, 0.0, 0.25}, range = 30.0, angle_max = math.rad(60.0), angle_min = math.rad(0.0),
                        power_up_t = 0.050,
                    },
                }
            },
        }
    },

	
	ViewSettings = ViewSettings,
	SnapViews	 = SnapViews,
	
	Countries = {"Russia","Ukraine","Germany","USA","Italy",
	"UK","Turkey","Canada","France","Spain","Belgium","The Netherlands","Norway",
	"Denmark","Georgia","Israel","Australia","Abkhazia"}
}

add_aircraft(TF_51D)


