local smokeLifeC = 2
local smokeLife = 8*smokeLifeC

Duration = {{0, 900}, {1, 1500}}
Emitters = { 	   
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentMarkerSmoke",
		Flags = {"SoftParticles", "Sort"},
		InitPositionBox = {Min = {-1.8,0,-0.6}, Max = {1.8,0,3,0.6}},
        
        Number = {{0, 3}},
        Life = {{0.0, 2.*smokeLifeC}, {1.0, 7.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

        Velocity = { {0., {-1, 3.6, -1}, {1, 4.5, 1}}},
        VelocityOverLife = { {0,1}, {1,0.4}},

		ParentVelocity = { {0, 0.1} },
		
		Size = {{0.0, 10}, {1.0, 14}},
        SizeOverLife = {{0, 0.35} , {0.9, 2.5}},

        RedOverLife =   {{0, 1}},
        GreenOverLife = {{0, 1}},
        BlueOverLife = {{0, 1}},
        -- AlfaOverLife = {{0.0, 0.0}, {1*fireLife/smokeLife, 1.0}, {1, 0}},
		AlfaOverLife = {{0.0, 0.0}, 
						{0.02, 1.0}, 
						{1, 0}},
    },
}

Lights = {}

Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 1.7}},
				Flags = {},
			},
		}
	},
	[2] = 
	{
		Distance = 2000,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 1.2}},
				Flags = {},
			},
		}
	},
}