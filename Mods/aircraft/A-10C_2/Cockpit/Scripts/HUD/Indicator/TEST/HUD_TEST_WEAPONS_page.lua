dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderWEAPONS = AddHUDTextElement_Pos_Val("HeaderWEAPONS", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WEAPONS")
--HeaderWEAPONS.h_clip_relation = h_clip_relations.NULL
HeaderWEAPONS.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
WEAP_30MM = AddHUDTextElement_Pos_Val("WEAP_30MM", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 30MM")
--WEAP_30MM.h_clip_relation = h_clip_relations.NULL
WEAP_30MM.isdraw = true
WEAP_30MM_CM = AddHUDTextElement_Pos_Val("WEAP_30MM_CM",
				  {{"HUD_TEST_30MM_TYPE", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "CM")
				  
WEAP_30MM_HEI = AddHUDTextElement_Pos_Val("WEAP_30MM_HEI",
				  {{"HUD_TEST_30MM_TYPE", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "HEI")				  
				  
WEAP_30MM_TP = AddHUDTextElement_Pos_Val("WEAP_30MM_TP", 
				  {{"HUD_TEST_30MM_TYPE", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "TP")
--WEAP_30MM_TP.h_clip_relation = h_clip_relations.NULL


--WEAP_30MM_CM.h_clip_relation = h_clip_relations.NULL


--WEAP_30MM_HEI.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
OFFSET_ADJUST = AddHUDTextElement_Pos_Val("OFFSET_ADJUST", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFFSET ADJUST")
--OFFSET_ADJUST.h_clip_relation = h_clip_relations.NULL
OFFSET_ADJUST.isdraw = true

PosY = PosY + TestModeDeltaPosY
VAR_TGT_ELEV = AddHUDTextElement_Pos_Val("VAR_TGT_ELEV", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VAR TGT ELEV")
--VAR_TGT_ELEV.h_clip_relation = h_clip_relations.NULL
VAR_TGT_ELEV.isdraw = true

VAR_TGT_ELEV_VAL = AddHUDTextElement_Pos("VAR_TGT_ELEV_VAL", 
				  {{"HUD_TEST_VAR_TGT_ELEV"}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
--VAR_TGT_ELEV_VAL.h_clip_relation = h_clip_relations.NULL

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
