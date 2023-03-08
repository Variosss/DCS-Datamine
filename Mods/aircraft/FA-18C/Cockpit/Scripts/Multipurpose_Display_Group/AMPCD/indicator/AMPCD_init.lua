dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_materials.lua")
dofile(LockOn_Options.script_path.."config.lua")

opacity_sensitive_materials = 
{
	MDG_font_name(MDG_SELF_IDS.HI),
	MDG_material_name(MDG_SELF_IDS.HI),
	"MPD_DMC_OUTLINE",
	"font_MPD_DMC_outline",
	"font_MPD_DMC_main",
}

-- Parameters handling functions
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/InitParams.lua")
-- Parameters to customize common symbology properties
writeParameter("MDG_init_specifics", LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_specifics.lua")
writeParameter("MDG_init_DEFAULT_LEVEL", 14)

indicator_type 				= indicator_types.COMMON

if bakeIndicators == true then
	purposes	   				= {100} -- direct render disabled
else
	purposes	   				= {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW} -- HUD only was added for test purposes
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
isAMPCD = true
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/MPD_AdvisoriesDefs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_init.lua")

if bakeIndicators ~= true then
	dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/AMPCD/indicator/AMPCD_viewport_cfg.lua")
end
