dofile(LockOn_Options.script_path.."Scripts/HeadUpDisplay/Indicator/definitions.lua")

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

glow_glass_mask = CreateElement "ceMeshPoly"
glow_glass_mask.name = "glow_glass_mask"

local glow_glass_maskX = 220
local glow_glass_maskYD = 1200 --315
local glow_glass_maskYU = 350 --315

glow_glass_mask.vertices = {{-glow_glass_maskX, glow_glass_maskYU},
                        { glow_glass_maskX, glow_glass_maskYU},
                        { glow_glass_maskX,-glow_glass_maskYD},
                        {-glow_glass_maskX,-glow_glass_maskYD}}
glow_glass_mask.indices = {0,1,2,0,2,3}
glow_glass_mask.init_pos		= {0, -110, -45}
glow_glass_mask.init_rot		 = {0, 0, -61} 
glow_glass_mask.material		= DBG_RED
glow_glass_mask.level			= HUD_DEFAULT_LEVEL + 1
glow_glass_mask.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glow_glass_mask.isdraw			= true
glow_glass_mask.change_opacity	= false
glow_glass_mask.isvisible		= false
Add(glow_glass_mask)


------ collimated

local grid_origin_collimated = create_origin()

local collimated_scale = 1.4 -- tune this - texture scale
local glow_collimated_size_x = collimated_scale * 175
local glow_collimated_size_y = collimated_scale * 175
local hud_glow_collimated 			= create_textured_box(0,0,256,256,256,256)
    hud_glow_collimated.vertices =  {{-glow_collimated_size_x, glow_collimated_size_y},
                        { glow_collimated_size_x, glow_collimated_size_y},
                        { glow_collimated_size_x,-glow_collimated_size_y},
                        {-glow_collimated_size_x,-glow_collimated_size_y}}
	hud_glow_collimated.name 	= create_guid_string()
	hud_glow_collimated.material = "HUD_GLOW_C"
	hud_glow_collimated.level			= HUD_DEFAULT_LEVEL + 1
	hud_glow_collimated.parent_element = grid_origin_collimated.name
    hud_glow_collimated.isdraw = true
	hud_glow_collimated.controllers = {{"hud_glow_c"}}
	hud_glow_collimated.h_clip_relation = h_clip_relations.COMPARE
	hud_glow_collimated.collimated = true
	hud_glow_collimated.isdraw = true
	hud_glow_collimated.use_mipfilter = true
	hud_glow_collimated.additive_alpha = true
Add(hud_glow_collimated)


------ non-collimated

local grid_origin_non_collimated = CreateElement "ceSimple"
	grid_origin_non_collimated.name = create_guid_string()
	grid_origin_non_collimated.collimated = false
	grid_origin_non_collimated.init_pos = {0, 0, 0}
	grid_origin_non_collimated.controllers = {{"hud_visible"}}

Add(grid_origin_non_collimated)

local non_collimated_scale = 1.025 -- tune this texture scaleto match the normal HUD mask (it's now tuned to match the texture)
local glow_non_collimated_size_x = non_collimated_scale * 175
local glow_non_collimated_size_y = non_collimated_scale * 200
local hud_glow_non_collimated 			= create_textured_box(0,0,256,256,256,256)
    hud_glow_non_collimated.vertices =  {{-glow_non_collimated_size_x, glow_non_collimated_size_y},
                        { glow_non_collimated_size_x, glow_non_collimated_size_y},
                        { glow_non_collimated_size_x,-glow_non_collimated_size_y},
                        {-glow_non_collimated_size_x,-glow_non_collimated_size_y}}
	hud_glow_non_collimated.name 	= create_guid_string()
	hud_glow_non_collimated.init_pos		= {0, -130, 0}
	hud_glow_non_collimated.init_rot		 = {0, 0, -63} 
	hud_glow_non_collimated.material = "HUD_GLOW_NC"
	hud_glow_non_collimated.parent_element = grid_origin_non_collimated.name
    hud_glow_non_collimated.isdraw = true
	hud_glow_non_collimated.use_mipfilter = true
	hud_glow_non_collimated.additive_alpha = true
Add(hud_glow_non_collimated)


