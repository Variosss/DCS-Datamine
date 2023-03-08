nozzleSpdMin = 200
Effect = {
	{
		Type = "hotAir",
		Target = "hotAir",
		
		Texture = "smoke5.dds",
		ParticlesLimit = 40,
		LODdistance = 750,

		ScaleBase = 1.3, --  meters
		
		nozzleSpeedMin = nozzleSpdMin,
		nozzleSpeedMax = 500,
		
		DistMax = { -- distance between particles, m
			{nozzleSpdMin+0, 8},
			{nozzleSpdMin+500, 3}
		},
		LifeTime = { -- nozzle speed min + aircraft speed, time
			{nozzleSpdMin+0,	2.2},
			{nozzleSpdMin+300,	1.2},
			{nozzleSpdMin+500,	0.5},
			{nozzleSpdMin+700,	0.06}
		},
		LifeTimeJitter = { -- result lifetime = LifeTime*(1-LifeTimeJitter)
			{nozzleSpdMin, 0.7},
			{nozzleSpdMin+500, 0.5}
		}
	},
}

staticEffect = true
updateTimeMin = 0.015
updateTimeMax = 0.1
updateDistMin = 50
updateDistMax = 4000

nozzleSpdMin = 450
Presets = 
{
	KO_50 = {
		{
			Type = "hotAir",
			
			ParticlesLimit = 30,
			LODdistance = 350,

			ScaleBase = 0.15, --  meters
			
			nozzleSpeedMin = nozzleSpdMin,
			nozzleSpeedMax = 500,
			
			DistMax = { -- distance between particles, m
				{nozzleSpdMin+0, 2},
				{nozzleSpdMin+500, 1}
			},
			LifeTime = { -- nozzle speed min + aircraft speed, time
				{nozzleSpdMin+0,	1.2},
				{nozzleSpdMin+300,	0.6},
				{nozzleSpdMin+500,	0.3},
				{nozzleSpdMin+700,	0.06}
			},
			LifeTimeJitter = { -- result lifetime = LifeTime*(1-LifeTimeJitter)
				{nozzleSpdMin, 0.7},
				{nozzleSpdMin+500, 0.5}
			}
		},
	}
}