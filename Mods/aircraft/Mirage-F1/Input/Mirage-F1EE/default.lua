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
-- Inertial Navigation System (INS)

-- Parameters selector
addInputEntryKey({down = devCmds.Cmd680, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Parameters selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}})
addInputEntryKey({down = devCmds.Cmd680, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Parameters selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}})
-- Modes selector
addInputEntryKey({down = devCmds.Cmd681, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Modes selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}})
addInputEntryKey({down = devCmds.Cmd681, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Modes selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}})
-- Waypoints selecting wheel
addInputEntryKey({down = devCmds.Cmd682, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Waypoints selecting wheel - Increase'), category = {_('Central front panel'), _('Inertial navigation system')}})
addInputEntryKey({down = devCmds.Cmd682, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Waypoints selecting wheel - Decrease'), category = {_('Central front panel'), _('Inertial navigation system')}})
-- Lights test and brightness selector
addInputEntryKey({down = devCmds.Cmd683, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Lights test and brightness selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}})
addInputEntryKey({down = devCmds.Cmd683, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Lights test and brightness selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}})
-- Vertical designation button
addInputEntryKey({down = devCmds.Cmd696, up = devCmds.Cmd696, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Vertical designation button'), category = {_('Right console'), _('Inertial navigation system')}})
-- Position validation button
addInputEntryKey({down = devCmds.Cmd697, up = devCmds.Cmd697, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Position validation button'), category = {_('Right console'), _('Inertial navigation system')}})
-- Data insertion button
addInputEntryKey({down = devCmds.Cmd698, up = devCmds.Cmd698, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Data insertion button'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS - 1 pushbutton
addInputEntryKey({down = devCmds.Cmd685, up = devCmds.Cmd685, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS - 1 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS N 2 pushbutton
addInputEntryKey({down = devCmds.Cmd686, up = devCmds.Cmd686, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS N 2 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS + 3 pushbutton
addInputEntryKey({down = devCmds.Cmd687, up = devCmds.Cmd687, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS + 3 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS W 4 pushbutton
addInputEntryKey({down = devCmds.Cmd688, up = devCmds.Cmd688, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS W 4 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 5 pushbutton
addInputEntryKey({down = devCmds.Cmd689, up = devCmds.Cmd689, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 5 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 6 E pushbutton
addInputEntryKey({down = devCmds.Cmd690, up = devCmds.Cmd690, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 6 E pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 7 pushbutton
addInputEntryKey({down = devCmds.Cmd691, up = devCmds.Cmd691, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 7 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 8 S pushbutton
addInputEntryKey({down = devCmds.Cmd692, up = devCmds.Cmd692, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 8 S pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 9 pushbutton
addInputEntryKey({down = devCmds.Cmd693, up = devCmds.Cmd693, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 9 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS * pushbutton
addInputEntryKey({down = devCmds.Cmd695, up = devCmds.Cmd695, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS * pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS 0 pushbutton
addInputEntryKey({down = devCmds.Cmd684, up = devCmds.Cmd684, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 0 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})
-- INS CLR pushbutton
addInputEntryKey({down = devCmds.Cmd694, up = devCmds.Cmd694, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS CLR pushbutton'), category = {_('Right console'), _('Inertial navigation system')}})


local resJoint = external_profile(folder.."../../default_EE_M.lua")
local resUHF = external_profile(folder.."../../default_UHF_TRAP_137B.lua")

join(resJoint.keyCommands, res.keyCommands)
join(resJoint.keyCommands, resUHF.keyCommands)

if isJoystick(deviceName) then
	join(resJoint.axisCommands, res.axisCommands)
	join(resJoint.axisCommands, resUHF.axisCommands)
end

return resJoint
