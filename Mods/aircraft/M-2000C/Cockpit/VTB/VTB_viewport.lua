dofile(LockOn_Options.common_script_path.."elements_defs.lua")

VTB_DEFAULT_LEVEL  = 65

SetScale(1)

local verts = {{-1, 1}, { 1, 1}, { 1,-1}, {-1,-1}}
local inds  = {0, 1, 2, 0, 2, 3}
local texc  = {{0,0}, {1,0}, {1,1} ,{0,1}}


local hud_only_background			 	= CreateElement "ceMeshPoly"
hud_only_background.h_clip_relation		= h_clip_relations.REWRITE_LEVEL
hud_only_background.level				= VTB_DEFAULT_LEVEL
hud_only_background.material		 	= MakeMaterial("",{0,0,0,192})
hud_only_background.vertices		 	= verts
hud_only_background.indices			 	= inds
hud_only_background.additive_alpha   	= false
Add(hud_only_background)


for i=0,4 do
	local picture				= CreateElement "ceTexPoly"
	picture.name				= "pic"..i
	picture.h_clip_relation 	= h_clip_relations.COMPARE
	picture.level				= VTB_DEFAULT_LEVEL
	picture.material			= "vtb_baked_image"
	picture.vertices			= verts
	picture.indices				= inds
	picture.tex_coords	 		= texc
	picture.additive_alpha  	= true
	picture.use_mipfilter   	= true
	Add(picture)
end



