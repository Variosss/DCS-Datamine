--**********************
--  EHSD
--  MOVING MAP VIDEO
--**********************
dofile(LockOn_Options.script_path.."MPCD/indicator/MPCD_definitions.lua")
dofile(LockOn_Options.script_path.."MPCD/indicator/MENU/MPCD_BG.lua")

-- Video Output
local szh 	 = GetHalfHeight() * MeterToIn * InToDI()
local szw    = GetHalfWidth() * MeterToIn * InToDI()
local verts  =	{
	{-szw,  szh},
	{ szw,  szh},
	{ szw, -szh},
	{-szw, -szh}
}

local	MMAP_RENDER				= CreateElement "ceTexPoly"
	MMAP_RENDER.name			= "MMAP_RENDER"
	MMAP_RENDER.init_pos		= {0.0, 0.0, 0.0}
	MMAP_RENDER.vertices		= verts
	MMAP_RENDER.indices			= {0, 1, 2, 0, 2, 3}
	MMAP_RENDER.tex_coords 		= {{0, 0},{1, 0},{1, 1},{0, 1}}
	MMAP_RENDER.material		= "render_target_"..tostring(GetRenderTarget() + 1)
	MMAP_RENDER.controllers		= {{"EHSD_MAP_Active"}}
	MMAP_RENDER.use_mipfilter	= true
	MMAP_RENDER.h_clip_relation	= h_clip_relations.COMPARE
	MMAP_RENDER.level			= MPCD_DEFAULT_LEVEL
	MMAP_RENDER.additive_alpha	= true
	MMAP_RENDER.collimated		= false
Add(MMAP_RENDER)

--[[
local	scr_foreground          	= CreateElement "ceMeshPoly"
	scr_foreground.name	    		= "scr_foreground"
	scr_foreground.init_pos			= {0, 0, 0}
	scr_foreground.vertices			= verts
	scr_foreground.indices			= {0,1,2 ; 0,2,3}
	scr_foreground.material			= MakeMaterial(nil, {0,0,0,100})
	scr_foreground.controllers		= {{"EHSD_MAP_Active"}, {"MPCD_Exported"}}
	scr_foreground.use_mipfilter	= true
	scr_foreground.h_clip_relation	= h_clip_relations.COMPARE
	scr_foreground.level			= MPCD_DEFAULT_LEVEL
	scr_foreground.additive_alpha	= true
	scr_foreground.collimated		= false
Add(scr_foreground)

--]]