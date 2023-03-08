dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderGND_BIT = AddHUDTextElement_Pos_Val("HeaderGND_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " IN-FLIGHT BIT")
--HeaderGND_BIT.h_clip_relation = h_clip_relations.NULL
HeaderGND_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
GCAS_BIT = AddHUDTextElement_Pos_Val("GCAS_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS BIT")
--GCAS_BIT.h_clip_relation = h_clip_relations.NULL
GCAS_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY
VMU_BIT = AddHUDTextElement_Pos_Val("VMU_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VMU BIT")
--VMU_BIT.h_clip_relation = h_clip_relations.NULL
VMU_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY * 4
BIT_FAULT_DISPLAY = AddHUDTextElement_Pos_Val("BIT_FAULT_DISPLAY", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BIT FAULT DISPLAY")
--BIT_FAULT_DISPLAY.h_clip_relation = h_clip_relations.NULL
BIT_FAULT_DISPLAY.isdraw = true

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
