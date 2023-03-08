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

local res2 = external_profile(f14input.."F-14B-RIO/keyboard/default.lua")
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

-- RIO HCU
{ up=device_commands.HCU_halfaction, down=device_commands.HCU_halfaction, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU half action'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_fullaction, down=device_commands.HCU_fullaction, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU full action'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_offset, down=device_commands.HCU_offset, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU offset'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_MRL, down=device_commands.HCU_MRL, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU MRL'),	 category=_('Hand Control Unit')},
{ up = device_commands.HCU_thumb, down = device_commands.HCU_thumb, cockpit_device_id=devices.RADAR, value_up = 0, value_down = 1, name = _('HCU thumb up'), category = _('Hand Control Unit')},
{ up = device_commands.HCU_thumb_center, down = device_commands.HCU_thumb_center, cockpit_device_id=devices.RADAR, value_up = 0, value_down = 1, name = _('HCU thumb re-center'), category = _('Hand Control Unit')},
{ up = device_commands.HCU_thumb, down = device_commands.HCU_thumb, cockpit_device_id=devices.RADAR, value_up = 0, value_down = -1, name = _('HCU thumb down'), category = _('Hand Control Unit')},

{ up=device_commands.HCU_IR_TV, down=device_commands.HCU_IR_TV, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU TCS mode'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_RDR, down=device_commands.HCU_RDR, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU radar mode'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_DDD_cursor, down=device_commands.HCU_DDD_cursor, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU DDD mode'),	 category=_('Hand Control Unit')},
{ up=device_commands.HCU_TID_cursor, down=device_commands.HCU_TID_cursor, cockpit_device_id=devices.HCU, value_up=0.0, value_down=1.0, 	name=_('HCU TID mode'),	 category=_('Hand Control Unit')},

{ up = device_commands.RADAR_elevation_updown, down = device_commands.RADAR_elevation_updown, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar elevation up'), category = _('Radar Control Panel')},
{ up = device_commands.RADAR_elevation_updown, down = device_commands.RADAR_elevation_updown, cockpit_device_id=devices.RADAR, value_down = -1, value_up = 0, name = _('Radar elevation down'), category = _('Radar Control Panel')},
{ up = device_commands.RADAR_azimuth_leftright, down = device_commands.RADAR_azimuth_leftright, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar azimuth right'), category = _('Radar Control Panel')},
{ up = device_commands.RADAR_azimuth_leftright, down = device_commands.RADAR_azimuth_leftright, cockpit_device_id=devices.RADAR, value_down = -1, value_up = 0, name = _('Radar azimuth left'), category = _('Radar Control Panel')},
{ up = device_commands.RADAR_elevation_center, down = device_commands.RADAR_elevation_center, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar elevation re-center'), category = _('Radar Control Panel')},
{ up = device_commands.RADAR_azimuth_center, down = device_commands.RADAR_azimuth_center, cockpit_device_id=devices.RADAR, value_down = 1, value_up = 0, name = _('Radar azimuth re-center'), category = _('Radar Control Panel')},
{ down = device_commands.RADAR_elevation_bars_change, cockpit_device_id=devices.RADAR, value_down = 1, name = _('Radar elevation bars increase'), category = _('Radar Control Panel')},
{ down = device_commands.RADAR_elevation_bars_change, cockpit_device_id=devices.RADAR, value_down = -1, name = _('Radar elevation bars decrease'), category = _('Radar Control Panel')},
{ down = device_commands.RADAR_azimuth_scan_change, cockpit_device_id=devices.RADAR, value_down = 1, name = _('Radar azimuth scan wider'), category = _('Radar Control Panel')},
{ down = device_commands.RADAR_azimuth_scan_change, cockpit_device_id=devices.RADAR, value_down = -1, name = _('Radar azimuth scan narrower'), category = _('Radar Control Panel')},

{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_PSRCH,   value_down = 1, up = device_commands.RADAR_DDD_WCS_PSRCH,   value_up = 0, name = _('RADAR Pulse Search'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_TWSMAN,  value_down = 1, up = device_commands.RADAR_DDD_WCS_TWSMAN,  value_up = 0, name = _('RADAR Track While Scan manual'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_TWSAUTO, value_down = 1, up = device_commands.RADAR_DDD_WCS_TWSAUTO, value_up = 0, name = _('RADAR Track While Scan auto'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_RWS,     value_down = 1, up = device_commands.RADAR_DDD_WCS_RWS,     value_up = 0, name = _('RADAR Range While Scan'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_PDSRCH,  value_down = 1, up = device_commands.RADAR_DDD_WCS_PDSRCH,  value_up = 0, name = _('RADAR Pulse Doppler Search'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_PSTT,    value_down = 1, up = device_commands.RADAR_DDD_WCS_PSTT,    value_up = 0, name = _('RADAR Pulse Single Target Track'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_WCS_PDSTT,   value_down = 1, up = device_commands.RADAR_DDD_WCS_PDSTT,   value_up = 0, name = _('RADAR Pulse Doppler Single Target Track'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_DDD_display_IFF, value_down = 1, up = device_commands.RADAR_DDD_display_IFF, value_up = 0, name = _('DDD Interrogate Friend or Foe'), category = _('Radar Control Panel')},

{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_VSL_switch, value_down = 1, up = device_commands.RADAR_VSL_switch, value_up = 0, name = _('VSL High'), category = _('Radar Control Panel')},
{ cockpit_device_id=devices.RADAR, down = device_commands.RADAR_VSL_switch, value_down = -1, up = device_commands.RADAR_VSL_switch, value_up = 0, name = _('VSL Low'), category = _('Radar Control Panel')},


})

-- joystick axes
join_override(res.axisCommands,{

{combos={{key='JOY_X'}},action = device_commands.HCU_leftright, cockpit_device_id=devices.HCU, name = _('HCU left/right')},
{combos={{key='JOY_Y'}},action = device_commands.HCU_updown, cockpit_device_id=devices.HCU, name = _('HCU up/down')},
{action = device_commands.HCU_DualTriggerAxisThresh, cockpit_device_id=devices.HCU, name = _('HCU dual stage trigger (axis thresholds)')},
{action = device_commands.HCU_thumb_axis, cockpit_device_id=devices.RADAR, name = _('HCU vernier thumbwheel')},

{action = device_commands.LANTIRN_XAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN Slew X')},
{action = device_commands.LANTIRN_YAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN Slew Y')},
{action = device_commands.LANTIRN_TriggerAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN Trigger Axis (Latched, Lase, Designate)')},
{action = device_commands.LANTIRN_S4_XAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN S4 HAT X Axis (QDES)')},
{action = device_commands.LANTIRN_S4_YAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN S4 HAT Y Axis (QSNO, QHUD)')},
{action = device_commands.LANTIRN_S3_XAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN S3 HAT X Axis (WP-, WP+)')},
{action = device_commands.LANTIRN_S3_YAxis, cockpit_device_id=devices.LANTIRN, name = _('LANTIRN S3 HAT Y Axis (AREA, POINT)')},
{action = device_commands.RADIO_ICS_ButtonAxisThresh_ICS_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button ICS (Intercom) PTT (axis threshold)')},
{action = device_commands.RADIO_ICS_ButtonAxisThresh_MIC_RIO, cockpit_device_id=devices.ICS, name = _('ICS Button MIC (UHF) PTT (axis threshold)')},
{action = device_commands.RADIO_ICS_ButtonAxisThresh_ICS_RIO_Export_Only, cockpit_device_id=devices.ICS, name = _('ICS Button ICS (Intercom) PTT (axis threshold) - SRS or VoIP Only / No Menu')},
{action = device_commands.RADIO_ICS_ButtonAxisThresh_MIC_RIO_Export_Only, cockpit_device_id=devices.ICS, name = _('ICS Button MIC (UHF) PTT (axis threshold) - SRS or VoIP Only / No Menu')},
{action = device_commands.RADAR_elevation_center_knob, cockpit_device_id=devices.RADAR, name = _('Radar elevation control')},
{action = device_commands.RADAR_azimuth_center_knob, cockpit_device_id=devices.RADAR, name = _('Radar azimuth control')},
{action = device_commands.RADAR_DDD_erase_axis, cockpit_device_id=devices.RADAR, name = _('DDD Erase')},
{action = device_commands.RADAR_DDD_pulse_gain_axis, cockpit_device_id=devices.RADAR, name = _('DDD Pulse gain')},
{action = device_commands.RADAR_DDD_pulse_vid_axis, cockpit_device_id=devices.RADAR, name = _('DDD Pulse Video')},
{action = device_commands.RADAR_DDD_bright_axis, cockpit_device_id=devices.RADAR, name = _('DDD Brightness')},

{action = device_commands.RADAR_azimuth_analog_adjust, cockpit_device_id=devices.RADAR, name = _('Radar azimuth relative adjustment')},
{action = device_commands.RADAR_elevation_analog_adjust, cockpit_device_id=devices.RADAR, name = _('Radar elevation relative adjustment')},
{action = device_commands.HCU_thumb_analog_adjust, cockpit_device_id=devices.RADAR, name = _('HCU vernier thumbwheel relative adjustment')},

{action = device_commands.TCS_Trim_az_axis, cockpit_device_id=devices.TCS, name = _('TCS azimuth trim axis')},
{action = device_commands.TCS_Trim_el_axis, cockpit_device_id=devices.TCS, name = _('TCS elevation trim axis')},

{action = device_commands.RADIO_ICS_Vol_RIO_axis, cockpit_device_id=devices.ICS, name = _('ICS Volume RIO')},
{action = device_commands.RWR_ALR67_Volume_axis, cockpit_device_id=devices.ICS, name = _('AN/ALR-67 Volume')},
{action = device_commands.RADIO_VHF_VOL_RIO_axis, cockpit_device_id=devices.ARC182, name = _('VHF/UHF ARC-182 Volume RIO')},
{action = device_commands.TACAN_Knob_Vol_RIO_axis, cockpit_device_id=devices.TACAN, name = _('TACAN Volume')},
{action = device_commands.TID_contrast_axis, cockpit_device_id=devices.TID, name = _('TID Contrast')},
{action = device_commands.TID_bright_axis, cockpit_device_id=devices.TID, name = _('TID Brightness')},
{action = device_commands.ECMD_Knob_Brightness_axis, cockpit_device_id=devices.ECMD, name = _('ECMD Brightness')},
{action = device_commands.DECM_Vol_Knob_axis, cockpit_device_id=devices.DECM, name = _('DECM ALQ-100 Volume')},


{action = iCommandViewHorizontalAbs			, name = _('Absolute Camera Horizontal View')},
{action = iCommandViewVerticalAbs			, name = _('Absolute Camera Vertical View')},
{action = iCommandViewZoomAbs				, name = _('Zoom View')},
{action = iCommandViewRollAbs 				, name = _('Absolute Roll Shift Camera View')},
{action = iCommandViewHorTransAbs 			, name = _('Absolute Horizontal Shift Camera View')},
{action = iCommandViewVertTransAbs 			, name = _('Absolute Vertical Shift Camera View')},
{action = iCommandViewLongitudeTransAbs 	, name = _('Absolute Longitude Shift Camera View')},

})

return res
