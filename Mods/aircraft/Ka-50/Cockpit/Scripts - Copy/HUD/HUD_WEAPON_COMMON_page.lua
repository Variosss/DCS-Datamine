dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

txt_launch_permission					= create_HUD_element("ceStringPoly")
txt_launch_permission.name				= "txt_launch_permission"
txt_launch_permission.material			= "font_Ka-50_HUD"
txt_launch_permission.init_pos			= {-0.643, TA_text_pos_y + interline + vertical_displacement, 0}
txt_launch_permission.alignment			= "LeftCenter"
txt_launch_permission.value				= "С"
txt_launch_permission.stringdefs		= {0.0073, 0.0073, -0.0007, 0.0}
txt_launch_permission.controllers       = {{"launch_permission"}}
AddWithDefaultClip(txt_launch_permission)

txt_training_mode					= create_HUD_element("ceStringPoly")
txt_training_mode.name				= "txt_training_mode"
txt_training_mode.material			= "font_Ka-50_HUD"
txt_training_mode.init_pos			= {-0.63, 0.25 + vertical_displacement, 0}
txt_training_mode.alignment			= "CenterTop"
txt_training_mode.value				= "ТРЕНАЖ"
txt_training_mode.stringdefs		= {0.0073, 0.0073, -0.0007, 0.0009}
txt_training_mode.controllers		= {{"TrainingModeSymbAvail"}}
AddWithDefaultClip(txt_training_mode)

local size_break_cross = (665.5 - 570.5)/1024
break_symbol					= create_HUD_element("ceTexPoly")
break_symbol.name				= "break_symbol"
break_symbol.vertices			= {{-size_break_cross/tex_scale, -size_break_cross/tex_scale}, 
							       {-size_break_cross/tex_scale,  size_break_cross/tex_scale},
							       { size_break_cross/tex_scale,  size_break_cross/tex_scale},
							       { size_break_cross/tex_scale, -size_break_cross/tex_scale}}
break_symbol.indices			= default_box_indices
break_symbol.init_pos			= {0,0.87 - 0.27  + vertical_displacement, 0}
break_symbol.material			= "INDICATION_HUD_KA50"
break_symbol.tex_params		= {446.5/1024,665.5/1024, tex_scale, tex_scale}
break_symbol.controllers	= {{"hud_cross"}}
AddWithDefaultClip(break_symbol)
