dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameFPBUILD",    2, 1, LFT, "FPBUILD")

AddText		 ("NMDisplay",		    1, 3, LFT, {{"FPNAMEMode", 0}, {"FPBUILDEditMode", 0, 1}, {"StratchpadIsEmpty", 1}}, SYS_ACTION)
AddText		 ("NMINPUT",		    1, 3, LFT, {{"FPNAMEMode", 1}}, DATA_ENTRY)
AddStaticText("NM",				    2, 3, LFT,  "NM:")
AddText		 ("FPBUILDPlanName",    5, 3, LFT, {{"FPNAMEMode", 0}, {"FPBUILDPlanName"}})
AddStaticText("INSERT",			   23, 3, RGHT, "INSERT")
AddText		 ("INSERTDisplay",	   24, 3, RGHT, {{"INSERTDisplay"}}, SYS_ACTION)
AddStaticText("F",				    5, 4, LFT, "F")
AddText		 ("FPBUILDPlanNumber",  6, 4, LFT, {{"FPBUILDPlanNumber"}})
AddText		 ("WPTATT",			   24, 4, RGHT, {{"FPBUILDEditMode", 0}}, "WPTATT")

AddText		 ("WPInput",		    1, 5, LFT, {{"WPInput", 0}}, DATA_ENTRY)
AddText		 ("WPFPNumber",		    2, 5, LFT, {{"WPFPNumber", 0}})
AddText		 ("WPNumber",		    5, 5, LFT, {{"FPBUILDEditMode", 0}, {"WPNumber", 0}})
AddText		 ("WPNumber1",		    5, 5, LFT, {{"FPBUILDEditMode", 2}, {"WPNumber", 0}})
AddText		 ("WPActive",		    9, 5, LFT, {{"FPBUILDEditMode", 0}, {"WPActive", 0}}, "*")
AddText		 ("WPActive1",		    9, 5, LFT, {{"FPBUILDEditMode", 2}, {"WPActive", 0}}, "*")
AddText		 ("WPName",			   10, 5, LFT, {{"FPBUILDEditMode", 0}, {"WPName", 0, 0}})
AddText		 ("WPName1",			   10, 5, LFT, {{"FPBUILDEditMode", 2}, {"WPName", 0, 0}})
AddText		 ("WPNewName",		   10, 5, LFT, {{"WPName", 0, 1}}, " (NEXT)")
AddText		 ("WPNewName1",		   10, 5, LFT, {{"WPName", 0, 2}}, " (FULL)")
AddText		 ("WPTATTBranch",	   24, 5, LFT, {{"FPBUILDEditMode", 0}, {"WPTATTBranch", 0}}, BRANCH_R)

AddText		 ("WPNumber2",		    5, 6, LFT, {{"FPBUILDEditMode", 1}, {"WPNumber", 0}})
AddText		 ("WPActive2",		    9, 6, LFT, {{"FPBUILDEditMode", 1}, {"WPActive", 0}}, "*")
AddText		 ("WPName2",			   10, 6, LFT, {{"FPBUILDEditMode", 1}, {"WPName", 0, 0}})

AddText		 ("WPInput1",		    1, 7, LFT, {{"WPInput", 1}}, DATA_ENTRY)
AddText		 ("WPFPNumber1",		    2, 7, LFT, {{"WPFPNumber", 1}})
AddText		 ("WPNumber3",		    5, 7, LFT, {{"FPBUILDEditMode", 0}, {"WPNumber", 1}})
AddText		 ("WPNumber4",		    5, 7, LFT, {{"FPBUILDEditMode", 2}, {"WPNumber", 1}})
AddText		 ("WPActive3",		    9, 7, LFT, {{"FPBUILDEditMode", 0}, {"WPActive", 1}}, "*")
AddText		 ("WPActive4",		    9, 7, LFT, {{"FPBUILDEditMode", 2}, {"WPActive", 1}}, "*")
AddText		 ("WPName3",			   10, 7, LFT, {{"FPBUILDEditMode", 0}, {"WPName", 1, 0}})
AddText		 ("WPName4",			   10, 7, LFT, {{"FPBUILDEditMode", 2}, {"WPName", 1, 0}})
AddText		 ("WPNewName2",		   10, 7, LFT, {{"WPName", 1, 1}}, " (NEXT)")
AddText		 ("WPNewName3",		   10, 7, LFT, {{"WPName", 1, 2}}, " (FULL)")
AddText		 ("WPTATTBranch1",	   24, 7, LFT, {{"FPBUILDEditMode", 0}, {"WPTATTBranch", 1}}, BRANCH_R)

AddText		 ("WPNumber5",		    5, 8, LFT, {{"FPBUILDEditMode", 1}, {"WPNumber", 1}})
AddText		 ("WPActive5",		    9, 8, LFT, {{"FPBUILDEditMode", 1}, {"WPActive", 1}}, "*")
AddText		 ("WPName5",			   10, 8, LFT, {{"FPBUILDEditMode", 1}, {"WPName", 1, 0}})

AddText		 ("WPInput2",		    1, 9, LFT, {{"WPInput", 2}}, DATA_ENTRY)
AddText		 ("WPFPNumber2",		2, 9, LFT, {{"WPFPNumber", 2}})
AddText		 ("WPNumber6",		    5, 9, LFT, {{"FPBUILDEditMode", 0}, {"WPNumber", 2}})
AddText		 ("WPNumber7",		    5, 9, LFT, {{"FPBUILDEditMode", 2}, {"WPNumber", 2}})
AddText		 ("WPActive6",		    9, 9, LFT, {{"FPBUILDEditMode", 0}, {"WPActive", 2}}, "*")
AddText		 ("WPActive7",		    9, 9, LFT, {{"FPBUILDEditMode", 2}, {"WPActive", 2}}, "*")
AddText		 ("WPName6",			10, 9, LFT, {{"FPBUILDEditMode", 0}, {"WPName", 2, 0}})
AddText		 ("WPName7",			10, 9, LFT, {{"FPBUILDEditMode", 2}, {"WPName", 2, 0}})
AddText		 ("WPNewName4",		   10, 9, LFT, {{"WPName", 2, 1}}, " (NEXT)")
AddText		 ("WPNewName5",		   10, 9, LFT, {{"WPName", 2, 2}}, " (FULL)")
AddText		 ("WPTATTBranch2",	   24, 9, LFT, {{"FPBUILDEditMode", 0}, {"WPTATTBranch", 2}}, BRANCH_R)

AddStaticText("P",				   19 + PageNumNorOffset, 10, LFT, "P")
AddText		 ("FPBUILDPageNumber", 20 + PageNumNorOffset, 10, LFT, {{"FPBUILDPageNumber"}})

add_static_hint_CDU("L1", _("Flight Plan Name: Press to Change Name in Scratchpad"))

add_hint_format_controllers_CDU("L2",
	{_("Waypoint LSK: Press to enter a waypoint number or identifier into sequence number XX  (Where XX is the 2 digit number next to the LSK)"),
	 _("Insert Waypoint into sequence number XX (Where XX is the 2 digit number next to the LSK)")},
	{{"FPBUILDEditModeHint", 0}})

add_hint_format_controllers_CDU("L3",
	{_("Waypoint LSK: Press to enter a waypoint number or identifier into sequence number XX  (Where XX is the 2 digit number next to the LSK)"),
	 _("Insert Waypoint into sequence number XX (Where XX is the 2 digit number next to the LSK)")},
	{{"FPBUILDEditModeHint", 1}})

add_hint_format_controllers_CDU("L4",
	{_("Waypoint LSK: Press to enter a waypoint number or identifier into sequence number XX  (Where XX is the 2 digit number next to the LSK)"),
	 _("Insert Waypoint into sequence number XX (Where XX is the 2 digit number next to the LSK)")},
	{{"FPBUILDEditModeHint", 2}})

add_hint_format_controllers_CDU("R1",
	{_("Enter Waypoint INSERT Mode"),
	 _("Exit INSERT Mode")},
	{{"FPBUILDEditModeHint", 3}})

add_hint_controllers_CDU("R2", _("Branch to the Waypoint Attributes (WPATT) Page for the Waypoint to the left of the LSK"), {{"FPBUILD_NotEditModeHint", 0}})
add_hint_controllers_CDU("R3", _("Branch to the Waypoint Attributes (WPATT) Page for the Waypoint to the left of the LSK"), {{"FPBUILD_NotEditModeHint", 1}})
add_hint_controllers_CDU("R4", _("Branch to the Waypoint Attributes (WPATT) Page for the Waypoint to the left of the LSK"), {{"FPBUILD_NotEditModeHint", 2}})
