--------------------------------------------------
-- TPOD Page: Mini HUD display
--------------------------------------------------

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MINIHUD_center"
		MPCD_center.init_pos		= {0, PosY(-0.45), 0}
		MPCD_center.controllers		= {{"TPOD_is_Operational"}, {"tpod_show_minihud"}}
Add_MPCD_Element(MPCD_center)

--------------------------------------------------
-- SYMBOLS & ICONS
--------------------------------------------------
local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "FOV_Center"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, PosY(-0.027), 0}
		TPOD_Symbol.parent_element	= "MINIHUD_center"
		TPOD_Symbol.points_set		= {"HUD_stroke_symbols", "waterline"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "Velocity_Vector"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0.0, PosY(0.0225), 0}
		TPOD_Symbol.parent_element	= "MINIHUD_center"
		TPOD_Symbol.points_set		= {"HUD_stroke_symbols", "FPM"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ac_vvm", 0.15}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "ac_attitude"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0.0, PosY(-0.035), 0}
		TPOD_Symbol.parent_element	= "Velocity_Vector"
		TPOD_Symbol.points_set		= {"HUD_stroke_symbols", "horizon"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"ac_roll"}, {"tpod_ac_att", 0.01}}
AddMPCDStrokeSymbol(TPOD_Symbol)
