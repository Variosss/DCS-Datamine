local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common/keyboard/default.lua")

join(res.keyCommands,{

----------------------------------------------------------------
-- Navigation indicator

-- Gyromagnetic-True IDN heading selector
{combos = {}, down = devCmds.Cmd655, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Gyromagnetic/True IDN heading selector - True'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd655, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Gyromagnetic/True IDN heading selector - Gyromagnetic'), category = {_('Central front panel'), _('Navigation indicator')}},
-- VOR/Radar narrow needle selector
{combos = {}, down = devCmds.Cmd656, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('VOR/Radar narrow needle selector - VOR'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd656, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('VOR/Radar narrow needle selector - Radar'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Mode selector switch
{combos = {}, down = devCmds.Cmd658, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode selector switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd658, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode selector switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}},
-- Additional vector bearing/distance adjustment switch
{combos = {}, down = devCmds.Cmd659, up = devCmds.Cmd659, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Additional vector bearing/distance adjustment switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}},
{combos = {}, down = devCmds.Cmd660, up = devCmds.Cmd660, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Additional vector bearing/distance adjustment switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}},

----------------------------------------------------------------
-- Aerial refuelling system
	
-- Transfer/filling switch guard
{combos = {}, down = devCmds.Cmd664, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Transfer/filling switch guard - OPEN'), category = {_('Left console'), _('Aerial refuelling system')}},
{combos = {}, down = devCmds.Cmd664, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Transfer/filling switch guard - CLOSE'), category = {_('Left console'), _('Aerial refuelling system')}},
-- Transfer/filling switch
{combos = {}, down = devCmds.Cmd663, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Transfer/filling switch - REMP. VOL (AERIAL REFUELLING)'), category = {_('Left console'), _('Aerial refuelling system')}},
{combos = {}, down = devCmds.Cmd663, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Transfer/filling switch - TRANSFERT (TRANSFER)'), category = {_('Left console'), _('Aerial refuelling system')}},
-- Aerial refuelling light adjustment potentiometer
{combos = {}, pressed = devCmds.Cmd668, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Aerial refuelling light adjustment potentiometer - Increase'), category = {_('Left console'), _('Aerial refuelling system')}},
{combos = {}, pressed = devCmds.Cmd668, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Aerial refuelling light adjustment potentiometer - Decrease'), category = {_('Left console'), _('Aerial refuelling system')}},
	
----------------------------------------------------------------
-- RWR ALR-300 Control Panel

{down = devCmds.Cmd670, up = devCmds.Cmd670, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Threats parameters recording'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{down = devCmds.Cmd671, up = devCmds.Cmd671, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Threats audio off'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{down = devCmds.Cmd672, up = devCmds.Cmd672, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Search threats off'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{down = devCmds.Cmd673, up = devCmds.Cmd673, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Display five most dangerous threats'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{down = devCmds.Cmd674, up = devCmds.Cmd674, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Detailed threats info'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{pressed = devCmds.Cmd676, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('ALR-300 display brightness - Clockwise/Increase'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{pressed = devCmds.Cmd676, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('ALR-300 display brightness - Counterclockwise/Decrease'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},
{down = devCmds.Cmd677, up = devCmds.Cmd677, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 test'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}},

-- Jammer detection / AAR Feeder tanks overflow light
{combos = {}, down = devCmds.Cmd291, up = devCmds.Cmd291, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Jammer detection / Feeder tanks overflow light - PUSH'), category = {_('Central front panel'), _('Warnings')}},
{combos = {}, pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Jammer detection / Feeder tanks overflow light - Increase'), category = {_('Central front panel'), _('Warnings')}},
{combos = {}, pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Jammer detection / Feeder tanks overflow light - Decrease'), category = {_('Central front panel'), _('Warnings')}},

})

return res
