--mounting 3d model paths and texture paths 
mount_vfs_model_path	(current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/mi-24p")
--to ease possible checksum test
--dofile(current_mod_path.."/Views.lua")


rot_nil = {}
rot_nil[1] = 0.0
rot_nil[2] = 0.0

arg_ch_rng = {}
arg_ch_rng[1] = 0.0
arg_ch_rng[2] = 1.0

declare_loadout({
	category			= CAT_PODS,
	CLSID				= "KORD_12_7_MI24_R",
	Picture				= "M60.png",
	PictureBlendColor	= "0xffffffff",
	displayName			= _("Kord 12.7mm HMG"),
	Weight				= 95.0,
	Cx_pil				= 0.001220703125,
	attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
	gun_mounts			= get_predefined_aircraft_gunpod("KORD_12_7"),
	kind_of_shipping	= 2,
	Elements = {{
		Position		= {0, 0, 0},
		ShapeName		= "mi-24p_kord",
	}},
	shape_table_data = {{
		file			= "mi-24p_kord", -- placeholder
		username		= "MI24Gunner",
		index			= WSTYPE_PLACEHOLDER,
	}},
	
	control_container_data = {
		  rot_x  = rot_nil,
	  	  --rot_y  = {-40,40},
		  rot_y  = {-40,40},
		  rot_z  = {-40,10},
		  arg_x  = 0,
		  arg_y  = 423,
		  arg_z  = 424,
		  rate_x = 0,
		  rate_y = 60,
          rate_z = 60, -- grads
		  arg_x_ch_range = arg_ch_rng,
		  arg_y_ch_range = {0.225,-0.218},
		  arg_z_ch_range = {-0.444,0.111},
          init_state = true,
		  arg_c_num  = 0,
		  init_c = -0.6,
	}
})

declare_loadout({
	category			= CAT_PODS,
	CLSID				= "KORD_12_7_MI24_L",
	Picture				= "M60.png",
	PictureBlendColor	= "0xffffffff",
	displayName			= _("Kord 12.7mm HMG"),
	Weight				= 95.0,
	Cx_pil				= 0.001220703125,
	attribute			= {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER},
	gun_mounts			= get_predefined_aircraft_gunpod("KORD_12_7"),
	kind_of_shipping	= 2,
	Elements = {{
		Position		= {0, 0, 0},
		ShapeName		= "mi-24p_kord1",
	}},
	shape_table_data = {{
		file			= "mi-24p_kord1", -- placeholder
		username		= "MI24Gunner",
		index			= WSTYPE_PLACEHOLDER,
	}},
	
	control_container_data = {
		  rot_x  = rot_nil,
	  	  --rot_y  = {-40,40},
		  rot_y  = {-40,40},
		  rot_z  = {-40,10},
		  arg_x  = 0,
		  arg_y  = 423,
		  arg_z  = 424,
		  rate_x = 0,
		  rate_y = 60,
          rate_z = 60, -- grads
		  arg_x_ch_range = arg_ch_rng,
		  arg_y_ch_range = {0.225,-0.218},
		  arg_z_ch_range = {-0.444,0.111},
          init_state = true,
		  arg_c_num  = 0,
		  init_c = -0.6,
	}
})

local function inboardTbl(KORD_STATION, KORD_CLSID)

return {
		{ CLSID = "B_8V20A_CM", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},
		{ CLSID = "B_8V20A_OFP2", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},
		{ CLSID = "B_8V20A_OM", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},
		{ CLSID = "{UB-32A-24}", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},--UB-32A-24 pod - 32 x S-5KO
		{ CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},--B-8V20A pod - 20 x S-8KOM
		{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}" },--FAB-100 - 100kg GP Bomb LD"
		{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },--FAB-250 - 250kg GP Bomb LD
		{ CLSID = "{FAB_250_M62}" },						 --FAB-250 M-62 - 250kg GP Bomb LD
		{ CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}" },--FAB-500 M-62 - 500kg GP Bomb LD
		
		{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}"},-- RBK-250 PTAB-2.5M
		{ CLSID = "{RBK_250_275_AO_1SCH}" },				-- RBK-250-275 AO-1SCh
		{ CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}"},-- RBK-500 PTAB-10-5
		{ CLSID = "{7AEC222D-C523-425e-B714-719C0D1EB14D}"},-- RBK-500 PTAB-1M
		{ CLSID = "{RBK_500U_OAB_2_5RT}" },					-- RBK-500U OAB-2.5RT
		
		{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74884}" },--KMGU-2 - 96 x AO-2.5RT Dispenser (CBU) HE/Frag
		{ CLSID = "{96A7F676-F956-404A-AD04-F33FB2C74881}" },--KMGU-2 - 96 x AO-2.5KO Dispenser (CBU) HE/Frag
		{ CLSID = "{PTB_450}" },		--PTB-450
		{ CLSID = "{APU_68_S-24}", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},	--S-24
		{ CLSID = "GUV_YakB_GSHP", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}, arg_value = 0.2},
		{ CLSID = "GUV_VOG", forbidden = {{station = KORD_STATION, loadout = {KORD_CLSID}}}},
	}
end

local inboardR = inboardTbl(8, "KORD_12_7_MI24_R")
local inboardL = inboardTbl(7, "KORD_12_7_MI24_L")
			
local outboard = {
	{ CLSID = "B_8V20A_CM" },
	{ CLSID = "B_8V20A_OFP2" },
	{ CLSID = "B_8V20A_OM" },
	{ CLSID = "{UB-32A-24}" },--UB-32A-24 pod - 32 x S-5KO
	{ CLSID = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}" },-- 9M114 Shturm-V-2
	{ CLSID = "{2x9M120_Ataka_V}" }, -- 9M120 Ataka-V-2
	{ CLSID = "{2x9M120F_Ataka_V}" }, -- 9M120F Ataka-V-2
	{ CLSID = "{2x9M220_Ataka_V}" }, -- 9M220O Ataka-V-2
	{ CLSID = "{FC56DF80-9B09-44C5-8976-DCFAFF219062}" },--B-13L pod - 5 x S-13-OF
	{ CLSID = "{PTB_450}" },		--PTB-450
	{ CLSID = "{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}" },--B-8V20A pod - 20 x S-8KOM
	{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" },--FAB-250 - 250kg GP Bomb LD
	{ CLSID = "{FAB_250_M62}" },						 --FAB-250 M-62 - 250kg GP Bomb LD
	{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}" },--FAB-100 - 100kg GP Bomb LD"
	{ CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}"},-- RBK-250 PTAB-2.5M
	{ CLSID = "{RBK_250_275_AO_1SCH}" },					-- RBK-250-275 AO-1SCh
	{ CLSID = "{APU_68_S-24}" },	--S-24
	{ CLSID = "GUV_VOG"},
	{ CLSID = "{APU-60-1_R_60M}"},
}


local function joinTbl(orig, to, from)
	for i, value in ipairs(orig) do									
		to[i] = value
	end
	for i, value in ipairs(from) do									
		table.insert(to, value)
	end
	return to
end

local outboardLeft = {}	-- left
joinTbl(outboard, outboardLeft,{
		{ CLSID = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}"},--paired R-60 left
})

local outboardRight = {}	-- Right
joinTbl(outboard, outboardRight,{
	{ CLSID = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}"}, --paired R-60 right
})


local wingtips = {
    { CLSID = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}" }, -- 9M114 Shturm-V-2
	{ CLSID = "{2x9M120_Ataka_V}" }, -- 9M120 Ataka-V-2
	{ CLSID = "{2x9M120F_Ataka_V}" }, -- 9M120F Ataka-V-2
	{ CLSID = "{2x9M220_Ataka_V}" }, -- 9M220O Ataka-V-2
	{ CLSID = "{9M114 Shturm-V-2 Rack}" },
}

Mi_24P =  {
        
	Name 				=   'Mi-24P',
	DisplayName			= _('Mi-24P'),
	Picture 			= "Mi-24P.png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	Shape 				= "Mi-24P",
	
	country_of_origin = "RUS",

	shape_table_data 	= 
	{
		{
			file  	 = 'Mi-24P';
			life  	 = 20; -- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	 = 3; -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt    = "mi-24p_oblomok"; -- Name of destroyed object file name
			fire  	 = { 300, 4}; -- Fire on the ground after destoyed: 300sec 4m
			username = 'Mi-24P';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			file  = "mi-24p_oblomok";
			fire  = { 0, 1};
		}
	},
	mapclasskey = "P0091000021",
	sounderName = "Aircraft/Helicopters/Mi-24",
	attribute  			= {wsType_Air, wsType_Helicopter, wsType_Battleplane, WSTYPE_PLACEHOLDER ,"Attack helicopters",},
	InternalCargo = {
			nominalCapacity = 800,
			maximalCapacity = 800,
		},
		
	Categories = {
        },
	-------------------------
	length	=	20.953,
	height	=	4.354,
	rotor_height	=	2.43,
	rotor_diameter	=	17.3,
	blades_number	=	5,
	blade_area	=	3.34,
	rotor_RPM	=	-240,
	engines_count	=	2,
	blade_chord	=	0.58,
	rotor_MOI	=	14300,
	rotor_pos = 	{0.108,	2.44,	0},
	thrust_correction	=	0.7,
	fuselage_Cxa0	=	0.5,
	fuselage_Cxa90	=	5.9,
	fuselage_area	=	4.8,
	centering	=	-0.09,
	tail_pos = 	{-10.658,	2.611,	0},
	tail_fin_area	=	3.15,
	tail_stab_area	=	1.47,
	M_empty	=	8891,
	M_nominal	=	11200,
	M_max	=	11500,
	MOI = 	{16562,	77634,	75047},
	M_fuel_max	=	1701,
	V_max	=	330,
	V_max_cruise	=	270,
	Vy_max	=	12.5,
	H_stat_max_L	=	2500,
	H_stat_max	=	2200,
	H_din_two_eng	=	4500,
	H_din_one_eng	=	3000,
	range	=	500,
	flight_time_typical	=	120,
	flight_time_maximum	=	240,
	main_gear_pos = 	{-1.105,	-1.8,	1.3},
	nose_gear_pos = 	{3.3,	-2.02,	0},
	lead_stock_main	=	0.438,
	lead_stock_support	=	0.356,
	stores_number	=	6,
	scheme	=	0,
	fire_rate	=	625,
    doors_movement  = 2,
	crew_size	=	3,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
            pos = {3.3, 0.0, 1.0},
			canopy_arg = 131,
            canopy_args = {133, 0.15, 131, 2.0, 38, 0.1, 86, 0.1},			
            ejection_added_speed = {0.0, 0.0, 1.0},
			can_be_playable 	= true,
			role 				= "pilot",
			role_display_name	= _("Pilot"),
		}, -- end of [1]
		[2] = 
		{
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
            pos = {4.9, -0.5, -1.0},
			canopy_arg = 133,
            canopy_args = {133, 2.0, 131, 0.15, 38, 0.1, 86, 0.1},
            ejection_added_speed = {0.0, 0.0, -1.0},
            canopy_arg = 133,
			can_be_playable 	= true,
			role 				= "pilot",
			role_display_name	= _("Copilot-gunner"),
		}, -- end of [1]
		[3] = {-- player slot 3
			ejection_seat_name	=	0,
			drop_canopy_name	=	0,
            pos = {1.5, -0.5, 0.0},
--			canopy_arg = 133,
--            canopy_args = {133, 2.0, 131, 0.15, 38, 0.1, 86, 0.1},
            ejection_added_speed = {0.0, 0.0, -1.0},
            canopy_arg = 133,
			can_be_playable 	= true,
			role 				= "gunner",
			role_display_name	= _("KORD-gunner"),
		},
			
	}, -- end of crew_members
	crew_stations = "Hybrid",
    mechanimations = {
       	Door0 = { -- operator canopy
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 133, "to", 0.9, "in", 3.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 133, "to", 0.0, "in", 3.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},
			Door1 = { -- pilot door
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 131, "to", 0.9, "in", 2.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 131, "to", 0.0, "in", 2.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},
			Door2 = { -- left cargo door
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 1.0, "in", 1.0/0.35},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 1.0/0.35},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},
			Door3 = { -- right cargo door
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 86, "to", 1.0, "in", 1.0/0.35},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 86, "to", 0.0, "in", 1.0/0.35},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},		
			Door4 = { -- sight door external
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 34, "to", 0.9, "in", 1.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 34, "to", 0.0, "in", 1.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},		
			Door5 = { -- sight door internal
				{Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 30, "to", 0.9, "in", 1.0},},},}, Flags = {"Reversible"},},
				{Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 30, "to", 0.0, "in", 1.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
			},					
            HeadLights = {
                {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 425, "to", 0.0, "speed", 0.2}, {"Arg", 426, "to", 0.0, "speed", 0.3},},},},},
                {Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 425, "to", 0.0, "speed", 0.2}, {"Arg", 426, "to", 0.0, "speed", 0.3},},},},},
                {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 425, "to", 0.3, "speed", 0.2}, {"Arg", 426, "to", 0.13, "speed", 0.3},},},},},
            },			
		   WindscreenWiper0 = {
                {Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
                {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 30.0, "sign", -1}}}}},
                {Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 2.0 / 60.0 * 90.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 90.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 2.0 / 60.0 * 60.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage2"}, Sequence = {{C = {{"Arg", 13, "to", 1.0, "at", 2.0 / 60.0 * 30.0, "sign", 1}}}, {C = {{"Arg", 13, "to", 0.0, "at", 2.0 / 60.0 * 30.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
            },
            WindscreenWiper1 = {
                {Transition = {"Any", "Hang"}, Sequence = {{C = {{"Sleep", "for", 0.0}}}}},
                {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 30.0, "sign", -1}}}}},
                {Transition = {"Any", "CustomStage0"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 2.0 / 60.0 * 90.0, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 90.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage1"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 2.0 / 60.0 * 60.0, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 60.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
                {Transition = {"Any", "CustomStage2"}, Sequence = {{C = {{"Arg", 14, "to", 1.0, "at", 2.0 / 60.0 * 30.0, "sign", 1}}}, {C = {{"Arg", 14, "to", 0.0, "at", 2.0 / 60.0 * 30.0, "sign", -1}}}, {C = {{"ValuePhase", 0}}}}},
            },
    }, -- end of mechanimations

	net_animation =
	{
		423,		-- searchlight retract-extend
		424,		-- searchlight rotate
		457,		--[[ExhausScreen]]
	},

	RCS	=	12,
	detection_range_max	=	0,
	IR_emission_coeff	=	0.5,
	Vy_land_max	=	12.8,
	Ny_max	=	2.5,
	radar_can_see_ground	=	false,
	sound_name	=	"Aircrafts/Engines/RotorMi24",

	--cannon_sight_type			=
	--cargo_max_weight			=
	--cargo_radius_in_menu		=
	helicopter_hook_pos		= {0, -1.0, 0},
	h_max_gear_hook			= 2.0,


	engines_nozzles =
	{
		[1] =
		{
			exhaust_length_ab_K	=	0.3,
			azimuth = 10,
		}, -- end of [1]
		[2] =
		{
			exhaust_length_ab_K	=	0.3,
			azimuth = -10,
		}, -- end of [1]
	}, -- end of engines_nozzles

	engine_data = 
	{
		power_take_off	=	1470,
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
		sound_name	=	"Aircrafts/Engines/EngineTV3117",
	}, -- end of engine_data
	cannon_sight_type	=	0,
	fires_pos = 
	{
		[1] = 	{0,	0.7,	0},
		[2] = 	{1.63,	0.95,	-0.6},
		[3] = 	{1.63,	0.95,	0.6},
		[4] = 	{-8.4,	0.96,	0},
		[5] = 	{-1.34,	0.65,	0},
		[6] = 	{1.21,	-1.06,	0},
		[7] = 	{0,	0,	0},
		[8] = 	{0,	0,	0},
		[9] = 	{0,	0,	0},
		[10] = 	{0,	0,	0},
		[11] = 	{0,	0,	0},
	}, -- end of fires_pos
	 effects_presets = {
            {effect = "APU_STARTUP_BLAST", preset = "mi8mtv2", ttl = 3.0},
        },
	
		
	--sensors
	
	detection_range_max		 = 30,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	
	CanopyGeometry = makeHelicopterCanopyGeometry(LOOK_GOOD, LOOK_GOOD, LOOK_AVERAGE),

	Sensors = {
            OPTIC = "Raduga-Sh",
            RWR = "Abstract RWR"
        },

-- Countermeasures
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 192,
		chaff = {default = 0, increment = 64, chargeSz = 1},
		flare = {default = 192, increment = 64, chargeSz = 1}
	},
	
	chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{0.2578,	0.0871,	-0.9623},
				pos = 	{-3.0,	1.0,	-1.28},
			}, -- end of [1]
			[2] = 
			{
				dir = 	{0.2578,	0.0871,	0.9623},
				pos = 	{-3.0,	1.0,	1.28},
			}, -- end of [2]
		}, -- end of chaff_flare_dispenser


	HumanRadio = {
			editable = true,
			frequency = 127.5,
			minFrequency = 100,
			maxFrequency = 400,
			modulation = MODULATION_AM
	},

	panelRadio = {
       [1] = {  
				name = _("R-863"),
				range = {min = 100.0, max = 399.9},
				channels = {
					[1] = { name = _("Channel 0"),		default = 127.5, modulation = _("AM"), connect = true}, -- default
					[2] = { name = _("Channel 1"),		default = 135.0, modulation = _("AM")},	-- min. water
					[3] = { name = _("Channel 2"),		default = 136.0, modulation = _("AM")},	-- nalchik
					[4] = { name = _("Channel 3"),		default = 127.0, modulation = _("AM")},	-- sochi
					[5] = { name = _("Channel 4"),		default = 125.0, modulation = _("AM")},	-- maykop
					[6] = { name = _("Channel 5"),		default = 121.0, modulation = _("AM")},	-- anapa
					[7] = { name = _("Channel 6"),		default = 141.0, modulation = _("AM")},	-- beslan
					[8] = { name = _("Channel 7"),		default = 128.0, modulation = _("AM")},	-- krasnodar-pashk.
					[9] = { name = _("Channel 8"),		default = 126.0, modulation = _("AM")},	-- gelenjik
					[10] = { name = _("Channel 9"),		default = 133.0, modulation = _("AM")},	-- kabuleti
					[11] = { name = _("Channel 10"),	default = 130.0, modulation = _("AM")},	-- gudauta
					[12] = { name = _("Channel 11"),	default = 129.0, modulation = _("AM")},	-- Sukhumi - Babushara
					[13] = { name = _("Channel 12"),	default = 123.0, modulation = _("AM")},	-- Novorossiysk
					[14] = { name = _("Channel 13"),	default = 131.0, modulation = _("AM")},	-- batumi
					[15] = { name = _("Channel 14"),	default = 134.0, modulation = _("AM")},	-- kutaisi
					[16] = { name = _("Channel 15"),	default = 132.0, modulation = _("AM")},	-- senaki
					[17] = { name = _("Channel 16"),	default = 138.0, modulation = _("AM")},	-- Tbilisi - Lochini
					[18] = { name = _("Channel 17"),	default = 122.0, modulation = _("AM")},	-- krasnodar-center
					[19] = { name = _("Channel 18"),	default = 124.0, modulation = _("AM")},	-- krymsk
					[20] = { name = _("Channel 19"),	default = 137.0, modulation = _("AM")}, -- mozdok
				}
			},--[1]
			[2] = {  
				name = _("R-828"),
				range = {min = 20.0, max = 59.9},
				channels = {
					[1] = { name = _("Channel 0"),		default = 21.5, modulation = _("FM")}, -- default
					[2] = { name = _("Channel 1"),		default = 25.7, modulation = _("FM")},
					[3] = { name = _("Channel 2"),		default = 27.0, modulation = _("FM")},
					[4] = { name = _("Channel 3"),		default = 28.0, modulation = _("FM")},
					[5] = { name = _("Channel 4"),		default = 30.0, modulation = _("FM")},
					[6] = { name = _("Channel 5"),		default = 32.0, modulation = _("FM")},
					[7] = { name = _("Channel 6"),		default = 40.0, modulation = _("FM")},
					[8] = { name = _("Channel 7"),		default = 50.0, modulation = _("FM")},
					[9] = { name = _("Channel 8"),		default = 55.5, modulation = _("FM")},
					[10] = { name = _("Channel 9"),		default = 59.9, modulation = _("FM")},
				}
			},--[2]			
    },

	Guns = {
		gun_mount("GSh_30_2K", {count = 250},
		{
			supply_position = {3.2, -0.78, 0.5},
			muzzle_pos_connector = "Gun_point_0",
			ejector_pos 		 = {-3.7, -0.2, 0.0},
			ejector_dir 		 = {-1.0,0.0,0.0},
			effects =
			{
				{ 
				  name 				   = "FireEffect",
				  helicopter = true,	
 			    },
				smoke_effect(),
				-- backfire 
				{ name 				   = "FireEffect",
				  custom_pos 		   = {2.5, -0.8 , 0.9},
				  custom_dir_azimuth   = math.rad(180.0),
				  custom_dir_elevation = math.rad(0),
				  custom_size          = {-0.5, 0.5},
				  helicopter = true,
				  helicopterback = true,
 			    },
			}	
		})
	},
	
	ammo_type_default = 1,
	ammo_type ={
			_("Combat Mix"),
			_("Combat Mix More Tracers"),
			_("Combat Mix No Tracers"),
			_("30MM HE"),
			_("30MM AP"),
			
	},
	
	Pylons = {
		 pylon(1, 0, -1.150000, -0.732000, -3.208000,
            {
				use_full_connector_position = true,
				connector = "hardpoint-1",
				DisplayName = _("@MSL"),

            },
           wingtips
        ),
        pylon(2, 0, -1.073000, -0.191000, -2.282000,
            {
				arg = 309,
                use_full_connector_position = true,
				connector = "hardpoint-2",
				DisplayName = _("1"),
				--FiZ = 2.0,
            },
            outboardLeft
        ),
        pylon(3, 0, -1.073000, -0.067000, -1.689000,
            {
				arg = 310,
				use_full_connector_position = true,--если TRUE, то читается положение из 3Дмодели, иначе - согласно координат от ц.м. в строке
				connector = "hardpoint-3",
				DisplayName = _("2"),
				FiZ = 0.0,--угол поворота по тангажу (Z) для ВСЕГО оружия, 
				--и в зависимости значения use_full_connector_position , 
				--добавляет это значение либо к позиции коннектора, либо к СГФ
            },
           inboardL
        ),
        pylon(4, 0, -1.073000, -0.139000, 1.769000,
            {
				arg = 311,
				use_full_connector_position = true,--если TRUE, то читается положение из 3Дмодели, иначе - согласно координат от ц.м. в строке
				connector = "hardpoint-4",--
				DisplayName = _("3"),
				FiZ = 0.0,--угол поворота по тангажу (Z) для ВСЕГО оружия, 
				--и в зависимости значения use_full_connector_position , добавляет это значение либо к позиции коннектора, либо к СГФ				
            },
            inboardR
        ),
        pylon(5, 0, -1.073000, -0.272000, 2.363000,
            {
				arg = 312,
				use_full_connector_position = true,
				connector = "hardpoint-5",
				DisplayName = _("4"),

            },
           outboardRight
        ),
        pylon(6, 0, -1.150000, -0.828000, 3.289000,
            {
				use_full_connector_position = true,
				connector = "hardpoint-6",
				DisplayName = _("@MSL"),

            },
           wingtips
        ),
		pylon(7, 0, 0.000, 0.000, 0.0000,
            {
				use_full_connector_position=true, connector = "GUNNER_POINT1", arg = 38 , arg_value = 0, DisplayName = _("L MG"),
            },
            {
				{ CLSID = "KORD_12_7_MI24_L", forbidden = {{station = 8, loadout = {"KORD_12_7_MI24_R"}}, 
															{station = 3, loadout = {"B_8V20A_CM"}},
															{station = 3, loadout = {"B_8V20A_OFP2"}},
															{station = 3, loadout = {"B_8V20A_OM" }},
															{station = 3, loadout = {"{UB-32A-24}"}},--UB-32A-24 pod - 32 x S-5KO
															{station = 3, loadout = {"{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}"}},--B-8V20A pod - 20 x S-8KOM
															{station = 3, loadout = {"{APU_68_S-24}"}},	--S-24
															{station = 3, loadout = {"GUV_YakB_GSHP"}},
															{station = 3, loadout = {"GUV_VOG"}}
															}, 
															arg_value = 1},
            }
        ),
		pylon(8, 0, 0.000, 0.000, 0.0000,
            {
				use_full_connector_position=true, connector = "GUNNER_POINT", arg = 86 , arg_value = 0, DisplayName = _("R MG"),
            },
            {
				{ CLSID = "KORD_12_7_MI24_R", forbidden = {{station = 7, loadout = {"KORD_12_7_MI24_L"}}, 
															{station = 4, loadout = {"B_8V20A_CM"}},
															{station = 4, loadout = {"B_8V20A_OFP2"}},
															{station = 4, loadout = {"B_8V20A_OM" }},
															{station = 4, loadout = {"{UB-32A-24}"}},--UB-32A-24 pod - 32 x S-5KO
															{station = 4, loadout = {"{6A4B9E69-64FE-439a-9163-3A87FB6A4D81}"}},--B-8V20A pod - 20 x S-8KOM
															{station = 4, loadout = {"{APU_68_S-24}"}},	--S-24
															{station = 4, loadout = {"GUV_YakB_GSHP"}},
															{station = 4, loadout = {"GUV_VOG"}}
															}, 
															arg_value = 1},
            }
        ),

    },
	
	Tasks = {
		aircraft_task(CAS),
        aircraft_task(GroundAttack),
		aircraft_task(Escort),
        aircraft_task(Transport),
        aircraft_task(AFAC),
        aircraft_task(AntishipStrike)
    },	
	DefaultTask = aircraft_task(CAS),
	
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
	
	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0	=	0.0668, -- zero AoA lift coefficient*
			Mzalfa	=	4.355, -- coefficients for pitch agility
			Mzalfadt	=	0.8,  -- coefficients for pitch agility
			kjx	=	2,--2.3, -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations)
			kjz	=	0.01,--0.0011, -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe	=	-0.014, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	=	0.02, -- coefficient, drag, gear ??
			cx_flap	=	0.06, -- coefficient, drag, full flaps
			cy_flap	=	0.35, -- coefficient, normal force, lift, flaps
			cx_brk	=	0.026, -- coefficient, drag, breaks
			table_data = 
			{	--      M		Cx0*	 	Cya*		B2		 	B4	 		Omxmax		Aldop*		Cymax*
				{ 0.0,	0.018	,	0.067	,	0.074	,	0.01 	,	0.372	,	17.3	,	1.1},		
				{ 0.1,	0.018	,	0.067	,	0.074	,	0.01 	,	0.372	,	17.3	,	1.1},
				{ 0.2,	0.0172	,	0.067	,	0.074	,	0.01	   ,	0.741	,	17.3	,	1.1},
				{ 0.3,	0.0165	,	0.067	,	0.074	,	0.01    ,	1.089	,	17.3	,	1.1},
				{ 0.4,	0.016	,	0.0682	,	0.074	,	0.01  	,	1.489	,	17.3	,	1.1},
				{ 0.5,	0.016	,	0.0708	,	0.074	,	0.01 	,	1.489	,	16.9	,	1.075},
				{ 0.6,	0.016	,	0.0746	,	0.074	,	0.01 	,	1.208	,	16.2	,	1.031},
				{ 0.7,	0.016	,	0.0798	,	0.074	,	0.01 	,	0.475	,	15.3	,	0.974},
				{ 0.8,	0.0168	,	0.0850	,	0.08 	,	0.01 	,	0.103	,	13.9	,	0.882},
				{ 0.86,	0.018	,	0.0822	,	0.082	,	0.11		,	0.028	,	12.8	,	0.815},
				{ 0.9,	0.0232	,	0.076	,	0.088	,	0.36 	,	0.008   ,	11.6	,	0.737},
				{ 0.94,	0.0402	,	0.0737	,	0.125	,	0.43	   ,	0.006	,	9.8	,	0.625},
				{ 1,	    0.0598	,	0.0735	,	0.15 	,	0.56   	,	0.004	,	8	,	0.511},
				{ 1.04,	0.063	,	0.0744	,	0.23 	,	0.84 	,	0.002	,	7.4	,	0.469},
				{ 1.2,	0.0642	,	0.0760	,	0.26 	,	1   	,	0.001 	,	6.7	,	0.425},
			}, -- end of table_data
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
			Nmg	=	35, -- RPM at idle
			MinRUD	=	0, -- Min state of the РУД
			MaxRUD	=	1, -- Max state of the РУД
			MaksRUD	=	1, -- Military power state of the РУД
			ForsRUD	=	1, -- Afterburner state of the РУД
			type	=	"TurboShaft",
			hMaxEng	=	19, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0134, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1340, --  altitude coefficient for max thrust
			dpdh_f	=	1340, --  altitude coefficient for AB thrust
			table_data = 
			{		--   M			Pmax		 Pfor	
				{ 0.0	,	26000	,	26000	},
				{ 0.1	,	26000	,	26000	},
				{ 0.2	,	24430	,	24430	},
				{ 0.3	,	23040	,	23040	},
				{ 0.4	,	22090	,	22090	},
				{ 0.5	,	21490	,	21490	},
				{ 0.6	,	21310	,	21310	},
				{ 0.7	,	21400	,	21400    },
				{ 0.8	,	22090	,	22090	},
				{ 0.86,	22780	,	22780	},
				{ 0.9	,	23300	,	23300	},
				{ 0.94,	23650	,	23650	},
				{ 1	,	24260	,	24260	},
				{ 1.04,	24600	,	24600	},
				{ 1.1	,	25640	,	25640	},
				
				
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},

	Failures = {
			{ id = 'APU_Fire',							label = _('AI-98 Tank-3 Fire'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'LeftEngine_Fire',					label = _('Left Engine Fire'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'RightEngine_Fire',					label = _('Right Engine Fire'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'MainReducer_Fire',					label = _('Main Reducer Fire'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

	Damage = {
			-------------  nose, gear
		[1]  = {critical_damage = 5, args = {147}},																	-- днище под задней кабиной		
		[59] = {critical_damage = 5, args = {148}},																	-- днище под передней кабиной 			
		[26] = {critical_damage = 4, args = {296}},																    -- блок с прицельной системой под передней кабиной		
		[7]  = {critical_damage = 4, args = {297}},																	-- пушка
  		[94] = {critical_damage = 6, args = {298}},																	-- борт передней кабины левый
		[95] = {critical_damage = 6, args = {299}},																	-- борт передней кабины правый
		[96] = {critical_damage = 6, args = {300}},																	-- борт задней кабины левый
		[97] = {critical_damage = 6, args = {301}},																	-- борт задней кабины правый		
				-------------  cabin
		[2]  = {critical_damage = 3, args = {302}},																	-- кабина передняя
		[3]  = {critical_damage = 3, args = {65}},																	-- кабина задняя
		[0]  = {critical_damage = 10, args = {146}},																-- нос и бронестекло оператора 
		[31] = {critical_damage = 10, args = {303}},																-- бронестекло задней кабины
				-------------  fuselage				
		[4]  = {critical_damage = 5, args = {150}},																	-- борт фюзеляжа с дверью левый
		[5]  = {critical_damage = 5, args = {149}},																	-- борт фюзеляжа с дверью правый
		[6]  = {critical_damage = 5, args = {152}, droppable = false},												-- днище фюзеляжа под груз. кабиной
		[9]  = {critical_damage = 5, args = {154}},																	-- борт левый перед крылом
		[10] = {critical_damage = 5, args = {153}},																	-- борт правый перед крылом
		[82] = {critical_damage = 5, args = {156}},																	-- днище, область перед нишами основного шасси
		[19] = {critical_damage = 5, args = {185}},																	-- область под блоками ЛТЦ, слева
		[20] = {critical_damage = 5, args = {183}},																	-- область под блоками ЛТЦ, справа
		[61] = {critical_damage = 5, args = {158}},																	-- борт левый за крылом, бак
		[62] = {critical_damage = 5, args = {157}},																	-- борт правый за крылом, бак		
		[58] = {critical_damage = 5, args = {159}},																	-- днище фюзеляжа перед хвостовой балкой			
				-------------  gear
		[8]  = {critical_damage = 3, args = {265}},																	-- створка передней стойки шасси	
		[83] = {critical_damage = 3, args = {134}},																	-- стойка шасси передняя
		[15] = {critical_damage = 5, args = {267}},																	-- створки основного шасси левого
		[16] = {critical_damage = 5, args = {266}},																	-- створки основного шасси правого
		[84] = {critical_damage = 5, args = {137}},																	-- стойка шасси, левая
		[85] = {critical_damage = 5, args = {136}},																	-- стойка шасси, правая
				-------------  wings
		[23] = {critical_damage = 5, args = {223}, deps_cells = {86}},												-- крыло левое, внешняя часть
		[35] = {critical_damage = 5, args = {225}, deps_cells = {23,86,87}},										-- крыло левое, внутренняя часть
		[24] = {critical_damage = 5, args = {213}, deps_cells = {89}},												-- крыло правое, внешняя часть
		[36] = {critical_damage = 5, args = {215}, deps_cells = {24,88,89}},										-- крыло правое, внутренняя часть
				-------------  engine
		[11] = {critical_damage = 5, args = {166}},																	-- двигатель левый
		[12] = {critical_damage = 5, args = {160}},																	-- двигатель правый
		[13] = {critical_damage = 5, args = {167}},																	-- область вокруг сопла, слева
		[14] = {critical_damage = 5, args = {161}},																	-- область вокруг сопла, справа
		[25] = {critical_damage = 5, args = {151}},																	-- обтекатель маслорадиатора, верхняя часть фюзеляжа 
		[99] = {critical_damage = 5, args = {155}},																	-- отсек ВСУ
				-------------  rotary parts
		[63] = {critical_damage = 20, args = {53}, deps_cells = {64,65,66,67,68,69,70,71,72,73,74,75,76,77,78}},		-- вал НВ		
		[64] = {critical_damage = 5, args = {117}, deps_cells = {65,66}},											-- Лопасть 1, внутренняя часть
		[65] = {critical_damage = 5, args = {116}, deps_cells = {66}},											-- Лопасть 1, центральная часть
		[66] = {critical_damage = 5, args = {115}},																-- Лопасть 1, внешняя часть				
		[67] = {critical_damage = 5, args = {120}, deps_cells = {68,69}},											-- Лопасть 2, внутренняя часть
		[68] = {critical_damage = 5, args = {119},	deps_cells = {69}},												-- Лопасть 2, центральная часть
		[69] = {critical_damage = 5, args = {118}},																	-- Лопасть 2, внешняя часть
		[70] = {critical_damage = 5, args = {123}, deps_cells = {71,72}},											-- Лопасть 3, внутренняя часть
		[71] = {critical_damage = 5, args = {122}, deps_cells = {72}},												-- Лопасть 3, центральная часть
		[72] = {critical_damage = 5, args = {121}},																	-- Лопасть 3, внешняя часть
		[73] = {critical_damage = 5, args = {126}, deps_cells = {74,75}},											-- Лопасть 4, внутренняя часть
		[74] = {critical_damage = 5, args = {125}, deps_cells = {75}},												-- Лопасть 4, центральная часть
		[75] = {critical_damage = 5, args = {124}},																	-- Лопасть 4, внешняя часть
		[76] = {critical_damage = 5, args = {129}, deps_cells = {77,78}},											-- Лопасть 5, внутренняя часть
		[77] = {critical_damage = 5, args = {128}, deps_cells = {78}},												-- Лопасть 5, центральная часть
		[78] = {critical_damage = 5, args = {127}},																	-- Лопасть 5, внешняя часть
		[54] = {critical_damage = 5, args = {54}},																	-- хвостовой винт		
				-------------  tail
		[56] = {critical_damage = 5, args = {235}},																	-- хвостовая балка, первая треть, слева
		[57] = {critical_damage = 5, args = {233}},																	-- хвостовая балка, первая треть, справа
		[100] = {critical_damage = 5, args = {303}},																-- хвостовая балка, первая треть, верхняя часть
		[43] = {critical_damage = 5, args = {246}},																	-- хвостовая балка, вторая треть, слева
		[44] = {critical_damage = 5, args = {243}},																	-- хвостовая балка, вторая треть, справа
		[55] = {critical_damage = 8, args = {81}, deps_cells = {39,40,41,42,43,44,47,48,54}},						-- хвостовая балка, вторая треть, верхняя часть,отрыв балки
		[41] = {critical_damage = 5, args = {245}},																	-- хвостовая балка, третья треть, слева
		[42] = {critical_damage = 5, args = {242}},																	-- хвостовая балка, третья треть, справа
		[39] = {critical_damage = 5, args = {61}},																	-- киль, нижняя часть
		[40] = {critical_damage = 5, args = {62}},																	-- киль, верхняя часть		
		[47] = {critical_damage = 5, args = {236}},																	-- стабилизатор левый 
		[48] = {critical_damage = 5, args = {234}},																	-- стабилизатор правый
				-------------  pylons
		[86] = {critical_damage = 5, args = {}},						-- пилон 1
		[87] = {critical_damage = 5, args = {}},						-- пилон 2
		[88] = {critical_damage = 5, args = {}},						-- пилон 3
		[89] = {critical_damage = 5, args = {}},						-- пилон 4		
				-------------  crew	
		[90] = {critical_damage = 5, args = {459}},						-- пилот
		[91] = {critical_damage = 5, args = {460}},						-- оператор	
		[92] = {critical_damage = 5, args = {461}},						-- бортстрелок правый	
		[93] = {critical_damage = 5, args = {462}},						-- бортстрелок левый
	},
	
	DamageParts = 
	{  
	[1] = "mi-24p_wing_r",
	[2] = "mi-24p_wing_l",
	[4] = "mi-24p_tail",
	[5] = "mi-24p_blade",
	},

    lights_data = {
        typename = "collection",
        lights =  {
            [WOLALIGHT_BEACONS] =  {
                typename = "collection",
                lights = {
                    {
                        typename = "RotatingBeacon", connector = "RED_BEACON", argument = 83,
                        proto = lamp_prototypes.MSL_3_2,
                    },
                },
            },
            [WOLALIGHT_SPOTS] = {
                typename = "collection",
                lights = {
                    {
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
					{
						typename = "argumentlight", argument = 209,
					},
					{
						typename = "argumentlight", argument = 208,
					},
                },
            },
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- navigation lights combo
                        typename = "argumentlight", argument = 191,
                    },    
					{ -- gear nose light
                        typename = "argumentlight", argument = 210,
                    },
					{  -- gear right light
                        typename = "argumentlight", argument = 211,
                        --exposude = {{0, 0.5, 0.6}}, movable = true,
                    },         
					{ -- gear left light
                        typename = "argumentlight", argument = 212,
                    },
				},
            },
            [WOLALIGHT_FORMATION_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- formation lights
                        typename = "argumentlight", argument = 200,
                    },
                },
            },
            [WOLALIGHT_TIPS_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- rotor tips lights
                        typename = "argumentlight", argument = 47,
                    },
                },
            },
        }, -- end of lights
    },-- end of lights_data

	AddPropAircraft = {			
			{ id = "LeftEngineResource", control = 'slider', xCtrl = 195, label = _('Left Engine Resource'), defValue = 90, min = 40, max = 100, dimension = '%',playerOnly = true},
			{ id = "RightEngineResource", control = 'slider', xCtrl = 195, label = _('Right Engine Resource'), defValue = 90, min = 40, max = 100, dimension = '%',playerOnly = true},
			{ id = "ExhaustScreen" , control = 'checkbox', label = _('Exhaust Dispenser'), defValue = true, weight = 160, arg = 457},
			{ id = "NS430allow" , control = 'checkbox', label = _('NS 430 allow'), defValue = true},
			{ id = "PilotNVG" , control = 'checkbox', label = _('Allow Pilots NVG'), defValue = true},
			{ id = "OperatorNVG" , control = 'checkbox', label = _('Allow Operators NVG'), defValue = true},
			{ id = "R60equipment" , control = 'checkbox', label = _('R-60 equipment'), defValue = true,
				weaponRestricted= { ["{APU-60-1_R_60M}"] = true,  -- true - оружие разрешено при установленной галке
									["{275A2855-4A79-4B2D-B082-91EA2ADF4691}"] = true,
									["{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}"] = true,
				},
			},
						-- AI HELPER SECTION
			{ id = "mul_Label", control = 'label', label = _('AI HELPER'), xLbl = 150,},
			{ id = "OverrideIFF", control = 'comboList', label = _('AI IFF Detection Mode'), playerOnly = true,
				values = {{id = 0, dispName = _("Auto")},
					{id = 1, dispName = _("Simple")},
					{id = 2, dispName = _("Label Only")},
					{id = 3, dispName = _("Realistic")}
				},
				defValue  = 0,
				wCtrl     = 150,
			},
			{ id = "GunnersAISkill" , control = 'slider', xCtrl = 195, label = _('Gunners AI Skill'), defValue = 90, min = 10, max = 100, dimension = '%'},
			{ id = "SimplifiedAI" , control = 'checkbox', label = _('Simplified AI'), defValue = false},
			{ id = "HideAngleBoxes" , control = 'checkbox', label = _('Hide boxes in Pilot AI menu'), defValue = false},
			{ id = "TrackAirTargets" , control = 'checkbox', label = _('Track air targets'), defValue = true},
						-- MULTIPLAYER SECTION
			{ id = "mul_Label", control = 'label', label = _('MULTIPLAYER'), xLbl = 150,},	
			{ id = "NetCrewControlPriority" , control = 'comboList', label = _('Aircraft Control Priority'), playerOnly = true,
				values = {{id =  0, dispName = _("Pilot")},
					{id =  1, dispName = _("Copilot-gunner")},
					{id = -1, dispName = _("Ask Always")},
					{id = -2, dispName = _("Equally Responsible")}
				},
				defValue  = 0,
				wCtrl     = 150,
			},
			{ id = "HumanOrchestra" , control = 'checkbox', label = _('Disable Multicrew'), defValue = false},
	},
	input_profile_entry = "Mi-24P_pilot",
--	ViewSettings = ViewSettings,
--	SnapViews    = SnapViews,
}

--[[if ED_PUBLIC_AVAILABLE then		

	table.remove(Mi_24P.Pylons)
	table.remove(Mi_24P.Pylons)
	
	Mi_24P.crew_size	=	2
	table.remove(Mi_24P.crew_members)
end]]

add_aircraft(Mi_24P)