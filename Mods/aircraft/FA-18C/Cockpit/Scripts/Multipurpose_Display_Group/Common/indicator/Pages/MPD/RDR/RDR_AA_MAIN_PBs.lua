dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

local PB_TextFont = {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), 6 * GetScale()}

-- PRF
local function addOperating_PRF_label(pos, ...)
	return addTextFromArgTable(arg, pos, {0, 1})
end

local PRF_formats = {"", "LO", "MED", "HI", "INTL", "PDI"}
local PRF_pos = {PB_positions[1][1] + glyphNominalWidth120 * 2 + fontIntercharDflt120 + fontIntercharDflt120 / 2, PB_positions[1][2] + 10}
-- Operating PRF
local operating_PRF_label = addOperating_PRF_label(PRF_pos, {"PDI", nil, {{"MPD_RDR_AA_Operating_PRF"}, {"MPD_RDR_AA_PRFLayoutShow", 0}}, {{"MPD_RDR_AA_PDI_boxShow"}}})[1]
operating_PRF_label.formats = PRF_formats
-- Instantaneous PRF
local inst_PRF_shift = {0, glyphNominalHeight120 + fontInterlineDflt120}
addStrokeText("Instantaneous_PRF", nil, STROKE_FNT_DFLT_120, "CenterBottom", inst_PRF_shift, operating_PRF_label.name, {{"MPD_RDR_AA_Instantaneous_PRF"}}, PRF_formats)
addStrokeText("Instantaneous_PRF_Layout", "HI\n\nMED\n\nINTL", PB_TextFont, "CenterCenter", {-470, -330}, nil, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_PRFLayoutShow", 1}})

-- Operating elevation bar scan
addPlaceholder("ElevBarScan_Main", nil, nil, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_ElevationBarScanLayoutShow", 0}})
local operElevBarScanLabel = add_PB_label_RDR(6, {"1B", "ElevBarScan_Main", {{"MPD_RDR_AA_OperatingElevBarScan"}}})[1]
operElevBarScanLabel.formats = {"%dB"}
-- Current elevation bar number
addStrokeText("Elevation_bar_number", "3", STROKE_FNT_DFLT_120, "LeftTop", {40, 0}, operElevBarScanLabel.name, {{"MPD_RDR_AA_ElevationBarNumber"}})
addStrokeText("ElevBarScan_Additional_Layout", "1B 2B 4B 6B", PB_TextFont, "CenterCenter", {-336, 496}, nil, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_ElevationBarScanLayoutShow", 1}})

-- NOTE: add_PB_label() is used instead of add_PB_label_RDR()
local RDR_PRI_label_tbl = add_PB_label(2, {"RDR", nil, {{"MPD_RDR_AA_RDR_PRI_LabelShow"}}}, {"PRI", nil, {{"MPD_RDR_AA_RDR_PRI_LabelShow"}}})
-- adjusting Y position of both to conform RDR format labels positions
adjust_PB_label_pos(RDR_PRI_label_tbl[1], 0, side_PB_shiftY)
-- additional X shift for PRI
adjust_PB_label_pos(RDR_PRI_label_tbl[2], label2ndRowIdentWide, side_PB_shiftY)

-- NOTE: SURF and QL (plus AUTO/MAN labels at PBs 3 and 4) are mutually exclusive
add_PB_label_RDR(3, {"SURF", nil, {{"MPD_RDR_AA_SURF_LabelShow"}}})

-- QL label
local QL_controllerName = "MPD_RDR_QuickLook_LabelsStatus"
local QL_label = add_PB_label(3, " ", {"QL", nil, {{QL_controllerName}}})[2]
-- QL label is placed between 3 and 4 PBs
adjust_PB_label_pos(QL_label, label2ndRowIdentWide, (PB_positions[4][2] - PB_positions[3][2]) / 2 + side_PB_shiftY)
-- MAN
local QL_MAN_labelAndBox = add_PB_label(3, {"MAN", nil, {{QL_controllerName}}, {{QL_controllerName, 1}}})
for i = 1, #QL_MAN_labelAndBox do
	adjust_PB_label_pos(QL_MAN_labelAndBox[i], 0, side_PB_shiftY)
end
-- AUTO
local QL_AUTO_labelAndBox = add_PB_label(4, {"AUTO", nil, {{QL_controllerName}}, {{QL_controllerName, 2}}})
for i = 1, #QL_AUTO_labelAndBox do
	adjust_PB_label_pos(QL_AUTO_labelAndBox[i], 0, side_PB_shiftY)
end

local RWS_PB_PH = addPlaceholder("RWS_PB", nil, nil, {{"MPD_RDR_RWS_LabelsRoot"}})

-- SIL/ACM labels (mutually exclusive)
add_PB_label_RDR(7, {" SIL ", nil, {{"MPD_RDR_SIL_LabelStatus", 1}}, {{"MPD_RDR_SIL_LabelStatus", 2}}})
add_PB_label_RDR(7, {" ACM ", nil, {{"MPD_RDR_ACM_BoxedShow"}}, {{"MPD_RDR_ACM_BoxedShow"}}})
-- ERASE/STOW/HITS labels (mutually exclusive)
add_PB_label_RDR(8, {"ERASE", nil, {{"MPD_RDR_ERASE_LabelShow"}}})
local STOW_HITS_label = add_PB_label_RDR(8, {"STOW ", nil, {{"MPD_RDR_AA_STOW_HITS_LabelsStatus"}}, {{"MPD_RDR_AA_STOW_HITS_LabelsStatus", 3}}})[1]
STOW_HITS_label.formats = {"", "STOW", "HITS", "STOW1", "STOW2", "HITS"}
-- ACTIVE label
add_PB_label_RDR(10, {"ACTIVE", nil, {{"MPD_RDR_ACTIVE_LabelShow"}}})
-- FLOOD label
add_PB_label_RDR(10, {"FLOOD", nil, {{"MPD_RDR_FLOOD_LabelShow"}}})
	
-- SET label
add_PB_label_RDR(13, {"SET", nil, {{"MPD_RDR_AA_SET_LabelShow", 0}}, {{"MPD_RDR_AA_SET_LabelShow", 1}}})
-- Range increment/decrement arrows
addRangeIncDecArrows()
add_PB_label_RDR(14, {"RSET", nil, {{"MPD_RDR_AA_RSET_LabelShow", 0}}, {{"MPD_RDR_AA_RSET_LabelShow", 1}}})
-- NCTR function
add_PB_label_RDR(15, {"NCTR", nil, nil, {{"MPD_RDR_AA_NCTR_Box"}}})
-- DATA label without box
add_PB16_DATA_label(false)
add_PB_label_RDR(17, {"CHAN", nil, {{"MPD_RDR_CHAN_LabelStatus"}}})

add_PB_label_RDR(10, {"TWS", nil, {{"MPD_RDR_AA_TWS_STT_Label", 1}}})


addPlaceholder("AzimuthScan_Main", nil, RWS_PB_PH.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_AzimuthScanLayoutShow", 0}})
local azimuthScanLabel = add_PB_label_RDR(19, {"140°", "AzimuthScan_Main"})[1]
azimuthScanLabel.controllers = {{"MPD_RDR_AA_AzimuthScanCoverage"}}
azimuthScanLabel.formats = {"%3d°"}
add_PB_label_RDR(20, {"MODE", "AzimuthScan_Main", {{"MPD_RDR_MODE_LabelStatus"}, {"MPD_RDR_AA_TrackedTarget_HideWhenActive"}}})
addStrokeText("AzimuthScan_Additional_Layout", "140 80 60 40 20", PB_TextFont, "CenterCenter", {-245, -496}, RWS_PB_PH.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_AzimuthScanLayoutShow", 1}})

-- TWS
local TWS_PB_PH = addPlaceholder("TWS_PB", nil, nil, {{"MPD_RDR_TWS_LabelsRoot"}})
add_PB_label_RDR(9, {"RAID", TWS_PB_PH.name, {{"MPD_RDR_AA_RDR_RAID_LabelShow"}}, {{"MPD_RDR_AA_RDR_RAID_BoxShow"}}})

addPlaceholder("AzimuthScanTWS_Main", nil, TWS_PB_PH.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AzimuthScanLayoutShow", 0}})
local azimuthScanLabelTWS = add_PB_label_RDR(19, {"140°", "AzimuthScanTWS_Main"})[1]
azimuthScanLabelTWS.controllers = {{"MPD_RDR_AA_AzimuthScanCoverage"}}
azimuthScanLabelTWS.formats = {"%3d°"}
add_PB_label_RDR(20, {"EXP", nil, {{"MPD_RDR_EXP_LabelStatus"}, {"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AzimuthScanLayoutShow", 1, 0}}, {{"MPD_RDR_TWS_EXP_Box"}, {"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AzimuthScanLayoutShow", 1, 0}}})
addStrokeText("AzimuthScan_Additional_Layout_2Bar", "80 60 40 20", PB_TextFont, "CenterCenter", {-205, -496}, TWS_PB_PH.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AzimuthScanLayoutShow", 1, 1}})
addStrokeText("AzimuthScan_Additional_Layout_4Bar", "40 20", PB_TextFont, "CenterCenter", {-145, -496}, TWS_PB_PH.name, {{"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AzimuthScanLayoutShow", 1, 2}})

local AutoManOffset = 20
local AutoManBoxOffset = 6
addStrokeText("TWS_AUTO_Label", "AUTO", PB_TextFont, "RightCenter", {PB_positions[13][1], PB_positions[13][2] + AutoManOffset}, TWS_PB_PH.name, {{"MPD_RDR_AA_TWS_AUTO_MAN_Show"}, {"MPD_RDR_AA_TrackedTarget_HideWhenActive"}, {"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}, {"MPD_RDR_AA_TWS_AUTO_BIAS_Label"}})
addStrokeBox("TWS_AUTO_Label_box", 88, 36, "RightCenter", {AutoManBoxOffset, 0}, "TWS_AUTO_Label", {{"MPD_RDR_AA_TWS_AUTO_MAN_Show"}, {"MPD_RDR_AA_TWS_AUTO_MAN_Box", 1}})
addStrokeText("TWS_MAN_Label", "MAN", PB_TextFont, "RightCenter", {PB_positions[13][1], PB_positions[13][2] - AutoManOffset}, TWS_PB_PH.name, {{"MPD_RDR_AA_TWS_AUTO_MAN_Show"}, {"MPD_RDR_AA_TrackedTarget_HideWhenActive"}, {"MPD_RDR_AA_TWS_RAID_PB_ShowOtherLabels"}})
addStrokeBox("TWS_MAN_Label_box", 66, 36, "RightCenter", {AutoManBoxOffset, 0}, "TWS_MAN_Label", {{"MPD_RDR_AA_TWS_AUTO_MAN_Show"}, {"MPD_RDR_AA_TWS_AUTO_MAN_Box", 0}})