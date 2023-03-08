dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
local PB_TextFont = {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), 6 * GetScale()}

-- Low Duty Factor
add_PB_label_RDR(1, "LDF")
-- Speed Gate
add_PB_label_RDR(2, {"NORM", nil, {{"MPD_RDR_SpeedGate", 1}}})
add_PB_label_RDR(2, {"WIDE", nil, {{"MPD_RDR_SpeedGate", 0}}})
-- ECCM enable/disable
add_PB_label_RDR(4, "ECCM")
-- RWR ATTK Option
RWR_ATTK_Label_PH = addPlaceholder("RWR_ATTK_Label_PH", nil, nil, {{"MPD_RDR_AA_DATA_RWR_ATTK_Show"}})
add_PB_label_RDR(5, {"RWR", RWR_ATTK_Label_PH.name}, {"ATTK", RWR_ATTK_Label_PH.name})
addStrokeBox("RWR_ATTK_Label_Box", 51, 128, "LeftCenter", {PB_positions[5][1],	PB_positions[5][2] + 24}, RWR_ATTK_Label_PH.name, {{"MPD_RDR_AA_DATA_RWR_ATTK_Box"}})
-- Target aging selection
addPlaceholder("TargetAging_Main", nil, nil, {{"MPD_RDR_AA_TargetAginhgLayoutShow", 0}})
add_PB_label_RDR(10, {" ", "TargetAging_Main", {{"MPD_RDR_AA_TargetAgingLabel"}}})
addStrokeText("TargetAging_Additional_Layout", "2 4 8 16 32", PB_TextFont, "CenterCenter", {336, 496}, nil, {{"MPD_RDR_AA_TargetAginhgLayoutShow", 1}})

local RAID_1LOOK_label_tbl = add_PB_label_RDR(12, "1LOOK", "RAID")
addStrokeBox("RAID_1LOOK_label_Box", 26, 156, "LeftCenter", {PB_positions[12][1] - 26,	PB_positions[12][2] + 24}, nil, {{"MPD_RDR_AA_DATA_1LOOK_RAID_Box"}})
-- additional shift for RAID
adjust_PB_label_pos(RAID_1LOOK_label_tbl[2], -10, 0)

add_PB_label_RDR(13, {"COLOR", nil, nil, {{"MPD_RDR_ColorBox"}}})
add_PB_label_RDR(14, {"MSI", nil, nil, {{"MPD_RDR_MSI_Box"}}})
add_PB_label_RDR(15, {"LTWS", nil, nil, {{"MPD_RDR_LTWSBox"}}})
add_PB_label_RDR(19, {"BRA", nil, nil, {{"MPD_RDR_BRAEnable"}}})
-- DATA label with box
add_PB16_DATA_label(true)
-- DCLTR / DCLTR 1 (boxed) / DCLTR 2 (boxed)
local DCLTR_Label = add_PB_label_RDR(17, {" DCLTR ", nil, {{"MPD_RDR_DCLTR_LabelStatus"}}, {{"MPD_RDR_DCLTR_LabelStatus", 1}}})[1]
DCLTR_Label.formats = {"DCLTR", "DCLTR 1", "DCLTR 2"}

