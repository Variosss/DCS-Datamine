Effect = {
	{
		Type = "speedSmoke",
		Texture = "smoke5.dds",
		ParticlesLimit = 800,
		LODdistance = 500,
		BaseColor = {0.1*1.4, 0.12*1.4, 0.14*1.4},

		SoftParticle = true,
		Radius = 0.3, -- meters
		RadiusMax = 0.1, -- max rotation radius of each particle, m
		ScaleBase = 2, --  meters
		
		ScaleJitter = {
			{20, 1.2},
			{100, 3.5},
			{1000,5}
		},
		ConvectionSpeed = {
			{1, 3},  
			{5, 4}
		},
		OffsetMax = {
			{20, 0.25},
			{1000, 0.29}
		},
		FrequencyMin = {
			{20, 0.25},
			{1000, 0.7}
		},
		FrequencyJitter = {
			{20, 0.25},
			{1000, 0.2}
		},
		AngleJitter = {
			{20, 0.45},
			{1000, 0.2}
		},
		DistMax	= {
			{3, 0.35},
			{20, 0.95},
			{1000, 3.0},
			{2000, 1.0}
		},
		TrailLength = {
			{1, 20},
			{20, 100},
			{300, 400},
			{1000, 700},
			{2000, 10}
		}
	}
}







