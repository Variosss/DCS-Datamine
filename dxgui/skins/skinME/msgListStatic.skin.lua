local skin = {
	["skinData"] = {
		["params"] = {
			["textLineHeight"] = 0,
			["textWrapping"] = false,
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
					["bkg"] = {
						["center_center"] = "0x00000030",
					},
					["picture"] = {
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0xffffffff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 16,
						["horzAlign"] = {
							["offset"] = 20,
							["type"] = "min",
						},
						["shadowColor"] = "0x00000000",
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 3,
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