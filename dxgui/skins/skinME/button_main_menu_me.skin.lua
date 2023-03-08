local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = 1,
				["left"] = 1,
				["right"] = 1,
				["top"] = 1,
			},
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0x808080ff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 19,
						["horzAlign"] = {
							["type"] = "min",
						},
						["lineHeight"] = 0,
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["type"] = "middle",
						},
					},
				},
			},
			["hover"] = {
				[1] = {
					["text"] = {
						["blur"] = 0,
						["color"] = "0x05ace1ff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 19,
						["lineHeight"] = 0,
					},
				},
			},
			["pressed"] = {
				[1] = {
					["bkg"] = {
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0xffffffff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 19,
						["horzAlign"] = {
							["offset"] = 2,
							["type"] = "min",
						},
						["lineHeight"] = 0,
						["vertAlign"] = {
							["offset"] = 2,
							["type"] = "middle",
						},
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["insets"] = {
							["bottom"] = "0",
							["left"] = "0",
							["right"] = "0",
							["top"] = "0",
						},
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0xffffff80",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 19,
						["horzAlign"] = {
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
		["type"] = "Button",
	},
	["version"] = 1,
}

return skin