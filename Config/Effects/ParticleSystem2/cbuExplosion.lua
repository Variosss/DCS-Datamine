-- CBUXXX_smoke - air puff
-- CBUXXX_explosion - ground explosion

Effect = {
	{
		-- CBU-97 air puff as default
		Type = "cbuAirExplosion",
		Texture = "normalSemiSphere2.tga",
		Technique = "CBU97",
		ParticlesLimit = 512,
	}
}

Presets =
{
	CBU87_smoke =
	{
		{
		Type = "cbuAirExplosion",
		Technique = "CBU103",
		}
	},
	CBU97_smoke =
	{
		{
		Type = "cbuAirExplosion",
		Technique = "CBU97",
		}
	},
	CBU103_smoke =
	{
		{
		Type = "cbuAirExplosion",
		Technique = "CBU103",
		}
	},
	CBU105_smoke =
	{
		{
		Type = "cbuAirExplosion",
		Technique = "CBU97",
		}
	},
	
	CBU87_explosion =
	{
		{
		Type = "cbuGroundExplosion",
		Technique = "CBU103",
		Texture = "normalSemiSphere2.tga",
		ParticlesLimit = 512,
		}
	},
	CBU97_explosion =
	{
		{
		Type = "cbuGroundExplosion",
		Technique = "CBU97",
		Texture = "normalSemiSphere2.tga",
		ParticlesLimit = 512,
		}
	},
	CBU103_explosion =
	{
		{
		Type = "cbuGroundExplosion",
		Technique = "CBU103",
		Texture = "normalSemiSphere2.tga",
		ParticlesLimit = 512,
		},
	},
	CBU105_explosion = 
	{
		{
		Type = "cbuGroundExplosion",
		Technique = "CBU105",
		Texture = "normalSemiSphere2.tga",
		ParticlesLimit = 512,
		}
	}
}