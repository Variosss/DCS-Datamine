dofile(LockOn_Options.common_script_path.."devices_defs.lua")

opacity_sensitive_materials = 
{
}

shaderLineParamsUpdatable	= true
shaderLineDefaultThickness	= 12.0
shaderLineDefaultFuzziness	= 0.3
shaderLineDrawAsWire		= false
shaderLineUseSpecularPass	= false

indicator_type		= indicator_types.COMMON

dofile(LockOn_Options.script_path.."config.lua")

if USE_LCD_MFD then
	purposes		= {100}	-- avoid direct call
else
	purposes		= {render_purpose.GENERAL}
end

--
dofile(LockOn_Options.script_path.."Displays/EHSI/indicator/EHSI_Pages_init.lua")

--
use_parser					= false
dynamically_update_geometry	= false

--
COLOR_RED		= {1, 0, 0}
COLOR_BLUE		= {0, 0.72, 0.95}
COLOR_YELLOW	= {1, 1, 0}
COLOR_GOLD		= {1, 0.98, 0.68}

if not USE_LCD_MFD then
	--ViewportHandling
	dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
	update_screenspace_diplacement(1, true, 0)
	try_find_assigned_viewport("EHSI")
end