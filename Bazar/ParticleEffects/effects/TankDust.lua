local DustRedOverLife = {{0.0, 0}} -- {{0.0, 1}}
local DustGreenOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustBlueOverLife = {{0.0, 0}} -- {{0.0, 0.85}}
Emitters = {
	[1] = 
	{
        Name = "Dust",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace"},
		InitPositionBox = {Min = {0.2, 0, -0.1}, Max = {0.5, 0, 0.1}},
		
        Number = {{0, 13}},
        Life = {{0, 5}, {1, 15}},
        Spin = {{0, 1}, {1, -1}},
        SpinOverLife = {{0, -2}, {0.7, 1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.3}},
		RadialVelocity = {{0, 1}, {10, 3}},
		Velocity = {{0, {-0.2, 1, -1}, {0.2, 1.5, 1}}},
        VelocityOverLife = {{0, 1.0}, {0.22, 0.0}},
		
        Size = {{0, 3}, {1, 4}},
        SizeOverLife = {{0, 0.3}, {0.2, 2}, {1, 8}},
		
		Windage = { {0, 0.5} },
		

        RedOverLife = {{0, 0.75}, {0.25, 0.75}},
        GreenOverLife = {{0, 0.62}, {0.25, 0.62}},
        BlueOverLife = {{0, 0.5}, {0.25, 0.5}},
        AlfaOverLife = {{0, 0.2}, {0.2, 1.0}, {0.4, 0.3}, {1, 0}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 1500,
		Emitters = 
		{
			["Dust"] = 
			{
				Number = {{0,4}},
			},
		}
	},
}