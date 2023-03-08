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
			["name"] = "Thrust",
			["removed"] = {
				[1] = {
					["key"] = "JOY_Z",
				},
			},
		},
		["a2005cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0,
						["hardwareDetent"] = false,
						["hardwareDetentAB"] = 0,
						["hardwareDetentMax"] = 0,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RX",
				},
			},
			["name"] = "Thrust Left",
		},
		["a2006cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0,
						["hardwareDetent"] = false,
						["hardwareDetentAB"] = 0,
						["hardwareDetentMax"] = 0,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RY",
				},
			},
			["name"] = "Thrust Right",
		},
		["a2012cdnil"] = {
			["added"] = {
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
					["key"] = "JOY_RZ",
				},
			},
			["name"] = "Zoom View",
		},
		["a3026cd13"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_Z",
				},
			},
			["name"] = "Radar Elevation Control",
		},
		["a3043cd13"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.12,
						},
						["deadzone"] = 0.03,
						["hardwareDetent"] = false,
						["hardwareDetentAB"] = 0,
						["hardwareDetentMax"] = 0,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_Y",
				},
			},
			["name"] = "Throttle Designator Controller - VERTICAL AXIS",
		},
		["a3044cd13"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.12,
						},
						["deadzone"] = 0.03,
						["hardwareDetent"] = false,
						["hardwareDetentAB"] = 0,
						["hardwareDetentMax"] = 0,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_X",
				},
			},
			["name"] = "Throttle Designator Controller - HORIZONTAL AXIS",
		},
	},
	["keyDiffs"] = {
		["d1587pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN16",
				},
			},
			["name"] = "Kneeboard ON/OFF",
		},
		["d3001pnilu3001cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN40",
				},
			},
			["name"] = "Master Mode Button - A/A",
		},
		["d3001pnilu3001cd30vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN50",
				},
			},
			["name"] = "Push to Test Switch - Push to activate BIT",
		},
		["d3001pnilunilcd68vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN17",
				},
			},
			["name"] = "Kneeboard Next Page",
		},
		["d3002pnilu3002cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN43",
				},
			},
			["name"] = "Master Mode Button - A/G",
		},
		["d3002pnilunilcd68vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN19",
				},
			},
			["name"] = "Kneeboard Previous Page",
		},
		["d3009pnilunilcd5vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN47",
				},
			},
			["name"] = "Arresting Hook Handle - DOWN ",
		},
		["d3009pnilunilcd5vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN46",
				},
			},
			["name"] = "Arresting Hook Handle - UP",
		},
		["d3017pnilunilcd2vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN49",
				},
			},
			["name"] = "FLAP Switch - Down",
		},
		["d3017pnilunilcd2vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN48",
				},
			},
			["name"] = "FLAP Switch - Up",
		},
		["d3023pnilu3023cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN13",
				},
			},
			["name"] = "Throttle Designator Controller - DEPRESS",
		},
		["d3027pnilu3027cd13vd0.2vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN20",
				},
			},
			["name"] = "COMM Switch - COMM 1 (call radio menu)",
		},
		["d3028pnilu3028cd13vd0.4vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN18",
				},
			},
			["name"] = "COMM Switch - COMM 2 (call radio menu)",
		},
		["d3031pnilu3031cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN32",
				},
			},
			["name"] = "Cage/Uncage Button",
		},
		["d3032pnilu3032cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN26",
				},
			},
			["name"] = "Dispense Switch - Forward(CHAFF)/Center(OFF)",
		},
		["d3033pnilu3033cd13vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN24",
				},
			},
			["name"] = "Dispense Switch - Aft(FLARE)/Center(OFF)",
		},
		["d3034pnilu3034cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN21",
				},
			},
			["name"] = "RAID/FLIR FOV Select Button",
		},
		["d3035pnilu3035cd13vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN29",
				},
			},
			["name"] = "Speed Brake Switch - EXTEND",
		},
		["d3035pnilunilcd13vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN31",
				},
			},
			["name"] = "Speed Brake Switch - RETRACT",
		},
		["d3037pnilu3037cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
			["name"] = "ATC Engage/Disengage Switch",
		},
		["d313pnilu311cdnilvd1vpnilvu1"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN41",
				},
			},
			["name"] = "Throttle (Left) - OFF(hold)<>IDLE",
		},
		["d314pnilu312cdnilvd1vpnilvu1"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN42",
				},
			},
			["name"] = "Throttle (Right) - OFF(hold)<>IDLE",
		},
		["d68pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN53",
				},
			},
			["name"] = "Landing Gear Control Handle - UP/DOWN",
		},
		["d74pnilu75cdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
			["name"] = "Wheel Brake - ON/OFF",
		},
		["dnilp3002unilcd30vdnilvp-0.02vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN51",
				},
			},
			["name"] = "Push to Test Switch - CCW/Decrease",
		},
		["dnilp3002unilcd30vdnilvp0.02vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN52",
				},
			},
			["name"] = "Push to Test Switch - CW/Increase",
		},
		["dnilp3002unilcd58vdnilvp-1vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN54",
				},
			},
			["name"] = "HMD OFF/BRT Knob - CCW/Decrease",
		},
		["dnilp3002unilcd58vdnilvp1vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN55",
				},
			},
			["name"] = "HMD OFF/BRT Knob - CW/Increase",
		},
	},
}
return diff