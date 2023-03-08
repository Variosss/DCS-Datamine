local pylon_1A,pylon_1B,pylon_2,pylon_3,pylon_4,pylon_5,pylon_6,pylon_7,pylon_8B,pylon_8A = 1,2,3,4,5,6,7,8,9,10

local unitPayloads = {
	["name"] = "F-14A",
	["payloads"] = {
		{
			["name"] = "XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[2] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
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
			["name"] = "AIM-54A-MK47*6, AIM-9L*2, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 R}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{SHOULDER AIM_54A_Mk47 L}", ["num"] = pylon_1B,
				},
				[10] = {
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
            ["name"] = "AIM-7F*6, AIM-9L*2, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				[2] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				[3] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[4] = {
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				[5] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[6] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				[10] = {
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
			["name"] = "AIM-54A-MK47*4, AIM-7F*2, AIM-9L*2, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{SHOULDER AIM-7F}", ["num"] = pylon_1B,
				},
				[10] = {
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
			["name"] = "AIM-54A-MK47*2, AIM-7F*1, AIM-9L*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				[6] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[7] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				[8] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_1A,
				},
				[9] = {
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
			["name"] = "AIM-54A-MK47*4, AIM-9L*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				[10] = {
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
			["name"] = "AIM-54A-MK47*4, AIM-9M*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{LAU-7 - AIM-9M}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{AIM_54A_Mk47}", ["num"] = pylon_3,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{LAU-7 - AIM-9M}", ["num"] = pylon_1B,
				},
				[10] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
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
			["name"] = "AIM-54A-MK60*4, AIM-9M*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{LAU-7 - AIM-9M}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_6,
				},
				[5] = {
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{AIM_54A_Mk60}", ["num"] = pylon_3,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{LAU-7 - AIM-9M}", ["num"] = pylon_1B,
				},
				[10] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
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
			["name"] = "AIM-7F*4, AIM-9L*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[2] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				[3] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[4] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				[5] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				[6] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				[7] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				[10] = {
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
			["name"] = "AIM-7F*4, AIM-9L*4, XT*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_6,
				},
				[2] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_3,
				},
				[3] = {
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				[4] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_8B,
				},
				[5] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				[6] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_4,
				},
				[7] = {
					["CLSID"] = "{BELLY AIM-7F}", ["num"] = pylon_5,
				},
				[8] = {
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				[9] = {
					["CLSID"] = "{LAU-7 - AIM-9L}", ["num"] = pylon_1B,
				},
				[10] = {
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
			["name"] = "BDU-33*14",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MAK79_BDU33 4}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{MAK79_BDU33 4}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{MAK79_BDU33 3L}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU3242_3*BDU33}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 GBU-10}", ["num"] = pylon_3,
				},
				[2] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 GBU-16}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 GBU-24}", ["num"] = pylon_3,
				},
				[2] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 MK-84}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 MK-83}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{MAK79_MK82 4}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{MAK79_MK82 4}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{MAK79_MK82 3L}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{MAK79_MK81 4}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{MAK79_MK81 4}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{MAK79_MK81 3L}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{BRU-32 MK-82AIR}", ["num"] = pylon_4,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU3242_2*LAU10 R}", ["num"] = pylon_3,
				},
				[2] = {
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
				[1] = {
					["CLSID"] = "{BRU3242_2*LAU10 R}", ["num"] = pylon_3,
				},
				[2] = {
					["CLSID"] = "{BRU3242_LAU10}", ["num"] = pylon_6,
				},
				[3] = {
					["CLSID"] = "{PHXBRU3242_2*LAU10 LS}", ["num"] = pylon_1B,
				},
				[4] = {
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
				[1] = {
					["CLSID"] = "{BRU3242_2*SUU25 R}", ["num"] = pylon_4,
				},
				[2] = {
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
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, XT*2, Mk-82*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
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
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, XT*2, Mk-82*1",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
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
			["name"] = "AIM-54A-MK60*1, AIM-7F*1, AIM-9L*2, XT*2, Mk-20*2",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9L}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 R}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
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
			["name"] = "AIM-7M*1, AIM-9M*2, XT*2, GBU-12*2, LANTIRN",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{F14-LANTIRN-TP}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 GBU-12}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7M}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
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
			["name"] = "AIM-7M*1, AIM-9M*2, XT*2, GBU-24*1, LANTIRN",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{F14-LANTIRN-TP}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 GBU-24}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				{
					["CLSID"] = "{SHOULDER AIM-7M}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
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
			["name"] = "AIM-54A-MK60*1, AIM-7M*1, AIM-9M*2, XT*2, Mk-82*2, LANTIRN",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{F14-LANTIRN-TP}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-82}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BELLY AIM-7M}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
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
			["name"] = "AIM-54A-MK60*1, AIM-7M*1, AIM-9M*2, XT*2, Mk-20*2, LANTIRN",
			["pylons"] = {
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_8A,
				},
				{
					["CLSID"] = "{F14-LANTIRN-TP}", ["num"] = pylon_8B,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_7,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_6,
				},
				{
					["CLSID"] = "{BRU-32 MK-20}", ["num"] = pylon_3,
				},
				{
					["CLSID"] = "{BELLY AIM-7M}", ["num"] = pylon_4,
				},
				{
					["CLSID"] = "{F14-300gal}", ["num"] = pylon_2,
				},
				{
					["CLSID"] = "{SHOULDER AIM_54A_Mk60 L}", ["num"] = pylon_1B,
				},
				{
					["CLSID"] = "{LAU-138 wtip - AIM-9M}", ["num"] = pylon_1A,
				},
			},
			["tasks"] = {
				[1] = GroundAttack,
				[2] = CAS,
				[3] = RunwayAttack,
				[4] = PinpointStrike,
			},
		},
	},
	["unitType"] = "F-14A-135-GR",
}
return unitPayloads
