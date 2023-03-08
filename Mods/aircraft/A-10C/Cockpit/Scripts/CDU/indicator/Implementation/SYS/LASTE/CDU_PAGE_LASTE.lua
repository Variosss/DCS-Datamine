dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameLASTE",  2, 1, LFT, "LASTE")

AddStaticText("READY",			2, 3, LFT, "READY")
AddStaticText("YES",		   11, 3, LFT, "YES")

AddText("OFP_SA",               1, 5, LFT, {{"LruTestMode", 1}}, SYS_ACTION)
AddStaticText("OFP",			2, 5, LFT, "OFP")
AddStaticText("NOT_ATTEMPTED", 11, 5, LFT, "NOT ATTEMPTED")

AddStaticText("INIT",			2, 6, LFT, "INIT")
AddStaticText("SUCCESSFUL",    11, 6, LFT, "SUCCESSFUL")

AddStaticText("SERVICE",		2, 7, LFT, "SERVICE")
AddStaticText("LOAD_PASS",	   11, 7, LFT, "LOAD PASS")

AddStaticText("WPN_EVENTS",		2, 8, LFT, "WPN EVENTS")
AddText		 ("WPN_EVENTS1",    16, 8, RGHT, {{"WPN_EVENTS"}})

AddStaticText("GCAS_MSGS",		2, 9, LFT, "GCAS MSGS")
AddText		 ("GCAS_MSGS1",     16, 9, RGHT, {{"GCAS_MSGS"}})

AddStaticText("LASTE_V",	   17, 3, LFT, "LASTE")
AddText      ("LASTE_ST0",     23, 3, LFT, {{"LASTEStatus", 0}}, "N")
AddText      ("LASTE_ST2",     23, 3, LFT, {{"LASTEStatus", 2}}, "V")

AddStaticText("WIND",		   24, 9, RGHT, "WIND" .. BRANCH_R)

add_static_hint_CDU("R4", _("Branch to the WIND Page"))
