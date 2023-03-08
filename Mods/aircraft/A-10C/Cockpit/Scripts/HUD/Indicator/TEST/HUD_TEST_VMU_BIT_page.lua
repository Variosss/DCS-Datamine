dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")
dofile(LockOn_Options.script_path.."IFFCC/IFFCC_BIT_modes.lua")

PosY = TestModeInitPosY
HeaderVMU_BIT = AddHUDTextElement_Pos_Val("HeaderVMU_BIT", 
				   {{"HUD_TEST_Bit_test_draw",A10C_VMU_TEST_START,A10C_VMU_TEST_RUN,A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VMU BIT")
HeaderVMU_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY*2

VMU_TESTING_RUN = AddHUDTextElement_Pos_Val("VMU_TESTING_RUN", 
				 {{"HUD_TEST_Bit_test_draw",A10C_VMU_TEST_START,A10C_VMU_TEST_RUN}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING")
VMU_TESTING_RUN.isdraw = true

VMU_TESTING_COMPLETE = AddHUDTextElement_Pos_Val("VMU_TESTING_COMPLETE", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING COMPLETE")
VMU_TESTING_COMPLETE.isdraw = true

PosY = PosY + TestModeDeltaPosY*2

VMU_CODE_1501 = AddHUDTextElement_Pos_Val("VMU_CODE_1501", 
				  {{"HUD_TEST_Bit_test_draw",A10C_VMU_TEST_START,A10C_VMU_TEST_RUN}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 1501")			
VMU_CODE_1501.isdraw = true

				  
VMU_NO_FAILURES_FOUND = AddHUDTextElement_Pos_Val("VMU_NO_FAILURES_FOUND", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO FAILURES FOUND")
VMU_NO_FAILURES_FOUND.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2

MONITOR_VMU = AddHUDTextElement_Pos_Val("MONITOR_VMU", 
				  {{"HUD_TEST_Bit_test_draw",A10C_VMU_TEST_RUN}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MONITOR VMU MESSAGES")
MONITOR_VMU.isdraw = true	


PosY = PosY + TestModeDeltaPosY * 2
EXIT = AddHUDTextElement_Pos_Val("EXIT_VMU", 
				   {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
EXIT.isdraw = true

Cursor = AddHUDTextElement_Pos_Val("HUD_TEST_VMU_Cursor", 
				  {{"HUD_TEST_CursorPos", TestModeDeltaPosY},{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE} }, 
				  {TestModePosX - 4.3,
				   TestModeInitPosY + TestModeDeltaPosY * 2.0, 0.0},
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  ">")

				


