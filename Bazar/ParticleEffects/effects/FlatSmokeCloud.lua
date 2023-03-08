Emitters = {
 	[1] = 
	{
        Name = "Smoke",
		Texture = "DCSSmoke.png",
        Technique = "Translucent",
		Flags = {"SoftParticles", "LocalSpace"},
		InitPositionSphere = {MinR = 1, Max = 5, EnableY = false},
		
        Number = {{0, 1000}},
		Duration = {{0, 0.02}},
		
        Life = {{0.0, 7}, {1.0, 9}},
        Spin = {{0, 0.3}},
		ShaderParams = {{0, {2,2,0,0}, {2,2,0,0}}},

		RadialVelocity = {{0, 15}};
        VelocityOverLife = {{0,1}, {0.3, 0.1}},
		
        Size = {{0.0, 15}, {1.0, 20}},
        SizeOverLife = {{0.0, 0.2}, {0.2, 1}},
		
		Windage = { {0, 1} },
				
		RedOverLife =   {{0, 1.0}, {1, 1.0}},
        GreenOverLife = {{0, 1}, {1, 1}},
        BlueOverLife = {{0, 1}, {1, 1}},
		
        AlfaOverLife = {{0.0, 0}, {0.2, 1}, {0.7, 1}, {1, 0}},
    }
}