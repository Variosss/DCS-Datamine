dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameDTSUPLD", 2, 1, LFT, "DTSUPLD")

AddStaticText("ALL", 1, 3, LFT, SYS_ACTION.."ALL ORIG")
AddStaticText("DATA",2, 4, LFT, "DATA")
AddStaticText("ORIG_NAV", 1, 5, LFT, SYS_ACTION.."ORIG NAV")
AddStaticText("DATA2",2, 6, LFT, "DATA")
AddStaticText("RECENT_NAV", 1, 9, LFT, SYS_ACTION.."RECENT NAV DATA")

AddStaticText("CDU_LASTE", 24, 3, RGHT, "CDU/LASTE"..SYS_ACTION)
AddStaticText("PREF",      23, 4, RGHT, "PREFERENCES")


AddStaticText("DTS", 24, 9, RGHT, "DTS" .. BRANCH_R)

add_static_hint_CDU("L1", _("Upload All Original Data (waypoints, flight plans, CDU preferences and LASTE settings)"))
add_static_hint_CDU("L2", _("Upload All Original Navigation Data"))
add_static_hint_CDU("L4", _("Upload Only Recent Navigation Data"))

add_static_hint_CDU("R1", _("Upload user-created CDU and LASTE settings preferences"))
add_static_hint_CDU("R4", _("Branch to the DTS page"))