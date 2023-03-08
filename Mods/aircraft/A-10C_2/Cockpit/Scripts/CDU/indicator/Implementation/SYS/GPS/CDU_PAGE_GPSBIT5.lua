dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSBIT5",	2, 1, LFT, "GPSBIT")

AddStaticText("IIW",         2, 3, LFT, "INFO ID WORDS")
AddText      ("BLOCK_NUM1", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 1}}, "1")
AddText      ("BLOCK_NUM2", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 2}}, "2")
AddText      ("BLOCK_NUM3", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 3}}, "3")
AddText      ("BLOCK_NUM4", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 4}}, "4")
AddText      ("BLOCK_NUM5", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 5}}, "5")
AddText      ("BLOCK_NUM6", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 6}}, "6")
AddText      ("BLOCK_NUM7", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 7}}, "7")
AddText      ("BLOCK_NUM8", 13, 9, LFT, {{"gpsInfoBitBlockNumber", 8}}, "8")
AddStaticText("GPS",        1 , 9, LFT, ROTARY.."NEXT BCKS P /8")

AddStaticText("GPS1", 24, 9, RGHT, "GPS" .. BRANCH_R)
AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P5/5")

add_static_hint_CDU("L4", _("Cycle between block failures"))
add_static_hint_CDU("R4", _("Branch to the GPS Page"))