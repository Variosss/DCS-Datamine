dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameEGI",   2, 1, LFT, "EGI")

AddStaticText("MBIT1",         2, 3, LFT, "MBIT1 0000")
AddStaticText("MBIT2",         2, 4, LFT, "MBIT2 0000")
AddStaticText("MBIT3",         2, 5, LFT, "MBIT3 0000")
AddStaticText("MBIT4",         2, 6, LFT, "MBIT4 0000")
AddStaticText("MBIT5",         2, 7, LFT, "MBIT5 0000")
AddStaticText("MBIT6",         2, 8, LFT, "MBIT6 0000")
AddStaticText("MBIT7",         2, 9, LFT, "MBIT7 0000")

AddStaticText("MBIT8",        14, 3, LFT, "MBIT8  0000")
AddStaticText("MBIT9",        14, 4, LFT, "MBIT9  0000")
AddStaticText("MBIT10",       14, 5, LFT, "MBIT10 0000")
AddStaticText("MBIT11",       14, 6, LFT, "MBIT11 0000")
AddStaticText("WARNING",      14, 7, LFT, "WARNING")
AddStaticText("WARCODE",      17, 8, LFT, "0000")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P3/4")
