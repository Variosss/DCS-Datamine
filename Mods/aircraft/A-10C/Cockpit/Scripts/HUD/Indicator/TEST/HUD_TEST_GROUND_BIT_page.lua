dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderGND_BIT = AddHUDTextElement_Pos_Val("HeaderGND_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GROUND BIT")
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

PosY = PosY + TestModeDeltaPosY
PREFLIGHT_BIT = AddHUDTextElement_Pos_Val("PREFLIGHT_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PREFLIGHT BIT")
--PREFLIGHT_BIT.h_clip_relation = h_clip_relations.NULL
PREFLIGHT_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY
MAINT_BIT = AddHUDTextElement_Pos_Val("MAINT_BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAINT BIT - WARNING NVM INFO WILL BE LOST")
--MAINT_BIT.h_clip_relation = h_clip_relations.NULL
MAINT_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY
MAN_RALT_SW = AddHUDTextElement_Pos_Val("MAN_RALT_SW", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MANUAL RADAR ALTIMETER SWITCH")
--MAN_RALT_SW.h_clip_relation = h_clip_relations.NULL
MAN_RALT_SW.isdraw = true

PosY = PosY + TestModeDeltaPosY
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
