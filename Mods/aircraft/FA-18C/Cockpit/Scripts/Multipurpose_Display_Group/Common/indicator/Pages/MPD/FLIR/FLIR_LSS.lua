dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/FLIR/FLIR_tools.lua")

--
local flirRoot = addPlaceholder("MPD_FLIR_Root", {0,0})
local operPlaceholder = addPlaceholder("MPD_FLIR_OnOff", {0,0}, flirRoot.name, {{"MPD_FLIR_OperPlaceholder", 1}})

---------------------------------------------------
-- VIDEO and other
AddRenderFLIR()
---------------------------------------------------

-- LST tracking
addStrokeText("MPD_FLIR_LST_label", "LST", STROKE_FNT_DFLT_120, "CenterCenter", {00, 400}, operPlaceholder.name, {{"MPD_FLIR_LST_Label"}})

addStrokeText("MPD_FLIR_LSTC_label", "", STROKE_FNT_DFLT_120, "CenterCenter", {171, -450}, operPlaceholder.name, {{"MPD_FLIR_LSTC_label"}}, {"%4d"})

-- Pushbuttons
local pb6 = add_PB_label(6, {"    ", operPlaceholder.name, {{"MPD_FLIR_LSS_Mode"}}})[1]
pb6.formats = {"NSRC", "WSRC"}

add_PB_label(17, {"LST", operPlaceholder.name, nil, {{"MPD_FLIR_LSS_PB", 1}}})
