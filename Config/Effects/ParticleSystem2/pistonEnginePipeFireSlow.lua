Effect = {
	{
		Type = "pistonEnginePipeFireSlow",
		Texture = "firePuff_03_low2.dds",
		ParticlesLimit = 500,
		
		Radius = 1.25, -- meters
		ScaleBase = 1.35, --  meters
		
		ConvectionSpeed = { -- speed value by emitter scale
			{1, 3},  
			{5, 12}
		},	
		
		DistMax = {
			{0, 0.05},
			{1, 0.04},
			{10, 0.03}
		},
		
		TrailLength = {
			{0, 2*1.35},
			{2, 2*1.35},
			{10, 1*1.35}
		}
	}
}
