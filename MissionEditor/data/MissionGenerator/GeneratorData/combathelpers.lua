local gettext       	= require("i_18n")

--db_path 	= db_path or "../MissionEditor/modules/"
dofile("./MissionEditor/modules/me_localizationMG.lua")
local localizationMG 	= require('me_localizationMG')
_ = gettext.translate

platoons = 
{
    [1] = 
    {
        name = "K-50 Flight",
        units = {"Ka-50", "Ka-50"},
        companyType = "Helicopters"
    },
    [2] = 
    {
        name = "AH-64A Flight",
        units = {"AH-64A", "AH-64A"},
        companyType = "Helicopters"
    },
    [3] = 
    {
        name = "AH-1W Flight",
        units = {"AH-1W", "AH-1W", "AH-1W"},
        companyType = "Helicopters"
    },
    [4] = 
    {
        name = "AH-64D Flight",
        units = {"AH-64D", "AH-64D"},
        companyType = "Helicopters"
    },
    [5] = 
    {
        name = "Mi-24V Flight",
        units = {"Mi-24V", "Mi-24V"},
        companyType = "Helicopters"
    },
    [6] = 
    {
        name = "Mi-28N Flight",
        units = {"Mi-28N", "Mi-28N"},
        companyType = "Helicopters"
    },
    [7] = 
    {
        name = "UH-60A Flight",
        units = {"UH-60A", "UH-60A"},
        companyType = "Helicopters",
    },
    [8] = 
    {
        name = "Mi-8MT Flight",
        units = {"Mi-8MT", "Mi-8MT"},
        companyType = "Helicopters",
    },
    [9] = 
    {
        name = "A-10C Flight",
        units = {"A-10C", "A-10C"},
        companyType = "AttackPlanes"
    },
    [10] = 
    {
        name = "Su-24M Flight",
        units = {"Su-24M", "Su-24M"},
        companyType = "AttackPlanes"
    },
    [11] = 
    {
        name = "Su-25T Flight",
        units = {"Su-25T", "Su-25T"},
        companyType = "AttackPlanes"
    },
    [12] = 
    {
        name = "F/A-18C Flight",
        units = {"F/A-18C", "F/A-18C"},
        companyType = "AttackPlanes"
    },
    [13] = 
    {
        name = "Su-25 Flight",
        units = {"Su-25", "Su-25"},
        companyType = "AttackPlanes"
    },
    [14] = 
    {
        name = "MiG-27 Flight",
        units = {"MiG-27K", "MiG-27K"},
        companyType = "AttackPlanes"
    },
    [15] = 
    {
        name = "Su-17M4 Flight",
        units = {"Su-17M4", "Su-17M4"},
        companyType = "AttackPlanes"
    },
    [16] = 
    {
        name = "F-16C Flight",
        units = {"F-16C bl.52d", "F-16C bl.52d"},
        companyType = "AttackPlanes"
    },
    [17] = 
    {
        name = "MiG-29A Flight",
        units = {"MiG-29A", "MiG-29A"},
        companyType = "FighterPlanes"
    },
    [18] = 
    {
        name = "Su-27 Flight",
        units = {"Su-27", "Su-27"},
        companyType = "FighterPlanes"
    },
    [19] = 
    {
        name = "2S6 Tunguska",
        units = {"2S6 Tunguska"},
        companyType = "SAM"
    },
    [20] = 
    {
        name = "M1097 Avenger",
        units = {"M1097 Avenger"},
        companyType = "SAM"
    },
    [21] = 
    {
        name = "T-80UD Platoon",
        units = {"T-80UD", "T-80UD", "T-80UD"},
        companyType = "Vehicles"
    },
    [22] = 
    {
        name = "T-72B Platoon",
        units = {"T-72B", "T-72B", "T-72B"},
        companyType = "Vehicles"
    },
    [23] = 
    {
        name = "T-55 Platoon",
        units = {"T-55", "T-55", "T-55"},
        companyType = "Vehicles"
    },
    [24] = 
    {
        name = "M1A2 Platoon",
        units = {"M-1 Abrams", "M-1 Abrams", "M-1 Abrams", "M-1 Abrams"},
        companyType = "Vehicles"
    },
    [25] = 
    {
        name = "M2A2 Platoon",
        units = {"M-2 Bradley", "M-2 Bradley", "M-2 Bradley", "M-2 Bradley"},
        companyType = "Vehicles"
    },
    [26] = 
    {
        name = "M1A2 and M2A2 Mixed Platoon",
        units = {"M-1 Abrams", "M-1 Abrams", "M-2 Bradley", "M-2 Bradley"},
        companyType = "Vehicles"
    },
    [27] = 
    {
        name = "2S19 Msta Battery",
        units = {"SAU Msta", "SAU Msta", "SAU Msta", "SAU Msta"},
        companyType = "Vehicles"
    },
    [28] = 
    {
        name = "2S1 Battery",
        units = {"SAU Gvozdika", "SAU Gvozdika", "SAU Gvozdika", "SAU Gvozdika"},
        companyType = "Vehicles"
    },
    [29] = 
    {
        name = "M109 Battery",
        units = {"M-109", "M-109", "M-109", "M-109"},
        companyType = "Vehicles"
    },
    [30] = 
    {
        name = "M163 Vulcan",
        units = {"Vulcan"},
        companyType = "AAA"
    },
    [31] = 
    {
        name = "ZSU-23-4 Shilka",
        units = {"ZSU-23-4 Shilka"},
        companyType = "AAA"
    },
    [32] = 
    {
        name = "Zu-23 on Ural-375",
        units = {"Ural-375 ZU-23"},
        companyType = "AAA"
    },
    [33] = 
    {
        name = "M6 Linebacker",
        units = {"M6 Linebacker"},
        companyType = "SAM"
    },
    [34] = 
    {
        name = "MLRS Section",
        units = {"MLRS", "MLRS"},
        companyType = "Vehicles"
    },
    [35] = 
    {
        name = "I-HAWK Battery",
        units = {"Hawk ln", "Hawk ln", "Hawk sr", "Hawk ln", "Hawk ln", "Hawk tr"},
        companyType = "SAM"
    },
    [36] = 
    {
        name = "SA-13 Strela-10",
        units = {"Strela-10M3"},
        companyType = "SAM"
    },
    [37] = 
    {
        name = "SA-18 Igla",
        units = {"SA-18 Igla-S manpad"},
        companyType = "SAM"
    },
    [38] = 
    {
        name = "SA-8 Osa",
        units = {"Osa 9A33 ln"},
        companyType = "SAM"
    },
    [39] = 
    {
        name = "SA-9 Strela-1",
        units = {"Strela-1 9P31"},
        companyType = "SAM"
    },
    [40] = 
    {
        name = "Smerch Section",
        units = {"Smerch", "Smerch"},
        companyType = "Vehicles"
    },
    [41] = 
    {
        name = "BM-21 Grad Section",
        units = {"Grad-URAL", "Grad-URAL"},
        companyType = "Vehicles"
    },
    [42] = 
    {
        name = "SA-11 Buk Battery",
        units = {"SA-11 Buk LN 9A310M1", "SA-11 Buk LN 9A310M1", "SA-11 Buk SR 9S18M1"},
        companyType = "SAM"
    },
    [43] = 
    {
        name = "BMP-3 Platoon",
        units = {"BMP-3", "BMP-3", "BMP-3"},
        companyType = "Vehicles"
    },
    [44] = 
    {
        name = "BMP-2 Platoon",
        units = {"BMP-2", "BMP-2", "BMP-2"},
        companyType = "Vehicles"
    },
    [45] = 
    {
        name = "BMP-1 Platoon",
        units = {"BMP-1", "BMP-1", "BMP-1"},
        companyType = "Vehicles"
    },
    [46] = 
    {
        name = "BTR-80 Platoon",
        units = {"BTR-80", "BTR-80", "BTR-80"},
        companyType = "Vehicles"
    },
    [47] = 
    {
        name = "BRDM-2 Platoon",
        units = {"BRDM-2", "BRDM-2", "BRDM-2"},
        companyType = "Vehicles"
    },
    [48] = 
    {
        name = "HUMMVV Armed",
        units = {"M1043 HMMWV Armament", "M1043 HMMWV Armament"},
        companyType = "Vehicles"
    },
    [49] = 
    {
        name = "M1126 Stryker Platoon",
        units = {"M1126 Stryker ICV", "M1126 Stryker ICV", "M1126 Stryker ICV", "M1126 Stryker ICV"},
        companyType = "Vehicles"
    },
    [50] = 
    {
        name = "M818 Platoon",
        units = {"M 818", "M 818", "M 818", "M 818"},
        companyType = "Vehicles"
    },
    [51] = 
    {
        name = "Ural375 Platoon",
        units = {"Ural-375", "Ural-375", "Ural-375", "Ural-375"},
        companyType = "Vehicles"
    },
    [52] = 
    {
        name = "E-3A",
        units = {"E-3A"},
        companyType = "AttackPlanes"
    },
	--Tank new Dec 2018
	[53] = 
    {
        name = "Challenger2 Platoon",
        units = {"Challenger2", "Challenger2", "Challenger2"},
        companyType = "Vehicles"
    },
	[54] = 
    {
        name = "Leclerc Platoon",
        units = {"Leclerc", "Leclerc", "Leclerc"},
        companyType = "Vehicles"
    },
	[55] = 
    {
        name = "Leopard1A3 Platoon",
        units = {"Leopard1A3", "Leopard1A3", "Leopard1A3"},
        companyType = "Vehicles"
    },
	[56] = 
    {
        name = "Leopard-2 Platoon",
        units = {"Leopard-2", "Leopard-2", "Leopard-2"},
        companyType = "Vehicles"
    },
	[57] = 
    {
        name = "M-60 Platoon",
        units = {"M-60", "M-60", "M-60"},
        companyType = "Vehicles"
    },
	[58] = 
    {
        name = "M1128 Stryker MGS Platoon",
        units = {"M1128 Stryker MGS", "M1128 Stryker MGS", "M1128 Stryker MGS"},
        companyType = "Vehicles"
    },
	[59] = 
    {
        name = "Merkava Mk.4 Platoon",
        units = {"Merkava_Mk4", "Merkava_Mk4", "Merkava_Mk4"},
        companyType = "Vehicles"
    },
	[60] = 
    {
        name = "T-90 Platoon",
        units = {"T-90", "T-90", "T-90"},
        companyType = "Vehicles"
    },
	--New artillery Dec 2018
	[61] = 
    {
        name = "SAU 2S3 Akatsia Platoon",
        units = {"SAU Akatsia", "SAU Akatsia", "SAU Akatsia"},
        companyType = "Vehicles"
    },
	[62] = 
    {
        name = "SpGH Dana Platoon",
        units = {"SpGH_Dana", "SpGH_Dana", "SpGH_Dana"},
        companyType = "Vehicles"
    },
	[63] = 
    {
        name = "MLRS 9K57 Uragan BM-27 Platoon",
        units = {"Uragan_BM-27", "Uragan_BM-27", "Uragan_BM-27"},
        companyType = "Vehicles"
    },
	-- New APC\IFV Dec 2018
	[64] = 
    {
        name = "APC AAV-7 Platoon",
        units = {"AAV7", "AAV7", "AAV7"},
        companyType = "Vehicles"
    },
	[65] = 
    {
        name = "ATGM M1045 HMMWV TOW Platoon",
        units = {"M1045 HMMWV TOW", "M1045 HMMWV TOW", "M1045 HMMWV TOW"},
        companyType = "Vehicles"
    },
	[66] = 
    {
        name = "ATGM M1134 Stryker Platoon",
        units = {"M1134 Stryker ATGM", "M1134 Stryker ATGM", "M1134 Stryker ATGM"},
        companyType = "Vehicles"
    },
	[67] = 
    {
        name = "APC M113 Platoon",
        units = {"M-113", "M-113", "M-113"},
        companyType = "Vehicles"
    },
	[68] = 
    {
        name = "APC MTLB Platoon",
        units = {"MTLB", "MTLB", "MTLB"},
        companyType = "Vehicles"
    },
	[69] = 
    {
        name = "APC TPz Fuchs Platoon",
        units = {"TPZ", "TPZ", "TPZ"},
        companyType = "Vehicles"
    },
	[70] = 
    {
        name = "APC LAV-25 Platoon",
        units = {"LAV-25", "LAV-25", "LAV-25"},
        companyType = "Vehicles"
    },
	[71] = 
    {
        name = "ARV BTR-RD Platoon",
        units = {"BTR_D", "BTR_D", "BTR_D"},
        companyType = "Vehicles"
    },
	[72] = 
    {
        name = "APC Cobra Platoon",
        units = {"Cobra", "Cobra", "Cobra"},
        companyType = "Vehicles"
    },
	[73] = 
    {
        name = "IFV Marder Platoon",
        units = {"Marder", "Marder", "Marder"},
        companyType = "Vehicles"
    },
	[74] = 
    {
        name = "IFV MCV-80 Platoon",
        units = {"MCV-80", "MCV-80", "MCV-80"},
        companyType = "Vehicles"
    },
	-- New SAM\AAA Dec 2018
	[75] = 
    {
        name = "SAM Chaparral M48",
        units = {"M48 Chaparral"},
        companyType = "SAM"
    },
	[76] = 
    {
        name = "SAM Roland ADS",
        units = {"Roland ADS"},
        companyType = "SAM"
    },
	[77] = 
    {
        name = "SAM SA-15 Tor 9A331",
        units = {"Tor 9A331"},
        companyType = "SAM"
    },
	[78] = 
    {
        name = "Soldier stinger",
        units = {"Stinger MANPADS"},
        companyType = "SAM"
    },
	[79] = 
    {
        name = "AAA Gepard",
        units = {"Gepard"},
        companyType = "AAA"
    },
	--New transport Dec 2018
	[80] = 
    {
        name = "Transport GAZ-66 Platoon",
        units = {"GAZ-66", "GAZ-66", "GAZ-66", "GAZ-66"},
        companyType = "Vehicles"
    },
	[81] = 
    {
        name = "Transport KAMAZ-43101 Platoon",
        units = {"KAMAZ Truck", "KAMAZ Truck", "KAMAZ Truck", "KAMAZ Truck"},
        companyType = "Vehicles"
    },
	--new plane Dec 2018
	[82] = 
    {
        name = "A-50",
        units = {"A-50"},
        companyType = "AttackPlanes"
    },
	[83] = 
    {
        name = "F-14A Flight",
        units = {"F-14A", "F-14A"},
        companyType = "FighterPlanes"
    },
	[84] = 
    {
        name = "F-15C Flight",
        units = {"F-15C", "F-15C"},
        companyType = "FighterPlanes"
    },
	[85] = 
    {
        name = "F-15E Flight",
        units = {"F-15E", "F-15E"},
        companyType = "AttackPlanes"
    },
	[86] = 
    {
        name = "F-16A Flight",
        units = {"F-16A", "F-16A"},
        companyType = "FighterPlanes"
    },	
	[87] = 
    {
        name = "F-4E Flight",
        units = {"F-4E", "F-4E"},
        companyType = "FighterPlanes"
    },
	
	[88] = 
    {
        name = "MiG-23MLD Flight",
        units = {"MiG-23MLD", "MiG-23MLD"},
        companyType = "AttackPlanes"
    },
	[89] = 
    {
        name = "MiG-25PD Flight",
        units = {"MiG-25PD", "MiG-25PD"},
        companyType = "FighterPlanes"
    },
	[90] = 
    {
        name = "MiG-29S Flight",
        units = {"MiG-29S", "MiG-29S"},
        companyType = "FighterPlanes"
    },
	[91] = 
    {
        name = "MiG-31 Flight",
        units = {"MiG-31", "MiG-31"},
        companyType = "FighterPlanes"
    },
	[92] = 
    {
        name = "Mirage 2000-5 Flight",
        units = {"Mirage 2000-5", "Mirage 2000-5"},
        companyType = "FighterPlanes"
    },
	[93] = 
    {
        name = "Su-30 Flight",
        units = {"Su-30", "Su-30"},
        companyType = "FighterPlanes"
    },
	[94] = 
    {
        name = "Su-33 Flight",
        units = {"Su-33", "Su-33"},
        companyType = "FighterPlanes"
    },
	[95] = 
    {
        name = "Su-34 Flight",
        units = {"Su-34", "Su-34"},
        companyType = "AttackPlanes"
    },
	[96] = 
    {
        name = "Tornado GR4 Flight",
        units = {"Tornado GR4", "Tornado GR4"},
        companyType = "AttackPlanes"
    },
	[97] = 
    {
        name = "Tornado IDS Flight",
        units = {"Tornado IDS", "Tornado IDS"},
        companyType = "AttackPlanes"
    },
	[98] = 
    {
        name = "F-86F Sabre Flight",
        units = {"F-86F Sabre", "F-86F Sabre"},
        companyType = "AttackPlanes"
    },
	[99] = 
    {
        name = "FW-190D9 Flight",
        units = {"FW-190D9", "FW-190D9"},
        companyType = "AttackPlanes"
    },
	[100] = 
    {
        name = "L-39ZA Flight",
        units = {"L-39ZA", "L-39ZA"},
        companyType = "AttackPlanes"
    },
	[101] = 
    {
        name = "MiG-15bis Flight",
        units = {"MiG-15bis", "MiG-15bis"},
        companyType = "AttackPlanes"
    },
	[102] = 
    {
        name = "B-17G Flight",
        units = {"B-17G", "B-17G"},
        companyType = "AttackPlanes"
    },
	[103] = 
    {
        name = "A-10A Flight",
        units = {"A-10A", "A-10A"},
        companyType = "AttackPlanes"
    },
	[104] = 
    {
        name = "Bf-109K-4 Flight",
        units = {"Bf-109K-4", "Bf-109K-4"},
        companyType = "FighterPlanes"
    },
	[105] = 
    {
        name = "MiG-29G Flight",
        units = {"MiG-29G", "MiG-29G"},
        companyType = "FighterPlanes"
    },
	[106] = 
    {
        name = "SpitfireLFMkIX Flight",
        units = {"SpitfireLFMkIX", "SpitfireLFMkIX"},
        companyType = "FighterPlanes"
    },
	
	--new Heli Dec 2018
	[107] = 
    {
        name = "OH-58D Flight",
        units = {"OH-58D", "OH-58D"},
        companyType = "Helicopters"
    },
	[108] = 
    {
        name = "UH-1H Flight",
        units = {"UH-1H", "UH-1H"},
        companyType = "Helicopters"
    },
	[109] = 
    {
        name = "MiG-29 Flight",
        units = {"MiG-29A", "MiG-29A"},
        companyType = "FighterPlanes"
    },

	--WW2 Vehicles added by Ben Whiteley 2021 (AP) = WW2 Asset pack
	[110] =
	{
		name = "Centaur IV Platoon (AP)",
		units = {"Centaur_IV", "Centaur_IV", "Centaur_IV"},
		companyType = "Vehicles"
	},
	[111] = 
	{
		name = "Churchill VII Platoon (AP)",
		units = {"Churchill_VII", "Churchill_VII", "Churchill_VII"},
		companyType = "Vehicles"
	},
	[112] = 
	{
		name = "Cromwell IV Platoon (AP)",
		units = {"Cromwell_IV", "Cromwell_IV", "Cromwell_IV"},
		companyType = "Vehicles"
	},
	[113] = 
	{
		name = "Jagdpanther G1 Platoon (AP)",
		units = {"Jagdpanther_G1", "Jagdpanther_G1", "Jagdpanther_G1"},
		companyType = "Vehicles"
	},
	[114] = 
	{
		name = "Jagdpanzer IV Platoon (AP)",
		units = {"Jagdpanzer_IV", "Jagdpanzer_IV", "Jagdpanzer_IV"},
		companyType = "Vehicles"
	},
	[115] = 
	{
		name = "M4A4 Sherman FF Platoon (AP)",
		units = {"M4A4_Sherman_FF", "M4A4_Sherman_FF", "M4A4_Sherman_FF"},
		companyType = "Vehicles"
	},
	[115] = 
	{
		name = "M10 GMC Platoon (AP)",
		units = {"M10_GMC", "M10_GMC", "M10_GMC"},
		companyType = "Vehicles"
	},
	[116] = 
	{
		name = "Pz V Panther Platoon (AP)",
		units = {"Pz_V_Panther", "Pz_V_Panther", "Pz_V_Panther"},
		companyType = "Vehicles"
	},
	[117] =
	{
		name = "SdKfz Elefant Platoon (AP)",
		units = {"SdKfz184_Elefant", "SdKfz184_Elefant", "SdKfz184_Elefant"},
		companyType = "Vehicles"
	},
	[118] = 
	{
		name = "StuG III Platoon (AP)",
		units = {"StuG_III_G", "StuG_III_G", "StuG_III_G"},
		companyType = "Vehicles"
	},
	[119] =
	{
		name = "StuG IV Platoon (AP)",
		units = {"StuG_IV", "StuG_IV", "StuG_IV"},
		companyType = "Vehicles"
	},
	[120] = 
	{
		name = "Tiger I Platoon (AP)",
		units = {"Tiger_I", "Tiger_I", "Tiger_I"},
		companyType = "Vehicles"
	},
	[121] = 
	{
		name = "Tiger II Platoon (AP)",
		units = {"Tiger_II_H", "Tiger_II_H", "Tiger_II_H"},
		companyType = "Vehicles"
	},
	[122] = 
	{
		name = "Daimler AC Platoon (AP)",
		units = {"Daimler_AC", "Daimler_AC", "Daimler_AC"},
		companyType = "Vehicles"
	},
	[123] = 
	{
		name = "M8 Greyhound Platoon (AP) ",
		units = {"M8_Greyhound", "M8_Greyhound", "M8_Greyhound"},
		companyType = "Vehicles"
	},
	[124] = 
	{
		name = "M30 Platoon (AP)",
		units = {"M30_CC", "M30_CC", "M30_CC"},
		companyType = "Vehicles"
	},
	[125] = 
	{
		name = "SdKfz234 Puma Platoon (AP)",
		unit = {"SdKfz234_2_Puma", "SdKfz234_2_Puma", "SdKfz234_2_Puma"},
		companyType = "Vehicles"
	},
	[126] = 
	{
		name = "Tetrarch Platoon (AP)",
		units = {"Tetrarch", "Tetrarch", "Tetrarch"},
		companyType = "Vehicles"
	},
	[127] = 
	{
		name = "Brummbar Platoon (AP)",
		units = {"Brummbar", "Brummbar", "Brummbar"},
		companyType = "Vehicles"
	},
	[128] = 
	{
		name = " M12 GMC Platoon (AP)",
		units = {"M12_GMC", "M12_GMC", "M12_GMC"},
		companyType = "Vehicles"
	},
	[129] = 
	{
		name = "M4 Tractor Platoon (AP)",
		units = {"M4_Tractor", "M4_Tractor", "M4_Tractor"},
		companyType = "Vehicles"
	},
	[130] = 
	{
		name = "WWII Mauser Infantry Platoon (8)",
		units = {"soilder_mauser98", "soilder_mauser98", "soilder_mauser98", "soilder_mauser98", "soilder_mauser98", "soilder_mauser98", "soilder_mauser98", "soilder_mauser98"},
		companyType = "Vehicles"
	},
	[131] = 
	{
		name = "WWII British Infantry Platoon (8)",
		units = {"soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01", "soilder_wwii_br_01"},
		companyType = "Vehicles"
	},
	[132] = 
	{
		name = "WWII US Infantry Platoon (8)",
		units = {"soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01", "soilder_wwii_us_01"},
		companyType = "Vehicles"
	},
	[133] = 
	{
		name = "Sherman Platoon",
		units = {"Sherman", "Sherman", "Sherman"},
		companyType = "Vehicles"
	},
	[134] = 
	{
		name = "Horch 901 Platoon (AP)",
		units = {"Horch_901_typ_40", "Horch_901_typ_40", "Horch_901_typ_40"},
		companyType = "Vehicles"
	},
	[135] = 
	{
		name = "Kubelwagen Platoon (AP)",
		units = {"Kubelwagen_82", "Kubelwagen_82", "Kubelwagen_82"},
		companyType = "Vehicles"
	},
	[136] = 
	{
		name = "Pz III Platoon (AP)",
		units = {"Pz_III", "Pz_III", "Pz_III"},
		companyType = "Vehicles"
	},
	[137] = 
	{
		name = "Pz V Platoon (AP)",
		units = {"Pz_V_G", "Pz_V_G", "Pz_V_G"},
		companyType = "Vehicles"
	},
	[138] = 
	{
		name = "SdKfz 2 Platoon (AP)",
		units = {"SdKfz_2", "SdKfz_2", "SdKfz_2"},
		companyType = "Vehicles"
	},
	[139] = 
	{
		name = "SdKfz 7 Platoon (AP)",
		units = {"SdKfz_7", "SdKfz_7", "SdKfz_7"},
		companyType = "Vehicles"
	},
	[140] = 
	{
		name = "Willys Jeep Platoon (AP)",
		units = {"Willys_MB", "Willys_MB", "Willys_MB"},
		companyType = "Vehicles"
	},
	[141] = 
	{
		name = "Flak 30 Platoon (AP)",
		units = {"Flak30", "Flak30", "Flak30", "Flak30"},
		companyType = "AAA"
	},
	[142] =
	{
		name = "Flak 36 Platoon (AP)",
		units = {"Flak36", "Flak36", "Flak36", "Flak36"},
		companyType = "AAA"
	},
	[143] = 
	{
		name = "Flak 37 Platoon (AP)",
		units = {"Flak37", "Flak37", "Flak37", "Flak37"},
		companyType = "AAA"
	},
	[144] = 
	{
		name = "Flak 41 Platoon (AP)",
		units = {"Flak41", "Flak41", "Flak41", "Flak41"},
		companyType = "AAA"
	},
	[144] = 
	{
		name = "Bedford Truck Platoon",
		units = {"Bedford", "Bedford", "Bedford"},
		companyType = "Vehicles"
	},
	[145] =
	{
		name = "Blitz Truck Platoon",
		units = {"Blitz_36-6700A", "Blitz_36-6700A", "Blitz_36-6700A"},
		companyType = "Vehicles"
	},
	[146] =
	{
		name = "M2A1 Halftrack Platoon",
		units = {"M2A1_halftrack", "M2A1_halftrack", "M2A1_halftrack"},
		companyType = "Vehicles"
	},
	[147] = 
	{
		name = "Pz IV Platoon",
		units = {"Pz_IV_H", "Pz_IV_H", "Pz_IV_H"},
		companyType = "Vehicles"
	},
	[148] = 
	{
		name = "SdKfz 251 Platoon",
		units = {"SdKfz_251", "SdKfz_251", "SdKfz_251"},
		companyType = "Vehicles"
	},
	[149] = 
	{
		name = "Bofors 40 Platoon",
		units = {"Bofors40", "Bofors40", "Bofors40", "Bofors40"},
		companyType = "AAA"
	},
	[150] = 
	{
		name = "Flak 18 Platoon",
		units = {"Flak18", "Flak18", "Flak18", "Flak18"},
		companyType = "AAA"
	},
	[151] = 
	{
		name = "A-20G Flight",
		units = {"A-20G", "A-20G"},
		companyType = "AttackPlanes"
	},
	[152] = 
	{
		name = "P-47D-30 Flight",
		units = {"P-47D-30", "P-47D-30"},
		companyType = "FighterPlanes"
	},
	[153] = 
	{
		name = "P-51D Flight",
		units = {"P-51D", "P-51D"},
		companyType = "FighterPlanes"
	},
	[154] = 
	{
		name = "FW-190-A8 Flight",
		units = {"FW-190-A8", "FW-190-A8"},
		companyType = "FighterPlanes"
	},

--[_1_0_9] = MISSING SKIN!!!!!
   -- {
       -- name = "F-16A MLU Flight",
        --units = {"F-16A MLU", "F-16A MLU"},
        --companyType = "AttackPlanes"
    --},	
}

startPositionsLocalize = 
{
	["Column"] 		= _("Column"),
	["Chaos 1"] 	= _("Chaos 1"),
	["Chaos 2"] 	= _("Chaos 2"),
	["Wedge"] 		= _("Wedge"),
	["Vee"] 		= _("Vee"),
	["Row"] 		= _("Row"),
	["Two Rows"] 	= _("Two Rows"),
}

startPositions =
{
    ["Column"] = 
    {
        [1] = {0, 0, 0},
        [2] = {-20, 0, 0},
        [3] = {-30, 0, 0},
        [4] = {-40, 0, 0},
        [5] = {-50, 0, 0},
        [6] = {-60, 0, 0},
    },
    ["Chaos 1"] = 
    {
        [1] = {0, 0, 0},
        [2] = {-30, -20, 0},
        [3] = {-25, 10, 0},
        [4] = {18, -32, 0},
        [5] = {30, 26, 0},
        [6] = {26, -45, 0},
    },
    ["Chaos 2"] = 
    {    
        [1] = {0, 0, 0},
        [2] = {32, 11, 0},
        [3] = {10, 27, 0},
        [4] = {16, -30, 0},
        [5] = {-25, 32, 0},
        [6] = {75, 14, 0},
    },
    ["Wedge"] = 
    {
        [1] = {0, 20, 0},
        [2] = {0, -20, 0},
        [3] = {-60, 40, 0},
        [4] = {-60, -40, 0},
        [5] = {-120, 80, 0},
        [6] = {-120, -80, 0},
    },
    ["Vee"] = 
    {
        [1] = {0, 20, 0},
        [2] = {0, -20, 0},
        [3] = {60, 40, 0},
        [4] = {60, -40, 0},
        [5] = {120, 80, 0},
        [6] = {120, -80, 0},
    },
    ["Row"] = 
    {
        [1] = {0, 0, 0},
        [2] = {0, -50, 0},
        [3] = {0, 50, 0},
        [4] = {0, -100, 0},
        [5] = {0, 100, 0},
        [6] = {0, -150, 0},
    },
    ["Two Rows"] = 
    {
        [1] = {0, 0, 0},
        [2] = {0, -50, 0},
        [3] = {0, 50, 0},
        [4] = {-30, 0, 0},
        [5] = {-30, -50, 0},
        [6] = {-30, 50, 0},
    },
}

pylons = --All pylons with comments by dr.lex 20.12.2018
--Russian helicopters
{
    ["Ka-50"] = 
    {
        [1] = "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}", --APU-6 - 6 9A4172 Vikhr
        [2] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
        [3] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
        [4] = "{A6FD14D3-6D30-4C85-88A7-8D17BEE120E2}", --APU-6 - 6 9A4172 Vikhr
    },
    ["Mi-8MT"] = 
    {
        [1] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
		[2] = "{05544F1A-C39C-466b-BC37-5BD1D52E57BB}", --UPK-23-250 pyl 2/5
        [3] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
        [4] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
        [5] = "{05544F1A-C39C-466b-BC37-5BD1D52E57BB}", --UPK-23-250 pyl 2/5
		[6] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
		[7] = "KORD_12_7",                              --MG KORD 12.7 only pyl 7 
		[8] = "PKT_7_62",                               --MG PKT 7.62 only pyl 8
    },
	["Mi-24V"] = 
    {
        [1] = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}", --9M114 Shturm-V - 2
        [2] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2 2/5_3/4
        [3] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2 2/5_3/4
        [4] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2 2/5_3/4
        [5] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2 2/5_3/4
        [6] = "{B919B0F4-7C25-455E-9A02-CEA51DB895E3}", --9M114 Shturm-V - 2
    },
	["Mi-28N"] = 
	{
		[1] = "{57232979-8B0F-4db7-8D9A-55197E06B0F5}", --9M114 Shturm-V õ 8 pyl 1/4
		[2] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
		[3] = "B_8V20A_OFP2",                           --B-8V20A - 20 S-8OFP2
		[4] = "{57232979-8B0F-4db7-8D9A-55197E06B0F5}", --9M114 Shturm-V õ 8 pyl 1/4
	},
	
--NATO helicopters

    ["AH-1W"] = 
    {
        [1] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K*4 Hellfire pyl 1/4
        [2] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151HE
        [3] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151HE
        [4] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K*4 Hellfire pyl 1/4
    },
    ["AH-64A"] = 
    {
        [1] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K Hellfire * 4
        [2] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151 HE
        [3] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151 HE
        [4] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K Hellfire * 4
    },
    ["AH-64D"] = 
    {
        [1] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K Hellfire * 4
        [2] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151 HE
        [3] = "{FD90A1DC-9147-49FA-BF56-CB83EF0BD32B}", --LAU-61 - 19 2.75' rockets MK151 HE
        [4] = "{88D18A5E-99C8-4B04-B40B-1C02F2018B6E}", --AGM-114K Hellfire * 4
    },    
	["OH-58D"] = 
    {
        --[1] = "oh-58-brauning",
		[1] = "M260_HYDRA",                             --M260 - 7 2.75' rockets MK156
        [2] = "AGM114x2_OH_58",
    },
	["UH-1H"] = 
    {
        [1] = "M134_L",                                 --M134 Minigun LEFT
        [2] = "M261_MK151",                             --LAU-61 - 19 2.75' rockets MK151 HE
		--[3] = "M134_SIDE_L",                            --M134 Minigun DOOR LEFT
		--[3] = "M60_SIDE_L",                             --MG M60 DOOR LEFT
		--[4] = "M134_SIDE_R",                            --M134 Minigun DOOR RIGHT
		--[4] = "M60_SIDE_R",                             --MG M60 DOOR RIGHT
        [5] = "M261_MK151",                             --LAU-61 - 19 2.75' rockets MK151 HE
        [6] = "M134_R",                                 --M134 Minigun RIGHT
    },    
	
--NATO Planes

	["A-10A"] = 
    {
        [1] = "ALQ_184",                                --ALQ-184
        [2] = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", --LAU-68 - 7 2.75' rockets M151 (HE)
        [3] = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}", -- LAU-88 AGM-65D*2 LEFT
        [4] = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}", -- 3*MK82
        [5] = "{CBU-87}",                               --CBU-87
        [7] = "{CBU-87}",                               --CBU-87
        [8] = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}", -- 3*MK82
        [9] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}", -- LAU-88 AGM-65D*2 RIGHT
        [10] = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}",--LAU-68 - 7 2.75' rockets M151 (HE)
        [11] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}",-- AIM-9M*2
    },
	["A-10C"] = 
    {
        [1] = "ALQ_184",                                --ALQ-184
        [2] = "{A021F29D-18AB-4d3e-985C-FC9C60E35E9E}", --LAU-68 - 7 2.75' rockets M151 (HE)
        [3] = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}", -- LAU-88 AGM-65D*2 LEFT
        [4] = "{CBU-87}",                               -- CBU-87
        [5] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
        [7] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
        [8] = "{CBU-87}",                               -- CBU-87
        [9] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}", -- LAU-88 AGM-65D*2 RIGHT
        [10] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", -- AN/AAQ-28(V) LITENING
        [11] = "{DB434044-F5D0-4F1F-9BA9-B73027E18DD3}", -- AIM-9M*2
    },
	["F/A-18C"] = 
    {
        [1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --AIM-9M
        [2] = "LAU_117_AGM_65G",                        --LAU_117_AGM_65G
        [3] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
        [4] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --AIM-120C
        [5] = "{EFEC8201-B922-11d7-9897-000476191836}", --HORNET_FUEL_TANK
        [6] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --AIM-120C
        [7] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
        [8] = "LAU_117_AGM_65G",                        --LAU_117_AGM_65G
        [9] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --AIM-9M
    },
	["F-16C bl.52d"] = 
    {
        [1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim 9M
		[2] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --Aim-120C
        [3] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
        [4] = "{444BA8AE-82A7-4345-842E-76154EFCCA46}", --AGM-65D
        [5] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", -- AN/AAQ-28(V) LITENING
        [6] = "ALQ_184",                                -- ALQ 184
        [7] = "{444BA8AE-82A7-4345-842E-76154EFCCA46}", --AGM-65D
        [8] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
		[9] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --Aim-120C
        [10] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",--Aim 9M
    },
	["F-16A"] = 
    {
        [1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim 9M
		[2] = "{C8E06185-7CD6-4C90-959F-044679E90751}", --Aim-120B
        [3] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
        [4] = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}", --PTB 370Gal
        [6] = "ALQ_184",                                --ECM ALQ 184
        [7] = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}", --PTB 370Gal
        [8] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[9] = "{C8E06185-7CD6-4C90-959F-044679E90751}", --Aim-120B
        [10] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",--Aim 9M
    },
	--["F-16A MLU"] = MISSING SKINS!!!!!!
    --{
        --[1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim 9M
		--[2] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --Aim-120C
        --[3] = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}", --LAU-88 AGM-65D*2 LEFT
        --[4] = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}", --PTB 370Gal
        --[5] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", -- AN/AAQ-28 LITENING
        --[6] = "{6D21ECEA-F85B-4E8D-9D51-31DC9B8AA4EF}", -- ALQ 131
        --[7] = "{F376DBEE-4CAE-41BA-ADD9-B2910AC95DEC}", --PTB 370Gal
        --[8] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}", --LAU-88 AGM-65D*2 RIGHT
		--[9] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --Aim-120C
        --[10] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",--Aim 9M
    --},	
	["P-51D"] = 
	{
		[1] = "{HVAR}", --Rocket
		[2] = "{HVAR}",
		[3] = "{HVAR}",
		[4] = "{HVAR}",
		[5] = "{HVAR}",
		[6] = "{HVAR}",
		[7] = "{HVAR}",
		[8] = "{HVAR}",
		[9] = "{HVAR}",
		[10] = "{HVAR}",
	},
	["Mirage 2000-5"] = 
	{
		[1] = "{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}", --R550 Magic2
		[2] = "{0DA03783-61E4-40B2-8FAE-6AEE0A5C5AAE}", --MICA IR
		[3] = "{6D778860-7BB8-4ACB-9E95-BA772C6BBC2C}", --MICA RF
		[4] = "{6D778860-7BB8-4ACB-9E95-BA772C6BBC2C}", --MICA RF
		[5] = "{414DA830-B61A-4F9E-B71B-C2F6832E1D7A}", --PTB M2000
		[6] = "{6D778860-7BB8-4ACB-9E95-BA772C6BBC2C}", --MICA RF
		[7] = "{6D778860-7BB8-4ACB-9E95-BA772C6BBC2C}", --MICA RF
		[8] = "{0DA03783-61E4-40B2-8FAE-6AEE0A5C5AAE}", --MICA IR
		[9] = "{FC23864E-3B80-48E3-9C03-4DA8B1D7497B}", --R550 Magic2
	},
	["F-15C"] = 
	{
		[1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M
		[2] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}", --PTB 610gal
		[3] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --AIM-120C
		[4] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[5] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[6] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}", --PTB 610gal
		[7] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[8] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[9] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --AIM-120C
		[10] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}",--PTB 610gal
		[11] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",--Aim9M
	},
	["F-14A"] = 
	{
		[1] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M
		[2] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[6] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[7] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7M
		[11] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}",--AIM-7M
		[12] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}",--Aim9M
	},
	["F-5E-3"] = 
	{
		[1] = "{AIM-9P5}",
		[2] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
		[3] = "LAU3_HE5",                               --MK5 rocket
		[4] = "{0395076D-2F77-4420-9D33-087A4398130B}", --PTB 275gal
		[5] = "LAU3_HE5",                               --MK5 rocket
		[6] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
		[7] = "{AIM-9P5}",
	},
	["F-4E"] = 
	{
		[1] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",  --GBU-12
		[2] = "{E6A6262A-CA08-4B3D-B030-E1A993B98452}", --LAU-88 AGM-65D*2 LEFT
		[3] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7m
		[4] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7m
		[5] = "{8B9E3FD0-F034-4A07-B6CE-C269884CC71B}", --PTB F4
		[6] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7m
		[7] = "{8D399DDA-FF81-4F14-904D-099B34FE7918}", --AIM-7m
		[8] = "{E6A6262A-CA08-4B3D-B030-E1A993B98453}", --LAU-88 AGM-65D*2 RIGHT
		[9] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}",  --GBU-12
	},
	["F-15E"] = 
	{
		[1] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", -- Aim120C
		[2] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", -- GBU-12
		[3] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M
		[4] = "{GBU-38}",
		[5] = "{GBU-38}",
		[6] = "{GBU-38}",
		[7] = "{GBU-38}",
		[8] = "{GBU-38}",
		[9] = "{GBU-38}",
		[10] = "{E1F29B21-F291-4589-9FD8-3272EEC69506}", -- ptb 610gal,
		[11] = "{GBU-38}",
		[12] = "{GBU-38}",
		[13] = "{GBU-38}",
		[14] = "{GBU-38}",
		[15] = "{GBU-38}",
		[16] = "{GBU-38}",
		[17] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M
		[18] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", -- GBU-12
		[19] = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}", --Aim120C
	},
	["Tornado GR4"] = 
	{
		[1] = "{8C3F26A2-FA0F-11d5-9190-00A0249B6F00}", --ECM Sky-Shadow
		[2] = "{EF124821-F9BB-4314-A153-E0E2FE1162C4}", --PTB Tornado
		[3] = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}", --ALARM
		[5] = "{A111396E-D3E8-4b9c-8AC9-2432489304D5}", --AN/AAQ-28 LITENING
		--[6] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
		--[7] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12
		[8] = "{DB769D48-67D7-42ED-A2BE-108D566C8B1E}", --GBU-12		 
		[10] = "{E6747967-B1F0-4C77-977B-AB2E6EB0C102}", --ALARM  
		[11] = "{EF124821-F9BB-4314-A153-E0E2FE1162C4}",--PTB Tornado
		[12] = "{8C3F26A2-FA0F-11d5-9190-00A0249B6F00}",--ECM Sky-Shadow 
	},
	["Tornado IDS"] = 
	{
		[1] = "{8C3F26A2-FA0F-11d5-9190-00A0249B6F00}", --ECM Sky-Shadow
		[2] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
		[3] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M
		[4] = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}", --GBU-16
		[9] = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}", --GBU-16		 
		[10] = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", --Aim9M 
		[11] = "{B06DD79A-F21E-4EB9-BD9D-AB3844618C93}", --AGM-88C
		[12] = "{8C3F26A2-FA0F-11d5-9190-00A0249B6F00}",--ECM Sky-Shadow 
	},
	["F-86F Sabre"] = 
	{
		[1] = "{HVARx2}", --Rocket
		[2] = "{HVARx2}",
		[3] = "{HVARx2}",
		[4] = "{HVARx2}",
		[5] = "{HVARx2}",
		[6] = "{HVARx2}",
		[7] = "{HVARx2}",
		[8] = "{HVARx2}",
		[9] = "{HVARx2}",
		[10] = "{HVARx2}",
	},	
	["FW-190D9"] = 
	{
		[1] = "ER_4_SC50",                             --4*bomb50
		[2] = "{FW_190_R4M_LEFT_WING}",                --13*R4M Rocket
		[3] = "{FW_190_R4M_RGHT_WING}",                --13*R4M Rocket
	},	
	["L-39ZA"] = 
	{
		[1] = "{APU-60-1_R_60M}",                      --R-60M
		[2] = "{UB-16-57UMP}",                         --UB-16-57 Rocket
		[4] = "{UB-16-57UMP}",                         --UB-16-57 Rocket
		[5] = "{APU-60-1_R_60M}",                      --R-60M
	},	
	["B-17G"] = 
	{
		[1] = "{12xM64}",                              --12*m64 242kg bomb
	},
	["MiG-29G"] = 
	{
		[1] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[2] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[3] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[4] = "{2BEC576B-CDF5-4B7F-961F-B0FA4312B841}", --PTB 1400L
		[5] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[6] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[7] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
	},
	
--Russian planes

	["MiG-15bis"] = 
	{
		[1] = "FAB_100M",                              --FAB 100
		[2] = "FAB_100M",                              --FAB 100
	},	
    ["Su-25T"] =
    {
        [1] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [2] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", --B-8M1 - 20 S-8KOM
        [3] = "B-8M1 - 20 S-8OFP2",                     -- B-8M1 - 20 S-8OFP2
        [4] = "{F789E86A-EE2E-4E6B-B81E-D5E5F903B6ED}", -- APU-8 - 8 9A4172 Vikhr
        [5] = "{96A7F676-F956-404A-AD04-F33FB2C74881}", -- KMGU-2 - 96 PTAB-2.5KO
        [6] = "{B1EF6B0E-3D91-4047-A7A5-A99E7D8B4A8B}", -- Mercury LLTV Pod
        [7] = "{96A7F676-F956-404A-AD04-F33FB2C74881}", -- KMGU-2 - 96 PTAB-2.5KO
        [8] = "{F789E86A-EE2E-4E6B-B81E-D5E5F903B6ED}", -- APU-8 - 8 9A4172 Vikhr
        [9] = "B-8M1 - 20 S-8OFP2",                     -- B-8M1 - 20 S-8OFP2
        [10] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}",--B-8M1 - 20 S-8KOM
        [11] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}",--R-60M
    },    
    ["Su-25"] = 
    {    
        [1] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [2] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", --B-8M1 - 20S-8KOM
        [3] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", --B-8M1 - 20S-8KOM
        [4] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
        [5] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
        [6] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
        [7] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
        [8] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", --B-8M1 - 20S-8KOM
        [9] = "{F72F47E5-C83A-4B85-96ED-D3E46671EE9A}", --B-8M1 - 20S-8KOM
        [10] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
    },
	["MiG-23MLD"] = 
    {
        [2] = "{6980735A-44CC-4BB9-A1B5-591532F1DC69}", --R-24T
        [3] = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}", --R-60M*2 LEFT
		[4] = "{A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}", --PTB 800
        [5] = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}", --R-60M*2 RIGHT
		[6] = "{CCF898C9-5BC7-49A4-9D1E-C3ED3D5166A1}", --R-24R        
    },
    ["MiG-27K"] = 
    {
        [2] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
        [3] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
		[4] = "{RBK_250_275_AO_1SCH}",                  --RBK-250-275-AO
        [5] = "{A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}", --PTB 800L
		[6] = "{RBK_250_275_AO_1SCH}",                  --RBK-250-275-AO
        [7] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [8] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
    },
    ["Su-17M4"] = 
    {
        [1] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh25ML
        [2] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [3] = "{292960BB-6518-41AC-BADA-210D65D5073C}", --Kh25MR
        [4] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
        [5] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
        [6] = "{292960BB-6518-41AC-BADA-210D65D5073C}", --Kh25MR
        [7] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [8] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh25ML
    },    
	["Su-24M"] = 
	{
		[1] = "{B0DBC591-0F52-4F7D-AD7B-51E67725FB81}", --R-60M*2 LEFT
		[2] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh25ML
		[3] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
		[4] = "{F99BEC1A-869D-4AC7-9730-FBA0E3B1F5FC}", --MER*6 FAB100
		[5] = "{RBK_250_275_AO_1SCH}",                  --RBK-250-275-AO
		[6] = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", --RBK-500-255-PTAB10-5
		[7] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh25ML
		[8] = "{275A2855-4A79-4B2D-B082-91EA2ADF4691}", --R-60M*2 RIGHT
	},	
	["Su-34"] = 
	{
		[1] = "{ECM_POD_L_175V}",                       --ECM L175V Khibiny 
		[2] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", --R-77
		[3] = "{E86C5AA5-6D49-4F00-AD2E-79A62D6DDE26}", --Kh-25MPU
		[4] = "{40AB87E8-BEFB-4D85-90D9-B2753ACF9514}", --Kh-59M 
		[5] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh-25ML
		[6] = "{BA565F89-2373-4A84-9502-A0E017D3A44A}", --KAB-500L
		[7] = "{BA565F89-2373-4A84-9502-A0E017D3A44A}", --KAB-500L
		[8] = "{6DADF342-D4BA-4D8A-B081-BA928C4AF86D}", --Kh-25ML
		[9] = "{40AB87E8-BEFB-4D85-90D9-B2753ACF9514}", --Kh-59M             
		[10] = "{E86C5AA5-6D49-4F00-AD2E-79A62D6DDE26}",--Kh-25MPU
		[11] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}",--R-77
		[12] = "{ECM_POD_L_175V}",                      --ECM L175V Khibiny 
	},	
	["MiG-29A"] = 
	{
		[1] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[2] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[3] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[4] = "{2BEC576B-CDF5-4B7F-961F-B0FA4312B841}", --PTB 1400L
		[5] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[6] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[7] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
	},
	["MiG-29S"] = 
	{
		[1] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[2] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", --R-77
		[3] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[4] = "{2BEC576B-CDF5-4B7F-961F-B0FA4312B841}", --PTB 1400L
		[5] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[6] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", --R-77
		[7] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
	},
	["Su-27"] = 
	{
		[1] = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}", --ECM L005 Sorbtsia LEFT
		[2] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[3] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[4] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[5] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[6] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[7] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER  
		[8] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[9] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[10] = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}",--ECM L005 Sorbtsia RIGHT
	},
	["Su-30"] = 
	{
		[1] = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}", --ECM L005 Sorbtsia LEFT
		[2] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[3] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", --R-77
		[4] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[5] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[6] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER
		[7] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET 
		[8] = "{B4C01D60-A8A3-4237-BD72-CA7655BC0FE9}", --R-77
		[9] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[10] = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}",--ECM L005 Sorbtsia RIGHT
	},
	["Su-33"] = 
	{
		[1] = "{44EE8698-89F9-48EE-AF36-5FD31896A82F}", --ECM L005 Sorbtsia LEFT
		[2] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}", --R-73
		[3] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}", --R-27ET
		[4] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER 
		[5] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER 
		[6] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER 
		[7] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER 
		[8] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER 
		[9] = "{E8069896-8435-4B90-95C0-01A03AE6E400}", --R-27ER            
		[10] = "{B79C379A-9E87-4E50-A1EE-7F7E29C2E87A}",--R-27ET
		[11] = "{FBC29BFE-3D24-4C64-B81D-941239D12249}",--R-73
		[12] = "{44EE8698-89F9-48EE-AF36-5FD31896A82A}",--ECM L005 Sorbtsia RIGHT
	},	
	["MiG-25PD"] = 
	{
		--[1] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60
		[1] = "{5F26DBC2-FB43-4153-92DE-6BBCE26CB0FF}", --R-40T
		[2] = "{4EDBA993-2E34-444C-95FB-549300BF7CAF}", --R-40R
		[3] = "{4EDBA993-2E34-444C-95FB-549300BF7CAF}", --R-40R
		[4] = "{5F26DBC2-FB43-4153-92DE-6BBCE26CB0FF}", --R-40T
		--[4] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60
	},	
	["MiG-31"] = 
	{
		[1] = "{5F26DBC2-FB43-4153-92DE-6BBCE26CB0FF}", --R-40T
		[2] = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}", --R-33
		[3] = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}", --R-33
		[4] = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}", --R-33
		[5] = "{F1243568-8EF0-49D4-9CB5-4DA90D92BC1D}", --R-33
		[6] = "{5F26DBC2-FB43-4153-92DE-6BBCE26CB0FF}", --R-40T
	}, 	
	["MiG-29"] = 
    {
        [2] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
        [3] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
		[4] = "{RBK_250_275_AO_1SCH}",                  --RBK-250-275-AO
        [5] = "{A5BAEAB7-6FAF-4236-AF72-0FD900F493F9}", --PTB 800L
		[6] = "{RBK_250_275_AO_1SCH}",                  --RBK-250-275-AO
        [7] = "{682A481F-0CB5-4693-A382-D00DD4A156D7}", --R-60M
        [8] = "{79D73885-0801-45a9-917F-C90FE1CE3DFC}", --Kh-25ML
    },
}

amountLevels = 
{
    {name = _("Min"), id = "Min"}, 
    {name = _("Med"), id = "Med"},
    {name = _("Max"), id = "Max"}, 
}
groundBehaviours = 
{
	{name = _("gStay"),id = "gStay"},
	{name = _("gAttack"),id = "gAttack"},
	{name = _("gArtAttack"),id = "gArtAttack"},
	{name = _("gMovingByRoad"),id = "gMovingByRoad"},
	{name = _("gJTAC"),id = "gJTAC"},
	{name = _("gAttackMapObject"),id = "gAttackMapObject"},
}
airBehaviours = 
{
	{name = _("aAttackGround"),id = "aAttackGround"},
	{name = _("aAttackAir"),id = "aAttackAir"},
	{name = _("aAWACS"),id = "aAWACS"},
	{name = _("aAttackGroundMap"),id = "aAttackGroundMap"},
	{name = _("aFreeFly"),id = "aFreeFly"},
}

companyTypes = 
{
	{name = _("ATTACK PLANES"), id = "AttackPlanes"}, 
	{name = _("FIGHTER PLANES"), id = "FighterPlanes"}, 
	{name = _("HELICOPTERS"), id = "Helicopters"}, 
	{name = _("AAA"), id = "AAA"}, 
	{name = _("SAM"), id = "SAM"}, 
	{name = _("VEHICLES"), id = "Vehicles"}, 
}

difficultyLevels = 
{
    {name = _("Average"), id = "Average"}, 
    {name = _("Good"), id = "Good"},
    {name = _("High"), id = "High"}, 
	{name = _("Excellent"), id = "Excellent"}, 
	{name = _("Random"), id = "Random"}, 
}

typeAttack =
{
	{name = _("head-on"), id = "head-on"},
	{name = _("chase"),   id = "chase"},
	{name = _("flank"),   id = "flank"},
}

wingmenDifficulty = 
{
    {name = _("Average"), id = "Average"}, 
    {name = _("Good"), id = "Good"},
    {name = _("High"), id = "High"}, 
	{name = _("Excellent"), id = "Excellent"}, 
	{name = _("Random"), id = "Random"}, 
}

scoreMessages = 
{
	[1] = {score = 10,  messages = {localizationMG.getLocKey("Nice_job"), localizationMG.getLocKey("Scratch"), localizationMG.getLocKey("Target_is_down"), localizationMG.getLocKey("Thats_a_hit")}},
	[2] = {score = 20,  messages = {localizationMG.getLocKey("You_got_it"), localizationMG.getLocKey("Target_hit"), localizationMG.getLocKey("Hogs_on_the_prowl")}},
	[3] = {score = 30,  messages = {localizationMG.getLocKey("Good_work"), localizationMG.getLocKey("Enemy_down"), localizationMG.getLocKey("Bad_day")}},
	[4] = {score = 40,  messages = {localizationMG.getLocKey("Well_done"), localizationMG.getLocKey("Direct_hit"), localizationMG.getLocKey("Let_have")}},
	[5] = {score = 50,  messages = {localizationMG.getLocKey("Way_to_fly"), localizationMG.getLocKey("Target_hit"), localizationMG.getLocKey("Welcome_to")}},
	[6] = {score = 60,  messages = {localizationMG.getLocKey("Nice_flying"), localizationMG.getLocKey("Target_desroyed"), localizationMG.getLocKey("Bad_guys")}},
	[7] = {score = 70,  messages = {localizationMG.getLocKey("Somebody"), localizationMG.getLocKey("Thats_kill"), localizationMG.getLocKey("Good_hunting")}},
	[8] = {score = 80,  messages = {localizationMG.getLocKey("Way_to_go"), localizationMG.getLocKey("Effect_on"), localizationMG.getLocKey("Hog_heaven")}},
	[9] = {score = 90,  messages = {localizationMG.getLocKey("Good_shooting"), localizationMG.getLocKey("Impact"), localizationMG.getLocKey("Positive")}},
	[10] = {score = 100,  messages = {localizationMG.getLocKey("Sierra"), localizationMG.getLocKey("Good_hit"), localizationMG.getLocKey("Confirmed")}},
}

takeoffTypes = 
{
    {name = _("In air"), pointType = "Turning Point"}, 
    {name = _("Runway"), pointType = "TakeOff"},
    {name = _("Ramp"), pointType = "TakeOffParking"}, 
}

actionsFromPoints = 
{
	["Fly Over Point"] = "Fly Over Point",
    ["Turning Point"] = "Turning Point",
    ["TakeOff"] = "From Runway",
    ["TakeOffParking"] = "From Parking Area",
    ["Land"] = "Landing",
}

inAirPointType = "Turning Point"
takeoffPointType = "TakeOff"
takeoffParkingPointType = "TakeOffParking"
landingPointType = "Land"

localizedStrings = 
{
	missionName			= localizationMG.localizedStrings.missionName.key,
	goalDescription		= localizationMG.localizedStrings.goalDescription.key,
	missionDescription	= localizationMG.localizedStrings.missionDescription.key,
	at					= localizationMG.localizedStrings.at.key,
	mhz					= localizationMG.localizedStrings.mhz.key,
	jtacDescription		= localizationMG.localizedStrings.jtacDescription.key,
	awacsDescription	= localizationMG.localizedStrings.awacsDescription.key,
	awacsDescription	= localizationMG.localizedStrings.awacsDescription.key,
	LastManStanding		= localizationMG.localizedStrings.LastManStanding.key,
	KillThemAll			= localizationMG.localizedStrings.KillThemAll.key,
	FreeFlightMission	= localizationMG.localizedStrings.FreeFlightMission.key,
	FreeFlight			= localizationMG.localizedStrings.FreeFlight.key,
	Conquest			= localizationMG.localizedStrings.Conquest.key,
	ToSmoothOutAirfield	= localizationMG.localizedStrings.ToSmoothOutAirfield.key,
}




