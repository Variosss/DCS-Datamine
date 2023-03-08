Effect = {

	{
		Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
		Target = "bowwave",
		Texture = "KevinWakePattern812x1024.dds",
		Slices = 10,
		WaveTexCount = 13,	-- count of traverse waves in texture
	},
	{
		Type = "shipFoam",
		Target = "bowwave",
		Texture = "ship_foam.png",
		Slices = 10,
		TrailLength = 100, 	-- length of foam trail
		ShipTexLength = 0.228, 	-- length of ship in texture coords
	},


	-- particles
	{
		Type = "shipTrail",

		Texture = "wave.dds",
		TextureFoam = "foam.png",
		Slices = 40,
		Length = 53.57, -- percent of ship width
		Width = 1.965, -- percent of ship width
	},
	{
		--kuznetsov = 28
		--moscow = 14.5
		Type = "shipTrailFoam",

		Texture = "foam2.png",
		TextureFoam = "foam_03.dds",
		ParticlesLimit = 400,
		Width = 20, -- meters
		ScaleBase = 25.0, --  meters
		
		DistMax = {
			{0, 4.5},
			{50, 4.5},
		},
		TrailLength = {
			{0, 0},
			{50, 700},
		}
	},
	{
		Type = "vehicleBow",
		SubEmittersOffsets = {
			{0.0, -1.0, 0.8},
			{0.0, -1.0, -0.8},
			{0.0, -1.0, 0.0},
			{0.0, -1.0, 0.4},
			{0.0, -1.0, -0.4}
		},
		Texture = "foam2.png",
		TextureFoam = "foam_03.dds",
		ParticlesLimit = 150,	

		ScaleBase = 0.35,
		ScaleMax = 0.5,
		OpacityBase = 1.0,
		BaseColor = {1, 1, 1},

		SpawnSystem = {
			RepeatSpawning = true
		},
		
		Speed = {
			{0, 0.1},	
			{50, 7.0},
		},

		LifeTime = {
			{0, 0.0},
			{20, 1.7},
			{50, 2.0},
		}
	}
}

updateTimeMin = 0.015
updateTimeMax = 0.15
updateDistMin = 500
updateDistMax = 4000

