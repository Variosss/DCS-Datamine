Effect = {
	{
		Type = "tracer",
		Texture = "tracer2.dds",
		
		Visibility = 40000,
		Size = {4.0, 0.6}, -- length, width
		SunFactors = {0.06, 0.2, 2.0}, -- scaling of tracer length by sunY, length = Size.x * (1.0f + SunFactors.z * (1.0f - saturate((sunY + SunFactors.x)/SunFactors.y)));
		Brightness = 4.0,
		
		Color = {255/255.0, 140/255.0, 30/255.0, 1.0}, -- gold
	},
	{
		Type = "volumetricPointLight",
		Segments = 1,
		Intensity = 10,
		Color = {255/255.0, 140/255.0, 30/255.0, 1.0}, -- gold
	}	
}

Presets =
{
	gold =
	{
		{
			Type = "tracer",
		},
		{
			Type = "volumetricPointLight",
			Segments = 1,
			Intensity = 10,
			Color = {255/255.0, 140/255.0, 30/255.0, 1.0}, -- gold
		}	
	},
	
	white =
	{
		{
			Type = "tracer",
			Color = {0.65, 0.65, 0.65, 1.0},
		},
		{
			Type = "volumetricPointLight",
			Segments = 1,
			Intensity = 10,
			Color = {0.65, 0.65, 0.65, 1.0},
		}	
	},
	
	red =
	{
		{
			Type = "tracer",
			Color = {1.0, 0.2, 0.2, 1.0},
		},
		{
			Type = "volumetricPointLight",
			Segments = 1,
			Intensity = 10,
			Color = {1.0, 0.2, 0.2, 1.0},
		}	
	},
	
	green =
	{
		{
			Type = "tracer",
			Color = {44/255.0, 255/255.0, 11/255.0, 1.0},
		},
		{
			Type = "volumetricPointLight",
			Segments = 1,
			Intensity = 10,
			Color = {44/255.0, 255/255.0, 11/255.0, 1.0},
		}	
	},
	
	yellow =
	{
		{
			Type = "tracer",
			Color = {255/255.0, 180/255.0, 21/255.0, 1.0},
		},
		{
			Type = "volumetricPointLight",
			Segments = 1,
			Intensity = 10,
			Color = {255/255.0, 180/255.0, 21/255.0, 1.0},
		}	
	},
}
