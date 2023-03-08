---------------------
-- EHSD Page       --
-- Navigation      --
-- Steerpoint Mode --
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
		EHSD_Symbol_Pos.name			= "STP_BRG_Center"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_EHSI"}, {"nav_wpt_brg_ptr_WP"}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "Steerpoint_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_NOT_AWLS_Str"}, {"nav_wpt_pos_WYPT", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "Steerpoint_Offset_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_NOT_AWLS_Str"}, {"nav_wpt_pos_OSWP", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "AWLS_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"EHSD_AWLS_Steering"}, {"nav_awls_pos", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "Target_Position"
		EHSD_Symbol_Pos.parent_element	= "MPCD_center"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"ccrp_target_pos", EHSD_Scale}}
Add_MPCD_Element(EHSD_Symbol_Pos)

-- Steerpoint Data
local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_brg_deg_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_brg_deg"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.38), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%03d;"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "LeftCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_brg"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_rng_nm_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.85), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_rng_nm"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.85), PosY(0.85), 0}
		EHSD_STP_Data.formats			= {"%1.1f"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "RightCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_rng"}}
Add_MPCD_Element(EHSD_STP_Data)

--

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_ttg_ms_ol"
		EHSD_STP_Data.material			= stroke_font_outline
		EHSD_STP_Data.init_pos			= {PosX(0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

local	EHSD_STP_Data					= CreateElement "ceStringSLine"
		EHSD_STP_Data.name				= "stp_ttg_ms"
		EHSD_STP_Data.material			= stroke_font
		EHSD_STP_Data.init_pos			= {PosX(0.63), PosY(0.75), 0}
		EHSD_STP_Data.formats			= {"%d:%02d"}
		EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		EHSD_STP_Data.alignment			= "CenterCenter"
		EHSD_STP_Data.controllers		= {{"nav_wpt_valid"}, {"nav_wpt_ttg"}}
Add_MPCD_Element(EHSD_STP_Data)

-- SYMBOLS
local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_stp_brg_ind_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, PosY(0.78), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "stp_brg_ind"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "STP_BRG_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_stp_brg_ind"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, PosY(0.78), 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "stp_brg_ind"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "STP_BRG_Center"
		EHSD_Symbol.controllers		= {{"EHSD_CR_Decenter_axis", 0.0342}}
AddMPCDStrokeSymbol(EHSD_Symbol)

-- COURSE LINE TICKS
for i = 1,10 do --Max tick marks in any mode
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_wpt_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Steerpoint_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WPT"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_wpt_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Steerpoint_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WPT"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_wos_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Steerpoint_Offset_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WOS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_wos_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Steerpoint_Offset_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WOS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_awls_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "AWLS_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_AWLS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_awls_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "AWLS_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_AWLS"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
end

-- STEERPOINT SYMBOLS
local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_steerpoint_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Steerpoint_Position"
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_steerpoint"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Steerpoint_Position"
AddMPCDStrokeSymbol(EHSD_Symbol)

-- STEERPOINT OFFSET SYMBOLS

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_os_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Offset_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_os_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Offset_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_os_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Offset_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_stp_os_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Steerpoint_Offset_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WOS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_steerpoint_offset_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Steerpoint_Offset_Position"
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_steerpoint_offset"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint_offset"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Steerpoint_Offset_Position"
AddMPCDStrokeSymbol(EHSD_Symbol)

-- AWLS SYMBOLS

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_awls_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AWLS_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_AWLS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_awls_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AWLS_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_AWLS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_awls_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AWLS_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_AWLS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_awls_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "AWLS_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_AWLS"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_awls_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "AWLS_Position"
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "nav_awls"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "AWLS_Position"
AddMPCDStrokeSymbol(EHSD_Symbol)

-- TARGET SYMBOLS
local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
		EHSD_Symbol_Pos.name			= "Target_Course"
		EHSD_Symbol_Pos.parent_element	= "Target_Position"
		EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
		EHSD_Symbol_Pos.controllers		= {{"nav_tgt_steer"}}
Add_MPCD_Element(EHSD_Symbol_Pos)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tgt_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Course"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tgt_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Course"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tgt_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Course"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "nav_tgt_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Course"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

--

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tgt_steerpoint_ol"
		EHSD_Symbol.material		= stroke_material_outl
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "target_s"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Target_Position"
AddMPCDStrokeSymbol(EHSD_Symbol, true, false)

local	EHSD_Symbol					= CreateElement "ceSMultiLine"
		EHSD_Symbol.name			= "tgt_steerpoint"
		EHSD_Symbol.material		= stroke_material
		EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
		EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "target_s"}
		EHSD_Symbol.scale			= MPCD_STRK_SCALE
		EHSD_Symbol.parent_element	= "Target_Position"
AddMPCDStrokeSymbol(EHSD_Symbol)

-- TARGETPOINT SYMBOLS
local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "tgt_stp_crs_line_ol"
		EHSD_Symbol_Line.material		= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "tgt_stp_crs_arrow_ol"
		EHSD_Symbol_Line.material   	= stroke_material_outl
		EHSD_Symbol_Line.width       	= EHSD_Line_OL_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Position"
		EHSD_Symbol_Line.controllers    = {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "tgt_stp_crs_line"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Position"
		EHSD_Symbol_Line.controllers	= {{"nav_wpt_crs_line", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

local	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
		EHSD_Symbol_Line.name			= "tgt_stp_crs_arrow"
		EHSD_Symbol_Line.material   	= stroke_material
		EHSD_Symbol_Line.width       	= EHSD_Line_Thickness
		EHSD_Symbol_Line.init_pos		= {0, 0, 0}
		EHSD_Symbol_Line.parent_element	= "Target_Position"
		EHSD_Symbol_Line.controllers   	= {{"nav_crs_arrow", mpcd_steering_modes["EHSD_STR_WPT"]}}
Add_MPCD_Element(EHSD_Symbol_Line)

for i = 1,10 do --Max tick marks in any mode
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_tgt_crs_line_tick_bg_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material_outl
			EHSD_Symbol_Line.width			= EHSD_Line_OL_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Target_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WPT"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
	
	local 	EHSD_Symbol_Line				= CreateElement "ceSimpleLineObject"
			EHSD_Symbol_Line.name			= "fp_tgt_crs_line_tick_" .. string.format("%02d", i)
			EHSD_Symbol_Line.material 		= stroke_material
			EHSD_Symbol_Line.width			= EHSD_Line_Thickness
			EHSD_Symbol_Line.init_pos 		= {0, 0, 0}
			EHSD_Symbol_Line.parent_element = "Target_Position"
			EHSD_Symbol_Line.controllers 	= {{"nav_crs_tick", mpcd_steering_modes["EHSD_STR_WPT"], i}}
	Add_MPCD_Element(EHSD_Symbol_Line)
end

-- SEQ Symbols
for i = 1, 8 do
	j = i - 3
	
	if j ~= 0 then
		local	EHSD_Symbol_Pos					= CreateElement "ceSimple"
				EHSD_Symbol_Pos.name			= "Steerpoint_SEQ_Position_" .. string.format("%02d", i)
				EHSD_Symbol_Pos.parent_element	= "MPCD_center"
				EHSD_Symbol_Pos.init_pos		= {0, 0, 0}
				EHSD_Symbol_Pos.controllers		= {{"EHSD_MAP_SEQ"}, {"nav_wpt_SEQ_pos", j, EHSD_Scale}}
		Add_MPCD_Element(EHSD_Symbol_Pos)
		
		--
		
		local	EHSD_Symbol					= CreateElement "ceSMultiLine"
				EHSD_Symbol.name			= "nav_seq_steerpoint_ol_" .. string.format("%02d", i)
				EHSD_Symbol.material		= stroke_material_outl
				EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
				EHSD_Symbol.parent_element	= "Steerpoint_SEQ_Position_" .. string.format("%02d", i)
				EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
				EHSD_Symbol.scale			= MPCD_STRK_SCALE
		AddMPCDStrokeSymbol(EHSD_Symbol, true, false)
		
		local	EHSD_Symbol					= CreateElement "ceSMultiLine"
				EHSD_Symbol.name			= "nav_seq_steerpoint_" .. string.format("%02d", i)
				EHSD_Symbol.material		= stroke_material
				EHSD_Symbol.init_pos		= {0.0, 0.0, 0}
				EHSD_Symbol.parent_element	= "Steerpoint_SEQ_Position_" .. string.format("%02d", i)
				EHSD_Symbol.points_set		= {"MPCD_stroke_symbols", "steerpoint"}
				EHSD_Symbol.scale			= MPCD_STRK_SCALE
		AddMPCDStrokeSymbol(EHSD_Symbol)
		
		--
		
		local	EHSD_STP_Data					= CreateElement "ceStringSLine"
				EHSD_STP_Data.name				= "SQE_wpt_label_ol_" .. string.format("%02d", i)
				EHSD_STP_Data.material			= stroke_font_outline
				EHSD_STP_Data.init_pos			= {0.0, PosY(-0.08), 0}
				EHSD_STP_Data.parent_element	= "Steerpoint_SEQ_Position_" .. string.format("%02d", i)
				EHSD_STP_Data.formats			= {"%s"}
				EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
				EHSD_STP_Data.alignment			= "CenterCenter"
				EHSD_STP_Data.controllers		= {{"nav_wpt_SEQ_lbl", j}}
		Add_MPCD_Element(EHSD_STP_Data)
		
		local	EHSD_STP_Data					= CreateElement "ceStringSLine"
				EHSD_STP_Data.name				= "SQE_wpt_label_" .. string.format("%02d", i)
				EHSD_STP_Data.material			= stroke_font
				EHSD_STP_Data.init_pos			= {0.0, PosY(-0.08), 0}
				EHSD_STP_Data.parent_element	= "Steerpoint_SEQ_Position_" .. string.format("%02d", i)
				EHSD_STP_Data.formats			= {"%s"}
				EHSD_STP_Data.stringdefs		= stringdefs[STROKE_FNT_DFLT_120]
				EHSD_STP_Data.alignment			= "CenterCenter"
				EHSD_STP_Data.controllers		= {{"nav_wpt_SEQ_lbl", j}}
		Add_MPCD_Element(EHSD_STP_Data)
	end
end

