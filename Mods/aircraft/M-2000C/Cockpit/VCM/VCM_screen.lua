dofile(LockOn_Options.common_script_path.."elements_defs.lua")

VCM_BASE_LEVEL     = 64
VCM_DEFAULT_LEVEL  = 65

SetScale(1)

local verts = {{-1, 1}, { 1, 1}, { 1,-1}, {-1,-1}}
local inds  = {0, 1, 2, 0, 2, 3}
local texc  = {{0,0}, {1,0}, {1,1} ,{0,1}}

vcm_base					= CreateElement "ceMeshPoly"
vcm_base.material			= MakeMaterial(nil,{255,0,0,255})
vcm_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
vcm_base.level				= VCM_DEFAULT_LEVEL
vcm_base.collimated			= false
vcm_base.isvisible			= false
vcm_base.z_enable			= false
vcm_base.vertices			= verts
vcm_base.indices			= inds
vcm_base.init_pos       	= {0,0,0}
Add(vcm_base)

local picture				= CreateElement "ceTexPoly"
picture.h_clip_relation 	= h_clip_relations.COMPARE
picture.level				= VCM_DEFAULT_LEVEL
picture.material			= "vcm_baked_image"
picture.vertices			= verts
picture.indices				= inds
picture.tex_coords	 		= texc
picture.additive_alpha  	= true
picture.use_mipfilter   	= true
picture.controllers			= {{"vcmdisp_crt_scale"}}
Add(picture)

