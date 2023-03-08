local unitPayloads = {
	["name"] = "MiG-19P",
	["payloads"] = {
		[1] = {
			["name"] = "PTB-760 x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 18,
				[3] = 19,
				[4] = 10,
			},
		},
		[2] = {
			["name"] = "K-13A x 2, PTB-760 x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{K-13A}",
					["num"] = 6,
				},
				[2] = {
					["CLSID"] = "{K-13A}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 18,
				[3] = 19,
				[4] = 10,
			},
		},
		[3] = {
			["name"] = "K-13A x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{K-13A}",
					["num"] = 6,
				},
				[2] = {
					["CLSID"] = "{K-13A}",
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 18,
				[3] = 19,
				[4] = 10,
			},
		},
		[4] = {
			["name"] = "K-13A x 2, ORO-57K x 2, PTB-760 x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{K-13A}",
					["num"] = 6,
				},
				[2] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 5,
				},
				[3] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{K-13A}",
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[5] = {
			["name"] = "ORO-57K x 2, PTB-760 x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "PTB760_MIG19",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[6] = {
			["name"] = "ORO-57K x 4",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[7] = {
			["name"] = "ORO-57K x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[8] = {
			["name"] = "FAB-100M x 2, ORO-57K x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "FAB_100M",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "FAB_100M",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[9] = {
			["name"] = "FAB-250 x 2, ORO-57K x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{ORO57K_S5M_HEFRAG}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
		[10] = {
			["name"] = "FAB-100M x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "FAB_100M",
					["num"] = 5,
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
		[11] = {
			["name"] = "FAB-250 x 2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 31,
				[2] = 32,
			},
		},
	},
	["tasks"] = {
	},
	["unitType"] = "MiG-19P",
}
return unitPayloads

