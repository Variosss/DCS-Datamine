dofile(LockOn_Options.common_script_path.."devices_defs.lua")

indicator_type = indicator_types.COLLIMATOR
purposes       = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

opacity_sensitive_materials = 
{
	"font_stroke_HUD",
	"HUD"
}

shaderLineParamsUpdatable  = true
shaderLineDefaultThickness = 0.8
shaderLineDefaultFuzziness = 0.5
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false

dynamically_update_geometry = false

-- page specific for the indicator, implements indicator border/FOV
--BasePage              = LockOn_Options.script_path.."Displays/HUD/indicator/Pages/HUD_base.lua"

DED_IndicatorType = 1
DED_PagesPath = LockOn_Options.script_path.."Displays/HUD/indicator/DED/Pages/"
dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/DED_Pages_init.lua")

-- optical center is 5.2 degrees below the FRL
collimator_default_distance_factor = {auto_collimator_default_distance_factor[1], auto_collimator_default_distance_factor[1] * math.rad(-5.2), 0}
