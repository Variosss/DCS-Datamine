dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSKEYS",	2, 1, LFT, "GPSKEYS")
AddStaticText("AS", 1, 3, LFT, ROTARY.."ANTI-SPOOFING")

AddText      ("AS_FLAG", 8, 4, LFT, {{"gpsAntiSpoofingFlag", 0}}, "OFF")
AddText      ("AS_FLAG1", 8, 4, LFT, {{"gpsAntiSpoofingFlag", 1}}, "ON")
AddText      ("AS_FLAG2", 8, 4, LFT, {{"gpsAntiSpoofingFlag", 2}}, "***")

AddStaticText("DUR",     1, 7, LFT, DATA_ENTRY.."DUR")
AddStaticText("DUR_VALS",9, 7, LFT, "/")

AddText      ("KEY_DUR", 8, 7, RGHT, {{"gpsKeyDuration"}})
AddText      ("KEY_REM",11, 7, RGHT, {{"gpsKeyRemainingDays"}})

AddStaticText("ZEROIZE", 1, 9, LFT, SYS_ACTION.."ZEROIZE")
AddStaticText("GPS",    24, 9, RGHT, "GPS" .. BRANCH_R)

add_static_hint_CDU("L1", _("Use only encrypted military GPS signals"))
add_static_hint_CDU("L3", _("Enter the number of days the key is valid"))
add_static_hint_CDU("L4", _("Erase the current key"))
add_static_hint_CDU("R4", _("Branch to the GPS Page"))
