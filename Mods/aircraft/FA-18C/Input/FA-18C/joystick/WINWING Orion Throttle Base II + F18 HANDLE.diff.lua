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
					["key"] = "JOY_RY",
				},
			},
			["name"] = "Thrust Left",
		},
		["a2006cdnil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_RX",
				},
			},
			["name"] = "Thrust Right",
		},
		["a2012cdnil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_SLIDER2",
				},
			},
			["name"] = "Zoom View",
		},
		["a3003cd58"] = {
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
					["key"] = "JOY_SLIDER1",
				},
			},
			["name"] = "HMD OFF/BRT Knob",
		},
		["a3026cd13"] = {
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
		["d3001pnilu3001cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN82",
				},
			},
			["name"] = "Master Mode Button - A/A",
		},
		["d3002pnilu3002cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN81",
				},
			},
			["name"] = "Master Mode Button - A/G",
		},
		["d3002pnilu3002cd54vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN80",
				},
			},
			["name"] = "Dispense Button",
		},
		["d3003pnilu3003cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN93",
				},
			},
			["name"] = "Master Arm Switch: ARM<>SAFE",
		},
		["d3004pnilu3004cd23vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN96",
				},
			},
			["name"] = "Emergency Jettison Button",
		},
		["d3005pnilunilcd5vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN75",
				},
			},
			["name"] = "Emergency/Parking Brake Handle - PULL",
		},
		["d3005pnilunilcd5vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN76",
				},
			},
			["name"] = "Emergency/Parking Brake Handle - STOW",
		},
		["d3007pnilunilcd2vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN79",
				},
			},
			["name"] = "FLAP Switch - FULL",
		},
		["d3007pnilunilcd2vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN78",
				},
			},
			["name"] = "FLAP Switch - HALF",
		},
		["d3007pnilunilcd2vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN77",
				},
			},
			["name"] = "FLAP Switch - AUTO",
		},
		["d3008pnilu3008cd9vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN92",
				},
			},
			["name"] = "MASTER CAUTION Reset Button",
		},
		["d3009pnilunilcd5vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN68",
				},
			},
			["name"] = "Arresting Hook Handle - DOWN ",
		},
		["d3009pnilunilcd5vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN67",
				},
			},
			["name"] = "Arresting Hook Handle - UP",
		},
		["d3011pnilunilcd2vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN69",
				},
			},
			["name"] = "Wing Fold Control Handle - FOLD",
		},
		["d3011pnilunilcd2vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN70",
				},
			},
			["name"] = "Wing Fold Control Handle - HOLD",
		},
		["d3011pnilunilcd2vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN71",
				},
			},
			["name"] = "Wing Fold Control Handle - SPREAD",
		},
		["d3014pnilu3014cd5vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN66",
				},
			},
			["name"] = "Launch Bar Control Switch - EXTEND",
		},
		["d3014pnilunilcd5vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN65",
				},
			},
			["name"] = "Launch Bar Control Switch - RETRACT",
		},
		["d3020pnilunilcd2vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN72",
				},
			},
			["name"] = "Wing Fold Control Handle - PULL/STOW",
		},
		["d3023pnilu3023cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN22",
				},
			},
			["name"] = "Throttle Designator Controller - DEPRESS",
		},
		["d3027pnilu3027cd13vd0.2vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
			["name"] = "COMM Switch - COMM 1 (call radio menu)",
		},
		["d3028pnilu3028cd13vd0.4vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN17",
				},
			},
			["name"] = "COMM Switch - COMM 2 (call radio menu)",
		},
		["d3029pnilu3029cd13vd0.6vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN16",
				},
			},
			["name"] = "COMM Switch - MIDS A",
		},
		["d3030pnilu3030cd13vd0.8vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
			["name"] = "COMM Switch - MIDS B",
		},
		["d3031pnilu3031cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN21",
				},
			},
			["name"] = "Cage/Uncage Button",
		},
		["d3032pnilu3032cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
			["name"] = "Dispense Switch - Forward(CHAFF)/Center(OFF)",
		},
		["d3033pnilu3033cd13vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
			["name"] = "Dispense Switch - Aft(FLARE)/Center(OFF)",
		},
		["d3034pnilu3034cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN6",
				},
			},
			["name"] = "RAID/FLIR FOV Select Button",
		},
		["d3035pnilu3035cd13vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN20",
				},
			},
			["name"] = "Speed Brake Switch - EXTEND",
		},
		["d3035pnilunilcd13vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN18",
				},
			},
			["name"] = "Speed Brake Switch - RETRACT",
		},
		["d3037pnilu3037cd13vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
			["name"] = "ATC Engage/Disengage Switch",
		},
		["d3041pnilunilcd13vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
			["name"] = "Exterior Lights Switch - OFF",
		},
		["d3041pnilunilcd13vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN3",
				},
			},
			["name"] = "Exterior Lights Switch - ON",
		},
		["d430pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN73",
				},
			},
			["name"] = "Landing Gear Control Handle - UP",
		},
		["d431pnilunilcdnilvdnilvpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN74",
				},
			},
			["name"] = "Landing Gear Control Handle - DOWN",
		},
		["dnilp3002unilcd58vdnilvp-1vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN83",
				},
			},
			["name"] = "HMD OFF/BRT Knob - CCW/Decrease",
		},
		["dnilp3002unilcd58vdnilvp1vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN84",
				},
			},
			["name"] = "HMD OFF/BRT Knob - CW/Increase",
		},
		["dnilp3011unilcd34vdnilvp-0.5vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN103",
				},
			},
			["name"] = "HUD Symbology Brightness Control Knob - CCW/Decrease",
		},
		["dnilp3011unilcd34vdnilvp0.5vunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN104",
				},
			},
			["name"] = "HUD Symbology Brightness Control Knob - CW/Increase",
		},
	},
}
return diff