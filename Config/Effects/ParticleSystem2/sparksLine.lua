Effect = {	
	{
		Type = "sparksLine",
		Texture = "Spark.dds",
		LODdistance = 800,--эффект виден до этой дистанции
		ParticlesLimit = 300,
		ParticleSize = 0.0125,-- размер частицы
		Lifetime = 1.0,
		LifetimeParticle = 0.3,
		--EmmitedPerDt = 100,
		Light =
		{
			Color = {1, 0.45, 0.09},
			Radius = 5.0,
			Lifetime = 1.0,
			Offset = {0, 0.5, 0}
		}	

	},
}

Presets = {}

Presets.SparksFirstTouch = deepcopy(Effect)
Presets.SparksFirstTouch[1].ParticlesLimit = 500
Presets.SparksFirstTouch[1].ParticleSize = 0.02
Presets.SparksFirstTouch[1].Lifetime = 1.5
Presets.SparksFirstTouch[1].LifetimeParticle = 0.5