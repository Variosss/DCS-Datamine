mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")

dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."sounds.lua")
dofile(LockOn_Options.script_path.."sounds_init.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

UseDBGInfo = false

layoutGeometry = {}

MainPanel = {"ccMainPanel",
			LockOn_Options.script_path.."mainpanel_init.lua"
					}


creators = {}

creators[devices.PROXY] = {"avLuaDevice", LockOn_Options.script_path.."proxy_device.lua"}

creators[devices.SENSORS] = {"CommonAvionics::SensorsDevice","",{}}
creators[devices.FMSENSOR] = {"F14Avionics::FMSensor","",{}}
creators[devices.MULTICREW] = {"F14Avionics::MultiCrew","",{}}
creators[devices.JESTERAI] = {"F14Avionics::JesterAI",LockOn_Options.script_path.."Scripts/JesterAI/Jester.lua",{}}


--Systems
creators[devices.BITPANEL] = {"F14Avionics::BITPanel","",{}}

creators[devices.COCKPITMECHANICS] = {"F14Avionics::CockpitMechanics",LockOn_Options.script_path.."Scripts/CockpitMechanics/CockpitMechanics.lua",{}}
creators[devices.HYDRAULICS] = {"F14Avionics::Hydraulics","",{}}
creators[devices.AICS] = {"F14Avionics::AICS","",{}}
creators[devices.ELECTRICS] = {"F14Avionics::Electrics","",{}}
creators[devices.PNEUMATICS] = {"F14Avionics::Pneumatics","",{}}

creators[devices.WINGSWEEP] = {"F14Avionics::WingSweep","",{}}
creators[devices.GEARHOOK] = {"F14Avionics::GearAndHook",LockOn_Options.script_path.."Scripts/GearAndHook/GearAndHook.lua",{}}
creators[devices.FLAPS] = {"F14Avionics::Flaps","",{}}

creators[devices.ENGINE] = {"F14Avionics::Engine", LockOn_Options.script_path.."Scripts/Engine/Device/Engine.lua",{}}
creators[devices.FUELSYSTEM] = {"F14Avionics::FuelSystem","",{}}
creators[devices.FIRE] = {"F14Avionics::Fire","",{}}

creators[devices.AFCS] = {"F14Avionics::AFCS","",{}}
creators[devices.CADC] = {"F14Avionics::CADC", LockOn_Options.script_path.."Scripts/CADC/Device/CADC.lua", {}}
creators[devices.CAP] = {"F14Avionics::CAP","",{}}

creators[devices.HOTAS] = {"F14Avionics::HOTAS","",{}}
creators[devices.HCU] = {"F14Avionics::HCU","",{}}

creators[devices.TCS] = {"F14Avionics::TCS","",{}}
creators[devices.LANTIRN] = {"F14Avionics::LANTIRN","",{}}
creators[devices.RADAR] = {"F14Avionics::Radar",LockOn_Options.script_path.."Scripts/Radar/Radar.lua",{}}
creators[devices.TID] = {"F14Avionics::TID",LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/TID.lua",{}}

--Instruments
creators[devices.ACCELEROMETER] = {"F14Avionics::Accelerometer","",{}}
creators[devices.AOASYSTEM] = {"F14Avionics::AngleOfAttackSystem","",{}}
creators[devices.CLOCK] = {"F14Avionics::Clock","",{}}
creators[devices.MACHANDAIRSPEED] = {"F14Avionics::MachAndAirspeedIndicator","",{}}
creators[devices.BAROALTIMETER] = {"F14Avionics::ServoedBarometricAltimeter","",{}}
creators[devices.RADARALTIMETER] = {"F14Avionics::RadarAltimeter","",{}}
creators[devices.STDBYAI] = {"F14Avionics::StandbyAttitudeIndicator","",{}}
creators[devices.TURNANDSLIP] = {"F14Avionics::TurnAndSlipIndicator","",{}}
creators[devices.VERTICALVEL] = {"F14Avionics::VerticalVelocityIndicator","",{}}
creators[devices.STANDBYCOMPASS] = {"F14Avionics::StandbyCompass","",{}}

creators[devices.WARNINGLIGHTS] = {"F14Avionics::WarningLightsPanel","",{}}

creators[devices.FCINSTRUMENTS] = {"F14Avionics::FlightControlInstruments","",{}}


creators[devices.BDHI] = {"F14Avionics::BDHI","",{}}

--Displays & hud
creators[devices.HUD] = {"F14Avionics::HUD",LockOn_Options.script_path.."Scripts/HeadUpDisplay/HUD.lua",{}}
creators[devices.HSD] = {"F14Avionics::HSD","",{}}
creators[devices.VDI] = {"F14Avionics::VDI",LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/VDI.lua",{}}
creators[devices.ECMD] = {"F14Avionics::ECMD","",{}}
creators[devices.HELMET_DEVICE]    = {"avNightVisionGoggles"}

--ECM
creators[devices.DECM] = {"F14Avionics::DECM","",{}}
creators[devices.COUNTERMEASURES] = {"F14Avionics::Countermeasures",LockOn_Options.script_path.."Scripts/Countermeasures/ALE39/ALE39.lua",{}}
creators[devices.RWR] = {"F14Avionics::ALR67",LockOn_Options.script_path.."Scripts/RWR/ALR67/ALR67.lua",{}}

--Nav
creators[devices.NAV_INTERFACE] = {"F14Avionics::NAV_Interface","",{}}
creators[devices.TACAN] = {"F14Avionics::TACAN",LockOn_Options.script_path.."Scripts/TACAN/TACAN.lua",{}}
creators[devices.ILS] = {"F14Avionics::AN_ARA63",LockOn_Options.script_path.."Scripts/ILS/ILS.lua",{}}
creators[devices.IMU] = {"F14Avionics::AN_ASN90",LockOn_Options.script_path.."Scripts/NAV/AN_ASN90.lua",{}}
creators[devices.INS] = {"F14Avionics::AN_ASN92",LockOn_Options.script_path.."Scripts/NAV/AN_ASN92.lua",{}}
creators[devices.AHRS] = {"F14Avionics::A_A24G39",LockOn_Options.script_path.."Scripts/NAV/A_A24G39.lua",{}}

--Radios
creators[devices.DATALINK] = {"F14Avionics::DataLink","",{}}
creators[devices.ICS] = {"F14Avionics::ICS", LockOn_Options.script_path.."Scripts/ICS/Device/init.lua", {}}
--creators[devices.ICSRADIO] = {"F14Avionics::ICSRadio", LockOn_Options.script_path.."Scripts/ICSRadio/Device/init.lua", {}}
creators[devices.IFF] = {"F14Avionics::IFF","",{}}

creators[devices.ARC159] = {"F14Avionics::UHF_ARC_159", LockOn_Options.script_path.."Scripts/UHF_Radio/Device/UHF_Radio.lua", {}}
creators[devices.ARC182] = {"F14Avionics::VHF_ARC_182", LockOn_Options.script_path.."Scripts/VHF_Radio/Device/VHF_Radio.lua", {}}

--Weapons
creators[devices.WEAPONS] = {"F14Avionics::WeaponsSystem","",{}}
creators[devices.WCS] = {"F14Avionics::WCS","",{}}


--Extras
creators[devices.WALKMAN] = {"F14Avionics::Walkman","",{}}
creators[devices.EPOXY] = {"F14Avionics::ExportProxy","",{}}


--Debug
creators[devices.DEBUGDISPLAY] = {"F14Avionics::DebugDisplay","",{}}
creators[devices.CONTROLS] = {"F14Avionics::ControlsIndicator","",  {}}

creators[devices.AUTO] = {"F14Avionics::AutoStart","",  {}}

creators[devices.AUTOPILOT] = {"F14Avionics::Autopilot","",{}}
creators[devices.REPAIR_DEVICE] = {"F14Avionics::NeedsRepair","",{}}

--[[ indicator ]]
indicators = {}

indicators[#indicators + 1] = {"F14Avionics::ccHUD",LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/init.lua",devices.HUD,{{"PNT-HUD-CENTER"},{sx_l = 0.1,sy_l = 0.06516,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccHSD",LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/init.lua",devices.HSD,{{"PNT_HSDI_CENTER","PNT_HSDI_LOWER","PNT_HSDI_R"}}}
indicators[#indicators + 1] = {"F14Avionics::ccVDI",LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/init.lua",devices.VDI,{{"PNT_VDI","PNT_VDI_BOTTOM","PNT_VDI_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccTIDbowl",LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/init.lua",devices.TID,{{"PNT_TID_CENTR","PNT_TID_BOTTOM","PNT_TID_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccECMD",LockOn_Options.script_path.."Scripts/ElectronicCounterMeasureDisplay/Indicator/init.lua",devices.ECMD,{{"PNT_ECMD_CENTR","PNT_ECMD_BOTTOM","PNT_ECMD_RIGHT"},{sx_l = -0.001,sy_l = 0.001,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccDDD",LockOn_Options.script_path.."Scripts/DetailDataDisplay/Indicator/init.lua",devices.RADAR,{{"PNT_DDD_CENTRw","PNT_DDD_BOTTOM","PNT_DDD_RIGHT"},{sx_l = -0.001,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccControlsIndicator",LockOn_Options.script_path.."Scripts/ControlsIndicator/init.lua",devices.CONTROLS,{{""},{sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}}

indicators[#indicators + 1] = {"F14Avionics::ccJesterAI",LockOn_Options.script_path.."Scripts/JesterAI/init.lua",devices.JESTERAI,{{""},{sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}}
indicators[#indicators + 1] = {"F14Avionics::ccJesterAI",LockOn_Options.script_path.."Scripts/JesterAI/JesterLANTIRN/init.lua",devices.JESTERAI,{{""},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}}

-- UHF
indicators[#indicators + 1] = {"F14Avionics::ccARC159",LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/Main/init.lua",devices.ARC159,{{"PILOT_FREQ_CENTR","PILOT_FREQ_BOTTOM","PILOT_FREQ_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccARC159",LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/RemotePilot/init.lua",devices.ARC159,{{"MP_UHF_CENTR","MP_UHF_BOTTOM","MP_UHF_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccARC159",LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/RemoteRIO/init.lua",devices.ARC159,{{"RIO_REMOTE_FREQ_CENTER","RIO_REMOTE_FREQ_BOTTOM","RIO_REMOTE_FREQ_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccARC159",LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/FreqChart/init.lua",devices.ARC159,{{"PNT_WRITTEN_RADIO_MID","PNT_WRITTEN_RADIO_LOWER","PNT_WRITTEN_RADIO_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

-- VHF
indicators[#indicators + 1] = {"F14Avionics::ccARC182",LockOn_Options.script_path.."Scripts/VHF_Radio/Indicator/Main/init.lua",devices.ARC182,{{"RIO_FREQ_CENTR","RIO_FREQ_BOTTOM","RIO_FREQ_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccARC182",LockOn_Options.script_path.."Scripts/VHF_Radio/Indicator/RemotePilot/init.lua",devices.ARC182,{{"MP_VHFUHF_CENTR","MP_VHFUHF_BOTTOM","MP_VHFUHF_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

-- RWR
indicators[#indicators + 1] = {"F14Avionics::ccALR67",LockOn_Options.script_path.."Scripts/RWR/Indicator/Pilot/init.lua",devices.RWR,{{"PNT_PILOT_ALR_CENTER","PNT_PILOT_ALR_LOWER","PNT_PILOT_ALR_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccALR67",LockOn_Options.script_path.."Scripts/RWR/Indicator/RIO/init.lua",devices.RWR,{{"PNT_RIO_ALR_CENTER","PNT_RIO_ALR_LOWER","PNT_RIO_ALR_RIGHT"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

--
indicators[#indicators + 1] = {"F14Avionics::ccDebugDisplay",LockOn_Options.script_path.."Scripts/DebugDisplay/Indicator/init.lua",devices.DEBUGDISPLAY,{{"PNT-HUD-CENTER"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

indicators[#indicators + 1] = {"F14Avionics::ccVideoExport",LockOn_Options.script_path.."Scripts/VideoExport/init.lua",devices.TID,{{""},{sx_l = -75,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}}

-- EGIT
indicators[#indicators + 1] = {"F14Avionics::ccEGIT",LockOn_Options.script_path.."Scripts/EGIT/RPM/init.lua",devices.ENGINE,{{"PNT_EGT_RPM_CENTER","PNT_EGT_RPM_BOTTOM","PNT_EGT_RPM_RIGHT"},{sx_l = 0.0004,sy_l = 0.0002,sz_l = -0.0001,sh = 0,sw = 0, rz_l = 0, ry_l = 0,rx_l = 0}}}
indicators[#indicators + 1] = {"F14Avionics::ccEGIT",LockOn_Options.script_path.."Scripts/EGIT/EGT/init.lua",devices.ENGINE,{{"PNT_EGT_TIT_CENTER","PNT_EGT_TIT_BOTTOM","PNT_EGT_TIT_RIGHT"},{sx_l = 0.00033,sy_l = 0.0005,sz_l = 0,sh = 0,sw = 0,rz_l = 0, ry_l = 0,rx_l = -0.3}}} --rx_l = -0.25
indicators[#indicators + 1] = {"F14Avionics::ccEGIT",LockOn_Options.script_path.."Scripts/EGIT/FF/init.lua",devices.ENGINE,{{"PNT_EGT_FF_CENTER","PNT_EGT_FF_BOTTOM","PNT_EGT_FF_RIGHT"},{sx_l = 0.00072,sy_l = 0.0006,sz_l = 0,sh = 0,sw = 0, rz_l = 0, ry_l = 0,rx_l = -0.1}}} --sw = -0.25

--
kneeboard_implementation = "F14Avionics::ccKneeboardExt"
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")

--indicators[#indicators + 1] = {"ccIndicator",LockOn_Options.script_path.."dir/Indicator/init.lua",--init script
--  nil,--id of parent device
--  {
--	{}, -- initial geometry anchor , triple of connector names
--	{sx_l =  0,  -- center position correction in meters (forward , backward)
--	 sy_l =  0,  -- center position correction in meters (up , down)
--	 sz_l =  0,  -- center position correction in meters (left , right)
--	 sh   =  0,  -- half height correction
--	 sw   =  0,  -- half width correction
--	 rz_l =  0,  -- rotation corrections
--	 rx_l =  0,
--	 ry_l =  0}
--  }
--}
