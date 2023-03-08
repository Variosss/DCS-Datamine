local cpt_cmn_folder = folder.."../../../Cockpit/Common/"
dofile(cpt_cmn_folder.."devices.lua")
dofile(cpt_cmn_folder.."command_defs.lua")
local res = external_profile(folder.."../../Common_EE_M/joystick/default.lua")

join(res.keyCommands,{


})

-- axes
join(res.axisCommands,{

})

return res
