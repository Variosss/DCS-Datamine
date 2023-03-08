Effect = {
	{
		Type = "FFX",
		Technique = "techUpdateDefault",

		IsShadowCaster = false,
		IsOriented = true,
		IsLightControlledByFFX = true,

		EffectSize = 1.0,

		FXFiles = {
			"T90A_shot_exp_b",
		},
		
		Texture = "puff01.dds",

		LODdistance1 = 500,
		LODdistance2 = 5000,
		ZFeather = 0.40,
		PositionOffset = {0, 0.0, 0},
		
		WindInfluence = 0.0,
		
		Light =
		{
			-- Color = {1, 0.59, 0,1313725},
			Color = {1.000000, 0.576470613, 0.13333334},
			Radius = 250.0,
			Lifetime = 0.7,
			Offset = {0, 0.5, 0},
		}
	},
	{
		Type = "blastWaveRefraction",
		Target = "hotAir",
		RadiusMin = 0.0,
		RadiusMax = 25.0,
		WaveSpeed = 340.29 * 0.25,
		Opacity = 1.5,
		PositionOffsetLocal = {2.5, 0, 0},
	},
}

Presets = {}
Presets.MSTA_S = deepcopy(Effect)
Presets.MSTA_S[1].FXFiles = {"T90A_shot_exp_b"}
Presets.MSTA_S[3] = deepcopy(Effect[1])
Presets.MSTA_S[3].FXFiles = {"T90A_shot_exp_b"}
Presets.MSTA_S[3].Orientation = {0,1,0, 3.1415/2}
Presets.MSTA_S[4] = deepcopy(Effect[1])
Presets.MSTA_S[4].FXFiles = {"T90A_shot_exp_b"}
Presets.MSTA_S[4].Orientation = {0,1,0, -3.1415/2}

