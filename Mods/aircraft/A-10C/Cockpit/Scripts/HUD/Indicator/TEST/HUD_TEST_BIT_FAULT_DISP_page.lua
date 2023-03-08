dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderBIT_FAULTS = AddHUDTextElement_Pos_Val("HeaderBIT_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BIT FAULTS")
--HeaderBIT_FAULTS.h_clip_relation = h_clip_relations.NULL
HeaderBIT_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2
LRU1_FAULTS = AddHUDTextElement_Pos_Val("LRU1_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO LRU     0000  0000  0000")
--LRU1_FAULTS.h_clip_relation = h_clip_relations.NULL
LRU1_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY
LRU2_FAULTS = AddHUDTextElement_Pos_Val("LRU2_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO LRU     0000  0000  0000")
--LRU2_FAULTS.h_clip_relation = h_clip_relations.NULL
LRU2_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY
LRU3_FAULTS = AddHUDTextElement_Pos_Val("LRU3_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO LRU     0000  0000  0000")
--LRU3_FAULTS.h_clip_relation = h_clip_relations.NULL
LRU3_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY
LRU4_FAULTS = AddHUDTextElement_Pos_Val("LRU4_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO LRU     0000  0000  0000")
--LRU4_FAULTS.h_clip_relation = h_clip_relations.NULL
LRU4_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY
LRU5_FAULTS = AddHUDTextElement_Pos_Val("LRU5_FAULTS", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO LRU     0000  0000  0000")
--LRU5_FAULTS.h_clip_relation = h_clip_relations.NULL
LRU5_FAULTS.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2
MASTER = AddHUDTextElement_Pos_Val("MASTER", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MASTER")
--MASTER.h_clip_relation = h_clip_relations.NULL
MASTER.isdraw = true

BIT_Option_Master = AddHUDTextElement_Pos_Val("BIT_Option_Master",
				  {{"HUD_TEST_BIT_Option", 0}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_Option_Master.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
SLAVE = AddHUDTextElement_Pos_Val("SLAVE", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SLAVE")
--SLAVE.h_clip_relation = h_clip_relations.NULL
SLAVE.isdraw = true

BIT_Option_Slave = AddHUDTextElement_Pos_Val("BIT_Option_Slave",
				  {{"HUD_TEST_BIT_Option", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_Option_Slave.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
PRES_FLT = AddHUDTextElement_Pos_Val("PRES_FLT", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PRES FLT")
--PRES_FLT.h_clip_relation = h_clip_relations.NULL
PRES_FLT.isdraw = true

BIT_FlightN_PRES = AddHUDTextElement_Pos_Val("BIT_FlightN_PRES",
				  {{"HUD_TEST_BIT_FlightN", 0}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_FlightN_PRES.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
PREV_FLT = AddHUDTextElement_Pos_Val("PREV_FLT",
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PREV FLT")
--PREV_FLT.h_clip_relation = h_clip_relations.NULL
PREV_FLT.isdraw = true

BIT_FlightN_PREV = AddHUDTextElement_Pos_Val("BIT_FlightN_PREV",
				  {{"HUD_TEST_BIT_FlightN", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_FlightN_PREV.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
SECOND_PREV_FLT = AddHUDTextElement_Pos_Val("SECOND_PREV_FLT",
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 2ND PREV FLT")
--SECOND_PREV_FLT.h_clip_relation = h_clip_relations.NULL
SECOND_PREV_FLT.isdraw = true

BIT_FlightN_2ND_PREV = AddHUDTextElement_Pos_Val("BIT_FlightN_2ND_PREV",
				  {{"HUD_TEST_BIT_FlightN", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_FlightN_2ND_PREV.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
BIT_CLEAR = AddHUDTextElement_Pos_Val("BIT_CLEAR",
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BIT CLEAR")
--BIT_CLEAR.h_clip_relation = h_clip_relations.NULL
BIT_CLEAR.isdraw = true

BIT_CLEAR_OPT_Y = AddHUDTextElement_Pos_Val("BIT_CLEAR_OPT_Y", 
				  {{"HUD_TEST_BIT_ToClearFaults", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--BIT_CLEAR_OPT_Y.h_clip_relation = h_clip_relations.NULL

BIT_CLEAR_OPT_N = AddHUDTextElement_Pos_Val("BIT_CLEAR_OPT_N",
				  {{"HUD_TEST_BIT_ToClearFaults", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--BIT_CLEAR_OPT_N.h_clip_relation = h_clip_relations.NULL

BIT_CLEAR_AST_BITCLRD = AddHUDTextElement_Pos_Val("BIT_CLEAR_AST_BITCLRD",
				  {{"HUD_TEST_BIT_FaultsCleared", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--BIT_CLEAR_AST_BITCLRD.h_clip_relation = h_clip_relations.NULL

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
