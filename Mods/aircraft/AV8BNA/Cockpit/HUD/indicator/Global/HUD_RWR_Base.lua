---------------------
-- HUD RWR Threats --
---------------------
local DBG_RED = MakeMaterial(nil, {255,0,0,50})
local DBG_MGN = MakeMaterial(nil, {255,0,255,50})

-- Threats


for i = 1, 16 do
	local	RWR_Symbol					= CreateElement "ceSimple"
			RWR_Symbol.name				= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Symbol.init_pos			= {0, 0, 0}
			RWR_Symbol.controllers		= {{"HUD_RWR"}, {"RWR_Threat_Azimuth", i-1}, {"hud_waterline", HUD_Waterline}}
	AddHUDElement(RWR_Symbol)

	-- Symbols
	local	RWR_Symbol					= CreateElement "ceSMultiLine"
			RWR_Symbol.name				= "Threat_Lollypop_Head" .. string.format("%02d", i)
			RWR_Symbol.material			= stroke_material
			RWR_Symbol.init_pos			= {0, 0.0 * MilToDI(HUD_SCALE), 0}
			RWR_Symbol.points_set		= {"HUD_stroke_symbols", "RWR_lollypop_head"}
			RWR_Symbol.scale			= HUD_SCALE
			RWR_Symbol.parent_element	= "threat_lollypop_" .. string.format("%02d", i)
	AddHUDStrokeSymbol(RWR_Symbol)
	
	local	RWR_Symbol					= CreateElement "ceSMultiLine"
			RWR_Symbol.name				= "Threat_Lollypop_NL" .. string.format("%02d", i)
			RWR_Symbol.material			= stroke_material
			RWR_Symbol.init_pos			= {0, -18.0 * MilToDI(HUD_SCALE), 0}
			RWR_Symbol.points_set		= {"HUD_stroke_symbols", "RWR_lollypop_stem_NL"}
			RWR_Symbol.scale			= HUD_SCALE
			RWR_Symbol.parent_element	= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Symbol.controllers		= {{"RWR_Threat_NLT", i-1}}
	AddHUDStrokeSymbol(RWR_Symbol)
	
	local	RWR_Symbol					= CreateElement "ceSMultiLine"
			RWR_Symbol.name				= "Threat_Lollypop_LT" .. string.format("%02d", i)
			RWR_Symbol.material			= stroke_material
			RWR_Symbol.init_pos			= {0, -24.0 * MilToDI(HUD_SCALE), 0}
			RWR_Symbol.points_set		= {"HUD_stroke_symbols", "RWR_lollypop_stem_LT"}
			RWR_Symbol.scale			= HUD_SCALE
			RWR_Symbol.parent_element	= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Symbol.controllers		= {{"RWR_Threat_LTL", i-1}}
	AddHUDStrokeSymbol(RWR_Symbol)
	
	local	RWR_Symbol					= CreateElement "ceSMultiLine"
			RWR_Symbol.name				= "Threat_Lollypop_CT" .. string.format("%02d", i)
			RWR_Symbol.material			= stroke_material
			RWR_Symbol.init_pos			= {0, -32.0 * MilToDI(HUD_SCALE), 0}
			RWR_Symbol.points_set		= {"HUD_stroke_symbols", "RWR_lollypop_stem_CTL"}
			RWR_Symbol.scale			= HUD_SCALE
			RWR_Symbol.parent_element	= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Symbol.controllers		= {{"RWR_Threat_CTL", i-1}}
	AddHUDStrokeSymbol(RWR_Symbol)
	
	local	RWR_Symbol					= CreateElement "ceSMultiLine"
			RWR_Symbol.name				= "Threat_Lollypop_Tail" .. string.format("%02d", i)
			RWR_Symbol.material			= stroke_material
			RWR_Symbol.init_pos			= {0, -58.0 * MilToDI(HUD_SCALE), 0}
			RWR_Symbol.points_set		= {"HUD_stroke_symbols", "RWR_lollypop_tail"}
			RWR_Symbol.scale			= HUD_SCALE
			RWR_Symbol.parent_element	= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Symbol.controllers		= {{"RWR_Threat_Alert", i-1}}
	AddHUDStrokeSymbol(RWR_Symbol)
	
	-- Code
	local	RWR_Threat						= CreateElement "ceStringSLine"
			RWR_Threat.name					= "RWR_ThreatCode" .. string.format("%02d", i)
			RWR_Threat.material				= stroke_font
			RWR_Threat.init_pos				= {0, 0.0 * MilToDI(HUD_SCALE), 0}
			RWR_Threat.formats				= {"%s"}
			RWR_Threat.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
			RWR_Threat.alignment			= "CenterCenter"
			RWR_Threat.parent_element		= "threat_lollypop_" .. string.format("%02d", i)
			RWR_Threat.controllers			= {{"RWR_Threat_Code", i-1}}
	AddHUDElement(RWR_Threat)
end
