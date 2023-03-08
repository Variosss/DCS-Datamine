dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

Cursor = AddHUDTextElement_Pos_Val("HUD_TEST_Cursor", 
				  {{"HUD_TEST_CursorPos", TestModeDeltaPosY}}, 
				  {TestModePosX - 4.3,
				   TestModeInitPosY + TestModeDeltaPosY * 2.0, 0.0},
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  ">")
--Cursor.h_clip_relation = h_clip_relations.NULL
