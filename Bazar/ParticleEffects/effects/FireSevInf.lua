local fireLife = 2
local smokeLifeC = 2
local smokeLife = 8*smokeLifeC
Emitters = {
 	   {
        Name = "Fire1",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {0.9,0.3,0.9}, Max = {-0.9,0.5,-0.9}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 3}, {9, 3}, {13, 0.5}},
        Life = {{0.0, 1.8}},
        
		ShaderParams = {{0, {0.8,0,0,0}, {0.8,0,0,0}}},

        Velocity = { {0.,{0, 2, 0}, {0., 2.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 2.5}, {1.0, 2.8}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.5} },
				
		RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 0.65}, {1, 0.7}},
        BlueOverLife = {{0, 0.4}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0.0}, {0.4, 1.4}, {1, 0}},
    },
	{
        Name = "Fire2",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {0.9,0.5,0.9}, Max = {0.9,0.6,0.9}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 2.5}, {7, 2.5}, {10, 1.0}},
		Life = {{0.0, 1.6}},
        
		ShaderParams = {{0, {1.7,0,0,0}, {1.7,0,0,0}}},

        Velocity = { {0., {0, 0.6, 0}, {0., 1.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 1.9}, {1.0, 2.1}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.5} },
				
		RedOverLife =   {{0, 1.0*1.2}, {1, 1.0}},
        GreenOverLife = {{0, 0.65*1.2}, {1, 0.7}},
        BlueOverLife = {{0, 0.4*1.2}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0}, {0.4, 1.2}, {1, 0}},
    },
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort"},
		InitPositionBox = {Min = {-1.8,0,-0.6}, Max = {1.8,0,3,0.6}},
        
        Number = {{0, 3}, {7, 3}, {15, 1}},
        Life = {{0.0, 2.*smokeLifeC}, {1.0, 7.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

        Velocity = { {0., {-1, 3.6, -1}, {1, 4.5, 1}}},
        VelocityOverLife = { {0,1}, {1,0.4}},

		ParentVelocity = { {0, 0.1} },
		
		Size = {{0.0, 10}, {1.0, 14}},
        SizeOverLife = {{0, 0.35} , {0.9, 2.5}},

        RedOverLife =   {{0, 0.7}, {1*fireLife/smokeLife,0.3}},
        GreenOverLife = {{0, 0.1}, {1*fireLife/smokeLife,0.3}},
        BlueOverLife = {{0, 0}, {1*fireLife/smokeLife,0.3}},
        AlfaOverLife = {{0.0, 0.0}, {1*fireLife/smokeLife, 1.0}, {1, 0}},
    },
}

local lb = 1.2 
Lights =
{
	{
		offset = {0,3,0},
		color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		distance = {{0, 6}, {1, 7}, {2, 6}},
	},
}

Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["Fire1"] = 
			{			
				Number = {{0, 2}},
				Flags = {},
			},
			["Fire2"] = 
			{		
				disable = true,
			},
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
			["Fire1"] = 
			{			
				disable = true,
			},
			["Fire2"] = 
			{		
				disable = true,
			},
			["SmokeL"] = 
			{
				Number = {{0, 1.2}},
				Flags = {},
			},
		}
	},
}