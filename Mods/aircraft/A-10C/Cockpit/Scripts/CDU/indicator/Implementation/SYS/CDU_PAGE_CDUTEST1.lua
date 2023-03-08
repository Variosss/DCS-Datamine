dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameCDUTEST1", 2, 1, LFT, "CDUTEST")

AddStaticText("DKI",		1, 3, LFT, "DKI    :")
AddText		 ("CDUTEST",	9, 3, LFT, {{"CDUTEST", 0, 0}}, " ")
AddText		 ("CDUTEST1",	9, 3, LFT, {{"CDUTEST", 0, 3}}, "P")

AddStaticText("RAM",		1, 4, LFT, "RAM    :")
AddText		 ("CDUTEST2",	9, 4, LFT, {{"CDUTEST", 1, 0}}, " ")
AddText		 ("CDUTEST3",	9, 4, LFT, {{"CDUTEST", 1, 1}}, "-")
AddText		 ("CDUTEST4",	9, 4, LFT, {{"CDUTEST", 1, 2}}, "W")
AddText		 ("CDUTEST5",	9, 4, LFT, {{"CDUTEST", 1, 3}}, "P")

AddStaticText("EEPROM",		1, 5, LFT, "EEPROM :")
AddText		 ("CDUTEST6",	9, 5, LFT, {{"CDUTEST", 2, 0}}, " ")
AddText		 ("CDUTEST7",	9, 5, LFT, {{"CDUTEST", 2, 1}}, "-")
AddText		 ("CDUTEST8",	9, 5, LFT, {{"CDUTEST", 2, 3}}, "P")

AddStaticText("FPP",		1, 6, LFT, "FPP    :")
AddText		 ("CDUTEST9",	9, 6, LFT, {{"CDUTEST", 3, 0}}, " ")
AddText		 ("CDUTEST10",	9, 6, LFT, {{"CDUTEST", 3, 1}}, "-")
AddText		 ("CDUTEST11",	9, 6, LFT, {{"CDUTEST", 3, 3}}, "P")

AddStaticText("HARS_I_F",	13, 3, LFT, "HARS I/F :")
AddText		 ("CDUTEST12",	23, 3, LFT, {{"CDUTEST", 4, 0}}, " ")
AddText		 ("CDUTEST13",	23, 3, LFT, {{"CDUTEST", 4, 1}}, "-")
AddText		 ("CDUTEST14",	23, 3, LFT, {{"CDUTEST", 4, 3}}, "P")

AddStaticText("RAM_1553",	13, 4, LFT, "1553 RAM:")
AddText		 ("CDUTEST15",	23, 4, LFT, {{"CDUTEST", 5, 0}}, " ")
AddText		 ("CDUTEST16",	23, 4, LFT, {{"CDUTEST", 5, 1}}, "-")
AddText		 ("CDUTEST17",	23, 4, LFT, {{"CDUTEST", 5, 3}}, "P")

AddStaticText("START",      23, 5, RGHT, "START")
AddText("START_SA",         24, 5, RGHT, {{"LruTestMode", 1}}, SYS_ACTION)

AddStaticText("DATA_PUMP",  11, 7, LFT, "DATA PUMP")
AddStaticText("DP_RTR",     24, 7, RGHT, ROTARY)
AddText("DATA_OFF",         21, 7, LFT, {{"DataPump", 0}}, "ON")
AddText("DATA_OFF1",         21, 7, LFT, {{"DataPump", 1}}, "OFF")


AddStaticText("LRUTEST",    24, 9, RGHT, "LRUTEST" .. BRANCH_R)
AddStaticText("BBCTL",       1, 9, LFT, BRANCH_L .. "BBCTL")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P1/2")

add_static_hint_CDU("L4", _("Branch to the BBCTL Page"))

add_static_hint_CDU("R2", _("Start a test"))
add_static_hint_CDU("R3", _("This will normally be set to OFF and would only be used for maintenance tests"))
add_static_hint_CDU("R4", _("Branch to the LRUTEST Page"))