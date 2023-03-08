Effect = {
	{
		Type = "wingtipContrail",
		Texture = "wingtipContrail2.bmp",
		LODdistance1 = 450, -- no perlin over length
		LODdistance2 = 2500, -- not drawn
		ParticlesLimit = 400,

		ScaleBase = 0.23,
		Side = -1,

		DistMax = {
			{50, 0.27},
			{1000, 0.27}
		},

		TrailLength = {
			{40, 10},
			{100, 45},
			{500, 80},
			{2000, 25}
		}
	}
}

Presets = 
{
	leftSide = 
	{
		{
			Type = "wingtipContrail",
			Side = 1, -- left
		},
	},
}
