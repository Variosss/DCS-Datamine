
dofile(LockOn_Options.script_path.."../../Common/devices.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

mount_vfs_path_to_mount_point("/shaders/", LockOn_Options.script_path.."../../../shaders")
--mount_vfs_path_to_mount_point("/fxo/", LockOn_Options.script_path.."../../../fxo")

function writeParameter(name, value)
	local param = get_param_handle(name)
	if param ~= nil then
		param:set(value)
	end
end

if not layoutGeometry then 
   layoutGeometry = {}
end

if not creators then 
   creators = {}
end

if not indicators then 
   indicators = {}
end


function createMainPanel(className, script)
	MainPanel = {className, script}
end

function createDeviceMain(className)
	creators[devices.MAIN] = {className}
end

dbgDisableAllIndicators = false

creators[devices.HELMET] 				= {"ABase::Helmet", LockOn_Options.script_path.."../../Common/Helmet/Helmet_config_sglseat.lua"}
creators[devices.AUTOSTART] 			= {"F1cmn::F1Autostart", LockOn_Options.common_script_path.."Macro_handler.lua"}
--creators[devices.INTERCOM] 				= {"F1cmn::F1Intercom"}
creators[devices.OXY_SYS_STARV_IMPL] 	= {"F1cmn::F1OxySysStarvationImpl"}
creators[devices.TRAP136]     			= {"F1cmn::F1_VUHF_TRAP136", LockOn_Options.script_path.."../../Common/Comm/TRAP136.lua"}
--creators[devices.TRAP137B]     		= {"F1cmn::F1CE_BE_EE::F1_UHF_TRAP137B", LockOn_Options.script_path.."../../Common/Comm/TRAP137B.lua"}

if dbgDisableAllIndicators == true then
	return
end

indicators[#indicators + 1] = {"ABase::HelmetAnimation", LockOn_Options.script_path.."../../Common/Helmet/Helmet_init.lua", devices.HELMET}
indicators[#indicators + 1] = {"ABase::ControlsIndicator", LockOn_Options.script_path.."../../Common/ControlsIndicator/ControlsIndicator.lua"}

dofile(LockOn_Options.common_script_path.."KNEEBOARD/declare_kneeboard_device.lua")
dofile(LockOn_Options.common_script_path.."PADLOCK/PADLOCK_declare.lua")
