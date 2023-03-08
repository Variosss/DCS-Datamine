--[[
"Intercept" = 10
"CAP" = 11
"Refueling" = 13
"AWACS" = 14
"Nothing" = 15
"AFAC" = 16
"Reconnaissance" = 17
"Escort" = 18
"FighterSweep" = 19
"GAI" = 20
"SEAD" = 29
"AntishipStrike" = 30
"CAS" = 31
"GroundAttack" = 32
"PinpointStrike" = 33
"RunwayAttack" = 34
"Transport" = 35
"Airborne" = 36 ]]

local unitPayloads = {
	["name"] = "I-16",
	["payloads"] = {
		[1] = {
			["name"] = "6xRS-82",
			["pylons"] = {
				[1] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 8,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[2] = {
			["name"] = "2xFAB-100",
			["pylons"] = {
				[1] = {
					["CLSID"] = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},

		[3] = {
			["name"] = "6xRS-82, 2xFAB-100",
			["pylons"] = {
				[1] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 8,
				},
				[7] = {
					["CLSID"] = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					["num"] = 4,
				},
				[8] = {
					["CLSID"] = "I16_FAB_100SV", --"{FB3CE165-BF07-4979-887C-92B87F13276B}", 
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		}, 

		[4] = {
			["name"] = "6xRS-82, 2xDropTank-93L",
			["pylons"] = {
				[1] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "I16_RS_82",
					["num"] = 8,
				},
				[7] = {
					["CLSID"] = "I16_DROP_FUEL_TANK",
					["num"] = 4,
				},
				[8] = {
					["CLSID"] = "I16_DROP_FUEL_TANK",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		}, 

		[5] = {
			["name"] = "2xDropTank-93L",
			["pylons"] = {
				[1] = {
					["CLSID"] = "I16_DROP_FUEL_TANK",
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = "I16_DROP_FUEL_TANK",
					["num"] = 5,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 17,
				[3] = 18,
			},
		}, 
	},
	["tasks"] = {
        --aircraft_task(CAP),
        --aircraft_task(Escort),
	},
	["unitType"] = "I-16",
}
return unitPayloads