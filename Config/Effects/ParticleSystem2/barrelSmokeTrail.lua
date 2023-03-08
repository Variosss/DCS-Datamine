Effect = {	
	{
		Type = "barrelSmokeTrail",
		Texture = "puff02.dds",
		ParticlesLimit = 150,

		SmokeColor = {0.7*227/255.0, 0.7*225/255.0, 0.7*213/255.0},
		LifeTime = 3.5, 
		RadiusMin = 0.2, -- meters
		Radius = 2.0, 	 -- meters
		ScaleBase = 0.4, -- meters
		Opacity = 0.35,
		TrailLength = {
			{0, 7},
			{0.7, 9},
			{0.8, 7},
			{0.9, 3},
			{1.0, 2}
		},
		DistMax = {
			{0, 0.03},
			{0.7, 0.001},
			{1.0, 0.04}
		},
		Speed = {
			{0, 3.5},
			{0.7, 2.5},
			{1.0, 1.2}
		}
	}
}