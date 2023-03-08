dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
Header = AddHUDTextElement_Pos_Val("Header", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAIN MENU        V3.00")
--Header.h_clip_relation = h_clip_relations.NULL
Header.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
CCIP_consent_opt = AddHUDTextElement_Pos_Val("CCIP_CONSENT_OPT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " CCIP CONSENT OPT")
--CCIP_consent_opt.h_clip_relation = h_clip_relations.NULL
CCIP_consent_opt.isdraw = true

CCIP_consent_opt_OFF = AddHUDTextElement_Pos_Val("CCIP_CONSENT_OPT_OFF", 
				  {{"HUD_TEST_CCIP_consent_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFF")
--CCIP_consent_opt_OFF.h_clip_relation = h_clip_relations.NULL

CCIP_consent_opt_3_9 = AddHUDTextElement_Pos_Val("CCIP_CONSENT_OPT_3_9", 
				  {{"HUD_TEST_CCIP_consent_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3/9")
--CCIP_consent_opt_3_9.h_clip_relation = h_clip_relations.NULL

CCIP_consent_opt_5_mil = AddHUDTextElement_Pos_Val("CCIP_CONSENT_OPT_5_MIL", 
				  {{"HUD_TEST_CCIP_consent_opt", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 5 MIL")
--CCIP_consent_opt_5_mil.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
BIT = AddHUDTextElement_Pos_Val("BIT", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " BIT")
--BIT.h_clip_relation = h_clip_relations.NULL
BIT.isdraw = true

PosY = PosY + TestModeDeltaPosY
AAS = AddHUDTextElement_Pos_Val("AAS", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AAS")
--AAS.h_clip_relation = h_clip_relations.NULL
AAS.isdraw = true

PosY = PosY + TestModeDeltaPosY
Weapons = AddHUDTextElement_Pos_Val("WEAPONS", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WEAPONS")
--Weapons.h_clip_relation = h_clip_relations.NULL
Weapons.isdraw = true

PosY = PosY + TestModeDeltaPosY
Wpn_rel_data = AddHUDTextElement_Pos_Val("WPN_REL_DATA", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " WPN REL DATA")
--Wpn_rel_data.h_clip_relation = h_clip_relations.NULL
Wpn_rel_data.isdraw = true

PosY = PosY + TestModeDeltaPosY
Display_modes = AddHUDTextElement_Pos_Val("DISPLAY_MODES", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DISPLAY MODES")
--Display_modes.h_clip_relation = h_clip_relations.NULL
Display_modes.isdraw = true

PosY = PosY + TestModeDeltaPosY
Maintenance = AddHUDTextElement_Pos_Val("MAINTENANCE", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAINTENANCE")
--Maintenance.h_clip_relation = h_clip_relations.NULL
Maintenance.isdraw = true

PosY = PosY + TestModeDeltaPosY
Delta_cal = AddHUDTextElement_Pos_Val("DELTA_CAL", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " DELTA CAL")
--Delta_cal.h_clip_relation = h_clip_relations.NULL
Delta_cal.isdraw = true

PosY = PosY + TestModeDeltaPosY
GCAS_training = AddHUDTextElement_Pos_Val("GCAS_TRAINING", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " GCAS TRAINING")
--GCAS_training.h_clip_relation = h_clip_relations.NULL
GCAS_training.isdraw = true

GCAS_training_opt_OFF = AddHUDTextElement_Pos_Val("GCAS_training_opt_OFF", 
				  {{"HUD_TEST_GCAS_plane_opt", 0}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " OFF")

GCAS_training_opt_2000 = AddHUDTextElement_Pos_Val("GCAS_training_opt_2000", 
				  {{"HUD_TEST_GCAS_plane_opt", 1}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 2000")

GCAS_training_opt_3000 = AddHUDTextElement_Pos_Val("GCAS_training_opt_3000", 
				  {{"HUD_TEST_GCAS_plane_opt", 2}},
				  {TestOptionPosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " 3000")
