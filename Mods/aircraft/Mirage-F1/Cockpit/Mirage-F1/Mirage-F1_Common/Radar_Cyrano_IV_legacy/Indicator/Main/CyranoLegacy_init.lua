-- Main

dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_init_common.lua")

purposes = {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}

--Source files for page subsets
SRC_RDR_BACK	= 0
SRC_RDR_COMMON	= 1
SRC_RDR_AA		= 2
SRC_RDR_AG		= 3

--subsets declare lua indication source files which will be used to combines pages 
my_path = LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Main/"

page_subsets = {
[SRC_RDR_BACK]			= my_path.."CyranoLegacy_back.lua",
[SRC_RDR_COMMON] 		= my_path.."CyranoLegacy_common.lua",
[SRC_RDR_AA] 			= my_path.."CyranoLegacy_AA.lua",
[SRC_RDR_AG] 			= my_path.."CyranoLegacy_AG.lua",
}

----------------------
pages = {
[PAGE_OFF]				= {},
[PAGE_AA]				= {SRC_RDR_BACK, SRC_RDR_COMMON, SRC_RDR_AA},
[PAGE_AG]				= {SRC_RDR_BACK, SRC_RDR_COMMON, SRC_RDR_AG},
}

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

local HUD_onlyRightAligned = true
local HUD_onlySz = 0 -- 8

if HUD_onlyRightAligned then
	update_screenspace_diplacement(1, false, HUD_onlySz)
	try_find_assigned_viewport("RIGHT_MFCD")
else
	update_screenspace_diplacement(1, true, HUD_onlySz)
	try_find_assigned_viewport("LEFT_MFCD")
end
