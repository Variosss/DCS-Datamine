local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = "0",
				["left"] = "20",
				["right"] = "0",
				["top"] = "0",
			},
			["minSize"] = {
				["horz"] = 0,
			},
			["textLineHeight"] = 0,
			["textWrapping"] = true,
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["text"] = {
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
						["color"] = "0xed1c24ff",
						["font"] = "DejaVuLGCSans-Bold.ttf",
						["fontSize"] = 36,
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
							["type"] = "min",
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