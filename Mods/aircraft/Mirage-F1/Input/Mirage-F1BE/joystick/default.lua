local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common_CE_BE/joystick/default.lua")

join(res.keyCommands,{

-- View Cockpit
{down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Seat 1'),	category = _('View Cockpit')},
{down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Seat 2'),	category = _('View Cockpit')},

})

-- axes
join(res.axisCommands,{

})

return res
