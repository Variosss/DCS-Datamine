local diff = {
	["axisDiffs"] = {
		["a2012cdnil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_SLIDER1",
				},
			},
			["name"] = "Zoom View",
		},
		["a2087cdnil"] = {
			["changed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_Z",
				},
			},
			["name"] = "Flight Control Collective",
		},
		["a3026cd3"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_RZ",
				},
			},
			["name"] = "Throttle",
			["removed"] = {
				[1] = {
					["key"] = "JOY_SLIDER1",
				},
			},
		},
	},
	["keyDiffs"] = {
		["d201pnilu202cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
				},
			},
			["name"] = "Rudder left",
		},
		["d203pnilu204cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
				},
			},
			["name"] = "Rudder right",
		},
		["d511pnilu515cdnilvdnilvpnilvunil"] = {
			["name"] = "Search light Left",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
				},
			},
		},
		["d512pnilu515cdnilvdnilvpnilvunil"] = {
			["name"] = "Search light Right",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
				},
			},
		},
	},
}
return diff