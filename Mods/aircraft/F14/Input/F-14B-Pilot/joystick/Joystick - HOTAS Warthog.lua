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

{ combos={{key='JOY_BTN_POV1_D'}}, up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=1.0,	name=_('Trim Pitch Up'),			 category = _('Flight Control')},
{ combos={{key='JOY_BTN_POV1_U'}}, up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=-1.0,	name=_('Trim Pitch Down'),			 category = _('Flight Control')},
{ combos={{key='JOY_BTN_POV1_L'}}, up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=-1.0,	name=_('Trim Roll Left Wing Down'), category = _('Flight Control')},
{ combos={{key='JOY_BTN_POV1_R'}}, up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=1.0,		name=_('Trim Roll Right Wing Down'),category = _('Flight Control')},

--Stick
{ combos={{key='JOY_BTN2'}}, up=device_commands.STICK_Bomb_Release, 				down=device_commands.STICK_Bomb_Release, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Store Release'),	 category=_('Stick')},
{ combos={{key='JOY_BTN1'}}, up=device_commands.STICK_Trigger_Detent, 				down=device_commands.STICK_Trigger_Detent, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger First Detent'),	 category=_('Stick')},
{ combos={{key='JOY_BTN6'}},up=device_commands.STICK_Trigger, 					down=device_commands.STICK_Trigger,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger'),	 category=_('Stick')},
{ combos={{key='JOY_BTN7'}}, up=device_commands.STICK_Weapon_Selector_up, 		down=device_commands.STICK_Weapon_Selector_up,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector up'),	 category=_('Stick')},
{ combos={{key='JOY_BTN9'}}, up=device_commands.STICK_Weapon_Selector_down, 	down=device_commands.STICK_Weapon_Selector_down,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector down'),	 category=_('Stick')},
{ combos={{key='JOY_BTN8'}}, up=device_commands.STICK_Weapon_Selector_press, 	down=device_commands.STICK_Weapon_Selector_press,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector press'),	 category=_('Stick')},
{ combos={{key='JOY_BTN15'}}, up=device_commands.STICK_DLC_ManDec_Thumbwheel,  		pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=1.0,  value_up=0,	name=_('DLC Thumbwheel Forward'), 	 category=_('Stick')},
{ combos={{key='JOY_BTN17'}}, up=device_commands.STICK_DLC_ManDec_Thumbwheel,   	pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=-1.0, value_up=0,	name=_('DLC Thumbwheel Aft'),	 category=_('Stick')},
{ combos={{key='JOY_BTN19'}}, down=device_commands.STICK_DLC_Toggle_CountDisp,up=device_commands.STICK_DLC_Toggle_CountDisp, 	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('DLC Toggle / Countermeasure Dispense'),	 category=_('Stick')},
{ combos={{key='JOY_BTN4'}}, down=device_commands.STICK_Autopilot_Emergency_Disconnect, up=device_commands.STICK_Autopilot_Emergency_Disconnect,	cockpit_device_id=devices.AFCS, value_down=1.0,value_up=0.0, 	name=_('Autopilot Emergency Disconnect Paddle'),	 category=_('Stick')},
{ combos={{key='JOY_BTN3'}}, down=device_commands.STICK_Autopilot_Ref_NWS_Toggle, up=device_commands.STICK_Autopilot_Ref_NWS_Toggle,	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('Autopilot Reference / Nosewheel Steering Toggle'),	 category=_('Stick')},

{ combos={{key='JOY_BTN11'}}, down=device_commands.WEAP_Target_designate_up, up=device_commands.WEAP_Target_designate_up, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate up / VSL HI'), category=_('Left sidewall')},
{ combos={{key='JOY_BTN12'}}, down=device_commands.WEAP_Target_designate_fwd, up=device_commands.WEAP_Target_designate_fwd, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate fwd / PAL'), category=_('Left sidewall')},
{ combos={{key='JOY_BTN13'}}, down=device_commands.WEAP_Target_designate_down, up=device_commands.WEAP_Target_designate_down, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate down / VSL LO'), category=_('Left sidewall')},


})

-- joystick axes 
join_override(res.axisCommands,{

{combos={{key='JOY_X'}},action=iCommandPlaneRoll,name=_('Roll')},
{combos={{key='JOY_Y'}},action=iCommandPlanePitch,name=_('Pitch')},
{action=iCommandPlaneRudder,name=_('Rudder')},
{action=iCommandPlaneThrustCommon,name='Throttle Both'},

{action = iCommandPlaneThrustLeft , name = _('Throttle Left')},
{action = iCommandPlaneThrustRight, name = _('Throttle Right')},

{action = iCommandLeftWheelBrake , name = _('Wheel Brake Left')},
{action = iCommandRightWheelBrake, name = _('Wheel Brake Right')},
{action = iCommandWheelBrake, name = _('Wheel Brake both')},

{action = device_commands.FLAPS_Lever_Axis, cockpit_device_id=devices.FLAPS, name = _('Flap Lever')},
{action = device_commands.STICK_DLC_ManDec_Thumbwheel, cockpit_device_id=devices.HOTAS, name = _('DLC / Maneuver Flaps Retract')},

{action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
{action = iCommandViewZoomAbs				, name = _('Zoom View')},
{action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

{action = device_commands.HSD_Knob_Brightness_axis, cockpit_device_id=devices.HSD, name = _('HSD Brightness')},
{action = device_commands.HSD_Knob_Heading_axis, cockpit_device_id=devices.HSD, name = _('HSD Selected Heading')},
{action = device_commands.HSD_Knob_Course_axis, cockpit_device_id=devices.HSD, name = _('HSD Selected Course')},
{action = device_commands.RADIO_ICS_Vol_Pilot_axis, cockpit_device_id=devices.ICS, name = _('ICS Volume Pilot')},
{action = device_commands.RADIO_ICS_Vol_Sidewinder_axis, cockpit_device_id=devices.ICS, name = _('Sidewinder Volume')},
{action = device_commands.RADIO_ICS_Vol_ALR67_Pilot_axis, cockpit_device_id=devices.ICS, name = _('ALR-67 Volume')},
{action = device_commands.RADIO_VHF_VOL_PILOT_axis, cockpit_device_id=devices.ARC182, name = _('VHF/UHF ARC-182 Volume Pilot')},
{action = device_commands.VDIG_HUD_bright_axis, cockpit_device_id=devices.HUD, name = _('HUD Brightness')},
{action = device_commands.VDIG_HUD_trim_axis, cockpit_device_id=devices.HUD, name = _('HUD Trim')},
{action = device_commands.VDIG_VSDI_bright_axis, cockpit_device_id=devices.VDI, name = _('VDI Screen Brightness')},
{action = device_commands.VDIG_VDI_contrast_axis, cockpit_device_id=devices.VDI, name = _('VDI Screen Contrast')},
{action = device_commands.VDIG_VSDI_trim_axis, cockpit_device_id=devices.VDI, name = _('VDI Trim')},
{action = device_commands.TACAN_Knob_Vol_Pilot_axis, cockpit_device_id=devices.TACAN, name = _('TACAN Volume')},
{action = device_commands.Emergency_Wingsweep_axis, cockpit_device_id=devices.WINGSWEEP, name = _('Emergency Wingsweep')},

})

return res