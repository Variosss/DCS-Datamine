dofile(LockOn_Options.script_path.."ODU/indicator/ODU_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

ODU_base					= CreateElement "ceMeshPoly"
ODU_base.name				= "ODU_DISPLAY"
ODU_base.material			= MakeMaterial(nil,{0,255,0,50})
ODU_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
ODU_base.level				= ODU_DEFAULT_LEVEL
ODU_base.collimated			= false
ODU_base.isvisible			= false
ODU_base.z_emable			= true
ODU_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
ODU_base.indices			=  {0, 1, 2; 0, 2, 3 }
Add(ODU_base)
