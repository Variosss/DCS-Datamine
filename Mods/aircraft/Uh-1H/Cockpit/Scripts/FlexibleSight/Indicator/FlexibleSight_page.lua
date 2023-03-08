dofile(LockOn_Options.script_path.."FlexibleSight/Indicator/FlexibleSight_definitions.lua")

tex_scale_UH1_X = 1.0 / 220.0
tex_scale_UH1_Y = 1.0 / 220.0

fixed_sight = AddHUDFLEXSIGHTTexElement("fixed_sight", 
				{{-101, -101}, {-101, 101}, 
				{101, 101}, {101, -101}},
				{tex_scale_UH1_X * 105, tex_scale_UH1_Y * 106, tex_scale_UH1_X, tex_scale_UH1_Y},
				{{"SightLightness"}},
				{0.0, ZSL, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
fixed_sight.isdraw = true
