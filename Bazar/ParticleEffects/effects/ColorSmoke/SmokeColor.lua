Duration = {{0, 80}, {1, 100}}
Emitters = {
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnimLowLight",
		Flags = {"SoftParticles", "Sort"},
		InitPositionBox = {Min = {0, 0, 0}, Max = {0, 0.3, 0.0}},
        
        Number = {{0, 6}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
        Life = {{0.0, 10.0}, {1.0, 25.0}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0.8}, {0.2, -0.2, 10, 0.8}}},

        Velocity = { {0., {-1, 1.0, -1}, {1, 4.0, 1}}},
        VelocityOverLife = { {0,1}, {0.5, 0.1}},

		ParentVelocity = { {0, 0.1} },
		
		Size = {{0.0, 2}, {1.0, 3}},
        SizeOverLife = {{0, 1} , {0.8, 6.0}},

        RedOverLife =   {{0, 0.7}},
        GreenOverLife = {{0, 0.1}},
        BlueOverLife = {{0, 0}},
        AlfaOverLife = {{0.0, 0.0}, {0.02, 1.0}, {1, 0}},
    },
}

local lb = 1.2 
Lights =
{
	-- {
		-- offset = {0,3,0},
		-- color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		-- distance = {{0, 2}, {1, 2.5}, {2, 2}},
	-- },
}

Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 5}},
				Flags = {},
			},
		}
	},
	[2] = 
	{
		Distance = 5000,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 2}},
				Flags = {},
			},
		}
	},
}