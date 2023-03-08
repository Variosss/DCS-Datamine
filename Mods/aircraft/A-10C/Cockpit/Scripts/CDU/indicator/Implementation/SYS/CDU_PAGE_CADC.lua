dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameCADC",   2, 1, LFT, "CADC")

AddStaticText("FAULT",   2, 3, LFT, "FAULT")
AddText("FAUL_STATUS0",  8, 3, LFT, {{"CADCFaultStatus", 0}}, "NO")
AddText("FAUL_STATUS1",  8, 3, LFT, {{"CADCFaultStatus", 1}}, "YES")

AddStaticText("P_ALT",   2, 4, LFT, "P ALT")
AddText("P_ALT_VAL",    13, 4, RGHT, {{"CADCPressureAltitude"}})

AddStaticText("B_ALT",   2, 5, LFT,  "B ALT")
AddText("B_ALT_VAL",    13, 5, RGHT, {{"CADCBarometricAltitude"}})

AddStaticText("TAS",   2, 6, LFT, "TAS")
AddText("TAS_VAL",     15, 6,RGHT, {{"CADCTrueAirSpeed"}})

AddStaticText("MACH",   2, 7, LFT, "MACH")
AddText("MACH_VAL",     16,7, RGHT, {{"CADCMach"}})

AddStaticText("IAS",    2, 8, LFT, "IAS")
AddText("IAS_VAL",      16,8, RGHT,{{"CADCIAS"}})

AddStaticText("TEMP",   2, 9, LFT, "TEMP")
AddText("TEMP_VAL",    14, 9, RGHT, {{"CADCTemperature"}})

AddStaticText("CADC",  16, 3, LFT, "CADC")
AddText("CADC_ST0",     21, 3, LFT, {{"CADCDeviceStatus", 0}} , "N")
AddText("CADC_ST1",     21, 3, LFT, {{"CADCDeviceStatus", 1}} , "I")
AddText("CADC_ST2",     21, 3, LFT, {{"CADCDeviceStatus", 2}} , "V")
AddText("CADC_ST3",     21, 3, LFT, {{"CADCDeviceStatus", 3}} , "F")
AddText("CADC_ST4",     21, 3, LFT, {{"CADCDeviceStatus", 4}} , "T")

AddText("P_ALT_ST",    21, 4, LFT, {{"CADCPressureAltitudeStatus", 2}} , "V")
AddText("P_ALT_ST1",    21, 4, LFT, {{"CADCPressureAltitudeStatus", 3}} , "F")

AddText("B_ALT_ST",    21, 5, LFT, {{"CADCBarometricAltitudeStatus", 2}} , "V")
AddText("B_ALT_ST1",    21, 5, LFT, {{"CADCBarometricAltitudeStatus", 3}} , "F")

AddText("TAS_ST",      21, 6, LFT, {{"CADCTASStatus", 2}} , "V")
AddText("TAS_ST1",      21, 6, LFT, {{"CADCTASStatus", 3}} , "F")

AddText("MACH_ST",      21, 7, LFT, {{"CADCMACHStatus", 2}} , "V")
AddText("MACH_ST1",      21, 7, LFT, {{"CADCMACHStatus", 3}} , "F")

AddText("IAS_ST",      21, 8, LFT, {{"CADCIASStatus", 2}} , "V")
AddText("IAS_ST1",      21, 8, LFT, {{"CADCIASStatus", 3}} , "F")

AddText("TEMP_ST",     21, 9, LFT, {{"CADCTEMPStatus", 2}} , "V")
AddText("TEMP_ST1",     21, 9, LFT, {{"CADCTEMPStatus", 3}} , "F")
