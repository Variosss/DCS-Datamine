local skin = {
	["skinData"] = {
		["params"] = {
			["decreaseButtonAlign"] = {
				["offset"] = 0,
				["type"] = "min",
			},
			["hasButtons"] = true,
			["increaseButtonAlign"] = {
				["offset"] = 0,
				["type"] = "min",
			},
			["insets"] = {
				["bottom"] = "1",
				["left"] = "1",
				["right"] = "1",
				["top"] = "1",
			},
			["maxSize"] = {
				["horz"] = 0,
				["vert"] = 19,
			},
			["minSize"] = {
				["horz"] = 0,
				["vert"] = 19,
			},
			["thumbAlign"] = {
				["type"] = "min",
			},
		},
		["skins"] = {
			["decreaseButton"] = "horzScrollBarDecreaseButtonSimSkin",
			["increaseButton"] = "horzScrollBarIncreaseButtonSimSkin",
			["thumb"] = "horzScrollBarThumbSimSkin",
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
						["right_bottom"] = "0xffffffff",
						["right_center"] = "0xffffffff",
						["right_top"] = "0xffffffff",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xbebe64ff",
						["center_top"] = "0xbebe64ff",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0xbebe64ff",
						["left_center"] = "0xbebe64ff",
						["left_top"] = "0xbebe64ff",
						["right_bottom"] = "0xbebe64ff",
						["right_center"] = "0xbebe64ff",
						["right_top"] = "0xbebe64ff",
					},
				},
			},
		},
		["type"] = "HorzScrollBar",
	},
	["version"] = 1,
}

return skin