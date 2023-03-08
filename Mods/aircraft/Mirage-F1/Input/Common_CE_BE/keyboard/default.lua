local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common/keyboard/default.lua")

join(res.keyCommands,{

----------------------------------------------------------------
-- Navigation indicator

-- Mode selector switch
{combos = {}, down = devCmds.Cmd556, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode selector switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd556, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode selector switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Normal/Additional vector selector switch
{combos = {}, down = devCmds.Cmd557, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Normal/Additional vector selector switch - VECT. ADD.'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd557, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Normal/Additional vector selector switch - NORMAL'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Additional target selector switch
{combos = {}, down = devCmds.Cmd558, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Additional target selector switch - Clockwise'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd558, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Additional target selector switch - Counterclockwise'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Bearing/Distance selector knob
{combos = {}, pressed = devCmds.Cmd559, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Bearing/Distance selector knob - Clockwise'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, pressed = devCmds.Cmd559, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Bearing/Distance selector knob - Counterclockwise'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Test button
{combos = {}, down = devCmds.Cmd560, up = devCmds.Cmd560, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Test button'), category = {_('Central front panel'), _('Navigation indicator')}},

----------------------------------------------------------------
-- MATRA 550 or Sidewinder jettisoning

-- MATRA 550 or Sidewinder jettison button guard
{combos = {{key = '`', reformers = {"LCtrl", "LShift"}}}, down = devCmds.Cmd561, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('MATRA 550 or Sidewinder jettison button guard - OPEN'), category = {_('Central front panel'), _('Armament system')}},
{combos = {{key = '`', reformers = {"LCtrl", "LAlt"}}}, down = devCmds.Cmd561, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('MATRA 550 or Sidewinder jettison button guard - CLOSE'), category = {_('Central front panel'), _('Armament system')}},
-- MATRA 550 or Sidewinder jettison button
{combos = {{key = '`'}}, down = devCmds.Cmd562, up = devCmds.Cmd562, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('MATRA 550 or Sidewinder jettison button'), category = {_('Central front panel'), _('Armament system')}},

----------------------------------------------------------------
-- Radar detector indicator

-- Indicator lights intensity adjusting switch and lights 'T' test button
{combos = {}, down = devCmds.Cmd573, up = devCmds.Cmd573, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Indicator lights T test button'), category = {_('Central front panel'), _('Radar detector')}},
-- Indicator lights intensity adjusting switch
{combos = {}, pressed = devCmds.Cmd575, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Indicator lights intensity adjusting switch - MINUS'), category = {_('Central front panel'), _('Radar detector')}},
{combos = {}, pressed = devCmds.Cmd575, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Indicator lights intensity adjusting switch - PLUS'), category = {_('Central front panel'), _('Radar detector')}},
-- Radar detector indicator test switch
{combos = {}, down = devCmds.Cmd576, up = devCmds.Cmd576, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Radar detector indicator test switch - PULSE'), category = {_('Central front panel'), _('Radar detector')}},
{combos = {}, down = devCmds.Cmd577, up = devCmds.Cmd577, cockpit_device_id = devices.MAIN ,value_down = -1.0, value_up = 0.0, name = _('Radar detector indicator test switch - CW'), category = {_('Central front panel'), _('Radar detector')}},

----------------------------------------------------------------
-- UHF radio

-- 5W/25W selector switch
{combos = {}, down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('5W/25W selector switch - 5W'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{combos = {}, down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('5W/25W selector switch - 25W'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Squelch switch
{combos = {}, down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Squelch switch - ON'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{combos = {}, down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Squelch switch - OFF'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Test selector switch
{combos = {}, down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio test selector switch - E+A2'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{combos = {}, down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('UHF radio test selector switch - R'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- CDE button (not used)
{combos = {}, down = devCmds.Cmd458, up = devCmds.Cmd458, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('CDE button (not used)'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Function selector
{combos = {}, down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio function selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{combos = {}, down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio function selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Test light - commented as it is just a light
--{combos = {}, down = devCmds.Cmd461, up = devCmds.Cmd461, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Test light'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Channel selector
{combos = {}, down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio channel selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{combos = {}, down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio channel selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},

-- Jammer detection light
{combos = {}, down = devCmds.Cmd291, up = devCmds.Cmd291, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Jammer detection light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{combos = {}, pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Jammer detection light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{combos = {}, pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Jammer detection light - Decrease'), category = {_('Central front panel'), _('Warnings')}},


})

return res
