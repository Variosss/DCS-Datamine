local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PCA_definitions.lua")

local half_width   = GetScale()
local half_height  = GetAspect() * half_width

local aspect       = GetAspect() -- GetHalfHeight()/GetHalfWidth()

pca_ur_base					= CreateElement "ceMeshPoly" -- untextured shape
pca_ur_base.name			= "PCA_BR"
pca_ur_base.material		= MakeMaterial(nil,{255,0,0,50})
pca_ur_base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
pca_ur_base.level			= PCA_DEFAULT_LEVEL
pca_ur_base.collimated		= false
pca_ur_base.isvisible		= false
pca_ur_base.z_emable		= true
pca_ur_base.vertices		= { {-1, aspect}, { 1,aspect}, { 1,-aspect}, {-1,-aspect}, }
pca_ur_base.indices			=  {0,1,2 ;  0,2,3 }
Add(pca_ur_base)
