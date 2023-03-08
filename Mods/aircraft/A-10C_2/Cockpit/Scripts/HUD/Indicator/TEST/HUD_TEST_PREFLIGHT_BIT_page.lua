dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")
dofile(LockOn_Options.script_path.."IFFCC/IFFCC_BIT_modes.lua")

PosY = TestModeInitPosY
HeaderPREFLIGHT_BIT = AddHUDTextElement_Pos_Val("HeaderPREFLIGHT_BIT", 
				   {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_START,A10C_PREFLIGHT_TEST_B1,A10C_PREFLIGHT_TEST_C1_1,A10C_PREFLIGHT_TEST_C1_2,
				   A10C_PREFLIGHT_TEST_40,A10C_PREFLIGHT_TEST_50,A10C_PREFLIGHT_TEST_80,A10C_GCAS_TEST_4,A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3,A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " PREFLIGHT BIT")
--HeaderPREFLIGHT_BIT.h_clip_relation = h_clip_relations.NULL
HeaderPREFLIGHT_BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY*2

TESTING_RUN = AddHUDTextElement_Pos_Val("TESTING_RUN", 
				 {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_START,A10C_PREFLIGHT_TEST_B1,A10C_PREFLIGHT_TEST_C1_1,A10C_PREFLIGHT_TEST_C1_2,
											 A10C_PREFLIGHT_TEST_40,A10C_PREFLIGHT_TEST_50,A10C_PREFLIGHT_TEST_80,A10C_GCAS_TEST_4,
											 A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING")
--LRU1_FAULTS.h_clip_relation = h_clip_relations.NULL
TESTING_RUN.isdraw = true

TESTING_COMPLETE = AddHUDTextElement_Pos_Val("TESTING_COMPLETE", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TESTING COMPLETE")
--LRU1_FAULTS.h_clip_relation = h_clip_relations.NULL
TESTING_COMPLETE.isdraw = true

PosY = PosY + TestModeDeltaPosY*2
	
CODE_A0B1 = AddHUDTextElement_Pos_Val("CODE_A0B1", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_B1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A0B1")			
CODE_A0B1.isdraw = true

CODE_A0C1 = AddHUDTextElement_Pos_Val("CODE_A0C1", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_C1_1,A10C_PREFLIGHT_TEST_C1_2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A0C1")			
CODE_A0C1.isdraw = true

CODE_A040 = AddHUDTextElement_Pos_Val("CODE_A040", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_40}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A040")			
CODE_A040.isdraw = true

CODE_A050 = AddHUDTextElement_Pos_Val("CODE_A050", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_50}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A050")			
CODE_A050.isdraw = true

CODE_A080 = AddHUDTextElement_Pos_Val("CODE_A080", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_80}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A080")			
CODE_A080.isdraw = true

CODE_3004 = AddHUDTextElement_Pos_Val("CODE_3004", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_4}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3004")			
CODE_3004.isdraw = true

CODE_3005 = AddHUDTextElement_Pos_Val("CODE_3005", 
				  {{"HUD_TEST_Bit_test_draw",A10C_GCAS_TEST_5_1,A10C_GCAS_TEST_5_2,A10C_GCAS_TEST_5_3}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3005")			
CODE_3005.isdraw = true

				  
NO_FAILURES_FOUND = AddHUDTextElement_Pos_Val("NO_FAILURES_FOUND", 
				  {{"HUD_TEST_Bit_test_draw",A10C_BIT_TESTS_COMPLETE}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO FAILURES FOUND")
--EXIT.h_clip_relation = h_clip_relations.NULL
NO_FAILURES_FOUND.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2

CENTER_YAW_TRIM = AddHUDTextElement_Pos_Val("CENTER_YAW_TRIM", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_START},{"HUD_TEST_Bit_test_blink", 0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CENTER YAW TRIM AND PRESS T.O. TRIM")
CENTER_YAW_TRIM.isdraw = true	

CAUTION_LIGHT = AddHUDTextElement_Pos_Val("CAUTION_LIGHT", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_B1},{"HUD_TEST_Bit_test_blink", 0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CAUTION LIGHT: OBSERVE CAP LIGHTS ON")
CAUTION_LIGHT.isdraw = true	

SAS_ENGAGE = AddHUDTextElement_Pos_Val("SAS_ENGAGE", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_C1_2},{"HUD_TEST_Bit_test_blink", 0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SAS: ENGAGE SAS SWITCHES")
SAS_ENGAGE.isdraw = true	

LASTE_SET_EAC = AddHUDTextElement_Pos_Val("LASTE_SET_EAC", 
				  {{"HUD_TEST_Bit_test_draw",A10C_PREFLIGHT_TEST_C1_1},{"HUD_TEST_Bit_test_blink", 0.1667}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " LASTE: SET EAC SW IN ARM")
LASTE_SET_EAC.isdraw = true	

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


Cursor = AddHUDTextElement_Pos_Val("HUD_TEST_Preflight_Cursor", 
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
				


