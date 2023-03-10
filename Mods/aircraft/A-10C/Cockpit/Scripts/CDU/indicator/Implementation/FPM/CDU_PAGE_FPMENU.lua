dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameFPMENU",	2,  1, LFT, "FPMENU")

AddText      ("PageFPBUILD",   24,  2, RGHT, {{"AnnVisible", 0}}, "FPBUILD")

AddText		 ("ActiveFP",       1,  3, LFT, {{"ActiveFP", 0}}, ROTARY)
AddText		 ("FPAction",       1,  3, LFT, {{"FPAction", 0}}, SYS_ACTION)
AddText		 ("FPNumber",       2,  3, LFT, {{"FPNumber", 0}})
AddText		 ("FPMode",	        5,  3, LFT, {{"ActiveFP", 0}, {"FPMode", 0, 0}}, "MAN")
AddText		 ("FPMode1",	        5,  3, LFT, {{"ActiveFP", 0}, {"FPMode", 0, 1}}, "AUTO")
AddText		 ("FPName",	       11,  3, LFT, {{"FPName", 0}})
AddText		 ("ActiveFP1",      22,  3, LFT, {{"ActiveFP", 0}}, "*")
AddText		 ("FPBUILDBranch", 24,  3, LFT, {{"FPBUILDBranch", 0}}, BRANCH_R)

AddText		 ("ActiveFP2",       1,  5, LFT, {{"ActiveFP", 1}}, ROTARY)
AddText		 ("FPAction1",       1,  5, LFT, {{"FPAction", 1}}, SYS_ACTION)
AddText		 ("FPNumber1",       2,  5, LFT, {{"FPNumber", 1}})
AddText		 ("FPMode2",	        5,  5, LFT, {{"ActiveFP", 1}, {"FPMode", 1, 0}}, "MAN")
AddText		 ("FPMode3",	        5,  5, LFT, {{"ActiveFP", 1}, {"FPMode", 1, 1}}, "AUTO")
AddText		 ("FPName1",	       11,  5, LFT, {{"FPName", 1}})
AddText		 ("ActiveFP3",      22,  5, LFT, {{"ActiveFP", 1}}, "*")
AddText		 ("FPBUILDBranch1", 24,  5, LFT, {{"FPBUILDBranch", 1}}, BRANCH_R)

AddText		 ("ActiveFP4",       1,  7, LFT, {{"ActiveFP", 2}}, ROTARY)
AddText		 ("FPAction2",       1,  7, LFT, {{"FPAction", 2}}, SYS_ACTION)
AddText		 ("FPNumber2",       2,  7, LFT, {{"FPNumber", 2}})
AddText		 ("FPMode4",	        5,  7, LFT, {{"ActiveFP", 2}, {"FPMode", 2, 0}}, "MAN")
AddText		 ("FPMode5",	        5,  7, LFT, {{"ActiveFP", 2}, {"FPMode", 2, 1}}, "AUTO")
AddText		 ("FPName2",	       11,  7, LFT, {{"FPName", 2}})
AddText		 ("ActiveFP5",      22,  7, LFT, {{"ActiveFP", 2}}, "*")
AddText		 ("FPBUILDBranch2", 24,  7, LFT, {{"FPBUILDBranch", 2}}, BRANCH_R)

AddText		 ("FPNameInput",	1,  9, LFT, {{"FPInput", 0}}, DATA_ENTRY)
AddText		 ("NEWFPNumber",    2,  9, LFT, {{"FPInput", 0}, {"NEWFPNumber"}})
AddText		 ("NEWFPText",	   10,  9, LFT, {{"FPInput", 0}}, "(NEW FP)")
AddText		 ("FULLText",	   10,  9, LFT, {{"FPInput", 1}}, "(FULL)")

AddStaticText("P",				  19 + PageNumNorOffset, 10, LFT, "P")
AddText		 ("FPMENUPageNumber", 20 + PageNumNorOffset, 10, LFT, {{"FPMENUPageNumber"}})

add_static_hint_CDU("L1", _("Activate a new flight plan or rotary the sequencing mode of the current flight plan between MAN and AUTO"))
add_static_hint_CDU("L2", _("Activate a new flight plan or rotary the sequencing mode of the current flight plan between MAN and AUTO"))
add_static_hint_CDU("L3", _("Activate a new flight plan or rotary the sequencing mode of the current flight plan between MAN and AUTO"))
add_static_hint_CDU("L4", _("Create new flight plan; enter the name of the flight plan into the scratchpad prior to pressing the LSK"))
add_static_hint_CDU("R1", _("Go to the Flight Plan Build (FPBUILD) Page for the flight plan displayed to the left of the LSK"))
add_static_hint_CDU("R2", _("Go to the Flight Plan Build (FPBUILD) Page for the flight plan displayed to the left of the LSK"))
add_static_hint_CDU("R3", _("Go to the Flight Plan Build (FPBUILD) Page for the flight plan displayed to the left of the LSK"))
