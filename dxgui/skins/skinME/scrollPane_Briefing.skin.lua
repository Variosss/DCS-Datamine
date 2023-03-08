local skin = {
	["skinData"] = {
		["params"] = {
			["horzScrollBarHeight"] = 30,
			["insets"] = {
				["bottom"] = "0",
				["left"] = 0,
				["right"] = 0,
				["top"] = "0",
			},
			["maxSize"] = {
				["horz"] = 0,
				["vert"] = 0,
			},
			["minSize"] = {
				["horz"] = 0,
				["vert"] = 0,
			},
			["pixelsPerWheelClick"] = 20,
			["textLineHeight"] = 0,
			["textWrapping"] = false,
			["vertScrollBarWidth"] = 30,
		},
		["skins"] = {
			["horzScrollBar"] = "horzScrollBarSkin_SV",
			["vertScrollBar"] = "vertScrollBarSkinSV",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x00000000",
						["center_center"] = "0x6d7376ff",
						["center_top"] = "0x00000000",
						["file"] = "",
						["insets"] = {
							["bottom"] = 0,
							["left"] = 0,
							["right"] = 0,
							["top"] = 0,
						},
						["left_bottom"] = "0x00000000",
						["left_center"] = "0x00000000",
						["left_top"] = "0x00000000",
						["rect"] = {
							["x1"] = 0,
							["x2"] = 0,
							["y1"] = 0,
							["y2"] = 0,
						},
						["right_bottom"] = "0x00000000",
						["right_center"] = "0x00000000",
						["right_top"] = "0x00000000",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["insets"] = {
							["right"] = 0,
						},
						["rect"] = {
							["x1"] = 0,
							["x2"] = 0,
							["y1"] = 0,
							["y2"] = 0,
						},
					},
					["text"] = {
						["vertAlign"] = {
							["type"] = "min",
						},
					},
				},
			},
		},
		["type"] = "ScrollPane",
	},
	["version"] = 1,
}

return skin