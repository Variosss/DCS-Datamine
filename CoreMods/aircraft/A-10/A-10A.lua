function make_A10(rewrite_settings)

-- A_10_Base completely defines A-10A
local A_10_Base =  {
	Name 				= "A-10A",
	EmptyWeight 		= "11625",
	MaxFuelWeight 		= 5029,
	MaxHeight 			= "13700",
	MaxSpeed 			= "840",
	MaxTakeOffWeight 	= "21081",
	Shape 				= "a-10a",
	WingSpan 			= "17.53",

	shape_table_data 	= 
	{
		{
			file  = "a-10a";
			username = "a-10a";
			index = A_10A;
			life  = 32; 			-- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   = 3; 				-- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt = "A-10_DAM"; 	-- Name of destroyed object file name
			fire  = { 300, 2}; 		-- Fire on the ground after destoyed: 300sec 4m
		},
		{
			file  = "A-10_DAM";
			fire  = { 0, 1};
		}
	},
	
	
	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/A-10C_overwingVapor.lua"},
	},

	Picture 			=   "A-10A.png",
	DisplayName			=	_("A-10A"),
	mapclasskey 		=   "P0091000025",
	WorldID				=   A_10A,
	attribute 			=   {wsType_Air, wsType_Airplane, wsType_Battleplane, A_10A, "Battleplanes", "Refuelable"},
		
	Categories 			=   {},
	CanopyGeometry 		=   makeAirplaneCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_AVERAGE),
	Rate				=	50,	

	country_of_origin   = "USA",

	-- Countermeasures
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 480,
		-- RR-170 - 30 cartridges per magazine, increment by 2 magazines
		chaff = {default = 240, increment = 60, chargeSz = 1},
		-- MJU-7 - 15 cartridges per magazine, increment by 2 magazines
		flare = {default = 120, increment = 30, chargeSz = 2}
	},
		
	Sensors = {
        RWR = "Abstract RWR"
    },

	ammo_type = {_("CM Combat Mix"),
		_("HEI High Explosive Incendiary"),
		_("TP Target Practice"),
	},

	Guns = {
		gun_mount("GAU_8", {count = 1150},
        {supply_position   = {2.8, -0.18, 0.0},
		 muzzle_pos		   = {7.135, -0.149, -0.086},
		 effects = {gatling_effect(351, 7), fire_effect(350, 0.02, 4), smoke_effect()}}
		)
	},

	HumanRadio = {
		frequency = 124.0,
		modulation = MODULATION_AM
	},
	
	-------------------------
	-- Former PlaneConst.lua data
	M_empty						= 11625, -- due TO 1-1B-40     --11325 + 5 pylons (60),
	M_nominal					= 13500,
	M_max						= 21081,
	M_fuel_max					= 5029,
	
	engines_count				= 2,
	has_afteburner				= false,
	average_fuel_consumption	= 0.302,
	thrust_sum_max				= 8224,
	thrust_sum_ab				= 8224,
	
	length						= 16.26,
	height						= 4.47,
	wing_area					= 47,
	wing_span					= 17.53,
	wing_type					= FIXED_WING,
	wing_tip_pos 				= {-2.466, 0.563, 8.9},
	main_gear_pos 				= {-0.689, -2.398, 2.637},
	nose_gear_pos 				= {4.69, -2.315, 0.31},
	nose_gear_wheel_diameter	= 0.754,
	main_gear_wheel_diameter	= 0.972,
	has_speedbrake				= true,
	has_differential_stabilizer = false,
	brakeshute_name				= 0,
	flaps_maneuver				= 0.35,
	
	H_max						= 10000,
	CAS_min						= 58,
	V_opt						= 125,
	V_take_off					= 62,
	V_land						= 68,
	V_max_sea_level				= 236,
	V_max_h						= 200,
	Vy_max						= 30,
	Mach_max					= 0.75,
	Ny_min						= -2,
	Ny_max						= 5.9,
	Ny_max_e					= 5.9,
	AOA_take_off				= 0.19,
	bank_angle_max				= 60,
	tand_gear_max				= 0.577,
	range						= 1500,
		
	tanker_type					= 1,
	air_refuel_receptacle_pos 	= {6.317, 0.65, 0},
	
	radar_can_see_ground		= false,
	RCS							= 10,
	detection_range_max			= 0,
	IR_emission_coeff			= 0.53,
	IR_emission_coeff_ab		= 0,
	
	stores_number				= 11,
	
	engines_nozzles = 
	{
		[1] = 
		{
			pos 				= {-5.2, 0.85, -1.44},
			elevation			= 0,
			diameter			= 0.9,
			exhaust_length_ab	= 8.631,
			exhaust_length_ab_K	= 0.76,
			--smokiness_level     = 0.01, 
		}, -- end of [1]
		[2] = 
		{
			pos 				= {-5.2, 0.85,  1.44},
			elevation			= 0,
			diameter			= 0.9,
			exhaust_length_ab	= 8.631,
			exhaust_length_ab_K	= 0.76,
			--smokiness_level   = 0.01, 
		}, -- end of [2]
	}, -- end of engines_nozzles
	
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	= 17,
			drop_canopy_name	= 20,
			pos 				= {3.949, 1.01, 0},
			boarding_arg 		= 323,
		}, -- end of [1]
	}, -- end of crew_members
	
	fires_pos = 
	{
		[1] = 	{-0.781,	0.254,	0},
		[2] = 	{-1.197,	0.356,	4.09},
		[3] = 	{-1.252,	0.307,	-2.819},
		[4] = 	{-0.82,		0.265,	2.774},
		[5] = 	{-0.82,		0.265,	-2.774},
		[6] = 	{-0.82,		0.255,	4.274},
		[7] = 	{-0.82,		0.255,	-4.274},
		[8] = 	{-4.91,		0.964,	1.385},
		[9] = 	{-4.91,		0.964,	-1.385},
		[10] = 	{-0.13,		0.21,	0.75},
		[11] = 	{-0.13,		0.21,	-0.75},
	}, -- end of fires_pos
	
	--[[
	chaff_flare_dispenser = 
	{
		[1] = 
		{
			-- gear bay left
			dir = 	{0,	-1,	0},
			pos = 	{-1.748, -1, -2.34},
		}, -- end of [1]
		[2] = 
		{
			-- gear bay right
			dir =	{0,	-1,	0},
			pos = 	{-1.748, -1, 2.34},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser
	]]
	
	chaff_flare_dispenser = 
	{
		[1] = 
		{
			-- gear bay left
			dir =	{0,	-1,	0},
			pos = 	{-1.748, -1.0, -2.33},
		}, -- end of [1]
		[2] = 
		{
			-- gear bay right
			dir = 	{0,	-1,	0},
			pos = 	{-1.748, -1.0, 2.33},
		}, -- end of [2]
		[3] = 
		{
			-- wingtip left
			dir = 	{0,	0, 0},
			pos = 	{-6.0, 0.0, -8.5},
		}, -- end of [3]
		[4] = 
		{
			-- wingtip right
			dir = 	{0,	0, 0},
			pos = 	{-6.0, 0.0, 8.5},
		}, -- end of [4]
	}, -- end of chaff_flare_dispenser
	
    mechanimations = {
		Door0 = {
			{Transition = {"Close", "Open"}, Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", (9.28 + 0.8)},},},}, Flags = {"Reversible"},},
			{Transition = {"Open", "Close"}, Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", (6.243 + 0.5)},},},}, Flags = {"Reversible", "StepsBackwards"},},
			{Transition = {"Open", "Board"}, Sequence = {{C = {{"Arg", 323, "from", 0.0, "to", 0.5473, "in", 1.25},},}, {C = {{"Sleep", "for", 1.5},},}, {C = {{"Arg", 323, "from", 0.5473, "to", 1.0, "in", 0.35},},},},},
			{Transition = {"Board", "Open"}, Sequence = {{C = {{"Arg", 323, "to", 0.03, "in", 2.2},},}, {C = {{"Sleep", "for", 0.8},},}, {C = {{"Arg", 323, "from", 0.03, "to", 0.0, "in", 0.21},},},},},
			{Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
		},
		ServiceHatches = {
			{Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 5}, {"Sleep", "for", 15.0},},}, {C = {{"Arg", 91, "to", 0.9, "in", 2.0},},},},},
			{Transition = {"Open", "Close"}, Sequence = {{C = {{"Arg", 91, "to", 0.0, "in", 2.0},},},},},
		},
	}, -- end of mechanimations
	
	SpecificCallnames = {
		["USA"] = {
			{_('Hawg'),			'Hawg'},
			{_('Boar'),			'Boar'},
			{_('Pig'),			'Pig'},
			{_('Tusk'),			'Tusk'}
		}
	},
	InheriteCommonCallnames = true,
	
	pylons_enumeration = {1, 11, 2, 10, 3, 9, 4, 8, 5, 7, 6},
	sounderName = "Aircraft/Planes/A-10A",
	
	Failures = {
		{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	
	Damage =
	{
		[0]		= {critical_damage = 5, args = {146}}                                                ,
		[3]		= {critical_damage = 20,args = {65}}                                                 ,
		[4]		= {critical_damage = 20, args = {150}}                                               ,
		[5]		= {critical_damage = 20, args = {147}}                                               ,
		[7]		= {critical_damage = 4, args = {249}}                                                ,
		[9]		= {critical_damage = 3, args = {154}}                                                ,
		[10]	= {critical_damage = 3, args = {153}}                                                ,
		[11]	= {critical_damage = 3, args = {167}}                                                ,
		[12]	= {critical_damage = 3, args = {161}}                                                ,
		[15]	= {critical_damage = 5, args = {267}}                                                ,
		[16]	= {critical_damage = 5, args = {266}}                                                ,
		[23]	= {critical_damage = 8, args = {223}, deps_cells = {25}}                             ,
		[24]	= {critical_damage = 8, args = {213}, deps_cells = {26, 60}}                         ,
		[25]	= {critical_damage = 3, args = {226}}                                                ,
		[26]	= {critical_damage = 3, args = {216}}                                                ,
		[29]	= {critical_damage = 9, args = {224}, deps_cells = {31, 25, 23}}                     ,
		[30]	= {critical_damage = 9, args = {214}, deps_cells = {32, 26, 24, 60}}                 ,
		[31]	= {critical_damage = 4, args = {229}}                                                ,
		[32]	= {critical_damage = 4, args = {219}}                                                ,
		[35]	= {critical_damage = 10, args = {225}, deps_cells = {29, 31, 25, 23}}                ,
		[36]	= {critical_damage = 10, args = {215}, deps_cells = {30, 32, 26, 24, 60}}            ,
		[37]	= {critical_damage = 4, args = {227}}                                                ,
		[38]	= {critical_damage = 4, args = {217}}                                                ,
		[39]	= {critical_damage = 7,	args = {244}, deps_cells = {53}}                             ,
		[40]	= {critical_damage = 7, args = {241}, deps_cells = {54}}                             ,
		[45]	= {critical_damage = 9, args = {235}, deps_cells = {39, 51, 53}}                     ,
		[46]	= {critical_damage = 9, args = {233}, deps_cells = {40, 52, 54}}                     ,
		[51]	= {critical_damage = 3, args = {239}}                                                ,
		[52]	= {critical_damage = 3, args = {237}}                                                ,
		[53]	= {critical_damage = 3, args = {248}}                                                ,
		[54]	= {critical_damage = 3, args = {247}}                                                ,
		[55]	= {critical_damage = 20, args = {81}, deps_cells = {39, 40, 45, 46, 51, 52, 53, 54}} ,
		[59]	= {critical_damage = 5, args = {148}}                                                ,
		[60]	= {critical_damage = 1, args = {144}}                                                ,
		[83]	= {critical_damage = 3, args = {134}}, -- nose wheel                                  
		[84]	= {critical_damage = 3, args = {136}}, -- left wheel                                  
		[85]	= {critical_damage = 3, args = {135}}, -- right wheel
	},-- end of Damage
	
	AddPropAircraft = {},

	DamageParts 	=
 	{
		[1] = "A-10-OBLOMOK-WING-R",
		[2] = "A-10-OBLOMOK-WING-L",
	},
	
	SFM_Data = {
		aerodynamics = 
		{
			Cy0			= 0,
			Mzalfa		= 6.6,
			Mzalfadt	= 1,
			kjx 		= 2.85,
			kjz 		= 0.00125,
			Czbe 		= -0.012,
			cx_gear 	= 0.026,
			cx_flap 	= 0.06,
			cy_flap 	= 0.32,
			cx_brk 		= 0.06,
			table_data  = {
			--      M	 Cx0		 Cya			B				B4	      Omxmax	Aldop	Cymax

				{0.0,	0.038,		0.09,			0.051,			0.0065,		0.15,	 20,	 1.40,	},
				{0.2,	0.038,		0.09,			0.051,			0.0065,		1.2,	 20,	 1.40,	},
				{0.3,	0.038,		0.09,			0.051,			0.009,		1.6,	 20,	 1.40,	},
				{0.4,	0.038,		0.09,			0.051,			0.009,		2.1,	 19,	 1.35,	},
				{0.5,	0.038,		0.09,			0.051,			0.009,		2.6,	 18,	 1.3,	},
				{0.6,	0.040,		0.09,			0.059,			0.016,		3.1,	 11,	 1.14,	},
				{0.7,	0.052,		0.09,			0.072,			0.03,		3.5,	 8,	 	 0.9,	},
				{0.8,	0.082,		0.09,			0.180,			0.06,		3.5,	 3,	 	 0.5,   },
				{1.1,	0.160,		0.09,			0.200,			0.08,		3.5,	 1,	 	 0.3    },
			}
		}, -- end of aerodynamics
		engine = 
		{
			Nmg			=	60.00001,
			MinRUD		=	0,
			MaxRUD		=	1,
			MaksRUD		=	1,
			ForsRUD		=	1,
			type		=	"TurboFan",
			hMaxEng		=	19.5,
			dcx_eng		=	0.015,
			cemax		=	0.37,
			cefor		=	0.37,
			dpdh_m		=	4500,
			dpdh_f		=	4500,
			table_data  = 
			{
			--   M			Pmax
				{0.0,		77824.0},
				{0.1,		68600.0},
				{0.2,		61300.0},
				{0.3,		54500.0},
				{0.4,		47600.0},
				{0.5,		41900.0},
				{0.6,		36700.0},
				{0.7,		31100.0},
				{0.8,		26000.0},
				{0.9,		25520.0},
				{1.9,		15000.0}
			},
            Startup_Duration = 35.0,
            Shutdown_Duration = 35.0,
		}, -- end of engine
	},

    lights_data = {
        typename = "collection",
        lights = {
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Left Position Light (red)
                        typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(45.0)}, argument = 190,
                        proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
                        controller = "Strobe", period = 0.73, reduced_flash_time = 0.5, power_up_t = 0.25, cool_down_t = 0.6, mode = 0,
						exposure = {{223, 0.245, 0.255, 1, 0}}, movable = true,
                    },
                    { -- 1 -- Right Position Light (green)
                        typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(135.0)}, argument = 191,
                        proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
                        controller = "Strobe", period = 0.73, reduced_flash_time = 0.5, power_up_t = 0.25, cool_down_t = 0.6, mode = 0,
						exposure = {{213, 0.245, 0.255, 1, 0}}, movable = true,
                    },
                    { -- 2 -- Tail Position Light (white)
                        typename = "Spot", connector = "BANO_0_BACK", dir_correction = {azimuth = math.rad(-90.0)}, argument = 192,
                        proto = lamp_prototypes.ANO_3_Bl,
                        controller = "Strobe", period = 0.73, reduced_flash_time = 0.5, power_up_t = 0.25, cool_down_t = 0.6, mode = 0,
						exposure = {{81, 0.245, 0.255, 1, 0}}, movable = true,
                    },
                },
            },
            [WOLALIGHT_LANDING_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Landing Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR_02", dir_correction = {azimuth = math.rad(1.0)}, argument = 209,
                                proto = lamp_prototypes.LFS_P_27_450,
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR_02",
                                proto = lamp_prototypes.LFS_P_27_450, range = 16.0, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                        },
                    },
                    { -- 1 -- Landing / Taxi Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR_01", dir_correction = {azimuth = math.rad(-3.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_R_27_250,
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                            {
                                typename = "omnilight", connector = "MAIN_SPOT_PTR_01", pos_correction = {0.5, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 8.0,
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Landing / Taxi Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR_01", dir_correction = {azimuth = math.rad(-3.0)}, argument = 208,
                                proto = lamp_prototypes.LFS_R_27_250,
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                            {
                                typename = "omnilight", connector = "MAIN_SPOT_PTR_01", pos_correction = {0.5, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 8.0,
                                exposure = {{0, 0.9, 1.0}}, movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_STROBES] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Left Anticollision Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "Spot", connector = "WHITE_BEACON L", dir_correction = {azimuth = math.rad(-55.0)}, argument = 195,
                                proto = lamp_prototypes.MPS_1, angle_max = math.rad(110.0), angle_min = math.rad(80.0),
                                controller = "Strobe", period = 1.2,
								exposure = {{223, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                            {
                                typename = "Omni", connector = "WHITE_BEACON L",
                                proto = lamp_prototypes.MPS_1, range = 18.2,
                                controller = "Strobe", period = 1.2,
								exposure = {{223, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                        },
                    },
                    { -- 1 -- Right Anticollision Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "Spot", connector = "WHITE_BEACON R", dir_correction = {azimuth = math.rad(-180.0 + 55.0)}, argument = 196,
                                proto = lamp_prototypes.MPS_1, angle_max = math.rad(110.0), angle_min = math.rad(80.0),
                                controller = "Strobe", period = 1.2,
								exposure = {{213, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                            {
                                typename = "Omni", connector = "WHITE_BEACON R",
                                proto = lamp_prototypes.MPS_1, range = 18.2,
                                controller = "Strobe", period = 1.2,
								exposure = {{213, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                        },
                    },
                    { -- 2 -- Tail Anticollision Light
                        typename = "collection",
                        lights = {
                            {
                                typename = "Spot", connector = "BANO_0_BACK", dir_correction = {azimuth = math.rad(-90.0)}, argument = 203,
                                proto = lamp_prototypes.MPS_1, angle_max = math.rad(110.0), angle_min = math.rad(80.0),
                                controller = "Strobe", period = 1.2,
								exposure = {{81, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                            {
                                typename = "Omni", connector = "BANO_0_BACK",
                                proto = lamp_prototypes.MPS_1, range = 18.2,
                                controller = "Strobe", period = 1.2,
								exposure = {{81, 0.245, 0.255, 1, 0}}, movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Top Formation Light
                        typename = "omnilight", connector = "BANO_0_TOP", pos_correction = {0.0, 0.2, 0.0}, argument = 202,
                        color = {1.0, 1.0, 1.0, 0.12}, range = 10.0,
                    },
                    { -- 1 -- Bottom Formation Light
                        typename = "omnilight", connector = "BANO_0_BOTTOM", pos_correction = {0.0, -0.2, 0.0}, argument = 201,
                        color = {1.0, 1.0, 1.0, 0.12}, range = 10.0,
                    },
                    { -- 2 -- Right Tail Logo Light
                        typename = "spotlight", connector = "BANO_W_HR", pos_correction = {0.0, 0.1, 0.0}, dir_correction = {azimuth = math.rad(-1.0), elevation = math.rad(3.0)}, argument = 205,
                        proto = lamp_prototypes.FR_100, angle_max = math.rad(45.0),
                    },
                    { -- 3 -- Left Tail Logo Light
                        typename = "spotlight", connector = "BANO_W_HL", pos_correction = {0.0, -0.1, 0.0}, dir_correction = {azimuth = math.rad(-1.0), elevation = math.rad(-3.0)}, argument = 204,
                        proto = lamp_prototypes.FR_100, angle_max = math.rad(45.0),
                    },
                    { -- 4 -- Electroluminescent formation lights
                        typename = "argumentlight", argument = 200,
                    },
                },
            },
            [WOLALIGHT_TIPS_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Nacelle Floodlight Combo
                        typename = "collection",
                        lights = {
                            { -- Right Nacelle Floodlight
                                typename = "spotlight", position = {0.5, 1.2, 0.0}, direction = {azimuth = math.rad(150.0), elevation = math.rad(5.0)}, argument = 212,
                                proto = lamp_prototypes.FR_100, angle_max = math.rad(28.0),
                            },
                            { -- Left Nacelle Floodlight
                                typename = "spotlight", position = {0.5, 1.2, 0.0}, direction = {azimuth = math.rad(-150.0), elevation = math.rad(5.0)},
                                proto = lamp_prototypes.FR_100, angle_max = math.rad(28.0),
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_AUX_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- Left Nose Floodlight
                        typename = "spotlight", position = {0.0, -0.3, -5.8}, direction = {azimuth = math.rad(45.0)}, argument = 211,
                        proto = lamp_prototypes.FR_100, angle_max = math.rad(28.0),
                    },
                    { -- 1 -- Right Nose Floodlight
                        typename = "spotlight", position = {0.0, -0.3, 5.8}, direction = {azimuth = math.rad(-45.0)}, argument = 210,
                        proto = lamp_prototypes.FR_100, angle_max = math.rad(28.0),
                    },
                },
            },
            [WOLALIGHT_REFUEL_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- UARRSI Light
                        typename = "omnilight", position = {6.5, 0.4, 0.0},
                        proto = lamp_prototypes.LFS_Z_27_250, range = 8.0,
                    },
                },
            },
            [WOLALIGHT_CABIN_NIGHT] = {
                typename = "collection",
                lights = {
                    {
                        typename = "argumentlight", argument = 69,
                    },
                },
            },
        },
    }, -- end of lights_data

	Pylons =	{
        pylon(1, 0, -0.615000, -0.016000, -6.365000,
            {
                FiZ = -4.0,
            },
            {
				{ CLSID = "LAU-105_2*AIM-9L"}, -- AIM-9Lx2
				{ CLSID = "LAU-105_1*AIM-9L_L"}, -- AIM-9Lx1
				{ CLSID = "LAU-105_2*AIM-9P5"}, -- AIM-9P5x2
                { CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" }, -- AIM-9Mx2
				{ CLSID = "LAU-105_1*AIM-9M_L" }, -- AIM-9Mx1
				{ CLSID = "{3C0745ED-8B0B-42eb-B907-5BD5C1717447}" }, -- AIM-9Px2
				{ CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" }, -- ALQ-131
				{ CLSID = "ALQ_184" }, -- ALQ-184		
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" }, -- Red-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" }, -- Green-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" }, -- Blue-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" }, -- White-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" }, -- Yellow-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" }, -- Orange-Smoke
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
				{ CLSID = "LAU-105_AIS_ASQ_T50_L" }, -- ACMI
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(2, 0, -0.615000, -0.144000, -5.408000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
                { CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" }, -- SUU-25
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(3, 0, -0.615000, -0.337000, -4.015000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" }, -- LAU-117-AGM-65K
				{ CLSID = "{444BA8AE-82A7-4345-842E-76154EFCCA46}" }, -- LAU-117-AGM-65D
				{ CLSID = "LAU_117_AGM_65G" }, -- LAU-117-AGM-65G
				{ CLSID = "LAU_117_AGM_65H" }, -- LAU-117-AGM-65H
				{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}" }, -- LAU-88-2xAGM-65D
				{ CLSID = "LAU_88_AGM_65H_2_L" }, -- LAU-88-2xAGM-65H
				{ CLSID = "{DAC53A2F-79CA-42FF-A77A-F5649B601308}" }, -- LAU-88-3xAGM-65D
				{ CLSID = "LAU_88_AGM_65H_3" }, -- LAU-88-3xAGM-65H
				{ CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, -- Mk-84
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- Mk-82-TER
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- Mk-82AIR-TER
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(4, 0, -0.615000, -0.501000, -1.853000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },  -- Mk-84
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- Mk-82-TER
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- Mk-82AIR-TER
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "Fuel_Tank_FT600" }, -- FT600-Fuel Tank	
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(5, 0, -0.615000, -0.501000, -0.587000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },  -- Mk-84
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(6, 0, -0.615000, -0.527000, 0.000000,
            {
                FiZ = -4.0,
            },
            {
			    { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },  -- Mk-84
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "Fuel_Tank_FT600" }, -- FT600-Fuel Tank	
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(7, 0, -0.615000, -0.501000, 0.587000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" }, -- Mk-84
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(8, 0, -0.615000, -0.501000, 1.853000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
                { CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },  -- Mk-84
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- Mk-82-TER
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- Mk-82AIR-TER
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "Fuel_Tank_FT600" }, -- FT600-Fuel Tank	
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(9, 0, -0.615000, -0.337000, 4.015000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{69DC8AE7-8F77-427B-B8AA-B19D3F478B66}" }, -- LAU-117-AGM-65K
				{ CLSID = "{444BA8AE-82A7-4345-842E-76154EFCCA46}" }, -- LAU-117-AGM-65D
				{ CLSID = "LAU_117_AGM_65G" }, -- LAU-117-AGM-65G
				{ CLSID = "LAU_117_AGM_65H" }, -- LAU-117-AGM-65H
				{ CLSID = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}" }, -- LAU-88-2xAGM-65D
				{ CLSID = "LAU_88_AGM_65H_2_R" }, -- LAU-88-2xAGM-65H
				{ CLSID = "{DAC53A2F-79CA-42FF-A77A-F5649B601308}" }, -- LAU-88-3xAGM-65D
				{ CLSID = "LAU_88_AGM_65H_3" }, -- LAU-88-3xAGM-65H
				{ CLSID = "{AB8B8299-F1CC-4359-89B5-2172E0CF4A5A}" },  -- Mk-84
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "BRU-42_3*BDU-33" }, -- BDU-33-TER
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- Mk-82-TER
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- Mk-82AIR-TER
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(10, 0, -0.615000, -0.144000, 5.408000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },  -- Mk-82
                { CLSID = "{CAE48299-A294-4bad-8EE6-89EFC5DCDF00}" },  -- SUU-25
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "{FC85D2ED-501A-48ce-9863-49D468DDD5FC}" }, -- LAU-68-MK1
				{ CLSID = "{174C6E6D-0C3D-42ff-BCB3-0853CB371F5C}" }, -- LAU-68-MK5
				{ CLSID = "{65396399-9F5C-4ec3-A7D2-5A8F4C1D90C4}" }, -- LAU-68-MK61
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}" }, -- LAU-68-M151
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}" }, -- LAU-68-MK156
				{ CLSID = "{1F7136CB-8120-4e77-B97B-945FF01FB67C}" }, -- LAU-68-WTU1B
				{ CLSID = "{647C5F26-BDD1-41e6-A371-8DE1E4CC0E94}" }, -- LAU-68-M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}" }, -- LAU-68-W274
				{ CLSID = "{D22C2D63-E5C9-4247-94FB-5E8F3DE22B71}" }, -- LAU-131-MK1
				{ CLSID = "{319293F2-392C-4617-8315-7C88C22AF7C4}" }, -- LAU-131-MK5
				{ CLSID = "{1CA5E00B-D545-4ff9-9B53-5970E292F14D}" }, -- LAU-131-MK61
				{ CLSID = "{69926055-0DA8-4530-9F2F-C86B157EA9F6}" }, -- LAU-131-M151
				{ CLSID = "{2AF2EC3F-9065-4de5-93E1-1739C9A71EF7}" }, -- LAU-131-MK156
				{ CLSID = "{DDCE7D70-5313-4181-8977-F11018681662}" }, -- LAU-131-WTU1B
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}" }, -- LAU-131-M257
				{ CLSID = "{6D6D5C07-2A90-4a68-9A74-C5D0CFFB05D9}" }, -- LAU-131-W274
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
        pylon(11, 0, -0.615000, -0.016000, 6.365000,
            {
                FiZ = -4.0,
            },
            {
                { CLSID = "LAU-105_2*AIM-9L"}, -- AIM-9Lx2
				{ CLSID = "LAU-105_1*AIM-9L_R"}, -- AIM-9Lx1
				{ CLSID = "LAU-105_2*AIM-9P5"}, -- AIM-9P5x2
				{ CLSID = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}" }, -- AIM-9Mx2
				{ CLSID = "LAU-105_1*AIM-9M_R" }, -- AIM-9Mx1
				{ CLSID = "{3C0745ED-8B0B-42eb-B907-5BD5C1717447}" }, -- AIM-9Px2
				{ CLSID = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}" }, -- ALQ-131
				{ CLSID = "ALQ_184" }, -- ALQ-184		
				{ CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}" }, -- Red-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}" }, -- Green-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}" }, -- Blue-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}" }, -- White-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}" }, -- Yellow-Smoke
                { CLSID = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}" }, -- Orange-Smoke
				{ CLSID = "{Mk82AIR}" },
				{ CLSID = "{CBU-87}" },
				{ CLSID = "{BDU-50LD}" }, -- BDU-50LD
				{ CLSID = "{BDU-50HD}" }, -- BDU-50HD
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" }, -- Mk-82
				{ CLSID = "LAU-105_AIS_ASQ_T50_R" }, -- ACMI
				{ CLSID = "{ADD3FAE1-EBF6-4EF9-8EFC-B36B5DDF1E6B}" }, -- Mk20 Rockeye
            }
        ),
    },
	
	Tasks = {
        aircraft_task(GroundAttack),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(RunwayAttack),
		aircraft_task(AntishipStrike),
    },-- end of Tasks
	DefaultTask	= aircraft_task(CAS),
}

if rewrite_settings then 
   for i, o in pairs(rewrite_settings) do
		A_10_Base[i] = o
   end
end

-- Make A-10 using basic (A-10A) settings.
add_aircraft(A_10_Base)

end

-- Make A-10A
make_A10()
