dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameRESET", 2, 1, LFT, "RESET")

AddStaticText("RESET_EGI",	   1, 3, LFT, SYS_ACTION .. "EGI")
AddText		 ("EGIStatus",     8, 3, LFT, {{"EGIStatus", 4, 0}}, "N")
AddText		 ("EGIStatus1",     8, 3, LFT, {{"EGIStatus", 4, 1}}, "I")
AddText		 ("EGIStatus2",     8, 3, LFT, {{"EGIStatus", 4, 2}}, "V")
AddText		 ("EGIStatus3",     8, 3, LFT, {{"EGIStatus", 4, 3}}, "F")
AddText		 ("EGIStatus4",     8, 3, LFT, {{"EGIStatus", 4, 4}}, "T")

AddStaticText("RESET_LASTE",   1, 5, LFT, SYS_ACTION .. "LASTE")
AddText      ("RESET_ST1",     8, 5, LFT, {{"LASTEStatus", 0}}, "N")
AddText      ("RESET_ST0",     8, 5, LFT, {{"LASTEStatus", 2}}, "V")

AddStaticText("RESET_CICU",    1, 7, LFT, SYS_ACTION .. "CICU")
AddText      ("RESET_CICU1",     8, 7, LFT, {{"CICUStatus", 0}}, "N")
AddText      ("RESET_CICU0",     8, 7, LFT, {{"CICUStatus", 1}}, "V")
--AddStaticText("RESET_LASTE1",   8, 7, LFT, "V")

AddStaticText("RESET_CADC",	  24, 3, RGHT, "CADC  " .. SYS_ACTION)
AddText("CADC_ST0",     23, 3, LFT, {{"CADCDeviceStatus", 0}} , "N")
AddText("CADC_ST2",     23, 3, LFT, {{"CADCDeviceStatus", 2}} , "V")
AddText("CADC_ST3",     23, 3, LFT, {{"CADCDeviceStatus", 3}} , "F")
AddText("CADC_ST4",     23, 3, LFT, {{"CADCDeviceStatus", 4}} , "T")

AddStaticText("RESET_HARS",	  24, 5, RGHT, "HARS  " .. SYS_ACTION)
AddText("HARS_ST2",			  23, 5, LFT, {{"HARS_DeviceStatus", 2}}, "V")
AddText("HARS_ST3",			  23, 5, LFT, {{"HARS_DeviceStatus", 3}}, "F")

AddStaticText("RESET_DTS",	  24, 7, RGHT, "DTS  " .. SYS_ACTION)
AddText("DTS_ST0",        23, 7, LFT, {{"DTSDeviceStatus", 0}}, "N")
AddText("DTS_ST1",        23, 7, LFT, {{"DTSDeviceStatus", 1}}, "I")
AddText("DTS_ST2",        23, 7, LFT, {{"DTSDeviceStatus", 2}}, "V")
AddText("DTS_ST3",        23, 7, LFT, {{"DTSDeviceStatus", 3}}, "F")

add_static_hint_CDU("L1", _("Reset the Embedded GPS INS"))
add_static_hint_CDU("L2", _("Reset the Low Altitude Safety and Targeting Enhancement (LASTE). Not Functional"))
add_static_hint_CDU("L3", _("Reset the Central Interface Control Unit (CICU). Not Functional"))

add_static_hint_CDU("R1", _("Reset the Central Air Data Computer (CADC)"))
add_static_hint_CDU("R2", _("Reset the Heading Attitude Reference System (HARS)"))
add_static_hint_CDU("R3", _("Reset the Data Transfer System (DTS)"))