dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameNAV", 2, 1, LFT, "NAV")

AddStaticText("ALIGN",		    1, 3, LFT, BRANCH_L .. "ALIGN")
AddStaticText("TIME",		    1, 5, LFT, BRANCH_L .. "TIME")
AddStaticText("UPDATE",		    1, 7, LFT, BRANCH_L .. "UPDATE")
AddStaticText("DTSUPLOAD",	    1, 9, LFT, BRANCH_L .. "DTSUPLOAD")

AddStaticText("NAVMODEROTARY", 24, 3, RGHT, ROTARY)
AddText		 ("FLIGHT_DRIVER", 23, 3, RGHT, {{"EGI_commandedNS", 1}}, "BLENDED")
AddText		 ("FLIGHT_DRIVER1", 23, 3, RGHT, {{"EGI_commandedNS", 2}}, "GPS")
AddText		 ("FLIGHT_DRIVER2", 23, 3, RGHT, {{"EGI_commandedNS", 3}}, "INS")

AddStaticText("ATTRIBUTES",    24, 5, RGHT, "ATTRIBUTES" .. BRANCH_R)
AddStaticText("OPTIONS",	   24, 7, RGHT, "OPTIONS" .. BRANCH_R)
AddStaticText("DIVERT",		   24, 9, RGHT, "DIVERT" .. BRANCH_R)

add_static_hint_CDU("L1", _("Branch to the ALIGN Page"))
add_static_hint_CDU("L2", _("Branch to the TIME Page"))
add_static_hint_CDU("L3", _("Branch to the UPDATE Page"))
add_static_hint_CDU("L4", _("Branch to the DTSUPLOAD Page"))
add_static_hint_CDU("R1", _("Toggle between BLENDED, GPS and INS"))
add_static_hint_CDU("R2", _("Branch to the ATTRIBUTES Page"))
add_static_hint_CDU("R3", _("Branch to the OPTIONS Page"))
add_static_hint_CDU("R4", _("Branch to the DIVERT Page"))
