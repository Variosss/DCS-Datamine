dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderIFFALERT = AddHUDTextElement_Pos_Val("HeaderIFFALERT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " IFF ALERT")
HeaderIFFALERT.isdraw = true

-- MODE 1
PosY = PosY + TestModeDeltaPosY * 2.0
MODE_1= AddHUDTextElement_Pos_Val("MODE_1", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MODE 1")
MODE_1.isdraw = true

MODE_1_opt_NO = AddHUDTextElement_Pos_Val("MODE_1_opt_NO", 
				  {{"HUD_TEST_IFFalertmode", 1, 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")

MODE_1_opt_YES = AddHUDTextElement_Pos_Val("MODE_1_opt_YES", 
				  {{"HUD_TEST_IFFalertmode", 1, 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
				  
PosY = PosY + TestModeDeltaPosY 
MODE_1_START= AddHUDTextElement_Pos_Val("MODE_1_START", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "    START")
MODE_1_START.isdraw = true

MODE_1_START_val = AddHUDTextElement_Pos("MODE_1_START_val", 		
				  {{"HUD_TEST_IFFalertTime", 1, 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

PosY = PosY + TestModeDeltaPosY 
MODE_1_INTERVAL= AddHUDTextElement_Pos_Val("MODE_1_INTERVAL", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "    INTERVAL")
MODE_1_INTERVAL.isdraw = true

MODE_1_INTERVAL_val = AddHUDTextElement_Pos("MODE_1_INTERVAL_val", 
				  {{"HUD_TEST_IFFalertTime", 1, 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

-- MODE 4
PosY = PosY + TestModeDeltaPosY
MODE_4= AddHUDTextElement_Pos_Val("MODE_4", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MODE 4")
MODE_4.isdraw = true

MODE_4_opt_NO = AddHUDTextElement_Pos_Val("MODE_4_opt_NO", 
				   {{"HUD_TEST_IFFalertmode", 4, 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
				  
MODE_4_opt_YES = AddHUDTextElement_Pos_Val("MODE_4_opt_YES", 
				   {{"HUD_TEST_IFFalertmode", 4, 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")

PosY = PosY + TestModeDeltaPosY 
MODE_4_START= AddHUDTextElement_Pos_Val("MODE_4_START", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "    START")
MODE_4_START.isdraw = true

MODE_4_START_val = AddHUDTextElement_Pos("MODE_4_START_val", 
				  {{"HUD_TEST_IFFalertTime", 4, 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

PosY = PosY + TestModeDeltaPosY 
MODE_4_INTERVAL= AddHUDTextElement_Pos_Val("MODE_4_INTERVAL", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "    INTERVAL")
MODE_4_INTERVAL.isdraw = true

MODE_4_INTERVAL_val = AddHUDTextElement_Pos("MODE_4_INTERVAL_val", 
				  {{"HUD_TEST_IFFalertTime", 4, 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
---------------------------------------------------------
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
