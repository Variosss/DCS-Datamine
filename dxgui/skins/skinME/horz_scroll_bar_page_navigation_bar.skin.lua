local skin = {
	["skinData"] = {
		["params"] = {
			["decreaseButtonAlign"] = {
				["type"] = "min",
			},
			["hasButtons"] = false,
			["increaseButtonAlign"] = {
				["type"] = "min",
			},
			["maxSize"] = {
				["horz"] = 0,
				["vert"] = 7,
			},
			["minSize"] = {
				["horz"] = 0,
				["vert"] = 7,
			},
			["textLineHeight"] = 0,
			["textWrapping"] = false,
			["thumbAlign"] = {
				["offset"] = 0,
				["type"] = "middle",
			},
		},
		["skins"] = {
			["thumb"] = "horzScrollBarThumbPageNavigationBarSkin",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xffffffff",
						["center_center"] = "0xb3b3b34d",
						["center_top"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\down.png",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0xffffffff",
						["left_center"] = "0xffffffff",
						["left_top"] = "0xffffffff",
						["rect"] = {
							["x1"] = 0,
							["x2"] = 0,
							["y1"] = 0,
							["y2"] = 0,
						},
						["right_bottom"] = "0xffffffff",
						["right_center"] = "0xffffffff",
						["right_top"] = "0xffffffff",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_center"] = "0x14232eff",
						["insets"] = {
							["bottom"] = "3",
							["left"] = "0",
							["right"] = "0",
							["top"] = "3",
						},
						["rect"] = {
							["x1"] = 0,
							["x2"] = 0,
							["y1"] = 0,
							["y2"] = 0,
						},
					},
				},
			},
		},
		["type"] = "HorzScrollBar",
	},
	["version"] = 1,
}

return skin