dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY+TestModeDeltaPosY*4
EngagePreflightBit = AddHUDTextElement_Pos_Val("EngagePreflightBit", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " ENGAGE PREFLIGHT BIT")
EngagePreflightBit.isdraw = true


EngagePreflightBit_opt_YES = AddHUDTextElement_Pos_Val("EngagePreflightBit_opt_YES", 
				  {{"HUD_TEST_EngagePreflightBit", 0}},
				  {TestOptionEngPreflPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO")

EngagePreflightBit_opt_NO = AddHUDTextElement_Pos_Val("EngagePreflightBit_opt_NO", 
				 {{"HUD_TEST_EngagePreflightBit", 1}},
				  {TestOptionEngPreflPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " YES")


