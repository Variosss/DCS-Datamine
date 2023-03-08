Effect = {
	{
		Type = "speedSmoke",
		Texture = "smoke6_nm.dds",
		Tech = "Steam",
		
		ParticlesLimit = 100,
		LODdistance = 500,	
		BaseColor = {0.1*1.4, 0.12*1.4, 0.14*1.4},
		Radius = 0.3, -- meters
		RadiusMax = 0.1, -- max rotation radius of each particle, m
		ScaleBase = 2, --  meters
	
		ScaleJitter = {
			{20, 2.2},
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
		DistMax = {
			{3, 0.2},
			{20, 3},
			{1000, 5},
			{2000, 2.5}
		},
		TrailLength = {
			{1, 30},
			{20, 100},
			{300, 300},
			{1000, 80},
			{2000, 60}
		}
	}
}

Presets = {}

Presets.small = deepcopy(Effect)
Presets.small[1].ScaleBase = 1.0

Presets.big = deepcopy(Effect)
Presets.big[1].ScaleBase = 2.0





