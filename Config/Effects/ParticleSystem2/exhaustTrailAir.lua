Effect = {
	{ 	-- right
		Type = "exhaustTrail",
		Texture = "smoke5.dds",
		-- Texture = "test06.jpg",
		ParticlesLimit = 1200,
		LODdistance = 10000,
		
		SpinDir = 1,
		ScaleBase = 1.5, --  meters
		
		nozzleSpeedMin = 200,  	
		nozzleSpeedMax = 400,
		
		
		DistMax = { 	-- distance between particles, m
			{600, 1},
			{1000, 1.6}
		},
		LifeTime = { -- nozzle speed min + aircraft speed, time
			{200, 7},
			{500, 7},
			{1000, 3.3}
		},
		LifeTimeJitter = { -- result lifetime = LifeTime*(1-LifeTimeJitter)
			{200, 0.1},
			{400, 0.5}
		}
	},
}

updateTimeMin = 0.015
updateTimeMax = 0.1
updateDistMin = 50
updateDistMax = 4000

KO50nozzleSpdMin = 450
Presets = 
{
	KO_50 = {
		{
			Type = "exhaustTrail",
			ParticlesLimit = 30,
			LODdistance = 350,

			ScaleBase = 0.15, --  meters
			
			nozzleSpeedMin = KO50nozzleSpdMin,
			nozzleSpeedMax = 500,
			
			DistMax = { -- distance between particles, m
				{KO50nozzleSpdMin+0, 2},
				{KO50nozzleSpdMin+500, 1}
			},
			LifeTime = { -- nozzle speed min + aircraft speed, time
				{KO50nozzleSpdMin+0,	1.0},
				{KO50nozzleSpdMin+300,	0.5},
				{KO50nozzleSpdMin+500,	0.25},
				{KO50nozzleSpdMin+700,	0.05}
			},
			LifeTimeJitter = { -- result lifetime = LifeTime*(1-LifeTimeJitter)
				{KO50nozzleSpdMin, 0.7},
				{KO50nozzleSpdMin+500, 0.5}
			}
		},
	}
}
