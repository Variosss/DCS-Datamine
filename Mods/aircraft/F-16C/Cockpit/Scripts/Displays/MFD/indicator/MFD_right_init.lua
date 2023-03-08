opacity_sensitive_materials = 
{
	"font_stroke_RMFD",
	"RMFD_MATERIAL"
}

-- Specific part of MFD initialization
-- Parameters handling functions
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Tools.lua")
writeParameter("MFD_init_DEFAULT_LEVEL", 6)

dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type 		 = indicator_types.COMMON

dofile(LockOn_Options.script_path.."config.lua")
if USE_LCD_MFD then
	purposes       		 = {100} -- avoid direct call
else
	purposes       		 = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
end

shaderLineParamsUpdatable  = true
shaderLineDefaultThickness = 0.8
shaderLineDefaultFuzziness = 0.5
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = true

writeParameter("MFD_Font_Name", "font_stroke_RMFD")
writeParameter("MFD_Material_Name", "RMFD_MATERIAL")

-- page specific for the indicator, implements indicator border/FOV
BasePage = LockOn_Options.script_path.."Displays/MFD/indicator/Pages/MFD_base.lua"
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/MFD_Pages_Init.lua")

-- gray shade for "render_target_X" , to change tone - make texture with that tone 
used_render_mask  = LockOn_Options.script_path.."../IndicationResources/Displays/flir_texture.dds"

if not USE_LCD_MFD then
	--ViewportHandling
	dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
	update_screenspace_diplacement(1, true, 0)
	try_find_assigned_viewport("RIGHT_MFCD")
end
