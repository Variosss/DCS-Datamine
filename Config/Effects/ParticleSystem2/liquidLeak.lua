Effect = {
--[[	{
		Type = "speedSmoke",		
		Texture = "liquid.dds",
		Tech = "LiquidLeakage",
		BaseColor = {0.1, 0.1, 0.13},
		ParticlesLimit = 700,
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
    },]]--
    {
        Type = "liquidAnimationBaking"
    },
    {
		Type = "billboard",
		Texture = "LiquidAnimationNormals", -- normals
		ColorGradientTexture = "LiquidAnimationAlphas", -- alpha
		AthlasSize = {8, 8},

		Visibility = 15000,
		Size = {0.05, 0.05}, -- min|max

		Scale = { -- scale over normalized time
            {0, 1.0},
            {1, 1.0},
		},
		
		Angle = {180.0, 180.0 }, -- min|max
		Opacity = {1.0, 1.0}, -- min|max
		OpacityFading = {0, 0.40}, -- {fadeIn stop, fadeOut start} in percents of lifetime
		Lifetime = {1000000000, 1000000.0}, -- min|max, seconds
		FlamePower = 1.5, -- power
		Flame = { -- flame visibility over time
			{0, 0.5},
			{0.2, 0.9},
			{0.4, 0.0},
		},

		IsSoftParticle = true,
		AnimationLoop = 1,
		AnimationFPSFactor = 1.0/0.03,-- if animation is not looped: frame = framesCount*pow(nnormalizedAge, AnimationFPSFactor); if it's looped: frame = animFPSFactor*emitterTime

		Color = {0.0/255.0, 0.0/255.0, 0.0/255.0, 1.0},
    }
}







