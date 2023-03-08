dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameEGITEST",2, 1, LFT, "EGITEST")

AddStaticText("GPS_SA",         2, 3, LFT, "GPS")
AddText("GPS_SA1",               1, 3, LFT, {{"IsGPSTestAvailable"}}, SYS_ACTION)
AddText("GPS_STATUS0",          6, 3, LFT, {{"GPSStatus", 0}}, "UN")
AddText("GPS_STATUS1",          6, 3, LFT, {{"GPSStatus", 1}}, "IP")
AddText("GPS_STATUS2",          6, 3, LFT, {{"GPSStatus", 2}}, "GO")
AddText("GPS_STATUS3",          6, 3, LFT, {{"GPSStatus", 3}}, "NG")

AddStaticText("INS",            2, 5, LFT, "INS")
AddText("INS_SA",               1, 5, LFT, {{"IsINSTestAvailable"}}, SYS_ACTION)
AddText("INS_STATUS0",          6, 5, LFT, {{"INSStatus", 0}}, "UN")
AddText("INS_STATUS1",          6, 5, LFT, {{"INSStatus", 1}}, "IP")
AddText("INS_STATUS2",          6, 5, LFT, {{"INSStatus", 2}}, "GO")
AddText("INS_STATUS3",          6, 5, LFT, {{"INSStatus", 3}}, "NG")


AddStaticText("MSN_SA",         2, 7, LFT, "MSN")
AddText("MSN",                  1, 7, LFT, {{"IsMSNTestAvailable"}}, SYS_ACTION)
AddText("MSN_STATUS0",          6, 7, LFT, {{"MSNStatus", 0}}, "UN")
AddText("MSN_STATUS1",          6, 7, LFT, {{"MSNStatus", 1}}, "IP")
AddText("MSN_STATUS2",          6, 7, LFT, {{"MSNStatus", 2}}, "GO")
AddText("MSN_STATUS3",          6, 7, LFT, {{"MSNStatus", 3}}, "NG")



AddStaticText("STOP_MSN",       2, 9, LFT, "STOP MSN")
AddText("STOP_SA",        1, 9, LFT, {{"IsMSNTestAvailable"}}, SYS_ACTION)


AddStaticText("LRUTEST",       24, 9, RGHT, "LRUTEST" .. BRANCH_R)

add_static_hint_CDU("L1", _("Run the Global Positioning System (GPS) Test"))
add_static_hint_CDU("L2", _("Run the Inertial Navigation System (INS) Test"))
add_static_hint_CDU("L3", _("Run the EGI MSN LRU Test"))
add_static_hint_CDU("L4", _("Cease the EGI MSN LRU Test"))

add_static_hint_CDU("R4", _("Branch to the LRUTEST page"))