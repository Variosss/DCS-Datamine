local my_path = LockOn_Options.script_path.."FUEL/"
dofile(my_path.."FUEL_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

fueL_base					= CreateElement "ceMeshPoly" -- untextured shape
fueL_base.name				= "FUEL"
fueL_base.material			= MakeMaterial(nil,{255,0,0,50})
fueL_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
fueL_base.level				= FUEL_DEFAULT_LEVEL
fueL_base.collimated		= false
fueL_base.isvisible			= false
fueL_base.z_emable			= true
fueL_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
fueL_base.indices			=  {0,1,2 ;  -- first triangle
								0,2,3 }  -- second
Add(fueL_base)
