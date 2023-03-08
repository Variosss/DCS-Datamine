dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
DELTACAL_Header = AddHUDTextElement_Pos_Val("DELTACAL_Header", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DELTA CAL")
DELTACAL_Header.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
RDR_DELTALT_opt = AddHUDTextElement_Pos_Val("RDR_DELTALT_opt", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RDR DELTA ALT")
RDR_DELTALT_opt.isdraw = true

RDR_DELTALT_opt_val = AddHUDTextElement_Pos("RDR_DELTALT_opt_val", 
				  {{"HUD_Delta_cal_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

PosY = PosY + TestModeDeltaPosY
RDR_MSLCAL_opt = AddHUDTextElement_Pos_Val("RDR_MSLCAL_opt", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RDR MSL CAL")
RDR_MSLCAL_opt.isdraw = true

RDR_MSLCAL_opt_val = AddHUDTextElement_Pos("RDR_MSLCAL_opt_val", 
				 {{"HUD_Delta_cal_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

PosY = PosY + TestModeDeltaPosY
GPS_DELTALT_opt = AddHUDTextElement_Pos_Val("GPS_DELTALT_opt", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GPS DELTA ALT")
GPS_DELTALT_opt.isdraw = true

GPS_DELTALT_opt_val = AddHUDTextElement_Pos("GPS_DELTALT_opt_val", 
				 {{"HUD_Delta_cal_opt", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
PosY = PosY + TestModeDeltaPosY
GPS_MSLCAL_opt = AddHUDTextElement_Pos_Val("GPS_MSLCAL_opt", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GPS MSL CAL")
GPS_MSLCAL_opt.isdraw = true

GPS_MSLCAL_opt_val = AddHUDTextElement_Pos("GPS_MSLCAL_opt_val", 
				  {{"HUD_Delta_cal_opt", 3}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				
PosY = PosY + TestModeDeltaPosY
DELTA_SELMODE_opt = AddHUDTextElement_Pos_Val("DELTA_SELMODE_opt", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SELECTED MODE")
DELTA_SELMODE_opt.isdraw = true

DELTA_SELMODE_opt_GPS = AddHUDTextElement_Pos_Val("DELTA_SELMODE_opt_GPS", 
				  {{"HUD_Delta_cal_opt", 4}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GPS")
				  
DELTA_SELMODE_opt_RDR = AddHUDTextElement_Pos_Val("DELTA_SELMODE_opt_RDR", 
				  {{"HUD_Delta_cal_opt", 5}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RDR")
				 
PosY = PosY + TestModeDeltaPosY
DELTA_STORE = AddHUDTextElement_Pos_Val("DELTA_STORE", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " STORE")
DELTA_STORE.isdraw = true

PosY = PosY + TestModeDeltaPosY
DELTA_CANCEL = AddHUDTextElement_Pos_Val("DELTA_CANCEL", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CANCEL")
DELTA_CANCEL.isdraw = true
