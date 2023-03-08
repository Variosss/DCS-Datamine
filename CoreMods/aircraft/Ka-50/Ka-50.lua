
function ka_50_outboard_station(v2022,station) 
	local res = {
		{ CLSID = "B_8V20A_CM" },
		{ CLSID = "B_8V20A_OFP2" },
		{ CLSID = "B_8V20A_OM" },
		{ CLSID = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}" },
		{ CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
		{ CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
		{ CLSID = "{05544F1A-C39C-466b-BC37-5BD1D52E57BB}" },
		{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74884}" },
		{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74881}" },
		{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" }, -- FAB-250
		{ CLSID = "{FAB_250_M62}" }, -- FAB-250-M62
		{ CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}" },
		{ CLSID = "{PTB_450}" },
	}
	local vikhr = { CLSID = "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}" , arg_value = 0 }

	if v2022 then
		if station == 1 then
			vikhr.connector = "HardPoint-2"
		else
			vikhr.connector = "HardPoint-5"
		end
	else
		if station == 1 then
			vikhr.connector = "hardpoint-1"
		else
			vikhr.connector = "hardpoint-4"
		end
	end

	res[#res + 1] = vikhr
	return res

end

ka_50_inboard_station = 
{
	{ CLSID = "B_8V20A_CM" },
	{ CLSID = "B_8V20A_OFP2" },
	{ CLSID = "B_8V20A_OM" },
	{ CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },
	{ CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },
	{ CLSID = "{05544F1A-C39C-466b-BC37-5BD1D52E57BB}" },
	{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74884}" },
	{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74881}" },
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" }, -- FAB-250
	{ CLSID = "{FAB_250_M62}" }, -- FAB-250-M62
	{ CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}" },
	{ CLSID = "{PTB_450}" },
}


function make_Ka50(rewrite_settings)

local Ka50 =  {
	Name 				= "Ka-50",
	EmptyWeight 		= "8030",
	MaxFuelWeight 		= "1450",
	MaxHeight 			= "6600",
    MaxSpeed 			= "300",
    MaxTakeOffWeight 	= "11900",
	Shape 				= "KA-50",
	
	shape_table_data 	= 
	{
		{
			file  = "ka-50";
			username = "Ka-50";
			index = KA_50;
			life  = 15;					-- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   = 3;                  -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt = "KA-50-OBLOMOK";	-- Name of destroyed object file name
			fire  = { 300, 2};          -- Fire on the ground after destoyed: 300sec 4m
		},
		{
			file  = "KA-50-OBLOMOK";
			fire  = { 0, 1};
		}
	},
	
	effects_presets = {
		{effect = "APU_STARTUP_BLAST", preset = "ka50", ttl = 3.0},
	},
	
	Picture 			= "Ka-50.png",
	DisplayName			= _("Ka-50"),
	mapclasskey 		= "P0091000021",
	WorldID 			= KA_50,
	attribute 			= {wsType_Air, wsType_Helicopter, wsType_Battleplane, KA_50, "Attack helicopters"},
	
	Categories 			= {},
	CanopyGeometry 		= makeHelicopterCanopyGeometry(LOOK_BAD, LOOK_GOOD, LOOK_BAD),
	Rate 				= "50", -- RewardPoint in Multiplayer
	
	country_of_origin 	= "RUS",
    
	LandRWCategories = 
	{
		[1] = 
		{
			Name = "AircraftCarrier",
		}, -- end of [1]
		[2] = 
		{
			Name = "HelicopterCarrier",
		}, -- end of [2]
	}, -- end of LandRWCategories
	
	TakeOffRWCategories = 
	{
		[1] = 
		{
			Name = "AircraftCarrier",
		}, -- end of [1]
		[2] = 
		{
			Name = "HelicopterCarrier",
		}, -- end of [2]
	}, -- end of TakeOffRWCategories
	
    Navpoint_Panel 		= true,
	Fixpoint_Panel 		= true,
	
	-- Countermeasures
	passivCounterm =
	{
		CMDS_Edit = true,
		ChaffNoEdit = true,
		SingleChargeTotal = 128,
		chaff = {default = 0, increment = 0, chargeSz = 0},
		flare = {default = 128, increment = 32, chargeSz = 1}
	},

	Sensors =
	{
		OPTIC = "Shkval",
	},
	
	laserEquipment = 
	{
		laserRangefinder = true,
		laserDesignator  = true,
	},
			
	Guns = {
		gun_mount("2A42", 
        {
			count1 = 240, 
			count2 = 220, 
			second_box_offset = {0.909, 0, 0} 
		}, 
        {
			supply_position = {0.305, -0.6, 0.0},
			muzzle_pos		= {2.793, -0.908, 0.905},
			ejector_pos = {-2.75, 0.0, 0.2}, 
            ejector_dir = {0.0, 0.0, 0.5},
		})
	},

	Countermeasures =
	{
		DISPENSER = "UV-26"
	},

	HumanRadio = {
		frequency = 124.0,
		editable = true,
		minFrequency = 100,
		maxFrequency = 400,
		modulation = MODULATION_AM
	},
	panelRadio = {
		[1] = {  
			name = _("R-828"),
			range = {min = 20.0, max = 59.9},
			channels = {
				[1] = { name = _("Channel 1"),		default = 21.5, modulation = _("FM")},
				[2] = { name = _("Channel 2"),		default = 25.7, modulation = _("FM")},
				[3] = { name = _("Channel 3"),		default = 27.0, modulation = _("FM")},
				[4] = { name = _("Channel 4"),		default = 28.0, modulation = _("FM")},
				[5] = { name = _("Channel 5"),		default = 30.0, modulation = _("FM")},
				[6] = { name = _("Channel 6"),		default = 32.0, modulation = _("FM")},
				[7] = { name = _("Channel 7"),		default = 40.0, modulation = _("FM")},
				[8] = { name = _("Channel 8"),		default = 50.0, modulation = _("FM")},
				[9] = { name = _("Channel 9"),		default = 55.5, modulation = _("FM")},
				[10] = { name = _("Channel 10"),	default = 59.9, modulation = _("FM")},
			}
		},--[1]
		[2] = {
			name = _("ARK-22"),                
			displayUnits = "kHz", --отображаемые единицы в МЕ-- задавать ниже в MHz все
			range = {min = 0.150, max = 1.750},
			channels = {
				[1] = { name = _("Channel 1, Outer"),		default	= 0.625,	modulation = _("AM")},	-- Krasnodar-Center
				[2] = { name = _("Channel 1, Inner"),		default = 0.303,	modulation = _("AM")},	-- Krasnodar-Center
				[3] = { name = _("Channel 2, Outer"),		default = 0.289,	modulation = _("AM")},	-- Maykop
				[4] = { name = _("Channel 2, Inner"),		default = 0.591,	modulation = _("AM")},	-- Maykop
				[5] = { name = _("Channel 3, Outer"),		default = 0.408,	modulation = _("AM")},	-- Krymsk
				[6] = { name = _("Channel 3, Inner"),		default = 0.803,	modulation = _("AM")},	-- Krymsk
				[7] = { name = _("Channel 4, Outer"),		default = 0.443,	modulation = _("AM")},	-- Anapa
				[8] = { name = _("Channel 4, Inner"),		default = 0.215,	modulation = _("AM")},	-- Anapa
				[9] = { name = _("Channel 5, Outer"),		default = 0.525,	modulation = _("AM")},	-- Mozdok
				[10] = { name = _("Channel 5, Inner"),		default = 1.065,	modulation = _("AM")},	-- Mozdok
				[11] = { name = _("Channel 6, Outer"),		default = 0.718,	modulation = _("AM")},	-- Nalchik
				[12] = { name = _("Channel 6, Inner"),		default = 0.350,	modulation = _("AM")},	-- Nalchik
				[13] = { name = _("Channel 7, Outer"),		default = 0.583,	modulation = _("AM")},	-- Min.Vody
				[14] = { name = _("Channel 7, Inner"),		default = 0.283,	modulation = _("AM")},	-- Min.Vody
				[15] = { name = _("Channel 8, Outer"),		default = 0.995,	modulation = _("AM")},	-- NDB Kislovodsk
				[16] = { name = _("Channel 8, Inner"),		default = 1.210,	modulation = _("AM")},	-- NDB Peredovaya
			}
		},--[2]
	},
	
	Failures =
	{
		{ id = 'hydro_main',  label = _('HYDRO MAIN'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hydro_common',  label = _('HYDRO COMMON'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'l_engine',  label = _('L-ENGINE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'r_engine',  label = _('R-ENGINE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_p',  	label = _('ASC PITCH'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_r',  	label = _('ASC ROLL'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_y',  	label = _('ASC YAW'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'asc_a',  	label = _('ASC ALT'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'abris_software',  	label = _('ABRIS SOFTWARE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'abris_hardware',  	label = _('ABRIS HARDWARE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'laser_failure' ,  	label = _('LASER FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADAR_ALT_TOTAL_FAILURE', 	label = _("RALT FAILURE"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},
	
	Damage =
	{
		[0] = {critical_damage = 2, args = {146}, deps_cells = {60}}, -- nose center
		[1] = {critical_damage = 3, args = {296}}, 
		[2] = {critical_damage = 3, args = {297}}, 
		[3] = {critical_damage = 15, args = {65}},  
		[4] = {critical_damage = 15, args = {150, 298}, deps_cells = {3}}, 
		[5] = {critical_damage = 17, args = {149, 301, 302}, deps_cells = {3}}, 
		[7] = {critical_damage = 3, args = {249}}, 
		[8] = {critical_damage = 3, args = {265}},
		[9] = {critical_damage = 5, args = {154, 299}},
		[10] = {critical_damage = 5, args = {153, 302, 303}},
		[11] = {critical_damage = 3, args = {167}}, 
		[12] = {critical_damage = 3, args = {161}},
		[15] = {critical_damage = 3,args = {267}},
		[16] = {critical_damage = 3,args = {266}},
		[17] = {critical_damage = 3, args = {188}},
		[18] = {critical_damage = 3, args = {189}},
		[23] = {critical_damage = 4, args = {223}}, 
		[24] = {critical_damage = 4, args = {213}}, 
		[29] = {critical_damage = 5, args = {224}, deps_cells = {23}},
		[30] = {critical_damage = 5, args = {214}, deps_cells = {24}},
		[39] = {critical_damage = 3, args = {244}},  
		[40] = {critical_damage = 3, args = {241}},
		[45] = {critical_damage = 3, args = {235}, deps_cells = {39}},
		[46] = {critical_damage = 3, args = {233}, deps_cells = {40}},
		[54] = {critical_damage = 3, args = {247}}, 
		[55] = {critical_damage = 3, args = {159}, deps_cells = {54}},
		[56] = {critical_damage = 5, args = {81, 304, 158}, deps_cells = {39, 40, 45, 46, 54, 55}}, 
		[57] = {critical_damage = 5, args = {81, 305, 157}, deps_cells = {39, 40, 45, 46, 54, 55}},
		[58] = {critical_damage = 5, args = {81, 156}, deps_cells = {39, 40, 45, 46, 54, 55}}, 
		[59] = {critical_damage = 3, args = {148}},
		[60] = {critical_damage = 1, args = {144}},
		[61] = {critical_damage = 5, args = {147}, droppable = false},
		[62] = {critical_damage = 5, args = {250}},
		[63] = {critical_damage = 10, args = {53}, deps_cells = {64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81}}, -- Rotor
		[64] = {critical_damage = 5, args = {117}, deps_cells = {65, 66}}, -- blade 1 in
		[65] = {critical_damage = 5, args = {116}, deps_cells = {66}},   -- blade 1 center
		[66] = {critical_damage = 5, args = {115}},     -- blade 1 out
		[67] = {critical_damage = 5, args = {120}, deps_cells = {68, 69}},  -- blade 2 in
		[68] = {critical_damage = 5, args = {119}, deps_cells = {69}},  -- blade 2 center
		[69] = {critical_damage = 5, args = {118}},     -- blade 2 out
		[70] = {critical_damage = 5, args = {123}, deps_cells = {71, 72}},  -- blade 3 in
		[71] = {critical_damage = 5, args = {122}, deps_cells = {72}},   -- blade 3 center
		[72] = {critical_damage = 5, args = {121}},      -- blade 3 out
		[73] = {critical_damage = 5, args = {126}, deps_cells = {74, 75}}, -- blade 4 in
		[74] = {critical_damage = 5, args = {125}, deps_cells = {75}},  -- blade 4 center
		[75] = {critical_damage = 5, args = {124}},      -- blade 4 out
		[76] = {critical_damage = 5, args = {129}, deps_cells = {77, 78}},  -- blade 5 in
		[77] = {critical_damage = 5, args = {128}, deps_cells = {78}},   -- blade 5 center
		[78] = {critical_damage = 5, args = {127}},      -- blade 5 out
		[79] = {critical_damage = 5, args = {132}, deps_cells = {80, 81}},  -- blade 6 in
		[80] = {critical_damage = 5, args = {131}, deps_cells = {81}},   -- blade 6 center
		[81] = {critical_damage = 5, args = {130}},      -- blade 6 out
		[82] = {critical_damage = 3, args = {152}}, -- fuselage bottom
		[83] = {critical_damage = 3, args = {134}}, -- nose wheel
		[84] = {critical_damage = 3, args = {136}}, -- left wheel
		[85] = {critical_damage = 3, args = {135}}, -- right wheel
		[86] = {critical_damage = 2},-- pylon1
		[87] = {critical_damage = 2}, -- pylon2
		[88] = {critical_damage = 2}, -- pylon3
		[89] = {critical_damage = 2}, -- pylon4
	},

	--AddPropAircraft = {
	--		{ id = "Realistic INS" , control = 'checkbox', label = _('Realistic INS'), defValue = true},
	--},
	
	DamageParts =
 	{
		[1] = "KA-50-WING-R",
		[2] = "KA-50-WING-L",
		[3] = "KA-50-NOSE",
		[4] = "KA-50-TAIL",
		[5] = "KA-50-BLADE",
	},
	
	--sounderName 				= "Aircraft/Helicopters/Ka-50",

	-------------------------
	-- Former HelicopterConst.lua data
	M_empty						= 8030,
	M_nominal					= 9800,
	M_max						= 11900,
	M_fuel_max					= 1450,
	
	engines_count				= 2,
	apu_rpm_delay_ 				= 2,
	thrust_correction			= 0.55,
	
	length						= 15.84,
	height						= 5.6,
	rotor_height				= 2.7,
	rotor_diameter				= 14.4,
	blades_number				= 6,
	blade_area					= 2.65,
	rotor_RPM					= 310,
	blade_chord					= 0.53,
	rotor_MOI					= 8200,
	rotor_pos 					= {0.838, 2.339, 0},
								  
	fuselage_Cxa0				= 0.8,
	fuselage_Cxa90				= 5.9,
	fuselage_area				= 3.7,
	centering					= -0.093,
	tail_pos 					= {-7.245, 0.752, 0},
	tail_fin_area				= 1.45,
	tail_stab_area				= 2.94,
								  
	MOI 						= {12000, 35000, 40000},
	
	V_max						= 350,
	V_max_cruise				= 310,
	Vy_max						= 14.6,
	Vy_land_max					= 12.8,
	Ny_max						= 3.5,
	H_stat_max_L				= 5070,
	H_stat_max					= 4000,
	H_din_two_eng				= 6400,
	H_din_one_eng				= 3290,
	range						= 450,
	flight_time_typical			= 110,
	flight_time_maximum			= 189,
	main_gear_pos 				= {-0.414, -1.83 - 0.03, 1.336}, 
	nose_gear_pos 				= {4.41,   -1.79 - 0.02, 0}, 
	lead_stock_main				= 0.295,
	lead_stock_support			= 0.21,
	
	stores_number				= 4,
	fire_rate					= 625,
								  
	scheme						= 1,
	
	radar_can_see_ground		= false,
	RCS							= 5,
	detection_range_max			= 0,
	IR_emission_coeff			= 0.3,
			
	cannon_sight_type			= 2,
	
	cargo_radius_in_menu 		= 2000, -- radius, when cargo displays in menu
	helicopter_hook_pos			= {0.0, -0.5, 0.0},
	h_max_gear_hook				= 3.3,
	
	sound_name					= "Aircrafts/Engines/RotorKa50",
	
	-- converted from 'exhaust_data' according to the way used in db_units_planes.lua: move_separated_data_to_obj_table(res) function
	engines_nozzles = 
	{
		[1] = 
		{
			pos 				= {-0.388, 0.594, -1.399},
			orientation 		= {0.5, 0.5, 1},
			diameter			= 3.0,
			exhaust_length_ab	= 3.0,
			exhaust_length_ab_K	= 0.3,
			engine_number		= 1,
		}, -- end of [1]
		[2] = 
		{
			pos 				= {-0.388, 0.594, 1.399},
			orientation 		= {0.5, 0.5, -1},
			diameter			= 3.0,
			exhaust_length_ab	= 3.0,
			exhaust_length_ab_K	= 0.3,
			engine_number		= 2,
		}, -- end of [2]
	}, -- end of engines_nozzles
	
	net_animation =
	{
		208,
		43,
		209,
		44--[[spotlight]]
	},
	
	crew_members = 
	{
		[1] =
		{
			ejection_seat_name	=	10,
			pilot_name			=	11,
			drop_canopy_name	=	0,
			pos = 	{3,0.7,0},
			ejection_added_speed = {5.0 ,30.0, 0},
			drop_parachute_name	 = "pilot_su27_parachute",
			canopy_arg = 38,
			bailout_arg = 25,
			boarding_arg = 38,
		}
	},
	
	fires_pos = 
	{
		[1] = 	{0.8,	0.4,	0},
		[2] = 	{0.27,	0.54,	-0.84},
		[3] = 	{0.27,	0.54,	0.84},
		[4] = 	{0,	0,	0},
		[5] = 	{2,	0.99,	0},
		[6] = 	{-1.37,	-0.85,	0},
		[7] = 	{0,	0,	0},
		[8] = 	{0,	0,	0},
		[9] = 	{0,	0,	0},
		[10] = 	{0,	0,	0},
		[11] = 	{0,	0,	0},
	}, -- end of fires_pos
	
	mechanimations = {
		Door0 = {
			{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "from", 0.0, "to", 1.0, "in", 1.356}}}}, Flags = {"Reversible"}},
			{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "from", 1.0, "to", 0.0, "in", 2.927}}}}, Flags = {"Reversible", "StepsBackwards"}},
			{Transition = {"Any", "Bailout"}, Sequence = {
				{C = {{"Origin", "x", 0.7, "y", 2.0, "z", 0.0}, {"Impulse", 1, "tertiary", 10.0}, {"Impulse", 2, "tertiary", 10.0},
					{"DamagePart", "BLADE_1_IN", "to", 1000},
					{"DamagePart", "BLADE_2_IN", "to", 1000},
					{"DamagePart", "BLADE_3_IN", "to", 1000},
					{"DamagePart", "BLADE_4_IN", "to", 1000},
					{"DamagePart", "BLADE_5_IN", "to", 1000},
					{"DamagePart", "BLADE_6_IN", "to", 1000},
					{"Sleep", "for", 0.5}}
				},
				{C = {{"Arg", 25, "to", 1.0, "in", 0.5}, {"Sleep", "for", 0.0}}},
			}},
		},
		WindscreenWiper0 = {
			{Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 13, "to", 0.0, "at", 1.5, "sign", -1}}}}},
			{Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 5.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 5.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
			{Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 3.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 3.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
			{Transition = {"Any", "CustomStage2"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 1.5, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 1.5, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
		},
		WindscreenWiper1 = {
			{Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 14, "to", 0.0, "at", 1.5, "sign", -1}}}}},
			{Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 1.5, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 1.5, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
		},
		HeadLights = {
			{Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 209, "to", 0.00, "speed", 0.14}, {"Arg", 44, "to", 0.00, "speed", 0.14},   {"Arg", 208, "to", 0.00, "speed", 0.14}, {"Arg", 43, "to", 0.00, "speed", 0.14},},},},},
			{Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 209, "to", 1.00, "speed", 0.14}, {"Arg", 44, "to", 0.0, "speed", 0.14},   {"Arg", 208, "to", 1.00, "speed", 0.14}, {"Arg", 43, "to", 0.0, "speed", 0.14},},},},},
			{Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 209, "to", 0.73, "speed", 0.14}, {"Arg", 44, "to", 0.0, "speed", 0.14},   {"Arg", 208, "to", 0.73, "speed", 0.14}, {"Arg", 43, "to", 0.0, "speed", 0.14},},},},},
		},
        ServiceHatches = {
            {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 1200.0}}}, {C = {{"Arg", 428, "to", 1.0, "speed", 0.6}}}}},
            {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 1200.0}}}, {C = {{"Arg", 428, "to", 0.0, "speed", 0.6}}}}},
        },

	}, -- end of mechanimations
	
	engine_data = 
	{
		power_take_off	=	1618,
		power_max	=	1618,
		power_WEP	=	1618,
		power_TH_k = 
		{
			[1] = 	{0,	-230.8,	2245.6},
			[2] = 	{0,	-230.8,	2245.6},
			[3] = 	{0,	-325.4,	2628.9},
			[4] = 	{0,	-235.6,	1931.9},
		}, -- end of power_TH_k
		SFC_k = 	{2.045e-007,	-0.0006328,	0.803},
		power_RPM_k = 	{-0.08639,	0.24277,	0.84175},
		power_RPM_min	=	9.1384,
		sound_name	=	"Aircrafts/Engines/Ka50AroundEngine",
		Nmg_Ready = 82.0,
	}, -- end of engine_data
	
	SFM_Data = {
		engine = {
			type = "TurboShaft",
			Nmg = 82.0,
			Startup_Duration = 53.0,
			Shutdown_Duration = 42.0,
		}, -- end of engine
	}, -- enf of SFM_Data
	
	lights_data = {
		typename = "collection",
		lights = {
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "collection",
				lights = {
					{
						typename = "collection",
						lights = {
							{
								typename = "spotlight", connector = "BANO_1", dir_correction = {elevation = math.rad(-45.0)}, argument = 190,
								proto = lamp_prototypes.BANO_7M_red,
							},
							{
								typename = "spotlight", connector = "BANO_2", dir_correction = {elevation = math.rad(45.0)}, argument = 191,
								proto = lamp_prototypes.BANO_7M_green,
							},
							{
								typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
								proto = lamp_prototypes.HS_2A,
							},
						},
					},
				},
			},
			[WOLALIGHT_SPOTS] = {
				typename = "collection",
				lights = {
					{
						typename = "collection",
						lights = {
							{
								typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
								proto = lamp_prototypes.FPP_7,
								movable = true,
							},
							{
								typename = "spotlight", connector = "MAIN_SPOT_PTR",
								proto = lamp_prototypes.FPP_7_halo,
								movable = true,
							},
							{
								typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
								proto = lamp_prototypes.FPP_7, range = 8.0,
								movable = true,
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
								typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
								proto = lamp_prototypes.FPP_7,
								movable = true,
							},
							{
								typename = "spotlight", connector = "MAIN_SPOT_PTR",
								proto = lamp_prototypes.FPP_7_halo,
								movable = true,
							},
							{
								typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
								proto = lamp_prototypes.FPP_7, range = 8.0,
								movable = true,
							},
						},
					},
				},
			},
			[WOLALIGHT_PROJECTORS ] = {			-- secondary spotlight moved here 
				typename = "collection",
				lights = {
					{
						typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 45,
						proto = lamp_prototypes.FPP_7,
						movable = true,
					},
					{
						typename = "spotlight", connector = "RESERV_SPOT_PTR",
						proto = lamp_prototypes.FPP_7_halo,
						movable = true,
					},
					{
						typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
						proto = lamp_prototypes.FPP_7, range = 8.0,
						movable = true,
					},
				},
			},
			[WOLALIGHT_BEACONS] = {
				typename = "collection",
				lights = {
					{
						typename = "Collection",
						lights = {
							{
								typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
								proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(360.0/1.5),
								emitter_shift_x = -0.25,
							},
						},
					},
				},
			},
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights = {
					{
						typename = "argumentlight", argument = 200,
					},
					{
						typename = "argumentlight", argument = 201,
					},
					{
						typename = "argumentlight", argument = 202,
					},
					{
						typename = "argumentlight", argument = 203,
					},
				},
			},
			--[WOLALIGHT_TIPS_LIGHTS] = tips_lights_default, -- the prototype from Lights.lua
			[WOLALIGHT_TIPS_LIGHTS] = {
				typename = "collection",
				lights = {
					{typename  = "argumentlight", argument = 47, }}--tips lights 
			}
		},
	}, -- end of lights_data
	
	Pylons = {
        pylon(1, 0, 0.947000, -0.348000, -2.735000,
            {
                FiZ 	  = -3,
				arg 	  = 308,
				arg_value = 0.701,
             },
			 ka_50_outboard_station(false, 1)
        ),
        pylon(2, 0, 0.916000, -0.348000, -2.023000,
            {
                FiZ = -3,
				arg = 309,
            },
			ka_50_inboard_station
        ),
        pylon(3, 0, 0.916000, -0.348000, 2.023000,
            {
                FiZ = -3,
				arg = 310,
            },
			ka_50_inboard_station
        ),
        pylon(4, 0, 0.947000, -0.348000, 2.735000,
            {
                FiZ 	  = -3,
				arg 	  = 311,
				arg_value = 0.701,
            },
			ka_50_outboard_station(false, 4)
        ),
    },
	
	Tasks = {
        aircraft_task(CAS),
        aircraft_task(GroundAttack),
		aircraft_task(Escort),
        aircraft_task(AFAC),
        aircraft_task(AntishipStrike)
    },
	DefaultTask	= aircraft_task(CAS),
}

if rewrite_settings then 
   for i, o in pairs(rewrite_settings) do
		Ka50[i] = o
   end
end

add_aircraft(Ka50)

end

make_Ka50()
