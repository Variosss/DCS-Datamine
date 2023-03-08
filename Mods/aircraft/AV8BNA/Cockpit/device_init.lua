mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")
dofile(LockOn_Options.script_path.."materials.lua")

layoutGeometry = {}

tv_map_render_id = {1, 2, 3, 4};

-- Devices --
MainPanel							= {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}

creators							= {}
creators[devices.ELECTRIC]          = {"avEPSS"}
creators[devices.COMM1]             = {"Comms::avARC210_COM1",	
										LockOn_Options.script_path.."Scripts/Radio/ARC210_Radio1.lua",	
										{{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.COMM2]             = {"Comms::avARC210_COM2",	
										LockOn_Options.script_path.."Scripts/Radio/ARC210_Radio2.lua",	
										{{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.INTERCOM]          = {"Comms::avAV8B_ICS",		
										LockOn_Options.script_path.."Scripts/Radio/Intercom.lua",	
										{{"COMM1", devices.COMM1}, 
										{"COMM2", devices.COMM2}, 
										{"TACAN", devices.TACAN}, 
										{"AWLS", devices.AWLS}, 
										{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.TACAN]             = {"Comms::avAV8B_TACAN",	
										LockOn_Options.script_path.."Scripts/RadioNav/AN_ARN118_config.lua", 
										{{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.AWLS]              = {"Comms::avAV8B_AWLS",	
										LockOn_Options.script_path.."Scripts/RadioNav/AN_ARN128_config.lua", 
										{{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.RSC]               = {"Comms::avAV8B_RSC",
										LockOn_Options.script_path.."Scripts/Radio/RCU_8150.lua", 
										{{"COM1", devices.COMM1}, 
										{"COM2", devices.COMM2}}}
creators[devices.ACNIP]             = {"Comms::avACNIP"}
creators[devices.DECS]              = {"BlackBox::avDECS"}
creators[devices.ADC]               = {"BlackBox::avADC"}
creators[devices.NAV_INS]           = {"BlackBox::avNAVINS",		
										LockOn_Options.script_path.."Scripts/BlackBoxes/ASN_130A.lua",
										{{"COM1", devices.COMM1}, 
										{"COM2", devices.COMM2},
										{"GD_AMC", devices.MSC},
										{"UFC_CTRL", devices.UFCCONTROL}} }
creators[devices.MSC]               = {"BlackBox::avMSC",		
										LockOn_Options.script_path.."Scripts/BlackBoxes/MSC.lua", 
										{{"AGM65X", devices.TVWPNS}, 
										{"ARBS", devices.DMT}, 
										{"AAQ_28", devices.TGTPOD}, 
										{"NAVFLIR", devices.NAVFLIR},
										{"ASN_139", devices.NAV_INS}, 
										{"EHSD_MAP", devices.EHSD_MAP},
										{"ARM_CTRL", devices.SMC}} }
creators[devices.VREST]             = {"BlackBox::avVREST"}
creators[devices.NAVFLIR]			= {"sensors::avFLIR"}
creators[devices.TGTPOD]			= {"sensors::avTPOD",
										LockOn_Options.script_path.."Scripts/TPOD/AAQ28.lua"}
creators[devices.DMT]				= {"sensors::avDMT",
										LockOn_Options.script_path.."Scripts/DMTS/DMT_init.lua"}
creators[devices.RWR]				= {"sensors::avEWS_RWR", 		
										LockOn_Options.script_path.."Scripts/EWS/RWR_init.lua", 
										{{"ELECTRIC",devices.ELECTRIC}} }
creators[devices.RWRCONTROL]        = {"sensors::avEWS_ALR67V2", nil,
										{{"ALR_67", devices.RWR}} }
creators[devices.FLIGHTCONTROLS]    = {"Systems::avFlightControls"}
creators[devices.SMC]               = {"Systems::avSMC", nil,
										{{"TGT_POD", devices.TGTPOD}, 
										{"NAVFLIR", devices.NAVFLIR}, 
										{"ARBS", devices.DMT}, 
										{"GD_AMC", devices.MSC},
										{"AGM65X", devices.TVWPNS}}}
creators[devices.EWS]               = {"Systems::avEWS",
										LockOn_Options.script_path.."Scripts/EWS/EW_Dispensers_init.lua"}
creators[devices.CBTSYST]           = {"Systems::avCBTSYS",
										LockOn_Options.script_path.."Scripts/BlackBoxes/CBTSYS.lua", 
										{{"TGT_POD", devices.TGTPOD}, 
										{"NAVFLIR", devices.NAVFLIR}, 
										{"ARBS", devices.DMT},
										{"AGM65X", devices.TVWPNS}} }
creators[devices.TVWPNS]			= {"Systems::avAGM65X",	
										LockOn_Options.script_path.."Scripts/IRMAV/AGM65F.lua", 
										{{"AAQ_28", devices.TGTPOD}, 
										{"NAVFLIR", devices.NAVFLIR}, 
										{"ARBS", devices.DMT}} }
creators[devices.LTEXT]             = {"Systems::avLights_Ext"}
creators[devices.LTINT]             = {"Systems::avLights_Int",	
										LockOn_Options.script_path.."Scripts/LTS/INT_LTS_init.lua"}
creators[devices.LTWCA]             = {"Systems::avLights_WCA"}
creators[devices.ECS]               = {"Systems::avECS"}
creators[devices.HYDRAULIC]         = {"Systems::avHydraulic"}
creators[devices.ATHS]				= {"Systems::avATHS_Ctrl"}
creators[devices.FLIGHTINSTRUMENTS] = {"Instruments::avFlightInst"}
creators[devices.EDP]               = {"Instruments::avEDP"}
creators[devices.FQIS]              = {"Instruments::avFQIS"}
creators[devices.HUDCONTROL]        = {"Instruments::avHUD"}
creators[devices.UFCCONTROL]        = {"Instruments::avUFC", nil, 
										{{"COM1", devices.COMM1}, 
										{"COM2", devices.COMM2}, 
										{"ASN_139", devices.NAV_INS},
										{"GD_AMC", devices.MSC},
										{"ACP_CTRL", devices.SMC},
										{"AAQ_28", devices.TGTPOD},
										{"ARBS", devices.DMT},
										{"ATHS", devices.ATHS} }}
creators[devices.ODUCONTROL]        = {"Instruments::avODU", nil, 
										{{"COM1", devices.COMM1}, 
										{"COM2", devices.COMM2}, 
										{"UFC_CTRL", devices.UFCCONTROL},
										{"ACP_CTRL", devices.SMC},
										{"ASN_139", devices.NAV_INS},
										{"ATHS", devices.ATHS} }}
creators[devices.EHSD_MAP]			= {"Instruments::avEHSD_Map",
										LockOn_Options.script_path.."MPCD/device/EHSD_MAP_init.lua"}
creators[devices.MPCD_LEFT]			= {"Instruments::avMPCD",	
										LockOn_Options.script_path.."MPCD/device/MPCDL_Device.lua", 
										{{"AAQ_28", devices.TGTPOD}, 
										{"ASN_139", devices.NAV_INS}, 
										{"NAVFLIR", devices.NAVFLIR}, 
										{"AGM65X", devices.TVWPNS},
										{"EHSD_MAP", devices.EHSD_MAP},
										{"UFC_CTRL", devices.UFCCONTROL},
										{"ATHS", devices.ATHS},
										{"GD_AMC", devices.MSC},
										{"ARM_CTRL", devices.SMC},
										{"DMG_CTRL", devices.DAMAGE_CONTROL}} }
creators[devices.MPCD_RIGHT]		= {"Instruments::avMPCD",	
										LockOn_Options.script_path.."MPCD/device/MPCDR_Device.lua", 
										{{"AAQ_28", devices.TGTPOD}, 
										{"ASN_139", devices.NAV_INS}, 
										{"NAVFLIR", devices.NAVFLIR}, 
										{"AGM65X", devices.TVWPNS},
										{"EHSD_MAP", devices.EHSD_MAP},
										{"UFC_CTRL", devices.UFCCONTROL},
										{"ATHS", devices.ATHS},
										{"GD_AMC", devices.MSC},
										{"ARM_CTRL", devices.SMC},
										{"DMG_CTRL", devices.DAMAGE_CONTROL}} }
creators[devices.NETWORKINTERFACE]  = {"avAV8BNetworkInterface"}
creators[devices.ANVIS9] 			= {"Helmet::ANVIS9"}
creators[devices.AUTOSTART]		    = {"Systems::avAutoStart",nil,
								      {{"FLIGHTCONTROLS",devices.FLIGHTCONTROLS},
								       {"ELECTRIC", devices.ELECTRIC},
								       {"DECS", devices.DECS},
									   {"ECS", devices.ECS},
									   {"LTEXT", devices.LTEXT},
									   {"LTINT", devices.LTINT},
									   {"LTWCA", devices.LTWCA},
									   {"SMC", devices.SMC},
									   {"NAVFLIR", devices.NAVFLIR},
									   {"DMT", devices.DMT},
									   {"NAV_INS", devices.NAV_INS},
									   {"MSC", devices.MSC},
									   {"RWRCONTROL", devices.RWRCONTROL},
									   {"EWS", devices.EWS},
									   {"EDP", devices.EDP},
									   {"FQIS", devices.FQIS},
									   {"MPCD_LEFT", devices.MPCD_LEFT},
									   {"MPCD_RIGHT", devices.MPCD_RIGHT},
									   {"HUDCONTROL", devices.HUDCONTROL},
									   {"UFCCONTROL", devices.UFCCONTROL},
								       {"VREST", devices.VREST},
								       {"INTERCOM", devices.INTERCOM}}}
creators[devices.DAMAGE_CONTROL] 	= {"Systems::avDmgCtl", 
										LockOn_Options.script_path.."Scripts/DMG_CTRL.lua"}
creators[devices.IRHSD]				= {"sensors::avIRHSD"}
creators[devices.DATAPARAMS]		= {"BlackBox::avDataParams"}

									   
-- Indicators --
-- indicators[#indicators + 1]  =  {class_name, init_lua_file, controller_id, optional_geometry_reference, optional_links_table}
indicators                          = {}
--- HUD ---
indicators[#indicators + 1] = { "Displays::ccHUDM",			LockOn_Options.script_path.."HUD/indicator/HUD_init.lua",		nil,				
								{{"PNT_HUD_CENTER", "PNT_HUD_DOWN", "PNT_HUD_RIGHT"}, {rz_l = 7.1}}, 
								{{"NAVFLIR", devices.NAVFLIR}, 
								{"ARBS", devices.DMT}, 
								{"ALR_67", devices.RWR},
								{"IRHSD", devices.IRHSD},
								{"WPN_CTRL", devices.SMC},
								{"TGT_CTRL", devices.CBTSYST}} }
								
-- HUD Repeaters --
indicators[#indicators + 1] = { "Displays::ccHUDRL",			LockOn_Options.script_path.."MPCD/indicator/HUD/HUD_L_init.lua",	nil,
								{{"PNT_MFD1_CENTER", "PNT_MFD1_DOWN", "PNT_MFD1_RIGHT"}},
								{{"NAVFLIR", devices.NAVFLIR}, 
								{"ARBS", devices.DMT}, 
								{"ALR_67", devices.RWR},
								{"IRHSD", devices.IRHSD},
								{"WPN_CTRL", devices.SMC},
								{"TGT_CTRL", devices.CBTSYST}} }
								
indicators[#indicators + 1] = { "Displays::ccHUDRR",			LockOn_Options.script_path.."MPCD/indicator/HUD/HUD_R_init.lua",	nil,
								{{"PNT_MFD2_CENTER", "PNT_MFD2_DOWN", "PNT_MFD2_RIGHT"}},
								{{"NAVFLIR", devices.NAVFLIR}, 
								{"ARBS", devices.DMT}, 
								{"ALR_67", devices.RWR},
								{"IRHSD", devices.IRHSD},
								{"WPN_CTRL", devices.SMC},
								{"TGT_CTRL", devices.CBTSYST}} }
								
-- MPCDs ---
indicators[#indicators + 1] = { "Displays::ccMPCDL",		LockOn_Options.script_path.."MPCD/indicator/MPCDL_init.lua",	devices.MPCD_LEFT,	
								{{"PNT_MFD1_CENTER", "PNT_MFD1_DOWN", "PNT_MFD1_RIGHT"}}, 
								{{"TGT_POD", devices.TGTPOD}, 
								{"NAVFLIR", devices.NAVFLIR}, 
								{"IRHSD", devices.IRHSD}, 
								{"ARBS", devices.DMT}, 
								{"AGM65X", devices.TVWPNS}, 
								{"ASN_139", devices.NAV_INS}, 
								{"EHSD_MAP", devices.EHSD_MAP}} }
								
indicators[#indicators + 1] = { "Displays::ccMPCDR",		LockOn_Options.script_path.."MPCD/indicator/MPCDR_init.lua",	devices.MPCD_RIGHT,	
								{{"PNT_MFD2_CENTER", "PNT_MFD2_DOWN", "PNT_MFD2_RIGHT"}}, 
								{{"TGT_POD", devices.TGTPOD}, 
								{"NAVFLIR", devices.NAVFLIR}, 
								{"IRHSD", devices.IRHSD}, 
								{"ARBS", devices.DMT}, 
								{"ASN_139", devices.NAV_INS}, 
								{"EHSD_MAP", devices.EHSD_MAP}} }

-- Other Displays --
indicators[#indicators + 1] = { "Displays::ccUFC",			LockOn_Options.script_path.."UFC/indicator/UFC_init.lua",		nil,				
								{{"PNT_UFC_CENTER", "PNT_UFC_DOWN", "PNT_UFC_RIGHT"}} }
indicators[#indicators + 1] = { "Displays::ccODU",			LockOn_Options.script_path.."ODU/indicator/ODU_init.lua",		nil,				
								{{"PNT_ODU_CENTER", "PNT_ODU_DOWN", "PNT_ODU_RIGHT"}} }
indicators[#indicators + 1] = { "Displays::ccUVHF",			LockOn_Options.script_path.."UVHF/indicator/UVHF_init.lua",		nil,				
								{{"PNT_RADIO_CENTER", "PNT_RADIO_DOWN", "PNT_RADIO_RIGHT"}} }
-- Indicators --
indicators[#indicators + 1] = { "ccControlsIndicatorAV8B",	LockOn_Options.script_path.."ControlsIndicator/ControlsIndicator.lua"}


kneeboard_implementation 		= "ccKBExt_AV8BNA"
disable_kneeboard_render_target = false
---------------------------------------------
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
---------------------------------------------
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
---------------------------------------------
