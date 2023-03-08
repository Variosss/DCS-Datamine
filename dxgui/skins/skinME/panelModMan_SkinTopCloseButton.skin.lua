local skin = {
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
			["hover"] = {
				[1] = {
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\Keys-v2.png",
						["rect"] = {
							["x1"] = "20",
							["x2"] = "40",
							["y1"] = "0",
							["y2"] = "20",
						},
					},
				},
			},
			["pressed"] = {
				[1] = {
					["bkg"] = {
					},
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\Keys-v2.png",
						["rect"] = {
							["x1"] = "20",
							["x2"] = "40",
							["y1"] = "0",
							["y2"] = "20",
						},
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
					},
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\Keys-v2.png",
						["rect"] = {
							["x1"] = "0",
							["x2"] = "20",
							["y1"] = "0",
							["y2"] = "20",
						},
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
		["type"] = "Button",
	},
	["version"] = 1,
}

return skin