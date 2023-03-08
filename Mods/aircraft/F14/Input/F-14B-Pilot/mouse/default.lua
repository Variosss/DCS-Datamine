
local cockpit = folder.."../../../Cockpit/"
local f14input = folder.."../../../Input/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
dofile(f14input.."utils.lua")

res = {
  keyCommands = {},
  axisCommands = {},
}

local res2 = external_profile(f14input.."F-14B/mouse/default.lua")
join(res.keyCommands, res2.keyCommands)

join(res.axisCommands, res2.axisCommands)
join_override(res.axisCommands,{

{action = iCommandPlaneRollDelta, name = _('Roll (Mouse)')},
{action = iCommandPlanePitchDelta, name = _('Pitch (Mouse)')},
{action = iCommandPlaneRudderDelta, name = _('Rudder (Mouse)')},
{action = iCommandPlaneThrustCommonDelta, name = _('Throttle (Mouse)')},

})

return res
