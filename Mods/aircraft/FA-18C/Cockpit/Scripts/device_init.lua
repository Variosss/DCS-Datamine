mount_vfs_model_path(LockOn_Options.script_path.."../Shape")

dofile(LockOn_Options.script_path		.."config.lua")
dofile(LockOn_Options.script_path		.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path		.."materials.lua")
dofile(LockOn_Options.script_path		.."Multipurpose_Display_Group/Common/indicator/InitParams.lua")

if bakeIndicators == true then
	writeParameter("bakeIndicators", 1)
	
	if bakeHUD == true then
		writeParameter("bakeHUD", 1)
	else
		writeParameter("bakeHUD", 0)
	end
	
	-- BAKE MATERIALS
	
	-- Multipurpose Display Group (MDG)
	writeParameter("HUD_BAKE_MATERIAL", HUD_BAKE_MATERIAL)
	writeParameter("LMDI_BAKE_MATERIAL", LMDI_BAKE_MATERIAL)
	writeParameter("RMDI_BAKE_MATERIAL", RMDI_BAKE_MATERIAL)
	writeParameter("AMPCD_BAKE_MATERIAL", AMPCD_BAKE_MATERIAL)
	
	-- Radar Warning Receiver (RWR) Azimuth Indicator
	writeParameter("RWR_BAKE_MATERIAL", RWR_BAKE_MATERIAL)
else
	writeParameter("bakeIndicators", 0)
	writeParameter("bakeHUD", 0)
end

MainPanel = {"F18::ccF18MainPanel", 
			LockOn_Options.script_path.."mainpanel_init.lua",
			{{"FM_Proxy",		devices.FM_PROXY},
			 {"CONTROL",		devices.CONTROL_INTERFACE},
			 {"ELEC",			devices.ELEC_INTERFACE},
			 {"HYDRO",			devices.HYDRAULIC_INTERFACE},
			 {"GEAR",			devices.GEAR_INTERFACE},
			 {"CPT_LIGHTS",		devices.CPT_LIGHTS},
			 {"ECS",			devices.ECS_INTERFACE},
			 -- Instruments --------------------------
			 {"IFEI",			devices.IFEI},
			 {"AAU52",			devices.AAU52},
			 {"AVU35",			devices.AVU35},
			 {"AVU53",			devices.AVU53},
			 {"ID2163A", 		devices.ID2163A},
			 {"SAI", 			devices.SAI},
			 --
			 {"RWR", 			devices.RWR},
			 {"CMDS",			devices.CMDS},
			 --		
			 {"RDR",			devices.RADAR},
			 -- MDG
			 {"LMDI", 			devices.MDI_LEFT},
			 {"RMDI", 			devices.MDI_RIGHT},
			 {"AMPCD", 			devices.AMPCD},
			},
}

function maintenance_setup_NVG()  
	local	ret_val ={}
			ret_val[1] = {[devices.HELMET] =  {
							"F18::avNVG_F18",
							LockOn_Options.script_path.."HELMET/NVG.lua",
							{}},
						}--devices
			ret_val[2] = {}--indicators
	return ret_val
end

function maintenance_setup_HMS()
	local	ret_val ={}
			ret_val[1] = {[devices.HELMET] = {
							"F18::avHMD_F18",
							LockOn_Options.script_path.."HMD/device/HMD.lua",
							{}},
						}--devices
			ret_val[2] = {{"ccHMD",
							LockOn_Options.script_path.."HMD/indicator/HMD_init.lua",
							devices.HELMET},
						}--indicators
	return ret_val
end

creators   = {}

function add_devs(tab_of_devs_and_indicators)
    local devs = tab_of_devs_and_indicators[1]
    for i,o in pairs(devs) do
        creators[i]  = o
    end
end

creators[devices.FM_PROXY] = {
	"F18::avFMProxy_F18",
	"",
	{{"FCCA", devices.FCCA},
	{"FCCB", devices.FCCB}}
}

creators[devices.CONTROL_INTERFACE] = {
	"F18::avControlInterface_F18",
	LockOn_Options.script_path.."Interfaces/ControlSystem.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC", devices.ELEC_INTERFACE},
	{"FCCA", devices.FCCA},
	{"FCCB", devices.FCCB}},
}

creators[devices.ELEC_INTERFACE] = {
	"F18::avElectricInterface_F18",
	LockOn_Options.script_path.."Interfaces/ElectricSystem.lua",
	{{"FM_proxy", devices.FM_PROXY}},
}

creators[devices.HYDRAULIC_INTERFACE] = {
	"F18::avHydroInterface_F18",
	LockOn_Options.script_path.."Interfaces/HydraulicSystem.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ElecInterface", devices.ELEC_INTERFACE}},
}

creators[devices.GEAR_INTERFACE] = {
	"F18::avGearInterface_F18",
	LockOn_Options.script_path.."Interfaces/GearSystem.lua",
	{{"ElecInterface", devices.ELEC_INTERFACE},
	{"CONTROL", devices.CONTROL_INTERFACE}},
}

creators[devices.FUEL_INTERFACE] = {
	"F18::avFuelInterface_F18",
	LockOn_Options.script_path.."Interfaces/FuelSystem.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ElecInterface", devices.ELEC_INTERFACE}},
}

creators[devices.CPT_MECHANICS] = {
	"F18::avCockpitMechanics_F18",
	"",
	{
		{"ElecInterface", devices.ELEC_INTERFACE},
		{"HOTAS", devices.HOTAS}
	},
}

creators[devices.EXT_LIGHTS] = {
	"F18::avExtLightsSystem_F18",
	LockOn_Options.script_path.."Interfaces/ExtLights.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	{"CPT_LIGHTS", devices.CPT_LIGHTS}}
}

creators[devices.CPT_LIGHTS] = {
	"F18::avCptLightsSystem_F18",
	LockOn_Options.script_path.."Interfaces/CptLights.lua",
	{{"ELEC",devices.ELEC_INTERFACE}}
}

creators[devices.OXYGEN_INTERFACE] = {
	"F18::avOxygenInterface_F18",
	LockOn_Options.script_path.."Interfaces/OxygenSystem.lua",
	{}
}

creators[devices.ECS_INTERFACE] = {
	"F18::avAirInterface_F18",
	LockOn_Options.script_path.."Interfaces/ECS.lua",
	{{"FM_Proxy", devices.FM_PROXY}}
}

creators[devices.ENGINES_INTERFACE] = {
	"F18::avEngineInterface_F18",
	"",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC", devices.ELEC_INTERFACE}}
}

-- HOTAS Interface
creators[devices.HOTAS]	= {
	"F18::avHOTAS_F18",
	"",
	{{"CONTROL", devices.CONTROL_INTERFACE},
	{"EXT_LIGHTS", devices.EXT_LIGHTS},
	{"INTERCOM", devices.INTERCOM},
	{"SMS", devices.SMS},
	{"CMDS", devices.CMDS},
	{"LMDI", devices.MDI_LEFT},
	{"RMDI", devices.MDI_RIGHT},
	{"RDR", devices.RADAR},
	}
}

-- Computers --------------------------
creators[devices.MUX] = {
	"F18::avMuxManager_F18",
	""
}

creators[devices.SDC] = {
	"F18::avSignalDataComputer_F18",
	"",
	{{"ELEC",devices.ELEC_INTERFACE},
	{"HYDRO",devices.HYDRAULIC_INTERFACE},
	{"FM_PROXY",devices.FM_PROXY},
	{"MuxManager", devices.MUX},
	{"IFEI", devices.IFEI}}
}

creators[devices.MISSION_COMPUTER_NO_1] = {
	"F18::avMC_No1_F18",
	LockOn_Options.script_path.."Computers/MC_No1.lua",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"FM_PROXY", devices.FM_PROXY},
		{"MIDS", devices.MIDS}
	}
}

creators[devices.MISSION_COMPUTER_NO_2] = {
	"F18::avMC_No2_F18",
	LockOn_Options.script_path.."Computers/MC_No2.lua",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"FM_PROXY", devices.FM_PROXY},
		{"MIDS", devices.MIDS},
		{"RADAR", devices.RADAR},
		{"DMC", devices.DIGITAL_MAP_COMPUTER},
	},
	LockOn_Options.script_path .. "Computers/MC2_commands.lua"
}

creators[devices.FCCA] = {
	"F18::avFCCA_F18",
	LockOn_Options.script_path.."Computers/FCC.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC", devices.ELEC_INTERFACE},
	{"CTRL", devices.CONTROL_INTERFACE},
	{"FCC_SEC", devices.FCCB},
	{"MuxManager", devices.MUX}},
}

creators[devices.FCCB] = {
	"F18::avFCCB_F18",
	LockOn_Options.script_path.."Computers/FCC.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC", devices.ELEC_INTERFACE},
	{"CTRL", devices.CONTROL_INTERFACE},
	{"FCC_SEC", devices.FCCA},
	{"MuxManager", devices.MUX}},
}

creators[devices.ADC] = {
	"F18::avAirDataComputer_F18",
	"",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC", devices.ELEC_INTERFACE},
	{"MuxManager", devices.MUX},
	{"MAD", devices.MAD}},
}

creators[devices.CONTROL_CONVERTER] = {
	"F18::avControlConverter_F18",
	"",
	{
		{"FM_proxy", devices.FM_PROXY},
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"UFC", devices.UFC},
		{"RadarAltimeter", devices.RADAR_ALTIMETER},
		{"RaltIndicator", devices.ID2163A},
		{"SAI", devices.SAI},
		{"ADF", devices.ADF},
		{"MIDS", devices.MIDS},
		{"INTERCOM", devices.INTERCOM},
		{"ICLS", devices.ILS},
		{"BCN", devices.BCN},
		{"LINK4", devices.LINK4},
	},
}

creators[devices.SMS] = {
	"F18::avArmamentControl_AYK22_F18",
	LockOn_Options.script_path.."Computers/SMS/SMS.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"AIM_9_Interface", devices.SIDEWINDER_INTERFACE},
		{"Maverick_Interface", devices.MAVERICK_INTERFACE},
		{"Walleye_Interface", devices.WALLEYE_INTERFACE},
		{"SLAM_Interface", devices.SLAM_INTERFACE},
		{"Harm_Interface", devices.HARM_INTERFACE},
		{"Datalink_Interface", devices.DATALINK_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY}
	},
	LockOn_Options.script_path .. "Computers/SMS/sms_commands.lua"
}

creators[devices.DIGITAL_MAP_COMPUTER] = {
	"F18::avDigitalMapComputer_ASQ196_F18",
	"",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX}
	},
}

creators[devices.UFC] = {
	"F18::avUFC_F18",
	"",
	{{"ControlConverter", devices.CONTROL_CONVERTER},
	{"ELEC", devices.ELEC_INTERFACE},
	{"INTERCOM", devices.INTERCOM},
	{"FM_PROXY", devices.FM_PROXY},
	{"CPT_LIGHTS", devices.CPT_LIGHTS}}
}

-- Instruments --------------------------
creators[devices.AAU52] = {
	"F18::avAAU52_F18",
	LockOn_Options.script_path.."Instruments/AAU52.lua",
	{{"FM_Proxy", devices.FM_PROXY},
	 {"ElecInterface",devices.ELEC_INTERFACE}}
}

creators[devices.AVU35] = {
	"F18::avAVU35_F18",
	LockOn_Options.script_path.."Instruments/AVU35.lua",
	{{"FM_Proxy", devices.FM_PROXY},
	 {"ElecInterface",devices.ELEC_INTERFACE}}
}

creators[devices.AVU53] = {
	"F18::avAVU53_F18",
	LockOn_Options.script_path.."Instruments/AVU53.lua",
	{{"FM_Proxy", devices.FM_PROXY},
	 {"ElecInterface",devices.ELEC_INTERFACE}}
}

creators[devices.STANDBY_COMPASS] = {
	"avMechCompass",
	LockOn_Options.script_path.."Instruments/StandbyCompass.lua",
	{}
}

creators[devices.ID2163A] = {
	"F18::avRadarAltimeterID2163A_F18",
	LockOn_Options.script_path.."Instruments/ID2163A.lua",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	 {"RadarAltimeter",devices.RADAR_ALTIMETER}}
}

creators[devices.RADAR_ALTIMETER] = {
	"F18::avRadarAltimeter_F18",
	LockOn_Options.script_path.."Instruments/RadarAltimeter.lua",
	{{"ID2163A", devices.ID2163A},
	 {"ElecInterface", devices.ELEC_INTERFACE}}
}

creators[devices.SAI] = {
	"F18::avSAI_F18",
	LockOn_Options.script_path.."Instruments/SAI_Parameters.lua",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	 {"FM_Proxy", devices.FM_PROXY},
	 {"ICLS", devices.ILS}}
}

creators[devices.IFEI] = {
	"F18::avIFEI_F18",
	LockOn_Options.script_path.."IFEI/device/IFEI.lua",
	{{"ElecInterface",devices.ELEC_INTERFACE},
	{"SDC", devices.SDC}}
}

-- Multipurpose Display Group ---------------------------
creators[devices.HUD] = {
	"F18::avHUD_AVQ32_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/device/AVQ32.lua",
	{
		-- common links for left/right MDIs, AMPCD, and HUD
		{"ELEC",devices.ELEC_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY},
		{"CPT_LIGHTS", devices.CPT_LIGHTS},
	}
}

creators[devices.MDI_LEFT] = {
	"F18::avMDI_IP1556A_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/device/MDI_left.lua",
	{
		-- common links for left/right MDIs, AMPCD, and HUD
		{"ELEC", devices.ELEC_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY},
		-- common links for left/right MDIs and AMPCD
		{"MuxManager", devices.MUX},
		{"DMC", devices.DIGITAL_MAP_COMPUTER},
		{"MC1", devices.MISSION_COMPUTER_NO_1},
		{"MC2", devices.MISSION_COMPUTER_NO_2},
		{"MAV", devices.MAVERICK_INTERFACE},
		{"WALLEYE", devices.WALLEYE_INTERFACE},
		{"SMS", devices.SMS},
		{"TGP", devices.TGP_INTERFACE},
		-- common links for left/right MDIs
		{"HI", devices.AMPCD},
		{"HUD", devices.HUD},
		{"RDR", devices.RADAR},
		{"CPT_LIGHTS", devices.CPT_LIGHTS},
	}
}

creators[devices.MDI_RIGHT] = {
	"F18::avMDI_IP1556A_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/device/MDI_right.lua",
	{
		-- common links for left/right MDIs, AMPCD, and HUD
		{"ELEC", devices.ELEC_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY},
		-- common links for left/right MDIs and AMPCD
		{"MuxManager", devices.MUX},
		{"DMC", devices.DIGITAL_MAP_COMPUTER},
		{"MC1", devices.MISSION_COMPUTER_NO_1},
		{"MC2", devices.MISSION_COMPUTER_NO_2},
		{"MAV", devices.MAVERICK_INTERFACE},
		{"WALLEYE", devices.WALLEYE_INTERFACE},
		{"SMS", devices.SMS},
		{"TGP", devices.TGP_INTERFACE},
		-- common links for left/right MDIs
		{"HI", devices.AMPCD},
		{"HUD", devices.HUD},
		{"RDR", devices.RADAR},
		{"CPT_LIGHTS", devices.CPT_LIGHTS},
	}
}

creators[devices.AMPCD] = {
	"F18::avAMPCD_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/device/AMPCD.lua",
	{
		-- common links for left/right MDIs, AMPCD, and HUD
		{"ELEC", devices.ELEC_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY},
		-- common links for left/right MDIs and AMPCD
		{"MuxManager", devices.MUX},
		{"DMC", devices.DIGITAL_MAP_COMPUTER},
		{"MC1", devices.MISSION_COMPUTER_NO_1},
		{"MC2", devices.MISSION_COMPUTER_NO_2},
		{"MAV", devices.MAVERICK_INTERFACE},
		{"WALLEYE", devices.WALLEYE_INTERFACE},
		{"SMS", devices.SMS},
		{"TGP", devices.TGP_INTERFACE},
		{"CPT_LIGHTS", devices.CPT_LIGHTS},
	}
}

-- Radio & Comm

creators[devices.INTERCOM] = {
	"F18::avIntercom_AM7360_F18",
	LockOn_Options.script_path.."Radio/Intercom.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"UHF1", devices.UHF1},
		{"UHF2", devices.UHF2},
		{"MIDS", devices.MIDS},
		{"RWR", devices.RWR},
		{"SMS", devices.SMS},
	}
}

creators[devices.UHF1] = {
	"F18::avUHF1_F18",
	LockOn_Options.script_path.."Radio/ARC_210_UHF1.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX},
		{"CONTROL_CONVERTER", devices.CONTROL_CONVERTER}
	}
}

creators[devices.UHF2] = {
	"F18::avUHF2_F18",
	LockOn_Options.script_path.."Radio/ARC_210_UHF2.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX},
		{"CONTROL_CONVERTER", devices.CONTROL_CONVERTER}
	}
}

creators[devices.KY58] = {
	"F18::avSecureSpeechSystem_KY_58_F18", 
	"",
	{{"ELEC", devices.ELEC_INTERFACE}}
}

--
creators[devices.RADAR] = {
	"F18::avRadar_APG73_F18",
	LockOn_Options.script_path.."Sensors/Radar/RadarDevice.lua",
	{
		{"ElecInterface",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"FM_PROXY", devices.FM_PROXY},
		{"IFF", devices.IFF},
		{"MIDS", devices.MIDS},
		{"MC2", devices.MISSION_COMPUTER_NO_2},
		{"DMC", devices.DIGITAL_MAP_COMPUTER}
	}
}

-- INS/GPS
creators[devices.INS] = {
	"F18::avINS_ASN139_F18",
	LockOn_Options.script_path.."INS_GPS/INS_ASN139.lua",
	{
		{"ElecInterface",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"FM_PROXY", devices.FM_PROXY},
		{"GPS", devices.GPS}
	}
}

-- GPS
creators[devices.GPS] = {
	"F18::avGPS_ASN163_F18",
	LockOn_Options.script_path.."INS_GPS/GPS_ASN163.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX}}
}

-- Magnetic Azimuth Detector
creators[devices.MAD] = {
	"F18::avMAD_DT604A_F18",
	LockOn_Options.script_path.."INS_GPS/MAD_DT604A.lua"
}

-- Armament
-- Implementation of missile features specific for avionic interface
creators[devices.SIDEWINDER_INTERFACE]= {"F18::avSidewinder_Interface",
										"",
										{}
}

creators[devices.MAVERICK_INTERFACE] = {"F18::avMaverick_Interface",
										LockOn_Options.script_path .. "Computers/SMS/maverick_interface.lua",
										{},
										LockOn_Options.script_path .. "Computers/SMS/maverick_commands.lua"
}

creators[devices.WALLEYE_INTERFACE] = {"F18::avWalleye_Interface",
										LockOn_Options.script_path .. "Computers/SMS/walleye_interface.lua",
										{{"DATALINK", devices.DATALINK_INTERFACE}}
}

creators[devices.SLAM_INTERFACE] 	= {"F18::avSLAM_Interface",
										LockOn_Options.script_path .. "Computers/SMS/slam_interface.lua",
										{{"DATALINK", devices.DATALINK_INTERFACE}}
}

creators[devices.DATALINK_INTERFACE] = {"F18::avDatalink_Interface",
										LockOn_Options.script_path .. "Computers/SMS/datalink_interface.lua",
										{}
}


-- RNAV
creators[devices.ADF] = {
	"F18::avADF_OA8697ARD_F18",
	LockOn_Options.script_path.."Radio/ADF.lua",
	{{"ELEC",devices.ELEC_INTERFACE}}
}

creators[devices.ANTENNA_SELECTOR] = {
	"F18::avAntennaSelector_F18",
	"",
	{{"ELEC",devices.ELEC_INTERFACE},
	{"UHF1",devices.UHF1},
	{"UHF2",devices.UHF2},
	{"ADF",devices.ADF}}
}

creators[devices.MIDS] = {
	"F18::avMIDS_LVT_F18",
	LockOn_Options.script_path.."Radio/MIDS.lua",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"MUX", devices.MUX},
		{"MIDS_RT", devices.MIDS_RT},
		{"RADAR", devices.RADAR},
		{"IFF", devices.IFF},
		{"MC2", devices.MISSION_COMPUTER_NO_2},
	}
}

creators[devices.MIDS_RT] = {
	"EfmCommon::avMIDS_RT",
	LockOn_Options.script_path.."Radio/MIDS_RT.lua",
	{}
}


creators[devices.ILS] = {
	"F18::avILS_ARA_63_F18",
	LockOn_Options.script_path.."Radio/ILS.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	{"INTERCOM",devices.INTERCOM}}
}

-- TEWS
creators[devices.RWR]	= {
	"F18::avRWR_ALR67_F18",
	LockOn_Options.script_path.."TEWS/device/RWR_ALR67.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"CPT_LIGHTS", devices.CPT_LIGHTS},
	 {"MIDS", devices.MIDS},
	 {"RDR", devices.RADAR},
	 }
}

creators[devices.CMDS]	= {
	"F18::avCMDS_ALE47_F18",
	LockOn_Options.script_path.."TEWS/device/CMDS_ALE47.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"RWR", devices.RWR},
	 }
}

creators[devices.ASPJ]	= {
	"F18::avASPJ_ALQ165_F18",
	LockOn_Options.script_path.."TEWS/device/ASPJ_ALQ165.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"FM_PROXY", devices.FM_PROXY},
	 {"RWR", devices.RWR},
	 }
}

--
creators[devices.MACROS]	= {
	"F18::avAutostartDevice_F18",
	LockOn_Options.common_script_path.."Macro_handler.lua",
	{
		{"POWER_PLANT", devices.ENGINES_INTERFACE},
		{"CONTROL_INTERFACE", devices.CONTROL_INTERFACE},
		{"CPT_LIGHTS", devices.CPT_LIGHTS},
		{"INS", devices.INS},
		{"AMPCD", devices.AMPCD},
		{"HMD_INTERFACE", devices.HMD_INTERFACE},
		{"HELMET", devices.HELMET},
	}
}

-- IFF
creators[devices.IFF]	= {
	"F18::avIFF_APX111_F18",
	"",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX}}
}

-- Helmet read
local helmet_option = get_aircraft_property_or_nil("HelmetMountedDevice")
if 	helmet_option == nil then
	helmet_option = 1
end
--apply
if helmet_option == 2 then
	add_devs(maintenance_setup_NVG())
elseif helmet_option == 1 then
	add_devs(maintenance_setup_HMS())
end

-- HMD
creators[devices.HMD_INTERFACE]	= {
	"F18::avHMD_Interface_F18",
	LockOn_Options.script_path.."HELMET/HMD_Interface.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"MC2", devices.MISSION_COMPUTER_NO_2},
	 {"HELMET", devices.HELMET},
	 {"MC1", devices.MISSION_COMPUTER_NO_1}
	 }
}

--
creators[devices.CLC] = {
	"F18::avCommandLaunchComputer_F18",
	LockOn_Options.script_path .. "Computers/SMS/CLC.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"RWR", devices.RWR},
	 {"Harm_Interface", devices.HARM_INTERFACE}}
}

creators[devices.HARM_INTERFACE] = {
	"F18::avHarm_Interface",
	"",
	{},
	""
}

creators[devices.TGP_INTERFACE] = {
	"F18::avTGP_Interface_F18",
	LockOn_Options.script_path.."Sensors/TGP/TGP.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"MC1", devices.MISSION_COMPUTER_NO_1}},
	""
}

creators[devices.BCN] = {
	"F18::avRadarBeacon_F18",
	"",
	{{"ELEC", devices.ELEC_INTERFACE},
	 },
}

creators[devices.LINK4] = {
	"F18::avLink4_F18",
	LockOn_Options.script_path.."Radio/Link4.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
	},
}


-- Indicators
indicators = {}

function add_inds(tab_of_devs_and_indicators)
    local inds = tab_of_devs_and_indicators[2]
    
    for i=1,#inds do
        indicators[#indicators + 1] = inds[i]
    end
end

-- Controls indicator
indicators[#indicators + 1] = {
	"F18::ccControlsIndicator_F18",
	LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua",
	devices.CONTROL_INTERFACE
}

local HUD_PositionGeometry = {"HUD-CENTER", "HUD-DOWN", "HUD-RIGHT"}
writeParameter("HUD_INDICATOR_INDEX", #indicators)

-- Head-up Display
indicators[#indicators + 1] = {
	"F18::ccHUD_AVQ32_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/AVQ32_init.lua",
	devices.HUD,
	{HUD_PositionGeometry,{}}
}

local LMDI_PositionGeometry = {"MDI-L-CENTER", "MDI-L-DOWN", "MDI-L-RIGHT"}
writeParameter("LMDI_INDICATOR_INDEX", #indicators)

-- Left MDI
indicators[#indicators + 1] = {
	"F18::ccMPD_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_left_init.lua",
	devices.MDI_LEFT,
	{LMDI_PositionGeometry,{},1}
}

local RMDI_PositionGeometry = {"MDI-R-CENTER", "MDI-R-DOWN", "MDI-R-RIGHT"}
writeParameter("RMDI_INDICATOR_INDEX", #indicators)

-- Right MDI
indicators[#indicators + 1] = {
	"F18::ccMPD_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_right_init.lua",
	devices.MDI_RIGHT,
	{RMDI_PositionGeometry,{},2}
}

local AMPCD_PositionGeometry = {"AMPCD-CENTER", "AMPCD-DOWN", "AMPCD-RIGHT"}
writeParameter("AMPCD_INDICATOR_INDEX", #indicators)

-- AMPCD
indicators[#indicators + 1] = {
	"F18::ccAMPCD_F18",
	LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_init.lua",
	devices.AMPCD,
	{AMPCD_PositionGeometry,{},3}
}

-- IFEI
indicators[#indicators + 1] = {
	"F18::ccIFEI_F18",
	LockOn_Options.script_path.."IFEI/indicator/IFEI_init.lua",
	devices.IFEI,
	{{"IFEI-CENTER","IFEIL-DOWN","IFEI-RIGHT"},
	{sx_l = 0.0004}}
}

-- UFC
indicators[#indicators + 1] = {
	"F18::ccUFC_F18",
	LockOn_Options.script_path.."UFC/indicator/UFC_init.lua",
	devices.UFC,
	{{"UFC-CENTER","UFC-DOWN","UFC-RIGHT"},
	{sx_l = 0.0}}
}

local RWR_PositionGeometry = {"RWR-CENTER", "RWR_DOWN", "RWR-RIGHT"}
writeParameter("RWR_INDICATOR_INDEX", #indicators)

-- RWR
indicators[#indicators + 1] = {
	"F18::ccRWR_ALR67_F18",
	LockOn_Options.script_path.."TEWS/indicator/RWR_ALR67_init.lua",
	devices.RWR,
	{RWR_PositionGeometry,{}}
}

-- Helmet apply
if helmet_option == 2 then
	add_inds(maintenance_setup_NVG())
elseif helmet_option == 1 then
	add_inds(maintenance_setup_HMS())
end

-- Bake MDG indicators
if bakeIndicators == true then
	-- HUD
	if bakeHUD == true then
		indicators[#indicators + 1] = {"F18::ccMDG_IndicatorBake_F18", LockOn_Options.script_path.."Multipurpose_Display_Group/HUD_AVQ32/indicator/BAKE/HUD_AVQ32_bake_init.lua", devices.HUD, {HUD_PositionGeometry,{}}}
	end
	
	-- Lelt MDI
	indicators[#indicators + 1] = {"F18::ccMDG_IndicatorBake_F18", LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/BAKE/MDI_left_bake_init.lua", devices.MDI_LEFT, {LMDI_PositionGeometry,{}}}
	-- Right MDI
	indicators[#indicators + 1] = {"F18::ccMDG_IndicatorBake_F18", LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/BAKE/MDI_right_bake_init.lua", devices.MDI_RIGHT, {RMDI_PositionGeometry,{}}}
	-- AMPCD
	indicators[#indicators + 1] = {"F18::ccMDG_IndicatorBake_F18", LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/BAKE/AMPCD_bake_init.lua", devices.AMPCD, {AMPCD_PositionGeometry,{}}}
	
	-- RWR
	indicators[#indicators + 1] = {"F18::ccRWR_ALR67_Bake_F18", LockOn_Options.script_path.."TEWS/indicator/BAKE/RWR_ALR67_bake_init.lua", devices.RWR, {RWR_PositionGeometry,{}}}
end

kneeboard_implementation 		= "F18::ccKneeboardExtension_F18"
disable_kneeboard_render_target = false
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")

creators[devices.KNEEBOARD] = {
	"F18::avKneeboard_F18",
	LockOn_Options.common_script_path.."KNEEBOARD/device/init.lua",
	{}
}
---------------------------------------------
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
---------------------------------------------
