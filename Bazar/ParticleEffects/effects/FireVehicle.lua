local fireLife = 2
local smokeLifeC = 2
local smokeLife = 8*smokeLifeC
local lifeTime = 120

Duration = {{0, 900}, {1, 1500}}
Emitters = {
 	   {
        Name = "Fire1",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {-1.2,0.8,0.3}, Max = {-1.2,1,1.3}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 4}, {1, 1}},
--		NumberRate  = {{-3, 1}, {0,0.125}},
        Life = {{0.0, 1.8}},
        
		ShaderParams = {{0, {0.8,0,0,0}, {0.8,0,0,0}}},

        Velocity = { {0.,{0, 2, 0}, {0., 2.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 2.5}, {1.0, 2.8}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.3} },
				
		RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 0.65}, {1, 0.7}},
        BlueOverLife = {{0, 0.4}, {1, 0.4}},
		
        AlfaOverLife = {{0.0, 0.0}, {0.4, 1.4}, {1, 0}},
    },
	{
        Name = "Fire2",
		Texture = "DCSFireTex.png",
        Technique = "AnimatedFire",
		InitPositionBox = {Min = {1.8,0.5,-0.7}, Max = {2.0,0.6,-0.9}},
		Flags = {"SoftParticles"},
        
        Number = {{0, 3.5}, {1.5, 1}},
 --       NumberRate  = {{-8, 1}, {-5, 0}},
        Life = {{0.0, 1.6}},
        
		ShaderParams = {{0, {1.7,0,0,0}, {1.7,0,0,0}}},

        Velocity = { {0., {0, 0.6, 0}, {0., 1.5, 0}}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}, {0.4,1}, {1.0,1.7}},
		
        Size = {{0.0, 1.9}, {1.0, 2.1}},
        SizeOverLife = {{0.6, 1} , {1, 0.1}},
		
		ParentVelocity = { {0, 0.5} },
		Windage = { {0, 0.3} },
				
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
        
        Number = {{0, 3}},
--        NumberRate  = {{-2, 1}, {0, 0.33}},
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
local df = 0.5 -- dist factor
Lights =
{
	{
		offset = {0,4.5,0},
		color = {{0, {1*lb, 0.6*lb, 0.2*lb}}, {0.3, {0.8*lb, 0.5*lb, 0.1*lb}}, {0.4, {1*lb, 0.6*lb, 0.2*lb}}},
		distance = {{0, 120*df}, {1.5, 155*df}, {3, 110*df}},
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
				Flags = {'Disable'},
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
				Flags = {'Disable'},
			},
			["Fire2"] = 
			{		
				Flags = {'Disable'},
			},
			["SmokeL"] = 
			{
				Number = {{0, 1.2}},
				Flags = {},
			},
		}
	},
}