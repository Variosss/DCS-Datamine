dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

txt_W					= create_HUD_element("ceStringPoly")
txt_W.name				= "txt_W"
txt_W.material			= "font_Ka-50_HUD"
txt_W.init_pos			= {-0.688, 1.03 + vertical_displacement, 0}
txt_W.alignment			= "LeftCenter"
txt_W.stringdefs		= {0.0073, 0.0073, -0.0007, 0.0}
txt_W.formats			= {"%+04.f"}
txt_W.controllers		= {{"scales_reject"}, {"txt_W", 0, -999.0, 999.0}}
AddWithDefaultClip(txt_W)

txt_Vy				   = create_HUD_element("ceStringPoly")
txt_Vy.name			   = "txt_Vy"
txt_Vy.material		   = "font_Ka-50_HUD"
txt_Vy.init_pos		   = {0.358, 0.184 + vertical_displacement, 0}
txt_Vy.alignment       = "LeftCenter"
txt_Vy.stringdefs      = {0.0073, 0.0073, -0.0007, 0.0}
txt_Vy.formats         = {"%+03.f"}
txt_Vy.controllers     = {{"scales_reject"}, 
                          {"vy_scale_visibility", 1},
                          {"txt_Vy", 0, -99.0, 99.0}}
AddWithDefaultClip(txt_Vy)

W_vector						= create_HUD_element("ceHWLine")
W_vector.name					= "W_vector"
W_vector.vertices				= {{-0.009, -0.0105}, {-0.009, 0.0105}, {3.675, 0.0105}, {3.675, -0.0105}}
W_vector.maskvertices			= {{0.0, -0.0105}, {0.0, 0.0105}, {3.666, 0.0105}, {3.666, -0.0105}}
W_vector.indices				= default_box_indices
W_vector.init_pos				= bird_position
W_vector.length					= 0.0
W_vector.maxlength				= 6.45
W_vector.material				= "INDICATION_HUD_KA50"
W_vector.tex_params				= {0.00332, 0.92996, tex_scale, tex_scale}
W_vector.controllers			= {{"scales_reject"}, {"W_vector", 50.0, 0.00868}}
AddWithDefaultClip(W_vector)

ny_scale             = create_HUD_element("ceTexPoly")
ny_scale.name        = "ny_scale"
ny_scale.vertices    = {{-0.082, -0.325}, {-0.082, 0.04}, {0.01, 0.04}, {0.01, -0.325}}
ny_scale.indices     = default_box_indices
ny_scale.init_pos    = {-0.467, 0.17918 + vertical_displacement, 0}
ny_scale.material    = "INDICATION_HUD_KA50"
ny_scale.tex_params  = {0.30233, 0.25554, tex_scale, tex_scale}
ny_scale.controllers = {{"scales_reject"}, {"Ny_availability"}}
AddWithDefaultClip(ny_scale)

ny_index					= create_HUD_element("ceTexPoly")
ny_index.name				= "ny_index"
ny_index.vertices			= {{-0.01, -0.029}, {-0.01, 0.029}, {0.029, 0.029}, {0.029, -0.029}}
ny_index.indices			= default_box_indices
ny_index.init_pos			= {0.014, -0.22478, 0}
ny_index.material			= "INDICATION_HUD_KA50"
ny_index.tex_params			= {0.28433, 0.01772, tex_scale, tex_scale}
ny_index.controllers		= {{"Ny_index", -1.2, 3.2, 0.0064}}
ny_index.parent_element		= "ny_scale"
AddWithDefaultClip(ny_index)

ny_max_index				 = create_HUD_element("ceTexPoly")
ny_max_index.name			 = "ny_max_index"
ny_max_index.vertices		 = {{-0.007, -0.022}, {-0.007, 0.01}, {0.049, 0.01}, {0.049, -0.022}}
ny_max_index.indices		 = default_box_indices
ny_max_index.init_pos		 = {0.004, -0.2247, 0}
ny_max_index.material		 = "INDICATION_HUD_KA50"
ny_max_index.tex_params		 = {0.33583, 0.08389, tex_scale, tex_scale}
ny_max_index.controllers	 = {{"ny_max_avail"}, {"ny_max", 0.00553}}
ny_max_index.parent_element  = "ny_scale"
AddWithDefaultClip(ny_max_index)

vy_scale				= create_HUD_element("ceTexPoly")
vy_scale.name			= "vy_scale"
vy_scale.vertices		= {{-0.011, -0.465}, {-0.011, 0.016}, {0.119, 0.016}, {0.119, -0.465}}
vy_scale.indices		= default_box_indices
vy_scale.init_pos       = {0.485, 0.13 + vertical_displacement, 0}
vy_scale.material		= "INDICATION_HUD_KA50"
vy_scale.tex_params		= {0.27686, 0.37459, tex_scale, tex_scale}
vy_scale.controllers    = {{"scales_reject"}, {"vy_scale_visibility", 1}}
AddWithDefaultClip(vy_scale)

vy_scale_index            = create_HUD_element("ceTexPoly")
vy_scale_index.name       = "vy_scale_index"
vy_scale_index.vertices   = {{-0.029, -0.029}, {-0.029, 0.029}, {0.01, 0.029}, {0.01, -0.029}}
vy_scale_index.indices    = default_box_indices
vy_scale_index.init_pos	  = {-0.012, -0.2255, 0}
vy_scale_index.material   = "INDICATION_HUD_KA50"
vy_scale_index.tex_params = {0.30759, 0.01772, tex_scale, tex_scale}
vy_scale_index.controllers = {{"Vy_index", -32.0, 32.0, 0.00055}}
vy_scale_index.parent_element = "vy_scale"
AddWithDefaultClip(vy_scale_index)

heading_tape_base             = create_HUD_element("ceSimple")
heading_tape_base.name        = "heading_tape_base"
heading_tape_base.controllers = {{"heading_or_azimuth_deviation_avail", 0}}
heading_tape_base.init_pos    = {0,heading_tape_vert_pos + vertical_displacement,0}
Add(heading_tape_base)


heading_index                 = create_HUD_element("ceTexPoly")
heading_index.name            = "heading_index"
heading_index.vertices        = {{-0.029, -0.029}, {-0.029, 0.01}, {0.029, 0.01}, {0.029, -0.029}}
heading_index.indices         = default_box_indices
heading_index.init_pos        = {0.0,-0.01328, 0}
heading_index.material        = "INDICATION_HUD_KA50"
heading_index.tex_params      = {0.32724, 0.01274, tex_scale, tex_scale}
heading_index.parent_element  = heading_tape_base.name
AddWithDefaultClip(heading_index)

heading_deviation_diamond					= create_HUD_element("ceTexPoly")
heading_deviation_diamond.name				= "heading_deviation_diamond"
heading_deviation_diamond.vertices			= {{-diamond_x_size, -diamond_y_size}, 
                                               {-diamond_x_size,  diamond_y_size},
                                               { diamond_x_size,  diamond_y_size},
                                               { diamond_x_size, -diamond_y_size}}
heading_deviation_diamond.indices			= default_box_indices
heading_deviation_diamond.init_pos			= {0.0, -0.032, 0}
heading_deviation_diamond.material			= "INDICATION_HUD_KA50"
heading_deviation_diamond.tex_params		= {14.0 / texture_size, 1.69 / texture_size, tex_scale, tex_scale}
heading_deviation_diamond.controllers		= {{"heading_deviation_avail"}, {"heading_deviation", 0.064, math.rad(14.0)}}
heading_deviation_diamond.parent_element    = heading_tape_base.name
AddWithDefaultClip(heading_deviation_diamond)

heading_tape_border                 = create_HUD_element("ceMeshPoly")
heading_tape_border.name            = "heading_tape_border"
heading_tape_border.primitivetype   = "triangles"
heading_tape_border.vertices        = {{-0.195, -0.015},
    								   {-0.195, 0.115},
    								   {0.195, 0.115},
    								   {0.195, -0.015}}
heading_tape_border.indices         = default_box_indices
heading_tape_border.parent_element  = heading_tape_base.name
heading_tape_border.material        = "GREEN_2"
heading_tape_border.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
heading_tape_border.level			= HUD_DEFAULT_LEVEL
heading_tape_border.isdraw          = true
heading_tape_border.isvisible       = false
Add(heading_tape_border)

heading_K = 0.06384
heading_tape1                               = create_HUD_element("ceTexPoly")
heading_tape1.name                          = "heading_tape1"
heading_tape1.vertices                      = {{-2.5, 0.086}, 
                                               {-2.5, -0.006},
                                               {0.348, -0.006},
                                               {0.348, 0.086}}
heading_tape1.indices                       = default_box_indices
heading_tape1.parent_element                = heading_tape_base.name
heading_tape1.init_pos	                    = {4.974, 0, 0}
heading_tape1.material                      = "INDICATION_HUD_KA50"
heading_tape1.tex_params                    = {0.87597, 0.99585, tex_scale, tex_scale}
heading_tape1.controllers                   = {{"heading_scale", heading_K}}
heading_tape1.h_clip_relation               = h_clip_relations.COMPARE
heading_tape1.level                         = HUD_DEFAULT_LEVEL + 1
Add(heading_tape1)

heading_tape2                               = create_HUD_element("ceTexPoly")
heading_tape2.name                          = "heading_tape2"
heading_tape2.vertices                      = {{-0.348, -0.006},
                                               {-0.348, 0.086}, 
                                               {2.49, 0.086}, 
                                               {2.49, -0.006}}
heading_tape2.indices                       = default_box_indices
heading_tape2.parent_element                = heading_tape_base.name
heading_tape2.material                      = "INDICATION_HUD_KA50"
heading_tape2.tex_params                    = {0.12652, 0.96305, tex_scale, tex_scale}
heading_tape2.controllers                   = {{"heading_scale", heading_K}}
heading_tape2.h_clip_relation               = h_clip_relations.COMPARE
heading_tape2.level                         = HUD_DEFAULT_LEVEL + 1
Add(heading_tape2)



