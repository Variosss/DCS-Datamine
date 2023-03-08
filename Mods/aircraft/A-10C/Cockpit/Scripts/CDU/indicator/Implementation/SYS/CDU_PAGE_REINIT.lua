dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameREINIT", 2, 1, LFT, "REINIT")

AddStaticText("REINIT_INS",    1, 3, LFT, SYS_ACTION .. "REINIT INS")
AddText		 ("EGIStatus",    15, 3, LFT, {{"EGIStatus", 0, 0}}, "N")
AddText		 ("EGIStatus1",    15, 3, LFT, {{"EGIStatus", 0, 1}}, "I")
AddText		 ("EGIStatus2",    15, 3, LFT, {{"EGIStatus", 0, 2}}, "V")
AddText		 ("EGIStatus3",    15, 3, LFT, {{"EGIStatus", 0, 3}}, "F")
AddText		 ("EGIStatus4",    15, 3, LFT, {{"EGIStatus", 0, 4}}, "T")

AddStaticText("REINIT_GPS",    1, 5, LFT, SYS_ACTION .. "REINIT GPS")
AddText		 ("EGIStatus5",    15, 5, LFT, {{"EGIStatus", 1, 0}}, "N")
AddText		 ("EGIStatus6",    15, 5, LFT, {{"EGIStatus", 1, 1}}, "I")
AddText		 ("EGIStatus7",    15, 5, LFT, {{"EGIStatus", 1, 2}}, "V")
AddText		 ("EGIStatus8",    15, 5, LFT, {{"EGIStatus", 1, 3}}, "F")
AddText		 ("EGIStatus9",    15, 5, LFT, {{"EGIStatus", 1, 4}}, "T")


AddStaticText("REINIT_LASTE",  1, 7, LFT, SYS_ACTION .. "REINIT LASTE")
AddText      ("LASTE_ST1",    15, 7, LFT, {{"LASTEStatus", 0}}, "N")
AddText      ("LASTE_ST0",    15, 7, LFT, {{"LASTEStatus", 2}}, "V")


AddStaticText("REINIT_DTSAS",  1, 9, LFT, SYS_ACTION .. "REINIT DTSAS")
AddText("DTSAS_ST0",      15, 9, LFT, {{"DTSASStatus", 0}}, "N")
AddText("DTSAS_ST2",      15, 9, LFT, {{"DTSASStatus", 2}}, "V")
AddText("DTSAS_ST3",      15, 9, LFT, {{"DTSASStatus", 3}}, "F")



AddStaticText("CADC",		  18, 3, LFT, "CADC")
AddText("CADC_ST0",     23, 3, LFT, {{"CADCDeviceStatus", 0}} , "N")
AddText("CADC_ST2",     23, 3, LFT, {{"CADCDeviceStatus", 2}} , "V")
AddText("CADC_ST3",     23, 3, LFT, {{"CADCDeviceStatus", 3}} , "F")
AddText("CADC_ST4",     23, 3, LFT, {{"CADCDeviceStatus", 4}} , "T")

AddStaticText("HARS",		  18, 4, LFT, "HARS")
AddText("HARS_ST2",			   23, 4, LFT, {{"HARS_DeviceStatus", 2}}, "V")
AddText("HARS_ST3",			   23, 4, LFT, {{"HARS_DeviceStatus", 3}}, "F")


AddStaticText("DTS",		  18, 5, LFT, "DTS")
AddText("DTS_ST0",        23, 5, LFT, {{"DTSDeviceStatus", 0}}, "N")
AddText("DTS_ST1",        23, 5, LFT, {{"DTSDeviceStatus", 1}}, "I")
AddText("DTS_ST2",        23, 5, LFT, {{"DTSDeviceStatus", 2}}, "V")
AddText("DTS_ST3",        23, 5, LFT, {{"DTSDeviceStatus", 3}}, "F")

AddStaticText("CDU",		  18, 6, LFT, "CDU")
AddText      ("CDU_ST1", 23, 6, LFT, {{"CDUDeviceStatus", 2}} , "V")
AddText      ("CDU_ST3", 23, 6, LFT, {{"CDUDeviceStatus", 3}} , "F")
AddText      ("CDU_ST4", 23, 6, LFT, {{"CDUDeviceStatus", 4}} , "T")


AddStaticText("MBC",		  18, 7, LFT, "MBC")
AddStaticText("MBC1",		  23, 7, LFT, "V")

AddStaticText("MSN",		  18, 8, LFT, "MSN")
AddText		 ("EGIStatus10",    23, 8, LFT, {{"EGIStatus", 2, 0}}, "N")
AddText		 ("EGIStatus11",    23, 8, LFT, {{"EGIStatus", 2, 1}}, "I")
AddText		 ("EGIStatus12",    23, 8, LFT, {{"EGIStatus", 2, 2}}, "V")
AddText		 ("EGIStatus13",    23, 8, LFT, {{"EGIStatus", 2, 3}}, "F")
AddText		 ("EGIStatus14",    23, 8, LFT, {{"EGIStatus", 2, 4}}, "T")

add_static_hint_CDU("L1", _("Reset the Inertial Navigation System (INS)"))
add_static_hint_CDU("L2", _("Reset the Global Positioning System (GPS)"))
add_static_hint_CDU("L3", _("Reset the Low Altitude and Targeting Enhancement (LASTE). Not Functional"))
add_static_hint_CDU("L4", _("Reset the Digital Terrain System Application Software (DTSAS). Not Functional"))
