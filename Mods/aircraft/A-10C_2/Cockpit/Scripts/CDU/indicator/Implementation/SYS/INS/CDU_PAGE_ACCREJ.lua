dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameACCREJ",		 2, 1, LFT, "AC/REJ")

AddStaticText("RTR",               24, 3, RGHT, ROTARY)
AddText		 ("CoordFormat0",      23, 3, RGHT, {{"FROM_CoordFormat", 0}}, "L/L")
AddText		 ("CoordFormat1",      23, 3, RGHT, {{"FROM_CoordFormat", 1}}, "UTM")

AddStaticText("ACCEPT",             1, 5, LFT,  SYS_ACTION.."ACCEPT")
AddStaticText("REJECT",            24, 5, RGHT, "REJECT"..SYS_ACTION)

AddText		 ("WAYPTLatUTM",	    2, 7, LFT, {{"STRInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLat",		    2, 7, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 0}, {"SteerLat"}})
AddText		 ("WAYPTUTM",		    2, 7, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 1}, {"SteerUTM"}})
AddText		 ("WAYPTLongMGRS",	    2, 9, LFT, {{"STRInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLong",		    2, 9, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 0}, {"SteerLong"}})
AddText		 ("WAYPTMGRS",		    2, 9, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 1}, {"SteerMGRS"}})

AddStaticText("NS",                 2, 6, LFT, "N")
AddText      ("NS_ERR",             7, 6, RGHT,  {{"SteerNorthSouthErr"}})
AddStaticText("WE",                18, 6, LFT, "E")
AddText      ("WE_ERR",            23, 6, RGHT, {{"SteerWestEastErr"}})

AddStaticText("MHD",               18, 7, LFT, "MHD")
AddText      ("MHD_ERR",           21, 7, LFT, {{"SteerMhdErr"}})

AddStaticText("DIS",               16, 8, LFT, "DIS")
AddText		 ("STRDIS",			   23, 8, RGHT, {{"SteerDistErr"}})

AddStaticText("STREL",			   17, 9, LFT, "EL")
AddText		 ("STREL3",			   23, 9, RGHT, {{"STRELPresent", 1}, {"STREL"}})

add_static_hint_CDU("L2", _("Accept the INS overhead update at this location"))

add_static_hint_CDU("R1", _("Cycle the coordinate format"))
add_static_hint_CDU("R2", _("Reject the INS overhead update at this location"))


