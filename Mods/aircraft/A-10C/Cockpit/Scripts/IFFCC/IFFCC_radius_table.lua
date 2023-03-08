dofile("Scripts/Database/wsTypes.lua")

bombs_casualty_radius = {}

bombs_casualty_radius[wsType_Weapon] = {} 
bombs_casualty_radius[wsType_Weapon][wsType_Bomb] = {}
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A] = {}
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][BDU_33] = 1127.76 --3700 feet
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][BDU_50LD] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][BDU_50HD] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][BDU_56LD] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][Mk_84] = 1127.76 
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][Mk_82] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_A][MK_82AIR] = 1127.76

bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster] = {}
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_87] = 240.0 --???
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_89] = 60.0 --???
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_97] = 60.0 --???
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_103] = 240.0 --???
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_104] = 60.0 --???
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Cluster][CBU_105] = 60.0 --???

bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided] = {}
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][GBU_10] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][GBU_12] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][BDU_50LGB] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][BDU_56LGB] = 1127.76

--JDAM
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][GBU_31] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][GBU_31_V_3B] = 1127.76
bombs_casualty_radius[wsType_Weapon][wsType_Bomb][wsType_Bomb_Guided][GBU_38] = 1127.76

