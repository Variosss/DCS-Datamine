Explosion = {
	name = 'DefaultMine',
	flags = {'EF_LIGHTING'},
	system = 'ExplosionMine',

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

	count = 125,
	spread = 1.5,
	life = 9.0,
	fadeexponent = 4.0,
	startsize = 1.0,
	endsize = 6.0,
	sizeexponent = 1.0,
	startspeed = 250.0,
	endspeed = 4.0,
	speedexponent = 2.0,
	roll = 0.2,
	windfalloff = 4.0,
	streamers = 1,
	speedvar = 70.0,
	dir = {0.0, 0.8, 0.0},
	dirvar = {0.3, 0.2, 0.3},
	posmul = {1.0, 1.0, 1.0},
	dirmul = {1.0, 1.0, 1.0},
}