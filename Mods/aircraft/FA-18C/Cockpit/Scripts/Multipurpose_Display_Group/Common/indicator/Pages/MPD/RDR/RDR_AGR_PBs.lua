dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

-- addStrokeText("Radar_RF_Channel", nil, STROKE_FNT_DFLT_120, "LeftCenter", {operModePosX - 55, operModePosY - 30}, nil, {{"MPD_RDR_AG_AGR_RF_Channel"}},
-- 	{"", "A", "B", "C", "D", "E", "F", "G", "*"})

add_PB_label_RDR(3, "AIR")
add_PB_label_RDR(4, "ECCM")

add_PB_label_RDR(15, {" SIL ", nil, {{"MPD_RDR_SIL_LabelStatus", 1}}, {{"MPD_RDR_SIL_LabelStatus", 2}}})

-- DATA label with box
--add_PB16_DATA_label(true)

-- DCLTR (boxed)
add_PB_label_RDR(16, "DATA")

add_PB_label_RDR(17, "CHAN")