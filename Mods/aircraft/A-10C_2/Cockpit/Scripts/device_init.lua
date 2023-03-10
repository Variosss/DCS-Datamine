dofile(LockOn_Options.script_path.."config.lua")
-- mount textures collections related to A-10C cockpit module and avionics (TAD maps related to terrain)
mount_vfs_model_path(LockOn_Options.script_path.."../Shape")
mount_vfs_texture_archives(LockOn_Options.script_path.."../Textures/A-10C-2020-CPT-TXT")
mount_vfs_texture_archives(LockOn_Options.script_path.."../Textures/A-10C-2020-Aged-CPT-TXT")

local terrain_data = get_terrain_related_data("TAD_vfs_archives")
if terrain_data then
	mount_vfs_path_to_mount_point("/textures/tad/",terrain_data)
end


dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

local function writeParameter(name, value)
	local param = get_param_handle(name)
	if param ~= nil then
		param:set(value)
	end
end

tv_map_render_id = {1, 2, 3, 4};

--	items in <...> are optional
--
-- MainPanel = {"NAME_OF_CLASS",
--				"INIT_SCRIPT_FILE",
--				<{devices.LINKED_DEVICE1, devices.LINKED_DEVICE2, ...},>
--			   }

MainPanel = {"A10C::ccMainPanel", 
			 LockOn_Options.script_path.."mainpanel_init.lua",
			{{"SysController",devices.SYS_CONTROLLER},
			 {"CMSC",devices.CMSC},
			 {"FM_Proxy",devices.FM_PROXY},
			 {"EGI",devices.EGI},
			 {"CADC",devices.CADC},
			 {"cpt_mech",devices.CPT_MECH},
			 {"fuel_system",devices.FUEL_SYSTEM},
			 {"ADI",devices.ADI},
			 {"SAI",devices.SAI},
			 {"HSI",devices.HSI},			 
			 {"NMSP",devices.NMSP},
			 {"TACAN", devices.TACAN},
			 {"ILS", devices.ILS},
			 {"IFFCC", devices.IFFCC},
			 {"AirspeedIndicator", devices.AIRSPEED_INDICATOR},
			 {"AAU34", devices.AAU34},
			 {"OxyControl", devices.OXYGEN_SYSTEM},
			 {"EnvControl", devices.ENVIRONMENT_SYSTEM},
			 {"HARS", devices.HARS},
			 {"engine_system",devices.ENGINE_SYSTEM},
			 {"hydraulic_system",devices.HYDRAULIC_SYSTEM},
			 {"IFF",devices.IFF},
			 {"Accelerometer",devices.ACCELEROMETER},
			 {"DVADR",devices.DVADR},
			 {"NavComp",devices.NAVIGATION_COMPUTER},
			 {"TISL",devices.TISL},
			 {"VHF_AM",devices.VHF_AM_RADIO},
			 {"VHF_FM",devices.VHF_FM_RADIO},
			 {"TACAN_CtrlPanel",devices.TACAN_CTRL_PANEL},
			 {"LIGHT_SYS", devices.LIGHT_SYSTEM}
			},
             LockOn_Options.script_path.."main_panel_commands.lua"}
			 
-- Avionics devices initialization example
--	items in <...> are optional
--
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--						  <"CONTROLLER_SCRIPT_FILE",>
--						  <{devices.LINKED_DEVICE1, devices.LINKED_DEVICE2, ...},>
--						  <"INPUT_COMMANDS_SCRIPT_FILE",>
--						  <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--						 }


creators = {}
creators[devices.ELEC_INTERFACE]	= {"A10Common::avElectricInterface"}

MFCD_Links_right ={
	 {"ElecInterface",devices.ELEC_INTERFACE},
	 {"brother",devices.MFCD_LEFT },
	 {"mav_interface",devices.MAVERICK_INTERFACE },
	 {"IFFCC", devices.IFFCC},
	 {"dsms_interface",devices.DSMS_INTERFACE },
	 {"tgp_interface", devices.LITENING_INTERFACE},
	 {"DTS",devices.DATA_TRANSFER_SYSTEM },
	 {"CDU", devices.CDU},
	 {"TAD", devices.TAD},
	 {"EGI", devices.EGI},
	 {"HUD", devices.HUD},
	 {"SysController",devices.SYS_CONTROLLER },
	 {"AIM9", devices.SIDEWINDER_INTERFACE},
	 {"HOTAS", devices.HOTAS},
	 {"SADL", devices.SADL},
	 {"IAM_Interface", devices.IAM_INTERFACE},
	 {"NavComp",devices.NAVIGATION_COMPUTER },
	 {"CICU", devices.CICU},
	 {"LIGHT_SYS", devices.LIGHT_SYSTEM},
	 {"HMCS",devices.SCORPION_HMCS},
	 {"arc210", devices.VHF_AM_RADIO},
	}


MFCD_Links_left = {}
copyTable(MFCD_Links_left, MFCD_Links_right)
MFCD_Links_left[2][2] = devices.MFCD_RIGHT

creators[devices.MFCD_LEFT]			= {"A10C_2::avMFCD_A10C_2",
								       LockOn_Options.script_path.."MFCD/device/MFCD_left_param.lua",
								       MFCD_Links_left,
									   LockOn_Options.script_path.."MFCD/device/MFCD_commands.lua",
								      }

creators[devices.MFCD_RIGHT]		= {"A10C_2::avMFCD_A10C_2",
								       LockOn_Options.script_path.."MFCD/device/MFCD_right_param.lua",
								       MFCD_Links_right,
									   LockOn_Options.script_path.."MFCD/device/MFCD_commands.lua",									   
								      }
									  
creators[devices.CMSP]				= {"A10Common::avCMSP",
								       LockOn_Options.script_path.."CMSP/device/CMSP_param.lua",
								       {{"JammerInterface",devices.JAMMERS_INTERFACE},
										{"ALR69V",devices.AN_ALR69V},
										{"ALE40V",devices.AN_ALE40V},
										{"ElecInterface",devices.ELEC_INTERFACE},
										{"AAR_47",devices.AAR47}},
								      }

creators[devices.CMSC]				= {"A10C::avCMSC",
								       LockOn_Options.script_path.."CMSC/device/CMSC_param.lua",
								       {{"JammerInterface",devices.JAMMERS_INTERFACE},
								        {"ALR69V",devices.AN_ALR69V},
								        {"ALE40V",devices.AN_ALE40V},
								        {"CMSP",devices.CMSP},
										{'ElecInterface',devices.ELEC_INTERFACE},
										{'AAR47',devices.AAR47}
										}
								      }
									  
creators[devices.AAR47]				= {"A10C::avAAR_47",
								       LockOn_Options.script_path.."AAR47/device/AAR47_param.lua",
									   {
									    {"ElecInterface",devices.ELEC_INTERFACE},
										{"CMSP",devices.CMSP}
									   },
								      }	


creators[devices.AN_APN_194]		= {"A10Common::avAN_APN_194",
								       LockOn_Options.script_path.."AN_APN_194/device/AN_APN_194_param.lua",
									   {
									    {"ElecInterface",devices.ELEC_INTERFACE},
--										{"FM_Proxy",devices.FM_PROXY},
--										{"EGI", devices.EGI},
									   },
								      }										  

creators[devices.JAMMERS_INTERFACE]	= {"A10C::avJammerInterface",
									   "",
								       {{"CMSP",devices.CMSP}},
									    LockOn_Options.script_path.."Jammers/jammers_commands.lua",
								      }

creators[devices.AHCP]				= {"A10C::avAHCP",
								       "",
									   {{"ElecInterface",devices.ELEC_INTERFACE },
										{"MFCD_Left", devices.MFCD_LEFT},
										{"MFCD_Right", devices.MFCD_RIGHT},
										{"IFFCC", devices.IFFCC},
										{"TGP",devices.LITENING_INTERFACE },
										{"TAD", devices.TAD},
										{"DTS",devices.DATA_TRANSFER_SYSTEM },
										{"HUD", devices.HUD},
										{"SADL", devices.SADL},
										{"IAM_Interface", devices.IAM_INTERFACE},
										{"CICU", devices.CICU},
										{"DTSAS", devices.DTSAS},
										{"DSMS", devices.DSMS_INTERFACE},
										{"LIGHT_SYS", devices.LIGHT_SYSTEM},
										},
									   LockOn_Options.script_path.."AHCP/AHCP_commands.lua",
								      }

creators[devices.UFC]				= {"A10C_2::avUFC_A10C_2",
								       "",
										{{"ElecInterface",devices.ELEC_INTERFACE},
										 {"CDU",devices.CDU},
										 {"DSMS",devices.DSMS_INTERFACE},
										 {"IFFCC",devices.IFFCC},
										 {"HUD",devices.HUD},
										 {"NavComp",devices.NAVIGATION_COMPUTER},
										 {"MAV",devices.MAVERICK_INTERFACE},
										 {"EGI",devices.EGI},
										 {"DTSAS", devices.DTSAS},
										 {"arc210", devices. VHF_AM_RADIO},
										}
								      }



creators[devices.CDU]				= {"A10C::avCDU",
								       LockOn_Options.script_path.."CDU/device/CDU.lua",
									  {{"AAP",devices.AAP },
										{"UFC",devices.UFC },
										{"NavigationComputer",devices.NAVIGATION_COMPUTER },
										{"EGI", devices.EGI},
										{"DTSAS",devices.DTSAS },
									    {"CADC", devices.CADC},
									    {"HARS", devices.HARS},										
										{"IFFCC", devices.IFFCC},
										{"DTS", devices.DATA_TRANSFER_SYSTEM},
										{"SysController", devices.SYS_CONTROLLER},
								        {"NMSP", devices.NMSP},
										{"CICU", devices.CICU},
										{"LIGHT_SYS", devices.LIGHT_SYSTEM},
										},
										LockOn_Options.script_path.."CDU/device/CDU_commands.lua",	
								      } 
									  



creators[devices.LITENING_INTERFACE]= {"A10C::avTGP_Interface",
								       LockOn_Options.script_path.."TGP/TGP.lua",
									   {{"DTSAS",devices.DTSAS },
										{"HOTAS",devices.HOTAS },
										{"IFFCC", devices.IFFCC},
										{"CADC",devices.CADC },
								        {"nav_computer", devices.NAVIGATION_COMPUTER},
										{"FM_proxy", devices.FM_PROXY},
										{"SysController", devices.SYS_CONTROLLER},
										{"CICU", devices.CICU},
										},
										LockOn_Options.script_path.."TGP/TGP_commands.lua",	
								      }
								       
									   
									   

creators[devices.IFFCC]				= {"A10C_2::avIFFCC_A10C_2",
										LockOn_Options.script_path.."IFFCC/IFFCC_param.lua",
										{{"mav_interface",devices.MAVERICK_INTERFACE},
										{"DSMS",devices.DSMS_INTERFACE },
										{"TGP",devices.LITENING_INTERFACE },
										{"ElecInterface",devices.ELEC_INTERFACE },
										{"HUD",devices.HUD },
										{"UFC",devices.UFC },
										{"SysController",devices.SYS_CONTROLLER },
										{"nav_computer",devices.NAVIGATION_COMPUTER },
										{"AIM9",devices.SIDEWINDER_INTERFACE },
										{"EGI",devices.EGI },
										{"DTSAS",devices.DTSAS },
										{"CDU",devices.CDU },
										{"IAM_Interface",devices.IAM_INTERFACE },
										{"SADL",devices.SADL },
										{"FM_Proxy",devices.FM_PROXY},
										{"autopilot",devices.AUTOPILOT},
										{"TAD",devices.TAD},
										{"CADC",devices.CADC},
										{"HOTAS",devices.HOTAS},
										{"CICU", devices.CICU},
										{"RDR_ALTIMETER", devices.AN_APN_194},
										{"VMU",	devices.VMU},
										},
										 LockOn_Options.script_path.."IFFCC/IFFCC_commands.lua"}

creators[devices.DSMS_INTERFACE]		= {"A10C_2::avDSMS_Interface_A10C_2",
											LockOn_Options.script_path.."DSMS/device/dsms_interface.lua",
											{{"MFCD_Left", devices.MFCD_LEFT},
											{"MFCD_Right",devices.MFCD_RIGHT },
											{"maverick_interface",devices.MAVERICK_INTERFACE },
											{"AIM9", devices.SIDEWINDER_INTERFACE},
											{"IAM_interface", devices.IAM_INTERFACE},
											{"SystemController",devices.SYS_CONTROLLER },
											{"weapon_interface",devices.IFFCC},
											{"TGP",devices.LITENING_INTERFACE },
											{"JammerInterface",devices.JAMMERS_INTERFACE},
											{"NavComp",devices.NAVIGATION_COMPUTER},
											{"CICU", devices.CICU}},
											LockOn_Options.script_path.."DSMS/device/DSMS_commands.lua"
											}

creators[devices.MAVERICK_INTERFACE] = {"A10C_2::avMaverick_Interface_A10C_2",
								        LockOn_Options.script_path.."Maverick/maverick_interface.lua",
										{{"IFFCC", devices.IFFCC},
										 {"DSMS", devices.DSMS_INTERFACE},
										 {"DTSAS", devices.DTSAS},
										 {"HOTAS", devices.HOTAS},
										 {"TGP", devices.LITENING_INTERFACE},
										 {"HUD", devices.HUD},
										 {"CICU", devices.CICU}},
										 LockOn_Options.script_path.."Maverick/maverick_commands.lua"
									   }
											
creators[devices.DATA_TRANSFER_SYSTEM]	= {"A10C_2::avDataTransferSystem_A10C_2",
										   LockOn_Options.script_path.."DigitalTransferSys/Parameters.lua",
											{{"DSMS",devices.DSMS_INTERFACE },
											{"ElecInterface", devices.ELEC_INTERFACE},
										    {"MFCD_left",devices.MFCD_LEFT },
											{"MFCD_right",devices.MFCD_RIGHT },
											{"HOTAS",devices.HOTAS },
											{"IFFCC",devices.IFFCC },
											{"CDU",devices.CDU },
											{"SADL",devices.SADL },
											{"TGP",devices.LITENING_INTERFACE },
											{"TAD",devices.TAD}}
										  }

creators[devices.DIGITAL_CLOCK]			= {"A10Common::avDigitalClock",
										   LockOn_Options.script_path.."DigitalClock/device/DIGIT_CLK_param.lua",
										   {{"ElecInterface",devices.ELEC_INTERFACE}}
										   }
										  
		

										  
creators[devices.HOTAS]					= {"A10C_2::avHOTAS_A10C_2",
										   LockOn_Options.script_path .. "HOTAS/HOTAS_param.lua",
											{
											{"MFCD_left",devices.MFCD_LEFT },
											{"MFCD_right",devices.MFCD_RIGHT },
											{"TGP",devices.LITENING_INTERFACE },
											{"MAV",devices.MAVERICK_INTERFACE },
											{"TAD",devices.TAD },
											{"ALE40",devices.AN_ALE40V },
											{"IFFCC",devices.IFFCC },
											{"DSMS",devices.DSMS_INTERFACE },
											{"HUD",devices.HUD },
											{"nav_computer",devices.NAVIGATION_COMPUTER },
											{"AIM9",devices.SIDEWINDER_INTERFACE},
									        {"SADL",devices.SADL },
											{"SysController",devices.SYS_CONTROLLER},
											{"elec_system",devices.ELEC_INTERFACE},
											{"CMSP",devices.CMSP},
											{"CMSC",devices.CMSC},
											{"INTERCOM",devices.INTERCOM},
											{"JammerInterface",devices.JAMMERS_INTERFACE},
											{"CICU", devices.CICU},
											{"DTSAS", devices.DTSAS},
											{"AHCP", devices.AHCP},
											{"CDU", devices.CDU},
											{"FM_proxy",devices.FM_PROXY},
											{"HMCS",devices.SCORPION_HMCS},
											},
										   LockOn_Options.script_path.."HOTAS/HOTAS_commands.lua"}

										   
										      
										   
creators[devices.HUD]				= {"A10C_2::avHUD_A10C_2",
									   LockOn_Options.script_path.."HUD/device/HUD_param.lua",
									    {{"ElecInterface",devices.ELEC_INTERFACE },
										{"CDU",devices.CDU },
										{"UFC",devices.UFC },
										{"NavComp",devices.NAVIGATION_COMPUTER },
										{"IFFCC",devices.IFFCC },
										{"TGP",devices.LITENING_INTERFACE },
										{"MAV",devices.MAVERICK_INTERFACE },
										{"TAD",devices.TAD },
										{"MFCD_left",devices.MFCD_LEFT },
										{"MFCD_right",devices.MFCD_RIGHT },
										{"SysController",devices.SYS_CONTROLLER },
										{"EGI",devices.EGI },
										{"AIM9",devices.SIDEWINDER_INTERFACE  },
										{"HOTAS",devices.HOTAS },
										{"SADL",devices.SADL},
										{"IAM_Interface",devices.IAM_INTERFACE},
										{"DSMS",devices.DSMS_INTERFACE},--for indicator
										{"CADC",devices.CADC },--for indicator
										{"FM_Proxy",devices.FM_PROXY},--for indicator
										{"HARS",devices.HARS},
										{"NMSP",devices.NMSP},
										{"CICU", devices.CICU},
										{"DTSAS", devices.DTSAS},
										{"HMCS",devices.SCORPION_HMCS},
										{"ARC_210",	devices.VHF_AM_RADIO},
										},
								      }
									  
creators[devices.DTSAS]				= {"A10C::avDTSAS",
								       LockOn_Options.script_path.."DTSAS/DTSAS_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
									    {"CDU", devices.CDU},
										{"HUD", devices.HUD},
										{"EGI", devices.EGI},
										},
								       }								      
 
 creators[devices.NMSP]				= {"A10C::avNMSP",
								       LockOn_Options.script_path.."NMSP/NMSP_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
										{"NavComp",devices.NAVIGATION_COMPUTER },
										{"EGI",devices.EGI },
										{"TISL",devices.TISL},
										{"HUD", devices.HUD},
										{"SysController",devices.SYS_CONTROLLER}
										},
								       LockOn_Options.script_path.."NMSP/NMSP_commands.lua",										
								       }											   

 creators[devices.HSI]				= {"A10C::avHSI",
								       LockOn_Options.script_path.."HSI/HSI_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
										{"NavComp",devices.NAVIGATION_COMPUTER}
										}								
								       }	

creators[devices.ADI]				= {"A10C::avADI",
								       LockOn_Options.script_path.."ADI/ADI_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
										{"NavComp",devices.NAVIGATION_COMPUTER},
										{"FM_Proxy",devices.FM_PROXY}
										}
								       }	 
									   
creators[devices.SAI]				= {"A10C::avSAI",
								       LockOn_Options.script_path.."SAI/SAI_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
										{"NavComp",devices.NAVIGATION_COMPUTER},
										{"FM_Proxy",devices.FM_PROXY}
										}
								       }	 									   
									   

creators[devices.NAVIGATION_COMPUTER]	= {"A10C::avNavigationComputer",
								       LockOn_Options.script_path.."NavigationComputer/Device/NavigationComputer_param.lua",
										{{"EGI",devices.EGI },
										 {"IFFCC",devices.IFFCC },
										 {"CDU",devices.CDU },
										 {"DTSAS",devices.DTSAS },
										 {"autopilot",devices.AUTOPILOT},
										 {"NMSP", devices.NMSP},
										 {"HSI", devices.HSI},
										 {"CADC", devices.CADC},
										 {"HARS", devices.HARS},
										 {"TACAN", devices.TACAN},
										 {"ILS", devices.ILS},
										 {"UHF_RADIO", devices.UHF_RADIO},
										 {"TISL", devices.TISL},
										 {"FM_Proxy",devices.FM_PROXY},
                                         {"TAD",devices.TAD},
										 {"DSMS", devices.DSMS_INTERFACE},
										{"CICU", devices.CICU},
										}
									}								      

creators[devices.AAP]				= {"A10C::avAAP",
								       "",
									    {{"ElecInterface",devices.ELEC_INTERFACE },
									    {"CDU",devices.CDU },
									    {"NavComp",devices.NAVIGATION_COMPUTER },
									    {"EGI",devices.EGI}}
								       }

creators[devices.EGI]				= {"A10C::avEGI",
								       LockOn_Options.script_path .. "EGI/EGI_param.lua",
									   {
										{"NavComp",devices.NAVIGATION_COMPUTER },
									    {"CDU",devices.CDU },
										{"CADC",devices.CADC},
									   }
								       }
									   								   

creators[devices.CADC]				= {"A10Common::avCADC",
								       LockOn_Options.script_path .. "CADC/CADC_param.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
									    {"FM_Proxy",devices.FM_PROXY}},
								      }

creators[devices.HARS]				= {"A10Common::avHARS",
								       LockOn_Options.script_path .. "HARS/HARS_param.lua",
								       {{"ElecInterface", devices.ELEC_INTERFACE},
									    {"RemoteCompass", devices.REMOTE_COMPASS}}
								      }									  
									  
creators[devices.REMOTE_COMPASS]	= {"A10Common::avRemoteCompassTransmitter",
								       LockOn_Options.script_path .. "RemoteCompassTransmitter/RemoteCompassTransmitter_param.lua",
								       {{"ElecInterface", devices.ELEC_INTERFACE}}
								      }									  
									  									  

creators[devices.SYS_CONTROLLER]	= {"A10C::avSystemController",
								       "",
										{{"ElecInterface",devices.ELEC_INTERFACE },
										{"PulseTimer",devices.PULSE_TIMER },
										{"MFCD_Left",devices.MFCD_LEFT },
										{"MFCD_Right",devices.MFCD_RIGHT },
										{"CDU",devices.CDU },
										{"CADC",devices.CADC },
										{"EGI",devices.EGI },
										{"IFFCC",devices.IFFCC },
										{"ToneGenerator",devices.TONE_GENERATOR},
										{"TGP",devices.LITENING_INTERFACE },
										{"MAV",devices.MAVERICK_INTERFACE },
										{"autopilot",devices.AUTOPILOT},
										{"FM_Proxy",devices.FM_PROXY},
										{"ILS",devices.ILS},
										{"HARS",devices.HARS},
										{"OxyControl",devices.OXYGEN_SYSTEM},
										{"cpt_mech",devices.CPT_MECH},
										{"VMU",	devices.VMU},
										{"RadarAltimeter", devices.AN_APN_194},
										{"EngSysInterface", devices.ENGINE_SYSTEM},
										{"envirCtrlSys", devices.ENVIRONMENT_SYSTEM},
										{"stallSys", devices.STALL},
										{"CICU", devices.CICU},
										},
										LockOn_Options.script_path.."SystemController_commands.lua",
								      }

creators[devices.PULSE_TIMER]		= {"A10Common::avPulseTimer",
								       LockOn_Options.script_path .. "PulseTimer/PulseTimerParam.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE}}
								      }
								  
creators[devices.TAD]				= {"A10C::avTAD_Interface",
								       LockOn_Options.script_path.."TAD/TAD.lua",
										{{"nav_computer",devices.NAVIGATION_COMPUTER },
										{"TGP",devices.LITENING_INTERFACE },
										{"DTSAS",devices.DTSAS },
										{"HOTAS",devices.HOTAS },
							            {"SADL",devices.SADL },
										{"IFFCC",devices.IFFCC },
										{"CDU",devices.CDU },
										{"EGI",devices.EGI},
										{"CADC",devices.CADC },
										{"SysController",devices.SYS_CONTROLLER}},
										LockOn_Options.script_path.."TAD/TAD_commands.lua",	
								      }

creators[devices.VMU]				= {"A10C::avVMU",
								       LockOn_Options.script_path.."VMU/device/VMU.lua",
								       {{"SysController",devices.SYS_CONTROLLER},
								        {"ElecInterface",devices.ELEC_INTERFACE}}
								      }

creators[devices.TONE_GENERATOR]	= {"A10C::avToneGenerator",
								       "",
								       {
								        {"ElecInterface",devices.ELEC_INTERFACE}}
								      }

creators[devices.AN_ALR69V]			= {"A10C::avAN_ALR69V",
								       LockOn_Options.script_path.."AN_ALR69V/device/ALR69_param.lua",
								       {{"CMSP",devices.CMSP},
									    {"AAR_47", devices.AAR47},
										{"CMSC",devices.CMSC},
										{'ElecInterface',devices.ELEC_INTERFACE},
										},
									  }

creators[devices.AN_ALE40V]			= {"A10C::avAN_ALE_40V",
									   LockOn_Options.script_path.."AN_ALE40V/device/AN_ALE40V_params.lua",
								      {{"CMSP",devices.CMSP},
									   {"FM_Proxy",devices.FM_PROXY},
									   {'ElecInterface',devices.ELEC_INTERFACE},
									   },
								       LockOn_Options.script_path.."AN_ALE40V/device/AN_ALE40V_commands.lua",
								      }



creators[devices.SIDEWINDER_INTERFACE]= {"A10C::avSidewinder_Interface",
								         "",
										{{"IFFCC",devices.IFFCC },
										{"DSMS",devices.DSMS_INTERFACE },
										{"TGP",devices.LITENING_INTERFACE },
										{"HOTAS",devices.HOTAS },
										{"EGI", devices.EGI}},
										LockOn_Options.script_path.."Sidewinder/sidewinder_commands.lua",
									    }



creators[devices.SADL]				  = {"A10C::avSADL",
								       LockOn_Options.script_path .. "SADL/SADL_param.lua",
										{{"ElecInterface", devices.ELEC_INTERFACE },
										 {"SysController", devices.SYS_CONTROLLER },
										 {"EGI", devices.EGI },
										 {"TAD", devices.TAD },
										 {"NavComp", devices.NAVIGATION_COMPUTER },
										 {"IFFCC", devices.IFFCC },
										 {"DSMS", devices.DSMS_INTERFACE },
										 {"RT1720", devices.RT1720},
										 {"Fuel_Interface", devices.FUEL_SYSTEM},
										 {"TGP", devices.LITENING_INTERFACE},
										 {"CICU", devices.CICU},
										},
										LockOn_Options.script_path.."SADL/SADL_commands.lua",
									    }
										
creators[devices.RT1720]	         = {	"A10C::avRT_1720", 
								            LockOn_Options.script_path.."RT_1720/device/RT1720_param.lua",
								            {
									         {"ElecInterface", devices.ELEC_INTERFACE},
								            }
									  }
										

creators[devices.IAM_INTERFACE]		= {"A10C::avIAM_Interface",
								         "",
								        {{"IFFCC",devices.IFFCC},
									     {"DSMS",devices.DSMS_INTERFACE},
									     {"EGI",devices.EGI},
										 {"CICU", devices.CICU}},
										 LockOn_Options.script_path.."IAM/IAM_commands.lua",
									    }

creators[devices.HELMET_DEVICE]		= {"avNightVisionGogglesV2",
									   LockOn_Options.script_path.."HELMET/HELMET.lua",
									   {},
									   LockOn_Options.script_path.."HELMET/HELMET_commands.lua"}
									   
creators[devices.FM_PROXY]			= {"A10Common::avA10_FM_Proxy"}

creators[devices.FUEL_SYSTEM]		= {"A10Common::avFuelSystemInterface_A10",LockOn_Options.script_path.."FuelSystem/FuelSystem_init.lua",
																			{{"elec_system",devices.ELEC_INTERFACE},
																			 {"FM_proxy",devices.FM_PROXY}}
																			}
																			
creators[devices.ENGINE_SYSTEM]		= {"A10Common::avEngineSystemInterface_A10",LockOn_Options.script_path.."EngineSystem/EngineSystem_init.lua",
																			{ {"elec_system",devices.ELEC_INTERFACE},
																			  {"FM_Proxy",devices.FM_PROXY},
																			}}
																			
creators[devices.HYDRAULIC_SYSTEM]	= {"A10Common::avHydraulicSystemInterface_A10",LockOn_Options.script_path.."HydraulicSystem/HydraulicSystem_init.lua",
																			{ {"elec_system",devices.ELEC_INTERFACE},
																			  {"FM_Proxy",devices.FM_PROXY},
																			}}
																			
creators[devices.AUTOPILOT]			= {"A10C::avAutoPilotInterface_A10C","",{{"EGI",devices.EGI},
																			 {"IFFCC",devices.IFFCC},
																			 {"CADC",devices.CADC},
																			 {"NMSP",devices.NMSP},
																			 {"HARS", devices.HARS},
																			 {"FM_proxy",devices.FM_PROXY},
																			 }}

creators[devices.CPT_MECH]			= {"A10Common::avCockpitMechanics_A10",LockOn_Options.script_path.."CockpitMechanics/CockpitMechanics_init.lua",
																			{{"elec_system",devices.ELEC_INTERFACE},
																			  {"FM_proxy",devices.FM_PROXY}}}

creators[devices.ENVIRONMENT_SYSTEM]= {"A10Common::avEnvironmentControlSystem",
										LockOn_Options.script_path.."EnvironmentSystem_init.lua",
										{{"elec_system",devices.ELEC_INTERFACE}}
									}
									
creators[devices.OXYGEN_SYSTEM]		= {"A10Common::avOxygenControlSystem",
										LockOn_Options.script_path.."OxygenSystem_init.lua",
										{{"elec_system",devices.ELEC_INTERFACE}, 
										{"Environment_system",devices.ENVIRONMENT_SYSTEM},
										{"FM_Proxy",devices.FM_PROXY}}
									}
										
creators[devices.IFF]				= {"A10Common::avIFF_APX_72",""			 ,{{"elec_system",devices.ELEC_INTERFACE}}}

creators[devices.LIGHT_SYSTEM]		= {"A10Common::avLightSystem_A10",LockOn_Options.script_path.."LightSystem/LightSystem.lua",{{"elec_system",devices.ELEC_INTERFACE}}}
creators[devices.FIRE_SYSTEM]		= {"A10Common::avFireExtinguishingSystem_A10","",{{"elec_system",devices.ELEC_INTERFACE}}}

creators[devices.TACAN]		= {"A10Common::avTACAN_AN_ARN118", 
								LockOn_Options.script_path.."TACAN_AN_ARN118/TACAN_AN_ARN118.lua", 
								{{"elec_system", devices.ELEC_INTERFACE}},
							  }

creators[devices.TACAN_CTRL_PANEL]	= {"avTACAN_ARN118_CtrlPanel", 
								LockOn_Options.script_path.."TACAN_AN_ARN118/TACAN_ARN118_CtrlPanel.lua", 
								{{"TACAN_ARN118", devices.TACAN}},
							  }

creators[devices.STALL]		= {"A10C::avSTALL",
								LockOn_Options.script_path.."STALL/StallParams.lua",
								{{"ToneGenerator",devices.TONE_GENERATOR},
								 {"FM_Proxy", devices.FM_PROXY},
								 {"elec_system", devices.ELEC_INTERFACE},
								 {"IFFCC", devices.IFFCC},
								}
							  }

creators[devices.ILS]		= {"A10Common::avILS_AN_ARN108", 
								LockOn_Options.script_path.."ILS/ILS_params.lua", 
								{{"elec_system", devices.ELEC_INTERFACE}},
								}
creators[devices.UHF_RADIO]	= {	"A10C::avUHF_ARC_164", 
								LockOn_Options.script_path.."UHF_Radio/device/UHF_Radio.lua",
								{{"elec_system", devices.ELEC_INTERFACE},
								{"NMSP", devices.NMSP}}}
creators[devices.VHF_FM_RADIO]	= {"A10C::avVHF_ARC_186", LockOn_Options.script_path.."VHF_radio/device/FM_Radio.lua", {{"elec_system", devices.ELEC_INTERFACE},
								{"NMSP", devices.NMSP}}, LockOn_Options.script_path.."VHF_radio/device/Radio_commands.lua"}  

creators[devices.TISL]		= {"A10C::avTISL", "", 
								{{"SysController",devices.SYS_CONTROLLER},
								{'ElecInterface',devices.ELEC_INTERFACE}
								}}

creators[devices.INTERCOM] = {	"A10C::avIntercom",
								LockOn_Options.script_path.."Intercom.lua",
								{{"elec_system", 	devices.ELEC_INTERFACE},
								 {"UHF_Radio",		devices.UHF_RADIO},
								 {"TACAN",			devices.TACAN},
								 {"ILS",			devices.ILS},
								 {"ToneGenerator",	devices.TONE_GENERATOR},
								 {"VHF_AM_Radio",	devices.VHF_AM_RADIO},
								 {"VHF_FM_Radio",	devices.VHF_FM_RADIO},
								 {"VMU",			devices.VMU},
								 {"AIM9", 			devices.SIDEWINDER_INTERFACE}
								 }}

creators[devices.AIRSPEED_INDICATOR]	= {"A10Common::avAirspeedIndicator",
								       LockOn_Options.script_path .. "AirspeedIndicator/Device/AirspeedIndicator.lua",
								       {{"FM_Proxy",devices.FM_PROXY}},
									}

creators[devices.AAU34]	= 	{"A10Common::avAAU34",
								       LockOn_Options.script_path .. "AAU34/Device/AAU34.lua",
								       {{"ElecInterface",devices.ELEC_INTERFACE},
										{"CADC",devices.CADC},
									   {"FM_Proxy",devices.FM_PROXY}}
								      }

creators[devices.STANDBY_COMPASS] = { "avMechCompass",
								       LockOn_Options.script_path .. "StandbyCompass/StandbyCompass.lua",
								       {}
									}

creators[devices.CICU]				= {"A10C_2::avCICU_A10C_2",
								       LockOn_Options.script_path.."CICU/device/CICU.lua",
									   {{"AHCP",devices.AHCP },
										{"HOTAS",devices.HOTAS },
										{"MFCD_Left", devices.MFCD_LEFT},
										{"MFCD_Right", devices.MFCD_RIGHT},
										{"IFFCC",devices.IFFCC },
										{"HUD", devices.HUD},
										{"SysController",devices.SYS_CONTROLLER},
										{"ElecInterface",devices.ELEC_INTERFACE},
										{"arc210",devices.VHF_AM_RADIO},
										}
								      }

creators[devices.KY_58] 			  = { "A10C::avKY_58"}

creators[devices.AVIONICS_PROXY]	  = {"A10C::avAvionicsDataProxyA10","",
											{{"CADC",devices.CADC},
											{"EGI",devices.EGI},
											{"RDR_ALTIMETER", devices.AN_APN_194},
											{"FM_PROXY",devices.FM_PROXY},
											}
										}

creators[devices.ACCELEROMETER] 	  = {"A10Common::avAccelerometer", LockOn_Options.script_path .. "Accelerometer/Accelerometer.lua",
											{{"FM_PROXY",devices.FM_PROXY}}
										}
									
creators[devices.DVADR]         	  = {"A10C::avDVADR",
											"",
											{{"ElecInterface",devices.ELEC_INTERFACE}}
										}
									
creators[devices.PADLOCK]       	  = {"A10C::avPadlock_A10",
											LockOn_Options.common_script_path .. "PADLOCK/PADLOCK_device.lua",
											{{"HUD", devices.HUD}}
										}

creators[devices.SCORPION_HMCS]		  = {"A10C_2::avScorpionHMCS", nil,
									    {{"ElecInterface",devices.ELEC_INTERFACE },
										{"CDU",devices.CDU },
										{"NavComp",devices.NAVIGATION_COMPUTER },
										{"IFFCC",devices.IFFCC },
										{"TGP",devices.LITENING_INTERFACE },
										--{"MAV",devices.MAVERICK_INTERFACE },
										{"TAD",devices.TAD },
										{"MFCD_left",devices.MFCD_LEFT },
										{"MFCD_right",devices.MFCD_RIGHT },
										{"EGI",devices.EGI },
										--{"AIM9",devices.SIDEWINDER_INTERFACE  },
										{"HOTAS",devices.HOTAS },
										{"SADL",devices.SADL},
										--{"IAM_Interface",devices.IAM_INTERFACE},
										{"DSMS",devices.DSMS_INTERFACE},
										{"FM_Proxy",devices.FM_PROXY},
										{"HARS",devices.HARS},
										{"NMSP",devices.NMSP},
										{"CICU", devices.CICU},
										{"DTSAS", devices.DTSAS},
										{"SysController",devices.SYS_CONTROLLER},
										{"HUD", devices.HUD},
										{"CADC", devices.CADC},
										{"LIGHT_SYS", devices.LIGHT_SYSTEM},
										},
								      }
									  
creators[devices.VHF_AM_RADIO]	= {"A10C_2::avARC_210",
						       LockOn_Options.script_path.."ARC_210/Device/ARC_210_param.lua",
							   {{"ElecInterface", devices.ELEC_INTERFACE},
							    {"EGI", devices.EGI},}
							   }



indicators = {}

indicators[#indicators + 1] = {"A10C::ccLitening",		LockOn_Options.script_path.."TGP/TGP_render_init.lua"					,devices.LITENING_INTERFACE	,{{},{},tv_map_render_id[1]}}
indicators[#indicators + 1] = {"A10C_2::ccMFCD_A10C_2",	LockOn_Options.script_path.."MFCD/indicator/MFCD_left_init.lua"			,devices.MFCD_LEFT			,{{"PNT-MFCD-L-CENTER","PNT-MFCD-L-DOWN","PNT-MFCD-L-RIGHT"},{},tv_map_render_id[2]}}
writeParameter("RMFCD_INDICATOR_INDEX", #indicators)
indicators[#indicators + 1] = {"A10C_2::ccMFCD_A10C_2",	LockOn_Options.script_path.."MFCD/indicator/MFCD_right_init.lua"		,devices.MFCD_RIGHT			,{{"PNT-MFCD-R-CENTER","PNT-MFCD-R-DOWN","PNT-MFCD-R-RIGHT"},{},tv_map_render_id[3]}}
indicators[#indicators + 1] = {"A10C::ccCDU", 			LockOn_Options.script_path.."CDU/indicator/CDU_init.lua"				,devices.CDU				,{{"PNT-CDU-CENTER","PNT-CDU-DOWN","PNT-CDU-RIGHT"}			,{sx_l = -0.001}}}
indicators[#indicators + 1] = {"A10Common::ccDigitalClock",	LockOn_Options.script_path.."DigitalClock/indicator/DIGIT_CLK_init.lua"	,devices.DIGITAL_CLOCK		,{{"PNT-WATCH-CENTER","PNT-WATCH-DOWN","PNT-WATCH-RIGHT"}	,{sx_l = -0.0002}}}
indicators[#indicators + 1] = {"A10C_2::ccHUD_A10C_2", 	LockOn_Options.script_path.."HUD/Indicator/HUD_init.lua"				,devices.HUD				,{{"PNT-HUD-CENTER","PNT-HUD-DOWN","PNT-HUD-RIGHT"}			,{sx_l = -0.2,sw = 0.035}}}
indicators[#indicators + 1] = {"A10C::ccAN_ALR69V", 	LockOn_Options.script_path	.."AN_ALR69V/indicator/AN_ALR69V_init.lua"	,devices.AN_ALR69V			,{{"PNT-RWR-CENTER","PNT-RWR-DOWN","PNT-RWR-RIGHT"}}}
indicators[#indicators + 1] = {"A10Common::ccCMSP", 	LockOn_Options.script_path.."CMSP/indicator/CMSP_init.lua"				,devices.CMSP				,{{"PNT-CMSP-CENTER","PNT-CMSP-DOWN","PNT-CMSP-RIGHT"}		,{sx_l = -0.0007,sy_l = -0.004,sz_l = 0.0015}}}
indicators[#indicators + 1] = {"A10C::ccCMSC", 			LockOn_Options.script_path.."CMSC/indicator/CMSC_init.lua"				,devices.CMSC				,{{"PNT-CMSC-CENTER","PNT-CMSC-DOWN","PNT-CMSC-RIGHT"}		,{sx_l = -0.0007}}}
indicators[#indicators + 1] = {"A10Common::ccControlsIndicator_A10"  , LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua",devices.AUTOPILOT}
indicators[#indicators + 1] = {"A10C::ccUHF_Radio",		LockOn_Options.script_path.."UHF_Radio/indicator/preset_channel_init.lua", devices.UHF_RADIO, 		 {{"PTR-ANARC164-CHANNEL-WINDOW-CENTER", "PTR-ANARC164-CHANNEL-WINDOW-DOWN", "PTR-ANARC164-CHANNEL-WINDOW-RIGHT"}, {sx_l = -0.001, sy_l = 0.0035, sz_l = 0.0005}}}
indicators[#indicators + 1] = {"A10C::ccUHF_Radio",		LockOn_Options.script_path.."UHF_Radio/indicator/freq_status_init.lua", devices.UHF_RADIO, 		 	 {{"PTR-ANARC164-STATUS-WINDOW-CENTER", "PTR-ANARC164-STATUS-WINDOW-DOWN", "PTR-ANARC164-STATUS-WINDOW-RIGHT"}, {sx_l = -0.001, sy_l = 0.0033, sz_l = -0.001}}}
indicators[#indicators + 1] = {"A10C::ccUHF_Radio",		LockOn_Options.script_path.."UHF_Radio/indicator/repeater_init.lua", 	devices.UHF_RADIO, 		 	 {{"PNT-UHF-CENTER", "PNT-UHF-DOWN", "PNT-UHF-RIGHT"}, {sx_l = -0.0005, sy_l = 0.0, sz_l = 0.0}}}
indicators[#indicators + 1] = {"A10C::ccUHF_Radio",		LockOn_Options.script_path.."UHF_Radio/indicator/channel_map_init.lua", devices.UHF_RADIO, 		 	 {{"PTR-ANARC164-CHANNEL-MAP-SHEET-CENTER", "PTR-ANARC164-CHANNEL-MAP-SHEET-DOWN", "PTR-ANARC164-CHANNEL-MAP-SHEET-RIGHT"}, {sx_l = -0.001, sy_l = -0.001, sz_l = 0.002}}}

indicators[#indicators + 1] = {"A10C::ccMFCD_Bake"}
indicators[#indicators + 1] = {"A10C::ccMFCD_Display",LockOn_Options.script_path.."MFCD/indicator/BAKE/left.lua",devices.MFCD_LEFT,{{"PNT-MFCD-L-CENTER","PNT-MFCD-L-DOWN","PNT-MFCD-L-RIGHT"}}}
indicators[#indicators + 1] = {"A10C::ccMFCD_Display",LockOn_Options.script_path.."MFCD/indicator/BAKE/right.lua",devices.MFCD_RIGHT,{{"PNT-MFCD-R-CENTER","PNT-MFCD-R-DOWN","PNT-MFCD-R-RIGHT"}}}

indicators[#indicators + 1] = {"A10C_2::ccScorpionHMCS", LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_init.lua",devices.SCORPION_HMCS, {{},{}}}
indicators[#indicators + 1] = {"A10C_2::ccARC_210", 	LockOn_Options.script_path	.."ARC_210/indicator/ARC_210_init.lua"	,devices.VHF_AM_RADIO, {{"VHFUHF-CENTER","VHFUHF-DOWN","VHFUHF-RIGHT"},{sx_l = -0.001, sw = -0.004}}}

if LockOn_Options.flight.padlock then
	indicators[#indicators + 1] = {"ccPadlock", LockOn_Options.common_script_path.."PADLOCK/PADLOCK_indicator.lua",devices.PADLOCK,{{},{sx_l = 1.0,sw = 0.1,sh = 0.1}}}
end

creators[devices.MACROS]    =  {"avAutostartDevice",LockOn_Options.common_script_path.."Macro_handler.lua"}

---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------

