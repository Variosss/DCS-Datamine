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
			["name"] = "Rudder",
			["removed"] = {
				[1] = {
					["key"] = "JOY_RZ",
				},
			},
		},
		["a2004cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = true,
					},
					["key"] = "JOY_X",
				},
			},
			["name"] = "Thrust",
			["removed"] = {
				[1] = {
					["key"] = "JOY_Z",
				},
			},
		},
		["a3003cd30"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_SLIDER2",
				},
			},
			["name"] = "HMCS SYMBOLOGY INT Knob",
		},
		["a3028cd16"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_Z",
				},
			},
			["name"] = "MAN RNG Knob",
		},
		["a3032cd16"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_RZ",
				},
			},
			["name"] = "ANT ELEV Knob",
		},
		["a3041cd17"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_SLIDER1",
				},
			},
			["name"] = "HUD Symbology Intensity Knob",
		},
		["a3046cd16"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0.03,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RY",
				},
			},
			["name"] = "RDR CURSOR Switch - Y axis",
		},
		["a3047cd16"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0.03,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RX",
				},
			},
			["name"] = "RDR CURSOR Switch - X axis",
		},
	},
	["keyDiffs"] = {
		["d3001pnilu3001cd12vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN9",
				},
			},
			["name"] = "Master Caution Button",
		},
		["d3002pnilu3002cd19vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
			["name"] = "MASTER ARM Switch (special) - MASTER ARM/OFF",
		},
		["d3004pnilu3004cd6vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN6",
				},
			},
			["name"] = "JFS Switch - START 1 / OFF",
		},
		["d3005pnilu3005cd6vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
			["name"] = "JFS Switch - START 2 / OFF",
		},
		["d3012pnilu3012cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN16",
				},
			},
			["name"] = "ICP COM Override Button - COM1(UHF)",
		},
		["d3013pnilu3013cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN17",
				},
			},
			["name"] = "ICP COM Override Button - COM2(VHF)",
		},
		["d3014pnilu3014cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
			["name"] = "ICP IFF Override Button - IFF",
		},
		["d3015pnilu3015cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
			["name"] = "ICP LIST Override Button - LIST",
		},
		["d3018pnilu3018cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN18",
				},
			},
			["name"] = "ICP Master Mode Button - A-A",
		},
		["d3019pnilu3019cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN19",
				},
			},
			["name"] = "ICP Master Mode Button - A-G",
		},
		["d3024pnilu3024cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN22",
				},
			},
			["name"] = "Transmit Switch - VHF",
		},
		["d3025pnilu3025cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN20",
				},
			},
			["name"] = "Transmit Switch - UHF",
		},
		["d3028pnilu3028cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN1",
				},
			},
			["name"] = "ICP DRIFT CUTOUT/WARN RESET Switch (special) - DRIFT C/O /NORM",
		},
		["d3029pnilu3029cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
			["name"] = "UNCAGE Switch",
		},
		["d3030pnilu3030cd16vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN25",
				},
			},
			["name"] = "DOGFIGHT/Missile Override Switch (special) - MISSILE OVERRIDE/CENTER",
		},
		["d3030pnilu3030cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN27",
				},
			},
			["name"] = "DOGFIGHT/Missile Override Switch (special) - DOGFIGHT/CENTER",
		},
		["d3030pnilu3030cd17vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
			["name"] = "ICP DED Increment/Decrement Switch - Increment",
		},
		["d3031pnilu3031cd16vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN23",
				},
			},
			["name"] = "SPD BRK Switch - Aft/EXTEND (Momentary)",
		},
		["d3031pnilu3031cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN21",
				},
			},
			["name"] = "SPD BRK Switch (special) - Fwd/RETRACT /OFF",
		},
		["d3031pnilu3031cd17vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN13",
				},
			},
			["name"] = "ICP DED Increment/Decrement Switch - Decrement",
		},
		["d3039pnilu3039cd16vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN32",
				},
			},
			["name"] = "ENABLE Switch - Depress",
		},
		["d430pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
			["name"] = "LG Handle - UP",
		},
		["d431pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN11",
				},
			},
			["name"] = "LG Handle - DN",
		},
	},
}
return diff