dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")


bombs_piper = add_piper("bombs_piper", {{"current_sight"},{"bound_by_circle",default_eye_distance*math.tan(9.0/57.3)}})

add_piper_distance_sector("bombs_distance_sector", "bombs_piper")
add_piper_DLZ_tick  ("bombs_min_range_tick", "bombs_piper", 0,10000)
add_piper_DLZ_tick  ("bombs_max_range_tick", "bombs_piper", 2,10000)

bomb_fall_line					= create_HUD_element("ceHWLine")
bomb_fall_line.primitivetype    = "triangles"
bomb_fall_line.name				= "bomb_fall_line"
bomb_fall_line.vertices			= {{-0.009, -0.0105}, {-0.009, 0.0105}, {3.675, 0.0105}, {3.675, -0.0105}}
bomb_fall_line.maskvertices		= {{0.0, -0.0105}, {0.0, 0.0105}, {3.666, 0.0105}, {3.666, -0.0105}}
bomb_fall_line.indices			= default_box_indices
bomb_fall_line.length			= 0.2
bomb_fall_line.maxlength		= 1
bomb_fall_line.material			= "INDICATION_HUD_KA50"
bomb_fall_line.tex_params		= {0.00332, 0.92996, tex_scale, tex_scale}
bomb_fall_line.controllers		= {{"fall_line"},{"move",( 1.5 * piper_size / tex_scale) * GetScale(),0}}
bomb_fall_line.parent_element	= bombs_piper.name
AddWithDefaultClip(bomb_fall_line)