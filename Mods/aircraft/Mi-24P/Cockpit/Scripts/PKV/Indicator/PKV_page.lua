dofile(LockOn_Options.script_path.."PKV/Indicator/PKV_definitions.lua")
dofile(LockOn_Options.common_script_path.."elements_defs.lua")

--drawIndicatorRefGrid(17, 10, 260, true, 170)

local scale = 4.7
tex_scale = 1.0 / 1024.0
tex_size = 1024.0 / 2.0 / scale
AddHUD_PKV_SIGHTTexElement("pkv_grid", 
				{{-tex_size, -tex_size}, {-tex_size, tex_size}, 
				{tex_size, tex_size}, {tex_size, -tex_size}},
				{tex_scale * 512, tex_scale * 512, tex_scale * scale, tex_scale * scale},
				{{"SightBrightness"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)