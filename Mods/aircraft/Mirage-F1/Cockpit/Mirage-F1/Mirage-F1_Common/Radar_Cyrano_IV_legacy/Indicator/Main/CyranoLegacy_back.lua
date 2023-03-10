dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_definitions.lua")

SetScale(METERS)
SetCustomScale(GetScale() * 0.01) -- Centimeters

--[[
do
	local rdr_HUDonly_back						= add_rdr_area(display_area_radius, 64)
	rdr_HUDonly_back.name 			  			= "rdr_HUDonly_back"
	rdr_HUDonly_back.material		  			= "RADAR_BACKGROUND"
	rdr_HUDonly_back.h_clip_relation 			= h_clip_relations.NULL
	--rdr_HUDonly_back.controllers 	 			= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
	Add(rdr_HUDonly_back)
end
--]]

addDisplayMask("radar_display_area_mask")

--drawIndicatorRefGrid(5, 1, 10, false)