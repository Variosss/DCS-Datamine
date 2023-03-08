Effect = {

	{
		Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
		Target = "bowwave",
		Texture = "kelvinWakePattern_Fr_1_w13.dds",
		Slices = 10,
		WaveTexCount = 13,	-- count of traverse waves in texture
	},
	{
		Type = "shipFoam",
		Target = "bowwave",
		Texture = "ship_foam.png",
		Slices = 10,
		TrailLength = 400, 	-- length of foam trail
		ShipTexLength = 0.228, 	-- length of ship in texture coords
	},

	-- particles
	{
		--kuznetsov = 28
		--moscow = 14.5
		Type = "shipTrailFoam",
		Target = "refraction",

		Texture = "foam2.png",
		TextureFoam = "foam_03.dds",
		ParticlesLimit = 600,
		
		Width = 25, -- meters
		ScaleBase = 35.0, --  meters
		
		DistMax = {
			{0, 4.5},
			{50, 4.5},
		},
		TrailLength = {
			{0, 0},
			{50, 2000},
		}
	},
	{
		Type = "shipTrail",

		Texture = "wave.dds",
		TextureFoam = "foam.png",
		Slices = 40,
		Length = 53.57, -- percent of ship width
		Width = 1.965, -- percent of ship width
	},
	{
		Type = "shipBow",
		Target = "main",

		Texture = "foam2.png",
		TextureFoam = "foam_03.dds",
		ParticlesLimit = 400,

		ScaleBase = 7.0,
		
		DistMax = {
			{0, 0.1},
			{50, 0.1},
		},

		LifeTime = {
			{0, 0.0},
			{20, 2.4},
			{50, 2.2},
		}
	}

}

Presets = {

	ArleighBurke = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_ArleighBurke_12mps_20f.dds",
			ShipTexSize = {0.027, 0.6226, 0.2988}, 	-- bow, stern, width in texture coords
			ShipSize = {150, 18},					-- footage calculated for ship {length, width} m
			ShipSpeed = 12,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 5,
			DisplaceMult = 1.5,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 25, -- meters
			ScaleBase = 90.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2800},
			}
		},

		{
			Type = "shipBow",
			Target = "main",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 400,

			SpeedMultiplier = 0.6,
			ScaleBase = 15.0,
		
			DistMax = {
				{0, 0.1},
				{50, 0.1},
			},

			LifeTime = {
				{0, 0.0},
				{20, 2.4},
				{50, 2.2},
			}
		}
	},

	Nimitz = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_Nimitz_12mps_20f.dds",
			ShipTexSize = {0.009, 0.6685, 0.34375}, 	-- bow, stern, width in texture coords
			ShipSize = {316, 42},					-- footage calculated for ship {length, width} m
			ShipSpeed = 12,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 5,
			DisplaceMult = 1.25,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 35, -- meters
			ScaleBase = 70.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2500},
			}
		},

		{
			Type = "shipBow",
			Target = "main",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 400,

			SpeedMultiplier = 0.8,
			ScaleBase = 15.0,
		
			DistMax = {
				{0, 0.1},
				{50, 0.1},
			},

			LifeTime = {
				{0, 0.0},
				{20, 2.4},
				{50, 2.2},
			}
		}
	},

	Kilo636 = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_Kilo636_9mps_20f.dds",
			ShipTexSize = {0.015, 0.5566, 0.156146}, 	-- bow, stern, width in texture coords
			ShipSize = {64, 10},					-- footage calculated for ship {length, width} m
			ShipSpeed = 9,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 5,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 25, -- meters
			ScaleBase = 65.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2500},
			}
		}
	},

	Molniya = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_Molniya_12mps_20f.dds",
			ShipTexSize = {0.0453, 0.4371, 0.2402}, 	-- bow, stern, width in texture coords
			ShipSize = {50, 10},					-- footage calculated for ship {length, width} m
			ShipSpeed = 12,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 5,
			DisplaceMult = 1.0,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 25, -- meters
			ScaleBase = 90.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2800},
			}
		},

		{
			Type = "shipBow",
			Target = "main",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 400,

			SpeedMultiplier = 1.0,
			ScaleBase = 15.0,
		
			DistMax = {
				{0, 0.1},
				{50, 0.1},
			},

			LifeTime = {
				{0, 0.0},
				{20, 2.4},
				{50, 2.2},
			}
		}
	},

	HandyWind = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_HandyWind_8mps_20f.dds",
			ShipTexSize = {0.05263, 0.7238, 0.3379}, 	-- bow, stern, width in texture coords
			ShipSize = {180, 24},					-- footage calculated for ship {length, width} m
			ShipSpeed = 8,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 5,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 7, -- meters
			ScaleBase = 37.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2700},
			}
		},

	},

	SeawiseGiant = {
		{
			Type = "shipWake",
			Target = "bowwave",
			Texture = "shipWake_SeawiseGiant_8mps_20f.dds",
			ShipTexSize = {0.036, 0.801, 0.4609}, 	-- bow, stern, width in texture coords
			ShipSize = {446, 69},					-- footage calculated for ship {length, width} m
			ShipSpeed = 8,							-- footage calculated for ship speed m/s
			FrameRate = 15,
			FrameCount = 20,
			Slices = 3,
		},

		{
			Type = "kelvinWakePattern",	-- Kelvin Wake Pattern
			Target = "bowwave",
			Texture = "kelvinWakePattern_Fr_1_w13.dds",
			Slices = 10,
			WaveTexCount = 13,	-- count of traverse waves in texture
		},

		--- particles
		{
			Type = "shipTrailFoam",
			Target = "bowwave",

			Texture = "foam2.png",
			TextureFoam = "foam_03.dds",
			ParticlesLimit = 600,
		
			Width = 45, -- meters
			ScaleBase = 120.0, --  meters
		
			DistMax = {
				{0, 4.5},
				{50, 4.5},
			},
			TrailLength = {
				{0, 0},
				{50, 2600},
			}
		},

	},


}

updateTimeMin = 0.015
updateTimeMax = 0.15
updateDistMin = 500
updateDistMax = 4000
