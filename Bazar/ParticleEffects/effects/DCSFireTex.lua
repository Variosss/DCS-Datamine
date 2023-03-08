local fireLife = 2
local smokeLifeC = 2
local smokeLife = 8*smokeLifeC
local CommonInitPos = {Min = {-1.8,0,-0.6}, Max = {1.8,0,3}}
local smokeMin, smokeMax = 0.7, 2.1

Emitters = {
 	   {
        Name = "Fire",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = CommonInitPos,
		Flags = {"SoftParticles"},
        
        Number = {{0, 11}},
        Life = {{0.0, 1.8}, {0.5, 1.8}, {1.0, 2.5}},
        
		ShaderParams = {{0, {1.3,0,0,0}, {1.3,0,0,0}}},

        Velocity = { {0., {-2, 3.6, -2}, {2, 4.5, 2}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 3.6}, {1.0, 4.5}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.8} },
				
		RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 0.65}, {1, 0.7}},
        BlueOverLife = {{0, 0.4}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0}, {0.13, 1}, {0.7, 1}, {1, 0}},
    },
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "Sort"},
		InitPositionBox = CommonInitPos,
        
        Number = {{0, 3}},
        Life = {{0.0, 7.*smokeLifeC}, {1.0, 10.0*smokeLifeC}},
        
		ShaderParams = {{0, {-0.3, 0.1, 10, 0}, {0.3, 0.7, 13, 0}}},

        Velocity = { {0., {-smokeMin, 3.6, -smokeMin}, {smokeMin, 4.5, smokeMin}},
					 {0.7, {-smokeMin, 3.6, -smokeMin}, {smokeMin, 4.5, smokeMin}},
					 {0.71, {-smokeMax, 3.6, -smokeMax}, {smokeMax, 4.5, smokeMax}},
					 {1., {-smokeMax, 3.6, -smokeMax}, {smokeMax, 4.5, smokeMax}},},
        VelocityOverLife = { {0,1}, {1,0.4}},

		ParentVelocity = { {0, 0.3} },
		
		Size = {{0.0, 16}, {1.0, 20}},
        SizeOverLife = {{0, 0.3}, {0.9, 2.5}},

        RedOverLife =   {{0, 0.7}, {0.75*fireLife/smokeLife,0.15}},
        GreenOverLife = {{0, 0.1}, {0.75*fireLife/smokeLife,0.15}},
        BlueOverLife = {{0, 0}, {0.75*fireLife/smokeLife,0.15}},
        AlfaOverLife = {{0.0, 0.0}, {0.65*fireLife/smokeLife, 1.1}, {1, 0}},
    },
	{
        Name = "SmokeHaze",
		Texture = "DCSSmoke.png",
		Technique = "Translucent",
		Flags = {"SoftParticles", "Disable"},
		InitPositionBox = CommonInitPos,
        
        Number = {{0, 2}},
        Life = {{0.0, 50}, {1.0,60}},
        
		ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},

        Velocity = { {0., {-4, 0, -4}, {4, 4, 4}}},
        VelocityOverLife = { {0,1}, {1,0.1}},

		ParentVelocity = { {0, 0.3} },
		
		Size = {{0.0, 120}, {1.0, 200}},
        SizeOverLife = {{0, 0.0}, {0.3, 1}},

        RedOverLife =   {{0, 0.3}},
        GreenOverLife = {{0, 0.3}},
        BlueOverLife = {{0, 0.3}},
        AlfaOverLife = {{0.0, 0.0}, {0.6, 0.3}, {1, 0.0}},
    },
}

local lb = 1.2 
Lights =
{
	{
		offset = {0,3,0},
		color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		distance = {{0, 20}, {1, 21}, {2, 20}},
	},
}


Lods = 
{
	[1] = 
	{
		Distance = 800,
		Emitters = 
		{
			["Fire"] = 
			{			
				Number = {{0, 2}},
				Flags = {},
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
			["Fire"] = 
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