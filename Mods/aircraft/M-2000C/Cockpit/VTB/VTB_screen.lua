dofile(LockOn_Options.common_script_path.."elements_defs.lua")

VTB_BASE_LEVEL     = 64
VTB_DEFAULT_LEVEL  = 65

SetScale(1)

local verts = {{-1, 1}, { 1, 1}, { 1,-1}, {-1,-1}}
local inds  = {0, 1, 2, 0, 2, 3}
local texc  = {{0,0}, {1,0}, {1,1} ,{0,1}}

vtb_nofov_base					= CreateElement "ceMeshPoly"
vtb_nofov_base.material			= MakeMaterial(nil,{255,0,0,50})
vtb_nofov_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
vtb_nofov_base.level			= VTB_DEFAULT_LEVEL
vtb_nofov_base.collimated		= false
vtb_nofov_base.isvisible		= false
vtb_nofov_base.z_enable			= false
vtb_nofov_base.vertices			= verts
vtb_nofov_base.indices			= inds
vtb_nofov_base.init_pos       	= {0,0,0}
vtb_nofov_base.controllers		= {{"vtbdisp_cone_enable", 0}}
Add(vtb_nofov_base)

vtb_fov_basebase					= CreateElement "ceMeshPoly"
vtb_fov_basebase.material			= MakeMaterial(nil,{255,0,0,50})
vtb_fov_basebase.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
vtb_fov_basebase.level				= VTB_BASE_LEVEL
vtb_fov_basebase.collimated			= false
vtb_fov_basebase.isvisible			= false
vtb_fov_basebase.z_enable			= false
vtb_fov_basebase.vertices			= verts
vtb_fov_basebase.indices			= inds
vtb_fov_basebase.init_pos       	= {0,0,0}
vtb_fov_basebase.controllers		= {{"vtbdisp_cone_enable", 1}}
Add(vtb_fov_basebase)


local s = 0.75
vtb_fov_mask					= CreateElement "ceMeshPoly"
vtb_fov_mask.name				= "vtb_fov_mask"
vtb_fov_mask.material			= MakeMaterial(nil,{255,0,0,50})
vtb_fov_mask.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
vtb_fov_mask.level				= VTB_BASE_LEVEL
vtb_fov_mask.collimated			= true
vtb_fov_mask.isvisible			= false
vtb_fov_mask.z_enabled	  		= false
vtb_fov_mask.vertices			= { {-s, s, 0}, { s,s, 0}, { s,-s, 0}, {-s,-s, 0}, }
vtb_fov_mask.indices			= {0,1,2 ; 0,2,3 }
vtb_fov_mask.controllers		= {{"vtbdisp_cone"}}
Add(vtb_fov_mask)


local picture				= CreateElement "ceTexPoly"
picture.h_clip_relation 	= h_clip_relations.COMPARE
picture.level				= VTB_DEFAULT_LEVEL
picture.material			= "vtb_baked_image"
picture.vertices			= verts
picture.indices				= inds
picture.tex_coords	 		= texc
picture.additive_alpha  	= true
picture.use_mipfilter   	= true
picture.controllers			= {{"vtbdisp_crt_scale"}}
Add(picture)


vtb_fov_mask					= CreateElement "ceMeshPoly"
vtb_fov_mask.material			= MakeMaterial(nil,{255,0,0,50})
vtb_fov_mask.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
vtb_fov_mask.level				= VTB_BASE_LEVEL
vtb_fov_mask.collimated			= true
vtb_fov_mask.isvisible			= false
vtb_fov_mask.z_enabled	  		= false
vtb_fov_mask.vertices			= verts
vtb_fov_mask.indices			= inds
vtb_fov_mask.controllers		= {{"vtbdisp_cone"}}
Add(vtb_fov_mask)

vtb_fov					= CreateElement "ceTexPoly"
vtb_fov.material		= "vtb_fov_material"
vtb_fov.h_clip_relation	= h_clip_relations.COMPARE
vtb_fov.level			= VTB_DEFAULT_LEVEL
vtb_fov.collimated		= true
vtb_fov.isvisible		= true
vtb_fov.vertices		= verts
vtb_fov.indices			= inds
vtb_fov.tex_coords 		= texc
vtb_fov.use_mipfilter   = true
vtb_fov.additive_alpha  = false
vtb_fov.z_enabled	  	= false
vtb_fov.controllers		= {{"vtbdisp_cone"}}
Add(vtb_fov)


