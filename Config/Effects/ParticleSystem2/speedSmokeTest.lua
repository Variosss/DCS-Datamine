Effect = {
	{
		Type = "speedSmokeTest",		
		Texture = "fire.png",
		TextureSmoke = "puff01.dds",
		TextureSmokeGradient = "fireGradient02.dds",
		BaseColor = {90/255.0*1.8, 90/255.0*1.8, 90/255.0*1.8},
		MaxParticlesFire =1000,
		MaxParticlesSmoke = 1200,
		ParticlesLimit = 2200,
		LODdistance = 500*500,
		Opacity = 1.0,
		NormalImportance = 0.65, 
		SmokeOffsetFactor = 1.0,
		SpawnRadius = 0.1,
		Radius = 0.3, -- meters
		RadiusMax = 0.1, -- max rotation radius of each particle, m
		SmokeScaleBase = 2.8*0.5, --  meters
		FireScaleBase = 3.5*0.4,
		LightScattering = 0.4,
		ConvectionSpeed = {
			{1, 3},  
			{5, 4}
		},			
		OffsetMax = {
			{20, 0.1},
			{1000, 0.29}
		},			
		FrequencyMin = {
			{20, 0.25},
			{1000, 0.7}
		},			
		FrequencyJitter = {
			{20, 0.25},
			{1000, 0.2}
		},		
		AngleJitter = {
			{20, 0.45},
			{1000, 0.2}
		},	
		
		SmokeOffset = {
			{0, 0.0},
			{50, 0.0},
			{75, 6.0}
		},

		FireScaleBaseFactor = {
			{0, 1.35},
			{50, 1.45},
			{75, 1.0},
			{100, 1.0}
		},

		SmokeScaleJitter = {
			{0, 0.5*0.7*1},
			{20, 0.5*0.7*1.75},
			{40, 3.5*0.7*1.75*1.5},
			{100, 3.5*0.7*1.75*1.5*1.75},
			{200, 5.0*0.7*1.75*1.75},
			{500, 5*0.7*1.75*1.25*1.75},
			{1000,7*0.7*1.75*1.4*1.75}
		},

		SmokeDistMax = {			
			{0, 0.75*0.25*0.25*1.5*5},
			{3, 0.75*0.25*0.25*1.5*3},
			{20, 0.75*0.25*0.25*1.5*2.5},
			{100, 0.75*0.25*0.75*1.5*1.5*0.75},
			{300, 0.75*0.75*0.75*1.5*0.75},
			{1000, 0.75*0.75*1.5*0.75},
			{2000, 0.75*1.5*0.75}
		},
		SmokeTrailLength = {
			{6, 55*3.8},
			{20, 90*3.6},
			{300, 400*2*3.5},
			{1000, 700*2*3.2},
			{2000, 10*2*3}
		},
		
		FireScaleJitter = {
			{20, 1.0*0.01},
			{50, 1.0*0.01},
			{75,3.0*0.7*0.25},
			{100,3.0*0.7*0.25},
			{200,3.5*0.7*0.45},
			{500,4.0*0.52},
			{1000,4.75*0.52}
		},
		FireDistMax = {			
			{20, 0.95*0.28*0.2*1.75},
			{1000, 3.0*0.4*0.3*1.75},
			{2000, 1.0*0.4*0.3*1.75}
		},
		FireTrailLength = {
			{6, 20*5*0.3},
			{20, 70*2.5*0.3*0.5*0.3},
			{300, 350*1.5*0.65},
			{1000, 480*1.5*0.65},
			{2000, 600*1.5*0.65}
		},
		Light =
		{
			Color = {1, 0.45, 0,09},
			Radius = 100.0,
			Lifetime = 1000.0,
			Offset = {0, 0.5, 0}
		}		
	}
}
 
Presets = {}

Presets.big = deepcopy(Effect)
Presets.big[1].SmokeScaleBase = Presets.big[1].SmokeScaleBase*1.5
Presets.big[1].FireScaleBase = Presets.big[1].FireScaleBase*1.5
Presets.big[1].MaxParticlesFire = 200
Presets.big[1].LightScattering = 0.75


Presets.small = deepcopy(Effect)
Presets.small[1].SmokeScaleBase = Presets.small[1].SmokeScaleBase/1.5
Presets.small[1].FireScaleBase = Presets.small[1].FireScaleBase/1.5

Presets.fire = deepcopy(Effect)
Presets.fire[1].MaxParticlesSmoke = 0
Presets.fire[1].MaxParticlesFire = 300
Presets.smoke = deepcopy(Effect)
Presets.smoke[1].MaxParticlesFire = 0
Presets.smoke[1].LightScattering = 0
Presets.smoke[1].Light.Lifetime = 0.0

Presets.smokeZone = deepcopy(Presets.smoke)
Presets.smokeZone[1].SpawnRadius = 1.5
Presets.smokeZone[1].Opacity = 0.45 
Presets.smokeZone[1].NormalImportance = 0.4
Presets.smokeZone[1].SmokeScaleBase = 2.8*1.35
Presets.smokeZone[1].FireScaleBase = 3.5*1.35


Presets.transparent = deepcopy(Effect)
Presets.transparent[1].Opacity = 0.005

Presets.transparent[1].SmokeScaleBase = Presets.transparent[1].SmokeScaleBase*2.5


Presets.smokeZoneSmall = deepcopy(Presets.smokeZone)
Presets.smokeZoneSmall[1].SmokeScaleBase = 1.0
Presets.smokeZoneSmall[1].FireScaleBase = 0.7

Presets.grey = deepcopy(Effect)
Presets.grey[1].Opacity = 0.05

Presets.blackBlue = deepcopy(Effect)
Presets.blackBlue[1].BaseColor = {61/255.0*1.2, 70/255.0*1.2, 80/255.0*1.2}
Presets.blackBlue[1].NormalImportance = 0.6
Presets.blackBlue[1].SpawnRadius = 1.0
Presets.blackBlue[1].DistMaxFactorFire = 1000.0
Presets.blackBlue[1].DistMaxFactorSmoke = 1500.0
Presets.blackBlue[1].FirePower = 0.75
Presets.blackBlue[1].SmokeScaleBase = Presets.blackBlue[1].SmokeScaleBase*1.25
Presets.blackBlue[1].FireScaleBase = Presets.blackBlue[1].FireScaleBase*1.25
Presets.blackBlue[1].ScaleJitterFactorFire = 2.0
Presets.blackBlue[1].SmokeOffsetFactor = 0


Presets.black = deepcopy(Effect)
Presets.black[1].BaseColor = {75/255, 75/255, 75/255}
Presets.black[1].NormalImportance = 0.8

Presets.greyBig = deepcopy(Presets.big)
Presets.greyBig[1].Opacity = 0.05

Presets.greySmall = deepcopy(Presets.small)
Presets.greySmall[1].Opacity = 0.05

Presets.greySmoke = deepcopy(Presets.smoke)
Presets.greySmoke[1].Opacity = 0.05

Presets.benzin = deepcopy(Effect)
Presets.benzin[1].FireTrailLength = {
	{6, 20*5*0.5},
	{20, 70*2.5*0.3*0.5},
	{300, 350*1.5*0.5},
	{1000, 480*1.5*0.5},
	{2000, 600*1.5*0.5}
}
Presets.benzin[1].SmokeDistMax = {			
	{3, 0.75*0.25*0.25*1.5},
	{20, 0.75*0.25*0.25*1.5},
	{100, 0.75*0.25*0.75*1.5},
	{300, 0.75*0.75*0.75*1.5},
	{1000, 0.75*0.75*1.5},
	{2000, 0.75*1.5}
}
Presets.benzin[1].SmokeTrailLength = {
	{6, 25*0.6*2},
	{20, 75*0.6*2},
	{300, 400*2*0.6*2},
	{1000, 700*2*0.6*2},
	{2000, 10*2*0.6*2}
}

Presets.benzin[1].SmokeScaleBase = Presets.benzin[1].SmokeScaleBase*0.6
Presets.benzin[1].FireScaleBase = Presets.benzin[1].FireScaleBase*0.8
Presets.benzin[1].Opacity = 0.5
Presets.benzin[1].BaseColor = {60/255, 60/255, 60/255}


Presets.carbon = deepcopy(Effect)
Presets.carbon[1].BaseColor = {60/255, 60/255, 60/255}
Presets.carbon[1].FireScaleBase = Presets.carbon[1].FireScaleBase*1.5
Presets.carbon[1].FirePower = 0.5
Presets.carbon[1].ScaleJitterFactorFire = 1.0/4.0
Presets.carbon[1].SpawnRadius = 0.45
Presets.carbon[1].DistMaxFactorFire = 20.0
Presets.carbon[1].DistMaxFactorSmoke = 20.0

Presets.cellSmoke = deepcopy(Effect)
Presets.cellSmoke[1].BaseColor = {60/255, 60/255, 60/255}
Presets.cellSmoke[1].SmokeScaleBase = Presets.cellSmoke[1].SmokeScaleBase*2.5
Presets.cellSmoke[1].Opacity = 0.0005
Presets.cellSmoke[1].MaxParticlesFire = 0
Presets.cellSmoke[1].Light.Lifetime = 0.0
Presets.cellSmoke[1].ScaleJitterFactorSmoke = 0.1
Presets.cellSmoke[1].SmokeOffsetFactor = 0


Presets.cellSmokeFireflies = deepcopy(Presets.cellSmoke)
Presets.cellSmokeFireflies[1].MaxParticlesFire = 0
Presets.cellSmokeFireflies[1].FireScaleBase = Presets.cellSmokeFireflies[1].FireScaleBase*0.025
Presets.cellSmokeFireflies[1].DecelerationFactorFire = 0.05
Presets.cellSmokeFireflies[1].DistMaxFactorFire = 180
Presets.cellSmokeFireflies[1].TrailLengthFactorFire = 0.01
Presets.cellSmokeFireflies[1].FirePower = 40.0
Presets.cellSmokeFireflies[1].InvSoftParticleFactor = 1.0
Presets.cellSmokeFireflies[1].FireScaleJitter = {
	{0, 1.2},
	{1000,1.5}
}

