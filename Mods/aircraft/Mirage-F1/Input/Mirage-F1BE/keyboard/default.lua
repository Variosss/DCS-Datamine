local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common_CE_BE/keyboard/default.lua")

join(res.keyCommands,{

-- View Cockpit
{combos = {{key = '1'}},   down = iCommandViewCockpitChangeSeat, value_down = 1, name = _('Occupy Seat 1'),	category = _('View Cockpit')},
{combos = {{key = '2'}},   down = iCommandViewCockpitChangeSeat, value_down = 2, name = _('Occupy Seat 2'),	category = _('View Cockpit')},

})

return res
