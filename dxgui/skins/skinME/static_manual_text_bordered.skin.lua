local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = "4",
				["left"] = "20",
				["right"] = "4",
				["top"] = "4",
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
					["bkg"] = {
						["center_bottom"] = "0x933634ff",
						["center_top"] = "0x933634ff",
						["insets"] = {
							["bottom"] = "2",
							["left"] = "2",
							["right"] = "2",
							["top"] = "2",
						},
						["left_bottom"] = "0x933634ff",
						["left_center"] = "0x933634ff",
						["left_top"] = "0x933634ff",
						["right_bottom"] = "0x933634ff",
						["right_center"] = "0x933634ff",
						["right_top"] = "0x933634ff",
					},
					["text"] = {
						["color"] = "0xd2d3cbff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 18,
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