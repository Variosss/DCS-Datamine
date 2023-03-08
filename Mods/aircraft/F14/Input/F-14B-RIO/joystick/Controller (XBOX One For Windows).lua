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

local res2 = external_profile(f14input.."F-14B-RIO/joystick/default.lua")
join(res.keyCommands, res2.keyCommands)
join(res.axisCommands, res2.axisCommands)
join(res.forceFeedback, res2.forceFeedback)

join_override(res.keyCommands,{

-- RIO HCU

{ combos={{key='JOY_BTN4'}}, up=device_commands.HCU_IR_TV, down=device_commands.HCU_IR_TV, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU TCS mode'),	 category=_('Hand Control Unit')},
{ combos={{key='JOY_BTN2'}}, up=device_commands.HCU_RDR, down=device_commands.HCU_RDR, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU radar mode'),	 category=_('Hand Control Unit')},
{ combos={{key='JOY_BTN1'}}, up=device_commands.HCU_DDD_cursor, down=device_commands.HCU_DDD_cursor, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU DDD mode'),	 category=_('Hand Control Unit')},
{ combos={{key='JOY_BTN3'}}, up=device_commands.HCU_TID_cursor, down=device_commands.HCU_TID_cursor, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU TID mode'),	 category=_('Hand Control Unit')},

{ combos={{key='JOY_BTN_POV1_U'}}, up = device_commands.RADAR_elevation_updown, down = device_commands.RADAR_elevation_updown, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar elevation up'), category = _('Radar Control Panel')},
{ combos={{key='JOY_BTN_POV1_D'}}, up = device_commands.RADAR_elevation_updown, down = device_commands.RADAR_elevation_updown, cockpit_device_id=devices.RADAR, value_down = -1, value_up = 0, name = _('Radar elevation down'), category = _('Radar Control Panel')},
{ combos={{key='JOY_BTN_POV1_R'}}, up = device_commands.RADAR_azimuth_leftright, down = device_commands.RADAR_azimuth_leftright, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar azimuth right'), category = _('Radar Control Panel')},
{ combos={{key='JOY_BTN_POV1_L'}}, up = device_commands.RADAR_azimuth_leftright, down = device_commands.RADAR_azimuth_leftright, cockpit_device_id=devices.RADAR, value_down = -1, value_up = 0, name = _('Radar azimuth left'), category = _('Radar Control Panel')},

})

-- joystick axes
join_override(res.axisCommands,{

{combos={{key='JOY_RX'}},action = device_commands.HCU_leftright, cockpit_device_id=devices.HCU, name = _('HCU left/right')},
{combos={{key='JOY_RY'}},action = device_commands.HCU_updown, cockpit_device_id=devices.HCU, name = _('HCU up/down')},
{combos={{key='JOY_Z'}},action = device_commands.HCU_DualTriggerAxisThresh, cockpit_device_id=devices.HCU, name = _('HCU dual stage trigger (trigger axis thresholds)')},
{action = device_commands.HCU_thumb_axis, cockpit_device_id=devices.RADAR, name = _('HCU vernier thumbwheel')},

{action = device_commands.RADIO_ICS_ButtonAxisThresh_ICS_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button ICS (Intercom) PTT (axis threshold)')},
{action = device_commands.RADIO_ICS_ButtonAxisThresh_MIC_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button MIC (UHF) PTT (axis threshold)')},
{action = device_commands.RADAR_elevation_center_knob, cockpit_device_id=devices.RADAR, name = _('Radar elevation control')},
{action = device_commands.RADAR_azimuth_center_knob, cockpit_device_id=devices.RADAR, name = _('Radar azimuth control')},

{action = device_commands.RADAR_azimuth_analog_adjust, cockpit_device_id=devices.RADAR, name = _('Radar azimuth relative adjustment')},
{action = device_commands.RADAR_elevation_analog_adjust, cockpit_device_id=devices.RADAR, name = _('Radar elevation relative adjustment')},
{action = device_commands.HCU_thumb_analog_adjust, cockpit_device_id=devices.RADAR, name = _('HCU vernier thumbwheel relative adjustment')},

{action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
{action = iCommandViewZoomAbs				, name = _('Zoom View')},
{action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

})

return res
