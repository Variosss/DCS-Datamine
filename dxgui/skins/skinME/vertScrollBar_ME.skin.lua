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
				["bottom"] = "2",
				["left"] = "1",
				["right"] = "1",
				["top"] = "2",
			},
			["maxSize"] = {
				["horz"] = 9,
				["vert"] = 0,
			},
			["minSize"] = {
				["horz"] = 9,
				["vert"] = 0,
			},
			["thumbAlign"] = {
				["type"] = "min",
			},
		},
		["skins"] = {
			["decreaseButton"] = "vertScrollBarDecreaseButtonSkin",
			["increaseButton"] = "vertScrollBarIncreaseButtonSkin",
			["thumb"] = "vertScrollBarThumbSkin",
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
						["center_bottom"] = "0x63686bff",
						["center_center"] = "0x63686bff",
						["center_top"] = "0x63686bff",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0x63686bff",
						["left_center"] = "0x63686bff",
						["left_top"] = "0x63686bff",
						["right_bottom"] = "0x63686bff",
						["right_center"] = "0x63686bff",
						["right_top"] = "0x63686bff",
					},
				},
			},
		},
		["type"] = "VertScrollBar",
	},
	["version"] = 1,
}

return skin