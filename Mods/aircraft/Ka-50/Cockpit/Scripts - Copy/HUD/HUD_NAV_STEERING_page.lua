dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

track_deviation_scale					= create_HUD_element("ceTexPoly")
track_deviation_scale.name				= "track_deviation_scale"
track_deviation_scale.vertices			= {{-0.365, -0.011}, {-0.365, 0.011}, {0.365, 0.011}, {0.365, -0.011}}
track_deviation_scale.indices			= default_box_indices
track_deviation_scale.init_pos			= {0.0, 0.12 + vertical_displacement, 0}
track_deviation_scale.init_rot			= {0.0, 0.0, 0}
track_deviation_scale.material			= "INDICATION_HUD_KA50"
track_deviation_scale.tex_params		= {16.10 / texture_size, 28.61 / texture_size, tex_scale, tex_scale}
track_deviation_scale.controllers		= {{"scales_reject"}, {"track_deviation_avail"}}
AddWithDefaultClip(track_deviation_scale)

--[[
track_deviation_scale_region		= create_region(track_deviation_scale, "track_deviation_scale_region")
track_deviation_scale_region.isdraw = true
Add(track_deviation_scale_region)
--]]

track_deviation_index					= create_HUD_element("ceTexPoly")
track_deviation_index.name				= "track_deviation_index"
track_deviation_index.vertices			= {{-0.027, -0.01}, {-0.027, 0.027}, {0.027, 0.027}, {0.027, -0.01}}
track_deviation_index.indices			= default_box_indices
track_deviation_index.init_pos			= {0.0, 0.015, 0}
track_deviation_index.init_rot			= {0.0, 0.0, 0}
track_deviation_index.material			= "INDICATION_HUD_KA50"
track_deviation_index.tex_params		= {14.01 / texture_size, 2.41 / texture_size, tex_scale, tex_scale}
track_deviation_index.parent_element    = "track_deviation_scale"
AddWithDefaultClip(track_deviation_index)

--[[
track_deviation_index_region		= create_region(track_deviation_index, "track_deviation_index_region")
track_deviation_index_region.isdraw = true
Add(track_deviation_index_region)
--]]

track_deviation_diamond					= create_HUD_element("ceTexPoly")
track_deviation_diamond.name			= "track_deviation_diamond"
track_deviation_diamond.vertices		= {{-diamond_x_size, -diamond_y_size}, {-diamond_x_size, diamond_y_size}, {diamond_x_size, diamond_y_size}, {diamond_x_size, -diamond_y_size}}
track_deviation_diamond.indices			= default_box_indices
track_deviation_diamond.init_pos		= {0.0, -0.032, 0}
track_deviation_diamond.init_rot		= {0.0, 0.0, 0}
track_deviation_diamond.material		= "INDICATION_HUD_KA50"
track_deviation_diamond.tex_params		= {14.0 / texture_size, 1.69 / texture_size, tex_scale, tex_scale}
track_deviation_diamond.controllers		= {{"track_deviation", 0.0000949, 300.0}}
track_deviation_diamond.parent_element  = "track_deviation_scale"
AddWithDefaultClip(track_deviation_diamond)


-- Кольцо точки висения
ring_hovering_deviation					= create_HUD_element("ceTexPoly")
ring_hovering_deviation.name			= "ring_hovering_deviation"
ring_hovering_deviation.vertices		= {{-0.1, -0.1}, {-0.1, 0.1}, {0.1, 0.1}, {0.1, -0.1}}
ring_hovering_deviation.indices			= default_box_indices
ring_hovering_deviation.init_pos		= bird_position
ring_hovering_deviation.material		= "INDICATION_HUD_KA50"
ring_hovering_deviation.controllers		= {{"hovering_deviation_avail"}} 
ring_hovering_deviation.tex_params		= {14.86 / texture_size, 30.33 / texture_size, tex_scale, tex_scale}
AddWithDefaultClip(ring_hovering_deviation)

-- Символ отклонения от точки висения
local rect_x_size = 0.03
local rect_y_size = diamond_x_size

point_hovering_deviation_rect					= create_HUD_element("ceTexPoly")
point_hovering_deviation_rect.name				= "point_hovering_deviation_rect"
point_hovering_deviation_rect.vertices			= {{-rect_x_size, -rect_y_size}, {-rect_x_size, rect_y_size}, {rect_x_size, rect_y_size}, {rect_x_size, -rect_y_size}}
point_hovering_deviation_rect.indices			= default_box_indices
point_hovering_deviation_rect.init_pos			= {0.0, 0.0, 0}
point_hovering_deviation_rect.init_rot			= {0.0, 0.0, 0}
point_hovering_deviation_rect.material			= "INDICATION_HUD_KA50"
point_hovering_deviation_rect.tex_params		= {15.49 / texture_size, 1.69 / texture_size, tex_scale, tex_scale}
point_hovering_deviation_rect.controllers		= {{"hovering_deviation", 50.0, 0.0005}}
point_hovering_deviation_rect.parent_element	= "ring_hovering_deviation"
AddWithDefaultClip(point_hovering_deviation_rect)


--Шкала отклонения от заданной высоты
alt_deviation_scale				= create_HUD_element("ceTexPoly")
alt_deviation_scale.name		= "alt_deviation_scale"
alt_deviation_scale.vertices	= {{-0.011, -0.465}, {-0.011, 0.016}, {0.119, 0.016}, {0.119, -0.465}}
alt_deviation_scale.indices		= default_box_indices
alt_deviation_scale.init_pos    = {0.485, 0.13 + vertical_displacement, 0}
alt_deviation_scale.material	= "INDICATION_HUD_KA50"
alt_deviation_scale.tex_params	= {19.83 / texture_size, 19.65 / texture_size, tex_scale, tex_scale}
alt_deviation_scale.controllers = {{"scales_reject"}, {"vy_scale_visibility", 2}}
AddWithDefaultClip(alt_deviation_scale)


--Индекс отклонения от заданной высоты
alt_deviation_scale_index           = create_HUD_element("ceTexPoly")
alt_deviation_scale_index.name      = "alt_deviation_scale_index"
alt_deviation_scale_index.vertices  = {{-0.029, -0.029}, {-0.029, 0.029}, {0.01, 0.029}, {0.01, -0.029}}
alt_deviation_scale_index.indices   = default_box_indices
alt_deviation_scale_index.init_pos	= {-0.012, -0.2255, 0}
alt_deviation_scale_index.material  = "INDICATION_HUD_KA50"
alt_deviation_scale_index.tex_params = {0.30759, 0.01772, tex_scale, tex_scale}
alt_deviation_scale_index.controllers = {{"alt_deviation_index", -21.0, 21.0, -0.00083}}
alt_deviation_scale_index.parent_element = "alt_deviation_scale"
AddWithDefaultClip(alt_deviation_scale_index)



--шкала отклонения от заданной скорости
IAS_deviation_scale				= create_HUD_element("ceTexPoly")
IAS_deviation_scale.name		= "IAS_deviation_scale"
IAS_deviation_scale.vertices	= {{-0.157, -0.55}, {-0.157, 0.032}, {0.008, 0.032}, {0.008, -0.55}}
IAS_deviation_scale.indices		= default_box_indices
IAS_deviation_scale.init_pos	= {-0.42, 0.87 + vertical_displacement, 0}
IAS_deviation_scale.material	= "INDICATION_HUD_KA50"
IAS_deviation_scale.tex_params	= {23.39 / texture_size, 19.65 / texture_size, tex_scale, tex_scale}
IAS_deviation_scale.controllers	= {{"scales_reject"}, {"IAS_scale_visibility", 50.0, 2}}
AddWithDefaultClip(IAS_deviation_scale)


--индекс отклонения от заданной скорости	
IAS_deviation_index				= create_HUD_element("ceTexPoly")
IAS_deviation_index.name		= "IAS_deviation_index"
IAS_deviation_index.vertices	= {{-0.04, -0.029}, {-0.01, 0.029}, {0.029, 0.029}, {0.029, -0.029}}
IAS_deviation_index.indices		= default_box_indices
IAS_deviation_index.init_pos	= {0.012, -0.225, 0}
IAS_deviation_index.material	= "INDICATION_HUD_KA50"
IAS_deviation_index.tex_params	= {0.28433, 0.01772, tex_scale, tex_scale}
IAS_deviation_index.controllers	= {{"IAS_deviation_index", -21.0, 21.0,-0.00083}}
IAS_deviation_index.parent_element	= "IAS_deviation_scale"
AddWithDefaultClip(IAS_deviation_index)

bird_mark_dummy             = create_HUD_element("ceSimple")
bird_mark_dummy.name        = "bird_mark_dummy"
bird_mark_dummy.init_pos    = bird_position
bird_mark_dummy.controllers = {{"scales_reject"},
                               {"directional_mode"}}
Add(bird_mark_dummy)


dir_alt_hor_line					= create_HUD_element("ceTexPoly")
dir_alt_hor_line.name				= "dir_alt_hor_line"
dir_alt_hor_line.vertices			= {{-0.28, -0.016}, {-0.28, 0.016}, {0.28, 0.016}, {0.28, -0.016}}
dir_alt_hor_line.indices			= default_box_indices
dir_alt_hor_line.material			= "INDICATION_HUD_KA50"
dir_alt_hor_line.tex_params			= {11.135 / texture_size, 32.87 / texture_size, tex_scale, tex_scale}
dir_alt_hor_line.controllers		= {{"pitch_director",pitch_K,math.rad(-15),math.rad(15)},
                                       {"roll_director",-1}}
dir_alt_hor_line.parent_element     = bird_mark_dummy.name
AddWithDefaultClip(dir_alt_hor_line)


--директорное управление по высоте


dir_alt_vert_line					= create_HUD_element("ceHWLine")
dir_alt_vert_line.primitivetype     = "triangles"
dir_alt_vert_line.name				= "dir_alt_vert_line"
dir_alt_vert_line.vertices			= {{-0.009, -0.022},
									   {-0.009, 0.021},
									   {1.88, 0.021},
									   {1.88, -0.021}}
dir_alt_vert_line.maskvertices		= {{0.0, -0.021},
									   {0.0, 0.021},
									   {1.88, 0.021},
									   {1.88, -0.021}}
dir_alt_vert_line.indices			= default_box_indices
dir_alt_vert_line.init_pos			= {-0.234, 0.009, 0}
dir_alt_vert_line.init_rot			= {90.0, 0.0, 0.0}
dir_alt_vert_line.length			= 0.0
dir_alt_vert_line.maxlength			= 0.2233
dir_alt_vert_line.material			= "INDICATION_HUD_KA50"
dir_alt_vert_line.tex_params		= {0.12 / texture_size, 32.86 / texture_size, tex_scale, tex_scale}
dir_alt_vert_line.controllers		= {{"alt_deviation_line", 1, -0.0062}}
dir_alt_vert_line.parent_element	= "dir_alt_hor_line"
AddWithDefaultClip(dir_alt_vert_line)

dir_alt_vert_line_2					= Copy(dir_alt_vert_line)
dir_alt_vert_line_2.init_pos		= {0.234, 0.009, 0}
Add(dir_alt_vert_line_2)



dir_alt_vert_line_down					= create_HUD_element("ceHWLine")
dir_alt_vert_line_down.primitivetype	= "triangles"
dir_alt_vert_line_down.name				= "dir_alt_vert_line_down"
dir_alt_vert_line_down.vertices			= {{-0.009, -0.022},
										   {-0.009, 0.021},
									       {1.88, 0.021},
									       {1.88, -0.021}}
dir_alt_vert_line_down.maskvertices		= {{0.0, -0.021},
									       {0.0, 0.021},
									       {1.88, 0.021},
									       {1.88, -0.021}}
dir_alt_vert_line_down.indices			= default_box_indices
dir_alt_vert_line_down.init_pos			= {-0.234, -0.009, 0}
dir_alt_vert_line_down.init_rot			= {-90.0, 0.0, 0.0}
dir_alt_vert_line_down.length			= 0.0
dir_alt_vert_line_down.maxlength		= 0.2233
dir_alt_vert_line_down.material			= "INDICATION_HUD_KA50"
dir_alt_vert_line_down.tex_params		= {0.12 / texture_size, 32.86 / texture_size, tex_scale, tex_scale}
dir_alt_vert_line_down.controllers		= {{"alt_deviation_line", 2, -0.0062}}
dir_alt_vert_line_down.parent_element	= "dir_alt_hor_line"
AddWithDefaultClip(dir_alt_vert_line_down)


dir_alt_vert_line_down2				= Copy(dir_alt_vert_line_down)
dir_alt_vert_line_down2.init_pos	= {0.234, -0.009, 0}
Add(dir_alt_vert_line_down2)

