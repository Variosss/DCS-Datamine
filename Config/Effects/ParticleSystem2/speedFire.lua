Effect = {
	{
		Type = "speedFire",
		Texture = "firePuff_03_low2.dds",
		ParticlesLimit = 500,
		
		ColorHot = {1.0, 0.655, 0.4455},
		ColorCold = {1.0, 0.4655, 0.3355},
		
		Radius = 1, -- meters
		ScaleBase = 2.5, --  meters
		Power = 8,
		ConvectionSpeed = { -- speed value by emitter scale
			{1, 3},  
			{5, 12}
		},	
		
		DistMax = {
			{5, 0.06},
			{20, 0.1*0.3},
			{1000, 0.65*0.3},
			{2000, 0.8*0.3}
		},
		
		TrailLength = {
			{5, 4},
			{20, 2},
			{500, 1.5},
			{2000, 1.2}
		},
	}
}

function makeColor(r, g, b)
	f = 1.0 / 255.0
	return {r*f, g*f, b*f}
end

function makePreset()
	p = deepcopy(Effect)
	p[1].HWTech = true
	p[1].ConvectionSpeed = {{1, 0.7}, {2, 0.7}}
	p[1].DistMax = {{1, 0.03}, {2, 0.03}}
	p[1].TrailLength = {{5, 4}, {20, 3}}
	p[1].Power = 0.05
	return p
end

Presets = {}

Presets.red = makePreset()
Presets.red[1].ColorHot  = makeColor(255, 90, 40)
Presets.red[1].ColorCold = makeColor(255, 90*0.75, 40*0.75)

Presets.green = makePreset()
Presets.green[1].ColorHot  = makeColor(90, 255, 40)
Presets.green[1].ColorCold = makeColor(90*0.75, 255, 40*0.75)

Presets.blue = makePreset()
Presets.blue[1].ColorHot  = makeColor(80, 160, 255)
Presets.blue[1].ColorCold = makeColor(80*0.75, 160*0.75, 255)
Presets.blue[1].Power = 0.1

Presets.yellow = makePreset()
Presets.yellow[1].ColorHot  = makeColor(255, 220, 40)
Presets.yellow[1].ColorCold = makeColor(255, 220*0.75, 40)
