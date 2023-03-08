-------------------
-- NAV Base Page --
-------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_page_NAV_base.lua")
dofile(hud_path.."/Global/HUD_Heading_Tape.lua")
dofile(hud_path.."/Global/HUD_TD_Base.lua")

-- SYMBOLOGY
local	STR_Symbol					= CreateElement "ceSMultiLine"
		STR_Symbol.name				= "Steerpoint_Cue"
		STR_Symbol.material			= stroke_material
		STR_Symbol.init_pos			= {0.0, 0.0 * MilToDI(HUD_SCALE), 0}
		STR_Symbol.points_set		= {"HUD_stroke_symbols", "Steerpoint_Cue"}
		STR_Symbol.parent_element	= HUD_center.name
		STR_Symbol.scale			= HUD_SCALE
		STR_Symbol.controllers 		= {{"nav_dmg_lvl_0"}, {"nav_steerpoint", HUD_SCALE}}
AddHUDStrokeSymbol(STR_Symbol)

local hud_vvm_controller = {{"nav_dmg_lvl_0"}, {"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}

-- Velocity Vector
local	hud_vvm						= CreateElement "ceSimple"
		hud_vvm.name				= "hud_vvm"
		hud_vvm.init_pos			= {0, 0.0, 0}
		hud_vvm.parent_element		= HUD_center.name
		hud_vvm.controllers			= hud_vvm_controller
AddHUDElement(hud_vvm)

local	VVM_Symbol					= CreateElement "ceSMultiLine"
		VVM_Symbol.name				= "HUD_VVM_caged"
		VVM_Symbol.material			= stroke_material
		VVM_Symbol.init_pos			= {0.0, 4.0 * MilToDI(HUD_SCALE), 0}
		VVM_Symbol.points_set		= {"HUD_stroke_symbols", "FPM"}
		VVM_Symbol.parent_element	= hud_vvm.name
		VVM_Symbol.scale			= HUD_SCALE
AddHUDStrokeSymbol(VVM_Symbol)

-- DRAW THE GHOST FPM IT NEEDS TO BE MASKED WHEN WITHIN 2 DEGREES OF THE CAGED FPM
local GhostVelVec_mask_side = DegToDI(2)
local DBG_RED = MakeMaterial(nil, {255,0,0,50})
local is_debug = false

-- Vertices
num_points = 32
step = math.rad(360.0/num_points)

local GhostVelVec_mask_vertices = {}
for i = 1, num_points do
	GhostVelVec_mask_vertices[i] = {GhostVelVec_mask_side * math.cos(i * step), GhostVelVec_mask_side * math.sin(i * step)}
end

-- Indexes
local GhostVelVec_mask_indices = {}
j = 0
for i = 0, 29 do
	j = j + 1
	GhostVelVec_mask_indices[j] = 0
	j = j + 1
	GhostVelVec_mask_indices[j] = i + 1
	j = j + 1
	GhostVelVec_mask_indices[j] = i + 2
end

-- Open Ghost FPM Region
local GhostMaskBegin            = CreateElement "ceMeshPoly"
GhostMaskBegin.name	    		= "GhostMaskBegin"
GhostMaskBegin.vertices			= GhostVelVec_mask_vertices
GhostMaskBegin.indices			= GhostVelVec_mask_indices
GhostMaskBegin.init_pos			= {0.0, 0.0, 0.0}
GhostMaskBegin.controllers		= hud_vvm_controller
GhostMaskBegin.material			= DBG_RED
GhostMaskBegin.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
GhostMaskBegin.level	        = HUD_DEFAULT_LEVEL
GhostMaskBegin.isvisible	    = is_debug
GhostMaskBegin.collimated	    = collimated
GhostMaskBegin.z_enabled        = false
GhostMaskBegin.parent_element	= HUD_center.name
Add(GhostMaskBegin)

local	VVM_GhostSymbol					= CreateElement "ceSMultiLine"
		VVM_GhostSymbol.name			= "HUD_VVM_ghost"
		VVM_GhostSymbol.material		= stroke_material
		VVM_GhostSymbol.init_pos		= {0.0, 6.0 * MilToDI(HUD_SCALE), 0}
		VVM_GhostSymbol.points_set		= {"HUD_stroke_symbols", "ghost_FPM"}
		VVM_GhostSymbol.parent_element	= HUD_center.name
		VVM_GhostSymbol.scale			= HUD_SCALE
        VVM_GhostSymbol.level	        = HUD_DEFAULT_LEVEL
		VVM_GhostSymbol.controllers 	= {{"ac_fpm_ghost", HUD_SCALE}}
AddHUDStrokeSymbol(VVM_GhostSymbol)

-- Close Ghost FPM Region
GhostMaskEnd                 = CreateElement "ceMeshPoly"
GhostMaskEnd.name	         = "GhostMaskEnd"
GhostMaskEnd.vertices	     = GhostMaskBegin.vertices
GhostMaskEnd.indices	     = GhostMaskBegin.indices
GhostMaskEnd.init_pos	     = GhostMaskBegin.init_pos
GhostMaskEnd.controllers	 = hud_vvm_controller
GhostMaskEnd.material	     = GhostMaskBegin.material
GhostMaskEnd.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
GhostMaskEnd.level	         = HUD_DEFAULT_LEVEL + 1
GhostMaskEnd.isvisible	     = is_debug
GhostMaskEnd.collimated	     = collimated
GhostMaskEnd.z_enabled       = false
GhostMaskEnd.parent_element  = GhostMaskBegin.parent_element
Add(GhostMaskEnd)

-- DIGITAL DATA LEFT
-- Ground Speed
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "GS_Label"
		Window01.material			= stroke_font
		Window01.init_pos			= {-90.0 * MilToDI(HUD_SCALE), -169.0 * MilToDI(HUD_SCALE), 0}
		Window01.value				= "S"
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"avn_dmg_lvl_0"}, {"hud_reject_2"}}
AddHUDElement(Window01)

local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "GS_Value"
		Window01.material			= stroke_font
		Window01.init_pos			= {33.0 * MilToDI(HUD_SCALE), 0, 0}
		Window01.formats			= {"%1.f"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window01.alignment			= "RightCenter"
		Window01.parent_element		= "GS_Label"
		Window01.controllers		= {{"ac_gs"}}
AddHUDElement(Window01)

-- Laser Status
local	Window01					= CreateElement "ceStringSLine"
		Window01.name				= "tpod_laser_status"
		Window01.material			= stroke_font
		Window01.init_pos			= {-80.0 * MilToDI(HUD_SCALE), -195.0 * MilToDI(HUD_SCALE), 0}
		Window01.formats			= {"%s"}
		Window01.stringdefs			= stringdefs[STROKE_FNT_DFLT_150]
		Window01.alignment			= "CenterCenter"
		Window01.parent_element		= HUD_center.name
		Window01.controllers		= {{"tpod_blinker_1hz"}, {"TPOD_Laser_Warning"}}
AddHUDElement(Window01)

-- DIGITAL DATA RIGHT
local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "VVI_FPM"
		Window02.material				= stroke_font
		Window02.init_pos				= {110.0 * MilToDI(HUD_SCALE), -143.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%1.f FPM"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "RightCenter"
		Window02.parent_element			= ADC_HUD_center.name
		Window02.controllers			= {{"hud_reject_1"}, {"ac_fpm"}}
AddHUDElement(Window02)

local	Window02						= CreateElement "ceStringSLine"
		Window02.name					= "Steerpoint_Data"
		Window02.material				= stroke_font
		Window02.init_pos				= {60.0 * MilToDI(HUD_SCALE), -156.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats				= {"%s"}
		Window02.stringdefs				= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment				= "LeftCenter"
		Window02.parent_element			= HUD_center.name
		Window02.controllers			= {{"nav_dmg_lvl_0"}, {"steerpoint_data"}}
AddHUDElement(Window02)

-- Time Data
local	TMR_HUD_center					= CreateElement "ceSimple"
		TMR_HUD_center.name				= "TMR_HUD_center"
		TMR_HUD_center.init_pos			= {0, -182.0 * MilToDI(HUD_SCALE), 0}
		TMR_HUD_center.parent_element	= HUD_center.name
		TMR_HUD_center.controllers		= {{"avn_dmg_lvl_0"}, {"hud_reject_2"}, {"timer_time_data"}}
AddHUDElement(TMR_HUD_center)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "AC_Timer_Real_Indicator"
		Window02.material			= stroke_font
		Window02.init_pos			= {60.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.value				= "R"
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= TMR_HUD_center.name
		Window02.controllers		= {{"tmr_real_selected"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "AC_Timer_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), 0, 0}
		Window02.formats			= {"%02d.%02d.%02d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= TMR_HUD_center.name
		Window02.controllers		= {{"tmr_value"}}
AddHUDElement(Window02)

local	Window02					= CreateElement "ceStringSLine"
		Window02.name				= "TTT_Value"
		Window02.material			= stroke_font
		Window02.init_pos			= {68.0 * MilToDI(HUD_SCALE), -182.0 * MilToDI(HUD_SCALE), 0}
		Window02.formats			= {"%02d.%02d.%02d"}
		Window02.stringdefs			= stringdefs[STROKE_FNT_DFLT_120]
		Window02.alignment			= "LeftCenter"
		Window02.parent_element		= ADC_HUD_center.name
		Window02.controllers		= {{"timer_cst_data"}, {"timer_cst_value"}}
AddHUDElement(Window02)

-- REJECT MODES
-- ANALOG DATA LEFT
local	Symbol01					= CreateElement "ceSMultiLine"
		Symbol01.name				= "AOA_analog_scale"
		Symbol01.material			= stroke_material
		Symbol01.init_pos			= {-50.0 * MilToDI(HUD_SCALE), -96.0 * MilToDI(HUD_SCALE), 0}
		Symbol01.points_set			= {"HUD_stroke_symbols", "AOA_analog_scale"}
		Symbol01.parent_element		= ADC_HUD_center.name
		Symbol01.scale				= HUD_SCALE
		Symbol01.controllers 		= {{"adc_dmg_lvl_0"}, {"hud_reject_11"}}
AddHUDStrokeSymbol(Symbol01)

local	Symbol01					= CreateElement "ceSMultiLine"
		Symbol01.name				= "AOA_LEFT_Indicator"
		Symbol01.material			= stroke_material
		Symbol01.init_pos			= {-40.0 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		Symbol01.points_set			= {"HUD_stroke_symbols", "LEFT_Indicator"}
		Symbol01.parent_element		= ADC_HUD_center.name
		Symbol01.scale				= HUD_SCALE
		Symbol01.controllers 		= {{"adc_dmg_lvl_0"}, {"hud_reject_11"}, {"ac_aoa_ind", 0.125 * HUD_SCALE}}
AddHUDStrokeSymbol(Symbol01)

local	aoa_zero_line					= CreateElement "ceSimpleLineObject"
		aoa_zero_line.name				= "aoa_zero_line"
		aoa_zero_line.material			= hud_line_indicators
		aoa_zero_line.width				= 1.0
		aoa_zero_line.init_pos			= {-47.5 * MilToDI(HUD_SCALE), -130.0 * MilToDI(HUD_SCALE), 0}
		aoa_zero_line.parent_element	= ADC_HUD_center.name
		aoa_zero_line.controllers		= {{"adc_dmg_lvl_0"}, {"hud_reject_11"}, {"ac_aoa_zero_line", 0.125 * HUD_SCALE}}
AddHUDElement(aoa_zero_line)

-- ANALOG DATA RIGHT
local	Symbol02					= CreateElement "ceSMultiLine"
		Symbol02.name				= "VSI_Analog_Scale"
		Symbol02.material			= stroke_material
		Symbol02.init_pos			= {50.0 * MilToDI(HUD_SCALE), -105.0 * MilToDI(HUD_SCALE), 0}
		Symbol02.points_set			= {"HUD_stroke_symbols", "VSI_Analog_Scale"}
		Symbol02.parent_element		= HUD_center.name
		Symbol02.scale				= HUD_SCALE
		Symbol02.controllers 		= {{"adc_dmg_lvl_0"}, {"hud_reject_11"}}
AddHUDStrokeSymbol(Symbol02)

local	Symbol02					= CreateElement "ceSMultiLine"
		Symbol02.name				= "VIS_RIGHT_Indicator"
		Symbol02.material			= stroke_material
		Symbol02.init_pos			= {43.0 * MilToDI(HUD_SCALE), -95.0 * MilToDI(HUD_SCALE), 0}
		Symbol02.points_set			= {"HUD_stroke_symbols", "RIGHT_Indicator"}
		Symbol02.parent_element		= ADC_HUD_center.name
		Symbol02.scale				= HUD_SCALE
		Symbol02.controllers 		= {{"adc_dmg_lvl_0"}, {"hud_reject_11"}, {"ac_fpm_ind", 0.19 * HUD_SCALE}}
AddHUDStrokeSymbol(Symbol02)