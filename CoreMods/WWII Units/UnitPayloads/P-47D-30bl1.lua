local unitPayloads = {
	["name"] = "P-47D-30bl1",
	["payloads"] = {
		[1] = {
			["name"] = "AN-M57*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AN_M57}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{AN_M57}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		[2] = {
			["name"] = "AN-M64*2, Fuel110",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AN-M64}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{AN-M64}",
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = "{US_110GAL_FUEL_TANK}",
					["num"] = 1,
				},
			},
			["tasks"] = {
			},
		},
	},
	["tasks"] = {
	},
	["unitType"] = "P-47D-30bl1",
}
return unitPayloads
