dofile(LockOn_Options.script_path.."Scripts/VHF_Radio/Indicator/Main/defs.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width
local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()


VHF_base					= CreateElement "ceMeshPoly" -- untextured shape
VHF_base.name				= "VHF_ARC182_base"
VHF_base.primitivetype      = "triangles"
VHF_base.material			= VHF_GREEN
VHF_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
VHF_base.level				= VHF_DEFAULT_LEVEL
--VHF_base.collimated		= false
VHF_base.isdraw		        = true
VHF_base.isvisible			= false
VHF_base.z_emable		    = true
VHF_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
VHF_base.indices			= {0, 1, 2, 0, 2, 3}

Add(VHF_base)


