-- F1CE/BE common clickable data description

local gettext = require("i_18n")
_ = gettext.translate

----------------------------------------------------------------
-- Warning lights

-- Master failure warning light
elements["PNT-920"] = default_button(_("Master failure warning light"), 0, devices.MAIN, devCmds.Cmd265, 920)
-- Fire warning light (ENG/AB) + Horn
elements["PNT-940"] = default_button(_("Fire warning light (ENG/AB) + Horn"), 0, devices.MAIN, devCmds.Cmd277, 940)

----------------------------------------------------------------
-- Navigation indicator

-- Mode selector switch
elements["PNT-1204"] = multiposition_switch(_("Mode selector switch"), 0, devices.MAIN, devCmds.Cmd555, 1204, 4, 0.3333, false, false, 0, sounds.sound_IDN_mode_sel, true, 4)
-- Normal/Additional vector selector switch
elements["PNT-1205"] = multiposition_switch(_("Normal/Additional vector selector switch"), 0, devices.MAIN, devCmds.Cmd557, 1205, 2, 1, true, false, 0, sounds.sound_IDN_vect_add_sw, true, anim_speed_default)
-- Additional target selector switch
elements["PNT-1206"] = default_2_position_tumb(_("Additional target selector switch"), 0, devices.MAIN, devCmds.Cmd558, 1206, nil, nil, nil, nil, sounds.sound_IDN_add_tgt_sel)
-- Bearing/Distance selector knob
elements["PNT-1207"] = default_axis(_("Bearing/Distance selector knob"), 0, devices.MAIN, devCmds.Cmd559, 1207, 1, 0.1, false, true)
-- Test button
elements["PNT-1208"] = default_button(_("Test button"), 0, devices.MAIN, devCmds.Cmd560, 1208)	


----------------------------------------------------------------
-- MATRA 550 or Sidewinder jettisoning

-- MATRA 550 or Sidewinder jettison button guard
elements["PNT-962"] = guard_switch(_("MATRA 550 or Sidewinder jettison button guard"), 0, devices.MAIN, devCmds.Cmd561, 962, false, sounds.sound_jettison_cover)
-- MATRA 550 or Sidewinder jettison button
elements["PNT-963"] = default_button(_("MATRA 550 or Sidewinder jettison button"), 0, devices.MAIN, devCmds.Cmd562, 963)


-- Jammer detection light
elements["PNT-194"] = default_button_axis(_("Jammer detection light"), 0, devices.MAIN, devCmds.Cmd291, devCmds.Cmd292, 194, 195)
