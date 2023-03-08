dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
WPN_CCIP_1_Header = AddHUDTextElement_Pos_Val("WPN_CCIP_1_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP - 1")
WPN_CCIP_1_Header.isdraw = true


WPN_CCIP_2_Header = AddHUDTextElement_Pos_Val("WPN_CCIP_2_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP - 2")
WPN_CCIP_2_Header.isdraw = true


WPN_CCIP_2_Header_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_Header_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 20}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_Header_VAL.formats = {"%2d/%2d/%02d", ""}	

WPN_CCIP_3_Header = AddHUDTextElement_Pos_Val("WPN_CCIP_3_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP - 3")
WPN_CCIP_3_Header.isdraw = true

WPN_CCIP_4_Header = AddHUDTextElement_Pos_Val("WPN_CCIP_4_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP - 4")
WPN_CCIP_4_Header.isdraw = true

WPN_CCIP_5_Header = AddHUDTextElement_Pos_Val("WPN_CCIP_5_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP - 5")
WPN_CCIP_5_Header.isdraw = true
			
-- CCIP data 			
PosY = PosY + TestModeDeltaPosY * 2.0
-- 1 -------------------------------------------------	
WPN_CCIP_1_PASSTIME = AddHUDTextElement_Pos_Val("WPN_CCIP_1_PASSTIME",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PASS/TIME")
WPN_CCIP_1_PASSTIME.isdraw = true

WPN_CCIP_1_PASSTIME_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_PASSTIME_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 11}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_1_PASSTIME_VAL.formats = {"%d/%s", ""}	  
-- 2 -------------------------------------------------				  
WPN_CCIP_2_MSLRDRALT = AddHUDTextElement_Pos_Val("WPN_CCIP_2_MSLRDRALT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MSL/RDR ALT")
WPN_CCIP_2_MSLRDRALT.isdraw = true

WPN_CCIP_2_MSLRDRALT_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_MSLRDRALT_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 21}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_MSLRDRALT_VAL.formats = {"%d/%d", ""}					  
-- 3 -------------------------------------------------				  
WPN_CCIP_3_VAU = AddHUDTextElement_Pos_Val("WPN_CCIP_3_VAU",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAU")
WPN_CCIP_3_VAU.isdraw = true

WPN_CCIP_3_VAU_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_VAU_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 31}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
-- 4 -------------------------------------------------				  
WPN_CCIP_4_VWINDX = AddHUDTextElement_Pos_Val("WPN_CCIP_4_VWINDX",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VWINDX")
WPN_CCIP_4_VWINDX.isdraw = true

WPN_CCIP_4_VWINDX_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_VWINDX_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 41}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
-- 5 -------------------------------------------------				  
WPN_CCIP_5_NSATMADJ = AddHUDTextElement_Pos_Val("WPN_CCIP_5_NSATMADJ",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NSATMADJ")
WPN_CCIP_5_NSATMADJ.isdraw = true

WPN_CCIP_5_NSATMADJ_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_NSATMADJ_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 51}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------	
WPN_CCIP_1_WPNTYPE = AddHUDTextElement_Pos_Val("WPN_CCIP_1_WPNTYPE",
				 {{"HUD_TEST_WpnRel_CCP_page", 1}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WPN/TYPE")
WPN_CCIP_1_WPNTYPE.isdraw = true

WPN_CCIP_1_WPNTYPE_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_WPNTYPE_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 12}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

-- 2 -------------------------------------------------					  
WPN_CCIP_2_MHDGSLRNG = AddHUDTextElement_Pos_Val("WPN_CCIP_2_MHDGSLRNG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " M HDG/SL RNG")
WPN_CCIP_2_MHDGSLRNG.isdraw = true

WPN_CCIP_2_MHDGSLRNG_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_MHDGSLRNG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 22}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_MHDGSLRNG_VAL.formats = {"%.1f/%d", ""}					  
-- 3 -------------------------------------------------	
WPN_CCIP_3_VAV = AddHUDTextElement_Pos_Val("WPN_CCIP_3_VAV",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAV")
WPN_CCIP_3_VAV.isdraw = true

WPN_CCIP_3_VAV_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_VAV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 32}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

-- 4 -------------------------------------------------	
WPN_CCIP_4_VWINDY = AddHUDTextElement_Pos_Val("WPN_CCIP_4_VWINDY",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VWINDY")
WPN_CCIP_4_VWINDY.isdraw = true

WPN_CCIP_4_VWINDY_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_VWINDY_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 42}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		

-- 5 -------------------------------------------------	
WPN_CCIP_5_TRUEHDG = AddHUDTextElement_Pos_Val("WPN_CCIP_5_TRUEHDG",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TRUE HDG")
WPN_CCIP_5_TRUEHDG.isdraw = true

WPN_CCIP_5_TRUEHDG_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_TRUEHDG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 52}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")						  
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCIP_1_RELMODE = AddHUDTextElement_Pos_Val("WPN_CCIP_1_RELMODE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " REL MODE")
WPN_CCIP_1_RELMODE.isdraw = true

WPN_CCIP_1_RELMODE_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_RELMODE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 13}},  
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------				  
WPN_CCIP_2_TFALLBMBRNG = AddHUDTextElement_Pos_Val("WPN_CCIP_2_TFALLBMBRNG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TFALL/BMB RNG")
WPN_CCIP_2_TFALLBMBRNG.isdraw = true

WPN_CCIP_2_TFALLBMBRNG_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_TFALLBMBRNG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 23}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_TFALLBMBRNG_VAL.formats = {"%.1f/%d",""}					  
-- 3 -------------------------------------------------				  
WPN_CCIP_3_VAW = AddHUDTextElement_Pos_Val("WPN_CCIP_3_VAW",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAW")
WPN_CCIP_3_VAW.isdraw = true

WPN_CCIP_3_VAW_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_VAW_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 33}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------				  
WPN_CCIP_4_VIX = AddHUDTextElement_Pos_Val("WPN_CCIP_4_VIX",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIX")
WPN_CCIP_4_VIX.isdraw = true

WPN_CCIP_4_VIX_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_VIX_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 43}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------				  
WPN_CCIP_5_MAXHT = AddHUDTextElement_Pos_Val("WPN_CCIP_5_MAXHT",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAX HT")
WPN_CCIP_5_MAXHT.isdraw = true

WPN_CCIP_5_MAXHT_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_MAXHT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 53}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY
-- 1 ------------------------------------------------- 
WPN_CCIP_1_QTYFT = AddHUDTextElement_Pos_Val("WPN_CCIP_1_QTYFT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " QTY/FT")
WPN_CCIP_1_QTYFT.isdraw = true

WPN_CCIP_1_QTYFT_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_QTYFT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data",14}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ------------------------------------------------- 				  
WPN_CCIP_2_HATSCE = AddHUDTextElement_Pos_Val("WPN_CCIP_2_HATSCE",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HAT/SCE")
WPN_CCIP_2_HATSCE.isdraw = true

WPN_CCIP_2_HATSCE_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_HATSCE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data",24}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_HATSCE_VAL.formats = {"%d/BARO", "%d/RADAR", "%d/DELTA", ""}	
-- 3 ------------------------------------------------- 				  
WPN_CCIP_3_AU = AddHUDTextElement_Pos_Val("WPN_CCIP_3_AU",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AU")
WPN_CCIP_3_AU.isdraw = true

WPN_CCIP_3_AU_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_AU_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 34}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 ------------------------------------------------- 				  
WPN_CCIP_4_VIY = AddHUDTextElement_Pos_Val("WPN_CCIP_4_VIY",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIY")
WPN_CCIP_4_VIY.isdraw = true

WPN_CCIP_4_VIY_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_VIY_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 44}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 ------------------------------------------------- 				  
WPN_CCIP_5_QBARC = AddHUDTextElement_Pos_Val("WPN_CCIP_5_QBARC",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " QBARC")
WPN_CCIP_5_QBARC.isdraw = true

WPN_CCIP_5_QBARC_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_QBARC_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 54}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 ------------------------------------------------- 	
WPN_CCIP_1_FUZENT = AddHUDTextElement_Pos_Val("WPN_CCIP_1_FUZENT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FUZE N/T")
WPN_CCIP_1_FUZENT.isdraw = true

WPN_CCIP_1_FUZENT_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_FUZENT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 15}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ------------------------------------------------- 	
WPN_CCIP_2_MRSCRITG = AddHUDTextElement_Pos_Val("WPN_CCIP_2_MRSCRITG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MRS CRIT/G")
WPN_CCIP_2_MRSCRITG.isdraw = true

WPN_CCIP_2_MRSCRITG_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_MRSCRITG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 25}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_MRSCRITG_VAL.formats = {"%d/%.1f",""}					
-- 3 ------------------------------------------------- 	
WPN_CCIP_3_AX = AddHUDTextElement_Pos_Val("WPN_CCIP_3_AX",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AX")
WPN_CCIP_3_AX.isdraw = true

WPN_CCIP_3_AX_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_AX_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 35}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 ------------------------------------------------- 	
WPN_CCIP_4_VIZ = AddHUDTextElement_Pos_Val("WPN_CCIP_4_VIZ",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VIZ")
WPN_CCIP_4_VIZ.isdraw = true

WPN_CCIP_4_VIZ_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_VIZ_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 45}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 ------------------------------------------------- 	
WPN_CCIP_5_LAMWV = AddHUDTextElement_Pos_Val("WPN_CCIP_5_LAMWV",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " LAMW/LAMV")
WPN_CCIP_5_LAMWV.isdraw = true

WPN_CCIP_5_LAMWV_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_LAMWV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 55}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCIP_1_FUZESET = AddHUDTextElement_Pos_Val("WPN_CCIP_1_FUZESET",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FUZE SET")
WPN_CCIP_1_FUZESET.isdraw = true

WPN_CCIP_1_FUZESET_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_FUZESET_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 16}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------
WPN_CCIP_2_DPLOYTIM = AddHUDTextElement_Pos_Val("WPN_CCIP_2_DPLOYTIM",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DPLOYTIM/ALT")
WPN_CCIP_2_DPLOYTIM.isdraw = true

WPN_CCIP_2_DPLOYTIM_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_DPLOYTIM_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_CCIP_data", 26}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_2_DPLOYTIM_VAL.formats = {"%.2f/%d",""}					
-- 3 -------------------------------------------------
WPN_CCIP_3_AW = AddHUDTextElement_Pos_Val("WPN_CCIP_3_AW",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AW")
WPN_CCIP_3_AW.isdraw = true

WPN_CCIP_3_AW_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_AW_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 36}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------
WPN_CCIP_4_HFILTER = AddHUDTextElement_Pos_Val("WPN_CCIP_4_HFILTER",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HFILTER")
WPN_CCIP_4_HFILTER.isdraw = true

WPN_CCIP_4_HFILTER_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_HFILTER_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 46}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------
WPN_CCIP_5_TTGD = AddHUDTextElement_Pos_Val("WPN_CCIP_5_TTGD",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TTGD")
WPN_CCIP_5_TTGD.isdraw = true

WPN_CCIP_5_TTGD_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_TTGD_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 56}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
			
PosY = PosY + TestModeDeltaPosY
-- 1 ------------------------------------------------- 
WPN_CCIP_1_HOFRPM = AddHUDTextElement_Pos_Val("WPN_CCIP_1_HOFRPM",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HOF/RPM")
WPN_CCIP_1_HOFRPM.isdraw = true

WPN_CCIP_1_HOFRPM_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_HOFRPM_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 17}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")			  
-- 2 ------------------------------------------------
WPN_CCIP_2_TGTLAT = AddHUDTextElement_Pos_Val("WPN_CCIP_2_TGTLAT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LAT")
WPN_CCIP_2_TGTLAT.isdraw = true

WPN_CCIP_2_TGTLAT_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_TGTLAT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 0,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
WPN_CCIP_2_TGTLAT_VAL.formats = {"%c %.2d %.2d.%.3d", ""}	
-- 3 ------------------------------------------------- 
WPN_CCIP_3_KTASMACH = AddHUDTextElement_Pos_Val("WPN_CCIP_3_KTASMACH",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KTAS/MACH")
WPN_CCIP_3_KTASMACH.isdraw = true

WPN_CCIP_3_KTASMACH_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_KTASMACH_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 37}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
WPN_CCIP_3_KTASMACH_VAL.formats = {"%.1f/%.2f", ""}
-- 4 ------------------------------------------------- 
WPN_CCIP_4_TFAT = AddHUDTextElement_Pos_Val("WPN_CCIP_4_TFAT",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TFAT")
WPN_CCIP_4_TFAT.isdraw = true

WPN_CCIP_4_TFAT_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_TFAT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 47}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
-- 5 ------------------------------------------------- 
WPN_CCIP_5_TTGMMNRGG = AddHUDTextElement_Pos_Val("WPN_CCIP_5_TTGMMNRGG",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TTGM/MNRNG")
WPN_CCIP_5_TTGMMNRGG.isdraw = true

WPN_CCIP_5_TTGMMNRGG_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_TTGMMNRGG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 57}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")					  
WPN_CCIP_5_TTGMMNRGG_VAL.formats = {"%.2f/%d", ""}				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCIP_1_MINALT = AddHUDTextElement_Pos_Val("WPN_CCIP_1_MINALT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN ALT")
WPN_CCIP_1_MINALT.isdraw = true

WPN_CCIP_1_MINALT_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_MINALT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 18}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -------------------------------------------------				  
WPN_CCIP_2_TGTLONG = AddHUDTextElement_Pos_Val("WPN_CCIP_2_TGTLONG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LONG")
WPN_CCIP_2_TGTLONG.isdraw = true

WPN_CCIP_2_TGTLONG_VAL = AddHUDTextElement_Pos("WPN_CCIP_2_TGTLONG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 1,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  	  
WPN_CCIP_2_TGTLONG_VAL.formats = {"%c %.3d %.2d.%.3d", ""}	
-- 3 -------------------------------------------------
WPN_CCIP_3_THE = AddHUDTextElement_Pos_Val("WPN_CCIP_3_THE",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " THE")
WPN_CCIP_3_THE.isdraw = true

WPN_CCIP_3_THE_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_THE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 38}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 4 -------------------------------------------------
WPN_CCIP_4_HFPRESS = AddHUDTextElement_Pos_Val("WPN_CCIP_4_HFPRESS",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HFPRESS")
WPN_CCIP_4_HFPRESS.isdraw = true

WPN_CCIP_4_HFPRESS_VAL = AddHUDTextElement_Pos("WPN_CCIP_4_HFPRESS_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 4},{"HUD_TEST_WpnRel_CCIP_data", 48}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 5 -------------------------------------------------
WPN_CCIP_5_GNDSPD = AddHUDTextElement_Pos_Val("WPN_CCIP_5_GNDSPD",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GND SPD")
WPN_CCIP_5_GNDSPD.isdraw = true

WPN_CCIP_5_GNDSPD_VAL = AddHUDTextElement_Pos("WPN_CCIP_5_GNDSPD_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 5},{"HUD_TEST_WpnRel_CCIP_data", 58}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCIP_1_TGTELV = AddHUDTextElement_Pos_Val("WPN_CCIP_1_TGTELV",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT ELV")
WPN_CCIP_1_TGTELV.isdraw = true

WPN_CCIP_1_TGTELV_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_TGTELV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 19}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_CCIP_1_TGTELV_VAL.formats = {"%d", "%d/DTS", ""}					  
-- 3 -------------------------------------------------
WPN_CCIP_3_PHI = AddHUDTextElement_Pos_Val("WPN_CCIP_3_PHI",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PHI")
WPN_CCIP_3_PHI.isdraw = true

WPN_CCIP_3_PHI_VAL = AddHUDTextElement_Pos("WPN_CCIP_3_PHI_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 3},{"HUD_TEST_WpnRel_CCIP_data", 39}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  

PosY = PosY + TestModeDeltaPosY 
-- 1 -------------------------------------------------
WPN_CCIP_1_KIASDIVE = AddHUDTextElement_Pos_Val("WPN_CCIP_1_KIASDIVE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KIAS/DIVE")
WPN_CCIP_1_KIASDIVE.isdraw = true

WPN_CCIP_1_KIASDIVE_VAL = AddHUDTextElement_Pos("WPN_CCIP_1_KIASDIVE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_CCIP_data", 10}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")			
WPN_CCIP_1_KIASDIVE_VAL.formats = {"%.2f/%.2f", ""}					  
-- 2 -------------------------------------------------------------	
WPN_CCIP_2_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCIP_2_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCIP_2_NEXT_PAGE.isdraw = true
-- 4 -------------------------------------------------------------	
WPN_CCIP_4_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCIP_4_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCIP_4_NEXT_PAGE.isdraw = true
-- 5 -------------------------------------------------------------	
WPN_CCIP_5_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCIP_5_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCIP_5_NEXT_PAGE.isdraw = true
			  
PosY = PosY + TestModeDeltaPosY
-- 2 -------------------------------------------------------------
WPN_CCIP_2_EXIT = AddHUDTextElement_Pos_Val("WPN_CCIP_2_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCIP_2_EXIT.isdraw = true
-- 3 -------------------------------------------------------------
WPN_CCIP_3_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCIP_3_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCIP_3_NEXT_PAGE.isdraw = true
-- 4 -------------------------------------------------------------
WPN_CCIP_4_EXIT = AddHUDTextElement_Pos_Val("WPN_CCIP_4_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 4}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCIP_4_EXIT.isdraw = true
-- 5 -------------------------------------------------------------
WPN_CCIP_5_EXIT = AddHUDTextElement_Pos_Val("WPN_CCIP_5_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 5}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCIP_5_EXIT.isdraw = true

PosY = PosY + TestModeDeltaPosY
-- 3 -------------------------------------------------------------
WPN_CCIP_3_EXIT = AddHUDTextElement_Pos_Val("WPN_CCIP_3_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCIP_3_EXIT.isdraw = true	

WPN_CCIP_1_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_CCIP_1_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_CCIP_1_NEXT_PAGE.isdraw = true

PosY = PosY + TestModeDeltaPosY

WPN_CCIP_1_EXIT = AddHUDTextElement_Pos_Val("WPN_CCIP_1_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_CCIP_1_EXIT.isdraw = true