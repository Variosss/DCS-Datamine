-- Pitch Ladder

local LADDER_SCALE = HUD_SCALE * 0.90

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive90"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive90"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -90.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive85"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -11.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive85"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -85.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive80"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -10.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive80"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -80.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive75"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -7.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive75"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -75.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive70"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -7.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive70"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -70.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive65"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -5.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive65"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -65.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive60"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -5.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive60"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -60.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive55"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -4.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive55"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -55.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive50"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -3.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive50"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -50.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive45"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -2.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive45"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -45.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive40"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -2.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive40"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -40.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive35"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -1.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive35"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -35.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive30"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -1.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive30"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -30.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive25"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive25"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -25.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive20"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive20"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -20.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive15"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive15"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -15.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive10"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, -0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive10"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -10.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "positive05"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0, 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "positive05"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", -5.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_horizon_line				= CreateElement "ceSMultiLine"
		hud_horizon_line.name			= "hud_horizon_line"
		hud_horizon_line.material		= stroke_material
		hud_horizon_line.init_pos		= {0, -2.0 * MilToDI(HUD_SCALE), 0}
		hud_horizon_line.points_set		= {"HUD_stroke_symbols", "horizon"}
		hud_horizon_line.parent_element	= INS_HUD_center.name
		hud_horizon_line.controllers	= {{"ac_roll"}, {"ac_pitch", 0.0, HUD_SCALE}}
		hud_horizon_line.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_horizon_line)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative05"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0, 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative05"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 5.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative10"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative10"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 10.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative15"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative15"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 15.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative20"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative20"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 20.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative25"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative25"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 25.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative30"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 1.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative30"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 30.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative35"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 1.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative35"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 35.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative40"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 2.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative40"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 40.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative45"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 2.3 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative45"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 45.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative50"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 3.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative50"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 50.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative55"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 4.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative55"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 55.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative60"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 5.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative60"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 60.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative65"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 6.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative65"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 65.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative70"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 7.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative70"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 70.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative75"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 7.5 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative75"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 75.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative80"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 9.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative80"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 80.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative85"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 9.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative85"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 85.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)

local	hud_pitch_ladder				= CreateElement "ceSMultiLine"
		hud_pitch_ladder.name			= "negative90"
		hud_pitch_ladder.material		= stroke_material
		hud_pitch_ladder.init_pos		= {0, 0.0 * MilToDI(HUD_SCALE), 0}
		hud_pitch_ladder.points_set		= {"HUD_stroke_symbols", "negative90"}
		hud_pitch_ladder.parent_element	= INS_HUD_center.name
		hud_pitch_ladder.controllers	= {{"ac_roll"}, {"ac_pitch", 90.0, HUD_SCALE}}
		hud_pitch_ladder.scale			= LADDER_SCALE
AddHUDStrokeSymbol(hud_pitch_ladder)
