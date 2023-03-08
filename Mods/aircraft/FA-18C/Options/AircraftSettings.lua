AircraftSettings = 
{
	{ id = 'AircraftSystems', name = _('ot_Aircraft Systems', "Aircraft Systems"), type = 'tab', childs = 
		{
			{ id = 'FuelSystem', name = _('ot_Fuel System', "Fuel System"), type = 'section', childs = 
				{				
					{ id = 'BingoFuel', name = _('ot_Bingo Fuel', "Bingo Fuel"), control = 'spinbox', defValue = 5000, min = 0, max = 20000},
				}
			},
			{ id = 'HUD', name = _('ot_HUD', "HUD"), type = 'section', childs = 
				{				
					{ id = 'HUDBrightness', name = _('ot_HUD Brightness', "HUD Brightness"), control = 'spinbox', defValue = 35, min = 0, max = 100},
					{ id = 'HUDReject', name = _('ot_HUD Reject', "HUD Reject"), control = 'comboList', defValue  = 0,
						values = {
									{id =  0, dispName = _("ot_NORM", "NORM")},
									{id =  1, dispName = _("ot_REJ1", "REJ1")},
									{id =  2, dispName = _("ot_REJ2", "REJ2")},
								},
					},
					{ id = 'HUDALT', name = _('ot_HUD ALT', "HUD ALT"), control = 'comboList', defValue  = 1,
						values = {
									{id =  0, dispName = _("ot_BARO", "BARO")},
									{id =  1, dispName = _("ot_RDR", "RDR")},
								},
					},
				}
			},
			{ id = 'Altimeter', name = _('ot_Altimeter', "Altimeter"), type = 'section', childs = 
				{
					{ id = 'RadarAltimeterGauge', name = _('ot_Radar Altimeter Gauge', "Radar Altimeter Gauge"), control = 'spinbox', defValue = 2500, min = 0, max = 2500},

					{ id = 'BarometricPressure', name = _('ot_Barometric Pressure', "Barometric Pressure"), type = 'section', childs = 
						{
							{ id = 'MatchMission', name = _('ot_Match Mission', "Match Mission"), control = 'checkbox', defValue = true},
							{ id = 'Pressure', name = _('ot_Pressure', "Pressure"), control = 'spinbox', defValue = 29.92, step = 0.01, min = 0, max = 99},
						}		
					},
				},
			},	
			{ id = 'Volume Panel', name = _('ot_Volume Panel', "Volume Panel"), type = 'section', childs = 
				{
					{ id = 'TCN', name = _('ot_TCN', "TCN"), control = 'spinbox', defValue = 0, min = 0, max = 100},
					{ id = 'AUX', name = _('ot_AUX', "AUX"), control = 'spinbox', defValue = 100, min = 0, max = 100},
					{ id = 'MIDS', name = _('ot_MIDS', "MIDS"), control = 'spinbox', defValue = 100, min = 0, max = 100},
					{ id = 'RWR', name = _('ot_RWR', "RWR"), control = 'spinbox', defValue = 50, min = 0, max = 100},
					{ id = 'WPN', name = _('ot_WPN', "WPN"), control = 'spinbox', defValue = 50, min = 0, max = 100},
					{ id = 'ICS', name = _('ot_ICS', "ICS"), control = 'spinbox', defValue = 100, min = 0, max = 100},
				}
			},	
			{ id = 'Lights', name = _('ot_Lights', "Lights"), type = 'section', childs = 
				{	
					{ id = 'Position', name = _('ot_Position', "Position"), control = 'spinbox', defValue = 100, min = 0, max = 100},
					{ id = 'Formation', name = _("ot_Formation", "Formation"), control = 'spinbox', defValue = 100, min = 0, max = 100},
					{ id = 'Strobe', name = _('ot_Strobe', "Strobe"), control = 'comboList', defValue  = 2,
						values = {
									{id =  0, dispName = _("ot_OFF", "OFF")},
									{id =  1, dispName = _("ot_DIM", "DIM")},
									{id =  2, dispName = _("ot_BRT", "BRT")},
								},
					},
					{ id = 'Consoles', name = _('ot_Consoles', "Consoles"), control = 'spinbox', defValue = 75, min = 0, max = 100},
					{ id = 'InstrumentPanel', name = _('ot_Instrument Panel', "Instrument Panel"), control = 'spinbox', defValue = 75, min = 0, max = 100},
					{ id = 'Flood', name = _('ot_Flood', "Flood"), control = 'spinbox', defValue = 0, min = 0, max = 100},
					{ id = 'Warn/Caution', name = _('ot_Warn/Caution', "Warn/Caution"), control = 'spinbox', defValue = 0, min = 0, max = 100},
					{ id = 'Chart', name = _('ot_Chart', "Chart"), control = 'spinbox', defValue = 0, min = 0, max = 100},
					{ id = 'Mode', name = _('ot_Mode_Lights', "Mode"), control = 'comboList', defValue  = 0,
						values = {
									{id =  0, dispName = _("ot_DAY", "DAY")},
									{id =  1, dispName = _("ot_NITE", "NITE")},
									{id =  2, dispName = _("ot_NVG", "NVG")},
								},
					},
				}
			},
			{ id = 'Switches', name = _('ot_Switches', "Switches"), type = 'section', childs = 
				{				
					{ id = 'EngineAnti-Ice', name = _('ot_Engine Anti-Ice', 'Engine Anti-Ice'), control = 'checkbox', defValue = true},
					{ id = 'PitotAnti-Ice', name = _('ot_Pitot Anti-Ice', 'Pitot Anti-Ice'), control = 'comboList', defValue  = 1,
						values = {
									{id =  0, dispName = _("ot_ON", "ON")},
									{id =  1, dispName = _("ot_AUTO", "AUTO")},
								},
					},
					{ id = 'Defog', name = _('ot_Defog', "Defog"), control = 'spinbox', defValue = 50, min = 0, max = 100},	
					{ id = 'Anti-Skid', name = _('ot_Anti-Skid', "Anti-Skid"), control = 'checkbox', defValue = false},	
					{ id = 'HookBypass', name = _('ot_Hook Bypass', "Hook Bypass"), control = 'comboList', defValue  = 0,
						values = {
									{id =  0, dispName = _("ot_CARRIER", "CARRIER")},
									{id =  1, dispName = _("ot_FIELD", "FIELD")},
								},
					},	
				},
			},
			{ id = 'AirToGroundWeapons', name = _('ot_Air-to-Ground Weapons A/C menu', 'Air-to-Ground Weapons'), type = 'section', childs = 	
				{
					{ id = 'LAU-61', name = _('ot_LAU-61', "LAU-61"), type = 'section', childs = 
						{
							{ id = 'InnerPylons', name = _('ot_Inner Pylons', "Inner Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},
							{ id = 'OuterPylons', name = _('ot_Outer Pylons', "Outer Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},							
							{ id = 'Motor', name = _('ot_Motor', "Motor"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_M4", "M4")},
											{id =  1, dispName = _("ot_M66", "M66")},
										},
							},
						},
					},	
					{ id = 'LAU-68', name = _('ot_LAU-68', "LAU-68"), type = 'section', childs = 
						{
							{ id = 'InnerPylons', name = _('ot_Inner Pylons', "Inner Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},
							{ id = 'OuterPylons', name = _('ot_Outer Pylons', "Outer Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},							
							{ id = 'Motor', name = _('ot_Motor', "Motor"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_M4", "M4")},
											{id =  1, dispName = _("ot_M66", "M66")},
										},
							},
						},
					},
					{ id = 'LAU-10', name = _('ot_LAU-10', "LAU-10"), type = 'section', childs = 
						{
							{ id = 'InnerPylons', name = _('ot_Inner Pylons', "Inner Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},
							{ id = 'OuterPylons', name = _('ot_Outer Pylons', "Outer Pylons"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_Single", "Single")},
											{id =  1, dispName = _("ot_Ripple", "Ripple")},
										},
							},							
							{ id = 'Motor', name = _('ot_Motor', "Motor"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_M4", "M4")},
											{id =  1, dispName = _("ot_M66", "M66")},
										},
							},
						},
					},
				},
			},	
		},
	},	
	
	{ id = 'MissionCard', name = _('ot_Mission Card', "Mission Card"), type = 'tab', childs = 
		{
			{ id = 'Radar', name = _('ot_Radar', "Radar"), type = 'section', childs = 
				{
					{ id = 'Navigation', name = _('ot_Navigation Master Mode', "Navigation Master Mode"), type = 'section', childs = 
						{
							{ id = 'Bar', name = _('ot_Bar', "Bar"), control = 'comboList', defValue  = 4,
								values = {
											{id =  1, dispName = ("1")},
											{id =  2, dispName = ("2")},
											{id =  4, dispName = ("4")},
											{id =  6, dispName = ("6")},
										},
							},
							{ id = 'Range', name = _('ot_Range', "Range"), control = 'comboList', defValue  = 40,
								values = {
											{id =  5, dispName = ("5")},
											{id =  10, dispName = ("10")},
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  80, dispName = ("80")},
											{id =  160, dispName = ("160")},
										},
							},	
							{ id = 'Azimuth', name = _('ot_Azimuth', "Azimuth"), control = 'comboList', defValue  = 140,
								values = {
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  60, dispName = ("60")},
											{id =  80, dispName = ("80")},
											{id =  140, dispName = ("140")},
										},
							},	
						},
					},
					{ id = 'DATASubLevel', name = _('ot_DATA Sub-Level', "DATA Sub-Level"), type = 'section', childs = 
						{
							{ id = 'Age', name = _('ot_Age', "Age"), control = 'comboList', defValue  = 16,
								values = {
											{id =  2, dispName = ("2")},
											{id =  4, dispName = ("4")},
											{id =  8, dispName = ("8")},
											{id =  16, dispName = ("16")},
											{id =  32, dispName = ("32")},
										},
							},
							{ id = 'RAIDLOOK1', name = _('ot_RAID 1LOOK', "RAID 1LOOK"), control = 'checkbox', defValue = true},
							{ id = 'COLOR', name = _('ot_COLOR', "COLOR"), control = 'checkbox', defValue = true},
							{ id = 'MSI', name = _('ot_MSI', "MSI"), control = 'checkbox', defValue = true},
							{ id = 'LTWS', name = _('ot_LTWS', "LTWS"), control = 'checkbox', defValue = true},
							{ id = 'BRA', name = _('ot_BRA', "BRA"), control = 'checkbox', defValue = true},
							{ id = 'EW', name = _('ot_EW', "EW"), control = 'checkbox', defValue = true},
							{ id = 'Declutter', name = _('ot_Declutter', "Declutter"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_Off", "Off")},
											{id =  1, dispName = _("ot_Declutter 1", "Declutter 1")},
											{id =  2, dispName = _("ot_Declutter 2", "Declutter 2")},
										},
							},
							
						}
						
					},	
				},
			},
			{ id = 'AirToAirWeapons', name = _('ot_Air-to-Air Weapons', 'Air-to-Air Weapons'), type = 'section', childs = 	
				{
					{ id = 'AAGun', name = _('ot_AA Gun', "AA Gun"), type = 'section', childs = 
						{
							{ id = 'RoundType', name = _('ot_Round Type', "Round Type"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_M50", "M50")},
											{id =  1, dispName = _("ot_PGU", "PGU")},
										},
							},
							{ id = 'FireRate', name = _('ot_Fire Rate', "Fire Rate"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_HI rate", "HI")},
											{id =  1, dispName = _("ot_LO", "LO")},
										},
							},
							{ id = 'Wingspan', name = _('ot_Wingspan', "Wingspan"), control = 'spinbox', defValue = 37, min = 0, max = 999},
						}
					},
					{ id = 'AIM-9', name = _('ot_AIM-9', "AIM-9"), type = 'section', childs = 
						{
							{ id = 'PRF', name = _('ot_PRF', "PRF"), control = 'comboList', defValue  = 2,
								values = {
											{id =  0, dispName = _("ot_HI", "HI")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_INTLV", "INTLV")},
										},
							},
							{ id = 'Bar', name = _('ot_Bar', "Bar"), control = 'comboList', defValue  = 4,
								values = {
											{id =  1, dispName = ("1")},
											{id =  2, dispName = ("2")},
											{id =  4, dispName = ("4")},
											{id =  6, dispName = ("6")},
										},
							},
							{ id = 'Range', name = _('ot_Range', "Range"), control = 'comboList', defValue  = 20,
								values = {
											{id =  5, dispName = ("5")},
											{id =  10, dispName = ("10")},
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  80, dispName = ("80")},
											{id =  160, dispName = ("160")},
										},
							},	
							{ id = 'Azimuth', name = _('ot_Azimuth', "Azimuth"), control = 'comboList', defValue  = 80,
								values = {
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  60, dispName = ("60")},
											{id =  80, dispName = ("80")},
											{id =  140, dispName = ("140")},
										},
							},									
						}
					},		
					{ id = 'AIM7', name = _('ot_AIM-7', "AIM-7"), type = 'section', childs = 
						{
							{ id = 'PRF', name = _('ot_PRF', "PRF"), control = 'comboList', defValue  = 2,
								values = {
											{id =  0, dispName = _("ot_HI", "HI")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_INTLV", "INTLV")},
										},
							},
							{ id = 'Bar', name = _('ot_Bar', "Bar"), control = 'comboList', defValue  = 4,
								values = {
											{id =  1, dispName = ("1")},
											{id =  2, dispName = ("2")},
											{id =  4, dispName = ("4")},
											{id =  6, dispName = ("6")},
										},
							},
							{ id = 'Range', name = _('ot_Range', "Range"), control = 'comboList', defValue  = 40,
								values = {
											{id =  5, dispName = ("5")},
											{id =  10, dispName = ("10")},
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  80, dispName = ("80")},
											{id =  160, dispName = ("160")},
										},
							},	
							{ id = 'Azimuth', name = _('ot_Azimuth', "Azimuth"), control = 'comboList', defValue  = 140,
								values = {
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  60, dispName = ("60")},
											{id =  80, dispName = ("80")},
											{id =  140, dispName = ("140")},
										},
							},
							{ id = 'Size', name = _('ot_Size', "Size"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_SML", "SML")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_LRG", "LRG")},
										},
							},
							{ id = 'RCS', name = _('ot_RCS', "RCS"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_SML", "SML")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_LRG", "LRG")},
										},
							},		
						}
					},
					
					
					{ id = 'AIM120', name = _('ot_AIM-120', "AIM-120"), type = 'section', childs = 
						{
							{ id = 'PRF', name = _('ot_PRF', "PRF"), control = 'comboList', defValue  = 2,
								values = {
											{id =  0, dispName = _("ot_HI", "HI")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_INTLV", "INTLV")},
										},
							},
							{ id = 'Bar', name = _('ot_Bar', "Bar"), control = 'comboList', defValue  = 4,
								values = {
											{id =  1, dispName = ("1")},
											{id =  2, dispName = ("2")},
											{id =  4, dispName = ("4")},
											{id =  6, dispName = ("6")},
										},
							},
							{ id = 'Range', name = _('ot_Range', "Range"), control = 'comboList', defValue  = 80,
								values = {
											{id =  5, dispName = ("5")},
											{id =  10, dispName = ("10")},
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  80, dispName = ("80")},
											{id =  160, dispName = ("160")},
										},
							},	
							{ id = 'Azimuth', name = _('ot_Azimuth', "Azimuth"), control = 'comboList', defValue  = 140,
								values = {
											{id =  20, dispName = ("20")},
											{id =  40, dispName = ("40")},
											{id =  60, dispName = ("60")},
											{id =  80, dispName = ("80")},
											{id =  140, dispName = ("140")},
										},
							},
							{ id = 'Size', name = _('ot_Size', "Size"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_SML", "SML")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_LRG", "LRG")},
										},
							},
							{ id = 'RCS', name = _('ot_RCS', "RCS"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_SML", "SML")},
											{id =  1, dispName = _("ot_MED", "MED")},
											{id =  2, dispName = _("ot_LRG", "LRG")},
										},
							},
						}
					},
				}	
			},
			{ id = 'AirToGroundWeapons', name = _('ot_Air-to-Ground Weapons', 'Air-to-Ground Weapons'), type = 'section', childs = 	
				{
					{ id = 'Tone', name = _('ot_Tone', "Tone"), control = 'comboList', defValue  = 0,
						values = {
									{id =  0, dispName = _("ot_OFF", "OFF")},
									{id =  1, dispName = _("ot_TONE1", "TONE1")},
									{id =  2, dispName = _("ot_TONE2", "TONE2")},
								},
					},	
					{ id = 'AGGun', name = _('ot_AG Gun', "AG Gun"), type = 'section', childs = 
						{
							{ id = 'Mode', name = _('ot_Mode_Gun', "Mode"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_CCIP", "CCIP")},
											{id =  1, dispName = _("ot_MAN", "MAN")},
										},
							},
							{ id = 'RoundType', name = _('ot_Round Type', "Round Type"), control = 'comboList', defValue  = 1,
								values = {
											{id =  0, dispName = _("ot_M50", "M50")},
											{id =  1, dispName = _("ot_PGU", "PGU")},
										},
							},
							{ id = 'FireRate', name = _('ot_Fire Rate', "Fire Rate"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_HI rate", "HI")},
											{id =  1, dispName = _("ot_LO", "LO")},
										},
							},
							{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 40, min = 0, max = 9999},
							{ id = 'HotGun', name = _('ot_Hot Gun', "Hot Gun"), control = 'checkbox', defValue = true},
						}
					},
					{ id = 'Rockets', name = _('ot_Rockets', "Rockets"), type = 'section', childs = 
						{
							{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_CCIP", "CCIP")},
											{id =  1, dispName = _("ot_MAN", "MAN")},
										},
							},
							{ id = 'FiringMode', name = _('ot_Firing Mode', "Firing Mode"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_SGL", "SGL")},
											{id =  1, dispName = _("ot_SAL", "SAL")},
										},
							},
							{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 120, min = 0, max = 9999},
						}
					},
					{ id = 'GeneralPurposeBombs', name = _('ot_General Purpose Bombs', "General Purpose Bombs"), type = 'section', childs = 
						{
							{ id = 'Program1', name = _('ot_Program 1', "Program 1"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},										
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},	
								}
							},
							{ id = 'Program2', name = _('ot_Program 2', "Program 2"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},	
								}
							},
							{ id = 'Program3', name = _('ot_Program 3', "Program 3"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program4', name = _('ot_Program 4', "Program 4"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program5', name = _('ot_Program 5', "Program 5"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 0, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
						}
					},
					{ id = 'LaserGuidedBombs', name = _('ot_Laser-Guided Bombs', "Laser-Guided Bombs"), type = 'section', childs = 
						{
							{ id = 'Program1', name = _('ot_Program 1', "Program 1"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Code', name = _('ot_Code', "Code"), type = 'section', childs = 
										{
											{ id = 'Station2:1x11', name = _('ot_Station 2: 1x11', 'Station 2: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station2:11x1', name = _('ot_Station 2: 11x1', 'Station 2: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station2:111x', name = _('ot_Station 2: 111x', 'Station 2: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station3:1x11', name = _('ot_Station 3: 1x11', 'Station 3: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station3:11x1', name = _('ot_Station 3: 11x1', 'Station 3: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station3:111x', name = _('ot_Station 3: 111x', 'Station 3: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station7:1x11', name = _('ot_Station 7: 1x11', 'Station 7: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station7:11x1', name = _('ot_Station 7: 11x1', 'Station 7: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station7:111x', name = _('ot_Station 7: 111x', 'Station 7: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station8:1x11', name = _('ot_Station 8: 1x11', 'Station 8: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station8:11x1', name = _('ot_Station 8: 11x1', 'Station 8: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station8:111x', name = _('ot_Station 8: 111x', 'Station 8: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
										}
									},
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program2', name = _('ot_Program 2', "Program 2"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Code', name = _('ot_Code', "Code"), type = 'section', childs = 
										{
											{ id = 'Station2:1x11', name = _('ot_Station 2: 1x11', 'Station 2: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station2:11x1', name = _('ot_Station 2: 11x1', 'Station 2: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station2:111x', name = _('ot_Station 2: 111x', 'Station 2: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station3:1x11', name = _('ot_Station 3: 1x11', 'Station 3: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station3:11x1', name = _('ot_Station 3: 11x1', 'Station 3: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station3:111x', name = _('ot_Station 3: 111x', 'Station 3: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station7:1x11', name = _('ot_Station 7: 1x11', 'Station 7: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station7:11x1', name = _('ot_Station 7: 11x1', 'Station 7: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station7:111x', name = _('ot_Station 7: 111x', 'Station 7: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station8:1x11', name = _('ot_Station 8: 1x11', 'Station 8: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station8:11x1', name = _('ot_Station 8: 11x1', 'Station 8: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station8:111x', name = _('ot_Station 8: 111x', 'Station 8: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
										}
									},
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program3', name = _('ot_Program 3', "Program 3"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Code', name = _('ot_Code', "Code"), type = 'section', childs = 
										{
											{ id = 'Station2:1x11', name = _('ot_Station 2: 1x11', 'Station 2: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station2:11x1', name = _('ot_Station 2: 11x1', 'Station 2: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station2:111x', name = _('ot_Station 2: 111x', 'Station 2: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station3:1x11', name = _('ot_Station 3: 1x11', 'Station 3: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station3:11x1', name = _('ot_Station 3: 11x1', 'Station 3: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station3:111x', name = _('ot_Station 3: 111x', 'Station 3: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station7:1x11', name = _('ot_Station 7: 1x11', 'Station 7: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station7:11x1', name = _('ot_Station 7: 11x1', 'Station 7: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station7:111x', name = _('ot_Station 7: 111x', 'Station 7: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station8:1x11', name = _('ot_Station 8: 1x11', 'Station 8: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station8:11x1', name = _('ot_Station 8: 11x1', 'Station 8: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station8:111x', name = _('ot_Station 8: 111x', 'Station 8: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
										}
									},
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program4', name = _('ot_Program 4', "Program 4"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Code', name = _('ot_Code', "Code"), type = 'section', childs = 
										{
											{ id = 'Station2:1x11', name = _('ot_Station 2: 1x11', 'Station 2: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station2:11x1', name = _('ot_Station 2: 11x1', 'Station 2: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station2:111x', name = _('ot_Station 2: 111x', 'Station 2: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station3:1x11', name = _('ot_Station 3: 1x11', 'Station 3: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station3:11x1', name = _('ot_Station 3: 11x1', 'Station 3: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station3:111x', name = _('ot_Station 3: 111x', 'Station 3: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station7:1x11', name = _('ot_Station 7: 1x11', 'Station 7: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station7:11x1', name = _('ot_Station 7: 11x1', 'Station 7: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station7:111x', name = _('ot_Station 7: 111x', 'Station 7: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station8:1x11', name = _('ot_Station 8: 1x11', 'Station 8: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station8:11x1', name = _('ot_Station 8: 11x1', 'Station 8: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station8:111x', name = _('ot_Station 8: 111x', 'Station 8: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
										}
									},
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
							{ id = 'Program5', name = _('ot_Program 5', "Program 5"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs', "Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_AUTO", "AUTO")},
													{id =  1, dispName = _("ot_FD", "FD")},
													{id =  2, dispName = _("ot_CCIP", "CCIP")},
													{id =  3, dispName = _("ot_MAN", "MAN")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_NOSE", "NOSE")},
													{id =  2, dispName = _("ot_TAIL", "TAIL")},
													{id =  3, dispName = _("ot_N/T", "N/T")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 2,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_VT", "VT")},
													{id =  2, dispName = _("ot_INST", "INST")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
													{id =  4, dispName = _("ot_DLY2", "DLY2")},
												},
									},
									{ id = 'HT', name = _('ot_HT', "HT"), control = 'comboList', defValue  = 1500,
										values = {
													{id =  300, dispName = ("300")},
													{id =  500, dispName = ("500")},
													{id =  700, dispName = ("700")},
													{id =  900, dispName = ("900")},
													{id =  1200, dispName = ("1200")},
													{id =  1500, dispName = ("1500")},
													{id =  1800, dispName = ("1800")},
													{id =  2200, dispName = ("2200")},
													{id =  2600, dispName = ("2600")},
													{id =  3000, dispName = ("3000")},
												},
									},	
									{ id = 'Code', name = _('ot_Code', "Code"), type = 'section', childs = 
										{
											{ id = 'Station2:1x11', name = _('ot_Station 2: 1x11', 'Station 2: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station2:11x1', name = _('ot_Station 2: 11x1', 'Station 2: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station2:111x', name = _('ot_Station 2: 111x', 'Station 2: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station3:1x11', name = _('ot_Station 3: 1x11', 'Station 3: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station3:11x1', name = _('ot_Station 3: 11x1', 'Station 3: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station3:111x', name = _('ot_Station 3: 111x', 'Station 3: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station7:1x11', name = _('ot_Station 7: 1x11', 'Station 7: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station7:11x1', name = _('ot_Station 7: 11x1', 'Station 7: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station7:111x', name = _('ot_Station 7: 111x', 'Station 7: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
											{ id = 'Station8:1x11', name = _('ot_Station 8: 1x11', 'Station 8: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
											{ id = 'Station8:11x1', name = _('ot_Station 8: 11x1', 'Station 8: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											{ id = 'Station8:111x', name = _('ot_Station 8: 111x', 'Station 8: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
										}
									},
									{ id = 'Quantity', name = _('ot_Quantity', "Quantity"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Multiples', name = _('ot_Multiples', "Multiples"), control = 'spinbox', defValue = 1, min = 1, max = 24},
									{ id = 'Interval ', name = _('ot_Interval ', "Interval"), control = 'spinbox', defValue = 1, min = 1, max = 1000},
									{ id = 'ManualReticle', name = _('ot_Manual Reticle', "Manual Reticle"), control = 'spinbox', defValue = 160, min = 0, max = 9999},
								}
							},
						}
					},
					{ id = 'GPSGuidedWeapons', name = _('ot_GPS-Guided Weapons', "GPS-Guided Weapons"), type = 'section', childs = 
						{
							{ id = 'Program1', name = _('ot_Program 1', "Program 1"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 1,
										values = {			
													{id =  0, dispName = _("ot_PP", "PP")},
													{id =  1, dispName = _("ot_TOO", "TOO")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_TAIL", "TAIL")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_INST", "INST")},
													{id =  2, dispName = _("ot_VT1", "VT1")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
												},
									},
									{ id = 'HSIDeclutter', name = _('ot_HSI Declutter', "HSI Declutter"), control = 'checkbox', defValue = false},
									{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_MAN", "MAN")},
													{id =  1, dispName = _("ot_AUTO LOFT 45", "AUTO LOFT 45")},
													{id =  2, dispName = _("ot_AUTO LOFT 30", "AUTO LOFT 30")},
													{id =  3, dispName = _("ot_AUTO LOFT 15", "AUTO LOFT 15")},
													{id =  4, dispName = _("ot_FD", "FD")},
												},
									},
								}
							},
							{ id = 'Program2', name = _('ot_Program 2', "Program 2"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 1,
										values = {			
													{id =  0, dispName = _("ot_PP", "PP")},
													{id =  1, dispName = _("ot_TOO", "TOO")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_TAIL", "TAIL")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_INST", "INST")},
													{id =  2, dispName = _("ot_VT1", "VT1")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
												},
									},										
									{ id = 'HSIDeclutter', name = _('ot_HSI Declutter', "HSI Declutter"), control = 'checkbox', defValue = false},
									{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_MAN", "MAN")},
													{id =  1, dispName = _("ot_AUTO LOFT 45", "AUTO LOFT 45")},
													{id =  2, dispName = _("ot_AUTO LOFT 30", "AUTO LOFT 30")},
													{id =  3, dispName = _("ot_AUTO LOFT 15", "AUTO LOFT 15")},
													{id =  4, dispName = _("ot_FD", "FD")},
												},
									},
								}
							},
							{ id = 'Program3', name = _('ot_Program 3', "Program 3"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 1,
										values = {			
													{id =  0, dispName = _("ot_PP", "PP")},
													{id =  1, dispName = _("ot_TOO", "TOO")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_TAIL", "TAIL")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_INST", "INST")},
													{id =  2, dispName = _("ot_VT1", "VT1")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
												},
									},										
									{ id = 'HSIDeclutter', name = _('ot_HSI Declutter', "HSI Declutter"), control = 'checkbox', defValue = false},
									{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_MAN", "MAN")},
													{id =  1, dispName = _("ot_AUTO LOFT 45", "AUTO LOFT 45")},
													{id =  2, dispName = _("ot_AUTO LOFT 30", "AUTO LOFT 30")},
													{id =  3, dispName = _("ot_AUTO LOFT 15", "AUTO LOFT 15")},
													{id =  4, dispName = _("ot_FD", "FD")},
												},
									},
								}
							},
							{ id = 'Program4', name = _('ot_Program 4', "Program 4"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 1,
										values = {			
													{id =  0, dispName = _("ot_PP", "PP")},
													{id =  1, dispName = _("ot_TOO", "TOO")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_TAIL", "TAIL")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_INST", "INST")},
													{id =  2, dispName = _("ot_VT1", "VT1")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
												},
									},										
									{ id = 'HSIDeclutter', name = _('ot_HSI Declutter', "HSI Declutter"), control = 'checkbox', defValue = false},
									{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_MAN", "MAN")},
													{id =  1, dispName = _("ot_AUTO LOFT 45", "AUTO LOFT 45")},
													{id =  2, dispName = _("ot_AUTO LOFT 30", "AUTO LOFT 30")},
													{id =  3, dispName = _("ot_AUTO LOFT 15", "AUTO LOFT 15")},
													{id =  4, dispName = _("ot_FD", "FD")},
												},
									},
								}
							},
							{ id = 'Program5', name = _('ot_Program 5', "Program 5"), type = 'section', childs = 
								{
									{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 1,
										values = {			
													{id =  0, dispName = _("ot_PP", "PP")},
													{id =  1, dispName = _("ot_TOO", "TOO")},
												},
									},
									{ id = 'MFUZ', name = _('ot_MFUZ', "MFUZ"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_TAIL", "TAIL")},
												},
									},
									{ id = 'EFUZ', name = _('ot_EFUZ', "EFUZ"), control = 'comboList', defValue  = 1,
										values = {
													{id =  0, dispName = _("ot_OFF", "OFF")},
													{id =  1, dispName = _("ot_INST", "INST")},
													{id =  2, dispName = _("ot_VT1", "VT1")},
													{id =  3, dispName = _("ot_DLY1", "DLY1")},
												},
									},										
									{ id = 'HSIDeclutter', name = _('ot_HSI Declutter', "HSI Declutter"), control = 'checkbox', defValue = false},
									{ id = 'ReleaseMode', name = _('ot_Release Mode', "Release Mode"), control = 'comboList', defValue  = 0,
										values = {
													{id =  0, dispName = _("ot_MAN", "MAN")},
													{id =  1, dispName = _("ot_AUTO LOFT 45", "AUTO LOFT 45")},
													{id =  2, dispName = _("ot_AUTO LOFT 30", "AUTO LOFT 30")},
													{id =  3, dispName = _("ot_AUTO LOFT 15", "AUTO LOFT 15")},
													{id =  4, dispName = _("ot_FD", "FD")},
												},
									},
								}
							},
						}
					},
					{ id = 'AGM65Maverick', name = _('ot_AGM-65 Maverick', "AGM-65 Maverick"), type = 'section', childs = 
						{
							{ id = 'Fuze', name = _('ot_Fuze', "Fuze"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_INST", "INST")},
											{id =  1, dispName = _("ot_DLY1", "DLY1")},
											{id =  2, dispName = _("ot_DLY2", "DLY2")},
										},
							},
							{ id = 'Ship', name = _('ot_Ship', "Ship"), control = 'checkbox', defValue = false},
							{ id = 'Track', name = _('ot_Track', "Track"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_WHT", "WHT")},
											{id =  1, dispName = _("ot_BLK", "BLK")},
										},
							},

							{ id = 'Code:1x11', name = _('ot_Code: 1x11', 'Code: 1x11'), control = 'spinbox', defValue = 6, min = 5, max = 7},
							{ id = 'Code:11x1', name = _('ot_Code: 11x1', 'Code: 11x1'), control = 'spinbox', defValue = 8, min = 1, max = 8},
							{ id = 'Code:111x', name = _('ot_Code: 111x', 'Code: 111x'), control = 'spinbox', defValue = 8, min = 1, max = 8},
											
						}
					},
					{ id = 'AGM88HARM', name = _('ot_AGM-88 HARM', "AGM-88 HARM"), type = 'section', childs = 
						{
							{ id = 'Mode', name = _('ot_Mode_bombs_guided', "Mode"), control = 'comboList', defValue  = 0,
										values = {			
													{id =  0, dispName = _("ot_SP", "SP")},
													{id =  1, dispName = _("ot_PP", "PP")},
													{id =  2, dispName = _("ot_TOO", "TOO")},
												},
									},
							{ id = 'Class', name = _('ot_Class', "Class"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_ALL", "ALL")},
											{id =  1, dispName = _("ot_FRD", "FRD")},
											{id =  2, dispName = _("ot_FN", "FN")},
											{id =  3, dispName = _("ot_HN", "HN")},
											{id =  4, dispName = _("ot_F1", "F1")},
											{id =  5, dispName = _("ot_F2", "F2")},
											{id =  6, dispName = _("ot_H1", "H1")},
											{id =  7, dispName = _("ot_H2", "H2")},
											{id =  8, dispName = _("ot_FAA", "FAA")},
											{id =  9, dispName = _("ot_HAA", "HAA")},
											{id =  10, dispName = _("ot_FS", "FS")},
											{id =  11, dispName = _("ot_HS", "HS")},
											{id =  12, dispName = _("ot_UKN", "UKN")},
											{id =  13, dispName = _("ot_PRI", "PRI")},
										},
							},
						}
					},
				}
			},
			{ id = 'DefensiveSystems', name = _('ot_Defensive Systems', "Defensive Systems"), type = 'section', childs = 	
				{
					{ id = 'EWHUD', name = _('ot_EW HUD', "EW HUD"), control = 'checkbox', defValue = true},				
					{ id = 'MAN 1', name = _('ot_MAN 1', "MAN 1"), type = 'section', childs = 
						{
							{ id = 'CHAF', name = _('ot_CHAF', "CHAF"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'FLAR', name = _('ot_FLAR', "FLAR"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'OTH1', name = _('ot_OTH1', "OTH1"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'OTH2', name = _('ot_OTH2', "OTH2"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'RPT', name = _('ot_RPT', "RPT"), control = 'spinbox', defValue = 1, min = 1, max = 24},
							{ id = 'INT', name = _('ot_INT', "INT"), control = 'spinbox', defValue = 0.25, step = 0.25, min = 0.25, max = 5},
						}
					},
					{ id = 'MAN 2', name = _('ot_MAN 2', "MAN 2"), type = 'section', childs = 
						{
							{ id = 'CHAF', name = _('ot_CHAF', "CHAF"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'FLAR', name = _('ot_FLAR', "FLAR"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'OTH1', name = _('ot_OTH1', "OTH1"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'OTH2', name = _('ot_OTH2', "OTH2"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'RPT', name = _('ot_RPT', "RPT"), control = 'spinbox', defValue = 1, min = 1, max = 24},
							{ id = 'INT', name = _('ot_INT', "INT"), control = 'spinbox', defValue = 0.25, step = 0.25, min = 0.25, max = 5},
						}
					},
					{ id = 'MAN 3', name = _('ot_MAN 3', "MAN 3"), type = 'section', childs = 
						{
							{ id = 'CHAF', name = _('ot_CHAF', "CHAF"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'FLAR', name = _('ot_FLAR', "FLAR"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'OTH1', name = _('ot_OTH1', "OTH1"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'OTH2', name = _('ot_OTH2', "OTH2"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'RPT', name = _('ot_RPT', "RPT"), control = 'spinbox', defValue = 1, min = 1, max = 24},
							{ id = 'INT', name = _('ot_INT', "INT"), control = 'spinbox', defValue = 0.25, step = 0.25, min = 0.25, max = 5},
						}
					},
					{ id = 'MAN 4', name = _('ot_MAN 4', "MAN 4"), type = 'section', childs = 
						{
							{ id = 'CHAF', name = _('ot_CHAF', "CHAF"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'FLAR', name = _('ot_FLAR', "FLAR"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'OTH1', name = _('ot_OTH1', "OTH1"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'OTH2', name = _('ot_OTH2', "OTH2"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'RPT', name = _('ot_RPT', "RPT"), control = 'spinbox', defValue = 1, min = 1, max = 24},
							{ id = 'INT', name = _('ot_INT', "INT"), control = 'spinbox', defValue = 0.25, step = 0.25, min = 0.25, max = 5},
						}
					},
					{ id = 'MAN 5', name = _('ot_MAN 5', "MAN 5"), type = 'section', childs = 
						{
							{ id = 'CHAF', name = _('ot_CHAF', "CHAF"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'FLAR', name = _('ot_FLAR', "FLAR"), control = 'spinbox', defValue = 1, min = 0, max = 99},
							{ id = 'OTH1', name = _('ot_OTH1', "OTH1"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'OTH2', name = _('ot_OTH2', "OTH2"), control = 'spinbox', defValue = 0, min = 0, max = 99},
							{ id = 'RPT', name = _('ot_RPT', "RPT"), control = 'spinbox', defValue = 1, min = 1, max = 24},
							{ id = 'INT', name = _('ot_INT', "INT"), control = 'spinbox', defValue = 0.25, step = 0.25, min = 0.25, max = 5},
						}
					},				
				}
			},
			{ id = 'HSI', name = _('ot_HSI', "HSI"), type = 'section', childs = 	
				{
					{ id = 'Heading', name = _('ot_Heading', "Heading"), control = 'comboList', defValue  = 1,
						values = {
									{id =  0, dispName = _("ot_Magnetic", "Magnetic")},
									{id =  1, dispName = _("ot_True", "True")},
								},
					},
					{ id = 'TAWS', name = _('ot_TAWS', "TAWS"), control = 'checkbox', defValue = true},
					{ id = 'HSIAltitude', name = _('ot_HSI Altitude', "HSI Altitude"), type = 'section', childs = 
						{
							{ id = 'BARO', name = _('ot_BARO', "BARO"), control = 'spinbox', defValue = 20000, min = 0, max = 50000},
							{ id = 'RADAR', name = _('ot_RADAR', "RADAR"), control = 'spinbox', defValue = 4500, min = 0, max = 5000},
						}
					},
					{ id = 'ZTOD', name = _('ot_ZTOD', "ZTOD"), control = 'checkbox', defValue = true},		
				}
			},					 
			{ id = 'Navigation', name = _('ot_Navigation', "Navigation"), type = 'section', childs = 	
				{
					{ id = 'ICLS', name = _('ot_ICLS', "ICLS"), control = 'spinbox', defValue = 11, min = 1, max = 20},
					
					{ id = 'TACAN ', name = _('ot_TACAN ', "TACAN"), type = 'section', childs = 	
						{
							{ id = 'ChannelMode', name = _('ot_Channel Mode', "Channel Mode"), control = 'comboList', defValue  = 0,
								values = {
											{id =  0, dispName = _("ot_X", "X")},
											{id =  1, dispName = _("ot_Y", "Y")},
										},
							},
							{ id = 'Channel', name = _('ot_Channel', "Channel"), control = 'spinbox', defValue = 74, min = 1, max = 126},						
						}
					},
				},	
			},
		},		
	},

	

}