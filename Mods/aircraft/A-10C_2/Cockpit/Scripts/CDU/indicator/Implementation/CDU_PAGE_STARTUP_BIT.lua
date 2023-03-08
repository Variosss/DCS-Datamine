dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddText      ("PageNameSTARTUPBIT", 3, 1, LFT,{{"STARTUPBIT", 9, 0}}, "CDU STARTUP BIT TEST")

AddText      ("DKI",		1, 3, LFT, {{"STARTUPBIT", 9, 0}}, "DKI    :")
AddText		 ("STARTUPBIT",	9, 3, LFT, {{"STARTUPBIT", 0, 0}}, " ")
AddText		 ("STARTUPBIT1",	9, 3, LFT, {{"STARTUPBIT", 0, 3}}, "P")

AddText      ("RAM",		1, 4, LFT, {{"STARTUPBIT", 9, 0}}, "RAM    :")
AddText		 ("STARTUPBIT2",	9, 4, LFT, {{"STARTUPBIT", 1, 0}}, " ")
AddText		 ("STARTUPBIT3",	9, 4, LFT, {{"STARTUPBIT", 1, 1}}, "-")
AddText		 ("STARTUPBIT4",	9, 4, LFT, {{"STARTUPBIT", 1, 2}}, "W")
AddText		 ("STARTUPBIT5",	9, 4, LFT, {{"STARTUPBIT", 1, 3}}, "P")

AddText      ("EEPROM",		1, 5, LFT, {{"STARTUPBIT", 9, 0}}, "EEPROM :")
AddText		 ("STARTUPBIT6",	9, 5, LFT, {{"STARTUPBIT", 2, 0}}, " ")
AddText		 ("STARTUPBIT7",	9, 5, LFT, {{"STARTUPBIT", 2, 1}}, "-")
AddText		 ("STARTUPBIT8",	9, 5, LFT, {{"STARTUPBIT", 2, 3}}, "P")

AddText      ("FPP",		1, 6, LFT, {{"STARTUPBIT", 9, 0}}, "FPP    :")
AddText		 ("STARTUPBIT9",	9, 6, LFT, {{"STARTUPBIT", 3, 0}}, " ")
AddText		 ("STARTUPBIT10",	9, 6, LFT, {{"STARTUPBIT", 3, 1}}, "-")
AddText		 ("STARTUPBIT11",	9, 6, LFT, {{"STARTUPBIT", 3, 3}}, "P")

AddText      ("HARS_I_F",	13, 3, LFT, {{"STARTUPBIT", 9, 0}}, "HARS I/F :")
AddText		 ("STARTUPBIT12",	23, 3, LFT, {{"STARTUPBIT", 4, 0}}, " ")
AddText		 ("STARTUPBIT13",	23, 3, LFT, {{"STARTUPBIT", 4, 1}}, "-")
AddText		 ("STARTUPBIT14",	23, 3, LFT, {{"STARTUPBIT", 4, 3}}, "P")

AddText      ("RAM_1553",	13, 4, LFT, {{"STARTUPBIT", 9, 0}}, "RAM 1553 :")
AddText		 ("STARTUPBIT15",	23, 4, LFT, {{"STARTUPBIT", 5, 0}}, " ")
AddText		 ("STARTUPBIT16",	23, 4, LFT, {{"STARTUPBIT", 5, 1}}, "-")
AddText		 ("STARTUPBIT17",	23, 4, LFT, {{"STARTUPBIT", 5, 3}}, "P")

AddText      ("I_F_1553",	13, 5, LFT, {{"STARTUPBIT", 9, 0}}, "I/F 1553 :")
AddText		 ("STARTUPBIT18",	23, 5, LFT, {{"STARTUPBIT", 6, 0}}, " ")
AddText		 ("STARTUPBIT19",	23, 5, LFT, {{"STARTUPBIT", 6, 1}}, "-")
AddText		 ("STARTUPBIT20",	23, 5, LFT, {{"STARTUPBIT", 6, 3}}, "P")

AddText      ("RT_ADDR",	13, 6, LFT, {{"STARTUPBIT", 9, 0}}, "RT ADDR  :")
AddText		 ("STARTUPBIT21",	23, 6, LFT, {{"STARTUPBIT", 7, 0}}, " ")
AddText		 ("STARTUPBIT22",	23, 6, LFT, {{"STARTUPBIT", 7, 1}}, "-")
AddText		 ("STARTUPBIT23",	23, 6, LFT, {{"STARTUPBIT", 7, 3}}, "P")

AddText      ("CSCI", 4, 10, LFT, {{"STARTUPBIT", 9, 0}}, "CSCI")
AddText		 ("STARTUPBIT24",	9, 10, LFT, {{"STARTUPBIT", 8, 0}}, "SU 2.009")
