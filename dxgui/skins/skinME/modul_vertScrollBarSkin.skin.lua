local skin = {
	["skinData"] = {
		["params"] = {
			["decreaseButtonAlign"] = {
				["type"] = "min",
			},
			["hasButtons"] = true,
			["increaseButtonAlign"] = {
				["type"] = "min",
			},
			["insets"] = {
				["bottom"] = 2,
				["left"] = 1,
				["right"] = 1,
				["top"] = 2,
			},
			["maxSize"] = {
				["horz"] = 18,
				["vert"] = 0,
			},
			["minSize"] = {
				["horz"] = 18,
				["vert"] = 0,
			},
			["thumbAlign"] = {
				["type"] = "middle",
			},
		},
		["skins"] = {
			["decreaseButton"] = "modul_vertScrollBarDecreaseButtonSkin",
			["increaseButton"] = "modul_vertScrollBarIncreaseButtonSkin",
			["thumb"] = "modul_vertScrollBarThumbSkin",
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
						["center_bottom"] = "0x000000ff",
						["center_center"] = "0x000000ff",
						["center_top"] = "0x000000ff",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0x000000ff",
						["left_center"] = "0x000000ff",
						["left_top"] = "0x000000ff",
						["right_bottom"] = "0x000000ff",
						["right_center"] = "0x000000ff",
						["right_top"] = "0x000000ff",
					},
				},
			},
		},
		["type"] = "VertScrollBar",
	},
	["version"] = 1,
}

return skin