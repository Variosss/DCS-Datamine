local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = "0",
				["left"] = "0",
				["right"] = "0",
				["top"] = "0",
			},
			["thumbAlign"] = {
				["type"] = "min",
			},
		},
		["skins"] = {
			["thumb"] = "horzSliderThumbOptionsPanelSkin",
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
					},
					["picture"] = {
						["color"] = "0x7c7f6eff",
						["file"] = "white.png",
						["horzAlign"] = {
							["type"] = "stretch",
						},
						["rect"] = {
							["x1"] = "0",
							["x2"] = "1",
							["y1"] = "0",
							["y2"] = "1",
						},
						["size"] = {
							["horz"] = 1,
							["vert"] = 1,
						},
						["vertAlign"] = {
							["type"] = "middle",
						},
					},
				},
			},
		},
		["type"] = "HorzSlider",
	},
	["version"] = 1,
}

return skin