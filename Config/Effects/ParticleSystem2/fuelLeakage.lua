Effect = {
	{
		Type = "speedSmoke",		
		Texture = "smoke6_nm.dds",
		Tech = "FuelLeakage",
		BaseColor = {0.1*1.4, 0.12*1.4, 0.14*1.4},
		ParticlesLimit = 800,
		LODdistance = 500,
		
		Radius = 0.05, -- meters
		RadiusMax = 0.1, -- max rotation radius of each particle, m
		ScaleBase = 2.5, --  meters
	
		ScaleJitter = {
			{20, 0.0},
			{100, 1.00},
			{300, 2.5},
			{1000,2}
		},
		ConvectionSpeed = {
			{1, -2.5},
			{5, -3.5}
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
			{0.05, 0.15},
			{20, 0.4},
			{300, 3.0},
			{1000, 4.0},
			{2000, 2.5}
		},
		TrailLength = {
			{1, 10},
			{20, 60},
			{300, 600},
			{1000, 1000},
			{2000, 80}
		}		
	}
}

Presets = {}

Presets.small = deepcopy(Effect)
Presets.small[1].ScaleBase = 1.0

Presets.big = deepcopy(Effect)
Presets.big[1].ScaleBase = 2.5







