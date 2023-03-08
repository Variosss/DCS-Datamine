------------------
-- AA Base Page --
------------------
local hud_path = LockOn_Options.script_path.."HUD/indicator/"

dofile(hud_path.."HUD_page_NAV_base.lua")
dofile(hud_path.."/Global/HUD_Digital_Heading.lua")

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

-- DIGITAL DATA RIGHT
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
