local skin = {
	["skinData"] = {
		["params"] = {
			["fillerHorzAlign"] = {
				["type"] = "min",
			},
			["fillerVertAlign"] = {
				["type"] = "stretch",
			},
			["insets"] = {
				["bottom"] = 1,
				["left"] = 1,
				["right"] = 1,
				["top"] = 1,
			},
		},
		["skins"] = {
			["filler"] = {
				["skinData"] = {
					["states"] = {
						["disabled"] = {
							[1] = {
								["bkg"] = {
									["center_bottom"] = "0xb3b3b3ff",
									["center_center"] = "0x83927aff",
									["center_top"] = "0xb3b3b3ff",
									["insets"] = {
										["bottom"] = 1,
										["left"] = 1,
										["right"] = 1,
										["top"] = 1,
									},
									["left_bottom"] = "0xb3b3b3ff",
									["left_center"] = "0xb3b3b3ff",
									["left_top"] = "0xb3b3b3ff",
									["right_bottom"] = "0xb3b3b3ff",
									["right_center"] = "0xb3b3b3ff",
									["right_top"] = "0xb3b3b3ff",
								},
							},
						},
						["released"] = {
							[1] = {
								["bkg"] = {
									["center_bottom"] = "0x60747cff",
									["center_center"] = "0x60747cff",
									["center_top"] = "0x60747cff",
									["insets"] = {
										["bottom"] = "0",
										["left"] = "0",
										["right"] = "1",
										["top"] = "0",
									},
									["left_bottom"] = "0x60747cff",
									["left_center"] = "0x60747cff",
									["left_top"] = "0x60747cff",
									["right_bottom"] = "0x60747cff",
									["right_center"] = "0x000000ff",
									["right_top"] = "0x60747cff",
								},
							},
						},
					},
				},
				["version"] = 1,
			},
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x000000ff",
						["center_center"] = "0xaab99bff",
						["center_top"] = "0x000000ff",
						["file"] = "dxgui\\skins\\skinME\\images\\down.png",
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
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x000000ff",
						["center_center"] = "0x4f5e64ff",
						["center_top"] = "0x000000ff",
						["file"] = "dxgui\\skins\\skinME\\images\\down.png",
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
					["text"] = {
						["color"] = "0xffffffff",
						["font"] = "DejaVuLGCSansCondensed-Bold.ttf",
						["fontSize"] = 12,
						["horzAlign"] = {
							["type"] = "middle",
						},
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["type"] = "middle",
						},
					},
				},
			},
		},
		["type"] = "HorzProgressBar",
	},
	["version"] = 1,
}

return skin