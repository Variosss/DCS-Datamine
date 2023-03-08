dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."HUD/HUD_Glass_Levels.lua")

local mask_material_glass	= MakeMaterial(nil,{255,51,204, 128}) -- magenta
--local mask_material_glass	= MakeMaterial(nil,{0,0,0, 128})

local log = require("log")
local sc = 1/GetScale()
local function vtx(x_3dmax,y_3dmax,z_3dmax) return {-y_3dmax * sc, z_3dmax * sc, x_3dmax * sc} end

local glass_vertices = {
	vtx(0.5838,	0.2749,	-0.3983),
	vtx(0.5838,	0.1261,	-0.3983),
	vtx(0.6197,	0.1261,	-0.2530),
	vtx(0.6197,	0.2749,	-0.2530),
}

local glass_faces = {
	0,    1,    2,
	2,    3,    0,
}

glass 				  = CreateElement "ceMeshPoly"
glass.name 			  = "glass"
glass.material		  = mask_material_glass
glass.controllers     = {{"set_origin_to_cockpit_shape"}}
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			  = GLASS_LEVEL
glass.collimated	  = false
glass.isvisible		  = false
glass.vertices		  = glass_vertices
glass.indices		  = glass_faces
Add(glass)



--log.info(string.format("HUD 'Front Left' glass, HUD GLASS LEVEL %f, HUD_SCALE %f", GLASS_LEVEL, HUD_SCALE))