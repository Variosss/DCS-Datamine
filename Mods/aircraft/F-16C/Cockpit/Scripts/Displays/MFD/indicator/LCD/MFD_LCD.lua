
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")

function declareMFD(left)
	
	indicator_type       = indicator_types.COMMON
	purposes       		 = {render_purpose.GENERAL,render_purpose.HUD_ONLY_VIEW}
	
	
	local viewport 			  = make_viewport(1,left,false,480)
	dedicated_viewport 		  = viewport
	dedicated_viewport_arcade = viewport
	
	--update_screenspace_diplacement(1, left, 0)

	if left then
		page_subsets    	 = {LockOn_Options.script_path.."Displays/MFD/indicator/LCD/page_left.lua"}
		try_find_assigned_viewport("LEFT_MFCD")
	else
		try_find_assigned_viewport("RIGHT_MFCD")
		page_subsets    	 = {LockOn_Options.script_path.."Displays/MFD/indicator/LCD/page_right.lua"}
	end
	
	pages 				 = {{1}}
	init_pageID     	 = 1
end

