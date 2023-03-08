Effect = {
	{ 	-- right
		Type = "turbulancedExhaustTrail",
		Texture = "puff01.dds",
		ParticlesLimit = 100,
		LODdistance = 500,
		
		SpawnSystem = {
			DelayBetweenGroups = 9.0
		},

		Lifetime = 4.0,
		Acceleration = 3.5,
		SpeedConv = 0.45,
		ScaleBase = 0.1,
		SpeedBase = 2.0,
		ScaleMax = 20.0,
		DelayBeforeRotating = 0.2,
		OpacityBase = 2.7,
		ColorBase = {0.089193, 0.1011, 0.1011},
		EffectLifetime = 9.0
	},
}