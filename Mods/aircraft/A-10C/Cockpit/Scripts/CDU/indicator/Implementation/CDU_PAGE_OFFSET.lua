dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameOFFSET",          2, 1, LFT, "OFFSET")

AddStaticText("INITWAYPT_INCR_DECR",     1, 3, LFT, INC_DEC)
AddText		 ("INITWAYPTNumber1",	     2, 3, LFT, {{"INITWAYPTNumber", 0}}, "****")
AddText		 ("INITWAYPTNumber2",        2, 3, LFT, {{"INITWAYPTNumber", 1}})

AddStaticText("BRACKETS_INIT_WP_ID",     1, 5, LFT, DATA_ENTRY)
AddText		 ("INITWAYPTIdent1",	     2, 5, LFT, {{"INITWAYPTIdent", 0}}, "************")
AddText		 ("INITWAYPTIdent2",  	     2, 5, LFT, {{"INITWAYPTIdent", 1}})

AddStaticText("BRACKETS_FIRSTCOORD",     1, 7, LFT, DATA_ENTRY)
AddText		 ("OFFSETWAYPTLatUTM",	     2, 7, LFT, {{"OFFSET_POS_Present", 0}}, "**********")
AddText		 ("OFFSETWAYPTLat",		     2, 7, LFT, {{"OFFSET_POS_Present", 1}, {"OFFSETWAYPTCoordFormat", 0}, {"OFFSETWAYPTLat"}})
AddText		 ("OFFSETWAYPTUTM",		     2, 7, LFT, {{"OFFSET_POS_Present", 1}, {"OFFSETWAYPTCoordFormat", 1}, {"OFFSETWAYPTUTM"}}) 
AddStaticText("BRACKETS_SECONDCOORD",    1, 9, LFT, DATA_ENTRY)
AddText		 ("OFFSETWAYPTLongMGRS",     2, 9, LFT, {{"OFFSET_POS_Present", 0}}, "**********")
AddText		 ("OFFSETWAYPTLong",	     2, 9, LFT, {{"OFFSET_POS_Present", 1}, {"OFFSETWAYPTCoordFormat", 0}, {"OFFSETWAYPTLong"}})
AddText		 ("OFFSETWAYPTMGRS",	     2, 9, LFT, {{"OFFSET_POS_Present", 1}, {"OFFSETWAYPTCoordFormat", 1}, {"OFFSETWAYPTMGRS"}}) 

AddText		 ("OFFSETWAYPTCoordFormat1", 24, 3, RGHT, {{"OFFSETWAYPTCoordFormat", 0}}, "L/L" .. ROTARY)
AddText		 ("OFFSETWAYPTCoordFormat2", 24, 3, RGHT, {{"OFFSETWAYPTCoordFormat", 1}}, "UTM" .. ROTARY)

AddStaticText("BRACKETS_MH_DIS",	    24, 5, RGHT, "MH/DIS:" .. DATA_ENTRY)
--AddText	 ("OFFSETWAYPTMH1",			16, 6, LFT, {{"OFFSETWAYPTPresent", 0}}, "***")
AddText		 ("OFFSETWAYPTMH2",			16, 6, LFT, {{"OFFSETWAYPTMH"}})
AddStaticText("OFFSETDIV",			    19, 6, LFT, "/")
--AddText	 ("OFFSETWAYPTDIS1",		20, 6, LFT, {{"OFFSETWAYPTPresent", 0}}, "****")
AddText		 ("OFFSETWAYPTDIS2",		20, 6, LFT, {{"OFFSETWAYPTDIS"}})

AddStaticText("TARGET_MARK",		    24, 7, RGHT, SYS_ACTION)
AddText		 ("NEW_WAYPT_NUM",	   	    23, 7, RGHT, {{"NEW_WAYPT_NUM"}})

AddStaticText("BRACKETS_WPNUM_LTR",     24, 9, RGHT, DATA_ENTRY)
AddText		 ("OFFSETWAYPTNumber1",	    23, 9, RGHT, {{"OFFSETWAYPTNumber", 0}}, "****")
AddText		 ("OFFSETWAYPTNumber2",     23, 9, RGHT, {{"OFFSETWAYPTNumber", 1}})

add_static_hint_CDU("L1", _("Enter new initial waypoint number/markpoint letter from scratchpad"))
add_static_hint_CDU("L2", _("Enter new initial waypoint identifier from scratchpad"))

add_hint_format_controllers_CDU("L3", 
	{_("Enter new offset latitude from scratchpad (DDMMTTT) and calculate a new heading and distance from the initial point to be displayed in the MH/DIS field"), 
	 _("Enter new UTM grid from scratchpad and calculate a new heading and distance from the initial point to be displayed in the MH/DIS field")},
	{{"OFFSETWAYPTCoordFormatHint"}})

add_hint_format_controllers_CDU("L4", 
	{_("Enter new offset longitude from scratchpad (DDDMMTTT) and calculate a new heading and distance from the initial point to be displayed in the MH/DIS field"), 
	 _("Enter new area and/or eastings and northings, and calculate a new heading and distance from the initial point to be displayed in the MH/DIS field")},
	{{"OFFSETWAYPTCoordFormatHint"}})

add_static_hint_CDU("R1", _("Rotary between Lat/Long and UTM"))
add_static_hint_CDU("R2", _("Enter new magnetic heading and distance (HHHDDD.T); Once entered a new offset point will be computed from the initial waypoint and the coordinates will be displayed on the left."))
add_static_hint_CDU("R3", _("Copy existing waypoint data into new mission point; enter a new name in the scratchpad prior to pressing this LSK or the new point will be named MSN0XX"))
add_static_hint_CDU("R4", _("Enter new offset waypoint number/markpoint letter from scratchpad; the new point coordinates will be displayed left and a new heading and distance from the initial point will be computed and displayed in MH/DIS"))
