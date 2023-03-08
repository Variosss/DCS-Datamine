local unitPayloads = {
	["name"] = "MiG-15bis",
	["payloads"] = {
		[1] = {
			["name"] = "2*FAB-50",
			["pylons"] = {
				[1] = {
					["CLSID"] = "FAB_50",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "FAB_50",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			}, 
		},
		[2] = {
			["name"] = "2*FAB-100M",
			["pylons"] = {
				[1] = {
					["CLSID"] = "FAB_100M",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "FAB_100M",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			}, 
		},
		[3] = {
			["name"] = "2*300L",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB300_MIG15",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "PTB300_MIG15",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
			}, 
		},
		[4] = {
			["name"] = "2*400L",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB400_MIG15",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "PTB400_MIG15",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
			}, 
		},
		[5] = {
			["name"] = "2*600L",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB600_MIG15",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "PTB600_MIG15",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
			}, 
		},
		
		[6] = {
			["displayName"] = "Fuel tank 300",
			["name"] = "Fuel tank 300",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB300_MIG15",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "PTB300_MIG15",
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 18,
				[2] = 19,
				[3] = 10,
			},
		},
		[7] = {
			["displayName"] = "Fuel tank 400",
			["name"] = "Fuel tank 400",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB400_MIG15",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "PTB400_MIG15",
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 18,
				[2] = 19,
				[3] = 10,
			},
		},
		
	},
	["tasks"] = {
	},
	["unitType"] = "MiG-15bis",
}
return unitPayloads
