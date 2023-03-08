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
				["left"] = "0",
				["right"] = "0",
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
			["thumbAlign"] = {
				["type"] = "min",
			},
		},
		["skins"] = {
			["decreaseButton"] = "vertScrollBarDecreaseButtonSkin",
			["increaseButton"] = "vertScrollBarIncreaseButtonSkin",
			["thumb"] = "comboListVertScrollBarThumbSkin",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_center"] = "0xb3b3b34d",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_center"] = "0x0000003c",
						["insets"] = {
							["bottom"] = "0",
							["left"] = "0",
							["right"] = "0",
							["top"] = "0",
						},
					},
				},
			},
		},
	},
	["version"] = 1,
}

return skin