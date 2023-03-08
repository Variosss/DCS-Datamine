dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")
dofile(LockOn_Options.script_path.."IFFCC/IFFCC_BIT_modes.lua")

PosY = TestModeInitPosY
HeaderGCAS_BIT = AddHUDTextElement_Pos_Val("HeaderGCAS_BIT", 
				   {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_4,A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3,A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS BIT")
--HeaderPREFLIGHT_BIT.h_clip_relation = h_clip_relations.NULL
HeaderGCAS_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY*2

GCAS_TESTING_RUN = AddHUDTextElement_Pos_Val("GCAS_TESTING_RUN", 
				 {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_4,A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING")
--LRU1_FAULTS.h_clip_relation = h_clip_relations.NULL
GCAS_TESTING_RUN.isdraw = true

GCAS_TESTING_COMPLETE = AddHUDTextElement_Pos_Val("GCAS_TESTING_COMPLETE", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING COMPLETE")
--LRU1_FAULTS.h_clip_relation = h_clip_relations.NULL
GCAS_TESTING_COMPLETE.isdraw = true

PosY = PosY + TestModeDeltaPosY*2

GCAS_CODE_3004 = AddHUDTextElement_Pos_Val("GCAS_CODE_3004", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_4}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3004")			
GCAS_CODE_3004.isdraw = true

GCAS_CODE_3005 = AddHUDTextElement_Pos_Val("GCAS_CODE_3005", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3005")			
GCAS_CODE_3005.isdraw = true

				  
GCAS_NO_FAILURES_FOUND = AddHUDTextElement_Pos_Val("GCAS_NO_FAILURES_FOUND", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO FAILURES FOUND")
--EXIT.h_clip_relation = h_clip_relations.NULL
GCAS_NO_FAILURES_FOUND.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2

MONITOR_GCAS = AddHUDTextElement_Pos_Val("MONITOR_GCAS", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2},{"HUD_TEST_Bit_test_blink", 0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MONITOR GCAS MESSAGES")
MONITOR_GCAS.isdraw = true	

NOT_MOVE_STICK  = AddHUDTextElement_Pos_Val("NOT_MOVE_STICK", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_5_3},{"HUD_TEST_Bit_test_blink",0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DO NOT MOVE THE STICK AND RUDDER PEDAL")
NOT_MOVE_STICK.isdraw = true	

PosY = PosY + TestModeDeltaPosY * 2
EXIT = AddHUDTextElement_Pos_Val("EXIT", 
				   {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
EXIT.isdraw = true


Cursor = AddHUDTextElement_Pos_Val("HUD_TEST_GCAS_Cursor", 
				  {{"HUD_TEST_CursorPos", TestModeDeltaPosY},{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE} }, 
				  {TestModePosX - 4.3,
				   TestModeInitPosY + TestModeDeltaPosY * 2.0, 0.0},
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  ">")

addHWLine("A10C_GCAS_TEST_P_LINE", 220, 220, {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_P_LINE}} , {-110, 15.0, 0.0}, {0.0, 0.0, 0.0}, nil, HUD_DEFAULT_LEVEL)


AddHUDTexElement("Break_X_1", 
				{{-52.0, -1.0}, {-52.0, 1.0}, 
				{52.0, 1.0}, {52.0, -1.0}},
				{6.025/texture_size, 14.19/texture_size, tex_scale, tex_scale},
				{{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_CROSS},{"TEST_GCAS_Break_X", 0.1667}},
				{0.0, 0.0, 0.0},
				{45.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
				
AddHUDTexElement("Break_X_2", 
				{{-52.0, -1.0}, {-52.0, 1.0}, 
				{52.0, 1.0}, {52.0, -1.0}},
				{6.025/texture_size, 14.19/texture_size, tex_scale, tex_scale},
				nil,
				{0.0, 0.0, 0.0},
				{90.0, 0.0, 0.0},
				"Break_X_1",
				HUD_DEFAULT_LEVEL)
				


