-------------------
-- HUD Hot Spots --
-------------------

-- Hot Spots
local i = 0

for i = 1, 8 do
	local	hotspot_mrkr			= CreateElement "ceSMultiLine"
		hotspot_mrkr.name			= "HotSpot_Marker_" .. string.format("%02d", i)
		hotspot_mrkr.material		= stroke_material
		hotspot_mrkr.init_pos		= {0, 4.0 * MilToDI(HUD_SCALE), 0}
		hotspot_mrkr.parent_element	= HUD_center.name
		hotspot_mrkr.points_set		= {"HUD_stroke_symbols", "hot_spot_mrk"}
		hotspot_mrkr.scale			= HUD_SCALE
		hotspot_mrkr.controllers	= {{"Hot_Spot_Pos", i-1, HUD_SCALE}}
	AddHUDStrokeSymbol(hotspot_mrkr)
end