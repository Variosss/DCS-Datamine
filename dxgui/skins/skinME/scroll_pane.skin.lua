local skin = {
	["skinData"] = {
		["params"] = {
			["horzScrollBarHeight"] = 30,
			["insets"] = {
				["bottom"] = 1,
				["left"] = 1,
				["right"] = 1,
				["top"] = 1,
			},
			["pixelsPerWheelClick"] = 20,
			["vertScrollBarWidth"] = 30,
		},
		["skins"] = {
			["horzScrollBar"] = "horzScrollBarSkin",
			["vertScrollBar"] = "vertScrollBarSkinSV",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xccccccff",
						["center_top"] = "0xccccccff",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0xccccccff",
						["left_center"] = "0xccccccff",
						["left_top"] = "0xccccccff",
						["right_bottom"] = "0xccccccff",
						["right_center"] = "0xccccccff",
						["right_top"] = "0xccccccff",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x000000ff",
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
		["type"] = "ScrollPane",
	},
	["version"] = 1,
}

return skin