dofile(LockOn_Options.script_path.."HeadUpDisplay/Indicator/definitions.lua")
local SHOW_MASKS = false
local TST = MakeMaterial(nil,{255,255,0,255}) 
local TST2= MakeMaterial(nil,{255,0,0,255}) 


-- "Binocular" view
num_points = 32*2
step = math.rad(360.0/(num_points/2))
TFOV= 15700.0796326791 -- <-9 degrees 314.1592653582-- <-18 degrees? --1200--120 -- I'll make this huge so it hides that fucking vertice that just dont want to play
verts = {}
local shiftthing = 0--60
for i = 1, (num_points) do
	verts[i] = {(TFOV * math.cos(i * step)) - shiftthing, TFOV * math.sin(i * step)}
end
-- for i = 1, (num_points/2) do
	-- verts[i+(num_points/2)] = {(TFOV * math.cos(i * step)) + shiftthing, TFOV * math.sin(i * step)}
-- end
local sc = 1/GetScale()
local function from_3dmax_vertex(vtx)
	return{-vtx[2] * sc,vtx[3] * sc,vtx[1] * sc}
end



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


-- Glass view
arc_sectors = 16*2;
arc_shift = 0---15;
arc_radius	= 1--105
half_width	= arc_radius
down_border	= -1.5 * arc_radius

clip_mesh_verts= {}
clip_mesh_indices= {}
clip_mesh_verts[1] = { 0, arc_shift}
clip_mesh_verts[2] = { -half_width , down_border}
clip_mesh_verts[3] = { -half_width , arc_shift}

local ellipse_a = arc_radius
local ellipse_b = arc_radius

for i = 1,arc_sectors do
	local alpha = math.pi - (math.pi/arc_sectors) * i;
	clip_mesh_verts[#clip_mesh_verts + 1] = {math.cos(alpha) * ellipse_a,
												math.sin(alpha) * ellipse_b + arc_shift}
end
clip_mesh_verts[#clip_mesh_verts + 1] = {half_width , down_border}

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
glass.name 			 = "glass2"
--glass.vertices 		 = clip_mesh_verts
--glass.indices 		 = clip_mesh_indices

-- ENLIGT VEAO!!!1!!
glass.vertices    ={from_3dmax_vertex({0.5595,	-0.0590,	-0.1223});
from_3dmax_vertex({0.4186,	-0.0604, 0.0188});
from_3dmax_vertex({0.4183,	-0.0602, 0.0191});
from_3dmax_vertex({0.4179,	-0.0599, 0.0195});
from_3dmax_vertex({0.4176,	-0.0595, 0.0198});
from_3dmax_vertex({0.4153,	-0.0533, 0.0219});
from_3dmax_vertex({0.4127,	-0.0457, 0.0241});
from_3dmax_vertex({0.4106,	-0.0381, 0.0259});
from_3dmax_vertex({0.4088,	-0.0305, 0.0274});
from_3dmax_vertex({0.4074,	-0.0229, 0.0286});
from_3dmax_vertex({0.4064,	-0.0153, 0.0294});
from_3dmax_vertex({0.4058,	-0.0077, 0.0299});
from_3dmax_vertex({0.4056,	-0.0001, 0.0300});
from_3dmax_vertex({0.4057,	0.0075,	0.0298});
from_3dmax_vertex({0.4062,	0.0151,	0.0292});
from_3dmax_vertex({0.4071,	0.0227,	0.0283});
from_3dmax_vertex({0.4084,	0.0303,	0.0271});
from_3dmax_vertex({0.4101,	0.0379,	0.0255});
from_3dmax_vertex({0.4121,	0.0455,	0.0236});
from_3dmax_vertex({0.4145,	0.0531,	0.0213});
from_3dmax_vertex({0.4168,	0.0593,	0.0191});
from_3dmax_vertex({0.4170,	0.0597,	0.0188});
from_3dmax_vertex({0.4175,	0.0600,	0.0184});
from_3dmax_vertex({0.4178,	0.0601,	0.0181});
from_3dmax_vertex({0.5586,	0.0615,	-0.1230})}

glass.indices={1,2,3,
3,4,5,
13,14,15,
15,16,17,
17,18,19,
19,20,21,
17,19,21,
21,22,23,
17,21,23,
15,17,23,
13,15,23,
12,13,23,
11,12,23,
10,11,23,
9,10,23,
8,9,23,
7,8,23,
6,7,23,
5,6,23,
3,5,23,
1,3,23,
1,23,24,
1,24,0,
}
-- ^^^EnLIGT VEAO!
--verts = glass.vertices
--inds = glass.indices

-- DENNA HADE JAG KOMMENTAR UT INNAN
glass.controllers     = {{"set_origin_to_cockpit_shape"}}  -- as geometry exported from max is better to render with same origin as cockpit shape
-- ^^^^ Christoffer hack?
glass.init_pos		 = {0, 0, 0}---0.07/GetScale()}
glass.init_rot		 = {0, 0, 0} 
glass.material		 = TST2
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = HUD_NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.isvisible		 = SHOW_MASKS
Add(glass)

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view2"
total_field_of_view.primitivetype = "triangles"



total_field_of_view.vertices 		= verts
total_field_of_view.indices			= inds
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)