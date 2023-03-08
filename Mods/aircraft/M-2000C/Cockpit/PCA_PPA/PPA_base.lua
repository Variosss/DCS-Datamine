local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PPA_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

ppa_base					= CreateElement "ceMeshPoly" -- untextured shape
ppa_base.name				= "PPA"
ppa_base.material			= MakeMaterial(nil,{255,0,0,50})
ppa_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL  -- check clipping : pixel on glass then increase level from GLASS_LEVEL to GLASS_LEVEL+1 = HUD_DEFAULT_LEVEL
ppa_base.level				= PPA_DEFAULT_LEVEL
ppa_base.collimated			= false
ppa_base.isvisible			= false
ppa_base.z_emable			= true
ppa_base.vertices			= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
ppa_base.indices			=  {0,1,2 ;  0,2,3 }
Add(ppa_base)
