
function applyRewriteSettings(src, target)
	if not src then
		return
	end
	
    for i, v in pairs(src) do
        if type(v) == 'table' then
            target[i] = {}
            copyTable(v, target[i])
        else
            target[i] = v
        end
    end
end

g_suit_effectiveness		= 1

noPassivCounterm = {
	CMDS_Edit 				= false,
	SingleChargeTotal 		= 0,
	chaff 					= {default = 0, increment = 0, chargeSz = 0},
	flare 					= {default = 0, increment = 0, chargeSz = 0}
}

passivCounterm = {
	CMDS_Edit 				= true,
	SingleChargeTotal 		= 60,
	chaff 					= {default = 30, increment = 30, chargeSz = 1},
	flare 					= {default = 15, increment = 15, chargeSz = 2}
}

-- KC-130 and KC-135MPRS have 'floating' drogue contact point lateral positioning.
-- The short probe coordinates were adjusted to account for this.
air_refuel_receptacle_pos_short = {5.66, 0.483, 0.311}
air_refuel_receptacle_pos_long = {5.818, 0.483, 0.311}

panelRadio_CE_BE_EE = {
	[1] = {  
		name = _("TRAP-136"),
		range = {min = 118.0, max = 399.975},
		channels = {
			[1] = { name = _("Channel 1"), default = 118.0, modulation = _("AM"), connect = true},
			[2] = { name = _("Channel 2"), default = 119.25, modulation = _("AM")},
			[3] = { name = _("Channel 3"), default = 122.0, modulation = _("AM")},
			[4] = { name = _("Channel 4"), default = 126.5, modulation = _("AM")},
			[5] = { name = _("Channel 5"), default = 127.0, modulation = _("AM")},
			[6] = { name = _("Channel 6"), default = 129.0, modulation = _("AM")},
			[7] = { name = _("Channel 7"), default = 131.0, modulation = _("AM")},
			[8] = { name = _("Channel 8"), default = 133.0, modulation = _("AM")},
			[9] = { name = _("Channel 9"), default = 141.0, modulation = _("AM")},
			[10] = { name = _("Channel 10"), default = 250.5, modulation = _("AM")},
			[11] = { name = _("Channel 11"), default = 251.0, modulation = _("AM")},
			[12] = { name = _("Channel 12"), default = 253.0, modulation = _("AM")},
			[13] = { name = _("Channel 13"), default = 254.0, modulation = _("AM")},
			[14] = { name = _("Channel 14"), default = 257.0, modulation = _("AM")},
			[15] = { name = _("Channel 15"), default = 260.0, modulation = _("AM")},
			[16] = { name = _("Channel 16"), default = 261.0, modulation = _("AM")},
			[17] = { name = _("Channel 17"), default = 262.0, modulation = _("AM")},
			[18] = { name = _("Channel 18"), default = 263.0, modulation = _("AM")},
			[19] = { name = _("Channel 19"), default = 267.0, modulation = _("AM")},
			[20] = { name = _("Channel 20"), default = 270.0, modulation = _("AM")},
		}			
	},
	
	[2] = {  
		name = _("TRAP-137B"),
		range = {min = 225.0, max = 399.975},
		channels = {
			[1] = { name = _("Channel 1"), default = 225.0, modulation = _("AM")},
			[2] = { name = _("Channel 2"), default = 230.0, modulation = _("AM")},
			[3] = { name = _("Channel 3"), default = 240.0, modulation = _("AM")},
			[4] = { name = _("Channel 4"), default = 250.5, modulation = _("AM")},
			[5] = { name = _("Channel 5"), default = 251.0, modulation = _("AM")},
			[6] = { name = _("Channel 6"), default = 256.0, modulation = _("AM")},
			[7] = { name = _("Channel 7"), default = 257.0, modulation = _("AM")},
			[8] = { name = _("Channel 8"), default = 262.0, modulation = _("AM")},
			[9] = { name = _("Channel 9"), default = 263.0, modulation = _("AM")},
			[10] = { name = _("Channel 10"), default = 267.0, modulation = _("AM")},
			[11] = { name = _("Channel 11"), default = 270.0, modulation = _("AM")},
			[12] = { name = _("Channel 12"), default = 254.0, modulation = _("AM")},
			[13] = { name = _("Channel 13"), default = 264.0, modulation = _("AM")},
			[14] = { name = _("Channel 14"), default = 266.0, modulation = _("AM")},
			[15] = { name = _("Channel 15"), default = 265.0, modulation = _("AM")},
			[16] = { name = _("Channel 16"), default = 252.0, modulation = _("AM")},
			[17] = { name = _("Channel 17"), default = 268.0, modulation = _("AM")},
			[18] = { name = _("Channel 18"), default = 271.0, modulation = _("AM")},
			[19] = { name = _("Channel 19"), default = 275.0, modulation = _("AM")},
			[20] = { name = _("Channel 20 (N/A in 'Easy Comms')"), default = 360.0, modulation = _("AM")},
		}			
	}
}

function makeAttribute(WorldID, refuelable)
	local res = {wsType_Air, wsType_Airplane, wsType_Fighter, WorldID, "Multirole fighters"}
	
	if refuelable == true then
		res[#res + 1] = "Refuelable"
	end
	
	return res
end

local defaultOptionWidgedWidth = 75

function makeAircraftProperties(...)
	
	-- Properties common for each aircraft version
	local props = {
		{ id = "RadarCoverSettings", control = 'comboList', label = _('Force Radar Cover State At Start'), playerOnly = true, 
		  values = {{id = 1, dispName = _("NO")},
					{id = 2, dispName = _("FORCE ON")},
					{id = 3, dispName = _("FORCE OFF")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
	
		{ id = "ChaffMultiNumber", control = 'comboList', label = _('Chaff Burst Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("3")},
					{id = 4, dispName = _("4")},
					{id = 5, dispName = _("6")},
					{id = 6, dispName = _("8")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffMultiTime", control = 'comboList', label = _('Chaff Burst Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("0.05 s")},
					{id = 2, dispName = _("0.1 s")},
					{id = 3, dispName = _("0.15 s")},
					{id = 4, dispName = _("0.2 s")},
					{id = 5, dispName = _("0.3 s")},
					{id = 6, dispName = _("0.4 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffProgramNumber", control = 'comboList', label = _('Chaff Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("4")},
					{id = 4, dispName = _("8")},
					{id = 5, dispName = _("Continuous")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "ChaffProgramTime", control = 'comboList', label = _('Chaff Salvo Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1.0 s")},
					{id = 2, dispName = _("2.0 s")},
					{id = 3, dispName = _("3.0 s")},
					{id = 4, dispName = _("4.0 s")},
					{id = 5, dispName = _("5.0 s")},
					{id = 6, dispName = _("8.0 s")},
					{id = 7, dispName = _("Random")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "FlareMultiNumber", control = 'comboList', label = _('Flare Burst Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("2")},
					{id = 3, dispName = _("4")},
					{id = 4, dispName = _("8")},
					{id = 5, dispName = _("Continuous")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "FlareMultiTime", control = 'comboList', label = _('Flare Burst Interval'), playerOnly = true, 
		  values = {{id = 1, dispName = _("3.0 s")},
					{id = 2, dispName = _("4.0 s")},
					{id = 3, dispName = _("6.0 s")},
					{id = 4, dispName = _("8.0 s")},
					{id = 5, dispName = _("10.0 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "GunBurstSettings", control = 'comboList', label = _('Gun Burst Settings'), playerOnly = true, 
		  values = {{id = 0, dispName = _("OFF")},
					{id = 1, dispName = _("BURST")},
					{id = 2, dispName = _("0.5 s")},
					{id = 3, dispName = _("1 s")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},	
		
		{ id = "RocketSalvoF1", control = 'comboList', label = _('F1 Rocket Launcher Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("6")},
					{id = 2, dispName = _("12")},
					{id = 3, dispName = _("18")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "RocketSalvoF4", control = 'comboList', label = _('F4 Rocket Launcher Salvo Count'), playerOnly = true, 
		  values = {{id = 1, dispName = _("1")},
					{id = 2, dispName = _("3")},
					{id = 3, dispName = _("6")},
					{id = 4, dispName = _("18")}},
		  defValue  = 1,
		  wCtrl     = defaultOptionWidgedWidth
		},
		
		{ id = "LaserCode100",		control = 'spinbox',  label = _('Laser code for GBUs, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
		{ id = "LaserCode10",		control = 'spinbox',  label = _('Laser code for GBUs, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
		{ id = "LaserCode1",		control = 'spinbox',  label = _('Laser code for GBUs, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},		
	}
	
	-- Add specific properties, added via the variable arguments list
	local arg = {...}
	for i, v in ipairs(arg) do
		props[#props + 1] = {}
		copyTable(v, props[#props])
	end
	
	return props
end

-- F1EE
extraAircraftProp_INSStartMode =
	{ id = "INSStartMode", control = 'comboList', label = _('INS start position always correct'), playerOnly = true, 
	  values = {{id = 1, dispName = _("YES")},
				{id = 2, dispName = _("NO")}},
	  defValue  = 1,
	  wCtrl     = defaultOptionWidgedWidth
	}

-- F1EE
extraAircraftProp_RWR_type =
	{ id = "RWR_type", control = 'comboList', label = _('RWR type'), playerOnly = true, -- TODO: to enable for AI
	  values = {{id = "ALR_300", dispName = _("ALR-300"), value = 0.0},
				{id = "BF", dispName = _("BF"), value = 0.5}},
	  defValue  = "ALR_300",
	  wCtrl     = defaultOptionWidgedWidth,
	  arg 		= 994
	}

-- Two-seaters
extraAircraftProp_SoloFlight =
	{id = "SoloFlight", control = 'checkbox', label = _('Solo Flight'), defValue = false, weight = -80}


F1_all_versions = {
	Rate 						= 40, -- RewardPoint in Multiplayer
	
	shape_table_data = 
	{
		{
			life  	 			= 18, -- lifebar
			vis   	 			= 3, -- visibility gain
			fire  	 			= {300, 6}, -- Fire on the ground after destoyed: 300sec 2m
			classname 			= "lLandPlane",
			positioning 		= "BYNORMAL",		
		},
		{
			fire  				= {300, 6},
			classname 			= "lLandPlane",
			positioning 		= "BYNORMAL",		
		},
	},
	
	mapclasskey 				= "P0091000024",
	Categories 					= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
	H_max 					 	= 15240, -- m --50000 ft practical ceiling. 55000 ft absolute.
	average_fuel_consumption 	= 0.5, -- this is highly relative, but good estimates are 36-40l/min = 28-31kg/min = 0.47-0.52kg/s -- 45l/min = 35kg/min = 0.583kg/s
	CAS_min 					= 50, -- if this is not OVERAL FLIGHT TIME, but jus LOITER TIME, than it sholud be 10-15 minutes.....CAS capability in minute (for AI)
	V_opt 						= 300,-- Cruise speed (for AI)
	Mach_max 					= 2.1, -- Max speed in Mach (for AI)
	Ny_min 						= -3, -- Min G (for AI)
	Ny_max 						= 7.2,  -- Max G (for AI)
	Ny_max_e 					= 6.0,  -- Max G (for AI)
	bank_angle_max 				= 85, -- Max bank angle (for AI)
	
	has_afteburner 				= true, -- AFB yes/no
	has_speedbrake 				= true, -- Speedbrake yes/no
	has_differential_stabilizer = false,
	bigParkingRamp				= false,
	
	stores_number				= 9,
	brakeshute_name				= "Mirage-F1_parachute_1", -- Landing - brake chute visual shape after separation
	
	tanker_type 				= 0, -- Tanker type if the plane is airrefuel capable
	is_tanker 					= false, -- Tanker yes/no
	
	wing_area 					= 25, -- wing area in m2
	wing_span 					= 8.4, -- wing span in m
	wing_type 					= 0,
	length 						= 15.3, -- full lenght in m
	height 						= 4.5, -- height in m
	flaps_maneuver 				= 0.5, -- Max flaps in take-off and maneuver (0.5 = 1st stage; 1.0 = 2nd stage) (for AI)
	range 						= 3300, -- Max range in km (for AI)
	RCS 						= 5, -- Radar Cross Section m2
	IR_emission_coeff 			= 0.8, -- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
	IR_emission_coeff_ab 		= 3, -- With afterburner
	wing_tip_pos 				= {-3.5, -0.04, 4.22}, -- wingtip coords for turbulence and AI taxi/collision logic

	engines_count				= 1, -- Engines count
	thrust_sum_max 				= 4867, -- thrust in kg (47.7kN)
	thrust_sum_ab 				= 6969, -- thrust in kg (68.3kN)
	
	----------------- LANDING GEAR
	nose_gear_amortizer_normal_weight_stroke = -0.00311633945,
	main_gear_amortizer_normal_weight_stroke = 0.00,

	nose_gear_wheel_diameter 	= 0.346, -- in m
	main_gear_wheel_diameter 	= 0.608, -- in m

	tand_gear_max 				= 2.1445,
	
	net_animation 				=
	{
		11, -- Right aileron
		12,	-- Left aileron
		13, -- Right slat
		14,	-- Left slat
		15, -- Right stabilizer
		16,	-- Left stabilizer
		18, -- Rudder
		28, -- Afterburner
		35, -- Brake chute deployment position
		36,	-- Brake chute deflection up/down
		37,	-- Brake chute deflection left/right
		38, -- Canopy position
		69, -- Cockpit main lights 
		75, -- GPU presence
		83, -- Navigation light fuselage
		86, -- Nosecones position
		90,	-- Nozzle position
		115, -- Right gear door
		116, -- Left gear door
		117, -- Nose gear door
		120, -- Right spoiler
		123, -- Left spoiler
		126, -- Right inner flap
		127, -- Right outer flap
		128, -- Left inner flap
		129, -- Left outer flap
		149, -- Canopy embrittlement
		182, -- Right airbrake
		184, -- Left airbrake
		190, -- Left navlight
		191, -- Right navlight
		201, -- Formation light
		209, -- Landing light
		282, -- Additional air intake right up
		283, -- Additional air intake right low
		284, -- Additional air intake left up
		285, -- Additional air intake left low
		
		308, -- Wingtip pylon left
		309, -- Outboard pylon left
		310, -- Inboard pylon left
		311, -- Centerline pylon
		312, -- Inboard pylon right
		313, -- Outboard pylon right
		314, -- Wingtip pylon right
		
		338, -- Right wing flex
		339, -- Left wing flex
		340, -- Right wing tors
		341, -- Left wing tors
		427, -- Landing light pos
		705, -- Radar cover
		750, -- Countermeasure number flare left
		751, -- Countermeasure number chaff right
		752, -- Countermeasure type left
		753, -- Countermeasure type right
		754, -- Countermeasure number flare right
		755, -- Countermeasure number chaff left
		780, -- ADI roll
		781, -- ADI pitch
		782, -- ADI bearing
		802, -- Nav light vert stab red
		803, -- Nav light vert stab white
		844, -- Wheel chocks
		845, -- Access ladder
		905, -- Police light
		911, -- Canopy hanger
		924, -- GPU state
		925, -- Compressor stall state
		926, -- Engine starter
		970, -- Lateral cockpit lights
		971, -- Miscellaneous cockpit lights
		972, -- AOA indicator lights
		973, -- Lateral cockpit flood lights
		974, -- Front cockpit flood lights
		975, -- UV cockpit lights
		
		994, -- Mirage F1EE RWR type
	},
	
	engines_nozzles = {
		[1] = 
		{
			pos 				=  {-8.0,-0.111,0.0}, -- nozzle coords
			elevation   		=  0, -- AFB cone elevation
			diameter	 		= 0.9, -- AFB cone diameter
			exhaust_length_ab   = 9, -- lenght in m
			exhaust_length_ab_K = 0.5, -- AB animation
			smokiness_level 	= 0.2,				
		}, -- end of [1]
	}, -- end of engines_nozzles
	
	fires_pos = {
		[1] = 	{-0.855,	0.593,	   0.0},	-- Fuselage					
		[2] = 	{-2.314,	0.178,	 2.065},	-- Wing inner Right
		[3] = 	{-2.332,	0.187,  -2.02},	    -- Wing inner Left
		[4] = 	{-2.836,	0.122,   2.775},	-- Wing middle Right
		[5] = 	{-2.973,	0.095,  -3.034},	-- Wing middle Left
		[6] = 	{-3.615,   -0.012,	 4.086},	-- Wing outer Right
		[7] = 	{-3.553,   -0.017,	-4.077},	-- Wing outer Left			
		[8] = 	{-5.249,     -0.1,	   0.0},	-- Engine
	}, -- end of fires_pos
	
	effects_presets = {
		{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/MirageF1_overwingVapor.lua"},
	},
	
	-- No passive countermeasures by default
	passivCounterm 				= noPassivCounterm,
	-- Coordinates for passive countermeasures dispencers (when those are present)
	chaff_flare_dispenser = {
		[1] = 
		{
			dir 				= {0, -1, -1},
			pos 				= {-4.312, -0.648, -0.488},
		}, -- end of [1]
		[2] = 
		{
			dir 				= {0, -1, 1},
			pos 				= {-4.312, -0.648, 0.488},
		}, -- end of [2]
	}, -- end of chaff_flare_dispenser
	
	-- Sensors
	detection_range_max		 	= 70,
	radar_can_see_ground 	 	= true,
	
	Sensors = {
		RADAR 					= "RDY",
		IRST 					= nil,
		RWR 					= "Abstract RWR"
	},
	
	CanopyGeometry = {
		azimuth   				= {-160.0, 160.0}, -- pilot view horizontal (AI)
		elevation 				= {-50.0, 90.0} -- pilot view vertical (AI)
	},		
	
	HumanRadio = {		
		frequency 				= 127.5,  -- Radio Freq
		editable 				= true,
		minFrequency 			= 100.000,
		maxFrequency 			= 400.000,
		modulation 				= MODULATION_AM
	},
		
	SFM_Data = {
		engine = 
		{
			type	=	"TurboJet",
			Nmg		=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			typeng	=	1,
			hMaxEng	=	19.5,
			dcx_eng	=	0.0085,  -- Affects drag of engine when shutdown
			                     -- cemax/cefor affect sponginess of elevator/inertia at slow speed
			                     -- affects available g load apparently
			cemax	=	1.24,
			cefor	=	2.56,
			-- following affect thrust/max alt
			dpdh_m	=	3270,  -- Loss of thrust in N per 1000 m
			dpdh_f	=	6600, -- Loss of thrust in N per 1000 m
			table_data = 
			{
			         --   M		 Pmax        Pfor
				[1] = 	{0,	    49000,	    70600},
				[2] = 	{0.2,	45700,	    67700}, -- 132 kts at SL
				[3] = 	{0.3,	44900,	    68700}, -- 198 kts at SL
				[4] = 	{0.4,	44800,	    69700}, -- 265 kts at SL
				[5] = 	{0.6,	46000,	    74600}, -- 397 kts at SL
				[6] = 	{0.7,	47000,	    78500},
				[7] = 	{0.8,	48600,	    82400},
				[8] = 	{0.9,	50000,	    87500},
				[9] = 	{1,	    51500,	    93200},
				[10] = 	{1.1,	53000,	    98100},
				[11] = 	{1.2,	54500,	    104000},
				[12] = 	{1.3,	56500,	    109900},
				[13] = 	{1.5,	59000,	    121600},
				[14] = 	{1.8,	70000,	    144000},
				[15] = 	{2,	    70000,	    155800},
				[16] = 	{2.2,	90000,	    167530},
				[17] = 	{2.5,	47700,	    162000},
				[18] = 	{3,	    20000,	    40000},
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
		}, -- end of engine
	},
---------------------------------------------------------------------------------------------------------------------------------------------	
	Failures = 
	{
		{ id = "battery_fail", label = _("Battery failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "alt1_fail", label = _("Alternator 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "alt2_fail", label = _("Alternator 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "tr1_fail", label = _("Transformer 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "tr2_fail", label = _("Transformer 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "triphase_inv_fail", label = _("Three-phase inverter failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "miss_bus_fail", label = _("Missile bus failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "left_fuel_pump_fail", label = _("Left fuel pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_fuel_pump_fail", label = _("Right fuel pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "detotalizer_fail", label = _("Fuel detotalizer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_gauges_fail", label = _("Fuel gauges failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_intercom_fail", label = _("Fuel crossfeed valve failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "fuel_pressurization_fail", label = _("Fuel pressurization failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_wing_transfer_fail", label = _("Left wing fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_wing_transfer_fail", label = _("Right wing fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "front_central_transfer_fail", label = _("Front central fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_front_transfer_fail", label = _("Left front fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_front_transfer_fail", label = _("Right front fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_rear_transfer_fail", label = _("Left rear fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_rear_transfer_fail", label = _("Right rear fuel tank transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "external_tanks_transfer_fail", label = _("External fuel tanks transfer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_wing_leaks", label = _("Left wing fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_wing_leaks", label = _("Right wing fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "front_central_leaks", label = _("Front central fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_front_leaks", label = _("Left front fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_front_leaks", label = _("Right front fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_rear_leaks", label = _("Left rear fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_rear_leaks", label = _("Right rear fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "left_feeder_leaks", label = _("Left feeder fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_feeder_leaks", label = _("Right feeder fuel tank leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "fuel_accu_leaks", label = _("Fuel accumulator leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "left_airbrake_fail", label = _("Left airbrake failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "right_airbrake_fail", label = _("Right airbrake failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_lever_fail", label = _("Gear actuation failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_down_lock_fail", label = _("Gear locking failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_nose_stuck", label = _("Nose gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_left_stuck", label = _("Left gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gear_right_stuck", label = _("Right gear stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "brakes_fail", label = _("Wheel brakes failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "chute_fail", label = _("Drag chute failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "electropump_fail", label = _("Electropump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_leaks", label = _("Hydraulic circuit 1 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_reserv_leaks", label = _("Hydraulic reservoir 1 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr1_pump_fail", label = _("Hydraulic pump 1 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_leaks", label = _("Hydraulic circuit 2 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_reserv_leaks", label = _("Hydraulic reservoir 2 leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr2_pump_fail", label = _("Hydraulic pump 2 failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "hydr_serv_leaks", label = _("Hydraulic servitudes circuit leaks"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flap_left_stuck", label = _("Left flap stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flap_right_stuck", label = _("Right flap stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "flaps_stuck", label = _("Both flaps stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_inner_left_stuck", label = _("Left inner slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_inner_right_stuck", label = _("Right inner slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_outer_left_stuck", label = _("Left outer slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slat_outer_right_stuck", label = _("Right outer slat stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "slats_stuck", label = _("All slats stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "pitot_heat_fail", label = _("Pitot tube heating failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "altitude_chain_fail", label = _("Altitude chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "mach_chain_fail", label = _("Mach chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "incidometer_fail", label = _("Incidometer failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "incidometer_blockage_fail", label = _("Incidometer stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "anemo_central_fail", label = _("Anemometry central failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "trim_pitch_fail", label = _("Pitch trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_roll_fail", label = _("Roll trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_yaw_fail", label = _("Yaw trim fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "trim_elect_supply", label = _("Trim electric failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "yaw_damper_fail", label = _("Yaw damper failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pilot_aids_1_fail", label = _("Pilot aids 1 electric supply failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pilot_aids_2_fail", label = _("Pilot aids 2 electric supply failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_chain_fail", label = _("Pitch control chain failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "ap_global_fail", label = _("Autopilot failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "broken_guards", label = _("Engine nozzle vanes stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "oil_fail", label = _("Engine oil pump failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck", label = _("Engine nosecones stuck"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck_forward", label = _("Engine nosecones stuck forwards"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "nosecone_stuck_backward", label = _("Engine nosecones stuck backwards"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "start_fail", label = _("Engine starter failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "ignition_fail", label = _("Engine ignition failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "total_comp_stall", label = _("Total compressor stall"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "partial_comp_stall", label = _("Partial compressor stall"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "overspeed_fail", label = _("Engine overspeed failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "discharge_valves_fail", label = _("Engine discharge valves failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		--{ id = "accessory_support_fail", label = _("Engine accessory supports failure"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_fire", label = _("Engine fire"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "AB_fire", label = _("Afterburner fire"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "compressor_damage", label = _("Engine compressor damaged"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "engine_flameout", label = _("Engine flameout"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "cabin_temp_fail", label = _("Cabin temperature regulation fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "equip_temp_fail", label = _("Equipment bay temperature regulation fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "oxygen_regulator_fail", label = _("Oxygen regulator fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "gyros_general_BSM_fail", label = _("General gyroscopic central fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gyros_main_fail", label = _("Main gyroscope fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "gyros_emergency_fail", label = _("Emergency gyroscope fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
		{ id = "BARAX_fail", label = _("BARAX emission fail"),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		
	},
	
---------------------------------------------------------------------------------------------------------------------------------------------
	lights_data = 	{
		typename = "collection",
		lights = 	{
			--[[NATO STROBE LIGHTS]]--
			[1] = {
				typename = "collection",
				lights ={
					{typename = "argnatostrobelight",  argument = 83,  period = 1.333,  phase_shift = 0.0}, -- Top Strobe
					{typename = "argnatostrobelight",  argument = 802,  period = 1.4,  phase_shift = 0.0}, -- Strobe Orange Tail
					{typename = "argnatostrobelight",  argument = 803,  period = 1.4,  phase_shift = 0.0}, --Strobe White Tail					
				}
			},
			
			--[[TAXI Lights]]--
			[2] = {	typename	=	"collection",
				lights = {
						[1] = {	typename = "spotlight",		argument = 209},	
						[3] = {	typename = "argumentlight",	argument = 427,	speed  = 3.0},
					}
			},
	

			--[[NAVIGATION LIGHTS]]--
			[4] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 190}, --Red Position
					{typename = "argumentlight",  argument  = 191}, --Green Position
					
					
				}
			},
			
			--[[FORMATION LIGHTS]]--
			[5] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",argument = 200}, --CT/CR
					{typename = "argumentlight",  argument  = 201}, --Green Position					

				}
			},	
			
			--[[REFUEL LIGHTS]]--
			[6] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 903},
				}
			},	
			--[[POLICE LIGHTS]]--
			[7] = {
				typename = "collection",
				lights ={
					{typename = "argumentlight",  argument  = 905},
				}
			},			
			
		},
	},
	-- end lights_data
	
	AddPropAircraft = makeAircraftProperties(),
}
