local diff = {
	["axisDiffs"] = {
		["a2004cdnil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_RZ",
				},
			},
			["name"] = "Throttle",
		},
		["a2033cdnil"] = {
			["name"] = "Absolute SHKVAL Horizontal Slew",
			["removed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0.1,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 0.15,
						["slider"] = false,
					},
					["key"] = "JOY_X",
				},
			},
		},
		["a2034cdnil"] = {
			["name"] = "Absolute SHKVAL Vertical Slew",
			["removed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0.1,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 0.15,
						["slider"] = false,
					},
					["key"] = "JOY_Y",
				},
			},
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
		["a2101cdnil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_SLIDER1",
				},
			},
			["name"] = "Wheel Brake",
		},
	},
	["keyDiffs"] = {
		["d103pnilunilcdnilvdnilvpnilvunil"] = {
			["name"] = "Shkval Narrow View 23x",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN11",
				},
			},
		},
		["d104pnilunilcdnilvdnilvpnilvunil"] = {
			["name"] = "Shkval Wide View 7x",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
		},
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
		["d350pnilu351cdnilvdnilvpnilvunil"] = {
			["name"] = "Release weapons",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN2",
				},
			},
		},
		["d412pnilu414cdnilvdnilvpnilvunil"] = {
			["name"] = "TV Target frame Increase size",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
		},
		["d413pnilu414cdnilvdnilvpnilvunil"] = {
			["name"] = "TV Target frame Decrease size",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
		},
		["d506pnilunilcdnilvdnilvpnilvunil"] = {
			["name"] = "Engage/Disengage Route Mode",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN9",
				},
			},
		},
		["d507pnilu508cdnilvdnilvpnilvunil"] = {
			["name"] = "Engage Descent Mode",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
		},
		["d509pnilu510cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN1",
				},
			},
			["name"] = "Lock target",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
		},
		["d511pnilu380cdnilvdnilvpnilvunil"] = {
			["name"] = "Spot light left",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN3",
				},
			},
		},
		["d512pnilu380cdnilvdnilvpnilvunil"] = {
			["name"] = "Spot light right",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
		},
		["d513pnilu515cdnilvdnilvpnilvunil"] = {
			["name"] = "Spot light up",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN6",
				},
			},
		},
		["d514pnilu515cdnilvdnilvpnilvunil"] = {
			["name"] = "Spot light down",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
		},
		["d537pnilu385cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
			["name"] = "Hover On/Off",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN3",
					["reformers"] = {
						[1] = "LAlt",
					},
				},
			},
		},
		["d824pnilu381cdnilvdnilvpnilvunil"] = {
			["name"] = "Weapon selection inward stations",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
				},
			},
		},
		["d825pnilu381cdnilvdnilvpnilvunil"] = {
			["name"] = "Weapon selection outward stations",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
				},
			},
		},
		["d826pnilu382cdnilvdnilvpnilvunil"] = {
			["name"] = "Weapon selection all stations",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_D",
				},
			},
		},
		["d827pnilu382cdnilvdnilvpnilvunil"] = {
			["name"] = "Weapon selection A-A mode",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_U",
				},
			},
		},
		["d84pnilu85cdnilvdnilvpnilvunil"] = {
			["name"] = "Gun fire",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN1",
				},
			},
		},
		["d853pnilunilcdnilvdnilvpnilvunil"] = {
			["name"] = "Readjust Free Turbine RPM to Nominal",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN13",
				},
			},
		},
		["d854pnilunilcdnilvdnilvpnilvunil"] = {
			["name"] = "Readjust Free Turbine RPM to Low",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
		},
		["d979pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
			["name"] = "Switch dialog",
		},
		["dnilp88u235cdnilvdnilvpnilvunil"] = {
			["name"] = "KU-31 Shkval slew left",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_L",
					["reformers"] = {
						[1] = "RAlt",
					},
				},
			},
		},
		["dnilp89u235cdnilvdnilvpnilvunil"] = {
			["name"] = "KU-31 Shkval slew right",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_R",
					["reformers"] = {
						[1] = "RAlt",
					},
				},
			},
		},
		["dnilp90u235cdnilvdnilvpnilvunil"] = {
			["name"] = "KU-31 Shkval slew up",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_U",
					["reformers"] = {
						[1] = "RAlt",
					},
				},
			},
		},
		["dnilp91u235cdnilvdnilvpnilvunil"] = {
			["name"] = "KU-31 Shkval slew down",
			["removed"] = {
				[1] = {
					["key"] = "JOY_BTN_POV1_D",
					["reformers"] = {
						[1] = "RAlt",
					},
				},
			},
		},
	},
}
return diff