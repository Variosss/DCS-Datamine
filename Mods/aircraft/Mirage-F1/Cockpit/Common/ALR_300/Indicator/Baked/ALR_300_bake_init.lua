dofile(LockOn_Options.common_script_path.."devices_defs.lua")

purposes 	 	= render_purposes_to_use or {render_purpose.GENERAL, render_purpose.HUD_ONLY_VIEW}
indicator_type 	= indicator_types.COMMON

page_subsets 	= {LockOn_Options.script_path.."../../Common/ALR_300/Indicator/Baked/ALR_300_bake_page.lua"}
pages 			= {{1}}
init_pageID     = 1

dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

local HUD_onlyRightAligned = false
local HUD_onlySz = 0

if HUD_onlyRightAligned then
	update_screenspace_diplacement(1, false, HUD_onlySz)
	try_find_assigned_viewport("RIGHT_MFCD")
else
	update_screenspace_diplacement(1, true, HUD_onlySz)
	try_find_assigned_viewport("LEFT_MFCD")
end
