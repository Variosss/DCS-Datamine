return {

forceFeedback = {
trimmer = 1.0,
shake = 0.5,
swapAxes = false,
invertX = false,
invertY = false,
},

keyCommands = {
-- Autopilot
{down = iCommandPlaneAutopilot, name    		= _('LAAP Engage/Disengage')     , category = _('LASTE Control Panel')},
{down = iCommandPlaneStabPathHold, name 		= _('LAAP Path Hold')			  , category = _('LASTE Control Panel')},
{down = iCommandPlaneStabHbarHeading, name 		= _('LAAP Altitude/Heading Hold'), category = _('LASTE Control Panel')},
{down = iCommandPlaneStabHbarBank, name 		= _('LAAP Altitude/Bank Hold')   , category = _('LASTE Control Panel')},
{combos = {{key = 'JOY_BTN1'}}, down = iCommandPlane_EAC_ARM, name = _('EAC Arm'), category = _('LASTE Control Panel')},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlane_EAC_OFF, name = _('EAC Off'), category = _('LASTE Control Panel')},
},

axisCommands = {
{combos = {{key = 'JOY_X'}}, action = iCommandPlaneRoll, name = _('Roll')},
{combos = {{key = 'JOY_Y'}}, action = iCommandPlanePitch, name = _('Pitch')},
{combos = {{key = 'JOY_RZ'}}, action = iCommandPlaneRudder, name = _('Rudder')},
{combos = {{key = 'JOY_SLIDER1'}}, action = iCommandPlaneThrustCommon, name = _('Thrust')},
},
}
