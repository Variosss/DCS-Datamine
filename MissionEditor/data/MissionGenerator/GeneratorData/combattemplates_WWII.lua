combatTemplates = 
{
	[1] = 
	{
		coalition	=	"red",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3619.757597945,	3419.8843027473},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{2216.3101217505,	-5416.9802073022},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{1648.5609594666,	20236.213193081},
				name	=	"Transport",
				isTarget	=	false,
				pMin = 	{-2789.9646104976,	790.97772073407},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{5300.2686250218,	21117.243780731},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{4232.8314814177,	20375.258795424},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2677.2423887112,	5958.8658335331},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{1354.9222962769,	713.94150640396},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 1",
			}, -- end of [4]			
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3619.757597945,	3419.8843027473},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{2216.3101217505,	-5416.9802073022},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany					
			}, -- end of [5]			
			[6] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"Red Fighters Min",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	true,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Max",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [6]					
					[7] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [7]
					[8] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [8]
					[9] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [9]							
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				pMax = 	{-7495.8682523689,	18400.535131044},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Max",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [6]					
					[7] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [7]
					[8] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [8]
					[9] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [9]		
				}, -- end of combatCompany
				name	=	"Attack Aircraft",
				pMin = 	{-13495.223741906,	2471.7062022276},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [7]
			[8] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2855.3208027882,	17309.851499618},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{1587.7484609678,	11548.354264838},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 2",
			}, -- end of [8]
		}, -- end of companies
		name	=	"Red Offensive - Large 1",
		playerZone = 
		{
			pMin = 	{-13577.333669089,	-14045.926837706},
			pMax = 	{-7844.6273421591,	1568.2152809611},
		}, -- end of playerZone
	}, -- end of [1]
	[2] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-42102.686482029,	-21920.844028928},
			pMax = 	{-25768.817458661,	23226.035740803},
		}, -- end of playerZone
		name	=	"Red Defensive - Large 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 2",
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [7]
			[8] = 
			{
				pMax = 	{-44489.445376521,	23201.231967949},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [6]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [4]
					[6] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
				name	=	"Air Cover",
				pMin = 	{-81819.08046629,	-18732.431985817},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [8]
		}, -- end of companies
	}, -- end of [2]
	[3] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-8326.3254981797,	12754.483124098},
			pMax = 	{-1242.4773442717,	28868.272003706},
		}, -- end of playerZone
		name	=	"Red Offensive - Large 2",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				name	=	"AAA 2",
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [7]
			[8] = 
			{
				pMax = 	{-44489.445376521,	23201.231967949},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
				isStartFromRunway    =    false,
                pMin =     {-16807.264350273,    -24719.702175863},
                companyType    =    "AttackPlanes",
                behaviour    =    "aAttackGround",
                name    =    "Attack Aircraft",
			}, -- end of [8]	
		}, -- end of companies			
	}, -- end of [3]						
	[4] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-11775.964383789,	-6423.7779369659},
			pMax = 	{-7892.3721128635,	4367.5906095792},
		}, -- end of playerZone
		name	=	"Red Defensive - Large 2",
		companies = 
{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				name	=	"AAA 2",
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				name	=	"AAA 1",
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [7]
			[8] = 
			{
				pMax = 	{-44489.445376521,	23201.231967949},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
				isStartFromRunway    =    false,
                pMin =     {-16807.264350273,    -24719.702175863},
                companyType    =    "AttackPlanes",
                behaviour    =    "aAttackGround",
                name    =    "Attack Aircraft",
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [4]
	[5] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-16745.268218756,	6201.5579181586},
			pMax = 	{-9798.8552163714,	18016.174722564},
		}, -- end of playerZone
		name	=	"Red Offensive - Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-708.99353144254,	2700.8204636156},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-11921.102282126,	-8107.8127185344},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{1813.7807483813,	2875.6896192638},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{821.29550266488,	-7564.6378152579},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2485.7858664765,	3005.6174308895},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{1374.7368629581,	-8968.7535408603},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-858.05626366891,	2497.7754454902},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-2736.0679017563,	-2531.4215337262},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 23-375 1",
			}, -- end of [4]
			[5] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"Red Fighters",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				pMax = 	{-9986.3160485972,	-9371.1935206532},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isStartFromRunway	=	false,
				pMin = 	{-16807.264350273,	-24719.702175863},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				name	=	"Attack Aircraft",
			}, -- end of [6]
		}, -- end of companies
	}, -- end of [5]
	[6] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-14684.362822287,	-8415.75679962},
			pMax = 	{-4789.9095850631,	1345.3215274879},
		}, -- end of playerZone
		name	=	"Red Defensive - Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{501.33001114219,	-8026.0727061681},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [1]
			[2] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"Red Fighters",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-636.02694451389,	911.08712505822},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-6997.7792905714,	-7314.2871808717},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4714.5184099525,	859.12141943238},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{3458.3970394823,	-7208.7694664334},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [6]
	[7] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-26249.758895863,	-17795.792785475},
			pMax = 	{-16445.667208273,	17766.98741007},
		}, -- end of playerZone
		name	=	"Red Offensive - Medium 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{4166.155412386,	6914.689953253},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{2317.2152529057,	-8823.4186187534},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{638.49510711408,	-1135.3386000742},
				name	=	"Armour 1",
				isTarget	=	false,
				pMin = 	{-1133.5672473938,	-10232.955426778},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{725.07326062966,	8337.56976692},
				name	=	"Armour 2",
				isTarget	=	false,
				pMin = 	{-991.63844620684,	1083.1646332369},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				pMax = 	{-59.518415080162,	-19385.123985018},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isStartFromRunway	=	false,
				pMin = 	{-15276.660049034,	-46716.18746037},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				name	=	"Attack Aircraft 1",
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-2485.8450005216,	7849.9752781164},
				name	=	"Logistics 1",
				isTarget	=	false,
				pMin = 	{-15269.400753811,	-9891.5095445218},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4807.6202311773,	8284.4342805304},
				name	=	"Recon 1",
				isTarget	=	false,
				pMin = 	{1899.0985348338,	-10332.817451891},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				name	=	"Red Fighters",
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[2] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[1] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[4] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [5]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [7]
		}, -- end of companies
	}, -- end of [7]
	[8] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-29968.486027344,	-9336.1199365999},
			pMax = 	{-7961.471774709,	6038.834039137},
		}, -- end of playerZone
		name	=	"Red Defensive - Medium 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4728.0648367048,	4545.8073606291},
				name	=	"Armour 1",
				isTarget	=	true,
				pMin = 	{3123.1271167597,	-8241.8163751709},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{7719.4605660056,	3121.8571077954},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{5383.9043985675,	-6186.8799690784},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [5]
				}, -- end of combatCompany
				name	=	"Red Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-348.17425198027,	3377.1028802362},
				name	=	"Logistics 1",
				isTarget	=	false,
				pMin = 	{-20757.639735079,	-7468.2566672922},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Blitz Truck Platoon", "Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon", "SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"Blitz Truck Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [8]
	[9] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-15934.32093991,	-1693.4835529884},
			pMax = 	{-2144.9748941255,	3831.1202265611},
		}, -- end of playerZone
		name	=	"Red Offensive - Very Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Wedge",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2069.3781960005,	3750.6603290159},
				name	=	"Armour 1",
				isTarget	=	false,
				pMin = 	{1136.941930798,	-1677.7215762973},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Red Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [2]
		}, -- end of companies
	}, -- end of [9]
	[10] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-12929.254491242,	3894.5496875566},
			pMax = 	{-2899.4221255557,	14893.465999788},
		}, -- end of playerZone
		name	=	"Red Defensive - Very Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Wedge",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3380.513540374,	2875.2841310401},
				name	=	"IFV 1",
				isTarget	=	true,
				pMin = 	{1936.4860647708,	-3440.3711398586},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight",	"FW-190D9 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Red Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [2]
		}, -- end of companies
	}, -- end of [10]
	[11] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-14135.093833701,	-28552.624808489},
			pMax = 	{-1950.94761769,	25098.899239839},
		}, -- end of playerZone
		name	=	"Red Modern CAP",
		companies = 
		{
			[1] = 
			{
				isStartFromRunway	=	false,
				pMax = 	{27510.702135124,	66682.638217643},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-14747.339084144,	-70801.890395319},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				name	=	"Fighter Flights",
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Row"},
				pMax = 	{1007.4639001667,	2929.5753167879},
				name	=	"Target Placeholder",
				isTarget	=	true,
				pMin = 	{-1728.3761433295,	-2847.6541356351},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Row"},
				pMin = 	{-5530.1718005984,	-8072.2188516978},
				pMax = 	{6981.6613033172,	6526.607767631},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA",
			}, -- end of [3]
		}, -- end of companies
	}, -- end of [11]
	[12] = 
	{
		coalition	=	"red",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-66680.305832,	67879.356692424},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-79807.198872394,	-64963.212881755},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Row"},
				pMax = 	{1304.5173686354,	1523.4559687934},
				name	=	"Target Placeholder",
				isTarget	=	true,
				pMin = 	{-1378.1281804611,	-2136.3493068566},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SdKfz 251 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Pz IV Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Pz IV Platoon",	"Pz IV Platoon",	"Pz IV Platoon",	"SdKfz 251 Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Chaos 1"},
				pMax = 	{6221.9440326818,	6689.8918833893},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Flak 18 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Flak 18 Platoon",	"Flak 18 Platoon",	"Flak 18 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-6289.8890712338,	-7908.9347359391},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA",
			}, -- end of [3]
		}, -- end of companies
		name	=	"Red Modern Intercept",
		playerZone = 
		{
			pMin = 	{-61562.759804723,	-46378.991294438},
			pMax = 	{-51058.73488533,	49861.073575576},
		}, -- end of playerZone
	}, -- end of [12]
	[13] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-42098.208295814,	-65307.634482437},
			pMax = 	{-29087.471419974,	-1747.0650238133},
		}, -- end of playerZone
		name	=	"Red Modern Fighter Sweep",
		companies = 
		{
			[1] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{-29672.463410055,	68683.774290733},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-42158.588177747,	5534.6036360324},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
		}, -- end of companies
	}, -- end of [13]
	[14] = 
	{
		coalition	=	"red",
		companies = 
		{
			[1] = 
			{
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMax = 	{-77160.853262222,	37549.882410862},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-90113.566721684,	7771.1060898962},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				isStartFromRunway	=	false,
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				name	=	"SEAD Flights",
				isStartFromRunway	=	false,
				pMin = 	{-106310.51947095,	-24007.250458662},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	39339.078767411},
				name	=	"Strike Flights",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMin = 	{-120441.31874188,	-23810.091887287},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				companyType	=	"AttackPlanes",
			}, -- end of [3]
		}, -- end of companies
		name	=	"Red Modern Escort",
		playerZone = 
		{
			pMin = 	{-90508.809859484,	-24510.140144714},
			pMax = 	{-76961.577275337,	6672.4316150398},
		}, -- end of playerZone
	}, -- end of [14]
	[15] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
		name	=	"Red Modern Ground Attack",
		companies = 
		{
			[1] = 
			{
				isStartFromRunway	=	false,
				pMax = 	{-74865.717081762,	37689.315826976},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				name	=	"Fighter Flights",
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				name	=	"SEAD Flights",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMin = 	{-106310.51947095,	-24007.250458662},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				companyType	=	"AttackPlanes",
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-120848.19912574,	10017.177738364},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"Strike Flights",
			}, -- end of [3]
		}, -- end of companies
	}, -- end of [15]
	[16] = 
	{
		coalition	=	"red",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-75939.054622379,	37152.817515946},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"Bf-109K-4 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-90992.329122917,	-23850.707814576},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-106897.74773298,	9588.0564486542},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"SEAD Flights",
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Strike Flights",
				pMin = 	{-122888.88888459,	-23301.553509551},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [3]
		}, -- end of companies
		name	=	"Red Modern SEAD",
		playerZone = 
		{
			pMin = 	{-106485.75239302,	-23458.655777746},
			pMax = 	{-92938.519808873,	7723.9159820076},
		}, -- end of playerZone
	}, -- end of [16]
	[17] = 
	{
		coalition	=	"red",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-74865.717081762,	37689.315826976},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[3] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-106310.51947095,	-24007.250458662},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"SEAD Flights",
			}, -- end of [3]
			[4] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Strike Flights",
				pMin = 	{-120848.19912574,	10017.177738364},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [4]
		}, -- end of companies
		name	=	"Red Modern Runway Attack",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
	}, -- end of [17]
	[18] = 
	{
		coalition	=	"red",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
		name	=	"Red Modern Anti-Ship",
		companies = 
		{
			[1] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{-74865.717081762,	37689.315826976},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190D9 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190D9 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190D9 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"SEAD Flights",
				pMin = 	{-106310.51947095,	-24007.250458662},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				name	=	"Strike Flights",
				isStartFromRunway	=	false,
				pMin = 	{-120848.19912574,	10017.177738364},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"FW-190-A8 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"FW-190-A8 Flight",	"FW-190-A8 Flight",	"FW-190-A8 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [18]
	[19] = 
	{
		coalition	=	"blue",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3619.757597945,	3419.8843027473},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{2216.3101217505,	-5416.9802073022},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany					
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{1648.5609594666,	20236.213193081},
				name	=	"Transport",
				isTarget	=	false,
				pMin = 	{-2789.9646104976,	790.97772073407},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{5300.2686250218,	21117.243780731},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{4232.8314814177,	20375.258795424},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2677.2423887112,	5958.8658335331},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{1354.9222962769,	713.94150640396},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 1",
			}, -- end of [4]			
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3619.757597945,	3419.8843027473},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{2216.3101217505,	-5416.9802073022},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany					
			}, -- end of [5]			
			[6] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"blue Fighters Min",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	true,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Max",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [6]					
					[7] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [7]
					[8] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [8]
					[9] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [9]							
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				pMax = 	{-7495.8682523689,	18400.535131044},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Max",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [5]
					[6] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [6]					
					[7] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [7]
					[8] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [8]
					[9] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [9]		
				}, -- end of combatCompany
				name	=	"Attack Aircraft",
				pMin = 	{-13495.223741906,	2471.7062022276},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [7]
			[8] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2855.3208027882,	17309.851499618},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{1587.7484609678,	11548.354264838},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 2",
			}, -- end of [8]
		}, -- end of companies
		name	=	"Blue Offensive - Large 1",
		playerZone = 
		{
			pMin = 	{-13577.333669089,	-14045.926837706},
			pMax = 	{-7844.6273421591,	1568.2152809611},
		}, -- end of playerZone
	}, -- end of [19]
	[20] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-42102.686482029,	-21920.844028928},
			pMax = 	{-25768.817458661,	23226.035740803},
		}, -- end of playerZone
		name	=	"Blue Defensive - Large 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 2",
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [7]
			[8] = 
			{
				pMax = 	{-44489.445376521,	23201.231967949},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [6]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [4]
					[6] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
				name	=	"Air Cover",
				pMin = 	{-81819.08046629,	-18732.431985817},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [8]
		}, -- end of companies
	}, -- end of [20]
	[21] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-8326.3254981797,	12754.483124098},
			pMax = 	{-1242.4773442717,	28868.272003706},
		}, -- end of playerZone
		name	=	"Blue Offensive - Large 2",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 2",
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [7]
			[8] = 
			{
				pMax = 	{-44489.445376521,	23201.231967949},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [6]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [4]
					[6] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of companies
				isStartFromRunway    =    false,
                pMin =     {-17868.841421156,    -21830.580832286},
                companyType    =    "AttackPlanes",
                behaviour    =    "aAttackGround",
                name    =    "Attack Aircraft",
			}, -- end of [8]
		}, -- end of companies
	}, -- end of [21]						
	[22] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-11775.964383789,	-6423.7779369659},
			pMax = 	{-7892.3721128635,	4367.5906095792},
		}, -- end of playerZone
		name	=	"Blue Defensive -Large 2",
		companies = 
{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-844.92983192653,	-6032.950226636},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{-3022.0022617871,	-16435.633088128},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-21578.321084693,	-20913.536789108},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 2",
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-3285.6870394134,	15259.812176045},
				name	=	"Armour",
				isTarget	=	true,
				pMin = 	{-11506.550985996,	-17541.458124975},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-12171.269253488,	15187.008272509},
				name	=	"Transport",
				isTarget	=	true,
				pMin = 	{-19257.660532265,	-17617.990442203},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [11]
				}, -- end of combatCompany
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-10887.194284922,	12882.651746347},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-51931.232907136,	-14401.030886899},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-1062.8924528009,	14362.354054415},
				name	=	"JTAC 2",
				isTarget	=	false,
				pMin = 	{-3011.0489905838,	3598.0387074224},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-8565.8568509803,	18325.866602042},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{-14314.813704441,	-20743.259076553},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [7]
			[8] = 
			{
                pMax =     {0,    1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [6]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [4]
					[6] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [6]
				}, -- end of combatCompany
				companyType    =    "FighterPlanes",
                name    =    "Blue Fighters",
                isTarget    =    false,
                pMin =     {-1000,    -1000},
                isStartFromRunway    =    false,
                behaviour    =    "aAttackAir",
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [22]
	[23] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-16745.268218756,	6201.5579181586},
			pMax = 	{-9798.8552163714,	18016.174722564},
		}, -- end of playerZone
		name	=	"Blue Offensive - Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-708.99353144254,	2700.8204636156},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-11921.102282126,	-8107.8127185344},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{1813.7807483813,	2875.6896192638},
				name	=	"Armour",
				isTarget	=	false,
				pMin = 	{821.29550266488,	-7564.6378152579},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2485.7858664765,	3005.6174308895},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{1374.7368629581,	-8968.7535408603},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{-858.05626366891,	2497.7754454902},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-2736.0679017563,	-2531.4215337262},
				companyType	=	"AAA",
				behaviour	=	"gAttack",
				name	=	"AAA 23-375 1",
			}, -- end of [4]
			[5] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"blue Fighters",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				pMax = 	{-9986.3160485972,	-9371.1935206532},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isStartFromRunway	=	false,
				pMin = 	{-16807.264350273,	-24719.702175863},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				name	=	"Attack Aircraft",
			}, -- end of [6]
		}, -- end of companies
	}, -- end of [23]
	[24] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-14684.362822287,	-8415.75679962},
			pMax = 	{-4789.9095850631,	1345.3215274879},
		}, -- end of playerZone
		name	=	"Blue Defensive - Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-16528.330819266,	18063.881294938},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	true,
				pMin = 	{501.33001114219,	-8026.0727061681},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA 1",
			}, -- end of [1]
			[2] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{0,	1000},
				name	=	"blue Fighters",
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-636.02694451389,	911.08712505822},
				name	=	"Logistics",
				isTarget	=	false,
				pMin = 	{-6997.7792905714,	-7314.2871808717},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4714.5184099525,	859.12141943238},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{3458.3970394823,	-7208.7694664334},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [24]
	[25] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-26249.758895863,	-17795.792785475},
			pMax = 	{-16445.667208273,	17766.98741007},
		}, -- end of playerZone
		name	=	"Blue Offensive - Medium 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{4166.155412386,	6914.689953253},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{2317.2152529057,	-8823.4186187534},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{638.49510711408,	-1135.3386000742},
				name	=	"Armour 1",
				isTarget	=	false,
				pMin = 	{-1133.5672473938,	-10232.955426778},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{725.07326062966,	8337.56976692},
				name	=	"Armour 2",
				isTarget	=	false,
				pMin = 	{-991.63844620684,	1083.1646332369},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [3]
			[4] = 
			{
				pMax = 	{-59.518415080162,	-19385.123985018},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isStartFromRunway	=	false,
				pMin = 	{-15276.660049034,	-46716.18746037},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				name	=	"Attack Aircraft 1",
			}, -- end of [4]
			[5] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-2485.8450005216,	7849.9752781164},
				name	=	"Logistics 1",
				isTarget	=	false,
				pMin = 	{-15269.400753811,	-9891.5095445218},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [5]
			[6] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4807.6202311773,	8284.4342805304},
				name	=	"Recon 1",
				isTarget	=	false,
				pMin = 	{1899.0985348338,	-10332.817451891},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [6]
			[7] = 
			{
				name	=	"blue Fighters",
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[2] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[1] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[4] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [5]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [7]
		}, -- end of companies
	}, -- end of [25]
	[26] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-29968.486027344,	-9336.1199365999},
			pMax = 	{-7961.471774709,	6038.834039137},
		}, -- end of playerZone
		name	=	"Blue Defensive - Medium 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Column",	"Chaos 2",	"Chaos 1"},
				pMax = 	{4728.0648367048,	4545.8073606291},
				name	=	"Armour 1",
				isTarget	=	true,
				pMin = 	{3123.1271167597,	-8241.8163751709},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{7719.4605660056,	3121.8571077954},
				name	=	"JTAC 1",
				isTarget	=	false,
				pMin = 	{5383.9043985675,	-6186.8799690784},
				companyType	=	"Vehicles",
				behaviour	=	"gJTAC",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [3]
					[1] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[4] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [4]
					[5] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [5]
				}, -- end of combatCompany
				name	=	"blue Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [3]
			[4] = 
			{
				startPositions = 	{"Column"},
				pMax = 	{-348.17425198027,	3377.1028802362},
				name	=	"Logistics 1",
				isTarget	=	false,
				pMin = 	{-20757.639735079,	-7468.2566672922},
				companyType	=	"Vehicles",
				behaviour	=	"gMovingByRoad",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bedford Truck Platoon", "Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon", "M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"Bedford Truck Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [26]
	[27] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-15934.32093991,	-1693.4835529884},
			pMax = 	{-2144.9748941255,	3831.1202265611},
		}, -- end of playerZone
		name	=	"Blue Offensive - Very Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Wedge",	"Chaos 2",	"Chaos 1"},
				pMax = 	{2069.3781960005,	3750.6603290159},
				name	=	"Armour 1",
				isTarget	=	false,
				pMin = 	{1136.941930798,	-1677.7215762973},
				companyType	=	"Vehicles",
				behaviour	=	"gAttack",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"blue Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [2]
		}, -- end of companies
	}, -- end of [27]
	[28] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-12929.254491242,	3894.5496875566},
			pMax = 	{-2899.4221255557,	14893.465999788},
		}, -- end of playerZone
		name	=	"Blue Defensive - Very Small 1",
		companies = 
		{
			[1] = 
			{
				startPositions = 	{"Wedge",	"Chaos 2",	"Chaos 1"},
				pMax = 	{3380.513540374,	2875.2841310401},
				name	=	"IFV 1",
				isTarget	=	true,
				pMin = 	{1936.4860647708,	-3440.3711398586},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{0,	1000},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-51D Flight",	"P-51D Flight",	"P-51D Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"blue Fighters",
				pMin = 	{-1000,	-1000},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [2]
		}, -- end of companies
	}, -- end of [28]
	[29] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-14135.093833701,	-28552.624808489},
			pMax = 	{-1950.94761769,	25098.899239839},
		}, -- end of playerZone
		name	=	"Blue Modern CAP",
		companies = 
		{
			[1] = 
			{
				isStartFromRunway	=	false,
				pMax = 	{27510.702135124,	66682.638217643},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-14747.339084144,	-70801.890395319},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				name	=	"Fighter Flights",
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Row"},
				pMax = 	{1007.4639001667,	2929.5753167879},
				name	=	"Target Placeholder",
				isTarget	=	true,
				pMin = 	{-1728.3761433295,	-2847.6541356351},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Row"},
				pMin = 	{-5530.1718005984,	-8072.2188516978},
				pMax = 	{6981.6613033172,	6526.607767631},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA",
			}, -- end of [3]
		}, -- end of companies
	}, -- end of [29]
	[30] = 
	{
		coalition	=	"blue",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-66680.305832,	67879.356692424},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-79807.198872394,	-64963.212881755},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[2] = 
			{
				startPositions = 	{"Row"},
				pMax = 	{1304.5173686354,	1523.4559687934},
				name	=	"Target Placeholder",
				isTarget	=	true,
				pMin = 	{-1378.1281804611,	-2136.3493068566},
				companyType	=	"Vehicles",
				behaviour	=	"gStay",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"M2A1 Halftrack Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Sherman Platoon"},
						amount	=	"Min",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Med",
					}, -- end of [3]
					[4] = 
					{
						company = 	{"Sherman Platoon",	"Sherman Platoon",	"Sherman Platoon",	"M2A1 Halftrack Platoon"},
						amount	=	"Max",
					}, -- end of [4]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				startPositions = 	{"Chaos 1"},
				pMax = 	{6221.9440326818,	6689.8918833893},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"Bofors 40 Platoon"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Med",
					}, -- end of [2]					
					[3] = 
					{
						company = 	{"Bofors 40 Platoon",	"Bofors 40 Platoon",	"Bofors 40 Platoon"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-6289.8890712338,	-7908.9347359391},
				companyType	=	"AAA",
				behaviour	=	"gStay",
				name	=	"AAA",
			}, -- end of [3]
		}, -- end of companies
		name	=	"Blue Modern Intercept",
		playerZone = 
		{
			pMin = 	{-61562.759804723,	-46378.991294438},
			pMax = 	{-51058.73488533,	49861.073575576},
		}, -- end of playerZone
	}, -- end of [30]
	[31] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-42098.208295814,	-65307.634482437},
			pMax = 	{-29087.471419974,	-1747.0650238133},
		}, -- end of playerZone
		name	=	"Blue Modern Fighter Sweep",
		companies = 
		{
			[1] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{-29672.463410055,	68683.774290733},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-42158.588177747,	5534.6036360324},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
		}, -- end of companies
	}, -- end of [31]
	[32] = 
	{
		coalition	=	"blue",
		companies = 
		{
			[1] = 
			{
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMax = 	{-77160.853262222,	37549.882410862},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-90113.566721684,	7771.1060898962},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				isStartFromRunway	=	false,
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				name	=	"SEAD Flights",
				isStartFromRunway	=	false,
				pMin = 	{-106310.51947095,	-24007.250458662},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	39339.078767411},
				name	=	"Strike Flights",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMin = 	{-120441.31874188,	-23810.091887287},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				companyType	=	"AttackPlanes",
			}, -- end of [3]
		}, -- end of companies
		name	=	"Blue Modern Escort",
		playerZone = 
		{
			pMin = 	{-90508.809859484,	-24510.140144714},
			pMax = 	{-76961.577275337,	6672.4316150398},
		}, -- end of playerZone
	}, -- end of [32]
	[33] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
		name	=	"Blue Modern Ground Attack",
		companies = 
		{
			[1] = 
			{
				isStartFromRunway	=	false,
				pMax = 	{-74865.717081762,	37689.315826976},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				companyType	=	"FighterPlanes",
				behaviour	=	"aAttackAir",
				name	=	"Fighter Flights",
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				name	=	"SEAD Flights",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				pMin = 	{-106310.51947095,	-24007.250458662},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				companyType	=	"AttackPlanes",
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-120848.19912574,	10017.177738364},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"Strike Flights",
			}, -- end of [3]
		}, -- end of companies
	}, -- end of [33]
	[34] = 
	{
		coalition	=	"blue",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-75939.054622379,	37152.817515946},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"SpitfireLFMkIX Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-90992.329122917,	-23850.707814576},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-106897.74773298,	9588.0564486542},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"SEAD Flights",
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Strike Flights",
				pMin = 	{-122888.88888459,	-23301.553509551},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [3]
		}, -- end of companies
		name	=	"Blue Modern SEAD",
		playerZone = 
		{
			pMin = 	{-106485.75239302,	-23458.655777746},
			pMax = 	{-92938.519808873,	7723.9159820076},
		}, -- end of playerZone
	}, -- end of [34]
	[35] = 
	{
		coalition	=	"blue",
		companies = 
		{
			[1] = 
			{
				name	=	"Fighter Flights",
				pMax = 	{-74865.717081762,	37689.315826976},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				companyType	=	"FighterPlanes",
			}, -- end of [1]
			[3] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				companyType	=	"AttackPlanes",
				pMin = 	{-106310.51947095,	-24007.250458662},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackGround",
				name	=	"SEAD Flights",
			}, -- end of [3]
			[4] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"Strike Flights",
				pMin = 	{-120848.19912574,	10017.177738364},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [4]
		}, -- end of companies
		name	=	"Blue Modern Runway Attack",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
	}, -- end of [35]
	[36] = 
	{
		coalition	=	"blue",
		playerZone = 
		{
			pMin = 	{-121459.60717918,	-23660.188949842},
			pMax = 	{-107912.37459504,	7522.3828099113},
		}, -- end of playerZone
		name	=	"Blue Modern Anti-Ship",
		companies = 
		{
			[1] = 
			{
				companyType	=	"FighterPlanes",
				pMax = 	{-74865.717081762,	37689.315826976},
				name	=	"Fighter Flights",
				isTarget	=	false,
				pMin = 	{-89918.991582299,	-23314.209503547},
				isStartFromRunway	=	false,
				behaviour	=	"aAttackAir",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-51D Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-51D Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-51D Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [1]
			[2] = 
			{
				pMax = 	{-93824.394703258,	39141.920196036},
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
				name	=	"SEAD Flights",
				pMin = 	{-106310.51947095,	-24007.250458662},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				isStartFromRunway	=	false,
			}, -- end of [2]
			[3] = 
			{
				pMax = 	{-107955.19397419,	38819.195890127},
				name	=	"Strike Flights",
				isStartFromRunway	=	false,
				pMin = 	{-120848.19912574,	10017.177738364},
				companyType	=	"AttackPlanes",
				behaviour	=	"aAttackGround",
				combatCompany = 
				{
					[1] = 
					{
						company = 	{"P-47D-30 Flight"},
						amount	=	"Min",
					}, -- end of [1]
					[2] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Med",
					}, -- end of [2]
					[3] = 
					{
						company = 	{"P-47D-30 Flight",	"P-47D-30 Flight",	"P-47D-30 Flight"},
						amount	=	"Max",
					}, -- end of [3]
				}, -- end of combatCompany
			}, -- end of [4]
		}, -- end of companies
	}, -- end of [36]
} -- end of combatTemplates
