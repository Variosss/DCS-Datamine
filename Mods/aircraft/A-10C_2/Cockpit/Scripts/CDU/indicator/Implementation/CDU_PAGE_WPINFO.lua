dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameWPINFO",	    2, 1, LFT, "WP INFO")

AddStaticText("WAYPT_INCR_DECR",    1, 3, LFT, INC_DEC)
AddText		 ("WAYPTNumber1",	    2, 3, LFT, {{"CurrWAYPTNumber", 0}}, "****")
AddText		 ("WAYPTNumber2",	    2, 3, LFT, {{"CurrWAYPTNumber", 1}})

AddStaticText("WAYPOINT",			1, 5, LFT, BRANCH_L .. "WAYPOINT")
AddStaticText("STEER_PT",			2, 7, LFT, "STEER PT")

AddText		 ("STRTTG1",		    2, 8, LFT, {{"STRInfoPresent", 0}}, "********")
AddText		 ("STRTTG2",		    2, 8, LFT, {{"STRInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("STRTTG3",		    2, 8, LFT, {{"STRInfoPresent", 1}, {"NotMoving", 1, 3}, {"STRTTG"}})

AddStaticText("STRDISMH",		    5, 9, LFT, "/")
AddText		 ("STRMH1",			    2, 9, LFT, {{"STRInfoPresent", 0}}, "***")
AddText		 ("STRMH2",			    2, 9, LFT, {{"STRInfoPresent", 1}, {"STRMH"}})
AddText		 ("STRDIS1",		    6, 9, LFT, {{"STRInfoPresent", 0}}, "****")
AddText		 ("STRDIS2",		    6, 9, LFT, {{"STRInfoPresent", 1}, {"STRDIS"}})

AddStaticText("BRACKETS_WPT_NAME", 24, 3, RGHT, DATA_ENTRY)
AddText		 ("WAYPTIdent1",	   23, 3, RGHT, {{"WAYPTIdent", 0}}, "************")
AddText		 ("WAYPTIdent2", 	   23, 3, RGHT, {{"WAYPTIdent", 1}})

AddText		 ("WPTTTG1",		   23, 4, RGHT, {{"WAYPTInfoPresent", 0}}, "********")
AddText		 ("WPTTTG2",		   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("WPTTTG3",		   23, 4, RGHT, {{"WAYPTInfoPresent", 1}, {"NotMoving", 1, 3}, {"WPTTTG"}})

AddStaticText("WPTDISMH",		   19, 5, LFT, "/")
AddText		 ("WPTDIS1",		   20, 5, LFT, {{"WAYPTInfoPresent", 0}}, "****")
AddText		 ("WPTDIS2",		   20, 5, LFT, {{"WAYPTInfoPresent", 1}, {"WPTDIS"}})
AddText		 ("WPTMH1",			   16, 5, LFT, {{"WAYPTInfoPresent", 0}}, "***")
AddText		 ("WPTMH2",			   16, 5, LFT, {{"WAYPTInfoPresent", 1}, {"WPTMH"}})

AddStaticText("ANCHOR_PT",		   24, 7, RGHT, "ANCHOR PT" .. BRANCH_R)
AddText		 ("ANCHORTTG1",		   23, 8, RGHT, {{"AnchorInfoPresent", 0}}, "********")
AddText		 ("ANCHORTTG2",		   23, 8, RGHT, {{"AnchorInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("ANCHORTTG3",		   23, 8, RGHT, {{"AnchorInfoPresent", 1}, {"NotMoving", 1, 3}, {"AnchorTTG"}})

AddStaticText("ANCHORTOFRRotary",  24, 9, RGHT, ROTARY)
AddStaticText("ANCHORDISMH",	   19, 9, LFT, "/")
AddText		 ("ANCHORDIS1",		   20, 9, LFT, {{"AnchorInfoPresent", 0}}, "****")
AddText		 ("ANCHORDIS2",		   20, 9, LFT, {{"AnchorInfoPresent", 1}, {"AnchorDIS"}})
AddText		 ("ANCHORMH1",		   16, 9, LFT, {{"AnchorInfoPresent", 0}}, "***")
AddText		 ("ANCHORMH2",		   16, 9, LFT, {{"AnchorInfoPresent", 1}, {"AnchorTOFRMode", 1}, {"AnchorMHTO"}})
AddText		 ("ANCHORMH3",		   16, 9, LFT, {{"AnchorInfoPresent", 1}, {"AnchorTOFRMode", 0}, {"AnchorMHFR"}})
AddText		 ("ANCHORTOFRMode1",   13, 9, LFT, {{"AnchorInfoPresent", 1}, {"AnchorTOFRMode", 0}}, "FR")
AddText		 ("ANCHORTOFRMode2",   13, 9, LFT, {{"AnchorInfoPresent", 1}, {"AnchorTOFRMode", 1}}, "TO")

add_static_hint_CDU("L1", _("Enter a desired waypoint number/letter from scratchpad or use +- rocker to scroll up/down"))
add_static_hint_CDU("L2", _("Branch to the WAYPT Page for selected waypoint"))
add_static_hint_CDU("R1", _("Enter a desired waypoint identifier from scratchpad"))
add_static_hint_CDU("R3", _("Branch to the ANCHOR Page"))
add_static_hint_CDU("R4", _("Rotary between TO/FR anchor point display"))
