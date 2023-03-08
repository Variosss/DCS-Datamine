Effect = {
	{
		Type = "landingSmoke",
		Texture = "smoke5.dds",
		ParticlesLimit = 300,
		LODdistance = 400,
		
		Radius = 0.1, -- meters
		ScaleBase = 0.7, --  meters
		ScaleMin = 0.5,
		
		ScaleJitter = {
			{20, 1.2},
			{100, 3.5}
		},
		OffsetMax = {
			{20, 0.25},
			{1000, 0.29}
		},
		DistMax = {
			{1, 0.1},
			{20, 0.6},
		},
		TrailLength = {
			{1, 1},
			{20, 30},
			{500, 40}
		}
	}
}
