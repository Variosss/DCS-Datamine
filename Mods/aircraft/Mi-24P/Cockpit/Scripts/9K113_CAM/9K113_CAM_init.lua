dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")


local   use_helmet = false

	  use_helmet = LockOn_Options.screen.oculus_rift

purposes 	 = {render_purpose.AUXILLARY_SIGHT_SCREENSPACE}

if use_helmet then 
	indicator_type = indicator_types.COLLIMATOR
	purposes 	   = {render_purpose.AUXILLARY_SIGHT}
else
	indicator_type = indicator_types.COMMON
    purposes 	   = {render_purpose.AUXILLARY_SIGHT_SCREENSPACE}
	
	local x,y,w,h,GUI_scale   = get_UIMainView()
	
	x = x/GUI_scale
	y = y/GUI_scale
	w = w/GUI_scale
	h = h/GUI_scale
	
	dedicated_viewport 		  = {x,y,w,h}
	dedicated_viewport_arcade = dedicated_viewport
end

page_subsets 			 = {LockOn_Options.script_path.."9K113_CAM\\9K113_CAM_base_page.lua"}
----------------------
pages 					 = {{1}}
init_pageID     		 = 1
