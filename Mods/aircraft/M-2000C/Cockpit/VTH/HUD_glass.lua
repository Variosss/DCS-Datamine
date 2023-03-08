dofile(LockOn_Options.common_script_path.."elements_defs.lua")

--local mask_material_glass = MakeMaterial(nil,{204,255,204,30}) -- light green
local mask_material_glass = MakeMaterial(nil,{0,0,0,30})
local GLASS_LEVEL  	  = 8


local sc = 1/GetScale()
local function vtx(x_3dmax,y_3dmax,z_3dmax) return {-y_3dmax * sc, z_3dmax * sc, x_3dmax * sc} end

local glass_vertices = {
	vtx(0.4385,  0.0000,  0.0500),
	vtx(0.4385, -0.0066,  0.0500),
	vtx(0.4385, -0.0112,  0.0499),
	vtx(0.4387, -0.0146,  0.0497),
	vtx(0.4388, -0.0176,  0.0495),
	vtx(0.4390, -0.0206,  0.0491),
	vtx(0.4393, -0.0239,  0.0486),
	vtx(0.4398, -0.0277,  0.0479),
	vtx(0.4404, -0.0322,  0.0469),
	vtx(0.4412, -0.0370,  0.0457),
	vtx(0.4462, -0.0575,  0.0377),
	vtx(0.4513, -0.0778,  0.0297),
	vtx(0.5093, -0.0778, -0.0615),
	vtx(0.5674, -0.0778, -0.1533),
	vtx(0.5674,  0.0000, -0.1533),
	vtx(0.5674,  0.0779, -0.1533),
	vtx(0.5093,  0.0779, -0.0615),
	vtx(0.4513,  0.0779,  0.0297),
	vtx(0.4462,  0.0576,  0.0377),
	vtx(0.4412,  0.0370,  0.0457),
	vtx(0.4404,  0.0322,  0.0469),
	vtx(0.4398,  0.0277,  0.0479),
	vtx(0.4393,  0.0239,  0.0486),
	vtx(0.4390,  0.0206,  0.0491),
	vtx(0.4388,  0.0176,  0.0495),
	vtx(0.4387,  0.0146,  0.0497),
	vtx(0.4385,  0.0112,  0.0499),
	vtx(0.4385,  0.0067,  0.0500),
}

local glass_faces = {
	 2,  1,  0,
	 4,  3,  2,
	 6,  5,  4,
	 6,  4,  2,
	 8,  7,  6,
	10,  9,  8,
	10,  8,  6,
	12, 11, 10,
	14, 13, 12,
	14, 12, 10,
	14, 10,  6,
	16, 15, 14,
	18, 17, 16,
	18, 16, 14,
	20, 19, 18,
	22, 21, 20,
	22, 20, 18,
	22, 18, 14,
	22, 14,  6,
	24, 23, 22,
	26, 25, 24,
	26, 24, 22,
	26, 22,  6,
	26,  6,  2,
	26,  2,  0,
	27, 26,  0,
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
