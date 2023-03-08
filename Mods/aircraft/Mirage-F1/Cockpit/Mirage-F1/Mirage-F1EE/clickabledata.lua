-- F1EE clickable data description

dofile(LockOn_Options.script_path.."../../Common/clickabledata_common.lua")

RWR_type = get_aircraft_property_or_nil("RWR_type") or "ALR_300"

dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/clickabledata_common_F1C.lua")
dofile(LockOn_Options.script_path.."../../Common/clickabledata_common_F1EE_M.lua")

local gettext = require("i_18n")
_ = gettext.translate


-- Inoperative
elements["PNT-1272"] = springloaded_2pos_switch(_("Inoperative"), 0, devices.MAIN, devCmds.Cmd701, devCmds.Cmd700, 1272, false, nil, sounds.sound_omnibearing_sel_mode)

----------------------------------------------------------------
-- Inertial Navigation System (INS)

-- Parameters selector
elements["PNT-665"] = multiposition_switch(_("Parameters selector"), 0, devices.MAIN, devCmds.Cmd680, 665, 6, 0.1, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 5)
-- Modes selector
elements["PNT-666"] = multiposition_switch(_("Modes selector"), 0, devices.MAIN, devCmds.Cmd681, 666, 9, 0.125, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 5)
-- Waypoints selecting wheel
elements["PNT-667"] = multiposition_switch_cycled_relative(_("Waypoints selecting wheel"), 0, devices.MAIN, devCmds.Cmd682, 667, 10, 0.111, false, 0, sounds.sound_freq_sel, 1)
-- Lights test and brightness selector
elements["PNT-668"] = multiposition_switch(_("Lights test and brightness selector"), 0, devices.MAIN, devCmds.Cmd683, 668, 3, 0.5, false, false, 0, sounds.sound_omnibearing_sel_mode, true, 5)
-- Vertical designation button
elements["PNT-650"] = default_button(_("Vertical designation button"), 0, devices.MAIN, devCmds.Cmd696, 650)
-- Position validation button
elements["PNT-651"] = default_button(_("Position validation button"), 0, devices.MAIN, devCmds.Cmd697, 651)
-- Data insertion button
elements["PNT-652"] = default_button(_("Data insertion button"), 0, devices.MAIN, devCmds.Cmd698, 652)
-- INS - 1 pushbutton
elements["PNT-653"] = default_button(_("INS - 1 pushbutton"), 0, devices.MAIN, devCmds.Cmd685, 653)
-- INS N 2 pushbutton
elements["PNT-654"] = default_button(_("INS N 2 pushbutton"), 0, devices.MAIN, devCmds.Cmd686, 654)
-- INS + 3 pushbutton
elements["PNT-655"] = default_button(_("INS + 3 pushbutton"), 0, devices.MAIN, devCmds.Cmd687, 655)
-- INS W 4 pushbutton
elements["PNT-656"] = default_button(_("INS W 4 pushbutton"), 0, devices.MAIN, devCmds.Cmd688, 656)
-- INS 5 pushbutton
elements["PNT-657"] = default_button(_("INS 5 pushbutton"), 0, devices.MAIN, devCmds.Cmd689, 657)
-- INS 6 E pushbutton
elements["PNT-658"] = default_button(_("INS 6 E pushbutton"), 0, devices.MAIN, devCmds.Cmd690, 658)
-- INS 7 pushbutton
elements["PNT-659"] = default_button(_("INS 7 pushbutton"), 0, devices.MAIN, devCmds.Cmd691, 659)
-- INS 8 S pushbutton
elements["PNT-660"] = default_button(_("INS 8 S pushbutton"), 0, devices.MAIN, devCmds.Cmd692, 660)
-- INS 9 pushbutton
elements["PNT-661"] = default_button(_("INS 9 pushbutton"), 0, devices.MAIN, devCmds.Cmd693, 661)
-- INS * pushbutton
elements["PNT-662"] = default_button(_("INS * pushbutton"), 0, devices.MAIN, devCmds.Cmd695, 662)
-- INS 0 pushbutton
elements["PNT-663"] = default_button(_("INS 0 pushbutton"), 0, devices.MAIN, devCmds.Cmd684, 663)
-- INS CLR pushbutton
elements["PNT-664"] = default_button(_("INS CLR pushbutton"), 0, devices.MAIN, devCmds.Cmd694, 664)

for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end
