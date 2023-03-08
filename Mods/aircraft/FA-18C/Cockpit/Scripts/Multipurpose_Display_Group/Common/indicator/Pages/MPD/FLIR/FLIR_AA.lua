dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_tools.lua")

---------------------------------------------------
-- On/Off placeholder
local flirRoot			= addPlaceholder("MPD_FLIR_Root", {0,0})
local flirRoot_L		= addPlaceholder("MPD_FLIR_AG_Root_L", {0,0}, flirRoot.name, {{"MPD_FLIR_TgpType", LITENING}})
local flirRoot_A		= addPlaceholder("MPD_FLIR_AG_Root_A", {0,0}, flirRoot.name, {{"MPD_FLIR_TgpType", ATFLIR}})
local operRoot			= addPlaceholder("MPD_FLIR_AG_OnOff", {0,0}, flirRoot.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local operRoot_L		= addPlaceholder("MPD_FLIR_AG_OnOff_L", {0,0}, flirRoot_L.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local operRoot_A		= addPlaceholder("MPD_FLIR_AG_OnOff_A", {0,0}, flirRoot_A.name, {{"MPD_FLIR_OperPlaceholder", 1}})
local videoOnPlaceholder = addPlaceholder("MPD_FLIR_VideoOn", {0,0}, operRoot.name, {{"MPD_FLIR_VideoOn"}})

-- RADAR label
local rdrOpt_root_L = addPlaceholder("MPD_FLIR_RDR_root", {0,0}, operRoot_L.name, {{"MPD_FLIR_RDR_opt"}})
addStrokeText("MPD_FLIR_RDR_label", "RADAR", STROKE_FNT_DFLT_120, "LeftCenter", {200, 430}, rdrOpt_root_L.name)

-- Radar LOS indicator
local RDR_LOS_root = addPlaceholder("MPD_FLIR_RDR_LOS_root", nil, operRoot.name, {{"MPD_FLIR_RDR_LOS_BoxPos", 512}})
local TD_boxSz = MilToDI(25)
addStrokeBox("MPD_FLIR_RDR_LOS_box", TD_boxSz, TD_boxSz, "CenterCenter", nil, RDR_LOS_root.name)

-- ACM cue
addStrokeText("MPD_FLIR_ACM_cue", "ACM", STROKE_FNT_DFLT_150, "CenterCenter", {0, -350}, operRoot.name, {{"MPD_FLIR_ACM_cue"}})

addStrokeText("MPD_FLIR_SLAVE_Label_A", "S\nL\nA\nV\nE", STROKE_FNT_DFLT_120, "RightCenter", {470, 60}, operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}})
local sideX = 26
local str_raw = "SLAVE"
local sideY = #str_raw * 32
addStrokeBox("MPD_FLIR_SLAVE_Box_A", sideX, sideY, "RightCenter", {476,	60}, operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_AFLIR_SLAVE_Box"}})

-- Pushbuttons
---------------------------------------------------
-- Only Litening PBs
add_PB_label(9, {"SLAVE", rdrOpt_root_L.name, {{"MPD_FLIR_SLAVE_PB", 1}}, {{"MPD_FLIR_SLAVE_PB", 2}}})
add_PB_label(10, {"SIL", rdrOpt_root_L.name, {{"MPD_FLIR_SIL_PB", 1}}, {{"MPD_FLIR_SIL_PB", 2}}})

add_PB_label(11, {"TDC", flirRoot_L.name})

local pb13 = add_PB_label(13, {"     ", operRoot_L.name, {{"MPD_FLIR_VVSL_PB", 1}}, {{"MPD_FLIR_VVSL_Box"}}})[1]
pb13.formats = {"", "V\nV\nS\nL\nV", "R\nR\nS\nL\nV"}

---------------------------------------------------
-- Only ATFLIR PBs
add_PB_label(12, {"L+S", operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}}, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_AFLIR_L_S_Box"}}})
add_PB_label(13, {"BST", operRoot_A.name, {{"MPD_FLIR_SETUP_Label", 0}}, {{"MPD_FLIR_SETUP_Label", 0}, {"MPD_AFLIR_BST_PB_Box"}}})