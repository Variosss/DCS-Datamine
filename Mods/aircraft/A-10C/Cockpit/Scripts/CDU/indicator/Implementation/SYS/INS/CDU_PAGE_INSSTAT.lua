dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameINSSTAT",		 2, 1, LFT, "INSSTAT")

AddStaticText("MODE",  2, 3, LFT, "MODE:")
AddText      ("MODE0", 8, 3, LFT, {{"insMode", 0}}, "OFF")
AddText      ("MODE1", 8, 3, LFT, {{"insMode", 1}}, "STBY")
AddText      ("MODE2", 8, 3, LFT, {{"insMode", 2}}, "AA")
AddText      ("MODE3", 8, 3, LFT, {{"insMode", 3}}, "SH")
AddText      ("MODE4", 8, 3, LFT, {{"insMode", 4}}, "GC")
AddText      ("MODE5", 8, 3, LFT, {{"insMode", 5}}, "NAV")
AddText      ("MODE6", 8, 3, LFT, {{"insMode", 6}}, "BATH")
AddText      ("MODE7", 8, 3, LFT, {{"insMode", 7}}, "ATT")
AddText      ("MODE8", 8, 3, LFT, {{"insMode", 8}}, "TEST")
AddText      ("MODE9", 8, 3, LFT, {{"insMode", 9}}, "NARF")

AddStaticText("INS_ST",      19, 3, LFT, "INS:")
AddText		 ("INS_ST1",     23, 3, LFT, {{"EGIStatus", 0, 0}}, "N")
AddText		 ("INS_ST2",     23, 3, LFT, {{"EGIStatus", 0, 1}}, "I")
AddText		 ("INS_ST3",     23, 3, LFT, {{"EGIStatus", 0, 2}}, "V")
AddText		 ("INS_ST4",     23, 3, LFT, {{"EGIStatus", 0, 3}}, "F")
AddText		 ("INS_ST5",     23, 3, LFT, {{"EGIStatus", 0, 4}}, "T")

AddStaticText("ADI_ATT", 10, 4, LFT, "ADI ATT")
AddText      ("ADI_ATT0",23, 4, LFT, {{"insAdiAttitudeStatus", 0}}, "F")
AddText      ("ADI_ATT1",23, 4, LFT, {{"insAdiAttitudeStatus", 1}}, "V")

AddStaticText("HUD_ATT", 10, 5, LFT, "HUD ATT")
AddText      ("HUD_ATT1",23, 5, LFT, {{"insHudAttitudeStatus", 0}}, "F")
AddText      ("HUD_ATT2",23, 5, LFT, {{"insHudAttitudeStatus", 1}}, "V")

AddStaticText("NAV_DAT", 10, 6, LFT, "NAV DATA")
AddText      ("NAV_DAT1",23, 6, LFT, {{"insNavDataStatus", 0}}, "F")
AddText      ("NAV_DAT2",23, 6, LFT, {{"insNavDataStatus", 1}}, "V")

AddStaticText("NAV_RDY", 10, 7, LFT, "NAV RDY")
AddText      ("NAV_RDY1",23, 7, LFT, {{"insNavRdyStatus", 0}}, "N")
AddText      ("NAV_RDY2",23, 7, LFT, {{"insNavRdyStatus", 1}}, "D")
AddText      ("NAV_RDY3",23, 7, LFT, {{"insNavRdyStatus", 2}}, "Y")

AddStaticText("ALTITUDE",10, 8, LFT, "ALTITUDE")
AddText      ("ALT_ST1", 23, 8, LFT, {{"insAltitudeStatus", 0}}, "F")
AddText      ("ALT_ST2", 23, 8, LFT, {{"insAltitudeStatus", 1}}, "V")

AddStaticText("SENSORS", 10, 9, LFT, "SENSORS")
AddText      ("SEN_ST1", 23, 9, LFT, {{"insSensorsStatus", 0}}, "F")
AddText      ("SEN_ST2", 23, 9, LFT, {{"insSensorsStatus", 1}}, "V")


AddStaticText("ATT", 1, 5, LFT, SYS_ACTION.. "ATT")

AddStaticText("INS", 1, 9, LFT, BRANCH_L .. "INS")

add_static_hint_CDU("L2", _("Select an Attitude mode (Not Functional)"))
add_static_hint_CDU("L4", _("Branch to the INS Page"))