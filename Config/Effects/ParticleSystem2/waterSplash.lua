Effect = {
	{
		Type = "waterSplash",
		LODdistance = 3000, -- m
		Texture = "normalSemiSphere2.tga",
		TextureFoam = "foam_03.dds",
		--TextureTerrainNoise = "'Bazar\\Effects\\RenderEffects\\Textures\\noise.png'",
		TextureTerrainNoise = "smoke5.dds",
		TextureTerrainNormal = 'ParticleNormalAlphaMap',
		TextureWater = "splashOnWater.png",
		TextureWaterNormal = "splashOnWaterNormal.png",
		ParticlesLimit = 200, --должно быть не меньше 100
		--Terrains_ID = 1,
	},

}

staticEffect = true;