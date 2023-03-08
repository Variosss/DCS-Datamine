dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddText		 ("WPT",		    2, 2, LFT, {{"AnnVisible", 0}}, "WPT:")
AddText		 ("WAYPTNumber",    6, 2, LFT, {{"AnnVisible", 0}, {"CurrWAYPTNumber", 0}}, "****")
AddText		 ("WAYPTNumber1",    6, 2, LFT, {{"AnnVisible", 0}, {"CurrWAYPTNumber", 1}})

AddText		 ("WAYPTIdent",	   12, 2, LFT, {{"AnnVisible", 0}, {"WAYPTIdent", 0}}, "************")
AddText		 ("WAYPTIdent1",    12, 2, LFT, {{"AnnVisible", 0}, {"WAYPTIdent", 1}})

AddStaticText("SCALE",		    1, 3, LFT, ROTARY .. "SCALE:")
AddText		 ("WAYPTScale",     2, 4, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTScale", 0}}, "ENROUTE")
AddText		 ("WAYPTScale1",     2, 4, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTScale", 1}}, "TERMINAL")
AddText		 ("WAYPTScale2",     2, 4, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTScale", 2}}, "APPROACH")
AddText		 ("WAYPTScale3",     2, 4, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTScale", 3}}, "HIGH ACC")
AddText		 ("WAYPTScale4",     2, 4, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTScale", 4}}, "********")

AddStaticText("STEER",		    1, 5, LFT, ROTARY .. "STEER:")
AddText		 ("WAYPTSteer",     2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTSteer", 0}}, "TO FROM")
AddText		 ("WAYPTSteer1",     2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTSteer", 1}}, "DIRECT")
AddText		 ("WAYPTSteer2",     2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTSteer", 2}}, "TO TO")
AddText		 ("WAYPTSteer4",     2, 6, LFT, {{"WAYPTInfoPresent", 1}, {"WAYPTSteer", 4}}, "*******")

AddStaticText("DTTG",		    1, 7, LFT, DATA_ENTRY .. "DTTG:")
AddText		 ("WAYPT_DTTG",	    8, 7, LFT, {{"WAYPT_DTTG", 0}}, "********")
AddText		 ("WAYPT_DTTG1",     7, 7, LFT, {{"WAYPT_DTTG", 1}})

AddStaticText("DTOT",		    1, 9, LFT, DATA_ENTRY .. "DTOT:")
AddText		 ("WAYPT_DTOT",	    8, 9, LFT, {{"WAYPT_DTOT", 0}}, "********")
AddText		 ("WAYPT_DTOT1",     8, 9, LFT, {{"WAYPT_DTOT", 1}})

AddText("FLDINFO",	   23, 3, RGHT, {{"WAYPTFldInfoPresent", 0}}, "FLDINFO")
AddText("FLDINFO_BR",  24, 3, RGHT, {{"WAYPTFldInfoPresent", 0}}, BRANCH_R)

AddStaticText("VNAV_MODE",	   24, 5, RGHT, "VNAV MODE:" .. ROTARY)
AddText		 ("WAYPTVNavMode", 23, 6, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 0}}, "2D")
AddText		 ("WAYPTVNavMode1", 23, 6, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1}}, "3D")
AddText		 ("WAYPTVNavMode2", 23, 6, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 2}}, "**")

AddText("VANGLE",  	           24, 7, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1}} ,"VANGLE:"..ROTARY)
AddText("VANGLEMode",          23, 8, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1}, {"WAYPTVangleMode", 0}}, "COMPUTED")
AddText("VANGLEMode1",          23, 8, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1}, {"WAYPTVangleMode", 1}}, "ENTERED")
AddText("VANGLEValue",         23, 9, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1}, {"WAYPTVangleValue"}})
AddText("VANGLEEntry",         24, 9, RGHT, {{"WAYPTInfoPresent", 1}, {"WAYPTVNavMode", 1} ,{"WAYPTVangleMode", 1}}, DATA_ENTRY)


AddStaticText("PAGE_NUM", 20 + PageNumNorOffset, 10, LFT, "2")

add_static_hint_CDU("L1", _("Rotary between scale modes (only ENROUTE functional)"))
add_static_hint_CDU("L2", _("Current waypoint steering mode (only TO FROM functional)"))
add_static_hint_CDU("L3", _("Enter new DTTG from scratchpad (HHMMSS); blank scratchpad will erase current DTTG"))
add_static_hint_CDU("L4", _("Enter new DTOT from scratchpad (HHMMSS); blank scratchpad will erase current DTOT"))
add_static_hint_CDU("R1", _("Branch to the Airfield Information (FLDINFO)"))
add_static_hint_CDU("R2", _("Rotary between 2D and 3D navigation modes"))
add_static_hint_CDU("R3", _("Toggle between COMPUTED and ENTERED Vertical Angle"))
add_hint_controllers_CDU("R4", _("Enter a Vertical Angle "), {{"WAYPTVangleMode",1}})