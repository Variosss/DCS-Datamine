local unitPayloads = {
	["name"] = "P-47D-30",
	["payloads"] = {
		[1] = {
			["name"] = "AN-M65*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AN_M65}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{AN_M65}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 34,
			},
		},
		[2] = {
			["name"] = "Fuel150*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{US_150GAL_FUEL_TANK}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{US_150GAL_FUEL_TANK}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 18,
				[2] = 11,
			},
		},
		[3] = {
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
				[1] = 32,
			},
		},
		[4] = {
			["name"] = "AN-M57*3",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AN_M57}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{AN_M57}",
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = "{AN_M57}",
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 32,
				[2] = 31,
			},
		},
	},
	["tasks"] = {
	},
	["unitType"] = "P-47D-30",
}
return unitPayloads
