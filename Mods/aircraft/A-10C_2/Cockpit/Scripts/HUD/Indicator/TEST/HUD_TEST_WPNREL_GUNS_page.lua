dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
WPN_GUNS_1_Header = AddHUDTextElement_Pos_Val("GUNS_1_Header", 
				  {{"HUD_TEST_WpnRel_Guns_page", 1, 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN - 1")
WPN_GUNS_1_Header.isdraw = true

WPN_GUNS_CCIP_1_Header = AddHUDTextElement_Pos_Val("WPN_GUNS_CCIP_1_Header", 
				  {{"HUD_TEST_WpnRel_Guns_page", 1, 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN - CCIP - 1")
WPN_GUNS_CCIP_1_Header.isdraw = true

WPN_GUNS_2_Header = AddHUDTextElement_Pos_Val("WPN_GUNS_2_Header", 
				  {{"HUD_TEST_WpnRel_Guns_page", 2, 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN - 2")
WPN_GUNS_2_Header.isdraw = true

WPN_GUNS_CCIP_2_Header = AddHUDTextElement_Pos_Val("WPN_GUNS_CCIP_2_Header", 
				  {{"HUD_TEST_WpnRel_Guns_page", 2, 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN - CCIP - 2")
WPN_GUNS_CCIP_2_Header.isdraw = true

WPN_GUNS_2_Header_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_Header_VAL", 
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 9}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_Header_VAL.formats = {"%2d/%2d/%02d", ""}

PosY = PosY + TestModeDeltaPosY * 2.0
WPN_GUNS_1_PASSTIME = AddHUDTextElement_Pos_Val("WPN_GUNS_1_PASSTIME",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PASS/TIME")
WPN_GUNS_1_PASSTIME.isdraw = true

WPN_GUNS_1_PASSTIME_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_PASSTIME_VAL", 
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_1_PASSTIME_VAL.formats = {"%d/%s", ""}		
	
WPN_GUNS_2_KIAS = AddHUDTextElement_Pos_Val("WPN_GUNS_2_KIAS",
				 {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KIAS/DIVE")
WPN_GUNS_2_KIAS.isdraw = true

WPN_GUNS_2_KIAS_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_KIAS_VAL", 
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 10}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_KIAS_VAL.formats = {"%.2f/%.2f", ""}	
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_AMMO = AddHUDTextElement_Pos_Val("WPN_GUNS_1_AMMO",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AMMO")
WPN_GUNS_1_AMMO.isdraw = true

WPN_GUNS_1_AMMO_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_AMMO_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 1}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_1_AMMO_VAL.formats = {"CM", "HEI", "TP", ""}	

WPN_GUNS_2_MSL = AddHUDTextElement_Pos_Val("WPN_GUNS_2_MSL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MSL/RDR ALT")
WPN_GUNS_2_MSL.isdraw = true

WPN_GUNS_2_MSL_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_MSL_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 11}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_PAC = AddHUDTextElement_Pos_Val("WPN_GUNS_1_PAC",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PAC")
WPN_GUNS_1_PAC.isdraw = true

WPN_GUNS_1_PAC_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_PAC_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 2}},  
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_1_PAC_VAL.formats = {"N", "Y", ""}	
  
WPN_GUNS_2_TOFOPEN = AddHUDTextElement_Pos_Val("WPN_GUNS_2_TOFOPEN",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TOF OPEN")
WPN_GUNS_2_TOFOPEN.isdraw = true

WPN_GUNS_2_TOFOPEN_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_TOFOPEN_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 12}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_TOFOPEN_VAL.formats = {"%.2f", ""}
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_OPEN = AddHUDTextElement_Pos_Val("WPN_GUNS_1_OPEN",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OPEN")
WPN_GUNS_1_OPEN.isdraw = true

WPN_GUNS_1_OPEN_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_OPEN_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 3}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
WPN_GUNS_2_PACPK = AddHUDTextElement_Pos_Val("WPN_GUNS_2_PACPK",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PAC PK/FNL")
WPN_GUNS_2_PACPK.isdraw = true

WPN_GUNS_2_PACPK_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_PACPK_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 13}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_PACPK_VAL.formats = {"%.2f/%.2f", ""}	
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_CEASE = AddHUDTextElement_Pos_Val("WPN_GUNS_1_CEASE",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CEASE")
WPN_GUNS_1_CEASE.isdraw = true

WPN_GUNS_1_CEASE_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_CEASE_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 4}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

WPN_GUNS_2_KTAS = AddHUDTextElement_Pos_Val("WPN_GUNS_2_KTAS",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KTAS")
WPN_GUNS_2_KTAS.isdraw = true

WPN_GUNS_2_KTAS_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_KTAS_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 14}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_KTAS_VAL.formats = {"%.2f", ""}
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_BURST = AddHUDTextElement_Pos_Val("WPN_GUNS_1_BURST",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BURST")
WPN_GUNS_1_BURST.isdraw = true

WPN_GUNS_1_BURST_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_BURST_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 5}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_1_BURST_VAL.formats = {"%.1f", ""}
				  
WPN_GUNS_2_HAT = AddHUDTextElement_Pos_Val("WPN_GUNS_2_HAT",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " HAT/SCE")
WPN_GUNS_2_HAT.isdraw = true

WPN_GUNS_2_HAT_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_HAT_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 15}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
WPN_GUNS_2_HAT_VAL.formats = {"%d/BARO", "%d/RADAR", "%d/DELTA", ""}	
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_RNDS = AddHUDTextElement_Pos_Val("WPN_GUNS_1_RNDS",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RNDS")
WPN_GUNS_1_RNDS.isdraw = true

WPN_GUNS_1_RNDS_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_RNDS_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 6}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

WPN_GUNS_2_G = AddHUDTextElement_Pos_Val("WPN_GUNS_2_G",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " G")
WPN_GUNS_2_G.isdraw = true

WPN_GUNS_2_G_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_G_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_Guns_data", 16}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
WPN_GUNS_2_G_VAL.formats = {"%.2f", ""}
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_MINALT = AddHUDTextElement_Pos_Val("WPN_GUNS_1_MINALT",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN ALT")
WPN_GUNS_1_MINALT.isdraw = true

WPN_GUNS_1_MINALT_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_MINALT_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 7}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
WPN_GUNS_2_TGTLAT = AddHUDTextElement_Pos_Val("WPN_GUNS_2_TGTLAT",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LAT")
WPN_GUNS_2_TGTLAT.isdraw = true

WPN_GUNS_2_TGTLAT_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_TGTLAT_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 0,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	

WPN_GUNS_2_TGTLAT_VAL.formats = {"%c %.2d %.2d.%.3d", ""}				  
				  
PosY = PosY + TestModeDeltaPosY 
WPN_GUNS_1_TGT_ELV = AddHUDTextElement_Pos_Val("WPN_GUNS_1_TGT_ELV",
				  {{"HUD_TEST_WpnRel_Guns_page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT ELV")
WPN_GUNS_1_TGT_ELV.isdraw = true

WPN_GUNS_1_TGT_ELV_VAL = AddHUDTextElement_Pos("WPN_GUNS_1_TGT_ELV_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 1},{"HUD_TEST_WpnRel_Guns_data", 8}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

WPN_GUNS_2_TGTLONG = AddHUDTextElement_Pos_Val("WPN_GUNS_2_TGTLONG",
				  {{"HUD_TEST_WpnRel_Guns_page", 2}},   
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TGT LONG")
WPN_GUNS_2_TGTLONG.isdraw = true

WPN_GUNS_2_TGTLONG_VAL = AddHUDTextElement_Pos("WPN_GUNS_2_TGTLONG_VAL",
				  {{"HUD_TEST_WpnRel_Guns_page", 2},{"HUD_TEST_WpnRel_tgt_coords", 1,0}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	  
				  
WPN_GUNS_2_TGTLONG_VAL.formats = {"%c %.3d %.2d.%.3d", ""}	
			
PosY = PosY + TestModeDeltaPosY*2.0

WPN_GUNS_1_NEXT_PAGE = AddHUDTextElement_Pos_Val("WPN_GUNS_1_NEXT_PAGE",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
WPN_GUNS_1_NEXT_PAGE.isdraw = true

PosY = PosY + TestModeDeltaPosY

WPN_GUNS_1_EXIT = AddHUDTextElement_Pos_Val("WPN_GUNS_1_EXIT",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
WPN_GUNS_1_EXIT.isdraw = true