--------------------------------------------------
-- TPOD Reticles
--------------------------------------------------

local	MPCD_center					= CreateElement "ceSimple"
		MPCD_center.name			= "MPCD_center"
		MPCD_center.init_pos		= {0, 0, 0}
		MPCD_center.controllers		= {{"TPOD_is_Operational"}}
Add_MPCD_Element(MPCD_center)

-- FOV

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_narrow_fov"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "MPCD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_narrow_fov"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_fov_wide"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

-- Normal Crosshair

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_cross"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "MPCD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_cross"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_common"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_ret_mrkr"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "tpod_cross"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_mrkr_brdr"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_mrkr"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_ret_dm"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "tpod_cross"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_d_m_brdr"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_dm"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_ret_mtc"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "tpod_cross"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_mtc_brdr"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_mtc"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

-- Slaved Crosshair

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_cross_slaved"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "MPCD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_cross_slaved"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_slaved"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_ret_mrkr_slvd"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "tpod_cross_slaved"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_mrkr_brdr_slvd"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_mrkr"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "tpod_ret_dm_slvd"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "tpod_cross_slaved"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "tpod_d_m_brdr_slvd"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_dm"}}
AddMPCDStrokeSymbol(TPOD_Symbol)


-- LSS/LST Crosshair

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "lss_reticle"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "MPCD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "lss_reticle"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_ret_lst"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

-- Target Gate

local	TPOD_Symbol					= CreateElement "ceSMultiLine"
		TPOD_Symbol.name			= "lss_reticle"
		TPOD_Symbol.material		= stroke_material
		TPOD_Symbol.init_pos		= {0, 0, 0}
		TPOD_Symbol.parent_element	= "MPCD_center"
		TPOD_Symbol.points_set		= {"MPCD_stroke_symbols", "target_gate"}
		TPOD_Symbol.scale			= MPCD_STRK_SCALE
		TPOD_Symbol.controllers		= {{"tpod_tgt_gate"}}
AddMPCDStrokeSymbol(TPOD_Symbol)

