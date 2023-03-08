dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

update_screenspace_diplacement(SelfWidth/SelfHeight,false)

indicator_type = indicator_types.COMMON
purposes 	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-- Pages Definition
ODU_OFF		= 0
ODU_DISP	= 1


-- Page Sources
SRC_ODU_BASE	= 0
SRC_ODU_DISP	= 1

local odu_path = LockOn_Options.script_path.."ODU/indicator/"

page_subsets = {
	[SRC_ODU_BASE]		= odu_path.."ODU_base.lua",
	[SRC_ODU_DISP]		= odu_path.."ODU_Display.lua",
}

----------------------
pages = {
	[ODU_OFF]		= {},
	[ODU_DISP]		= {SRC_ODU_BASE, SRC_ODU_DISP},
}

init_pageID			= ODU_DISP

brightness_sensitive_materials = {
	"ufc_font_base",
}