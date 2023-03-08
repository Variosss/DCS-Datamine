Explosion = {
	name = 'ShellOnGround',
	flags = {'EF_LIGHTING'},
	system = 'ExplosionMine',

	Shading = {
		tech = 'Standart',

		noise = 'Bazar\\Effects\\RenderEffects\\Textures\\noise.png',
		normals = 'ParticleNormalAlphaMap',

		color0 = {88/255, 64/255, 51/255},
		color1 = {1, 1, 1},
		colorvariance = 0.5,

		flashcolor = {1.0, 0.8, 0.5}, 
		flashintensity = 10.0,
		flashtime = 0.25,
		flashdistance = 1.0,
	},

	count = 48,
	spread = 2.5,
	life = 3.0,
	fadeexponent = 2,
	startsize = 0.5,
	endsize = 10.0,
	sizeexponent = 1.0,
	startspeed = 250.0,
	endspeed = 4.0,
	speedexponent = 2.0,
	roll = 0.2,
	windfalloff = 4.0,
	streamers = 1,
	speedvar = 25.0,
	dir = {0.0, 0.9, 0.0},
	dirvar = {0.3, 0.2, 0.3},
	posmul = {1.0, 1.0, 1.0},
	dirmul = {1.0, 1.0, 1.0},
}