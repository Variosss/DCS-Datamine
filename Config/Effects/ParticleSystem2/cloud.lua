staticEffect = true
isCloud = true

Effect = {
		{
			Type = "cloud",
			ShadingFX = "ParticleSystem2/cloud.fx",
			UpdateFX  = "ParticleSystem2/cloudComp.fx",
			Technique = "techCloud",

			Texture = "puff_clouds.dds",
			LODdistance = 100000, -- max distance getting from float smCamera_Implement::GetDistance(viFlag mask=viCloud) = 100000  
			EffectRadius = 400.000000,
			ClustersCount = 150,
			ParticlesCount = 1,
			ClusterRadius = 1.600000,
			ParticleSize = 5.000000,
			
			Color = {200/255.0, 225/255.0, 255/255.0},
			
			FixedUpdateDelta = 20 --миллисекунды
			                          
	}
}

