dofile(LockOn_Options.script_path.."UFC/indicator/UFC_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect()

UFC_base					= CreateElement "ceMeshPoly"
UFC_base.name				= "UFC_DISPLAY"
UFC_base.material			= MakeMaterial(nil,{0,255,0,50})
UFC_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
UFC_base.level				= UFC_DEFAULT_LEVEL
UFC_base.collimated			= false
UFC_base.isvisible			= false
UFC_base.z_emable			= true
UFC_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
UFC_base.indices			=  {0, 1, 2; 0, 2, 3 }
Add(UFC_base)
