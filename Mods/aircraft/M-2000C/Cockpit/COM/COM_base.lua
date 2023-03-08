local my_path = LockOn_Options.script_path.."COM/"
dofile(my_path.."COM_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

com_base					= CreateElement "ceMeshPoly" -- untextured shape
com_base.name				= "COM"
com_base.material			= MakeMaterial(nil,{255,0,0,50})
com_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
com_base.level				= COM_DEFAULT_LEVEL
com_base.collimated			= false
com_base.isvisible			= false
com_base.z_emable			= true
com_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
com_base.indices			=  {0,1,2 ;  0,2,3 }
Add(com_base)
