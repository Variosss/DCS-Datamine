local skin = {
	["skinData"] = {
		["params"] = {
			["buttonAlign"] = {
				["type"] = "middle",
			},
			["insets"] = {
				["bottom"] = 1,
				["left"] = 1,
				["right"] = 1,
				["top"] = 1,
			},
			["maxItemCount"] = 10,
		},
		["skins"] = {
			["button"] = "comboListButtonAWACSSkin",
			["listBox"] = "comboListListBoxAWACSSkin",
			["view"] = "comboListViewAWACSSkin",
			["window"] = "comboListWindowAWACSSkin",
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
						["center_bottom"] = "0x8ed8f8ff",
						["center_center"] = "0x313131ff",
						["center_top"] = "0x8ed8f8ff",
						["insets"] = {
							["bottom"] = 1,
							["left"] = 1,
							["right"] = 1,
							["top"] = 1,
						},
						["left_bottom"] = "0x8ed8f8ff",
						["left_center"] = "0x8ed8f8ff",
						["left_top"] = "0x8ed8f8ff",
						["right_bottom"] = "0x8ed8f8ff",
						["right_center"] = "0x8ed8f8ff",
						["right_top"] = "0x8ed8f8ff",
					},
					["text"] = {
						["blur"] = 0,
						["color"] = "0x8ed8f8ff",
						["font"] = "DejaVuLGCSansCondensed.ttf",
						["fontSize"] = 12,
						["lineHeight"] = 0,
					},
				},
			},
		},
	},
}

return skin