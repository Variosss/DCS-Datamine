dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameEGI",   2, 1, LFT, "EGI")

AddStaticText("CBIT1",         2, 3, LFT, "CBIT1 0000")
AddStaticText("CBIT2",         2, 4, LFT, "CBIT2 0000")
AddStaticText("CBIT3",         2, 5, LFT, "CBIT3 0000")
AddStaticText("CBIT4",         2, 6, LFT, "CBIT4 0000")
AddStaticText("CBIT5",         2, 7, LFT, "CBIT5 0000")
AddStaticText("CBIT6",         2, 8, LFT, "CBIT6 0000")
AddStaticText("CBIT7",         2, 9, LFT, "CBIT7 0000")

AddStaticText("CBIT8",        14, 3, LFT, "CBIT8  0000")
AddStaticText("CBIT9",        14, 4, LFT, "CBIT9  0000")
AddStaticText("CBIT10",       14, 5, LFT, "CBIT10 0000")
AddStaticText("CBIT11",       14, 6, LFT, "CBIT11 0000")
AddStaticText("WARNING",      14, 7, LFT, "WARNING")
AddStaticText("WARCODE",      17, 8, LFT, "0000")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P4/4")
