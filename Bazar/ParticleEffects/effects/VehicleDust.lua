local DustRedOverLife = {{0.0, 1}}
local DustGreenOverLife = {{0.0, 1}}
local DustBlueOverLife = {{0.0, 0.85}}

Emitters = {
	[1] = 
	{
        Name = "TracksDustL",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace", "Sort"},
		InitPositionBox = {Min = {-3, 0, -1}, Max = {0, 0, -1}},
		
        Number = {{0, 12}}, -- {{0, 15}},
        Life = {{0, 6}, {1, 8}},
        Spin = {{0, 1}, {1, -1}},
		SpinOverLife = {{0, 2}, {0.7, -1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.1}},
		RadialVelocity = {{0, 1}, {10, 3}},
		Velocity = {{0, {-0.6, 0.5, 0.1}, {-0.6, 0.5, -0.1}}},
        VelocityOverLife = {{0, 0.2}, {0.3, 0.8}, {1, 1}},
		
        Size = {{0, 2}, {1, 3}},
        SizeOverLife = {{0, 0.6}, {0.1, 1.2}, {0.5, 2}, {1, 4}},
		
		Windage = { {0, 0.1} },
				
	RedOverLife = {{0, 0.75}, {0.25, 0.75}},
	GreenOverLife = {{0, 0.62}, {0.25, 0.62}},
	BlueOverLife = {{0, 0.5}, {0.25, 0.5}},
		AlfaOverLife = {{0.0, 0}, {0.1, 0.8}, {0.35, 0.1}, {1, 0}},
    },
	[2] = 
	{
        Name = "TracksDustR",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace", "Sort"},
		InitPositionBox = {Min = {-3, 0, 1}, Max = {0, 0, 1}},
		
        Number = {{0, 12}}, -- {{0, 15}},
        Life = {{0, 6}, {1, 8}},
        Spin = {{0, 1}, {1, -1}},
		SpinOverLife = {{0, 2}, {0.7, -1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.1}},
		RadialVelocity = {{0, 1}, {10, 3}},
		Velocity = {{0, {-0.6, 0.5, 0.1}, {-0.6, 0.5, -0.1}}},
        VelocityOverLife = {{0, 0.2}, {0.3, 0.8}, {1, 1}},
		
        Size = {{0, 2}, {1, 3}},
        SizeOverLife = {{0, 0.6}, {0.1, 1.2}, {0.5, 2}, {1, 4}},
		
		Windage = { {0, 0.1} },
				
	RedOverLife = {{0, 0.75}, {0.25, 0.75}},
	GreenOverLife = {{0, 0.62}, {0.25, 0.62}},
	BlueOverLife = {{0, 0.5}, {0.25, 0.5}},
		AlfaOverLife = {{0.0, 0}, {0.1, 0.8}, {0.35, 0.1}, {1, 0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 7000,
		Emitters = 
		{
			["TracksDustR"] = 
			{
				Number = {{0, 8}},
			},
			["TracksDustL"] = 
			{
				Number = {{0, 8}},
			},
		}
	},
}