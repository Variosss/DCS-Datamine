local skin = {
	["skinData"] = {
		["params"] = {
			["insets"] = {
				["bottom"] = 0,
				["left"] = 0,
				["right"] = 0,
				["top"] = 0,
			},
			["maxSize"] = {
				["horz"] = 40,
				["vert"] = 21,
			},
			["minSize"] = {
				["horz"] = 40,
				["vert"] = 21,
			},
		},
		["states"] = {
			["disabled"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xb3b3b34d",
						["center_center"] = "0xb3b3b34d",
						["center_top"] = "0xb3b3b34d",
						["file"] = "dxgui\\skins\\skinME\\images\\up.png",
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
			["focused"] = {
			},
			["hover"] = {
				[1] = {
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinme\\images\\buttons\\drm_hover.png",
					},
				},
			},
			["pressed"] = {
				[1] = {
					["bkg"] = {
						["center_bottom"] = "0xffffffff",
						["center_top"] = "0xffffffff",
						["left_bottom"] = "0xffffffff",
						["left_center"] = "0xffffffff",
						["left_top"] = "0xffffffff",
						["right_bottom"] = "0xffffffff",
						["right_center"] = "0xffffffff",
						["right_top"] = "0xffffffff",
					},
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinme\\images\\buttons\\drm_pressed.png",
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["insets"] = {
							["bottom"] = 0,
							["left"] = 0,
							["right"] = 0,
							["top"] = 0,
						},
					},
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinme\\images\\buttons\\drm_neutral.png",
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