dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPS", 2, 1, LFT, "GPS")

AddStaticText("INIT",		     1, 3, LFT, SYS_ACTION .. "INIT")
AddText		 ("EGICurrentMode",	 6, 3, LFT, {{"gpsCurrentMode", 1}}, "*")
AddStaticText("NAV",		     1, 5, LFT, SYS_ACTION .. "NAV")
AddText		 ("EGICurrentMode1",	 5, 5, LFT, {{"gpsCurrentMode", 4}}, "*")

AddStaticText("FOM",		 8, 3, LFT, "FOM")
AddText		("EGI_GPS_FOM",	15, 3, RGHT, {{"EGI_FOM", 2, 0}}, "*")
AddText		("EGI_GPS_FOM1",	15, 3, RGHT, {{"EGI_FOM", 2, 1}}, "1")
AddText		("EGI_GPS_FOM2",	15, 3, RGHT, {{"EGI_FOM", 2, 2}}, "2")
AddText		("EGI_GPS_FOM3",	15, 3, RGHT, {{"EGI_FOM", 2, 3}}, "3")
AddText		("EGI_GPS_FOM4",	15, 3, RGHT, {{"EGI_FOM", 2, 4}}, "4")
AddText		("EGI_GPS_FOM5",	15, 3, RGHT, {{"EGI_FOM", 2, 5}}, "5")
AddText		("EGI_GPS_FOM6",	15, 3, RGHT, {{"EGI_FOM", 2, 6}}, "6")
AddText		("EGI_GPS_FOM7",	15, 3, RGHT, {{"EGI_FOM", 2, 7}}, "7")
AddText		("EGI_GPS_FOM8",	15, 3, RGHT, {{"EGI_FOM", 2, 8}}, "8")
AddText		("EGI_GPS_FOM9",	15, 3, RGHT, {{"EGI_FOM", 2, 9}}, "9")

AddStaticText("EHE",		 8, 4, LFT, "EHE")
AddText		("EGI_GPS_EHE",	15, 4, RGHT, {{"GPSParamsPresent", 0}}, "****")
AddText		("EGI_GPS_EHE1",	15, 4, RGHT, {{"GPSParamsPresent", 1}, {"EGI_GPS_EHE"}})

AddStaticText("EVE",		 8, 5, LFT, "EVE")
AddText		("EGI_GPS_EVE",	15, 5, RGHT, {{"GPSParamsPresent", 0}}, "****")
AddText		("EGI_GPS_EVE1",	15, 5, RGHT, {{"GPSParamsPresent", 1}, {"EGI_GPS_EVE"}})

AddStaticText("ST5",		 8, 6, LFT, "ST5")
AddText		("EGI_GPS_ST5",	15, 6, RGHT, {{"GPSParamsPresent", 0}}, "****")
AddText		("EGI_GPS_ST51",	15, 6, RGHT, {{"GPSParamsPresent", 1}, {"EGI_GPS_ST5"}})

AddStaticText("ST3",		 8, 7, LFT, "ST3")
AddText		("EGI_GPS_ST3",	15, 7, RGHT, {{"GPSParamsPresent", 0}}, "****")
AddText		("EGI_GPS_ST31",	15, 7, RGHT, {{"GPSParamsPresent", 1}, {"EGI_GPS_ST3"}})

AddStaticText("GPSSTAT",	24, 3, RGHT, "GPSSTAT" .. BRANCH_R)
AddStaticText("GPSBIT",		24, 5, RGHT, "GPSBIT" .. BRANCH_R)
AddStaticText("TIME",		24, 7, RGHT, "TIME" .. BRANCH_R)
AddStaticText("GPSKEYS",	24, 9, RGHT, "GPSKEYS" .. BRANCH_R)

add_static_hint_CDU("L1", _("Command a GPS Initialization"))
add_static_hint_CDU("L2", _("Command a GPS-only navigation mode"))
add_static_hint_CDU("R1", _("Branch to the GPSSTAT Page"))
add_static_hint_CDU("R2", _("Branch to the GPSBIT Page"))
add_static_hint_CDU("R3", _("Branch to the TIME Page"))
add_static_hint_CDU("R4", _("Branch to the GPSKEYS Page"))
