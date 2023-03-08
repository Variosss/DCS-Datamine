function m3_browing(tbl)

	tbl.category = CAT_GUN_MOUNT 
	tbl.name 	 = "m3_browning"
	tbl.supply 	 = 
	{
		shells = {"M2_50_aero_AP","M20_50_aero_APIT"},
		mixes  = {{1,2,2,1,2,2}}, --  
		count  = 300,
	}
	if tbl.mixes then 
	   tbl.supply.mixes =  tbl.mixes
	   tbl.mixes	    = nil
	end
	tbl.gun = 
	{
		max_burst_length = 300,
		rates 			 = {1200},
		recoil_coeff 	 = 1,
		barrels_count 	 = 1,
	}
	if tbl.rates then 
	   tbl.gun.rates    =  tbl.rates
	   tbl.rates	    = nil
	end	
	tbl.ejector_pos 			= tbl.ejector_pos or {-0.4, -1.2, 0.18}
	tbl.ejector_dir 			= {0,-1,0}
	tbl.supply_position  		= tbl.supply_position   or {0,  0.3, -0.3}
	tbl.aft_gun_mount 			= false
	tbl.effective_fire_distance = 1000
	tbl.drop_cartridge 			= 0
	tbl.muzzle_pos				= tbl.muzzle_pos 		 or  {0,0,0} -- all position from connector
	tbl.muzzle_pos_connector	= tbl.muzzle_pos_connector 		 or  "Gun_point" -- all position from connector
	tbl.azimuth_initial 		= tbl.azimuth_initial    or 0   
	tbl.elevation_initial 		= tbl.elevation_initial  or 0   
	if  tbl.effects == nil then
		tbl.effects = {{ name = "FireEffect"     , arg 		 = tbl.effect_arg_number or 436 },
					   { name = "HeatEffectExt"  , shot_heat = 7.823, barrel_k = 0.462 * 2.7, body_k = 0.462 * 14.3 },
					   { name = "SmokeEffect"}}
	end
	return declare_weapon(tbl)
end


function make_Sabre(rewrite_settings)
local rewrite_settings  = rewrite_settings or {Name = 'F-86F Sabre', DisplayName = _('F-86F')}

local base_Sabre =  {
        
	Name 				= rewrite_settings.Name,
	DisplayName			= rewrite_settings.DisplayName,
	Picture 			= "F-86F Sabre.png",
	Rate 				= 20, -- RewardPoint in Multiplayer
	Shape				= 'f-86f',
	livery_entry		= "F-86F Sabre",

	country_of_origin = "USA",

	shape_table_data 	= 
	{
		{
			file  	 = 'f-86f';
			life  	 = 15; -- прочность объекта (методом lifebar*) -- The strength of the object (ie. lifebar *)
			vis   	 = 3; -- множитель видимости (для маленьких объектов лучше ставить поменьше). Visibility factor (For a small objects is better to put lower nr).
			desrt    = 'Fighter-2-crush',--'F86F_destr'; -- Name of destroyed object file name
			fire  	 = { 300, 4}; -- Fire on the ground after destoyed: 300sec 4m
			username = 'F-86F';
			index    =  WSTYPE_PLACEHOLDER;
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		--[[
		{
			name  = "F86F_destr";
			file  = "F-86F Sabre-destr";
			fire  = { 240, 2};
			classname = "lLandPlane";
			positioning = "BYNORMAL";
		},
		--]]
	},
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
	-------------------------
	M_empty 					= 5046, -- kg			**(11125 lbs - Standard Aircraft Characteristics - SAC)
	M_nominal 					= 7113, -- kg			**(15681 lbs - Combat Weight - SAC)
	M_max 						= 9349, -- kg			**(20611 lbs - Max TO - SAC)
	M_fuel_max 					= 1282, -- kg			**(435 gallons - 1.6467m3 - 779 kg/m3)
	H_max 					 	= 15100, -- m
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 50, -- minimal indicated airspeed*?
	-- M = 15600 lbs
	V_opt 						= 237,-- Cruise speed (for AI)*
	V_take_off 					= 63, -- Take off speed in m/s (for AI)*	(122)
	V_land 						= 78, -- Land speed in m/s (for AI) (152kn - final approach, 126kn - touchdown)
	V_max_sea_level 			= 303, -- Max speed at sea level in m/s (for AI) (589kn)
	V_max_h 					= 268, -- Max speed at max altitude in m/s (for AI)	(522kn)
	Vy_max 						= 45.72, -- Max climb speed in m/s (for AI)	(9000ft/min)
	Mach_max 					= 0.95, -- Max speed in Mach (for AI)	???
	Ny_min 						= -3, -- Min G (for AI)
	Ny_max 						= 8.0,  -- Max G (for AI)
	Ny_max_e 					= 8.0, -- ?? Max G (for AI)
	AOA_take_off 				= 0.17, -- AoA in take off radians (for AI)
	bank_angle_max 				= 85, -- Max bank angle (for AI)


	has_afteburner 				= false, -- AFB yes/no
	has_speedbrake 				= true, -- Speedbrake yes/no
	tand_gear_max 				= 0.554, -- // tangent on maximum yaw angle of front whell
	wing_area 					= 28.173, -- wing area in m2 		**
	wing_span 					= 11.9 , -- wing span in m			**(39'1" - TO 1F-86-1, after F-25)
	wing_type 					= 0,	-- Fixed wing				**
	thrust_sum_max 				= 2680, -- thrust in kg (26.3kN)	**
	thrust_sum_ab 				= 2680, -- thrust inkg (26.3kN)		**
	length 						= 11.43, -- full lenght in m		**(37'6" - TO 1F-86-1)
	height 						= 4.496, -- height in m				**(14'9" - TO 1F-86-1)
	flaps_maneuver 				= 1, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
    flaps_transmission          = "Electrical",
    undercarriage_transmission  = "Hydraulic",
	range 						= 1210, -- Max range in km (for AI)
	RCS 						= 2, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.25, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 0.25, -- With afterburner
	wing_tip_pos 				= {-3.214,-0.135, 5.658}, -- wingtip coords for visual effects
	
	nose_gear_pos 				= { 3.527, -1.626,	0},   -- nosegear coord 
	nose_gear_amortizer_direct_stroke   		=  0,  -- down from nose_gear_pos !!!
	nose_gear_amortizer_reversal_stroke  		= -0.126,  -- up 
	nose_gear_amortizer_normal_weight_stroke 	= -0.06,   -- up 
	nose_gear_wheel_diameter 	= 0.544, -- in m
	
	main_gear_pos 						 	 = {-1.076  ,-1.712 , 1.297}, -- main gear coords 
	main_gear_amortizer_direct_stroke	 	 =   0, --  down from main_gear_pos !!!
	main_gear_amortizer_reversal_stroke  	 = 	-0.238, --  up 
	main_gear_amortizer_normal_weight_stroke =  -0.1,-- down from main_gear_pos
	main_gear_wheel_diameter 				 =   0.66, -- in m

	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos					= {-6.25,	0.3,	0}, -- nozzle coords
			elevation			= -0.1, -- AFB cone elevation
			diameter			= 0.75, -- AFB cone diameter
			exhaust_length_ab	= 3, -- lenght in m
			exhaust_length_ab_K = 0.76, -- AB animation
			smokiness_level     = 0.5, 
		}, -- end of [1]
	}, -- end of engines_nozzles
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name = "pilot_f86_seat",
			drop_canopy_name   = "f-86f-canopy",
			pilot_name		   = "pilot_f86",
			drop_parachute_name	 = "pilot_f86_parachute",
			pos 	   =  {1.7, 0.5 ,	0},
			canopy_pos = {1.607000 ,1.181,0},
			canopy_ejection_dir = {-1.0,0.2,0},
			g_suit = 0.7,
		}, -- end of [1]
	}, -- end of crew_members

    mechanimations = {
        Door0 = {
            {Transition = {"Close", "Open"},  Sequence = {{C = {{"Arg", 38, "to", 0.9, "in", 2.2},},},}, Flags = {"Reversible"},},
            {Transition = {"Open", "Close"},  Sequence = {{C = {{"Arg", 38, "to", 0.0, "in", 2.2},},},}, Flags = {"Reversible", "StepsBackwards"},},
            {Transition = {"Open", "Taxi"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
            {Transition = {"Taxi", "Open"},   Sequence = {{C = {{"Sleep", "for", 0.0},},},},},
            {Transition = {"Any", "Bailout"}, Sequence = {{C = {{"JettisonCanopy", 0},},},},},
        },
        HeadLights = {
            {Transition = {"Any", "Retract"}, Sequence = {{C = {{"Arg", 427, "to", 0.0, "speed", 1.0/13.0},    {"Arg", 419, "to", 0.0, "speed", 1.0/13.0},},},},},
            {Transition = {"Any", "Taxi"},    Sequence = {{C = {{"Arg", 427, "to", 0.8625, "speed", 1.0/13.0}, {"Arg", 419, "to", 0.0, "speed", 1.0/13.0},},},},},
            {Transition = {"Any", "High"},    Sequence = {{C = {{"Arg", 427, "to", 1.0, "speed", 1.0/13.0},    {"Arg", 419, "to", 1.0, "speed", 1.0/13.0},},},},},
        },
        HeadLight0 = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"Arg", 427, "from", 0.0, "to", 1.0, "speed", 1.0/13.0},},},},},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"Arg", 427, "from", 1.0, "to", 0.0, "speed", 1.0/13.0},},},},},
        },
        HeadLight1 = {
            {Transition = {"Retract", "Extend"}, Sequence = {{C = {{"Arg", 419, "from", 0.0, "to", 1.0, "speed", 1.0/13.0},},},},},
            {Transition = {"Extend", "Retract"}, Sequence = {{C = {{"Arg", 419, "from", 1.0, "to", 0.0, "speed", 1.0/13.0},},},},},
        },
    },

	fires_pos = {
			[1] = 	{-0.40,		-0.46,	 0.0},		-- Fuselage					10 - fuselage right
			[2] = 	{-1.114,	-0.29,	 0.901},	-- Wing inner Right
			[3] = 	{-1.268,	-0.29,	-1.162},	-- Wing inner Left
			[4] = 	{ 0.215,	-0.26,	 1.195},	-- Wing middle Right
			[5] = 	{-1.582,	-0.26,	-1.687},	-- Wing middle Left
			[6] = 	{-0.80,		-0.26,	 2.2},		-- Wing outer Right
			[7] = 	{-1.0,		-0.29,	-0.806},	-- Wing outer Left
			[8] = 	{0.0,		 0.0,	 0.0},		-- Engine (inner Right)
			[9] = 	{-7.75,		 0.3,	 0.0},		-- Engine (inner Left)
	}, -- end of fires_pos
	
	--sensors
	
	detection_range_max		 = 30,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = {
		azimuth    = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation  = {-30.0, 90.0} -- pilot view vertical (AI)
	},
	Sensors = {
		-- RWR = "Abstract RWR", -- RWR type
		-- RADAR = "N-008", -- Radar type
	},
	HumanRadio = {
		frequency = 225.0,  -- Radio Freq
		editable = true,
		minFrequency = 225.000,
		maxFrequency = 400.000,
		modulation = MODULATION_AM
	},

	panelRadio = {
        [1] = {  
            name = _("AN/ARC-27"),
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

	Guns = {--left
			m3_browing({muzzle_pos = {2.91,   0.42,  -0.5 }  	, rates = {1249},mixes = {{2,1,1,1,1,1}},effect_arg_number = 434,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --up   
			m3_browing({muzzle_pos = {3.09,   0.260,  -0.54}	, rates = {1229},mixes = {{1,1,2,1,1,1}},effect_arg_number = 435,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --center
			m3_browing({muzzle_pos = {3.04,   0.09,  -0.59 } 	, rates = {1177},mixes = {{1,1,1,1,1,2}},effect_arg_number = 436,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3, -0.4}}), --down
			--right                                                                           
			m3_browing({muzzle_pos = {2.91,  0.42, 0.5 }		, rates = {1190},mixes = {{1,1,2,1,1,1}},effect_arg_number = 433,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3,  0.4}}), --up
			m3_browing({muzzle_pos = {3.09,  0.260, 0.54}		, rates = {1154},mixes = {{1,1,1,1,2,1}},effect_arg_number = 432,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3,  0.4}}), --center
			m3_browing({muzzle_pos = {3.04,  0.09, 0.59 }		, rates = {1172},mixes = {{1,2,1,1,1,1}},effect_arg_number = 350,azimuth_initial = 0,elevation_initial = 0,supply_position = {2, -0.3,  0.4}})  --down  
			},
	
	
	Pylons = {
		--LEFT WING
		pylon(1, 0, -1.342523, -0.538103, -3.077469,{use_full_connector_position=true,connector = "Pylon1_B",arg = 308,arg_value = 0},
			{
				{ CLSID = "{PTB_200_F86F35}" ,forbidden = {{station = 2}},connector = "Pylon1_Fuel_Tank",arg_value = 1.0},
				{ CLSID = "{PTB_120_F86F35}" ,forbidden = {{station = 2}},connector = "Pylon1_Fuel_Tank", arg_value = 1.0},
				{ CLSID = "{HVARx2}"									 ,connector = "Pylon1",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}"						 		 ,connector = "Pylon1",arg_value = 0.1},
			}
		),
		pylon(2, 0, -1.094708, -0.564540, -2.731248,{use_full_connector_position=true,connector = "Pylon2",arg = 309,arg_value = 0},
			{
				{ CLSID = "{HVARx2}",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}",arg_value = 0.1},
			}
		),
		pylon(3, 0, -0.841246, -0.593487, -2.381041,{use_full_connector_position=true,connector = "Pylon3",arg = 310,arg_value = 0},
			{
				{ CLSID = "{HVARx2}",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}",arg_value = 0.1},
			}
		),
		pylon(4, 0, -0.587138, -0.620194, -2.030714,{use_full_connector_position=true,connector = "Pylon4_B",arg = 311,arg_value = 0},
			{
				{ CLSID = "{PTB_120_F86F35}" ,forbidden = {{station = 3}}	,connector = "Pylon4_Fuel_Tank", arg_value = 1.0},
				{ CLSID = "{F86ANM64}"		 ,forbidden = {{station = 3}}	,arg_value = 0.5},
				{ CLSID = "{HVARx2}"		 ,connector = "Pylon4"			,arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}"	 ,connector = "Pylon4"			,arg_value = 0.1},
				{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}"			,forbidden = {{station = 3}}, arg_value = 0.5, attach_point_position = {-0.09, 0.02, 0.0}}, -- M117
			}
		),	
		pylon(5, 0, 0.821999, -0.733671, -1.279437,{use_full_connector_position=true, connector ="Pylon9",arg = 316,arg_value = 0},--SIDEWINDER-----------
			{
				{ CLSID = "{GAR-8}",arg_value = 0.1},
			}
		),	
		--RIGHT WING		
		pylon(6, 0, 0.821999, -0.733671,  1.279437,{use_full_connector_position=true, connector ="Pylon10",arg = 317,arg_value = 0},--SIDEWINDER-----------
			{
				{ CLSID = "{GAR-8}",arg_value = 0.1},
			}
		),
		pylon(7, 0, -0.586426, -0.620050, 2.029953,{use_full_connector_position=true,connector = "Pylon5_B",arg = 315,arg_value = 0},
			{
				{ CLSID = "{PTB_120_F86F35}" ,forbidden = {{station = 8}}	,connector = "Pylon5_Fuel_Tank",arg_value = 1.0},
				{ CLSID = "{F86ANM64}"		 ,forbidden = {{station = 8}}	,arg_value = 0.5},
				{ CLSID = "{HVARx2}"		 ,connector = "Pylon5"			,arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}"	 ,connector = "Pylon5"			,arg_value = 0.1},
				{ CLSID = "{00F5DAC4-0466-4122-998F-B1A298E34113}"			,forbidden = {{station = 8}}, arg_value = 0.5, attach_point_position = {-0.09, 0.02, 0.0}}, -- M117
			}
		),
		pylon(8, 0, -0.841299, -0.593386, 2.380349,{use_full_connector_position=true,connector = "Pylon6" ,arg = 314,arg_value = 0},
			{
				{ CLSID = "{HVARx2}",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}",arg_value = 0.1},
			}
		),
		pylon(9, 0, -1.095487, -0.564540, 2.731211,{use_full_connector_position=true,connector = "Pylon7" ,arg = 313,arg_value = 0},
			{
				{ CLSID = "{HVARx2}",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}",arg_value = 0.1},
			}
		),
		pylon(10, 0, -1.342523, -0.538103, 3.077707,{use_full_connector_position=true,connector = "Pylon8_B",arg = 312,arg_value = 0},
			{
				{ CLSID = "{PTB_200_F86F35}" ,forbidden = {{station = 9}},connector = "Pylon8_Fuel_Tank",arg_value = 1.0},
				{ CLSID = "{PTB_120_F86F35}" ,forbidden = {{station = 9}},connector = "Pylon8_Fuel_Tank",arg_value = 1.0},
				{ CLSID = "{HVARx2}"									 ,connector = "Pylon8",arg_value = 0.1},
				{ CLSID = "{HVAR_SMOKE_2}"						 		 ,connector = "Pylon8",arg_value = 0.1},
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
		aircraft_task(AntishipStrike),
    },	
	DefaultTask = aircraft_task(CAP),
	
	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0	=	0.0668, -- zero AoA lift coefficient*
			Mzalfa	=	4.355, -- coefficients for pitch agility
			Mzalfadt	=	0.8,  -- coefficients for pitch agility
			kjx	=	2,--2.3, -- Inertia parametre X - Dimension (clean) airframe drag coefficient at X (Top) Simply the wing area in square meters (as that is a major factor in drag calculations)
			kjz	=	0.01,--0.0011, -- Inertia parametre Z - Dimension (clean) airframe drag coefficient at Z (Front) Simply the wing area in square meters (as that is a major factor in drag calculations)
			Czbe	=	-0.014, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear	=	0.008, -- coefficient, drag, gear ??
			cx_flap	=	0.08, -- coefficient, drag, full flaps
			cy_flap	=	0.26, -- coefficient, normal force, lift, flaps
			cx_brk	=	0.08, -- coefficient, drag, breaks
			table_data = 
			{	--      M		Cx0*	 	Cya*		B2		 	B4	 		Omxmax		Aldop*		Cymax*
				[1 ] = { 0,		0.0189	,	0.0669	,	0.0182	,	0.2298	,	0.41	,	16.2	,	1.154},
				[2 ] = { 0.1,	0.0189	,	0.0669	,	0.0182	,	0.2298	,	0.41	,	16.2	,	1.154},
				[3 ] = { 0.2,	0.0186	,	0.0669	,	0.0182	,	0.2296	,	0.81	,	16.2	,	1.154},
				[4 ] = { 0.4,	0.0180	,	0.0669	,	0.0183	,	0.2294	,	1.62	,	16.2	,	1.154},
				[5 ] = { 0.6,	0.0174	,	0.0674	,	0.0194	,	0.2245	,	2.43	,	16.0	,	1.145},
				[6 ] = { 0.65,	0.0183	,	0.0690	,	0.0229	,	0.2113	,	2.63	,	14.9	,	1.096},
				[7 ] = { 0.7,	0.0191	,	0.0722	,	0.0303	,	0.2111	,	2.82	,	11.8	,	0.921},
				[8 ] = { 0.75,	0.0189	,	0.0709	,	0.0424	,	0.3165	,	2.98	,	10.0	,	0.777},
				[9 ] = { 0.8,	0.0189	,	0.0689	,	0.0510	,	0.3826	,	2.47	,	9.9		,	0.749},
				[10] = { 0.9,	0.0270	,	0.0661	,	0.0554	,	0.4359	,	0.60	,	10.1	,	0.731},
				[11] = { 0.95,	0.0510	,	0.0643	,	0.0526	,	0.4836	,	1.31	,	10.2	,	0.717},
				[12] = { 1.0,	0.0682	,	0.0631	,	0.0514	,	0.5218	,	0.42	,	10.2	,	0.707},
				[13] = { 1.1,	0.0718	,	0.0621	,	0.0547	,	0.5431	,	0.71	,	10.3	,	0.701},
				[14] = { 1.2,	0.0718	,	0.0620	,	0.0559	,	0.5453	,	0.73	,	10.3	,	0.701},
				[15] = { 1.3,	0.0718	,	0.0620	,	0.0572	,	0.5447	,	0.78	,	10.3	,	0.701},
				-- Approximately
				[16] = { 2.0,	0.0718	,	0.0620	,	0.0572	,	0.5447	,	0.73	,	10.3	,	0.701},
				[17] = { 2.5,	0.0718	,	0.0620	,	0.0572	  ,	0.5447	,	0.71	,	10.3	,	0.701},
				[18] = { 3.9,	0.0718	,	0.0620	,	0.0572	,	0.5447	,	0.42	,	10.3	,	0.701},
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
            Nominal_RPM = 7950,
			Nmg	=	35, -- RPM at idle
			MinRUD	=	0, -- Min state of the РУД
			MaxRUD	=	1, -- Max state of the РУД
			MaksRUD	=	1, -- Military power state of the РУД
			ForsRUD	=	1, -- Afterburner state of the РУД
			type	=	"TurboJet",
            Startup_Prework = 23.0,
            Startup_Duration = 40.0,
            Shutdown_Duration = 25.0,
			hMaxEng	=	19, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0134, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	1670, --  altitude coefficient for max thrust
			dpdh_f	=	1670, --  altitude coefficient for AB thrust
			table_data = 
			{		--   M			Pmax		 Pfor	
				[1 ] = { 0		,	26296	,	26296	},
				[2 ] = { 0.2	,	24072	,	24072	},
				[3 ] = { 0.3	,	23441	,	23441	},
				[4 ] = { 0.4	,	23088	,	23088	},
				[5 ] = { 0.5	,	22981	,	22981	},
				[6 ] = { 0.55	,	23011	,	23011	},
				[7 ] = { 0.6	,	23088	,	23088	},
				[8 ] = { 0.65	,	23212	,	23212	},
				[9 ] = { 0.7	,	23377	,	23377	},
				[10] = { 0.75	,	23579	,	23579	},
				[11] = { 0.8	,	23810	,	23810	},
				[12] = { 0.9	,	24350	,	24350	},
				[13] = { 1		,	24953	,	24953	},
				[14] = { 1.1	,	25452	,	25452	},
				[15] = { 1.2	,	25884	,	25884	},
				[16] = { 1.3	,	26084	,	26084	},
				[17] = { 1.4	,	25969	,	25969	},
				-- Approximately
				[18] = { 2.5	,	100		,	100	},		
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},

	Failures = {
		-- electric system
		{ id = 'es_damage_Generator',		label = _('Generator FAILURE'), 			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_MainInverter',	label = _('Main Inverter FAILURE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_AltInverter',		label = _('Alternate Inverter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'es_damage_RadarInverter',	label = _('Radar Inverter FAILURE'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- hydraulic system
		{ id = 'hs_damage_MainHydro',		label = _('Main Hydraulic FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_AltHydro',		label = _('Alternate Hydraulic FAILURE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'hs_damage_UtilityHydro',	label = _('Utility Hydraulic FAILURE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- power plant
		{ id = 'pp_damage_BladesBrake',		label = _('Engine: Blades Brake'),		 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_Ignition',		label = _('Engine: Ignition FAILURE'),	 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = 'pp_damage_MainMaxFreq',			label = _('Main Fuel: Max Freq. Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_MainMaxNormFreq',		label = _('Main Fuel: Max Normalized Freq. Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_MainMaxTempr',		label = _('Main Fuel: Max Temperature Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_MainStabFactor',		label = _('Main Fuel: Stability Factor FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		{ id = 'pp_damage_EmergMaxFreq',		label = _('Emerg.Fuel: Max Freq. Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_EmergMaxNormFreq',	label = _('Emerg.Fuel: Max Normalized Freq. Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_EmergMaxTempr',		label = _('Emerg.Fuel: Max Temperature Limiter FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		{ id = 'pp_damage_OilPump',			label = _('Engine: Oil Pump FAILURE'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'pp_damage_OilSeparator',	label = _('Engine: Oil Separator FAILURE'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		-- 
	},

	Damage = {
		-------------  nose
--		[0] = {critical_damage = 12, args = {146},droppable = false},	-- nose center / nosecone
		[1] = {critical_damage = 3, args = {150}},						-- nose left
		[2] = {critical_damage = 3, args = {149}},						-- nose right
		[59] = {critical_damage = 3, args = {148}},						-- nose bottom 
--		[8] = {critical_damage = 15, args = {265, 134}, deps_cells = {83},droppable = false}, -- front gear
--		[83] = {critical_damage = 3, args = {134},droppable = false},	-- wheel nose 
		-------------  cabin
		[3] = {critical_damage = 1, args = {65, 147}},						-- cockpit
--		[4] = {critical_damage = 15,  args = {154},droppable = false}, -- cabin left
--		[5] = {critical_damage = 15, args = {153, 145},droppable = false}, -- cabin right
--		[6] = {critical_damage = 15, args = {148}, deps_cells = {8, 83},droppable = false}, -- cabin bottom
		-------------  fuselage
		[9] = {critical_damage = 3, args = {154}},-- deps_cells = {19}},			-- fuselage left
		[10] = {critical_damage = 3, args = {153}},-- deps_cells = {20}},			-- fuselage right
		[82] = {critical_damage = 3, args = {152}},-- deps_cells = {19, 20, 7}},	-- fuselage bottom
		[19] = {critical_damage = 1, args = {185}},									-- airbrake left
		[20] = {critical_damage = 1, args = {183}},									-- airbrake right
--		[7] = {critical_damage = 4, args = {249}, deps_cells = {19, 20},droppable = false},  -- gun
		-------------
		[35] = {critical_damage = 7, args = {225}, deps_cells = {29, 23, 25, 37, 86}},	-- wing in left
		[29] = {critical_damage = 7, args = {224}, deps_cells = {23, 25}},			-- wing center left
		[23] = {critical_damage = 6, args = {223}, deps_cells = {25}},				-- wing out left
		[25] = {critical_damage = 1, args = {226}},									-- aileron left
		[37] = {critical_damage = 2, args = {227}},									-- flap in left
		[86] = {critical_damage = 2, args = {308, 309, 310, 311}},					-- pylon L
--		[15] = {critical_damage = 13,args = {267, 136}},-- deps_cells = {84} ,droppable = false}, -- gear left
--		[84] = {critical_damage = 3, args = {136}},--droppable = false},  -- wheel left
		-------------
		[36] = {critical_damage = 7, args = {215}, deps_cells = {30, 24, 26, 38, 87}},	-- wing in right
		[30] = {critical_damage = 7, args = {214}, deps_cells = {24, 26}},			-- wing center right
		[24] = {critical_damage = 6, args = {213}, deps_cells = {26}},				-- wing out right
		[26] = {critical_damage = 1, args = {216}},									-- aileron right
		[38] = {critical_damage = 2, args = {217}},									-- flap in right
		[87] = {critical_damage = 2, args = {312, 313, 314, 315}},					-- pylon R
--		[16] = {critical_damage = 13,args = {266, 135}}, --deps_cells = {85} ,droppable = false}, -- gear right
--		[85] = {critical_damage = 3, args = {135}},--droppable = false},  -- wheel right
		-------------		
		[43] = {critical_damage = 3, args = {243}, deps_cells = {41, 39, 53}, droppable = false}, -- fin bottom
		[41] = {critical_damage = 3, args = {242}, deps_cells = {39}}, -- fin center
		[39] = {critical_damage = 3, args = {241}, deps_cells = {53}}, -- fin top
		[53] = {critical_damage = 1, args = {247}},		-- rudder
		-------------
--		[55] = {critical_damage = 20, args = {81}, deps_cells = {56, 57, 17, 18, 13, 14, 11, 47, 48, 41, 43, 39, 53, 51, 49, 52, 50}}, -- tail
		[56] = {critical_damage = 3, args = {158}},-- deps_cells = {57, 17, 18, 13, 14, 11, 58, 47, 48, 41, 43, 39, 53, 51, 49, 52, 50}},droppable = false}, -- tail left
		[57] = {critical_damage = 3, args = {157}},--droppable = false}, -- tail right
		[58] = {critical_damage = 3, args = {156}},--droppable = false}, -- tail bottom
--		[17] = {critical_damage = 10, args = {168} ,droppable = false}, -- motogondola left
--		[18] = {critical_damage = 10, args = {162} ,droppable = false}, -- motogondola right
--		[13] = {critical_damage = 15, args = {169} ,droppable = false}, -- chute box L
--		[14] = {critical_damage = 15, args = {163} ,droppable = false}, -- chute box R
--		[11] = {critical_damage = 5, args = {167}  ,droppable = false}, -- engine
		-------------	
		[47] = {critical_damage = 3, args = {236}, deps_cells = {45, 49, 51}},	-- stabilizer in left
		[45] = {critical_damage = 2, args = {235}, deps_cells = {49, 51}},		-- stabilizer out left
		[51] = {critical_damage = 1, args = {240}},								-- elevator in left
		[49] = {critical_damage = 1, args = {239}},								-- elevator out left
		-------------
		[48] = {critical_damage = 3, args = {234}, deps_cells = {46, 50, 52}},	-- stabilizer in right
		[46] = {critical_damage = 2, args = {233}, deps_cells = {50, 52}},		-- stabilizer out right
		[52] = {critical_damage = 1, args = {238}},								-- elevator in right
		[50] = {critical_damage = 1, args = {237}},								-- elevator out right
		-------------
--		[61] = {critical_damage = 10, args = {233} ,droppable = false}, -- fuel tank front / left
--		[62] = {critical_damage = 10, args = {234} ,droppable = false}, -- fuel tank back / right
		-------------
--		[94] = {critical_damage = 1, args = {265}},	-- nose gear door
--		[95] = {critical_damage = 1, args = {267}},	-- left gear door
--		[96] = {critical_damage = 1, args = {266}},	-- right gear door
	},
	
	DamageParts = 
	{  
		[1] = "F-86F-oblomok-wing-R", -- wing R
		[2] = "F-86F-oblomok-wing-L", -- wing L
		--[3] = "F-86F Sabre-nose", -- nose
		[4] = "F-86F-oblomok-F3", -- tail
	},

    lights_data = {
        typename = "collection",
        lights = {
            -- WOLALIGHT_NAVLIGHTS -- навигационные
            [WOLALIGHT_NAVLIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- left wing
                        typename = "Spot", connector = "BANO_2", dir_correction = {elevation = math.rad(-90.0)}, argument = 190,
                        proto = lamp_prototypes.ANO_3_Kr,
                        controller = "Strobe", mode = 0, period = 60/40, reduced_flash_time = 0.5,
                    },
                    { -- 1 -- right wing
                        typename = "Spot", connector = "BANO_1", dir_correction = {elevation = math.rad(-90.0)}, argument = 191,
                        proto = lamp_prototypes.ANO_3_Zl,
                        controller = "Strobe", mode = 0, period = 60/40, reduced_flash_time = 0.5,
                    },
                    { -- 2 -- right tail / RH white
                        typename = "Spot", connector = "BANO_3", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                        proto = lamp_prototypes.ANO_3_Bl,
                        controller = "Strobe", mode = 0, period = 60/40, reduced_flash_time = 0.5,
                    },
                    { -- 3 -- left tail / LH yellow
                        typename = "Spot", connector = "BANO_4", dir_correction = {azimuth = math.rad(180.0)}, argument = 193,
                        proto = lamp_prototypes.ANO_3_Gl,
                        controller = "Strobe", mode = 0, period = 60/40, reduced_flash_time = 0.5, phase_shift = 0.5,
                    },
                    { -- 4 -- bottom fuselage light
                        typename = "collection",
                        lights = {
                            {
                                typename = "Spot", connector = "BANO_5", pos_correction = {0.0, 0.0, -0.2}, dir_correction = {azimuth = math.rad(180.0)}, argument = 194,
                                color = {255, 201, 125, 0.16}, range = 5.5, angle_max = math.rad(180.0), angle_min = math.rad(175.0),
                            },
                            {
                                typename = "Omni", connector = "BANO_5", pos_correction = {0.0, 0.0, -0.2},
                                color = {255, 201, 125, 0.15}, range = 4.0,
                            },
                        },
                    },
                    { -- 5 -- top fuselage
                        typename = "argumentlight", argument = 195,
                    },
                },
            },
            -- WOLALIGHT_SPOTS -- фары
            [WOLALIGHT_SPOTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- LH LDG & TAXI LIGHT
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 209,
                                proto = lamp_prototypes.LFS_R_27_250,
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR",
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.2, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.0,
                                movable = true,
                            },
                        },
                    },
                    { -- 1 -- RH LANDING LIGHT
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 208,
                                proto = lamp_prototypes.LFS_P_27_450,
                                exposure = {{419, 0.79, 0.81}}, movable = true,
                            },
                            {
                                typename = "spotlight", connector = "MAIN_SPOT_PTR",
                                proto = lamp_prototypes.LFS_P_27_450, range = 2.2, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                                exposure = {{419, 0.79, 0.81}}, movable = true,
                            },
                            {
                                typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_P_27_450, range = 2.0,
                                exposure = {{419, 0.79, 0.81}}, movable = true,
                            },
                        },
                    },
                },
            },
            [WOLALIGHT_TAXI_LIGHTS] = {
                typename = "collection",
                lights = {
                    { -- 0 -- LH LDG & TAXI LIGHT
                        typename = "collection",
                        lights = {
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 209,
                                proto = lamp_prototypes.LFS_R_27_250,
                                movable = true,
                            },
                            {
                                typename = "spotlight", connector = "RESERV_SPOT_PTR",
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.2, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                                movable = true,
                            },
                            {
                                typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                                proto = lamp_prototypes.LFS_R_27_250, range = 2.0,
                                movable = true,
                            },
                        },
                    },
                },
            },
        },
    },-- end of lights data
}

if rewrite_settings then 
   for i,o in pairs(rewrite_settings) do
		base_Sabre[i] = o
   end
end

add_aircraft(base_Sabre)
end

make_Sabre()

----------------------------------------------------------------------------------
	
declare_loadout(
	{
		category	= CAT_FUEL_TANKS,
		CLSID		= "{PTB_200_F86F35}",
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 200 gallons"),
		Weight_Empty	= 70,
		Weight		= 70 +  3.028 * 200,
		Cx_pil		= 0.002,
		shape_table_data = 
		{
			{
				name 	= "PTB_200_F86F35",
				file	= "f-86f-fuel-tank-200";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB_200_F86F35";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB_200_F86F35",
			}, 
		}, 
	}
)

declare_loadout(
	{
		category		= CAT_FUEL_TANKS,
		CLSID			= "{PTB_120_F86F35}",
		attribute		=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture			= "PTB.png",
		displayName		= _("Fuel Tank 120 gallons"),
		Weight_Empty	= 50,
		Weight			= 50 +  3.028 * 120,
		Cx_pil			= 0.001313754,
		shape_table_data = 
		{
			{
				name 	= "PTB_120_F86F35",
				file	= "f-86f-fuel-tank-120";
				life	= 1;
				fire	= { 0, 1};
				username	= "PTB_120_F86F35";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "PTB_120_F86F35",
			}, 
		}, 
	}
)

declare_loadout(
	{
		category		= CAT_BOMBS,
		CLSID		=	"{F86ANM64}",
		Picture		=	"M64.png",
		displayName	=	_("AN-M64 - 500lb GP Bomb LD"),
		Weight	=	227,
		attribute	=	{4,	5,	9,	90},
		Elements	=	
		{
			[1]	=	
			{
				Position	=	{0,- 0.059317,0},
				ShapeName	=	"AN-M64",
			}, 
		}, -- end of Elements
	}
)

declare_loadout(
	{
		category		= CAT_ROCKETS,
		CLSID			= "{HVARx2}",
		attribute		= {4,7,	33,159},
		Picture			= "HVAR.png",
		displayName		= _("2 x HVAR, UnGd Rkts"),
		Weight_Empty	= 0,
		Weight			= 64 * 2,
		Count 			= 2,
		Cx_pil			= 0.001313754,
		Elements		=	{{ShapeName	=	"HVAR_rocket", Position	=	{0   	,  0		,0},  DrawArgs	=	{{3,0.1}}},
							 {ShapeName	=	"HVAR_rocket", Position	=	{0.155  , -0.1396480,0},  DrawArgs	=	{{3,0.2}}}}
	}
)

declare_loadout(
	{
		category		= CAT_PODS,
		CLSID			= "{HVAR_SMOKE_2}",
		Picture			= "HVAR.png",
		displayName		= _("HVAR SMOKE, UnGd Rkt"),
		
		attribute	=	{4,	15,	50,	WSTYPE_PLACEHOLDER},			
		Smoke  = {
			alpha = 180,
			r  = 245,
			g  = 40,
			b  = 100,
			dx = -1.455,
			dy = -0.062
		}, -- red R-73U
		
		shape_table_data = 
		{
			{
				name 	= "HVAR_SMOKE_2",
				file	= "HVAR_rocket";
				life	= 1;
				fire	= { 0, 1};
				username	= "HVAR_SMOKE_2";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Weight			= 100,
		Count 			= 1,
		Cx_pil			= 0.001313754,
		Elements		={{
								ShapeName	=	"HVAR_rocket", 
								Position	=	{0,- 0.059317,0}, 
								DrawArgs	=	{{3,0.1}}
							}}
	}
)

