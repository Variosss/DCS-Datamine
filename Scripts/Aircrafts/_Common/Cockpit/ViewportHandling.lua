-- positioning on screen in HUD Only view 
function update_screenspace_diplacement(aspect,is_left,zoom_value)
	local w = LockOn_Options.screen.width;
	local h = LockOn_Options.screen.height;
	
	if LockOn_Options.screen.oculus_rift then 
		local ui_x,ui_y,ui_w,ui_h = get_UIMainView()
		w = ui_w;
		h = ui_h;
	end	

	local x0 = 0
	local w0 = 0.5 * h
	
	local aspect     =     aspect or 1
	local zoom_value = zoom_value or 0
	local default_width  = w0 + (64 * zoom_value)

	if default_width > h then
	   default_width = h
	end
	
	if default_width > 0.5 * w then
	   default_width = 0.5 * w
	end
		
	local default_height = default_width / aspect
	local default_y      = h - default_height
	local default_x      = w - default_width - x0
	if  is_left then
		default_x   = x0
	end
	dedicated_viewport 		  = {default_x,default_y,default_width,default_height}
	dedicated_viewport_arcade = {default_x, 0	    ,default_width,default_height}
end

function make_viewport(aspect,is_left,is_top,default_width,zoom_value)
	local w = LockOn_Options.screen.width;
	local h = LockOn_Options.screen.height;

	if LockOn_Options.screen.oculus_rift then 
		local ui_x,ui_y,ui_w,ui_h = get_UIMainView()
		w = ui_w;
		h = ui_h;
	end

	local x0 = 0
	local w0 = 0.5 * h
	
	local aspect      	 =     aspect or 1
	local zoom_value	 = zoom_value or 0
	local default_width  = default_width or w0
		  default_width  = default_width + (64 * zoom_value)
 
	if default_width > h then
	   default_width = h
	end
	
	if default_width > 0.5 * w then
	   default_width = 0.5 * w
	end
		
	local default_height = default_width / aspect
	local default_y      = h - default_height
	local default_x      = w - default_width - x0
	if  is_left then
		default_x   = x0
	end
	if is_top then 
	    default_y 	= 0
	end
	return {default_x,default_y,default_width,default_height}
end

function set_full_viewport_coverage(viewport)
   dedicated_viewport 		 = {viewport.x,
								viewport.y,
								viewport.width,
								viewport.height}
   dedicated_viewport_arcade = dedicated_viewport
   purposes 				 = {render_purpose.GENERAL,
								render_purpose.HUD_ONLY_VIEW,
								render_purpose.SCREENSPACE_OUTSIDE_COCKPIT,
								render_purpose.SCREENSPACE_INSIDE_COCKPIT} -- set purposes to draw it always 
   render_target_always = true
end

-- try to find assigned viewport
function try_find_assigned_viewport(exactly_name,abstract_name)
	local viewport  = find_viewport(exactly_name) or 
					  find_viewport(abstract_name)				  
	if viewport then 
	   set_full_viewport_coverage(viewport)
	end
	return viewport
end
