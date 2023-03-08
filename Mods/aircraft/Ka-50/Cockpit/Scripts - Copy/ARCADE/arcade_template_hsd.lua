dofile(LockOn_Options.script_path.."ARCADE\\arcade_usefull_definitions.lua")


target_airborne                  = CreateElement "ceTexPoly"
target_airborne.name             = "target_airborne"
target_airborne.vertices          = {{-hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y},
                                    {-hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                    { hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                    { hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y}}
target_airborne.indices          = default_box_indices
target_airborne.material			= "ARCADE"
target_airborne.tex_params		= {0.5, 365.5 / 512, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
target_airborne.controllers      = {{"draw_target_hsd",hsd_size,hsd_size},
                                    {"draw_iff_color"},
                                    {"you_are_the_target_blinking"}}
target_airborne.additive_alpha  = true
target_airborne.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_airborne.level		  	=  DEFAULT_LEVEL + 3
AddElement(target_airborne)


target_ground                  = CreateElement "ceTexPoly"
target_ground.name             = "target_ground"
target_ground.vertices         = {{-hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y},
                                  {-hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                  { hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                  { hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y}}
target_ground.indices          = default_box_indices
target_ground.material	       = "ARCADE"
target_ground.tex_params	   = {330/512, 365.5 / 512, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
target_ground.controllers      = {{"draw_target_hsd",hsd_size,hsd_size},
                                  {"remove_orientation"},
                                  {"draw_iff_color"},
                                  {"you_are_the_target_blinking"}}
target_ground.additive_alpha   = true
target_ground.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_ground.level		  	   =  DEFAULT_LEVEL + 3
AddElement(target_ground)

target_air_defense                  = CreateElement "ceTexPoly"
target_air_defense.name             = "target_air_defense"
target_air_defense.vertices         = {{-1.1*hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y},
                                       {-1.1*hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                       { 1.1*hsd_coeff*trg_size_x,  hsd_coeff*trg_size_y},
                                       { 1.1*hsd_coeff*trg_size_x, -hsd_coeff*trg_size_y}}
target_air_defense.indices          = default_box_indices
target_air_defense.material	        = "ARCADE_RED"
target_air_defense.tex_params	    = {255/512, 129/ 512, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
target_air_defense.controllers      = {{"draw_target_hsd",hsd_size,hsd_size},
	                                  {"remove_orientation"},
	                                  {"draw_iff_color"},
	                                  {"you_are_the_target_blinking"}}
target_air_defense.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_air_defense.level		  	=  DEFAULT_LEVEL + 3
target_air_defense.additive_alpha   = true
AddElement(target_air_defense)


target_mission                  = CreateElement "ceTexPoly"
target_mission.name             = "target_mission"
target_mission.vertices         = {{-0.5*hsd_coeff*trg_size_x, -0.5*hsd_coeff*trg_size_y},
                                   {-0.5*hsd_coeff*trg_size_x,  0.5*hsd_coeff*trg_size_y},
                                   { 0.5*hsd_coeff*trg_size_x,  0.5*hsd_coeff*trg_size_y},
                                   { 0.5*hsd_coeff*trg_size_x, -0.5*hsd_coeff*trg_size_y}}
target_mission.indices          = default_box_indices
target_mission.material	        = "ARCADE_PURPLE"
target_mission.tex_params	    = {330/512, 365.5 / 512, tex_scale/(hsd_coeff *0.5), tex_scale/(hsd_coeff*0.5)}
target_mission.controllers      = {{"draw_mission_target_hsd",hsd_size,hsd_size}}
target_mission.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_mission.level		  	=  DEFAULT_LEVEL + 3
target_mission.additive_alpha  = true
AddElement(target_mission)


target_current_clear				 = CreateElement "ceMeshPoly"
target_current_clear.name			 = "target_current"
target_current_clear.primitivetype   = "triangles"
target_current_clear.vertices		 = {{-hsd_coeff*curr_target_size_x,-hsd_coeff*curr_target_size_y}, 
                                        {-hsd_coeff*curr_target_size_x, hsd_coeff*curr_target_size_y},
                                        { hsd_coeff*curr_target_size_x, hsd_coeff*curr_target_size_y},
                                        { hsd_coeff*curr_target_size_x,-hsd_coeff*curr_target_size_y}}
target_current_clear.indices		 = default_box_indices
target_current_clear.material		 = "GREEN_2"
target_current_clear.h_clip_relation = h_clip_relations.INCREASE_LEVEL
target_current_clear.isvisible       = false
target_current_clear.controllers     =  {{"draw_current_target_hsd",hsd_size,hsd_size},
                                         {"remove_orientation"},
                                         {"bound_by_circle_without_root",hsd_size,hsd_size}}
AddElement(target_current_clear)


target_current					= CreateElement "ceTexPoly"
target_current.name				= "target_current_shape"
target_current.vertices			= {{-hsd_coeff*curr_target_size_x,-hsd_coeff*curr_target_size_y}, 
                                   {-hsd_coeff*curr_target_size_x, hsd_coeff*curr_target_size_y},
                                   { hsd_coeff*curr_target_size_x, hsd_coeff*curr_target_size_y},
                                   { hsd_coeff*curr_target_size_x,-hsd_coeff*curr_target_size_y}}
target_current.indices			= default_box_indices
target_current.material			= "ARCADE"
target_current.tex_params		= {330/512, 0.5, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
target_current.controllers      = {{"draw_iff_color"}}
target_current.additive_alpha   = true
target_current.parent_element   = target_current_clear.name
target_current_clear.h_clip_relation = h_clip_relations.INCREASE_LEVEL
AddElement(target_current)

local   spike_size          = ((0.5 * (79 - 63)/256) / hud_symbol_size_px) * hud_symbol_size

mlws_contact					= CreateElement "ceTexPoly"
mlws_contact.name				= "mlws_contact"
mlws_contact.vertices			= {{-hsd_coeff*spike_size,-hsd_coeff*spike_size}, 
                                   {-hsd_coeff*spike_size, hsd_coeff*spike_size},
                                   { hsd_coeff*spike_size, hsd_coeff*spike_size},
                                   { hsd_coeff*spike_size,-hsd_coeff*spike_size}}
mlws_contact.indices			= default_box_indices
mlws_contact.material			= "ARCADE"
mlws_contact.tex_params		    = {394/512,0.5, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
mlws_contact.controllers        = {{"draw_mlws_contact_hsd",hsd_size,hsd_size}}
mlws_contact.additive_alpha     = true
mlws_contact.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
mlws_contact.level		  	=  DEFAULT_LEVEL + 3
AddElement(mlws_contact)

local   wpt_size              = ((0.5*(79 - 63)/256) / hud_symbol_size_px) * hud_symbol_size
local   wpt_scale             = 1.5
local   sight_size            = ((0.5*(79 - 51)/256) / hud_symbol_size_px) * hud_symbol_size
local   sight_vertices     	  = {{-sight_size,-sight_size}, 
                                 {-sight_size, sight_size},
                                 { sight_size, sight_size},
                                 { sight_size,-sight_size}}

airfield					= CreateElement "ceTexPoly"
airfield.name				= "airfield"
airfield.vertices			= sight_vertices
airfield.indices			= default_box_indices
airfield.tex_params	        = {179/512, 0.5, tex_scale,tex_scale}  
airfield.material			= "ARCADE_GREY"
airfield.controllers        = {{"draw_mark_hsd",hsd_size,hsd_size}}
--airfield.h_clip_relation    = h_clip_relations.INCREASE_IF_LEVEL
--airfield.level		  	    =  DEFAULT_LEVEL + 3   
airfield.isvisible          = true
airfield.additive_alpha     = true
AddElement(airfield)


airfield2					= CreateElement "ceTexPoly"
airfield2.vertices			= {{-wpt_size*wpt_scale,-wpt_size*wpt_scale}, 
                               {-wpt_size*wpt_scale, wpt_size*wpt_scale},
                               { wpt_size*wpt_scale, wpt_size*wpt_scale},
                               { wpt_size*wpt_scale,-wpt_size*wpt_scale}}
airfield2.indices			= default_box_indices
airfield2.material			= "ARCADE_BLUE"
airfield2.tex_params	    = {394/512,0.5, tex_scale/wpt_scale, tex_scale/wpt_scale}  
airfield2.parent_element    = airfield.name
--airfield2.h_clip_relation   = h_clip_relations.INCREASE_IF_LEVEL
--airfield2.level		  	    =  DEFAULT_LEVEL + 3   
airfield2.additive_alpha    = false
AddElement(airfield2)