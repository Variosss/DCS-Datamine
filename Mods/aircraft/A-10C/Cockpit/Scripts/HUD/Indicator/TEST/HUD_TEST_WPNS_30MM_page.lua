dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
Header30MM = AddHUDTextElement_Pos_Val("Header30MM", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 30 MM")
--Header30MM.h_clip_relation = h_clip_relations.NULL
Header30MM.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
AMMO_TYPE = AddHUDTextElement_Pos_Val("AMMO_TYPE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AMMO TYPE")
--AMMO_TYPE.h_clip_relation = h_clip_relations.NULL
AMMO_TYPE.isdraw = true

AMMO_TYPE_CM = AddHUDTextElement_Pos_Val("AMMO_TYPE_CM",
				  {{"HUD_TEST_30MM_TYPE_EDITED", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "CM")
				  
AMMO_TYPE_HEI = AddHUDTextElement_Pos_Val("AMMO_TYPE_HEI",
				  {{"HUD_TEST_30MM_TYPE_EDITED", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "HEI")		
				  
AMMO_TYPE_TP = AddHUDTextElement_Pos_Val("AMMO_TYPE_TP", 
				  {{"HUD_TEST_30MM_TYPE_EDITED", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "TP")
				  
--AMMO_TYPE_TP.h_clip_relation = h_clip_relations.NULL


--AMMO_TYPE_CM.h_clip_relation = h_clip_relations.NULL


--AMMO_TYPE_HEI.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
AMMO_MFG = AddHUDTextElement_Pos_Val("AMMO_MFG", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AMMO MFG")
--AMMO_MFG.h_clip_relation = h_clip_relations.NULL
AMMO_MFG.isdraw = true

AMMO_MFG_AVE = AddHUDTextElement_Pos_Val("AMMO_MFG_AVE",
				  {{"HUD_TEST_30MM_MFG_TYPE", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "AVE")
--AMMO_MFG_AVE.h_clip_relation = h_clip_relations.NULL

AMMO_MFG_OLIN = AddHUDTextElement_Pos_Val("AMMO_MFG_OLIN",
				  {{"HUD_TEST_30MM_MFG_TYPE", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "OLIN")
--AMMO_MFG_OLIN.h_clip_relation = h_clip_relations.NULL

AMMO_MFG_ALLT = AddHUDTextElement_Pos_Val("AMMO_MFG_ALLT",
				  {{"HUD_TEST_30MM_MFG_TYPE", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "ALLT")
--AMMO_MFG_ALLT.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
PAC1_POS_MODE = AddHUDTextElement_Pos_Val("PAC1_POS_MODE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PAC1 POS MODE")
--PAC1_POS_MODE.h_clip_relation = h_clip_relations.NULL
PAC1_POS_MODE.isdraw = true

PAC1_POS_MODE_N = AddHUDTextElement_Pos_Val("PAC1_POS_MODE_N",
				  {{"HUD_TEST_30MM_PAC1_POS_MODE", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--PAC1_POS_MODE_N.h_clip_relation = h_clip_relations.NULL

PAC1_POS_MODE_Y = AddHUDTextElement_Pos_Val("PAC1_POS_MODE_Y",
				  {{"HUD_TEST_30MM_PAC1_POS_MODE", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--PAC1_POS_MODE_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
MIN_ALT = AddHUDTextElement_Pos_Val("MIN_ALT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN ALT")
--MIN_ALT.h_clip_relation = h_clip_relations.NULL
MIN_ALT.isdraw = true

MIN_ALT_VAL = AddHUDTextElement_Pos("MIN_ALT_VAL", 
				  {{"HUD_TEST_30MM_MIN_ALT"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--MIN_ALT_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
RNDS = AddHUDTextElement_Pos_Val("RNDS", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RNDS")
--RNDS.h_clip_relation = h_clip_relations.NULL
RNDS.isdraw = true

RNDS_VAL = AddHUDTextElement_Pos("RNDS_VAL", 
				  {{"HUD_TEST_30MM_RNDS"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--RNDS_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
RNDS_RESET = AddHUDTextElement_Pos_Val("RNDS_RESET", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RNDS RESET")
--RNDS_RESET.h_clip_relation = h_clip_relations.NULL
RNDS_RESET.isdraw = true

PosY = PosY + TestModeDeltaPosY
STORE = AddHUDTextElement_Pos_Val("STORE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " STORE")
--STORE.h_clip_relation = h_clip_relations.NULL
STORE.isdraw = true
