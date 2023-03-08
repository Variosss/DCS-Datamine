dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameWPMENU", 2, 1, LFT, "WP MENU")

AddStaticText("STEERPOINT", 1, 3, LFT, BRANCH_L .. "STEERPOINT")
AddStaticText("ANCHOR_PT", 1, 5, LFT, BRANCH_L .. "ANCHOR PT")

AddStaticText("WAYPOINT", 24, 3, RGHT, "WAYPOINT" .. BRANCH_R)
AddStaticText("FROM_PT", 24, 5, RGHT, "FROM PT" .. BRANCH_R)

AddText      ("SPHEROID", 23, 9, RGHT, {{"currentSpheroidModel"}})
AddStaticText("BRACKETS", 24, 9, LFT, DATA_ENTRY);


add_static_hint_CDU("L1", _("Branch to the WAYPT Page for current steerpoint"))
add_static_hint_CDU("L2", _("Branch to the ANCHOR Page"))
add_static_hint_CDU("R1", _("Branch to the WAYPT Page"))
add_static_hint_CDU("R2", _("Branch to the FROM PT Page"))
add_static_hint_CDU("R4", _("Enter a Different Spheroid (Not functional)"))
