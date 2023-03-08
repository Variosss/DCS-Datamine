local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = 0,
				["left"] = 0,
				["right"] = 0,
				["top"] = 0,
			},
		},
		["skins"] = {
			["arrow"] = {
				["skinData"] = {
					["params"] = {
						["maxSize"] = {
							["horz"] = 0,
							["vert"] = 5,
						},
						["minSize"] = {
							["horz"] = 0,
							["vert"] = 5,
						},
					},
					["states"] = {
						["released"] = {
							[1] = {
								["bkg"] = {
									["center_center"] = "0xff0000ff",
								},
								["picture"] = {
									["color"] = "0xffffffff",
									["file"] = "dxgui\\skins\\skinME\\images/dialarrow.png",
									["horzAlign"] = {
										["type"] = "stretch",
									},
									["size"] = {
										["horz"] = 0,
										["vert"] = 0,
									},
									["userTexSampler"] = 0,
									["vertAlign"] = {
										["type"] = "stretch",
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
			["released"] = {
				[1] = {
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images/diallever.png",
						["horzAlign"] = {
							["type"] = "stretch",
						},
						["size"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["userTexSampler"] = 0,
						["vertAlign"] = {
							["type"] = "stretch",
						},
					},
				},
			},
		},
		["type"] = "Dial",
	},
	["version"] = 1,
}

return skin