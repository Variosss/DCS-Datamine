dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderMAN_RTY = AddHUDTextElement_Pos_Val("HeaderMAN_RTY", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAN RTY")
--HeaderMAN_RTY.h_clip_relation = h_clip_relations.NULL
HeaderMAN_RTY.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
RTY_WNGSPN = AddHUDTextElement_Pos_Val("RTY_WNGSPN",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RTY WNGSPN")
--RTY_WNGSPN.h_clip_relation = h_clip_relations.NULL
RTY_WNGSPN.isdraw = true

RTY_WNGSPN_VAL = AddHUDTextElement_Pos("RTY_WNGSPN_VAL", 
				  {{"HUD_TEST_Wngspn", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--RTY_WNGSPN_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
RTY_LENGTH = AddHUDTextElement_Pos_Val("RTY_LENGTH",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RTY LENGTH")
--RTY_LENGTH.h_clip_relation = h_clip_relations.NULL
RTY_LENGTH.isdraw = true

RTY_LENGTH_VAL = AddHUDTextElement_Pos("RTY_LENGTH_VAL", 
				  {{"HUD_TEST_Length", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--RTY_LENGTH_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
RTY_TGTSPEED = AddHUDTextElement_Pos_Val("RTY_TGTSPEED",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RTY TGTSPEED")
--RTY_TGTSPEED.h_clip_relation = h_clip_relations.NULL
RTY_TGTSPEED.isdraw = true

RTY_TGTSPEED_VAL = AddHUDTextElement_Pos("RTY_TGTSPEED_VAL", 
				  {{"HUD_TEST_Tgtspeed", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--RTY_TGTSPEED_VAL.h_clip_relation = h_clip_relations.NULL

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

PosY = PosY + TestModeDeltaPosY
CANCEL = AddHUDTextElement_Pos_Val("CANCEL",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CANCEL")
--CANCEL.h_clip_relation = h_clip_relations.NULL
CANCEL.isdraw = true
