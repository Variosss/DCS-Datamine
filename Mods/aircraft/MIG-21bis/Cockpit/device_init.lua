mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

UseDBGInfo = false

layoutGeometry = {}

MainPanel = {"ccMainPanel",
			LockOn_Options.script_path.."mainpanel_init.lua"
					}					


creators = {}

		creators[devices.MACROS] = {"test_namespace::avAuto_Start_Stop",
					"",
					{}
				 }
				 
		creators[devices.DC_BUS] = {"test_namespace::avDCBus",
					LockOn_Options.script_path.."Systems/R_DC_Bus.lua",
					{}
				}
		creators[devices.AC_BUS] = {"test_namespace::avACBus",
					LockOn_Options.script_path.."Systems/R_AC_Bus.lua",
					{}
				}	
		creators[devices.FUEL_PUMPS] = {"test_namespace::avFuelPumps",
					"",
					{}
				}	
		creators[devices.FUEL_SYSTEM] = {"test_namespace::avFuelSystem",
					"",
					{}
				}
		creators[devices.OXYGENE_SYSTEM] = {"test_namespace::avOxygenSystem",
					"",
					{}
				}
		creators[devices.COMPRESSED_AIR_SYSTEM] = {"test_namespace::avCompressedAirSystem",
					"",
					{}
				}
		creators[devices.MAIN_HYDRO] = {"test_namespace::avMainHydro",
					"",
					{}
				}
		creators[devices.ENGINE] = {"test_namespace::avEngine",
					LockOn_Options.script_path.."Systems/R_Engine.lua",
					{}
				}				
				
		creators[devices.ENGINE_START_DEVICE] = {"test_namespace::avEngineStartDevice",
					"",
					{}
				}
				
				--[[
		creators[devices.AIR_CONDITIONING] = {"test_namespace::avAirConditioning",
					"",
					{}
				}
				]]
				
		creators[devices.AIRBRAKE] = {"test_namespace::avAirbrake",
					"",
					{}
				}

		creators[devices.FLAPS] = {"test_namespace::avFlaps",
					"",
					{}
				}

		creators[devices.GEARS] = {"test_namespace::avGears",
					"",
					{}
				}
				
		creators[devices.GEAR_BRAKES] = {"test_namespace::avGearBrakes",
					"",
					{}
				}				

		creators[devices.CONTROL_SYSTEM] = {"test_namespace::avControlSystem",
					"",
					{}
				}
				
		creators[devices.GYRO_DEVICES] = {"test_namespace::avGyroDevice",
					LockOn_Options.script_path.."Systems/R_Gyro_Devices.lua",
					{}
				}

		creators[devices.KSI] = {"test_namespace::avKSI",
					"",
					{}
				}	

		creators[devices.PITOT_TUBES] = {"test_namespace::avPitotTubes",
					LockOn_Options.script_path.."Systems/R_Pitot_Tubes.lua",
					{}
				}	

		creators[devices.KPP] = {"test_namespace::avKPP",
					"",
					{}
				}	

		creators[devices.IAS_INDICATOR] = {"test_namespace::avIAS",
					"",
					{}
				}	

		creators[devices.TAS_INDICATOR] = {"test_namespace::avTAS",
					"",
					{}
				}	

		creators[devices.M_INDICATOR] = {"test_namespace::avMachIndicator",
					"",
					{}
				}	

		creators[devices.ALTIMETER] = {"test_namespace::avAltimeter",
					"",
					{}
				}

		creators[devices.RADIO_ALTIMETER] = {"test_namespace::avRadioAltimeter",
					"",
					{}
				}	

		creators[devices.DA_200] = {"test_namespace::avDa200",
					"",
					{}
				}	

		creators[devices.UUA] = {"test_namespace::avUUA",
					"",
					{}
				}	

		creators[devices.SOD] = {"test_namespace::avSOD",
					"",
					{}
				}	

		creators[devices.ACCELEROMETER] = {"test_namespace::avAccelerometer",
					"",
					{}
				}
				
		creators[devices.HELMET_VISOR] = {"test_namespace::avHelmet",
					"",
					{}
				}

		creators[devices.LIGHTS] = {"test_namespace::avLights",
					LockOn_Options.script_path.."Systems/R_Lights.lua",
					{}
				}

		creators[devices.LIGHTS_WARNING] = {"test_namespace::avLightsWarning",
					"",
					{}
				}

		creators[devices.SARPP] = {"test_namespace::avSARPP",
					"",
					{}
				}

				--[[
		creators[devices.UNCLASSIFIED] = {"test_namespace::avUnclassified",
					"",
					{}
				}	
				]]
				
		creators[devices.RSBN] = {"test_namespace::avRSBN",
					LockOn_Options.script_path.."Systems/R_NAV_data.lua",
					{}
				}
				
		creators[devices.ARK] = {"test_namespace::avARK",
					LockOn_Options.script_path.."Systems/R_NAV_data.lua",
					{}
				}

		creators[devices.MARKER] = {"test_namespace::avMarker",
					LockOn_Options.script_path.."Systems/R_NAV_data.lua",
					{}
				}
				
		creators[devices.SPO] = {"test_namespace::avSPOnew",
					LockOn_Options.script_path.."Systems/R_SPO.lua",
					{}
				}

		creators[devices.ASP] = {"test_namespace::avASP",
					"",
					{}
				}

		creators[devices.KONUS] = {"test_namespace::avKonus",
					"",
					{}
				}
				
		creators[devices.FIRE_EXTINGUISHER] = {"test_namespace::avFireExtinguisher",
					"",
					{}
				}

		creators[devices.CANOPY] = {"test_namespace::avCanopy",
					"",
					{}
				}

		creators[devices.CHUTE] = {"test_namespace::avChute",
					"",
					{}
				}
				
		creators[devices.SPS] = {"test_namespace::avSPS",
					"",
					{}
				}

		creators[devices.SOPLO] = {"test_namespace::avSOPLO",
					LockOn_Options.script_path.."Systems/R_Soplo.lua",
					{}
				}	

		creators[devices.TRIMER] = {"test_namespace::avTrimmer",
					"",
					{}
				}
				
		creators[devices.ARU] = {"test_namespace::avARU",
					"",
					{}
				}

		creators[devices.SAU] = {"test_namespace::avSAU",
					"",
					{}
				}				

		creators[devices.SRZO] = {"test_namespace::avSRZO",
					LockOn_Options.script_path.."Systems/R_SRZO.lua",
					{}
				}			

		creators[devices.SPRD] = {"test_namespace::avSPRD",
					"",
					{}
				}				

		creators[devices.WEAPON_CONTROL] = {"test_namespace::avWeaponsControl",
					LockOn_Options.script_path.."Systems/R_Weapons_Control.lua",
					{}
				}

		creators[devices.RADIO] = {"test_namespace::avRadio",
					LockOn_Options.script_path.."Systems/R_Radio.lua",
					{}
				}
				
		creators[devices.RADAR] = {"test_namespace::avRP21new",
					LockOn_Options.script_path.."Systems/R_rp22.lua",
					{}
				}
					

		creators[devices.INTERCOM] = {"test_namespace::avCustomIntercom",
					LockOn_Options.script_path.."Systems/R_Intercom.lua",	
					{--links 
						{"radio_1", devices.RADIO},
					}
				}
				
		creators[devices.avAChS] = {"test_namespace::avAvAChS",
					LockOn_Options.script_path.."Systems/R_AChS.lua",
					{}
				}		
				
		creators[devices.SPS_CONTROL] = {"test_namespace::avSPSBox",
					"",
					{}
				}	

		creators[devices.NUKE_CONTROL] = {"test_namespace::avNukeIAB",
					"",
					{}
				}
				
		creators[devices.ASO] = {"test_namespace::avASO",
					"",
					{}
				}				
	
		creators[devices.DEBUG] = {"test_namespace::avDebugDevice",
					"",
					{}
				}
		
		--/N/ feb 2014:
		creators[devices.SMOKE] = {"test_namespace::avSmoke",
					"",
					{}
				}

				
		--/N/ may 2018: disabled, moved down, disabled down, re-implemented down		 
		--creators[devices.KNEEBOARD] = {"avKneeboard",LockOn_Options.script_path.."KNEEBOARD/device/init.lua"}

		creators[devices.CONTROLSINDICATOR] = {"test_namespace::avControlsIndicator",
					"",
					{}
				}	
	
indicators = {}


indicators[#indicators + 1] = {"test_namespace::ccHUD",LockOn_Options.script_path.."HUD/Indicator/init.lua",nil,{{"PNT-HUD-CENTER"},{sx_l = 0.0,sy_l = -0.005,sz_l = 0,sh = 0,sw = 0}}}

indicators[#indicators + 1] = 
								{ "test_namespace::ccRadar", 
								 LockOn_Options.script_path.."RADAR/Indicator/init.lua",
								 devices.RADAR,
								 {	
									{"Point_Radar_screen"},
									{sx_l = 0.000,
									 sy_l = 0.000, 
									 sz_l = 0,
									 sh = -0.054,
									 sw = -0.054,
									 rz_l = 10,
									 rx_l = -1.25,
									 ry_l = -1.25}
								 }
								} 


--[[
if LockOn_Options.flight.padlock then 
	indicators[#indicators + 1] = {"ccPadlock" , LockOn_Options.common_script_path.."PADLOCK/PADLOCK_indicator.lua" ,devices.PADLOCK}
end
]]

dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")

if LockOn_Options.flight.easy_radar then
	-- Easy Radar
	-- creators[devices.ARCADE] =	{"avLuaDevice",LockOn_Options.script_path.."ARCADE/arcade.lua",{},"",}
	-- indicators[#indicators + 1] = {"test_namespace::ccRadar",LockOn_Options.script_path.."ARCADE/init.lua",devices.ARCADE,{{""},
									-- {sx_l = 0,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}}

	-- Easy weapons panel
	indicators[#indicators + 1] = {"test_namespace::ccWeaponsSystem",LockOn_Options.script_path.."EASYWEAPONS/Indicator/init.lua",devices.WEAPON_CONTROL,{{""},
									{sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}} 
end


--/N/ may 2018, new, load maps and custom pages, but missing custom overlay
--[[ ]]
disable_kneeboard_render_target = false
is_left = true
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")



--/N/ may 2018. old, ceased to load maps, bugged on ED side, everything else works. For files structure see 1.5.8 repository.
--[[ 
kneeboard_render_target_id = 4
is_left = true
creators[devices.KNEEBOARD] = {"avKneeboard",LockOn_Options.script_path.."KNEEBOARD/device/init.lua"}
indicators [#indicators + 1] =
{

	"ccKneeboard",
	LockOn_Options.script_path.."KNEEBOARD/indicator/init.lua",
	devices.KNEEBOARD,
	{
		
		{
			"PNT_KNEEBOARD",
		},

		{
			sx_l = 0.00,
			sz_l = -0.15,
			sy_l = 0,
			rx_l = 0,
			ry_l = 0, 
			rz_l = 80,
			sw = 0.142 * 0.3 - 0.1,
			sh = 0.214 * 0.3 - 0.1,
			kneeboard_render_target_id
		}, 
		
		--nil
		
	}
}
]]

indicators[#indicators + 1] = {"test_namespace::ccControlsIndicator",LockOn_Options.script_path.."CONTROLS_INDICATOR/Indicator/ControlsIndicator.lua",devices.CONTROLSINDICATOR,{{""},
							  {sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}} 
							  
indicators[#indicators + 1] = {"test_namespace::ccHelmet",LockOn_Options.script_path.."HELMET/Indicator/HelmetIndicator.lua",devices.HELMET_VISOR,{{""},
							  {sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}} 							  