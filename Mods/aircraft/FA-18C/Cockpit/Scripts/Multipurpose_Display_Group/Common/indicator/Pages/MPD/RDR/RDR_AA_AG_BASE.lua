dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")

------------------------------------------------------------------------------
-- Symbology common for AA/AG, non-backup and backup

-- Radar range/velocity search scale
-- maximum range/velocity
addStrokeText("RadarRange_VS_scaleMax", nil, STROKE_FNT_DFLT_120, "LeftTop", {tactical_display_sz_half + 15, tactical_display_sz_half + 6}, nil, {{"MPD_RDR_Range_VS_scaleMaxMin", 0}})
-- minimum range/velocity
addStrokeText("RadarRange_VS_scaleMin", nil, STROKE_FNT_DFLT_120, "RightBottom", {tactical_display_sz_half + 49, -tactical_display_sz_half}, nil, {{"MPD_RDR_Range_VS_scaleMaxMin", 1}})

-- Iron Cross/Large X, radar positioned symbols
local IronCross_LargeX_pos = {-330, -330}
-- Iron cross (Maltese Cross)
local ironCross = addStrokeSymbol("Radar_RF_pwr_stat_Iron_Cross", {"stroke_symbols_MDI_AMPCD", "104-iron-cross"}, "CenterCenter", IronCross_LargeX_pos, nil,
	{{"MPD_RDR_IronCross_LargeX_symbols", 1}})
local flashingIronCross 		= Copy(ironCross)
flashingIronCross.name			= "Radar_RF_pwr_stat_Iron_Cross_flashing"
flashingIronCross.controllers 	= {{"MPD_RDR_IronCross_LargeX_symbols", 2}}
Add(flashingIronCross)
-- Large X
-- TEMP, to change the shape
addStrokeText("Radar_RF_pwr_stat_LargeX", "X", STROKE_FNT_DFLT_200, "CenterCenter", IronCross_LargeX_pos, nil, {{"MPD_RDR_IronCross_LargeX_symbols", 3}})

-- Jammer
addStrokeText("Jammer label", "JAMMER ON", STROKE_FNT_DFLT_200, "CenterCenter", nil, nil, {{"MPD_RDR_JammerOn"}})

--[[
local DBG_enableScanLimitsDisplay = false

if DBG_enableScanLimitsDisplay == true then
	--local  addPlaceholder("DBG_AA_targetsKeeper", nil, nil, {{"MPD_updateMultipleSymbolsBuffer", 0}})
	
end
]]