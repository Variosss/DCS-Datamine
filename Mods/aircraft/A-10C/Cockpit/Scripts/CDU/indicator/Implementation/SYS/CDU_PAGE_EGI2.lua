dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameEGI",   2, 1, LFT, "EGI")

AddStaticText("SPU",           2, 3, LFT, "SPU")
AddStaticText("SPU_STATUS",   10, 3, LFT, "V")
AddStaticText("ISA",           2, 4, LFT, "ISA")
AddStaticText("ISA_STATUS",   10, 4, LFT, "V")
AddStaticText("PS" ,           2, 5, LFT, "PS")
AddStaticText("PS_STATUS",    10, 5, LFT, "V")
AddStaticText("CHASSIS",       2, 6, LFT, "CHASSIS")
AddStaticText("CHASSIS_STATUS",10,6, LFT, "V")

AddStaticText("GPS",          15, 3, LFT, "GPS")
--AddStaticText("GPS_STATUS",   20, 3, LFT, "V")
AddText		 ("GPSStatus",    20, 3, LFT, {{"EGIStatus", 1, 0}}, "N")
AddText		 ("GPSStatus1",    20, 3, LFT, {{"EGIStatus", 1, 1}}, "I")
AddText		 ("GPSStatus2",    20, 3, LFT, {{"EGIStatus", 1, 2}}, "V")
AddText		 ("GPSStatus3",    20, 3, LFT, {{"EGIStatus", 1, 3}}, "F")
AddText		 ("GPSStatus4",    20, 3, LFT, {{"EGIStatus", 1, 4}}, "T")
AddStaticText("IE",           15, 4, LFT, "IE")
AddStaticText("IE_STATUS",    20, 4, LFT, "V")
AddStaticText("MSN",          15, 5, LFT, "MSN")
--AddStaticText("MSN_STATUS",   20, 5, LFT, "V")
AddText		 ("EGIStatus",    20, 5, LFT, {{"EGIStatus", 2, 0}}, "N")
AddText		 ("EGIStatus1",    20, 5, LFT, {{"EGIStatus", 2, 1}}, "I")
AddText		 ("EGIStatus2",    20, 5, LFT, {{"EGIStatus", 2, 2}}, "V")
AddText		 ("EGIStatus3",    20, 5, LFT, {{"EGIStatus", 2, 3}}, "F")
AddText		 ("EGIStatus4",    20, 5, LFT, {{"EGIStatus", 2, 4}}, "T")

AddText("EGI_SA",              1, 7, LFT, {{"TestModeOn"}}, SYS_ACTION)
AddStaticText("EGI_OFP",       2, 7, LFT, "EGI OFP ID A10P4")
AddStaticText("STATUS",        2, 8, LFT, "STATUS     DISABLED")
AddText("GEM_SA",              1, 9, LFT, {{"TestModeOn"}}, SYS_ACTION)
AddStaticText("GEM_OFP",       2, 9, LFT, "GEM OFP ID 00=017")






AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P2/4")
