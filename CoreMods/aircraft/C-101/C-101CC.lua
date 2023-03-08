
make_aviojet({
 	Shape 										= 	'C-101CC',
	Name										=	'C-101CC',
	Picture										=	'C-101CC.png',	
	DisplayName									=	_('C-101CC'),

	Sensors = {
		-- RWR = "Abstract RWR", -- RWR type
		RADAR = "Tornado SS radar", -- Radar type
	},	
---------------------------------------------------------------------------------------------------------------------------------------------			

	mapclasskey 		= "P0091000024",
	Categories 			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},	
---------------------------------------------------------------------------------------------------------------------------------------------

	-- BOW. 3475 kg of empty aircraft with unusable fluids (not including fuel) + two pilots (160 kg)
	-- WARNING! cpp OEW value should always be set to [M_empty - 160 kg] in the case when M_empty is updated
	M_empty 			= 3635.0,
	M_nominal 			= 5217.0, -- kg average aircraft weight
	M_max 				= 6300.0, -- kg -- MTOW = MLW
	-- M_fuel_max:
	-- previous - 4148 lb (1881.501 kg) max, including unusable fuel
	-- updated - 3960 lb (1796 kg) max, including unusable fuel
	M_fuel_max 			= 1796.0, -- kg -- All tanks full: 2337 lts, wing tanks full: 1667, lts fuselage tank full: 1115 lts
	MaxFuelWeight		= 1796.0,
	MaxTakeOffWeight	= 5366.0, -- a copy from EB
	
	H_max 			 	= 11000, -- m Average

	thrust_sum_max    	= 2100, -- thrust in kg 
	thrust_sum_ab     	= 2100, -- thrust in kg
	
	pylons_enumeration = {1, 2, 3, 4, 5, 6, 7},
	HumanRadio = {
		frequency = 225.000,  -- Radio Freq
		editable = true,
		minFrequency = 118.000,
		maxFrequency = 399.975,
		modulation = MODULATION_AM
	},
	panelRadio = {
        [1] = {  
            name = _("V/TVU-740"),
            range = {min = 118.0, max = 399.975},
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
				[20] = { name = _("Channel 20"), default = 281.0, modulation = _("AM")},
				[21] = { name = _("Channel 21"), default = 285.0, modulation = _("AM")},
            }
    },
},	

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
		{ id = "CameraRecorder", control = 'checkbox' , label = _('Camera Recorder'), playerOnly = true, defValue = false},
		{ id = "SightSunFilter", control = 'checkbox' , label = _('Sight Sun Filter'), playerOnly = true, defValue = false},
		{ id = "NS430allow", control = 'comboList', label = _('NS430 Setup'), playerOnly = true, 
		  values = {{id = 0, dispName = _("Not installed")},
					{id = 1, dispName = _("Forward seat")},
					{id = 2, dispName = _("Rear seat")}},
		  defValue  = 1,
		  wCtrl     = 150
		},
	},		
		
	Pylons =     {

-- C:\DCS Dev\trunk_nightly\MissionEditor\data\images\Loadout\Weapon

        pylon(1, 0, -0.234, -0.538, -3.605,
            { use_full_connector_position=false, connector = "PYLON_1", arg = 308, arg_value = -1.0 },
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",connector = "Pylon_1_B", arg_value = 0.5, required = {{station = 7,loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}}} },	-- AIM-9M 	
				{ CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}",connector = "Pylon_1_B", arg_value = 0.5, required = {{station = 7,loadout = {"{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"}}} },	-- AIM-9P			
				{ CLSID = "{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}",connector = "Pylon_1_B", arg_value = 0.5, required = {{station = 7,loadout = {"{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}"}}} },	-- R.550 Magic 2			

			
			
            }
		),			
        pylon(2, 0, -0.234, -0.606, -2.936,
            { use_full_connector_position=false, connector = "PYLON_2", arg = 309, arg_value = -1.0 },
            {
				{ CLSID = "{1461CD18-429A-42A9-A21F-4C621ECD4573}",Type = 1, arg_value = 0.1, required = {{station = 6,loadout = {"{1461CD18-429A-42A9-A21F-4C621ECD4573}"}}} },	-- SEA EAGLE			
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.1, required = {{station = 6,loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}} },	-- MK-82			
				{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", arg_value = 0.1, required = {{station = 6,loadout = {"{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}"}}} },	-- LAU-61 - 19x M151 HE	
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", arg_value = 0.1, required = {{station = 6,loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}}} },	-- LAU-68 - 7x M151 HE			
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", arg_value = 0.1, required = {{station = 6,loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}}} },	-- LAU-68 - 7x M156 WP	
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}", arg_value = 0.1, required = {{station = 6,loadout = {"{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}"}}} }, -- LAU-131 with M257			
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}", arg_value = 0.1, required = {{station = 6,loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}}} },	-- LAU-68 - 7x M274 (Practice smoke)
				{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", arg_value = 0.1, required = {{station = 6,loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}} },	-- BL755 Anti-Armor CBU	
				{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", arg_value = 0.1, required = {{station = 6,loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },	-- FAB-250	
				{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", arg_value = 0.1, required = {{station = 6,loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}} },	-- FAB-100			
				{ CLSID = "{BLG66_BELOUGA}", arg_value = 0.1, required = {{station = 6,loadout = {"{BLG66_BELOUGA}"}}} },	-- BELOUGA_BLG66	
				{ CLSID = "BR_250", arg_value = 0.1, required = {{station = 6,loadout = {"BR_250"}}} },	-- BR-250			
				{ CLSID = "BIN_200", arg_value = 0.1, required = {{station = 6,loadout = {"BIN_200"}}} },	-- BIN-200				

            }
        ),
        pylon(3, 0, -0.234, -0.675, -2.247,
            { use_full_connector_position=false, connector = "PYLON_3", arg = 310, arg_value = -1.0 },
            {
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", arg_value = 0.1, required = {{station = 5,loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}}} },	-- LAU-68 - 7x M151 HE			
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", arg_value = 0.1, required = {{station = 5,loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}}} },	-- LAU-68 - 7x M156 WP	
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}", arg_value = 0.1, required = {{station = 5,loadout = {"{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}"}}} }, -- LAU-131 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}", arg_value = 0.1, required = {{station = 5,loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}}} },	-- LAU-68 - 7x M274 (Practice smoke)
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.1, required = {{station = 5,loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}} },	-- MK-82				
				{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", arg_value = 0.1, required = {{station = 5,loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}} },	-- BL755 Anti-Armor CBU			
				{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", arg_value = 0.1, required = {{station = 5,loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },	-- FAB-250
				{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", arg_value = 0.1, required = {{station = 5,loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}} },	-- FAB-100				
				{ CLSID = "{BLG66_BELOUGA}", arg_value = 0.1, required = {{station = 5,loadout = {"{BLG66_BELOUGA}"}}} },	-- BELOUGA_BLG66	
				{ CLSID = "BR_250", arg_value = 0.1, required = {{station = 5,loadout = {"BR_250"}}} },	-- BR-250			
				{ CLSID = "BR_500", arg_value = 0.1, required = {{station = 5,loadout = {"BR_500"}}} },	-- BR_500
				{ CLSID = "BIN_200", arg_value = 0.1, required = {{station = 5,loadout = {"BIN_200"}}} },	-- BIN-200
				{ CLSID = "CBLS-200", arg_value = 0.1, required = {{station = 5,loadout = {"CBLS-200"}}} },	-- BRU-42_3*BDU-33					

            }
        ),

------------GUNS------------			
        pylon(4, 0, 2.233, -0.966, -0.000000,
            { use_full_connector_position=false, connector = "PYLON_4_GUN_2", arg = 314, arg_value = -1.0 },
            {
				{ CLSID = "{C-101-DEFA553}",arg_value = 0.1},	-- Canon Pack DEFA 553, cal 30 mm
				{ CLSID = "{AN-M3}"	 ,connector = "Pylon_4_GUN_1",arg_value = 1.0},	-- Machine Gun Pack AN M3 cal 0.50 ins
            }
	),
------------GUNS------------	

        pylon(5, 0, -0.234, -0.675, 2.247,
            { use_full_connector_position=false, connector = "PYLON_5", arg = 311, arg_value = -1.0 },
            {
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", arg_value = 0.1, required = {{station = 3,loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}}} },	-- LAU-68 - 7x M151 HE			
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", arg_value = 0.1, required = {{station = 3,loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}}} },	-- LAU-68 - 7x M156 WP	
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}", arg_value = 0.1, required = {{station = 3,loadout = {"{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}"}}} }, -- LAU-131 with M257
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}", arg_value = 0.1, required = {{station = 3,loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}}} },	-- LAU-68 - 7x M274 (Practice smoke)
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.1, required = {{station = 3,loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}} },	-- MK-82				
				{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", arg_value = 0.1, required = {{station = 3,loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}} },	-- BL755 Anti-Armor CBU			
				{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", arg_value = 0.1, required = {{station = 3,loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },	-- FAB-250
				{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", arg_value = 0.1, required = {{station = 3,loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}} },	-- FAB-100	
				{ CLSID = "{BLG66_BELOUGA}", arg_value = 0.1, required = {{station = 3,loadout = {"{BLG66_BELOUGA}"}}} },	-- BELOUGA_BLG66	
				{ CLSID = "BR_250", arg_value = 0.1, required = {{station = 3,loadout = {"BR_250"}}} },	-- BR-250			
				{ CLSID = "BR_500", arg_value = 0.1, required = {{station = 3,loadout = {"BR_500"}}} },	-- BR_500
				{ CLSID = "BIN_200", arg_value = 0.1, required = {{station = 3,loadout = {"BIN_200"}}} },	-- BIN-200
				{ CLSID = "CBLS-200", arg_value = 0.1, required = {{station = 3,loadout = {"CBLS-200"}}} },	-- BRU-42_3*BDU-33	
            }
		),
        pylon(6, 0, -0.234, -0.606, 2.936,
            { use_full_connector_position=false, connector = "PYLON_6", arg = 312, arg_value = -1.0 },
            {
				{ CLSID = "{1461CD18-429A-42A9-A21F-4C621ECD4573}",Type = 1, arg_value = 0.1, required = {{station = 2,loadout = {"{1461CD18-429A-42A9-A21F-4C621ECD4573}"}}} },	-- SEA EAGLE			
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}", arg_value = 0.1, required = {{station = 2,loadout = {"{BCE4E030-38E9-423E-98ED-24BE3DA87C32}"}}} },	-- MK-82			
				{ CLSID = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", arg_value = 0.1, required = {{station = 2,loadout = {"{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}"}}} },	-- LAU-61 - 19x M151 HE	
				{ CLSID = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", arg_value = 0.1, required = {{station = 2,loadout = {"{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}"}}} },	-- LAU-68 - 7x M151 HE			
				{ CLSID = "{4F977A2A-CD25-44df-90EF-164BFA2AE72F}", arg_value = 0.1, required = {{station = 2,loadout = {"{4F977A2A-CD25-44df-90EF-164BFA2AE72F}"}}} },	-- LAU-68 - 7x M156 WP	
				{ CLSID = "{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}", arg_value = 0.1, required = {{station = 2,loadout = {"{DAD45FE5-CFF0-4a2b-99D4-5D044D3BC22F}"}}} }, -- LAU-131 with M257			
				{ CLSID = "{0877B74B-5A00-4e61-BA8A-A56450BA9E27}", arg_value = 0.1, required = {{station = 2,loadout = {"{0877B74B-5A00-4e61-BA8A-A56450BA9E27}"}}} },	-- LAU-68 - 7x M274 (Practice smoke)
				{ CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", arg_value = 0.1, required = {{station = 2,loadout = {"{08164777-5E9C-4B08-B48E-5AA7AFB246E2}"}}} },	-- BL755 Anti-Armor CBU	
				{ CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", arg_value = 0.1, required = {{station = 2,loadout = {"{3C612111-C7AD-476E-8A8E-2485812F4E5C}"}}} },	-- FAB-250	
				{ CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", arg_value = 0.1, required = {{station = 2,loadout = {"{FB3CE165-BF07-4979-887C-92B87F13276B}"}}} },	-- FAB-100			
				{ CLSID = "{BLG66_BELOUGA}", arg_value = 0.1, required = {{station = 2,loadout = {"{BLG66_BELOUGA}"}}} },	-- BELOUGA_BLG66	
				{ CLSID = "BR_250", arg_value = 0.1, required = {{station = 2,loadout = {"BR_250"}}} },	-- BR-250			
				{ CLSID = "BIN_200", arg_value = 0.1, required = {{station = 2,loadout = {"BIN_200"}}} },	-- BIN-200					

            }
        ),

        pylon(7, 0, -0.234, -0.538, 3.605,
            { use_full_connector_position=false, connector = "PYLON_7", arg = 313, arg_value = -1.0 },
            {
				{ CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",connector = "Pylon_7_B", arg_value = 0.5, required = {{station = 1,loadout = {"{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}"}}} },	-- AIM-9M 	
				{ CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}",connector = "Pylon_7_B", arg_value = 0.5, required = {{station = 1,loadout = {"{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}"}}} },	-- AIM-9P			
				{ CLSID = "{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}",connector = "Pylon_7_B", arg_value = 0.5, required = {{station = 1,loadout = {"{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}"}}} },	-- R.550 Magic 2	
			
				
            }
		),
    },
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
					["WING_L_CENTER"]= {critical_damage = 5, args = {254}, deps_cells = {"WING_L_OUT","AILERON_L","PYLON1","PYLON2"}}, -- WING_L_CENTER					
					["WING_L_IN"] 	 = {critical_damage = 10, args = {255}, deps_cells = {"WING_L_CENTER","FLAP_L"}}, -- WING_L_IN
					
					["PYLON1"] 	= {critical_damage = 2},  -- LEFT WING OUTER PYLON
					["PYLON2"] 	= {critical_damage = 2},  -- LEFT WING INNER PYLON				

					["AILERON_L"]    = {critical_damage = 3, args = {256}},--AILERON_L 
		    		["FLAP_L"]	= {critical_damage = 4, args = {257}, droppable = true,  droppable_shape = "C-101-oblomok-flap-L-base"},--FLAP_L					
					
--------------------------------WING R--------------------------------
					["WING_R_OUT"]	= {critical_damage = 3, args = {263}}, -- WING_R_OUT
					["WING_R_CENTER"] 	= {critical_damage = 5, args = {262}, deps_cells = {"WING_R_OUT","AILERON_R","PYLON3","PYLON4"}}, -- WING_R_CENTER
					["WING_R_IN"] 	= {critical_damage = 10, args = {261}, deps_cells = {"WING_R_CENTER","FLAP_R"}}, -- WING_R_IN
					
					["PYLON3"] 	= {critical_damage = 2},  --   RIGHT WING INNER PYLON
					["PYLON4"]	= {critical_damage = 2},	-- RIGHT WING OUTER PYLON				

					["AILERON_R"]    = {critical_damage = 3, args = {264}},--AILERON_R 
		    		["FLAP_R"]	= {critical_damage = 4, args = {265}, droppable = true,  droppable_shape = "C-101-oblomok-flap-R-base"},--FLAP_R					

--------------------------------PWD--------------------------------
					["PWD"]	= {critical_damage = 1, args = {110}},--PWD
--------------------------------GUN--------------------------------
					["GUN"] 	= {critical_damage = 4, args = {402}},--GUN				
	}
	),-- end of Damage	
	
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
		{ id = "eng_computer_total_fail", label = _("Failure of auto and manual modes (back-up mode)"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "hydr_leak",      label = _("Hydraulic leak"),       enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "elevator_loss",   label = _("Elevator loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "aileron_loss",   label = _("Aileron loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "rudder_loss",   label = _("Rudder loss"),         enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_trim_runaway_up", label = _("Pitch trim runaway - Nose up"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "pitch_trim_runaway_down", label = _("Pitch trim runaway - Nose down"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "pitch_trim_fail", label = _("Control stick pitch trim switch failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "aileron_trim_fail", label = _("Control stick aileron trim switch failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "rudder_trim_fail", label = _("Rudder trim failure"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
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
		{ id = "dme_fail", label = _("DME signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "adf_fail", label = _("ADF receiver indication fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		{ id = "radioalt_fail", label = _("Radio altimeter signal fail"), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
		{ id = "sight_lamps_fail", label = _("Gunsight lamps failure"),   enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
	},
	
	Tasks = {
		aircraft_task(CAP),				-- 11, Combat Air Patrol
        aircraft_task(CAS),				-- 31, Close air support
        aircraft_task(Escort),			-- 18,
        aircraft_task(FighterSweep),	-- 19,
        aircraft_task(GroundAttack),	-- 32,
        aircraft_task(Intercept),		-- 10,
		-- aircraft_task(PinpointStrike),
		aircraft_task(AntishipStrike),
		aircraft_task(RunwayAttack),
		aircraft_task(AFAC),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(CAS),
	
})

