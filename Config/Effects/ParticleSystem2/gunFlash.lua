Effect = {
	{
		Type = "gunFlash",
		Texture = "tgares.dds",
		TextureFront = "newfront.dds",
		TextureGlow = "tgares.dds",
		--NewTex = "tgares.dds",
		NewTex = "o2.dds",
		ParticlesLimit = 8,
		FlashingProbability = 0.90,
		Power = 1.1,
		Size = {1.2, 2.4},

		
	},
}


Presets = {}

Presets.helicopter = deepcopy(Effect)
Presets.helicopter[1].ParticlesLimit = 1
Presets.helicopter[1].Size = {2.5*1.4*1.25, 2.5*1.6*1.25}
Presets.helicopter[1].RandomSize = {0.55, 0.55}
Presets.helicopter[1].Helicopter = true
Presets.helicopter[1].Power = 2.0
Presets.helicopter[1].FlashingProbability = 0.70
Presets.helicopter[1].TextureFront = "fronto2.dds"

Presets.helicopterback = deepcopy(Effect)
Presets.helicopterback[1].ParticlesLimit = 1
Presets.helicopterback[1].Size = {2.5*1.4*0.5, 2.5*1.6*0.5*1.5}
Presets.helicopterback[1].AnimationOffset = 0.0
Presets.helicopterback[1].RandomSize = {0.2, 0.4}
Presets.helicopterback[1].Power = 2.0
Presets.helicopterback[1].Color = {2.5*0.5, 1.2*0.5, 1.0*0.5}
Presets.helicopterback[1].Helicopter = true
Presets.helicopterback[1].FlashingProbability = 0.70
Presets.helicopterback[1].TextureFront = "fronto2.dds"
