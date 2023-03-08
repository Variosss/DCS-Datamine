Effect = {	
	{
		Type = "energyShield",
		Texture = "shieldNoise.dds",
		Segments = 64,
		Height = 7.5,
		Opacity = 0.5,
		MeshType = 0, -- 0 - cylinder, 1 - sphere
	}	
}

Presets = {}
Presets.sphereShield = deepcopy(Effect)
Presets.sphereShield[1].MeshType = 1
