dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/device/MDG_device_common.lua") -- MDG IDs

local MDG_material_names = {}
MDG_material_names[MDG_SELF_IDS.HUD] 	= "HUD_SYMBOLOGY_MATERIAL"
MDG_material_names[MDG_SELF_IDS.LMDI] 	= "LMDI_SYMBOLOGY_MATERIAL"
MDG_material_names[MDG_SELF_IDS.RMDI] 	= "RMDI_SYMBOLOGY_MATERIAL"
MDG_material_names[MDG_SELF_IDS.HI] 	= "AMPCD_SYMBOLOGY_MATERIAL"

function MDG_material_name(ID)
	return MDG_material_names[ID]
end

local MDG_font_names = {}
MDG_font_names[MDG_SELF_IDS.HUD] 		= "HUD_FONT_MATERIAL"
MDG_font_names[MDG_SELF_IDS.LMDI] 		= "LMDI_FONT_MATERIAL"
MDG_font_names[MDG_SELF_IDS.RMDI] 		= "RMDI_FONT_MATERIAL"
MDG_font_names[MDG_SELF_IDS.HI] 		= "AMPCD_FONT_MATERIAL"

function MDG_font_name(ID)
	return MDG_font_names[ID]
end
