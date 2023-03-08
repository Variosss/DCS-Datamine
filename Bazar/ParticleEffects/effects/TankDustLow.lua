-- FX for one track
local DustRedOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustGreenOverLife = {{0.0, 1}} -- {{0.0, 1}}
local DustBlueOverLife = {{0.0, 0.85}} -- {{0.0, 0.85}}
Emitters = {
	[1] = -- dust fron the back of the track
	{
        Name = "TracksDust",
		Texture = "SmokeNormAnim.png",
        Technique = "TranslucentAnim",
		Flags = {"SoftParticles", "LocalSpace", "Sort"},
		InitPositionBox = {Min = {-3.0, 0, -0.1}, Max = {-2.5, 0, 0.1}},
		
        Number = {{0, 15}},
        Life = {{0, 4}, {1, 8}},
        Spin = {{0, 1}, {1, -1}},
		SpinOverLife = {{0, 2}, {0.7, -1}},
		ShaderParams = {{0, {-0.2, 0.3, 10, 0}, {0.2, -0.2, 10, 0}}},

		ParentVelocity = {{0, 0.1}},
		--RadialVelocity = {{0, 1}, {10, 3}},
		Velocity = {{0, {0.0, 0.3, 0.1}, {0.0, 0.5, -0.1}}},
        VelocityOverLife = {{0, 1}, {0.3, 0.4}, {1, 0}},
		
        Size = {{0, 1}, {1, 1.5}},
        SizeOverLife = {{0, 0.2}, {0.1, 1}, {0.5, 2}, {1, 4}},
		
		Windage = { {0, 0.5}, },
				
        RedOverLife = {{0, 0.75}, {0.25, 0.75}},
        GreenOverLife = {{0, 0.62}, {0.25, 0.62}},
        BlueOverLife = {{0, 0.5}, {0.25, 0.5}},
		AlfaOverLife = {{0.0, 0.9}, {0.2, 0.3}, {0.35, 0.1}, {1, 0}},
    },
	[2] = -- dirt from the top front of the track
	{
        Name = "TracksDirtFront",
		Texture = "DustDirt.png",
        Technique = "Translucent",
		Flags = {"LocalSpace"},

		InitPositionBox = {Min = {-0.01, 0.7, 0.02}, Max = {0.01, 0.7, -0.02}}, -- F/R, U/D, L/R
		
        Number = {{0, 10}}, -- {{0, 10}},
        Life = {{0.0, 0.6}, {1.0, 0.8}},
        Spin = {{0, -2}, {1, 2}},
		ShaderParams = {{0, {1,1,0,0}, {1,1,0,0}}}, -- {sprite u, sprite v, uk, uk}

		ParentVelocity = {{0, 0.9}},
		Velocity = {{0, {-0.02, -0.5, 0.2}, {0.02, -1.0, -0.2}}},
		Acceleration = {{0, {-0.2, -9.7, -0.01}, {0.0, -9.8, 0.01}}},
		
        Size = {{0.0, 0.3}, {1.0, 1.0}},
        SizeOverLife = {{0.0, 0.6}, {0.6, 1.0}},
		
		Windage = { {0, 0.0} },
				
		RedOverLife = {{0.0, 0.3}},
		GreenOverLife = {{0.0, 0.3}},
		BlueOverLife = {{0.0, 0.27}},
        AlfaOverLife = {{0.0, 0}, {0.1, 1}, {0.8, 0.8}, {1.0, 0.3}},
    },
}

Lods = 
{
	[1] = 
	{
		Distance = 200,
		Emitters = 
		{
			["TracksDirtFront"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
	[2] = 
	{
		Distance = 1000,
		Emitters = 
		{
			["TracksDirtFront"] = 
			{			
				Flags = {'Disable'},
			},
			["TracksDust"] = 
			{			
				Flags = {'Disable'},
			},
		}
	},
}