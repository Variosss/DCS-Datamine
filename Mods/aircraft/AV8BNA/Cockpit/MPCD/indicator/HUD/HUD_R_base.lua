local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_definitions.lua")

--local mask_material_TFOV 			  = MakeMaterial(nil,{204,255,204,25}) -- light green
local mask_material_TFOV = MakeMaterial(nil,{255,51,204,105}) -- magenta

-- First HUD FOV

total_field_of_view	 				  = CreateElement "ceMeshPoly"
total_field_of_view.name 			  = "TFOV"
total_field_of_view.material		  = mask_material_TFOV
total_field_of_view.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
total_field_of_view.level			  = GLASS_LEVEL
total_field_of_view.collimated	  	  = true
total_field_of_view.isvisible		  = false
total_field_of_view.init_pos		  = {0, 0, 0}

local TFOV_radius  =  191	-- mils

num_points = 32
step = math.rad(360.0/num_points)

local verts = {}
for i = 1, num_points do
	verts[i] = {TFOV_radius * math.cos(i * step), TFOV_radius * math.sin(i * step)}
end

local inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.vertices = verts
total_field_of_view.indices  = inds
Add(total_field_of_view)

-- Second HUD FOV
--[[
local TFOV_radius2  =  191 -- mils

total_field_of_view2	 			  = CreateElement "ceMeshPoly"
total_field_of_view2.name 			  = "TFOV2"
total_field_of_view2.material		  = mask_material_TFOV
total_field_of_view2.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view2.level			  = GLASS_LEVEL
total_field_of_view2.collimated	  	  = true
total_field_of_view2.isvisible		  = true
total_field_of_view2.init_pos		  = {0,-80,0}

num_points = 32
step = math.rad(360.0/num_points)

local verts = {}
for i = 1, num_points do
	verts[i] = {TFOV_radius2 * math.cos(i * step), TFOV_radius2 * math.sin(i * step)}
end

local inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view2.vertices = verts
total_field_of_view2.indices  = inds
Add(total_field_of_view2)
]]
