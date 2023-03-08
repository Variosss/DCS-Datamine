dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")

local SHOW_MASKS = false

local TFOV				= 175 -- 10degrees

local TST = MakeMaterial(nil,{255,255,0,255}) 

glass = CreateElement "ceMeshPoly"
glass.name = "glass"
glass.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)

local glassX = 140
local glassY = 315

verts = {}
for i = 1, num_points do
	verts[i] = {glassX * math.cos(i * step), glassY * math.sin(i * step)}
end

glass.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

glass.indices			= inds
glass.init_pos		= {0, -130, 0}
glass.init_rot		 = {0, 0, -60}
glass.material		= DBG_GREEN
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			= HUD_NOCLIP_LEVEL
glass.isdraw			= true
glass.change_opacity	= false
glass.isvisible		= SHOW_MASKS
Add(glass)

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)

verts = {}
for i = 1, num_points do
	verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

total_field_of_view.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.indices			= inds
total_field_of_view.init_pos		= {0, -90, 0}
total_field_of_view.init_rot		 = {0, 0, 0} 
total_field_of_view.material		= DBG_RED
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)

