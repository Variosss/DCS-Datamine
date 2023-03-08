dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSSTAT1",	2, 1, LFT, "GPSSTAT")

AddStaticText("NAV_DATA", 2, 4, LFT, "NAV DATA")
AddText      ("NAV_DATAs",11,4, LFT, {{"gpsNavigationDataStatus", 0}}, "F")
AddText      ("NAV_DATAs1",11,4, LFT, {{"gpsNavigationDataStatus", 1}}, "V")

AddStaticText("BIT_INPR", 2, 5, LFT, "BIT INPR")
AddText      ("BIT_INPRs",11,5, LFT, {{"gpsBitInProgress", 0}}, "N")
AddText      ("BIT_INPRs1",11,5, LFT, {{"gpsBitInProgress", 1}}, "Y")

AddStaticText("INIT_REQ", 2, 6, LFT, "INIT REQ")
AddText      ("INIT_REQs",11,6, LFT, {{"gpsInitializationRequired", 0}}, "N")
AddText      ("INIT_REQs1",11,6, LFT, {{"gpsInitializationRequired", 1}}, "Y")

AddStaticText("UTC",      2, 7, LFT, "UTC")
AddText      ("UTCs",    11, 7, LFT, {{"gpsUtcStatus", 0}}, "F")
AddText      ("UTCs1",    11, 7, LFT, {{"gpsUtcStatus", 1}}, "V")

AddStaticText("ALM_REQ",  2, 8, LFT, "ALM REQ")
AddText      ("ALM_REQs", 11,8, LFT, {{"gpsAlmanacRequired", 0}}, "N")
AddText      ("ALM_REQs1", 11,8, LFT, {{"gpsAlmanacRequired", 1}}, "Y")

AddStaticText("FLTR_INS", 2, 9, LFT, "FILTER")
AddText      ("FLTR_INSs",11,9, LFT, {{"gpsKalmanFilterMode", 0}}, "INS")
AddText      ("FLTR_INSs1",11,9, LFT, {{"gpsKalmanFilterMode", 1}}, "PVA")

AddStaticText("GPS",          14, 3, LFT, "GPS")
AddText		 ("GPSStatus",    23, 3, LFT, {{"EGIStatus", 1, 0}}, "N")
AddText		 ("GPSStatus1",    23, 3, LFT, {{"EGIStatus", 1, 1}}, "I")
AddText		 ("GPSStatus2",    23, 3, LFT, {{"EGIStatus", 1, 2}}, "V")
AddText		 ("GPSStatus3",    23, 3, LFT, {{"EGIStatus", 1, 3}}, "F")
AddText		 ("GPSStatus4",    23, 3, LFT, {{"EGIStatus", 1, 4}}, "T")

AddStaticText("KEY_USED",     14, 5, LFT, "KEY USED")
AddText      ("KEY_USEDs",    23, 5, LFT, {{"gpsKeyStatus", 0}}, "N")
AddText      ("KEY_USEDs1",    23, 5, LFT, {{"gpsKeyStatus", 1}}, "U")
AddText      ("KEY_USEDs2",    23, 5, LFT, {{"gpsKeyStatus", 2}}, "I")
AddText      ("KEY_USEDs3",    23, 5, LFT, {{"gpsKeyStatus", 3}}, "V")

AddStaticText("GUK_USER", 14, 6, LFT, "GUK USER")
AddText      ("GUK_USERs",23, 6, LFT, {{"gpsGukUserStatus", 0}}, "N")
AddText      ("GUK_USERs1",23, 6, LFT, {{"gpsGukUserStatus", 1}}, "Y")

AddStaticText("KEY_PAR", 14, 7, LFT,  "KEY PAR")
AddText      ("KEY_PARs",23, 7, LFT, {{"gpsKeyParityStatus", 0}}, "F")
AddText      ("KEY_PARs1",23, 7, LFT, {{"gpsKeyParityStatus", 1}}, "V")


AddStaticText("KEY_2HR", 14, 8, LFT,  "KEY 2HR")
AddText      ("KEY_PARs2",23, 8, LFT, {{"gpsKey2hrStatus", 0}}, "F")
AddText      ("KEY_PARs3",23, 8, LFT, {{"gpsKey2hrStatus", 1}}, "V")

AddStaticText("GPS1", 24, 9, RGHT, "GPS" .. BRANCH_R)

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P1/2")

add_static_hint_CDU("R4", _("Branch to the GPS Page"))