dofile(LockOn_Options.script_path.."ARCADE\\arcade_usefull_definitions.lua")
----------------------------------------------

base_hud = add_hud()


local   wpt_size              = ((0.5*(79 - 63)/256) / hud_symbol_size_px) * hud_symbol_size
local   wpt_scale             = 1

waypoint_mark_hud					= CreateElement "ceTexPoly"
waypoint_mark_hud.vertices			= {{-wpt_size*wpt_scale,-wpt_size*wpt_scale}, 
									   {-wpt_size*wpt_scale, wpt_size*wpt_scale},
									   { wpt_size*wpt_scale, wpt_size*wpt_scale},
									   { wpt_size*wpt_scale,-wpt_size*wpt_scale}}
waypoint_mark_hud.indices			= default_box_indices
waypoint_mark_hud.tex_params	    = {394/512,0.5, tex_scale/wpt_scale, tex_scale/wpt_scale}  
waypoint_mark_hud.material			= "ARCADE_GREEN"
waypoint_mark_hud.controllers       = {{"draw_waypoint_hud"},{"time_rotate_Y",0.2}}
waypoint_mark_hud.parent_element    = base_hud.name    
waypoint_mark_hud.additive_alpha    = true
AddElement(waypoint_mark_hud)

----------------------------------------------
if LockOn_Options.flight.easy_radar then
base_hsd = add_hsd()


local   north_direction                 = CreateElement "ceTexPoly"
        north_direction.name            = "north_direction"
        north_direction.vertices        = {{-hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5},
                                           {-hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                           { hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                           { hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5}}
        north_direction.indices         = default_box_indices
        north_direction.material		= "ARCADE_2_YELLOW"
        north_direction.tex_params		= {179/512,365.5 / 512, (tex_scale/hsd_coeff)/1.5, (tex_scale/hsd_coeff)/1.5}
        north_direction.controllers     = {{"north_direction_hsd"},{"move",0,hsd_size * 1.05}}
        north_direction.additive_alpha  = true
        north_direction.parent_element  = base_hsd.name
        AddElement(north_direction)
        
local   N_txt                 = CreateElement "ceStringPoly"
        N_txt.name            = "N"
        N_txt.material        = "font_ARCADE"
        N_txt.init_pos		  = {0,-hsd_coeff*trg_size_x * 3.25}
        N_txt.alignment       = "CenterCenter"
        N_txt.stringdefs      = {0.0035, 0.0035,0,0}
        N_txt.value           = "N"
        N_txt.parent_element  = north_direction.name
        N_txt.additive_alpha  = true
        AddElement(N_txt)
	
local   course                 = CreateElement "ceTexPoly"
        course.name            = "course"
        course.vertices        = {{-hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5},
                                  {-hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                  { hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                  { hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5}}
        course.indices         = default_box_indices
        course.material		   = "ARCADE_TRANSP_GREEN"
		course.init_pos		   = {0,hsd_size * 1.05}  
        course.tex_params	   = {179/512,365.5 / 512, (tex_scale/hsd_coeff)/1.5, (tex_scale/hsd_coeff)/1.5}
        course.additive_alpha  = true
        course.parent_element  = base_hsd.name
        AddElement(course)
		
local   course_txt                 = CreateElement "ceStringPoly"
        course_txt.name            = "NN"
        course_txt.material        = "font_ARCADE_GREEN"
        course_txt.init_pos		   = {0,-hsd_coeff*trg_size_x * 3.25}
        course_txt.alignment       = "CenterCenter"
        course_txt.stringdefs      = {0.0035*0.5, 0.0035*0.5,0,0}
        course_txt.formats         = {"%03.f"}
		course_txt.controllers     = {{"txt_course",0}}
        course_txt.parent_element  = course.name
        course_txt.additive_alpha  = true
        AddElement(course_txt)

local   self_mark                 = CreateElement "ceTexPoly"
        self_mark.name            = "self_mark"
        self_mark.vertices        = {{-hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5},
                                  {-hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                  { hsd_coeff*trg_size_x * 1.5,  hsd_coeff*trg_size_y * 1.5},
                                  { hsd_coeff*trg_size_x * 1.5, -hsd_coeff*trg_size_y * 1.5}}
        self_mark.indices         = default_box_indices
        self_mark.material		  = "ARCADE_2_YELLOW"
        self_mark.tex_params	  = {179/512,365.5 / 512, (tex_scale/hsd_coeff)/1.5, (tex_scale/hsd_coeff)/1.5}
		self_mark.init_pos        = {0,hsd_coeff*trg_size_y * 1.5}
        self_mark.additive_alpha  = true
        self_mark.parent_element  = base_hsd.name
        AddElement(self_mark)
                
local   line_width                      = hsd_coeff *(0.5*(4.5/256)/ tex_scale) * 1.5

local history ={}
local hist_coeff = 1
for i=1,50 do
		local  scale = 0.02 * i
		history[i]                 = CreateElement "ceTexPoly"
        history[i].vertices        = {{-hsd_coeff*trg_size_x * hist_coeff, -hsd_coeff*trg_size_y * hist_coeff},
									  {-hsd_coeff*trg_size_x * hist_coeff,  hsd_coeff*trg_size_y * hist_coeff},
								      { hsd_coeff*trg_size_x * hist_coeff,  hsd_coeff*trg_size_y * hist_coeff},
									  { hsd_coeff*trg_size_x * hist_coeff, -hsd_coeff*trg_size_y * hist_coeff}}
        history[i].indices         = default_box_indices
        history[i].material		   = "ARCADE_TRANSP_YELLOW"
        history[i].tex_params	   = {0.5, 365.5 / 512, (tex_scale/hsd_coeff)/hist_coeff, (tex_scale/hsd_coeff)/hist_coeff}
		history[i].controllers     = {{"hsd_history_pnt",hsd_size,hsd_size,i-1},{"scale",scale,-scale}}
        history[i].additive_alpha  = true
        history[i].parent_element  = base_hsd.name
        AddElement(history[i])
end

local   waypoint_mark_hsd					= CreateElement "ceTexPoly"
        waypoint_mark_hsd.vertices			= {{-wpt_size*wpt_scale,-wpt_size*wpt_scale}, 
	                                           {-wpt_size*wpt_scale, wpt_size*wpt_scale},
	                                           { wpt_size*wpt_scale, wpt_size*wpt_scale},
	                                           { wpt_size*wpt_scale,-wpt_size*wpt_scale}}
        waypoint_mark_hsd.indices			= default_box_indices
        waypoint_mark_hsd.tex_params	    = {394/512,0.5, tex_scale/wpt_scale, tex_scale/wpt_scale}  
        waypoint_mark_hsd.material			= "ARCADE_GREEN"
        waypoint_mark_hsd.controllers       = {{"draw_waypoint_hsd",hsd_size,hsd_size},
										   {"bound_by_circle_without_root",hsd_size,hsd_size}}
        waypoint_mark_hsd.parent_element    = base_hsd.name    
        waypoint_mark_hsd.additive_alpha    = true
        AddElement(waypoint_mark_hsd)

--[[
local   W_vector						= CreateElement "ceHWLine"
        W_vector.name					= "W_vector"
        W_vector.vertices				= {{0    , -line_width},
                                           {0    ,  line_width},
                                           {hsd_size   ,  line_width},
                                           {hsd_size   , -line_width}}
        W_vector.maskvertices			= {{0    , -1.2*line_width},
                                           {0    ,  1.2*line_width}, 
                                           {hsd_size   ,  1.2*line_width}, 
                                           {hsd_size   , -1.2*line_width}}
        W_vector.indices				= default_box_indices
        W_vector.length					= 0.0
        W_vector.maxlength				= hsd_size
        W_vector.init_rot               = {90,0,0}
        W_vector.material				= "ARCADE_2_YELLOW"
        W_vector.tex_params				= {128/512,176.5/512,0.5/hsd_size,(tex_scale/hsd_coeff)/1.5}
        W_vector.controllers			= {{"draw_velocity_vector_hsd",(320/3.6),(hsd_size)/(320/3.6)}}
        W_vector.parent_element         = base_hsd.name
        W_vector.additive_alpha         = true
        AddElement(W_vector)
--]]

end
----------------------------------------------
