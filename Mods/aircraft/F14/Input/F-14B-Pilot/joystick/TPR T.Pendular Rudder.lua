local cockpit = folder.."../../../Cockpit/"
local f14input = folder.."../../../Input/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")
dofile(f14input.."utils.lua")

res = {
  keyCommands = {},
  axisCommands = {},
  forceFeedback = {},
}

local res2 = external_profile(f14input.."F-14B-Pilot/joystick/default.lua")
join(res.keyCommands, res2.keyCommands)
join(res.axisCommands, res2.axisCommands)
join(res.forceFeedback, res2.forceFeedback)


-- joystick axes
join_override(res.axisCommands,{

{action=iCommandPlaneRoll,name='Roll'},
{action=iCommandPlanePitch,name='Pitch'},
{combos={{key='JOY_Z'}},action=iCommandPlaneRudder,name='Rudder'},
{action=iCommandPlaneThrustCommon,name='Throttle Both'},

{action = iCommandPlaneThrustLeft , name = _('Throttle Left')},
{action = iCommandPlaneThrustRight, name = _('Throttle Right')},

{combos={{key='JOY_Y'}},action = iCommandLeftWheelBrake , name = _('Wheel Brake Left')},
{combos={{key='JOY_X'}},action = iCommandRightWheelBrake, name = _('Wheel Brake Right')},
{action = iCommandWheelBrake, name = _('Wheel Brake both')},

{action = device_commands.STICK_DLC_ManDec_Thumbwheel, cockpit_device_id=devices.HOTAS, name = _('DLC / Maneuver Flaps Retract')},

{action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
{action = iCommandViewZoomAbs				, name = _('Zoom View')},
{action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},



})

return res
