dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

-- Radar mode
-- {-511, 335}
local RadarModePlaceholder = addPlaceholder("RadarModePlaceholder", {PB_positions[5][1] + side_PB_shiftX, 335})
addStrokeText("Radar_mode", nil, STROKE_FNT_DFLT_120, "LeftCenter", nil, RadarModePlaceholder.name, {{"MPD_RDR_OperatingMode"}, {"MPD_RDR_AA_RadarModeLayoutShow", 0}},
	{"", "RWS", "VS", "TWS", "MAP", "GMT", "SEA", "TA", "AGR", "PVU", "GACQ", "BST", "VACQ", "WACQ", "HACQ"})
add_X_Over("Radar_mode_X_Over", 66, 24, {glyphNominalWidth120 * 1.5 + fontIntercharDflt120, 0}, RadarModePlaceholder.name, {{"MPD_RDR_OperatingModeFail"}})

addStrokeText("Radar_mode_Layout", "RWS\n\nTWS", PB_TextFont, "CenterCenter", {-470, 305}, nil, {{"MPD_RDR_AA_RadarModeLayoutShow", 1}})

-- Return to search label
addStrokeText("RTS_Label", "RTS", STROKE_FNT_DFLT_120, "LeftCenter", {PB_positions[5][1] + side_PB_shiftX, 365}, nil, {{"MPD_RDR_ReturnToSearchLabel"}})