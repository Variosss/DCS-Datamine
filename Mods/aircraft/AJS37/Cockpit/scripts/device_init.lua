mount_vfs_model_path(LockOn_Options.script_path.."../Resources/Model/Shape")
mount_vfs_texture_archives("Bazar/Textures/AvionicsCommon")
mount_vfs_texture_archives (LockOn_Options.script_path.."../Resources/Model/textures")
dofile(LockOn_Options.script_path.."devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")


 

layoutGeometry = {}
			
MainPanel = {"ccMainPanel",LockOn_Options.script_path.."mainpanel_init.lua"}
			 

creators    = {}
creators[devices.WEAPON_SYSTEM]	 = {"AJS37::VigWeaponsSystem","",{}}
creators[devices.CLOCK]			 = {"avAChS_1"			    ,LockOn_Options.script_path.."clock.lua"}
creators[devices.ELECTRIC_SYSTEM]= {"avSimpleElectricSystem",LockOn_Options.script_path.."Systems/electric_system.lua"}
creators[devices.LANDINGGEAR]	 = {"avLuaDevice",LockOn_Options.script_path.."Systems/landing_gear_system.lua"}
creators[devices.REVERSAL]		 = {"avLuaDevice",LockOn_Options.script_path.."Systems/reversal_system.lua"}
creators[devices.CANARDFLAPS]	 = {"avLuaDevice",LockOn_Options.script_path.."Systems/canard_flaps.lua"}
creators[devices.SPAK]			 = {"avLuaDevice",LockOn_Options.script_path.."Systems/spak.lua"}
creators[devices.WEAPON_SYS]	 = {"avLuaDevice",LockOn_Options.script_path .. "Systems/weap_commands.lua"}
creators[devices.AIRBRAKE]	 	 = {"avLuaDevice",LockOn_Options.script_path .. "Systems/airbrake.lua"}
creators[devices.NAVIGATION]	 = {"avLuaDevice",LockOn_Options.script_path .. "Systems/navigation.lua"}
creators[devices.ENGINE_MGMT]	 = {"avLuaDevice",LockOn_Options.script_path .. "Systems/engine_mgmt.lua"}
creators[devices.DEBUG]			 = {"avLuaDevice",LockOn_Options.script_path .. "Systems/debug.lua"}
creators[devices.EP13] = {"AJS37::TVDevice", LockOn_Options.script_path.."TV-Indicator/Device/init.lua",  {}}
creators[devices.RADAR] = {"AJS37::RadarDevice", LockOn_Options.script_path.."Radar/Device/init.lua",  {}}
creators[devices.LIGHTS] = {"AJS37::LightsPanel", LockOn_Options.script_path.."LightsPanel/Device/init.lua", {}}
creators[devices.ENGINEPANEL] = {"AJS37::EnginePanel", LockOn_Options.script_path.."EnginePanel/Device/init.lua", {}}
creators[devices.ELECTRICSYSTEM] = {"AJS37::ElectricSystem", LockOn_Options.script_path.."ElectricSystem/Device/init.lua", {}}
creators[devices.RADARALT] = {"AJS37::RadarAltimeter", LockOn_Options.script_path.."RadarAltimeter/Device/init.lua", {}}
creators[devices.DOPPLER] = {"AJS37::DopplerSystem", LockOn_Options.script_path.."DopplerSystem/Device/init.lua", {}}
creators[devices.FLIGHTDATAUNIT] = {"AJS37::FlightDataUnitPanel", LockOn_Options.script_path.."FlightDataUnitPanel/Device/init.lua", {}}
creators[devices.NAVIGATIONPANEL] = {"AJS37::NavigationPanel", LockOn_Options.script_path.."NavigationPanel/Device/init.lua", {}}
creators[devices.RWR] = {"AJS37::RWR", LockOn_Options.script_path.."RWR/Device/init.lua", {}}
creators[devices.HIGHALPHAWARNING] = {"AJS37::HighAlphaWarning", LockOn_Options.script_path.."HighAlphaWarning/Device/init.lua", {}}
creators[devices.ERRORPANEL] = {"AJS37::ErrorPanel", LockOn_Options.script_path.."ErrorPanel/Device/init.lua", {}}
creators[devices.MISSILECONTROLLER] = {"AJS37::MissileController", LockOn_Options.script_path.."MissileController/Device/init.lua", {}}
creators[devices.COUNTERMEASURE] = {"AJS37::Countermeasure", LockOn_Options.script_path.."CounterMeasure/Device/init.lua", {}}
creators[devices.FR22] = {"AJS37::FR22", LockOn_Options.script_path.."TestRadio2/Device/init.lua", {}}
creators[devices.FR24] = {"AJS37::FR24", LockOn_Options.script_path.."TestRadio/Device/init.lua", {}}
creators[devices.TESTINTERCOM] = {"AJS37::avTestIntercom", LockOn_Options.script_path.."TestIntercom/Device/init.lua", {}}
creators[devices.IFF] = {"AJS37::IFFPanel", LockOn_Options.script_path.."IFFPanel/Device/init.lua", {}}
--creators[devices.CONTROLS] = {"AJS37::avControlsIndicator", LockOn_Options.script_path.."ControlsIndicator\Indicator\ControlsIndicator.lua",  {}}
creators[devices.JOKER] = {"AJS37::Joker",LockOn_Options.script_path.."Joker/device/init.lua"}
creators[devices.WALKMAN] = {"AJS37::Walkman","",{}}
creators[devices.REPORTER] = {"AJS37::BugReporter","",{}}
creators[devices.KNEEBOARDINTERFACE] = {"AJS37::Kneeboard","",{}}

creators[devices.MISSIONGENERATOR] = {"AJS37::MissionGenerator","",{}}
creators[devices.MACROS]    =  {"avAutostartDevice",LockOn_Options.common_script_path.."Macro_handler.lua"}

creators[devices.HELMET_DEVICE]	= {"avNightVisionGoggles"}	


indicators = {}

 indicators[#indicators + 1] = {"AJS37::RadarIndicator" ,LockOn_Options.script_path.."Radar/Indicator/init.lua"  ,devices.RADAR,{{"PTR-CIcentr", "PTR-CIlower", "PTR-CIright"},
{sx_l =  -0.0005,  -- center position correction in meters (forward , backward)
sy_l =  0,  -- center position correction in meters (up , down)
sz_l =  0,  -- center position correction in meters (left , right)
sh   =  0,  -- half height correction 
 	 sw   =  0,  -- half width correction 
 	 rz_l =  -0.431,  -- rotation corrections  
 	 rx_l =  0,
 	 ry_l =  0}
   }} --TV-indicator (Ep13 for Maverick)
   
indicators[#indicators + 1] = {"AJS37::NavigationIndicator" ,LockOn_Options.script_path.."Destination/Indicator/init.lua"  ,nil,{{"PTR-DESTcentr","PTR-DESTlower","PTR-DESTright"},{sx_l = 0,sy_l = 0,sz_l = 0,sh = 0,sw = 0}}} --Destination indicator
indicators[#indicators + 1] = {"AJS37::NavigationIndicator" ,LockOn_Options.script_path.."Data/Indicator/init.lua"  ,nil,{{"PTR-DATAcentr1","PTR-DATAlower1","PTR-DATAright1"},{sx_l = 0.00,sy_l = -0.004,sz_l = -0.004,sh = 0.0,sw = 0.0}}} --Data indicator
indicators[#indicators + 1] = {"AJS37::TVIndicator" ,LockOn_Options.script_path.."TV-Indicator/Indicator/init.lua"  ,devices.EP13,{{"PTR-EP13centr","PTR-EP13lower","PTR-EP13right"},{sx_l = -0.01,sy_l = 0.00,sz_l = 0.0,sh = -0.0,sw = 0.0}}} --TV-indicator (Ep13 for Maverick)


indicators[#indicators + 1] = {"AJS37::ccControlsIndicator",LockOn_Options.script_path.."ControlsIndicator/Indicator/init.lua",devices.CONTROLS,{{""},{sx_l = -75,sy_l = 0,sz_l = 0,sh = 0.0,sw = 0.0}}} 
								
indicators[#indicators + 1] = {"AJS37::HUDIndicator" ,LockOn_Options.script_path.."HeadUpDisplay/Indicator/init.lua"  ,nil,nil} 
indicators[#indicators + 1] = {"AJS37::HUDIndicator" ,LockOn_Options.script_path.."HeadUpDisplayGlow/Indicator/init.lua"  ,nil,nil} 

kneeboard_implementation = "AJS37::KneeboardIndicator"
dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")