dofile(LockOn_Options.script_path.."MapDisplay/MapDisplay_defs.lua")

local back = CreateElement "ceTexPoly"
back.material		= MakeMaterial("Mods/aircraft/Mi-24P/Textures/map_temp.dds",{255,255,255,255})
back.name			= "back"
back.vertices		= default_vertices(width, height)
back.indices		= default_indices
back.tex_coords		= default_tex_coords
back.init_pos		= {0,0}
back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
back.level = 1
Add(back)


local map = CreateElement "ceTexPoly"
map.name			= "map"
map.parent_element	= back.name
map.vertices		= default_vertices(width, height)
map.indices			= default_indices
map.tex_coords		= default_tex_coords
map.material		= "render_target_"..string.format("%d", GetRenderTarget() + 1)
map.blend_mode 		= blend_mode.IBM_REGULAR_RGB_ONLY
Add(map)

local pseudoWPT = CreateElement "ceSimple"
pseudoWPT.name = "pseudoWPT"
pseudoWPT.controllers = 
{
	{"pencil", 0}
}
Add(pseudoWPT)

