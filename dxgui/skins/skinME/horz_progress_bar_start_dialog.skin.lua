local skin = {
	["skinData"] = {
		["base"] = "horzProgressBarSkin",
		["params"] = {
			["fillerHorzAlign"] = {
				["offset"] = 1,
				["type"] = "min",
			},
			["fillerVertAlign"] = {
				["offset"] = 0,
				["type"] = "middle",
			},
			["insets"] = {
				["bottom"] = "1",
				["left"] = "1",
				["right"] = "1",
				["top"] = "1",
			},
			["params"] = {
			},
			["skins"] = {
				["filler"] = {
					["skinData"] = {
						["params"] = {
						},
						["states"] = {
							["released"] = {
								[1] = {
									["bkg"] = {
										["center_center"] = "0x60747cff",
										["insets"] = {
											["bottom"] = "0",
											["left"] = "1",
											["right"] = "1",
											["top"] = "0",
										},
										["left_center"] = "0x000000ff",
										["right_center"] = "0x000000ff",
									},
								},
							},
						},
					},
				},
			},
			["states"] = {
				["released"] = {
					[1] = {
						["bkg"] = {
							["center_center"] = "0x4f5e64ff",
						},
						["text"] = {
							["color"] = "0xffffffff",
						},
					},
				},
			},
		},
		["skins"] = {
			["filler"] = "horzProgressBarFillerStartDialogSkin",
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xffffffff",
						["center_center"] = "0xaab99bff",
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
						["center_center"] = "0x000000ff",
					},
					["picture"] = {
						["color"] = "0xffffff5f",
						["file"] = "dxgui\\skins\\common\\images\\progressbar_base.png",
						["horzAlign"] = {
							["offset"] = 0,
							["type"] = "min",
						},
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0xffffff8c",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 14,
						["horzAlign"] = {
							["offset"] = 7,
							["type"] = "middle",
						},
						["lineHeight"] = 0,
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 25,
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