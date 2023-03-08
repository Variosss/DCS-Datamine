local cockpit = folder.."../../../Cockpit/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")


return {

keyCommands={

{combos = {{key = 'MOUSE_BTN3'}}, down = iCommandViewTransposeModeOn, up = iCommandViewTransposeModeOff, name = _('Camera transpose mode (press and hold)'), category = _('View Cockpit')},
{down = iCommandCockpitClickModeOnOff, 	name = _('Force cursor to show on/off'),	category = _('General')},

},


--mouse axes
axisCommands = {

{combos = {{key = 'MOUSE_X'}}, action = iCommandPlaneViewHorizontal, name = _('Horizontal View (Mouse)')},
{combos = {{key = 'MOUSE_Y'}}, action = iCommandPlaneViewVertical, name = _('Vertical View (Mouse)')},
{combos = {{key = 'MOUSE_Z'}}, action = iCommandPlaneZoomView, name = _('Zoom View (Mouse)')},
{action = iCommandViewRoll , name = _('Cockpit camera roll (Mouse)')},
{action = iCommandViewHorTrans , name = _('Cockpit camera move lateral (Mouse)')},
{action = iCommandViewVertTrans , name = _('Cockpit camera move vertical (Mouse)')},
{action = iCommandViewLongitudeTrans , name = _('Cockpit camera move forward/backward (Mouse)')},

},

}
