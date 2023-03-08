local cockpit = folder.."../../../Cockpit/"
local f14input = folder.."../../../Input/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

res = {
  --keyCommands = {},
  axisCommands = {},
}

local res2 = external_profile(f14input.."F-14B/trackir/default.lua")
--join(res.keyCommands, res2.keyCommands)
--join(res.keyCommands,{
--})

join(res.axisCommands, res2.axisCommands)
join(res.axisCommands,{
})

return res