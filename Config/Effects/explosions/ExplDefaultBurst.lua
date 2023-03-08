Explosion = {
	name = 'DefaultBurst',
	flags = {'EF_LIGHTING'},
	system = 'ExplosionBurst',

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

	count = 345,
	spread = 1.0,
	life = 9.0,
	fadeexponent = 4.0,
	startsize = 0.5,
	endsize = 8.0,
	sizeexponent = 1.0,
	startspeed = 100.0,
	endspeed = 4.0,
	speedexponent = 4.0,
	roll = 0.2,
	windfalloff = 1.0,
	streamers = 30,
	speedvar = 100.0,
	dir = {0.0, 0.5, 0.0},
	dirvar = {1.0, 0.5, 1.0},
	posmul = {1.0, 1.0, 1.0},
	dirmul = {1.0, 1.0, 1.0},
}