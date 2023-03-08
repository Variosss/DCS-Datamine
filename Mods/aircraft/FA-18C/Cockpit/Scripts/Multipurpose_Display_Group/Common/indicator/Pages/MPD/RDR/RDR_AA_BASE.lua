dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

------------------------------------------------------------------------------
-- Symbology common for AA, non-backup and backup

-- WARNING! Do not add non-backup symbology here

-- 4 in tactical area border
addStrokeBox("Radar_border", tactical_display_sz, tactical_display_sz, "CenterCenter")

-- B sweep line, radar positioned
addStrokeLine("B_sweep", tactical_display_sz + 5, {0, -tactical_display_sz_half}, 0, nil, {{"MPD_RDR_AA_B_SweepPos", tactical_display_sz_half}})

-- Elevation caret, radar positioned
add_RDR_caret("Elevation_caret", {-tactical_display_sz_half, 0}, -90, nil, {{"MPD_RDR_ElevationCaret", tactical_display_sz_half}})

-- targets, radar video signal
addPlaceholder("DBG_AA_targetsKeeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RADAR}})
local TWS_PB_PH = addPlaceholder("TWS_PB", nil, nil, {{"MPD_RDR_TWS_TracksLabelRoot"}})
addPlaceholder("TWS_Tracks_Keeper", nil, TWS_PB_PH.name, {{"MPD_updateMultipleSymbolsBuffer", DYNAMIC_DATA.RDR_TRACKS}})
