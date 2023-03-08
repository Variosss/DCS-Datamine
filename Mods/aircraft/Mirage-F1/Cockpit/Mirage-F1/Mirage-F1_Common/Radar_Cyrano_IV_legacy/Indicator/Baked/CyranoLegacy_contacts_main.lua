dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

--[[
drawDbgMarkers 					= true
local lineK 					= 10
local dbg_marker 				= add_debug_marker("dbg_marker_r", {0, 0}, dbg_marker_span * lineK, dbg_marker_span * lineK)
if dbg_marker ~= nil then
	dbg_marker.controllers		= {{"DBG_AA_r_cross", 0}} --{{"DBG_AA_r_cross", bake_scale}}
end
--]]
	
--addPlaceholder("radar_contacts", {0, 0}, {{"displayRadarContacts"}, {"radarUpdateContacts"}})
addPlaceholder("radar_contacts", {0, 0}, {{"radarUpdateContacts"}})
