-- F1EE/M common clickable data description

local gettext = require("i_18n")
_ = gettext.translate

RWR_type = RWR_type or "ALR_300"

----------------------------------------------------------------
-- Warning lights

-- Left master failure warning light
elements["PNT-920"] = default_button(_("Left master failure warning light"), 0, devices.MAIN, devCmds.Cmd265, 920)
-- Right master failure warning light
elements["PNT-922"] = default_button(_("Right master failure warning light"), 0, devices.MAIN, devCmds.Cmd678, 922)
-- Fire warning light AB + Horn
elements["PNT-940"] = default_button(_("Fire warning light AB + Horn"), 0, devices.MAIN, devCmds.Cmd277, 940)
-- Fire warning light ENG + Horn
elements["PNT-936"] = default_button(_("Fire warning light ENG + Horn"), 0, devices.MAIN, devCmds.Cmd679, 936)


----------------------------------------------------------------
-- Navigation indicator

-- Gyromagnetic-True IDN heading selector
elements["PNT-1254"] = default_2_position_tumb(_("Gyromagnetic/True IDN heading selector"), 0, devices.MAIN, devCmds.Cmd655, 1254, 1, {0, 1}, true, true, nil, true)
-- VOR/Radar narrow needle selector
elements["PNT-1255"] = default_2_position_tumb(_("VOR/Radar narrow needle selector"), 0, devices.MAIN, devCmds.Cmd656, 1255, 1, {0, 1}, true, true, nil, true)
-- Mode selector switch
elements["PNT-1256"] = multiposition_switch(_("Mode selector switch"), 0, devices.MAIN, devCmds.Cmd657, 1256, 6, 0.2, false, false, 0, nil, true, 6)
-- Additional vector bearing/distance adjustment switch
elements["PNT-1257"] = springloaded_2pos_switch(_("Additional vector bearing/distance adjustment switch"), 0, devices.MAIN, devCmds.Cmd659, devCmds.Cmd660, 1257, false, nil, nil)


----------------------------------------------------------------
-- In-flight refuelling system

-- Transfer/filling switch guard
elements["PNT-400"] = guard_switch(_("Transfer/filling switch guard"), 0, devices.MAIN, devCmds.Cmd664, 400, false, sounds.sound_AB_main_cock_sw_guard)
-- Transfer/filling switch
elements["PNT-401"] = default_2_position_tumb(_("Transfer/filling switch"), 0, devices.MAIN, devCmds.Cmd663, 401, nil, nil, nil, nil, sounds.sound_pump_sw)
-- Aerial refuelling light adjustment potentiometer
elements["PNT-407"] = default_axis_limited(_("Aerial refuelling light adjustment potentiometer"), 0, devices.MAIN, devCmds.Cmd667, 407)


----------------------------------------------------------------
-- BARAX

-- BARAX light test
elements["PNT-1260"] = default_button(_("BARAX light test"), 0, devices.MAIN, devCmds.Cmd707, 1260, nil, nil, nil, sounds.sound_EFF_sw)
elements["PNT-1260"].updatable = true
-- BARAX state selector (OFF/ON/TEST)
elements["PNT-1262"] = multiposition_switch(_("BARAX state selector (OFF/ON/TEST)"), 0, devices.MAIN, devCmds.Cmd705, 1262, 3, 0.5, nil, nil, nil, sounds.sound_warning_horn_sw)
-- BARAX emission ready korry
elements["PNT-1264"] = default_2_position_tumb(_("BARAX emission ready korry"), 0, devices.MAIN, devCmds.Cmd706, 1264, nil, nil, nil, nil, sounds.sound_feeder_tank_fus_sw)


-- ALR-300 control panel
if RWR_type == "ALR_300" then
	-- REG
	elements["PNT-1012"] = default_button(_("ALR-300 Threats parameters recording"), 0, devices.MAIN, devCmds.Cmd670, 1012)
	-- TONO ELIM
	elements["PNT-1013"] = default_button(_("ALR-300 Threats audio off"), 0, devices.MAIN, devCmds.Cmd671, 1013)
	-- EXPL ELIM
	elements["PNT-1014"] = default_button(_("ALR-300 Search threats off"), 0, devices.MAIN, devCmds.Cmd672, 1014)
	-- AMEN ELIM
	elements["PNT-1015"] = default_button(_("ALR-300 Display five most dangerous threats"), 0, devices.MAIN, devCmds.Cmd673, 1015)
	-- CURS
	elements["PNT-1016"] = default_button(_("ALR-300 Detailed threats info"), 0, devices.MAIN, devCmds.Cmd674, 1016)

	-- RWR display brightness
	elements["PNT-1017"] = default_axis_limited(_("ALR-300 display brightness"), 0, devices.MAIN, devCmds.Cmd675, 1017)
	-- RWR test
	elements["PNT-1018"] = default_button(_("ALR-300 test"), 0, devices.MAIN, devCmds.Cmd677, 1018)
end


-- Jammer detection / AAR Feeder tanks overflow light
elements["PNT-194"] = default_button_axis(_("Jammer detection / Feeder tanks overflow light"), 0, devices.MAIN, devCmds.Cmd291, devCmds.Cmd292, 194, 195)

