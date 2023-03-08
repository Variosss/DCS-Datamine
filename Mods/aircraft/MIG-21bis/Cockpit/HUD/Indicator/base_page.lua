dofile(LockOn_Options.script_path.."HUD/Indicator/definitions.lua")

local is_colimated = true
local SHOW_MASKS = false
local GLASS_MAT= MakeMaterial(nil,{255,0,0,255}) 
local FOW_MAT = MakeMaterial(nil,{255,255,0,255}) 

arc_sectors = 16
arc_radius	= 113.44 --/N/ 6.5 deg
half_width	= arc_radius
down_border	=  -113.44 -- /N/ bottom clip border

clip_mesh_verts= {} --20 * 2
clip_mesh_indices= {} --19
clip_mesh_verts[1] = { 0, 0}
clip_mesh_verts[2] = { (-half_width * 0.85) , (down_border * 0.97)}

local ellipse_a = arc_radius  - 15 --/N/ -15 side clip borders
local ellipse_b = arc_radius  - 22 --/N/ -22 top clip border


for i = 0, (arc_sectors - 1) do
	local alpha = math.pi - (math.pi/arc_sectors) * i;
	clip_mesh_verts[#clip_mesh_verts + 1] = {math.cos(alpha) * ellipse_a,
												math.sin(alpha) * ellipse_b}
end
clip_mesh_verts[#clip_mesh_verts + 1] = {(half_width * 0.85) , (down_border * 0.97)}


local number_of_triangles = #clip_mesh_verts - 1

for i = 1,number_of_triangles do

	clip_mesh_indices[3 * (i - 1)+ 1] = 0
	clip_mesh_indices[3 * (i - 1)+ 2] = i
	if i < number_of_triangles then
		clip_mesh_indices[3 * (i - 1)+ 3] = i + 1
	else
		clip_mesh_indices[3 * (i - 1)+ 3] = 1
	end
	
end

glass 			 	 = CreateElement "ceMeshPoly"
glass.name 			 = "glass"
glass.vertices 		 = clip_mesh_verts
glass.indices 		 = clip_mesh_indices
glass.init_pos		 =  {0, -10, 0} --{0, -10, -0.07/GetScale()} 
glass.init_rot		 = {0, 0, -30} 
glass.material		 = GLASS_MAT
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = HUD_NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.isvisible		 = SHOW_MASKS
Add(glass)

--********************************************************

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)
TFOV= 130 - 10
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
total_field_of_view.material		= FOW_MAT
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= is_colimated
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)
