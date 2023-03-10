local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
dofile(folder.."../../input_tools.lua")

local res
if isJoystick(deviceName) then
	res = {keyCommands = {}, axisCommands = {}}
else
	res = {keyCommands = {}}
end
	
local function addInputEntryKey(defs, keyb_combos, joy_combos)
	addInputEntryKeyCmn(res.keyCommands, deviceName, defs, keyb_combos, joy_combos)
end

local function addInputEntryAxis(defs, combos)
	addInputEntryAxisCmn(res.axisCommands, deviceName, defs, combos)
end

----------------------------------------------------------------
-- UHF radio

-- 5W/25W selector switch
addInputEntryKey({down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('5W/25W selector switch - 5W'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('5W/25W selector switch - 25W'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- Squelch switch
addInputEntryKey({down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Squelch switch - ON'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Squelch switch - OFF'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- Test selector switch
addInputEntryKey({down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio test selector switch - E+A2'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('UHF radio test selector switch - R'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- CDE button (not used)
addInputEntryKey({down = devCmds.Cmd458, up = devCmds.Cmd458, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('CDE button (not used)'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- Function selector
addInputEntryKey({down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio function selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio function selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- Test light - commented as it is just a light
--addInputEntryKey({down = devCmds.Cmd461, up = devCmds.Cmd461, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Test light'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
-- Channel selector
addInputEntryKey({down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio channel selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})
addInputEntryKey({down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio channel selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio control unit')}})


return res
