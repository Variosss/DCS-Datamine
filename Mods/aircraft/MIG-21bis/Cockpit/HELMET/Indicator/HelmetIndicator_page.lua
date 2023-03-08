dofile(LockOn_Options.common_script_path.."elements_defs.lua")

--local texture_mat  		 = MakeMaterial("rp21.tga",{204,255,0,255})
local orange_mat  		 = MakeMaterial("",{0,20,0,100})

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end


local sizeX = 10.0
local sizeY = 1.0

local totalSizeX = sizeX
local totalSizeY = sizeY

-- ¡¿«¿ -----------------------------------------------------------------------------
base				= CreateElement "ceMeshPoly"
base.name			= "base"
base.primitivetype	= "triangles"
base.material		= orange_mat --texture_mat --orange_mat
base.vertices		= {{-totalSizeX,	-totalSizeY},
                       {-totalSizeX,	totalSizeY}, 
                       { totalSizeX, 	totalSizeY},
                       { totalSizeX, 	-totalSizeY}}        
base.indices		= default_box_indices
--base.state_tex_coords	    = { {0.0, 0.0}, {0.0, 1.0}, {1.0, 0.0}, {1.0, 1.0} }
base.init_pos		= {0,0}
base.controllers	= {{"show"},{"screenspace_position",0,0,0},
                                {"screenspace_position",0,0,0}}
base.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
base.level			= DEFAULT_LEVEL
AddElement(base)