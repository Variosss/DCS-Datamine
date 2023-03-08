dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

local line_width_up = 0.01
local line_width_down = -(0.01 - 0.001)

cannon_limits_up					= create_HUD_element("ceTexPoly")
cannon_limits_up.name				= "cannon_limits_up"
cannon_limits_up.vertices			= {{-0.009, line_width_down}, {-0.009, line_width_up}, {1.18, line_width_up}, {1.18, line_width_down}}
cannon_limits_up.indices			= default_box_indices
cannon_limits_up.init_pos			= {-0.2648, 1.07 + vertical_displacement, 0}
cannon_limits_up.init_rot			= {0.0, 0.0, 0}
cannon_limits_up.material			= "INDICATION_HUD_KA50"
cannon_limits_up.tex_params			= {0.00332, 0.92248, tex_scale, tex_scale}
cannon_limits_up.controllers		= {{"cannon_ready"},{"cannon_uncaged"},{"cannon_on_stop_blinking"}}
AddWithDefaultClip(cannon_limits_up)

--[[
cannon_limits_up_region		= create_region(cannon_limits_up, "cannon_limits_up_region")
cannon_limits_up_region.isdraw = true
Add(cannon_limits_up_region)
--]]

cannon_limits_left					= create_HUD_element("ceTexPoly")
cannon_limits_left.name				= "cannon_limits_left"
cannon_limits_left.vertices			= {{-0.009, line_width_down}, {-0.009, line_width_up}, {3.675, line_width_up}, {3.675, line_width_down}}
cannon_limits_left.indices			= default_box_indices
cannon_limits_left.init_pos			= {-0.003, 0.0, 0}
cannon_limits_left.init_rot			= {-90.0, 0.0, 0}
cannon_limits_left.material			= "INDICATION_HUD_KA50"
cannon_limits_left.tex_params		= {0.00332, 0.92996, tex_scale, tex_scale}
cannon_limits_left.parent_element   = "cannon_limits_up"
AddWithDefaultClip(cannon_limits_left)

cannon_limits_right					= create_HUD_element("ceTexPoly")
cannon_limits_right.name			= "cannon_limits_right"
cannon_limits_right.vertices		= {{-0.009, line_width_down}, {-0.009, line_width_up}, {3.675, line_width_up}, {3.675, line_width_down}}
cannon_limits_right.indices			= default_box_indices
cannon_limits_right.init_pos		= {1.171, 0, 0}
cannon_limits_right.init_rot		= {-90.0, 0.0, 0}
cannon_limits_right.material		= "INDICATION_HUD_KA50"
cannon_limits_right.tex_params		= {0.00332, 0.92996, tex_scale, tex_scale}
cannon_limits_right.parent_element  = "cannon_limits_up"
AddWithDefaultClip(cannon_limits_right)

cannon_piper = add_piper("cannon_piper", {{"cannon_uncaged",0},{"current_sight"}})

--[[
test_cannon_piper_region		= create_region(cannon_piper, "test_cannon_piper_region")
test_cannon_piper_region.isdraw	= true
test_cannon_piper_region.controllers	= {{"current_sight"}}
Add(test_cannon_piper_region)
--]]

dummy_TDC					= CreateElement("ceSimple")
dummy_TDC.name				= "dummy_TDC"
dummy_TDC.collimated		= true
dummy_TDC.controllers      = {{"cannon_uncaged"},
                              {"tv_mark", 1},
                              {"tv_mark_in_HUD_zone",0,hud_zone},
                              {"shkval_limits_blinking",math.rad(5.0)}}
Add(dummy_TDC)


add_piper_distance_sector("cannon_distance_sector_piper", "cannon_piper")
--[[
add_piper_range_tick("cannon_min_range_tick", "cannon_piper", -28.8)
add_piper_range_tick("cannon_max_range_tick", "cannon_piper", -144.0)
--]]
add_piper_DLZ_tick  ("cannon_min_range_tick", "cannon_piper", 0,10000)
add_piper_DLZ_tick  ("cannon_max_range_tick", "cannon_piper", 2,10000)

add_piper_distance_sector("cannon_distance_sector_dummy", "dummy_TDC")
--[[
add_piper_range_tick("cannon_min_range_tick", "dummy_TDC", -28.8)
add_piper_range_tick("cannon_max_range_tick", "dummy_TDC", -144.0)
--]]
add_piper_DLZ_tick  ("cannon_min_range_tick_dumm", "dummy_TDC", 0,10000)
add_piper_DLZ_tick  ("cannon_max_range_tick_dumm", "dummy_TDC", 2,10000)
