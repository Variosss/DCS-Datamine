dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_definitions.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Radar_Cyrano_IV_legacy_colors.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Radar_Cyrano_IV_legacy_render_cfg.lua")

SetScale(METERS)
SetCustomScale(GetScale() * 0.01) -- centimeters

additive_alpha				= false

boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, 0}, nil, false)

dofile(LockOn_Options.script_path.."../../Common/symbology_tight_tools.lua")

scan_line_shift 			= 0
scan_line_len 				= 10

scal_line_tex_x 			= 21
scal_line_tex_y 			= 76

scan_line_tex_params = getTexParams(scal_line_tex_x, scal_line_tex_y)

scanFrameLevel				= INDICATOR_DEFAULT_LEVEL + 1

function RdrAddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	local element = AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	element.material = "SYMB_LEGACY_RADAR_GREEN"
	return element
end

-- The line zero starts at the left edge. Thus the line is directed to the right by default.
-- center_shift is the distance from the left edge
function RdrAddLine(name, center_shift, length, tex_params, controllers, init_pos, init_rot, level)
	local line_HalfWidth = 0.1 -- centimeters
	
	local verts = {{(-line_HalfWidth - center_shift), -line_HalfWidth},
		{(-line_HalfWidth - center_shift), line_HalfWidth},
		{(length + line_HalfWidth - center_shift), line_HalfWidth},
		{(length + line_HalfWidth - center_shift), -line_HalfWidth}}
		
	return RdrAddTexuredElement(name, verts, tex_params, controllers, init_pos, init_rot, level)
end

local function getRenderVertsAndTexParams(w, h, scale)
	local half_w = w / 2
	local half_h = h / 2

	local verts = {{-half_w,  half_h},
				   { half_w,  half_h},
				   { half_w, -half_h},
				   {-half_w, -half_h}}

	local tex_params = {0.5, 0.5, scale, scale}
	
	return verts, tex_params
end


function addStandardRenderTex(name, w, h, scale, pos, material, parent, controllers)
	
	local verts, tex_params = getRenderVertsAndTexParams(w, h, scale)
	
	local element = AddTexuredElement(name, verts, tex_params, controllers, pos)
	
	if parent ~= nil then
		element.parent = parent
	end
	
	element.material = material
	element.additive_alpha = additive_alpha

	return element
end

function addRadarRenderTex(name, w, h, scale, pos, rot, level, material, parent, controllers)
	
	local verts, tex_params = getRenderVertsAndTexParams(w, h, scale)
	
	local element = CreateElement "RdrTexPoly"
	setTexturedElementProperties(element, name, verts, tex_params, controllers, pos, rot, level)
	Add(element)
	
	if parent ~= nil then
		element.parent = parent
	end
	
	element.material = material
	element.additive_alpha = additive_alpha
	
	return element
end

-- "CopiedTex" class. Not used now.
--[[
function addBuffTex(name, w, h, scale, pos, rot, level, material, parent, controllers)
	
	local verts, tex_params = getRenderVertsAndTexParams(w, h, scale)
	
	local element = CreateElement "CopiedTex"
	setTexturedElementProperties(element, name, verts, tex_params, controllers, pos, rot, level)
	Add(element)
	
	if parent ~= nil then
		element.parent = parent
	end
	
	element.material = material
	element.additive_alpha = additive_alpha

	return element
end
--]]

function makeRangeMarksVerts(w)
		
	local h = display_area_radius
	
	return {{-w, -h}, {-w, h}, {w, h}, {w, -h}}
end

range_mask_margin = -0.03
local rangeMarkTexParams = getTexParams(21, 76)

function addRangeMarks(name_suffix, parent, halfWidth, level)
	
	if level == nil then
		level = INDICATOR_DEFAULT_LEVEL
	end
	
	local function addRangeMarksForRange(range_idx, range, count, step)
		
		local scale = AA_range_vel_zone_half * 2 / range
		
		for i = 1, count do
			local mark =
				RdrAddLine("range_mark_"..i.."_"..range.."NM_"..name_suffix,
				0, halfWidth * 2 + 1, rangeMarkTexParams, {{"radarSelectedRange", range_idx}}, {0, i * step * scale}, nil, level)
			mark.parent_element = parent.name
		end
	
	end
	
	-- 7 NM
	addRangeMarksForRange(0, 7, 3, 2)
	
	-- 15 NM
	addRangeMarksForRange(1, 15, 3, 5)
	
	-- 35 NM
	addRangeMarksForRange(2, 35, 3, 10)
	
	-- 60 NM
	addRangeMarksForRange(3, 60, 6, 10)
end

function addContactShapes(stor_idx, min_idx, max_idx, holder, x_k)

	local function getTexParamsContact(x, y)
		return {x / texture_resolution, y / texture_resolution, tex_scale / x_k, tex_scale}
		--return {x / texture_resolution, y / texture_resolution, tex_scale, tex_scale}
	end

	local contact_shape_width = 0.2234 -- cm
	local contact_shape_height = contact_shape_width

	local contact_shape_half_width = contact_shape_width * 0.8 * x_k
	local contact_shape_half_height = contact_shape_height * 0.5

	local contact_shape_verts = {{-contact_shape_half_width, -contact_shape_half_height},
			{-contact_shape_half_width, contact_shape_half_height},
			{contact_shape_half_width, contact_shape_half_height},
			{contact_shape_half_width, -contact_shape_half_height}}

	local contact_tex_params_step = 21.1135
	local init_coord_x = 21
	local init_coord_y = 97
	
	local max_in_line = 22
	
	local function addContactShape(name, idx, parent, controllers)
		local coord_x
		local coord_y
		
		if idx > max_in_line then
			coord_x = init_coord_x + contact_tex_params_step * (idx - max_in_line - 1)
			coord_y = init_coord_y + contact_tex_params_step
		else
			coord_x = init_coord_x + contact_tex_params_step * idx
			coord_y = init_coord_y
		end
	
		local shape =
			RdrAddTexuredElement(name.."_"..idx, contact_shape_verts,
			--getTexParamsContact(coord_x, coord_y), {{"radarContactShapeNum", stor_idx, idx}, {"radarContactShapeAngle", stor_idx}})
			getTexParamsContact(coord_x, coord_y), controllers)
			
		shape.parent_element = parent.name
		
		return shape
	end
	
	-- contacts
	
	local step = 7
	
	if (max_idx - min_idx + 1 > step) then
	
		local nodes = {}
		local node_idx = 0
	
		local grp_min_idx = 0
		local grp_max_idx = grp_min_idx + step
		
		for i = min_idx, max_idx do
			if i % step == 0 then
				
				grp_min_idx = i
				node_idx = node_idx + 1
				
				if grp_min_idx + step <= max_idx then
					grp_max_idx = grp_min_idx + step
				else
					grp_max_idx = max_idx
				end
		
				nodes[node_idx] = addPlaceholder("radar_contact_grp_placeholder_"..grp_min_idx, nil,
					{{"radarContactShapeNumRange", stor_idx, grp_min_idx, grp_max_idx}})

				nodes[node_idx].parent_element  = holder.name
			end
				
			--drawDbgGeometry 	= true
			--drawDbgMarkers  	= true

			--if node_idx == 1 or node_idx == 2 or node_idx == 3 or node_idx == 4 then
			--if node_idx == 4 then
				if nodes[node_idx] ~= nil then
					addContactShape("radar_contact_shape", i, nodes[node_idx], {{"radarContactShapeNum", stor_idx, i}})
				end
			--end
			
			--drawDbgGeometry 	= false
			--drawDbgMarkers  	= false
		end
		
	else
		
		for i = min_idx, max_idx do
			addContactShape("radar_contact_shape", i, holder, {{"radarContactShapeNum", stor_idx, i}})
		end
		
	end
	
	
	
	-- track
	
	--[[
	local radar_track = addPlaceholder("radar_track", nil, {{"radarTrackPosition", AA_azimuth_zone_half, AA_range_vel_zone_half}})
	
	for i = 23, 27 do
		addContactShape("radar_track_shape", i, radar_track, {{"radarTrackShapeNum", i}})
	end
	--]]
end
