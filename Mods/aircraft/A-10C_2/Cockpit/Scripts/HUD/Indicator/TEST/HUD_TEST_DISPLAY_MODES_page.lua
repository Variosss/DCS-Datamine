dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

TestDispOptionPosX = TestModePosX + Size1FontSymbWidth * 26

PosY = TestModeInitPosY
HeaderDISPLAY_MODES = AddHUDTextElement_Pos_Val("HeaderDISPLAY_MODES", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DISPLAY MODES")
--HeaderDISPLAY_MODES.h_clip_relation = h_clip_relations.NULL
HeaderDISPLAY_MODES.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
AUTO_DATA_DISP = AddHUDTextElement_Pos_Val("AUTO_DATA_DISP", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AUTO DATA DISP")
--AUTO_DATA_DISP.h_clip_relation = h_clip_relations.NULL
AUTO_DATA_DISP.isdraw = true

AUTO_DATA_DISP_N = AddHUDTextElement_Pos_Val("AUTO_DATA_DISP_N",
				  {{"HUD_TEST_AUTO_DATA_DISP", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--AUTO_DATA_DISP_N.h_clip_relation = h_clip_relations.NULL

AUTO_DATA_DISP_2 = AddHUDTextElement_Pos_Val("AUTO_DATA_DISP_2",
				  {{"HUD_TEST_AUTO_DATA_DISP", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "2")
--AUTO_DATA_DISP_2.h_clip_relation = h_clip_relations.NULL

AUTO_DATA_DISP_Y = AddHUDTextElement_Pos_Val("AUTO_DATA_DISP_Y",
				  {{"HUD_TEST_AUTO_DATA_DISP", 2}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--AUTO_DATA_DISP_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
CCIP_GUN_CROSS_OCCULT = AddHUDTextElement_Pos_Val("CCIP_GUN_CROSS_OCCULT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP GUN CROSS OCCULT")
--CCIP_GUN_CROSS_OCCULT.h_clip_relation = h_clip_relations.NULL
CCIP_GUN_CROSS_OCCULT.isdraw = true

CCIP_GUN_CROSS_OCCULT_N = AddHUDTextElement_Pos_Val("CCIP_GUN_CROSS_OCCULT_N",
				  {{"HUD_TEST_CCIP_GUN_CROSS_OCLT", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--CCIP_GUN_CROSS_OCCULT_N.h_clip_relation = h_clip_relations.NULL

CCIP_GUN_CROSS_OCCULT_Y = AddHUDTextElement_Pos_Val("CCIP_GUN_CROSS_OCCULT_Y",
				  {{"HUD_TEST_CCIP_GUN_CROSS_OCLT", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--CCIP_GUN_CROSS_OCCULT_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
TAPES = AddHUDTextElement_Pos_Val("TAPES", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TAPES")
--TAPES.h_clip_relation = h_clip_relations.NULL
TAPES.isdraw = true

TAPES_N = AddHUDTextElement_Pos_Val("TAPES_N",
				  {{"HUD_TEST_Tapes", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--TAPES_N.h_clip_relation = h_clip_relations.NULL

TAPES_Y = AddHUDTextElement_Pos_Val("TAPES_Y",
				  {{"HUD_TEST_Tapes", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--TAPES_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
METRIC = AddHUDTextElement_Pos_Val("METRIC",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " METRIC")
--METRIC.h_clip_relation = h_clip_relations.NULL
METRIC.isdraw = true

METRIC_N = AddHUDTextElement_Pos_Val("METRIC_N",
				  {{"HUD_TEST_Metric", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--METRIC_N.h_clip_relation = h_clip_relations.NULL

METRIC_Y = AddHUDTextElement_Pos_Val("METRIC_Y",
				  {{"HUD_TEST_Metric", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--METRIC_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
RDRALT_TAPE = AddHUDTextElement_Pos_Val("RDRALT_TAPE",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RDRALT TAPE")
--RDRALT_TAPE.h_clip_relation = h_clip_relations.NULL
RDRALT_TAPE.isdraw = true

RDRALT_TAPE_N = AddHUDTextElement_Pos_Val("RDRALT_TAPE_N",
				  {{"HUD_TEST_Ralt_Tape", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--RDRALT_TAPE_N.h_clip_relation = h_clip_relations.NULL

RDRALT_TAPE_Y = AddHUDTextElement_Pos_Val("RDRALT_TAPE_Y",
				  {{"HUD_TEST_Ralt_Tape", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--RDRALT_TAPE_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
AIRSPEED = AddHUDTextElement_Pos_Val("AIRSPEED",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AIRSPEED")
--AIRSPEED.h_clip_relation = h_clip_relations.NULL
AIRSPEED.isdraw = true

AIRSPEED_IAS = AddHUDTextElement_Pos_Val("AIRSPEED_IAS",
				  {{"HUD_TEST_Airspeed", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "IAS")
--AIRSPEED_IAS.h_clip_relation = h_clip_relations.NULL

AIRSPEED_TRUE = AddHUDTextElement_Pos_Val("AIRSPEED_TRUE",
				  {{"HUD_TEST_Airspeed", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "TRUE")
--AIRSPEED_TRUE.h_clip_relation = h_clip_relations.NULL

AIRSPEED_GS = AddHUDTextElement_Pos_Val("AIRSPEED_GS",
				  {{"HUD_TEST_Airspeed", 2}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "GS")
--AIRSPEED_GS.h_clip_relation = h_clip_relations.NULL

AIRSPEED_MACH_IAS = AddHUDTextElement_Pos_Val("AIRSPEED_MACH_IAS",
				  {{"HUD_TEST_Airspeed", 3}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "MACH/IAS")
--AIRSPEED_MACH_IAS.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
VERT_VEL = AddHUDTextElement_Pos_Val("VERT_VEL",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VERT VEL")
--VERT_VEL.h_clip_relation = h_clip_relations.NULL
VERT_VEL.isdraw = true

VERT_VEL_N = AddHUDTextElement_Pos_Val("VERT_VEL_N",
				  {{"HUD_TEST_VertVel", 0}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "N")
--VERT_VEL_N.h_clip_relation = h_clip_relations.NULL

VERT_VEL_Y = AddHUDTextElement_Pos_Val("VERT_VEL_Y",
				  {{"HUD_TEST_VertVel", 1}},
				  {TestDispOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "Y")
--VERT_VEL_Y.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
IFF_ALERT = AddHUDTextElement_Pos_Val("IFF_ALERT",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " IFF ALERT")
--IFF_ALERT.h_clip_relation = h_clip_relations.NULL
IFF_ALERT.isdraw = true

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
