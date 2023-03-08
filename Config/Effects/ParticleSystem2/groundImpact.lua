Effect = {
	{	-- dirt
		Type = "groundImpact",
		Pass = "DecalForward",

		AlbedoTex = "Voronka.dds", 
		RoughMetTex = "Voronka_RoughMet.dds",
		NormalTex = "Voronka_Normal.tga",

		ParticlesLimit = 500, --one effect per N craters
		LODdistance = 15000, --for crater of radius 1m
	},
}

staticEffect = true;

Presets = {}
Presets.concrete = deepcopy(Effect)
Presets.concrete[1].ParticlesLimit = 300
Presets.concrete[1].AlbedoTex = "Voronka_beton.tga"
Presets.concrete[1].RoughMetTex = "Voronka_beton_RoughMet.tga"
Presets.concrete[1].NormalTex = "Voronka_beton_Normal.tga"
