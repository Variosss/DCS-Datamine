dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)
local sX = 1.6
local sY = 0.8

-- SUN VISOR --





local visor_left			= CreateElement "ceTexPoly"
visor_left.primitivetype	= "triangles"
visor_left.material			= "helmet_sun_visor"
visor_left.vertices			= {{-1.6, -1.2}, {-1.6, 1.2}, { 1.6, 1.2}, { 1.6, -1.2}}
visor_left.indices			= default_box_indices
visor_left.init_pos			= {0,0}
visor_left.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
visor_left.level			= DEFAULT_LEVEL
visor_left.additive_alpha	= false
visor_left.use_mipfilter	= false
visor_left.tex_coords 		= {{-0.3,0.995},{-0.3,0},{1.3,0},{1.3,0.995}}
visor_left.name				= "visor_vr_left"
visor_left.controllers		= {	{"sunvisor", 0} }
Add(visor_left)

local visor_right			= CreateElement "ceTexPoly"
visor_right.primitivetype	= "triangles"
visor_right.material		= "helmet_sun_visor"
visor_right.vertices		= {{-1.6, -1.2}, {-1.6, 1.2}, { 1.6, 1.2}, { 1.6, -1.2}}
visor_right.indices			= default_box_indices
visor_right.init_pos		= {0,0}
visor_right.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
visor_right.level			= DEFAULT_LEVEL
visor_right.additive_alpha	= false
visor_right.use_mipfilter	= false
visor_right.tex_coords 		= {{-0.3,0.995},{-0.3,0},{1.3,0},{1.3,0.995}}
visor_right.name			= "visor_vr_right"
visor_right.controllers		= {	{"sunvisor", 1} }
Add(visor_right)


local visor_novr			= CreateElement "ceTexPoly"
visor_novr.primitivetype	= "triangles"
visor_novr.material			= "helmet_sun_visor"
visor_novr.vertices			= {{-sX, -sY}, {-sX, sY}, { sX, sY}, { sX, -sY}}
visor_novr.indices			= default_box_indices
visor_novr.init_pos			= {0,0}
visor_novr.h_clip_relation	= h_clip_relations.REWRITE_LEVEL
visor_novr.level			= DEFAULT_LEVEL
visor_novr.additive_alpha 	= false
visor_novr.use_mipfilter	= false
visor_novr.tex_coords 		= {{0,0.995},{0,0},{2,0},{2,0.995}}
visor_novr.name				= "visor_novr"
visor_novr.controllers		= {	{"sunvisor", 2} }
Add(visor_novr)