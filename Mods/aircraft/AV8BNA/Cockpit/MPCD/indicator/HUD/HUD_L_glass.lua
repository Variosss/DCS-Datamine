dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."HUD/indicator/HUD_Glass_Levels.lua")

--local mask_material_glass = MakeMaterial(nil,{204,255,204,30}) -- light green
local mask_material_glass = MakeMaterial(nil,{0,0,0,30})

local sc = 1/GetScale()
local function vtx(x_3dmax,y_3dmax,z_3dmax) return {-y_3dmax * sc, z_3dmax * sc, x_3dmax * sc} end

local glass_vertices = {
	vtx(0.6286,	 0.0560, -0.1628),
	vtx(0.6286,	 0.0938, -0.1628),
	vtx(0.4882,	 0.0938, -0.0046),
	vtx(0.4466,	 0.0369,  0.0286),
	vtx(0.4466,	-0.0377,  0.0286),
	vtx(0.4782,	-0.0946, -0.0046),
	vtx(0.6495,	-0.0946, -0.1848),
	vtx(0.6495,	 0.0520, -0.1848),
	vtx(0.6316,	 0.0520, -0.1659),
}

local glass_faces = {
	2, 1, 0,
	5, 4, 3,
	5, 3, 2,
	5, 2, 0,
	8, 7, 6,
	8, 6, 5,
	8, 5, 0,
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
