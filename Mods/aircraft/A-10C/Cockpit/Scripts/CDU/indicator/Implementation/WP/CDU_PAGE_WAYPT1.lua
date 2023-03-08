dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("WAYPT_INCR_DECR",    1, 3, LFT, INC_DEC)

AddText("FROM_TITLE",              15, 2, LFT, {{"AnnVisible", 0}, {"FROM_ToToMode", 2}}, "FROM:")
AddText("FROM_NUMBER",             20, 2, LFT, {{"AnnVisible", 0}, {"FROM_ToToMode", 2},{"FROM_WaypointNumber"}})

AddText		 ("WAYPTNumber",	    2, 3, LFT, {{"CurrWAYPTNumber", 0}}, "****")
AddText		 ("WAYPTNumber1",	    2, 3, LFT, {{"CurrWAYPTNumber", 1}})
AddText		 ("STEERPTIndicator",   7, 3, LFT, {{"STEERPTIndicator"}}, "SP")

AddText		 ("BRACKETS_EL",	    1, 5, LFT, {{"WAYPT_BRACKETS_EL"}}, DATA_ENTRY)
AddStaticText("EL",					2, 5, LFT, "EL:")
AddText		 ("WAYPT_EL1",		    5, 5, LFT, {{"WAYPTInfoPresent", 0}}, "*****")
AddText		 ("WAYPT_EL2",		    5, 5, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPT_EL_AVAIL", 0}}, "*****")
AddText		 ("WAYPT_EL3",		    5, 5, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPT_EL_AVAIL", 1}, {"WAYPT_EL"}})

AddText		 ("WAYPT_CR_FLAG",	    2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPT_CR_FLAG", 0}}, "NO CR")
AddText		 ("WAYPT_CR_FLAG1",	    2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPT_CR_FLAG", 1}}, "CR")

AddStaticText("BRACKETS_WPT_NAME", 24, 3, RGHT, DATA_ENTRY)
AddText		 ("WAYPTIdent",		   23, 3, RGHT, {{"WAYPTIdent", 0}}, "************")
AddText		 ("WAYPTIdent1",  	   23, 3, RGHT, {{"WAYPTIdent", 1}})

AddText		 ("WAYPTClass",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 0}}, "******")
AddText		 ("WAYPTClass1",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  0}}, "AIMP")
AddText		 ("WAYPTClass2",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  1}}, "A-CIV")
AddText		 ("WAYPTClass3",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  2}}, "A-JNT")
AddText		 ("WAYPTClass4",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  3}}, "A-MIL")
AddText		 ("WAYPTClass5",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  4}}, "A-OTH")
AddText		 ("WAYPTClass6",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  5}}, "LOCAL")
AddText		 ("WAYPTClass7",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  6}}, "NDB")
AddText		 ("WAYPTClass8",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  7}}, "NDBDME")
AddText		 ("WAYPTClass9",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  8}}, "TACAN")
AddText		 ("WAYPTClass10",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass",  9}}, "VOR")
AddText		 ("WAYPTClass11",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 10}}, "VORDME")
AddText		 ("WAYPTClass12",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 11}}, "VORTAC")
AddText		 ("WAYPTClass13",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 12}}, "WAY-B")
AddText		 ("WAYPTClass14",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 13}}, "WAY-H")
AddText		 ("WAYPTClass15",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 14}}, "WAY-L")
AddText		 ("WAYPTClass16",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 15}}, "WAY-R")
AddText		 ("WAYPTClass17",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 16}}, "WAY-T")
AddText		 ("WAYPTClass18",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 17}}, "W-IAP")
AddText		 ("WAYPTClass19",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 18}}, "W-SID")
AddText		 ("WAYPTClass20",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 19}}, "W-STAR")
AddText		 ("WAYPTClass21",  	   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTClass", 20}}, "UNK")

AddStaticText("DTOT",			   24, 5, RGHT, "DTOT" .. DATA_ENTRY)
AddText		 ("WAYPT_DTOT",		   18, 5, RGHT, {{"WAYPT_DTOT", 0}}, "********")
AddText		 ("WAYPT_DTOT1",  	   18, 5, RGHT, {{"WAYPT_DTOT", 1}})

AddStaticText("TGTSYM_NEW_WPT",	   24, 7, RGHT, SYS_ACTION)
AddText		 ("NEW_WAYPT_NUM", 	   23, 7, RGHT, {{"NEW_WAYPT_NUM"}})

AddStaticText("WND",			   13, 8, LFT, "WND    /")

AddText		 ("WAYPTWindDirection1", 17, 8, LFT, {{"WindParamsValid", 0}}, "***")
AddText		 ("WAYPTWindDirection2", 17, 8, LFT, {{"WindParamsValid", 1}, {"WAYPTWindDirection"}})
AddText		 ("WAYPTWindSpeed1",	 21, 8, LFT, {{"WindParamsValid", 0}}, "***")
AddText		 ("WAYPTWindSpeed2",	 21, 8, LFT, {{"WindParamsValid", 1}, {"WAYPTWindSpeed"}})

AddText		 ("WAYPTCoordFormat",  24, 9, RGHT, {{"WAYPTCoordFormat", 0}}, "L/L" .. ROTARY)
AddText		 ("WAYPTCoordFormat1",  24, 9, RGHT, {{"WAYPTCoordFormat", 1}}, "UTM" .. ROTARY)

AddText      ("WAYPTDATA_ENTRY",    1, 7, LFT, {{"WAYPTDATA_ENTRY"}}, DATA_ENTRY)
AddText		 ("WAYPTLatUTM",	    2, 7, LFT, {{"WAYPTInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLat",		    2, 7, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTCoordFormat", 0}, {"WAYPTLat"}})
AddText		 ("WAYPTUTM",		    2, 7, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTCoordFormat", 1}, {"WAYPTUTM"}})
AddText      ("WAYPTDATA_ENTRY1",   1, 9, LFT, {{"WAYPTDATA_ENTRY"}}, DATA_ENTRY)
AddText		 ("WAYPTLongMGRS",	    2, 9, LFT, {{"WAYPTInfoPresent", 0}}, "**********")
AddText		 ("WAYPTLong",		    2, 9, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTCoordFormat", 0}, {"WAYPTLong"}})
AddText		 ("WAYPTMGRS",		    2, 9, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTCoordFormat", 1}, {"WAYPTMGRS"}})

AddStaticText("PAGE_NUM", 20 + PageNumNorOffset, 10, LFT, "1")

add_static_hint_CDU("L1", _("Enter new waypoint number/markpoint letter from scratchpad"))
add_static_hint_CDU("L2", _("Enter new elevation (mission points only)"))

add_hint_format_controllers_CDU("L3", 
	{_("Enter new waypoint latitude from scratchpad (DDMMTTT)"), 
	 _("Enter new UTM grid from scratchpad (WGS-84 constant)")},
	{{"WAYPTCoordFormatHint"}})

add_hint_format_controllers_CDU("L4", 
	{_("Enter new waypoint longitude from scratchpad (DDDMMTTT)"), 
	 _("Enter new area and/or eastings and northings from scratchpad")},
	{{"WAYPTCoordFormatHint"}})

add_static_hint_CDU("R1", _("Enter new waypoint identifier from scratchpad"))
add_static_hint_CDU("R2", _("Enter new DTOT from scratchpad (HHMMSS); blank scratchpad will erase current DTOT"))
add_static_hint_CDU("R3", _("Copy existing waypoint data into new mission point; enter a new name in the scratchpad prior to pressing this LSK or the new point will be named MSN0XX"))
add_static_hint_CDU("R4", _("Rotary between Lat/Long and UTM"))
