local unitPayloads = {
	["name"] = "MB-339A",
	["payloads"] = {
		[1] = {
			["name"] = "A - 2*320L TipTanks + 2*DEFA-553 GunPods + 2*Mk.83 + 2*Mk.81 ",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[3] = {
					["CLSID"] = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",
					["num"] = 8,
				},
				[4] = {
					["CLSID"] = "{7A44FF09-527C-4B7E-B42B-3F111CFE50FB}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",
					["num"] = 9,
				},
				[6] = {
					["CLSID"] = "{90321C8E-7ED1-47D4-A160-E074D5ABD902}",
					["num"] = 2,
				},
				[7] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[2] = {
			["name"] = "A - 2*320L TipTanks [Clean]",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 8,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 4,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 3,
				},
				[8] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 35,
			},
		},
		[3] = {
			["name"] = "Recon",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{MB339_ANM3_R}",
					["num"] = 7,
				},
				[4] = {
					["CLSID"] = "{MB339_VINTEN}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 9,
				},
				[8] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 17,
			},
		},
		[4] = {
			["name"] = "Training",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{BRD_4_250_4xMK76}",
					["num"] = 8,
				},
				[4] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 9,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 2,
				},
				[6] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[7] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
			},
		},
		[5] = {
			["name"] = "AA - 2*320L TipTanks + 2*DEFA-553 GunPods + 2*LAU-10(Zuni Rockets) [ARMADA]",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",
					["num"] = 8,
				},
				[4] = {
					["CLSID"] = "{F3EFE0AB-E91A-42D8-9CA2-B63C91ED570A}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 30,
			},
		},
		[6] = {
			["name"] = "AM - 2*320L TipTanks + 2*AN/M3 GunPods + 2*330L Tanks + 2*LAU-3 (Hydra rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "LAU3_HE151",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "LAU3_HE151",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{MB339_ANM3_R}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{MB339_ANM3_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},

		[7] = {
			["name"] = "A - 2*500L TipTanks + 2*330L Tanks + Luggage Container  [Ferry Long Range]",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 8,
				},
				[2] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 7,
				},
				[3] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-L}",
					["num"] = 1,
				},
				[5] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-R}",
					["num"] = 10,
				},
				[6] = {
					["CLSID"] = "{MB339_TRAVELPOD}",
					["num"] = 4,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 9,
				},
				[8] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 15,
				[2] = 35,
			},
		},
		[8] = {
			["name"] = "A - 2*500L TipTanks + 4*Mk.82HD + 2*LR-25 (API Rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{Mk82SNAKEYE}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{Mk82SNAKEYE}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{Mk82SNAKEYE}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{Mk82SNAKEYE}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[9] = {
			["name"] = "A - 2*320L TipTanks + 2*330L Tanks [Ferry Medium Range]",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 8,
				},
				[4] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 3,
				},
				[5] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 9,
				},
				[7] = {
					["CLSID"] = "<CLEAN>",
					["num"] = 2,
				},
			},
			["tasks"] = {
				[1] = 35,
			},
		},
		[10] = {
			["name"] = "A - 2*500L TipTanks + 2*AN/M3 GunPods + 2*Matra 155 + 2* Belouga",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{BLG66_BELOUGA_AC}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{BLG66_BELOUGA_AC}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{MB339_ANM3_R}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{MB339_ANM3_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[11] = {
			["name"] = "Runway Interdiction",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{BLU107B_DURANDAL}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 34,
			},
		},
		[12] = {
			["name"] = "A - 2*500L TipTanks + 2*DEFA-553 GunPods + 2*Mk.82LD + 2*LR-25 (API Rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[2] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
				[3] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-R}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{FUEL-TIP-TANK-500-L}",
					["num"] = 1,
				},
			},
			["tasks"] = {
			},
		},
		[13] = {
			["name"] = "A - 2*320L TipTanks + 2*DEFA-553 GunPods + 2*Mk.82LD Bombs + 2*LR-25(API Rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 8,
				},
				[7] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{LR25_ARF8M3_API}",
					["num"] = 9,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},
		[14] = {
			["name"] = "A - 2*320L TipTanks + 2*DEFA-553 GunPods + 2*Mk.82LD + 2*LR-25 (HEI Rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{LR25_ARF8M3_HEI}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 8,
				},
				[7] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{LR25_ARF8M3_HEI}",
					["num"] = 9,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[15] = {
			["name"] = "A - 2*320L TipTanks + 6*Mk.82LD",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[2] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 3,
				},
				[4] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 4,
				},
				[5] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 7,
				},
				[6] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 8,
				},
				[7] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[8] = {
					["CLSID"] = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}",
					["num"] = 9,
				},
			},
			["tasks"] = {
				[1] = 15,
				[2] = 32,
			},
		},
		[16] = {
			["name"] = "Runway Interdiction (36*BAP-100)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{14_3_M2_6xBAP100}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 34,
			},
		},
		[17] = {
			["name"] = "Anti - Light Armoured Vehicle (36*BAT-120 ABL)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{14_3_M2_6xBAT120}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 32,
			},
		},
		[18] = {
			["name"] = "AP - 2*320L TipTanks + 2*DEFA-553 GunPods + 2*330L Tanks + 2*Matra 155 (SNEB rockets)",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-R}",
					["num"] = 10,
				},
				[2] = {
					["CLSID"] = "{FUEL-TIP-ELLITTIC-L}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 9,
				},
				[4] = {
					["CLSID"] = "{Matra155RocketPod}",
					["num"] = 2,
				},
				[5] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 8,
				},
				[6] = {
					["CLSID"] = "{FUEL-SUBAL_TANK-330}",
					["num"] = 3,
				},
				[7] = {
					["CLSID"] = "{MB339_DEFA553_R}",
					["num"] = 7,
				},
				[8] = {
					["CLSID"] = "{MB339_DEFA553_L}",
					["num"] = 4,
				},
			},
			["tasks"] = {
				[1] = 31,
			},
		},		
	},
	["tasks"] = {
	},
	["unitType"] = "MB-339A",
}
return unitPayloads
