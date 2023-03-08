dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameTIME",	2, 1, LFT, "TIME")

AddStaticText("DTOT_ADJUST",	1, 3, LFT, DATA_ENTRY .. "DTOT ADJUST")
AddText		 ("DTOT_ADJUST_TXT",2, 4, LFT, {{"DTOT_ADJUST"}})

AddStaticText("LCL_ADJUST",		1, 7, LFT, DATA_ENTRY .. "LCL ADJUST")
AddText		 ("LCL_ADJUST_TXT",	2, 8, LFT, {{"LCL_ADJUST"}})

AddStaticText("YEAR",		   16, 3, LFT, "YEAR")
AddText		 ("YEAR_TXT",	   23, 3, RGHT, {{"YEAR"}})
AddText      ("YEAR_DE",       24, 3, LFT, {{"IsGpsTimeEdited"}}, DATA_ENTRY)

AddStaticText("MONTH",		   16, 5, LFT, "MONTH")
AddText		 ("MONTH_TXT",	   23, 5, RGHT, {{"MONTH"}})
AddText      ("MONTH_DE",      24, 5, LFT, {{"IsGpsTimeEdited"}}, DATA_ENTRY)

AddStaticText("DAY",		   16, 7, LFT, "DAY")
AddText		 ("DAY_TXT",	   23, 7, RGHT, {{"DAY"}})
AddText      ("DAY_DE",        24, 7, LFT, {{"IsGpsTimeEdited"}}, DATA_ENTRY)

AddText		 ("GMT_LCL1",	   12, 9, LFT, {{"GMT_LCL", 0}}, "GMT")
AddText		 ("GMT_LCL2",	   12, 9, LFT, {{"GMT_LCL", 1}}, "LCL")
AddText		 ("GMT_LCL_Time",  16, 9, LFT, {{"GMT_LCL_Time"}})
AddText      ("GMT_DE",        24, 9, LFT, {{"IsGpsTimeEdited"}}, DATA_ENTRY)

add_static_hint_CDU("L1", _("Enter new DTOT adjustment from scratchpad (HH:MM:SS). Press again to change from positive to negative adjustment."))
add_static_hint_CDU("L3", _("Enter new local time adjustment from scratchpad (HH:MM). Press again to change from positive to negative adjustment."))
