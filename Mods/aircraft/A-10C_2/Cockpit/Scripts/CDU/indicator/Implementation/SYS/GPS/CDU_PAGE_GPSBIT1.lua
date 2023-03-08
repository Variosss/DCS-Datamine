dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSBIT1",	2, 1, LFT, "GPSBIT")

AddStaticText("KYK",  2, 3, LFT, "KYK   P    LRU  P")
AddStaticText("DSW1", 2, 4, LFT, "DPRAM STAT WORD 1")
AddStaticText("DSW2", 2, 5, LFT, "DPRAM STAT WORD 2")
AddStaticText("BVU",  2, 6, LFT, "BATT VLT UNLOADED")
AddStaticText("BVL",  2, 7, LFT, "BATT VLT LOADED")
AddStaticText("GC",   2, 8, LFT, " GEM CHECKSUM")

AddStaticText("DSW1_VAL", 24, 4, RGHT, "000C")
AddStaticText("DSW2_VAL", 24, 5, RGHT, "0000")
AddStaticText("BVU_VAL",  24, 6, RGHT, "3.516")
AddStaticText("BVL_VAL",  24, 7, RGHT, "3.380")
AddStaticText("GC1",       24, 8, RGHT, "B58B")


AddStaticText("GPS", 24, 9, RGHT, "GPS" .. BRANCH_R)

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P1/5")

add_static_hint_CDU("R4", _("Branch to the GPS Page"))