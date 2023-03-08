---------------------
-- EHSD Page       --
-- Navigation      --
-- TACAN Mode      --
---------------------
local	EHSD_Scale = 0.5 * GetHalfHeight()
local	EHSD_Line_Thickness		= stroke_thickness * 3.5
local	EHSD_Line_OL_Thickness	= DMC_outline_thickness * 3.5

-- Symbols Centers
local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"EHSD_Compass_Rose_Center", -0.05}}
Add_MPCD_Element(MPCD_center)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "TCN_BRG_Center"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_EHSI"}, {"nav_tcn_brg_ptr"}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "TCN_RADIAL_Center"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_EHSI"}, {"nav_tcn_rad_ptr"}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "TCN_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_EHSI"}, {"nav_tcn_pos", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "TCN_Offset_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_EHSI"}, {"nav_tcn_os_pos", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)


-- TACAN Data
local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_brg_deg_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.80), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_brg_deg"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.80), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_rng_nm_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_rng_nm"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_ttg_ms_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(-0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "tcn_ttg_ms"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(-0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"EHSD_NAV_Mode"}, {"nav_tcn_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

-- TACAN Stations
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tcn_brg_ind_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.parent_element	= "TCN_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tcn_brg_ind"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.parent_element	= "TCN_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tcn_os_brg_ind_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tcn_os_brg_ind"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
AddMPCDStrokeSymbol(EHSD_Symbol)

-- TACAN NEEDLES
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_tcn_brg_ind_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, PosY(0.90), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_brg_pointer"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "TCN_BRG_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_tcn_brg_ind"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, PosY(0.90), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tacan_brg_pointer"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "TCN_BRG_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_tcn_radial_ind_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, PosY(0.90), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tcn_radial_ptr"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "TCN_RADIAL_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_tcn_radial_ind"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, PosY(0.90), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "tcn_radial_ptr"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "TCN_RADIAL_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- Course Line
for i = 1,10 do --Max tick marks in any mode
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "tcn_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "TCN_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_TCN"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "tcn_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "TCN_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_TCN"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "tos_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "TCN_Offset_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_TOS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "tos_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "TCN_Offset_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_TOS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
end

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tcn_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_TCN"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tcn_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_TCN"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tcn_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_TCN"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tcn_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_TCN"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

--

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tos_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_TOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tos_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_TOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tos_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_TOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tos_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "TCN_Offset_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_TOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

