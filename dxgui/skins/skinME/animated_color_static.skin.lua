local skin = {
	["skinData"] = {
		["params"] = {
			["textWrapping"] = false,
			["textColorAppearDuration"] = 0.5,
			["textColorShowDuration"] = 5,
			["textColorDisappearDuration"] = 3,
			["imageColorAppearDuration"] = 1,
			["imageColorShowDuration"] = 5,
			["imageColorDisappearDuration"] = 3,						
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["text"] = {
						["blur"] = 0,
						["color"] = "0x808080ff",
						["font"] = "DejaVuLGCSansCondensed-BoldOblique.ttf",
						["fontSize"] = 12,
						["horzAlign"] = {
							["type"] = "min",
						},
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 0,
							["type"] = "min",
						},
					},
				},
			},
			["released"] = {
				[1] = {
					["text"] = {
						["blur"] = 0,
						["color"] = "0xbec0afff",
						["font"] = "DejaVuLGCSansCondensed-BoldOblique.ttf",
						["fontSize"] = 12,
						["horzAlign"] = {
							["type"] = "min",
						},
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 0,
							["type"] = "min",
						},
					},
				},
			},
		},
		["type"] = "AnimatedColorStatic",
	},
	["version"] = 1,
}

return skin