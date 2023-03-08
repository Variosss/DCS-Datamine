dofile(LockOn_Options.script_path.."RADAR/Indicator/definitions.lua")

local TST   = MakeMaterial(nil,{80,17,7,130}) --200

local SHOW_MASKS = false

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name 		= "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32 --32
step = math.rad(360.0/num_points)
TFOV  = 1
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
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level			= RADAR_DEFAULT_LEVEL
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= false
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)