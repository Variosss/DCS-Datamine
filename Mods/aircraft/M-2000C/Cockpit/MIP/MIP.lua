dofile(LockOn_Options.common_script_path.."elements_defs.lua")

MIP_DEFAULT_LEVEL     = 8

SetScale(FOV)

local aspect       = GetAspect()

mip_base					= CreateElement "ceMeshPoly" -- untextured shape
mip_base.name				= "mip-base"
mip_base.material			= MakeMaterial(nil,{0,0,0,255})
mip_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
mip_base.level				= MIP_DEFAULT_LEVEL
mip_base.collimated			= false
mip_base.isvisible			= false
mip_base.z_enabled			= true
mip_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
mip_base.indices			=  {0,1,2 ;  0,2,3 }
Add(mip_base)


-- ** LEFT LCD ** --
local	mip_name			= CreateElement "ceStringPoly"
mip_name.name				= "mip-name"
mip_name.material			= "mip_label_font"
mip_name.init_pos			= {1.08,-0.1,0.0}
mip_name.alignment			= "RightTop"
mip_name.value				= ""
mip_name.stringdefs			= {0.004,0.003}
mip_name.controllers		= {{"mip_name"}}
mip_name.use_mipfilter    	= true
mip_name.h_clip_relation  	= h_clip_relations.COMPARE
mip_name.additive_alpha  	= false
mip_name.level				= MIP_DEFAULT_LEVEL
mip_name.z_enabled			= true
Add(mip_name)
