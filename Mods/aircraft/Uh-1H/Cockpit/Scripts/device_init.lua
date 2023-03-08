mount_vfs_model_path(LockOn_Options.script_path.."../Shape")


dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."config.lua")

	
--	items in <...> are optional
--
-- MainPanel = {"NAME_OF_CLASS",
--				"INIT_SCRIPT_FILE",
--				<{{"varname1", devices.LINKED_DEVICE1}, {"varname2", devices.LINKED_DEVICE2}, ...},>
--			   }

MainPanel = {
	"UH1H::ccMainPanel", 
	LockOn_Options.script_path.."mainpanel_init.lua",
	{{"SysController",devices.SYS_CONTROLLER},
	{"cpt_mech", devices.CPT_MECH},
	{"EnginesInterface", devices.ENGINE_INTERFACE},
	{"misc_systems", devices.MISC_SYSTEMS_INTERFACE},
	{"weap_interface", devices.WEAPON_SYS},
	{"hydro_interface", devices.HYDRO_SYS_INTERFACE},
	{"fuel_interface", devices.FUELSYS_INTERFACE},
	{"GMC", devices.GMCS},
	{"ADI_PILOT", devices.ADI_PILOT},
	{"ADI_OPERATOR", devices.ADI_OPERATOR},
	{"CLOCK", devices.CLOCK},
	{"electric_interface", devices.ELEC_INTERFACE},
	{"AAU7", devices.AAU7},
	{"AAU32", devices.AAU32},
	{"VHF", devices.VHF_ARC_134},
	{"UHF", devices.UHF_ARC_51},
	{"NAV_COMM", devices.ARN_82},
	{"MARKER_BEACON", devices.MARKER_BEACON},
	{"FM", devices.VHF_ARC_131},
	{"ADF", devices.ADF_ARN_83},
	{"COURSE_IND", devices.COURSE_IND},
	{"MARKER_BEACON", devices.MARKER_BEACON},
	{"TURN_IND", devices.TURN_IND},
	{"ROOF_AIRSPEED", devices.ROOF_AIRSPEED},
	{"NOSE_AIRSPEED", devices.NOSE_AIRSPEED},
	{"COPILOT_RMI", devices.COPILOT_RMI},
	{"VARIOMETER_PILOT", devices.VARIOMETER_PILOT},
	{"VARIOMETER_COPILOT", devices.VARIOMETER_COPILOT},
	{"flex_sight", devices.FLEX_SIGHT},
	{"pilot_sight", devices.PILOT_SIGHT},
	{"light_system", devices.NAVLIGHT_SYSTEM},
	{"IFF_system", devices.IFF},
	{"RALT",devices.RADAR_ALTIMETER},
	{"XM_130", devices.XM_130}},
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

creators[devices.HEAD_WRAPPER] = {
	"UH1H::avHeadWrapper",
	LockOn_Options.script_path.."Devices_specs/HeadWrapper.lua",
	{{"weap_sys",devices.WEAPON_SYS},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
	""
}

creators[devices.WEAPON_SYS] = {
	"UH1H::avWeaponSys_UH1H",
	LockOn_Options.script_path.."Devices_specs/WeaponSystem.lua",
	{{"flex_sight", devices.FLEX_SIGHT},
	 {"pilot_sight", devices.PILOT_SIGHT},
	 {"HeadWrapper", devices.HEAD_WRAPPER},
	 {"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER},
     {"CrewIndicator", devices.CREWE}},
	LockOn_Options.script_path .. "Devices_specs/weap_commands.lua"
}

creators[devices.GMCS]	 = {
	"UH1H::avGMC",
	LockOn_Options.script_path .. "GyroMagCompass/GyroMagCompass.lua",
	{{"RemoteCompass", devices.REMOTE_COMPASS},
	{"VOR_SOURCE", devices.ARN_82},
	{"ADF_SOURCE", devices.ADF_ARN_83},
	{"elec_system",devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.COPILOT_RMI]	 = {
	"UH1H::avID_250ARN",
	LockOn_Options.script_path .. "Devices_specs/CopilotRMI.lua",
	{{"GMC", devices.GMCS},
	{"elec_system",devices.ELEC_INTERFACE}}
}
						   
creators[devices.REMOTE_COMPASS] = {	
	"UH1H::avRemoteCompassTransmitter",
	LockOn_Options.script_path .. "RemoteCompassTransmitter/RemoteCompassTransmitter_param.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE}}
}	

creators[devices.ELEC_INTERFACE] = {
	"UH1H::avElectricInterface_UH1H",
	LockOn_Options.script_path.."Devices_specs/ElectricSystem.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.SYS_CONTROLLER] = {
	"UH1H::avSystemController",
	"",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	{"IFF",devices.IFF},
	{"light_system", devices.NAVLIGHT_SYSTEM},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.HEATING_SYSTEM] = {
	"UH1H::avHeatingSystem",
	"",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.CPT_MECH] = {
	"UH1H::avCockpitMechanics_UH1H",
	LockOn_Options.script_path .. "CPT_MECH/cpt_mech.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
	LockOn_Options.script_path .. "CPT_MECH/cpt_mech_commands.lua"
}

creators[devices.CONTROL_SYSTEM] = {
	"UH1H::avControlSystemInterface_UH1H",
	"",
	{{"cptMech", devices.CPT_MECH},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.FUELSYS_INTERFACE]	= {
	"UH1H::avFuelSysInterface_UH1H",
	LockOn_Options.script_path.."Devices_specs/FuelSys.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}

creators[devices.ENGINE_INTERFACE] = {
	"UH1H::avEnginesInterface_UH1H",
	LockOn_Options.script_path .. "Devices_specs/EnginesIndicators.lua",
	{{"ctl_sys", devices.CONTROL_SYSTEM},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.HYDRO_SYS_INTERFACE] =	{
	"UH1H::avHydroInterface_UH1H",
	LockOn_Options.script_path.."Devices_specs/HydroSystem.lua",
	{{"cptMech", devices.CPT_MECH},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.MISC_SYSTEMS_INTERFACE] = {
	"UH1H::avMiscSystemsInterface_UH1H",
	LockOn_Options.script_path.."Devices_specs/MiscSystems.lua",
}                                                  				

creators[devices.ADI_PILOT] = {
	"UH1H::avADI_Pilot",
	LockOn_Options.script_path.."Devices_specs/PilotAI.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE},
	{"MD_GYRO", devices.MD_1_GYRO},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.ADI_OPERATOR] = {
	"UH1H::avCopilotAI",
	LockOn_Options.script_path.."Devices_specs/CopilotAI.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}							 

creators[devices.NAVLIGHT_SYSTEM] =  {
	"UH1H::avNavLightsSystem",
	LockOn_Options.script_path.."Devices_specs/NavLightsSystem.lua",
	{{"ctl_sys", devices.CONTROL_SYSTEM},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
	LockOn_Options.script_path.."Devices_specs/NavLightsSystem_commands.lua"
}

creators[devices.CLOCK]	= {
	"UH1H::avA11Clock_UH1H",
	LockOn_Options.script_path.."Devices_specs/Clock.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.ROOF_AIRSPEED]	= {
	"UH1H::avRoofAirspeedIndicator_UH1H",
	LockOn_Options.script_path .. "Devices_specs/RoofASind.lua",
	{{"FM_Proxy",devices.FM_PROXY}}
}

creators[devices.NOSE_AIRSPEED]	= {
	"UH1H::avNoseAirspeedIndicator_UH1H",
	LockOn_Options.script_path .. "Devices_specs/NoseASind.lua",
	{{"FM_Proxy",devices.FM_PROXY}}
}

creators[devices.IFF] = {
	"UH1H::avIFF_APX_72_UH1H",
	""	,
	{{"ElecInterface", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.AAU7]	= {
	"UH1H::avAAU_7_A",
	LockOn_Options.script_path .. "Devices_specs/AAU7.lua",
	{{"FM_Proxy",devices.FM_PROXY},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}
									  
creators[devices.AAU32]	= {	
	"UH1H::avAAU_32_A",	
	LockOn_Options.script_path .. "Devices_specs/AAU32.lua",
	{{"FM_Proxy",devices.FM_PROXY},
	{"ElecInterface", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}
 
creators[devices.VHF_ARC_134] = {
	"UH1H::avVHF_ARC_134", 
	LockOn_Options.script_path.."VHF_ARC_134/AM_Radio.lua", 
	{{"elec_system", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}, 
	LockOn_Options.script_path.."VHF_ARC_134/Radio_commands.lua"
} 

creators[devices.INTERCOM] 	= {
	"UH1H::avIntercom_C1611", 
	LockOn_Options.script_path.."Intercom.lua",
	{{"elec_system", devices.ELEC_INTERFACE},
	{"VHF_AM_Radio", devices.VHF_ARC_134},
	{"UHF_Radio", devices.UHF_ARC_51},
	{"VHF_FM_Radio_1", devices.VHF_ARC_131},
	{"VHF_FM_Radio_2", devices.ARN_82},	
	{"NAV_Set", devices.ADF_ARN_83},
	{"MARKER_BEACON", devices.MARKER_BEACON},
	{"ctl_sys", devices.CONTROL_SYSTEM},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.UHF_ARC_51] = {
	"UH1H::avUHF_ARC_51", 
	LockOn_Options.script_path.."UHF_ARC_51/UHF_Radio.lua",
	{{"elec_system", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
	LockOn_Options.script_path.."UHF_ARC_51/UHF_Radio_commands.lua"
}
								
creators[devices.VHF_ARC_131] = {
	"UH1H::avVHF_ARC_131", 
	LockOn_Options.script_path.."VHF_ARC_131/FM_Radio.lua",
	{{"elec_system", devices.ELEC_INTERFACE},
	{"NAVIGATION_RELAY", devices.NAVIGATION_RELAY},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
	LockOn_Options.script_path.."VHF_ARC_131/Radio_commands.lua"
}

creators[devices.ILS] = {
	"UH1H::avILS_UH1", 
	LockOn_Options.script_path.."Devices_specs/ILS_params.lua", 
	{},
}

creators[devices.ARN_82]	= {	
	"UH1H::avAN_ARN_82", 
	LockOn_Options.script_path.."NAV_ARN_82/ARN_82.lua",
	{{"elec_system", devices.ELEC_INTERFACE},
	{"ILS", devices.ILS},
	{"MARKER_BEACON", devices.MARKER_BEACON},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.ADF_ARN_83] = {
	"UH1H::avAN_ARN_83", 
	LockOn_Options.script_path.."ADF_ARN_83/ADF_ARN_83.lua",
	{{"elec_system", devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}

creators[devices.MARKER_BEACON]	= {	
	"UH1H::avMarkerBeaconReceiver", 
	LockOn_Options.script_path.."Devices_specs/MarkerBeacon.lua",
	{{"ILS", devices.ILS},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}												

creators[devices.COURSE_IND] = {
	"UH1H::avCourseInd_ID1347",
	LockOn_Options.script_path.."CourseInd_ID1347/Course_indicator.lua",
	{{"elec_system",devices.ELEC_INTERFACE},
	{"NAVIGATION_RELAY", devices.NAVIGATION_RELAY},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}
							 
creators[devices.FM_PROXY] = {"UH1H::avFMProxy_UH1","",{}}					

creators[devices.FLEX_SIGHT]	= {
	"UH1H::avFlexibleSight",
	LockOn_Options.script_path.."FlexibleSight/device/FlexibleSight_param.lua",
	{{"HeadWrapper", devices.HEAD_WRAPPER},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}

creators[devices.PILOT_SIGHT]	= {
	"UH1H::avPilotSight",
	LockOn_Options.script_path.."PilotSight/device/PilotSight_param.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}


creators[devices.TURN_IND]	= {
	"UH1H::avTurnSlipIndicator",
	LockOn_Options.script_path.."Devices_specs/TurnIndicator.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE},
	{"FM_Proxy",devices.FM_PROXY}},
	"",
}

creators[devices.NAVIGATION_RELAY]	= {
	"UH1H::avNavigationRelay",
	"",
	{{"NAV", devices.ARN_82},
	{"HOMING", devices.VHF_ARC_131},
	{"MARKER_BEACON", devices.MARKER_BEACON}}
}

creators[devices.MD_1_GYRO]	= {
	"UH1H::avMD_1_Gyro",
	LockOn_Options.script_path.."Devices_specs/MD_1_Gyro.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE}},
	"",
}

creators[devices.STANDBY_COMPASS] = { 
	"avMechCompass",
	LockOn_Options.script_path .. "Devices_specs/StandbyCompass.lua",
	{}
}
								
creators[devices.MACROS] = {
	"UH1H::avAutostartDevice_UH1H",
	LockOn_Options.common_script_path.."Macro_handler.lua",
    {}
}

creators[devices.VARIOMETER_PILOT] = {
	"avSimpleVariometer",
	LockOn_Options.script_path.."Devices_specs/Variometer.lua",
	{{"FM_Proxy",devices.FM_PROXY}},
}	

creators[devices.VARIOMETER_COPILOT] = {
	"avSimpleVariometer",
	LockOn_Options.script_path.."Devices_specs/Variometer.lua",
	{{"FM_Proxy",devices.FM_PROXY}},
}	

creators[devices.RADAR_ALTIMETER] = {
	"UH1H::avAPN_209_UH1H",
	LockOn_Options.script_path.."Devices_specs/RadarAltimeter.lua",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}

creators[devices.XM_130] = {
	"UH1H::avXM_130_UH1H",
	LockOn_Options.script_path.."Devices_specs/XM_130.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}},
}

creators[devices.HELMET_DEVICE]	= {"avNightVisionGogglesV2"}	

creators[devices.PADLOCK]       = {"avPadlock",
                                   LockOn_Options.common_script_path .. "PADLOCK/PADLOCK_device.lua"}
								   
creators[devices.CARGO_CAM] = {"UH1H::avCargo_Camera",
						 LockOn_Options.script_path.."Devices_specs/Cargo_Cam.lua",
						 {{"RADAR_ALTIMETER",devices.RADAR_ALTIMETER}},
						 ""
						}

creators[devices.EXTERNAL_CARGO_VIEW]	= {
	"UH1H::avExternalCargoView_UH1H",
	LockOn_Options.script_path.."Devices_specs/CargoViewAdjustment.lua",
	{{"cpt_mech", devices.CPT_MECH}}
}

creators[devices.EXT_CARGO_EQUIPMENT] = { 
	"UH1H::avExternalCargoEquipment_UH1H",
	LockOn_Options.script_path .. "Devices_specs/ExtCargoEquipment.lua",
	{{"pSynchControl",devices.NETWORK_SYNCH_CONTROLLER}}
}

creators[devices.EXTERNAL_CARGO_SPEECH]	= {
	"avExternalCargoSpeech",
	"",
	{}
}

creators[devices.NETWORK_SYNCH_CONTROLLER] = { 
	"UH1H::avNetworkSyncController_UH1H",
	LockOn_Options.script_path .. "Devices_specs/NetworkSyncController.lua",
	{
		{"pWeaponSystem",  	devices.WEAPON_SYS},
		{"pControlSystem", 	devices.CONTROL_SYSTEM},
		{"pIntercom",      	devices.INTERCOM},
		{"pCargoSystem",   	devices.EXT_CARGO_EQUIPMENT},
		{"pNavLightsSystem",   devices.NAVLIGHT_SYSTEM},												
		{"pEngines",   		devices.ENGINE_INTERFACE},
		{"pCourseInd",   		devices.COURSE_IND},
		{"pGMC",				devices.GMCS},
		{"pAAU7",				devices.AAU7},
		{"pAAU32",				devices.AAU32},
		{"pRadioAltimeter",	devices.RADAR_ALTIMETER},
		{"pFuelSys",			devices.FUELSYS_INTERFACE},
		{"pADIPilot",			devices.ADI_PILOT},
		{"pADICoPilot",		devices.ADI_OPERATOR},
		{"pARC_134",			devices.VHF_ARC_134},
		{"pARC_51",			devices.UHF_ARC_51},
		{"pARC_131",			devices.VHF_ARC_131},
		{"pARN_83",			devices.ADF_ARN_83},
		{"pARN_82",			devices.ARN_82},
		{"pMarkerBeakon",      devices.MARKER_BEACON},
		{"pAPX_72",			devices.IFF},
		{"pHydroSys",			devices.HYDRO_SYS_INTERFACE},
		{"pSysController",		devices.SYS_CONTROLLER},
		{"pElectric",			devices.ELEC_INTERFACE},
		{"pMech",				devices.CPT_MECH},
		{"pHeatingSys",		devices.HEATING_SYSTEM},
		{"pPilotSight",		devices.PILOT_SIGHT},
		{"pXM130",				devices.XM_130},
		{"pClock",				devices.CLOCK},
		{"pFlexibleSight",     devices.FLEX_SIGHT},
		{"pHeadWrapper",		devices.HEAD_WRAPPER},
	}
}

creators[devices.CREWE] = {"UH1H::avCrewIndicator", nil, {{"weapon_system", devices.WEAPON_SYS}}}


tv_map_render_id ={1, 2, 3, 4};

indicators[#indicators + 1] = {"UH1H::ccControlsIndicator", LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua", devices.CONTROL_SYSTEM}  
indicators[#indicators + 1] = {"ccCargoIndicatorBase", LockOn_Options.script_path.."CargoIndicator/CargoIndicator.lua"}            
indicators[#indicators + 1] = {"UH1H::ccPilotSight",  
	LockOn_Options.script_path.."PilotSight/Indicator/PilotSight_init.lua",
	devices.PILOT_SIGHT,
	{{"sight1_point_center","sight1_point_bottom","sight1_point_right"}}
}

indicators[#indicators + 1] = {
	"UH1H::ccFlexibleGunSight",  
	LockOn_Options.script_path.."FlexibleSight/Indicator/FlexibleSight_init.lua",
	devices.FLEX_SIGHT,
	{{"sight_point_center","sight_point_bottom","sight_point_right"}}
}

indicators[#indicators + 1] = {"ccPadlock", LockOn_Options.common_script_path.."PADLOCK/PADLOCK_indicator.lua",devices.PADLOCK}

if LockOn_Options.flight.easy_flight then
	indicators[#indicators + 1] = {"UH1H::ccLifeBar_UH1H"  , LockOn_Options.script_path.."LifeBar/LifeBar.lua"} 
end

indicators[#indicators + 1] = {"UH1H::ccCargo_Camera", LockOn_Options.script_path.."CARGO_CAM/CARGO_CAM_init.lua", devices.CARGO_CAM, {{},{},tv_map_render_id[1]}}

indicators[#indicators + 1] = {"UH1H::ccGunnersCPanel", LockOn_Options.script_path.."AI/ControlPanel/g_panel.lua",devices.WEAPON_SYS}

indicators[#indicators + 1] = {
	"UH1H::ccUHF_ARC51_UH1H",
	LockOn_Options.script_path.."UHF_ARC_51/AN_ARC51_init.lua",
	devices.UHF_ARC_51,
	{
		{"UHF_ARC51_CHANNELS_TABLE_CENTER", "UHF_ARC51_CHANNELS_TABLE_BOTTOM", "UHF_ARC51_CHANNELS_TABLE_RIGHT"},
		{sx = -0.0002, sy = 0.00002, sz = -0.0002}
	}
}

indicators[#indicators + 1] = {"ccCrewIndicatorBase", LockOn_Options.script_path .. "CrewIndicator/crew_indicator_init.lua", devices.CREWE}

kneeboard_implementation 		= "UH1H::ccKneeboardExtension_UH1H"
disable_kneeboard_render_target = false
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
