tasks = {
	["SEAD"] = {
		--["airdrome"] = 31,
		["player"] = {
			--["unit"] = "Su-25T",
			["fuel"] = 100,
			["radius_of_birth"] = 60000,
		},
		["Enemies"] = {
			["Ground"] = {
				[1] = {
					["name"] = "ZSU-23-4 Shilka", --From *.lua Name=""
					["min"] = 4, -- group
					["med"] = 4, -- group
					["max"] = 4, -- group
					["task"] = "Stay",
					["radius_of_birth"] = {1000,2000},
					["bots"] = {1,1}, -- units in group  {min,max - random between this}
				},
				[2] = {
					["name"] = "Osa 9A33 ln",		-- unit name or template name or category =""
					["min"] = 2, -- group
					["med"] = 4, -- group
					["max"] = 0, -- group
					["task"] = "Stay",
					["radius_of_birth"] = {1000,2000},
					["bots"] = {1,1}, -- units in group  {min,max - random between this}
				},
				[3] = {
					["name"] = "Tor 9A331",			-- unit name or template name or category =""
					["min"] = 0, -- group
					["med"] = 0, -- group
					["max"] = 4, -- group
					["task"] = "Stay",
					["radius_of_birth"] = {1000,2000},
					["bots"] = {1,1}, -- units in group  {min,max - random between this}
				},
				[4] = {
					["name"] = "SA-11 SAM Battery", -- unit name or template name or category =""
					["min"] = 0, -- group
					["med"] = 0, -- group
					["max"] = 1, -- group
					["radius_of_birth"] = {1000,2000},
					["task"] = "Stay",
					["category"] = "SAM",
				},
				[5] = {
					["name"] = "SA-6 SAM Battery", -- unit name or template name or category =""
					["min"] = 0, -- group
					["med"] = 1, -- group
					["max"] = 0, -- group
					["radius_of_birth"] = {1000,2000},
					["task"] = "Stay",
					["category_unit"] = "SAM", --"SAM/AAA/Vehicle"
				},
				[6] = {
					["name"] = "Transport",			-- unit name or template name or category =""
					["min"] = 1, -- group
					["med"] = 4, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {8,8}, -- units in group  {min,max - random between this}
				},
				[7] = {
					["name"] = "Armor",				-- unit name or template name or category =""
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
				},
				[8] = {
					["name"] = "Tanks",				-- unit name or template name or category ="" or Attribute ""
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
				},
				[9] = {
					["name"] = "Artillery",			-- unit name or template name or category ="" /Air Defence/Armor/...
					["min"] = 2, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
					["task"] = "Stay",
				},
			},
			["Aircraft"] = {
		
				[1] = {
					["type"] = "Attack Planes",		-- unit name or type
					["min"] = 0, -- group
					["med"] = 0, -- group
					["max"] = 0, -- group
					["task"] = "CAS",
					["circle_route"] = {
						["radius"] = 15000.,
						["position"] = "airdrome", --"self", --"airdrome"
						["speed"] = 550.,
						["altitude"] = 2000.,
					},
					["bots"] = {2,2}, -- units in group
				},
				[2] = {
					["type"] = "Fighter Planes",
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["task"] = "CAP",
					["circle_route"] = {
						["radius"] = 15000.,
						["position"] = "self", --"airdrome"
						["speed"] = 800.,
						["altitude"] = 4000.,
					},
					["bots"] = {2,2}, -- units in group
				},
				[3] = {
					["type"] = "Helicopters",
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["task"] = "CAS",
					["circle_route"] = {
						["radius"] = 2000.,
						["position"] = "airdrome", --"self", --"airdrome"
						["speed"] = 180.,
						["altitude"] = 100.,
					},
					["bots"] = {2,2}, -- units in group
				},
			},
		},
		["Allied"] = {
			["Aircraft"] = {
		
				[1] = {
					["type"] = "Attack Planes",
					["min"] = 0, -- group
					["med"] = 1, -- group
					["max"] = 2, -- group
					["task"] = "CAS",
					["bots"] = {2,2}, -- units in group
				},
				[2] = {
					["type"] = "Fighter Planes",
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 3, -- group
					["task"] = "CAP",
					["bots"] = {2,2}, -- units in group
				},
				[3] = {
					["type"] = "Helicopters",
					["min"] = 0, -- group
					["med"] = 0, -- group
					["max"] = 0, -- group
					["task"] = "CAS",
					["bots"] = {2,2}, -- units in group
				},
			},
		},
	},
	["Escort"] =
	{
		["player"] = {
			--["unit"] = "Su-25T",
			["fuel"] = 50,
			["radius_of_birth"] = 60000,
		},
		["Enemies"] = {
			["Ground"] = {
				[1] = {
					["name"] = "Armor",				-- unit name or template name or category =""
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
				},
				[2] = {
					["name"] = "Tanks",				-- unit name or template name or category ="" or Attribute ""
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
				},
				[3] = {
					["name"] = "Artillery",			-- unit name or template name or category ="" /Air Defence/Armor/...
					["min"] = 2, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["radius_of_birth"] = {1000,2000},
					["bots"] = {4,4}, -- units in group  {min,max - random between this}
					["task"] = "Stay",
				},
			},
			["Aircraft"] = {
				[1] = {
					["type"] = "Fighter Planes",
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 3, -- group
					["task"] = "Fighter Sweep",
					--["target"] = "Bombers",     -- 
					["bots"] = {1,2}, -- units in group
				},
			},
		},
		["Allied"] = {
			["Ground"] = {
				[1] = {
				
				},
			},
			["Aircraft"] = {
				[1] = {
					["type"] = "Bombers",		-- unit name or type or Bombers (take from table Bombers.lua)
					["min"] = 1, -- group
					["med"] = 2, -- group
					["max"] = 4, -- group
					["task"] = "Ground Attack",
					["target"] = "",
					["circle_route"] = {
						["radius"] = 15000.,
						["position"] = "airdrome", --"self", --"airdrome"
						["speed"] = 550.,
						["altitude"] = 2000.,
					},
					["bots"] = {1,2}, -- units in group								
				},
			},
		},
	},
}
