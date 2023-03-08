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

local res2 = external_profile(f14input.."F-14B-Pilot/keyboard/default.lua")
join_override(res.keyCommands, res2.keyCommands)

res2 = external_profile(f14input.."F-14B/joystick/default.lua")
join_override(res.keyCommands, res2.keyCommands)
join_override(res.axisCommands, res2.axisCommands)
join_override(res.forceFeedback, res2.forceFeedback)


join_override(res.forceFeedback,{
	trimmer=1.0,
	shake=0.5,
	swapAxes=false,
	invertX=false,
	invertY=false,
})

join_override(res.keyCommands,{


--Flight Control
{ up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=1.0, 	name=_('Speed brake extend'),			 category=_('Gears, brakes, and hook')},
{ up=device_commands.SPEEDBRAKE_ExtendRetract, pressed=device_commands.SPEEDBRAKE_ExtendRetract, 	cockpit_device_id=devices.GEARHOOK, value_up=0.0, value_pressed=-1.0,	name=_('Speed brake retract'),			 category=_('Gears, brakes, and hook')},
{ down=device_commands.GEAR_Toggle, cockpit_device_id=devices.GEARHOOK, value_down=0,		name=_('Gears Toggle'),			 category=_('Gears, brakes, and hook')},

{ up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=1.0,	name=_('Trim Pitch Up'),			 category = _('Flight Control')},
{ up=iCommandPlaneTrimPitch, pressed=iCommandPlaneTrimPitch, value_up=0.0, value_pressed=-1.0,	name=_('Trim Pitch Down'),			 category = _('Flight Control')},
{ up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=-1.0,	name=_('Trim Roll Left Wing Down'), category = _('Flight Control')},
{ up=iCommandPlaneTrimRoll, pressed=iCommandPlaneTrimRoll, value_up=0.0, value_pressed=1.0,		name=_('Trim Roll Right Wing Down'),category = _('Flight Control')},
{ up=iCommandPlaneTrimRudder, pressed=iCommandPlaneTrimRudder, value_up=0.0, value_pressed=-1.0,name=_('Trim Rudder Left'),		 category = _('Flight Control')},
{ up=iCommandPlaneTrimRudder, pressed=iCommandPlaneTrimRudder, value_up=0.0, value_pressed=1.0,	name=_('Trim Rudder Right'),		 category = _('Flight Control')},

-- Flaps
{ down=device_commands.FLAPS_Lever, cockpit_device_id=devices.FLAPS, value_down=0.0, name = _('Flaps Down'), category = _('Flight Control')},
{ down=device_commands.FLAPS_Lever, cockpit_device_id=devices.FLAPS, value_down=1.0, name = _('Flaps Up'), category = _('Flight Control')},
{ down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=-1, name = _('Emergency Flaps Down'), category = _('Flight Control')},
{ down=device_commands.FLAPS_Lever, 	cockpit_device_id=devices.FLAPS, value_down=2.0, name = _('Emergency Flaps Up'), category = _('Flight Control')},

--Stick
{ up=device_commands.STICK_Bomb_Release, 				down=device_commands.STICK_Bomb_Release, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Store Release'),	 category=_('Stick')},
{ up=device_commands.STICK_Trigger_Detent, 				down=device_commands.STICK_Trigger_Detent, 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger First Detent'),	 category=_('Stick')},
{ up=device_commands.STICK_Trigger, 					down=device_commands.STICK_Trigger,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Trigger'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=1.0, 	name=_('Weapon Selector Gun'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=0.5, 	name=_('Weapon Selector Sparrow or Phoenix Missiles'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=-0.5, 	name=_('Weapon Selector Sidewinder Missiles'),	 category=_('Stick')},
{ down=device_commands.STICK_Weapon_Selector, 		cockpit_device_id=devices.WEAPONS, value_down=-1.0,	name=_('Weapon Selector Off'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_up, 		down=device_commands.STICK_Weapon_Selector_up,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector up'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_down, 	down=device_commands.STICK_Weapon_Selector_down,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector down'),	 category=_('Stick')},
{ up=device_commands.STICK_Weapon_Selector_press, 	down=device_commands.STICK_Weapon_Selector_press,		 	cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, 	name=_('Weapon Selector press'),	 category=_('Stick')},
{ up=device_commands.STICK_DLC_ManDec_Thumbwheel,  		pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=1.0,  value_up=0,	name=_('DLC Thumbwheel Forward'), 	 category=_('Stick')},
{ up=device_commands.STICK_DLC_ManDec_Thumbwheel,   	pressed=device_commands.STICK_DLC_ManDec_Thumbwheel, 	cockpit_device_id=devices.HOTAS, value_pressed=-1.0, value_up=0,	name=_('DLC Thumbwheel Aft'),	 category=_('Stick')},
{ down=device_commands.STICK_DLC_Toggle_CountDisp, up=device_commands.STICK_DLC_Toggle_CountDisp,	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('DLC Toggle / Countermeasure Dispense'),	 category=_('Stick')},
{ down=device_commands.STICK_Autopilot_Emergency_Disconnect, up=device_commands.STICK_Autopilot_Emergency_Disconnect,	cockpit_device_id=devices.AFCS, value_down=1.0,value_up=0.0, 	name=_('Autopilot Emergency Disconnect Paddle'),	 category=_('Stick')},
{ down=device_commands.STICK_Autopilot_Ref_NWS_Toggle,up=device_commands.STICK_Autopilot_Ref_NWS_Toggle, 	cockpit_device_id=devices.HOTAS, value_down=1.0,value_up=0.0,		name=_('Autopilot Reference / Nosewheel Steering Toggle'),	 category=_('Stick')},

{ up=device_commands.THROTTLE_CAGE_SEAM, down=device_commands.THROTTLE_CAGE_SEAM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('CAGE-SEAM button'),	 category=_('Throttle')},
{ up=device_commands.THROTTLE_PLM, down=device_commands.THROTTLE_PLM, cockpit_device_id=devices.HOTAS, value_up=0.0, value_down=1.0, name=_('PLM button'),	 category=_('Throttle')},

{ down=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=0.0, name=_('Exterior Lights Master Switch OFF'),	 category=_('Throttle')},
{ down=device_commands.LIGHTS_Exterior_Master_Switch, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, name=_('Exterior Lights Master Switch ON'),	 category=_('Throttle')},
{ down=device_commands.LIGHTS_Exterior_Master_Switch_Toggle, cockpit_device_id=devices.COCKPITMECHANICS, value_down=1.0, value_up=0.0, name=_('Exterior Lights Master Switch Toggle'),	 category=_('Throttle')},

{ up=device_commands.WINGSWEEP_AutoButton, down=device_commands.WINGSWEEP_AutoButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Auto Mode'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_FwdButton, down=device_commands.WINGSWEEP_FwdButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Forward'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_AftButton, down=device_commands.WINGSWEEP_AftButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Aft'),	 category=_('Throttle')},
{ up=device_commands.WINGSWEEP_BombButton, down=device_commands.WINGSWEEP_BombButton, cockpit_device_id=devices.WINGSWEEP, value_up=0.0, value_down=1.0, name=_('Wing Sweep Bomb Mode'),	 category=_('Throttle')},

{cockpit_device_id=devices.ENGINE, down = device_commands.THROTTLE_Left_Throttle_CutOff , up = device_commands.THROTTLE_Left_Throttle_CutOff, value_up=0.0, value_down=1.0,  name = _('Left Engine Cutoff'), category = _('Throttle')},
{cockpit_device_id=devices.ENGINE, down = device_commands.THROTTLE_Right_Throttle_CutOff, up = device_commands.THROTTLE_Right_Throttle_CutOff, value_up=0.0, value_down=1.0, name = _('Right Engine Cutoff'), category = _('Throttle')},

{ down=device_commands.AP_Engage_Toggle, cockpit_device_id=devices.AFCS, value_down=0.0, name=_('Autopilot toggle'),	 category=_('Flight Control')},



-- pilot display control panel
{ down=device_commands.DISP_mode_takeoff, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode takeoff'), category=_('PDCP')},
{ down=device_commands.DISP_mode_cruise, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode cruise'), category=_('PDCP')},
{ down=device_commands.DISP_mode_air2air, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode air to air'), category=_('PDCP')},
{ down=device_commands.DISP_mode_air2ground, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode air to ground'), category=_('PDCP')},
{ down=device_commands.DISP_mode_landing, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode landing'), category=_('PDCP')},
{ down=device_commands.DISP_mode_next, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode next'), category=_('PDCP')},
{ down=device_commands.DISP_mode_prev, cockpit_device_id=devices.HUD, value_down=1.0, name=_('Display mode previous'), category=_('PDCP')},



--************************************* Jester AI  ******************************************************************

--Menu
{	cockpit_device_id=devices.JESTERAI, up =device_commands.JESTER_ToggleMenu ,down=device_commands.JESTER_ToggleMenu, value_up=-1.0, value_down=1.0,	name=_('Toggle Menu'), category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command1, value_down=1.0,	name=_('Command 1'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command2, value_down=1.0,	name=_('Command 2'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command3, value_down=1.0,	name=_('Command 3'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command4, value_down=1.0,	name=_('Command 4'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command5, value_down=1.0,	name=_('Command 5'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command6, value_down=1.0,	name=_('Command 6'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command7, value_down=1.0,	name=_('Command 7'),	 category=_('Jester AI')},
{	 cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_Command8, value_down=1.0,	name=_('Command 8'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuHorizontal, up=device_commands.JESTER_MenuHorizontal, value_down=-1.0, value_up=0.0, name=_('Jester Menu Left'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuHorizontal, up=device_commands.JESTER_MenuHorizontal, value_down=1.0, value_up=0.0, name=_('Jester Menu Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuVertical, up=device_commands.JESTER_MenuVertical, value_down=1.0, value_up=0.0, name=_('Jester Menu Up'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuVertical, up=device_commands.JESTER_MenuVertical, value_down=-1.0, value_up=0.0, name=_('Jester Menu Down'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag45, up=device_commands.JESTER_MenuDiag45, value_down=-1.0, value_up=0.0, name=_('Jester Menu Down Left'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag45, up=device_commands.JESTER_MenuDiag45, value_down=1.0, value_up=0.0, name=_('Jester Menu Up Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag135, up=device_commands.JESTER_MenuDiag135, value_down=1.0, value_up=0.0, name=_('Jester Menu Down Right'),	 category=_('Jester AI')},
{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_MenuDiag135, up=device_commands.JESTER_MenuDiag135, value_down=-1.0, value_up=0.0, name=_('Jester Menu Up Left'),	 category=_('Jester AI')},

{cockpit_device_id=devices.JESTERAI, down=device_commands.JESTER_CloseMenu, value_down=1.0,  name=_('Close Menu'),	 category=_('Jester AI')},



-- ACM Panel
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=-1.0, name=_('Master arm cover toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_Cover, up=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Master arm cover open/close (2pos)'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm cover close'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_And_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm on and cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm_And_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm off and cover close'), category=_('ACM Panel')},

{ down=device_commands.WEAP_ACM_Cover_Toggle, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('ACM cover toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover, up=device_commands.WEAP_ACM_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('ACM cover open/close (2pos)'), category=_('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('ACM cover open'), category=_('ACM Panel')},
{ down=device_commands.WEAP_ACM_Cover, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('ACM cover close'), category=_('ACM Panel')},

{ down=device_commands.WEAP_ACM_Jettison, up=device_commands.WEAP_ACM_Jettison, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('ACM Jettison'), category=_('ACM Panel')},
{ down=device_commands.WEAP_MSL_Mode, up=device_commands.WEAP_MSL_Mode, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Missile mode toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Gun_Rate, up=device_commands.WEAP_Gun_Rate, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Gun rate toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_SW_Cool, up=device_commands.WEAP_SW_Cool, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('AIM-9 cooling toggle'), category=_('ACM Panel')},
{ down=device_commands.WEAP_MSL_Prep, up=device_commands.WEAP_MSL_Prep, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Missile prepare toggle'), category=_('ACM Panel')},

{ down=device_commands.WEAP_Master_Arm, up=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=-1.0, value_up=0.0, name=_('Master arm on/off (3pos)'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, up=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Master arm off/training (3pos)'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=-1.0, name=_('Master arm on'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=0.0, name=_('Master arm off'), category=_('ACM Panel')},
{ down=device_commands.WEAP_Master_Arm, cockpit_device_id=devices.WEAPONS, value_down=1.0, name=_('Master arm training'), category=_('ACM Panel')},

{ down=device_commands.WEAP_Target_designate_up, up=device_commands.WEAP_Target_designate_up, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate up / VSL HI'), category=_('Left sidewall')},
{ down=device_commands.WEAP_Target_designate_fwd, up=device_commands.WEAP_Target_designate_fwd, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate fwd / PAL'), category=_('Left sidewall')},
{ down=device_commands.WEAP_Target_designate_down, up=device_commands.WEAP_Target_designate_down, cockpit_device_id=devices.WEAPONS, value_down=1.0, value_up=0.0, name=_('Target designate down / VSL LO'), category=_('Left sidewall')},

})



-- joystick axes
join_override(res.axisCommands,{
{combos = defaultDeviceAssignmentFor("roll"),action=iCommandPlaneRoll,name=_('Roll')},
{combos = defaultDeviceAssignmentFor("pitch"),action=iCommandPlanePitch,name=_('Pitch')},
{combos = defaultDeviceAssignmentFor("rudder"),action=iCommandPlaneRudder,name=_('Rudder')},
{combos = defaultDeviceAssignmentFor("thrust"),action=iCommandPlaneThrustCommon,name=_('Throttle Both')},

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
