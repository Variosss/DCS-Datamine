dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderMAN_FXD = AddHUDTextElement_Pos_Val("HeaderMAN_FXD", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAN FXD")
--HeaderMAN_FXD.h_clip_relation = h_clip_relations.NULL
HeaderMAN_FXD.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
FXD_WNGSPN = AddHUDTextElement_Pos_Val("FXD_WNGSPN",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FXD WNGSPN")
--FXD_WNGSPN.h_clip_relation = h_clip_relations.NULL
FXD_WNGSPN.isdraw = true

FXD_WNGSPN_VAL = AddHUDTextElement_Pos("FXD_WNGSPN_VAL", 
				  {{"HUD_TEST_Wngspn", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--FXD_WNGSPN_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
FXD_LENGTH = AddHUDTextElement_Pos_Val("FXD_LENGTH",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FXD LENGTH")
--FXD_LENGTH.h_clip_relation = h_clip_relations.NULL
FXD_LENGTH.isdraw = true

FXD_LENGTH_VAL = AddHUDTextElement_Pos("FXD_LENGTH_VAL", 
				  {{"HUD_TEST_Length", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--FXD_LENGTH_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
FXD_TGTSPEED = AddHUDTextElement_Pos_Val("FXD_TGTSPEED",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " FXD TGTSPEED")
--FXD_TGTSPEED.h_clip_relation = h_clip_relations.NULL
FXD_TGTSPEED.isdraw = true

FXD_TGTSPEED_VAL = AddHUDTextElement_Pos("FXD_TGTSPEED_VAL", 
				  {{"HUD_TEST_Tgtspeed", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--FXD_TGTSPEED_VAL.h_clip_relation = h_clip_relations.NULL

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
