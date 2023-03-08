dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSBIT3",	2, 1, LFT, "GPSBIT")

AddStaticText("FWI", 2, 3, LFT, "INFORMATION WORDS")
AddStaticText("L4", 2, 4, LFT, " 0083     A007    0005")
AddStaticText("L5", 2, 5, LFT, " 0000     0000    0000")

AddStaticText("GPS", 24, 9, RGHT, "GPS" .. BRANCH_R)

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P3/5")

add_static_hint_CDU("R4", _("Branch to the GPS Page"))