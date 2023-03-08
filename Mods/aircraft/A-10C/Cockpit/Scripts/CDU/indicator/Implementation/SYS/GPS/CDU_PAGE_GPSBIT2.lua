dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSBIT2",	2, 1, LFT, "GPSBIT")

AddStaticText("FWI", 2, 3, LFT, "FAIL INDICATOR WORDS")
AddStaticText("L4", 2, 4, LFT, " 0000     0000    0000")
AddStaticText("L5", 2, 5, LFT, " 0000     0000    0000")


AddStaticText("GPS", 24, 9, RGHT, "GPS" .. BRANCH_R)

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P2/5")

add_static_hint_CDU("R4", _("Branch to the GPS Page"))