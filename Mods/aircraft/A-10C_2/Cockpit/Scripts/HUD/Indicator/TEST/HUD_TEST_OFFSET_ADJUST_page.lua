dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
Header_OFFSET_ADJUST = AddHUDTextElement_Pos_Val("Header_OFFSET_ADJUST",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFFSET ADJUST")
--Header_OFFSET_ADJUST.h_clip_relation = h_clip_relations.NULL
Header_OFFSET_ADJUST.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
OFFSET_ADJ = AddHUDTextElement_Pos_Val("OFFSET_ADJ",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFFSET ADJ")
--OFFSET_ADJ.h_clip_relation = h_clip_relations.NULL
OFFSET_ADJ.isdraw = true

OFFSET_ADJ_N = AddHUDTextElement_Pos_Val("OFFSET_ADJ_N",
				  {{"HUD_TEST_OffsetAdj", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--OFFSET_ADJ_N.h_clip_relation = h_clip_relations.NULL

OFFSET_ADJ_Y = AddHUDTextElement_Pos_Val("OFFSET_ADJ_Y",
				  {{"HUD_TEST_OffsetAdj", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--OFFSET_ADJ_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
GUN_RT = AddHUDTextElement_Pos_Val("GUN_RT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN RT")
--GUN_RT.h_clip_relation = h_clip_relations.NULL
GUN_RT.isdraw = true

GUN_RT_VAL = AddHUDTextElement_Pos("GUN_RT_VAL", 
				  {{"HUD_TEST_GunRT"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--GUN_RT_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
GUN_UP = AddHUDTextElement_Pos_Val("GUN_UP",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GUN UP")
--GUN_UP.h_clip_relation = h_clip_relations.NULL
GUN_UP.isdraw = true

GUN_UP_VAL = AddHUDTextElement_Pos("GUN_UP_VAL",
				  {{"HUD_TEST_GunUP"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--GUN_UP_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
BOMB_RT = AddHUDTextElement_Pos_Val("BOMB_RT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BOMB RT")
--BOMB_RT.h_clip_relation = h_clip_relations.NULL
BOMB_RT.isdraw = true

BOMB_RT_VAL = AddHUDTextElement_Pos("BOMB_RT_VAL",
				  {{"HUD_TEST_BombRT"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--BOMB_RT_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
BOMB_UP = AddHUDTextElement_Pos_Val("BOMB_UP",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BOMB UP")
--BOMB_UP.h_clip_relation = h_clip_relations.NULL
BOMB_UP.isdraw = true

BOMB_UP_VAL = AddHUDTextElement_Pos("BOMB_UP_VAL",
				  {{"HUD_TEST_BombUP"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--BOMB_UP_VAL.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
EXIT = AddHUDTextElement_Pos_Val("EXIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
--EXIT.h_clip_relation = h_clip_relations.NULL
EXIT.isdraw = true
