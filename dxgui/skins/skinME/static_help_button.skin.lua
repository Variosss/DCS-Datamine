local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["left"] = 13,
				["right"] = 13,
			},
			["minSize"] = {
				["vert"] = 48,
			},
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
						["center_top"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinme\\images\\button_help.png",
						["insets"] = {
							["left"] = 13,
							["right"] = 13,
							["top"] = 48,
						},
						["left_top"] = "0xffffffff",
						["rect"] = {
							["x1"] = 0,
						},
						["right_top"] = "0xffffffff",
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0x000000dc",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 24,
						["horzAlign"] = {
							["type"] = "middle",
						},
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = -4,
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