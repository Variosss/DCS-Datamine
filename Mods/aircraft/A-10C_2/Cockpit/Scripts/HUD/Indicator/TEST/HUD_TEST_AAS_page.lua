dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

PosY = TestModeInitPosY
HeaderAAS = AddHUDTextElement_Pos_Val("HeaderAAS", 
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " AAS")
--HeaderAAS.h_clip_relation = h_clip_relations.NULL
HeaderAAS.isdraw = true

PosY = PosY + TestModeDeltaPosY * 2.0
for i = 1, 10 do
	PreplannedThreat = AddHUDTextElement_Pos("PREPLANNED_THREAT_" .. string.format("%d", i),
					{{"HUD_TEST_AAS_Threat", i}}, 
					{TestModePosX, PosY, 0.0}, 
					nil,
					HUD_DEFAULT_LEVEL,
					"LeftCenter")
	--PreplannedThreat.h_clip_relation = h_clip_relations.NULL
	
	PreplannedThreatInRtry = AddHUDTextElement_Pos_Val("PREPLANNED_THREAT_INRTRY_" .. string.format("%d", i),
					{{"HUD_TEST_AAS_ThreatInRotary", i, 1}}, 
					{TestModePosX, PosY, 0.0}, 
					nil,
					HUD_DEFAULT_LEVEL,
					"LeftCenter",
					"o")
	--PreplannedThreatInRtry.h_clip_relation = h_clip_relations.NULL

	PosY = PosY + TestModeDeltaPosY
end

MAN_FXD = AddHUDTextElement_Pos_Val("MAN_FXD",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAN-FXD")
--MAN_FXD.h_clip_relation = h_clip_relations.NULL
MAN_FXD.isdraw = true

MAN_FXD_WasSaved = AddHUDTextElement_Pos_Val("MAN_FXD_WasSaved",
				  {{"HUD_TEST_AAS_Threat_WasSaved", 0, 1}},
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--MAN_FXD_WasSaved.h_clip_relation = h_clip_relations.NULL

PosY = PosY + TestModeDeltaPosY
MAN_RTY = AddHUDTextElement_Pos_Val("MAN_RTY",
				  nil, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  " MAN-RTY")
--MAN_RTY.h_clip_relation = h_clip_relations.NULL
MAN_RTY.isdraw = true

MAN_RTY_WasSaved = AddHUDTextElement_Pos_Val("MAN_RTY_WasSaved",
				  {{"HUD_TEST_AAS_Threat_WasSaved", 1, 1}}, 
				  {TestModePosX, PosY, 0.0}, 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  "o")
--MAN_RTY_WasSaved.h_clip_relation = h_clip_relations.NULL

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
