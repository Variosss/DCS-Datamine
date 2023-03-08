dofile(LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_definitions.lua")

-- The Total Field Of View
local verts

-- 1 - horizontally stretched circle, 2 - rectangular with cut angles
local shapeVariant = 2
	
if shapeVariant == 1 then
	-- 'stretched' along horizontal axis variant

	-- change it to get more smooth (or vice-versa less smooth) shape
	local num_points_in_circle = 32
	
	-- Build TFOV shape vertices
	do
		local step = math.rad(360.0 / num_points_in_circle)

		-- The Total Field Of View has a shape of a circle 'stretched' along horizontal axis,
		--   thus we have each semicircle shifted to left or right from the center by the fixed offset (currently 3 degrees to each side)
		local offsetX = (HMCS_horizontal_sz_mil - HMCS_vertical_sz_mil) / 2

		verts = {}
		
		-- right semicircle
		for pt_idx = 0, num_points_in_circle / 2 do
			verts[pt_idx + 1] = {HMCS_vertical_sz_mil * 0.5 * math.sin(pt_idx * step) + offsetX, HMCS_vertical_sz_mil * 0.5 * math.cos(pt_idx * step)}
		end

		-- left semicircle
		for pt_idx = num_points_in_circle / 2, num_points_in_circle do
			verts[pt_idx + 2] = {HMCS_vertical_sz_mil * 0.5 * math.sin(pt_idx * step) - offsetX, HMCS_vertical_sz_mil * 0.5 * math.cos(pt_idx * step)}
		end
	end
else
	-- rectangle with cut angles variant

	local x_corner_len = 30 -- mils
	local y_corner_len = 30 -- mils
	
	local x_half_sz = HMCS_horizontal_sz_mil / 2
	local y_half_sz = HMCS_vertical_sz_mil / 2
	
	local x_angle_corner = x_half_sz - x_corner_len
	local y_angle_corner = y_half_sz - y_corner_len
	
	verts = {{-x_half_sz, -y_angle_corner}, {-x_half_sz, y_angle_corner},
			 {-x_angle_corner, y_half_sz}, {x_angle_corner, y_half_sz},
			 {x_half_sz, y_angle_corner}, {x_half_sz, -y_angle_corner},
			 {x_angle_corner, -y_half_sz}, {-x_angle_corner, -y_half_sz}}
end

total_field_of_view 				= CreateElement "ceMeshPoly"
total_field_of_view.name 			= "total_field_of_view"
total_field_of_view.primitivetype 	= "triangles"
total_field_of_view.vertices 		= verts
total_field_of_view.indices			= buildConvexPolyIndices(#verts)
total_field_of_view.init_pos		= {0, 0}
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= collimated or false
total_field_of_view.isvisible		= true
total_field_of_view.h_clip_relation = determineClipRelation(h_clip_relations.REWRITE_LEVEL, true)
total_field_of_view.level			= HMCS_DEFAULT_LEVEL

if large_TFOV == true then
	total_field_of_view.material		= "DBG_LIGHT_GREY" --"DBG_RED"
else
	total_field_of_view.material		= "HMCS_TFOV_GREY"
end

Add(total_field_of_view)

-- A debug very large TFOV to display symbology which outside of the 'normal' TFOV
if large_TFOV == true then
	local largeTFOV_x_half_sz = largeTFOV_horizontal_sz_mil * 0.5
	local largeTFOV_y_half_sz = largeTFOV_vertical_sz_mil * 0.5

	local largeTFOV_verts = {{-largeTFOV_x_half_sz, -largeTFOV_y_half_sz},
							{-largeTFOV_x_half_sz, largeTFOV_y_half_sz},
							{largeTFOV_x_half_sz, largeTFOV_y_half_sz},
							{largeTFOV_x_half_sz, -largeTFOV_y_half_sz},}

	largeTFOV 					= CreateElement "ceMeshPoly"
	largeTFOV.name 				= "largeTFOV"
	largeTFOV.primitivetype 	= "triangles"
	largeTFOV.vertices 			= largeTFOV_verts
	largeTFOV.indices			= buildConvexPolyIndices(#largeTFOV_verts)
	largeTFOV.init_pos			= {0, 0}
	largeTFOV.material			= "HMCS_TFOV_GREY"
	largeTFOV.isdraw			= true
	largeTFOV.change_opacity	= false
	largeTFOV.collimated 		= collimated or false
	largeTFOV.isvisible			= false
	largeTFOV.h_clip_relation 	= determineClipRelation(h_clip_relations.REWRITE_LEVEL, true)
	largeTFOV.level				= HMCS_DEFAULT_LEVEL
	Add(largeTFOV)
end

--add_debug_marker("DISPLAY CENTER", {0, 0}, 40)

--------------------------------------------------------------------------------

local dbgRefRadius = HMCS_vertical_sz_mil / 2
local dbgRefGridLineLen = HMCS_horizontal_sz_mil

-- 1 degree step reference grid
--drawIndicatorRefGrid(14, 1 * degToMil, dbgRefGridLineLen, true, dbgRefRadius)

-- 10 mil step reference grid
--drawIndicatorRefGrid(24, 10, dbgRefGridLineLen, true, dbgRefRadius)
