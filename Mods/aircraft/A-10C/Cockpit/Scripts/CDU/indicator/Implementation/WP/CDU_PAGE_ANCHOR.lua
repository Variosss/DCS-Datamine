dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameANCHOR",		2, 1, LFT, "ANCHOR")

AddStaticText("ANCHORNumberEntry",  1, 3, LFT, DATA_ENTRY)
AddText		 ("ANCHORNumber1",	    2, 3, LFT, {{"CurrAnchorPointNumber", 0}}, "****")
AddText		 ("ANCHORNumber2",	    2, 3, LFT, {{"CurrAnchorPointNumber", 1}})

AddStaticText("ANCHORIdentEntry",	1, 5, LFT, DATA_ENTRY)
AddText		 ("ANCHORIdent1",		2, 5, LFT, {{"AnchorIdent", 0}}, "************")
AddText		 ("ANCHORIdent2",		2, 5, LFT, {{"AnchorIdent", 1}})

AddStaticText("TTG",				2, 6, LFT, "TTG")
AddText		 ("ANCHORTTG1",			6, 6, LFT, {{"AnchorInfoPresent", 0}}, "********")
AddText		 ("ANCHORTTG2",			6, 6, LFT, {{"AnchorInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("ANCHORTTG3",			6, 6, LFT, {{"AnchorInfoPresent", 1}, {"NotMoving", 1, 3}, {"AnchorTTG"}})

AddStaticText("DMH",				2, 7, LFT, "DMH")
AddText		 ("ANCHORDMH1",		    8, 7, RGHT, {{"AnchorInfoPresent", 0}}, "***")
AddText		 ("ANCHORDMH2",		    8, 7, RGHT, {{"AnchorInfoPresent", 1}, {"AnchorDMH"}})

AddStaticText("DIS",				2, 8, LFT, "DIS")
AddText		 ("ANCHORDIS1",		    9, 8, RGHT, {{"AnchorInfoPresent", 0}}, "*****")
AddText		 ("ANCHORDIS2",		    9, 8, RGHT, {{"AnchorInfoPresent", 1}, {"AnchorDIS"}})

AddText		 ("STRIdentEntry",		24, 3, RGHT, {{"STRIdentEntry"}}, DATA_ENTRY)
AddText		 ("STRIdent1",			23, 3, RGHT, {{"ATTRIB_SCS", 0}, {"STRIdent", 0}}, "************")
AddText		 ("STRIdent2",			23, 3, RGHT, {{"ATTRIB_SCS", 0}, {"STRIdent", 1}})
AddText		 ("STRIdent3",			23, 3, RGHT, {{"ATTRIB_SCS", 1}}, "************")

AddText		 ("STRTTG1",			23, 6, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 0}}, "********")
AddText		 ("STRTTG2",			23, 6, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("STRTTG3",			23, 6, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 1}, {"NotMoving", 1, 3}, {"STRTTG"}})
AddText		 ("STRTTG4",			23, 6, RGHT, {{"ATTRIB_SCS", 1}, {"NotMoving", 0, 3}}, "********")
AddText		 ("STRTTG5",			23, 6, RGHT, {{"ATTRIB_SCS", 1}, {"NotMoving", 1, 3}, {"SCSTTG"}})

AddText		 ("STRDMH1",			23, 7, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 0}}, "***")
AddText		 ("STRDMH2",			23, 7, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 1}, {"STRDMH"}})
AddText		 ("STRDMH3",			23, 7, RGHT, {{"ATTRIB_SCS", 1}, {"SCSMagneticHeading"}})

AddText		 ("STRDIS1",			23, 8, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 0}}, "*****")
AddText		 ("STRDIS2",			23, 8, RGHT, {{"ATTRIB_SCS", 0}, {"STRInfoPresent", 1}, {"STRDIS"}})
AddText		 ("STRDIS3",			23, 8, RGHT, {{"ATTRIB_SCS", 1}, {"SCSDistance"}})

AddStaticText("HUD_IND",             1, 9, LFT, SYS_ACTION .. "HUD")
AddText      ("HUD_OFF",             6, 9, LFT, {{"AnchorHUD", 0}}, "OFF")
AddText      ("HUD_ON",              6, 9, LFT, {{"AnchorHUD", 1}}, "ON")

add_static_hint_CDU("L1", _("Enter a new anchor point number/markpoint letter from the scratchpad"))
add_static_hint_CDU("L2", _("Enter a new anchor point identifier from the scratchpad"))
add_static_hint_CDU("L4", _("Set an Anchor data on the HUD On or Off"))
add_static_hint_CDU("R1", _("Enter new steerpoint identifier from scratchpad"))
