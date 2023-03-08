local skin = {
	["skinData"] = {
		["params"] = {
			["textLineHeight"] = 0,
			["textWrapping"] = false,
		},
		["states"] = {
			["disabled"] = {
				[1] = {
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
							["offset"] = 0,
							["type"] = "min",
						},
					},
				},
			},
			["released"] = {
				[1] = {
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\background-details-1.png",
						["rect"] = {
							["x1"] = "0",
							["x2"] = "0",
							["y1"] = "0",
							["y2"] = "0",
						},
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0xffffffff",
						["font"] = "DejaVuLGCSans-BoldOblique.ttf",
						["fontSize"] = 23,
						["horzAlign"] = {
							["offset"] = -40,
							["type"] = "max",
						},
						["lineHeight"] = 0,
						["shadowOffset"] = {
							["horz"] = 0,
							["vert"] = 0,
						},
						["vertAlign"] = {
							["offset"] = 0,
							["type"] = "middle",
						},
					},
				},
			},
		},
		["type"] = "Static",
	},
	["version"] = 1,
}

return skin