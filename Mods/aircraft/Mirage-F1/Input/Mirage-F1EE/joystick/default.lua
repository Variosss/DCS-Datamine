local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common_EE_M/joystick/default.lua")

join(res.keyCommands,{

----------------------------------------------------------------
-- UHF radio

-- 5W/25W selector switch
{down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('5W/25W selector switch - 5W'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{down = devCmds.Cmd455, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('5W/25W selector switch - 25W'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Squelch switch
{down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Squelch switch - ON'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{down = devCmds.Cmd456, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Squelch switch - OFF'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Test selector switch
{down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio test selector switch - E+A2'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{down = devCmds.Cmd457, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('UHF radio test selector switch - R'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- CDE button (not used)
{down = devCmds.Cmd458, up = devCmds.Cmd458, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('CDE button (not used)'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Function selector
{down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio function selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{down = devCmds.Cmd460, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio function selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Test light - commented as it is just a light
--{down = devCmds.Cmd461, up = devCmds.Cmd461, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Test light'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
-- Channel selector
{down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('UHF radio channel selector - Clockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},
{down = devCmds.Cmd463, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('UHF radio channel selector - Counterclockwise'), category = {_('Left console'), _('Radio system'), _('UHF radio')}},

----------------------------------------------------------------
-- Inertial Navigation System (INS)

-- Parameters selector
{down = devCmds.Cmd680, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Parameters selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}},
{down = devCmds.Cmd680, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Parameters selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}},
-- Modes selector
{down = devCmds.Cmd681, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Modes selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}},
{down = devCmds.Cmd681, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Modes selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}},
-- Waypoints selecting wheel
{down = devCmds.Cmd682, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Waypoints selecting wheel - Increase'), category = {_('Central front panel'), _('Inertial navigation system')}},
{down = devCmds.Cmd682, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Waypoints selecting wheel - Decrease'), category = {_('Central front panel'), _('Inertial navigation system')}},
-- Lights test and brightness selector
{down = devCmds.Cmd683, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Lights test and brightness selector - Clockwise'), category = {_('Right console'), _('Inertial navigation system')}},
{down = devCmds.Cmd683, cockpit_device_id  = devices.MAIN, value_down = -1.0, name = _('Lights test and brightness selector - Counterclockwise'), category = {_('Right console'), _('Inertial navigation system')}},
-- Vertical designation button
{down = devCmds.Cmd696, up = devCmds.Cmd696, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Vertical designation button'), category = {_('Right console'), _('Inertial navigation system')}},
-- Position validation button
{down = devCmds.Cmd697, up = devCmds.Cmd697, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Position validation button'), category = {_('Right console'), _('Inertial navigation system')}},
-- Data insertion button
{down = devCmds.Cmd698, up = devCmds.Cmd698, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Data insertion button'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS - 1 pushbutton
{down = devCmds.Cmd685, up = devCmds.Cmd685, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS - 1 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS N 2 pushbutton
{down = devCmds.Cmd686, up = devCmds.Cmd686, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS N 2 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS + 3 pushbutton
{down = devCmds.Cmd687, up = devCmds.Cmd687, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS + 3 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS W 4 pushbutton
{down = devCmds.Cmd688, up = devCmds.Cmd688, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS W 4 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 5 pushbutton
{down = devCmds.Cmd689, up = devCmds.Cmd689, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 5 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 6 E pushbutton
{down = devCmds.Cmd690, up = devCmds.Cmd690, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 6 E pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 7 pushbutton
{down = devCmds.Cmd691, up = devCmds.Cmd691, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 7 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 8 S pushbutton
{down = devCmds.Cmd692, up = devCmds.Cmd692, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 8 S pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 9 pushbutton
{down = devCmds.Cmd693, up = devCmds.Cmd693, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 9 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS * pushbutton
{down = devCmds.Cmd695, up = devCmds.Cmd695, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS * pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS 0 pushbutton
{down = devCmds.Cmd684, up = devCmds.Cmd684, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS 0 pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},
-- INS CLR pushbutton
{down = devCmds.Cmd694, up = devCmds.Cmd694, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('INS CLR pushbutton'), category = {_('Right console'), _('Inertial navigation system')}},

})

-- axes
join(res.axisCommands,{

})

return res
