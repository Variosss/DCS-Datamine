local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

forceFeedback = {
trimmer = 1.0,
shake = 0.5,
swapAxes = false,
},

keyCommands = {
},

axisCommands = {
{combos = {{key = 'JOY_Z'}}, action = iCommandPlaneRudder, name = _('Rudder')},
{combos = {{key = 'JOY_X',filter ={	deadzone 	= 0,
									saturationX = 1,
									curvature   = {0},
									saturationY = 1,
									invert		= true,
									slider		= true}}}, action = iCommandLeftWheelBrake,	name = _('Wheel Brake Left')},
{combos = {{key = 'JOY_Y',filter ={	deadzone 	= 0,
									saturationX = 1,
									curvature   = {0},
									saturationY = 1,
									invert		= true,
									slider		= true}}},action = iCommandRightWheelBrake,	name = _('Wheel Brake Right')},
},
}
