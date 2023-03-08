dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderMAINTENANCE= AddHUDTextElement_Pos_Val("HeaderMAINTENANCE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAINTENANCE")
HeaderMAINTENANCE.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
MAINTENANCE_SWVERSION= AddHUDTextElement_Pos_Val("MAINTENANCE_SWVERSION", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " SW VERSION")
MAINTENANCE_SWVERSION.isdraw = true

MAINTENANCE_SWVERSION_VAL = AddHUDTextElement_Pos_Val("MAINTENANCE_SWVERSION_VAL", 
				  nil, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "V3.00")
MAINTENANCE_SWVERSION_VAL.isdraw = true
-----------------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
MAINTENANCE_CHKSUM = AddHUDTextElement_Pos_Val("MAINTENANCE_CHKSUM", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CHK SUM")
MAINTENANCE_CHKSUM.isdraw = true

MAINTENANCE_CHKSUM_VAL = AddHUDTextElement_Pos_Val("MAINTENANCE_CHKSUM_VAL", 
				  nil,
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "43569176")
MAINTENANCE_CHKSUM_VAL.isdraw = true
-------------------------------------------------------------				  
PosY = PosY + TestModeDeltaPosY 
MAINTENANCE_BORESIGHT= AddHUDTextElement_Pos_Val("MAINTENANCE_BORESIGHT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BORESIGHT")
MAINTENANCE_BORESIGHT.isdraw = true

MAINTENANCE_BORESIGHT_YES = AddHUDTextElement_Pos_Val("MAINTENANCE_BORESIGHT_YES", 		
				  {{"HUD_TEST_MaintenanceBoresight", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				   "Y")
				  
MAINTENANCE_BORESIGHT_NO = AddHUDTextElement_Pos_Val("MAINTENANCE_BORESIGHT_NO", 		
				  {{"HUD_TEST_MaintenanceBoresight", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				   "N")
-----------------------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
MAINTENANCE_BORESIGHT_RT= AddHUDTextElement_Pos_Val("MAINTENANCE_BORESIGHT_RT", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RT BORESIGHT")
MAINTENANCE_BORESIGHT_RT.isdraw = true

MAINTENANCE_BORESIGHT_RT_val = AddHUDTextElement_Pos("MAINTENANCE_BORESIGHT_RT_val", 
				  {{"HUD_TEST_MaintenanceBoresightVal", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-----------------------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
MAINTENANCE_BORESIGHT_UP= AddHUDTextElement_Pos_Val("MAINTENANCE_BORESIGHT_UP", 
				  nil,
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " UP BORESIGHT")
MAINTENANCE_BORESIGHT_UP.isdraw = true

MAINTENANCE_BORESIGHT_UP_val = AddHUDTextElement_Pos("MAINTENANCE_BORESIGHT_UP_val", 
				  {{"HUD_TEST_MaintenanceBoresightVal", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

--------------------------------------------------------------------------------------
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
