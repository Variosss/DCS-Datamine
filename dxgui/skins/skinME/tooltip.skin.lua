local skin = {
	["skinData"] = {
		["params"] = {
			["duration"] = 5,
			["insets"] = {
				["bottom"] = 4,
				["left"] = 2,
				["right"] = 4,
				["top"] = 2,
			},
			["offset"] = {
				["horz"] = 0,
				["vert"] = 20,
			},
			["startTime"] = 0.5,
			["textLineHeight"] = 0,
		},
		["states"] = {
			["released"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0x000000ff",
						["center_center"] = "0xffffe1ff",
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
					["text"] = {
						["blur"] = 0,
						["color"] = "0x000000ff",
						["font"] = "DejaVuLGCSans.ttf",
						["fontSize"] = 11,
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