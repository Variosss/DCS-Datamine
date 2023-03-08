dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

purposes 	 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}

indicator_type 	 = indicator_types.COMMON

update_screenspace_diplacement(1.0,disposition == 'L')	

if disposition == 'L' then
	try_find_assigned_viewport("LEFT_MFCD")
	page_subsets = {  LockOn_Options.script_path.."MFCD/indicator/BAKE/page_left.lua"}
else 
	try_find_assigned_viewport("RIGHT_MFCD")
	page_subsets = {  LockOn_Options.script_path.."MFCD/indicator/BAKE/page_right.lua"}
end

pages 			= {{1}}
init_pageID     = 1

