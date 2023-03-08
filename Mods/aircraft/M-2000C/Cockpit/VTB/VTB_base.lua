local my_path = LockOn_Options.script_path.."VTB/"

dofile(my_path.."VTB_definitions.lua")

local half_width   = 125.0*0.5
local half_height  = 125.0*0.5

vtb_base					= CreateElement "ceMeshPoly" -- untextured shape
vtb_base.name				= "vtb-center"
vtb_base.material			= MakeMaterial(nil,{255,0,0,50})
vtb_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
vtb_base.level				= VTB_BASE_LEVEL
vtb_base.collimated			= false
vtb_base.isvisible			= false
vtb_base.z_enable			= false
vtb_base.vertices			= { {-half_width, half_height}, { half_width,half_height}, { half_width,-half_height}, {-half_width,-half_height}, }
vtb_base.indices			=  {0,1,2 ; 0,2,3 }
vtb_base.init_pos       	= {0,0,0}
Add(vtb_base)

