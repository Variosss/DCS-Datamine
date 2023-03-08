dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("pName",	   2, 1, LFT, "GPSSTAT")
AddStaticText("GPS",      24, 9, RGHT,"GPS" .. BRANCH_R)

AddStaticText("BATTERY",  2, 3, LFT, "BATTERY")
AddText      ("BATTERYs",11, 3, LFT, {{"gpsBatteryStatus", 0}}, "F")
AddText      ("BATTERYs1",11, 3, LFT, {{"gpsBatteryStatus", 1}}, "V")

AddStaticText("SAT4",     2, 4, LFT, "4 SAT")
AddText      ("SAT4s",   11, 4, LFT, {{"gpsFourSattelitesStatus", 0}}, "F")
AddText      ("SAT4s1",   11, 4, LFT, {{"gpsFourSattelitesStatus", 1}}, "V")

AddStaticText("RPU",     2, 5, LFT, "RPU")
AddText      ("RPU4s",  11, 5, LFT, {{"gpsRpuStatus", 0}}, "F")
AddText      ("RPU4s1",  11, 5, LFT, {{"gpsRpuStatus", 1}}, "V")

AddStaticText("MSN_DUR", 2, 7, LFT, "MSN DUR    /")
AddText      ("KEY_DUR",12, 7, RGHT, {{"gpsKeyDuration"}})
AddText      ("KEY_REM",16, 7, RGHT, {{"gpsKeyRemainingDays"}})

AddStaticText("KEYLOAD", 2, 8, LFT, "KEYLOAD FAILED")
AddText      ("KLDs",   17, 8, LFT, {{"gpsKeyLoadFailed", 0}}, "NO")
AddText      ("KLDs1",   17, 8, LFT, {{"gpsKeyLoadFailed", 1}}, "YES")

AddStaticText("SUFKEYS", 13, 3, LFT, "SUFKEYS")
AddText      ("SFKEYSs", 23, 3, LFT, {{"gpsSufficientKey", 0}}, "N")
AddText      ("SFKEYSs1", 23, 3, LFT, {{"gpsSufficientKey", 1}}, "Y")
AddText      ("SFKEYSs2", 23, 3, LFT, {{"gpsSufficientKey", 2}}, "U")

AddStaticText("ERASEFL", 13, 4, LFT, "ERASEFAIL")
AddText      ("ERASEFs", 23, 4, LFT, {{"gpsEraseFailStatus", 0}}, "N")
AddText      ("ERASEFs1", 23, 4, LFT, {{"gpsEraseFailStatus", 1}}, "Y")

AddStaticText("HAS_KEYS", 13, 5, LFT, "HAS KEYS")
AddText      ("HAS_KEYSs",23, 5, LFT,  {{"gpsHasKeys", 0}}, "N")
AddText      ("HAS_KEYSs1",23, 5, LFT, {{"gpsHasKeys", 1}}, "Y")

AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P2/2")

add_static_hint_CDU("R4", _("Branch to the GPS Page"))