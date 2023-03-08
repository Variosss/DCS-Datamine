Duration = {{0, 430}, {1, 450}}
Emitters = { 	   
	{
        Name = "SmokeCloud",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentMarkerSmoke",
		Flags = {"SoftParticles", "Sort"},
		InitPositionHalfSphere = {MinR = 0.0, MaxR = 20.0, kY = 0.1},
        
        Number = {{0, 1000.0}, {0.1, 1000.0}, {0.11, 0.0}, {450.0, 0.0}},
        Life = {{0.0, 400}, {1.0, 450}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

        Velocity = { {0., {-0.2, 0.0, -0.2}, {0.2, 0.01, 0.2}}},
        VelocityOverLife = { {0,1}, {0.022, 0.03} },
		RadialVelocity = {{0.0, 1.0}, {1.0, 2.0}},

		Windage = { {0, 0.4}, {1.0, 0.3} },
		
		Roll = {{0.0, 0.0}, {1.0, 6.28}},
		Spin = {{0, -0.04}, {1.0, 0.04}},
		Size = {{0.0, 5}, {1.0, 10}},
        SizeOverLife = {{0, 1.0} , {0.01, 2.5}, {1.0, 4}},

        RedOverLife =   {{0, 1}},
        GreenOverLife = {{0, 1}},
        BlueOverLife = {{0, 1}},
		AlfaOverLife = {{0.0, 0.1},
						{0.03, 0.8}, 
						{1, 0}},
    },
}

Lights = {}
--[[
Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["SmokeCloud"] = 
			{
				Number = {{0, 1.7}},
				Flags = {},
			},
		}
	},
}
]]