local unitPayloads = {
	["name"] = "Mirage-F1BE",
	["payloads"] = {
		[1] = {
			["name"] = "2*AIM9-JULI, 2*R530IR, 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 10,
				[2] = 11,
				[3] = 18,
				[4] = 19,
			},
		},
		
		[2] = {
			["name"] = "2*R550 Magic I, 2*R530IR, 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 10,
				[2] = 11,
				[3] = 18,
				[4] = 19,
			},
		},
		
		[3] = {
			["name"] = "2*R550 Magic I, 2*R530EM, 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{R530F_EM}",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "{R530F_EM}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 10,
				[2] = 11,
				[3] = 18,
				[4] = 19,
			},
		},
		
		[4] = {
			["name"] = "2*AIM9-JULI, R530IR",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 10,
			},
		},
		
		[5] = {
			["name"] = "2*R550 Magic I, R530EM",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{R530F_EM}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 10,
			},
		},
		
		[6] = {
			["name"] = "2*AIM9-JULI, 1*R530IR, 2*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		
		[7] = {
			["name"] = "2*R550 Magic I, 1*R530IR, 2*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 5,
				},
				[4] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 11,
			},
		},
		
		[8] = {
			["name"] = "2*AIM9-J, 2*MATRA F4 SNEB251 (HE), 2*R530IR, 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MATRA_F4_SNEBT251}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{MATRA_F4_SNEBT251}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 5,
				},
				[6] = {
					["CLSID"] = "{R530F_IR}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 19,
			},
		},
		
		[9] = {
			["name"] = "2*AIM-9J, 2*Fuel Tank, 4*SAMP 400 LD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 5,
				},
				[5] = {
					["CLSID"] = "{CLB4_SAMP400LD}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[10] = {
			["name"] = "2*AIM-9J, 2*Fuel Tank, 4*SAMP 400 HD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9J}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 5,
				},
				[5] = {
					["CLSID"] = "{CLB4_SAMP400HD}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		
		
		[11] = {
			["name"] = "2*R550 Magic I, 4*MATRA F1 SNEB253 (Shaped Charge), 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MATRA_F1_SNEBT253}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{MATRA_F1_SNEBT253}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{MATRA_F1_SNEBT253}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{MATRA_F1_SNEBT253}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[12] = {
			["name"] = "2*R550 Magic I, 4*MATRA F4 SNEB253 (Shaped Charge), 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MATRA_F4_SNEBT253}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{MATRA_F4_SNEBT253}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{MATRA_F4_SNEBT253}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{MATRA_F4_SNEBT253}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[13] = {
			["name"] = "2*R550 Magic I, 4*MATRA F1 SNEB256 (AP), 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[14] = {
			["name"] = "2*R550 Magic I, 4*MATRA F4 SNEB256 (AP), 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MATRA_F4_SNEBT256}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{MATRA_F4_SNEBT256}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{MATRA_F4_SNEBT256}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{MATRA_F4_SNEBT256}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[15] = {
			["name"] = "2*R550 Magic I, 2*SAMP 250 HD, 2 MATRA F1 SNEB256 (AP), 1*Fuel Tank",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{R550_Magic_1}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{MATRA_F1_SNEBT256}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "PTB-1200-F1",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		
		[16] = {
			["name"] = "2*AIM-9JULI, 8*SAMP 250 HD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{SAMP250HD}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "{CLB4_SAMP250HD}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		
		[17] = {
			["name"] = "2*AIM-9JULI, 8*SAMP 400 LD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{SAMP400LD}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{SAMP400LD}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{SAMP400LD}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{SAMP400LD}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "{CLB4_SAMP400LD}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32, 
				[2] = 34,
			},
		},
		
		
		[18] = {
			["name"] = "2*AIM-9JULI, 8*BLU107 Durandal",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{AIM-9JULI}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 6,
				},
				[5] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 3,
				},
				[6] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 5,
				},
				[7] = {
					["CLSID"] = "{CLB4_BLU107}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32, 
				[2] = 34,
			},
		},
		
	},
	["tasks"] = {
	},
	["unitType"] = "Mirage-F1BE",
}
return unitPayloads
