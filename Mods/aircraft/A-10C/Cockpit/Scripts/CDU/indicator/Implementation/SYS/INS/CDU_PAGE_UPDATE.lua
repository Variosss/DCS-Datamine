dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameUPDATE",		 2, 1, LFT, "UPDATE")

AddText		 ("STRNumber",		    2, 3, LFT, {{"CurrSteerPointNumber", 0}}, "****")
AddText		 ("STRNumber1",		    2, 3, LFT, {{"CurrSteerPointNumber", 1}})

AddStaticText("RTR",               24, 3, RGHT, ROTARY)
AddText		 ("CoordFormat0",      23, 3, RGHT, {{"FROM_CoordFormat", 0}}, "L/L")
AddText		 ("CoordFormat1",      23, 3, RGHT, {{"FROM_CoordFormat", 1}}, "UTM")

AddStaticText("DIS",                7, 4, LFT, "DIS")
AddText		 ("STRDIS",			   17, 4, RGHT, {{"STRInfoPresent", 0}}, "*****")
AddText		 ("STRDIS1",			   17, 4, RGHT, {{"STRInfoPresent", 1}, {"STRDIS"}})

AddText		 ("STRIdent",		    2, 5, LFT, {{"STRIdent", 0}}, "************")
AddText		 ("STRIdent1",		    2, 5, LFT, {{"STRIdent", 1}})

AddStaticText("OPTIONS_HS0",       16, 5, LFT, "MV")
AddText      ("MV",                23, 5, RGHT, {{"MagneticVariation"}})
AddText      ("OPTIONS_EQUAL",     18, 5, LFT,  {{"EqualSign"}}, "=")

AddStaticText("STRTTG",			   7, 6, LFT, "TTG")
AddText		 ("STRTTG1",			   11, 6, LFT, {{"STRInfoPresent", 0}}, "********")
AddText		 ("STRTTG2",			   11, 6, LFT, {{"STRInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("STRTTG3",			   11, 6, LFT, {{"STRInfoPresent", 1}, {"NotMoving", 1, 3}, {"STRTTG"}})

AddText		 ("WAYPTLatUTM",	    2, 7, LFT, {{"STRInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLat",		    2, 7, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 0}, {"SteerLat"}})
AddText		 ("WAYPTUTM",		    2, 7, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 1}, {"SteerUTM"}})
AddText		 ("WAYPTLongMGRS",	    2, 9, LFT, {{"STRInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLong",		    2, 9, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 0}, {"SteerLong"}})
AddText		 ("WAYPTMGRS",		    2, 9, LFT, {{"STRInfoPresent", 1}, {"FROM_CoordFormat", 1}, {"SteerMGRS"}})

AddText      ("INS",               24, 7, RGHT, {{"EGI_NS", 0}}, "PROCEED"..SYS_ACTION)
AddText      ("INS1",               24, 7, RGHT, {{"EGI_NS", 1}}, "PROCEED"..SYS_ACTION)
AddText      ("INS2",               24, 7, RGHT, {{"EGI_NS", 2}}, "PROCEED"..SYS_ACTION)

AddStaticText("STREL",			   17, 9, LFT, "EL")
AddText		 ("STREL1",			   23, 9, RGHT, {{"STRInfoPresent", 0}, {"STRELPresent", 0}}, "*****")
AddText		 ("STREL2",			   23, 9, RGHT, {{"STRInfoPresent", 1}, {"STRELPresent", 0}}, "*****")
AddText		 ("STREL3",			   23, 9, RGHT, {{"STRInfoPresent", 1}, {"STRELPresent", 1}, {"STREL"}})

add_static_hint_CDU("R1", _("Cycle the coordinate format"))
add_static_hint_CDU("R3", _("PROCEED. When pressed you can press MK button to take the INS update"))


