local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

keyCommands = {
{down = iCommandPlaneFire, up = iCommandPlaneFire, value_down = 1, value_up = 0, name = _('Machinegun fire'), category = _('Weapon')},
},

axisCommands = {			  
{action = device_commands.Button_44, cockpit_device_id = devices.WEAPON_SYS, name = _('Gun Left/Right (Joystick)')},
{action = device_commands.Button_43, cockpit_device_id = devices.WEAPON_SYS, name = _('Gun Up/Down (Joystick)')},
},

}
