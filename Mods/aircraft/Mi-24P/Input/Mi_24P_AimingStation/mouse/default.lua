local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {
axisCommands = {

-- mouse axes
{combos = {{key = 'MOUSE_X'}}, action = i9K113_commands.Command_SIGHT_LEFT_RIGHT_AXIS, cockpit_device_id = devices.I9K113, name = _('Aiming Station Left/Right (Mouse)')},
{combos = {{key = 'MOUSE_Y'}}, action = i9K113_commands.Command_SIGHT_UP_DOWN_AXIS, cockpit_device_id = devices.I9K113, name = _('Aiming Station Up/Down (Mouse)')},
{combos = {{key = 'MOUSE_Z'}}, action = i9K113_commands.Command_SIGHT_ZOOM, cockpit_device_id = devices.I9K113, name = _('Aiming Station Zoom In/Out (Mouse)')},
},
}
