db_path = db_path or "./Scripts/Database/";
dofile(db_path.."db_countries.lua");
AJS37 =  {
        
	Name 				=   'AJS37',
	DisplayName			= _('AJS37'),
	ViewSettings			= ViewSettings,
	-- takeoff_and_landing_type = "VTOL", -- enable this to take off from ground. AI will land vertically though... :(
	
	Picture 			= "AJS37.png",
	Rate 				= 40, -- RewardPoint in Multiplayer
	Shape 				= "AJS37",
	
	shape_table_data 	= 
	{
		{
			file  	 = 'AJS37';
			life  	 = 18; -- lifebar
			vis   	 = 3; -- visibility gain.
			desrt    = 'su-25-oblomok'; -- Name of destroyed object file name
			fire  	 = { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username = 'AJS37';
			index    =  WSTYPE_PLACEHOLDER;
		},
		{
			name  = "su-25-oblomok";
			file  = "su-25-oblomok";
			fire  = { 240, 2};
		},

	},
	mapclasskey 		= "P0091000025",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER ,"Battleplanes",},
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	

--	Waypoint_Panel = true,
	Navpoint_Panel = true,
--	Fixpoint_Panel = true,

	-------------------------
	M_empty 					= 10659+90, -- kg
	M_nominal 					= 15225, -- kg
	M_max 						= 20000, -- kg
	M_fuel_max 					= 4476, -- kg --Internal fuel
	H_max 					 	= 21000, -- m
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 50, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 152,-- Cruise speed (for AI)
	V_take_off 					= 80, -- Take off speed in m/s (for AI)
	V_land 						= 70, -- Land speed in m/s (for AI)
	V_max_sea_level 			= 408, -- Max speed at sea level in m/s (for AI)
	V_max_h 					= 612, -- Max speed at max altitude in m/s (for AI)
	Vy_max 						= 200, -- Max climb speed in m/s (for AI)
	Mach_max 					= 2.0, -- Max speed in Mach (for AI)
	Ny_min 						= -2, -- Min G (for AI)
	Ny_max 						= 8.0,  -- Max G (for AI)
	Ny_max_e 					= 8.0,  -- Max G (for AI)
	AOA_take_off 				= 0.2, -- AoA in take off (for AI)
	bank_angle_max 				= 85, -- Max bank angle (for AI)


	has_afteburner 				= true, -- AFB yes/no
	has_speedbrake 				= true, -- Speedbrake yes/no
	nose_gear_pos 				= {  5.1,	-2.1,	0}, -- nosegear coord
	main_gear_pos 				= {-0.8, -2.1, -2.5},
	nose_gear_wheel_diameter 	= 0.380, -- in m
	main_gear_wheel_diameter 	= 0.570, -- in m
	tand_gear_max 				= 0.4,
	tanker_type 				= 0, -- Tanker type if the plane is airrefuel capable
	wing_area 					= 46, -- wing area in m2
	wing_span 					= 10.6, -- wing spain in m
	wing_type 					= 0,
	thrust_sum_max 				= 6689, -- thrust in kg (65.6kN)
	thrust_sum_ab 				= 11788, -- thrust inkg (115.6kN)
	length 						= 16.3, -- full lenght in m
	height 						= 5.81,--5.81, -- height in m
	flaps_maneuver 				= 1.0, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 2000, -- Max range in km (for AI)
	RCS 						= 3, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.62, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 2.0, -- With afterburner
	wing_tip_pos                =  {-4.53,    -0.36, -5.1}, -- wingtip coords for visual effects
	brakeshute_name 			= 0, -- Landing - brake chute visual shape after separation
	is_tanker 					= false, -- Tanker yes/no
	air_refuel_receptacle_pos 	= {0, 0, 0}, -- refuel coords
	engines_count				= 1, -- Engines count
	engines_nozzles = {
		[1] = 
		{
			pos 		=  {-3,	-0.1,	0}, -- nozzle coords
			elevation   =  0, -- AFB cone elevation
			diameter	 = 1.3, -- AFB cone diameter
			exhaust_length_ab   = 11, -- lenght in m
			exhaust_length_ab_K = 0.76, -- AB animation
			afterburner_circles_count = 0,
			afterburner_circles_pos = {0.2, 0.8},
			afterburner_circles_scale = 1.0,
			afterburner_effect_texture = "afterburner_f-16c",
			smokiness_level = 0.2, -- 0.4 previously
		}, -- end of [1]
	}, -- end of engines_nozzles
	
	crew_size	 = 1,
	crew_members = 
	{
		[1] = 
		{
			ejection_seat_name = "pilot+ejectionseat",
			drop_canopy_name = "AJS37_CANOPY",
			pos =  {4.8,	0.6,	0},
			canopy_pos = {4.7,	0.0,	0},
		}, -- end of [1]
	}, -- end of crew_members

		net_animation = 
	{
	38, -- Canopy
	400,	-- Taxi light
	435, --[[Afterburner]]
	811, -- Rotating beacon
	900, --[[Left Bogie]]
	901, --[[Hood]]
	910, -- RAT extend
	911, -- RAT spin
	},
	
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
			[12] = {-5.0,-5.0,5.0},
		}, -- end of fires_pos

	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/AJS37_overwingVapor.lua"},
	},
			
	detection_range_max		 = 60,
	radar_can_see_ground 	 = true, -- this should be examined (what is this exactly?)
	CanopyGeometry = {
		azimuth   = {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation = {-50.0, 90.0} -- pilot view vertical (AI)
	},
	
	Sensors = {
		RWR = "Abstract RWR", -- RWR type
		RADAR = "PS-37A", -- Radar typd
		OPTIC = "Shkval", -- laser
	},
	HumanRadio = {
		frequency = 305.0,  -- Radio Freq
		editable = true,
		minFrequency = 103.000,
		maxFrequency = 399.950,
		modulation = MODULATION_AM
	},


 AirframeProperties =
 {
  foreplane =
  {
   area = 6.70;          -- in square meters
   span = 5.45;                                       -- in meters
   mean_chord     = 2.3;                    -- mean aerodynamic chord length
   mean_chord_position   = 1.0;                    -- mean aerodynamic chord position
   mean_chord_position_y = 1.0;                    -- mean aerodynamic chord position - vertical
   sweep_angle     = 59;      -- for leading edge
   sweep_angle_25    = 59;                      -- 25 % of the way back from the leading edge
   tip_pos      = {1.35,    -0.02, -2.42};  -- for vortex attachment
  },
 },


	
--[[ 			SpecificCallnames = {
			[country.USA] = {
				{_('Rod'),			'Rod',			'{1A80D590-0D57-4254-83F1-1E803A89B6EF}'},
				{_('Gul'),			'Gul',			'{320BA7E0-B3E1-431f-B5C2-B1F4C644D8C7}'},
				{_('Gron'),			'Gron',			'{B12C0B89-8893-497d-BB45-2E623720F9A3}'},
				{_('Bla'),			'Bla',			'{CF68FACA-71B5-4bd1-9DEA-D38E9BFCDF6F}'}
			}
		},
		InheriteCommonCallnames = true, ]]
		
-- Countermeasures
	-- There are no discrete nr of chaff charges but there are
	-- 18 charges of flares with 2 flares in each charge.
	-- In fast-mode the flares lasts 72 seconds and the chaff
	-- lasts for 3.5 minutes. The flares are dispensed every other
	-- seconds so there should ideally be 2.91 times more chaff 
	-- than flares (1/(72/(60*3.5))).
	-- Because there can be two pods loaded, the max amount needs
	-- to be two times the max amount of one pod.
		-- Countermeasures
	passivCounterm = {
		CMDS_Edit = true,
		SingleChargeTotal = 280,
		chaff = {default = 105*2, increment = 4, chargeSz = 1},
		flare = {default = 36*2, increment = 4, chargeSz = 1}
	},

	chaff_flare_dispenser = 
	{
		{
			dir = 	{0,	0,	0},
			pos = 	{-3, -1, -2.5},
		},-- end of [1]
		{
			dir = 	{0,	0,	0},
			pos = 	{-3, -1, 2.5},
		},-- end of [2]
	},-- end of chaff_flare_dispenser
	
	
	-- SingleChargeTotal	 	= 280,
	-- CMDS_Incrementation 	= 4,
	-- ChaffDefault 			= 105,
	-- ChaffChargeSize 		= 4,
	-- FlareDefault 			= 36,
	-- FlareChargeSize 		= 1,
	-- CMDS_Edit 				= true,
	-- chaff = {default = 32, increment = 2, chargeSz = 4},
	-- flare = {default = 32, increment = 2, chargeSz = 1},
	-- chaff_flare_dispenser 	= {
		-- [1] = 
		-- {
			-- dir =  {0, 0, -0}, -- I think the flares are just dispensed rearward...
			-- pos =  {-3, -1, 2},
		-- }, -- end of [1]
		-- [2] = 
		-- {
			-- dir =  {0, -0, 0},
			-- pos =  {-3, -1, -2},
		-- }, -- end of [2]
	-- }, -- end of chaff_flare_dispenser
	
	Pylons =     {
        pylon(1, 0, -3.01000, -0.65000, -3.950000, --Left wing rail
            {
				use_full_connector_position=true,
            },
            {
			--{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},
				--{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --    AIM-9M
				--{ CLSID	= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"  }, -- AIM-9P Rb24 replacement					
            }
        ),
        pylon(2, 0, -3.01000, -0.65, -2.944000, --left wing
            {
				use_full_connector_position=true,
            },
            {
			{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},
			
				--{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, -- AIM-9M
				--{ CLSID	= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"  }, -- AIM-9P Rb24 replacement						
				{ CLSID = "{BK90}",Type = 1},									-- BK90
				{ CLSID = "{BK90MJ1}",Type = 1 },									-- BK90 MJ1
				{ CLSID = "{BK90MJ2}",Type = 1},									-- BK90 MJ2
				{CLSID	=	"{AKAN}"}, -- AKAN gun pod
				{CLSID	=	"{ARAKM70BHE}"}, -- ARAK M70HE pod
				{CLSID	=	"{ARAKM70BAP}"}, -- ARAK M70AP pod
				{ CLSID = "{Rb04}",Type = 1}, -- Rb04 for humans
				{CLSID	=	"{Rb15}",Type = 1}, -- Rb15	
				{CLSID	=	"{Rb04AI}",Type = 1, attach_point_position = {0.20 ,-0.270,	0} }, -- Rb04 for AI
				{CLSID	=	"{Rb15AI}",Type = 1, attach_point_position = {0.20 ,-0.270,	0} }, -- Rb15	for AI				{0 ,-0.135,	0}
				{CLSID  =	"{KB}" }, -- KB countermeasure dispenser
				{CLSID  =	"{LYSBOMB}" }, -- Illumination bomb
				{CLSID  =   "{M71BOMB}" }, -- HE bomb
				{CLSID  =   "{M71BOMBD}" }, -- HE bomb w chute	
				{CLSID  =   "{MERPYLON}" }, -- EMPTY PYLON
				{CLSID  =   "{RB75}" }, -- RB75		
				{CLSID  =   "{RB75B}" }, -- RB75B		
				{CLSID  =   "{RB75T}" }, -- RB75T		
            }
        ),
        pylon(3, 0, 0.660000, -0.973000, -0.863000, --left fuselage
            {
				use_full_connector_position=true,
            },
            {
			{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},
				--{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --    AIM-9M
				--{ CLSID	= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"  }, -- AIM-9P Rb24 replacement						
				{ CLSID = "{BK90}",Type = 1},									-- BK90
				{ CLSID = "{BK90MJ1}",Type = 1},									-- BK90 MJ1
				{ CLSID = "{BK90MJ2}",Type = 1},									-- BK90 MJ2
				{CLSID	=	"{ARAKM70BHE}"}, -- ARAK M70HE pod
				{CLSID	=	"{ARAKM70BAP}"}, -- ARAK M70AP pod				
				{CLSID	=	"{Robot05}" }, -- Rb05
				{CLSID  =	"{LYSBOMB}" }, -- Illumination bomb
				{CLSID  =   "{M71BOMB}" }, -- HE bomb
				{CLSID  =   "{M71BOMBD}" }, -- HE bomb w chute	
				{CLSID  =   "{MERPYLON}" }, -- EMPTY PYLON
				{CLSID  =   "{RB75}" }, -- RB75		
				{CLSID  =   "{RB75B}" }, -- RB75B		
				{CLSID  =   "{RB75T}" }, -- RB75T		
            }
        ),
		
		pylon(4, 1, 1.435, -1.125, -0, --centre pylon 
            {
				use_full_connector_position=true,
			},
            {
				{ CLSID	= "{VIGGEN_X-TANK}",Type = 1}, -- Viggen tank
            }
		),
		pylon(5, 0, 0.660000, -0.973000, 0.863000, --right fuselage
            {
				use_full_connector_position=true,
			},
            {
			{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},
				--{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --    AIM-9M 
				--{ CLSID	= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"  }, -- AIM-9P Rb24 replacement		
				{ CLSID = "{BK90}",Type = 1},									-- BK90
				{ CLSID = "{BK90MJ1}",Type = 1},									-- BK90 MJ1
				{ CLSID = "{BK90MJ2}",Type = 1},									-- BK90 MJ2
				{CLSID	=	"{ARAKM70BHE}"}, -- ARAK M70HE pod
				{CLSID	=	"{ARAKM70BAP}"}, -- ARAK M70AP pod				
				{CLSID	=	"{Robot05}" }, -- Rb05	
				{CLSID  =	"{LYSBOMB}" }, -- Illumination bomb		
				{CLSID  =   "{M71BOMB}" }, -- HE bomb	
				{CLSID  =   "{M71BOMBD}" }, -- HE bomb w chute		
				{CLSID  =   "{RB75}" }, -- RB75		
				{CLSID  =   "{RB75B}" }, -- RB75B		
				{CLSID  =   "{RB75T}" }, -- RB75T		
{CLSID  =   "{MERPYLON}" }, -- EMPTY PYLON				
            }
		),
		pylon(6, 0, -3.01000, -0.65, 2.944000, --Right wing
            {
				use_full_connector_position=true,
			},
            {
			{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},		
				{ CLSID = "{BK90}",Type = 1},									-- BK90
				{ CLSID = "{BK90MJ1}",Type = 1},									-- BK90 MJ1
				{ CLSID = "{BK90MJ2}",Type = 1},									-- BK90 MJ2
				{CLSID	=	"{AKAN}"}, -- AKAN gun pod
				{CLSID	=	"{ARAKM70BHE}"}, -- ARAK M70HE pod
				{CLSID	=	"{ARAKM70BAP}"}, -- ARAK M70AP pod				
				{ CLSID = "{Rb04}",Type = 1}, -- Rb04 for humans
				{CLSID	=	"{Rb15}",Type = 1}, -- Rb15	for humans				
				{CLSID	=	"{Rb04AI}",Type = 1, attach_point_position = {0.20 ,-0.270,	0} }, -- Rb04 for AI
				{CLSID	=	"{Rb15AI}",Type = 1, attach_point_position = {0.20 ,-0.270,	0} }, -- Rb15	for AI 		
				{CLSID  =	"{KB}" }, -- KB countermeasure dispenser
				{CLSID  =	"{U22}" }, -- U22 jammer
				{CLSID  =	"{U22A}" }, -- U22/A jammer
				{CLSID  =	"{LYSBOMB}" }, -- Illumination bomb
				{CLSID  =   "{M71BOMB}" }, -- HE bomb
				{CLSID  =   "{M71BOMBD}" }, -- HE bomb w chute
				{CLSID  =   "{MERPYLON}" }, -- EMPTY PYLON
				{CLSID  =   "{RB75}" }, -- RB75		
				{CLSID  =   "{RB75B}" }, -- RB75B		
				{CLSID  =   "{RB75T}" }, -- RB75T	
            }
		),
		------------
        pylon(7, 0, -3.01000, -0.65000, 3.95, -- Right wing rail
            {
				use_full_connector_position=true,
            },
            {
			--{CLSID = "{Robot74}"},
			{CLSID = "{Robot24J}"},
			{CLSID = "{Robot24}"},
				--{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}" }, --    AIM-9M
				--{ CLSID	= "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}" }, -- AIM-9P Rb24 replacement							
            }
        ),
    },
	
--	 LandRWCategories = 
-- {
 -- [1] = 
 -- {
 --  Name = "AircraftCarrier",
 -- }, -- end of [1]
 --}, -- end of LandRWCategories
 
-- TakeOffRWCategories = 
-- {
 -- [1] = 
 -- {
 --  Name = "AircraftCarrier With Catapult",
 -- }, -- end of [1]
 --}, -- end of TakeOffRWCategories
	
	Tasks = {
        aircraft_task(GroundAttack),
        aircraft_task(RunwayAttack),
        aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(CAP),
        aircraft_task(Escort),
        aircraft_task(SEAD),
        aircraft_task(FighterSweep),
        aircraft_task(Intercept),
		aircraft_task(AntishipStrike),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(GroundAttack),
	
	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0			=	0,      -- zero AoA lift coefficient
			Mzalfa		=	3.255,  -- coefficients for pitch agility
			Mzalfadt	=	1.2,    -- coefficients for pitch agility
			kjx			=	2.0,    
			kjz			=	0.00125,  
			Czbe		=	-0.014, -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear		=	0.3,    -- coefficient, drag, gear
			cx_flap		=	0.08,   -- coefficient, drag, full flaps
			cy_flap		=	0.4,    -- coefficient, normal force, lift, flaps
			cx_brk		=	0.20,   -- coefficient, drag, breaks
			table_data  = 
			{	--      M		Cx0		 Cya		B	B4	    Omxmax		Aldop		Cymax
				[1] = 	{0,	   0.0100087631,	0.025,	0.175,	0,		0.5,		20,			1.17},
				[2] = 	{0.2,	0.0100087631,	0.043,	0.175,	0,		3.197,		17,			1.17},
				[3] = 	{0.4,	0.0100087631,	0.064,	0.175,	0,		3.014,		15,			0.935},
				[4] = 	{0.6,	0.0100087631,	0.065,	0.175,	0,		1.910,		15,			0.875},


				[5] = 	{0.7,	0.0100087631,	0.071,	0.175,	0,		2.242,		15,			0.845},
				[6] = 	{0.8,	0.0100087631,	0.072,	0.175,	0,		2.580,		15,			0.865},
				[7] = 	{0.9,	0.0078,	0.078,	0.175,	0,		2.923,		15,			0.985},

				[8] = 	{1	,	0.016,	0.089,	0.175,	0,		3.161,		15,			1.185},
				[9] = 	{1.05,	0.0190920818,	0.087,	0.189,	0,		3.049,		15,			1.185},
				[10] = 	{1.1,	0.0190920818,	0.086,	0.204,	0,		2.937,		15,			1.185},
				[11] = 	{1.2,	0.0190920818,	0.080,	0.218,	0,		3.209,		15,			1},
				[12] = 	{1.3,	0.0190920818,	0.074,	0.235,	0,		2.055,		15,			1},
				[13] = 	{1.5,	0.0190920818,	0.063,	0.278,	0,		2.179,		13,			1},

				[14] = 	{1.7,	0.0190920818,	0.051,	0.339,	0,		2.113,		12,			0.8},
				[15] = 	{1.8,	0.0190920818,	0.046,	0.381,	0,		2.218,		11.4,		0.7},
				[16] = 	{2,	    0.0190920818,	0.034,	0.506,	0,		2.399,		10.2,		0.6},
				[17] = 	{2.1,	0.0190920818,	0.029,	0.606,	0,		2.47,		9.6,		0.6},
				[18] = 	{2.2,	0.0190920818,	0.023,	0.755,	0,		0.7,		9,			0.6},
				[19] = 	{3.9,	0.0190920818,	0.033,	0.35,	0,		0.7,		9,			0.6},
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
			Nmg	=	59, -- RPM at idle
			MinRUD	=	0, -- Min state of the throttle
			MaxRUD	=	1, -- Max state of the throttle
			MaksRUD	=	0.60, -- Military power state of the throttle
			ForsRUD	=	0.71, -- Afterburner state of the throttle
			typeng	=	1,
			--[[
				E_TURBOJET = 0
				E_TURBOJET_AB = 1
				E_PISTON = 2
				E_TURBOPROP = 3
				E_TURBOFAN				= 4
				E_TURBOSHAFT = 5
			--]]
			
			hMaxEng	=	20, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.0124, -- Engine drag coeficient
			cemax	=	1.24, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calulation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	2000, --  altitude coefficient for max thrust
			dpdh_f	=	4200,  --  altitude coefficient for AB thrust
			table_data = 
			{		--   M		Pmax		 Pfor	
				[1] = 	{0,	65600,	115600},
				[2] = 	{0.2,	65600,	115000},
				[3] = 	{0.4,	79000,	150000},
				[4] = 	{0.6,	82000,	165000},
				[5] = 	{0.7,	90000,	177000},
				[6] = 	{0.8,	94000,	193000},
				[7] = 	{0.9,	96000,	200000},
				[8] = 	{1,	100000,	205000},
				[9] = 	{1.1,	100000,	214000},
				[10] = 	{1.2,	98000,	222000},
				[11] = 	{1.3,	100000,	235000},
				[12] = 	{1.5,	98000,	258000},
				[13] = 	{1.8,	94000,	276000},
				[14] = 	{2,	88000,	283000},
				[15] = 	{2.2,	82000,	285000},
				[16] = 	{2.5,	80000,	287000},
				[17] = 	{3.9,	50000,	200000},
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = verbose_to_dmg_properties(
	{

	
				--MAIN-----------------------------------------------------------------------------------
				["FRONT"]					= {args = {148}, critical_damage = 2}, -- NOSE_BOTTOM
				
				["COCKPIT"]					= {args = {65},  critical_damage = 4},-- COCKPIT
				
				["FUSELAGE_LEFT_SIDE"]		= {args = {154}, critical_damage = 3}, -- FUSELAGE_LEFT_SIDE
				["FUSELAGE_RIGHT_SIDE"]		= {args = {153}, critical_damage = 3}, -- FUSELAGE_RIGHT_SIDE
				
				["TAIL"]					= {args = {159}, critical_damage = 3}, --
				
				["PYLON_04"]				= {				 critical_damage = 2},
				["ENGINE"]					= {args = {271}, critical_damage = 7, deps_cells = {"TAIL"}}, -- ENGINE Mid fuselage, high strength due to size
				--END MAIN----------------------------------------------------------------------------------
				
				
				
				--LEFT WING--------------------------------------------------------------------------------------------------------------------------
				["WING_L_IN"]				= {args = {225}, critical_damage = 5, deps_cells = {"WING_L_OUT", "ELEVATOR_L_IN", "PYLON_03", "PYLON_02", "AILERON_L"}}, -- WING_L_IN
				["WING_L_OUT"]				= {args = {223}, critical_damage = 5, deps_cells = {"PYLON_01", "AILERON_L"}}, -- WING_L_OUT
				["AILERON_L"]				= {args = {998}, critical_damage = 2}, -- Left outer surface			
				["ELEVATOR_L_IN"]			= {args = {997}, critical_damage = 2}, -- Left inner surface
				--END LEFT WING-----------------------------------------------------------------------------------------------------
				
				
				["PYLON_01"]				= {				 critical_damage = 2},
				["PYLON_02"]				= {				 critical_damage = 2},
				["PYLON_03"]				= {				 critical_damage = 2},
				
				
				--RIGHT WING-------------------------------------------------------------------------------------------------
				["WING_R_IN"]				= {args = {701}, critical_damage = 5, deps_cells = {"WING_R_OUT", "ELEVATOR_R_IN"}}, -- WING_R_IN
				["WING_R_OUT"]				= {args = {700}, critical_damage = 5, deps_cells = {"AILERON_R"}}, -- WING_R_OUT
				["AILERON_R"]				= {args = {216}, critical_damage = 3}, -- Right outer surface			
				["ELEVATOR_R_IN"]			= {args = {999}, critical_damage = 3}, -- Right inner surface
				--END RIGHT WING---------------------------------------------------------------------------------------------
				
				
			--	["PYLON_05"]				= {				 critical_damage = 2},
			--	["PYLON_06"]				= {				 critical_damage = 2},
			--	["PYLON_07"]				= {				 critical_damage = 2},				

			
			-- CANARDS-----------------------------------------------------------------
				["STABILIZATOR_L"]			= {args = {226}, critical_damage = 3, deps_cells = {"FLAP_L"}},-- LEFT CANARD!!
				
				["FLAP_L"]					= {args = {227}, critical_damage = 2},-- LEFT CANARDFLAP!!
				
				["STABILIZATOR_R"]			= {args = {800}, critical_damage = 3, deps_cells = {"FLAP_R"}},-- Right canard
				["FLAP_R"]					= {args = {801}, critical_damage = 2},-- FLAP_R -- flap
			--END CANARDS---------------------------------------------------------------
			
			
			
			--VERTICAL TAILPLANE--------------------------------------------------------
				["FIN_L_TOP"]				= {args = {242}, critical_damage = 3},
				["FIN_L_BOTTOM"]			= {args = {246}, critical_damage = 3},
				["RUDDER"]					= {args = {248}, critical_damage = 2},-- RUDDER
			--END VERTICAL TAILPLANE------------------------------------------------------
			
			
			
			--TIRES-----------------------------------------------------------------------
				["WHEEL_F"]					= {args = {134}, critical_damage = 4},-- WHEEL_F
				["WHEEL_L"]					= {args = {136}, critical_damage = 4},-- WHEEL_L
				["WHEEL_R"]					= {args = {135}, critical_damage = 4},-- WHEEL_R
			--END TIRES-------------------------------------------------------------------
			
				}),
	
	DamageParts = 
	{  
		[1000 + 36] = "AJS37-part-wing-R", -- Wing R
		[1000 + 35] = "AJS37-part-wing-L", -- Wing L
		[1000 + 26] = "AJS37-part-aileron", --Aileron R
		[1000 + 25] = "AJS37-part-aileron", --Aileron L
		[1000 + 37] = "AJS37-part-canardflap", --Canard Flap L
		[1000 + 38] = "AJS37-part-canardflap", --Canard Flap R
		
		[1000 + 51] = "AJS37-part-elevon", --Elevon L
		[1000 + 52] = "AJS37-part-elevon", -- Elevon R
		
		
		[3] = "AJS37-part-nose", -- nose
		[4] = "AJS37-part-tail", -- tail
		--[1000 + 37] = "DMG_AJS37_LCANARD", 
		
		--damage_cells["AILERON_R"] = 26

		--damage_cells["FLAP_L"] = 37
		--damage_cells["FLAP_R"] = 38 AJS37-part-canardflap
		--damage_cells["ELEVATOR_L_IN"] = 51
		--damage_cells["ELEVATOR_R_IN"] = 52
	},
	
		Failures = {
		{ id = 'ADI_UNIT',	  	  label = _('Flight attitude and direction unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CK_UNIT',	  	  label = _('Centralkalkylator 37'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DATACARTRIDGE',	  	  label = _('Data cartridge'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RPMSENSOR',	  	  label = _('RPM sensor'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'EGTSENSOR',	  	  label = _('EGT sensor'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'EPRSENSOR',	  	  label = _('EPR sensor'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TVDISPLAY',	  	  label = _('EP13 Maverick sight display'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HUDDISPLAY',	  	  label = _('EP08 Head Up Display'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAINPITOT',	  	  label = _('Main pitot'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AOASENSOR',	  	  label = _('Angle of attack sensor'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ACCSENSOR',	  	  label = _('Accelerometer unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FDU',	  	  label = _('Flight Data Unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BCKPITOT',	  	  label = _('Backup pitot'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BCKGYRO',	  	  label = _('Backup gyro'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TEMPSENSOR',	  	  label = _('Temperature sensor'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HAW',	  	  label = _('High Alpha Warning'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FR22RADIO',	  	  label = _('FR22 Radio unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FR22ANTENNA',	  	  label = _('FR22 Radio antenna'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FR24RADIO',	  	  label = _('FR24 Radio unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FR24ANTENNA',	  	  label = _('FR24 Radio antenna'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADARALTUNIT',	  	  label = _('Radar altimeter unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADARALTANT',	  	  label = _('Radar altimeter antenna'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADARASS',	  	  label = _('Radar PS-37 assembly'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RADARDISPL',	  	  label = _('Central Indikator display'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TAPEREC',	  	  label = _('Tape recorder'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RB05ANT',	  	  label = _('Rb05 antenna unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWRANTLEFT',	  	  label = _('RWR antenna left wing'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWRANTRIGHT',	  	  label = _('RWR antenna right wing'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWRANTREAR',	  	  label = _('RWR antenna rear'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RWRUNIT',	  	  label = _('RWR control unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'JAMMER',	  	  label = _('U22 or U22/A Jammer'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CMDISP',	  	  label = _('KB countermeasure dispenser'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AUTOPILOT',	  	  label = _('SA-06 Autopilot unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONOUTERLEFT',	  	  label = _('Elevon control surface outer left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONINNERLEFT',	  	  label = _('Elevon control surface inner left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONINNERRIGHT',	  	  label = _('Elevon control surface inner right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONOUTERRIGHT',	  	  label = _('Elevon control surface outer right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONSERVOUTERLEFT',	  	  label = _('Elevon servo outer left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONSERVINNERLEFT',	  	  label = _('Elevon servo inner left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONSERVINNERRIGHT',	  	  label = _('Elevon servo inner right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'ELEVONSERVOUTERRIGHT',	  	  label = _('Elevon servo outer right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RUDDER',	  	  label = _('Rudder control surface'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'RUDDERSERV',	  	  label = _('Rudder servo'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CANARDFLAPLEFT',	  	  label = _('Canard flap surface left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CANARDFLAPRIGHT',	  	  label = _('Canard flap surface right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CANARDSERVOLEFT',	  	  label = _('Canard flap servo left'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'CANARDSERVORIGHT',	  	  label = _('Canard flap servo right'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AIRBRAKE',	  	  label = _('Airbrake surfaces'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AIRBRAKESERVO',	  	  label = _('Airbrake servo'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDR1PUMP',	  	  label = _('Hydraulic pump System 1'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDR1ACC',	  	  label = _('Hydraulic accumulator System 1'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDR2PUMP',	  	  label = _('Hydraulic pump System 2'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDR2ACC',	  	  label = _('Hydraulic accumulator System 2'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'HYDRRESERVPUMP',	  	  label = _('Hydraulic pump backup'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'OXYGEN',	  	  label = _('Oxygen bottle'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAINPOWER',	  	  label = _('Main electrical junction & relays'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'MAINGENERATOR',	  	  label = _('Main generator'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BACKUPGENERATOR',	  	  label = _('Backup generator (RAT)'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BATTERY',	  	  label = _('Main battery'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'IFF',	  	  label = _('IFF'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TILS',	  	  label = _('TILS'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'DOPPLER_UNIT',	  	  label = _('Doppler unit'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'COMPRESSOR',	  	  label = _('Engine fan and compressor stage'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'BURNER',	  	  label = _('Engine burner stage'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'TURBINE',	  	  label = _('Engine turbine stage'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'GTS',	  	  label = _('Engine starter (GTS)'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'AFK',	  	  label = _('Auto-thrust (AFK)'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'REVERSER',	  	  label = _('Thrust reverser'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK2',	  	  label = _('Fuel tank 2'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK3L',	  	  label = _('Fuel tank 3V'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK3R',	  	  label = _('Fuel tank 3H'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK1',	  	  label = _('Fuel tank 1'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK4L',	  	  label = _('Fuel tank 4V'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK5L',	  	  label = _('Fuel tank 5V'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK4R',	  	  label = _('Fuel tank 4H'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'FUELTANK5R',	  	  label = _('Fuel tank 5H'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'LANDINGGEARL',	  	  label = _('Left landing gear'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = 'LANDINGGEARR',	  	  label = _('Right landing gear'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },

		
		
		},
		panelRadio = {
       [1] = {
           name = _("Radio frequencies"),		   
           range = {	
						{min = 103.0, max = 400.0}
			},
            channels = {
				[1] = { name = _("Group 100"), default = 305.0, modulation = _("AM"), connect = true},
				[2] = { name = _("Group 101"), default = 264.0, modulation = _("AM")},
				[3] = { name = _("Group 102"), default = 265.0, modulation = _("AM")},
				[4] = { name = _("Group 103"), default = 256.0, modulation = _("AM")},
				[5] = { name = _("Group 104"), default = 254.0, modulation = _("AM")},
				[6] = { name = _("Group 105"), default = 250.0, modulation = _("AM")},
				[7] = { name = _("Group 106"), default = 270.0, modulation = _("AM")},
				[8] = { name = _("Group 107"), default = 257.0, modulation = _("AM")},
				[9] = { name = _("Group 108"), default = 255.0, modulation = _("AM")},
				[10] = { name = _("Group 109"), default = 262.0, modulation = _("AM")},
				[11] = { name = _("Group 110"), default = 259.0, modulation = _("AM")},
				[12] = { name = _("Group 111"), default = 268.0, modulation = _("AM")},
				[13] = { name = _("Group 112"), default = 269.0, modulation = _("AM")},
				[14] = { name = _("Group 113"), default = 260.0, modulation = _("AM")},
				[15] = { name = _("Group 114"), default = 263.0, modulation = _("AM")},
				[16] = { name = _("Group 115"), default = 261.0, modulation = _("AM")},
				[17] = { name = _("Group 116"), default = 267.0, modulation = _("AM")},
				[18] = { name = _("Group 117"), default = 251.0, modulation = _("AM")},
				[19] = { name = _("Group 118"), default = 253.0, modulation = _("AM")},
				[20] = { name = _("Group 119"), default = 266.0, modulation = _("AM")},

				[21] = { name = _("Group 120"), default = 305.0, modulation = _("AM")},
				[22] = { name = _("Group 121"), default = 264.0, modulation = _("AM")},
				[23] = { name = _("Group 122"), default = 265.0, modulation = _("AM")},
				[24] = { name = _("Group 123"), default = 256.0, modulation = _("AM")},
				[25] = { name = _("Group 124"), default = 254.0, modulation = _("AM")},
				[26] = { name = _("Group 125"), default = 250.0, modulation = _("AM")},
				[27] = { name = _("Group 126"), default = 270.0, modulation = _("AM")},
				[28] = { name = _("Group 127"), default = 257.0, modulation = _("AM")},
				[29] = { name = _("Group 128"), default = 255.0, modulation = _("AM")},
				[30] = { name = _("Group 139"), default = 262.0, modulation = _("AM")},
				[31] = { name = _("Group 130"), default = 259.0, modulation = _("AM")},
				[32] = { name = _("Group 131"), default = 268.0, modulation = _("AM")},
				[33] = { name = _("Group 132"), default = 269.0, modulation = _("AM")},
				[34] = { name = _("Group 133"), default = 260.0, modulation = _("AM")},
				[35] = { name = _("Group 134"), default = 263.0, modulation = _("AM")},
				[36] = { name = _("Group 135"), default = 261.0, modulation = _("AM")},
				[37] = { name = _("Group 136"), default = 267.0, modulation = _("AM")},
				[38] = { name = _("Group 137"), default = 251.0, modulation = _("AM")},
				[39] = { name = _("Group 138"), default = 253.0, modulation = _("AM")},
				[40] = { name = _("Group 139"), default = 266.0, modulation = _("AM")},

                [41] = { name = _("Special 1"), default = 305.0, modulation = _("AM")}, -- default
                [42] = { name = _("Special 2"), default = 264.0, modulation = _("AM")},	-- min. water : 135.0, 264.0
                [43] = { name = _("Special 3"), default = 265.0, modulation = _("AM")},	-- nalchik : 136.0, 265.0
                [44] = { name = _("E"), default = 125.0, modulation = _("AM")},	-- maykop : 125.0, 254.0
                [45] = { name = _("F"), default = 121.0, modulation = _("AM")},	-- anapa : 121.0, 250.0
                [46] = { name = _("G"), default = 141.0, modulation = _("AM")},	-- beslan : 141.0, 270.0
                [47] = { name = _("H (LARM/GUARD)"),		default = 121.5, modulation = _("AM")},	-- beslan : 141.0, 270.0
            }
       },
	          -- [2] = {
           -- name = _("Identify Friendly or Foe"),		   
           -- range = {	
						-- {min = 1, max = 11}
			-- },
            -- channels = {
                -- [1] = { name = _("IFF code"),		default = 2}, -- default
                -- }
       -- },
   },	
   		AddPropAircraft = {
			{ id = "Rb04GroupTarget" , control = 'comboList', label = _('Rb04 Group Target Selection'),
				values = {{id =  0, dispName = _("First and third")},
							{id =  1, dispName = _("First and second")},
							{id = 2, dispName = _("Second and third")},
							{id = 3, dispName = _("Random")}},
				defValue  = 3,
				wCtrl     = 150
			},			
			{ id = "Rb04VinkelHopp" , control = 'comboList', label = _('Rb04 Angle Jump Target Selection'),
				values = {{id =  0, dispName = _("None")},
							{id =  1, dispName = _("Left")},
							{id = 2, dispName = _("Right")},
							{id = 3, dispName = _("Both")}},
				defValue  = 0,
				wCtrl     = 150
			},	
			{ id = "WeapSafeHeight" , control = 'comboList', label = _('Weapon safety height'),
				values = {{id =  0, dispName = _("Low Alt")},
							{id =  1, dispName = _("Medium Alt")},
							{id = 2, dispName = _("High Alt")}},
				defValue  = 1,
				wCtrl     = 150
			},
			{ id = "MissionGeneratorSetting", control = 'comboList', label = _('Cartridge restrictions'),
				values = {{id =  0, dispName = _("Allow all")},
							--{id =  1, dispName = _("Allow for discovered units")},
							{id = 2, dispName = _("Allow non-generated")},
							{id = 3, dispName = _("Disallow cartridge switching")}},
				defValue  = 0,
				wCtrl     = 150
			},
			-- { id = "AutomagicPresets" , control = 'checkbox', label = _('Use automagic radio presets'),
				-- defValue = true, weightWhenOn = -80
			-- },
			
		},

		
	lights_data = {
	typename = "collection",
	lights = {
    [1] = { typename = "collection",
						lights = {
								  -- Top Anticollision Light
								  {typename = "strobelight",
								   connector = "RED_BEACON T001",
								   argument_1 = 811,
								   period = 1.33,
								   phase_shift = 0,
								   color = {0.07,0,0, 0.5},
								  },
								  -- Tail Anticollision Light
								  {typename = "strobelight",
								   connector = "RED_BEACON B001",
--argument_1 = 192,
								   period = 1.33,
								   phase_shift = 0,
								   color = {0.07,0,0, 0.0},
								  }
								 }
									  },
	[2] = { typename = "collection",
							lights = {-- Landing light
									  {typename = "argumentlight",
									   connector = "MAIN_SPOT_PTR_01",
									  -- argument = 400,
									   dir_correction = {elevation = math.rad(-1)}
									  }
									 }
						},
    [3]	= {	typename = "collection", --Navlights
						lights = {-- Left wing tip Light (red)
								  {typename = "argumentlight",
								   connector = "BANO_6",
								   color = {0, 0, 0, 0.0},
								--   pos_correction  = {0, 0, -0.2},
								   argument  = 190
								  },
								  -- Right wing tip Light (green)
								  {typename = "argumentlight",
								   connector = "BANO_8",
								   color = {0, 0, 0, 0.0},
								 --  pos_correction = {0, 0, 0.2},
								   argument  = 190
								  },
								}
									},
    [4] = {	typename = "collection", --formation lights
				lights = {-- Electroluminescent formation lights
							{typename  = "argumentlight", argument = 812},
						 }
			},

    [5]	= {	typename = "collection", --Led ljus
						lights = {
								  --Left middle
								{typename = "argumentlight",
								   connector = "BANO_009",
								   color = {0, 0, 0, 0.0},
								--   pos_correction  = {0, 0, -0.2},
								   argument  = 191
								  },
								  -- Right middle
								  {typename = "argumentlight",
								   connector = "BANO_010",
								   color = {0, 0, 0, 0.0},
								 --  pos_correction = {0, 0, 0.2},
								   argument  = 191
								  },

								}
							},
	[6]	= {	typename = "collection", --Lanternor
						lights = {
								
								  --Left root
								{typename = "argumentlight",
								   connector = "BANO_3",
								   color = {0, 0, 0, 0.0},
								--   pos_correction  = {0, 0, -0.2},
								   argument  = 192
								  },
								  -- Right root
								  {typename = "argumentlight",
								   connector = "BANO_4",
								   color = {0, 0, 0, 0.0},
								 --  pos_correction = {0, 0, 0.2},
								   argument  = 192
								  },
								}
							},
							
		}
	},
}

add_aircraft(AJS37)
