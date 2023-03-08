dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
WpnRel_Header = AddHUDTextElement_Pos_Val("WpnRel_Header", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WPN REL DATA")
WpnRel_Header.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0

WpnRel_autoscroll = AddHUDTextElement_Pos_Val("WpnRel_autoscroll", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AUTO SCROLL")
				  
WpnRel_autoscroll.isdraw = true

WpnRel_autoscroll_opt_NO = AddHUDTextElement_Pos_Val("WpnRel_autoscroll_opt_NO", 
				  {{"HUD_TEST_WPNRel_autoscroll_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO")

WpnRel_autoscroll_opt_YES = AddHUDTextElement_Pos_Val("WpnRel_autoscroll_opt_YES", 
				  {{"HUD_TEST_WPNRel_autoscroll_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " YES")

PosY = PosY + TestModeDeltaPosY
WpnRel_EXIT = AddHUDTextElement_Pos_Val("WpnRel_EXIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")

WpnRel_EXIT.isdraw = true

