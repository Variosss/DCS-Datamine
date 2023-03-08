Effect = {
	{
		Type = "uh1h_pipeJetFire",
		Texture = "firePuff_05.dds",
		ParticlesLimit = 290,
		
		Lifetime = 2.7,
		RadiusMin = 0.05,
		Radius = 0.18, 	-- meters
		ScaleBase = 0.35, 	-- meters
		Speed = 1.2, -- m/s
		
		DistMax = 0.007,
		TrailLength = {
			{0, 0.1},
			{0.15, 1.0},
			{0.5, 0.4},
			{1.0, 1.0}
		}
	}
}

Presets = 
{
	mi8mtv2 =
	{
		{
			Type = "uh1h_pipeJetFire",
			ParticlesLimit = 70,
			
			Lifetime = 2.7,
			RadiusMin = 0.025,
			Radius = 0.078, 	-- meters
			ScaleBase = 0.22, 	-- meters
			Speed = 0.6, -- m/s
			
			DistMax = 0.006,
			TrailLength = {
				{0, 0.05},
				{0.1, 0.26},
				{0.45, 0.11},
				{1.0, 0.05}
			}
		}
	},

	F18 =
	{
		{
			Type = "uh1h_pipeJetFire",
			ParticlesLimit = 70,

			RadiusMin = 0.01,
			Radius = 0.03, 	-- meters
			ScaleBase = 0.22, 	-- meters
			Speed = 0.6, -- m/s

			DistMax = 0.0065,
			TrailLength = {
				{0, 0.04},
				{0.1, 0.10},
				{0.45, 0.07},
				{1.0, 0.04}
			}
		}
	},
}

Presets.ka50 = deepcopy(Presets.mi8mtv2)
