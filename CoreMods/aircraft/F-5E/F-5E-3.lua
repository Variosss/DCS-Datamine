function f5e3_settings(unit_name, display_name)
	local f5_local_setting =
	{
		Shape 										= 	'f-5e3',
		Name										=	 unit_name,
		livery_entry								=   "F-5E-3",
		Picture										=	'F-5E.png',	
		DisplayName									=	 display_name or _(unit_name),
		WorldID										=    WSTYPE_PLACEHOLDER,
		desrt										=	'f-5e3_oblomok',

		M_empty										=	4835,
		M_fuel_max									=	2046,

		country_of_origin = "USA",

		Sensors = {
			RADAR = "AN/APQ-159",
			RWR = "Abstract RWR", -- RWR type
		},

		-- Countermeasures, 
		passivCounterm = {
			CMDS_Edit = true,
			SingleChargeTotal = 60,
			-- MJU-13/A - 30 cartridges per magazine
			chaff = {default = 30, increment = 30, chargeSz = 1},
			-- MJU-14/A - 15 cartridges per magazine
			flare = {default = 15, increment = 15, chargeSz = 2}
		},

		chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{0, -1, 0},
				pos = 	{-1.3,	-0.506,	-0.496},
			}, -- end of [1]
		}, -- end of chaff_flare_dispenser

		DamageParts 	= 	{
			[1] = "f-5e3_oblomok_wing_l",
			[2] = "f-5e3_oblomok_wing_r",
		},

		panelRadio = {
			[1] = {  
				name = _("UHF Radio AN/ARC-164"),
				range = {min = 225.0, max = 399.999},
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
					[18] = { name = _("Channel 18"),	default = 251.0, modulation = _("AM")},	-- krasnodar-center : 122.0, 251.0
					[19] = { name = _("Channel 19"),	default = 253.0, modulation = _("AM")},	-- krymsk : 124.0, 253.0
					[20] = { name = _("Channel 20"),	default = 266.0, modulation = _("AM")}, -- mozdok : 137.0, 266.0
				}
			},
		},

		Failures = {
			-- electric system
			{ id = 'esf_LeftGenerator',			label = _('Electricity: Left Generator'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_RightGenerator',		label = _('Electricity: Right Generator'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_LeftRectifier',			label = _('Electricity: Left Rectifier'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_RightRectifier',		label = _('Electricity: Right Rectifier'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'esf_StaticInverter',		label = _('Electricity: Static Inverter'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- fuel system
			{ id = 'fsf_AutoBalance',			label = _('Fuel System: Fuel Autobalance'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_LeftBoostPump',			label = _('Fuel System: Left Fuel Boost Pump'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_RightBoostPump',		label = _('Fuel System: Right Fuel Boost Pump'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'fsf_CrossfeedValve',		label = _('Fuel System: Crossfeed Valve'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- hydraulic system
			{ id = 'hsf_UtilityHydraulic',		label = _('Hydraulic: Utility Hydraulic System'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hsf_ControlHydraulic',		label = _('Hydraulic: Flight Control Hydraulic System'),	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- control system
			{ id = 'csf_PitchDamper',			label = _('Control: Pitch Damper'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_YawDamper',				label = _('Control: Yaw Damper'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_PitchTrim',				label = _('Control: Pitch Trim'),							enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'csf_AutoFlap',				label = _('Control: Auto Flap System'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- sensors system
			{ id = 'sensf_CADC',				label = _('Sensors: Central Air Data Computer'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'sensf_PITOT_DAMAGE',		label = _('Sensors: Pitot-static System Leakage'),			enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- power plant
			{ id = 'ppf_LeftGearbox',			label = _('Power Plant: Left Gearbox'),						enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightGearbox',			label = _('Power Plant: Right Gearbox'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_FireLeft',				label = _('Power Plant: Fire Left Engine'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_FireRight',				label = _('Power Plant: Fire Right Engine'),				enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_LeftNozzleControl',		label = _('Power Plant: Left Nozzle Control System'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightNozzleControl',	label = _('Power Plant: Right Nozzle Control System'),		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_LeftOil',				label = _('Power Plant: Left Oil System'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ppf_RightOil',				label = _('Power Plant: Right Oil System'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- oxygen system
			{ id = 'oxy_FAILURE_TOTAL',			label = _('Oxygen System: Total Failure'),					enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			-- weapon system

			-- radio devices
		},

		-- Aircraft Additional Properties
		AddPropAircraft = {
			{ id = "LAU3ROF",			control = 'comboList', label = _('LAU-3 Rate of Fire'),
				values = {
					{id =  0, dispName = _("Single")},
					{id =  1, dispName = _("Ripple, 17ms")},
					{id =  2, dispName = _("Ripple, 20ms")},
					{id =  3, dispName = _("Ripple, 60ms")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "LAU68ROF",			control = 'comboList', label = _('LAU-68 Rate of Fire'),
				values = {
					{id =  0, dispName = _("Single")},
					{id =  1, dispName = _("Ripple, 60ms")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "LaserCode100",     	control = 'spinbox',  label = _('Laser code for GBUs, 1x11'), defValue = 6, min = 5, max = 7, dimension = ' ', playerOnly = true},
			{ id = "LaserCode10",     	control = 'spinbox',  label = _('Laser code for GBUs, 11x1'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
			{ id = "LaserCode1",     	control = 'spinbox',  label = _('Laser code for GBUs, 111x'), defValue = 8, min = 1, max = 8, dimension = ' ', playerOnly = true},
			{ id = "ChaffBurst", 		control = 'comboList', label = _('Chaff Burst Count'),
				values = {
					{id =  0, dispName = _("1")},
					{id =  1, dispName = _("2")},
					{id =  2, dispName = _("3")},
					{id =  3, dispName = _("4")},
					{id =  4, dispName = _("6")},
					{id =  5, dispName = _("8")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "ChaffSalvo", 		control = 'comboList', label = _('Chaff Salvo Count'),
				values = {
					{id =  0, dispName = _("1")},
					{id =  1, dispName = _("2")},
					{id =  2, dispName = _("4")},
					{id =  3, dispName = _("8")},
					{id =  4, dispName = _("C")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "ChaffBurstInt", 	control = 'comboList', label = _('Chaff Burst Interval'),
				values = {
					{id =  0, dispName = _("0.1s")},
					{id =  1, dispName = _("0.2s")},
					{id =  2, dispName = _("0.3s")},
					{id =  3, dispName = _("0.4s")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "ChaffSalvoInt", 	control = 'comboList', label = _('Chaff Salvo Interval'),
				values = {
					{id =  0, dispName = _("1s")},
					{id =  1, dispName = _("2s")},
					{id =  2, dispName = _("3s")},
					{id =  3, dispName = _("4s")},
					{id =  4, dispName = _("5s")},
					{id =  5, dispName = _("8s")},
					{id =  6, dispName = _("R")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "FlareBurst", 		control = 'comboList', label = _('Flare Burst Count'),
				values = {
					{id =  0, dispName = _("1")},
					{id =  1, dispName = _("2")},
					{id =  2, dispName = _("4")},
					{id =  3, dispName = _("8")},
					{id =  4, dispName = _("C")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
			{ id = "FlareBurstInt", 	control = 'comboList', label = _('Falre Burst Interval'),
				values = {
					{id =  0, dispName = _("3s")},
					{id =  1, dispName = _("4s")},
					{id =  2, dispName = _("6s")},
					{id =  3, dispName = _("8s")},
					{id =  4, dispName = _("10s")},
				},
				defValue  = 0,
				wCtrl     = 150,
				playerOnly = true
			},
		}
	}
	return f5_local_setting
end

make_tiger(f5e3_settings('F-5E-3'))