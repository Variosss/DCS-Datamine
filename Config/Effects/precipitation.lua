Rain =
{
	particleTexture = "raindropNormBlur3.dds",
	mistTexture = "normalSemiSphere2.tga",


	particlesMax = 1024*4, -- количество частиц в ячейке, кратно 1024
	mistParticlesMax = 256*1*0, -- количество частиц в ячейке, кратно 256
	
	verticalSpeed = {15, 15}, -- мин | макс вертикальная скорость падения капли при слабом дожде, м/с
	
	particlesCellSize = 15, -- размер затайленой ячейки с дождем, м
	particlesVolumeDepth = 4, -- глубина объема частиц, количество ячеек в ребре куба = 2^(particlesVolumeDepth-1), particlesVolumeDepth > 1
	particleJitterFreq = {0.4, 0.4}, -- скорость изменения направления плавания частиц в горизонтальной плоскости, мин | макс
	particleJitterVelocity = {0.045, 0.045}, -- скорость плавания частиц дымки в горизонтальной плоскости, мин | макс
	
	mistCellSize = 200,
	mistVolumeDepth = 3,
	mistJitterFreq = {0.3, 0.3},
	mistJitterVelocity = {2.5, 2.5},
	mistVerticalSpeedFactor = 0.4,
};

Snow =
{
	particleTexture = "normalSemiSphere2.tga",
	mistTexture = "normalSemiSphere2.tga",

	particlesMax = 1024*6,
	mistParticlesMax = 256*2*0,
	
	verticalSpeed = {0.15, 1.1},
	
	particlesCellSize = 15,
	particlesVolumeDepth = 4,
	particleJitterFreq = {0.2, 1},
	particleJitterVelocity = {0.15, 0.3},
	
	mistCellSize = 200,
	mistVolumeDepth = 3,
	mistJitterFreq = {0.3, 0.3},
	mistJitterVelocity = {2.5, 2.5},
	mistVerticalSpeedFactor = 0.4,
};
