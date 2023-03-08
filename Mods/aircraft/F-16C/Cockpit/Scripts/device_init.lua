mount_vfs_model_path(LockOn_Options.script_path.."../Shape")

dofile(LockOn_Options.script_path		.."config.lua")
dofile(LockOn_Options.script_path		.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path		.."materials.lua")

dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Tools.lua")

MainPanel = {"F16::ccF16MainPanel",
	LockOn_Options.script_path.."mainpanel_init.lua",
	{
		{"FM_PROXY",			devices.FM_PROXY},
		{"CONTROL",				devices.CONTROL_INTERFACE},
		{"ELEC",				devices.ELEC_INTERFACE},
		{"FUEL",				devices.FUEL_INTERFACE},
		{"HYDRAULIC",			devices.HYDRO_INTERFACE},
		{"engine_interface",	devices.ENGINE_INTERFACE},
		{"gear_interface",		devices.GEAR_INTERFACE},
		{"oxygen_interface",	devices.OXYGEN_INTERFACE},
		{"cpt_mechanics",		devices.CPT_MECH},
		{"extlights_system",	devices.EXTLIGHTS_SYSTEM},
		{"CPT_LIGHTS",			devices.CPTLIGHTS_SYSTEM},
		{"ECS",					devices.ECS_INTERFACE},
		{"CMDS",				devices.CMDS},
		{"RWR",					devices.RWR},
		-- Radio --------------------------------
		{"IFF_CONTROL_PANEL",	devices.IFF_CONTROL_PANEL},
		{"UHFRadio",			devices.UHF_RADIO},
		-- Instruments --------------------------
 		{"AoAIndicator",		devices.AOA_INDICATOR},
		{"AMI",					devices.AMI},
		{"VVI",					devices.VVI},
		{"AAU34",				devices.AAU34},
		{"ADI",					devices.ADI},
		{"SAI",					devices.SAI},
		{"Clock",				devices.CLOCK},
		--
		{"FCR",					devices.FCR},
		{"ECM", 				devices.ECM_INTERFACE},
	},
}

function maintenance_setup_NVG()  
	local	ret_val ={}
			ret_val[1] = {[devices.HELMET] =  {
							"F16::avNVG_F16",
							LockOn_Options.script_path.."HELMET/NVG.lua",
							{}},
						}--devices
			ret_val[2] = {}--indicators
	return ret_val
end

function maintenance_setup_HMS()
	local	ret_val ={}
			ret_val[1] = {[devices.HELMET] = {
							"F16::avHMD_F16",
							LockOn_Options.script_path.."HMD/device/HMD.lua",
							{}},
						}--devices
			ret_val[2] = {{"F16::ccHMD_F16",
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
	"F16::avFMProxy_F16",
	"",
	{}
}

creators[devices.CONTROL_INTERFACE] = {
	"F16::avControlInterface_F16",
	LockOn_Options.script_path.."Systems/ControlSystem.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ELEC",devices.ELEC_INTERFACE},
	{"FLCC", devices.FLCC}},
}

creators[devices.ELEC_INTERFACE] = {
	"F16::avElectricInterface_F16",
	LockOn_Options.script_path.."Systems/ElectricSystem.lua",
	{}
}

creators[devices.FUEL_INTERFACE] = { 
	"F16::avFuelInterface_F16",
	LockOn_Options.script_path.."Systems/FuelSystem.lua",
	{{"FM_PROXY", devices.FM_PROXY},
	{"ELEC",devices.ELEC_INTERFACE}},
}	

creators[devices.HYDRO_INTERFACE] = {
	"F16::avHydroInterface_F16",
	LockOn_Options.script_path.."Systems/HydroSystem.lua",
	{{"FM_PROXY", devices.FM_PROXY},
	{"ELEC",devices.ELEC_INTERFACE}},
}

creators[devices.ENGINE_INTERFACE] = { 
	"F16::avEngineInterface_F16",
	LockOn_Options.script_path.."Systems/PowerPlant.lua",
	{{"FM_proxy", devices.FM_PROXY},
	{"ElecInterface",devices.ELEC_INTERFACE}}
}	

creators[devices.GEAR_INTERFACE] = {
	"F16::avGearInterface_F16",
	LockOn_Options.script_path.."Systems/GearSystem.lua",
	{{"ELEC",devices.ELEC_INTERFACE}}
}

creators[devices.OXYGEN_INTERFACE]	= {
	"F16::avOxygenInterface_F16",
	LockOn_Options.script_path.."Systems/OxygenSystem.lua",
	{
		{"FM_PROXY", devices.FM_PROXY},
		{"ELEC", devices.ELEC_INTERFACE},
		{"HEARING_SENS", devices.HEARING_SENS}
	}
}

creators[devices.HEARING_SENS] = {
	"avBasicHearingSensitivityInterface",
	"",
	{{"OXYGEN",	devices.OXYGEN_INTERFACE}}
}

creators[devices.CPT_MECH] = { 
	"F16::avCockpitMechanics_F16",
	LockOn_Options.script_path.."Systems/CockpitMechanics.lua",
	{{"ELEC", devices.ELEC_INTERFACE}}
}

creators[devices.EXTLIGHTS_SYSTEM] = {
	"F16::avExtLightsSystem_F16",
	LockOn_Options.script_path.."Systems/ExtLights.lua",
	{{"ELEC",devices.ELEC_INTERFACE}}
}

creators[devices.CPTLIGHTS_SYSTEM] = {
	"F16::avCptLightsSystem_F16",
	LockOn_Options.script_path.."Systems/IntLights.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	{"CMDS", devices.CMDS}}
}

creators[devices.ECS_INTERFACE] = {
	"F16::avECSInterface_F16",
	LockOn_Options.script_path.."Systems/ECSystem.lua",
	{{"FM_PROXY",devices.FM_PROXY}}
}

creators[devices.INS] = {
	"F16::avINS_ASN141_F16",
	LockOn_Options.script_path.."Systems/INS.lua",
	{
		{"ELEC",		devices.ELEC_INTERFACE},
		{"MuxManager",	devices.MUX},
		{"FM_PROXY",	devices.FM_PROXY},
	}
}

creators[devices.RALT] = {
	"F16::avRadarAltimeter_F16",
	LockOn_Options.script_path.."Systems/CARA.lua",
	{{"ELEC",		devices.ELEC_INTERFACE},
	 {"MuxManager",	devices.MUX},}
}


-- HOTAS Interface
creators[devices.HOTAS]	= {
	"F16::avHOTAS_F16",
	"",
	{
		{"CONTROL",		devices.CONTROL_INTERFACE},
		{"GEAR",		devices.GEAR_INTERFACE},
		{"INTERCOM",	devices.INTERCOM},
		{"ELEC",		devices.ELEC_INTERFACE},
		{"FUEL",		devices.FUEL_INTERFACE},
		{"MMC",			devices.MMC},
		{"FCR",			devices.FCR},
		{"SMS",			devices.SMS},
		{"FLCC",		devices.FLCC},
		{"CMDS",		devices.CMDS},
		{"ECM",			devices.ECM_INTERFACE},
	}
}

--
creators[devices.UFC] = {
	"F16::avUFC_F16",
	LockOn_Options.script_path.."Computers/UFC.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"HUD", devices.HUD},
		{"DED", devices.DED},
		{"UHF", devices.UHF_RADIO},
		{"VHF", devices.VHF_RADIO},
		{"PFLD", devices.PFLD},
		{"FM_PROXY", devices.FM_PROXY},
		{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM},
	}
}

-- Computers -----------------------------
creators[devices.MUX] = {
	"F16::avMuxManager_F16",
	""
}

creators[devices.MMC] = {
	"F16::avMMC_F16",
	LockOn_Options.script_path.."Computers/MMC.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"HUD", devices.HUD},
		{"SMS", devices.SMS},
		{"AIM9_Interface", devices.SIDEWINDER_INTERFACE},
		{"HARM_Interface", devices.HARM_INTERFACE},
		{"FM_PROXY", devices.FM_PROXY},
		{"MIDS", devices.MIDS},
		{"FCR", devices.FCR},
		{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM},
		{"DTE_Interface", devices.DTE},
		{"HTS_Interface",devices.HTS_INTERFACE},
		{"RWR_radar",devices.RWR},
	}
}

creators[devices.CADC] = {
	"F16::avCADC_F16",
	"",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"FM_proxy", devices.FM_PROXY},
 	 {"MuxManager", devices.MUX}},
}

creators[devices.FLCC] = {
	"F16::avFLCC_F16",
	LockOn_Options.script_path.."Computers/FLCC.lua",
	{{"FM_proxy", devices.FM_PROXY},
	 {"ELEC", devices.ELEC_INTERFACE},
	 {"CTRL", devices.CONTROL_INTERFACE},
	 {"MuxManager", devices.MUX}},
}

creators[devices.SMS] = {
	"F16::avSMS_F16",
	"",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"AIM9_Interface", devices.SIDEWINDER_INTERFACE},
	 {"Maverick_Interface", devices.MAV_INTERFACE},
	 {"HARM_Interface", devices.HARM_INTERFACE}}
}

-- Displays -----------------------------
creators[devices.HUD] = {
	"F16::avHUD_F16",
	LockOn_Options.script_path.."Displays/HUD/device/HUD.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"MMC", devices.MMC}}
}

creators[devices.MFD_LEFT] = {
	"F16::avMFD_F16",
	LockOn_Options.script_path.."Displays/MFD/device/MFD_left.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"FCR", devices.FCR},
	 {"TGP", devices.TGP_INTERFACE},
 	 {"IFF", devices.IFF},
	 {"MMC", devices.MMC},
	 {"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM},
	 {"INS", devices.INS},
	 {"SMS", devices.SMS},
	 {"Maverick_Interface", devices.MAV_INTERFACE}}
}

creators[devices.MFD_RIGHT] = {
	"F16::avMFD_F16",
	LockOn_Options.script_path.."Displays/MFD/device/MFD_right.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"FCR", devices.FCR},
	 {"TGP", devices.TGP_INTERFACE},
 	 {"IFF", devices.IFF},
 	 {"MMC", devices.MMC},
	 {"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM},
	 {"INS", devices.INS},
	 {"SMS", devices.SMS},
	 {"Maverick_Interface", devices.MAV_INTERFACE}}
}

creators[devices.DED] = {
	"F16::avDED_F16",
	LockOn_Options.script_path.."Displays/DED/device/DED.lua",
	{{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM}}
}

creators[devices.PFLD] = {
	"F16::avPFLD_F16",
	LockOn_Options.script_path.."Displays/PFLD/device/PFLD.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM}
	}
}

creators[devices.EHSI] = {
	"F16::avEHSI_F16",
	LockOn_Options.script_path.."Displays/EHSI/device/EHSI.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM}
	}
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
creators[devices.HMCS] = {
	"F16::avHMCS_Interface_F16",
	LockOn_Options.script_path.."HELMET/HMD_Interface.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"RWR", devices.RWR},
		{"HELMET", devices.HELMET},
	}
}

-- Sensors ------------------------------
creators[devices.FCR] = {
	"F16::avRadar_APG68_F16",
	LockOn_Options.script_path.."Sensors/Radar/RadarDevice.lua",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX},
		{"FM_PROXY", devices.FM_PROXY},
		{"IFF", devices.IFF},
		{"MIDS", devices.MIDS}
	}
}

-- EWS ----------------------------------
creators[devices.CMDS] = {
	"F16::avCMDS_ALE47_F16",
	LockOn_Options.script_path.."EWS/CMDS/device/CMDS_ALE47.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX},
	 {"RWR", devices.RWR}}
}

creators[devices.RWR] = {
	"F16::avRWR_ALR56_F16",
	LockOn_Options.script_path.."EWS/RWR/device/RWR_ALR56.lua",
	{{"ELEC",		devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX}},
}

-- Radio --------------------------------
creators[devices.IFF]	= {
	"F16::avAIFF_APX113_F16",
	"",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX}
	}
}

creators[devices.IFF_CONTROL_PANEL]	= {
	"F16::avIFF_ControlPanel_F16",
	LockOn_Options.script_path.."Radio/IFF_ControlPanel.lua",
	{
		{"ELEC",devices.ELEC_INTERFACE},
		{"IFF", devices.IFF}
	}
}

creators[devices.UHF_RADIO]	= {
	"F16::avAN_ARC_164_F16",
	LockOn_Options.script_path.."Radio/UHF_Radio.lua",
	{{"ELEC", devices.ELEC_INTERFACE}}
}

creators[devices.UHF_CONTROL_PANEL]	= {
	"F16::avAN_ARC_164_ControlPanel_F16",
	"",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"UHF", devices.UHF_RADIO}
	}
}

creators[devices.VHF_RADIO]	= {
	"F16::avAN_ARC_222_F16",
	LockOn_Options.script_path.."Radio/VHF_Radio.lua",
	{{"ELEC", devices.ELEC_INTERFACE}}
}

creators[devices.INTERCOM] = {
	"F16::avIntercom_F16", 
	LockOn_Options.script_path.."Radio/Intercom.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"UHFRadio", devices.UHF_RADIO},
		{"VHFRadio", devices.VHF_RADIO},
		{"MIDS", devices.MIDS},
		{"SMS", devices.SMS},
		{"RWR", devices.RWR},
		{"ILS", devices.ILS}
	}
}

creators[devices.MIDS_RT] = {
	"EfmCommon::avMIDS_RT",
	LockOn_Options.script_path.."Radio/MIDS_RT.lua",
	{},
}

creators[devices.MIDS] = {
	"F16::avMIDS_LVT_F16",
	LockOn_Options.script_path.."Radio/MIDS.lua",
	{
		{"MIDS_RT", devices.MIDS_RT},
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX},
		{"FCR", devices.FCR},
		{"HTS", devices.HTS_INTERFACE},
		{"MMC", devices.MMC}
	},
}

creators[devices.KY58] = {
	"F16::avSecureSpeechSystem_KY58_F16",
	"",
	{{"ELEC", devices.ELEC_INTERFACE}}
}

creators[devices.ILS] = {
	"F16::avILS_F16",
	"",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX}
	}
}

creators[devices.IDM] = {
	"F16::avIDM_F16",
	LockOn_Options.script_path.."Radio/IDM.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX}
	},
}

-- Instruments --------------------------
creators[devices.AOA_INDICATOR] = {
	"F16::avAoAIndicator_F16",
	LockOn_Options.script_path.."Instruments/AoAIndicator.lua",
	{{"ELEC",devices.ELEC_INTERFACE},
	 {"CADC", devices.CADC}}
}

creators[devices.AAU34] = {
	"F16::avAAU34_F16",
	LockOn_Options.script_path.."Instruments/AAU34.lua",
	{{"FM_Proxy", devices.FM_PROXY},
	 {"ELEC",devices.ELEC_INTERFACE}}
}

creators[devices.AMI] = {
	"F16::avAMI_F16",
	LockOn_Options.script_path.."Instruments/AMI.lua",
	{{"FM_Proxy", devices.FM_PROXY}}
}

creators[devices.SAI] = {
	"F16::avSAI_F16",
	LockOn_Options.script_path.."Instruments/SAI.lua",
	{{"FM_Proxy", devices.FM_PROXY},
	 {"ElecInterface",devices.ELEC_INTERFACE}}
}

creators[devices.VVI] = {
	"F16::avVVI_F16",
	LockOn_Options.script_path.."Instruments/VVI.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"CADC", devices.CADC}}
}

creators[devices.STANDBY_COMPASS] = {
	"avMechCompass",
	LockOn_Options.script_path.."Instruments/StandbyCompass.lua",
	{}
}

creators[devices.ADI] = {
	"F16::avADI_F16",
	LockOn_Options.script_path.."Instruments/ADI.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"ILS", devices.ILS},
		{"EHSI", devices.EHSI},
		{"INS", devices.INS}
	}
}

creators[devices.CLOCK] = {
	"avABU11Clock",
	LockOn_Options.script_path.."Instruments/Clock.lua",
	{},
}

--
creators[devices.MACROS] = {
	"F16::avAutostartDevice_F16",
	LockOn_Options.common_script_path.."Macro_handler.lua",
	{
		{"ENGINE_INTERFACE", devices.ENGINE_INTERFACE},
		{"CONTROL_INTERFACE", devices.CONTROL_INTERFACE},
		{"CPT_LIGHTS", devices.CPTLIGHTS_SYSTEM},
		{"INS", devices.INS},
		{"SMS", devices.SMS},
		{"HMD_INTERFACE", devices.HMCS},
		{"HELMET", devices.HELMET},
	}
}

creators[devices.AIHelper]	= {"F16::avAIHelper_F16",
								LockOn_Options.script_path.."AIHelper/AIHelperDev.lua",
								{{"ELECTRIC", devices.ELEC_INTERFACE},
								{"ENGINES", devices.ENGINE_INTERFACE},
								{"OXYGEN", devices.OXYGEN_INTERFACE},
								{"FMPROXY", devices.FM_PROXY},
								{"GEAR", devices.GEAR_INTERFACE}}
}

-- Armament
-- Implementation of missile features specific for avionic interface
creators[devices.SIDEWINDER_INTERFACE]= {
	"F16::avSidewinder_Interface_F16",
	"",
	{}
}

creators[devices.TGP_INTERFACE] = {
	"F16::avTGP_Interface_F16",
	LockOn_Options.script_path.."Sensors/TGP/TGP.lua",
	{{"ELEC", devices.ELEC_INTERFACE},
	 {"MuxManager", devices.MUX}},
	""
}

creators[devices.MAV_INTERFACE] = {
	"F16::avMaverick_Interface_F16",
	LockOn_Options.script_path.."Computers/SMS/maverick_interface.lua",
	{}
}

creators[devices.HARM_INTERFACE] = {
	"F16::avHarm_Interface_F16",
	LockOn_Options.script_path.."Computers/SMS/harm_interface.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX}
	}
}

creators[devices.HTS_INTERFACE] = {
	"F16::avHTS_Interface_F16",
	LockOn_Options.script_path.."Computers/SMS/hts_interface.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX}
	}
}

--
creators[devices.GPS] = {
	"F16::avGPS_ASN151_F16",
	LockOn_Options.script_path.."Systems/GPS.lua",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MuxManager", devices.MUX}
	},
}

creators[devices.MAP] = {
	"F16::avMAP_F16",
	"",
	{
		{"ELEC", devices.ELEC_INTERFACE},
		{"MUX", devices.MUX}
	},
}

creators[devices.DTE] = {
	"F16::avDTE_F16",
	LockOn_Options.common_script_path..'AN_ALR_SymbolsBase.lua',
	{
		{"MuxManager",	devices.MUX},
		{"ELEC", devices.ELEC_INTERFACE},
	}
}

creators[devices.ECM_INTERFACE] =
{
	"F16::avECM_Interface_F16",
	"",
	{
		{"ELEC", devices.ELEC_INTERFACE},
	 	{"MuxManager",	devices.MUX},
		{"CMDS",		devices.CMDS},
		{"RWR", 		devices.RWR},
	}
}

local HUD_Position =
{
	{"PTR-HUD-CENTER", "PTR-HUD-DOWN", "PTR-HUD-RIGHT"},
	{sx_l = -0.13, sy_l = 0.005}
}

-- Indicators
indicators = {}

function add_inds(tab_of_devs_and_indicators)
    local inds = tab_of_devs_and_indicators[2]
    
    for i=1,#inds do
        indicators[#indicators + 1] = inds[i]
    end
end

indicators[#indicators + 1] = {
	"F16::ccControlsIndicator_F16",
	LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua",
	devices.CONTROL_INTERFACE
}

-- HUD
indicators[#indicators + 1] = {
	"F16::ccHUD_F16",
	LockOn_Options.script_path.."Displays/HUD/indicator/HUD_init.lua",
	devices.HUD,
	HUD_Position
}

indicators[#indicators + 1] = {
	"F16::ccDED_F16",
	LockOn_Options.script_path.."Displays/HUD/indicator/DED/HUD_DED_init.lua",
	devices.HUD,
	HUD_Position
}

indicators[#indicators + 1] = {
	"F16::ccPFLD_F16",
	LockOn_Options.script_path.."Displays/HUD/indicator/PFLD/HUD_PFLD_init.lua",
	devices.HUD,
	HUD_Position
}

local MFD_X_shift = 0.000051
local MFD_Z_shift = 0.0005

local LMFD_PositionGeometry = {"PTR-MFCD-L-CENTER", "PTR-MFCD-L-DOWN", "PTR-MFCD-L-RIGHT"}
local RMFD_PositionGeometry = {"PTR-MFCD-R-CENTER", "PTR-MFCD-R-DOWN", "PTR-MFCD-R-RIGHT"}
	
-- Left MFD
indicators[#indicators + 1] = {
	"F16::ccMFD_F16",
	LockOn_Options.script_path.."Displays/MFD/indicator/MFD_left_init.lua",
	devices.MFD_LEFT,
	{
		LMFD_PositionGeometry,
		{sx_l = MFD_X_shift, sz_l = MFD_Z_shift},
		1
	}
}

writeParameter("MFD_LEFT_INDICATOR_INDEX", #indicators - 1)

-- Right MFD
indicators[#indicators + 1] = {
	"F16::ccMFD_F16",
	LockOn_Options.script_path.."Displays/MFD/indicator/MFD_right_init.lua",
	devices.MFD_RIGHT,
	{
		RMFD_PositionGeometry,
		{sx_l = MFD_X_shift, sz_l = MFD_Z_shift},
		2
	}
}

writeParameter("MFD_RIGHT_INDICATOR_INDEX", #indicators - 1)

-- DED
indicators[#indicators + 1] = {
	"F16::ccDED_F16",
	LockOn_Options.script_path.."Displays/DED/indicator/DED_init.lua",
	devices.DED,
	{
		{"PTR-DED-CENTER", "PTR-DED-DOWN", "PTR-DED-RIGHT"}
	}
}

-- PFLD
indicators[#indicators + 1] = {
	"F16::ccPFLD_F16",
	LockOn_Options.script_path.."Displays/PFLD/indicator/PFLD_init.lua",
	devices.PFLD,
	{
		{"PTR-PFD-CENTER", "PTR-PFD-DOWN", "PTR-PFD-RIGHT"},
		{sx = 0, sy = 0, sz = 0, sx_l = -0.0001}
	}
}

if USE_LCD_MFD then
	--MFD LCD effect - 3 additional objects - first will render content of actual devices to target , and two others are just render texture holders
	--indicators[#indicators + 1] = {"F16::ccMFD_LCD_F16"}
	--------------------------------------------------------------------------
	indicators[#indicators + 1] = {"F16::ccMFD_LCD_F16", LockOn_Options.script_path.."Displays/MFD/indicator/LCD/MFD_LCD_left.lua" , devices.MFD_LEFT,
	{
		LMFD_PositionGeometry,
		{sx_l = MFD_X_shift, sz_l = MFD_Z_shift},
	}}
	indicators[#indicators + 1] = {"F16::ccMFD_LCD_F16", LockOn_Options.script_path.."Displays/MFD/indicator/LCD/MFD_LCD_Right.lua", devices.MFD_RIGHT,
	{
		RMFD_PositionGeometry,
		{sx_l = MFD_X_shift, sz_l = MFD_Z_shift},
	}}
end

-- UHF Backup Control Panel
indicators[#indicators + 1] = {"F16::ccAN_ARC164_F16",	LockOn_Options.script_path.."AN_ARC164/indicator/preset_channel_init.lua",	devices.UHF_CONTROL_PANEL,	{{"PTR-ANARC164-CHNL-CENTER", "PTR-ANARC164-CHNL-DOWN", "PTR-ANARC164-CHNL-RIGHT"},							{sx_l = 0.0, sy_l = 0.0, sz_l = 0.0}}}
indicators[#indicators + 1] = {"F16::ccAN_ARC164_F16",	LockOn_Options.script_path.."AN_ARC164/indicator/freq_status_init.lua",		devices.UHF_CONTROL_PANEL,	{{"PTR-ANARC164-STATUS-CENTER", "PTR-ANARC164-STATUS-DOWN", "PTR-ANARC164-STATUS-RIGHT"},					{sx_l = 0.0, sy_l = 0.0, sz_l = 0.0}}}
indicators[#indicators + 1] = {"F16::ccAN_ARC164_F16",	LockOn_Options.script_path.."AN_ARC164/indicator/channel_map_init.lua",		devices.UHF_CONTROL_PANEL,	{{"PTR-ANARC164-CHNL-MAP-SHEET-CTR", "PTR-ANARC164-CHNL-MAP-SHEET-DWN", "PTR-ANARC164-CHNL-MAP-SHEET-RGT"},	{sx_l = 0.0, sy_l = 0.0, sz_l = 0.0}}}

-- EHSI
indicators[#indicators + 1] = {
	"F16::ccEHSI_F16",
	LockOn_Options.script_path.."Displays/EHSI/indicator/EHSI_init.lua",
	devices.EHSI,
	{
		{"PTR-EHSI-CENTER", "PTR-EHSI-DOWN", "PTR-EHSI-RIGHT"},
		{sx_l = 0.0},
		3
	}
}

writeParameter("EHSI_INDICATOR_INDEX", #indicators - 1)

if USE_LCD_MFD then
	indicators[#indicators + 1] = {"F16::ccEHSI_LCD_F16", "", devices.EHSI}
	--
	indicators[#indicators + 1] = {
		"ccIndicator", LockOn_Options.script_path.."Displays/EHSI/indicator/LCD/EHSI_LCD.lua",
		devices.EHSI,
		{
			{"PTR-EHSI-CENTER", "PTR-EHSI-DOWN", "PTR-EHSI-RIGHT"},
			{sx_l = 0.0},
		}
	}
end

-- CMDS
indicators[#indicators + 1] = {
	"F16::ccCMDS_ALE47_F16",
	LockOn_Options.script_path.."EWS/CMDS/indicator/CMDS_ALE47_init.lua",
	devices.CMDS,
	{
		{"PTR-CMDS-DSP-CENTER", "PTR-CMDS-DSP-DOWN", "PTR-CMDS-DSP-RIGHT"},
		{sx_l = 0, sy_l = -0.001, sz_l = 0.0},
	}
}

-- RWR
indicators[#indicators + 1] = {
	"F16::ccRWR_ALR56_F16",
	LockOn_Options.script_path.."EWS/RWR/indicator/RWR_ALR56_init.lua",
	devices.RWR,
	{
		{"PTR-RWR-CENTER", "PTR-RWR-DOWN", "PTR-RWR-RIGHT"}
	}
}

-- Helmet apply
if helmet_option == 2 then
	add_inds(maintenance_setup_NVG())
elseif helmet_option == 1 then
	add_inds(maintenance_setup_HMS())
end

--indicators[#indicators + 1] = {"ccAIHelperBase",	LockOn_Options.script_path.."AIHelper/AIHelper.lua",	devices.AIHelper}

kneeboard_implementation 		= "F16::ccKneeboardExtension_F16"
disable_kneeboard_render_target = false
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
---------------------------------------------		   
