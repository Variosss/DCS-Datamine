local  input_root = folder.."../../"
local res = external_profile(input_root.."su-27/keyboard/default.lua")

join(res.keyCommands,{
--0042832: J-11A: add key command to control anti-collision light
{combos = {{key = 'L', reformers = {'RCtrl','RAlt'}}}, down = iCommandPlaneAntiCollisionLights, name = _('Anti-collision lights'), category = _('Systems')},
})

return res
