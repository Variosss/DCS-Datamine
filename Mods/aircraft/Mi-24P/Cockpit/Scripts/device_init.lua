mount_vfs_model_path(LockOn_Options.script_path.."../Shape")
mount_vfs_texture_archives(LockOn_Options.script_path.."../Textures")


dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")

-- modules which implement the cockpit functionality
modules = {"CockpitMi24"}
	
--	items in <...> are optional
--
-- MainPanel = {"NAME_OF_CLASS",
--				"INIT_SCRIPT_FILE",
--				<{{"varname1", devices.LINKED_DEVICE1}, {"varname2", devices.LINKED_DEVICE2}, ...},>
--			   }

MainPanel = {"Mi24::ccMainPanel_Mi24", 
	LockOn_Options.script_path.."mainpanel_init.lua",
	{
		{"cpt_mech", devices.CPT_MECH},
		{"radarAltimeter", devices.RADAR_ALTIMETER},
		{"EnginesInterface", devices.ENGINE_INTERFACE},
		{"misc_systems", devices.MISC_SYSTEMS_INTERFACE},
		{"ppr", devices.AUTOPILOT},
		{"weap_interface", devices.WEAP_SYS},
		{"I9K113", devices.I9K113},
		{"UKT2", devices.UKT_2},
		{"IntLightsSystem", devices.INT_LIGHTS_SYSTEM},
		{"MGV_1", devices.MGV1SU_1},
		{"MGV_2", devices.MGV1SU_2},
		{"GREBEN", devices.GREBEN},
		{"HydroInterface", devices.HYDRO_SYS_INTERFACE},
		{"PKP72M_P", devices.PKP72M_P},
		{"PKP72M_O", devices.PKP72M_O},
		{"CLOCK_P", devices.CLOCK_P},
		{"CLOCK_O", devices.CLOCK_O},
		{"IAS_P", devices.IAS_P},
		{"IAS_O", devices.IAS_O},
		{"VARIOMETER", devices.VARIOMETER},
		{"BAROALT_P", devices.BAROALT_P},
		{"BAROALT_O", devices.BAROALT_O},
		{"RMI2_P", devices.RMI2_P},
		{"RMI2_O", devices.RMI2_O},
		{"ElecInterface", devices.ELEC_INTERFACE},
		{"Autopilot", devices.AUTOPILOT},
		{"FuelInterface", devices.FUELSYS_INTERFACE},
		{"ASP17V", devices.ASP_17V},
		{"spo10_interface", devices.SPO_10},
		{"aso2V_interface", devices.ASO_2V},
		{"DISS_15", devices.DISS_15},
		{"R_863", devices.R_863},
		{"JADRO_1I", devices.JADRO_1I},
		{"EUCALYPT_M24", devices.EUCALYPT_M24},
		{"R_852", devices.R_852},
		{"G_Meter", devices.G_Meter},
		{"IFF",devices.IFF},
		{"Recorder_MC61",devices.Recorder_MC61},
		{"AntiIceSysInterface", devices.ANTI_ICE_INTERFACE},
		{"MAP_DISPLAY", devices.MAP_DISPLAY},
		{"KM_2", devices.KM_2},
		{"HelperAI", devices.HELPER_AI},
		{"Timer", devices.TIMER},
		{"R60_Interface", devices.R60_INTERFACE},
	},
	LockOn_Options.script_path.."main_panel_commands.lua"
}

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

creators[devices.WEAP_SYS] = {"Mi24::avWeaponSys_Mi24",
								   LockOn_Options.script_path.."Devices_specs/WeaponSystem.lua",
								  {{"i9K113", devices.I9K113},
								   {"Asp_17V", devices.ASP_17V},
								   {"ADI", devices.UKT_2},
								   {"IntLightsSystem", devices.INT_LIGHTS_SYSTEM},
								   {"HeadWrapper",devices.HEAD_WRAPPER},
								   {"CrewIndicator", devices.CREW_INDICATOR},
							   	   {"R60_Interface", devices.R60_INTERFACE},
								   },
								  LockOn_Options.script_path.."Weap_syst_commands.lua"
								 }
								 
creators[devices.I9K113] = {"Mi24::av9K113",
							LockOn_Options.script_path.."Devices_specs/9K113.lua",
							{{"weap_interface", devices.WEAP_SYS},
							{"hydro_interface", devices.HYDRO_SYS_INTERFACE},
							{"HeadWrapper",devices.HEAD_WRAPPER},
							{"HelperAI", devices.HELPER_AI}},
							""
							}
							
creators[devices.R60_INTERFACE]= {"Mi24::avR60_Interface",
								"",
								{{"weap_interface", devices.WEAP_SYS}},
								""
								}
							
creators[devices.CREW_INDICATOR] = {"Mi24::avCrewIndicator", nil, {{"WeaponSystem", devices.WEAP_SYS}}}							


creators[devices.DISS_15] = {"Mi24::avDISS_15",
								LockOn_Options.script_path.."Devices_specs/DISS_15.lua",
								{{"MGV_1",devices.MGV1SU_1},
								{"MGV_2",devices.MGV1SU_2},
								{"Greben", devices.GREBEN},},
								""
							}


creators[devices.ASO_2V] = {"Mi24::avASO_2V",
							LockOn_Options.script_path.."ASO_2V/ASO_2V.lua",
							{},
							""
						}


creators[devices.AUTOPILOT]	=	{"Mi24::avAutopilot_Mi24",
									LockOn_Options.script_path.."Devices_specs/autopilot.lua",
									{
										{"MGV_1",devices.MGV1SU_1},
										{"MGV_2",devices.MGV1SU_2},
										{"diss", devices.DISS_15},
										{"RadarAltimeter", devices.RADAR_ALTIMETER},
										{"Greben", devices.GREBEN},
										{"HeadWrapper",devices.HEAD_WRAPPER},
									},
										LockOn_Options.script_path.."Devices_commands/AUTOPILOT_commands.lua"
								}

creators[devices.ELEC_INTERFACE] = {"Mi24::avElectricInterface_Mi24",
									LockOn_Options.script_path.."Devices_specs/ElecGauges.lua",
									{},
								}

creators[devices.CPT_MECH]		= {"Mi24::avCockpitMechanics_Mi24",
									LockOn_Options.script_path .. "CPT_MECH/cpt_mech.lua",
									{ {"autopilot", devices.AUTOPILOT},
									{"weap_interface", devices.WEAP_SYS}},
								}

creators[devices.FUELSYS_INTERFACE]	= {"Mi24::avFuelSysInterface_Mi24",
										LockOn_Options.script_path.."Devices_specs/FuelSys.lua",
										{},
									}

creators[devices.ENGINE_INTERFACE] = {"Mi24::avEnginesInterface_Mi24",
										LockOn_Options.script_path .. "ENGINE_INTERFACE/EnginesIndicators.lua",
										{{"cptMech", devices.CPT_MECH}},
										LockOn_Options.script_path .. "ENGINE_INTERFACE/Engine_commands.lua"
									}

creators[devices.HYDRO_SYS_INTERFACE] =	{"Mi24::avHydroInterface_Mi24",
											LockOn_Options.script_path.."Devices_specs/HydroSystem.lua",
											{{"cptMech", devices.CPT_MECH},},
										}

creators[devices.RADAR_ALTIMETER]	= {"Mi24::avUV_5",
										LockOn_Options.script_path.."Devices_specs/RadarAltimeter.lua",
										{}
									}

creators[devices.FIRE_EXTING_INTERFACE] = {"Mi24::avFireExtinguishersInterface_Mi24",
											"",
											{},
										}

creators[devices.MISC_SYSTEMS_INTERFACE] = {"Mi24::avMiscSystemsInterface_Mi24",
											LockOn_Options.script_path.."Devices_specs/MiscSystems.lua",
											{
												{"RADAR_ALTIMETER", devices.RADAR_ALTIMETER}
											},
											LockOn_Options.script_path.."MiscSystems_commands.lua"
										}

creators[devices.EXT_LIGHTS_SYSTEM]		=  {"Mi24::avExtLightsSystem_Mi24",
											LockOn_Options.script_path.."Devices_specs/ExtLights.lua",
											{},
											""
										}

creators[devices.ASP_17V]  = {"Mi24::avASP_17V",
								LockOn_Options.script_path.."ASP17V/ASP_17V.lua",
								{
									{"RadarAltimeter", devices.RADAR_ALTIMETER},
									{"i9K113", devices.I9K113},
									{"weap_interface", devices.WEAP_SYS}
								}
							}

creators[devices.PKV]  = {"Mi24::avPKV",
							LockOn_Options.script_path.."PKV/PKV.lua",
							{}
						}

creators[devices.UKT_2] = {"Mi24::avUKT2_Mi24",
							LockOn_Options.script_path.."Devices_specs/UKT2.lua",
							{{"MGV1SU2", devices.MGV1SU_2},},
							""
						}

creators[devices.SPUU_52]	= {"Mi24::avSPUU_52_Mi24",
									LockOn_Options.script_path.."Devices_specs/SPUU_52.lua",
									{}
								}

creators[devices.SOUND_SYSTEM]	= {"Mi24::avSoundSystem_Mi24",
									LockOn_Options.script_path.."Devices_specs/SoundSystem.lua",
									{
										{"RADAR_ALTIMETER", devices.RADAR_ALTIMETER},
										{"IntLightsSystem", devices.INT_LIGHTS_SYSTEM},
										{"weap_interface", devices.WEAP_SYS},
										{"spo10_interface", devices.SPO_10},
										{"R60_Interface", devices.R60_INTERFACE},
									}
								}

creators[devices.HEAD_WRAPPER] = {
	"Mi24::avHeadWrapper",
	LockOn_Options.script_path.."Devices_specs/HeadWrapper.lua",
	{
		{"NVG", 		devices.NVG},
		{"weap_sys", 	devices.WEAP_SYS},
	},
	""
}

creators[devices.INT_LIGHTS_SYSTEM] =	{"Mi24::avIntLightsSystem_Mi24",
											LockOn_Options.script_path.."Devices_specs/Int_Lights_System.lua",
											{}
										}

creators[devices.MGV1SU_1] =	{"Mi24::avMGV1SU_Mi24",
									LockOn_Options.script_path.."Devices_specs/MGV1SU_1.lua",
									{
										{"OtherGyro",devices.MGV1SU_2},
									}
								}

creators[devices.MGV1SU_2] =	{"Mi24::avMGV1SU_Mi24",
									LockOn_Options.script_path.."Devices_specs/MGV1SU_2.lua",
									{
										{"OtherGyro",devices.MGV1SU_1},
									}
								}

creators[devices.GREBEN] =	{"Mi24::avGreben1_Mi24",
								LockOn_Options.script_path.."Devices_specs/Greben.lua",
								{
									{"RemoteCompass",devices.ID6},
									{"KM_2",devices.KM_2},
								}
							}

creators[devices.ID6] =	{"Mi24::avID6_Mi24",
							LockOn_Options.script_path.."Devices_specs/ID6.lua",
							{}
						}

creators[devices.HELPER_AI] =	{"Mi24::avHelperAI_Mi24",
									LockOn_Options.script_path.."HelperAI/HelperAI.lua",
									{
										{"HeadWrapper",devices.HEAD_WRAPPER},
										{"Greben",devices.GREBEN},
										{"IAS",devices.IAS_P},
										{"weap_interface", devices.WEAP_SYS},
										{"I9K113",devices.I9K113},
										{"BAROALT_P",devices.BAROALT_P},
										{"ASP17V", devices.ASP_17V},
										{"HydroInterface", devices.HYDRO_SYS_INTERFACE},
										{"Autopilot", devices.AUTOPILOT},
										{"cpt_mech", devices.CPT_MECH},							
										{"aso2V_interface", devices.ASO_2V},
										{"spuu52", devices.SPUU_52},
										{"KM_2", devices.KM_2},
										{"radarAltimeter", devices.RADAR_ALTIMETER},
									}
								}

creators[devices.ECS_INTERFACE]		= {"Mi24::avECSInterface_Mi24",
										LockOn_Options.script_path .. "Devices_specs/ECSystem.lua",
										{},
									}

creators[devices.OXYGEN_INTERFACE]	= {"Mi24::avOxygenInterface_Mi24",
										LockOn_Options.script_path .. "Devices_specs/OxygenSystem.lua",
										{},
									}

creators[devices.PKP72M_P] =	{"Mi24::avPKP72M",
									LockOn_Options.script_path.."Devices_specs/PKP72M.lua",
									{
										{"MGV1SU1", devices.MGV1SU_1},
										{"MGV1SU2", devices.MGV1SU_2},
										{"radarAltimeter", devices.RADAR_ALTIMETER},
									},
								}

creators[devices.PKP72M_O] =	{"Mi24::avPKP72M",
									LockOn_Options.script_path.."Devices_specs/PKP72M.lua",
									{
										{"MGV1SU1", devices.MGV1SU_1},
										{"MGV1SU2", devices.MGV1SU_2},
										{"radarAltimeter", devices.RADAR_ALTIMETER},
									},
								}
	
creators[devices.PKP72M_INTERFACE] =	{"Mi24::avPKP72M_Mi24",
											LockOn_Options.script_path.."Devices_specs/PKP72M.lua",
											{
												{"PKP72M_P", devices.PKP72M_P},
												{"PKP72M_O", devices.PKP72M_O},
												{"UKT2", devices.UKT_2},
											},
										}

creators[devices.CLOCK_P]	= {"Mi24::avClock_Mi24",
								"",
								{},
							}

creators[devices.CLOCK_O]	= {"Mi24::avClock_Mi24",
								"",
								{},
							}

creators[devices.FM_PROXY]	= {"Mi24::avFMProxy_Mi24",
								"",
								{},
							}

creators[devices.IAS_P]	= {"Mi24::avAirspeedIndicator_Pilot_Mi24",
								LockOn_Options.script_path.."Devices_specs/IAS_ind_US450K.lua",
								{{"FM_Proxy", devices.FM_PROXY}},
							}
	
creators[devices.IAS_O]	= {"Mi24::avAirspeedIndicator_Operator_Mi24",
								LockOn_Options.script_path.."Devices_specs/IAS_ind_US450K.lua",
								{{"FM_Proxy", devices.FM_PROXY}},
							}

creators[devices.VARIOMETER] = {"Mi24::avVariometer_Mi24",
									LockOn_Options.script_path.."Devices_specs/Variometer.lua",
									{{"FM_Proxy", devices.FM_PROXY}},
								}

creators[devices.BAROALT_P] = {"Mi24::avBarometricAltimeterPilot_Mi24",
								LockOn_Options.script_path.."Devices_specs/Bar_Alt_VD10VK.lua",
								{{"FM_Proxy", devices.FM_PROXY}},
							}

creators[devices.BAROALT_O] = {"Mi24::avBarometricAltimeterOperator_Mi24",
								LockOn_Options.script_path.."Devices_specs/Bar_Alt_VD10VK.lua",
								{{"FM_Proxy", devices.FM_PROXY},},
							}

creators[devices.RMI2_P] = {"Mi24::avRMI2_Mi24",
							LockOn_Options.script_path.."Devices_specs/RMI2.lua",
							{
								{"Greben1", devices.GREBEN},
								{"ARC_15", devices.ARC_15},
								{"ARC_U2", devices.ARC_U2},
							},
						}

creators[devices.RMI2_O] = {"Mi24::avRMI2_Mi24",
								LockOn_Options.script_path.."Devices_specs/RMI2.lua",
								{
									{"Greben1", devices.GREBEN},
									{"ARC_15", devices.ARC_15},
									{"ARC_U2", devices.ARC_U2},
								},
							}

creators[devices.MAP_DISPLAY] = {"Mi24::avMapDisplay_Mi24",
									LockOn_Options.script_path.."MapDisplay/MapDisplay_devconfig.lua",
									{
										{"greben", devices.GREBEN},
										{"diss", devices.DISS_15},
										{"IntLightsSystem", devices.INT_LIGHTS_SYSTEM},
									},
								}

creators[devices.ARC_15]	=  {
									"Mi24::avARC_15_Mi24",
									LockOn_Options.script_path.."Devices_specs/Radio/ARC_15.lua",
									{},
								}

creators[devices.ARC_15_PANEL_P]	=  {
											"Mi24::avARC_15_Panel_Mi24",
											LockOn_Options.script_path.."Devices_specs/Radio/ARC_15_Panel_P.lua",
											{
												{"ARC_15", devices.ARC_15},
											},
										}

creators[devices.ARC_15_PANEL_O]	=  {
											"Mi24::avARC_15_Panel_Mi24",
											LockOn_Options.script_path.."Devices_specs/Radio/ARC_15_Panel_O.lua",
											{
												{"ARC_15", devices.ARC_15},
											},
										}

creators[devices.ARC_U2]	=  {
									"Mi24::avARC_U2_Mi24",
									LockOn_Options.script_path.."Devices_specs/Radio/ARC_U2.lua",
									{},
								}

creators[devices.R_863]	=  {
								"Mi24::avR_863_Mi24",
								LockOn_Options.script_path.."Devices_specs/Radio/R_863.lua",
								{},
								LockOn_Options.script_path.."Devices_specs/Radio/Radio_commands.lua"
							}

creators[devices.JADRO_1I]	=  {
									"Mi24::avJadro_1I_Mi24",
									LockOn_Options.script_path.."Devices_specs/Radio/Jadro_1I.lua",
									{},
									LockOn_Options.script_path.."Devices_specs/Radio/Radio_commands.lua"
								}

creators[devices.EUCALYPT_M24]	=  {
										"Mi24::avEucalypt_Mi24",
										LockOn_Options.script_path.."Devices_specs/Radio/Eucalypt.lua",
										{},
										LockOn_Options.script_path.."Devices_specs/Radio/Radio_commands.lua"
									}

creators[devices.R_852]	=  {
								"Mi24::avR_852_Mi24",
								LockOn_Options.script_path.."Devices_specs/Radio/R_852.lua",
								"",
								{},
								LockOn_Options.script_path.."Devices_specs/Radio/Radio_commands.lua"
							}

creators[devices.SPU_8]	=  {
								"Mi24::avSPU_8_Mi24", LockOn_Options.script_path.."Devices_specs/Radio/SPU_8.lua",
								{
									{"JADRO_1I", devices.JADRO_1I},
									{"R_863",devices.R_863},
									{"R_852",devices.R_852},
									{"EUCALYPT_M24",devices.EUCALYPT_M24},
									{"ARC_15",devices.ARC_15},
									{"ARC_U2",devices.ARC_U2},
									{"VMS", devices.VMS},
									{"SOUND_SYSTEM", devices.SOUND_SYSTEM},
								}
							}

creators[devices.RS_Proxy]	=  {
								"Mi24::avRadioStationProxy_Mi24", LockOn_Options.script_path.."Devices_specs/Radio/SPU_8.lua",
								{
									{"R_852",devices.R_852},
									{"EUCALYPT_M24",devices.EUCALYPT_M24},
									{"ARC_U2",devices.ARC_U2},
								}
							}

creators[devices.G_Meter]	= {"Mi24::avGMeter_Mi24",
								LockOn_Options.script_path.."Devices_specs/G_Meter.lua",
								{},
							}

creators[devices.IFF]	= 	{"Mi24::avIFF_6201_Mi24",
								"",
								{}
							}

creators[devices.Recorder_MC61]	= 	{"Mi24::avRecorderMC61_Mi24", "",
								{
								}
							}

creators[devices.VMS] = {"Mi24::avVMS_Mi24",
							LockOn_Options.script_path.."Devices_specs/VMS.lua",
							{
							}
						}

creators[devices.ANTI_ICE_INTERFACE] = {"Mi24::avAntiIceSysInterface_Mi24",
											LockOn_Options.script_path .. "Devices_specs/AntiIceSystem.lua",
											{},
										}

creators[devices.EXT_CARGO_EQUIPMENT] = {
											"Mi24::avExternalCargoEquipment_Mi24",
											LockOn_Options.script_path .. "Devices_specs/ExtCargoEquipment.lua",
											{}
										}

creators[devices.EXTERNAL_CARGO_SPEECH]	= {
	"avExternalCargoSpeech",
	"",
	{}
}

creators[devices.SARPP12I1]	= {"Mi24::avSARPP12I1_Mi24",
								LockOn_Options.script_path.."Devices_specs/SARPP12I1.lua",
								{}
							}

creators[devices.SIGHT_DOORS]	= {"Mi24::avSightDoors_Mi24",
									LockOn_Options.script_path.."Devices_specs/avSightDoors.lua",
									{
										{"IntLightsSystem", devices.INT_LIGHTS_SYSTEM},
									}
								}

creators[devices.SIGNAL_FLARES] = {"Mi24::avSignalFlares_Mi24",
									LockOn_Options.script_path .. "Devices_specs/SignalFlares.lua",
									{}
								}

creators[devices.MACROS] = {"Mi24::avAutostartDevice_Mi24",
								LockOn_Options.common_script_path.."Macro_handler.lua",
								{}
							}

creators[devices.STANDBY_COMPASS] = {"avMechCompass",
										LockOn_Options.script_path .. "Devices_specs/StandbyCompass.lua",
										{}
									}

creators[devices.SPO_10]	=	{"Mi24::avSPO_10",
									LockOn_Options.script_path .. "Devices_specs/SPO_10.lua",
									{{"i9K113", devices.I9K113}}
								}

creators[devices.KM_2] = {"Mi24::avKM_2_Mi24",
							LockOn_Options.script_path.."Devices_specs/KM_2.lua",
							{{"GREBEN", devices.GREBEN}}
						}
						
creators[devices.NVG]	= {"Mi24::avOVN_1"}

creators[devices.TIMER] = {"Mi24::avTimerDevice_Mi24",
							"",
							{{"weap_interface", devices.WEAP_SYS}}
						}



indicators[#indicators + 1] = {"Mi24::cc9K113",LockOn_Options.script_path.."9K113_CAM/9K113_CAM_init.lua", devices.I9K113}

indicators[#indicators + 1] = {"Mi24::ccPKV"              	, LockOn_Options.script_path.."PKV/Indicator/PKV_init.lua"      	   ,devices.PKV,
										{{"HUD-CENTER-O", "HUD-DOWN-O", "HUD-RIGHT-O"}, {sx = 0, sy = 0, sz = 0}}}
indicators[#indicators + 1] = {"Mi24::ccASP17"              , LockOn_Options.script_path.."ASP17V/Indicator/ASP_17V_init.lua"      ,devices.ASP_17V,
										{{"HUD-CENTER", "HUD-DOWN", "HUD-RIGHT"}, {sx = 0, sy = 0, sz = 0}}}

indicators[#indicators + 1] = {"Mi24::ccControlsIndicator"  , LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua",devices.AUTOPILOT}

indicators[#indicators + 1] = {
	"Mi24::ccMapDisplay_Mi24",
	LockOn_Options.script_path.."MapDisplay/MapDisplay.lua",
	devices.MAP_DISPLAY,
	{
		{"MAP-DISPLAY-CENTER-PTR","MAP-DISPLAY-DOWN-PTR","MAP-DISPLAY-RIGHT-PTR"},
		{},
		1
	}
}

indicators[#indicators + 1] = {"ccIndicator"		,LockOn_Options.script_path.."MapDisplay/bake/init.lua"}

indicators[#indicators + 1] = {"Mi24::ccHelperAIIndicator_Mi24"  , LockOn_Options.script_path.."HelperAI/HelperAI_indicator.lua",devices.HELPER_AI}
indicators[#indicators + 1] = {"Mi24::ccHelperAIIndicator_Mi24"  , LockOn_Options.script_path.."HelperAI/HelperAI_indicator_VR.lua",devices.HELPER_AI}

indicators[#indicators + 1] = {"Mi24::ccGunnersCPanel", LockOn_Options.script_path.."AI/ControlPanel/g_panel.lua",devices.WEAP_SYS}
indicators[#indicators + 1] = {"Mi24::ccCrewIndicator", LockOn_Options.script_path .. "CrewIndicator/crew_indicator_init.lua", devices.CREW_INDICATOR}

---------------------------------------------

kneeboard_implementation		= "Mi24::ccKneeboardExtension_Mi24"
disable_kneeboard_render_target = false
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------

creators[devices.KNEEBOARD] = {"Mi24::avKneeboard_Mi24",LockOn_Options.common_script_path.."KNEEBOARD/device/init.lua", {{"weap_sys", devices.WEAP_SYS}, {"aso_2V", devices.ASO_2V}}}

