dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameALTALGN",		 2, 1, LFT, "ALTALGN")

AddStaticText("POS_SOURCE",			 2, 3, LFT, "POS SOURCE")
AddText		 ("POS_Source_Standby",	 2, 4, LFT, {{"AlignPOS_Source", 0}}, "STANDBY")
AddText		 ("POS_Source_Man",		 2, 4, LFT, {{"AlignPOS_Source", 1}}, "MAN(PILOT)")
AddText		 ("POS_Source_DTS",		 2, 4, LFT, {{"AlignPOS_Source", 2}}, "AUTO(DTC)")
AddText		 ("POS_Source_Last_Pos", 2, 4, LFT, {{"AlignPOS_Source", 3}}, "AUTO(LAST POS)")
AddText		 ("POS_Source_GPS",		 2, 4, LFT, {{"AlignPOS_Source", 4}}, "AUTO(GPS)")
AddText		 ("POS_Source_GPS1",		 2, 4, LFT, {{"AlignPOS_Source", 5}}, "NOT AVAILABLE")

AddText      ("AlignMode_Ground",   11, 4, LFT, {{"AltAlignmentMode"}})
--AddText      ("AlignMode_InFlt",    11, 4, LFT, {{"AlignmentMode", 1}}, "-INFLT")
--AddText      ("AlignMode_SH",       11, 4, LFT, {{"AlignmentMode", 2}}, "-SH")
--AddText      ("AlignMode_BATH",     11, 4, LFT, {{"AlignmentMode", 3}}, "-BATH")

AddText		 ("InitPosCoordFormat_LL",   1, 5, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 0}}, ROTARY .. "L/L")
AddText		 ("InitPosCoordFormat_UTM",  1, 5, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 1}}, ROTARY .. "UTM")

AddText      ("InitPositText",		 2, 6, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}}, "INIT POSIT:")
AddText		 ("InitInputLatUTM",	 1, 7, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"AltInitInput"}}, DATA_ENTRY)
AddText		 ("InitPositLat",		 2, 7, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 0}, {"InitPositLat"}})
AddText		 ("InitPositUTM",		 2, 7, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 1}, {"InitPositUTM"}})
AddText		 ("InitInputLongMGRS",	 1, 9, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"AltInitInput"}}, DATA_ENTRY)
AddText		 ("InitPositLong",		 2, 9, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 0}, {"InitPositLong"}})
AddText		 ("InitPositMGRS",		 2, 9, LFT, {{"HideIfInitPosNotAvailable"}, {"HideIfInfltMode"}, {"InitPosCoordFormat", 1}, {"InitPositMGRS"}})

AddStaticText("T",					 4, 8, LFT, "T=")
AddText		 ("AlignTimeAsterisk",	 7, 8, LFT, {{"AlignTime", 0}}, "*****")
AddText		 ("AlignTime",			 7, 8, LFT, {{"AlignTime", 1}})
AddText		 ("AlignStatusAsterisk",13, 8, LFT, {{"AlignStatus", 0}}, "********")
AddText		 ("AlignStatus",		13, 8, LFT, {{"AlignStatus", 1}}, "INIT")
AddText		 ("AlignStatus1",		13, 8, LFT, {{"AlignStatus", 2}}, "ATTD")
AddText		 ("AlignStatus2",		13, 8, LFT, {{"AlignStatus", 3}}, "ATTD+HDG")
AddText		 ("EstimatedDrift",		13, 8, LFT, {{"EstimatedDrift"}})

-- AddText		 ("AlignModes",		 24, 3, RGHT, {{"AlignModes"}})

AddText		 ("EGICurrentMode",		19, 3, LFT, {{"EGICurrentMode", 5}}, "*")
AddStaticText("FAST",				23, 3, RGHT, "FAST")
AddText		 ("EGIAvailableMode",	24, 3, LFT, {{"DisableIfAircraftMoving"}, {"EGIAvailableMode", 5}}, SYS_ACTION)

AddStaticText("MH",				16, 5, RGHT, "MH")
AddText      ("MH1",				23, 5, RGHT, {{"AltMagHead"}})
AddText      ("MH_DE",          24, 5, LFT, {{"AltInitInput"}}, DATA_ENTRY)

AddText		 ("EGICurrentMode1",		20, 7, LFT, {{"EGICurrentMode", 4}}, "*")
AddStaticText("NAV",				23, 7, RGHT, "NAV")
AddText		 ("EGIAvailableMode1",	24, 7, LFT, {{"EGIAvailableMode", 4}}, SYS_ACTION)

AddStaticText("INS",				24, 9, RGHT, "INS" .. BRANCH_R)

add_static_hint_CDU("L2", _("Rotary between Lat/Long and UTM"))

add_static_hint_CDU("R3", _("Command a NAV Mode (available only with steady or flashing INS NAV RDY)"))
add_static_hint_CDU("R4", _("Branch to the INS Page"))

