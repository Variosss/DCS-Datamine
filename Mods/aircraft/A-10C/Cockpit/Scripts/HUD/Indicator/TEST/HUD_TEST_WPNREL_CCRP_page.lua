dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
WPN_CCRP_1_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_1_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 1")
WPN_CCRP_1_Header.isdraw = true
WPN_CCRP_2_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_2_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 2")
WPN_CCRP_2_Header.isdraw = true
WPN_CCRP_2_Header_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_Header_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 20}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_Header_VAL.formats = {"%2d/%2d/%02d", ""}	
WPN_CCRP_3_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_3_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 3")
WPN_CCRP_3_Header.isdraw = true
WPN_CCRP_4_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_4_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 4")
WPN_CCRP_4_Header.isdraw = true
WPN_CCRP_5_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_5_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 5")
WPN_CCRP_5_Header.isdraw = true

WPN_CCRP_8_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_8_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 6")
WPN_CCRP_8_Header.isdraw = true

WPN_CCRP_7_Header = AddHUDTextElement_Pos_Val("WPN_CCRP_7_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCRP - 7")
WPN_CCRP_7_Header.isdraw = true
			
-- CCRP data 			
PosY = PosY + TestModeDeltaPosY * 2.0
-- 1 -------------------------------------------------	
WPN_CCRP_1_PASSTIME = AddHUDTextElement_Pos_Val("WPN_CCRP_1_PASSTIME",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PASS/TIME")
WPN_CCRP_1_PASSTIME.isdraw = true

WPN_CCRP_1_PASSTIME_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_PASSTIME_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 11}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_1_PASSTIME_VAL.formats = {"%d/%s", ""}	  
-- 2 -------------------------------------------------				  
WPN_CCRP_2_MSLRDRALT = AddHUDTextElement_Pos_Val("WPN_CCRP_2_MSLRDRALT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MSL/RDR ALT")
WPN_CCRP_2_MSLRDRALT.isdraw = true

WPN_CCRP_2_MSLRDRALT_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_MSLRDRALT_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 21}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_MSLRDRALT_VAL.formats = {"%d/%d", ""}					  
-- 3 -------------------------------------------------				  
WPN_CCRP_3_VAU = AddHUDTextElement_Pos_Val("WPN_CCRP_3_VAU",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAU")
WPN_CCRP_3_VAU.isdraw = true

WPN_CCRP_3_VAU_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_VAU_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 31}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
-- 4 -------------------------------------------------				  
WPN_CCRP_4_VWINDX = AddHUDTextElement_Pos_Val("WPN_CCRP_4_VWINDX",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VWINDX")
WPN_CCRP_4_VWINDX.isdraw = true

WPN_CCRP_4_VWINDX_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_VWINDX_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 41}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
-- 5 -------------------------------------------------				  
WPN_CCRP_5_NSATMADJ = AddHUDTextElement_Pos_Val("WPN_CCRP_5_NSATMADJ",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NSATMADJ")
WPN_CCRP_5_NSATMADJ.isdraw = true

WPN_CCRP_5_NSATMADJ_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_NSATMADJ_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 51}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				 
-- 6 -------------------------------------------------	
WPN_CCRP_6_TRKECCRP = AddHUDTextElement_Pos_Val("WPN_CCRP_6_TRKECCRP",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TRKECCRP")
WPN_CCRP_6_TRKECCRP.isdraw = true

WPN_CCRP_6_TRKECCRP_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_TRKECCRP_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 61}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
-- 7 -------------------------------------------------				  
WPN_CCRP_7_GAMHATC = AddHUDTextElement_Pos_Val("WPN_CCRP_7_GAMHATC",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GAMHATC")
WPN_CCRP_7_GAMHATC.isdraw = true

WPN_CCRP_7_GAMHATC_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_GAMHATC_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 71}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
PosY = PosY + TestModeDeltaPosY 				  
-- 1 -------------------------------------------------	
WPN_CCRP_1_WPNTYPE = AddHUDTextElement_Pos_Val("WPN_CCRP_1_WPNTYPE",
				 {{"HUD_TEST_WpnRel_CCP_page", 1}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WPN/TYPE")
WPN_CCRP_1_WPNTYPE.isdraw = true

WPN_CCRP_1_WPNTYPE_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_WPNTYPE_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 12}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

-- 2 -------------------------------------------------					  
WPN_CCRP_2_MHDGSLRNG = AddHUDTextElement_Pos_Val("WPN_CCRP_2_MHDGSLRNG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " M HDG/SL RNG")
WPN_CCRP_2_MHDGSLRNG.isdraw = true

WPN_CCRP_2_MHDGSLRNG_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_MHDGSLRNG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 22}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_MHDGSLRNG_VAL.formats = {"%.1f/%d", ""}					  
-- 3 -------------------------------------------------	
WPN_CCRP_3_VAV = AddHUDTextElement_Pos_Val("WPN_CCRP_3_VAV",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAV")
WPN_CCRP_3_VAV.isdraw = true

WPN_CCRP_3_VAV_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_VAV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 32}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

-- 4 -------------------------------------------------	
WPN_CCRP_4_VWINDY = AddHUDTextElement_Pos_Val("WPN_CCRP_4_VWINDY",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VWINDY")
WPN_CCRP_4_VWINDY.isdraw = true

WPN_CCRP_4_VWINDY_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_VWINDY_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 42}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		

-- 5 -------------------------------------------------	
WPN_CCRP_5_TRUEHDG = AddHUDTextElement_Pos_Val("WPN_CCRP_5_TRUEHDG",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TRUE HDG")
WPN_CCRP_5_TRUEHDG.isdraw = true

WPN_CCRP_5_TRUEHDG_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_TRUEHDG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 52}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")						  
-- 6 ------------------------------------------------- 				  
WPN_CCRP_6_RMDRMC = AddHUDTextElement_Pos_Val("WPN_CCRP_6_RMDRMC",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RMD/RMC")
WPN_CCRP_6_RMDRMC.isdraw = true

WPN_CCRP_6_RMDRMC_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_RMDRMC_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 62}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 7 -------------------------------------------------				  
WPN_CCRP_7_PSIBAHC = AddHUDTextElement_Pos_Val("WPN_CCRP_7_PSIBAHC",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PSIBAHC")
WPN_CCRP_7_PSIBAHC.isdraw = true

WPN_CCRP_7_PSIBAHC_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_PSIBAHC_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 72}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCRP_1_RELMODE = AddHUDTextElement_Pos_Val("WPN_CCRP_1_RELMODE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " REL MODE")
WPN_CCRP_1_RELMODE.isdraw = true

WPN_CCRP_1_RELMODE_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_RELMODE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 13}},  
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------				  
WPN_CCRP_2_TFALLBMBRNG = AddHUDTextElement_Pos_Val("WPN_CCRP_2_TFALLBMBRNG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TFALL/BMB RNG")
WPN_CCRP_2_TFALLBMBRNG.isdraw = true

WPN_CCRP_2_TFALLBMBRNG_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_TFALLBMBRNG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 23}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_TFALLBMBRNG_VAL.formats = {"%.1f/%d",""}					  
-- 3 -------------------------------------------------				  
WPN_CCRP_3_VAW = AddHUDTextElement_Pos_Val("WPN_CCRP_3_VAW",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAW")
WPN_CCRP_3_VAW.isdraw = true

WPN_CCRP_3_VAW_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_VAW_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 33}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------				  
WPN_CCRP_4_VIX = AddHUDTextElement_Pos_Val("WPN_CCRP_4_VIX",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIX")
WPN_CCRP_4_VIX.isdraw = true

WPN_CCRP_4_VIX_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_VIX_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 43}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------				  
WPN_CCRP_5_MAXHT = AddHUDTextElement_Pos_Val("WPN_CCRP_5_MAXHT",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAX HT")
WPN_CCRP_5_MAXHT.isdraw = true

WPN_CCRP_5_MAXHT_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_MAXHT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 53}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
-- 6 ------------------------------------------------- 	
WPN_CCRP_6_RSTABAZ = AddHUDTextElement_Pos_Val("WPN_CCRP_6_RSTABAZ",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RSTABAZ")
WPN_CCRP_6_RSTABAZ.isdraw = true

WPN_CCRP_6_RSTABAZ_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_RSTABAZ_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 63}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		
-- 7 -------------------------------------------------				  
WPN_CCRP_7_VXBFEND = AddHUDTextElement_Pos_Val("WPN_CCRP_7_VXBFEND",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VXFEND")
WPN_CCRP_7_VXBFEND.isdraw = true

WPN_CCRP_7_VXBFEND_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_VXBFEND_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 73}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")					  
PosY = PosY + TestModeDeltaPosY
-- 1 ------------------------------------------------- 
WPN_CCRP_1_QTYFT = AddHUDTextElement_Pos_Val("WPN_CCRP_1_QTYFT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " QTY/MSEC")
WPN_CCRP_1_QTYFT.isdraw = true

WPN_CCRP_1_QTYFT_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_QTYFT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data",14}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ------------------------------------------------- 				  
WPN_CCRP_2_HATSCE = AddHUDTextElement_Pos_Val("WPN_CCRP_2_HATSCE",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HAT/SCE")
WPN_CCRP_2_HATSCE.isdraw = true

WPN_CCRP_2_HATSCE_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_HATSCE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data",24}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_HATSCE_VAL.formats = {"%d/BARO", "%d/RADAR", "%d/DELTA", ""}	
-- 3 ------------------------------------------------- 				  
WPN_CCRP_3_AU = AddHUDTextElement_Pos_Val("WPN_CCRP_3_AU",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AU")
WPN_CCRP_3_AU.isdraw = true

WPN_CCRP_3_AU_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_AU_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 34}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 ------------------------------------------------- 				  
WPN_CCRP_4_VIY = AddHUDTextElement_Pos_Val("WPN_CCRP_4_VIY",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIY")
WPN_CCRP_4_VIY.isdraw = true

WPN_CCRP_4_VIY_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_VIY_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 44}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 ------------------------------------------------- 				  
WPN_CCRP_5_QBARC = AddHUDTextElement_Pos_Val("WPN_CCRP_5_QBARC",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " QBARC")
WPN_CCRP_5_QBARC.isdraw = true

WPN_CCRP_5_QBARC_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_QBARC_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 54}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 6 -------------------------------------------------
WPN_CCRP_6_RSTABEL = AddHUDTextElement_Pos_Val("WPN_CCRP_6_RSTABEL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RSTABEL")
WPN_CCRP_6_RSTABEL.isdraw = true

WPN_CCRP_6_RSTABEL_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_RSTABEL_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 64}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		
-- 7 -------------------------------------------------				  
WPN_CCRP_7_VZBFEND= AddHUDTextElement_Pos_Val("WPN_CCRP_7_VZBFEND",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VZBFEND")
WPN_CCRP_7_VZBFEND.isdraw = true

WPN_CCRP_7_VZBFEND_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_VZBFEND_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 74}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")					  
PosY = PosY + TestModeDeltaPosY 
-- 1 ------------------------------------------------- 	
WPN_CCRP_1_FUZENT = AddHUDTextElement_Pos_Val("WPN_CCRP_1_FUZENT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FUZE N/T")
WPN_CCRP_1_FUZENT.isdraw = true

WPN_CCRP_1_FUZENT_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_FUZENT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 15}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ------------------------------------------------- 	
WPN_CCRP_2_MRSCRITG = AddHUDTextElement_Pos_Val("WPN_CCRP_2_MRSCRITG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MRS CRIT/G")
WPN_CCRP_2_MRSCRITG.isdraw = true

WPN_CCRP_2_MRSCRITG_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_MRSCRITG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 25}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_MRSCRITG_VAL.formats = {"%d/%.1f",""}					
-- 3 ------------------------------------------------- 	
WPN_CCRP_3_AX = AddHUDTextElement_Pos_Val("WPN_CCRP_3_AX",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AX")
WPN_CCRP_3_AX.isdraw = true

WPN_CCRP_3_AX_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_AX_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 35}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 ------------------------------------------------- 	
WPN_CCRP_4_VIZ = AddHUDTextElement_Pos_Val("WPN_CCRP_4_VIZ",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIZ")
WPN_CCRP_4_VIZ.isdraw = true

WPN_CCRP_4_VIZ_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_VIZ_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 45}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 ------------------------------------------------- 	
WPN_CCRP_5_DLAMDGAM = AddHUDTextElement_Pos_Val("WPN_CCRP_5_DLAMDGAM",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DLAMDGAM")
WPN_CCRP_5_DLAMDGAM.isdraw = true

WPN_CCRP_5_DLAMDGAM_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_DLAMDGAM_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 55}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 6 -------------------------------------------------				  
WPN_CCRP_6_PHIF = AddHUDTextElement_Pos_Val("WPN_CCRP_6_PHIF",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PHIF/PHIF I")
WPN_CCRP_6_PHIF.isdraw = true

WPN_CCRP_6_PHIF_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_PHIF_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 65}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
-- 7 -------------------------------------------------------------	
WPN_CCRP_7_GAMCDOT = AddHUDTextElement_Pos_Val("WPN_CCRP_7_GAMCDOT",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GAMCDOT")
WPN_CCRP_7_GAMCDOT.isdraw = true

WPN_CCRP_7_GAMCDOT_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_GAMCDOT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 75}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")					  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCRP_1_FUZESET = AddHUDTextElement_Pos_Val("WPN_CCRP_1_FUZESET",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FUZE SET")
WPN_CCRP_1_FUZESET.isdraw = true

WPN_CCRP_1_FUZESET_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_FUZESET_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 16}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------
WPN_CCRP_2_DPLOYTIM = AddHUDTextElement_Pos_Val("WPN_CCRP_2_DPLOYTIM",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DPLOYTIM/ALT")
WPN_CCRP_2_DPLOYTIM.isdraw = true

WPN_CCRP_2_DPLOYTIM_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_DPLOYTIM_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCRP_data", 26}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_2_DPLOYTIM_VAL.formats = {"%.2f/%d",""}					
-- 3 -------------------------------------------------
WPN_CCRP_3_AW = AddHUDTextElement_Pos_Val("WPN_CCRP_3_AW",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AW")
WPN_CCRP_3_AW.isdraw = true

WPN_CCRP_3_AW_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_AW_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 36}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------
WPN_CCRP_4_HFILTER = AddHUDTextElement_Pos_Val("WPN_CCRP_4_HFILTER",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HFILTER")
WPN_CCRP_4_HFILTER.isdraw = true

WPN_CCRP_4_HFILTER_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_HFILTER_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 46}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------
WPN_CCRP_5_RSB = AddHUDTextElement_Pos_Val("WPN_CCRP_5_RSB",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RSB")
WPN_CCRP_5_RSB.isdraw = true

WPN_CCRP_5_RSB_VAL = AddHUDTextElement_Pos("WPN_CCRP_5_RSB_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCRP_data", 56}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
-- 6 -------------------------------------------------				  
WPN_CCRP_6_PHIFSQ = AddHUDTextElement_Pos_Val("WPN_CCRP_6_PHIFSQ",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PHIFSQ")
WPN_CCRP_6_PHIFSQ.isdraw = true

WPN_CCRP_6_PHIFSQ_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_PHIFSQ_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 66}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
-- 7 -------------------------------------------------
WPN_CCRP_7_PSIBCDOT = AddHUDTextElement_Pos_Val("WPN_CCRP_7_PSIBCDOT",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PSIBCDOT")
WPN_CCRP_7_PSIBCDOT.isdraw = true

WPN_CCRP_7_PSIBCDOT_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_PSIBCDOT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 76}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")					  
PosY = PosY + TestModeDeltaPosY
-- 1 ------------------------------------------------- 
WPN_CCRP_1_HOFRPM = AddHUDTextElement_Pos_Val("WPN_CCRP_1_HOFRPM",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HOF/RPM")
WPN_CCRP_1_HOFRPM.isdraw = true

WPN_CCRP_1_HOFRPM_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_HOFRPM_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 17}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")			  
-- 2 ------------------------------------------------
WPN_CCRP_2_TGTLAT = AddHUDTextElement_Pos_Val("WPN_CCRP_2_TGTLAT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LAT")
WPN_CCRP_2_TGTLAT.isdraw = true

WPN_CCRP_2_TGTLAT_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_TGTLAT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 0,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
WPN_CCRP_2_TGTLAT_VAL.formats = {"%c %.2d %.2d.%.3d", ""}	
-- 3 ------------------------------------------------- 
WPN_CCRP_3_KTASMACH = AddHUDTextElement_Pos_Val("WPN_CCRP_3_KTASMACH",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KTAS/MACH")
WPN_CCRP_3_KTASMACH.isdraw = true

WPN_CCRP_3_KTASMACH_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_KTASMACH_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 37}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
WPN_CCRP_3_KTASMACH_VAL.formats = {"%.1f/%.2f", ""}
-- 4 ------------------------------------------------- 
WPN_CCRP_4_TFAT = AddHUDTextElement_Pos_Val("WPN_CCRP_4_TFAT",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TFAT")
WPN_CCRP_4_TFAT.isdraw = true

WPN_CCRP_4_TFAT_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_TFAT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 47}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		
-- 6 -------------------------------------------------------------	
WPN_CCRP_6_SINXIR = AddHUDTextElement_Pos_Val("WPN_CCRP_6_SINXIR",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SINXIR")
WPN_CCRP_6_SINXIR.isdraw = true

WPN_CCRP_6_SINXIR_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_SINXIR_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 67}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		
-- 7 -------------------------------------------------				  
WPN_CCRP_7_RXRY = AddHUDTextElement_Pos_Val("WPN_CCRP_7_RXRY",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RX/RY")
WPN_CCRP_7_RXRY.isdraw = true

WPN_CCRP_7_RXRY_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_RXRY_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 77}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCRP_1_MINALT = AddHUDTextElement_Pos_Val("WPN_CCRP_1_MINALT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN ALT")
WPN_CCRP_1_MINALT.isdraw = true

WPN_CCRP_1_MINALT_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_MINALT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 18}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------				  
WPN_CCRP_2_TGTLONG = AddHUDTextElement_Pos_Val("WPN_CCRP_2_TGTLONG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LONG")
WPN_CCRP_2_TGTLONG.isdraw = true

WPN_CCRP_2_TGTLONG_VAL = AddHUDTextElement_Pos("WPN_CCRP_2_TGTLONG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 1,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  	  
WPN_CCRP_2_TGTLONG_VAL.formats = {"%c %.3d %.2d.%.3d", ""}	
-- 3 -------------------------------------------------
WPN_CCRP_3_THE = AddHUDTextElement_Pos_Val("WPN_CCRP_3_THE",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " THE")
WPN_CCRP_3_THE.isdraw = true

WPN_CCRP_3_THE_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_THE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 38}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------
WPN_CCRP_4_HFPRESS = AddHUDTextElement_Pos_Val("WPN_CCRP_4_HFPRESS",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HFPRESS")
WPN_CCRP_4_HFPRESS.isdraw = true

WPN_CCRP_4_HFPRESS_VAL = AddHUDTextElement_Pos("WPN_CCRP_4_HFPRESS_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCRP_data", 48}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------
WPN_CCRP_5_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_5_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_5_NEXT_PAGE.isdraw = true			  
-- 6 -------------------------------------------------				  
WPN_CCRP_6_GAMMAC = AddHUDTextElement_Pos_Val("WPN_CCRP_6_GAMMAC",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GAMMAC")
WPN_CCRP_6_GAMMAC.isdraw = true

WPN_CCRP_6_GAMMAC_VAL = AddHUDTextElement_Pos("WPN_CCRP_6_GAMMAC_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 6},{"HUD_TEST_WpnRel_CCRP_data", 68}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")			
-- 7 -------------------------------------------------				  
WPN_CCRP_7_RZ = AddHUDTextElement_Pos_Val("WPN_CCRP_7_RZ",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RZ")
WPN_CCRP_7_RZ.isdraw = true

WPN_CCRP_7_RZ_VAL = AddHUDTextElement_Pos("WPN_CCRP_7_RZ_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 7},{"HUD_TEST_WpnRel_CCRP_data", 78}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCRP_1_TGTELV = AddHUDTextElement_Pos_Val("WPN_CCRP_1_TGTELV",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT ELV")
WPN_CCRP_1_TGTELV.isdraw = true

WPN_CCRP_1_TGTELV_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_TGTELV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 19}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCRP_1_TGTELV_VAL.formats = {"%d", "%d/DTS", ""}					  
-- 3 -------------------------------------------------
WPN_CCRP_3_PHI = AddHUDTextElement_Pos_Val("WPN_CCRP_3_PHI",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PHI")
WPN_CCRP_3_PHI.isdraw = true

WPN_CCRP_3_PHI_VAL = AddHUDTextElement_Pos("WPN_CCRP_3_PHI_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCRP_data", 39}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  
-- 5 -------------------------------------------------------------
WPN_CCRP_5_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_5_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_5_EXIT.isdraw = true

PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCRP_1_KIASDIVE = AddHUDTextElement_Pos_Val("WPN_CCRP_1_KIASDIVE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KIAS/DIVE")
WPN_CCRP_1_KIASDIVE.isdraw = true

WPN_CCRP_1_KIASDIVE_VAL = AddHUDTextElement_Pos("WPN_CCRP_1_KIASDIVE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCRP_data", 10}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")			
WPN_CCRP_1_KIASDIVE_VAL.formats = {"%.2f/%.2f", ""}					  
-- 2 -------------------------------------------------------------	
WPN_CCRP_2_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_2_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_2_NEXT_PAGE.isdraw = true
-- 4 -------------------------------------------------------------	
WPN_CCRP_4_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_4_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_4_NEXT_PAGE.isdraw = true
-- 6 -------------------------------------------------------------	
WPN_CCRP_6_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_6_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_6_NEXT_PAGE.isdraw = true
-- 7 -------------------------------------------------------------	
WPN_CCRP_7_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_7_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_7_NEXT_PAGE.isdraw = true
			  
PosY = PosY + TestModeDeltaPosY
-- 2 -------------------------------------------------------------
WPN_CCRP_2_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_2_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_2_EXIT.isdraw = true
-- 3 -------------------------------------------------------------
WPN_CCRP_3_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_3_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_3_NEXT_PAGE.isdraw = true
-- 4 -------------------------------------------------------------
WPN_CCRP_4_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_4_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_4_EXIT.isdraw = true
-- 6-------------------------------------------------------------
WPN_CCRP_6_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_6_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 6}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_6_EXIT.isdraw = true
-- 7  -------------------------------------------------------
WPN_CCRP_7_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_7_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 7}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_7_EXIT.isdraw = true
PosY = PosY + TestModeDeltaPosY
-- 3 -------------------------------------------------------------
WPN_CCRP_3_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_3_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_3_EXIT.isdraw = true	

WPN_CCRP_1_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCRP_1_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCRP_1_NEXT_PAGE.isdraw = true

PosY = PosY + TestModeDeltaPosY

WPN_CCRP_1_EXIT = AddHUDTextElement_Pos_Val("WPN_CCRP_1_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCRP_1_EXIT.isdraw = true