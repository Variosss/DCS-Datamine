local skin = {
	["skinData"] = {
		["params"] = {
			["textLineHeight"] = 0,
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
						["color"] = "0xffffffff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 12,
						["horzAlign"] = {
							["offset"] = 20,
							["type"] = "min",
						},
						["lineHeight"] = 0,
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 0,
							["type"] = "middle",
						},
					},
				},
			},
		},
		["type"] = "Static",
	},
	["version"] = 1,
}

return skin