local hud_path = LockOn_Options.script_path.."HUD/indicator/"

-- Video Output
local szh 	 = 130 * MilToDI(HUD_SCALE)
local szw    = 130 * MilToDI(HUD_SCALE)
local verts  =	{
					{-szw,  szh},
					{ szw,  szh},
					{ szw, -szh},
					{-szw, -szh}
				}

-- VLIR window
local DBG_RED = MakeMaterial(nil, {255,0,0,5})
local VIDEO_GREEN = "HUD_VIDEO_GREEN"
local is_debug = false
local video_mat = "hud_video_output" --MakeMaterial("mfd"..tostring(GetRenderTarget()), {11, 181, 60, 10})

local f_szh		= 115 * MilToDI(HUD_SCALE)
local f_szw		= 130 * MilToDI(HUD_SCALE)
local f_verts	=	{
					{-f_szw,  f_szh},
					{ f_szw,  f_szh},
					{ f_szw, -f_szh},
					{-f_szw, -f_szh}
				}

local flir_render_name = "TV_RENDER"

if hud_repeater then
	if hud_repeater == "L" then
		flir_render_name = "TV_RENDER_LEFT"
	else
		flir_render_name = "TV_RENDER_RIGHT"
	end
end

flir_begin          		= CreateElement "ceMeshPoly"
flir_begin.name	    		= "flir_begin"
flir_begin.vertices			= f_verts
flir_begin.indices			= {0,1,2 ; 0,2,3}
flir_begin.init_pos			= {0, 11.0 * MilToDI(HUD_SCALE), 0}
flir_begin.material			= DBG_RED
flir_begin.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
flir_begin.level	        = HUD_DEFAULT_LEVEL
flir_begin.isvisible	    = is_debug
flir_begin.collimated	    = collimated
flir_begin.z_enabled        = false
Add(flir_begin)


TV_RENDER					= CreateElement "ceTexPoly"
TV_RENDER.name				= flir_render_name
TV_RENDER.init_pos			= {0, 11.0 * MilToDI(HUD_SCALE), 0}
TV_RENDER.vertices			= verts
TV_RENDER.indices			= {0, 1, 2, 0, 2, 3}
TV_RENDER.tex_coords 		= {{0,0}, {1,0}, {1,1}, {0,1}}
TV_RENDER.material			= "render_target_"..tostring(GetRenderTarget() + 1)
TV_RENDER.controllers		= {{"flir_enabled"}}
TV_RENDER.use_mipfilter		= true
TV_RENDER.h_clip_relation	= h_clip_relations.COMPARE
TV_RENDER.level				= HUD_DEFAULT_LEVEL + 1
TV_RENDER.additive_alpha	= ALPHA_BLEND
TV_RENDER.collimated		= collimated
Add(TV_RENDER)

-- Close Heading Tape Region
flir_end                 = CreateElement "ceMeshPoly"
flir_end.name	         = "flir_end"
flir_end.vertices	     = flir_begin.vertices
flir_end.indices	     = flir_begin.indices
flir_end.init_pos	     = flir_begin.init_pos
flir_end.material	     = flir_begin.material
flir_end.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
flir_end.level	         = HUD_DEFAULT_LEVEL + 1
flir_end.isvisible	     = is_debug
flir_end.collimated	     = collimated
flir_end.z_enabled       = false
Add(flir_end)
