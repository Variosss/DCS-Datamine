dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")


indicator_type = indicator_types.COMMON
purposes 	 = {100}	-- Don't render, only bake

PAGE_0		= 0
SRC_VCM		= 0

page_subsets = { [SRC_VCM] = LockOn_Options.script_path.."VCM/VCM_page.lua" }

----------------------
pages = { [PAGE_0] = {SRC_VCM}}
init_pageID	= PAGE_0


shaderLineParamsUpdatable  = true
shaderLineDrawAsWire 	   = false
shaderLineUseSpecularPass  = false
shaderLineDefaultThickness = 1.0
shaderLineDefaultFuzziness = 1.0

brightness_sensitive_materials	= { }
