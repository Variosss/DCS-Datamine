

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."config.lua")

mount_vfs_model_path(LockOn_Options.script_path.."../Shape")
mount_vfs_texture_archives(LockOn_Options.script_path.."../Textures/Cockpit-Ka-50_2_Textures")

--	items in <...> are optional
--
-- MainPanel = {"NAME_OF_CLASS",
--				"INIT_SCRIPT_FILE",
--				<{{"varname1", devices.LINKED_DEVICE1}, {"varname2", devices.LINKED_DEVICE2}, ...},>
--			   }

MainPanel = {"Ka50::ccMainPanel", 
			 LockOn_Options.script_path.."mainpanel_init.lua",
			 {{"sys_controller", devices.SYST_CONTROLLER},
			  {"hud", devices.HUD},
			  {"ki_13", devices.KI_13}, 
			  {"clock", devices.CLOCK},
			  {"HSI", devices.HSI},
			  {"ADI", devices.ADI},
			  {"pvi", devices.PVI},
			  {"uv26", devices.UV_26},
			  {"cpt_mech", devices.CPT_MECH},
			  {"LaserWarningSystem", devices.LASER_WARNING_SYSTEM},
			  {"radarAltimeter", devices.RADAR_ALTIMETER},
			  {"abris", devices.ABRIS},
			  {"EnginesInterface", devices.ENGINE_INTERFACE},
			  {"nav_interface", devices.NAV_INTERFACE},
			  {"misc_systems", devices.MISC_SYSTEMS_INTERFACE},
			  {"ppr", devices.AUTOPILOT},
			  {"DataLink", devices.DATALINK},
			  {"r_800", devices.R_800},
			  {"r_828", devices.R_828},
			  {"weap_interface", devices.WEAP_INTERFACE},
			  {"hydro_interface", devices.HYDRO_SYS_INTERFACE},
			  {"fuel_interface", devices.FUELSYS_INTERFACE},
			  {"illumination_interface", devices.ILLUMINATION_INTERFACE},
			  {"eject_interface", devices.EJECT_SYS_INTERFACE},
			  {"shkval", devices.SHKVAL},
			  {"STBY_ADI", devices.STBY_ADI},
			  {"PShK", devices.PShK_7},
			  {"ZMS", devices.ZMS_3},
			  {"Accelerometer", devices.ACCELEROMETER},
			 },
             LockOn_Options.script_path.."main_panel_commands.lua"
			}
		
function  maintenance_setup_NVG()  
    local  ret_val ={}
           ret_val[1] = {[devices.HELMET] =  {"Ka50::avOVN_1","",{},LockOn_Options.script_path.."HELMET/HELMET_commands.lua"},}--devices
           ret_val[2] = {}--indicators
	return ret_val
end

function maintenance_setup_HMS()
    local  ret_val ={}
           ret_val[1] = {[devices.HELMET] = {
                               "Ka50::avHelmet_3UM","",
							   {{"slaved_platform", devices.SHKVAL},{"weap_interface", devices.WEAP_INTERFACE}},
                               LockOn_Options.script_path.."HELMET/HELMET_commands.lua"}
                        }--devices
           ret_val[2] = {{"Ka50::ccHelmet_3UM",
                           LockOn_Options.script_path.."HELMET/Helmet.lua",
                           devices.HELMET,{{},{sw = 0.2,sh = 0.2}}}
                        }--indicators
	return ret_val
end

-- Avionics devices initialization example
--	items in <...> are optional
--
-- creators[DEVICE_ID] = {"NAME_OF_CONTROLLER_CLASS",
--						  <"CONTROLLER_SCRIPT_FILE",>
--						  <{{"varname1", devices.LINKED_DEVICE1}, {"varname2", devices.LINKED_DEVICE2}, ...},>
--						  <"INPUT_COMMANDS_SCRIPT_FILE",>
--						  <{{"NAME_OF_INDICATOR_CLASS", "INDICATOR_SCRIPT_FILE"}, ...}>
--						 }

creators   = {}
indicators = {}

function add_devs(tab_of_devs_and_indicators)
    local devs = tab_of_devs_and_indicators[1]
    for i,o in pairs(devs) do
        creators[i]  = o
    end
end

function add_inds(tab_of_devs_and_indicators)
    local inds = tab_of_devs_and_indicators[2]
    
    for i=1,#inds do
        indicators[#indicators + 1] = inds[i]
    end
end

creators[devices.DBG_OUTPUT] = {"Ka50::avDbg_output",
							"",
							{{"ikv", devices.C061K},
							 {"nav_interface", devices.NAV_INTERFACE},
							 {"diss", devices.DISS_32_28},
							 {"weap_interface", devices.WEAP_INTERFACE},
							 {"datalink", devices.DATALINK},
							 {"spu", devices.SPU_9},
							 {"r800", devices.R_800},
							 {"r828", devices.R_828},
							 {"ark", devices.ARK_22}},
							""}

creators[devices.HUD]    = {"Ka50::avHUD",
							LockOn_Options.script_path.."Devices_specs/HUD.lua",
							{{"ikv", devices.C061K},
                             {"nav_interface", devices.NAV_INTERFACE},
							 {"diss", devices.DISS_32_28},
                             {"weap_interface", devices.WEAP_INTERFACE},
							 {"shkval_v", devices.SHKVAL},
							 {"radarAltimeter", devices.RADAR_ALTIMETER},
							 {"limiters", devices.LIMITERS},
							 {"blinkTimer", devices.BLINK_TIMER},
                             {"autopilot", devices.AUTOPILOT},
                             {"datalink", devices.DATALINK},
                             {"LaserRanger", devices.LASERRANGER},
							 {"CptElectricInterface", devices.ELEC_INTERFACE},
							 },
							LockOn_Options.script_path.."HUD/HUD_commands.lua"}

creators[devices.SHKVAL] = {"Ka50::avSHKVAL_V",
							LockOn_Options.script_path.."Devices_specs/SHKVAL_V.lua",
							{{"ikv", devices.C061K},
							 {"laser_ranger", devices.LASERRANGER}, 
							 {"radarAltimeter", devices.RADAR_ALTIMETER},
							 {"nav_interface", devices.NAV_INTERFACE}, 
							 {"limiters", devices.LIMITERS},
							 {"weap_interface", devices.WEAP_INTERFACE},
                             {"arcade", devices.ARCADE, isSoft = true}},
							LockOn_Options.script_path.."SHKVAL/SHKVAL_commands.lua"}

creators[devices.ABRIS]  = {"Ka50::avABRIS",
							LockOn_Options.script_path.."Devices_specs/ABRIS.lua",
							{{"ikv", devices.C061K},
							 {"k041", devices.K041},
							 {"diss", devices.DISS_32_28},
							 {"datalink", devices.DATALINK},
							 {"ark" , devices.ARK_22},
							 {"ralt", devices.RADAR_ALTIMETER},
							 --{"r800", devices.R_800}, --dbg
							 {"emd", devices.ID_6},
							 {"CptElectricInterface", devices.ELEC_INTERFACE}
							 --,devices.SHKVAL
							},
							LockOn_Options.script_path.."ABRIS/ABRIS_global_commands.lua"}

creators[devices.EKRAN_32_03] = {"Ka50::avEkran_32_03",
							LockOn_Options.script_path.."EKRAN/Device/EKRAN_32_03.lua",
							{{"system_controller", devices.SYST_CONTROLLER},
							 {"cptMech", devices.CPT_MECH},
							 {"vms", devices.VMS}},
							""}

creators[devices.LASERRANGER] = {"Ka50::avLaserRanger",
								 LockOn_Options.script_path.."Devices_specs/LaserRanger.lua",
								 {{"weap_interface", devices.WEAP_INTERFACE},},
								 LockOn_Options.script_path.."LaserRanger_commands.lua"
								}

creators[devices.WEAP_INTERFACE] = {"Ka50::avWeapInterface_Ka50",
								   LockOn_Options.script_path.."Devices_specs/WeaponSystem.lua",
								  {{"CVM_N", devices.CVM_N},
                                   {"CVM_B", devices.CVM_B},
								   {"nav_interface", devices.NAV_INTERFACE},
								   {"Padlock", devices.PADLOCK, isSoft = true},
								   {"system_controller", devices.SYST_CONTROLLER}},
								  LockOn_Options.script_path.."Weap_syst_commands.lua"
								 }

creators[devices.VMS] = {"Ka50::avVMS_ALMAZ_UP_48",
						 LockOn_Options.script_path.."Devices_specs/ALMAZ_UP_48.lua",
						 {{"system_controller", devices.SYST_CONTROLLER},
						  {"ekran", devices.EKRAN_32_03},
						  {"spu_9", devices.SPU_9},
						  {"CptElectricInterface", devices.ELEC_INTERFACE},
						 },
						 LockOn_Options.script_path.."VMS_commands.lua"
						}

creators[devices.SYST_CONTROLLER] = {"Ka50::avSystemController_Ka50",
									 "",
									 {{"ekran", devices.EKRAN_32_03},
									  {"blinkTimer", devices.BLINK_TIMER},
									  {"nav_interface", devices.NAV_INTERFACE},
									  {"weap_interface", devices.WEAP_INTERFACE},
									  {"limiters", devices.LIMITERS},
									  {"hud", devices.HUD},
									  {"autopilot", devices.AUTOPILOT},
									  {"datalink", devices.DATALINK},
                                      {"I_251V", devices.SHKVAL},
									  {"ikv", devices.C061K},
                                      {"L140", devices.LASER_WARNING_SYSTEM},
                                      {"VMS", devices.VMS},
                                      {"RadarAltimeter", devices.RADAR_ALTIMETER},
                                      {"DNS", devices.DISS_32_28},
                                      {"UV_26", devices.UV_26},
                                      {"FuelInterface", devices.FUELSYS_INTERFACE},
                                      {"GunTurret", devices.GUN},
                                      {"EngineInterface", devices.ENGINE_INTERFACE},
									  {"cptMech", devices.CPT_MECH}},
									 LockOn_Options.script_path.."SystControl_commands.lua"
									}

creators[devices.C061K]	 = {"Ka50::avC061K",
							LockOn_Options.script_path .. "C061K/Device/C061K.lua",
							{},
							LockOn_Options.script_path .. "C061K/Device/C061K_commands.lua",
							
						   }

creators[devices.DISS_32_28] = {"Ka50::avDISS_32_28",
								LockOn_Options.script_path.."Devices_specs/DISS_32_28.lua",
								{{"ikv", devices.C061K}}
						       }

creators[devices.KI_13] = {"Ka50::avKI_13",
							LockOn_Options.script_path.."Devices_specs/KI_13.lua"
						  }

creators[devices.ID_6]  = {"Ka50::avID_6",
						   LockOn_Options.script_path.."Devices_specs/ID_6.lua",
						   {}
						  }


creators[devices.PVI]   = {"Ka50::avPVI",
						   "",
						   {{"pNavInterface", devices.NAV_INTERFACE},
						    {"pAutopilot", devices.AUTOPILOT},
						    {"pIKV", devices.C061K},
						    {"pI_251V", devices.SHKVAL},
							{"pLaserRanger", devices.LASERRANGER},
							{"blinkTimer", devices.BLINK_TIMER}},
						   LockOn_Options.script_path.."PVI/PVI_commands.lua"}

creators[devices.PUI_800] = {"Ka50::avPUI_800",
							 "",
							 {{"weap_interface", devices.WEAP_INTERFACE}},
							 ""}

creators[devices.UV_26]	= {"Ka50::avUV_26_Ka50",
						   LockOn_Options.script_path.."Devices_specs/UV_26.lua",
						   {},
						   LockOn_Options.script_path.."UV_26/UV_26_commands.lua"}

creators[devices.AVIONICS_PROXY] = {"Ka50::avAvionicsDataProxyKa50","",{}}						   
						  
if LockOn_Options.flight.padlock then
	creators[devices.PADLOCK]  = {"avPadlock",LockOn_Options.common_script_path.."PADLOCK/PADLOCK_device.lua"}
end

local function use_NVG() 
	local is_night = LockOn_Options.time.hours <= 7 or LockOn_Options.time.hours >= 20
	return is_night or  LockOn_Options.cockpit.use_nightvision_googles
end
                             
if 	use_NVG() then
	add_devs(maintenance_setup_NVG())
else
	add_devs(maintenance_setup_HMS())
end

creators[devices.DATALINK]= {"Ka50::avDatalink_Ka50",
						LockOn_Options.script_path.."Devices_specs/Datalink.lua",
						{{"I_251V", devices.SHKVAL},
						 {"laser_ranger", devices.LASERRANGER},
						 {"nav_interface", devices.NAV_INTERFACE},
						 {"ikv", devices.C061K},
						 {"blinkTimer", devices.BLINK_TIMER},
						 {"pvi", devices.PVI},
						 {"r_800", devices.R_800}},
						LockOn_Options.script_path.."Datalink/Datalink_commands.lua"
					   }

creators[devices.NAV_INTERFACE]	= {"Ka50::avNavInterface_Ka50",
								   LockOn_Options.script_path.."Devices_specs/NavInterace.lua",
								   {{"CVM_N", devices.CVM_N},
								    {"CVM_B", devices.CVM_B},
								    {"pvi", devices.PVI},
								    {"autopilot", devices.AUTOPILOT},
                                    {"rad_altimeter", devices.RADAR_ALTIMETER}},
								   LockOn_Options.script_path.."Nav_sys_commands.lua"
								  }

CVM_Links = {{"ikv", devices.C061K},
			 {"diss", devices.DISS_32_28},
			 {"p_ins", devices.INS_KA50},
			 {"p_ins_embedded", devices.INS_EMBEDDED_KA50},
			 {"range_finder_designator", devices.LASERRANGER},
			 {"I_251V", devices.SHKVAL},
			 {"helmet", devices.HELMET},
			 {"pvi", devices.PVI},
			 {"nav_interface", devices.NAV_INTERFACE},
			 {"autopilot", devices.AUTOPILOT},
             {"datalink", devices.DATALINK},
             {"arcade", devices.ARCADE, isSoft = true},
             {"gun_turret", devices.GUN},
             {"UPP_800_turret", devices.MISSILE_TURRET},
			 {"CptElectricInterface", devices.ELEC_INTERFACE},
			 {"weap_interface", devices.WEAP_INTERFACE},
			 {"memory", devices.CVM_MEMORY},
			 {"ZMS", devices.ZMS_3},
			 {"ki_13", devices.KI_13}, 
			}

creators[devices.CVM_N]			= {"Ka50::avCVM_N",
								   LockOn_Options.script_path.."CVM_N/Device/CVM_N.lua",
								   CVM_Links
								  }

creators[devices.CVM_B]			= {"Ka50::avCVM_B",
								   LockOn_Options.script_path.."CVM_B/Device/CVM_B.lua",
								   CVM_Links
								  }
								  
creators[devices.INS_KA50]		= {"Ka50::avINS_KA50",
								   {}
								  }								  
	
creators[devices.INS_EMBEDDED_KA50]	= {"Ka50::avINS_Embedded_KA50",
								   {}
								  }									  
								  								  

creators[devices.CLOCK]			= {"avAChS_1",
								   "",
								   {},
								   LockOn_Options.script_path.."clock_commands.lua"
								  }

creators[devices.HSI]			= {"Ka50::avPNP_72_16",
								   LockOn_Options.script_path.."HSI/Device/HSI.lua",
								   {{"pIKV", devices.C061K},
								    {"pNavInterface", devices.NAV_INTERFACE},
									{"pR800", devices.R_800},
								    {"pADF", devices.ARK_22},
								    {"pAutopilot", devices.AUTOPILOT}},
								   LockOn_Options.script_path.."HSI/Device/HSI_commands.lua"
								  }

creators[devices.ADI]			= {"Ka50::avIKP_81",
								   LockOn_Options.script_path.."ADI/Device/ADI.lua",
								   {{"ikv", devices.C061K},
								    {"nav_interface", devices.NAV_INTERFACE}},
								   LockOn_Options.script_path.."ADI/Device/ADI_commands.lua"
								  }

creators[devices.PPK]			= {"Ka50::avPPK",
								   "",
								   {}
								  }

creators[devices.AUTOPILOT]		= {"Ka50::avAutopilot_Ka50",
								   "",
								   {{"pvi", devices.PVI},
								    {"nav_interface", devices.NAV_INTERFACE},
								    {"blinkTimer", devices.BLINK_TIMER},
								    {"ikv", devices.C061K},
								    {"diss", devices.DISS_32_28},
                                    {"I_251V", devices.SHKVAL},
									{"RadarAltimeter", devices.RADAR_ALTIMETER},
									},
								    LockOn_Options.script_path.."AUTOPILOT_commands.lua"}

creators[devices.ELEC_INTERFACE] = {"Ka50::avElectricInterface_Ka50",
									"",
									{},
									LockOn_Options.script_path.."Elec_commands.lua"
								   }

creators[devices.CPT_MECH]		= {"Ka50::avCockpitMechanics_Ka50",
								   LockOn_Options.script_path .. "CPT_MECH/cpt_mech.lua",
								   {{"sys_controller", devices.SYST_CONTROLLER},
                                    {"ekran", devices.EKRAN_32_03},
                                    {"autopilot", devices.AUTOPILOT},
                                    {"weap_interface", devices.WEAP_INTERFACE},
									{"CptElectricInterface", devices.ELEC_INTERFACE},
								   },
								   LockOn_Options.script_path .. "CPT_MECH/cpt_mech_commands.lua"
								  }
									
creators[devices.GUN]	    	= {"Ka50::avGunTurret",
								   LockOn_Options.script_path.."Devices_specs/GunTurret.lua",
								   {{"weap_interface", devices.WEAP_INTERFACE},
								    {"tv_sensor", devices.SHKVAL}}
								  }

creators[devices.MISSILE_TURRET] = {"Ka50::avMissileTurret",
								    LockOn_Options.script_path.."Devices_specs/MissileTurret.lua",
								 	{{"weap_interface", devices.WEAP_INTERFACE},
								 	 {"tv_sensor", devices.SHKVAL}}
								   }

creators[devices.FUELSYS_INTERFACE]	= {"Ka50::avFuelSysInterface_Ka50",
									   LockOn_Options.script_path.."Devices_specs/FuelSys.lua",
									   {{"system_controller", devices.SYST_CONTROLLER},
									    {"weap_interface", devices.WEAP_INTERFACE},
									   },
									   LockOn_Options.script_path.."fuel_system_commands.lua"
									  }

creators[devices.ENGINE_INTERFACE] = {"Ka50::avEnginesInterface_Ka50",
									  LockOn_Options.script_path .. "ENGINE_INTERFACE/EnginesIndicators.lua",
									  {{"cptMech", devices.CPT_MECH},
									   {"system_controller", devices.SYST_CONTROLLER},
									   {"CptElectricInterface", devices.ELEC_INTERFACE}},
									  LockOn_Options.script_path .. "ENGINE_INTERFACE/Engine_commands.lua"
									 }

creators[devices.HYDRO_SYS_INTERFACE] =	{"Ka50::avHydroInterface_Ka50",
										 LockOn_Options.script_path.."Devices_specs/HydroSystem.lua",
										 {{"cptMech", devices.CPT_MECH},
										 },
										 LockOn_Options.script_path.."Hydro_system_commands.lua"
										}

creators[devices.EJECT_SYS_INTERFACE] =	{"Ka50::avEjectSysInterface_Ka50",
										 "",
										 {},
										 LockOn_Options.script_path.."eject_system_commands.lua"
										}

creators[devices.LASER_WARNING_SYSTEM] = {"Ka50::avLWS_Ka50",
										  "",
								 		  {},
								 		 LockOn_Options.script_path.."LWS/LaserWarningSys_commands.lua"
										 }

creators[devices.RADAR_ALTIMETER]	   = {"Ka50::avA_036",
										  LockOn_Options.script_path.."Devices_specs/RadarAltimeter.lua",
								 		  {},
										  LockOn_Options.script_path.."A036_commands.lua"
										 }

creators[devices.BLINK_TIMER]		   = {"Ka50::avBlinkTimer",
										  "",
								 		  {}
										 }

creators[devices.FIRE_EXTING_INTERFACE] = {"Ka50::avFireExtinguishersInterface_Ka50",
										   "",
								 		   {{"system_controller", devices.SYST_CONTROLLER}},
								 		   LockOn_Options.script_path.."FireExtinguishersInterface_commands.lua"
										  }

creators[devices.MISC_SYSTEMS_INTERFACE] = {"Ka50::avMiscSystemsInterface_Ka50",
										    LockOn_Options.script_path.."Devices_specs/MiscSystems.lua",
								 		    {{"hud", devices.HUD},
								 		     {"shkval", devices.SHKVAL}},
                                            LockOn_Options.script_path.."MiscSystems_commands.lua"
										   }

creators[devices.IFF]					= {"Ka50::avIzd_620",
										   "",
								 		   {},
										   LockOn_Options.script_path.."IFF_commands.lua"
										  }

creators[devices.LIMITERS]				= {"Ka50::avLimiters_Ka50",
										   "",
								 		   {{"radarAltimeter", devices.RADAR_ALTIMETER},
                                            {"nav_interface", devices.NAV_INTERFACE},
                                           }
										  }

creators[devices.SPOTLIGHT_SYSTEM]	   = {"Ka50::avFPP_7M_Spot",
										  LockOn_Options.script_path.."Devices_specs/FPP_7M.lua",
								 		  {},
										  LockOn_Options.script_path.."FPP_7M_commands.lua"
										 }

creators[devices.NAVLIGHT_SYSTEM]	   =  {"Ka50::avNavLightsSystem",
										   LockOn_Options.script_path.."Devices_specs/NavLightsSystem.lua",
								 		   {},
								 		   LockOn_Options.script_path.."NavLightsSystem_commands.lua"
								 		  }

creators[devices.ARK_22]	   			   = {"Ka50::avARK_22",
											  LockOn_Options.script_path.."Devices_specs/ARK.lua",
											  {{"mrp", devices.MRP, isSoft = true}},
											  LockOn_Options.script_path.."ADF_commands.lua"}

local enable_MRP = false
if enable_MRP then
	creators[devices.MRP]	   			   =  {"Ka50::avMRP",
										       LockOn_Options.script_path.."Devices_specs/MRP.lua",
									 		   {},
									 		   ""
									 		  }
end

creators[devices.R_800]	   			   =  {"Ka50::avR_800",
									      LockOn_Options.script_path.."Devices_specs/R_800.lua",
										  {{"HSI", devices.HSI}},
										  LockOn_Options.script_path.."R_800_commands.lua"}

creators[devices.R_828]	   			   =  {"Ka50::avR_828_Ka50",
									      LockOn_Options.script_path.."Devices_specs/R_828.lua",
								 		  {},
										  LockOn_Options.script_path.."R_828_commands.lua"}

creators[devices.SPU_9]	   			   =  {"Ka50::avSPU_9",
										  LockOn_Options.script_path.."Devices_specs/SPU_9.lua",
								 		  {{"r800", devices.R_800},
								 		   {"r828", devices.R_828},
								 		   {"ark", devices.ARK_22},
								 		   {"mrp", devices.MRP, isSoft = true},
										   {"vms", devices.VMS},
								 		   {"system_controller", devices.SYST_CONTROLLER},
								 		   {"RadarAltimeter", devices.RADAR_ALTIMETER},
										   {"CptElectricInterface", devices.ELEC_INTERFACE},
										  },
										  LockOn_Options.script_path.."SPU_9_commands.lua"}

creators[devices.ILLUMINATION_INTERFACE] = {"Ka50::avIlluminationInterface_Ka50",
										  LockOn_Options.script_path.."Devices_specs/IlluminationInterface.lua",
								 		  {},
										  LockOn_Options.script_path.."Illumination_interface_commands.lua"}
                                  
creators[devices.SIGNAL_FLARE_DISPENSER] = {"Ka50::avSignalFlareDispenser",
										  LockOn_Options.script_path.."Devices_specs/SignalFlareDispenser.lua",
								 		  {},
										  LockOn_Options.script_path.."SignalFlareDispenser_commands.lua"}

if LockOn_Options.flight.radio_assist then
	creators[devices.MLWS]                   = {"avMLWS",
												LockOn_Options.script_path.."Devices_specs/MLWS.lua",
												{{"betty", devices.VMS}}}
end                                            

creators[devices.STBY_ADI]		= {"Ka50::avAGR_81",
								   LockOn_Options.script_path .. "STBY_ADI/Device/STBY_ADI_Prop.lua",
								   {},
								   LockOn_Options.script_path.."ADI/Device/ADI_commands.lua"
								  }

--[[
creators[devices.X52Pro] =          {"avLuaDevice",
                                     LockOn_Options.script_path.."x52pro_device.lua",
                                     {},"",{}}

--]]

creators[devices.PShK_7]		= {"Ka50::avPShK_7",
								   LockOn_Options.script_path .. "PShK/Device/PShK.lua",
								   {},
								   ""
								  }

creators[devices.ZMS_3]			= {"Ka50::avZMS_3",
								   LockOn_Options.script_path .. "ZMS/Device/ZMS.lua",
								   {},
								   LockOn_Options.script_path .. "ZMS/Device/ZMS_commands.lua"
								  }

creators[devices.K041]		=	{"Ka50::avK041",
								 LockOn_Options.script_path .. "Devices_specs/K041.lua",
								 {{"hud", devices.HUD},
								  {"ikv", devices.C061K},
								  {"diss", devices.DISS_32_28},
								  {"emd", devices.ID_6},
								  {"pvi", devices.PVI},
								  {"pui", devices.PUI_800},
								  {"datalink", devices.DATALINK},
								  {"autopilot", devices.AUTOPILOT},
								  {"CVM_N", devices.CVM_N},
								  {"CVM_B", devices.CVM_B},
								  {"HSI", devices.HSI},
								  {"ADI", devices.ADI},
								  {"LaserWarningSystem", devices.LASER_WARNING_SYSTEM},
								  {"radarAltimeter", devices.RADAR_ALTIMETER},
								  {"I_251V", devices.SHKVAL},
								  {"ark", devices.ARK_22},
								  {"mrp", devices.MRP, isSoft = true},
								  {"NavInterface", devices.NAV_INTERFACE},
								  {"PShK_7", devices.PShK_7},
								  {"ZMS_3", devices.ZMS_3},
								  {"weap_interface", devices.WEAP_INTERFACE},
								 },
								  LockOn_Options.script_path.."K041_commands.lua"
								}
creators[devices.ACCELEROMETER]  =  {"Ka50::avAccelerometer",
                                LockOn_Options.script_path.."Devices_specs/Accelerometer.lua",
                                {},
                                "",
                                }
								
creators[devices.CVM_MEMORY] 	= {"Ka50::avCVM_Memory",
								   LockOn_Options.script_path.."CVM_Memory/Device/CVM_Memory.lua",
								   {{"CptElectricInterface", devices.ELEC_INTERFACE}}
								  }

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
creators[devices.MACROS]    =  {"avLuaDevice",
                                LockOn_Options.common_script_path.."Macro_handler.lua",
                                {},
                                "",
                                }

tv_map_render_id ={1, 2, 3, 4};

indicators[#indicators + 1] = {"Ka50::ccDbg_output"         , LockOn_Options.script_path.."DBG/DBG_init.lua"                       ,devices.DBG_OUTPUT      ,{{"HUD-CENTER", "HUD-DOWN", "HUD-RIGHT"}}}
indicators[#indicators + 1] = {"Ka50::ccHUD"                , LockOn_Options.script_path.."HUD/HUD_init.lua"                       ,devices.HUD             ,{{"HUD-CENTER", "HUD-DOWN", "HUD-RIGHT"},{sy_l = 0.0499138832}}}
indicators[#indicators + 1] = {"Ka50::ccSHKVAL_V"           , LockOn_Options.script_path.."SHKVAL/SHKVAL_init.lua"                 ,devices.SHKVAL          ,{{"SHKVAL-CENTER", "SHKVAL-DOWN", "SHKVAL-RIGHT"},{},tv_map_render_id[1]}}
indicators[#indicators + 1] = {"Ka50::ccABRIS"              , LockOn_Options.script_path.."ABRIS/ABRIS_init.lua"                   ,devices.ABRIS           ,{{"ABRIS-CENTER", "ABRIS-DOWN", "ABRIS-RIGHT"},{},tv_map_render_id[2]}}
indicators[#indicators + 1] = {"ccEkranIndicator"     		, LockOn_Options.script_path.."EKRAN/Indicator/EKRAN_init.lua"         ,devices.EKRAN_32_03     ,{{"EKRAN-CENTER", "EKRAN-DOWN", "EKRAN-RIGHT"},{sz_l = -0.0017,sy_l = -0.0005}}}
indicators[#indicators + 1] = {"Ka50::ccPVI"                , LockOn_Options.script_path.."PVI/PVI_init.lua"                       ,devices.PVI             ,{{"PVI-CENTER", "PVI-DOWN", "PVI-RIGHT"}}}

indicators[#indicators + 1] = {"Ka50::ccPUI_800"            , LockOn_Options.script_path.."PUI_800/PUI_800_init.lua"               ,devices.PUI_800         ,{{"PUI-CENTER", "PUI-DOWN", "PUI-RIGHT"},{sx_l = -0.002}}}
indicators[#indicators + 1] = {"ccUV_26"              		, LockOn_Options.script_path.."UV_26/UV_26_init.lua"                   ,devices.UV_26           ,{{"UV-26-CENTER", "UV-26-DOWN", "UV-26-RIGHT"}}}
indicators[#indicators + 1] = {"Ka50::ccControlsIndicator"  , LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua",devices.AUTOPILOT}
indicators[#indicators + 1] = {"Ka50::ccARK"                , LockOn_Options.script_path.."ARK/ARK_init.lua"                       ,devices.ARK_22          ,{{"ARK-PANEL-CENTER", "ARK-PANEL-BOTTOM", "ARK-PANEL-RIGHT"},{ry_l = -0.05}}}
if LockOn_Options.flight.padlock then              
	indicators[#indicators + 1] = {"ccPadlock"              , LockOn_Options.common_script_path.."PADLOCK/PADLOCK_indicator.lua"   ,devices.PADLOCK}
end     
                
if 	use_NVG() then
	add_inds(maintenance_setup_NVG())
else
	add_inds(maintenance_setup_HMS())
end

indicators[#indicators + 1] = {"ccIndicator",LockOn_Options.script_path.."Caution_lights_indicator/CautionLights_panel.lua",nil,{{},{sx_l = 1,sw = 1,sh = 1}}}


indicators[#indicators + 1] = {"Ka50::ccABRIS_Bake" ,LockOn_Options.script_path.."ABRIS/BAKE/init.lua",devices.ABRIS,{{"ABRIS-CENTER", "ABRIS-DOWN", "ABRIS-RIGHT"}}}
indicators[#indicators + 1] = {"ccIndicator"		,LockOn_Options.script_path.."SHKVAL/BAKE/init.lua"}

---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------