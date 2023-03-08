local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_definitions.lua")

local mask_material_TFOV	= MakeMaterial(nil, {0, 255, 0, 5}) -- green
local material_visible		= true

-- First HUD FOV
local TFOV_Name		= "TFOV"
local TFOV_radius	=  170 * MilToDI(HUD_SCALE)	-- mils

if hud_repeater then
	material_visible	= false
	mask_material_TFOV	= MakeMaterial(nil, {0, 255, 0, 10})
	TFOV_Name			= "TFOV_" .. HUD_ID
	TFOV_radius			=  215 * MilToDI(HUD_SCALE)
	
	local log = require("log")
	--log.info(string.format("HUD REPEATER: %s, GLASS LEVEL %f, DEFAULT LEVEL %f, SCALE %f, TFOV %f", HUD_ID, GLASS_LEVEL, HUD_DEFAULT_LEVEL, HUD_SCALE, TFOV_radius))
end

-- Vertices
num_points = 32
step = math.rad(360.0/num_points)

local verts = {}
for i = 1, num_points do
	verts[i] = {TFOV_radius * math.cos(i * step), TFOV_radius * math.sin(i * step)}
end

-- Indexes
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

total_field_of_view						= CreateElement "ceMeshPoly"
total_field_of_view.name				= TFOV_Name
total_field_of_view.material			= mask_material_TFOV
total_field_of_view.h_clip_relation		= h_clip_relations.INCREASE_IF_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
total_field_of_view.level				= GLASS_LEVEL
total_field_of_view.collimated			= true
total_field_of_view.isvisible			= material_visible
total_field_of_view.init_pos			= {0, 0, 0}
total_field_of_view.vertices 			= verts
total_field_of_view.indices  			= inds
Add(total_field_of_view)
