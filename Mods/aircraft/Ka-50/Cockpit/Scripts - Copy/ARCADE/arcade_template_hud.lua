dofile(LockOn_Options.script_path.."ARCADE\\arcade_usefull_definitions.lua")

target_airborne                 = CreateElement "ceTexPoly"
target_airborne.name            = "target_airborne"
target_airborne.vertices        = {{-trg_size_x, -trg_size_y},
                                   {-trg_size_x,  trg_size_y},
                                   { trg_size_x,  trg_size_y},
                                   { trg_size_x, -trg_size_y}}
target_airborne.indices         = default_box_indices
target_airborne.material		= "ARCADE_RED"
target_airborne.tex_params		= {0.5, 365.5 / 512, tex_scale, tex_scale}
target_airborne.controllers     = {{"draw_target_hud"},{"draw_iff_color"},{"you_are_the_target_blinking"}}
target_airborne.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
target_airborne.level		  	=  DEFAULT_LEVEL + 1
target_airborne.additive_alpha  = true
AddElement(target_airborne)


target_ground                  = CreateElement "ceTexPoly"
target_ground.name             = "target_ground"
target_ground.vertices         = {{-trg_size_x, -trg_size_y},
                                  {-trg_size_x,  trg_size_y},
                                  { trg_size_x,  trg_size_y},
                                  { trg_size_x, -trg_size_y}}
target_ground.indices          = default_box_indices
target_ground.material	       = "ARCADE_RED"
target_ground.tex_params	   = {330/512, 365.5 / 512, tex_scale, tex_scale}
target_ground.controllers      = {{"draw_target_hud"},
                                  {"draw_iff_color"},
                                  {"you_are_the_target_blinking"}}
target_ground.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_ground.level		  	   =  DEFAULT_LEVEL + 1
target_ground.additive_alpha  = true
AddElement(target_ground)


target_air_defense                  = CreateElement "ceTexPoly"
target_air_defense.name             = "target_air_defense"
target_air_defense.vertices         = {{-1.1*trg_size_x, -trg_size_y},
                                       {-1.1*trg_size_x,  trg_size_y},
                                       { 1.1*trg_size_x,  trg_size_y},
                                       { 1.1*trg_size_x, -trg_size_y}}
target_air_defense.indices          = default_box_indices
target_air_defense.material	        = "ARCADE_RED"
target_air_defense.tex_params	    = {255/512, 129/ 512, tex_scale, tex_scale}
target_air_defense.controllers      = {{"draw_target_hud"},
									   {"draw_iff_color"},
                                       {"you_are_the_target_blinking"}}
target_air_defense.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_air_defense.level		  	=  DEFAULT_LEVEL + 1
target_air_defense.additive_alpha   = true
AddElement(target_air_defense)



target_mission                  = CreateElement "ceTexPoly"
target_mission.name             = "target_mission"
target_mission.vertices         = {{-0.5*trg_size_x, -0.5*trg_size_y},
                                   {-0.5*trg_size_x,  0.5*trg_size_y},
                                   { 0.5*trg_size_x,  0.5*trg_size_y},
                                   { 0.5*trg_size_x, -0.5*trg_size_y}}
target_mission.indices          = default_box_indices
target_mission.material	        = "ARCADE_PURPLE"
target_mission.tex_params	    = {330/512, 365.5 / 512, tex_scale/0.5, tex_scale/0.5}
target_mission.controllers      = {{"draw_mission_target_hud"}}
target_mission.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
target_mission.level		  	=  DEFAULT_LEVEL + 1
target_mission.additive_alpha  = true
AddElement(target_mission)

local   bound_delta = 0.1

target_current_clear				 = CreateElement "ceTexPoly"
target_current_clear.name			 = "target_current"
target_current_clear.primitivetype   = "triangles"
target_current_clear.vertices		 = {{-curr_target_size_x,-curr_target_size_y}, 
                                        {-curr_target_size_x, curr_target_size_y},
                                        { curr_target_size_x, curr_target_size_y},
                                        { curr_target_size_x,-curr_target_size_y}}
target_current_clear.indices		 = default_box_indices
target_current_clear.material		 = "GREEN_2"
target_current_clear.h_clip_relation = h_clip_relations.INCREASE_LEVEL
target_current_clear.isvisible       = false
target_current_clear.controllers     =  {{"draw_current_target_hud"},
                                         {"bound_by_box",aspect - bound_delta, 1 - bound_delta}}
AddElement(target_current_clear)

LA                 = CreateElement "ceStringPoly"
LA.material        = "font_ARCADE_RED"
LA.init_pos		   = {0,-0.1}
LA.alignment       = "CenterCenter"
LA.stringdefs      = {0.0035, 0.0035,0,0}
LA.value           = _("!!SHOOT!!")
LA.controllers     = {{"draw_fire_permission"},{"blinking"}}
LA.parent_element  = target_current_clear.name
LA.additive_alpha  = true
AddElement(LA)  


target_current					= CreateElement "ceTexPoly"
target_current.name				= "current_sign"
target_current.vertices			= target_current_clear.vertices
target_current.indices			= target_current_clear.indices
target_current.material			= "ARCADE_RED"
target_current.tex_params		= {330/512, 0.5, tex_scale, tex_scale}
target_current.parent_element   = "target_current"
target_current.controllers      = {{"draw_iff_color"}}
target_current.additive_alpha  = true
AddElement(target_current)


local sector_size   = curr_target_size_y * 1.2

local hud_tex_scale = 0.35 * 0.15 / sector_size

distance_sector			        = CreateElement "ceHWSector"
distance_sector.vertices1		= {{-0.05 * sector_size, -sector_size}, 
                                   {-0.05 * sector_size,  sector_size},
                                   {        sector_size,  sector_size},
                                   {        sector_size, -sector_size}}
distance_sector.tex_params1		=  {0.8784606866,0.0620155, hud_tex_scale, hud_tex_scale}
distance_sector.vertices2		= {{      -sector_size, -sector_size}, 
                                   {      -sector_size,  sector_size}, 
                                   {0.05 * sector_size,  sector_size}, 
                                   {0.05 * sector_size, -sector_size}}                                  
distance_sector.tex_params2		= {0.8726467, 0.0620155, hud_tex_scale, hud_tex_scale}
distance_sector.maskvertices	= {{-sector_size, -sector_size}, 
                                   {-sector_size,  sector_size}, 
                                   {  0.0       ,  sector_size}, 
                                   {  0.0       , -sector_size}}
distance_sector.indices			= default_box_indices
distance_sector.material		= "ARCADE_4"
distance_sector.controllers     = {{"draw_target_distance",10000.0,math.rad(360.0)/10000.0},{"draw_iff_color"}}
distance_sector.parent_element	= target_current.name
distance_sector.minangle		= math.rad(2.0)
distance_sector.maxangle		= math.rad(358.0)
distance_sector.additive_alpha  = true
AddElement(distance_sector)

local   spike_size          = ((0.5 * (79 - 63)/256) / hud_symbol_size_px) * hud_symbol_size

authorized_distance					= CreateElement "ceTexPoly"
authorized_distance.vertices		= {{-hsd_coeff*spike_size,-hsd_coeff*spike_size}, 
                                       {-hsd_coeff*spike_size, hsd_coeff*spike_size},
                                       { hsd_coeff*spike_size, hsd_coeff*spike_size},
                                       { hsd_coeff*spike_size,-hsd_coeff*spike_size}}
authorized_distance.indices		   = default_box_indices
authorized_distance.material	   = "ARCADE"
authorized_distance.tex_params	   = {394/512,0.5, tex_scale/hsd_coeff, tex_scale/hsd_coeff}
authorized_distance.controllers    = {{"draw_distance_authorized",10000.0,-math.rad(360.0)/10000.0},{"move",0,sector_size*GetScale(),0},{"draw_iff_color"}}
authorized_distance.parent_element = target_current.name
authorized_distance.additive_alpha = true
AddElement(authorized_distance)


local contact_k = 0.5
mlws_contact					= CreateElement "ceTexPoly"
mlws_contact.name				= "mlws_contact"
mlws_contact.vertices			= {{-trg_size_x * contact_k, -trg_size_y * contact_k},
                                   {-trg_size_x * contact_k,  trg_size_y * contact_k},
                                   { trg_size_x * contact_k,  trg_size_y * contact_k},
                                   { trg_size_x * contact_k, -trg_size_y * contact_k}}
mlws_contact.indices			= default_box_indices
mlws_contact.material			= "ARCADE_RED"
mlws_contact.tex_params		    = {330/512, 365.5 / 512, tex_scale/contact_k, tex_scale/contact_k}
mlws_contact.controllers        = {{"draw_mlws_contact_hud"},
                                   {"time_rotate_X",2.0}}
mlws_contact.additive_alpha     = true
AddElement(mlws_contact)


