Effect = {
	{
		Type = "smoke",
		LODdistance = 50000.0,
		Texture = "puff01.dds",
		-- Texture = "puff02.dds",
		
		ColorGradientTexture = "fireGradient01.dds",
		AlphaGradientTexture = "fireGradient01.dds",
		
		Points = 7, -- 2 minimum
		Density = 0.2,
		Radius = {150, 750},-- start, finish
		RadiusFactor = 1.0,
		Length = 1500,
		TrailSpeedMin = 15,
		HeightFactor = 0.15,
		
		AnimSpeed = 30, -- FPS

		Color = {61/255.0, 70/255.0, 73/255.0},
		Opacity = 0.5,
		Lighting = 0.6,

		FlameAttenuation = {-92, 280}, -- meters from smoke start
		FlamePower = 5.0*9,
		FlameFactor = 1.5,
		Light =
		{
			Color = {1, 0.45, 0,09},
			Radius = 100.0,
			Lifetime = 1000.0,
			Offset = {0, 0.5, 0},
		}
	},
}

staticEffect = true

Presets =
{
	hugeSmokeWithFire =
	{
		{
			Type = "smoke",

			Light =
			{
				Color = {1, 0.45, 0,09},
				Radius = 150.0,
				--Radius = 100000.0,
				Lifetime = 1000.0,
				Offset = {0, 2.0, 0},
			}
		}
	},
	
	largeSmokeWithFire =
	{
		{
			Type = "smoke",
			
			Density = 0.2,
			Radius = {80, 370},-- start, finish
			RadiusFactor = 1.0,
			Length = 800,
			TrailSpeedMin = 10,
			HeightFactor = 0.15,
			
			AnimSpeed = 60, -- FPS

			Color = {61/255.0, 70/255.0, 73/255.0},
			Opacity = 1.0,
			Lighting = 0.6,
			
			FlameAttenuation = {-50, 150}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.5,

			Light =
			{
				Color = {1, 0.45, 0,09},
				Radius = 150.0,
				--Radius = 100000.0,
				Lifetime = 1000.0,
				Offset = {0, 2.0, 0},
			}
		}
	},
	
	mediumSmokeWithFire =
	{
		{
			Type = "smoke",
			
			Density = 0.2,
			Radius = {35, 170},-- start, finish
			RadiusFactor = 1.0,
			Length = 350,
			TrailSpeedMin = 10,
			HeightFactor = 0.15,
			
			AnimSpeed = 65, -- FPS

			Color = {61/255.0, 70/255.0, 73/255.0},
			Opacity = 1.0,
			Lighting = 0.6,
			
			FlameAttenuation = {-20, 60}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.5,

			Light =
			{
				Color = {1, 0.45, 0,09},
				Radius = 100.0,
				--Radius = 100000.0,
				Lifetime = 1000.0,
				Offset = {0, 2.0, 0},
			}
		}
	},
	
	smallSmokeWithFire =
	{
		{
			Type = "smoke",
			
			Density = 0.2,
			Radius = {15, 80},-- start, finish
			RadiusFactor = 1.0,
			Length = 150,
			TrailSpeedMin = 5,
			HeightFactor = 0.25,
			
			AnimSpeed = 70, -- FPS

			Color = {61/255.0*0.8, 70/255.0*0.8, 73/255.0*0.8},
			Opacity = 1.0,
			Lighting = 0.6,
			
			FlameAttenuation = {-10, 30}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.5,

			Light =
			{
				Color = {1, 0.45, 0,09},
				Radius = 75.0,
				--Radius = 100000.0,
				Lifetime = 1000.0,
				Offset = {0, 2.0, 0},
			}
		}
	},

	miniSmokeWithFire =
	{
		{
			Type = "smoke",
			
			Density = 0.2,
			Radius = {8, 40},-- start, finish
			RadiusFactor = 1.0,
			Length = 80,
			TrailSpeedMin = 2.5,
			HeightFactor = 0.25,
			
			AnimSpeed = 70, -- FPS

			Color = {61/255.0*0.8, 70/255.0*0.8, 73/255.0*0.8},
			Opacity = 1.0,
			Lighting = 0.6,
			
			FlameAttenuation = {-5, 15}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.5,

			Light =
			{
				Color = {1, 0.45, 0,09},
				Radius = 75.0,
				--Radius = 100000.0,
				Lifetime = 1000.0,
				Offset = {0, 2.0, 0},
			}
		}
	},

	areaSmokeWithFire =
	{
		{
			Type = "smoke",
			
			Density = 0.2,
			Radius = {15, 80},-- start, finish
			RadiusFactor = 1.0,
			Length = 150,
			TrailSpeedMin = 5,
			HeightFactor = 0.25,
			
			AnimSpeed = 70, -- FPS

			Color = {61/255.0*0.8, 70/255.0*0.8, 73/255.0*0.8},
			Opacity = 1.0,
			Lighting = 0.6,
			
			FlameAttenuation = {-10, 30}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.5,
		},
		{
			Type = "smoke",
			
			Density = 0.25,
			Radius = {5, 50},-- start, finish
			RadiusFactor = 1.0,
			Length = 65,
			TrailSpeedMin = 4,
			HeightFactor = 0.25,
			
			AnimSpeed = 90, -- FPS

			Color = {61/255.0*0.8, 70/255.0*0.8, 73/255.0*0.8},
			Opacity = 0.9,
			Lighting = 0.65,
			
			FlameAttenuation = {-10, 38}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.4,
			PositionOffsetLocal = {-6.5, -0.5, -7.543},

			LODdistance = 50000.0,
			Texture = "puff01.dds",
			-- Texture = "puff02.dds",
			
			ColorGradientTexture = "fireGradient01.dds",
			AlphaGradientTexture = "fireGradient01.dds",
			
			Points = 7, -- 2 minimum
			

		}
		,{
			Type = "smoke",
			LODdistance = 50000.0,
			Texture = "puff01.dds",
			-- Texture = "puff02.dds",
			
			ColorGradientTexture = "fireGradient01.dds",
			AlphaGradientTexture = "fireGradient01.dds",
			
			Points = 7, -- 2 minimum
			

			Density = 0.15,
			Radius = {4, 40},-- start, finish
			RadiusFactor = 0.75,
			Length = 80,
			TrailSpeedMin = 3,
			HeightFactor = 0.2,
			
			AnimSpeed = 85, -- FPS

			Color = {61/255.0*0.8, 70/255.0*0.8, 73/255.0*0.8},
			Opacity = 0.95,
			Lighting = 0.5,
			
			FlameAttenuation = {-10, 35}, -- meters from smoke start
			FlamePower = 5.0*9,
			FlameFactor = 1.6,
			PositionOffsetLocal = {7.23, -0.75, 6.2},
		}
	},
}

Presets.hugeSmoke = deepcopy(Presets.hugeSmokeWithFire)
Presets.hugeSmoke[1].FlameAttenuation = {-100, -1.0}
Presets.hugeSmoke[1].Light.Radius = 0

Presets.largeSmoke = deepcopy(Presets.largeSmokeWithFire)
Presets.largeSmoke[1].FlameAttenuation = {-100, -1.0}
Presets.largeSmoke[1].Light.Radius = 0

Presets.mediumSmoke = deepcopy(Presets.mediumSmokeWithFire)
Presets.mediumSmoke[1].FlameAttenuation = {-100, -1.0}
Presets.mediumSmoke[1].Light.Radius = 0

Presets.smallSmoke = deepcopy(Presets.smallSmokeWithFire)
Presets.smallSmoke[1].FlameAttenuation = {-100, -1.0}
Presets.smallSmoke[1].Light.Radius = 0



Presets.smokeMarkerBlack = deepcopy(Presets.smallSmoke)
Presets.smokeMarkerBlack[1].Length = 50
Presets.smokeMarkerBlack[1].Radius = {4, 35}
Presets.smokeMarkerBlack[1].PositionOffsetLocal = {0, -1, 0}

Presets.smokeMarkerGreen = deepcopy(Presets.smokeMarkerBlack)
Presets.smokeMarkerGreen[1].Color = {0.5, 0.95, 0.15}

Presets.smokeMarkerOrange = deepcopy(Presets.smokeMarkerGreen)
Presets.smokeMarkerOrange[1].Color = {0.95, 0.6, 0.15}

Presets.smokeMarkerRed = deepcopy(Presets.smokeMarkerGreen)
Presets.smokeMarkerRed[1].Color = {0.85, 0.15, 0.15}