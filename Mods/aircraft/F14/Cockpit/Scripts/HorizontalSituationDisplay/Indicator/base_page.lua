dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/hsd_defs.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width
local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

HSD_base					= CreateElement "ceMeshPoly" -- untextured shape
HSD_base.name				= "HSD_base"
HSD_base.primitivetype = "triangles"
HSD_base.material			= HSD_GREEN
HSD_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
HSD_base.level				= HSD_DEFAULT_LEVEL
--HSD_base.collimated		= false
HSD_base.isdraw		        = true
HSD_base.isvisible			= false
HSD_base.z_emable		= true
HSD_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
HSD_base.indices			= {0, 1, 2, 0, 2, 3}

Add(HSD_base)


