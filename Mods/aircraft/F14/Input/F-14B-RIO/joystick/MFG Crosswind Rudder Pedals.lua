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

-- joystick axes
join_override(res.axisCommands,{

{action = device_commands.HCU_leftright, cockpit_device_id=devices.HCU, name = _('HCU left/right')},
{action = device_commands.HCU_updown, cockpit_device_id=devices.HCU, name = _('HCU up/down')},
{action = device_commands.HCU_thumb_axis, cockpit_device_id=devices.RADAR, name = _('HCU vernier thumbwheel')},

{combos={{key='JOY_X'}},action = device_commands.RADIO_ICS_ButtonAxisThresh_ICS_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button ICS (Intercom) PTT (axis threshold)')},
{combos={{key='JOY_Y'}},action = device_commands.RADIO_ICS_ButtonAxisThresh_MIC_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button MIC (UHF) PTT (axis threshold)')},

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
