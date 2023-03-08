dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

update_screenspace_diplacement(SelfWidth/SelfHeight,false)

indicator_type = indicator_types.COMMON
purposes 	   = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

-- Pages Definition
UVHF_OFF	= 0
UVHF_SCREEN	= 1


-- Page Sources
SRC_UVHF_BASE	= 0
SRC_UVHF_SCREEN	= 1

local UVHF_path = LockOn_Options.script_path.."UVHF/indicator/"

page_subsets = {
	[SRC_UVHF_BASE]		= UVHF_path.."UVHF_base.lua",
	[SRC_UVHF_SCREEN]	= UVHF_path.."UVHF_ARC210.lua",
}

----------------------
pages = {
	[UVHF_OFF]		= {},
	[UVHF_SCREEN]	= {SRC_UVHF_BASE, SRC_UVHF_SCREEN},
}

init_pageID			= UVHF_SCREEN

