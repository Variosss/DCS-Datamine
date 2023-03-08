Effect = {
	{
		Type = "groundPuff",
		ShadingFX = "ParticleSystem2/groundPuff.fx",
		UpdateFX = "ParticleSystem2/groundPuffComp.fx",
		Technique = "techUpdateDefault",
		-- TechniqueLighting = "techLightingForFFX",
		-- TechniqueLighting = "techLighting",

		Texture = "puff01.dds",

		LODdistance = 10000,

		Lifetime = 20.0,

		Color = {69/255, 67/255, 56/255, 0.8},-- земляной
		-- Color = {38/255, 43/255, 43/255, 0.8},--темно серый
		-- Color = {74/255, 75/255, 69/255, 0.8},
		-- Color = {255/255, 75/255, 69/255, 0.8},
		
		EffectRadius = 10,
		EffectOpacity = 1.0,
		ZFeather = 0.0,

		ClustersCount = 40,
		ClusterRadius = 2, --размер кластера

		ParticlesCount = 3,
		ParticleSize = 15,-- размер частицы
		
		FixedUpdateDelta = 20, --миллисекунды

		ParticlesCount = 3,
		ParticleSize = 15,-- размер частицы

		ClustersCount = 250,
		ParticlesPerCluster = 3,
		ClusterRadius = 1.600000,
		ParticleSize = 5.000000,
		EffectRadius = 40.000000,
		-- Color = {0.400000,0.357000,0.302000},
		Color = {0.600000,0.557000,0.502000},
	},
}

tankShotYOffset = 0 --учитывается в коде, для корректной сортировки пуфика с эффектом вспышки

Presets = {}
Presets.TankShotMedium = deepcopy(Effect)
Presets.TankShotMedium[1].Technique = "techUpdateReal"
Presets.TankShotMedium[1].LODdistance = 3000
Presets.TankShotMedium[1].EffectOpacity = 1.0
Presets.TankShotMedium[1].EffectRadius = 10.000000
Presets.TankShotMedium[1].ClustersCount = 192
Presets.TankShotMedium[1].ParticlesCount = 1
Presets.TankShotMedium[1].ClusterRadius = 0.100000
Presets.TankShotMedium[1].ParticleSize = 1.500000
Presets.TankShotMedium[1].Lifetime = 8.0
Presets.TankShotMedium[1].ZFeather = 0.35
Presets.TankShotMedium[1].Color = {0.600000,0.557000,0.502000}	
Presets.TankShotMedium[1].PositionOffset = {2.0, -2.0, 0}
Presets.TankShotMedium[2] =
{
	Type = "blastWave",
	Texture = "blastWave2.dds",
	RadiusMin = 0.3,
	RadiusMax = 10.0,
	WaveSpeed = 340.29 * 0.25,
	Opacity = 0.07,
	PositionOffsetLocal = {0, tankShotYOffset+0.35, 0},
}

Presets.GroundPuffReal = deepcopy(Effect)
Presets.GroundPuffReal[1].Technique = "techUpdateReal"
Presets.GroundPuffReal[1].LODdistance = 10000
Presets.GroundPuffReal[1].Color = {0.4, 0.357, 0.302, 0.8}
Presets.GroundPuffReal[1].EffectOpacity = 1.0
Presets.GroundPuffReal[1].EffectRadius = 40	
Presets.GroundPuffReal[1].ClustersCount = 250
Presets.GroundPuffReal[1].ClusterRadius = 1
Presets.GroundPuffReal[1].ParticlesCount = 3
Presets.GroundPuffReal[1].ParticleSize = 2	
Presets.GroundPuffReal[1].PositionOffset = {0, -0.1, 0}

Presets.CBU87_103 = deepcopy(Effect)

Presets.CBU97_105 = deepcopy(Effect)
Presets.CBU97_105[1].Technique = "techUpdateCBU97"
Presets.CBU97_105[1].EffectOpacity = 1.0
Presets.CBU97_105[1].EffectRadius = 15
Presets.CBU97_105[1].ClustersCount = 70
Presets.CBU97_105[1].ClusterRadius = 2
Presets.CBU97_105[1].ParticlesCount = 3
Presets.CBU97_105[1].ParticleSize = 15
