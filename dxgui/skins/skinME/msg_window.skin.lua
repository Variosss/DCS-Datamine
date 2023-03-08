local skin = {
	["skinData"] = {
		["params"] = {
			["buttonSize"] = {
				["horz"] = 100,
				["vert"] = 30,
			},
			["buttonToBottomGap"] = 10,
			["buttonsGap"] = 10,
			["captionToButtonGap"] = 10,
			["headerHeight"] = 20,
			["headerToCaptionGap"] = 10,
			["insets"] = {
				["bottom"] = 0,
				["left"] = 0,
				["right"] = 0,
				["top"] = 0,
			},
			["leftGap"] = 10,
			["pictureSize"] = {
				["horz"] = 64,
				["vert"] = 64,
			},
			["pictureToCaptionGap"] = 5,
			["rightGap"] = 10,
		},
		["skins"] = {
			["button"] = {
				["skinData"] = {
					["params"] = {
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
					},
					["states"] = {
						["disabled"] = {
							[1] = {
								["bkg"] = {
									["center_bottom"] = "0xb3b3b34d",
									["center_center"] = "0xb3b3b34d",
									["center_top"] = "0xb3b3b34d",
									["file"] = "dxgui\\skins\\skinME\\images/up.png",
									["insets"] = {
										["bottom"] = 1,
										["left"] = 1,
										["right"] = 1,
										["top"] = 1,
									},
									["left_bottom"] = "0xb3b3b34d",
									["left_center"] = "0xb3b3b34d",
									["left_top"] = "0xb3b3b34d",
									["right_bottom"] = "0xb3b3b34d",
									["right_center"] = "0xb3b3b34d",
									["right_top"] = "0xb3b3b34d",
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0x808080ff",
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
						["pressed"] = {
							[1] = {
								["bkg"] = {
									["center_bottom"] = "0xffffffff",
									["center_center"] = "0xffffffff",
									["center_top"] = "0xffffffff",
									["file"] = "dxgui\\skins\\skinME\\images/down.png",
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
									["center_bottom"] = "0xffffffff",
									["center_center"] = "0xb1bfc0ff",
									["center_top"] = "0xffffffff",
									["file"] = "dxgui\\skins\\skinME\\images/up.png",
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
								["text"] = {
									["blur"] = 0,
									["color"] = "0x465041ff",
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
				},
			},
			["caption"] = {
				["skinData"] = {
					["states"] = {
						["disabled"] = {
							[1] = {
								["text"] = {
									["blur"] = 0,
									["color"] = "0xffffffff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 14,
									["horzAlign"] = {
										["type"] = "min",
									},
									["lineThroughHeight"] = 1,
									["lineThroughOffset"] = 0,
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
								["text"] = {
									["blur"] = 0,
									["color"] = "0xffffffff",
									["font"] = "DejaVuLGCSansCondensed.ttf",
									["fontSize"] = 14,
									["horzAlign"] = {
										["type"] = "min",
									},
									["lineThroughHeight"] = 1,
									["lineThroughOffset"] = 0,
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
			["header"] = {
				["skinData"] = {
					["params"] = {
						["insets"] = {
							["bottom"] = 2,
							["left"] = 2,
							["right"] = 2,
							["top"] = 2,
						},
					},
					["skins"] = {
						["closeButton"] = {
							["skinData"] = {
								["params"] = {
									["maxSize"] = {
										["horz"] = 10,
										["vert"] = 10,
									},
									["minSize"] = {
										["horz"] = 10,
										["vert"] = 10,
									},
								},
								["states"] = {
									["disabled"] = {
										[1] = {
											["picture"] = {
												["color"] = "0xffffffff",
												["file"] = "dxgui\\skins\\skinME\\images\\btn-tools-01.png",
												["horzAlign"] = {
													["type"] = "min",
												},
												["rect"] = {
													["x1"] = 484,
													["x2"] = 494,
													["y1"] = 4,
													["y2"] = 14,
												},
												["size"] = {
													["horz"] = 10,
													["vert"] = 10,
												},
												["userTexSampler"] = 0,
												["vertAlign"] = {
													["type"] = "min",
												},
											},
										},
									},
									["hover"] = {
										[1] = {
											["picture"] = {
												["color"] = "0xffffffff",
												["file"] = "dxgui\\skins\\skinME\\images\\btn-tools-01.png",
												["horzAlign"] = {
													["type"] = "min",
												},
												["rect"] = {
													["x1"] = 484,
													["x2"] = 494,
													["y1"] = 4,
													["y2"] = 14,
												},
												["size"] = {
													["horz"] = 10,
													["vert"] = 10,
												},
												["userTexSampler"] = 0,
												["vertAlign"] = {
													["type"] = "min",
												},
											},
										},
									},
									["pressed"] = {
										[1] = {
											["picture"] = {
												["color"] = "0xffffffff",
												["file"] = "dxgui\\skins\\skinME\\images\\btn-tools-01.png",
												["horzAlign"] = {
													["type"] = "min",
												},
												["rect"] = {
													["x1"] = 484,
													["x2"] = 494,
													["y1"] = 22,
													["y2"] = 32,
												},
												["size"] = {
													["horz"] = 10,
													["vert"] = 10,
												},
												["userTexSampler"] = 0,
												["vertAlign"] = {
													["type"] = "min",
												},
											},
										},
									},
									["released"] = {
										[1] = {
											["picture"] = {
												["color"] = "0xffffffff",
												["file"] = "dxgui\\skins\\skinME\\images\\btn-tools-01.png",
												["horzAlign"] = {
													["type"] = "min",
												},
												["rect"] = {
													["x1"] = 484,
													["x2"] = 494,
													["y1"] = 4,
													["y2"] = 14,
												},
												["size"] = {
													["horz"] = 10,
													["vert"] = 10,
												},
												["userTexSampler"] = 0,
												["vertAlign"] = {
													["type"] = "min",
												},
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
									["center_center"] = "0x000000ff",
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0x808080ff",
									["font"] = "DejaVuLGCSansCondensed-BoldOblique.ttf",
									["fontSize"] = 12,
									["horzAlign"] = {
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
								["bkg"] = {
									["center_center"] = "0x000000ff",
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0xffffffff",
									["font"] = "DejaVuLGCSansCondensed-BoldOblique.ttf",
									["fontSize"] = 12,
									["horzAlign"] = {
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
									["center_center"] = "0x000000ff",
								},
								["text"] = {
									["blur"] = 0,
									["color"] = "0xffffffff",
									["font"] = "DejaVuLGCSansCondensed-BoldOblique.ttf",
									["fontSize"] = 12,
									["horzAlign"] = {
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
		},
		["states"] = {
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x000000ff",
						["center_center"] = "0x788990ff",
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
	},
	["version"] = 1,
}

return skin