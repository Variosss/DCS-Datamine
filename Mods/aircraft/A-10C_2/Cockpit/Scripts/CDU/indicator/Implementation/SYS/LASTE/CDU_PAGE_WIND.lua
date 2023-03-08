dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameWIND",	 2, 1, LFT, "WIND")

AddStaticText("BRACKETS_ITEM2",  1, 5, LFT, DATA_ENTRY)

AddStaticText("BRACKETS_ITEM3",  1, 7, LFT, DATA_ENTRY)

AddStaticText("BRACKETS_ITEM4",  1, 9, LFT, DATA_ENTRY)

AddText		 ("WNDDIV",			17, 2, LFT, {{"AnnVisible", 0}}, "/")
AddText		 ("WNDWindDirection1",	14, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 0}}, "***")
AddText		 ("WNDWindDirection2",	14, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 1}, {"WAYPTWindDirection"}})
AddText		 ("WNDWindSpeed1",		18, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 0}}, "***")
AddText		 ("WNDWindSpeed2",		18, 2, LFT, {{"AnnVisible", 0}, {"WindParamsValid", 1}, {"WAYPTWindSpeed"}})
AddText		 ("WINDTemp",		24, 2, RGHT, {{"AnnVisible", 0}, {"TempMode", 0}, {"WINDTempCur", 0}})
AddText		 ("WINDTemp1",		24, 2, RGHT, {{"AnnVisible", 0}, {"TempMode", 1}, {"WINDTempCur", 1}})

AddStaticText("WINDMODE",	    24, 3, RGHT, ROTARY)
AddText		 ("WINDMODE1",       23, 3, RGHT, {{"WINDMODE", 0}}, "NONE")
AddText		 ("WINDMODE2",       23, 3, RGHT, {{"WINDMODE", 1}}, "WIND")
AddText		 ("WINDMODE3",       23, 3, RGHT, {{"WINDMODE", 2}}, "TEMP")
AddText		 ("WINDMODE4",       23, 3, RGHT, {{"WINDMODE", 3}}, "BOTH")


AddStaticText("WNDEDIT",	    24, 5, RGHT, "WNDEDIT" .. BRANCH_R)
AddText		 ("WINDCLRMODE",    24, 7, RGHT, {{"WINDCLRMODE", 0}}, SYS_ACTION)
AddText		 ("WINDCLRMODE1",    24, 7, RGHT, {{"WINDCLRMODE", 1}}, "CLR" .. SYS_ACTION)
AddText		 ("WINDCLRMODE2",    24, 7, RGHT, {{"WINDCLRMODE", 2}}, "CONFIRM" .. SYS_ACTION)
AddStaticText("LASTE",			24, 9, RGHT, "LASTE" .. BRANCH_R)

AddStaticText("PAGE", 19 + PageNumNorOffset, 10, LFT, "P /2")

add_static_hint_CDU("L2", _("Enter a Wind Data"))
add_static_hint_CDU("L3", _("Enter a Wind Data"))
add_static_hint_CDU("L4", _("Enter a Wind Data"))

add_static_hint_CDU("R1", _("Select a Model Mode. Determine which data is used for a ballistic calculations"))
add_static_hint_CDU("R2", _("Branch to the WNDEDIT page"))
add_static_hint_CDU("R3", _("Clear all wind data"))
add_static_hint_CDU("R4", _("Branch to the LASTE page"))
