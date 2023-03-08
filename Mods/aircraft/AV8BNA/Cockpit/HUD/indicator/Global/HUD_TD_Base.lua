-- Common Target Designators (All Modes)

local	HUD_TD_center_pos					= CreateElement "ceSimple"
		HUD_TD_center_pos.name				= "HUD_TD_center_pos"
		HUD_TD_center_pos.init_pos			= {0, 0, 0}
		HUD_TD_center_pos.parent_element	= HUD_center.name
AddHUDElement(HUD_TD_center_pos)

local	hud_TD_vvm_pos						= CreateElement "ceSimple"
		hud_TD_vvm_pos.name					= "hud_TD_vvm_pos"
		hud_TD_vvm_pos.init_pos				= {0, 0.0, 0}
		hud_TD_vvm_pos.parent_element		= HUD_center.name
		hud_TD_vvm_pos.controllers			= {{"ac_vvz", HUD_SCALE}, {"ac_vvy", HUD_SCALE}}
AddHUDElement(hud_TD_vvm_pos)

local	HUD_AG_TGT_pos						= CreateElement "ceSimple"
		HUD_AG_TGT_pos.name					= "HUD_AG_TGT_pos"
		HUD_AG_TGT_pos.init_pos				= {0, 0, 0}
		HUD_AG_TGT_pos.parent_element		= HUD_center.name
		HUD_AG_TGT_pos.controllers			= {{"AG_TGT_POS", HUD_SCALE}}
AddHUDElement(HUD_AG_TGT_pos)

-- Target Steering
local	AG_TGT_OOB_steering					= CreateElement "ceSMultiLine"
		AG_TGT_OOB_steering.name			= "AG_TGT_OOB_steering"
		AG_TGT_OOB_steering.material		= stroke_material
		AG_TGT_OOB_steering.init_pos		= {0, 0, 0}
		AG_TGT_OOB_steering.points_set		= {"HUD_stroke_symbols", "TGT_Steering"}
		AG_TGT_OOB_steering.parent_element	= hud_TD_vvm_pos.name
		AG_TGT_OOB_steering.scale			= HUD_SCALE
		AG_TGT_OOB_steering.controllers		= {{"AG_TGT_steering"}}	
AddHUDStrokeSymbol(AG_TGT_OOB_steering)

-- TPOD TD
local	TPOD_TD_FOV					= CreateElement "ceSMultiLine"
		TPOD_TD_FOV.name			= "TPOD_TD_FOV"
		TPOD_TD_FOV.material		= stroke_material
		TPOD_TD_FOV.init_pos		= {0, 0, 0}
		TPOD_TD_FOV.points_set		= {"HUD_stroke_symbols", "TPOD"}
		TPOD_TD_FOV.parent_element	= HUD_TD_center_pos.name
		TPOD_TD_FOV.scale			= HUD_SCALE
		TPOD_TD_FOV.controllers		= {{"tpod_active"}, {"tpod_td_pos", HUD_SCALE}, {"bound_by_circle", RFOV_radius * GetScale()}}	
AddHUDStrokeSymbol(TPOD_TD_FOV)

local	TPOD_TD_FOV					= CreateElement "ceSMultiLine"
		TPOD_TD_FOV.name			= "TPOD_TD_SLAVED"
		TPOD_TD_FOV.material		= stroke_material
		TPOD_TD_FOV.init_pos		= {0.5 * MilToDI(HUD_SCALE), 0.5 * MilToDI(HUD_SCALE), 0}
		TPOD_TD_FOV.points_set		= {"HUD_stroke_symbols", "slideslip_ind"}
		TPOD_TD_FOV.parent_element	= "hud_TD_vvm_pos"
		TPOD_TD_FOV.scale			= HUD_SCALE
		TPOD_TD_FOV.controllers		= {{"tpod_slave_vv"}}
AddHUDStrokeSymbol(TPOD_TD_FOV)

-- INS Targets
local	AG_INS_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_INS_TGT_BOX.name				= "AG_INS_Target"
		AG_INS_TGT_BOX.material			= stroke_material
		AG_INS_TGT_BOX.init_pos			= {0, 0, 0}
		AG_INS_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond"}
		AG_INS_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_INS_TGT_BOX.scale			= HUD_SCALE
		AG_INS_TGT_BOX.controllers		= {{"ins_mode"}, {"AG_TGT_NV_Normal"}}
AddHUDStrokeSymbol(AG_INS_TGT_BOX)

local	AG_INS_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_INS_TGT_BOX.name				= "AG_INS_Target_Limited"
		AG_INS_TGT_BOX.material			= stroke_material
		AG_INS_TGT_BOX.init_pos			= {0, 0, 0}
		AG_INS_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond_Limited"}
		AG_INS_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_INS_TGT_BOX.scale			= HUD_SCALE
		AG_INS_TGT_BOX.controllers		= {{"ins_mode"}, {"AG_TGT_NV_Limited"}}
AddHUDStrokeSymbol(AG_INS_TGT_BOX)

-- TV Targets
local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_VVM_Centroid"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "sidewinder_bst"}
		AG_TV_TGT_BOX.parent_element	= hud_TD_vvm_pos.name
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_centroid"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)

local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_TD_Narrow"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "DMT_TD"}
		AG_TV_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_td_no_slew"}, {"dmt_td_v"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)

local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_TD_NarrowFOV"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "DMT_TD"}
		AG_TV_TGT_BOX.parent_element	= "HUD_TD_center_pos"
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_fov_pos_snowplow"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)


local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_TD_SlewFOV"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "DMT_TD_Slew"}
		AG_TV_TGT_BOX.parent_element	= "HUD_TD_center_pos"
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_fov_pos"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)

local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_TD_NoVideo"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond"}
		AG_TV_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_td_no_slew"}, {"dmt_td_nv_n"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)

local	AG_TV_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_TV_TGT_BOX.name				= "TV_TD_NoVideo_Limited"
		AG_TV_TGT_BOX.material			= stroke_material
		AG_TV_TGT_BOX.init_pos			= {0, 0, 0}
		AG_TV_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond_Limited"}
		AG_TV_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_TV_TGT_BOX.scale				= HUD_SCALE
		AG_TV_TGT_BOX.controllers		= {{"dmt_mode"}, {"dmt_td_no_slew"}, {"dmt_td_nv_l"}}
AddHUDStrokeSymbol(AG_TV_TGT_BOX)

-- LST Targets
local	AG_LST_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_LST_TGT_BOX.name				= "LST_Spot_Box"
		AG_LST_TGT_BOX.material			= stroke_material
		AG_LST_TGT_BOX.init_pos			= {0, 0, 0}
		AG_LST_TGT_BOX.points_set		= {"HUD_stroke_symbols", "laser_spot"}
		AG_LST_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_LST_TGT_BOX.scale			= HUD_SCALE
		AG_LST_TGT_BOX.controllers		= {{"lst_mode"}, {"lst_sensor_pos", HUD_SCALE}}
AddHUDStrokeSymbol(AG_LST_TGT_BOX)

local	AG_LST_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_LST_TGT_BOX.name				= "LST_TD_Box"
		AG_LST_TGT_BOX.material			= stroke_material
		AG_LST_TGT_BOX.init_pos			= {0, 0, 0}
		AG_LST_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond"}
		AG_LST_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_LST_TGT_BOX.scale			= HUD_SCALE
		AG_LST_TGT_BOX.controllers		= {{"lst_mode"}, {"AG_TGT_NV_Normal"}}
AddHUDStrokeSymbol(AG_LST_TGT_BOX)

local	AG_LST_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_LST_TGT_BOX.name				= "LST_TD_Box_Limited"
		AG_LST_TGT_BOX.material			= stroke_material
		AG_LST_TGT_BOX.init_pos			= {0, 0, 0}
		AG_LST_TGT_BOX.points_set		= {"HUD_stroke_symbols", "Target_Diamond_Limited"}
		AG_LST_TGT_BOX.parent_element	= HUD_AG_TGT_pos.name
		AG_LST_TGT_BOX.scale			= HUD_SCALE
		AG_LST_TGT_BOX.controllers		= {{"lst_mode"}, {"AG_TGT_NV_Limited"}}
AddHUDStrokeSymbol(AG_LST_TGT_BOX)

-- AGM TDs
local WD_Slew = 0
local NR_Slew = 1

local	AG_AGM_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_AGM_TGT_BOX.name				= "IRMV_RET_FOV_Wide"
		AG_AGM_TGT_BOX.material			= stroke_material
		AG_AGM_TGT_BOX.init_pos			= {0, 0, 0}
		AG_AGM_TGT_BOX.points_set		= {"HUD_stroke_symbols", "TV_TD_WD"}
		AG_AGM_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_AGM_TGT_BOX.scale			= HUD_SCALE
		AG_AGM_TGT_BOX.controllers		= {{"IM_sight_fov_slew", WD_Slew, HUD_SCALE}}
AddHUDStrokeSymbol(AG_AGM_TGT_BOX)

local	AG_AGM_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_AGM_TGT_BOX.name				= "IRMV_RET_FOV_Narrow"
		AG_AGM_TGT_BOX.material			= stroke_material
		AG_AGM_TGT_BOX.init_pos			= {0, 0, 0}
		AG_AGM_TGT_BOX.points_set		= {"HUD_stroke_symbols", "TV_TD_NR"}
		AG_AGM_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_AGM_TGT_BOX.scale			= HUD_SCALE
		AG_AGM_TGT_BOX.controllers		= {{"IM_sight_fov_slew", NR_Slew, HUD_SCALE}}
AddHUDStrokeSymbol(AG_AGM_TGT_BOX)

local	AG_AGM_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_AGM_TGT_BOX.name				= "IRMV_RET_Locked"
		AG_AGM_TGT_BOX.material			= stroke_material
		AG_AGM_TGT_BOX.init_pos			= {0, 0, 0}
		AG_AGM_TGT_BOX.points_set		= {"HUD_stroke_symbols", "IRMV_TD"}
		AG_AGM_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_AGM_TGT_BOX.scale			= HUD_SCALE
		AG_AGM_TGT_BOX.controllers		= {{"IM_sight_locked", HUD_SCALE}}
AddHUDStrokeSymbol(AG_AGM_TGT_BOX)

local	AG_AGM_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_AGM_TGT_BOX.name				= "LMAV_LSS_Spot"
		AG_AGM_TGT_BOX.material			= stroke_material
		AG_AGM_TGT_BOX.init_pos			= {0, 0, 0}
		AG_AGM_TGT_BOX.points_set		= {"HUD_stroke_symbols", "LSS_Search"}
		AG_AGM_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_AGM_TGT_BOX.scale			= HUD_SCALE
		AG_AGM_TGT_BOX.controllers		= {{"LM_sight_seek", HUD_SCALE}}
AddHUDStrokeSymbol(AG_AGM_TGT_BOX)

local	AG_AGM_TGT_BOX					= CreateElement "ceSMultiLine"
		AG_AGM_TGT_BOX.name				= "LMAV_LSS_Spot"
		AG_AGM_TGT_BOX.material			= stroke_material
		AG_AGM_TGT_BOX.init_pos			= {0, 0, 0}
		AG_AGM_TGT_BOX.points_set		= {"HUD_stroke_symbols", "laser_spot"}
		AG_AGM_TGT_BOX.parent_element	= HUD_TD_center_pos.name
		AG_AGM_TGT_BOX.scale			= HUD_SCALE
		AG_AGM_TGT_BOX.controllers		= {{"LM_sight_locked", HUD_SCALE}}
AddHUDStrokeSymbol(AG_AGM_TGT_BOX)
