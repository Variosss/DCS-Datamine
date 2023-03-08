dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

-- DATA label with box
add_PB16_DATA_label(true)
-- DCLTR / DCLTR (boxed)
add_PB_label_RDR(17, {" DCLTR ", nil, nil, {{"MPD_RDR_DCLTR_LabelStatus", 1}}})

local GN_Lable = add_PB_label_RDR(1, {"GN"}, {"1", nil, {{"MPD_RDR_AG_DATA_Gain"}}})
local GainLabelOffsetY = 60
GN_Lable[1].init_pos = {GN_Lable[1].init_pos[1], GN_Lable[1].init_pos[2] + GainLabelOffsetY}
GN_Lable[2].init_pos = {GN_Lable[2].init_pos[1], GN_Lable[2].init_pos[2] + GainLabelOffsetY}
local arrowPosAdjX = 20
local GainIncrementArrow 		=
    addStrokeSymbol("GainIncrementArrow", {"stroke_symbols_MDI_AMPCD", "076-arrow-up"}, "RightCenter", {PB_positions[2][1] + arrowPosAdjX, PB_positions[2][2]})
local GainDecrementArrow 		= Copy(GainIncrementArrow)
GainDecrementArrow.name  		= "GainDecrementArrow"
GainDecrementArrow.init_pos    = {PB_positions[1][1] + arrowPosAdjX, PB_positions[1][2]}
GainDecrementArrow.init_rot    = {180}
GainDecrementArrow.alignment	= "LeftCenter"
Add(GainDecrementArrow)