local skin = {
	["skinData"] = {
		["params"] = {
			["decreaseButtonAlign"] = {
				["offset"] = 1,
				["type"] = "min",
			},
			["hasButtons"] = false,
			["increaseButtonAlign"] = {
				["offset"] = 1,
				["type"] = "min",
			},
			["insets"] = {
				["bottom"] = "0",
				["left"] = "1",
				["right"] = "0",
				["top"] = "0",
			},
			["maxSize"] = {
				["horz"] = 20,
				["vert"] = 0,
			},
			["minSize"] = {
				["horz"] = 20,
				["vert"] = 0,
			},
			["thumbAlign"] = {
				["type"] = "min",
			},
		},
		["skins"] = {
			["decreaseButton"] = "vertScrollBarDecreaseButtonSkin",
			["increaseButton"] = "vertScrollBarIncreaseButtonSkin",
			["thumb"] = "vertScrollBarThumbNewsSkin",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xffffffff",
						["center_center"] = "0xffffffff",
						["center_top"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\news_scroll.png",
						["insets"] = {
							["bottom"] = "2",
							["left"] = "27",
							["right"] = "0",
							["top"] = "2",
						},
						["left_bottom"] = "0xffffffff",
						["left_center"] = "0xffffffff",
						["left_top"] = "0xffffffff",
						["rect"] = {
							["x1"] = "0",
							["x2"] = "14",
							["y1"] = "24",
							["y2"] = "29",
						},
						["right_bottom"] = "0xffffffff",
						["right_center"] = "0xffffffff",
						["right_top"] = "0xffffffff",
					},
				},
			},
		},
		["type"] = "VertScrollBar",
	},
	["version"] = 1,
}

return skin