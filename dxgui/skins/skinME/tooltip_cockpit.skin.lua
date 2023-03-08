local skin = {
	["skinData"] = {
		["params"] = {
			["duration"] = 3,
			["insets"] = {
				["bottom"] = 2,
				["left"] = 4,
				["right"] = 4,
				["top"] = 2,
			},
			["offset"] = {
				["horz"] = 0,
				["vert"] = 20,
			},
			["startTime"] = 0.6,
			["textLineHeight"] = 0,
			["textWrapping"] = false,
		},
		["states"] = {
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_center"] = "0xfff4ba96",
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0x000000ff",
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
		["type"] = "Tooltip",
	},
	["version"] = 1,
}

return skin