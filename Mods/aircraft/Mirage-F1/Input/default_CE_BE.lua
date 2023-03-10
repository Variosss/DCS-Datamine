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
-- Warning lights

-- Master failure warning light
addInputEntryKey({down = devCmds.Cmd265, up = devCmds.Cmd265, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Master failure warning light'), category = {_('Central front panel'), _('Warnings')}},
	{{key = 'M', reformers = {"LShift"}}})
-- Fire warning light (ENG/AB) + Horn
addInputEntryKey({down = devCmds.Cmd277, up = devCmds.Cmd277, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fire warning light (ENG/AB) + Horn'), category = {_('Central front panel'), _('Warnings')}})


----------------------------------------------------------------
-- Navigation indicator

-- Mode selector switch
addInputEntryKey({down = devCmds.Cmd556, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode selector switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd556, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode selector switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Normal/Additional vector selector switch
addInputEntryKey({down = devCmds.Cmd557, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Normal/Additional vector selector switch - VECT. ADD.'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd557, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Normal/Additional vector selector switch - NORMAL'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Additional target selector switch
addInputEntryKey({down = devCmds.Cmd558, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Additional target selector switch - Clockwise'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd558, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Additional target selector switch - Counterclockwise'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Bearing/Distance selector knob
addInputEntryKey({pressed = devCmds.Cmd559, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Bearing/Distance selector knob - Clockwise'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({pressed = devCmds.Cmd559, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Bearing/Distance selector knob - Counterclockwise'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Test button
addInputEntryKey({down = devCmds.Cmd560, up = devCmds.Cmd560, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Test button'), category = {_('Central front panel'), _('Navigation indicator')}})

----------------------------------------------------------------
-- MATRA 550 or Sidewinder jettisoning

-- MATRA 550 or Sidewinder jettison button guard
addInputEntryKey({down = devCmds.Cmd561, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('MATRA 550 or Sidewinder jettison button guard - OPEN'), category = {_('Central front panel'), _('Armament system')}},
	{{key = '`', reformers = {"LCtrl", "LShift"}}})
addInputEntryKey({down = devCmds.Cmd561, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('MATRA 550 or Sidewinder jettison button guard - CLOSE'), category = {_('Central front panel'), _('Armament system')}},
	{{key = '`', reformers = {"LCtrl", "LAlt"}}})
-- MATRA 550 or Sidewinder jettison button
addInputEntryKey({down = devCmds.Cmd562, up = devCmds.Cmd562, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('MATRA 550 or Sidewinder jettison button'), category = {_('Central front panel'), _('Armament system')}},
	{{key = '`'}})

----------------------------------------------------------------
-- Radar detector indicator

-- Indicator lights intensity adjusting switch and lights 'T' test button
addInputEntryKey({down = devCmds.Cmd573, up = devCmds.Cmd573, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Indicator lights T test button'), category = {_('Central front panel'), _('Radar detector')}})
-- Indicator lights intensity adjusting switch
addInputEntryKey({pressed = devCmds.Cmd575, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Indicator lights intensity adjusting switch - MINUS'), category = {_('Central front panel'), _('Radar detector')}})
addInputEntryKey({pressed = devCmds.Cmd575, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Indicator lights intensity adjusting switch - PLUS'), category = {_('Central front panel'), _('Radar detector')}})
-- Radar detector indicator test switch
addInputEntryKey({down = devCmds.Cmd576, up = devCmds.Cmd576, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar detector indicator test switch - PULSE'), category = {_('Central front panel'), _('Radar detector')}})
addInputEntryKey({down = devCmds.Cmd577, up = devCmds.Cmd577, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Radar detector indicator test switch - CW'), category = {_('Central front panel'), _('Radar detector')}})

-- Jammer detection light
addInputEntryKey({down = devCmds.Cmd291, up = devCmds.Cmd291, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Jammer detection light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Jammer detection light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Jammer detection light - Decrease'), category = {_('Central front panel'), _('Warnings')}})


----------------------------------------------------------------

local resJoint = external_profile(folder.."../../default_cmn.lua")
local resUHF = external_profile(folder.."../../default_UHF_TRAP_137B.lua")

join(resJoint.keyCommands, res.keyCommands)
join(resJoint.keyCommands, resUHF.keyCommands)

if isJoystick(deviceName) then
	join(resJoint.axisCommands, res.axisCommands)
	join(resJoint.axisCommands, resUHF.axisCommands)
end

return resJoint
