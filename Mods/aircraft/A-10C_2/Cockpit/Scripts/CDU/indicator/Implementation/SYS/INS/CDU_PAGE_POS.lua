dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNamePOS", 2, 1, LFT, "POS")

AddText		 ("PresPositLat",    2, 3, LFT, {{"PresPosPresent", 0}}, "***********")
AddText		 ("PresPositLat1",    2, 3, LFT, {{"PresPosPresent", 1}, {"PresPositLat"}})
AddText		 ("PresPositLong",   2, 4, LFT, {{"PresPosPresent", 0}}, "***********")
AddText		 ("PresPositLong1",   2, 4, LFT, {{"PresPosPresent", 1}, {"PresPositLong"}})

AddText		 ("PresPositUTM",	 2, 6, LFT, {{"PresPosPresent", 0}}, "*******")
AddText		 ("PresPositUTM1",    2, 6, LFT, {{"PresPosPresent", 1}, {"PresPositUTM"}})
AddText		 ("PresPositMGRS",	 2, 7, LFT, {{"PresPosPresent", 0}}, "**************")
AddText		 ("PresPositMGRS1",   2, 7, LFT, {{"PresPosPresent", 1}, {"PresPositMGRS"}})

AddStaticText("CTD",			 2, 8, LFT, "CROSS TRK DEV")
AddText      ("CTD_VAL",        16, 8, LFT, {{"CrossTrackDev"}})

AddStaticText("G_ALT",			 2, 9, LFT, "G ALT")
AddText		 ("GPSAltitude",	 8, 9, LFT, {{"EGINavMode", 0}}, "******")
AddText		 ("GPSAltitude1",     8, 9, LFT, {{"EGINavMode", 1}, {"GPSAltitude"}})

AddStaticText("NAVMODEROTARY",  24, 3, RGHT, ROTARY)
AddText		 ("FLIGHT_DRIVER",  23, 3, RGHT, {{"EGI_PosSource", 0}}, "NONE")
AddText		 ("FLIGHT_DRIVER1",  23, 3, RGHT, {{"EGI_PosSource", 1}}, "BLENDED")
AddText		 ("FLIGHT_DRIVER2",  23, 3, RGHT, {{"EGI_PosSource", 2}}, "GPS")
AddText		 ("FLIGHT_DRIVER3",  23, 3, RGHT, {{"EGI_PosSource", 3}}, "INS")

add_static_hint_CDU("R1", _("Select present position determination"))