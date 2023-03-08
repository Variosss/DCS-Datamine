dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("DTS", 1, 3, LFT, BRANCH_L .. "DTS")
AddStaticText("LRUTEST", 1, 5, LFT, BRANCH_L .. "LRUTEST")
AddStaticText("ZEROES1", 1, 7, LFT, DATA_ENTRY .. "00000000")
AddStaticText("OFPID", 1, 9, LFT, BRANCH_L .. "OFPID")

AddStaticText("CADC", 24, 3, RGHT, "CADC" .. BRANCH_R)
AddStaticText("CDUTEST", 24, 5, RGHT, "CDUTEST" .. BRANCH_R)
AddStaticText("ZEROES2", 23, 7, RGHT, "0000")
AddStaticText("MXLOG", 24, 9, RGHT, "MXLOG" .. BRANCH_R)

AddStaticText("PAGE_NUM", 20 + PageNumNorOffset, 10, LFT, "2")

add_static_hint_CDU("L1", _("Branch to the DTS Page"))
add_static_hint_CDU("L2", _("Branch to the LRUTEST Page"))
add_static_hint_CDU("L4", _("Branch to the OFPID Page"))
add_static_hint_CDU("R1", _("Branch to the CADC Page"))
add_static_hint_CDU("R2", _("Branch to the CDUTEST Page"))
add_static_hint_CDU("R4", _("Branch to the MXLOG Page"))
