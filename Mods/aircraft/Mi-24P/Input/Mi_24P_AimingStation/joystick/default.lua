local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

axisCommands = 
{

{action = i9K113_commands.Command_SIGHT_LEFT_RIGHT_JOY_AXIS, cockpit_device_id = devices.I9K113, name = _('Aiming Station Left/Right (Joystick)')},
{action = i9K113_commands.Command_SIGHT_UP_DOWN_JOY_AXIS, cockpit_device_id = devices.I9K113, name = _('Aiming Station Up/Down (Joystick)')},

}

}


