Presets = 
{
	AJS37 =
	{
		{
			Type = "overwingVapor",
			ShadingFX = "ParticleSystem2/overwingVapor.fx",
			UpdateFX  = "ParticleSystem2/overwingVaporComp.fx",
			Technique = "techOverwingVapor",

			Texture = "overwingVapor.dds",
			TextureDetailNoise = "puffNoise.png",
			LODdistance = 1500,

			SpawnLocationsFile = "AJS37_vapor.owv",

			ParticlesCount = 600,
			ParticleSize = 2.7,
			ScaleOverAgeFactor = 1.8, -- scale = ParticleSize * (1 + (normalized age) * ScaleOverAgeFactor)
			
			VaporLengthMax = 15.0, -- meters
			
			AlbedoSRGB = 0.86,
			
			OpacityMax = 0.25,
			OpacityOverPower = {-- vapor power -> normalized opacity. In this case opacity = pow((x-s)/(1-s),N) where N = 1.8 and s = 0.1
				{0.0,	0.0},
				{0.1,	0.0}, -- Curve is offset to avoid the effect being cutoff early because of some internal cutoff on the x-axis.
				{0.2,	0.0192},
				{0.3,	0.0667},
				{0.4,	0.1384},
				{0.5,	0.2323},
				{0.6,	0.3471},
				{0.7,	0.482},
				{0.8,	0.6361},
				{0.9,	0.809},
				{1.0,	1.0},
				
			},
		}
	}
}
