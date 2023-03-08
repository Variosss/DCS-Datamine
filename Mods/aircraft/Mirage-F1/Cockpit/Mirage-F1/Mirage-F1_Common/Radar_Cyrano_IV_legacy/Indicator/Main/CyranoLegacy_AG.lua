dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

--local dspl_sz = display_side_sz
--local AG_render_material = "render_target_"..string.format("%d", GetRenderTarget() + 1)
--local AG_render = addStandardRenderTex("AG_render", dspl_sz, dspl_sz, 0.79 / dspl_sz, {0, 0}, AG_render_material, nil, nil)
--AG_render.h_clip_relation = h_clip_relations.NULL
--AG_render.isvisible = false

--drawDbgGeometry 	= true
--drawDbgMarkers  	= true

local scan_line_pos = {0, -display_area_radius + AG_scan_center_shift_y}

local scan_line_brt = 0.75
local scan_line_r = RadarLegacy_GREEN[1] * scan_line_brt
local scan_line_g = RadarLegacy_GREEN[2] * scan_line_brt
local scan_line_b = RadarLegacy_GREEN[3] * scan_line_brt

RdrAddLine("AG_rendered_scan_line", scan_line_shift, scan_line_len, scan_line_tex_params,
	{{"radar_AG_ScanLine", scan_line_r, scan_line_g, scan_line_b}},
	 scan_line_pos, {90})
