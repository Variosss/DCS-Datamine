mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."sounds_init.lua")

function writeParameter(name, value)
	local param = get_param_handle(name)
	if param ~= nil then
		param:set(value)
	end
end

function script(name)
	return LockOn_Options.script_path.."Scripts/"..name
end

layoutGeometry = {}

MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators    = {}
creators[devices.INS]			= {"Sensors::INS", LockOn_Options.script_path.."Scripts/UNI.lua", {{"dbus", devices.DATABUS}} }
creators[devices.CAS] 			= {"Weapons::CAS", nil, {{"dbus", devices.DATABUS}, {"rdi",devices.RDI}}}
creators[devices.ELECTRIC]		= {"avM2000CElectricalSystem"}
creators[devices.FLIGHTINST]	= {"FlightInstruments::avFlightInst", LockOn_Options.script_path.."Scripts/FINST_init.lua", {{"dbus", devices.DATABUS}}}
creators[devices.INSTPANEL]		= {"FlightInstruments::avInstPanel", nil, {{"dbus", devices.DATABUS}} }
creators[devices.NAVINST]		= {"Panels::NAV", LockOn_Options.script_path.."Scripts/NAVINST.lua", {{"dbus", devices.DATABUS}} }
creators[devices.VTB]			= {"Panels::VTB", nil, {{"dbus", devices.DATABUS}} }
creators[devices.PCA]			= {"Systems::PCA", nil, {{"dbus", devices.DATABUS}}	}
creators[devices.PCN]			= {"Panels::PCN", LockOn_Options.script_path.."Scripts/UNI.lua", {{"ins", devices.INS}, {"dbus", devices.DATABUS}}}
creators[devices.PWRPNL]		= {"Panels::avPWRPNL",script("PWR_SPLY.lua"), {{"ELECTRIC",devices.ELECTRIC}}}
creators[devices.SYSLIGHTS]		= {"Panels::avLights", nil, {{"dbus", devices.DATABUS}}}
creators[devices.CDVE]			= {"Systems::CDVE"}
creators[devices.ENGINE]		= {"SubSystems::ssEngine", script("SNECMA_M53P2.lua")}
creators[devices.HYDRAULICS]	= {"SubSystems::ssHydraulics"}
creators[devices.PCR]			= {"Radar::PCR", nil, {{"dbus", devices.DATABUS}, {"rdi",devices.RDI}}}
creators[devices.MAGIC]			= {"Weapons::MAGIC", script("GUNS_init.lua"), {{"dbus", devices.DATABUS}}}
creators[devices.VHF]		 	= {"Comms::avM2KCRadio_VHF", script("Radio/M2KC_VHF_Radio.lua"), {{"ELECTRIC",devices.ELECTRIC}}}
creators[devices.UHF] 		 	= {"Comms::avM2KCRadio_UHF", script("Radio/M2KC_UHF_Radio.lua"), {{"ELECTRIC",devices.ELECTRIC}}}
creators[devices.MISCPANELS]	= {"Panels::avMISC_PNL", nil, {{"dbus", devices.DATABUS}}}
creators[devices.TACAN]		 	= {"Comms::avM2KC_TACAN",nil,{{"ELECTRIC",devices.ELECTRIC}}}
creators[devices.VORILS] 		= {"Comms::avM2KC_VORILS",nil,{{"dbus", devices.DATABUS}, {"ELECTRIC",devices.ELECTRIC}}}
creators[devices.ECS] 		    = {"Panels::avECS"}
creators[devices.FBW] 		    = {"Panels::avFBW_PNL"}
creators[devices.PCCM]			= {"Sensors::PCCM", nil,{{"dbus", devices.DATABUS}, {"serval",devices.SERVAL}}}
creators[devices.SABRE]			= {"Sensors::SABRE", script("SABRE.lua"), {{"dbus", devices.DATABUS}} }
creators[devices.SPIRALE]		= {"Sensors::SPIRALE", nil, {{"dbus", devices.DATABUS}} }
creators[devices.SERVAL]		= {"Sensors::SERVAL", script("RWR.lua"), {{"elec",devices.ELECTRIC}, {"dbus", devices.DATABUS}}}
creators[devices.DDM]			= {"Sensors::DDM", script("DDM.lua"), {{"dbus", devices.DATABUS}, {"elec",devices.ELECTRIC}}}
creators[devices.SNA]			= {"Systems::SNA", nil, {{"dbus", devices.DATABUS}} }
creators[devices.PPA]			= {"Panels::PPA", nil, {{"dbus", devices.DATABUS}} }
creators[devices.RDI]			= {"Radar::RDI", script("RDI.lua"), {{"dbus", devices.DATABUS}}}
creators[devices.CCLT]			= {"Weapons::CCLT", nil, {{"dbus", devices.DATABUS}}}
creators[devices.VTH]			= {"Panels::VTH", nil, {{"dbus", devices.DATABUS}} }
creators[devices.CAA]			= {"Weapons::CAA", nil, {{"dbus", devices.DATABUS}} }
creators[devices.RS]			= {"Sensors::RS", nil, {{"dbus", devices.DATABUS}} }
creators[devices.TAF]			= {"Systems::TAF", nil, {{"dbus", devices.DATABUS}} }
creators[devices.CANOPY]		= {"Systems::Canopy"}
creators[devices.Helmet_NVG]	= {"M2K_Helmet::ANVIS9"}

creators[devices.INTERCOM]   	= {"Comms::avM2KCIntercom", script("Radio/M2KC_Intercom.lua"),
									{{"VHFRadio", devices.VHF},
									{"UHFRadio", devices.UHF},
									{"TACAN", devices.TACAN},
									{"VORILS", devices.VORILS},
									{"ELECTRIC",devices.ELECTRIC}}}

creators[devices.ENGPANEL]		= {"Panels::avEngStart",nil,
									{{"dbus", devices.DATABUS},
									{"PWRPNL",devices.PWRPNL},
									{"ENGINE", devices.ENGINE},
									{"MISCPANELS", devices.MISCPANELS},
									{"INSTPANEL", devices.INSTPANEL},
									{"FLT_INST", devices.FLIGHTINST},
									{"VTH", devices.VTH},
									{"VTB", devices.VTB},
									{"PCN", devices.PCN},
									{"HYDRAULICS", devices.HYDRAULICS},
									{"CDVE", devices.CDVE},
									{"SYSLIGHTS", devices.SYSLIGHTS},
									{"TACAN", devices.TACAN},
									{"VORILS", devices.VORILS},
									{"VHF", devices.VHF},
									{"UHF", devices.UHF},
									{"PCCM", devices.PCCM},
									{"CANOPY", devices.CANOPY}}}

creators[devices.DATABUS]		= {"Networks::DataBus", nil, {	{"fliDevice", devices.FLIGHTINST},
																{"lumDevice", devices.SYSLIGHTS},
																{"insDevice", devices.INS},
																{"pcaDevice", devices.PCA},
																{"snaDevice",devices.SNA},
																{"tafDevice",devices.TAF},
																{"cdveDevice",devices.CDVE},
																{"casDevice",devices.CAS},
																{"caaDevice",devices.CAA},
																{"pcrDevice",devices.PCR},
																{"rdiDevice",devices.RDI},
																{"ppaDevice", devices.PPA},
																{"magDevice", devices.MAGIC},		
																{"ccltDevice", devices.CCLT},
																{"vthDevice", devices.VTH},
																{"vtbDevice", devices.VTB},
																{"navDevice", devices.NAVINST},
																{"rsDevice", devices.RS},
																{"pccmDevice", devices.PCCM},
																{"servalDevice", devices.SERVAL},
																{"spiraleDevice", devices.SPIRALE},
																{"sabreDevice", devices.SABRE},
																{"ddmDevice", devices.DDM},
																{"comDevice", devices.INTERCOM},
																} }


									

-- Indicators
indicators = {}
indicators[#indicators + 1]	= {"Panels::VTH_Indicator", LockOn_Options.script_path.."VTH/HUD_init.lua", devices.VTH, {{"PNT_HUD_CENTER","PNT_HUD_DOWN","PNT_HUD_RIGHT"}}, {{"dbus", devices.DATABUS}, {"mag", devices.MAGIC}, {"cas", devices.CAS}} }
indicators[#indicators + 1] = {"Panels::VTB_Indicator", LockOn_Options.script_path.."VTB/VTB_init.lua", devices.VTB, { {"PNT_VTB_CENTER","PNT_VTB_DOWN","PNT_VTB_RIGHT"}, {sx_l = -0.02}}, {{"dbus", devices.DATABUS}} }
indicators[#indicators + 1] = {"Panels::VCM_Indicator", LockOn_Options.script_path.."VCM/VCM_init.lua", devices.SERVAL, { {"PNT_RWR_CENTER","PNT_RWR_DOWN","PNT_RWR_RIGHT"}, }, {{"dbus", devices.DATABUS}} }
indicators[#indicators + 1] = {"FlightInstruments::Fuel_Panel", LockOn_Options.script_path.."FUEL/FUEL_init.lua", devices.FLIGHTINST, { {"PNT_FUEL_CENTER","PNT_FUEL_DOWN","PNT_FUEL_RIGHT"}, } }
indicators[#indicators + 1] = {"Systems::PCA_LCD", LockOn_Options.script_path.."PCA_PPA/PCA_UR_init.lua", devices.PCA, { {"PNT_PCA_U_CENTER","PNT_PCA_U_DOWN","PNT_PCA_U_RIGHT"}, } }
indicators[#indicators + 1] = {"Systems::PCA_LCD", LockOn_Options.script_path.."PCA_PPA/PCA_BR_init.lua", devices.PCA, { {"PNT_PCA_L_CENTER","PNT_PCA_L_DOWN","PNT_PCA_L_RIGHT"}, } }
indicators[#indicators + 1] = {"Panels::PPA_LCD", LockOn_Options.script_path.."PCA_PPA/PPA_init.lua", devices.PPA, { {"PNT_PPA_CENTER","PNT_PPA_DOWN","PNT_PPA_RIGHT"}, } }
indicators[#indicators + 1] = {"FlightInstruments::COMS", LockOn_Options.script_path.."COM/COM_init.lua", devices.FLIGHTINST, { {"PNT_UHF_CENTER","PNT_UHF_DOWN","PNT_UHF_RIGHT"}, } }
indicators[#indicators + 1] = {"FlightInstruments::COMS", LockOn_Options.script_path.."COM/COM_GreenBox_init.lua", devices.FLIGHTINST, { {"PNT_VHF_CENTER","PNT_VHF_DOWN","PNT_VHF_RIGHT"}, } }
indicators[#indicators + 1] = {"Panels::ccPCN_UR", LockOn_Options.script_path.."PCN/PCN_UR_init.lua", devices.PCN, { {"PNT_PCN_U_CENTER","PNT_PCN_U_DOWN","PNT_PCN_U_RIGHT"}, } }
indicators[#indicators + 1] = {"Panels::ccPCN_BR", LockOn_Options.script_path.."PCN/PCN_BR_init.lua", devices.PCN, { {"PNT_PCN_L_CENTER","PNT_PCN_L_DOWN","PNT_PCN_L_RIGHT"}, } }
indicators[#indicators + 1] = {"Panels::EVF_LCD", LockOn_Options.script_path.."EVF/EVF_init.lua", devices.TAF, { {"PNT_TAF_CENTER","PNT_TAF_DOWN","PNT_TAF_RIGHT"}, } }
indicators[#indicators + 1] = {"Panels::MIP_Label", LockOn_Options.script_path.."MIP/MIP_init.lua", devices.PCN, { {"MIP_CENTER","MIP_DOWN","MIP_RIGHT"}, {sx_l = -0.001}} }
indicators[#indicators + 1] = {"ccControlsIndicatorM2000C",LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua"}
indicators[#indicators + 1] = {"FlightInstruments::AoARepeater",LockOn_Options.script_path.."AOA/AOA_init.lua", devices.VTH, { {"PNT_UHF_CENTER"}, {sx_l=-0.025, sy_l=0.041, sz_l=0.041, rz_l=5 }} }

indicators[#indicators + 1] = {"Panels::VTB_Screen",LockOn_Options.script_path.."VTB/VTB_screen_init.lua",devices.VTB, { {"PNT_VTB_CENTER","PNT_VTB_DOWN","PNT_VTB_RIGHT"}, {sx_l = -0.02 } } }
indicators[#indicators + 1] = {"Panels::VCM_Screen",LockOn_Options.script_path.."VCM/VCM_screen_init.lua",devices.SERVAL, { {"PNT_RWR_CENTER","PNT_RWR_DOWN","PNT_RWR_RIGHT"}, } }
indicators[#indicators + 1] = {"ccHelmetM2000C",LockOn_Options.script_path.."HELMET/Indicator/HelmetIndicator.lua"} 	

indicators[#indicators + 1] = {"Panels::VTB_Viewport",LockOn_Options.script_path.."VTB/VTB_viewport_init.lua",devices.VTB,   }

							  
--Kneeboard
---kneeboard_implementation 		= "KneeboardM2K"
---disable_kneeboard_render_target = false
---dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
local kneeboard_render_target_id = 4
creators[devices.KNEEBOARD] = {"avKneeboard",LockOn_Options.common_script_path.."KNEEBOARD/device/init.lua"}
indicators[#indicators + 1] = {"KneeboardM2K", LockOn_Options.common_script_path.."KNEEBOARD/indicator/init.lua", devices.KNEEBOARD, {{},{sx_l = -0.65,sz_l =  0.15,sy_l = -0.5,ry_l =  10, rz_l = 85 ,sw = 0.142 * 0.5 - 0.1,sh = 0.214 * 0.5 - 0.1}, kneeboard_render_target_id} }

---------------------------------------------
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
---------------------------------------------