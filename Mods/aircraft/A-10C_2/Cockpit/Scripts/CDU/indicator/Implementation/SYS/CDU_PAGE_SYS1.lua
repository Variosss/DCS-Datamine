dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("EGI", 1, 3, LFT, BRANCH_L .. "EGI")
AddStaticText("INS", 1, 5, LFT, BRANCH_L .. "INS")
AddStaticText("GPS", 1, 7, LFT, BRANCH_L .. "GPS")
AddStaticText("REINIT", 1, 9, LFT, BRANCH_L .. "REINIT")

AddStaticText("LASTE", 24, 3, RGHT, "LASTE" .. BRANCH_R)
AddStaticText("HARS", 24, 5, RGHT, "HARS" .. BRANCH_R)
AddStaticText("DTSAS", 24, 7, RGHT, "DTSAS" .. BRANCH_R)
AddStaticText("RESET", 24, 9, RGHT, "RESET" .. BRANCH_R)

AddText      ("LRU_INS",  7, 3, LFT, {{"sysPageInitMode"}}, "INS")
AddText		 ("EGIStatus", 11, 3, LFT, {{"sysPageInitMode"}, {"EGIStatus", 0, 0}}, "N")
AddText		 ("EGIStatus1", 11, 3, LFT, {{"sysPageInitMode"}, {"EGIStatus", 0, 1}}, "I")
AddText		 ("EGIStatus2", 11, 3, LFT, {{"sysPageInitMode"}, {"EGIStatus", 0, 2}}, "V")
AddText		 ("EGIStatus3", 11, 3, LFT, {{"sysPageInitMode"}, {"EGIStatus", 0, 3}}, "F")
AddText		 ("EGIStatus4", 11, 3, LFT, {{"sysPageInitMode"}, {"EGIStatus", 0, 4}}, "T")

AddText      ("LRU_GPS",  7, 4, LFT, {{"sysPageInitMode"}}, "GPS")
AddText		 ("EGIStatus5", 11, 4, LFT, {{"sysPageInitMode"}, {"EGIStatus", 1, 0}}, "N")
AddText		 ("EGIStatus6", 11, 4, LFT, {{"sysPageInitMode"}, {"EGIStatus", 1, 1}}, "I")
AddText		 ("EGIStatus7", 11, 4, LFT, {{"sysPageInitMode"}, {"EGIStatus", 1, 2}}, "V")
AddText		 ("EGIStatus8", 11, 4, LFT, {{"sysPageInitMode"}, {"EGIStatus", 1, 3}}, "F")
AddText		 ("EGIStatus9", 11, 4, LFT, {{"sysPageInitMode"}, {"EGIStatus", 1, 4}}, "T")

AddText      ("LRU_MSN",  7, 5, LFT, {{"sysPageInitMode"}}, "MSN")
AddText		 ("EGIStatus10", 11, 5, LFT, {{"sysPageInitMode"}, {"EGIStatus", 2, 0}}, "N")
AddText		 ("EGIStatus11", 11, 5, LFT, {{"sysPageInitMode"}, {"EGIStatus", 2, 1}}, "I")
AddText		 ("EGIStatus12", 11, 5, LFT, {{"sysPageInitMode"}, {"EGIStatus", 2, 2}}, "V")
AddText		 ("EGIStatus13", 11, 5, LFT, {{"sysPageInitMode"}, {"EGIStatus", 2, 3}}, "F")
AddText		 ("EGIStatus14", 11, 5, LFT, {{"sysPageInitMode"}, {"EGIStatus", 2, 4}}, "T")

AddText      ("LRU_CADC", 6, 6, LFT, {{"sysPageInitMode"}}, "CADC")
AddText      ("CADC_ST0", 11, 6, LFT, {{"sysPageInitMode"}, {"CADCDeviceStatus", 0}} , "N")
AddText      ("CADC_ST1", 11, 6, LFT, {{"sysPageInitMode"}, {"CADCDeviceStatus", 1}} , "I")
AddText      ("CADC_ST2", 11, 6, LFT, {{"sysPageInitMode"}, {"CADCDeviceStatus", 2}} , "V")
AddText      ("CADC_ST3", 11, 6, LFT, {{"sysPageInitMode"}, {"CADCDeviceStatus", 3}} , "F")
AddText      ("CADC_ST4", 11, 6, LFT, {{"sysPageInitMode"}, {"CADCDeviceStatus", 4}} , "T")

AddText      ("LRU_HARS", 6, 7, LFT, {{"sysPageInitMode"}}, "HARS")
AddText      ("HARS_ST2",11, 7, LFT, {{"sysPageInitMode"}, {"HARS_DeviceStatus", 2}}, "V")
AddText      ("HARS_ST3",11, 7, LFT, {{"sysPageInitMode"}, {"HARS_DeviceStatus", 3}}, "F")

AddText      ("LRU_LASTE",5, 8, LFT, {{"sysPageInitMode"}}, "LASTE")
AddText      ("LASTE_ST0",11, 8, LFT, {{"sysPageInitMode"}, {"LASTEStatus", 0}}, "N")
AddText      ("LASTE_ST2",11, 8, LFT, {{"sysPageInitMode"}, {"LASTEStatus", 2}}, "V")

AddText      ("LRU_CDU", 13, 3, LFT, {{"sysPageInitMode"}}, "CDU")
AddText      ("CDU_ST0", 17, 3, LFT, {{"sysPageInitMode"}, {"CDUDeviceStatus", 0}} , "N")
AddText      ("CDU_ST1", 17, 3, LFT, {{"sysPageInitMode"}, {"CDUDeviceStatus", 2}} , "V")
AddText      ("CDU_ST3", 17, 3, LFT, {{"sysPageInitMode"}, {"CDUDeviceStatus", 3}} , "F")
AddText      ("CDU_ST4", 17, 3, LFT, {{"sysPageInitMode"}, {"CDUDeviceStatus", 4}} , "T")


AddText      ("LRU_MBC", 13, 4, LFT, {{"sysPageInitMode"}}, "MBC V")
AddText      ("LRU_DTS", 13, 5, LFT, {{"sysPageInitMode"}}, "DTS")
AddText("DTS_ST0",        17, 5, LFT, {{"sysPageInitMode"}, {"DTSDeviceStatus", 0}}, "N")
AddText("DTS_ST1",        17, 5, LFT, {{"sysPageInitMode"}, {"DTSDeviceStatus", 1}}, "I")
AddText("DTS_ST2",        17, 5, LFT, {{"sysPageInitMode"}, {"DTSDeviceStatus", 2}}, "V")
AddText("DTS_ST3",        17, 5, LFT, {{"sysPageInitMode"}, {"DTSDeviceStatus", 3}}, "F")
AddText("DTS_ST4",        17, 5, LFT, {{"sysPageInitMode"}, {"DTSDeviceStatus", 4}}, "V")

AddText      ("LRU_DTSAS",13, 6, LFT, {{"sysPageInitMode"}}, "DTSAS") 
AddText("DTSAS_ST0",      19, 6, LFT, {{"sysPageInitMode"}, {"DTSASStatus", 0}}, "N")
AddText("DTSAS_ST2",      19, 6, LFT, {{"sysPageInitMode"}, {"DTSASStatus", 2}}, "V")
AddText("DTSAS_ST3",      19, 6, LFT, {{"sysPageInitMode"}, {"DTSASStatus", 3}}, "F")


AddStaticText("PAGE_NUM", 20 + PageNumNorOffset, 10, LFT, "1")

add_static_hint_CDU("L1", _("Branch to the EGI Page"))
add_static_hint_CDU("L2", _("Branch to the INS Page"))
add_static_hint_CDU("L3", _("Branch to the GPS Page"))
add_static_hint_CDU("L4", _("Branch to the REINIT Page"))
add_static_hint_CDU("R1", _("Branch to the LASTE Page"))
add_static_hint_CDU("R2", _("Branch to the HARS Page"))
add_static_hint_CDU("R3", _("Branch to the DTSAS Page"))
add_static_hint_CDU("R4", _("Branch to the RESET Page"))
