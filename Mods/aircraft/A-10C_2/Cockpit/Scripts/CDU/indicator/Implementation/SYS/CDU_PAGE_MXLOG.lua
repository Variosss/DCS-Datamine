dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameMXLOG",   2, 1, LFT, "MXLOG")

AddStaticText("INCR",     2, 3, LFT,  "INCR")
AddStaticText("DECR",    23, 3, RGHT, "DECR")
AddStaticText("MISSION",  2, 4, LFT, "MISSION DATE TIME")
AddStaticText("EMPTY",    3, 5, LFT, "EMPTY MX LOG")
AddStaticText("ERASE",    2, 7, LFT,  "ERASE LOG")
AddText("ERASE_SA",       1, 7, LFT, {{"LruTestMode", 1}}, SYS_ACTION)

AddStaticText("WRITE",    2, 9, LFT,  "WRITE LOG")

AddStaticText("MXOPT",	 23, 7, RGHT, "MXOPT")


add_static_hint_CDU("L1", _("Cycle forward to the next recorded log file. Not Functional"))
add_static_hint_CDU("L3", _("Erase all maintenance logs. Not Functional"))
add_static_hint_CDU("L4", _("Create a maintenance log. Not Functional"))

add_static_hint_CDU("R1", _("Cycle back to the previous recorded log file. Not Functional"))
add_static_hint_CDU("R3", _("View log data. Not Functional"))