dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
GCAS_Header = AddHUDTextElement_Pos_Val("GCAS_Header", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS TRAINING")
GCAS_Header.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
GCAS_plane_opt = AddHUDTextElement_Pos_Val("GCAS_plane_opt", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GND PLANE")
GCAS_plane_opt.isdraw = true

GCAS_plane_opt_OFF = AddHUDTextElement_Pos_Val("GCAS_plane_opt_OFF", 
				  {{"HUD_TEST_GCAS_training_plane_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFF")

GCAS_plane_opt_2000 = AddHUDTextElement_Pos_Val("GCAS_plane_opt_2000", 
				  {{"HUD_TEST_GCAS_training_plane_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 2000")

GCAS_plane_opt_3000 = AddHUDTextElement_Pos_Val("GCAS_plane_opt_3000", 
				  {{"HUD_TEST_GCAS_training_plane_opt", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3000")

PosY = PosY + TestModeDeltaPosY
GCAS_autoscroll = AddHUDTextElement_Pos_Val("GCAS_autoscroll", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AUTO SCROLL")
				  
GCAS_autoscroll.isdraw = true

GCAS_autoscroll_opt_NO = AddHUDTextElement_Pos_Val("GCAS_autoscroll_opt_NO", 
				  {{"HUD_TEST_GCAS_training_autoscroll_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NO")

GCAS_autoscroll_opt_YES = AddHUDTextElement_Pos_Val("GCAS_autoscroll_opt_YES", 
				  {{"HUD_TEST_GCAS_training_autoscroll_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " YES")

PosY = PosY + TestModeDeltaPosY
GCAS_STORE = AddHUDTextElement_Pos_Val("GCAS_STORE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " STORE")

GCAS_STORE.isdraw = true

PosY = PosY + TestModeDeltaPosY
GCAS_CANCEL = AddHUDTextElement_Pos_Val("GCAS_CANCEL", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CANCEL")
GCAS_CANCEL.isdraw = true
