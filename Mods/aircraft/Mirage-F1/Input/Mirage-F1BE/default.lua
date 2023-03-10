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

-- View Cockpit
addInputEntryKey({down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Seat 1'),	category = _('View Cockpit')},
	{{key = '1'}})
addInputEntryKey({down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Seat 2'),	category = _('View Cockpit')},
	{{key = '2'}})


----------------------------------------------------------------

local resJoint = external_profile(folder.."../../default_CE_BE.lua")
join(resJoint.keyCommands, res.keyCommands)

if isJoystick(deviceName) then
	join(resJoint.axisCommands, res.axisCommands)
end

return resJoint
