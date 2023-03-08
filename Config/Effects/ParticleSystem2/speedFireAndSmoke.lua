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
	},
	{
		Type = "speedFire",
		Texture = "firePuff_03_low2.dds",
		ParticlesLimit = 300,
		
		Radius = 1, -- meters
		ScaleBase = 2.0, --  meters
		Power = 8,
		ConvectionSpeed = { -- speed value by emitter scale
			{1, 3},  
			{5, 12}
		},	
		
		DistMax = {
			{5, 0.06},
			{20, 0.1*0.3},
			{1000, 0.65*0.3},
			{2000, 0.8*0.3}
		},
		
		TrailLength = {
			{5, 4},
			{20, 2},
			{500, 1.5},
			{2000, 1.2}
		},
	}
}


Presets = {}

Presets.oilFiring = deepcopy(Effect)
Presets.oilFiring[1].BaseColor = {12.0/255.0, 14.0/255.0, 18.0/255.0}
Presets.oilFiring[1].ScaleBase = 4.0
Presets.oilFiring[1].ScaleJitter = 	{
	{20, 2.0},
	{100, 4.5},
	{1000,7}
}

Presets.wwii_plywood = deepcopy(Effect)
Presets.wwii_plywood[1].ScaleBase = 0.75
Presets.wwii_plywood[1].DistMax = {
    {5, 3},
    {1000, 3},
}
Presets.wwii_plywood[2].ScaleBase = 0.5
Presets.wwii_plywood[2].TrailLength = {
	{5, 4},
	{20, 2},
	{500, 1.5},
	{2000, 1.2}
}
Presets.wwii_plywood[2].DistMax = {
	{5, 0.06},
	{20, 0.1*0.3},
	{1000, 0.65*0.3},
	{2000, 0.8*0.3}
}


