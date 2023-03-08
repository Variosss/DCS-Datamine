dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."config.lua")

indicator_type 		 		= indicator_types.COMMON

if bakeIndicators == true then
	purposes	   				= {100} -- direct render disabled
else
	purposes	   				= {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
end

shaderLineParamsUpdatable  	= true
shaderLineDefaultThickness 	= 0.8
shaderLineDefaultFuzziness 	= 0.5
shaderLineDrawAsWire 	   	= false
shaderLineUseSpecularPass  	= true

-- page specific for the indicator, implements indicator border/FOV
BasePage              = LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_base.lua"
-- Cautions/Advisories and MENU label
IndicatorSpecificPage = LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/CautAdvAndMenuPage.lua"
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_AdvisoriesDefs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_init.lua")

-- green shade for "render_target_X" , to change tone - make texture with that tone 
used_render_mask  = LockOn_Options.script_path.."../IndicationResources/MDG/flir_texture.dds"
