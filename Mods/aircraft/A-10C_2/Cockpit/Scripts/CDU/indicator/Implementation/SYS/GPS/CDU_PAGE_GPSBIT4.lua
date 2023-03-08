dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameGPSBIT4",	2, 1, LFT, "GPSBIT")

AddStaticText("FWI", 2, 3, LFT, "FAILURE ID WORDS")

AddText      ("BLOCK_NUM1", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 1}}, "1")
AddText      ("BLOCK_NUM2", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 2}}, "2")
AddText      ("BLOCK_NUM3", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 3}}, "3")
AddText      ("BLOCK_NUM4", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 4}}, "4")
AddText      ("BLOCK_NUM5", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 5}}, "5")
AddText      ("BLOCK_NUM6", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 6}}, "6")
AddText      ("BLOCK_NUM7", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 7}}, "7")
AddText      ("BLOCK_NUM8", 13, 9, LFT, {{"gpsFailureBitBlockNumber", 8}}, "8")
AddStaticText("GPS",        1 , 9, LFT, ROTARY.."NEXT BCKS P /8")

AddStaticText("GPS1", 24, 9, RGHT, "GPS" .. BRANCH_R)
AddStaticText("PAGE_NUMBER", 19 + PageNumNorOffset, 10, LFT, "P4/5")

add_static_hint_CDU("L4", _("Cycle between block failures"))
add_static_hint_CDU("R4", _("Branch to the GPS Page"))