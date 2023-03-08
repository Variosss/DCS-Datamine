dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

-- Range increment/decrement arrows
addRangeIncDecArrows()

add_PB_label_RDR(1, {"RADAR", nil, {{"MPD_RDR_AG_MAP_DEBUG_SHOW_TV_RADAR"}}}, {"TV", nil, {{"MPD_RDR_AG_MAP_DEBUG_SHOW_TV_RADAR"}}})

add_PB_label_RDR(3, {"AIR",  nil, {{"MPD_RDR_AG_AIR_Show"}}})
add_PB_label_RDR(4, {"ECCM", nil, {{"MPD_RDR_AG_ECCM_Show"}, {"MPD_RDR_AG_RadarModeLayoutShow", 0}}, {{"MPD_RDR_AG_ECCM_Show"}, {"MPD_RDR_AG_RadarModeLayoutShow", 0}}})

add_PB_label_RDR(6,  {"EXP1", nil, {{"MPD_RDR_AG_EXP1_PB_Show"}},{{"MPD_RDR_AG_EXP_1_Box"}}})
add_PB_label_RDR(6,  {"INTL", nil, {{"MPD_RDR_AG_INTL_PB_Show"}},{{"MPD_RDR_AG_INTL_Box"}}})
add_PB_label_RDR(7,  {"EXP2", nil, {{"MPD_RDR_AG_EXP2_PB_Show"}},{{"MPD_RDR_AG_EXP_2_Box"}}})
add_PB_label_RDR(8,  {"EXP3", nil, {{"MPD_RDR_AG_EXP3_PB_Show"}},{{"MPD_RDR_AG_EXP_3_Box"}}})
add_PB_label_RDR(8,  {"ERASE", nil, {{"MPD_RDR_ERASE_LabelShow"}}})

local PEN_FAN_Offset = 40
local PEN = add_PB_label_RDR(9,  {"PEN", nil, {{"MPD_RDR_AG_PEN_FAN_Show"}}, {{"MPD_RDR_AG_PEN_FAN_Show"}, {"MPD_RDR_AG_PEN_FAN", 1}}})
PEN[1].init_pos = {PEN[1].init_pos[1] - PEN_FAN_Offset, PEN[1].init_pos[2]}
PEN[2].init_pos = {PEN[2].init_pos[1] - PEN_FAN_Offset, PEN[2].init_pos[2]}
local FAN = add_PB_label_RDR(9,  {"FAN", nil, {{"MPD_RDR_AG_PEN_FAN_Show"}}, {{"MPD_RDR_AG_PEN_FAN_Show"}, {"MPD_RDR_AG_PEN_FAN", 2}}})
FAN[1].init_pos = {FAN[1].init_pos[1] + PEN_FAN_Offset, FAN[1].init_pos[2]}
FAN[2].init_pos = {FAN[2].init_pos[1] + PEN_FAN_Offset, FAN[2].init_pos[2]}

add_PB_label_RDR(10, {"ACTIVE", nil, {{"MPD_RDR_ACTIVE_LabelShow"}}})
add_PB_label_RDR(13, {" FRZ ", nil, {{"MPD_RDR_AG_FREEZE_LabelStatus", 1}}, {{"MPD_RDR_AG_FREEZE_LabelStatus", 2}}})
add_PB_label_RDR(14, {"RSET", nil, {{"MPD_RDR_AA_RSET_LabelShow"}}})
add_PB_label_RDR(15, {" SIL ", nil, {{"MPD_RDR_SIL_LabelStatus", 1}}, {{"MPD_RDR_SIL_LabelStatus", 2}}})

add_PB_label_RDR(17, {"CHAN"}, {"LST ", nil, {{"MPD_FLIR_LST_Label"}}})
local azimuthScanLabel = add_PB_label_RDR(19, "120°")[1]
azimuthScanLabel.controllers = {{"MPD_RDR_AA_AzimuthScanCoverage"}, {"MPD_RDR_AG_AzimuthScanLayoutShow", 0}}
azimuthScanLabel.formats = {"%3d°"}
addStrokeText("AzimuthScan_Layout", "120 90 45 20", PB_TextFont, "CenterCenter", {-210, -496}, nil, {{"MPD_RDR_AG_AzimuthScanLayoutShow", 1, 0}})
addStrokeText("AzimuthScan_LayoutGMT", "    90 45 20", PB_TextFont, "CenterCenter", {-210, -496}, nil, {{"MPD_RDR_AG_AzimuthScanLayoutShow", 1, 1}})

add_PB_label_RDR(20, {"FAST", nil, {{"MPD_RDR_AG_FastShow"}, {"MPD_RDR_AG_AzimuthScanLayoutShow", 0, 1}}, {{"MPD_RDR_AG_FastOption"}, {"MPD_RDR_AG_AzimuthScanLayoutShow", 0, 1}}})

-- DATA label without box
add_PB16_DATA_label(false)

addStrokeText("Radar_Gain", nil, STROKE_FNT_DFLT_120, "CenterCenter", {0, -450}, nil, {{"MPD_RDR_AG_DATA_Gain"}})