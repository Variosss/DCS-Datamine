dofile(LockOn_Options.common_script_path.."elements_defs.lua")

--local mask_material_glass = MakeMaterial(nil,{204,255,204,30}) -- light green
local mask_material_glass = MakeMaterial(nil,{0,0,0,5})
local GLASS_LEVEL  	  = 10

local sc = 1/GetScale()
local function vtx(x_3dmax,y_3dmax,z_3dmax) return {-y_3dmax * sc, z_3dmax * sc, x_3dmax * sc} end


local glass_vertices = {
	vtx(0.6407,	-0.2557,	-0.3348),
	vtx(0.6408,	-0.1186,	-0.3347),
	vtx(0.6153,	-0.1186,	-0.4656),
	vtx(0.6154,	-0.2559,	-0.4650),
}

local glass_faces = {
	3, 0, 1,
	1, 2, 3,
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
