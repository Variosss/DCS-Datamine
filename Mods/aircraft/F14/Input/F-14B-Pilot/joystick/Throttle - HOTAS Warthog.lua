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

join_override(res.keyCommands,{


--Flight Control
{ combos={{key='JOY_BTN8'}}, up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=1.0, 	name=_('Speed brake extend'),			 category=_('Gears, brakes, and hook')},
{ combos={{key='JOY_BTN7'}}, up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=-1.0,	name=_('Speed brake retract'),			 category=_('Gears, brakes, and hook')},
{ combos={{key='JOY_BTN21'}}, down=device_commands.GEAR_Toggle, cockpit_device_id=devices.GEARHOOK, value_down=0,		name=_('Gears Toggle'),			 category=_('Gears, brakes, and hook')},


-- Flaps
{combos = {{key = 'JOY_BTN23'}}, down=device_commands.FLAPS_Lever, cockpit_device_id=devices.FLAPS, value_down=0.0, name = _('Flaps Down'), category = _('Flight Control')},
{combos = {{key = 'JOY_BTN22'}},  down=device_commands.FLAPS_Lever, cockpit_device_id=devices.FLAPS, value_down=1.0, name = _('Flaps Up'), category = _('Flight Control')},

--Stick

{ combos={{key='JOY_BTN15'}},up=device_commands.THROTTLE_CAGE_SEAM, down=device_commands.THROTTLE_CAGE_SEAM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('CAGE-SEAM button'),	 category=_('Throttle')},
{ combos={{key='JOY_BTN1'}},up=device_commands.THROTTLE_PLM, down=device_commands.THROTTLE_PLM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('PLM button'),	 category=_('Throttle')},

{ combos={{key='JOY_BTN13'}},down=device_commands.LIGHTS_Exterior_Master_Switch, up=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Exterior Lights Master Switch ON (pressed) / OFF (released)'),	 category=_('Throttle')},

{ combos={{key='JOY_BTN3'}}, up=device_commands.WINGSWEEP_AutoButton, down=device_commands.WINGSWEEP_AutoButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Auto Mode'),	 category=_('Throttle')},
{ combos={{key='JOY_BTN4'}}, up=device_commands.WINGSWEEP_FwdButton, down=device_commands.WINGSWEEP_FwdButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Forward'),	 category=_('Throttle')},
{ combos={{key='JOY_BTN6'}}, up=device_commands.WINGSWEEP_AftButton, down=device_commands.WINGSWEEP_AftButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Aft'),	 category=_('Throttle')},
{ combos={{key='JOY_BTN5'}}, up=device_commands.WINGSWEEP_BombButton, down=device_commands.WINGSWEEP_BombButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Bomb Mode'),	 category=_('Throttle')},


--Jester
{combos={{key='JOY_BTN2'}},	cockpit_device_id=devices.JESTERAI, up =device_commands.JESTER_ToggleMenu ,down=device_commands.JESTER_ToggleMenu, value_up=-1.0, value_down=1.0,	name=_('Toggle Menu'), category=_('Jester AI')},

-- AP

{ combos={{key='JOY_BTN26'}},down=device_commands.AP_Engage_Toggle, cockpit_device_id=devices.AFCS, value_down=0.0, name=_('Autopilot toggle'),	 category=_('Flight Control')},

-- ACM Panel
{ combos={{key='JOY_BTN11'}}, down=device_commands.WEAP_Gun_Rate, up=device_commands.WEAP_Gun_Rate, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Gun rate toggle'), category=_('ACM Panel')},
{ combos={{key='JOY_BTN12'}}, down=device_commands.WEAP_SW_Cool, up=device_commands.WEAP_SW_Cool, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('AIM-9 cooling toggle'), category=_('ACM Panel')},

{ combos={{key='JOY_BTN9'}}, down=device_commands.WEAP_Master_Arm, up=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=-1.0, value_up=0.0, name=_('Master arm on/off (3pos)'), category=_('ACM Panel')},
{ combos={{key='JOY_BTN10'}}, down=device_commands.WEAP_Master_Arm, up=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Master arm off/training (3pos)'), category=_('ACM Panel')},

})

-- joystick axes
join(res.axisCommands,{

{action=iCommandPlaneRoll,name=_('Roll')},
{action=iCommandPlanePitch,name=_('Pitch')},
{action=iCommandPlaneRudder,name=_('Rudder')},
{action=iCommandPlaneThrustCommon,name=_('Throttle Both')},

{combos={{key='JOY_RZ'}},action = iCommandPlaneThrustLeft , name = _('Throttle Left')},
{combos={{key='JOY_Z'}},action = iCommandPlaneThrustRight, name = _('Throttle Right')},

{action = iCommandLeftWheelBrake , name = _('Wheel Brake Left')},
{action = iCommandRightWheelBrake, name = _('Wheel Brake Right')},
{action = iCommandWheelBrake, name = _('Wheel Brake both')},

{action = device_commands.STICK_DLC_ManDec_Thumbwheel, cockpit_device_id=devices.HOTAS, name = _('DLC / Maneuver Flaps Retract')},

{action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
{combos = {{key = "JOY_SLIDER1"}}, action = iCommandViewZoomAbs				, name = _('Zoom View')},
{action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

})

return res
