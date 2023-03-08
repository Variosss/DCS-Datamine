local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

keyCommands = {
{combos = {{key = 'MOUSE_BTN1'}}, down = iCommandPlaneFire, up = iCommandPlaneFire, value_down = 1, value_up = 0, name = _('Machinegun fire'), category = _('Weapon')},
{combos = {{key = 'MOUSE_BTN2'}}, down = iCommand_ExplorationStart, name = _('Enable visual recon mode'), category = _('View Cockpit')},
{combos = {{key = 'MOUSE_BTN3'}}, down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},
},

axisCommands = {

-- mouse axes
{combos = {{key = 'MOUSE_Z'}}, action = iCommandPlaneZoomView, name = _('Camera Zoom View')},
						  
{combos = {{key = 'MOUSE_Y'}}, action = weapon_commands.Gunner_SIGHT_UP_DOWN_AXIS, 		cockpit_device_id = devices.WEAP_SYS, name = _('Gun Up/Down')},
{combos = {{key = 'MOUSE_X'}}, action = weapon_commands.Gunner_SIGHT_LEFT_RIGHT_AXIS, 	cockpit_device_id = devices.WEAP_SYS, name = _('Gun Left/Right')},

{action = weapon_commands.Gunner_WS_CMD_HAngle, cockpit_device_id = devices.WEAP_SYS, name = _('Camera Horizontal View')},
{action = weapon_commands.Gunner_WS_CMD_VAngle, cockpit_device_id = devices.WEAP_SYS, name = _('Camera Vertical View')},

},
}
