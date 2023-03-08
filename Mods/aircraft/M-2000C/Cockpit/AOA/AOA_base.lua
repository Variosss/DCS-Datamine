local my_path = LockOn_Options.script_path.."AOA/"
dofile(my_path.."AOA_definitions.lua")

local hw = 0.011
local hh = 0.04


aoa_base					= CreateElement "ceMeshPoly"
aoa_base.name				= "aoa_base"
aoa_base.material			= MakeMaterial(nil,{0,0,0,255})
aoa_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
aoa_base.level				= AOA_DEFAULT_LEVEL
aoa_base.isvisible			= false
aoa_base.z_enabled			= false
aoa_base.vertices			= { {-hw, hh}, { hw,hh}, { hw,-hh}, {-hw,-hh}, }
aoa_base.indices			=  {0,1,2 ;  0,2,3 }
aoa_base.tex_coords 		= {{0,0},{1,0},{1,1},{0,1}}
aoa_base.controllers			= {{"visible"}}
aoa_base.additive_alpha		= false
Add(aoa_base)


aoa_blk						= CreateElement "ceMeshPoly"
aoa_blk.parent_element		= "aoa_base"
aoa_blk.material			= "BLACK"
aoa_blk.h_clip_relation		= h_clip_relations.COMPARE
aoa_blk.level				= AOA_DEFAULT_LEVEL
aoa_blk.isvisible			= true
aoa_blk.z_enabled			= false
aoa_blk.vertices			= { {0, hh*2}, { hw*0.7,hh*2}, { hw*0.7, 0}, {0, 0}, }
aoa_blk.indices				= {0,1,2 ;  0,2,3 }
aoa_blk.init_pos			= {0, -hh, 0}
aoa_blk.additive_alpha		= false
Add(aoa_blk)

aoa_ndl						= CreateElement "ceMeshPoly"
aoa_ndl.parent_element		= "aoa_base"
aoa_ndl.material			= "SIMPLE_WHITE"
aoa_ndl.h_clip_relation		= h_clip_relations.COMPARE
aoa_ndl.level				= AOA_DEFAULT_LEVEL
aoa_ndl.isvisible			= true
aoa_ndl.z_enabled			= false
aoa_ndl.vertices			= { {0, hh*2}, { hw*0.7,hh*2}, { hw*0.7, 0}, {0, 0}, }
aoa_ndl.indices				= {0,1,2 ;  0,2,3 }
aoa_ndl.controllers			= {{"needle"}}
aoa_ndl.init_pos			= {0, -hh, 0}
aoa_ndl.additive_alpha		= false
Add(aoa_ndl)

aoa_ind						= CreateElement "ceTexPoly"
aoa_ind.parent_element		= "aoa_base"
aoa_ind.material			= "aoa_repeater"
aoa_ind.h_clip_relation		= h_clip_relations.COMPARE
aoa_ind.level				= AOA_DEFAULT_LEVEL
aoa_ind.isvisible			= true
aoa_ind.z_enabled			= false
aoa_ind.vertices			= { {-hw, hh}, { hw,hh}, { hw,-hh}, {-hw,-hh}, }
aoa_ind.indices				=  {0,1,2 ;  0,2,3 }
aoa_ind.tex_coords 			= {{0,0},{1,0},{1,1},{0,1}}
aoa_ind.additive_alpha		= false
Add(aoa_ind)


