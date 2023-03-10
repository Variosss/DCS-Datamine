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

-- Left master failure warning light
addInputEntryKey({down = devCmds.Cmd265, up = devCmds.Cmd265, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Left master failure warning light'), category = {_('Central front panel'), _('Warnings')}},
	{{key = 'M', reformers = {"LShift"}}})
-- Right master failure warning light
addInputEntryKey({down = devCmds.Cmd678, up = devCmds.Cmd678, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Right master failure warning light'), category = {_('Central front panel'), _('Warnings')}})
-- Fire warning light AB + Horn
addInputEntryKey({down = devCmds.Cmd277, up = devCmds.Cmd277, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fire warning light AB + Horn'), category = {_('Central front panel'), _('Warnings')}})
-- Fire warning light ENG + Horn
addInputEntryKey({down = devCmds.Cmd679, up = devCmds.Cmd679, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Fire warning light ENG + Horn'), category = {_('Central front panel'), _('Warnings')}})


----------------------------------------------------------------
-- Navigation indicator

-- Gyromagnetic-True IDN heading selector
addInputEntryKey({down = devCmds.Cmd655, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('Gyromagnetic/True IDN heading selector - True'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd655, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('Gyromagnetic/True IDN heading selector - Gyromagnetic'), category = {_('Central front panel'), _('Navigation indicator')}})
-- VOR/Radar narrow needle selector
addInputEntryKey({down = devCmds.Cmd656, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('VOR/Radar narrow needle selector - VOR'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd656, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('VOR/Radar narrow needle selector - Radar'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Mode selector switch
addInputEntryKey({down = devCmds.Cmd658, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Mode selector switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd658, cockpit_device_id = devices.MAIN, value_down = -1.0, name = _('Mode selector switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}})
-- Additional vector bearing/distance adjustment switch
addInputEntryKey({down = devCmds.Cmd659, up = devCmds.Cmd659, cockpit_device_id = devices.MAIN, value_down = -1.0, value_up = 0.0, name = _('Additional vector bearing/distance adjustment switch - LEFT'), category = {_('Central front panel'), _('Navigation indicator')}})
addInputEntryKey({down = devCmds.Cmd660, up = devCmds.Cmd660, cockpit_device_id = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('Additional vector bearing/distance adjustment switch - RIGHT'), category = {_('Central front panel'), _('Navigation indicator')}})

----------------------------------------------------------------
-- Aerial refuelling system
	
-- Transfer/filling switch guard
addInputEntryKey({down = devCmds.Cmd664, cockpit_device_id = devices.MAIN, value_down = 1.1, name = _('Transfer/filling switch guard - OPEN'), category = {_('Left console'), _('Aerial refuelling system')}})
addInputEntryKey({down = devCmds.Cmd664, cockpit_device_id = devices.MAIN, value_down = -0.1, name = _('Transfer/filling switch guard - CLOSE'), category = {_('Left console'), _('Aerial refuelling system')}})
-- Transfer/filling switch
addInputEntryKey({down = devCmds.Cmd663, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('Transfer/filling switch - REMP. VOL (AERIAL REFUELLING)'), category = {_('Left console'), _('Aerial refuelling system')}})
addInputEntryKey({down = devCmds.Cmd663, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('Transfer/filling switch - TRANSFERT (TRANSFER)'), category = {_('Left console'), _('Aerial refuelling system')}})
-- Aerial refuelling light adjustment potentiometer
addInputEntryKey({pressed = devCmds.Cmd668, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Aerial refuelling light adjustment potentiometer - Increase'), category = {_('Left console'), _('Aerial refuelling system')}})
addInputEntryKey({pressed = devCmds.Cmd668, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Aerial refuelling light adjustment potentiometer - Decrease'), category = {_('Left console'), _('Aerial refuelling system')}})
	
----------------------------------------------------------------
-- RWR ALR-300 Control Panel

addInputEntryKey({down = devCmds.Cmd670, up = devCmds.Cmd670, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Threats parameters recording'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({down = devCmds.Cmd671, up = devCmds.Cmd671, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Threats audio off'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({down = devCmds.Cmd672, up = devCmds.Cmd672, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Search threats off'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({down = devCmds.Cmd673, up = devCmds.Cmd673, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Display five most dangerous threats'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({down = devCmds.Cmd674, up = devCmds.Cmd674, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 Detailed threats info'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({pressed = devCmds.Cmd676, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('ALR-300 display brightness - Clockwise/Increase'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({pressed = devCmds.Cmd676, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('ALR-300 display brightness - Counterclockwise/Decrease'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})
addInputEntryKey({down = devCmds.Cmd677, up = devCmds.Cmd677, cockpit_device_id  = devices.MAIN, value_down = 1.0, value_up = 0.0, name = _('ALR-300 test'), category = {_('Central front panel'), _('RWR ALR-300 control panel')}})

-- Jammer detection / AAR Feeder tanks overflow light
addInputEntryKey({down = devCmds.Cmd291, up = devCmds.Cmd291, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('Jammer detection / Feeder tanks overflow light - PUSH'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = 1.0, name = _('Jammer detection / Feeder tanks overflow light - Increase'), category = {_('Central front panel'), _('Warnings')}})
addInputEntryKey({pressed = devCmds.Cmd293, cockpit_device_id  = devices.MAIN, value_pressed = -1.0, name = _('Jammer detection / Feeder tanks overflow light - Decrease'), category = {_('Central front panel'), _('Warnings')}})

----------------------------------------------------------------
-- BARAX

-- BARAX light test
addInputEntryKey({down = devCmds.Cmd707, up = devCmds.Cmd707, cockpit_device_id = devices.MAIN ,value_down = 1.0, value_up = 0.0, name = _('BARAX light test'), category = {_('Central front panel'), _('BARAX')}})
-- BARAX state selector (OFF/ON/TEST)
addInputEntryKey({down = devCmds.Cmd705, cockpit_device_id = devices.MAIN, value_down = 1.0, name = _('BARAX state selector - TEST'), category = {_('Central front panel'), _('BARAX')}})
addInputEntryKey({down = devCmds.Cmd705, cockpit_device_id = devices.MAIN, value_down = 0.5, name = _('BARAX state selector - ON'), category = {_('Central front panel'), _('BARAX')}})
addInputEntryKey({down = devCmds.Cmd705, cockpit_device_id = devices.MAIN, value_down = 0.0, name = _('BARAX state selector - OFF'), category = {_('Central front panel'), _('BARAX')}})
-- BARAX emission ready korry
addInputEntryKey({down = devCmds.Cmd706, cockpit_device_id  = devices.MAIN, value_down = 1.0, name = _('BARAX emission ready korry - pressed'), category = {_('Central front panel'), _('BARAX')}})
addInputEntryKey({down = devCmds.Cmd706, cockpit_device_id  = devices.MAIN, value_down = 0.0, name = _('BARAX emission ready korry - released'), category = {_('Central front panel'), _('BARAX')}})

----------------------------------------------------------------

local resJoint = external_profile(folder.."../../default_cmn.lua")
join(resJoint.keyCommands, res.keyCommands)

if isJoystick(deviceName) then
	join(resJoint.axisCommands, res.axisCommands)
end

return resJoint
