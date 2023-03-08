dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameBBCTL", 2, 1, LFT, "BBCTL")

AddText("BRANCH1",     1, 3, LFT, {{"BBCTL"}}, BRANCH_L)
AddStaticText("VIEW1", 2, 3, LFT,           "VIEW1")
AddStaticText("VIEW2", 2, 5, LFT,           "VIEW2")
AddStaticText("VIEW3", 2, 7, LFT,           "VIEW3")
AddStaticText("VIEW4", 2, 9, LFT,           "VIEW4")
AddStaticText("VIEW5", 23, 3, RGHT,         "VIEW5")

AddStaticText("CLEAR", 23, 7, RGHT,         "CLEAR")
AddText("CLEAR_SA", 24, 7, RGHT, {{"LruTestMode", 1}}, SYS_ACTION)

AddStaticText("RESET", 24, 9, RGHT, "CDUTEST" .. BRANCH_R)

add_static_hint_CDU("R3", _("Clear all bitballs"))
add_static_hint_CDU("R4", _("Branch to the CDUTEST Page"))