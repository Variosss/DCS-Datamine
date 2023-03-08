local diff = {
	["axisDiffs"] = {
		["a2001cdnil"] = {
			["name"] = "Pitch",
			["removed"] = {
				[1] = {
					["key"] = "JOY_Y",
				},
			},
		},
		["a2002cdnil"] = {
			["name"] = "Roll",
			["removed"] = {
				[1] = {
					["key"] = "JOY_X",
				},
			},
		},
		["a2003cdnil"] = {
			["changed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.03,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RZ",
				},
			},
			["name"] = "Rudder",
		},
		["a2033cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.03,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 0.4,
						["slider"] = false,
					},
					["key"] = "JOY_X",
				},
			},
			["name"] = "HOTAS Slew Horizontal",
		},
		["a2034cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.03,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 0.4,
						["slider"] = false,
					},
					["key"] = "JOY_Y",
				},
			},
			["name"] = "HOTAS Slew Vertical",
		},
	},
	["keyDiffs"] = {
		["d179pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN1",
				},
			},
			["name"] = "Communication menu",
		},
		["d350pnilu351cdnilvdnilvpnilvunil"] = {
			["name"] = "Weapon release",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN2",
				},
			},
		},
		["d539pnilu543cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_U",
				},
			},
			["name"] = "HOTAS Coolie Switch Up",
		},
		["d540pnilu543cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_D",
				},
			},
			["name"] = "HOTAS Coolie Switch Down",
		},
		["d541pnilu543cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
				},
			},
			["name"] = "HOTAS Coolie Switch Left",
		},
		["d542pnilu543cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
				},
			},
			["name"] = "HOTAS Coolie Switch Right",
		},
		["d554pnilu638cdnilvdnilvpnilvunil"] = {
			["name"] = "Gun Trigger",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN1",
				},
			},
		},
		["d562pnilu606cdnilvdnilvpnilvunil"] = {
			["name"] = "HOTAS Nosewheel Steering Button",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
		},
		["d563pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
			["name"] = "HOTAS Boat Switch Forward",
		},
		["d564pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
			["name"] = "HOTAS Boat Switch Aft",
		},
		["d565pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
			["name"] = "HOTAS Boat Switch Center",
		},
		["d566pnilu589cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
			["name"] = "HOTAS China Hat Forward",
		},
		["d567pnilu589cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
			["name"] = "HOTAS China Hat Aft",
		},
		["d571pnilu1557cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN2",
				},
			},
			["name"] = "HOTAS Left Throttle Button",
		},
		["d68pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN3",
				},
			},
			["name"] = "Landing Gear Up/Down",
		},
		["d957pnilu958cdnilvdnilvpnilvunil"] = {
			["name"] = "Stick to trimmer control mode",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN3",
				},
			},
		},
		["dnilp32u214cdnilvdnilvpnilvunil"] = {
			["name"] = "View Left slow",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
				},
			},
		},
		["dnilp33u214cdnilvdnilvpnilvunil"] = {
			["name"] = "View Right slow",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
				},
			},
		},
		["dnilp34u214cdnilvdnilvpnilvunil"] = {
			["name"] = "View Up slow",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_U",
				},
			},
		},
		["dnilp35u214cdnilvdnilvpnilvunil"] = {
			["name"] = "View Down slow",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_D",
				},
			},
		},
		["dnilp36unilcdnilvdnilvpnilvunil"] = {
			["name"] = "View Center",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
		},
	},
}
return diff