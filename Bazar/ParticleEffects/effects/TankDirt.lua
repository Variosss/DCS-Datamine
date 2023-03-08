local birthBoxSize = 0.1

Emitters = {
	[1] = 
	{
        Name = "TracksDirt",
		Texture = "DustDirt.png",
        Technique = "Translucent",
		Flags = {"LocalSpace"},
		InitPositionBox = {Min = {-0.05, 0, 0.2}, Max = {0.05, 0, -0.2}}, -- F/R, U/D, L/R
		
        Number = {{0, 15}}, -- {{0, 20}},
        Life = {{0.0, 1.25}, {1.0, 1.4}},
        Spin = {{0, 5}, {1, -5}},
		ShaderParams = {{0, {1,1,0,0}, {1,1,0,0}}}, -- {sprite u, sprite v, uk, uk}

		ParentVelocity = {{0, 0.6}},
		Velocity = {{0, {-0.1, 3, 0.2}, {-0.2, 3, -0.2}}},
		Acceleration = {{0, {0, -9.8, 0.0}, {0, -9.8, 0.0}}},
		
        Size = {{0.0, 0.7}, {1.0, 1.1}},
        SizeOverLife = {{0.0, 0.4}, {0.6, 1.0}},
		
		Windage = { {0, 0.0} },
				
		RedOverLife = {{0.0, 0.19}}, -- {{0.0, 0.204}},
		GreenOverLife = {{0.0, 0.17}}, -- {{0.0, 0.15}},
		BlueOverLife = {{0.0, 0.08}}, -- {{0.0, 0.055}},
        AlfaOverLife = {{0.0, 0}, {0.1, 1}, {0.8, 0.8}, {1.0, 0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 100,
		Emitters = 
		{
			["TracksDirt"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
}