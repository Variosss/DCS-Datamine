dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
-- 1 ---------------------------------------------------------------
GCAS_1_Header = AddHUDTextElement_Pos_Val("GCAS_1_Header", 
				  {{"HUD_TEST_GCAS_Page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS - 1")
GCAS_1_Header.isdraw = true
-- 2 ---------------------------------------------------------------
GCAS_2_Header = AddHUDTextElement_Pos_Val("GCAS_2_Header", 
				  {{"HUD_TEST_GCAS_Page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS - 2")
GCAS_2_Header.isdraw = true

-- 1 ----------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY * 2.0
GCAS_1_CALLTIME = AddHUDTextElement_Pos_Val("GCAS_1_CALLTIME",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CALL/TIME")
GCAS_1_CALLTIME.isdraw = true

GCAS_1_CALLTIME_VAL = AddHUDTextElement_Pos("GCAS_1_CALLTIME_VAL", 
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
GCAS_1_CALLTIME_VAL.formats = {"%d/%s", ""}	
-- 2 ----------------------------------------------------------------	
GCAS_2_CALLTIME = AddHUDTextElement_Pos_Val("GCAS_2_CALLTIME",
				  {{"HUD_TEST_GCAS_Page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CALL/TIME")
GCAS_2_CALLTIME.isdraw = true

GCAS_2_CALLTIME_VAL = AddHUDTextElement_Pos("GCAS_2_CALLTIME_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data", 20}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")	
GCAS_2_CALLTIME_VAL.formats = {"%d/%s", ""}					  
-- 1 ----------------------------------------------------------------				  
PosY = PosY + TestModeDeltaPosY 
GCAS_1_KIAS = AddHUDTextElement_Pos_Val("GCAS_1_KIAS",
				 {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " KIAS")
GCAS_1_KIAS.isdraw = true

GCAS_1_KIAS_VAL = AddHUDTextElement_Pos("GCAS_1_KIAS_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",1}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_MINRDRALT = AddHUDTextElement_Pos_Val("GCAS_2_MINRDRALT",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MIN RDR ALT")
GCAS_2_MINRDRALT.isdraw = true

GCAS_2_MINRDRALT_VAL = AddHUDTextElement_Pos("GCAS_2_MINRDRALT_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",21}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 1 ----------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
GCAS_1_DIVE = AddHUDTextElement_Pos_Val("GCAS_1_DIVE",
				  {{"HUD_TEST_GCAS_Page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DIVE")
GCAS_1_DIVE.isdraw = true

GCAS_1_DIVE_VAL = AddHUDTextElement_Pos("GCAS_1_DIVE_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",2}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_TIMETOMAXG = AddHUDTextElement_Pos_Val("GCAS_2_TIMETOMAXG",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " TIME TO MAX G")
GCAS_2_TIMETOMAXG.isdraw = true

GCAS_2_TIMEG_VAL = AddHUDTextElement_Pos("GCAS_2_TIMEG_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",22}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 1 ----------------------------------------------------------------				  
PosY = PosY + TestModeDeltaPosY 
GCAS_1_BANK = AddHUDTextElement_Pos_Val("GCAS_1_BANK",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BANK")
GCAS_1_BANK.isdraw = true

GCAS_1_BANK_VAL = AddHUDTextElement_Pos("GCAS_1_BANK_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",3}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_MAXG = AddHUDTextElement_Pos_Val("GCAS_2_MAXG",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAX G")
GCAS_2_MAXG.isdraw = true

GCAS_2_MAXG_VAL = AddHUDTextElement_Pos("GCAS_2_MAXG_VAL", 
				   {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",23}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 1 ----------------------------------------------------------------				  
PosY = PosY + TestModeDeltaPosY 
GCAS_1_ROLL = AddHUDTextElement_Pos_Val("GCAS_1_ROLL",
				  {{"HUD_TEST_GCAS_Page", 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " ROLL RT")
GCAS_1_ROLL.isdraw = true

GCAS_1_ROLL_VAL = AddHUDTextElement_Pos("GCAS_1_ROLL_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",4}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_RECBANK = AddHUDTextElement_Pos_Val("GCAS_2_RECBANK",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RECOVERY BANK")
GCAS_2_RECBANK.isdraw = true

GCAS_2_RECBANK_VAL = AddHUDTextElement_Pos("GCAS_2_RECBANK_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",24}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
 -- 1 ----------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
GCAS_1_RDRALT = AddHUDTextElement_Pos_Val("GCAS_1_RDRALT",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RDR ALT")
GCAS_1_RDRALT.isdraw = true

GCAS_1_RDR_VAL = AddHUDTextElement_Pos("GCAS_1_RDR_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",5}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_MAXROLLRT = AddHUDTextElement_Pos_Val("GCAS_2_MAXROLLRT",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAX ROLL RT")
GCAS_2_MAXROLLRT.isdraw = true

GCAS_2_MAXROLL_VAL = AddHUDTextElement_Pos("GCAS_2_MAXROLL_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",25}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 1 ----------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
GCAS_1_GNDSLOPE = AddHUDTextElement_Pos_Val("GCAS_1_GNDSLOPE",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GND SLOPE")
GCAS_1_GNDSLOPE.isdraw = true

GCAS_1_GNDSLOPE_VAL = AddHUDTextElement_Pos("GCAS_1_GNDSLOPE_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",6}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------		
GCAS_2_RECTIME = AddHUDTextElement_Pos_Val("GCAS_2_RECTIME",
				  {{"HUD_TEST_GCAS_Page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " RECOVERY TIME")
GCAS_2_RECTIME.isdraw = true

GCAS_2_RECTIME_VAL = AddHUDTextElement_Pos("GCAS_2_RECTIME_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",26}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 1 ----------------------------------------------------------------
PosY = PosY + TestModeDeltaPosY 
GCAS_1_ACG = AddHUDTextElement_Pos_Val("GCAS_1_ACG",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " A/C G")
GCAS_1_ACG.isdraw = true

GCAS_1_G_VAL = AddHUDTextElement_Pos("GCAS_1_G_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",7}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_GNDPLANE = AddHUDTextElement_Pos_Val("GCAS_2_GNDPLANE",
				  {{"HUD_TEST_GCAS_Page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GND PLANE")
GCAS_2_GNDPLANE.isdraw = true

GCAS_2_GNDPLANE_VAL = AddHUDTextElement_Pos("GCAS_2_GNDPLANE_VAL", 
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",27}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  
-- 1 ----------------------------------------------------------------				  
PosY = PosY + TestModeDeltaPosY 
GCAS_1_VVI = AddHUDTextElement_Pos_Val("GCAS_1_VVI",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " VVI")
GCAS_1_VVI.isdraw = true
GCAS_1_VVI_VAL = AddHUDTextElement_Pos("GCAS_1_VVI_VAL",
				  {{"HUD_TEST_GCAS_Page", 1},{"HUD_TEST_GCAS_data",8}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
-- 2 ----------------------------------------------------------------
GCAS_2_CALL_S = AddHUDTextElement_Pos_Val("GCAS_2_CALL_S",
				  {{"HUD_TEST_GCAS_Page", 2}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CALL SOURCE")
GCAS_2_CALL_S.isdraw = true

GCAS_2_CALL_S_VAL = AddHUDTextElement_Pos("GCAS_2_CALL_S_VAL",
				  {{"HUD_TEST_GCAS_Page", 2},{"HUD_TEST_GCAS_data",28}}, 
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
GCAS_2_CALL_S_VAL.formats = {"DTSAS PGCAS", "IFFCC PGCAS", "IFFCC 90-FT"}

PosY = PosY + 2*TestModeDeltaPosY
-- 1 ----------------------------------------------------------------
GCAS_2_NEXT_PAGE = AddHUDTextElement_Pos_Val("GCAS_2_NEXT_PAGE",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
GCAS_2_NEXT_PAGE.isdraw = true
-- 2 ----------------------------------------------------------------
GCAS_1_NEXT_PAGE = AddHUDTextElement_Pos_Val("GCAS_1_NEXT_PAGE",
				  {{"HUD_TEST_GCAS_Page", 2}},  
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " NEXT PAGE")
GCAS_1_NEXT_PAGE.isdraw = true

PosY = PosY + TestModeDeltaPosY
-- 1 ----------------------------------------------------------------
GCAS_1_EXIT = AddHUDTextElement_Pos_Val("GCAS_1_EXIT",
				  {{"HUD_TEST_GCAS_Page", 2}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")			  
-- 2 ----------------------------------------------------------------
GCAS_2_EXIT = AddHUDTextElement_Pos_Val("GCAS_2_EXIT",
				  {{"HUD_TEST_GCAS_Page", 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " EXIT")
GCAS_2_EXIT.isdraw = true