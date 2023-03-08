local unitPayloads = {
	["name"] = "MiG-25RBT",
	["payloads"] = {
		[1] = {
			["name"] = "FAB-500x2_60x2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{APU-60-1_R_60M}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{37DCC01E-9E02-432F-B61D-10C166CA2798}",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "{APU-60-1_R_60M}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[2] = {
			["name"] = "R-60M*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{APU-60-1_R_60M}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{APU-60-1_R_60M}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 17,
			},
		},
	},
	["unitType"] = "MiG-25RBT",
}
return unitPayloads
