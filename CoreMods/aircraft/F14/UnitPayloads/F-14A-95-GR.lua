local pylon_1A,pylon_1B,pylon_2,pylon_3,pylon_4,pylon_5,pylon_6,pylon_7,pylon_8B,pylon_8A = 1,2,3,4,5,6,7,8,9,10

local unitPayloads = {
	["name"] = "F-14A IRIAF",
	["payloads"] = {
		{
			["name"] = "AIM-54A-MK47*6, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*6, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK60*6, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-7F*6, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
            ["name"] = "AIM-7F*6, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*4, AIM-7F*2, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*4, AIM-7F*2, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK60*4, AIM-7F*2, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*2, AIM-7F*1, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*2, AIM-7F*1, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK60*2, AIM-7F*1, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*4, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*4, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK60*4, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-7F*4, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-7F*4, AIM-9L*4",
			["pylons"] = {
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				{
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*2, AIM-7F*3, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK47*2, AIM-7F*3, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "AIM-54A-MK60*2, AIM-7F*3, AIM-9L*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				{
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
			},
			["tasks"] = {
				[1] = Intercept,
				[2] = CAP,
				[3] = Escort,
				[4] = FighterSweep,
			},
		},
		{
			["name"] = "BDU-33*14",
			["pylons"] = {
				{
					["CLSID"] = "{MAK79_BDU33 4}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{MAK79_BDU33 4}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{MAK79_BDU33 3L}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{MAK79_BDU33 3R}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "BDU-33*12",
			["pylons"] = {
				{
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "GBU-10*2",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 GBU-10}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 GBU-10}", ["num"] = pylon_6,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = PinpointStrike,
				[3] = RunwayAttack,
			},
		},
		{
			["name"] = "GBU-12*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = PinpointStrike,
			},
		},
		{
			["name"] = "GBU-16*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = PinpointStrike,
			},
		},
		{
			["name"] = "GBU-24*2",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 GBU-24}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 GBU-24}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = PinpointStrike,
				[3] = RunwayAttack,
			},
		},
		{
			["name"] = "Mk-84*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = RunwayAttack,
			},
		},
		{
			["name"] = "Mk-83*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = RunwayAttack,
			},
		},
		{
			["name"] = "Mk-82*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
			},
		},
		{
			["name"] = "Mk-82*14",
			["pylons"] = {
				{
					["CLSID"] = "{MAK79_MK82 4}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{MAK79_MK82 4}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{MAK79_MK82 3L}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{MAK79_MK82 3R}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "Mk-81*14",
			["pylons"] = {
				{
					["CLSID"] = "{MAK79_MK81 4}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{MAK79_MK81 4}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{MAK79_MK81 3L}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{MAK79_MK81 3R}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "Mk-20*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
			},
		},
		{
			["name"] = "Mk-82AIR*4",
			["pylons"] = {
				{
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
			},
		},
		{
			["name"] = "Zuni*12",
			["pylons"] = {
				{
					["CLSID"] = "{BRU3242_2*LAU10 R}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU3242_LAU10}", ["num"] = pylon_6,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "Zuni*28",
			["pylons"] = {
				{
					["CLSID"] = "{BRU3242_2*LAU10 R}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BRU3242_LAU10}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{PHXBRU3242_2*LAU10 LS}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{PHXBRU3242_2*LAU10 RS}", ["num"] = pylon_8B,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "LUU-2*24",
			["pylons"] = {
				{
					["CLSID"] = "{BRU3242_2*SUU25 R}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{BRU3242_SUU25}", ["num"] = pylon_5,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
				[3] = RunwayAttack,
				[4] = PinpointStrike,
			},
		},
		{
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, Mk-82*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, Mk-82*1",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
		{
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, Mk-20*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
			},
		},
	},
	["unitType"] = "F-14A-95-GR",
}
return unitPayloads
