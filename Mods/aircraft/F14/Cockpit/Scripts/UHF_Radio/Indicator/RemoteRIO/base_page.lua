dofile(LockOn_Options.script_path.."Scripts/UHF_Radio/Indicator/RemoteRIO/defs.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width
local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()


UHF_base					= CreateElement "ceMeshPoly" -- untextured shape
UHF_base.name				= "UHF_ARC159_base_RIO"
UHF_base.primitivetype      = "triangles"
UHF_base.material			= UHF_GREEN
UHF_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
UHF_base.level				= UHF_DEFAULT_LEVEL
--UHF_base.collimated		= false
UHF_base.isdraw		        = true
UHF_base.isvisible			= false
UHF_base.z_emable		    = true
UHF_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
UHF_base.indices			= {0, 1, 2, 0, 2, 3}

Add(UHF_base)


