dofile("Scripts/Database/wsTypes.lua")

Weapons_Types = {}
Weapons_Types[1]   = {"AIM-7",     "S", {{wsType_Weapon, wsType_Missile, wsType_AA_Missile, AIM_7}}} -- AIM-7 Sparrow
Weapons_Types[2]   = {"AIM-9",     "S", {{wsType_Weapon, wsType_Missile, wsType_AA_Missile, AIM_9}}} -- AIM-9 Sidewinder
Weapons_Types[3]   = {"AIM-54",    "S", {{wsType_Weapon, wsType_Missile, wsType_AA_Missile, AIM_54}}} -- AIM-54 Phoenix
Weapons_Types[4]   = {"AGM-45",    "H", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_45}}} -- AGM-45 Shrike
Weapons_Types[5]   = {"AGM-65A",   "A"} -- AGM-65A Maverick (TV)
Weapons_Types[6]   = {"AGM-65B",   "A"} -- AGM-65B Maverick (TV)
Weapons_Types[7]   = {"AGM-65D",   "A", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_65D}}} -- AGM-65D Maverick (IR)
Weapons_Types[8]   = {"AGM-65E",   "A", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_65E}}} -- AGM-65E Maverick (Laser MAW)
Weapons_Types[9]   = {"AGM-78",    "H"} -- AGM-78
Weapons_Types[10]  = {"AGM-65G",   "A", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_65G}}} -- AGM-65G Maverick
Weapons_Types[11]  = {"AIM-120",   "S", {{wsType_Weapon, wsType_Missile, wsType_AA_Missile, AIM_120}}} -- AIM-120 AMRAAM
Weapons_Types[12]  = {"AGM-65H",   "A", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_65H}}} -- AGM-65H Maverick
Weapons_Types[13]  = {"AGM-65K",   "A", {{wsType_Weapon, wsType_Missile, wsType_AS_Missile, AGM_65K}}} -- AGM-65K Maverick
Weapons_Types[15]  = {"BLU-27",    "B"} -- BLU-27 Napalm
Weapons_Types[17]  = {"MK-82AIR",  "B", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, MK_82AIR}}} -- MK-82 Air
Weapons_Types[18]  = {"MK-84AIR",  "B"} -- MK-84 Air
Weapons_Types[19]  = {"CBU-24",    "C"} -- CBU-24
Weapons_Types[20]  = {"CBU-49",    "C"} -- CBU-49
Weapons_Types[22]  = {"CBU-59B",   "C"} -- CBU-59/B Rockeye II
Weapons_Types[24]  = {"CBU-87",    "C", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, CBU_87}}} -- CBU-87 CEM
Weapons_Types[25]  = {"CBU-89",    "C", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, CBU_89}}} -- CBU-89 Gator
Weapons_Types[26]  = {"CBU-90",    "C"} -- CBU-90
Weapons_Types[27]  = {"CBU-92",    "C"} -- CBU-92
Weapons_Types[28]  = {"CBU-93",    "C"} -- CBU-93
Weapons_Types[29]  = {"CBU-421A",  "C"} -- CBU-421A
Weapons_Types[30]  = {"CBU-81B",   "C"} -- CBU-81B
Weapons_Types[31]  = {"GBU-10",    "L", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_10}}} -- GBU-10 Paveway I & II (MK-84)
Weapons_Types[32]  = {"GBU-12",    "L", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_12}}} -- GBU-12 Paveway I & II (MK-82)
Weapons_Types[33]  = {"GBU-15",    "L"} -- GBU-15(V)-4B
Weapons_Types[34]  = {"GBU-22B",   "L"} -- GBU-22B
Weapons_Types[41]  = {"MK-24",     "B"} -- MK-24
Weapons_Types[42]  = {"MK-33",     "B"} -- MK-33
Weapons_Types[43]  = {"MK-36",     "M"} -- MK-36 Sea Mine
Weapons_Types[44]  = {"MK-45",     "B"} -- MK-45
Weapons_Types[45]  = {"MK-77",     "B"} -- MK-77
Weapons_Types[46]  = {"MK-81SE",   "B"} -- MK-81SE
Weapons_Types[47]  = {"MK-82LD",   "B", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_82}}} -- MK-82 LD
Weapons_Types[48]  = {"MK-82SE",   "B"} -- MK-82SE Snake Eye
Weapons_Types[49]  = {"MK-83",     "B"} -- MK-83 GP 1000LB
Weapons_Types[50]  = {"MK-84LD",   "B", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, Mk_84}}} -- MK-84 LD 2000LB
Weapons_Types[51]  = {"MK-117",    "B"} -- MK-117 750LB
Weapons_Types[52]  = {"Rockets",   "R", {{wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_M257},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_M278},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_M151},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_M156},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_WTU1B},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_M274},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_MK1},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_MK5},
						    {wsType_Weapon, wsType_NURS, wsType_Rocket, HYDRA_70_MK61}}} -- Rockets (2.75)
Weapons_Types[55]  = {"AGM-62",    "A"} -- AGM-62 Walleye
Weapons_Types[56]  = {"AGM-62",    "A"} -- AGM-62 Walleye I (EO) 1000LB
Weapons_Types[57]  = {"AGM-62",    "A"} -- AGM-62 Walleye II (ER/DL) (EO) 2400LB
Weapons_Types[59]  = {"AIM-132",   "S"} -- AIM-132 ASRAAM
Weapons_Types[60]  = {"CBU-97",    "C", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, CBU_97}}} -- CBU-97 SFW
Weapons_Types[75]  = {"LUU-2B",    "F", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_2B}}} -- LUU-2B
Weapons_Types[76]  = {"LUU-2AB",   "F", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_2AB}}} -- LUU-2AB
Weapons_Types[77]  = {"LUU-2BB",   "F", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_2BB}}} -- LUU-2BB
Weapons_Types[78]  = {"LUU-19",    "F", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Lighter, LUU_19}}} -- LUU-19
Weapons_Types[85]  = {"TP 400",    "F"} -- FLARE-TP 400
Weapons_Types[86]  = {"ALE-40",    "F"} -- FLARE-ALE 40
Weapons_Types[88]  = {"S EAGLE", "N"} -- Sea Eagle
Weapons_Types[94]  = {"BDU-33",    "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_33}}} -- BDU-33 (Practice Bomb)
Weapons_Types[95]  = {"BDU-48",    "T"} -- BDU-48 (Practice Bomb)
Weapons_Types[96]  = {"TGM-65D",   "T", {{wsType_Weapon, wsType_Missile, wsType_AS_TRAIN_Missile, TGM_65D}}} -- TGM-65D Maverick
Weapons_Types[97]  = {"TGM-65E",   "T", {{wsType_Weapon, wsType_Missile, wsType_AS_TRAIN_Missile, TGM_65E}}} -- TGM-65E Maverick
Weapons_Types[98]  = {"TGM-65G",   "T", {{wsType_Weapon, wsType_Missile, wsType_AS_TRAIN_Missile, TGM_65G}}} -- TGM-65G Maverick
Weapons_Types[99]  = {"TGM-65H",   "T", {{wsType_Weapon, wsType_Missile, wsType_AS_TRAIN_Missile, TGM_65H}}} -- TGM-65H Maverick
Weapons_Types[100] = {"CATM-65K",  "T", {{wsType_Weapon, wsType_Missile, wsType_AS_TRAIN_Missile, CATM_65K}}} -- CATM-65K Maverick
Weapons_Types[101] = {"BDU-50LD",  "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_50LD}}} -- BDU-50LD (Practice Bomb)
Weapons_Types[102] = {"BDU-50HD",  "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_50HD}}} -- BDU-50HD (Practice Bomb)
Weapons_Types[103] = {"BDU-50LGB", "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, BDU_50LGB}}} -- BDU-50LGB (Practice Bomb)
Weapons_Types[104] = {"BDU-56LD",  "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_A, BDU_56LD}}} -- BDU-56LD (Practice Bomb)
Weapons_Types[105] = {"BDU-56LGB", "T", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, BDU_56LGB}}} -- BDU-56LGB (Practice Bomb)
Weapons_Types[106] = {"CATM-9",    "T", {{wsType_Weapon, wsType_Missile, wsType_AA_TRAIN_Missile, CATM_9}}} -- CATM-9
Weapons_Types[108] = {"AGM-154",   "J"} -- AGM-154 JSOW (BLU-97)
Weapons_Types[121] = {"MJU-27",    "D"} -- MJU-27
Weapons_Types[122] = {"MJU-37",    "D"} -- MJU-37
Weapons_Types[182] = {"GBU-31",    "J", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_31}}} -- GBU-31 JDAM (MK-84)
Weapons_Types[183] = {"GBU-38",    "J", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_38}}} -- GBU-38 JDAM (MK-82)
Weapons_Types[184] = {"GBU-31",    "J", {{wsType_Weapon, wsType_Bomb, wsType_Bomb_Guided, GBU_31_V_3B}}} -- GBU-31(V)3/B JDAM (BLU-109)
Weapons_Types[250] = {"VAPOR",     "V"} -- Chemical (vapor)


TypesDisplayPriority = {}
TypesDisplayPriority[1]  = {"A"}
TypesDisplayPriority[2]  = {"C"}
TypesDisplayPriority[3]  = {"B"}
TypesDisplayPriority[4]  = {"L"}
TypesDisplayPriority[5]  = {"R"}
TypesDisplayPriority[6]  = {"S"}
TypesDisplayPriority[7]  = {"J"}
TypesDisplayPriority[8]  = {"H"}
TypesDisplayPriority[9]  = {"N"}
TypesDisplayPriority[10] = {"F"}
TypesDisplayPriority[11] = {"V"}
TypesDisplayPriority[12] = {"D"}
TypesDisplayPriority[13] = {"T"}
TypesDisplayPriority[14] = {"M"}
