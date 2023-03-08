Effect = {	
	{
		Type = "flareTrail",
		Texture = "smoke6_nm.dds",
		TextureGlow = "flareGlow.dds",
		GlowOnly = false, -- no trail if true
		LODdistance = 4000, -- m
		Length = 1000,	-- m
		SegmentLength = 30,	-- m
		ScaleBase = 1.4, --  meters
		Lighting = 0.85,
		DetailFactorMax = 5.0, --  max particles in segment = 2^(1+detailFactor). 5 - maximum
		GlowDistFactor = 0.0005, -- glow scale = scale * (1 + GlowDistFactor * depth)
		DifferentGlow = false,
	},
}

Presets =
{
	signalFlare = 
	{--сигнальная ракета
		{
			Type = "flareTrail",
			LODdistance = 2000, -- m
			Length = 200,	-- m
			SegmentLength = 20,	-- m
			ScaleBase = 0.8, --  meters
			GlowDistFactor = 0.0018,
		}
	},
	
	signalFlareGround = 
	{--сигнальная ракета на земле
		{
			Type = "flareTrail",
			GlowOnly = true,
			GlowDistFactor = 0.0018,
		}
	},

	differentGlow = 
	{--сигнальная ракета на земле
		{
			Type = "flareTrail",
			DifferentGlow = true,
		}
	},
}