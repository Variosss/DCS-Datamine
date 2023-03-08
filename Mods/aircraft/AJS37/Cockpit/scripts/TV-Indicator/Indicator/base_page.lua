dofile(LockOn_Options.script_path.."TV-Indicator/Indicator/definitions.lua")

local TST  		 = MakeMaterial(nil,{255,255,0,120})
local TST2 		 = MakeMaterial(nil,{255,255,0,120})
local SHOW_MASKS = false
local one_degree = 9.9104250048--16.5454545455
arc_sectors           = 10;
arc_shift             = 10;
arc_radius  	  	  = 500--105
half_width			  = arc_radius
down_border			  =1 * arc_radius

local sc = 1/GetScale()
local function from_3dmax_vertex(vtx)
	return{-vtx[2] * sc,vtx[3] * sc,vtx[1] * sc}
end

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
local glassradius = 50

glass 			 	 = CreateElement "ceMeshPoly"
glass.name 			 = "TVglass"


glass.vertices 		 = {
	from_3dmax_vertex({0.351848602, -0.098026872, -0.077325433});
	from_3dmax_vertex({0.350707054, -0.064657003, -0.098782450});
	from_3dmax_vertex({0.343142718, -0.064943701, -0.106357336});
	from_3dmax_vertex({0.335093737, -0.068463534, -0.112441212});
	from_3dmax_vertex({0.344495356, -0.104206294, -0.081110507});
	from_3dmax_vertex({0.327786565, -0.074656397, -0.116123021});
	from_3dmax_vertex({0.323287696, -0.082812071, -0.116808176});
	from_3dmax_vertex({0.328945041, -0.107763797, -0.094832808});
	from_3dmax_vertex({0.320256174, -0.091210246, -0.114575863});
	from_3dmax_vertex({0.320119858, -0.098874122, -0.109467775});
	from_3dmax_vertex({0.323101819, -0.104653805, -0.102667540});
	from_3dmax_vertex({0.336453259, -0.107616901, -0.087263435});
	from_3dmax_vertex({0.357382536, -0.090018332, -0.076506943});
	from_3dmax_vertex({0.356622994, -0.067677796, -0.090871453});
	from_3dmax_vertex({0.360240042, -0.081417263, -0.078795940})
}


		   
glass.indices 		 = {
0, 1, 2, 
2, 3, 4, 
5, 6, 7, 
8, 9, 10, 
10, 7, 6, 
11, 4, 3, 
0, 12, 1, 
13, 1, 12, 
3, 5, 11, 
8, 10, 6, 
4, 0, 2, 
14, 13, 12, 
5, 7, 11  
}



glass.controllers     = {{"set_origin_to_cockpit_shape"}}  
glass.init_pos		 = {0, 0, 0}-- -0.07/GetScale()}
glass.init_rot		 = {0, 0, 0}---43}
glass.material		 = TST2
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			 = HUD_NOCLIP_LEVEL
glass.isdraw		 = true
glass.change_opacity = false
glass.SHOW_MASKS = true
glass.isvisible		 = SHOW_MASKS
Add(glass)

local mask_material_TFOV 			  = MakeMaterial(nil,{255,255,0,120})

total_field_of_view	 				  = CreateElement "ceMeshPoly" -- untextured shape
total_field_of_view.name 			  = "TVTFOV"
total_field_of_view.material		  = mask_material_TFOV
total_field_of_view.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
total_field_of_view.level			  = HUD_DEFAULT_LEVEL - 1
total_field_of_view.collimated	  	  = false   --
total_field_of_view.isvisible		  = false  -- by default TFOV is not visible and rendered only to stencil buffer
--TFOV is usuall y circle so :
local TFOV_radius  =  one_degree*10--60 -- let it be 120 mils

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

-- local TST  		 = MakeMaterial(nil,{255,255,0,120})
-- local TST2 		 = MakeMaterial(nil,{255,255,0,120})
-- local SHOW_MASKS = true

-- arc_sectors           = 10;
-- arc_shift             = 10;
-- arc_radius  	  	  = 200--105
-- half_width			  = arc_radius
-- down_border			  =1 * arc_radius

-- clip_mesh_verts    = {}
-- clip_mesh_indices  = {}
-- clip_mesh_verts[1] = { 0, arc_shift}
-- clip_mesh_verts[2] = { -half_width , down_border}
-- clip_mesh_verts[3] = { -half_width ,   arc_shift}

-- local ellipse_a = arc_radius
-- local ellipse_b = arc_radius  

-- for i = 1,arc_sectors do
	-- local alpha        	   				  = math.pi - (math.pi/arc_sectors) * i;
    -- clip_mesh_verts[#clip_mesh_verts + 1] = {math.cos(alpha) * ellipse_a,
											 -- math.sin(alpha) * ellipse_b + arc_shift}
-- end
-- clip_mesh_verts[#clip_mesh_verts + 1] = {  half_width , down_border}

-- local number_of_triangles = #clip_mesh_verts - 1

-- for i = 1,number_of_triangles do

	-- clip_mesh_indices[3 * (i - 1)  + 1] = 0
	-- clip_mesh_indices[3 * (i - 1)  + 2] = i
	-- if i < number_of_triangles then
		-- clip_mesh_indices[3 * (i - 1)  + 3] = i + 1
	-- else
		-- clip_mesh_indices[3 * (i - 1)  + 3] = 1
	-- end
	
-- end
-- local glassradius = 100

-- glass 			 	 = CreateElement "ceMeshPoly"
-- glass.name 			 = "glass"
-- glass.vertices 		 = {{-glassradius*2, glassradius},
				   -- { glassradius*2, glassradius},
				   -- { glassradius*2,-glassradius},
				   -- {-glassradius*2,-glassradius}}
--avfyrningsorder.indices	= {0,1,2,2,3,0}
-- glass.indices 		 = {0,1,2,2,3,0}
-- glass.init_pos		 = {0, 0, 0}-- -0.07/GetScale()}
-- glass.init_rot		 = {0, 0, 0}---43}
-- glass.material		 = TST2
-- glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
-- glass.level			 = HUD_NOCLIP_LEVEL
-- glass.isdraw		 = true
-- glass.change_opacity = false
-- glass.isvisible		 = SHOW_MASKS
-- Add(glass)

-- total_field_of_view = CreateElement "ceMeshPoly"
-- total_field_of_view.name = "total_field_of_view"
-- total_field_of_view.primitivetype = "triangles"

-- num_points = 32
-- step = math.rad(360.0/num_points)
-- TFOV  = 330 --155
-- verts = {}
-- for i = 1, num_points do
	-- verts[i] = {TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
-- end

-- total_field_of_view.vertices = {{-glassradius*2, glassradius},
				   -- { glassradius*2, glassradius},
				   -- { glassradius*2,-glassradius},
				   -- {-glassradius*2,-glassradius}}
-- inds = {}
-- j = 0
-- for i = 0, 29 do
	-- j = j + 1
	-- inds[j] = 0
	-- j = j + 1
	-- inds[j] = i + 1
	-- j = j + 1
	-- inds[j] = i + 2
-- end

-- total_field_of_view.indices			= {0,1,2,2,3,0}
-- total_field_of_view.init_pos		= {0, 0, 0}
-- total_field_of_view.material		= TST
-- total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
-- total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
-- total_field_of_view.change_opacity	= false
-- total_field_of_view.collimated 		= true
-- total_field_of_view.isvisible		= SHOW_MASKS
-- Add(total_field_of_view)