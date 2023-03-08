-- local my_path = LockOn_Options.script_path.."SimpleHUD/Lua/"

-- dofile(my_path.."HUD_definitions.lua")

-- local mask_material_TFOV 			  = MakeMaterial(nil,{255,153,51,30}) -- orange

-- total_field_of_view	 				  = CreateElement "ceMeshPoly" -- untextured shape
-- total_field_of_view.name 			  = "TFOV"
-- total_field_of_view.material		  = mask_material_TFOV
-- total_field_of_view.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
-- total_field_of_view.level			  = GLASS_LEVEL
-- total_field_of_view.collimated	  	  = true   --
-- total_field_of_view.isvisible		  = true  -- by default TFOV is not visible and rendered only to stencil buffer
--TFOV is usuall y circle so :
-- local TFOV_radius  =  120 -- let it be 120 mils

-- num_points = 32
-- step = math.rad(360.0/num_points)

-- local verts = {}
-- for i = 1, num_points do
	-- verts[i] = {TFOV_radius * math.cos(i * step), TFOV_radius * math.sin(i * step)}
-- end

-- local inds = {}
-- j = 0
-- for i = 0, 29 do
	-- j = j + 1
	-- inds[j] = 0
	-- j = j + 1
	-- inds[j] = i + 1
	-- j = j + 1
	-- inds[j] = i + 2
-- end 

-- total_field_of_view.vertices = verts
-- total_field_of_view.indices  = inds
-- Add(total_field_of_view)


dofile(LockOn_Options.script_path.."Data/Indicator/definitions.lua")

local TST  		 = MakeMaterial(nil,{255,255,0,120})
local TST2 		 = MakeMaterial(nil,{255,255,0,120})
local SHOW_MASKS = false

arc_sectors           = 10;
arc_shift             = 10;
arc_radius  	  	  = 200--105
half_width			  = arc_radius
down_border			  =1 * arc_radius

clip_mesh_verts    = {}
clip_mesh_indices  = {}
clip_mesh_verts[1] = { 0, arc_shift}
clip_mesh_verts[2] = { -half_width , down_border}
clip_mesh_verts[3] = { -half_width ,   arc_shift}

local ellipse_a = arc_radius
local ellipse_b = arc_radius  

for i = 1,arc_sectors do
	local alpha        	   				  = math.pi - (math.pi/arc_sectors) * i;
    clip_mesh_verts[#clip_mesh_verts + 1] = {math.cos(alpha) * ellipse_a,
											 math.sin(alpha) * ellipse_b + arc_shift}
end
clip_mesh_verts[#clip_mesh_verts + 1] = {  half_width , down_border}

local number_of_triangles = #clip_mesh_verts - 1

for i = 1,number_of_triangles do

	clip_mesh_indices[3 * (i - 1)  + 1] = 0
	clip_mesh_indices[3 * (i - 1)  + 2] = i
	if i < number_of_triangles then
		clip_mesh_indices[3 * (i - 1)  + 3] = i + 1
	else
		clip_mesh_indices[3 * (i - 1)  + 3] = 1
	end
	
end
local glassradius = 100

glass 			 	 = CreateElement "ceMeshPoly"
glass.name 			 = "glass"
glass.vertices 		 = {{-glassradius*2, glassradius},
				   { glassradius*2, glassradius},
				   { glassradius*2,-glassradius},
				   {-glassradius*2,-glassradius}}
--avfyrningsorder.indices	= {0,1,2,2,3,0}
glass.indices 		 = {0,1,2,2,3,0}
glass.init_pos		 = {0, 0, 0}-- -0.07/GetScale()}
glass.init_rot		 = {0, 0, 0}---43}
glass.material		 = TST2
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = HUD_NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.isvisible		 = SHOW_MASKS
Add(glass)

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)
TFOV  = 330 --155
verts = {}
for i = 1, num_points do
	verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

total_field_of_view.vertices = {{-glassradius*2, glassradius},
				   { glassradius*2, glassradius},
				   { glassradius*2,-glassradius},
				   {-glassradius*2,-glassradius}}
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

total_field_of_view.indices			= {0,1,2,2,3,0}
total_field_of_view.init_pos		= {0, 0, 0}
total_field_of_view.material		= TST
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)