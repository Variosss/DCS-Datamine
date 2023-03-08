--mounting 3d model paths and texture paths

dofile(current_mod_path.."/WEAPONS/M2KC_BLG66.lua")
dofile(current_mod_path.."/WEAPONS/M2KC_BAP100.lua")
dofile(current_mod_path.."/WEAPONS/M2KC_FACTICE.lua")
dofile(current_mod_path.."/WEAPONS/M2KC_ECLAIR.lua")
dofile(current_mod_path.."/WEAPONS/M2KC_RP.lua")
dofile(current_mod_path.."/WEAPONS/M2KC_Weapons.luac")
dofile(current_mod_path.."/WEAPONS/M2KC_RACKS.lua")


function pylon_loadout(clsid, arg_value, arg_increment, attach_point_position, required, forbidden, Cx_gain)
	result = {}
	result['CLSID'] = clsid
	if arg_value then
		result['arg_value'] = arg_value
	end
	if arg_increment then
		result['arg_increment'] = arg_increment
	end
	if attach_point_position then
		result['attach_point_position'] = attach_point_position
	end
	if required then
		reqlist = {}
		for i, pylon in ipairs(required) do
			reqlist[#reqlist+1]= {station = pylon, loadout = {clsid}}
		end	
		result['required'] = reqlist
	end
	
	if forbidden then
		forblist = {}
		for i, pylon in ipairs(forbidden) do
			forblist[#forblist+1]= {station = pylon}
		end	
		result['forbidden'] = forblist
	end
	
	if Cx_gain~=nil then
		result['Cx_gain'] = Cx_gain
	end	
	
	return result
end

local id_MAG   = "{MMagicII}"
local id_MAGDM = "{MMagicII_DDM}"
local id_S530D = "{Matra_S530D}"
local id_MK82  = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"
local id_MK82S = "{Mk82SNAKEYE}"
local id_MK82A = "{Mk82AIR}"
local id_BLG66 = "{BLG66_BELOUGA_AC}"
local id_SM25L = "{SAMP250LD}"
local id_SM25H = "{SAMP250HD}"

local id_6xBP100 = "{M2KC_BAP100_6_RACK}"
local id_12xBP100 = "{M2KC_BAP100_12_RACK}"
local id_18xBP100 = "{M2KC_BAP100_18_RACK}"

local id_GBU12 = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}"
local id_GBU16 = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}"
local id_GBU24 = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}"
local id_SMK_R = "{A4BCC903-06C8-47bb-9937-A30FEDB4E741}"
local id_SMK_G = "{A4BCC903-06C8-47bb-9937-A30FEDB4E742}"
local id_SMK_B = "{A4BCC903-06C8-47bb-9937-A30FEDB4E743}"
local id_SMK_W = "{A4BCC903-06C8-47bb-9937-A30FEDB4E744}"
local id_SMK_Y = "{A4BCC903-06C8-47bb-9937-A30FEDB4E745}"
local id_SMK_O = "{A4BCC903-06C8-47bb-9937-A30FEDB4E746}"
local id_RKTS  = "{Matra155RocketPod}"

local id_2xGBU12 = "{M2KC_RAFAUT_GBU12}"
local id_2xMK82  = "{M2KC_RAFAUT_MK82}"
local id_2xMK82S = "{M2KC_RAFAUT_MK82S}"
local id_2xMK82A = "{M2KC_RAFAUT_MK82A}"
local id_2xBLG66 = "{M2KC_RAFAUT_BLG66}"
local id_2xSM25L = "{M2KC_RAFAUT_SAMP250LD}"
local id_2xSM25H = "{M2KC_RAFAUT_SAMP250HD}"

local id_RPL522   = "{M2KC_RPL_522}"
local id_RPL522E  = "{M2KC_RPL_522_EMPTY}"
local id_RPL541L  = "{M2KC_02_RPL541}"
local id_RPL541LE = "{M2KC_02_RPL541_EMPTY}"
local id_RPL541R  = "{M2KC_08_RPL541}"
local id_RPL541RE = "{M2KC_08_RPL541_EMPTY}"



M_2000C =  {

	--Name 				=   'Mirage 2000C',
	Name 				=   'M-2000C',
	DisplayName			= _('M-2000C'),
	ViewSettings		= ViewSettings,

	Picture 			= "M-2000C.png",
	Rate 				= 50, -- RewardPoint in Multiplayer
	Shape 				= "m-2000c",

	shape_table_data 	=
	{
		{
			file  	 = 'M-2000C';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'M-2000C_destr'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'M-2000C';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  = "M-2000C_destr";
			file  = "M-2000C_destr";
			fire  = { 240, 2};
		},

	},
	-------------------------
	-- add model draw args for network transmitting to this draw_args table (32 limit)
	net_animation = 
	{
		21,  --  DRAG_CHUTE_UNLOCK
		35,  --  DRAG_CHUTE
		38,  --  CANOPY ANGLE
		49,  --  NAV_LIGHTS
		51,  --  LANDING_LIGHTS
		83,  --  STROBE_LIGHT_TOP
		88,  --  FORM_LIGHTS
		99,  --  HEAD UP/DOWN
		190, --  LEFT_NAV_LIGHT
		191, --  TAIL_NAV_LIGHT
		192, --  RIGHT_NAV_LIGHT
		200, --  FORM_LIGHTS
		208, --  LANDING_LIGHT
		209, --  TAXI_LIGHT
		334, --  DRAG_CHUTE_VERTICAL
		335, --  DRAG_CHUTE_HORIZONTAL
		336, --  DRAG_CHUTE_CAP
		373, --  INTERNAL AB GLOW
		802, --  STRONG_LIGHT_BOTTOM
		902, --  REFUEL LIGHT MOVE
		903, --  REFUEL LIGHT INTAKE
		904, --  REFUEL LIGHT NOSE
		905, --  POLICE LIGHT
        182, --  LEFT_AIRBRAKE
        184, --  RIGHT_AIRBRAKE
        900, --  LEFT_INTAKE_SCOOP
        901, --  RIGHT_INTAKE_SCOOP
        13,  --  RIGHT_INNER_SLAT
        14,  --  LEFT_INNER_SLAT
        131, --  RIGHT_OUTER_SLAT
        133, --  LEFT_OUTER_SLAT
        90,  --  NOZZLE
        86,  --  SOURIS
		1000,--  SMOKE AND EFFECTS
		1001,--  GROUND POWER UNIT
		1002,--  ENGINE BEARING DAMAGE

		--[]=906, --  PILOT VISOR
	},
	
	-------------------------
	mapclasskey	= "P0091000024",
	attribute	= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Multirole fighters", "Refuelable" },
	Categories 	= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	-------------------------
	M_empty 					= 7600.0,	-- with pilot and nose load, kg
	M_nominal 					= 10650.0,	-- kg (Empty Plus Full Internal Fuel)
	M_max 						= 16500.0,	-- kg (Maximum Take Off Weight)
	M_fuel_max 					= 3165.0,	-- kg (Internal Fuel Only)
	H_max 			 			= 17526,	-- m  (Maximum Operational Ceiling)
	average_fuel_consumption 	= 0.25,  	-- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 30.0,   	-- Other documents state this is minimum Loiter Time
	V_opt 						= 250.0,	-- Cruise speed (m/s) (for AI)
	V_take_off 					= 81.3,    	-- Take off speed in m/s (for AI)
	V_land 						= 82.3,    	-- Land speed in m/s (for AI)
	V_max_sea_level 			= 400,   	-- Max speed at sea level in m/s (for AI)
	V_max_h 					= 660,   	-- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 304,    	-- Max climb speed in m/s (for AI)
	Mach_max 					= 2.2,   	-- Max speed in Mach (for AI)
	Ny_min 						= -3.0,  	-- Min G (for AI)
	Ny_max 						= 8.0,     	-- Max G (for AI)
	Ny_max_e 					= 8.0,     	-- Max G (for AI)
	AOA_take_off 				= 0.175,  	-- AoA in take off (for AI)
	bank_angle_max 				= 60,    	-- Max bank angle (for AI)
	has_afteburner 				= true,  	-- AFB yes/no
	has_speedbrake 				= true,  	-- Speedbrake yes/no
	has_differential_stabilizer = false,
	radar_can_see_ground		= false,
	stores_number				= 9,
	brakeshute_name				= 2,		-- Landing - brake chute visual shape after separation
	-----------------------------------------------------------------------
	----------------- SUSPENSION CODE BEGINS
	-----------------------------------------------------------------------

	tand_gear_max 							 = 2.1445,	-- tangent on maximum yaw angle of front wheel, 65 degrees tan(64deg)

	nose_gear_pos 							 = {2.9,-1.5, 0.0},		-- nosegear coord
	nose_gear_wheel_diameter				 =  0.35 * 2.0,		-- in m
	nose_gear_amortizer_direct_stroke        =  0.220,  	    -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke      = -0.015,		-- up
	nose_gear_amortizer_normal_weight_stroke =  0.1,		-- down from nose_gear_pos
	
	main_gear_pos 							 = {-1.9,-1.5, 1.75},	-- main gear coords
	main_gear_wheel_diameter				 =  0.45 * 2.0,				-- in m
	main_gear_amortizer_direct_stroke        =  0.21,		-- down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke      = -0.01, 		-- up
	main_gear_amortizer_normal_weight_stroke =  0.0,				-- down from main_gear_pos

	-----------------------------------------------------------------------
	----------------- SUSPENSION CODE ENDS
	-----------------------------------------------------------------------

	tanker_type 				= 4,		-- Tanker type if the plane is airrefuel capable (same type as F-14, aka drogue basket)
	is_tanker 					= false,	-- Tanker yes/no
	air_refuel_receptacle_pos 	= {5.436, 1.027, 0.409}, -- refuel coords

	wing_area 					= 41.4,		-- wing area in m2
	wing_span 					= 9.13,		-- wing spain in m
	wing_type 					= 0,		-- Fixed wing
	flaps_maneuver 				= 0.5,		-- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)

	thrust_sum_max 				= 6556.77,	-- thrust in kgf (64.3 kN)
	thrust_sum_ab 				= 9697.50,	-- thrust in kgf (95.1 kN)

	length 						= 14.36,	-- full lenght in m
	height 						= 5.20,		-- height in m
	range 						= 1550,		-- Max range in km (for AI)
	RCS 						= 4.0,		-- Radar Cross Section m2
	IR_emission_coeff 			= 0.8,		-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 1.62,		-- With afterburner
	wing_tip_pos 				= { -5.0, -0.100, 4.565}, -- wingtip coords for visual effects

	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] =
		{
			pos 				=  {-6.585, 0.525, 0.000},	-- nozzle coords
			elevation   		=  0, 						-- AFB cone elevation
			diameter	 		= 1.30,						-- AFB cone diameter
			exhaust_length_ab   = 9,						-- lenght in m
			exhaust_length_ab_K = 0.7,						-- AB animation
			smokiness_level		= 0.2,
		}, -- end of [1]
	}, -- end of engines_nozzles
	
	crew_size	 = 1,
	crew_members =
	{
		[1] =
		{
			ejection_seat_name		= "M-2000C_pilotseat",
			pilot_name		   		= "M-2000C_pilot",
			drop_canopy_name		= "M-2000c_canopy",
			drop_parachute_name 	= "M-2000C_parachute",
			pos						= {2.679, 0.512, 0.0, },
			g_suit 			    	=  5.0,
			bailout_arg 			= -1,
		}, -- end of [1]
	}, -- end of crew_members

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.9, "in", 5.0},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"VelType", 3}, {"Arg", 38, "to", 0.0, "in", 3.0},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"Arg", 909, "set", 1.0},},},},},
        },
        ServiceHatches = {
            {Transition = {"Close", "Open"}, Sequence = {{C = {{"PosType", 3}, {"Sleep", "for", 30.0}}}, {C = {{"Arg", 24, "set", 1.0}}}}},
            {Transition = {"Open", "Close"}, Sequence = {{C = {{"PosType", 6}, {"Sleep", "for", 5.0}}}, {C = {{"Arg", 24, "set", 0.0}}}}},
        },
        CrewLadder = {
            {Transition = {"Dismantle", "Erect"}, Sequence = {
                {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
                {C = {{"Arg", 91, "set", 1.0}}},
                {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
            }},
            {Transition = {"Erect", "Dismantle"}, Sequence = {
                {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
                {C = {{"Arg", 91, "set", 0.0}}},
                {C = {{"PosType", 6}, {"Sleep", "for", 10.0}}},
            }},
        },
    }, -- end of mechanimations

	fires_pos =
		{
			[1] = 	{-3.484, -0.004, -0.149}, -- After maingear, fuselage bottom
			[2] = 	{-2.518,  0.055,  1.216}, -- Wing inner Left
			[3] = 	{-2.518,  0.055, -1.216}, -- Wing inner Right
			[4] = 	{-6.250,  0.525,  0.000}, -- Engine damage big
			[5] = 	{-6.750,  0.525,  0.000}, -- Engine damage small
			[6] = 	{-2.346, -0.448,  0.000}, -- Air intake bottom L
			[7] = 	{ 2.346, -0.448,  0.000}, -- Air intake bottom R
		}, -- end of fires_pos
        
    effects_presets = {		
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/M-2000C_overwingVapor.lua"},
	},

	-- Countermeasures
	Countermeasures = {
		ECM = "AN/ALQ-135"
	},

	passivCounterm = {
		CMDS_Edit = false,
 		SingleChargeTotal = 21*8*18,	--What the fuck
		chaff = {default = 234, increment = 18, chargeSz =  8},
		flare = {default =  64, increment =  8, chargeSz = 18},
	},

	chaff_flare_dispenser 	= {
		[1] = { dir =  {0, -1, -1}, pos =  {-5.232,   0.170, -0.573}, }, -- 0 L
		[2] = { dir =  {0, -1,  1}, pos =  {-5.232,   0.170,  0.573}, }, -- 1 R
		[3] = { dir =  {0, -1,  0}, pos =  {-5.000,  -0.300,  0.000}, }, -- 2 Eclair 
		[4] = { dir =  {0, -1,  0}, pos =  {-5.000,  -0.300,  0.000}, }, -- 3 Dummy
	},

	--sensors
	detection_range_max		 = 120,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	
	CanopyGeometry = {
		azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation = {-50.0, 90.0} -- pilot view vertical (AI)
	},

	Sensors = {
		RWR = "Abstract RWR", -- RWR type
		RADAR = "RDY",        -- Radar type
	},

	Guns = {
		--gun_mount("DEFA_554", { count = 125 },{muzzle_pos_connector = "GUN_POINT_L", muzzle_pos = {1.389,  0.325, -0.241}}),
		--gun_mount("DEFA_554", { count = 125 },{muzzle_pos_connector = "GUN_POINT_R", muzzle_pos = {1.389, -0.325, -0.241}})
		defa554({muzzle_pos = { 0.0, -1.0,  0.325 },elevation_initial	 = -1.3, muzzle_pos_connector = "GUN_POINT_R"}), --right 
		defa554({muzzle_pos = { 0.0, -1.0, -0.325 },elevation_initial	 = -1.3, muzzle_pos_connector = "GUN_POINT_L"}), --left 
		
	},
	ammo_type ={ _("30mm AP"),
        _("30mm AP Tracers")},

	Pylons = {
		-- LEFT WING
		pylon(1, 0, -3.086, -0.587, 3.311, {use_full_connector_position=true, connector = "str_pnt_001", arg = 308, arg_value = 0},
			{	
				pylon_loadout(id_MAG  , 0.15, nil,	nil, 		{ 9 }, nil, 0.6),	-- Matra Magic R.550
				pylon_loadout(id_MAGDM, 0.25, nil,	nil, 		{ 9 }),				-- Matra Magic R.550 with DDM
				pylon_loadout(id_RKTS , 0.15, nil,	nil,		{ 9 }), 			-- Rockets
				pylon_loadout(id_SMK_R, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder red
				pylon_loadout(id_SMK_G, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder green
				pylon_loadout(id_SMK_B, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder blue
				pylon_loadout(id_SMK_W, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder white
				pylon_loadout(id_SMK_Y, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder yellow
				pylon_loadout(id_SMK_O, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder orange
			}
		),
		
		pylon(2, 0, -1.809, -0.556, 2.333, {use_full_connector_position=true, connector = "str_pnt_002", arg = 309, arg_value = 0},
			{
				--Air-to-Air
				pylon_loadout(id_MAG  ,	  0.45, nil, nil, 				  { 8 }, nil, 0.6), -- Matra Magic R.550
				pylon_loadout(id_S530D,	  0.15, nil, {0.0, -0.13, 0.0},	  { 8 }, nil, 0.35), -- Matra Super 530D
				pylon_loadout(id_RKTS ,	  0.25, nil, nil, 				  { 8 }), -- Rockets
				pylon_loadout(id_MK82 ,	  0.35, nil, {-0.13, -0.14, 0.0}, { 8 }), -- MK-82
				pylon_loadout(id_MK82S,	  0.35, nil, {-0.13, -0.14, 0.0}, { 8 }), -- MK-82 Snakeye
				pylon_loadout(id_MK82A,	  0.35, nil, {-0.13, -0.14, 0.0}, { 8 }), -- MK-82 Air
				pylon_loadout(id_BLG66,	  0.35, nil, nil, 				  { 8 }), -- BLG-66 Belouga
				pylon_loadout(id_SM25L,   0.35, nil, {-0.28, -0.16, 0.0}, { 8 }, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H,   0.35, nil, {-0.33, -0.16, 0.0}, { 8 }, nil, 0.14), -- SAMP-250 HD

				pylon_loadout(id_2xMK82 , 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- MK-82 x2
				pylon_loadout(id_2xMK82S, 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- MK-82S x2
				pylon_loadout(id_2xMK82A, 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- MK-82S x2
				pylon_loadout(id_2xBLG66, 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- BLG66 x2
				pylon_loadout(id_2xSM25L, 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- SAMP-250 LD x2
				pylon_loadout(id_2xSM25H, 0.35, nil, {0.015, 0.036, 0.0}, { 8 }), --- SAMP-250 HD x2

				
				--Fuel tanks
				{CLSID = id_RPL541L,  required = {{station = 8,loadout = {id_RPL541R}}} }, 	-- RPL 541 Fuel Tank
				{CLSID = id_RPL541LE, required = {{station = 8,loadout = {id_RPL541RE}}} }, -- RPL 541 Fuel Tank
			}
		),
		
		-- LEFT WING ROOT
		pylon(3, 0,  0.870,  -0.467, 0.779,{use_full_connector_position=true, connector = "str_pnt_003", arg = 310, arg_value = 0},
			{
				pylon_loadout(id_MK82 , 0.15, nil, {-0.13, -0.14, 0.0}, {4, 6, 7}), -- MK-82
				pylon_loadout(id_MK82S, 0.15, nil, {-0.13, -0.14, 0.0}, {4, 6, 7}), -- MK-82 Snakeye
				pylon_loadout(id_MK82A, 0.15, nil, {-0.13, -0.14, 0.0}, {4, 6, 7}), -- MK-82 Air 
				pylon_loadout(id_BLG66, 0.15, nil, {-0.005,0.021, 0.0}, {4, 6, 7}), -- BLG-66 Belouga Cluster bomb
				pylon_loadout(id_GBU12, 0.15, nil, {0.30,  -0.14, 0.0}, {7},{4,6}), -- GBU-12
				pylon_loadout(id_SM25L, 0.15, nil, {-0.28, -0.15, 0.0},	{4, 6, 7}, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H, 0.15, nil, {-0.33, -0.15, 0.0}, {4, 6, 7}, nil, 0.14), -- SAMP-250 HD
			}
		), 
		
		pylon(4, 0, -3.115, -0.467, 1.080, {use_full_connector_position=true, connector = "str_pnt_004", arg = 311, arg_value = 0},
			{
				pylon_loadout(id_MK82 , 0.15, nil, {-0.13, -0.14, 0.0}, {3, 6, 7}), -- MK-82
				pylon_loadout(id_MK82S, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 6, 7}), -- MK-82 Snakeye
				pylon_loadout(id_MK82A, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 6, 7}), -- MK-82 Air 
				pylon_loadout(id_BLG66, 0.15, nil, {-0.04,  0.02, 0.0}, {3, 6, 7}), -- BLG-66 Belouga Cluster bomb
				pylon_loadout(id_SM25L, 0.15, nil, {-0.28, -0.16, 0.0},	{3, 6, 7}, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H, 0.15, nil, {-0.33, -0.16, 0.0},	{3, 6, 7}, nil, 0.14), -- SAMP-250 HD
			}
		),
		
		-- CENTER FUSELAGE
		pylon(5, 0, -1.075, -0.589, 0.000, {use_full_connector_position=true, connector = "str_pnt_005", arg = 312, arg_value = 0},
			{
				pylon_loadout(id_BLG66, 0.25), -- BLG-66 Belouga
				pylon_loadout(id_GBU12, 0.25), -- GBU-12
				pylon_loadout(id_GBU16, 0.25), -- GBU-16
				pylon_loadout(id_GBU24, 0.25), -- GBU-24

				pylon_loadout(id_6xBP100,  0.25, nil, {0.1,  0.02,  0.0}), -- BAP-100 x6
				pylon_loadout(id_12xBP100, 0.25, nil, {0.1,  0.02,  0.0}), -- BAP-100 x12
				pylon_loadout(id_18xBP100, 0.25, nil, {0.1,  0.02,  0.0}), -- BAP-100 x18
				pylon_loadout(id_2xGBU12,  0.25, nil, {-0.07,  0.02,  0.0}), -- GBU-12 x2
				
				pylon_loadout(id_RPL522, 0.15), -- RPL 522 FUEL TANK
				pylon_loadout(id_RPL522E, 0.15), -- RPL 522 EMPTY FUEL TANK
				
				-- Smoke Generators
				pylon_loadout(id_SMK_R, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder red
				pylon_loadout(id_SMK_G, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder green
				pylon_loadout(id_SMK_B, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder blue
				pylon_loadout(id_SMK_W, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder white
				pylon_loadout(id_SMK_Y, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder yellow
				pylon_loadout(id_SMK_O, 0.15, -0.1, nil, nil, {2,3,4,6,7,8}), -- Smokewinder orange
			}
		),
		
		-- RIGHT WING ROOT
		pylon(6, 0, -3.115, -0.467, -1.080, {use_full_connector_position=true, connector = "str_pnt_007", arg = 314, arg_value = 0},
			{
				pylon_loadout(id_MK82 , 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 7}), -- MK-82
				pylon_loadout(id_MK82S, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 7}), -- MK-82 Snakeye
				pylon_loadout(id_MK82A, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 7}), -- MK-82 Air 
				pylon_loadout(id_BLG66, 0.15, nil, {-0.04,  0.02, 0.0}, {3, 4, 7}), -- BLG-66 Belouga Cluster bomb
				pylon_loadout(id_SM25L, 0.15, nil, {-0.28, -0.16, 0.0},	{3, 4, 7}, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H, 0.15, nil, {-0.33, -0.16, 0.0},	{3, 4, 7}, nil, 0.14), -- SAMP-250 HD
			}
		),
		
		pylon(7, 0,  0.870, -0.467, -0.779,{use_full_connector_position=true, connector = "str_pnt_006", arg = 313, arg_value = 0},
			{
				pylon_loadout(id_MK82 , 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 6}), -- MK-82
				pylon_loadout(id_MK82S, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 6}), -- MK-82 Snakeye
				pylon_loadout(id_MK82A, 0.15, nil, {-0.13, -0.14, 0.0}, {3, 4, 6}), -- MK-82 Air 
				pylon_loadout(id_BLG66, 0.15, nil, {-0.005,0.021, 0.0}, {3, 4, 6}), -- BLG-66 Belouga Cluster bomb
				pylon_loadout(id_GBU12, 0.15, nil, {0.30,  -0.14, 0.0}, {3},{4,6}), -- GBU-12
				pylon_loadout(id_SM25L, 0.15, nil, {-0.28, -0.15, 0.0},	{3, 4, 6}, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H, 0.15, nil, {-0.33, -0.15, 0.0}, {3, 4, 6}, nil, 0.14), -- SAMP-250 HD
			}
		),
		
		-- RIGHT WING
		pylon(8, 0, -1.809, -0.556, -2.333, {use_full_connector_position=true, connector = "str_pnt_008", arg = 315, arg_value = 0},
			{
				pylon_loadout(id_MAG  , 0.45, nil, nil, 				{ 2 }, nil, 0.6), -- Matra Magic R.550
				pylon_loadout(id_S530D, 0.15, nil, {0.0, -0.13, 0.0}, 	{ 2 }, nil, 0.35), -- Matra Super 530D
				pylon_loadout(id_RKTS , 0.25, nil, nil,					{ 2 }), -- Rockets
				pylon_loadout(id_MK82 , 0.35, nil, {-0.13, -0.14, 0.0}, { 2 }), -- MK-82
				pylon_loadout(id_MK82S, 0.35, nil, {-0.13, -0.14, 0.0}, { 2 }), -- MK-82 Snakeye
				pylon_loadout(id_MK82A, 0.35, nil, {-0.13, -0.14, 0.0}, { 2 }), -- MK-82 Air
				pylon_loadout(id_BLG66, 0.35, nil, nil, 				{ 2 }), -- BLG-66 Belouga
				pylon_loadout(id_SM25L, 0.35, nil, {-0.28, -0.16, 0.0},	{ 2 }, nil, 0.14), -- SAMP-250 LD
				pylon_loadout(id_SM25H, 0.35, nil, {-0.33, -0.16, 0.0},	{ 2 }, nil, 0.14), -- SAMP-250 HD
				
				pylon_loadout(id_2xMK82 , 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- MK-82 x2
				pylon_loadout(id_2xMK82S, 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- MK-82S x2
				pylon_loadout(id_2xMK82A, 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- MK-82S x2
				pylon_loadout(id_2xBLG66, 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- BLG66 x2
				pylon_loadout(id_2xSM25L, 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- SAMP-250 LD x2
				pylon_loadout(id_2xSM25H, 0.35, nil, {0.015, 0.036, 0.0}, { 2 }), --- SAMP-250 HD x2
				
				--Fuel Tanks
				{CLSID = id_RPL541R,  required = {{station = 2,loadout = {id_RPL541L}}} }, 	-- RPL 541 Fuel Tank
				{CLSID = id_RPL541RE, required = {{station = 2,loadout = {id_RPL541LE}}} }, -- RPL 541 Fuel Tank
			}
		),
		
		pylon(9, 0,  -3.086, -0.587, -3.311, {use_full_connector_position=true, connector = "str_pnt_009", arg = 316, arg_value = 0},
			{
				pylon_loadout(id_MAG  , 0.15, nil,	nil,		{ 1 }, nil, 0.6),	-- Matra Magic R.550
				pylon_loadout(id_MAGDM, 0.25, nil,	nil,		{ 1 }),				-- Matra Magic R.550 with DDM
				pylon_loadout(id_RKTS , 0.15, nil, nil,			{ 1 }), 			-- Rockets
				
				-- Smoke Generators
				pylon_loadout(id_SMK_R, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder red
				pylon_loadout(id_SMK_G, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder green
				pylon_loadout(id_SMK_B, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder blue
				pylon_loadout(id_SMK_W, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder white
				pylon_loadout(id_SMK_Y, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder yellow
				pylon_loadout(id_SMK_O, 0.15, -0.1, nil, nil,	{2,3,4,6,7,8}), 	-- Smokewinder orange
			}
		),
				
		pylon(10, 0,  -5.086, -0.587, 0.0, {use_full_connector_position=true, connector = "str_pnt_010", arg = 317, arg_value = 0},
			{	
			{CLSID = "{Eclair}", arg_value = 0.40},
			{CLSID = "{EclairM_06}", arg_value = 0.40},
			{CLSID = "{EclairM_15}", arg_value = 0.40},
			{CLSID = "{EclairM_24}", arg_value = 0.40},
			{CLSID = "{EclairM_33}", arg_value = 0.40},
			{CLSID = "{EclairM_42}", arg_value = 0.40},
			{CLSID = "{EclairM_51}", arg_value = 0.40},
			{CLSID = "{EclairM_60}", arg_value = 0.40},
			} -- Eclair Pod
		),

		pylon(11, 0,  0.0, 0.0, 0.0, {use_full_connector_position=true, connector = "str_pnt_010", arg = nil, arg_value = 0},
			{
				{CLSID = "{M2KC_AGF}", arg_value = 0.00},
				--{CLSID = "{M2KC_AAF}", arg_value = 0.00},
			}
		),

	},

	Tasks = {
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(PinpointStrike),
        aircraft_task(CAS),
		aircraft_task(AFAC),
		aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
    },

	DefaultTask = aircraft_task(CAP),

	SFM_Data = {
		aerodynamics =
		{
		---------------------------------------------------------------------------
		----- SFM Basic Data
		---------------------------------------------------------------------------
			Cy0	=	0,			--- This makes more sense, prevents odd pitch up, that flight controller would normally handle
			Mzalfa	=	6.6,	--- 
			Mzalfadt	=	1,	--- pitch agility mine 5.23
			kjx	=	2.85,       --- roll inertia
			kjz	=	0.00125,    --- pitch inertia
			Czbe	=	-0.012, --- 
			cx_gear	=	0.02,   --- 
			cx_flap	=	0.05,   --- 
			cy_flap	=	0.6,  	--- 
			cx_brk	=	0.025, 	--- 

			-------------------- Drag Polar Coefficients:
			-- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
			-- It appears this really provides us with a good way to tune turn rate performance
			-- and provides us with how much drag we build up for a given amount of lift we make
			-- Drag polars were tuned from the flight manual and testing with correct max sustained
			-- turn rate
			-------------------- Roll rate taken directly from performance charts
			table_data =
			{
			--	M		Cx0			Cya		B		B4		Omxmax	Aldop		Cymax
				{0,	 	0.0100,		0.081,	0.1500,	0.1100,	0.500,	24.0,	1.280},
				{0.05, 	0.0100,		0.079,	0.1500,	0.1000,	1.000,	29.0,	1.140},
				{0.1,	0.0100,		0.074,	0.1500,	0.0900,	2.800,	17.0,	1.070},
				{0.2,	0.0100,		0.069,	0.1500,	0.0750,	3.280,	17.0,	0.980},
				{0.3,	0.0100,		0.067,	0.1442,	0.3897,	3.400,	17.0,	0.950},
				{0.4,	0.0110,		0.064,	0.1383,	0.7044,	4.363,	17.0,	0.950},
				{0.6,	0.0110,		0.065,	0.1265,	1.3339,	4.854,	17.0,	0.950},
				{0.7,	0.0120,		0.065,	0.1206,	1.6486,	4.829,	17.0,	0.930},
				{0.8,	0.0130,		0.066,	0.1148,	1.9633,	4.803,	17.0,	0.925},
				{0.85,	0.0130,		0.067,	0.1118,	2.1206,	4.778,	17.0,	0.920},
				{0.9,	0.0140,		0.071,	0.1089,	2.2780,	4.752,	17.0,	0.915},
				{1,		0.0150,		0.082,	0.1030,	2.5927,	4.726,	17.0,	0.910},
				{1.05,	0.0160,		0.085,	0.1000,	2.7500,	4.713,	17.0,	0.905},
				{1.1,	0.0160,		0.086,	0.1035,	2.7586,	4.701,	17.0,	0.900},
				{1.2,	0.0165,		0.083,	0.1104,	2.7759,	4.675,	17.0,	0.900},
				{1.3,	0.0170,		0.077,	0.1173,	2.7931,	4.650,	16.0,	0.900},
				{1.5,	0.0180,		0.062,	0.1311,	2.8276,	4.598,	13.0,	0.900},
				{1.7,	0.0200,		0.051,  0.1449,	2.8621,	4.547,	12.0,	0.700},
				{1.8,	0.0210,		0.046,	0.1518,	2.8793,	4.522,	11.4,	0.640},
				{2,		0.0230,		0.039,	0.1656,	2.9138,	4.470,	10.2,	0.520},
				{2.1,	0.0240,		0.034,	0.1725,	2.9310,	4.445,	 9.0,	0.400},
				{2.2,	0.0245,		0.034,	0.1794,	2.9483,	4.419,	 9.0,	0.400},
				{2.5,	0.0300,		0.033,	0.2000,	3.0000,	3.500,	 9.0,	0.400},
			}, -- end of table_data
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. Inversely proportional to the available G-loading at any Mach value. (lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff
			-- B4 - Polar 4th power coeff
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)

		}, -- end of aerodynamics
		engine =
		{
			Nmg	    =	51.0,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			typeng	=	1,
			hMaxEng	=	19.0,
			dcx_eng	=	0.0144, -- Affects drag of engine when shutdown
			-- cemax/cefor affect sponginess of elevator/inertia at slow speed
			-- affects available g load apparently
			cemax	=	1.24,
			cefor	=	2.56, 
			-- following affect thrust/max alt
			--
			dpdh_m	=	4100, --  altitude coefficient for max thrust
			dpdh_f	=	11800, --  altitude coefficient for AB thrust  -- affects thrust?? Apparently makes no diff. between 1000 and 20000
			table_data =
			{
				{0,		64300,		95000},
				{0.2,	67000,		96000},
				{0.4,	67000,		96000},
				{0.6,	67000,		102000},
				{0.7,	67000,		111000},
				{0.8,	75000,		126000},
				{0.9,	75000,		145000},
				{1,		75000,		164000},
				{1.1,	75000,		177000},
				{1.2,	80000,		187000},
				{1.3,	82000,		194000},
				{1.5,	76000,		213000},
				{1.8,	69246,		229000},
				{2,		71719,		233000},
				{2.2,	70483,		240000},
				{2.5,	68009,		237000},
				{3,		61827,		117436},
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power - kilo Newtons
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
	
	Failures = {
		{ id = 'HYD_PUMP_1_FAIL_100',		  	  label = _('Hydraulic Pump 1 Fail'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYD_PUMP_2_FAIL_100',		  	  label = _('Hydraulic Pump 2 Fail'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYD_PUMP_3_FAIL_100',		  	  label = _('Hydraulic Aux Pump Fail'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_SYSTEM_FAIL_050',		  	  label = _('Oil System Leak'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OIL_SYSTEM_FAIL_100',		  	  label = _('Oil System Fail'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BATT_FAIL',		  	              label = _('Battery Fail'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TRN_FAIL',		  	              label = _('Main Transformer Fail'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TRN_FAIL_AUX',	  	              label = _('Aux Transformer Fail'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENG_ALT_1_FAIL',		  	      label = _('Engine Alternator 1 Fail'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ENG_ALT_2_FAIL',		  	      label = _('Engine Alternator 2 Fail'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYD_ALT_1_FAIL',		  	      label = _('Hydraulic Alternator 1 Fail'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYD_ALT_2_FAIL',		  	      label = _('Hydraulic Alternator 1 Fail'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_PART_FAIL',		  	          label = _('INS Partial Failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_GYROS_FAIL',		  	      label = _('INS Gyros Fail'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'INS_TOTAL_FAIL',		  	      label = _('INS Total Failure'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_SENSOR_TAIL',		  label = _('SPIRALE Tail Sensor'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_SENSOR_LEFT',		  label = _('SPIRALE L Sensor'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_SENSOR_RIGHT',		  label = _('SPIRALE R Sensor'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWR_FAILURE_TOTAL',		 		  label = _('SPIRALE Main'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},

	Damage = verbose_to_dmg_properties({
		-- NOSE, COCKPIT & AVIONICS
		["NOSE_CENTER"]	 		= {critical_damage =  3, args = {82}},
		["NOSE_LEFT_SIDE"]	 	= {critical_damage =  5, args = {150}},
		["NOSE_RIGHT_SIDE"]	 	= {critical_damage =  5, args = {149}},
		["COCKPIT"]	 			= {critical_damage =  2, args = {65}},
		["CABIN_LEFT_SIDE"]	 	= {critical_damage =  5, args = {298}},
		["CABIN_RIGHT_SIDE"]	= {critical_damage =  5, args = {299}},
		["CREW_1"]				= {critical_damage =  5},
		["PYLON1"]				= {critical_damage =  4, args = {300}},	-- AVIONICS BAY 1
		["PYLON2"] 				= {critical_damage =  4, args = {301}},	-- AVIONICS BAY 2
		["PYLON3"]				= {critical_damage =  4, args = {302}},	-- SERVAL TAIL

		-- CONTROL SURFACES
		["RUDDER"] 				= {critical_damage =  3, args = {248}},
		["AILERON_L"]			= {critical_damage =  3, args = {226}},
		["ELEVATOR_L_IN"]		= {critical_damage =  4, args = {240}},
		["ELEVATOR_R_IN"]		= {critical_damage =  4, args = {238}},
		["AILERON_R"]			= {critical_damage =  3, args = {216}},
		["WING_L_PART_OUT"]		= {critical_damage =  1, args = {232}},	-- SLAT L OUT
		["WING_L_PART_IN"]		= {critical_damage =  1, args = {230}},	-- SLAT L IN 
		["WING_R_PART_OUT"]		= {critical_damage =  1, args = {222}},	-- SLAT R OUT
		["WING_R_PART_IN"]		= {critical_damage =  1, args = {220}},	-- SLAT R IN
		["AIR_BRAKE_L"]			= {critical_damage =  2, args = {183}},
		["AIR_BRAKE_R"]			= {critical_damage =  2, args = {185}},

		-- ENGINE & FUEL TANKS
		["ENGINE"]				= {critical_damage = 8,  args = {271}},
		["FUEL_TANK_LEFT_SIDE"]	= {critical_damage = 7,  args = {224}},
		["FUEL_TANK_RIGHT_SIDE"]= {critical_damage = 7,  args = {214}},
		["BLADE_1_CENTER"]		= {critical_damage = 7,  args = {155}},	-- (BLADE_1_CENTER)
		["BLADE_1_OUT"]			= {critical_damage = 3               },	-- (BATTERY (BLADE_1_OUT)
		["BLADE_2_IN"]			= {critical_damage = 3               },	-- (ALTERNATOR 1)
		["BLADE_2_CENTER"]		= {critical_damage = 3               },	-- (ALTERNATOR 2)
		["BLADE_2_OUT"]			= {critical_damage = 3               },	-- (CONVERTER 1)
		["BLADE_3_IN"]			= {critical_damage = 3               },	-- (CONVERTER 2)
		["BLADE_3_CENTER"]		= {critical_damage = 3               },	-- (HYD PUMP 1)
		["BLADE_3_OUT"]			= {critical_damage = 3               },	-- (HYD PUMP 2)

		-- FUSELAGE & WINGS
		["FIN_L_TOP"]			= {critical_damage = 3,  args = {244}, },
		["FIN_L_CENTER"]		= {critical_damage = 4,  args = {245}, deps_cells = {"FIN_L_TOP","RUDDER"}},
		["FIN_L_BOTTOM"]		= {critical_damage = 5,  args = {246}, deps_cells = {"FIN_L_CENTER","PYLON3"}},
		["WING_L_OUT"]			= {critical_damage = 3,  args = {223}, deps_cells = {"WING_L_PART_OUT", "AILERON_L"}},
		["WING_R_OUT"]			= {critical_damage = 3,  args = {213}, deps_cells = {"WING_R_PART_OUT", "AILERON_R"}},
		["WING_L_CENTER"]		= {critical_damage = 5,  args = {224}, deps_cells = {"WING_L_OUT"}},
		["WING_R_CENTER"]		= {critical_damage = 5,  args = {214}, deps_cells = {"WING_R_OUT"}},
		["WING_L_IN"]			= {critical_damage = 7,  args = {225}, deps_cells = {"AIR_BRAKE_L","WING_L_CENTER","WING_L_PART_IN","FUEL_TANK_LEFT_SIDE" ,"WHEEL_L"}},
		["WING_R_IN"]			= {critical_damage = 7,  args = {215}, deps_cells = {"AIR_BRAKE_R","WING_R_CENTER","WING_R_PART_IN","FUEL_TANK_RIGHT_SIDE","WHEEL_R"}},
		["FUSELAGE_LEFT_SIDE"]	= {critical_damage = 5,  args = {154}},
		["FUSELAGE_BOTTOM"]		= {critical_damage = 5,  args = {152}},
		["FUSELAGE_RIGHT_SIDE"] = {critical_damage = 5,  args = {153}},
		["TAIL"]				= {critical_damage = 4,  args = {159}},				-- NOZZLE
		["TAIL_LEFT_SIDE"]		= {critical_damage = 4,  args = {158}},
		["TAIL_RIGHT_SIDE"]		= {critical_damage = 4,  args = {157}},
		["TAIL_BOTTOM"]			= {critical_damage = 4,  args = {156}},

		-- LANDING GEAR
		--["FRONT_GEAR_BOX"]	= {critical_damage = 6, args = {265}, deps_cells = {"WHEEL_F"}},   -- MISSING IN MODEL!
		--["LEFT_GEAR_BOX"]		= {critical_damage = 6, args = {267}, deps_cells = {"WHEEL_L"}},   -- MISSING IN MODEL!
		--["RIGHT_GEAR_BOX"]	= {critical_damage = 6, args = {266}, deps_cells = {"WHEEL_R"}},   -- MISSING IN MODEL!
		["WHEEL_F"]				= {critical_damage = 3, args = {134}},
		["WHEEL_L"]				= {critical_damage = 3, args = {135}},
		["WHEEL_R"]				= {critical_damage = 3, args = {136}},

		-- WEAPONS
		["GUN"]					= {critical_damage = 3, args = {296}},

	}),

	--oblomok = russian for splinter
	--must create models for damaged parts
	DamageParts =
	{
        [1] = "m-2000c-oblomok-wing-R",
        [2] = "m-2000c-oblomok-wing-L",
        [4] = "m-2000c-oblomok-tail", -- tail
		[1000 + 35] = "m-2000c-oblomok-wing-L",
		[1000 + 36] = "m-2000c-oblomok-wing-R",
	},

	-- Must create the connectors in the exernal model for the external lights
	--[[ LIGHT COLLECTION DATA
		WOLALIGHT_STROBES 		   = 1--must be collection
		WOLALIGHT_SPOTS  		   = 2--must be collection
		WOLALIGHT_NAVLIGHTS 	   = 3--must be collection
		WOLALIGHT_FORMATION_LIGHTS = 4--must be collection
		WOLALIGHT_TIPS_LIGHTS      = 5--must be collection
	]]--
	
	lights_data = 	{
		typename = "collection",
		lights = 	{
			--[[NATO STROBE LIGHTS]]--
			[WOLALIGHT_STROBES] = {
				typename = "collection",
				lights ={
					{typename = "argnatostrobelight",  argument = 83,  period = 1.333,  phase_shift = 0.0}, -- Top Strobe
					{typename = "argnatostrobelight",  argument = 802, period = 1.333,  phase_shift = 0.5}, -- Bottom Strobe
				}
			},
			
			--[[TAXI Lights]]--
			[WOLALIGHT_TAXI_LIGHTS] = {
				typename = "collection",
				lights ={
					--Taxi Spotlights
					{typename = "argumentlight", argument = 209, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
					{typename = "argumentlight", argument = 209, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[[LANDING Lights]]--
			[WOLALIGHT_LANDING_LIGHTS] = {
				typename = "collection",
				lights ={
					--Landing Spot Lights
					{typename = "argumentlight", argument = 208, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
					{typename = "argumentlight", argument = 208, dir_correction = {elevation = math.rad(3)}, speed = 1.0},
				}
			},
			
			--[[NAVIGATION LIGHTS]]--
			[WOLALIGHT_NAVLIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 190}, --Red Position
					{typename = "argumentlight",  argument  = 192}, --Green Position
					{typename = "argumentlight",  argument  = 191}, --White Position
				}
			},
			
			--[[FORMATION LIGHTS]]--
			[WOLALIGHT_FORMATION_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", argument = 200, color = {0.02, 0.02, 0.02}}, -- form front
					{typename = "argumentlight", argument = 201, color = {0.02, 0.02, 0.02}}, -- form aft
				}
			},	
			
			--[[REFUEL LIGHTS]]--
			[WOLALIGHT_REFUEL_LIGHTS] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight", connector = "CNT_RF1", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 903}, -- Right Side Low
					{typename = "argumentlight", connector = "CNT_RF2", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 907, speed = 1.0}, -- Right Side High
					{typename = "argumentlight", connector = "CNT_RF3", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 908, speed = 1.0}, -- Nose High
					--{typename = "argumentlight", connector = "CNT_RF4", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 904}, -- Nose Low
				}
			},	
			
			--[[POLICE LIGHTS]]--
			[WOLALIGHT_PROJECTORS] = {
				typename = "collection",
				lights = {
					--{typename = "argumentlight", connector = "CTN_POL1", color = {0.99, 0.99, 0.99}, pos_correction  = {0, 0, 0.0}, argument  = 905, speed = 1.0}, -- Police
					{typename = "spotlight", connector = "CTN_POL1", color = {1.0,1.0,1.0},	pos_correction  = {0, 0, 0.0}, argument  = 905,	speed = 1.0, angle_max = math.rad(50.0), angle_min = math.rad(0.0), direction = {azimuth = math.rad(-40.0), elevation = math.rad(-4)},	range = 150.0 },
					{typename = "spotlight", connector = "CTN_POL1", color = {1.0,1.0,1.0},	pos_correction  = {0, 0, 0.0}, argument  = 905,	speed = 1.0, angle_max = math.rad(25.0), angle_min = math.rad(0.0), direction = {azimuth = math.rad(-40.0), elevation = math.rad(-4)},	range = 190.0 },
					{typename = "spotlight", connector = "CTN_POL1", color = {1.0,1.0,1.0},	pos_correction  = {0, 0, 0.0}, argument  = 905,	speed = 1.0, angle_max = math.rad(5.0) , angle_min = math.rad(0.0), direction = {azimuth = math.rad(-40.0), elevation = math.rad(-4)},	range = 230.0 },
				}
			},	
		},
	},
	-- end lights_data
	
	panelRadio = {
       [1] = {
           name = _("UHF Radio"),		   
           range = {	
						{min = 225.0, max = 400.0}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 305.0, modulation = _("AM"), connect = true}, -- default
                [2] = { name = _("Channel 2"),		default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 3"),		default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 4"),		default = 256.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 5"),		default = 254.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 6"),		default = 250.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 7"),		default = 270.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 8"),		default = 257.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"),		default = 255.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 10"),	default = 262.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
                [11] = { name = _("Channel 11"),	default = 259.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 12"),	default = 268.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 13"),	default = 269.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 14"),	default = 260.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 15"),	default = 263.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 16"),	default = 261.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 17"),	default = 267.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 18"),	default = 252.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 19"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 20"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
            }
       },
	   [2] = {
           name = _("V/UHF Radio"),		   
           range = {	{min = 118.0, max = 140.0},
						{min = 225.0, max = 400.0}
			},
            channels = {
                [1] = { name = _("Channel 1"),		default = 129.0, modulation = _("AM")}, -- default
                [2] = { name = _("Channel 2"),		default = 135.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [3] = { name = _("Channel 3"),		default = 136.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [4] = { name = _("Channel 4"),		default = 127.0, modulation = _("AM")},	-- sochi : 127.0, 256.0
                [5] = { name = _("Channel 5"),		default = 125.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [6] = { name = _("Channel 6"),		default = 121.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [7] = { name = _("Channel 7"),		default = 141.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [8] = { name = _("Channel 8"),		default = 128.0, modulation = _("AM")},	-- krasnodar-pashk. : 128.0, 257.0
                [9] = { name = _("Channel 9"),		default = 126.0, modulation = _("AM")},	-- gelenjik : 126.0, 255.0
                [10] = { name = _("Channel 10"),	default = 133.0, modulation = _("AM")},	-- kabuleti : 133.0, 262.0
                [11] = { name = _("Channel 11"),	default = 130.0, modulation = _("AM")},	-- gudauta : 130.0, 259.0
                [12] = { name = _("Channel 12"),	default = 139.0, modulation = _("AM")},	-- soginlug : 139.0, 268.0
                [13] = { name = _("Channel 13"),	default = 140.0, modulation = _("AM")},	-- vaziani : 140.0, 269.0
                [14] = { name = _("Channel 14"),	default = 131.0, modulation = _("AM")},	-- batumi : 131.0, 260.0
                [15] = { name = _("Channel 15"),	default = 134.0, modulation = _("AM")},	-- kutaisi : 134.0, 263.0
                [16] = { name = _("Channel 16"),	default = 132.0, modulation = _("AM")},	-- senaki : 132.0, 261.0
                [17] = { name = _("Channel 17"),	default = 138.0, modulation = _("AM")},	-- lochini : 138.0, 267.0
                [18] = { name = _("Channel 18"),	default = 122.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
                [19] = { name = _("Channel 19"),	default = 124.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
                [20] = { name = _("Channel 20"),	default = 137.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
            }
       },
   },	
   
   -- Aircraft Additional Properties
	Navpoint_Panel = true,
	AddPropAircraft = {
		{ id = "RocketBurst", control = 'comboList', label = _('Rocket Burst Count'),
			values = {
				{id =  1, dispName = _("1 Rocket")},
				{id =  3, dispName = _("3 Rockets")},
				{id =  6, dispName = _("6 Rockets")},
				{id = 18, dispName = _("18 Rockets")}
			},
			defValue  = 6,
			wCtrl     = 150
		},
		{ id = "GunBurst", control = 'comboList', label = _('Gun Burst Length (Seconds)'),
			values = {
				{id =  1, dispName = _("0.5 Second")},
				{id =  2, dispName = _("1.0 Second")}
			},
			defValue  = 1,
			wCtrl     = 150
		},
        { id = "LaserCode100",  control = 'spinbox',  label = _('Laser code for GBUs, 1x11'), defValue = 6, min = 1, max = 8, dimension = ' ' },
        { id = "LaserCode10",   control = 'spinbox',  label = _('Laser code for GBUs, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ' },
        { id = "LaserCode1",    control = 'spinbox',  label = _('Laser code for GBUs, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ' },
        { id = "WpBullseye",    control = 'spinbox',  label = _('Waypoint Bullseye'),   defValue = 0, min = 0, max = 20, dimension = ' ' },
        { id = "ForceINSRules", control = 'checkbox', label = _('Enforce INS drift'), defValue = false },
        { id = "ReadyALCM",		control = 'checkbox', label = _('Aircraft is ALCM ready'), defValue = true },
		{ id = "LoadNVGCase", 	control = 'checkbox', label = _('Load NVG Case'), defValue = false },
        { id = "InitHotDrift",  control = 'slider',   label = _('Initial drift for in flight start'), defValue = 0, min = 0.0, max = 180, dimension = 'min' },
		{ id = "EnableTAF", control = 'checkbox', label = _('Enable TAF (GCI link)'), defValue = true },
		{ id = "DisableVTBExport", control = 'checkbox', label = _('Disable VTB Export'), defValue = false },
	}
}

add_aircraft(M_2000C)
