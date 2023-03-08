Effect = {
	{--дымогенератор
		Type = "smokeTrail",
		Texture = "smoke6_nm.dds",
		Tech = "Main",
		LODdistance = 10000, -- m
		
		ScaleBase = 2, -- meters
		
		Lighting = 1,
		
		DetailFactorMax = 5.0, -- max particles in segment = 2^(1+detailFactor). 5 - maximum
		
		Flame = false,
		Nozzle	= false,
		NozzleDir = -1,
		NozzleSpeedMin = 0,
		NozzleSpeedMax = 0,
		
		FadeInRange = 0, -- 0 - not used, or fadeInOpacity = saturate( (curHeight - startHeight) / FadeInRange )
		FadeOutHeight = 99999, --  0 - not used
		
		DissipationFactor = 20.0,
		
		Length = 7000, -- m
		SegmentLength = 60,	-- m
		FadeIn = 0,	-- m
	}
}

Presets =
{

	contrail =
	{	--инверсионный след
		{
			Type = "smokeTrail",
			LODdistance = 20000, -- m
			ScaleBase = 3,
			
			Lighting = 0.5,
			
			DetailFactorMax = 4.0,
			
			Nozzle	= true,
			NozzleSpeedMin = 200,
			NozzleSpeedMax = 400,
			
			FadeInRange = 350,
			FadeOutHeight = 12000,
			
			Length = 12000,	-- m
			SegmentLength = 100, -- m
			FadeIn = 30, -- m
		}
	},
	
	blacktail =
	{	--дымный след
		{
			Type = "smokeTrail",
			LODdistance = 5000,	-- m
			ScaleBase = 2.4,
			Length = 1000,	-- m
		}
	},
	
	chair = 
	{	--дым от катапультного стульчика
		{
			Type = "smokeTrail",
			Tech = "Main",
			Nozzle	= true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			
			Lighting = 0.5,
			
			Flame = true,
			
			ScaleBase = 3,
			
			DissipationFactor = 7.0,
			
			LODdistance = 5000,	-- m
			Length = 100, -- m
			SegmentLength = 10,	-- m
			FadeIn = 1.0, -- m
		}
	},
	
	A2Amissile10000 =
	{	--ракетный дым
		{
			Type = "smokeTrail",
			Tech = "Missile",
			Nozzle = true,
			Flame = true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			Lighting = 0.5,
			ScaleBase = 3.0,
			DissipationFactor = 15.0,
			LODdistance = 15000, -- m
			Length = 10000,	-- m
			SegmentLength = 60,	-- m
			FadeIn = 1.5, -- m
		}
	},
	
	A2Amissile5000 =
	{	--ракетный дым
		{
			Type = "smokeTrail",
			Tech = "Missile",
			Nozzle = true,
			Flame = true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			Lighting = 0.5,
			ScaleBase = 3.0,
			DissipationFactor = 10.0,
			LODdistance = 15000, -- m
			Length = 5000,	-- m
			SegmentLength = 60,	-- m
			FadeIn = 1.5, -- m
		}
	},
	
	A2Amissile2500 =
	{	--ракетный дым
		{
			Type = "smokeTrail",
			Tech = "Missile",
			Nozzle = true,
			Flame = true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			Lighting = 0.5,
			ScaleBase = 3.0,
			DissipationFactor = 6.0,
			LODdistance = 10000, -- m
			Length = 2500,	-- m
			SegmentLength = 60,	-- m
			FadeIn = 1.5, -- m
		}
	},
	
	A2Amissile1000 =
	{	--ракетный дым
		{
			Type = "smokeTrail",
			Tech = "Missile",
			Nozzle = true,
			Flame = true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			Lighting = 0.5,	
			ScaleBase = 3.0,
			DissipationFactor = 2.0,
			LODdistance = 10000, -- m
			Length = 1000,	-- m
			SegmentLength = 60,	-- m
			FadeIn = 1.5, -- m
		}
	},

	A2Amissile10000Afterburner =
	{	--ракетный дым
	{
		Type = "smokeTrail",
		Tech = "Missile",
		Nozzle = true,
		Flame = true,
		NozzleSpeedMin = 300,
		NozzleSpeedMax = 300,
		Lighting = 0.1,
		ScaleBase = 2.0,
		DissipationFactor = 15.0,
		LODdistance = 15000, -- m
		Length = 10000,	-- m
		SegmentLength = 60,	-- m
		FadeIn = 8.5, -- m
		MissileColor = {1.0, 0.67*1.25, 0.45*1.25},
		MissileAlpha = 0.2
	},{
		Type = "afterburner",
		Texture = "afterburner.dds",
		TextureCircle = "afterburner_circle.dds",
		TextureGlow = "flareGlow.dds",
		StuttPower = 5,
		TrailLength = 4,
		TrailScale = 0.25,
		LODdistance1 = 1500,
		LODdistance2 = 8000,
		CircleBrightness = 2,
		WindInfluence = 0.0,
		VolumeBrightness = 11,
		Offset = {0.38, 0.00, 0.0}
	}
		
	},
	
	A2Amissile5000Afterburner =
	{	--ракетный дым
	{
		Type = "smokeTrail",
		Tech = "Missile",
		Nozzle = true,
		Flame = true,
		NozzleSpeedMin = 300,
		NozzleSpeedMax = 300,
		Lighting = 0.5,
		ScaleBase = 3.0,
		DissipationFactor = 10.0,
		LODdistance = 15000, -- m
		Length = 5000,	-- m
		SegmentLength = 60,	-- m
		FadeIn = 1.5, -- m
		MissileColor = {1.0, 0.67*1.25, 0.45*1.25},
		MissileAlpha = 0.2
	}
	,{
		Type = "afterburner",
		Texture = "afterburner.dds",
		TextureCircle = "afterburner_circle.dds",
		TextureGlow = "flareGlow.dds",
		StuttPower = 5,
		TrailLength = 9,
		TrailScale = 0.5,
		LODdistance1 = 1500,
		LODdistance2 = 8000,
		CircleBrightness = 5,
		VolumeBrightness = 3,
		Offset = {0.07, 0.08, 0.0}		}
	},
	
	A2Amissile2500Afterburner =
	{	--ракетный дым
	{
		Type = "smokeTrail",
		Tech = "Missile",
		Nozzle = true,
		Flame = true,
		NozzleSpeedMin = 300,
		NozzleSpeedMax = 300,
		Lighting = 0.5,
		ScaleBase = 3.0,
		DissipationFactor = 6.0,
		LODdistance = 10000, -- m
		Length = 2500,	-- m
		SegmentLength = 60,	-- m
		FadeIn = 1.5, -- m
		MissileColor = {1.0, 0.67*1.25, 0.45*1.25},
		MissileAlpha = 0.2
	}
	,{
		Type = "afterburner",
		Texture = "afterburner.dds",
		TextureCircle = "afterburner_circle.dds",
		TextureGlow = "flareGlow.dds",
		StuttPower = 5,
		TrailLength = 9,
		TrailScale = 0.5,
		CircleBrightness = 5,
		VolumeBrightness = 3,
		LODdistance1 = 1500,
		LODdistance2 = 8000,
		Offset = {0.07, 0.08, 0.0}		}
	},
	
	MissileNoCircleAfterburner =
	{	--ракетный дым
	{
		Type = "smokeTrail",
		Tech = "Missile",
		Nozzle = true,
		Flame = true,
		NozzleSpeedMin = 300,
		NozzleSpeedMax = 300,
		Lighting = 0.2,
		ScaleBase = 2.0,
		DissipationFactor = 6.0,
		LODdistance = 15000, -- m
		Length = 10000,	-- m
		SegmentLength = 100,	-- m
		FadeIn = 10, -- m
		MissileColor = {1.0, 0.67*1.25, 0.45*1.25},
		MissileAlpha = 0.4,
		ColorFadingFactor = 0
	},
	{
		Type = "afterburner",
		Texture = "afterburner.dds",
		TextureCircle = "afterburner_circle.dds",
		TextureGlow = "flareGlow.dds",
		StuttPower = 5,
		TrailLength = 2.5,
		TrailScale = 0.1,
		CircleBrightness = 0.4,
		VolumeBrightness = 8,
		LODdistance1 = 1500,
		LODdistance2 = 8000,
		CircleNumber = 0,
		Offset = {0.38, 0.00, 0.0}
	}
		
	},

	A2Amissile1000Afterburner =
	{	--ракетный дым
	{
		Type = "smokeTrail",
		Tech = "Missile",
		Nozzle = true,
		Flame = true,
		NozzleSpeedMin = 300,
		NozzleSpeedMax = 300,
		Lighting = 0.5,	
		ScaleBase = 3.0,
		DissipationFactor = 2.0,
		LODdistance = 10000, -- m
		Length = 1000,	-- m
		SegmentLength = 60,	-- m
		FadeIn = 1.5, -- m
		MissileColor = {1.0, 0.67*1.25, 0.45*1.25},
		MissileAlpha = 0.2
	}
	,{
		Type = "afterburner",
		Texture = "afterburner.dds",
		TextureCircle = "afterburner_circle.dds",
		TextureGlow = "flareGlow.dds",
		StuttPower = 5,
		TrailLength = 5,
		TrailScale = 0.1,
		CircleBrightness = 5,
		VolumeBrightness = 3,
		LODdistance1 = 1500,
		LODdistance2 = 8000,
		Offset = {0.07, 0.02, 0.0}		}
	},

	markerSmoke = 
	{	
			{--дымогенератор

			Type = "smokeTrail",
			LODdistance = 20000, -- m
			ScaleBase = 3,
			
			Lighting = 0.5,
			
			DetailFactorMax = 5.0,
			
			Nozzle	= true,
			NozzleSpeedMin = 200,
			NozzleSpeedMax = 400,
			
			FadeInRange = 350,
			FadeOutHeight = 12000,
			
			Length = 12000,	-- m
			SegmentLength = 60, -- m
			FadeIn = 30, -- m

			ColorFadingFactor = 0.0
		},
	},

	Torpedo =
	{	
		{

			Type = "smokeTrail",
			Nozzle = true,
			Flame = false,
			UnderWater = true,
			NozzleSpeedMin = 300,
			NozzleSpeedMax = 300,
			DetailFactorMax = 5.0,
			Lighting = 0.5,
			ScaleBase = 0.25,
			DissipationFactor = 5.0,
			LODdistance = 15000, -- m
			Length = 1200,	-- m
			SegmentLength = 20,	-- m
			FadeIn = 100, -- m
			Target = "refraction"
		}
	},

	podSmoke = 
	{	
		{
			Type = "smokeTrail",
			Texture = "smoke6_nm.dds",
			Tech = "Main",
			LODdistance = 10000, -- m
			
			ScaleBase = 2, -- meters
			
			Lighting = 1,
			
			DetailFactorMax = 5.0, 
			
			Flame = false,
			Nozzle	= false,
			NozzleDir = -1,
			NozzleSpeedMin = 0,
			NozzleSpeedMax = 0,
			
			FadeInRange = 0, 
			FadeOutHeight = 99999, 
			
			DissipationFactor = 20.0,
		
			Length = 7000, -- m
			SegmentLength = 60,	-- m
			FadeIn = 0,	-- m
			PodSmoke = true,
		}
	},
}
