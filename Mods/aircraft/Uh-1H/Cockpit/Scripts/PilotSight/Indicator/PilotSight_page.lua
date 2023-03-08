dofile(LockOn_Options.script_path.."PilotSight/Indicator/PilotSight_definitions.lua")

tex_scale_UH1_X = 1.0 / 60.0
tex_scale_UH1_Y = 1.0 / 60.0

tex_size = 28

pilot_sight = AddHUDPILOTSIGHTTexElement("pilot_sight", 
				{{-tex_size, -tex_size}, {-tex_size, tex_size}, 
				{tex_size, tex_size}, {tex_size, -tex_size}},
				{tex_scale_UH1_X * 90, tex_scale_UH1_Y * 90, tex_scale_UH1_X, tex_scale_UH1_Y},
				{{"SightBrightness"}, {"SightDepression", 56.0/1000.0}},
				{0.0, ZSL, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
pilot_sight.isdraw = true
pilot_sight.isvisible	= true