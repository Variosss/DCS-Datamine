local ExtFuelTankID							= "{EFT_230GAL}"

local NURSLauncherID_MK151					= "M261_MK151"									-- M261 pod - 19 x 2.75" Hydra rockets M151 HE - high-explosive
local NURSLauncherID_M257					= "{M261_M257}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M257, Illum.
local NURSLauncherID_M274					= "{M261_M274}"									-- M261 pod - 19 x 2.75\" Hydra, UnGd Rkts M274, Smk
local NURSLauncherID_M151_M274_OUTBOARD		= "{M261_OUTBOARD_AB_M151_E_M274}"				-- M261: Outboard Launcher, Zones A/B: M151 Hydra (6PD), Zone E: M274 Hydra (6SK)
local NURSLauncherID_M151_M257_OUTBOARD		= "{M261_OUTBOARD_AB_M151_E_M257}"				-- M261: Outboard Launcher, Zones A/B: M151 Hydra (6PD), Zone E: M257 Hydra (6IL)
local NURSLauncherID_M274_M151_INBOARD		= "{M261_INBOARD_DE_M151_C_M274}"				-- M261: Inboard Launcher, Zone C: M274 Hydra (6SK), Zones D/E: M151 Hydra (6PD)
local NURSLauncherID_M257_M151_INBOARD		= "{M261_INBOARD_DE_M151_C_M257}"				-- M261: Inboard Launcher, Zone C: M257 Hydra (6IL), Zones D/E: M151 Hydra (6PD)

local HellfireLauncherID					= "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}"		-- AGM-114K Hellfire * 4

local unitPayloads = {
	["name"] = "AH-64D_BLK_II",
	["payloads"] = {
		[1] = {
			["displayName"] = "4 * Fuel Tank 230 gal",
			["name"] = "4 * Fuel Tank 230 gal",
			["pylons"] = {
				[1] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[2] = {
			["displayName"] = "2 * M261: M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * M261: M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[3] = {
			["name"] = "4 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[4] = {
			["displayName"] = "4 * M261: M151 (6PD)",
			["name"] = "4 * M261: M151 (6PD)",
			["pylons"] = {
				[1] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[5] = {
			["displayName"] = "2 * M261: M151 (6PD), 2 * Fuel Tank 230 gal",
			["name"] = "2 * M261: M151 (6PD), 2 * Fuel Tank 230 gal",
			["pylons"] = {
				[1] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = NURSLauncherID_MK151,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[6] = {
			["displayName"] = "2 * Fuel Tank 230 gal, 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * Fuel Tank 230 gal, 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = ExtFuelTankID,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		
		-- No mixed payload for now!
		[7] = {
			["displayName"] = "2 * M261: A/B - M151 (6PD), E - M274 (6SK), 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * M261: A/B - M151 (6PD), E - M274 (6SK), 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = NURSLauncherID_M151_M274_OUTBOARD,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = NURSLauncherID_M151_M274_OUTBOARD,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[8] = {
			["displayName"] = "2 * M261: A/B - M151 (6PD), E - M257 (6IL), 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * M261: A/B - M151 (6PD), E - M257 (6IL), 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = NURSLauncherID_M151_M257_OUTBOARD,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = NURSLauncherID_M151_M257_OUTBOARD,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[9] = {
			["displayName"] = "2 * M261: C - M257 (6IL), D/E - M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * M261: C - M257 (6IL), D/E - M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = NURSLauncherID_M257_M151_INBOARD,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = NURSLauncherID_M257_M151_INBOARD,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
		[10] = {
			["displayName"] = "2 * M261: C - M274 (6SK), D/E - M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["name"] = "2 * M261: C - M274 (6SK), D/E - M151 (6PD), 2 * Hellfire station: 4*AGM-114K",
			["pylons"] = {
				[1] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 4,
				},
				[2] = {
					["CLSID"] = NURSLauncherID_M274_M151_INBOARD,
					["num"] = 3,
				},
				[3] = {
					["CLSID"] = NURSLauncherID_M274_M151_INBOARD,
					["num"] = 2,
				},
				[4] = {
					["CLSID"] = HellfireLauncherID,
					["num"] = 1,
				},
			},
			["tasks"] = {
				[1] = 16,	-- AFAC
				[2] = 30,	-- Anti-ship Strike
				[3] = 31,	-- CAS
				[4] = 18,	-- Escort
				[5] = 32,	-- Ground Attack
			},
		},
	},
	["unitType"] = "AH-64D_BLK_II",
}
return unitPayloads
