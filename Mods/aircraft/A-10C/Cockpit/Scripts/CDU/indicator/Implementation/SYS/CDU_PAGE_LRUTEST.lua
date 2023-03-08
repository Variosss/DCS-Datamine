dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameLRUTEST", 2, 1, LFT, "LRUTEST")

AddStaticText("CADC",            2, 5, LFT, "CADC")
AddText("CADC_SA",               1, 5, LFT, {{"IsCADCTestAvailable"}}, SYS_ACTION)
AddText("CADC_STATUS0",          7, 5, LFT, {{"CADCStatus", 0}}, "UN")
AddText("CADC_STATUS1",          7, 5, LFT, {{"CADCStatus", 1}}, "IP")
AddText("CADC_STATUS2",          7, 5, LFT, {{"CADCStatus", 2}}, "GO")
AddText("CADC_STATUS3",          7, 5, LFT, {{"CADCStatus", 3}}, "NG")

AddStaticText("CDU",             2, 7, LFT, "CDU")
AddText("CDU_SYS_ACTION",        1, 7, LFT, {{"IsCDUTestAvailable"}}, SYS_ACTION)
AddText("CDU_STATUS0",           6, 7, LFT, {{"CDUStatus", 0}}, "UN")
AddText("CDU_STATUS1",           6, 7, LFT, {{"CDUStatus", 1}}, "IP")
AddText("CDU_STATUS2",           6, 7, LFT, {{"CDUStatus", 2}}, "GO")
AddText("CDU_STATUS3",           6, 7, LFT, {{"CDUStatus", 3}}, "NG")

AddStaticText("DTS_LB",          18, 3, LFT, "DTS")
AddText("DTS_SA",          24, 3, RGHT, {{"IsDTSTestAvailable"}}, SYS_ACTION)
AddText("DTS_STATUS0",           22, 3, LFT, {{"DTSStatus", 0}}, "UN")
AddText("DTS_STATUS1",           22, 3, LFT, {{"DTSStatus", 1}}, "IP")
AddText("DTS_STATUS2",           22, 3, LFT, {{"DTSStatus", 2}}, "GO")
AddText("DTS_STATUS3",           22, 3, LFT, {{"DTSStatus", 3}}, "NG")

AddStaticText("RECORD",          24, 7, RGHT, "RECORD"..SYS_ACTION)
AddStaticText("EGITEST",          1, 3, LFT, BRANCH_L .. "EGITEST")

AddText("TEST_SA",                1, 9, LFT, {{"LruTestMode", 0}}, SYS_ACTION)
AddText("TEST_SA1",                1, 9, LFT, {{"LruTestMode", 1}}, SYS_ACTION)
AddText("TEST_SA2",                1, 9, LFT, {{"LruTestMode", 2}}, SYS_ACTION)
AddText("TEST_MODE0",             2, 9, LFT, {{"LruTestMode", 0}}, "TEST MODE")
AddText("TEST_MODE1",             2, 9, LFT, {{"LruTestMode", 1}}, "EXIT TESTING")
AddText("TEST_MODE2",             2, 9, LFT, {{"LruTestMode", 2},{"Blinking"}}, "EXIT TESTING")
AddText("TEST_MODE4",             2, 9, LFT, {{"LruTestMode", 3}}, "TEST MODE")

add_static_hint_CDU("L1", _("Branch to the EGITEST page"))
add_static_hint_CDU("L2", _("Run a Test of the CADC LRU"))
add_static_hint_CDU("L3", _("Run a Test of the CDU LRU"))
add_static_hint_CDU("L4", _("Select Test Mode. To run a test of the CDU LRU, you must first press this LSK"))

add_static_hint_CDU("R1", _("Run a Test of the DTS LRU"))
add_static_hint_CDU("R3", _("Record the BIT results. Not Functional"))