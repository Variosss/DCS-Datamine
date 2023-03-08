-- Left/Right MDIs have specific symbology clipping levels, thus there are separate left/right init files
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")

if bakeIndicators ~= true then
	opacity_sensitive_materials = 
	{
		MDG_font_name(MDG_SELF_IDS.RMDI),
		MDG_material_name(MDG_SELF_IDS.RMDI)
	}
end

-- Specific part of MDI initialization
-- Parameters handling functions
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/InitParams.lua")
writeParameter("MDG_init_DEFAULT_LEVEL", 10)
-- Parameters to customize common symbology properties
writeParameter("MDG_init_specifics", LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_right_specifics.lua")

-- Common part of MDI initialization
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_init.lua")

if bakeIndicators ~= true then
	dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/MDI_IP1556A/indicator/MDI_right_viewport_cfg.lua")
end
