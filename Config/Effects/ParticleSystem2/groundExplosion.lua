Effect = {
	{
		Type = "FFX",
		Technique = "techUpdateDefault",
		
		IsShadowCaster = false,		
		IsOriented = false,		
		IsLightControlledByFFX = true,
		
		FXFiles = {
			-- "clusterTestFX",
			-- "clusterTestFX2",
			"groundExplosion_03_01",
			-- "groundExplosion_03_02",
			-- "groundExplosion_03_03",
			-- "groundExplosion_03_04",
			-- "groundExplosion_03_05",
		},
	
		Texture = "puff01.dds",

		EffectSize = 1.0,
		LODdistance1 = 1000,
		LODdistance2 = 10000,
		ZFeather = 0,
		PositionOffset = {0, 0.12, 0},
		LightFlirAmount = 1.5,
		LightFlirLifetime = 1.0,
		LightFlirYOffset = 4.0,
		LightFlirRadius = 8.0,
		
		Light =
		{
			Color = {1, 0.59, 0.1313725},
			Radius = 350.0,
			Lifetime = 0.7,
			Offset = {0, 2.5, 0},
		}
	},
	{
		Type = "groundPuff",
		-- ShadingFX = "ParticleSystem2/groundPuff.fx",
		-- UpdateFX = "ParticleSystem2/groundPuffComp.fx",
		Technique = "techUpdateReal",
		-- TechniqueLighting = "techLightingForFFX",
		Texture = "puff01.dds",
		LODdistance = 10000,
		EffectRadius = 40.000000,
		ClustersCount = 250,
		ParticlesCount = 3,
		ClusterRadius = 1.600000,
		ParticleSize = 5.000000,
		Lifetime = 20.0,
		EffectOpacity = 1.0,
		ZFeather = 0.0,

		Color = {0.600000,0.557000,0.502000},
		
		FixedUpdateDelta = 20, --миллисекунды
		
		PositionOffset = {0, -0.1, 0}
	},
	{
		Type = "blastWave",
		Texture = "blastWave2.dds",
		RadiusMin = 20.0,
		RadiusMax = 140.0,
		Opacity = 0.16,
		WaveSpeed = 340.29,
		PositionOffset = {0, 3, 0},
	},
	{
		Type = "blastWaveRefraction",
		Target = "hotAir",
		RadiusMin = 20.0,
		RadiusMax = 140.0 * 1.5,
		WaveSpeed = 340.29,
		PositionOffset = {0, 3, 0},
		Opacity = 1.0,
	},
	{
		Type = "debris",
		IsTransparentQueue = false,
		
		LODdistance = 1700,
		
		--  mesh file | min instances | max instances
		Metal = {
			-- "barrel01", 0, 5,
			-- "brick01",	4, 20,
			-- "crate01",	0, 5,
			-- "rail01",	1, 7,
			-- "rock01",	2, 20,
			-- "stone01",	0, 3,
			"IronDestruction_V1", 0, 15,
			"IronDestruction_V2", 0, 15,
			"IronDestruction_V3", 0, 15,
			"IronDestruction_V4", 0, 15,
			"IronDestruction_V5", 0, 15,
		},
		Dirt = {
			"Ground_V1", 0, 15,
			"Ground_V2", 0, 15,
			"Ground_V3", 0, 15,
			"Ground_V4", 0, 15,
			"Ground_V5", 0, 15,
		},
		Brick = {
			"Bricks_V1", 0, 15,
			"Bricks_V2", 0, 15,
			"Bricks_V3", 0, 15,
			"Bricks_V4", 0, 15,
		},
		Concrete = {
			"ConcreteDestruction_V1", 0, 10,
			"ConcreteDestruction_V2", 0, 10,
			"ConcreteDestruction_V3", 0, 10,
			"ConcreteDestruction_V4", 0, 10,
			"ConcreteDestruction_V5", 0, 10,
		},
		Wood = {
			"WoodBar_V1", 0, 15,
			"WoodBar_V2", 0, 15,
			"WoodBar_V3", 0, 15,
		},
		Log = {
			"Log_V1", 0, 10,
			"Log_V2", 0, 10,
			"Log_V3", 0, 10,
		},
	},
}

Presets = {}
Presets.hedgehogForIgor = deepcopy(Effect)
Presets.hedgehogForIgor[1] =
{
	Type = "GPUExplosion",
	ShadingFX = "ParticleSystem2/GPUExplosion.fx",
	UpdateFX  = "ParticleSystem2/hedgehogExplosionComp.fx",
	Technique = "techHedgehog",

	Texture = "puff01.dds",
	LODdistance1 = 1500,
	LODdistance2 = 10000,
	ClustersCount = 1000,
	ParticlesCount = 1,
	ClusterRadius = 1.6,
	ParticleSize = 5.0,
	Lifetime = 15.0,
	VertSpeedFactorMax = {2.0, 3.8},

	VariantsCount = 5,

	Color = {120/255.0, 108/255.0, 92/255.0},
	
	FixedUpdateDelta = 20, --миллисекунды
	
	PositionOffset = {0, 0.12, 0},
	
	GlowBillboardSizeMax = 150,
	GlowBillboardBrightness = 0.5,
	GlowBillboardPos = {0, 2, 0},
	GlowPowerOverLive = {{0.0, 0.5},{0.1, 1.0},{0.3, 0.0}},
	
	LightFlirAmount = 1.5,
	LightFlirLifetime = 1.0,
	LightFlirYOffset = 4.0,
	LightFlirRadius = 8.0,

	Light =
	{
		Color = {1, 0.59, 0,1313725},
		Radius = 250.0,
		Lifetime = 0.5,
		Offset = {0, 2.5, 0},
	}
}

-- NAPALM
Presets.napalm = deepcopy(Effect)
Presets.napalm[1] =
{
	Type = "FFX",
	FXFiles = {
		"groundExplosion_napalm",
	},
	LightRadius = 450,
	LightFlirAmount = 1.5,
	LightFlirLifetime = 1.0,
	LightFlirYOffset = 4.0,
	LightFlirRadius = 8.0,
}
Presets.napalm[2].FixedUpdateDelta = 20 --миллисекунды
Presets.napalm[2].Type = "groundPuff"
Presets.napalm[2].Texture = "puff01.dds"
Presets.napalm[2].EffectRadius = 60.000000
Presets.napalm[2].ClustersCount = 250
Presets.napalm[2].ParticlesCount = 2
Presets.napalm[2].ClusterRadius = 2.600000
Presets.napalm[2].ParticleSize = 10.000000
Presets.napalm[2].Color = {0.600000,0.557000,0.502000}
Presets.napalm[3] = {
	Type = "blastWave",
	RadiusMin = 20.0,
	RadiusMax = 190.0,
	WaveSpeed = 340.29,
	Opacity = 0.16,
}
Presets.napalm[4] = {
	Type = "blastWaveRefraction",
	RadiusMin = 20.0,
	RadiusMax = 190.0 * 1.5,
	WaveSpeed = 340.29,
	Opacity = 1.0,
	Target = "hotAir"
}

-- BIG
Presets.big = deepcopy(Effect)
Presets.big[1] = {
	Type = "FFX",
	FXFiles = {
		"groundExplosion_big",
	},
	LightRadius = 450,
	LightFlirAmount = 1.5,
	LightFlirLifetime = 1.0,
	LightFlirYOffset = 4.0,
	LightFlirRadius = 8.0,
}
Presets.big[2].FixedUpdateDelta = 20 --миллисекунды
Presets.big[2].Type = "groundPuff"
Presets.big[2].Texture = "puff01.dds"
Presets.big[2].EffectRadius = 80.000000
Presets.big[2].ClustersCount = 250
Presets.big[2].ParticlesCount = 3
Presets.big[2].ClusterRadius = 2.600000
Presets.big[2].ParticleSize = 10.000000
Presets.big[2].Color = {0.600000,0.557000,0.502000}
Presets.big[3] = {
	Type = "blastWave",
	RadiusMin = 20.0,
	RadiusMax = 240.0,
	WaveSpeed = 340.29,
	Opacity = 0.16,
}
Presets.big[4] = {
	Type = "blastWaveRefraction",
	Target = "hotAir",
	RadiusMin = 20.0,
	RadiusMax = 240.0 * 1.5,
	WaveSpeed = 340.29,
	Opacity = 1.0,
}

-- NAR
Presets.nar = deepcopy(Effect)
Presets.nar[1] = {
	Type = "FFX",
	FXFiles = {
		"groundExplosion_nar",
	},
	LightRadius = 250,
	EffectSize = 1.0,
	LightFlirAmount = 1.5,
	LightFlirLifetime = 1.0,
	LightFlirYOffset = 4.0,
	LightFlirRadius = 8.0,
}
Presets.nar[2] = {
	Type = "groundPuff",
	FixedUpdateDelta = 20, --миллисекунды
	Texture = "puff01.dds",
	EffectRadius = 30.000000,
	ClustersCount = 100,
	ParticlesCount = 3,
	ClusterRadius = 1.600000,
	ParticleSize = 5.000000,
	Color = {0.600000,0.557000,0.502000},
	PositionOffset = {0, -0.1, 0}
}
Presets.nar[3] = {
	Type = "blastWave",
	RadiusMin = 15.0,
	RadiusMax = 100.0,
	WaveSpeed = 340.29,
	Opacity = 0.16,
}
Presets.nar[4] = {
	Type = "blastWaveRefraction",
	RadiusMin = 15.0,
	RadiusMax = 100.0 * 1.5,
	WaveSpeed = 340.29,
	Opacity = 1.0,
	Target = "hotAir"
}
