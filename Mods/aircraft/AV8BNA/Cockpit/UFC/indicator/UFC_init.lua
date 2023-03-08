dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

update_screenspace_diplacement(SelfWidth/SelfHeight,false)

indicator_type = indicator_types.COMMON
purposes 	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-- Pages Definition
UFC_OFF		= 0
UFC_SCRPAD	= 1
UFC_ALPHA	= 2


-- Page Sources
SRC_UFC_BASE	= 0
SRC_UFC_SCRPAD	= 1
SRC_UFC_ALPHA	= 2

local ufc_path = LockOn_Options.script_path.."UFC/indicator/"

page_subsets = {
	[SRC_UFC_BASE]		= ufc_path.."UFC_base.lua",
	[SRC_UFC_SCRPAD]	= ufc_path.."UFC_scratchpad.lua",
	[SRC_UFC_ALPHA]		= ufc_path.."UFC_ALPHA.lua",
}

----------------------
pages = {
	[UFC_OFF]		= {},
	[UFC_SCRPAD]	= {SRC_UFC_BASE, SRC_UFC_SCRPAD},
	[UFC_ALPHA]		= {SRC_UFC_BASE, SRC_UFC_ALPHA},
}

init_pageID			= UFC_SCRPAD

brightness_sensitive_materials = {
	"ufc_font_base",
}