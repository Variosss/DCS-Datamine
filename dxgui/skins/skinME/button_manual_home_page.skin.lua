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
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\manual\\btn_L_dblar_disable.png",
						["horzAlign"] = {
							["type"] = "middle",
						},
					},
					["text"] = {
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
						["file"] = "dxgui\\skins\\skinME\\images\\manual\\btn_L_dblar_hover.png",
						["horzAlign"] = {
							["type"] = "middle",
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
						["file"] = "dxgui\\skins\\skinME\\images\\manual\\btn_L_dblar_pressed.png",
						["horzAlign"] = {
							["type"] = "middle",
						},
					},
				},
			},
			["released"] = {
				[1] = {
					["bkg"] = {
						["insets"] = {
							["bottom"] = "0",
							["left"] = "0",
							["right"] = "0",
							["top"] = "0",
						},
					},
					["picture"] = {
						["color"] = "0xffffffff",
						["file"] = "dxgui\\skins\\skinME\\images\\manual\\btn_L_dblar_released.png",
						["horzAlign"] = {
							["type"] = "middle",
						},
					},
					["text"] = {
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