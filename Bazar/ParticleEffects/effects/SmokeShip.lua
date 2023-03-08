local fireLife = 2
local smokeLifeDelta = 12.0
local smokeLife = 50.0
local hazeLifeDelta = 20.0
local hazeLife = 90.0
local CommonInitPos = {Min = {-1.8,0,-0.6}, Max = {1.8,0,3}}
Emitters = {
	{
        Name = "SmokeL",
		Texture = "SmokeNormAnim.png",
		Technique = "TranslucentAnim",
		Flags = {"Sort"},
		InitPositionBox = CommonInitPos,
        
        Number = {{0, 3.5}},
        Life = {{0.0, smokeLife-smokeLifeDelta}, {1.0, smokeLife+smokeLifeDelta}},
        
		ShaderParams = {{0, {-0.2, 0.1, 30, 0}, {0.2, 0.3, 30, 0}}},

        Velocity = { {0., {-1.5, 4., -1.5}, {1.5, 8.0, 1.5}}},
        VelocityOverLife = { {0,1}, {10*fireLife/smokeLife,0.6}, {0.8,0.05}},

		Size = {{0.0, 16}, {1.0, 20}},
        SizeOverLife = {{0, 0.3}, {fireLife/smokeLife, 1}, {0.6, 4}},

        RedOverLife =   {{0, 0.15}, {0.75*fireLife/smokeLife,0.15}},
        GreenOverLife = {{0, 0.15}, {0.75*fireLife/smokeLife,0.15}},
        BlueOverLife =  {{0, 0.15}, {0.75*fireLife/smokeLife,0.15}},
        AlfaOverLife =  {{0.0,0.5}, {0.65*fireLife/smokeLife,0.1},{1, 0}},
    },
	{
        Name = "SmokeHaze",
		Texture = "DCSSmoke.png",
		Technique = "Translucent",
		Flags = {"SoftParticles", "Sort"},
		InitPositionBox = CommonInitPos,
        
        Number = {{0, 0.12}},
        Life = {{0.0, hazeLife - hazeLifeDelta}, {1.0, hazeLife + hazeLifeDelta}},
		
		ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},
		--ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},

        Velocity = {{0.0, {-1.0, 3.0, -1.0}, {1.0, 4, 1.0}},
					{0.2, {-1.0, 3.0, -1.0}, {1.0, 4, 1.0}},
					{0.2, {-2, 4.0, -2}, {2, 7.0, 2}},
					{1.0, {-2, 4.0, -2}, {2, 7.0, 2}}},
        VelocityOverLife = { {0,1}, {10*fireLife/hazeLife, 1}, {0.8,0.1}},

		Size = {{0.0, 16}, {1.0, 20}},
        SizeOverLife = {{0, 0.0}, {10*fireLife/hazeLife, 1}, {0.7, 13}},

        RedOverLife =   {{0, 0.2}},
        GreenOverLife = {{0, 0.2}},
        BlueOverLife = {{0, 0.2}},
        AlfaOverLife = {{0.0, 0.0}, {smokeLife/hazeLife, 0.35}, {0.7, 0.35}, {1, 0.0}},
    },
}

local lb = 1.2 
Lights =
{
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
				Number = {{0, 2}},
				Flags = {},
			},
			["Haze"] = 
			{
				Flags = {"SoftParticles"},
			}
		}
	},
	[2] = 
	{
		Distance = 2000,
		Emitters = 
		{
			["SmokeL"] = 
			{
				Number = {{0, 2}},
				Flags = {},
			},
			["Haze"] = 
			{
				Flags = {},
			}
		}
	},
}