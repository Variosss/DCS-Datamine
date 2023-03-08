dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
WPN_MAV_1_Header = AddHUDTextElement_Pos_Val("MAV_1_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAV - 1")
WPN_MAV_1_Header.isdraw = true

WPN_MAV_2_Header = AddHUDTextElement_Pos_Val("WPN_MAV_2_Header", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAV - 2")
WPN_MAV_2_Header.isdraw = true

WPN_MAV_2_Header_VAL = AddHUDTextElement_Pos("WPN_MAV_2_Header_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 20}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_MAV_2_Header_VAL.formats = {"%2d/%2d/%02d", ""}

PosY = PosY + TestModeDeltaPosY * 2.0
-- 1 -----------------------------------------------------------
WPN_MAV_1_PASSTIME = AddHUDTextElement_Pos_Val("WPN_MAV_1_PASSTIME",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PASS/TIME")
WPN_MAV_1_PASSTIME.isdraw = true

WPN_MAV_1_PASSTIME_VAL = AddHUDTextElement_Pos("WPN_MAV_1_PASSTIME_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 11}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_MAV_1_PASSTIME_VAL.formats = {"%d/%s", ""}		
-- 2 -----------------------------------------------------------	
WPN_MAV_2_KIAS = AddHUDTextElement_Pos_Val("WPN_MAV_2_KIAS",
				 {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KIAS/DIVE")
WPN_MAV_2_KIAS.isdraw = true

WPN_MAV_2_KIAS_VAL = AddHUDTextElement_Pos("WPN_MAV_2_KIAS_VAL", 
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 21}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_MAV_2_KIAS_VAL.formats = {"%.2f/%.2f", ""}	
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_MAVTYPE = AddHUDTextElement_Pos_Val("WPN_MAV_1_MAVTYPE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAV TYPE")
WPN_MAV_1_MAVTYPE.isdraw = true

WPN_MAV_1_MAVTYPE_VAL = AddHUDTextElement_Pos("WPN_MAV_1_MAVTYPE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 12}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -----------------------------------------------------------
WPN_MAV_2_MSL = AddHUDTextElement_Pos_Val("WPN_MAV_2_MSL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MSL/RDR ALT")
WPN_MAV_2_MSL.isdraw = true

WPN_MAV_2_MSL_VAL = AddHUDTextElement_Pos("WPN_MAV_2_MSL_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 22}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
WPN_MAV_2_MSL_VAL.formats = {"%d/%d", ""}				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_STATION = AddHUDTextElement_Pos_Val("WPN_MAV_1_STATION",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " STATION")
WPN_MAV_1_STATION.isdraw = true

WPN_MAV_1_STATION_VAL = AddHUDTextElement_Pos("WPN_MAV_1_STATION_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 13}},  
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
 -- 2 ----------------------------------------------------------- 
WPN_MAV_2_MAGTRUEHDG = AddHUDTextElement_Pos_Val("WPN_MAV_2_MAGTRUEHDG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAG/TRUE HDG")
WPN_MAV_2_MAGTRUEHDG.isdraw = true

WPN_MAV_2_MAGTRUEHDG_VAL = AddHUDTextElement_Pos("WPN_MAV_2_MAGTRUEHDG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 23}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_MAV_2_MAGTRUEHDG_VAL.formats = {"%.1f/%.1f", ""}				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_MINALT = AddHUDTextElement_Pos_Val("WPN_MAV_1_MINALT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN ALT")
WPN_MAV_1_MINALT.isdraw = true

WPN_MAV_1_MINALT_VAL = AddHUDTextElement_Pos("WPN_MAV_1_MINALT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 14}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -----------------------------------------------------------				  
WPN_MAV_2_SLANTRNG = AddHUDTextElement_Pos_Val("WPN_MAV_2_SLANTRNG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SLANT RNG")
WPN_MAV_2_SLANTRNG.isdraw = true

WPN_MAV_2_SLANTRNG_VAL = AddHUDTextElement_Pos("WPN_MAV_2_SLANTRNG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 24}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_BOREUPRT = AddHUDTextElement_Pos_Val("WPN_MAV_1_BOREUPRT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BORE UP/RT")
WPN_MAV_1_BOREUPRT.isdraw = true

WPN_MAV_1_BOREUPRT_VAL = AddHUDTextElement_Pos("WPN_MAV_1_BOREUPRT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 15}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -----------------------------------------------------------
WPN_MAV_2_HATSCE = AddHUDTextElement_Pos_Val("WPN_MAV_2_HATSCE",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HAT/SCE")
WPN_MAV_2_HATSCE.isdraw = true

WPN_MAV_2_HATSCE_VAL = AddHUDTextElement_Pos("WPN_MAV_2_HATSCE_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 25}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_MAV_2_HATSCE_VAL.formats = {"%d/BARO", "%d/RADAR", "%d/DELTA", ""}	
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_TGTELV = AddHUDTextElement_Pos_Val("WPN_MAV_1_TGTELV",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT ELV")
WPN_MAV_1_TGTELV.isdraw = true

WPN_MAV_1_TGTELV_VAL = AddHUDTextElement_Pos("WPN_MAV_1_TGTELV_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 1},{"HUD_TEST_WpnRel_MAV_data", 16}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 -----------------------------------------------------------				  
WPN_MAV_2_MAVAZEL = AddHUDTextElement_Pos_Val("WPN_MAV_2_MAVAZEL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAV AZ/EL")
WPN_MAV_2_MAVAZEL.isdraw = true

WPN_MAV_2_MAVAZEL_VAL = AddHUDTextElement_Pos("WPN_MAV_2_MAVAZEL_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 26}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY 

-- 2 -----------------------------------------------------------
WPN_MAV_2_G = AddHUDTextElement_Pos_Val("WPN_MAV_2_G",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " G")
WPN_MAV_2_G.isdraw = true

WPN_MAV_2_G_VAL = AddHUDTextElement_Pos("WPN_MAV_2_G_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_MAV_data", 27}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
WPN_MAV_2_G_VAL.formats = {"%.2f", ""}
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_MAV_1_NEXT_PAGE",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_MAV_1_NEXT_PAGE.isdraw = true

-- 2 -----------------------------------------------------------				  
WPN_MAV_2_TGTLAT = AddHUDTextElement_Pos_Val("WPN_MAV_2_TGTLAT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LAT")
WPN_MAV_2_TGTLAT.isdraw = true

WPN_MAV_2_TGTLAT_VAL = AddHUDTextElement_Pos("WPN_MAV_2_TGTLAT_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 0,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
WPN_MAV_2_TGTLAT_VAL.formats = {"%c %.2d %.2d.%.3d", ""}				  
				  
PosY = PosY + TestModeDeltaPosY 
-- 1 -----------------------------------------------------------
WPN_MAV_1_EXIT = AddHUDTextElement_Pos_Val("WPN_MAV_1_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_MAV_1_EXIT.isdraw = true
-- 2 -----------------------------------------------------------
WPN_MAV_2_TGTLONG = AddHUDTextElement_Pos_Val("WPN_MAV_2_TGTLONG",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LONG")
WPN_MAV_2_TGTLONG.isdraw = true

WPN_MAV_2_TGTLONG_VAL = AddHUDTextElement_Pos("WPN_MAV_2_TGTLONG_VAL",
				  {{"HUD_TEST_WpnRel_CCP_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 1,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  	  
WPN_MAV_2_TGTLONG_VAL.formats = {"%c %.3d %.2d.%.3d", ""}	
			
PosY = PosY + TestModeDeltaPosY*2.0

WPN_MAV_2_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_MAV_2_NEXT_PAGE",
				   {{"HUD_TEST_WpnRel_CCP_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_MAV_2_NEXT_PAGE.isdraw = true

PosY = PosY + TestModeDeltaPosY

WPN_MAV_2_EXIT = AddHUDTextElement_Pos_Val("WPN_MAV_2_EXIT",
				  {{"HUD_TEST_WpnRel_CCP_page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_MAV_2_EXIT.isdraw = true