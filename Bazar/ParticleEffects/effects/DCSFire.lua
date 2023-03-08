Emitters = {
 	   {
        Name = "Fire",
		Texture = "DCSFire.png",
		Technique = "AnimatedFire",
		InitPositionBox = {Min = {-2,0,-2}, Max = {2,1,2}},
        
--		Flags = {"Intense", "LightSource"},
        
        Number = {{0, 60}},
        Visibility = {{0, 1}},

       
        Life = {{0.0, 0.5}, {0.5, 0.5}, {1.0, 1.1}},
        Velocity = { {0., 10}, {1., 12}},
        Size = {{0.0, 10}, {1.0, 13}},
        Weight = { {0, 0} },
        Spin = {{0, 1}},

        SizeOverLife = {{0, 0.0}, {0.2, 0.75}, {0.6, 1} , {1, 0.1}},
        VelocityOverLife = { {0,0} , {0.16, 0.15}, {0.33,1}},
		WeightOverLife = {{0,0}},

--		RedOverLife =   {{0, 1} , {0.10, 255/255}, {1, 0.9}},
--        GreenOverLife = {{0, 1} , {0.10, 150/255}, {1, 0.2}},
--        BlueOverLife = {{0, 0.05}, {1, 0}},
        
        RedOverLife =   {{0, 0.6} , {0.10, 120/255}, {1, 0.9}},
        GreenOverLife = {{0, 0.2} , {0.10, 60/255}, {1, 0.10}},
        BlueOverLife = {{0, 0.05}, {1, 0}},
        AlfaOverLife = {{0.0, 0}, {0.1, 1}, {0.7, 1}, {1, 0}},
    },
	{
        Name = "Smoke",
		Texture = "DCSSmoke.png",
		Technique = "Translucent",
		InitPositionBox = {Min = {-2,0,-2}, Max = {2,1,2}},
        
        Number = {{0, 5}},
        Visibility = {{0, 1}},

        Life = {{0.0, 5.0}, {1.0, 7.0}},
        Velocity = { {0.0, 10}, {1., 15} },
        Size = {{0.0, 50}, {1.0, 75}},
        Weight = {{0, 3}},
        Spin = {{0, 0}, {1.0, 1.0}},
		ShaderParams = {{0, {2, 2, 0, 0}, {2, 2, 0, 0}}},

        SizeOverLife = {{0, 0.15} , {0.6, 1.0}},
		WeightOverLife = {{0,-1}, {0, 1}},

        RedOverLife =   {{0, 0.5}, {0.15,0}},
        GreenOverLife = {{0, 0}},
        BlueOverLife = {{0, 0}},
        AlfaOverLife = {{0.0, 0.0}, {0.15, 1}, {1, 0}},
    },
	{
        Name = "Distortion",
		Technique = "Distortion",
		Flags = {"Disable"},
        
        Number = {{0, 2}},
        Visibility = {{0, 1}},

        Life = {{0.0, 2.0}, {1.0, 2.5}},
        Velocity = { {0., 5}, {1.0, 10} },
        Size = {{0.0, 10}, {1.0, 15}},
    },
}
