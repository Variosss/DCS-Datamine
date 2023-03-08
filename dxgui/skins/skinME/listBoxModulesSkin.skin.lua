local skin = {
	["skinData"] = {
		["params"] = {
			["horzScrollBarHeight"] = 30,
			["insets"] = {
				["bottom"] = 0,
				["left"] = 1,
				["right"] = 0,
				["top"] = 0,
			},
			["itemHeight"] = 48,
			["itemsPerWheelClick"] = 3,
			["vertScrollBarWidth"] = 11,
		},
		["skins"] = {
			["horzScrollBar"] = "horzScrollBarSkin_SV",
			["item"] = {
				["skinData"] = {
					["params"] = {
					},
					["states"] = {
						["disabled"] = {
							[1] = {
								["text"] = {
									["blur"] = 0,
									["color"] = "0x808080ff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 11,
									["horzAlign"] = {
										["offset"] = 20,
										["type"] = "min",
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
						["hover"] = {
							[1] = {
								["bkg"] = {
									["center_center"] = "0x46504132",
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0x000000ff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 11,
									["horzAlign"] = {
										["offset"] = 20,
										["type"] = "min",
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
						["released"] = {
							[1] = {
								["picture"] = {
									["color"] = "0xffffffff",
									["horzAlign"] = {
										["offset"] = 2,
										["type"] = "min",
									},
									["size"] = {
										["horz"] = 16,
										["vert"] = 16,
									},
									["userTexSampler"] = 0,
									["vertAlign"] = {
										["type"] = "middle",
									},
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0x000000ff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 11,
									["horzAlign"] = {
										["offset"] = 20,
										["type"] = "min",
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
							[2] = {
								["bkg"] = {
									["center_center"] = "0x46504164",
								},
								["picture"] = {
									["color"] = "0xffffffff",
									["horzAlign"] = {
										["offset"] = 2,
										["type"] = "min",
									},
									["size"] = {
										["horz"] = 16,
										["vert"] = 16,
									},
									["userTexSampler"] = 0,
									["vertAlign"] = {
										["type"] = "middle",
									},
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0x000000ff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 11,
									["horzAlign"] = {
										["offset"] = 20,
										["type"] = "min",
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
				},
			},
			["vertScrollBar"] = "vertScrollBarSkinSV",
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
						["center_bottom"] = "0x36393cff",
						["center_center"] = "0x36393cff",
						["center_top"] = "0x36393cff",
						["left_bottom"] = "0x36393cff",
						["left_center"] = "0x36393cff",
						["left_top"] = "0x36393cff",
						["rect"] = {
							["x1"] = 0,
							["x2"] = 0,
							["y1"] = 0,
							["y2"] = 0,
						},
						["right_bottom"] = "0x36393cff",
						["right_center"] = "0x36393cff",
						["right_top"] = "0x36393cff",
					},
				},
			},
		},
		["type"] = "ListBox",
	},
}

return skin