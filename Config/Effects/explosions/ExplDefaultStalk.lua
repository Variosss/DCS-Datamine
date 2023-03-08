Explosion = {
	name = 'DefaultStalk',
	flags = {'EF_LIGHTING'},
	system = 'ExplosionStalk',

	Shading = {
		tech = 'Standart',

		noise = 'Bazar\\Effects\\RenderEffects\\Textures\\noise.png',
		normals = 'ParticleNormalAlphaMap',

		color0 = {0.8, 0.8, 0.8},
		color1 = {0.8, 0.8, 0.8},
		colorvariance = 0.0,

		flashcolor = {1.0, 0.3, 0.05},
		flashintensity = 100.0,
		flashtime = 0.25,
		flashdistance = 1.0,
	},

	count = 500,
	spread = 10.0,
	life = 14.0,
	fadeexponent = 8.0,
	startsize = 0.0,
	endsize = 5.0,
	sizeexponent = 128.0,
	startspeed = 50.0,
	endspeed = -1.0,
	speedexponent = 32.0,
	roll = 0.2,
	windfalloff = 20.0,
	streamers = 1,
	speedvar = 1.0,
	dir = {0.0, 0.0, 0.0},
	dirvar = {0.0, 0.0, 0.0},
	posmul = {1.0, 0.1, 1.0},
	dirmul = {1.0, 0.1, 1.0},
}